class Volunteer
    attr_reader :name, :project_id, :id
    def initialize(attributes)
        @name = attributes[:name]
        @project_id = attributes[:project_id]
        @id = attributes[:id]
    end
end
