def jekyll(opts = "", path = "/usr/bin/")
  sh "rm -rf _site"
  sh path + "jekyll " + opts
end

desc "Build site using Jekyll"
task :build do
  jekyll
end

desc "Serve on Localhost with port 4000"
task :default do
  jekyll("--server --auto --growl")
end

task :stable do
  jekyll("--server --auto --growl", "")
end

desc "Deploy to Dev"
task :deploy => :"deploy:live"

namespace :deploy do
  desc "Deploy to Dev"
  task :dev => :build do
    rsync "$HOME/Sites/dev.tritarget.org"
  end
  
  desc "Deploy to Live"
  task :live => :build do
    rsync "ktohg@tritarget.org:dev.tritarget.org"
  end
  
  desc "Deploy to Dev and Live"
  task :all => [:dev, :live]
  
  def rsync(location)
    sh "rsync -rtz --delete _site/ #{location}/"
  end
end
