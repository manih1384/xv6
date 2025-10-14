
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }


int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f 96 00 00 00    	jg     b7 <main+0xb7>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 79 13 00 00       	push   $0x1379
      2b:	e8 93 0e 00 00       	call   ec3 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 2e                	jmp    67 <main+0x67>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      40:	80 3d 42 1a 00 00 20 	cmpb   $0x20,0x1a42
      47:	0f 84 8d 00 00 00    	je     da <main+0xda>
      4d:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 26 0e 00 00       	call   e7b <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 c1 00 00 00    	je     11f <main+0x11f>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	74 63                	je     c5 <main+0xc5>
    wait();
      62:	e8 24 0e 00 00       	call   e8b <wait>
      printf(2, "$ ");
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	68 d8 12 00 00       	push   $0x12d8
      6f:	6a 02                	push   $0x2
      71:	e8 5a 0f 00 00       	call   fd0 <printf>
      memset(buf, 0, nbuf);
      76:	83 c4 0c             	add    $0xc,%esp
      79:	6a 64                	push   $0x64
      7b:	6a 00                	push   $0x0
      7d:	68 40 1a 00 00       	push   $0x1a40
      82:	e8 69 0c 00 00       	call   cf0 <memset>
      gets(buf, nbuf);
      87:	58                   	pop    %eax
      88:	5a                   	pop    %edx
      89:	6a 64                	push   $0x64
      8b:	68 40 1a 00 00       	push   $0x1a40
      90:	e8 bb 0c 00 00       	call   d50 <gets>
      if(buf[0] == 0) // EOF
      95:	0f b6 05 40 1a 00 00 	movzbl 0x1a40,%eax
      9c:	83 c4 10             	add    $0x10,%esp
      9f:	84 c0                	test   %al,%al
      a1:	74 0f                	je     b2 <main+0xb2>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      a3:	3c 63                	cmp    $0x63,%al
      a5:	75 a9                	jne    50 <main+0x50>
      a7:	80 3d 41 1a 00 00 64 	cmpb   $0x64,0x1a41
      ae:	75 a0                	jne    50 <main+0x50>
      b0:	eb 8e                	jmp    40 <main+0x40>
  exit();
      b2:	e8 cc 0d 00 00       	call   e83 <exit>
      close(fd);
      b7:	83 ec 0c             	sub    $0xc,%esp
      ba:	50                   	push   %eax
      bb:	e8 eb 0d 00 00       	call   eab <close>
      break;
      c0:	83 c4 10             	add    $0x10,%esp
      c3:	eb a2                	jmp    67 <main+0x67>
      runcmd(parsecmd(buf));
      c5:	83 ec 0c             	sub    $0xc,%esp
      c8:	68 40 1a 00 00       	push   $0x1a40
      cd:	e8 ee 0a 00 00       	call   bc0 <parsecmd>
      d2:	89 04 24             	mov    %eax,(%esp)
      d5:	e8 36 01 00 00       	call   210 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      da:	83 ec 0c             	sub    $0xc,%esp
      dd:	68 40 1a 00 00       	push   $0x1a40
      e2:	e8 d9 0b 00 00       	call   cc0 <strlen>
      if(chdir(buf+3) < 0)
      e7:	c7 04 24 43 1a 00 00 	movl   $0x1a43,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ee:	c6 80 3f 1a 00 00 00 	movb   $0x0,0x1a3f(%eax)
      if(chdir(buf+3) < 0)
      f5:	e8 f9 0d 00 00       	call   ef3 <chdir>
      fa:	83 c4 10             	add    $0x10,%esp
      fd:	85 c0                	test   %eax,%eax
      ff:	0f 89 62 ff ff ff    	jns    67 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
     105:	51                   	push   %ecx
     106:	68 43 1a 00 00       	push   $0x1a43
     10b:	68 81 13 00 00       	push   $0x1381
     110:	6a 02                	push   $0x2
     112:	e8 b9 0e 00 00       	call   fd0 <printf>
     117:	83 c4 10             	add    $0x10,%esp
     11a:	e9 48 ff ff ff       	jmp    67 <main+0x67>
    panic("fork");
     11f:	83 ec 0c             	sub    $0xc,%esp
     122:	68 db 12 00 00       	push   $0x12db
     127:	e8 a4 00 00 00       	call   1d0 <panic>
     12c:	66 90                	xchg   %ax,%ax
     12e:	66 90                	xchg   %ax,%ax

