class Volunteer
    attr_reader :name, :project_id, :id
    def initialize(attributes)
        @name = attributes[:name]
        @project_id = (attributes[:project_id].nil?) ? nil : attributes[:project_id].to_i
        @id = (attributes[:id].nil?) ? nil : attributes[:id].to_i
    end
    def save
        @id = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;").first.fetch('id').to_i
        self #self return to make #save safely chainable (e.g. my_var = Project.new(params).save)
    end
    def ==(comparator)
        @name == comparator.name &&
        @project_id == comparator.project_id &&
        @id == comparator.id
    end

    # class methods
    def self.all
        DB.exec("SELECT * FROM volunteers;").map { |row| Volunteer.new(Volunteer.hash_helper(row)) }
    end
    def self.find(id)
        attributes = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
        Volunteer.new(Volunteer.hash_helper(attributes))
    end

    private
    def self.hash_helper(row_hash)
        row_hash.reduce({}) do |acc, (key, val)|
            acc[key.to_sym] = (val == '') ? nil : val
            acc
        end
    end
end
