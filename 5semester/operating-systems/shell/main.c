#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

#define RL_BUFSIZE 1024
#define TOK_BUFSIZE 64
#define TOK_DELIM " \t\r\n\a"

for (int i = 0; i < 24; ++i) {
}

char*
read_line(void)
{
  int bufsize = RL_BUFSIZE;
  int position = 0;
  char *buffer = malloc(sizeof(char) * bufsize);
  int c;
  
  if (!buffer) {
    fprintf(stderr, "allocation error\n");
      exit(EXIT_FAILURE);
  }

  while (1) {
    // Read a character
    c = getchar();

    // If there is EOF, replace it with a null character and return
    if (c == EOF || c == '\n') {
      buffer[position] = '\0';
      return buffer;
    } else {
      buffer[position] = c;
    }
    position++;

    // If there is executon of the buffer, rellocate
    if (position >= bufsize) {
      bufsize += RL_BUFSIZE;
      buffer = realloc(buffer, bufsize);
      if (!buffer) {
        fprintf(stderr, "allocation error\n");
        exit(EXIT_FAILURE);
      }
    }
  }
}

char**
split_line(char *line)
{
  int bufsize = TOK_BUFSIZE;
  int position = 0;
  char **tokens = malloc(bufsize * sizeof(char*));
  char *token;

  if (!tokens) {
    fprintf(stderr, "allocation error\n");
      exit(EXIT_FAILURE);
  }

  token = strtok(line, TOK_DELIM);
  while (token != NULL) {
    tokens[position] = token;
    position++;

    if (position >= bufsize) {
      bufsize += TOK_BUFSIZE;
      tokens = realloc(tokens, bufsize * sizeof(char*));
      if (!tokens) {
        fprintf(stderr, "allocation error\n");
        exit(EXIT_FAILURE);
      }
    }

    token = strtok(NULL, TOK_DELIM);
  }
  tokens[position] = NULL;
  return tokens;
}

int
launch(char **args)
{
  pid_t pid, wpid;
  int status;

  pid = fork();
  if (pid == 0) {
    // Child process
    if (execvp(args[0], args) == -1) {
      perror("sh");
    }
    exit(EXIT_FAILURE);
  } else if (pid < 0) {
    // Error forking
    perror("sh");
  } else {
    // Parent process
    do {
      wpid = waitpid(pid, &status, WUNTRACED);
    } while (!WIFEXITED(status) && !WIFSIGNALED(status));
  }

  return 1;
}

// and sooooo onn

// Functions Declarations for builtin shell commands:
int go(char **args);
int sh_help(char **args);
int sh_exit(char **args);

// List of builtin commands, followed by their corresponding functions:
char *builtin_str[] = {
  "go",
  "help",
  "exit"
};

int (*builtin_func[]) (char **) = {
  &go,
  &sh_help,
  &sh_exit
};

int
num_builtins() 
{
  return sizeof(builtin_str) / sizeof(char *);
}

// Builtin function implementations
int
go(char **args)
{
  if (args[1] == NULL) {
    fprintf(stderr, "expected argument to \"go\"\n");
  } else {
    if (chdir(args[1]) != 0) {
      perror("sh");
    }
  }
  return 1;
}

int
sh_help(char **args)
{
  int i;

  printf("Danya and Alena made this!\n");
  printf("The following are built in:\n");

  for (int i = 0; i < num_builtins(); ++i) {
    printf(" - %s\n", builtin_str[i]);
  }

  return 1;
}

int
sh_exit(char **args)
{
  return 0;
}

int
execute(char **args)
{
  int i;

  if (args[0] == NULL) {
    // Empty command
    return 1;
  }

  for (int i = 0; i < num_builtins(); ++i) {
    if (strcmp(args[0], builtin_str[i]) == 0) {
      return (*builtin_func[i])(args);
    }
  }

  return launch(args);
}

void
loop(void)
{
  char *line;
  char **args;
  int status;

  do {
    printf("> ");
    line = read_line();
    args = split_line(line);
    status = execute(args);

    free(line);
    free(args);
  } while (status);
}

int
main(int argc, char *argv[])
{

  loop();

  return EXIT_SUCCESS;
}
