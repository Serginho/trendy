namespace :wrapper do
  desc "Start wrapper to download posts"
  task start: :environment do
    Wrapper.start_wrapping
  end

end
