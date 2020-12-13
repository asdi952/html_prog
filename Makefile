
root = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
cpp_path = $(root)cpp/
header_path = $(root)header/
preHeader_path = $(header_path)preHeader/
bin_path = $(root)bin/
compile_trash_path = $(bin_path)compile_trash/

cpp_files = main
#header_files
#preHeader_files
exe_files = main.exe

aux_exe_files = $(addprefix $(bin_path), $(word 1, $(exe_files)))
aux_preHeader_files = $(addsuffix .gch, $(addprefix $(preHeader_path), $(preHeader_files)))
aux_cpp_files = $(addsuffix .o, $(addprefix $(compile_trash_path), $(cpp_files)))

run_without_debug: $(aux_preHeader_files) $(aux_exe_files)
	@echo /--------------------------------------------------------/
	@echo /---------------------------------------------/
	@echo /----------------------------------/
	@echo /--------------------------------------------------------/
	@echo
	@$(aux_exe_files)

$(preHeader_path)%.h.gch: $(header_path)%.h
	@echo preHeader - $<
	@g++ -std=c++17 $< -o $@

$(compile_trash_path)%.o: $(cpp_path)%.cpp
	@echo objectify - $<
	@g++ -std=c++17 -c $< -o $@

$(aux_exe_files): $(aux_cpp_files)
	@echo linking - $^
	@g++ -std=c++17 $^ -o $@
