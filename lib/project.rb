class Project
    attr_reader :title, :vols_needed, :id
    def initialize(attributes)
        @title = attributes[:title]
        @vols_needed = (attributes[:vols_needed].nil?) ? nil : attributes[:vols_needed].to_i
        @id = (attributes[:id].nil?) ? nil : attributes[:id].to_i
    end
    def save
        @id = DB.exec("INSERT INTO projects (title, vols_needed) VALUES ('#{@title}', '#{@vols_needed || 0}') RETURNING id;").first.fetch('id').to_i
        self #self return to make #save safely chainable (e.g. my_var = Project.new(params).save)
    end
    def vols_assigned
        DB.exec("SELECT count(*) FROM volunteers WHERE project_id = #{@id};").first['count'].to_i
    end
    def update(attributes)
        attributes = Project.hash_helper(attributes)
        unless attributes[:title].nil?
            @title = attributes[:title]
            DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
        end
        unless attributes[:vols_needed].nil?
            @vols_needed = attributes[:vols_needed].to_i
            DB.exec("UPDATE projects SET vols_needed = '#{@vols_needed || 0}' WHERE id = #{@id};")
        end
    end
    def volunteers
        DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id};").map do |vol|
            attributes = Project.hash_helper(vol)
            Volunteer.new(attributes)
        end
    end
    def delete
        DB.exec("DELETE FROM projects WHERE id = #{@id};")
        DB.exec("DELETE FROM volunteers WHERE project_id = #{@id};")
    end
    def ==(comparator)
        @title == comparator.title &&
        @id == comparator.id
    end

    #class methods
    def self.find(id)
        attributes = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
        Project.new(Project.hash_helper(attributes))
    end
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
