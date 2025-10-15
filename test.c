

// void
// autocompletion(char *buf, int pos, int tab_count)
// {
//   int i;
//   char prefix[DIRSIZ+1];
//   int start = 0;

//   // Find where the last word starts (after last space)
//   for (i = pos - 1; i >= 0; i--) {
//     if (buf[i] == ' ' || buf[i] == '\n' || buf[i] == '\r') {
//       start = i + 1;
//       break;
//     }
//   }

//   // Copy that part into prefix[]
//   int j = 0;
//   while (start + j < pos && j < DIRSIZ) {
//     prefix[j] = buf[start + j];
//     j++;
//   }
//   prefix[j] = '\0';

//   // Debug print to test your extraction first:
  
// }



//   char*
//   gets_modified(char *buf, int max)
//   {
    
//     int i, cc;
//     char c;
//     int tab_count = 0;

//     for (i = 0; i + 1 < max; ) {
//       cc = read(0, &c, 1);
//       printf(2, "$ ");
//       if (cc < 1)
//         break;

//       if (c == '\t') {
//         tab_count++;
//         autocompletion(buf,i,tab_count);
//         continue;   // don’t put '\t' in buffer
//       } else {
//         tab_count = 0;
//       }

//       buf[i++] = c;

//       if (c == '\n' || c == '\r')
//         break;
//     }

//     buf[i] = '\0';
//     return buf;
//   }




void autocompletion(char *buf)
{
  int match_count = 0;
  char match_buf[100]; // Static buffer to hold the best match so far
  char *current_word = buf;
  int i;

  memset(match_buf, 0, sizeof(match_buf));
  
  // Find the start of the word we need to complete
  for(i = strlen(buf) - 1; i >= 0; i--){
    if(buf[i] == ' '){
      current_word = buf + i + 1;
      break;
    }
  }

  // Decide whether to complete a command name or a file/path name.
  if(current_word == buf) {
    // --- COMMAND COMPLETION LOGIC ---
    for (i = 0; i < num_known_commands; i++) {
      if (strncmp(knowncommands[i], current_word, strlen(current_word)) == 0) {
        if (match_count == 0) {
          // First match found. Copy it to our static buffer.
          strncpy(match_buf, knowncommands[i], sizeof(match_buf) - 1);
        } else {
          // More than one match. Update match_buf to be the common prefix.
          update_common_prefix(match_buf, knowncommands[i], sizeof(match_buf));
        }
        match_count++;
      }
    }
  } else {
    // --- FILE/DIRECTORY COMPLETION LOGIC (like 'ls') ---
    char path[512];
    int fd;
    struct dirent de;
    struct stat st;

    // Open the current directory for reading.
    if((fd = open(".", 0)) < 0){
      printf(2, "autocomplete: cannot open .\n");
      return;
    }
    
    // Read through all directory entries.
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0) // Skip empty entries.
        continue;
      
      // We must not try to complete "." or ".."
      if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
        continue;
        
      // Check if the file name starts with our current word.
      if (strncmp(de.name, current_word, strlen(current_word)) == 0) {
        if (match_count == 0) {
          // First match. Copy to our buffer.
          strncpy(match_buf, de.name, sizeof(match_buf) - 1);
        } else {
          // Multiple matches. Find common prefix.
          update_common_prefix(match_buf, de.name, sizeof(match_buf));
        }
        match_count++;
      }
    }
    close(fd);
    
    // This is a nice-to-have feature: if there's a single, unique match,
    // and it's a directory, add a '/' to the end.
    if(match_count == 1) {
        // We need to build the full path to stat() the file
        if(strlen(buf) + strlen(match_buf) < sizeof(path)) {
            strcpy(path, "."); // or the directory part of the path if you implement that
            strcpy(path + strlen(path), "/");
            strcpy(path + strlen(path), match_buf);
            if(stat(path, &st) >= 0 && st.type == T_DIR) {
                int len = strlen(match_buf);
                if(len + 1 < sizeof(match_buf)) {
                    match_buf[len] = '/';
                    match_buf[len+1] = '\0';
                }
            }
        }
    }
  }

  // --- SEND THE RESULT BACK TO THE KERNEL ---
  if (match_count > 0 && strlen(match_buf) > strlen(current_word)) {
    char* completion_text = match_buf + strlen(current_word);
    int completion_len = strlen(completion_text);
    
    // Use a static buffer for the result message to the kernel
    char result[128];
    if (completion_len + 3 < sizeof(result)) {
        memset(result, 0, sizeof(result));
        strcpy(result, "\t\t");
        strcpy(result + 2, completion_text);

        // This write() call sends the special message to consolewrite.
        write(1, result, strlen(result));
    }
  }
}





int
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    // Wait for the writer (consoleintr or consolewrite) to provide input.
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }

    // Read one character from the buffer.
    c = input.buf[input.r++ % INPUT_BUF];

    if(c == C('D')){  // Handle EOF
      if(n < target){
        input.r--;
      }
      break;
    }

    *dst++ = c;
    --n;

    // A read is complete on a newline or a tab.
    if(c == '\n' || c == '\t')
      break;
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
