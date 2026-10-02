/**
 * Cloudflare Quick Tunnel Service for KSIT CSE (ICB) Portal
 * Provides instant, zero-configuration HTTPS public URL with no password screens.
 */

const { startTunnel } = require('untun');
const os = require('os');

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

async function main() {
  const localIp = getLocalIp();
  console.log('\n================================================================');
  console.log('  STARTING CLOUDFLARE PUBLIC TUNNEL FOR KSIT CSE (ICB) PORTAL');
  console.log('================================================================');
  console.log(`  Local Access:   http://localhost:${PORT}`);
  console.log(`  Network Access: http://${localIp}:${PORT}`);
  console.log(`  Connecting to Cloudflare edge network...`);

  try {
    const tunnel = await startTunnel({ port: PORT });
    const publicUrl = await tunnel.getURL();

    console.log('\n================================================================');
    console.log('  PORTAL IS NOW LIVE ON THE INTERNET!');
    console.log(`  LIVE PUBLIC URL:  ${publicUrl}`);
    console.log('================================================================');
    console.log('  - Share this URL with teachers, evaluators, or team members.');
    console.log('  - Works on all mobile phones, laptops, and tablets.');
    console.log('  - Keep this terminal window open to keep the tunnel active.\n');
  } catch (err) {
    console.error('Failed to establish Cloudflare tunnel:', err.message);
  }
}

main();
