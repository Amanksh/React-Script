#!/bin/bash

# Check if a folder name is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

# Get the folder name from command line argument
folder_name=$1

# Create the project folder
mkdir "$folder_name"
cd "$folder_name"

# Initialize a React project
npm create vite@latest  .

# Install Tailwind CSS and its dependencies
npm install tailwindcss postcss-cli autoprefixer

# Initialize Tailwind CSS configuration files
npx tailwindcss init -p

# Add Tailwind CSS imports to CSS file
echo "
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';
" > src/index.css
echo "/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}" >tailwind.config.js
# Add Tailwind CSS classes to App.js
sed -i '/import ".\/App.css";/a\
import ".\/index.css";' src/App.js

# Clean up unnecessary files
rm src/App.css src/logo.svg src/reportWebVitals.js src/setupTests.js

# Display success message
echo "React project '$folder_name' with Tailwind CSS has been set up successfully!"

