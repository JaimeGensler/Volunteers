class Project
    attr_reader :title, :id
    def initialize(attributes)
        @title = attributes[:title]
        @id = (attributes[:id].nil?) ? nil : attributes[:id].to_i
    end
    def save
        @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first.fetch('id').to_i
        self #self return to make #save safely chainable method (e.g. my_var = Project.new(params).save)
    end
    def ==(comparator)
        @title == comparator.title &&
        @id == comparator.id
    end

    #class methods
    # def self.all
    #     DB.exec("SELECT * FROM projects;").map { |row| Project.new(Project.hash_helper(row)) }
    # end

    private
    def self.hash_helper(row_hash)
        row_hash.reduce({}) do |acc, (key, val)|
            acc[key.to_sym] = (val == '') ? nil : val
            acc
        end
    end
end
