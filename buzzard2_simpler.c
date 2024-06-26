int str_mem;
int m;
int last_dict_entry, program_counter;
int stack;
int stack_ptr;
int last_str_entry, top_of_stack;

wi8(o, v){
  *(char*)o = (v & 255);
}

ri8(o){
 return *(char*)o;
}

wi32(o, v) {
  wi8(o,v&0xFF);
  v=v>>8;
  wi8(o+1,v&0xFF);
  v=v>>8;
  wi8(o+2,v&0xFF);
  v=v>>8;
  wi8(o+3,v&0xFF);
}

ri32(o) {
  return (ri8(o)&255)       | (ri8(o+1)&255)<<8 |
         (ri8(o+2)&255)<<16 | (ri8(o+3)&255)<<24;
}

append_to_dict(val) {
    int addr;
    addr = ri32(m);
    wi32(m + (4*addr), val);
    wi32(m, ri32(m) + 1);
}

def_word(codeword)
{
    append_to_dict(last_dict_entry);
    last_dict_entry = ri32(m) - 1;
    append_to_dict(last_str_entry);
    append_to_dict(codeword);
    scanf("%s", str_mem + last_str_entry);
    last_str_entry = last_str_entry + strlen(str_mem + last_str_entry) + 1;
}

r(word_addr)
{
    int read_count, val, entry_addr, entry_data_addr, next_word, codeword;
    next_word = word_addr + 1;
    codeword = ri32(m + (4 * word_addr));
    if(codeword == 5) {
            read_count = scanf("%s", str_mem);
            if (read_count < 1) {
                exit(0);
            } else {
                entry_addr = last_dict_entry;
            }
            while (strcmp(str_mem, str_mem + ri32(m+(4*(entry_addr + 1))))) {
                entry_addr = ri32(m + (4*entry_addr));
            }
            if (entry_addr != 1) {

                entry_data_addr = entry_addr + 2;

                r(entry_data_addr);
            } else {
                append_to_dict(2);
                val = atoi(str_mem);
                append_to_dict(val);
            }
    } else if(codeword == 12) {
            program_counter = ri32(m + 4*(ri32(m + (4*1))));
            wi32(m + (4*1), ri32(m + (4*1))- 1);
    } else if(codeword == 15) {
            top_of_stack = ri32(stack + (4*(stack_ptr - top_of_stack)));
    } else if(codeword == 1) {
            append_to_dict(next_word);
    } else if(codeword == 9) {
            top_of_stack = top_of_stack * ri32(stack + (4*stack_ptr));
            stack_ptr = stack_ptr - 1;
    } else if(codeword == 7) {
            wi32(m + (4*top_of_stack), ri32(stack+(4*stack_ptr)));
            stack_ptr = stack_ptr - 1;
            top_of_stack = ri32(stack+(4*stack_ptr));
            stack_ptr = stack_ptr - 1;
    } else if(codeword == 0) {
            stack_ptr = stack_ptr + 1;
            wi32(stack+(4*stack_ptr), top_of_stack);
            top_of_stack = ri32(m +(4*program_counter));
            program_counter = program_counter + 1;
    } else if(codeword == 8) {
            top_of_stack = ri32(stack+ (4*stack_ptr)) - top_of_stack;
            stack_ptr = stack_ptr - 1;
    } else if(codeword == 2) {
            wi32(m + (4*1), ri32(m + (4*1)) + 1);
            wi32(m+(4*(ri32(m+ (4*1)))), program_counter);
            program_counter = next_word;
    } else if(codeword == 11) {
            top_of_stack = 0 > top_of_stack;
    } else if(codeword == 4) {
            wi32(m, ri32(m) - 2);
            append_to_dict(2);
    } else if(codeword == 6) {
            top_of_stack = ri32(m+(4*top_of_stack));
    } else if(codeword == 10) {
            top_of_stack = ri32(stack +(4*stack_ptr)) / top_of_stack;
            stack_ptr = stack_ptr - 1;
    } else if(codeword == 3) {
            def_word(1);
            append_to_dict(2);
    } else if(codeword == 13) {
            putchar(top_of_stack);
            top_of_stack = ri32(stack+(4*stack_ptr));
            stack_ptr = stack_ptr - 1;
    } else if(codeword == 14) {
            stack_ptr = stack_ptr + 1;
            wi32(stack +(4*stack_ptr), top_of_stack);
            top_of_stack = getchar();
    } else {
      puts("unsupported word");
      exit(1);
    }
}

main()
{
    int i, tmp1, word_to_execute;
    last_dict_entry = 1;
    stack_ptr = 0;
    last_str_entry = 64;
    str_mem = calloc(1, 5000);
    m = calloc(1, 20000);
    wi32(m, 32);
    stack = calloc(1, 500);
    def_word(3);
    def_word(4);
    def_word(1);
    tmp1 = ri32(m);
    append_to_dict(5);
    append_to_dict(2);
    program_counter = ri32(m);
    append_to_dict(tmp1);
    append_to_dict(program_counter - 1);
    for (i = 6; i < 16; i = i + 1) {
        def_word(1);
        append_to_dict(i);
    }
    wi32(m+(4*1), ri32(m));
    wi32(m, ri32(m)+512);
    while(1) {
        word_to_execute = ri32(m + (4 * program_counter));
        program_counter = program_counter + 1;
        r(word_to_execute);
    }
    return 0;
}
