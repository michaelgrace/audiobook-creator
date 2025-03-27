# Make sure you're in the project root
cd D:\live\Documents\GitHub\audiobook-creator

# Initialize git if needed
git init

# Add the .gitignore file
# Create the .gitignore file with contents above
git add .gitignore

# Add all files respecting the gitignore
git add .

# Commit the changes
git commit -m "Working audiobook creator with Kokoro, added Ollama (not used-okay to remove)"

# Add a tag
git tag -a v1.1 -m "Working version with Docker GPU support"

# If you're pushing to GitHub
git push origin main
git push origin v1.1