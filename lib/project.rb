class Project
    attr_reader :title, :id
    def initialize(attributes)
        @title = attributes[:title]
        @id = (attributes[:id].nil?) ? nil : attributes[:id].to_i
    end
    def save
        @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first.fetch('id').to_i
        self #self return to make #save safely chainable (e.g. my_var = Project.new(params).save)
    end
    def update(attributes)
        attributes = Project.hash_helper(attributes)
        unless attributes[:title].nil?
            @title = attributes[:title]
            DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
        end
    end
    def delete
        DB.exec("DELETE FROM projects WHERE id = #{@id};")
        # DB.exec("DELETE FROM volunteers WHERE project_id = #{@id};")
    end
    def ==(comparator)
        @title == comparator.title &&
        @id == comparator.id
    end

    #class methods
    def self.all
        DB.exec("SELECT * FROM projects;").map { |row| Project.new(Project.hash_helper(row)) }
    end

    private
    def self.hash_helper(row_hash)
        row_hash.reduce({}) do |acc, (key, val)|
            acc[key.to_sym] = (val == '') ? nil : val
            acc
        end
    end
end
