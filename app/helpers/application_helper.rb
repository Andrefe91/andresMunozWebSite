module ApplicationHelper
  def projects_hash
    # The memoization helps to cache the information
    @projects_hash ||= YAML.safe_load(File.read(Rails.root.join("config/data", "projects.yaml")), aliases: true)
  end
end
