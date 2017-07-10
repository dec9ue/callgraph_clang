require 'ffi'
require 'ffi/clang'


def print_graph(target_file)
    index = FFI::Clang::Index::new()
    trans_unit = index.parse_translation_unit(target_file)
    cursor = trans_unit.cursor()
    
    cursor.visit_children do |current,parent,data| 
        if( current.kind == :cursor_function && current.location.file == target_file)
        then
            p "*** function name ****"
            p current.display_name
            p current.location.file
            p "*** called function names ****"
            res = current.find_all(:cursor_call_expr)
            res.each do |a|
                p a.display_name
            end
        end
        :continue
    end
    # index and trans_unit will be automatically released
end

target_file = "test.c"

print_graph(target_file)