00000130 <find_incomplete_command_start>:
int find_incomplete_command_start(char *buf) {
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	8b 4d 08             	mov    0x8(%ebp),%ecx
    for (i = 0; buf[i] != 0; i++) {
     136:	0f b6 01             	movzbl (%ecx),%eax
     139:	84 c0                	test   %al,%al
     13b:	74 33                	je     170 <find_incomplete_command_start+0x40>
     13d:	31 d2                	xor    %edx,%edx
     13f:	eb 12                	jmp    153 <find_incomplete_command_start+0x23>
     141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     148:	83 c2 01             	add    $0x1,%edx
     14b:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
     14f:	84 c0                	test   %al,%al
     151:	74 1d                	je     170 <find_incomplete_command_start+0x40>
        if (buf[i] == '\t') {
     153:	3c 09                	cmp    $0x9,%al
     155:	75 f1                	jne    148 <find_incomplete_command_start+0x18>
    for (i = tab_pos - 1; i >= 0; i--) {
     157:	8d 42 ff             	lea    -0x1(%edx),%eax
     15a:	85 d2                	test   %edx,%edx
     15c:	75 07                	jne    165 <find_incomplete_command_start+0x35>
     15e:	eb 20                	jmp    180 <find_incomplete_command_start+0x50>
     160:	83 e8 01             	sub    $0x1,%eax
     163:	72 1b                	jb     180 <find_incomplete_command_start+0x50>
        if (buf[i] == '\n') {
     165:	80 3c 01 0a          	cmpb   $0xa,(%ecx,%eax,1)
     169:	75 f5                	jne    160 <find_incomplete_command_start+0x30>
            start = i + 1; // first char after '\n'
     16b:	83 c0 01             	add    $0x1,%eax
}
     16e:	5d                   	pop    %ebp
     16f:	c3                   	ret
        return -1; // no tab found
     170:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     175:	5d                   	pop    %ebp
     176:	c3                   	ret
     177:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     17e:	00 
     17f:	90                   	nop
    int start = 0;
     180:	31 c0                	xor    %eax,%eax
}
     182:	5d                   	pop    %ebp
     183:	c3                   	ret
     184:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     18b:	00 
     18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <getcmd>:
  {
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	56                   	push   %esi
     194:	53                   	push   %ebx
     195:	8b 5d 08             	mov    0x8(%ebp),%ebx
     198:	8b 75 0c             	mov    0xc(%ebp),%esi
      printf(2, "$ ");
     19b:	83 ec 08             	sub    $0x8,%esp
     19e:	68 d8 12 00 00       	push   $0x12d8
     1a3:	6a 02                	push   $0x2
     1a5:	e8 26 0e 00 00       	call   fd0 <printf>
      memset(buf, 0, nbuf);
     1aa:	83 c4 0c             	add    $0xc,%esp
     1ad:	56                   	push   %esi
     1ae:	6a 00                	push   $0x0
     1b0:	53                   	push   %ebx
     1b1:	e8 3a 0b 00 00       	call   cf0 <memset>
      gets(buf, nbuf);
     1b6:	58                   	pop    %eax
     1b7:	5a                   	pop    %edx
     1b8:	56                   	push   %esi
     1b9:	53                   	push   %ebx
     1ba:	e8 91 0b 00 00       	call   d50 <gets>
      if(buf[0] == 0) // EOF
     1bf:	83 c4 10             	add    $0x10,%esp
     1c2:	80 3b 01             	cmpb   $0x1,(%ebx)
     1c5:	19 c0                	sbb    %eax,%eax
  }
     1c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1ca:	5b                   	pop    %ebx
     1cb:	5e                   	pop    %esi
     1cc:	5d                   	pop    %ebp
     1cd:	c3                   	ret
     1ce:	66 90                	xchg   %ax,%ax

000001d0 <panic>:
{
     1d0:	55                   	push   %ebp
     1d1:	89 e5                	mov    %esp,%ebp
     1d3:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     1d6:	ff 75 08             	push   0x8(%ebp)
     1d9:	68 75 13 00 00       	push   $0x1375
     1de:	6a 02                	push   $0x2
     1e0:	e8 eb 0d 00 00       	call   fd0 <printf>
  exit();
     1e5:	e8 99 0c 00 00       	call   e83 <exit>
     1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001f0 <fork1>:
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     1f6:	e8 80 0c 00 00       	call   e7b <fork>
  if(pid == -1)
     1fb:	83 f8 ff             	cmp    $0xffffffff,%eax
     1fe:	74 02                	je     202 <fork1+0x12>
  return pid;
}
     200:	c9                   	leave
     201:	c3                   	ret
    panic("fork");
     202:	83 ec 0c             	sub    $0xc,%esp
     205:	68 db 12 00 00       	push   $0x12db
     20a:	e8 c1 ff ff ff       	call   1d0 <panic>
     20f:	90                   	nop

00000210 <runcmd>:
{
     210:	55                   	push   %ebp
     211:	89 e5                	mov    %esp,%ebp
     213:	53                   	push   %ebx
     214:	83 ec 14             	sub    $0x14,%esp
     217:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     21a:	85 db                	test   %ebx,%ebx
     21c:	74 42                	je     260 <runcmd+0x50>
  switch(cmd->type){
     21e:	83 3b 05             	cmpl   $0x5,(%ebx)
     221:	0f 87 e3 00 00 00    	ja     30a <runcmd+0xfa>
     227:	8b 03                	mov    (%ebx),%eax
     229:	ff 24 85 98 13 00 00 	jmp    *0x1398(,%eax,4)
    if(ecmd->argv[0] == 0)
     230:	8b 43 04             	mov    0x4(%ebx),%eax
     233:	85 c0                	test   %eax,%eax
     235:	74 29                	je     260 <runcmd+0x50>
    exec(ecmd->argv[0], ecmd->argv);
     237:	8d 53 04             	lea    0x4(%ebx),%edx
     23a:	51                   	push   %ecx
     23b:	51                   	push   %ecx
     23c:	52                   	push   %edx
     23d:	50                   	push   %eax
     23e:	e8 78 0c 00 00       	call   ebb <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     243:	83 c4 0c             	add    $0xc,%esp
     246:	ff 73 04             	push   0x4(%ebx)
     249:	68 e7 12 00 00       	push   $0x12e7
     24e:	6a 02                	push   $0x2
     250:	e8 7b 0d 00 00       	call   fd0 <printf>
    break;
     255:	83 c4 10             	add    $0x10,%esp
     258:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     25f:	00 
    exit();
     260:	e8 1e 0c 00 00       	call   e83 <exit>
    if(fork1() == 0)
     265:	e8 86 ff ff ff       	call   1f0 <fork1>
     26a:	85 c0                	test   %eax,%eax
     26c:	75 f2                	jne    260 <runcmd+0x50>
     26e:	e9 8c 00 00 00       	jmp    2ff <runcmd+0xef>
    if(pipe(p) < 0)
     273:	83 ec 0c             	sub    $0xc,%esp
     276:	8d 45 f0             	lea    -0x10(%ebp),%eax
     279:	50                   	push   %eax
     27a:	e8 14 0c 00 00       	call   e93 <pipe>
     27f:	83 c4 10             	add    $0x10,%esp
     282:	85 c0                	test   %eax,%eax
     284:	0f 88 a2 00 00 00    	js     32c <runcmd+0x11c>
    if(fork1() == 0){
     28a:	e8 61 ff ff ff       	call   1f0 <fork1>
     28f:	85 c0                	test   %eax,%eax
     291:	0f 84 a2 00 00 00    	je     339 <runcmd+0x129>
    if(fork1() == 0){
     297:	e8 54 ff ff ff       	call   1f0 <fork1>
     29c:	85 c0                	test   %eax,%eax
     29e:	0f 84 c3 00 00 00    	je     367 <runcmd+0x157>
    close(p[0]);
     2a4:	83 ec 0c             	sub    $0xc,%esp
     2a7:	ff 75 f0             	push   -0x10(%ebp)
     2aa:	e8 fc 0b 00 00       	call   eab <close>
    close(p[1]);
     2af:	58                   	pop    %eax
     2b0:	ff 75 f4             	push   -0xc(%ebp)
     2b3:	e8 f3 0b 00 00       	call   eab <close>
    wait();
     2b8:	e8 ce 0b 00 00       	call   e8b <wait>
    wait();
     2bd:	e8 c9 0b 00 00       	call   e8b <wait>
    break;
     2c2:	83 c4 10             	add    $0x10,%esp
     2c5:	eb 99                	jmp    260 <runcmd+0x50>
    if(fork1() == 0)
     2c7:	e8 24 ff ff ff       	call   1f0 <fork1>
     2cc:	85 c0                	test   %eax,%eax
     2ce:	74 2f                	je     2ff <runcmd+0xef>
    wait();
     2d0:	e8 b6 0b 00 00       	call   e8b <wait>
    runcmd(lcmd->right);
     2d5:	83 ec 0c             	sub    $0xc,%esp
     2d8:	ff 73 08             	push   0x8(%ebx)
     2db:	e8 30 ff ff ff       	call   210 <runcmd>
    close(rcmd->fd);
     2e0:	83 ec 0c             	sub    $0xc,%esp
     2e3:	ff 73 14             	push   0x14(%ebx)
     2e6:	e8 c0 0b 00 00       	call   eab <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     2eb:	58                   	pop    %eax
     2ec:	5a                   	pop    %edx
     2ed:	ff 73 10             	push   0x10(%ebx)
     2f0:	ff 73 08             	push   0x8(%ebx)
     2f3:	e8 cb 0b 00 00       	call   ec3 <open>
     2f8:	83 c4 10             	add    $0x10,%esp
     2fb:	85 c0                	test   %eax,%eax
     2fd:	78 18                	js     317 <runcmd+0x107>
      runcmd(bcmd->cmd);
     2ff:	83 ec 0c             	sub    $0xc,%esp
     302:	ff 73 04             	push   0x4(%ebx)
     305:	e8 06 ff ff ff       	call   210 <runcmd>
    panic("runcmd");
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 e0 12 00 00       	push   $0x12e0
     312:	e8 b9 fe ff ff       	call   1d0 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     317:	51                   	push   %ecx
     318:	ff 73 08             	push   0x8(%ebx)
     31b:	68 f7 12 00 00       	push   $0x12f7
     320:	6a 02                	push   $0x2
     322:	e8 a9 0c 00 00       	call   fd0 <printf>
      exit();
     327:	e8 57 0b 00 00       	call   e83 <exit>
      panic("pipe");
     32c:	83 ec 0c             	sub    $0xc,%esp
     32f:	68 07 13 00 00       	push   $0x1307
     334:	e8 97 fe ff ff       	call   1d0 <panic>
      close(1);
     339:	83 ec 0c             	sub    $0xc,%esp
     33c:	6a 01                	push   $0x1
     33e:	e8 68 0b 00 00       	call   eab <close>
      dup(p[1]);
     343:	58                   	pop    %eax
     344:	ff 75 f4             	push   -0xc(%ebp)
     347:	e8 af 0b 00 00       	call   efb <dup>
      close(p[0]);
     34c:	58                   	pop    %eax
     34d:	ff 75 f0             	push   -0x10(%ebp)
     350:	e8 56 0b 00 00       	call   eab <close>
      close(p[1]);
     355:	58                   	pop    %eax
     356:	ff 75 f4             	push   -0xc(%ebp)
     359:	e8 4d 0b 00 00       	call   eab <close>
      runcmd(pcmd->left);
     35e:	5a                   	pop    %edx
     35f:	ff 73 04             	push   0x4(%ebx)
     362:	e8 a9 fe ff ff       	call   210 <runcmd>
      close(0);
     367:	83 ec 0c             	sub    $0xc,%esp
     36a:	6a 00                	push   $0x0
     36c:	e8 3a 0b 00 00       	call   eab <close>
      dup(p[0]);
     371:	5a                   	pop    %edx
     372:	ff 75 f0             	push   -0x10(%ebp)
     375:	e8 81 0b 00 00       	call   efb <dup>
      close(p[0]);
     37a:	59                   	pop    %ecx
     37b:	ff 75 f0             	push   -0x10(%ebp)
     37e:	e8 28 0b 00 00       	call   eab <close>
      close(p[1]);
     383:	58                   	pop    %eax
     384:	ff 75 f4             	push   -0xc(%ebp)
     387:	e8 1f 0b 00 00       	call   eab <close>
      runcmd(pcmd->right);
     38c:	58                   	pop    %eax
     38d:	ff 73 08             	push   0x8(%ebx)
     390:	e8 7b fe ff ff       	call   210 <runcmd>
     395:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     39c:	00 
     39d:	8d 76 00             	lea    0x0(%esi),%esi

000003a0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	53                   	push   %ebx
     3a4:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a7:	6a 54                	push   $0x54
     3a9:	e8 42 0e 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3ae:	83 c4 0c             	add    $0xc,%esp
     3b1:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     3b3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3b5:	6a 00                	push   $0x0
     3b7:	50                   	push   %eax
     3b8:	e8 33 09 00 00       	call   cf0 <memset>
  cmd->type = EXEC;
     3bd:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     3c3:	89 d8                	mov    %ebx,%eax
     3c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3c8:	c9                   	leave
     3c9:	c3                   	ret
     3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	53                   	push   %ebx
     3d4:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d7:	6a 18                	push   $0x18
     3d9:	e8 12 0e 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3de:	83 c4 0c             	add    $0xc,%esp
     3e1:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     3e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3e5:	6a 00                	push   $0x0
     3e7:	50                   	push   %eax
     3e8:	e8 03 09 00 00       	call   cf0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     3ed:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     3f0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3f6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3fc:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3ff:	8b 45 10             	mov    0x10(%ebp),%eax
     402:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     405:	8b 45 14             	mov    0x14(%ebp),%eax
     408:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     40b:	8b 45 18             	mov    0x18(%ebp),%eax
     40e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     411:	89 d8                	mov    %ebx,%eax
     413:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     416:	c9                   	leave
     417:	c3                   	ret
     418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     41f:	00 

00000420 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	53                   	push   %ebx
     424:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     427:	6a 0c                	push   $0xc
     429:	e8 c2 0d 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     42e:	83 c4 0c             	add    $0xc,%esp
     431:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     433:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     435:	6a 00                	push   $0x0
     437:	50                   	push   %eax
     438:	e8 b3 08 00 00       	call   cf0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     43d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     440:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     446:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     449:	8b 45 0c             	mov    0xc(%ebp),%eax
     44c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     44f:	89 d8                	mov    %ebx,%eax
     451:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     454:	c9                   	leave
     455:	c3                   	ret
     456:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     45d:	00 
     45e:	66 90                	xchg   %ax,%ax

00000460 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	53                   	push   %ebx
     464:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     467:	6a 0c                	push   $0xc
     469:	e8 82 0d 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     46e:	83 c4 0c             	add    $0xc,%esp
     471:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     473:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     475:	6a 00                	push   $0x0
     477:	50                   	push   %eax
     478:	e8 73 08 00 00       	call   cf0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     47d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     480:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     486:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     489:	8b 45 0c             	mov    0xc(%ebp),%eax
     48c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     48f:	89 d8                	mov    %ebx,%eax
     491:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     494:	c9                   	leave
     495:	c3                   	ret
     496:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     49d:	00 
     49e:	66 90                	xchg   %ax,%ax

000004a0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	53                   	push   %ebx
     4a4:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a7:	6a 08                	push   $0x8
     4a9:	e8 42 0d 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4ae:	83 c4 0c             	add    $0xc,%esp
     4b1:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     4b3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4b5:	6a 00                	push   $0x0
     4b7:	50                   	push   %eax
     4b8:	e8 33 08 00 00       	call   cf0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     4bd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     4c0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     4c6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     4c9:	89 d8                	mov    %ebx,%eax
     4cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4ce:	c9                   	leave
     4cf:	c3                   	ret

000004d0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	57                   	push   %edi
     4d4:	56                   	push   %esi
     4d5:	53                   	push   %ebx
     4d6:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     4d9:	8b 45 08             	mov    0x8(%ebp),%eax
{
     4dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     4df:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     4e2:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     4e4:	39 df                	cmp    %ebx,%edi
     4e6:	72 0f                	jb     4f7 <gettoken+0x27>
     4e8:	eb 25                	jmp    50f <gettoken+0x3f>
     4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     4f0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     4f3:	39 fb                	cmp    %edi,%ebx
     4f5:	74 18                	je     50f <gettoken+0x3f>
     4f7:	0f be 07             	movsbl (%edi),%eax
     4fa:	83 ec 08             	sub    $0x8,%esp
     4fd:	50                   	push   %eax
     4fe:	68 20 1a 00 00       	push   $0x1a20
     503:	e8 08 08 00 00       	call   d10 <strchr>
     508:	83 c4 10             	add    $0x10,%esp
     50b:	85 c0                	test   %eax,%eax
     50d:	75 e1                	jne    4f0 <gettoken+0x20>
  if(q)
     50f:	85 f6                	test   %esi,%esi
     511:	74 02                	je     515 <gettoken+0x45>
    *q = s;
     513:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     515:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     518:	3c 3c                	cmp    $0x3c,%al
     51a:	0f 8f c8 00 00 00    	jg     5e8 <gettoken+0x118>
     520:	3c 3a                	cmp    $0x3a,%al
     522:	7f 5a                	jg     57e <gettoken+0xae>
     524:	84 c0                	test   %al,%al
     526:	75 48                	jne    570 <gettoken+0xa0>
     528:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     52a:	8b 4d 14             	mov    0x14(%ebp),%ecx
     52d:	85 c9                	test   %ecx,%ecx
     52f:	74 05                	je     536 <gettoken+0x66>
    *eq = s;
     531:	8b 45 14             	mov    0x14(%ebp),%eax
     534:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     536:	39 df                	cmp    %ebx,%edi
     538:	72 0d                	jb     547 <gettoken+0x77>
     53a:	eb 23                	jmp    55f <gettoken+0x8f>
     53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     540:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     543:	39 fb                	cmp    %edi,%ebx
     545:	74 18                	je     55f <gettoken+0x8f>
     547:	0f be 07             	movsbl (%edi),%eax
     54a:	83 ec 08             	sub    $0x8,%esp
     54d:	50                   	push   %eax
     54e:	68 20 1a 00 00       	push   $0x1a20
     553:	e8 b8 07 00 00       	call   d10 <strchr>
     558:	83 c4 10             	add    $0x10,%esp
     55b:	85 c0                	test   %eax,%eax
     55d:	75 e1                	jne    540 <gettoken+0x70>
  *ps = s;
     55f:	8b 45 08             	mov    0x8(%ebp),%eax
     562:	89 38                	mov    %edi,(%eax)
  return ret;
}
     564:	8d 65 f4             	lea    -0xc(%ebp),%esp
     567:	89 f0                	mov    %esi,%eax
     569:	5b                   	pop    %ebx
     56a:	5e                   	pop    %esi
     56b:	5f                   	pop    %edi
     56c:	5d                   	pop    %ebp
     56d:	c3                   	ret
     56e:	66 90                	xchg   %ax,%ax
  switch(*s){
     570:	78 22                	js     594 <gettoken+0xc4>
     572:	3c 26                	cmp    $0x26,%al
     574:	74 08                	je     57e <gettoken+0xae>
     576:	8d 48 d8             	lea    -0x28(%eax),%ecx
     579:	80 f9 01             	cmp    $0x1,%cl
     57c:	77 16                	ja     594 <gettoken+0xc4>
  ret = *s;
     57e:	0f be f0             	movsbl %al,%esi
    s++;
     581:	83 c7 01             	add    $0x1,%edi
    break;
     584:	eb a4                	jmp    52a <gettoken+0x5a>
     586:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     58d:	00 
     58e:	66 90                	xchg   %ax,%ax
  switch(*s){
     590:	3c 7c                	cmp    $0x7c,%al
     592:	74 ea                	je     57e <gettoken+0xae>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     594:	39 df                	cmp    %ebx,%edi
     596:	72 27                	jb     5bf <gettoken+0xef>
     598:	e9 87 00 00 00       	jmp    624 <gettoken+0x154>
     59d:	8d 76 00             	lea    0x0(%esi),%esi
     5a0:	0f be 07             	movsbl (%edi),%eax
     5a3:	83 ec 08             	sub    $0x8,%esp
     5a6:	50                   	push   %eax
     5a7:	68 18 1a 00 00       	push   $0x1a18
     5ac:	e8 5f 07 00 00       	call   d10 <strchr>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	85 c0                	test   %eax,%eax
     5b6:	75 1f                	jne    5d7 <gettoken+0x107>
      s++;
     5b8:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5bb:	39 fb                	cmp    %edi,%ebx
     5bd:	74 4d                	je     60c <gettoken+0x13c>
     5bf:	0f be 07             	movsbl (%edi),%eax
     5c2:	83 ec 08             	sub    $0x8,%esp
     5c5:	50                   	push   %eax
     5c6:	68 20 1a 00 00       	push   $0x1a20
     5cb:	e8 40 07 00 00       	call   d10 <strchr>
     5d0:	83 c4 10             	add    $0x10,%esp
     5d3:	85 c0                	test   %eax,%eax
     5d5:	74 c9                	je     5a0 <gettoken+0xd0>
    ret = 'a';
     5d7:	be 61 00 00 00       	mov    $0x61,%esi
     5dc:	e9 49 ff ff ff       	jmp    52a <gettoken+0x5a>
     5e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     5e8:	3c 3e                	cmp    $0x3e,%al
     5ea:	75 a4                	jne    590 <gettoken+0xc0>
    if(*s == '>'){
     5ec:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     5f0:	74 0d                	je     5ff <gettoken+0x12f>
    s++;
     5f2:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     5f5:	be 3e 00 00 00       	mov    $0x3e,%esi
     5fa:	e9 2b ff ff ff       	jmp    52a <gettoken+0x5a>
      s++;
     5ff:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     602:	be 2b 00 00 00       	mov    $0x2b,%esi
     607:	e9 1e ff ff ff       	jmp    52a <gettoken+0x5a>
  if(eq)
     60c:	8b 45 14             	mov    0x14(%ebp),%eax
     60f:	85 c0                	test   %eax,%eax
     611:	74 05                	je     618 <gettoken+0x148>
    *eq = s;
     613:	8b 45 14             	mov    0x14(%ebp),%eax
     616:	89 18                	mov    %ebx,(%eax)
  while(s < es && strchr(whitespace, *s))
     618:	89 df                	mov    %ebx,%edi
    ret = 'a';
     61a:	be 61 00 00 00       	mov    $0x61,%esi
     61f:	e9 3b ff ff ff       	jmp    55f <gettoken+0x8f>
  if(eq)
     624:	8b 55 14             	mov    0x14(%ebp),%edx
     627:	85 d2                	test   %edx,%edx
     629:	74 ef                	je     61a <gettoken+0x14a>
    *eq = s;
     62b:	8b 45 14             	mov    0x14(%ebp),%eax
     62e:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     630:	eb e8                	jmp    61a <gettoken+0x14a>
     632:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     639:	00 
     63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000640 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	57                   	push   %edi
     644:	56                   	push   %esi
     645:	53                   	push   %ebx
     646:	83 ec 0c             	sub    $0xc,%esp
     649:	8b 7d 08             	mov    0x8(%ebp),%edi
     64c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     64f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     651:	39 f3                	cmp    %esi,%ebx
     653:	72 12                	jb     667 <peek+0x27>
     655:	eb 28                	jmp    67f <peek+0x3f>
     657:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     65e:	00 
     65f:	90                   	nop
    s++;
     660:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     663:	39 de                	cmp    %ebx,%esi
     665:	74 18                	je     67f <peek+0x3f>
     667:	0f be 03             	movsbl (%ebx),%eax
     66a:	83 ec 08             	sub    $0x8,%esp
     66d:	50                   	push   %eax
     66e:	68 20 1a 00 00       	push   $0x1a20
     673:	e8 98 06 00 00       	call   d10 <strchr>
     678:	83 c4 10             	add    $0x10,%esp
     67b:	85 c0                	test   %eax,%eax
     67d:	75 e1                	jne    660 <peek+0x20>
  *ps = s;
     67f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     681:	0f be 03             	movsbl (%ebx),%eax
     684:	31 d2                	xor    %edx,%edx
     686:	84 c0                	test   %al,%al
     688:	75 0e                	jne    698 <peek+0x58>
}
     68a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     68d:	89 d0                	mov    %edx,%eax
     68f:	5b                   	pop    %ebx
     690:	5e                   	pop    %esi
     691:	5f                   	pop    %edi
     692:	5d                   	pop    %ebp
     693:	c3                   	ret
     694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     698:	83 ec 08             	sub    $0x8,%esp
     69b:	50                   	push   %eax
     69c:	ff 75 10             	push   0x10(%ebp)
     69f:	e8 6c 06 00 00       	call   d10 <strchr>
     6a4:	83 c4 10             	add    $0x10,%esp
     6a7:	31 d2                	xor    %edx,%edx
     6a9:	85 c0                	test   %eax,%eax
     6ab:	0f 95 c2             	setne  %dl
}
     6ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6b1:	5b                   	pop    %ebx
     6b2:	89 d0                	mov    %edx,%eax
     6b4:	5e                   	pop    %esi
     6b5:	5f                   	pop    %edi
     6b6:	5d                   	pop    %ebp
     6b7:	c3                   	ret
     6b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6bf:	00 

000006c0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	57                   	push   %edi
     6c4:	56                   	push   %esi
     6c5:	53                   	push   %ebx
     6c6:	83 ec 2c             	sub    $0x2c,%esp
     6c9:	8b 75 0c             	mov    0xc(%ebp),%esi
     6cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6cf:	90                   	nop
     6d0:	83 ec 04             	sub    $0x4,%esp
     6d3:	68 29 13 00 00       	push   $0x1329
     6d8:	53                   	push   %ebx
     6d9:	56                   	push   %esi
     6da:	e8 61 ff ff ff       	call   640 <peek>
     6df:	83 c4 10             	add    $0x10,%esp
     6e2:	85 c0                	test   %eax,%eax
     6e4:	0f 84 f6 00 00 00    	je     7e0 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     6ea:	6a 00                	push   $0x0
     6ec:	6a 00                	push   $0x0
     6ee:	53                   	push   %ebx
     6ef:	56                   	push   %esi
     6f0:	e8 db fd ff ff       	call   4d0 <gettoken>
     6f5:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     6f7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     6fa:	50                   	push   %eax
     6fb:	8d 45 e0             	lea    -0x20(%ebp),%eax
     6fe:	50                   	push   %eax
     6ff:	53                   	push   %ebx
     700:	56                   	push   %esi
     701:	e8 ca fd ff ff       	call   4d0 <gettoken>
     706:	83 c4 20             	add    $0x20,%esp
     709:	83 f8 61             	cmp    $0x61,%eax
     70c:	0f 85 d9 00 00 00    	jne    7eb <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     712:	83 ff 3c             	cmp    $0x3c,%edi
     715:	74 69                	je     780 <parseredirs+0xc0>
     717:	83 ff 3e             	cmp    $0x3e,%edi
     71a:	74 05                	je     721 <parseredirs+0x61>
     71c:	83 ff 2b             	cmp    $0x2b,%edi
     71f:	75 af                	jne    6d0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     721:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     724:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     727:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     72a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     72d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     730:	6a 18                	push   $0x18
     732:	e8 b9 0a 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     737:	83 c4 0c             	add    $0xc,%esp
     73a:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     73c:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     73e:	6a 00                	push   $0x0
     740:	50                   	push   %eax
     741:	e8 aa 05 00 00       	call   cf0 <memset>
  cmd->type = REDIR;
     746:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     74c:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     74f:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     752:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     755:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     758:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     75b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     75e:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     765:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     768:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     76f:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     772:	e9 59 ff ff ff       	jmp    6d0 <parseredirs+0x10>
     777:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     77e:	00 
     77f:	90                   	nop
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     780:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     783:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     786:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     789:	89 55 d0             	mov    %edx,-0x30(%ebp)
     78c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     78f:	6a 18                	push   $0x18
     791:	e8 5a 0a 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     796:	83 c4 0c             	add    $0xc,%esp
     799:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     79b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     79d:	6a 00                	push   $0x0
     79f:	50                   	push   %eax
     7a0:	e8 4b 05 00 00       	call   cf0 <memset>
  cmd->cmd = subcmd;
     7a5:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     7a8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     7ab:	83 c4 10             	add    $0x10,%esp
  cmd->efile = efile;
     7ae:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     7b1:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     7b7:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     7ba:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     7bd:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     7c0:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     7c7:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     7ce:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     7d1:	e9 fa fe ff ff       	jmp    6d0 <parseredirs+0x10>
     7d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7dd:	00 
     7de:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     7e0:	8b 45 08             	mov    0x8(%ebp),%eax
     7e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7e6:	5b                   	pop    %ebx
     7e7:	5e                   	pop    %esi
     7e8:	5f                   	pop    %edi
     7e9:	5d                   	pop    %ebp
     7ea:	c3                   	ret
      panic("missing file for redirection");
     7eb:	83 ec 0c             	sub    $0xc,%esp
     7ee:	68 0c 13 00 00       	push   $0x130c
     7f3:	e8 d8 f9 ff ff       	call   1d0 <panic>
     7f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7ff:	00 

00000800 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 30             	sub    $0x30,%esp
     809:	8b 5d 08             	mov    0x8(%ebp),%ebx
     80c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     80f:	68 2c 13 00 00       	push   $0x132c
     814:	56                   	push   %esi
     815:	53                   	push   %ebx
     816:	e8 25 fe ff ff       	call   640 <peek>
     81b:	83 c4 10             	add    $0x10,%esp
     81e:	85 c0                	test   %eax,%eax
     820:	0f 85 aa 00 00 00    	jne    8d0 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     826:	83 ec 0c             	sub    $0xc,%esp
     829:	89 c7                	mov    %eax,%edi
     82b:	6a 54                	push   $0x54
     82d:	e8 be 09 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     832:	83 c4 0c             	add    $0xc,%esp
     835:	6a 54                	push   $0x54
     837:	6a 00                	push   $0x0
     839:	89 45 d0             	mov    %eax,-0x30(%ebp)
     83c:	50                   	push   %eax
     83d:	e8 ae 04 00 00       	call   cf0 <memset>
  cmd->type = EXEC;
     842:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     845:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     848:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     84e:	56                   	push   %esi
     84f:	53                   	push   %ebx
     850:	50                   	push   %eax
     851:	e8 6a fe ff ff       	call   6c0 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     856:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     859:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     85c:	eb 15                	jmp    873 <parseexec+0x73>
     85e:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     860:	83 ec 04             	sub    $0x4,%esp
     863:	56                   	push   %esi
     864:	53                   	push   %ebx
     865:	ff 75 d4             	push   -0x2c(%ebp)
     868:	e8 53 fe ff ff       	call   6c0 <parseredirs>
     86d:	83 c4 10             	add    $0x10,%esp
     870:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     873:	83 ec 04             	sub    $0x4,%esp
     876:	68 43 13 00 00       	push   $0x1343
     87b:	56                   	push   %esi
     87c:	53                   	push   %ebx
     87d:	e8 be fd ff ff       	call   640 <peek>
     882:	83 c4 10             	add    $0x10,%esp
     885:	85 c0                	test   %eax,%eax
     887:	75 5f                	jne    8e8 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     889:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     88c:	50                   	push   %eax
     88d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     890:	50                   	push   %eax
     891:	56                   	push   %esi
     892:	53                   	push   %ebx
     893:	e8 38 fc ff ff       	call   4d0 <gettoken>
     898:	83 c4 10             	add    $0x10,%esp
     89b:	85 c0                	test   %eax,%eax
     89d:	74 49                	je     8e8 <parseexec+0xe8>
    if(tok != 'a')
     89f:	83 f8 61             	cmp    $0x61,%eax
     8a2:	75 62                	jne    906 <parseexec+0x106>
    cmd->argv[argc] = q;
     8a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     8a7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     8aa:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     8ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8b1:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     8b5:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     8b8:	83 ff 0a             	cmp    $0xa,%edi
     8bb:	75 a3                	jne    860 <parseexec+0x60>
      panic("too many args");
     8bd:	83 ec 0c             	sub    $0xc,%esp
     8c0:	68 35 13 00 00       	push   $0x1335
     8c5:	e8 06 f9 ff ff       	call   1d0 <panic>
     8ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     8d0:	89 75 0c             	mov    %esi,0xc(%ebp)
     8d3:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     8d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8d9:	5b                   	pop    %ebx
     8da:	5e                   	pop    %esi
     8db:	5f                   	pop    %edi
     8dc:	5d                   	pop    %ebp
    return parseblock(ps, es);
     8dd:	e9 ae 01 00 00       	jmp    a90 <parseblock>
     8e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     8e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     8eb:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     8f2:	00 
  cmd->eargv[argc] = 0;
     8f3:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     8fa:	00 
}
     8fb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     8fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
     901:	5b                   	pop    %ebx
     902:	5e                   	pop    %esi
     903:	5f                   	pop    %edi
     904:	5d                   	pop    %ebp
     905:	c3                   	ret
      panic("syntax");
     906:	83 ec 0c             	sub    $0xc,%esp
     909:	68 2e 13 00 00       	push   $0x132e
     90e:	e8 bd f8 ff ff       	call   1d0 <panic>
     913:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     91a:	00 
     91b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000920 <parsepipe>:
{
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
     923:	57                   	push   %edi
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	83 ec 14             	sub    $0x14,%esp
     929:	8b 75 08             	mov    0x8(%ebp),%esi
     92c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     92f:	57                   	push   %edi
     930:	56                   	push   %esi
     931:	e8 ca fe ff ff       	call   800 <parseexec>
  if(peek(ps, es, "|")){
     936:	83 c4 0c             	add    $0xc,%esp
     939:	68 48 13 00 00       	push   $0x1348
  cmd = parseexec(ps, es);
     93e:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     940:	57                   	push   %edi
     941:	56                   	push   %esi
     942:	e8 f9 fc ff ff       	call   640 <peek>
     947:	83 c4 10             	add    $0x10,%esp
     94a:	85 c0                	test   %eax,%eax
     94c:	75 12                	jne    960 <parsepipe+0x40>
}
     94e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     951:	89 d8                	mov    %ebx,%eax
     953:	5b                   	pop    %ebx
     954:	5e                   	pop    %esi
     955:	5f                   	pop    %edi
     956:	5d                   	pop    %ebp
     957:	c3                   	ret
     958:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     95f:	00 
    gettoken(ps, es, 0, 0);
     960:	6a 00                	push   $0x0
     962:	6a 00                	push   $0x0
     964:	57                   	push   %edi
     965:	56                   	push   %esi
     966:	e8 65 fb ff ff       	call   4d0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     96b:	58                   	pop    %eax
     96c:	5a                   	pop    %edx
     96d:	57                   	push   %edi
     96e:	56                   	push   %esi
     96f:	e8 ac ff ff ff       	call   920 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     974:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     97b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     97d:	e8 6e 08 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     982:	83 c4 0c             	add    $0xc,%esp
     985:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     987:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     989:	6a 00                	push   $0x0
     98b:	50                   	push   %eax
     98c:	e8 5f 03 00 00       	call   cf0 <memset>
  cmd->left = left;
     991:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     994:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     997:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     999:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     99f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     9a1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     9a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9a7:	5b                   	pop    %ebx
     9a8:	5e                   	pop    %esi
     9a9:	5f                   	pop    %edi
     9aa:	5d                   	pop    %ebp
     9ab:	c3                   	ret
     9ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009b0 <parseline>:
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	57                   	push   %edi
     9b4:	56                   	push   %esi
     9b5:	53                   	push   %ebx
     9b6:	83 ec 24             	sub    $0x24,%esp
     9b9:	8b 75 08             	mov    0x8(%ebp),%esi
     9bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     9bf:	57                   	push   %edi
     9c0:	56                   	push   %esi
     9c1:	e8 5a ff ff ff       	call   920 <parsepipe>
  while(peek(ps, es, "&")){
     9c6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     9c9:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     9cb:	eb 3b                	jmp    a08 <parseline+0x58>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     9d0:	6a 00                	push   $0x0
     9d2:	6a 00                	push   $0x0
     9d4:	57                   	push   %edi
     9d5:	56                   	push   %esi
     9d6:	e8 f5 fa ff ff       	call   4d0 <gettoken>
  cmd = malloc(sizeof(*cmd));
     9db:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     9e2:	e8 09 08 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     9e7:	83 c4 0c             	add    $0xc,%esp
     9ea:	6a 08                	push   $0x8
     9ec:	6a 00                	push   $0x0
     9ee:	50                   	push   %eax
     9ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     9f2:	e8 f9 02 00 00       	call   cf0 <memset>
  cmd->type = BACK;
     9f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     9fa:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     9fd:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     a03:	89 5a 04             	mov    %ebx,0x4(%edx)
    cmd = backcmd(cmd);
     a06:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     a08:	83 ec 04             	sub    $0x4,%esp
     a0b:	68 4a 13 00 00       	push   $0x134a
     a10:	57                   	push   %edi
     a11:	56                   	push   %esi
     a12:	e8 29 fc ff ff       	call   640 <peek>
     a17:	83 c4 10             	add    $0x10,%esp
     a1a:	85 c0                	test   %eax,%eax
     a1c:	75 b2                	jne    9d0 <parseline+0x20>
  if(peek(ps, es, ";")){
     a1e:	83 ec 04             	sub    $0x4,%esp
     a21:	68 46 13 00 00       	push   $0x1346
     a26:	57                   	push   %edi
     a27:	56                   	push   %esi
     a28:	e8 13 fc ff ff       	call   640 <peek>
     a2d:	83 c4 10             	add    $0x10,%esp
     a30:	85 c0                	test   %eax,%eax
     a32:	75 0c                	jne    a40 <parseline+0x90>
}
     a34:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a37:	89 d8                	mov    %ebx,%eax
     a39:	5b                   	pop    %ebx
     a3a:	5e                   	pop    %esi
     a3b:	5f                   	pop    %edi
     a3c:	5d                   	pop    %ebp
     a3d:	c3                   	ret
     a3e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     a40:	6a 00                	push   $0x0
     a42:	6a 00                	push   $0x0
     a44:	57                   	push   %edi
     a45:	56                   	push   %esi
     a46:	e8 85 fa ff ff       	call   4d0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     a4b:	58                   	pop    %eax
     a4c:	5a                   	pop    %edx
     a4d:	57                   	push   %edi
     a4e:	56                   	push   %esi
     a4f:	e8 5c ff ff ff       	call   9b0 <parseline>
  cmd = malloc(sizeof(*cmd));
     a54:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     a5b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     a5d:	e8 8e 07 00 00       	call   11f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a62:	83 c4 0c             	add    $0xc,%esp
     a65:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     a67:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     a69:	6a 00                	push   $0x0
     a6b:	50                   	push   %eax
     a6c:	e8 7f 02 00 00       	call   cf0 <memset>
  cmd->left = left;
     a71:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     a74:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     a77:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     a79:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     a7f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     a81:	89 7e 08             	mov    %edi,0x8(%esi)
}
     a84:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a87:	5b                   	pop    %ebx
     a88:	5e                   	pop    %esi
     a89:	5f                   	pop    %edi
     a8a:	5d                   	pop    %ebp
     a8b:	c3                   	ret
     a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a90 <parseblock>:
{
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	57                   	push   %edi
     a94:	56                   	push   %esi
     a95:	53                   	push   %ebx
     a96:	83 ec 10             	sub    $0x10,%esp
     a99:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a9c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     a9f:	68 2c 13 00 00       	push   $0x132c
     aa4:	56                   	push   %esi
     aa5:	53                   	push   %ebx
     aa6:	e8 95 fb ff ff       	call   640 <peek>
     aab:	83 c4 10             	add    $0x10,%esp
     aae:	85 c0                	test   %eax,%eax
     ab0:	74 4a                	je     afc <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     ab2:	6a 00                	push   $0x0
     ab4:	6a 00                	push   $0x0
     ab6:	56                   	push   %esi
     ab7:	53                   	push   %ebx
     ab8:	e8 13 fa ff ff       	call   4d0 <gettoken>
  cmd = parseline(ps, es);
     abd:	58                   	pop    %eax
     abe:	5a                   	pop    %edx
     abf:	56                   	push   %esi
     ac0:	53                   	push   %ebx
     ac1:	e8 ea fe ff ff       	call   9b0 <parseline>
  if(!peek(ps, es, ")"))
     ac6:	83 c4 0c             	add    $0xc,%esp
     ac9:	68 68 13 00 00       	push   $0x1368
  cmd = parseline(ps, es);
     ace:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     ad0:	56                   	push   %esi
     ad1:	53                   	push   %ebx
     ad2:	e8 69 fb ff ff       	call   640 <peek>
     ad7:	83 c4 10             	add    $0x10,%esp
     ada:	85 c0                	test   %eax,%eax
     adc:	74 2b                	je     b09 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     ade:	6a 00                	push   $0x0
     ae0:	6a 00                	push   $0x0
     ae2:	56                   	push   %esi
     ae3:	53                   	push   %ebx
     ae4:	e8 e7 f9 ff ff       	call   4d0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     ae9:	83 c4 0c             	add    $0xc,%esp
     aec:	56                   	push   %esi
     aed:	53                   	push   %ebx
     aee:	57                   	push   %edi
     aef:	e8 cc fb ff ff       	call   6c0 <parseredirs>
}
     af4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     af7:	5b                   	pop    %ebx
     af8:	5e                   	pop    %esi
     af9:	5f                   	pop    %edi
     afa:	5d                   	pop    %ebp
     afb:	c3                   	ret
    panic("parseblock");
     afc:	83 ec 0c             	sub    $0xc,%esp
     aff:	68 4c 13 00 00       	push   $0x134c
     b04:	e8 c7 f6 ff ff       	call   1d0 <panic>
    panic("syntax - missing )");
     b09:	83 ec 0c             	sub    $0xc,%esp
     b0c:	68 57 13 00 00       	push   $0x1357
     b11:	e8 ba f6 ff ff       	call   1d0 <panic>
     b16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b1d:	00 
     b1e:	66 90                	xchg   %ax,%ax

00000b20 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
     b23:	53                   	push   %ebx
     b24:	83 ec 04             	sub    $0x4,%esp
     b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b2a:	85 db                	test   %ebx,%ebx
     b2c:	74 29                	je     b57 <nulterminate+0x37>
    return 0;

  switch(cmd->type){
     b2e:	83 3b 05             	cmpl   $0x5,(%ebx)
     b31:	77 24                	ja     b57 <nulterminate+0x37>
     b33:	8b 03                	mov    (%ebx),%eax
     b35:	ff 24 85 b0 13 00 00 	jmp    *0x13b0(,%eax,4)
     b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     b40:	83 ec 0c             	sub    $0xc,%esp
     b43:	ff 73 04             	push   0x4(%ebx)
     b46:	e8 d5 ff ff ff       	call   b20 <nulterminate>
    nulterminate(lcmd->right);
     b4b:	58                   	pop    %eax
     b4c:	ff 73 08             	push   0x8(%ebx)
     b4f:	e8 cc ff ff ff       	call   b20 <nulterminate>
    break;
     b54:	83 c4 10             	add    $0x10,%esp
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     b57:	89 d8                	mov    %ebx,%eax
     b59:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b5c:	c9                   	leave
     b5d:	c3                   	ret
     b5e:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     b60:	83 ec 0c             	sub    $0xc,%esp
     b63:	ff 73 04             	push   0x4(%ebx)
     b66:	e8 b5 ff ff ff       	call   b20 <nulterminate>
}
     b6b:	89 d8                	mov    %ebx,%eax
    break;
     b6d:	83 c4 10             	add    $0x10,%esp
}
     b70:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b73:	c9                   	leave
     b74:	c3                   	ret
     b75:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     b78:	8b 4b 04             	mov    0x4(%ebx),%ecx
     b7b:	85 c9                	test   %ecx,%ecx
     b7d:	74 d8                	je     b57 <nulterminate+0x37>
     b7f:	8d 43 08             	lea    0x8(%ebx),%eax
     b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     b88:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     b8b:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     b8e:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     b91:	8b 50 fc             	mov    -0x4(%eax),%edx
     b94:	85 d2                	test   %edx,%edx
     b96:	75 f0                	jne    b88 <nulterminate+0x68>
}
     b98:	89 d8                	mov    %ebx,%eax
     b9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b9d:	c9                   	leave
     b9e:	c3                   	ret
     b9f:	90                   	nop
    nulterminate(rcmd->cmd);
     ba0:	83 ec 0c             	sub    $0xc,%esp
     ba3:	ff 73 04             	push   0x4(%ebx)
     ba6:	e8 75 ff ff ff       	call   b20 <nulterminate>
    *rcmd->efile = 0;
     bab:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     bae:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     bb1:	c6 00 00             	movb   $0x0,(%eax)
}
     bb4:	89 d8                	mov    %ebx,%eax
     bb6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bb9:	c9                   	leave
     bba:	c3                   	ret
     bbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000bc0 <parsecmd>:
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	57                   	push   %edi
     bc4:	56                   	push   %esi
  cmd = parseline(&s, es);
     bc5:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     bc8:	53                   	push   %ebx
     bc9:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     bcc:	8b 5d 08             	mov    0x8(%ebp),%ebx
     bcf:	53                   	push   %ebx
     bd0:	e8 eb 00 00 00       	call   cc0 <strlen>
  cmd = parseline(&s, es);
     bd5:	59                   	pop    %ecx
     bd6:	5e                   	pop    %esi
  es = s + strlen(s);
     bd7:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     bd9:	53                   	push   %ebx
     bda:	57                   	push   %edi
     bdb:	e8 d0 fd ff ff       	call   9b0 <parseline>
  peek(&s, es, "");
     be0:	83 c4 0c             	add    $0xc,%esp
     be3:	68 f6 12 00 00       	push   $0x12f6
  cmd = parseline(&s, es);
     be8:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     bea:	53                   	push   %ebx
     beb:	57                   	push   %edi
     bec:	e8 4f fa ff ff       	call   640 <peek>
  if(s != es){
     bf1:	8b 45 08             	mov    0x8(%ebp),%eax
     bf4:	83 c4 10             	add    $0x10,%esp
     bf7:	39 d8                	cmp    %ebx,%eax
     bf9:	75 13                	jne    c0e <parsecmd+0x4e>
  nulterminate(cmd);
     bfb:	83 ec 0c             	sub    $0xc,%esp
     bfe:	56                   	push   %esi
     bff:	e8 1c ff ff ff       	call   b20 <nulterminate>
}
     c04:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c07:	89 f0                	mov    %esi,%eax
     c09:	5b                   	pop    %ebx
     c0a:	5e                   	pop    %esi
     c0b:	5f                   	pop    %edi
     c0c:	5d                   	pop    %ebp
     c0d:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     c0e:	52                   	push   %edx
     c0f:	50                   	push   %eax
     c10:	68 6a 13 00 00       	push   $0x136a
     c15:	6a 02                	push   $0x2
     c17:	e8 b4 03 00 00       	call   fd0 <printf>
    panic("syntax");
     c1c:	c7 04 24 2e 13 00 00 	movl   $0x132e,(%esp)
     c23:	e8 a8 f5 ff ff       	call   1d0 <panic>
     c28:	66 90                	xchg   %ax,%ax
     c2a:	66 90                	xchg   %ax,%ax
     c2c:	66 90                	xchg   %ax,%ax
     c2e:	66 90                	xchg   %ax,%ax

00000c30 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     c30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c31:	31 c0                	xor    %eax,%eax
{
     c33:	89 e5                	mov    %esp,%ebp
     c35:	53                   	push   %ebx
     c36:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     c40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     c44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     c47:	83 c0 01             	add    $0x1,%eax
     c4a:	84 d2                	test   %dl,%dl
     c4c:	75 f2                	jne    c40 <strcpy+0x10>
    ;
  return os;
}
     c4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c51:	89 c8                	mov    %ecx,%eax
     c53:	c9                   	leave
     c54:	c3                   	ret
     c55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     c5c:	00 
     c5d:	8d 76 00             	lea    0x0(%esi),%esi

00000c60 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	53                   	push   %ebx
     c64:	8b 55 08             	mov    0x8(%ebp),%edx
     c67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     c6a:	0f b6 02             	movzbl (%edx),%eax
     c6d:	84 c0                	test   %al,%al
     c6f:	75 17                	jne    c88 <strcmp+0x28>
     c71:	eb 3a                	jmp    cad <strcmp+0x4d>
     c73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     c78:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     c7c:	83 c2 01             	add    $0x1,%edx
     c7f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     c82:	84 c0                	test   %al,%al
     c84:	74 1a                	je     ca0 <strcmp+0x40>
     c86:	89 d9                	mov    %ebx,%ecx
     c88:	0f b6 19             	movzbl (%ecx),%ebx
     c8b:	38 c3                	cmp    %al,%bl
     c8d:	74 e9                	je     c78 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     c8f:	29 d8                	sub    %ebx,%eax
}
     c91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c94:	c9                   	leave
     c95:	c3                   	ret
     c96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     c9d:	00 
     c9e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
     ca0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     ca4:	31 c0                	xor    %eax,%eax
     ca6:	29 d8                	sub    %ebx,%eax
}
     ca8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cab:	c9                   	leave
     cac:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     cad:	0f b6 19             	movzbl (%ecx),%ebx
     cb0:	31 c0                	xor    %eax,%eax
     cb2:	eb db                	jmp    c8f <strcmp+0x2f>
     cb4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     cbb:	00 
     cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000cc0 <strlen>:

uint
strlen(const char *s)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     cc6:	80 3a 00             	cmpb   $0x0,(%edx)
     cc9:	74 15                	je     ce0 <strlen+0x20>
     ccb:	31 c0                	xor    %eax,%eax
     ccd:	8d 76 00             	lea    0x0(%esi),%esi
     cd0:	83 c0 01             	add    $0x1,%eax
     cd3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     cd7:	89 c1                	mov    %eax,%ecx
     cd9:	75 f5                	jne    cd0 <strlen+0x10>
    ;
  return n;
}
     cdb:	89 c8                	mov    %ecx,%eax
     cdd:	5d                   	pop    %ebp
     cde:	c3                   	ret
     cdf:	90                   	nop
  for(n = 0; s[n]; n++)
     ce0:	31 c9                	xor    %ecx,%ecx
}
     ce2:	5d                   	pop    %ebp
     ce3:	89 c8                	mov    %ecx,%eax
     ce5:	c3                   	ret
     ce6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ced:	00 
     cee:	66 90                	xchg   %ax,%ax

00000cf0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	57                   	push   %edi
     cf4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     cf7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     cfa:	8b 45 0c             	mov    0xc(%ebp),%eax
     cfd:	89 d7                	mov    %edx,%edi
     cff:	fc                   	cld
     d00:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     d02:	8b 7d fc             	mov    -0x4(%ebp),%edi
     d05:	89 d0                	mov    %edx,%eax
     d07:	c9                   	leave
     d08:	c3                   	ret
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d10 <strchr>:

char*
strchr(const char *s, char c)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	8b 45 08             	mov    0x8(%ebp),%eax
     d16:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     d1a:	0f b6 10             	movzbl (%eax),%edx
     d1d:	84 d2                	test   %dl,%dl
     d1f:	75 12                	jne    d33 <strchr+0x23>
     d21:	eb 1d                	jmp    d40 <strchr+0x30>
     d23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     d28:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     d2c:	83 c0 01             	add    $0x1,%eax
     d2f:	84 d2                	test   %dl,%dl
     d31:	74 0d                	je     d40 <strchr+0x30>
    if(*s == c)
     d33:	38 d1                	cmp    %dl,%cl
     d35:	75 f1                	jne    d28 <strchr+0x18>
      return (char*)s;
  return 0;
}
     d37:	5d                   	pop    %ebp
     d38:	c3                   	ret
     d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     d40:	31 c0                	xor    %eax,%eax
}
     d42:	5d                   	pop    %ebp
     d43:	c3                   	ret
     d44:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d4b:	00 
     d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d50 <gets>:

