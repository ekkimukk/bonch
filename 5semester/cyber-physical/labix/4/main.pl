% Copyright (c) 2024 ekkimukk. All Rights Reserved.
% paint :-
%     write("                           (            "), nl,
%     write("*                           )   *       "), nl,
%     write("              )     *      (            "), nl,
%     write("    )        (                   (      "), nl,
%     write("   (          )     (             )     "), nl,
%     write("    )    *           )        )  (      "), nl,
%     write("   (                (        (      *   "), nl,
%     write("    )          H     )        )         "), nl,
%     write("              [ ]            (          "), nl,
%     write("       (  *   |-|       *     )    (    "), nl,
%     write(" *      )     |_|        .          )   "), nl,
%     write("       (      | |    .                  "), nl,
%     write(" )           /   \     .    . .        *"), nl,
%     write("(           |_____|  .  .    .          "), nl,
%     write(" )          | ___ |  \~~~/  . .   (     "), nl,
%     write("        *   | \ / |   \_/  \~~~/   )    "), nl,
%     write("            | _Y_ |    |    \_/   (     "), nl,
%     write("*     .     |-----|  __|__   |      *   "), nl,
%     write("            *-----*        __|__        "), nl,
%     nl.

main :-
        assert(wine("", "", "", "")),
        retractall(wine(_, _, _, _)),
        menu.

menu :-
    write("✿ ✿ ✿ Welcome to the Wine Database✿ ✿ ✿ "), nl,
    write(" 1. ✉  Show contents"), nl,
    write(" 2. ✎  Add the entry"), nl,
    write(" 3. ✀  Edit the entry"), nl,
    write(" 4. ➰ Delete the entry"), nl,
    write(" 5. 〄 Clear the current database"), nl,
    write(" 6. ➫  Load the database from a file"), nl,
    write(" 7. ✈  Save the current database"), nl,
    write(" 8. ✋ Exit"), nl,
    nl,
    write("> Choose the option: "), nl,
    read_string(user_input, "\n", "\t", _, Option), nl,
	menu_option(Option).

menu_option("1") :-
    show,
    menu.
menu_option("2") :-
    add,
    menu.
menu_option("3") :-
    edit_,
    menu.
menu_option("4") :-
    delete,
    menu.
menu_option("5") :-
    clear,
    menu.
menu_option("6") :-
    load,
    menu.
menu_option("7") :-
    save_,
    menu.
menu_option("8") :-
    write("✌ Goodbye!✋"),
    halt.
menu_option(_) :-
    write("> Invalid option. Try again."), nl,
    menu.

show :-
    findall(wine(ID, Name, Year, Region), wine(ID, Name, Year, Region), Wines),
    write("> The current database contains: "), nl,
    format("ID | Name | Year | Region ~n", []),
    print_wines(Wines),
    nl.

print_wines([]).
print_wines([wine(ID, Name, Year, Region)|Rest]) :-
    ID == "", Name == "", Year == "", Region == "",
    print_wines(Rest).
print_wines([wine(ID, Name, Year, Region)|Rest]) :-
    format('~w | ~w | ~w | ~w  ~n', [ID, Name, Year, Region]),
    print_wines(Rest).

add :-
    write("> Enter the ID of the wine: "), nl,
    read_string(user_input, "\n", "\t", End, ID), nl,
    write("> Enter the name of the wine: "), nl,
    read_string(user_input, "\n", "\t", End, Name), nl,
    write("> Enter the year of production of the wine: "), nl,
    read_string(user_input, "\n", "\t", End, Year), nl,
    write("> Enter the region where the wine was produced: "), nl,
    read_string(user_input, "\n", "\t", End, Region), nl,
    assertz(wine(ID, Name, Year, Region)),
    write('> Wine added successfully!'), nl,
    nl.

