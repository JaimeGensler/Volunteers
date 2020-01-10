class Project
    attr_reader :title, :id
    def initialize(attributes)
        @title = attributes[:title]
        @id = attributes[:id]
    end
    def save
        @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first.fetch('id').to_i
        self #self return to make #save safely chainable method (e.g. my_var = Project.new(params).save)
    end
    def ==(comparator)
        @title == comparator.title &&
        @id == comparator.id
    end
end
