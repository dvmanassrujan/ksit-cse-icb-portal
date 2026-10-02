/**
 * All-in-One Instant Host Runner for KSIT CSE (ICB) Portal
 * Combines Express Backend Server + Cloudflare Live Public Tunnel in a SINGLE command.
 */

const http = require('http');
const os = require('os');
const { startTunnel } = require('untun');

const PORT = parseInt(process.env.PORT, 10) || 3000;

function getLocalIp() {
  const nets = os.networkInterfaces();
  for (const name of Object.keys(nets)) {
    for (const net of nets[name]) {
      if (net.family === 'IPv4' && !net.internal) {
        return net.address;
      }
    }
  }
  return 'localhost';
}

function isServerRunning(port) {
  return new Promise((resolve) => {
    const req = http.get(`http://localhost:${port}/api/health`, (res) => {
      resolve(res.statusCode === 200);
    });
    req.on('error', () => resolve(false));
    req.setTimeout(1500, () => {
      req.destroy();
      resolve(false);
    });
  });
}

async function main() {
  const localIp = getLocalIp();
  console.log('\n================================================================');
  console.log('       KSIT CSE (ICB) INTEGRATED ACADEMIC PORTAL');
  console.log('                  ALL-IN-ONE HOST RUNNER');
  console.log('================================================================');

  // Check if server is already running
  const running = await isServerRunning(PORT);
  if (!running) {
    console.log(`[Host] Starting backend server on port ${PORT}...`);
    try {
      require('./server.js');
      // Wait for server to bind
      let ready = false;
      for (let i = 0; i < 10; i++) {
        await new Promise((r) => setTimeout(r, 600));
        ready = await isServerRunning(PORT);
        if (ready) break;
      }
      if (!ready) {
        console.log('[Host] Note: Server is initializing in background...');
      }
    } catch (err) {
      if (err.code !== 'EADDRINUSE') {
        console.error('[Host] Server error:', err.message);
      }
    }
  } else {
    console.log(`[Host] Backend server is already running & healthy on port ${PORT}.`);
  }

  // Start Cloudflare Quick Tunnel
  console.log('[Host] Connecting to Cloudflare global network to create public URL...');
  try {
    const tunnel = await startTunnel({ port: PORT });
    const publicUrl = await tunnel.getURL();

    console.log('\n================================================================');
    console.log('  SUCCESS! YOUR PORTAL IS LIVE ON THE INTERNET:');
    console.log(`  PUBLIC URL:    ${publicUrl}`);
    console.log(`  LOCAL URL:     http://localhost:${PORT}`);
    console.log(`  WI-FI / LAN:   http://${localIp}:${PORT}`);
    console.log('================================================================');
    console.log('  - Share the PUBLIC URL with students, teachers & evaluators.');
    console.log('  - Works anywhere on mobile, tablet, and PC.');
    console.log('  - Press Ctrl+C in this terminal when you want to stop hosting.\n');

    // Keep event loop alive
    setInterval(() => {}, 1000 * 60 * 60);
  } catch (err) {
    console.error('[Host] Cloudflare Tunnel Error:', err.message);
    console.log('\nFallback: You can also access via your Wi-Fi network at:');
    console.log(`  http://${localIp}:${PORT}`);
  }
}

main();
