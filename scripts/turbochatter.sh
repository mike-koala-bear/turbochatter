if [ `yarn -v 1.22.19` ]; then
  echo "Yarn is already installed / up to date"
else
  echo "Yarn is not installed - installing now / updating..."
  curl -o- -L https://yarnpkg.com/install.sh | bash
  echo "Using yarn version: `yarn -v`"
  yarn install
  echo "Yarn install complete"
fi

if [ `bundle -v 2.3.12` ]; then
  echo "Bundler is already installed / up to date"
else
  echo "Bundler is updating..."
  bundle update
  bundle install
  echo "Using bundler version: `bundle -v`"
  echo "Bundler install / update complete"
fi

echo "Starting Turbochatter..."
echo "Creating database..."
bundle exec rails db:create
echo "Migrating database..."
bundle exec rails db:migrate
echo "Seeding database..."
bundle exec rails db:seed
echo "Starting server..."
bundle exec rails server
echo "Turbochatter started successfully - visit http://localhost:3000"
