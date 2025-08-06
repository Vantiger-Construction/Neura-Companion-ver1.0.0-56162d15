
#!/bin/bash
# Firebase Deploy Script for Neura Companion Press Site

echo "🔥 Initializing Firebase Hosting..."
firebase init hosting --project neuro-companion --public .
echo "🚀 Deploying to Firebase..."
firebase deploy
