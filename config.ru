require './config/environment'

begin
  fi_check_migration

  use Rack::MethodOverride
  use ArtistsController
  use GenresController
  use SongsController
  run ApplicationController
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
<<<<<<< HEAD
end
=======
end

# begin
#   fi_check_migration

#   use Rack::MethodOverride
#   run ApplicationController
# rescue ActiveRecord::PendingMigrationError => err
#   STDERR.puts err
#   exit 1
# end

# use Rack::MethodOverride

# use GenresController
# use ArtistsController
# use SongsController
# run ApplicationController
>>>>>>> 86dd21d9cd70c81b968073d3e2e0d5ea31042253
