class Project
    attr_reader :title, :id
    def initialize(attributes)
        @title = attributes[:title]
        @id = attributes[:id]
    end
end
