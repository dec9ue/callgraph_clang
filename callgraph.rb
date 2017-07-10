require 'ffi'
require 'ffi/clang'

index = FFI::Clang::Index::new()

# target_file = "../work/tulip/thirdparty/sip-4.15.5/sipgen/transform.c"
target_file = "test.c"
trans_unit = index.parse_translation_unit(target_file)
cursor = trans_unit.cursor()

children1 = cursor.visit_children do |current,parent,data| 
	if( current.kind == :cursor_function && current.location.file == target_file)
	then
		p "*** function name ****";
		p current.display_name;
		p current.location.file
		p "*** called function names ****";
		temp = current
		res = temp.find_all(:cursor_call_expr)
		res.each do |a|
			p a.display_name
		end
	end
	1
end