edit_ :-
    write("> Enter the ID of the entry you want to edit: "), nl,
    read_string(user_input, "\n", "\t", End, ID), nl,
    retract(wine(ID, _, _, _)),
    write("> Enter new ID of the wine: "), nl,
    read_string(user_input, "\n", "\t", End, NewID), nl,
    write("> Enter the name of the wine: "), nl,
    read_string(user_input, "\n", "\t", End, Name), nl,
    write("> Enter the year of production of the wine: "), nl,
    read_string(user_input, "\n", "\t", End, Year), nl,
    write("> Enter the region where the wine was produced: "), nl,
    read_string(user_input, "\n", "\t", End, Region), nl,
    assertz(wine(NewID, Name, Year, Region)),
    write('> Wine edited successfully!'), nl,
    nl;
    write("> ERROR in ID"), nl.

delete :-
    write("> Enter the ID of the entry you want to delete: "), nl,
    read_string(user_input, "\n", "\t", _, ID), nl,
    retract(wine(ID, _, _, _)),
    write('> Wine deleted successfully!'), nl,
    nl;
    write("> ERROR in ID"), nl.

clear :-
    write("> Are you sure you want to delete all current entries? [y/n]"), nl,
    read_string(user_input, "\n", "\t", _, Option), nl,
    clear_option(Option).

clear_option("y") :-
    retractall(wine(_, _, _, _)).
clear_option(_).

load :-
    write("> What type of file do you want to read? [txt/csv]"), nl,
    read_string(user_input, "\n", "\t", _, Filetype), nl,
    readFiletype(Filetype).

readFiletype("txt") :-
    readTxtFile,
    write("> File read successfully!"), nl,
    nl.
readFiletype("csv") :-
    readCsvFile,
    write("> File read successfully!"), nl,
    nl.
readFiletype(_) :-
    write("> Invalid option. Try again."), nl,
    menu.

readTxtFile :-
    write("> Enter the name of the file: "), nl,
    read_string(user_input, "\n", "\t", _, Filename), nl,
    exists_file(Filename),
    retractall(wine(_, _, _, _)),
    consult(Filename).

readCsvFile :-
    write("> Enter the name of the file: "), nl,
    read_string(user_input, "\n", "\t", _, Filename), nl,
    exists_file(Filename),
    retractall(wine(_, _, _, _)),
    csv_read_file(Filename, Data),
write(Data), nl,
    parseCsvRows(Data).

parseCsvRows([]).
parseCsvRows([row(ID, Name, Year, Region)|Rest]) :-
    % term_to_atom(ID, SID),
    % term_to_atom(Name, SName),
    % term_to_atom(Year, SYear),
    % term_to_atom(Region, SRegion),
    % assertz(wine(SID, SName, SYear, SRegion)),
    assertz(wine(ID, Name, Year, Region)),
    parseCsvRows(Rest).

save_ :-
    write("> What file format would you like to save the current database to? [txt/csv]"), nl,
    read_string(user_input, "\n", "\t", _, Filetype), nl,
    writeFiletype(Filetype).

writeFiletype("txt") :-
    writeTxtFile,
    write("> File written successfully!"), nl,
    nl.
writeFiletype("csv") :-
    writeCsvFile,
    write("> File written successfully!"), nl,
    nl.
writeFiletype(_) :-
    write("> Invalid option. Try again."), nl,
    menu.

writeTxtFile :-
    write("> Enter the name of the file: "), nl,
    read_string(user_input, "\n", "\t", _, Filename), nl,
    open(Filename, write, Stream),
    forall(wine(ID, Name, Year, Region),
           (write_term(Stream, wine(ID, Name, Year, Region), [quoted(true)]),
            write(Stream, '.'), nl(Stream))),
    close(Stream).

writeCsvFile :-
    write("> Enter the name of the file: "), nl,
    read_string(user_input, "\n", "\t", _, Filename), nl,
    open(Filename, write, Stream),
    forall(wine(ID, Name, Year, Region),
           (format(Stream, '~w,~w,~w,~w~n', [ID, Name, Year, Region]))),
    close(Stream).