char*
gets(char *buf, int max)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	57                   	push   %edi
     d54:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     d55:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
     d58:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     d59:	31 db                	xor    %ebx,%ebx
     d5b:	8d 73 01             	lea    0x1(%ebx),%esi
{
     d5e:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     d61:	3b 75 0c             	cmp    0xc(%ebp),%esi
     d64:	7d 3b                	jge    da1 <gets+0x51>
     d66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d6d:	00 
     d6e:	66 90                	xchg   %ax,%ax
    cc = read(0, &c, 1);
     d70:	83 ec 04             	sub    $0x4,%esp
     d73:	6a 01                	push   $0x1
     d75:	57                   	push   %edi
     d76:	6a 00                	push   $0x0
     d78:	e8 1e 01 00 00       	call   e9b <read>
    // printf(2, "read returned %d, char=%c\n", cc, c);
    if(cc < 1)
     d7d:	83 c4 10             	add    $0x10,%esp
     d80:	85 c0                	test   %eax,%eax
     d82:	7e 1d                	jle    da1 <gets+0x51>
      break;
    buf[i++] = c;
     d84:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     d88:	8b 55 08             	mov    0x8(%ebp),%edx
     d8b:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r' || c=='\t')
     d8f:	3c 0a                	cmp    $0xa,%al
     d91:	7f 25                	jg     db8 <gets+0x68>
     d93:	3c 08                	cmp    $0x8,%al
     d95:	7f 0c                	jg     da3 <gets+0x53>
{
     d97:	89 f3                	mov    %esi,%ebx
  for(i=0; i+1 < max; ){
     d99:	8d 73 01             	lea    0x1(%ebx),%esi
     d9c:	3b 75 0c             	cmp    0xc(%ebp),%esi
     d9f:	7c cf                	jl     d70 <gets+0x20>
     da1:	89 de                	mov    %ebx,%esi
      break;
      
  }
  buf[i] = '\0';
     da3:	8b 45 08             	mov    0x8(%ebp),%eax
     da6:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     daa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dad:	5b                   	pop    %ebx
     dae:	5e                   	pop    %esi
     daf:	5f                   	pop    %edi
     db0:	5d                   	pop    %ebp
     db1:	c3                   	ret
     db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     db8:	3c 0d                	cmp    $0xd,%al
     dba:	74 e7                	je     da3 <gets+0x53>
{
     dbc:	89 f3                	mov    %esi,%ebx
     dbe:	eb d9                	jmp    d99 <gets+0x49>

00000dc0 <stat>:

int
stat(const char *n, struct stat *st)
{
     dc0:	55                   	push   %ebp
     dc1:	89 e5                	mov    %esp,%ebp
     dc3:	56                   	push   %esi
     dc4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     dc5:	83 ec 08             	sub    $0x8,%esp
     dc8:	6a 00                	push   $0x0
     dca:	ff 75 08             	push   0x8(%ebp)
     dcd:	e8 f1 00 00 00       	call   ec3 <open>
  if(fd < 0)
     dd2:	83 c4 10             	add    $0x10,%esp
     dd5:	85 c0                	test   %eax,%eax
     dd7:	78 27                	js     e00 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     dd9:	83 ec 08             	sub    $0x8,%esp
     ddc:	ff 75 0c             	push   0xc(%ebp)
     ddf:	89 c3                	mov    %eax,%ebx
     de1:	50                   	push   %eax
     de2:	e8 f4 00 00 00       	call   edb <fstat>
  close(fd);
     de7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     dea:	89 c6                	mov    %eax,%esi
  close(fd);
     dec:	e8 ba 00 00 00       	call   eab <close>
  return r;
     df1:	83 c4 10             	add    $0x10,%esp
}
     df4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     df7:	89 f0                	mov    %esi,%eax
     df9:	5b                   	pop    %ebx
     dfa:	5e                   	pop    %esi
     dfb:	5d                   	pop    %ebp
     dfc:	c3                   	ret
     dfd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     e00:	be ff ff ff ff       	mov    $0xffffffff,%esi
     e05:	eb ed                	jmp    df4 <stat+0x34>
     e07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e0e:	00 
     e0f:	90                   	nop

00000e10 <atoi>:

int
atoi(const char *s)
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	53                   	push   %ebx
     e14:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e17:	0f be 02             	movsbl (%edx),%eax
     e1a:	8d 48 d0             	lea    -0x30(%eax),%ecx
     e1d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     e20:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     e25:	77 1e                	ja     e45 <atoi+0x35>
     e27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e2e:	00 
     e2f:	90                   	nop
    n = n*10 + *s++ - '0';
     e30:	83 c2 01             	add    $0x1,%edx
     e33:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     e36:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     e3a:	0f be 02             	movsbl (%edx),%eax
     e3d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     e40:	80 fb 09             	cmp    $0x9,%bl
     e43:	76 eb                	jbe    e30 <atoi+0x20>
  return n;
}
     e45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e48:	89 c8                	mov    %ecx,%eax
     e4a:	c9                   	leave
     e4b:	c3                   	ret
     e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e50 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	8b 45 10             	mov    0x10(%ebp),%eax
     e57:	8b 55 08             	mov    0x8(%ebp),%edx
     e5a:	56                   	push   %esi
     e5b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e5e:	85 c0                	test   %eax,%eax
     e60:	7e 13                	jle    e75 <memmove+0x25>
     e62:	01 d0                	add    %edx,%eax
  dst = vdst;
     e64:	89 d7                	mov    %edx,%edi
     e66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e6d:	00 
     e6e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
     e70:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     e71:	39 f8                	cmp    %edi,%eax
     e73:	75 fb                	jne    e70 <memmove+0x20>
  return vdst;
}
     e75:	5e                   	pop    %esi
     e76:	89 d0                	mov    %edx,%eax
     e78:	5f                   	pop    %edi
     e79:	5d                   	pop    %ebp
     e7a:	c3                   	ret

00000e7b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e7b:	b8 01 00 00 00       	mov    $0x1,%eax
     e80:	cd 40                	int    $0x40
     e82:	c3                   	ret

00000e83 <exit>:
SYSCALL(exit)
     e83:	b8 02 00 00 00       	mov    $0x2,%eax
     e88:	cd 40                	int    $0x40
     e8a:	c3                   	ret

00000e8b <wait>:
SYSCALL(wait)
     e8b:	b8 03 00 00 00       	mov    $0x3,%eax
     e90:	cd 40                	int    $0x40
     e92:	c3                   	ret

00000e93 <pipe>:
SYSCALL(pipe)
     e93:	b8 04 00 00 00       	mov    $0x4,%eax
     e98:	cd 40                	int    $0x40
     e9a:	c3                   	ret

00000e9b <read>:
SYSCALL(read)
     e9b:	b8 05 00 00 00       	mov    $0x5,%eax
     ea0:	cd 40                	int    $0x40
     ea2:	c3                   	ret

00000ea3 <write>:
SYSCALL(write)
     ea3:	b8 10 00 00 00       	mov    $0x10,%eax
     ea8:	cd 40                	int    $0x40
     eaa:	c3                   	ret

00000eab <close>:
SYSCALL(close)
     eab:	b8 15 00 00 00       	mov    $0x15,%eax
     eb0:	cd 40                	int    $0x40
     eb2:	c3                   	ret

00000eb3 <kill>:
SYSCALL(kill)
     eb3:	b8 06 00 00 00       	mov    $0x6,%eax
     eb8:	cd 40                	int    $0x40
     eba:	c3                   	ret

00000ebb <exec>:
SYSCALL(exec)
     ebb:	b8 07 00 00 00       	mov    $0x7,%eax
     ec0:	cd 40                	int    $0x40
     ec2:	c3                   	ret

00000ec3 <open>:
SYSCALL(open)
     ec3:	b8 0f 00 00 00       	mov    $0xf,%eax
     ec8:	cd 40                	int    $0x40
     eca:	c3                   	ret

00000ecb <mknod>:
SYSCALL(mknod)
     ecb:	b8 11 00 00 00       	mov    $0x11,%eax
     ed0:	cd 40                	int    $0x40
     ed2:	c3                   	ret

00000ed3 <unlink>:
SYSCALL(unlink)
     ed3:	b8 12 00 00 00       	mov    $0x12,%eax
     ed8:	cd 40                	int    $0x40
     eda:	c3                   	ret

00000edb <fstat>:
SYSCALL(fstat)
     edb:	b8 08 00 00 00       	mov    $0x8,%eax
     ee0:	cd 40                	int    $0x40
     ee2:	c3                   	ret

00000ee3 <link>:
SYSCALL(link)
     ee3:	b8 13 00 00 00       	mov    $0x13,%eax
     ee8:	cd 40                	int    $0x40
     eea:	c3                   	ret

00000eeb <mkdir>:
SYSCALL(mkdir)
     eeb:	b8 14 00 00 00       	mov    $0x14,%eax
     ef0:	cd 40                	int    $0x40
     ef2:	c3                   	ret

00000ef3 <chdir>:
SYSCALL(chdir)
     ef3:	b8 09 00 00 00       	mov    $0x9,%eax
     ef8:	cd 40                	int    $0x40
     efa:	c3                   	ret

00000efb <dup>:
SYSCALL(dup)
     efb:	b8 0a 00 00 00       	mov    $0xa,%eax
     f00:	cd 40                	int    $0x40
     f02:	c3                   	ret

00000f03 <getpid>:
SYSCALL(getpid)
     f03:	b8 0b 00 00 00       	mov    $0xb,%eax
     f08:	cd 40                	int    $0x40
     f0a:	c3                   	ret

00000f0b <sbrk>:
SYSCALL(sbrk)
     f0b:	b8 0c 00 00 00       	mov    $0xc,%eax
     f10:	cd 40                	int    $0x40
     f12:	c3                   	ret

00000f13 <sleep>:
SYSCALL(sleep)
     f13:	b8 0d 00 00 00       	mov    $0xd,%eax
     f18:	cd 40                	int    $0x40
     f1a:	c3                   	ret

00000f1b <uptime>:
SYSCALL(uptime)
     f1b:	b8 0e 00 00 00       	mov    $0xe,%eax
     f20:	cd 40                	int    $0x40
     f22:	c3                   	ret
     f23:	66 90                	xchg   %ax,%ax
     f25:	66 90                	xchg   %ax,%ax
     f27:	66 90                	xchg   %ax,%ax
     f29:	66 90                	xchg   %ax,%ax
     f2b:	66 90                	xchg   %ax,%ax
     f2d:	66 90                	xchg   %ax,%ax
     f2f:	90                   	nop

00000f30 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	57                   	push   %edi
     f34:	56                   	push   %esi
     f35:	53                   	push   %ebx
     f36:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     f38:	89 d1                	mov    %edx,%ecx
{
     f3a:	83 ec 3c             	sub    $0x3c,%esp
     f3d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
     f40:	85 d2                	test   %edx,%edx
     f42:	0f 89 80 00 00 00    	jns    fc8 <printint+0x98>
     f48:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     f4c:	74 7a                	je     fc8 <printint+0x98>
    x = -xx;
     f4e:	f7 d9                	neg    %ecx
    neg = 1;
     f50:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
     f55:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     f58:	31 f6                	xor    %esi,%esi
     f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     f60:	89 c8                	mov    %ecx,%eax
     f62:	31 d2                	xor    %edx,%edx
     f64:	89 f7                	mov    %esi,%edi
     f66:	f7 f3                	div    %ebx
     f68:	8d 76 01             	lea    0x1(%esi),%esi
     f6b:	0f b6 92 20 14 00 00 	movzbl 0x1420(%edx),%edx
     f72:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
     f76:	89 ca                	mov    %ecx,%edx
     f78:	89 c1                	mov    %eax,%ecx
     f7a:	39 da                	cmp    %ebx,%edx
     f7c:	73 e2                	jae    f60 <printint+0x30>
  if(neg)
     f7e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     f81:	85 c0                	test   %eax,%eax
     f83:	74 07                	je     f8c <printint+0x5c>
    buf[i++] = '-';
     f85:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
     f8a:	89 f7                	mov    %esi,%edi
     f8c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
     f8f:	8b 75 c0             	mov    -0x40(%ebp),%esi
     f92:	01 df                	add    %ebx,%edi
     f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
     f98:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
     f9b:	83 ec 04             	sub    $0x4,%esp
     f9e:	88 45 d7             	mov    %al,-0x29(%ebp)
     fa1:	8d 45 d7             	lea    -0x29(%ebp),%eax
     fa4:	6a 01                	push   $0x1
     fa6:	50                   	push   %eax
     fa7:	56                   	push   %esi
     fa8:	e8 f6 fe ff ff       	call   ea3 <write>
  while(--i >= 0)
     fad:	89 f8                	mov    %edi,%eax
     faf:	83 c4 10             	add    $0x10,%esp
     fb2:	83 ef 01             	sub    $0x1,%edi
     fb5:	39 c3                	cmp    %eax,%ebx
     fb7:	75 df                	jne    f98 <printint+0x68>
}
     fb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fbc:	5b                   	pop    %ebx
     fbd:	5e                   	pop    %esi
     fbe:	5f                   	pop    %edi
     fbf:	5d                   	pop    %ebp
     fc0:	c3                   	ret
     fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     fc8:	31 c0                	xor    %eax,%eax
     fca:	eb 89                	jmp    f55 <printint+0x25>
     fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000fd0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	57                   	push   %edi
     fd4:	56                   	push   %esi
     fd5:	53                   	push   %ebx
     fd6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     fd9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
     fdc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
     fdf:	0f b6 1e             	movzbl (%esi),%ebx
     fe2:	83 c6 01             	add    $0x1,%esi
     fe5:	84 db                	test   %bl,%bl
     fe7:	74 67                	je     1050 <printf+0x80>
     fe9:	8d 4d 10             	lea    0x10(%ebp),%ecx
     fec:	31 d2                	xor    %edx,%edx
     fee:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     ff1:	eb 34                	jmp    1027 <printf+0x57>
     ff3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     ff8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
     ffb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1000:	83 f8 25             	cmp    $0x25,%eax
    1003:	74 18                	je     101d <printf+0x4d>
  write(fd, &c, 1);
    1005:	83 ec 04             	sub    $0x4,%esp
    1008:	8d 45 e7             	lea    -0x19(%ebp),%eax
    100b:	88 5d e7             	mov    %bl,-0x19(%ebp)
    100e:	6a 01                	push   $0x1
    1010:	50                   	push   %eax
    1011:	57                   	push   %edi
    1012:	e8 8c fe ff ff       	call   ea3 <write>
    1017:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    101a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    101d:	0f b6 1e             	movzbl (%esi),%ebx
    1020:	83 c6 01             	add    $0x1,%esi
    1023:	84 db                	test   %bl,%bl
    1025:	74 29                	je     1050 <printf+0x80>
    c = fmt[i] & 0xff;
    1027:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    102a:	85 d2                	test   %edx,%edx
    102c:	74 ca                	je     ff8 <printf+0x28>
      }
    } else if(state == '%'){
    102e:	83 fa 25             	cmp    $0x25,%edx
    1031:	75 ea                	jne    101d <printf+0x4d>
      if(c == 'd'){
    1033:	83 f8 25             	cmp    $0x25,%eax
    1036:	0f 84 04 01 00 00    	je     1140 <printf+0x170>
    103c:	83 e8 63             	sub    $0x63,%eax
    103f:	83 f8 15             	cmp    $0x15,%eax
    1042:	77 1c                	ja     1060 <printf+0x90>
    1044:	ff 24 85 c8 13 00 00 	jmp    *0x13c8(,%eax,4)
    104b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1050:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1053:	5b                   	pop    %ebx
    1054:	5e                   	pop    %esi
    1055:	5f                   	pop    %edi
    1056:	5d                   	pop    %ebp
    1057:	c3                   	ret
    1058:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    105f:	00 
  write(fd, &c, 1);
    1060:	83 ec 04             	sub    $0x4,%esp
    1063:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1066:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    106a:	6a 01                	push   $0x1
    106c:	52                   	push   %edx
    106d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    1070:	57                   	push   %edi
    1071:	e8 2d fe ff ff       	call   ea3 <write>
    1076:	83 c4 0c             	add    $0xc,%esp
    1079:	88 5d e7             	mov    %bl,-0x19(%ebp)
    107c:	6a 01                	push   $0x1
    107e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1081:	52                   	push   %edx
    1082:	57                   	push   %edi
    1083:	e8 1b fe ff ff       	call   ea3 <write>
        putc(fd, c);
    1088:	83 c4 10             	add    $0x10,%esp
      state = 0;
    108b:	31 d2                	xor    %edx,%edx
    108d:	eb 8e                	jmp    101d <printf+0x4d>
    108f:	90                   	nop
        printint(fd, *ap, 16, 0);
    1090:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1093:	83 ec 0c             	sub    $0xc,%esp
    1096:	b9 10 00 00 00       	mov    $0x10,%ecx
    109b:	8b 13                	mov    (%ebx),%edx
    109d:	6a 00                	push   $0x0
    109f:	89 f8                	mov    %edi,%eax
        ap++;
    10a1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    10a4:	e8 87 fe ff ff       	call   f30 <printint>
        ap++;
    10a9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    10ac:	83 c4 10             	add    $0x10,%esp
      state = 0;
    10af:	31 d2                	xor    %edx,%edx
    10b1:	e9 67 ff ff ff       	jmp    101d <printf+0x4d>
        s = (char*)*ap;
    10b6:	8b 45 d0             	mov    -0x30(%ebp),%eax
    10b9:	8b 18                	mov    (%eax),%ebx
        ap++;
    10bb:	83 c0 04             	add    $0x4,%eax
    10be:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    10c1:	85 db                	test   %ebx,%ebx
    10c3:	0f 84 87 00 00 00    	je     1150 <printf+0x180>
        while(*s != 0){
    10c9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    10cc:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    10ce:	84 c0                	test   %al,%al
    10d0:	0f 84 47 ff ff ff    	je     101d <printf+0x4d>
    10d6:	8d 55 e7             	lea    -0x19(%ebp),%edx
    10d9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    10dc:	89 de                	mov    %ebx,%esi
    10de:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
    10e0:	83 ec 04             	sub    $0x4,%esp
    10e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    10e6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    10e9:	6a 01                	push   $0x1
    10eb:	53                   	push   %ebx
    10ec:	57                   	push   %edi
    10ed:	e8 b1 fd ff ff       	call   ea3 <write>
        while(*s != 0){
    10f2:	0f b6 06             	movzbl (%esi),%eax
    10f5:	83 c4 10             	add    $0x10,%esp
    10f8:	84 c0                	test   %al,%al
    10fa:	75 e4                	jne    10e0 <printf+0x110>
      state = 0;
    10fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    10ff:	31 d2                	xor    %edx,%edx
    1101:	e9 17 ff ff ff       	jmp    101d <printf+0x4d>
        printint(fd, *ap, 10, 1);
    1106:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1109:	83 ec 0c             	sub    $0xc,%esp
    110c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1111:	8b 13                	mov    (%ebx),%edx
    1113:	6a 01                	push   $0x1
    1115:	eb 88                	jmp    109f <printf+0xcf>
        putc(fd, *ap);
    1117:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    111a:	83 ec 04             	sub    $0x4,%esp
    111d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    1120:	8b 03                	mov    (%ebx),%eax
        ap++;
    1122:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    1125:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1128:	6a 01                	push   $0x1
    112a:	52                   	push   %edx
    112b:	57                   	push   %edi
    112c:	e8 72 fd ff ff       	call   ea3 <write>
        ap++;
    1131:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1134:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1137:	31 d2                	xor    %edx,%edx
    1139:	e9 df fe ff ff       	jmp    101d <printf+0x4d>
    113e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1140:	83 ec 04             	sub    $0x4,%esp
    1143:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1146:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1149:	6a 01                	push   $0x1
    114b:	e9 31 ff ff ff       	jmp    1081 <printf+0xb1>
    1150:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    1155:	bb 8f 13 00 00       	mov    $0x138f,%ebx
    115a:	e9 77 ff ff ff       	jmp    10d6 <printf+0x106>
    115f:	90                   	nop

00001160 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1160:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1161:	a1 a4 1a 00 00       	mov    0x1aa4,%eax
{
    1166:	89 e5                	mov    %esp,%ebp
    1168:	57                   	push   %edi
    1169:	56                   	push   %esi
    116a:	53                   	push   %ebx
    116b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    116e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1178:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    117a:	39 c8                	cmp    %ecx,%eax
    117c:	73 32                	jae    11b0 <free+0x50>
    117e:	39 d1                	cmp    %edx,%ecx
    1180:	72 04                	jb     1186 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1182:	39 d0                	cmp    %edx,%eax
    1184:	72 32                	jb     11b8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1186:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1189:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    118c:	39 fa                	cmp    %edi,%edx
    118e:	74 30                	je     11c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    1190:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1193:	8b 50 04             	mov    0x4(%eax),%edx
    1196:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1199:	39 f1                	cmp    %esi,%ecx
    119b:	74 3a                	je     11d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    119d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    119f:	5b                   	pop    %ebx
  freep = p;
    11a0:	a3 a4 1a 00 00       	mov    %eax,0x1aa4
}
    11a5:	5e                   	pop    %esi
    11a6:	5f                   	pop    %edi
    11a7:	5d                   	pop    %ebp
    11a8:	c3                   	ret
    11a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11b0:	39 d0                	cmp    %edx,%eax
    11b2:	72 04                	jb     11b8 <free+0x58>
    11b4:	39 d1                	cmp    %edx,%ecx
    11b6:	72 ce                	jb     1186 <free+0x26>
{
    11b8:	89 d0                	mov    %edx,%eax
    11ba:	eb bc                	jmp    1178 <free+0x18>
    11bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    11c0:	03 72 04             	add    0x4(%edx),%esi
    11c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    11c6:	8b 10                	mov    (%eax),%edx
    11c8:	8b 12                	mov    (%edx),%edx
    11ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    11cd:	8b 50 04             	mov    0x4(%eax),%edx
    11d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    11d3:	39 f1                	cmp    %esi,%ecx
    11d5:	75 c6                	jne    119d <free+0x3d>
    p->s.size += bp->s.size;
    11d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    11da:	a3 a4 1a 00 00       	mov    %eax,0x1aa4
    p->s.size += bp->s.size;
    11df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    11e2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    11e5:	89 08                	mov    %ecx,(%eax)
}
    11e7:	5b                   	pop    %ebx
    11e8:	5e                   	pop    %esi
    11e9:	5f                   	pop    %edi
    11ea:	5d                   	pop    %ebp
    11eb:	c3                   	ret
    11ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000011f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	57                   	push   %edi
    11f4:	56                   	push   %esi
    11f5:	53                   	push   %ebx
    11f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    11fc:	8b 15 a4 1a 00 00    	mov    0x1aa4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1202:	8d 78 07             	lea    0x7(%eax),%edi
    1205:	c1 ef 03             	shr    $0x3,%edi
    1208:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    120b:	85 d2                	test   %edx,%edx
    120d:	0f 84 8d 00 00 00    	je     12a0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1213:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1215:	8b 48 04             	mov    0x4(%eax),%ecx
    1218:	39 f9                	cmp    %edi,%ecx
    121a:	73 64                	jae    1280 <malloc+0x90>
  if(nu < 4096)
    121c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1221:	39 df                	cmp    %ebx,%edi
    1223:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1226:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    122d:	eb 0a                	jmp    1239 <malloc+0x49>
    122f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1230:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1232:	8b 48 04             	mov    0x4(%eax),%ecx
    1235:	39 f9                	cmp    %edi,%ecx
    1237:	73 47                	jae    1280 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1239:	89 c2                	mov    %eax,%edx
    123b:	3b 05 a4 1a 00 00    	cmp    0x1aa4,%eax
    1241:	75 ed                	jne    1230 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1243:	83 ec 0c             	sub    $0xc,%esp
    1246:	56                   	push   %esi
    1247:	e8 bf fc ff ff       	call   f0b <sbrk>
  if(p == (char*)-1)
    124c:	83 c4 10             	add    $0x10,%esp
    124f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1252:	74 1c                	je     1270 <malloc+0x80>
  hp->s.size = nu;
    1254:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1257:	83 ec 0c             	sub    $0xc,%esp
    125a:	83 c0 08             	add    $0x8,%eax
    125d:	50                   	push   %eax
    125e:	e8 fd fe ff ff       	call   1160 <free>
  return freep;
    1263:	8b 15 a4 1a 00 00    	mov    0x1aa4,%edx
      if((p = morecore(nunits)) == 0)
    1269:	83 c4 10             	add    $0x10,%esp
    126c:	85 d2                	test   %edx,%edx
    126e:	75 c0                	jne    1230 <malloc+0x40>
        return 0;
  }
}
    1270:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1273:	31 c0                	xor    %eax,%eax
}
    1275:	5b                   	pop    %ebx
    1276:	5e                   	pop    %esi
    1277:	5f                   	pop    %edi
    1278:	5d                   	pop    %ebp
    1279:	c3                   	ret
    127a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1280:	39 cf                	cmp    %ecx,%edi
    1282:	74 4c                	je     12d0 <malloc+0xe0>
        p->s.size -= nunits;
    1284:	29 f9                	sub    %edi,%ecx
    1286:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1289:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    128c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    128f:	89 15 a4 1a 00 00    	mov    %edx,0x1aa4
}
    1295:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1298:	83 c0 08             	add    $0x8,%eax
}
    129b:	5b                   	pop    %ebx
    129c:	5e                   	pop    %esi
    129d:	5f                   	pop    %edi
    129e:	5d                   	pop    %ebp
    129f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    12a0:	c7 05 a4 1a 00 00 a8 	movl   $0x1aa8,0x1aa4
    12a7:	1a 00 00 
    base.s.size = 0;
    12aa:	b8 a8 1a 00 00       	mov    $0x1aa8,%eax
    base.s.ptr = freep = prevp = &base;
    12af:	c7 05 a8 1a 00 00 a8 	movl   $0x1aa8,0x1aa8
    12b6:	1a 00 00 
    base.s.size = 0;
    12b9:	c7 05 ac 1a 00 00 00 	movl   $0x0,0x1aac
    12c0:	00 00 00 
    if(p->s.size >= nunits){
    12c3:	e9 54 ff ff ff       	jmp    121c <malloc+0x2c>
    12c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    12cf:	00 
        prevp->s.ptr = p->s.ptr;
    12d0:	8b 08                	mov    (%eax),%ecx
    12d2:	89 0a                	mov    %ecx,(%edx)
    12d4:	eb b9                	jmp    128f <malloc+0x9f>
