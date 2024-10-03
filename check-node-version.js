import { execSync } from 'child_process';
import readline from 'readline';

// Create a readline interface to prompt the user
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Get the current Node.js version
const nodeVersion = process.version;
const majorVersion = parseInt(nodeVersion.split('.')[0].replace('v', ''));

// Define the minimum required version (v19)
const requiredVersion = 19;

// Check if the current version is lower than the required version
if (majorVersion < requiredVersion) {
  console.log(`You are using Node.js ${nodeVersion}.`);
  console.log(`This project requires Node.js version v${requiredVersion} or higher.`);
  console.log('Please update Node.js to v19 or above.');

  // Ask the user if they want to update
  rl.question('Do you want to update Node.js to v19? (y/n): ', (answer) => {
    if (answer.toLowerCase() === 'y') {
      console.log('Updating Node.js to v19...');
      
      try {
        // Use nvm to install and use v19
        execSync('nvm install 19', { stdio: 'inherit' });
        execSync('nvm use 19', { stdio: 'inherit' });
        console.log('Node.js has been updated to v19.');
      } catch (error) {
        console.error('Error updating Node.js:', error.message);
      }
    } else {
      console.log('Update canceled. Exiting...');
    }
    
    // Close the readline interface
    rl.close();
  });
} else {
  console.log(`You are using Node.js ${nodeVersion}, which is compatible.`);
}
