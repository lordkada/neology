module Neology

  module IndexMixin

    class QueryBuilder

      include Enumerable

      def initialize class_name, index_name, query
        @class_name = class_name
        @index_name = index_name
        @query      = query
      end

      def asc(*fields)
        @sort_keys = fields.inject(@sort_keys || { }) { |memo, key| memo[key] = false; memo }
        self
      end

      def desc(*fields)
        @sort_keys = fields.inject(@sort_keys || { }) { |memo, key| memo[key] = true; memo }
        self
      end

      def sort_keys
        (@sort_keys.keys.inject([]) do |memo, key|
          memo << "new SortField( '#{key}', SortField.DOUBLE, #{@sort_keys[key]} )"
        end).join(", ")
      end

      def each
        fetch.each { |n|
          yield Object.const_get(@class_name).load n } if fetch
      end

      def size
        fetch.size
      end

      private

      def fetch
        @fetch ||= query
      end

      def query

        script_code = "import org.neo4j.graphdb.index.*;"+
                "import org.neo4j.index.lucene.*;"+
                "import org.apache.lucene.search.*;"+
                "neo4j = g.getRawGraph();"+
                "idxManager = neo4j.index();"+
                "index = idxManager.forNodes('#{@index_name}');"+
                "query = new QueryContext( '#{@query}' );"

        script_code += "query = query.sort( new Sort( (SortField[])[ #{sort_keys} ] ) );" if (@sort_keys && @sort_keys.size > 0)
        script_code += "results = index.query( query );"

        #p script_code
        Neology::NeoServer.execute_script script_code

      end

    end

  end

end