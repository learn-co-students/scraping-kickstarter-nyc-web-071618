require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
    projects = {}
      kickstarter.css("li.project.grid_4").each do |project|
        # THE LI PROJECT GRID 4 IS EACH OF THE BLOCKS OF PROJECTS
          title = project.css("h2.bbcard_name strong a").text
          # FOR EACH ONE grab the name of the project which can be would with the html tage bbcard...
            projects[title.to_sym] = {
              # now this projects will assign a key to the title then make the value another hash
                :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
                :description => project.css("p.bbcard_blurb").text,
                :location => project.css("ul.project-meta span.location-name").text,
                :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
                }
  end
  projects
end
