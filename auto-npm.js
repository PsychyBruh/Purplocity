const { exec } = require('child_process');
const fs = require('fs');

// Helper function to run npm install
function runNpmInstall() {
  return new Promise((resolve, reject) => {
    exec('npm install', (error, stdout, stderr) => {
      if (error) {
        reject({ stdout, stderr, error });
      } else {
        resolve(stdout);
      }
    });
  });
}

// Helper function to install missing dependencies
function installDependency(dependency) {
  return new Promise((resolve, reject) => {
    exec(`npm install ${dependency}`, (error, stdout, stderr) => {
      if (error) {
        reject({ stdout, stderr, error });
      } else {
        resolve(stdout);
      }
    });
  });
}

// Function to handle the installation and fix missing dependencies
async function autoInstall() {
  let retries = 0;
  let maxRetries = 5; // Avoid infinite loops
  let success = false;

  // Keep trying until no more errors or maximum retries
  while (!success && retries < maxRetries) {
    retries++;

    try {
      console.log(`Attempt ${retries}: Running npm install...`);
      await runNpmInstall();
      console.log("Installation successful!");
      success = true; // If npm install succeeds, break out of the loop
    } catch (err) {
      console.error(`Error during installation: ${err.error.message}`);
      
      // Parse error for missing dependencies
      const missingDependencies = extractMissingDependencies(err.stderr);
      
      if (missingDependencies.length === 0) {
        console.log('No missing dependencies found. Exiting...');
        break;
      }

      console.log('Missing dependencies:', missingDependencies);

      // Install each missing dependency one by one
      for (let dep of missingDependencies) {
        console.log(`Attempting to install missing dependency: ${dep}`);
        try {
          await installDependency(dep);
          console.log(`Successfully installed: ${dep}`);
        } catch (installError) {
          console.error(`Failed to install ${dep}: ${installError.stderr || installError.error.message}`);
        }
      }
    }
  }

  if (retries >= maxRetries) {
    console.log('Reached maximum retries. Some dependencies might be unresolved.');
  }
}

// Function to extract missing dependencies from error stderr
function extractMissingDependencies(stderr) {
  const missingDeps = [];
  
  // Regular expression to capture common npm missing dependency errors
  const missingDepRegex = /Could not resolve.*'(.*)'/g;
  let match;
  
  // Find all matches for missing dependencies
  while ((match = missingDepRegex.exec(stderr)) !== null) {
    const dep = match[1].split('@')[0]; // Remove version if present
    if (!missingDeps.includes(dep)) {
      missingDeps.push(dep);
    }
  }
  
  return missingDeps;
}

// Run the automatic installation process
autoInstall().catch(err => {
  console.error('Critical error:', err);
});
