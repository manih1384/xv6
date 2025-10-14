
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:



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
      11:	eb 0a                	jmp    1d <main+0x1d>
      13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	7f 71                	jg     8e <main+0x8e>
  while((fd = open("console", O_RDWR)) >= 0){
      1d:	83 ec 08             	sub    $0x8,%esp
      20:	6a 02                	push   $0x2
      22:	68 2e 1a 00 00       	push   $0x1a2e
      27:	e8 27 15 00 00       	call   1553 <open>
      2c:	83 c4 10             	add    $0x10,%esp
      2f:	85 c0                	test   %eax,%eax
      31:	79 e5                	jns    18 <main+0x18>
      33:	eb 2a                	jmp    5f <main+0x5f>
      35:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d 62 22 00 00 20 	cmpb   $0x20,0x2262
      3f:	74 70                	je     b1 <main+0xb1>
      41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      48:	e8 be 14 00 00       	call   150b <fork>
  if(pid == -1)
      4d:	83 f8 ff             	cmp    $0xffffffff,%eax
      50:	0f 84 9c 00 00 00    	je     f2 <main+0xf2>
    if(fork1() == 0)
      56:	85 c0                	test   %eax,%eax
      58:	74 42                	je     9c <main+0x9c>
    wait();
      5a:	e8 bc 14 00 00       	call   151b <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      5f:	83 ec 08             	sub    $0x8,%esp
      62:	6a 64                	push   $0x64
      64:	68 60 22 00 00       	push   $0x2260
      69:	e8 22 07 00 00       	call   790 <getcmd>
      6e:	83 c4 10             	add    $0x10,%esp
      71:	85 c0                	test   %eax,%eax
      73:	78 14                	js     89 <main+0x89>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      75:	80 3d 60 22 00 00 63 	cmpb   $0x63,0x2260
      7c:	75 ca                	jne    48 <main+0x48>
      7e:	80 3d 61 22 00 00 64 	cmpb   $0x64,0x2261
      85:	75 c1                	jne    48 <main+0x48>
      87:	eb af                	jmp    38 <main+0x38>
  exit();
      89:	e8 85 14 00 00       	call   1513 <exit>
      close(fd);
      8e:	83 ec 0c             	sub    $0xc,%esp
      91:	50                   	push   %eax
      92:	e8 a4 14 00 00       	call   153b <close>
      break;
      97:	83 c4 10             	add    $0x10,%esp
      9a:	eb c3                	jmp    5f <main+0x5f>
      runcmd(parsecmd(buf));
      9c:	83 ec 0c             	sub    $0xc,%esp
      9f:	68 60 22 00 00       	push   $0x2260
      a4:	e8 a7 11 00 00       	call   1250 <parsecmd>
      a9:	89 04 24             	mov    %eax,(%esp)
      ac:	e8 ef 07 00 00       	call   8a0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      b1:	83 ec 0c             	sub    $0xc,%esp
      b4:	68 60 22 00 00       	push   $0x2260
      b9:	e8 92 12 00 00       	call   1350 <strlen>
      if(chdir(buf+3) < 0)
      be:	c7 04 24 63 22 00 00 	movl   $0x2263,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      c5:	c6 80 5f 22 00 00 00 	movb   $0x0,0x225f(%eax)
      if(chdir(buf+3) < 0)
      cc:	e8 b2 14 00 00       	call   1583 <chdir>
      d1:	83 c4 10             	add    $0x10,%esp
      d4:	85 c0                	test   %eax,%eax
      d6:	79 87                	jns    5f <main+0x5f>
        printf(2, "cannot cd %s\n", buf+3);
      d8:	50                   	push   %eax
      d9:	68 63 22 00 00       	push   $0x2263
      de:	68 36 1a 00 00       	push   $0x1a36
      e3:	6a 02                	push   $0x2
      e5:	e8 76 15 00 00       	call   1660 <printf>
      ea:	83 c4 10             	add    $0x10,%esp
      ed:	e9 6d ff ff ff       	jmp    5f <main+0x5f>
    panic("fork");
      f2:	83 ec 0c             	sub    $0xc,%esp
      f5:	68 90 19 00 00       	push   $0x1990
      fa:	e8 61 07 00 00       	call   860 <panic>
      ff:	90                   	nop

00000100 <strncpy>:
{
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	57                   	push   %edi
     104:	56                   	push   %esi
     105:	8b 75 08             	mov    0x8(%ebp),%esi
     108:	53                   	push   %ebx
     109:	8b 55 10             	mov    0x10(%ebp),%edx
  while(n-- > 0 && (*s++ = *t++) != 0)
     10c:	89 f0                	mov    %esi,%eax
     10e:	eb 15                	jmp    125 <strncpy+0x25>
     110:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     114:	8b 7d 0c             	mov    0xc(%ebp),%edi
     117:	83 c0 01             	add    $0x1,%eax
     11a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
     11e:	88 48 ff             	mov    %cl,-0x1(%eax)
     121:	84 c9                	test   %cl,%cl
     123:	74 13                	je     138 <strncpy+0x38>
     125:	89 d3                	mov    %edx,%ebx
     127:	83 ea 01             	sub    $0x1,%edx
     12a:	85 db                	test   %ebx,%ebx
     12c:	7f e2                	jg     110 <strncpy+0x10>
}
     12e:	5b                   	pop    %ebx
     12f:	89 f0                	mov    %esi,%eax
     131:	5e                   	pop    %esi
     132:	5f                   	pop    %edi
     133:	5d                   	pop    %ebp
     134:	c3                   	ret
     135:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
     138:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
     13b:	83 e9 01             	sub    $0x1,%ecx
     13e:	85 d2                	test   %edx,%edx
     140:	74 ec                	je     12e <strncpy+0x2e>
     142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
     148:	83 c0 01             	add    $0x1,%eax
     14b:	89 ca                	mov    %ecx,%edx
     14d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
     151:	29 c2                	sub    %eax,%edx
     153:	85 d2                	test   %edx,%edx
     155:	7f f1                	jg     148 <strncpy+0x48>
}
     157:	5b                   	pop    %ebx
     158:	89 f0                	mov    %esi,%eax
     15a:	5e                   	pop    %esi
     15b:	5f                   	pop    %edi
     15c:	5d                   	pop    %ebp
     15d:	c3                   	ret
     15e:	66 90                	xchg   %ax,%ax

00000160 <strncmp>:
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	53                   	push   %ebx
     164:	8b 55 10             	mov    0x10(%ebp),%edx
     167:	8b 45 08             	mov    0x8(%ebp),%eax
     16a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
     16d:	85 d2                	test   %edx,%edx
     16f:	75 16                	jne    187 <strncmp+0x27>
     171:	eb 2d                	jmp    1a0 <strncmp+0x40>
     173:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     178:	3a 19                	cmp    (%ecx),%bl
     17a:	75 12                	jne    18e <strncmp+0x2e>
    n--, p++, q++;
     17c:	83 c0 01             	add    $0x1,%eax
     17f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
     182:	83 ea 01             	sub    $0x1,%edx
     185:	74 19                	je     1a0 <strncmp+0x40>
     187:	0f b6 18             	movzbl (%eax),%ebx
     18a:	84 db                	test   %bl,%bl
     18c:	75 ea                	jne    178 <strncmp+0x18>
  return (uchar)*p - (uchar)*q;
     18e:	0f b6 00             	movzbl (%eax),%eax
     191:	0f b6 11             	movzbl (%ecx),%edx
}
     194:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     197:	c9                   	leave
  return (uchar)*p - (uchar)*q;
     198:	29 d0                	sub    %edx,%eax
}
     19a:	c3                   	ret
     19b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     1a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
     1a3:	31 c0                	xor    %eax,%eax
}
     1a5:	c9                   	leave
     1a6:	c3                   	ret
     1a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     1ae:	00 
     1af:	90                   	nop

000001b0 <update_common_prefix>:
void update_common_prefix(char *prefix_buf, const char *new_word, int max_len) {
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	57                   	push   %edi
     1b4:	8b 55 10             	mov    0x10(%ebp),%edx
     1b7:	56                   	push   %esi
     1b8:	53                   	push   %ebx
     1b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    while (len < max_len - 1 && prefix_buf[len] && new_word[len] && prefix_buf[len] == new_word[len]) {
     1bc:	89 de                	mov    %ebx,%esi
     1be:	83 fa 01             	cmp    $0x1,%edx
     1c1:	7e 2e                	jle    1f1 <update_common_prefix+0x41>
     1c3:	8d 7a ff             	lea    -0x1(%edx),%edi
     1c6:	31 c0                	xor    %eax,%eax
     1c8:	eb 1c                	jmp    1e6 <update_common_prefix+0x36>
     1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     1d3:	0f b6 0c 01          	movzbl (%ecx,%eax,1),%ecx
     1d7:	38 ca                	cmp    %cl,%dl
     1d9:	75 16                	jne    1f1 <update_common_prefix+0x41>
     1db:	84 c9                	test   %cl,%cl
     1dd:	74 12                	je     1f1 <update_common_prefix+0x41>
        len++;
     1df:	83 c0 01             	add    $0x1,%eax
    while (len < max_len - 1 && prefix_buf[len] && new_word[len] && prefix_buf[len] == new_word[len]) {
     1e2:	39 f8                	cmp    %edi,%eax
     1e4:	74 1a                	je     200 <update_common_prefix+0x50>
     1e6:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     1ea:	8d 34 03             	lea    (%ebx,%eax,1),%esi
     1ed:	84 d2                	test   %dl,%dl
     1ef:	75 df                	jne    1d0 <update_common_prefix+0x20>
    prefix_buf[len] = '\0';
     1f1:	c6 06 00             	movb   $0x0,(%esi)
}
     1f4:	5b                   	pop    %ebx
     1f5:	5e                   	pop    %esi
     1f6:	5f                   	pop    %edi
     1f7:	5d                   	pop    %ebp
     1f8:	c3                   	ret
     1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    prefix_buf[len] = '\0';
     200:	8d 34 03             	lea    (%ebx,%eax,1),%esi
     203:	c6 06 00             	movb   $0x0,(%esi)
}
     206:	5b                   	pop    %ebx
     207:	5e                   	pop    %esi
     208:	5f                   	pop    %edi
     209:	5d                   	pop    %ebp
     20a:	c3                   	ret
     20b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000210 <autocompletion>:
{
     210:	55                   	push   %ebp
     211:	89 e5                	mov    %esp,%ebp
     213:	57                   	push   %edi
     214:	56                   	push   %esi
  memset(match_buf, 0, sizeof(match_buf));
     215:	8d 85 84 fd ff ff    	lea    -0x27c(%ebp),%eax
{
     21b:	53                   	push   %ebx
     21c:	81 ec b0 02 00 00    	sub    $0x2b0,%esp
  memset(match_buf, 0, sizeof(match_buf));
     222:	6a 64                	push   $0x64
     224:	6a 00                	push   $0x0
     226:	50                   	push   %eax
     227:	e8 54 11 00 00       	call   1380 <memset>
  for(i = strlen(buf) - 1; i >= 0; i--){
     22c:	58                   	pop    %eax
     22d:	ff 75 08             	push   0x8(%ebp)
     230:	e8 1b 11 00 00       	call   1350 <strlen>
     235:	83 c4 10             	add    $0x10,%esp
     238:	83 e8 01             	sub    $0x1,%eax
     23b:	0f 88 4f 01 00 00    	js     390 <autocompletion+0x180>
     241:	8b 55 08             	mov    0x8(%ebp),%edx
     244:	eb 13                	jmp    259 <autocompletion+0x49>
     246:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     24d:	00 
     24e:	66 90                	xchg   %ax,%ax
     250:	83 e8 01             	sub    $0x1,%eax
     253:	0f 82 37 01 00 00    	jb     390 <autocompletion+0x180>
    if(buf[i] == ' '){
     259:	80 3c 02 20          	cmpb   $0x20,(%edx,%eax,1)
     25d:	75 f1                	jne    250 <autocompletion+0x40>
    if((fd = open(".", 0)) < 0){
     25f:	83 ec 08             	sub    $0x8,%esp
      current_word = buf + i + 1;
     262:	8b 75 08             	mov    0x8(%ebp),%esi
    if((fd = open(".", 0)) < 0){
     265:	6a 00                	push   $0x0
     267:	68 86 19 00 00       	push   $0x1986
      current_word = buf + i + 1;
     26c:	8d 5c 06 01          	lea    0x1(%esi,%eax,1),%ebx
    if((fd = open(".", 0)) < 0){
     270:	e8 de 12 00 00       	call   1553 <open>
     275:	83 c4 10             	add    $0x10,%esp
     278:	89 c7                	mov    %eax,%edi
     27a:	85 c0                	test   %eax,%eax
     27c:	0f 88 7c 03 00 00    	js     5fe <autocompletion+0x3ee>
  int match_count = 0;
     282:	c7 85 50 fd ff ff 00 	movl   $0x0,-0x2b0(%ebp)
     289:	00 00 00 
     28c:	8d b5 60 fd ff ff    	lea    -0x2a0(%ebp),%esi
     292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     298:	83 ec 04             	sub    $0x4,%esp
     29b:	6a 10                	push   $0x10
     29d:	56                   	push   %esi
     29e:	57                   	push   %edi
     29f:	e8 87 12 00 00       	call   152b <read>
     2a4:	83 c4 10             	add    $0x10,%esp
     2a7:	83 f8 10             	cmp    $0x10,%eax
     2aa:	0f 85 30 02 00 00    	jne    4e0 <autocompletion+0x2d0>
      if(de.inum == 0) // Skip empty entries.
     2b0:	66 83 bd 60 fd ff ff 	cmpw   $0x0,-0x2a0(%ebp)
     2b7:	00 
     2b8:	74 de                	je     298 <autocompletion+0x88>
      if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
     2ba:	83 ec 08             	sub    $0x8,%esp
     2bd:	8d 85 62 fd ff ff    	lea    -0x29e(%ebp),%eax
     2c3:	68 86 19 00 00       	push   $0x1986
     2c8:	50                   	push   %eax
     2c9:	e8 22 10 00 00       	call   12f0 <strcmp>
     2ce:	83 c4 10             	add    $0x10,%esp
     2d1:	85 c0                	test   %eax,%eax
     2d3:	74 c3                	je     298 <autocompletion+0x88>
     2d5:	83 ec 08             	sub    $0x8,%esp
     2d8:	8d 85 62 fd ff ff    	lea    -0x29e(%ebp),%eax
     2de:	68 85 19 00 00       	push   $0x1985
     2e3:	50                   	push   %eax
     2e4:	e8 07 10 00 00       	call   12f0 <strcmp>
     2e9:	83 c4 10             	add    $0x10,%esp
     2ec:	85 c0                	test   %eax,%eax
     2ee:	74 a8                	je     298 <autocompletion+0x88>
      if (strncmp(de.name, current_word, strlen(current_word)) == 0) {
     2f0:	83 ec 0c             	sub    $0xc,%esp
     2f3:	53                   	push   %ebx
     2f4:	e8 57 10 00 00       	call   1350 <strlen>
  while(n > 0 && *p && *p == *q)
     2f9:	83 c4 10             	add    $0x10,%esp
     2fc:	89 d9                	mov    %ebx,%ecx
     2fe:	8d 95 62 fd ff ff    	lea    -0x29e(%ebp),%edx
     304:	85 c0                	test   %eax,%eax
     306:	74 33                	je     33b <autocompletion+0x12b>
     308:	89 9d 54 fd ff ff    	mov    %ebx,-0x2ac(%ebp)
     30e:	eb 13                	jmp    323 <autocompletion+0x113>
     310:	3a 19                	cmp    (%ecx),%bl
     312:	75 16                	jne    32a <autocompletion+0x11a>
    n--, p++, q++;
     314:	83 c2 01             	add    $0x1,%edx
     317:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	0f 84 f2 02 00 00    	je     615 <autocompletion+0x405>
     323:	0f b6 1a             	movzbl (%edx),%ebx
     326:	84 db                	test   %bl,%bl
     328:	75 e6                	jne    310 <autocompletion+0x100>
     32a:	8b 9d 54 fd ff ff    	mov    -0x2ac(%ebp),%ebx
      if (strncmp(de.name, current_word, strlen(current_word)) == 0) {
     330:	0f b6 01             	movzbl (%ecx),%eax
     333:	38 02                	cmp    %al,(%edx)
     335:	0f 85 5d ff ff ff    	jne    298 <autocompletion+0x88>
        if (match_count == 0) {
     33b:	8b 8d 50 fd ff ff    	mov    -0x2b0(%ebp),%ecx
     341:	85 c9                	test   %ecx,%ecx
     343:	0f 84 69 02 00 00    	je     5b2 <autocompletion+0x3a2>
     349:	89 9d 54 fd ff ff    	mov    %ebx,-0x2ac(%ebp)
     34f:	8d 85 84 fd ff ff    	lea    -0x27c(%ebp),%eax
     355:	8d 8d 62 fd ff ff    	lea    -0x29e(%ebp),%ecx
     35b:	eb 1e                	jmp    37b <autocompletion+0x16b>
     35d:	8d 76 00             	lea    0x0(%esi),%esi
    while (len < max_len - 1 && prefix_buf[len] && new_word[len] && prefix_buf[len] == new_word[len]) {
     360:	0f b6 19             	movzbl (%ecx),%ebx
     363:	38 da                	cmp    %bl,%dl
     365:	75 1b                	jne    382 <autocompletion+0x172>
     367:	84 db                	test   %bl,%bl
     369:	74 17                	je     382 <autocompletion+0x172>
     36b:	83 c0 01             	add    $0x1,%eax
     36e:	8d 9d e7 fd ff ff    	lea    -0x219(%ebp),%ebx
     374:	83 c1 01             	add    $0x1,%ecx
     377:	39 d8                	cmp    %ebx,%eax
     379:	74 07                	je     382 <autocompletion+0x172>
     37b:	0f b6 10             	movzbl (%eax),%edx
     37e:	84 d2                	test   %dl,%dl
     380:	75 de                	jne    360 <autocompletion+0x150>
    prefix_buf[len] = '\0';
     382:	c6 00 00             	movb   $0x0,(%eax)
     385:	8b 9d 54 fd ff ff    	mov    -0x2ac(%ebp),%ebx
}
     38b:	e9 62 02 00 00       	jmp    5f2 <autocompletion+0x3e2>
    for (i = 0; i < num_known_commands; i++) {
     390:	a1 10 22 00 00       	mov    0x2210,%eax
     395:	31 db                	xor    %ebx,%ebx
     397:	8d b5 e7 fd ff ff    	lea    -0x219(%ebp),%esi
  int match_count = 0;
     39d:	c7 85 50 fd ff ff 00 	movl   $0x0,-0x2b0(%ebp)
     3a4:	00 00 00 
    for (i = 0; i < num_known_commands; i++) {
     3a7:	85 c0                	test   %eax,%eax
     3a9:	7e 71                	jle    41c <autocompletion+0x20c>
     3ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if (strncmp(knowncommands[i], current_word, strlen(current_word)) == 0) {
     3b0:	83 ec 0c             	sub    $0xc,%esp
     3b3:	ff 75 08             	push   0x8(%ebp)
     3b6:	e8 95 0f 00 00       	call   1350 <strlen>
     3bb:	8b 3c 9d 20 22 00 00 	mov    0x2220(,%ebx,4),%edi
  while(n > 0 && *p && *p == *q)
     3c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
     3c5:	83 c4 10             	add    $0x10,%esp
     3c8:	89 fa                	mov    %edi,%edx
     3ca:	85 c0                	test   %eax,%eax
     3cc:	74 60                	je     42e <autocompletion+0x21e>
     3ce:	89 bd 54 fd ff ff    	mov    %edi,-0x2ac(%ebp)
     3d4:	89 c7                	mov    %eax,%edi
     3d6:	eb 17                	jmp    3ef <autocompletion+0x1df>
     3d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     3df:	00 
     3e0:	3a 01                	cmp    (%ecx),%al
     3e2:	75 12                	jne    3f6 <autocompletion+0x1e6>
    n--, p++, q++;
     3e4:	83 c2 01             	add    $0x1,%edx
     3e7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
     3ea:	83 ef 01             	sub    $0x1,%edi
     3ed:	74 39                	je     428 <autocompletion+0x218>
     3ef:	0f b6 02             	movzbl (%edx),%eax
     3f2:	84 c0                	test   %al,%al
     3f4:	75 ea                	jne    3e0 <autocompletion+0x1d0>
     3f6:	8b bd 54 fd ff ff    	mov    -0x2ac(%ebp),%edi
      if (strncmp(knowncommands[i], current_word, strlen(current_word)) == 0) {
     3fc:	0f b6 01             	movzbl (%ecx),%eax
     3ff:	38 02                	cmp    %al,(%edx)
     401:	74 2b                	je     42e <autocompletion+0x21e>
    for (i = 0; i < num_known_commands; i++) {
     403:	83 c3 01             	add    $0x1,%ebx
     406:	39 1d 10 22 00 00    	cmp    %ebx,0x2210
     40c:	7f a2                	jg     3b0 <autocompletion+0x1a0>
  if (match_count > 0 && strlen(match_buf) > strlen(current_word)) {
     40e:	8b 85 50 fd ff ff    	mov    -0x2b0(%ebp),%eax
     414:	85 c0                	test   %eax,%eax
     416:	0f 8f ee 00 00 00    	jg     50a <autocompletion+0x2fa>
}
     41c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     41f:	5b                   	pop    %ebx
     420:	5e                   	pop    %esi
     421:	5f                   	pop    %edi
     422:	5d                   	pop    %ebp
     423:	c3                   	ret
     424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     428:	8b bd 54 fd ff ff    	mov    -0x2ac(%ebp),%edi
        if (match_count == 0) {
     42e:	8b 85 50 fd ff ff    	mov    -0x2b0(%ebp),%eax
     434:	8d 95 84 fd ff ff    	lea    -0x27c(%ebp),%edx
     43a:	85 c0                	test   %eax,%eax
     43c:	74 54                	je     492 <autocompletion+0x282>
     43e:	8d 85 84 fd ff ff    	lea    -0x27c(%ebp),%eax
     444:	eb 23                	jmp    469 <autocompletion+0x259>
     446:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     44d:	00 
     44e:	66 90                	xchg   %ax,%ax
    while (len < max_len - 1 && prefix_buf[len] && new_word[len] && prefix_buf[len] == new_word[len]) {
     450:	0f b6 0f             	movzbl (%edi),%ecx
     453:	84 c9                	test   %cl,%cl
     455:	74 19                	je     470 <autocompletion+0x260>
     457:	38 ca                	cmp    %cl,%dl
     459:	75 15                	jne    470 <autocompletion+0x260>
     45b:	83 c0 01             	add    $0x1,%eax
     45e:	83 c7 01             	add    $0x1,%edi
     461:	39 f0                	cmp    %esi,%eax
     463:	0f 84 3f 01 00 00    	je     5a8 <autocompletion+0x398>
     469:	0f b6 10             	movzbl (%eax),%edx
     46c:	84 d2                	test   %dl,%dl
     46e:	75 e0                	jne    450 <autocompletion+0x240>
    prefix_buf[len] = '\0';
     470:	c6 00 00             	movb   $0x0,(%eax)
        match_count++;
     473:	83 85 50 fd ff ff 01 	addl   $0x1,-0x2b0(%ebp)
     47a:	eb 87                	jmp    403 <autocompletion+0x1f3>
     47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(n-- > 0 && (*s++ = *t++) != 0)
     480:	0f b6 0f             	movzbl (%edi),%ecx
     483:	8d 42 01             	lea    0x1(%edx),%eax
     486:	83 c7 01             	add    $0x1,%edi
     489:	88 48 ff             	mov    %cl,-0x1(%eax)
     48c:	84 c9                	test   %cl,%cl
     48e:	74 10                	je     4a0 <autocompletion+0x290>
     490:	89 c2                	mov    %eax,%edx
     492:	39 f2                	cmp    %esi,%edx
     494:	75 ea                	jne    480 <autocompletion+0x270>
     496:	eb db                	jmp    473 <autocompletion+0x263>
     498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     49f:	00 
     4a0:	8d 8d e6 fd ff ff    	lea    -0x21a(%ebp),%ecx
     4a6:	29 d1                	sub    %edx,%ecx
  while(n-- > 0)
     4a8:	85 c9                	test   %ecx,%ecx
     4aa:	7e c7                	jle    473 <autocompletion+0x263>
     4ac:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
     4af:	83 e1 01             	and    $0x1,%ecx
     4b2:	74 0c                	je     4c0 <autocompletion+0x2b0>
    *s++ = 0;
     4b4:	8d 42 02             	lea    0x2(%edx),%eax
     4b7:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
     4bb:	39 f8                	cmp    %edi,%eax
     4bd:	74 b4                	je     473 <autocompletion+0x263>
     4bf:	90                   	nop
    *s++ = 0;
     4c0:	c6 00 00             	movb   $0x0,(%eax)
     4c3:	83 c0 02             	add    $0x2,%eax
     4c6:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
     4ca:	39 f8                	cmp    %edi,%eax
     4cc:	75 f2                	jne    4c0 <autocompletion+0x2b0>
        match_count++;
     4ce:	83 85 50 fd ff ff 01 	addl   $0x1,-0x2b0(%ebp)
     4d5:	e9 29 ff ff ff       	jmp    403 <autocompletion+0x1f3>
     4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    close(fd);
     4e0:	83 ec 0c             	sub    $0xc,%esp
     4e3:	57                   	push   %edi
     4e4:	e8 52 10 00 00       	call   153b <close>
    if(match_count == 1) {
     4e9:	83 c4 10             	add    $0x10,%esp
     4ec:	83 bd 50 fd ff ff 01 	cmpl   $0x1,-0x2b0(%ebp)
     4f3:	0f 84 75 01 00 00    	je     66e <autocompletion+0x45e>
  if (match_count > 0 && strlen(match_buf) > strlen(current_word)) {
     4f9:	8b 85 50 fd ff ff    	mov    -0x2b0(%ebp),%eax
     4ff:	89 5d 08             	mov    %ebx,0x8(%ebp)
     502:	85 c0                	test   %eax,%eax
     504:	0f 8e 12 ff ff ff    	jle    41c <autocompletion+0x20c>
     50a:	83 ec 0c             	sub    $0xc,%esp
     50d:	8d 85 84 fd ff ff    	lea    -0x27c(%ebp),%eax
     513:	50                   	push   %eax
     514:	e8 37 0e 00 00       	call   1350 <strlen>
     519:	89 c3                	mov    %eax,%ebx
     51b:	58                   	pop    %eax
     51c:	ff 75 08             	push   0x8(%ebp)
     51f:	e8 2c 0e 00 00       	call   1350 <strlen>
     524:	83 c4 10             	add    $0x10,%esp
     527:	39 d8                	cmp    %ebx,%eax
     529:	0f 83 ed fe ff ff    	jae    41c <autocompletion+0x20c>
    char* completion_text = match_buf + strlen(current_word);
     52f:	83 ec 0c             	sub    $0xc,%esp
     532:	ff 75 08             	push   0x8(%ebp)
     535:	8d b5 84 fd ff ff    	lea    -0x27c(%ebp),%esi
     53b:	e8 10 0e 00 00       	call   1350 <strlen>
     540:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
    int completion_len = strlen(completion_text);
     543:	89 1c 24             	mov    %ebx,(%esp)
     546:	e8 05 0e 00 00       	call   1350 <strlen>
    if (completion_len + 3 < sizeof(result)) {
     54b:	83 c4 10             	add    $0x10,%esp
     54e:	83 c0 03             	add    $0x3,%eax
     551:	83 f8 7f             	cmp    $0x7f,%eax
     554:	0f 87 c2 fe ff ff    	ja     41c <autocompletion+0x20c>
        memset(result, 0, sizeof(result));
     55a:	83 ec 04             	sub    $0x4,%esp
     55d:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
     563:	68 80 00 00 00       	push   $0x80
     568:	6a 00                	push   $0x0
     56a:	56                   	push   %esi
     56b:	e8 10 0e 00 00       	call   1380 <memset>
        strcpy(result, "\t\t");
     570:	58                   	pop    %eax
     571:	5a                   	pop    %edx
     572:	68 8a 19 00 00       	push   $0x198a
     577:	56                   	push   %esi
     578:	e8 43 0d 00 00       	call   12c0 <strcpy>
        strcpy(result + 2, completion_text);
     57d:	8d 85 ea fd ff ff    	lea    -0x216(%ebp),%eax
     583:	59                   	pop    %ecx
     584:	5f                   	pop    %edi
     585:	53                   	push   %ebx
     586:	50                   	push   %eax
     587:	e8 34 0d 00 00       	call   12c0 <strcpy>
        write(1, result, strlen(result));
     58c:	89 34 24             	mov    %esi,(%esp)
     58f:	e8 bc 0d 00 00       	call   1350 <strlen>
     594:	83 c4 0c             	add    $0xc,%esp
     597:	50                   	push   %eax
     598:	56                   	push   %esi
     599:	6a 01                	push   $0x1
     59b:	e8 93 0f 00 00       	call   1533 <write>
     5a0:	83 c4 10             	add    $0x10,%esp
     5a3:	e9 74 fe ff ff       	jmp    41c <autocompletion+0x20c>
     5a8:	89 f0                	mov    %esi,%eax
    prefix_buf[len] = '\0';
     5aa:	c6 00 00             	movb   $0x0,(%eax)
     5ad:	e9 c1 fe ff ff       	jmp    473 <autocompletion+0x263>
     5b2:	89 9d 54 fd ff ff    	mov    %ebx,-0x2ac(%ebp)
     5b8:	8d 85 62 fd ff ff    	lea    -0x29e(%ebp),%eax
     5be:	8d 95 84 fd ff ff    	lea    -0x27c(%ebp),%edx
     5c4:	eb 1c                	jmp    5e2 <autocompletion+0x3d2>
     5c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     5cd:	00 
     5ce:	66 90                	xchg   %ax,%ax
  while(n-- > 0 && (*s++ = *t++) != 0)
     5d0:	0f b6 08             	movzbl (%eax),%ecx
     5d3:	8d 58 01             	lea    0x1(%eax),%ebx
     5d6:	83 c2 01             	add    $0x1,%edx
     5d9:	88 4a ff             	mov    %cl,-0x1(%edx)
     5dc:	84 c9                	test   %cl,%cl
     5de:	74 4b                	je     62b <autocompletion+0x41b>
     5e0:	89 d8                	mov    %ebx,%eax
     5e2:	8d 9d c5 fd ff ff    	lea    -0x23b(%ebp),%ebx
     5e8:	39 d8                	cmp    %ebx,%eax
     5ea:	75 e4                	jne    5d0 <autocompletion+0x3c0>
     5ec:	8b 9d 54 fd ff ff    	mov    -0x2ac(%ebp),%ebx
        match_count++;
     5f2:	83 85 50 fd ff ff 01 	addl   $0x1,-0x2b0(%ebp)
     5f9:	e9 9a fc ff ff       	jmp    298 <autocompletion+0x88>
      printf(2, "autocomplete: cannot open .\n");
     5fe:	83 ec 08             	sub    $0x8,%esp
     601:	68 68 19 00 00       	push   $0x1968
     606:	6a 02                	push   $0x2
     608:	e8 53 10 00 00       	call   1660 <printf>
      return;
     60d:	83 c4 10             	add    $0x10,%esp
     610:	e9 07 fe ff ff       	jmp    41c <autocompletion+0x20c>
        if (match_count == 0) {
     615:	8b 8d 50 fd ff ff    	mov    -0x2b0(%ebp),%ecx
     61b:	8b 9d 54 fd ff ff    	mov    -0x2ac(%ebp),%ebx
     621:	85 c9                	test   %ecx,%ecx
     623:	0f 85 20 fd ff ff    	jne    349 <autocompletion+0x139>
     629:	eb 87                	jmp    5b2 <autocompletion+0x3a2>
     62b:	8d 8d c4 fd ff ff    	lea    -0x23c(%ebp),%ecx
     631:	8b 9d 54 fd ff ff    	mov    -0x2ac(%ebp),%ebx
     637:	29 c1                	sub    %eax,%ecx
  while(n-- > 0)
     639:	85 c9                	test   %ecx,%ecx
     63b:	7e b5                	jle    5f2 <autocompletion+0x3e2>
     63d:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     640:	83 e1 01             	and    $0x1,%ecx
     643:	74 0b                	je     650 <autocompletion+0x440>
    *s++ = 0;
     645:	83 c2 01             	add    $0x1,%edx
     648:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
     64c:	39 c2                	cmp    %eax,%edx
     64e:	74 a2                	je     5f2 <autocompletion+0x3e2>
    *s++ = 0;
     650:	c6 02 00             	movb   $0x0,(%edx)
     653:	83 c2 02             	add    $0x2,%edx
     656:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
     65a:	39 c2                	cmp    %eax,%edx
     65c:	74 94                	je     5f2 <autocompletion+0x3e2>
    *s++ = 0;
     65e:	c6 02 00             	movb   $0x0,(%edx)
     661:	83 c2 02             	add    $0x2,%edx
     664:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
     668:	39 c2                	cmp    %eax,%edx
     66a:	75 e4                	jne    650 <autocompletion+0x440>
     66c:	eb 84                	jmp    5f2 <autocompletion+0x3e2>
        if(strlen(buf) + strlen(match_buf) < sizeof(path)) {
     66e:	83 ec 0c             	sub    $0xc,%esp
     671:	ff 75 08             	push   0x8(%ebp)
     674:	e8 d7 0c 00 00       	call   1350 <strlen>
     679:	89 c6                	mov    %eax,%esi
     67b:	8d 85 84 fd ff ff    	lea    -0x27c(%ebp),%eax
     681:	89 04 24             	mov    %eax,(%esp)
     684:	e8 c7 0c 00 00       	call   1350 <strlen>
     689:	83 c4 10             	add    $0x10,%esp
     68c:	01 c6                	add    %eax,%esi
     68e:	81 fe ff 01 00 00    	cmp    $0x1ff,%esi
     694:	76 0a                	jbe    6a0 <autocompletion+0x490>
     696:	89 5d 08             	mov    %ebx,0x8(%ebp)
     699:	e9 6c fe ff ff       	jmp    50a <autocompletion+0x2fa>
     69e:	66 90                	xchg   %ax,%ax
            strcpy(path, "."); // or the directory part of the path if you implement that
     6a0:	83 ec 08             	sub    $0x8,%esp
     6a3:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
     6a9:	68 86 19 00 00       	push   $0x1986
     6ae:	56                   	push   %esi
     6af:	e8 0c 0c 00 00       	call   12c0 <strcpy>
            strcpy(path + strlen(path), "/");
     6b4:	89 34 24             	mov    %esi,(%esp)
     6b7:	e8 94 0c 00 00       	call   1350 <strlen>
     6bc:	59                   	pop    %ecx
     6bd:	5f                   	pop    %edi
     6be:	68 88 19 00 00       	push   $0x1988
     6c3:	01 f0                	add    %esi,%eax
            strcpy(path + strlen(path), match_buf);
     6c5:	8d bd 84 fd ff ff    	lea    -0x27c(%ebp),%edi
            strcpy(path + strlen(path), "/");
     6cb:	50                   	push   %eax
     6cc:	e8 ef 0b 00 00       	call   12c0 <strcpy>
            strcpy(path + strlen(path), match_buf);
     6d1:	89 34 24             	mov    %esi,(%esp)
     6d4:	e8 77 0c 00 00       	call   1350 <strlen>
     6d9:	5a                   	pop    %edx
     6da:	59                   	pop    %ecx
     6db:	57                   	push   %edi
     6dc:	01 f0                	add    %esi,%eax
     6de:	50                   	push   %eax
     6df:	e8 dc 0b 00 00       	call   12c0 <strcpy>
            if(stat(path, &st) >= 0 && st.type == T_DIR) {
     6e4:	58                   	pop    %eax
     6e5:	8d 85 70 fd ff ff    	lea    -0x290(%ebp),%eax
     6eb:	5a                   	pop    %edx
     6ec:	50                   	push   %eax
     6ed:	56                   	push   %esi
     6ee:	e8 5d 0d 00 00       	call   1450 <stat>
     6f3:	83 c4 10             	add    $0x10,%esp
     6f6:	85 c0                	test   %eax,%eax
     6f8:	78 9c                	js     696 <autocompletion+0x486>
     6fa:	66 83 bd 70 fd ff ff 	cmpw   $0x1,-0x290(%ebp)
     701:	01 
     702:	75 92                	jne    696 <autocompletion+0x486>
                int len = strlen(match_buf);
     704:	83 ec 0c             	sub    $0xc,%esp
     707:	57                   	push   %edi
     708:	e8 43 0c 00 00       	call   1350 <strlen>
                if(len + 1 < sizeof(match_buf)) {
     70d:	83 c4 10             	add    $0x10,%esp
     710:	8d 50 01             	lea    0x1(%eax),%edx
     713:	83 fa 63             	cmp    $0x63,%edx
     716:	0f 87 7a ff ff ff    	ja     696 <autocompletion+0x486>
                    match_buf[len] = '/';
     71c:	ba 2f 00 00 00       	mov    $0x2f,%edx
     721:	66 89 94 05 84 fd ff 	mov    %dx,-0x27c(%ebp,%eax,1)
     728:	ff 
  if (match_count > 0 && strlen(match_buf) > strlen(current_word)) {
     729:	e9 68 ff ff ff       	jmp    696 <autocompletion+0x486>
     72e:	66 90                	xchg   %ax,%ax

00000730 <find_incomplete_command_start>:
int find_incomplete_command_start(char *buf) {
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	8b 4d 08             	mov    0x8(%ebp),%ecx
    for (i = 0; buf[i] != 0; i++) {
     736:	0f b6 01             	movzbl (%ecx),%eax
     739:	84 c0                	test   %al,%al
     73b:	74 33                	je     770 <find_incomplete_command_start+0x40>
     73d:	31 d2                	xor    %edx,%edx
     73f:	eb 12                	jmp    753 <find_incomplete_command_start+0x23>
     741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     748:	83 c2 01             	add    $0x1,%edx
     74b:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
     74f:	84 c0                	test   %al,%al
     751:	74 1d                	je     770 <find_incomplete_command_start+0x40>
        if (buf[i] == '\t') {
     753:	3c 09                	cmp    $0x9,%al
     755:	75 f1                	jne    748 <find_incomplete_command_start+0x18>
    for (i = tab_pos - 1; i >= 0; i--) {
     757:	8d 42 ff             	lea    -0x1(%edx),%eax
     75a:	85 d2                	test   %edx,%edx
     75c:	75 07                	jne    765 <find_incomplete_command_start+0x35>
     75e:	eb 20                	jmp    780 <find_incomplete_command_start+0x50>
     760:	83 e8 01             	sub    $0x1,%eax
     763:	72 1b                	jb     780 <find_incomplete_command_start+0x50>
        if (buf[i] == '\n') {
     765:	80 3c 01 0a          	cmpb   $0xa,(%ecx,%eax,1)
     769:	75 f5                	jne    760 <find_incomplete_command_start+0x30>
            start = i + 1; // first char after '\n'
     76b:	83 c0 01             	add    $0x1,%eax
}
     76e:	5d                   	pop    %ebp
     76f:	c3                   	ret
        return -1; // no tab found
     770:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     775:	5d                   	pop    %ebp
     776:	c3                   	ret
     777:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     77e:	00 
     77f:	90                   	nop
    int start = 0;
     780:	31 c0                	xor    %eax,%eax
}
     782:	5d                   	pop    %ebp
     783:	c3                   	ret
     784:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     78b:	00 
     78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000790 <getcmd>:
{
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	57                   	push   %edi
     794:	56                   	push   %esi
     795:	53                   	push   %ebx
     796:	83 ec 24             	sub    $0x24,%esp
     799:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(2, "$ ");
     79c:	68 8d 19 00 00       	push   $0x198d
     7a1:	6a 02                	push   $0x2
     7a3:	e8 b8 0e 00 00       	call   1660 <printf>
    memset(buf, 0, nbuf);
     7a8:	83 c4 0c             	add    $0xc,%esp
     7ab:	ff 75 0c             	push   0xc(%ebp)
     7ae:	6a 00                	push   $0x0
     7b0:	53                   	push   %ebx
     7b1:	e8 ca 0b 00 00       	call   1380 <memset>
    for(i = 0; i+1 < nbuf; ){
     7b6:	83 c4 10             	add    $0x10,%esp
     7b9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     7bd:	0f 8e 8a 00 00 00    	jle    84d <getcmd+0xbd>
     7c3:	31 ff                	xor    %edi,%edi
     7c5:	be 01 00 00 00       	mov    $0x1,%esi
     7ca:	eb 18                	jmp    7e4 <getcmd+0x54>
     7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        buf[i++] = c;
     7d0:	88 01                	mov    %al,(%ecx)
        if(c == '\n' || c == '\r'){
     7d2:	3c 0a                	cmp    $0xa,%al
     7d4:	74 72                	je     848 <getcmd+0xb8>
     7d6:	3c 0d                	cmp    $0xd,%al
     7d8:	74 6e                	je     848 <getcmd+0xb8>
        buf[i++] = c;
     7da:	89 f7                	mov    %esi,%edi
    for(i = 0; i+1 < nbuf; ){
     7dc:	8d 77 01             	lea    0x1(%edi),%esi
     7df:	3b 75 0c             	cmp    0xc(%ebp),%esi
     7e2:	7d 3c                	jge    820 <getcmd+0x90>
        if(read(0, &c, 1) < 1)
     7e4:	83 ec 04             	sub    $0x4,%esp
     7e7:	8d 45 e7             	lea    -0x19(%ebp),%eax
     7ea:	6a 01                	push   $0x1
     7ec:	50                   	push   %eax
     7ed:	6a 00                	push   $0x0
     7ef:	e8 37 0d 00 00       	call   152b <read>
     7f4:	83 c4 10             	add    $0x10,%esp
     7f7:	85 c0                	test   %eax,%eax
     7f9:	7e 3d                	jle    838 <getcmd+0xa8>
        if (c == '\t') {
     7fb:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
            buf[i] = '\0';        // Null-terminate the string so far.
     7ff:	8d 0c 3b             	lea    (%ebx,%edi,1),%ecx
        if (c == '\t') {
     802:	3c 09                	cmp    $0x9,%al
     804:	75 ca                	jne    7d0 <getcmd+0x40>
            autocompletion(buf);  // Call the logic to calculate the completion.
     806:	83 ec 0c             	sub    $0xc,%esp
            buf[i] = '\0';        // Null-terminate the string so far.
     809:	c6 01 00             	movb   $0x0,(%ecx)
    for(i = 0; i+1 < nbuf; ){
     80c:	8d 77 01             	lea    0x1(%edi),%esi
            autocompletion(buf);  // Call the logic to calculate the completion.
     80f:	53                   	push   %ebx
     810:	e8 fb f9 ff ff       	call   210 <autocompletion>
            continue; // Continue the for loop to read the completed text
     815:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i+1 < nbuf; ){
     818:	3b 75 0c             	cmp    0xc(%ebp),%esi
     81b:	7c c7                	jl     7e4 <getcmd+0x54>
     81d:	8d 76 00             	lea    0x0(%esi),%esi
    buf[i] = '\0';
     820:	01 df                	add    %ebx,%edi
     822:	c6 07 00             	movb   $0x0,(%edi)
    if(buf[0] == 0) // EOF
     825:	80 3b 01             	cmpb   $0x1,(%ebx)
     828:	19 c0                	sbb    %eax,%eax
}
     82a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     82d:	5b                   	pop    %ebx
     82e:	5e                   	pop    %esi
     82f:	5f                   	pop    %edi
     830:	5d                   	pop    %ebp
     831:	c3                   	ret
     832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     838:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1; // EOF
     83b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     840:	5b                   	pop    %ebx
     841:	5e                   	pop    %esi
     842:	5f                   	pop    %edi
     843:	5d                   	pop    %ebp
     844:	c3                   	ret
     845:	8d 76 00             	lea    0x0(%esi),%esi
    buf[i] = '\0';
     848:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
            break;
     84b:	eb d5                	jmp    822 <getcmd+0x92>
    for(i = 0; i+1 < nbuf; ){
     84d:	89 df                	mov    %ebx,%edi
     84f:	eb d1                	jmp    822 <getcmd+0x92>
     851:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     858:	00 
     859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000860 <panic>:
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     866:	ff 75 08             	push   0x8(%ebp)
     869:	68 2a 1a 00 00       	push   $0x1a2a
     86e:	6a 02                	push   $0x2
     870:	e8 eb 0d 00 00       	call   1660 <printf>
  exit();
     875:	e8 99 0c 00 00       	call   1513 <exit>
     87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000880 <fork1>:
{
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     886:	e8 80 0c 00 00       	call   150b <fork>
  if(pid == -1)
     88b:	83 f8 ff             	cmp    $0xffffffff,%eax
     88e:	74 02                	je     892 <fork1+0x12>
  return pid;
}
     890:	c9                   	leave
     891:	c3                   	ret
    panic("fork");
     892:	83 ec 0c             	sub    $0xc,%esp
     895:	68 90 19 00 00       	push   $0x1990
     89a:	e8 c1 ff ff ff       	call   860 <panic>
     89f:	90                   	nop

000008a0 <runcmd>:
{
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	53                   	push   %ebx
     8a4:	83 ec 14             	sub    $0x14,%esp
     8a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     8aa:	85 db                	test   %ebx,%ebx
     8ac:	74 42                	je     8f0 <runcmd+0x50>
  switch(cmd->type){
     8ae:	83 3b 05             	cmpl   $0x5,(%ebx)
     8b1:	0f 87 e3 00 00 00    	ja     99a <runcmd+0xfa>
     8b7:	8b 03                	mov    (%ebx),%eax
     8b9:	ff 24 85 8c 1a 00 00 	jmp    *0x1a8c(,%eax,4)
    if(ecmd->argv[0] == 0)
     8c0:	8b 43 04             	mov    0x4(%ebx),%eax
     8c3:	85 c0                	test   %eax,%eax
     8c5:	74 29                	je     8f0 <runcmd+0x50>
    exec(ecmd->argv[0], ecmd->argv);
     8c7:	8d 53 04             	lea    0x4(%ebx),%edx
     8ca:	51                   	push   %ecx
     8cb:	51                   	push   %ecx
     8cc:	52                   	push   %edx
     8cd:	50                   	push   %eax
     8ce:	e8 78 0c 00 00       	call   154b <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     8d3:	83 c4 0c             	add    $0xc,%esp
     8d6:	ff 73 04             	push   0x4(%ebx)
     8d9:	68 9c 19 00 00       	push   $0x199c
     8de:	6a 02                	push   $0x2
     8e0:	e8 7b 0d 00 00       	call   1660 <printf>
    break;
     8e5:	83 c4 10             	add    $0x10,%esp
     8e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     8ef:	00 
    exit();
     8f0:	e8 1e 0c 00 00       	call   1513 <exit>
    if(fork1() == 0)
     8f5:	e8 86 ff ff ff       	call   880 <fork1>
     8fa:	85 c0                	test   %eax,%eax
     8fc:	75 f2                	jne    8f0 <runcmd+0x50>
     8fe:	e9 8c 00 00 00       	jmp    98f <runcmd+0xef>
    if(pipe(p) < 0)
     903:	83 ec 0c             	sub    $0xc,%esp
     906:	8d 45 f0             	lea    -0x10(%ebp),%eax
     909:	50                   	push   %eax
     90a:	e8 14 0c 00 00       	call   1523 <pipe>
     90f:	83 c4 10             	add    $0x10,%esp
     912:	85 c0                	test   %eax,%eax
     914:	0f 88 a2 00 00 00    	js     9bc <runcmd+0x11c>
    if(fork1() == 0){
     91a:	e8 61 ff ff ff       	call   880 <fork1>
     91f:	85 c0                	test   %eax,%eax
     921:	0f 84 a2 00 00 00    	je     9c9 <runcmd+0x129>
    if(fork1() == 0){
     927:	e8 54 ff ff ff       	call   880 <fork1>
     92c:	85 c0                	test   %eax,%eax
     92e:	0f 84 c3 00 00 00    	je     9f7 <runcmd+0x157>
    close(p[0]);
     934:	83 ec 0c             	sub    $0xc,%esp
     937:	ff 75 f0             	push   -0x10(%ebp)
     93a:	e8 fc 0b 00 00       	call   153b <close>
    close(p[1]);
     93f:	58                   	pop    %eax
     940:	ff 75 f4             	push   -0xc(%ebp)
     943:	e8 f3 0b 00 00       	call   153b <close>
    wait();
     948:	e8 ce 0b 00 00       	call   151b <wait>
    wait();
     94d:	e8 c9 0b 00 00       	call   151b <wait>
    break;
     952:	83 c4 10             	add    $0x10,%esp
     955:	eb 99                	jmp    8f0 <runcmd+0x50>
    if(fork1() == 0)
     957:	e8 24 ff ff ff       	call   880 <fork1>
     95c:	85 c0                	test   %eax,%eax
     95e:	74 2f                	je     98f <runcmd+0xef>
    wait();
     960:	e8 b6 0b 00 00       	call   151b <wait>
    runcmd(lcmd->right);
     965:	83 ec 0c             	sub    $0xc,%esp
     968:	ff 73 08             	push   0x8(%ebx)
     96b:	e8 30 ff ff ff       	call   8a0 <runcmd>
    close(rcmd->fd);
     970:	83 ec 0c             	sub    $0xc,%esp
     973:	ff 73 14             	push   0x14(%ebx)
     976:	e8 c0 0b 00 00       	call   153b <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     97b:	58                   	pop    %eax
     97c:	5a                   	pop    %edx
     97d:	ff 73 10             	push   0x10(%ebx)
     980:	ff 73 08             	push   0x8(%ebx)
     983:	e8 cb 0b 00 00       	call   1553 <open>
     988:	83 c4 10             	add    $0x10,%esp
     98b:	85 c0                	test   %eax,%eax
     98d:	78 18                	js     9a7 <runcmd+0x107>
      runcmd(bcmd->cmd);
     98f:	83 ec 0c             	sub    $0xc,%esp
     992:	ff 73 04             	push   0x4(%ebx)
     995:	e8 06 ff ff ff       	call   8a0 <runcmd>
    panic("runcmd");
     99a:	83 ec 0c             	sub    $0xc,%esp
     99d:	68 95 19 00 00       	push   $0x1995
     9a2:	e8 b9 fe ff ff       	call   860 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     9a7:	51                   	push   %ecx
     9a8:	ff 73 08             	push   0x8(%ebx)
     9ab:	68 ac 19 00 00       	push   $0x19ac
     9b0:	6a 02                	push   $0x2
     9b2:	e8 a9 0c 00 00       	call   1660 <printf>
      exit();
     9b7:	e8 57 0b 00 00       	call   1513 <exit>
      panic("pipe");
     9bc:	83 ec 0c             	sub    $0xc,%esp
     9bf:	68 bc 19 00 00       	push   $0x19bc
     9c4:	e8 97 fe ff ff       	call   860 <panic>
      close(1);
     9c9:	83 ec 0c             	sub    $0xc,%esp
     9cc:	6a 01                	push   $0x1
     9ce:	e8 68 0b 00 00       	call   153b <close>
      dup(p[1]);
     9d3:	58                   	pop    %eax
     9d4:	ff 75 f4             	push   -0xc(%ebp)
     9d7:	e8 af 0b 00 00       	call   158b <dup>
      close(p[0]);
     9dc:	58                   	pop    %eax
     9dd:	ff 75 f0             	push   -0x10(%ebp)
     9e0:	e8 56 0b 00 00       	call   153b <close>
      close(p[1]);
     9e5:	58                   	pop    %eax
     9e6:	ff 75 f4             	push   -0xc(%ebp)
     9e9:	e8 4d 0b 00 00       	call   153b <close>
      runcmd(pcmd->left);
     9ee:	5a                   	pop    %edx
     9ef:	ff 73 04             	push   0x4(%ebx)
     9f2:	e8 a9 fe ff ff       	call   8a0 <runcmd>
      close(0);
     9f7:	83 ec 0c             	sub    $0xc,%esp
     9fa:	6a 00                	push   $0x0
     9fc:	e8 3a 0b 00 00       	call   153b <close>
      dup(p[0]);
     a01:	5a                   	pop    %edx
     a02:	ff 75 f0             	push   -0x10(%ebp)
     a05:	e8 81 0b 00 00       	call   158b <dup>
      close(p[0]);
     a0a:	59                   	pop    %ecx
     a0b:	ff 75 f0             	push   -0x10(%ebp)
     a0e:	e8 28 0b 00 00       	call   153b <close>
      close(p[1]);
     a13:	58                   	pop    %eax
     a14:	ff 75 f4             	push   -0xc(%ebp)
     a17:	e8 1f 0b 00 00       	call   153b <close>
      runcmd(pcmd->right);
     a1c:	58                   	pop    %eax
     a1d:	ff 73 08             	push   0x8(%ebx)
     a20:	e8 7b fe ff ff       	call   8a0 <runcmd>
     a25:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a2c:	00 
     a2d:	8d 76 00             	lea    0x0(%esi),%esi

00000a30 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	53                   	push   %ebx
     a34:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     a37:	6a 54                	push   $0x54
     a39:	e8 42 0e 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a3e:	83 c4 0c             	add    $0xc,%esp
     a41:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     a43:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     a45:	6a 00                	push   $0x0
     a47:	50                   	push   %eax
     a48:	e8 33 09 00 00       	call   1380 <memset>
  cmd->type = EXEC;
     a4d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     a53:	89 d8                	mov    %ebx,%eax
     a55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a58:	c9                   	leave
     a59:	c3                   	ret
     a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a60 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	53                   	push   %ebx
     a64:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     a67:	6a 18                	push   $0x18
     a69:	e8 12 0e 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a6e:	83 c4 0c             	add    $0xc,%esp
     a71:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     a73:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     a75:	6a 00                	push   $0x0
     a77:	50                   	push   %eax
     a78:	e8 03 09 00 00       	call   1380 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     a80:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     a86:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     a89:	8b 45 0c             	mov    0xc(%ebp),%eax
     a8c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     a8f:	8b 45 10             	mov    0x10(%ebp),%eax
     a92:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     a95:	8b 45 14             	mov    0x14(%ebp),%eax
     a98:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     a9b:	8b 45 18             	mov    0x18(%ebp),%eax
     a9e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     aa1:	89 d8                	mov    %ebx,%eax
     aa3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     aa6:	c9                   	leave
     aa7:	c3                   	ret
     aa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     aaf:	00 

00000ab0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	53                   	push   %ebx
     ab4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     ab7:	6a 0c                	push   $0xc
     ab9:	e8 c2 0d 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     abe:	83 c4 0c             	add    $0xc,%esp
     ac1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     ac3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     ac5:	6a 00                	push   $0x0
     ac7:	50                   	push   %eax
     ac8:	e8 b3 08 00 00       	call   1380 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     acd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     ad0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     ad6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
     adc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     adf:	89 d8                	mov    %ebx,%eax
     ae1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ae4:	c9                   	leave
     ae5:	c3                   	ret
     ae6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     aed:	00 
     aee:	66 90                	xchg   %ax,%ax

00000af0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	53                   	push   %ebx
     af4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     af7:	6a 0c                	push   $0xc
     af9:	e8 82 0d 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     afe:	83 c4 0c             	add    $0xc,%esp
     b01:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     b03:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     b05:	6a 00                	push   $0x0
     b07:	50                   	push   %eax
     b08:	e8 73 08 00 00       	call   1380 <memset>
  cmd->type = LIST;
  cmd->left = left;
     b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     b10:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     b16:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     b19:	8b 45 0c             	mov    0xc(%ebp),%eax
     b1c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     b1f:	89 d8                	mov    %ebx,%eax
     b21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b24:	c9                   	leave
     b25:	c3                   	ret
     b26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b2d:	00 
     b2e:	66 90                	xchg   %ax,%ax

00000b30 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	53                   	push   %ebx
     b34:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     b37:	6a 08                	push   $0x8
     b39:	e8 42 0d 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     b3e:	83 c4 0c             	add    $0xc,%esp
     b41:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     b43:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     b45:	6a 00                	push   $0x0
     b47:	50                   	push   %eax
     b48:	e8 33 08 00 00       	call   1380 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     b50:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     b56:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     b59:	89 d8                	mov    %ebx,%eax
     b5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b5e:	c9                   	leave
     b5f:	c3                   	ret

00000b60 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	57                   	push   %edi
     b64:	56                   	push   %esi
     b65:	53                   	push   %ebx
     b66:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     b69:	8b 45 08             	mov    0x8(%ebp),%eax
{
     b6c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     b6f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     b72:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     b74:	39 df                	cmp    %ebx,%edi
     b76:	72 0f                	jb     b87 <gettoken+0x27>
     b78:	eb 25                	jmp    b9f <gettoken+0x3f>
     b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     b80:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     b83:	39 fb                	cmp    %edi,%ebx
     b85:	74 18                	je     b9f <gettoken+0x3f>
     b87:	0f be 07             	movsbl (%edi),%eax
     b8a:	83 ec 08             	sub    $0x8,%esp
     b8d:	50                   	push   %eax
     b8e:	68 08 22 00 00       	push   $0x2208
     b93:	e8 08 08 00 00       	call   13a0 <strchr>
     b98:	83 c4 10             	add    $0x10,%esp
     b9b:	85 c0                	test   %eax,%eax
     b9d:	75 e1                	jne    b80 <gettoken+0x20>
  if(q)
     b9f:	85 f6                	test   %esi,%esi
     ba1:	74 02                	je     ba5 <gettoken+0x45>
    *q = s;
     ba3:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     ba5:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     ba8:	3c 3c                	cmp    $0x3c,%al
     baa:	0f 8f c8 00 00 00    	jg     c78 <gettoken+0x118>
     bb0:	3c 3a                	cmp    $0x3a,%al
     bb2:	7f 5a                	jg     c0e <gettoken+0xae>
     bb4:	84 c0                	test   %al,%al
     bb6:	75 48                	jne    c00 <gettoken+0xa0>
     bb8:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     bba:	8b 4d 14             	mov    0x14(%ebp),%ecx
     bbd:	85 c9                	test   %ecx,%ecx
     bbf:	74 05                	je     bc6 <gettoken+0x66>
    *eq = s;
     bc1:	8b 45 14             	mov    0x14(%ebp),%eax
     bc4:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     bc6:	39 df                	cmp    %ebx,%edi
     bc8:	72 0d                	jb     bd7 <gettoken+0x77>
     bca:	eb 23                	jmp    bef <gettoken+0x8f>
     bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     bd0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     bd3:	39 fb                	cmp    %edi,%ebx
     bd5:	74 18                	je     bef <gettoken+0x8f>
     bd7:	0f be 07             	movsbl (%edi),%eax
     bda:	83 ec 08             	sub    $0x8,%esp
     bdd:	50                   	push   %eax
     bde:	68 08 22 00 00       	push   $0x2208
     be3:	e8 b8 07 00 00       	call   13a0 <strchr>
     be8:	83 c4 10             	add    $0x10,%esp
     beb:	85 c0                	test   %eax,%eax
     bed:	75 e1                	jne    bd0 <gettoken+0x70>
  *ps = s;
     bef:	8b 45 08             	mov    0x8(%ebp),%eax
     bf2:	89 38                	mov    %edi,(%eax)
  return ret;
}
     bf4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bf7:	89 f0                	mov    %esi,%eax
     bf9:	5b                   	pop    %ebx
     bfa:	5e                   	pop    %esi
     bfb:	5f                   	pop    %edi
     bfc:	5d                   	pop    %ebp
     bfd:	c3                   	ret
     bfe:	66 90                	xchg   %ax,%ax
  switch(*s){
     c00:	78 22                	js     c24 <gettoken+0xc4>
     c02:	3c 26                	cmp    $0x26,%al
     c04:	74 08                	je     c0e <gettoken+0xae>
     c06:	8d 48 d8             	lea    -0x28(%eax),%ecx
     c09:	80 f9 01             	cmp    $0x1,%cl
     c0c:	77 16                	ja     c24 <gettoken+0xc4>
  ret = *s;
     c0e:	0f be f0             	movsbl %al,%esi
    s++;
     c11:	83 c7 01             	add    $0x1,%edi
    break;
     c14:	eb a4                	jmp    bba <gettoken+0x5a>
     c16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     c1d:	00 
     c1e:	66 90                	xchg   %ax,%ax
  switch(*s){
     c20:	3c 7c                	cmp    $0x7c,%al
     c22:	74 ea                	je     c0e <gettoken+0xae>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     c24:	39 df                	cmp    %ebx,%edi
     c26:	72 27                	jb     c4f <gettoken+0xef>
     c28:	e9 87 00 00 00       	jmp    cb4 <gettoken+0x154>
     c2d:	8d 76 00             	lea    0x0(%esi),%esi
     c30:	0f be 07             	movsbl (%edi),%eax
     c33:	83 ec 08             	sub    $0x8,%esp
     c36:	50                   	push   %eax
     c37:	68 00 22 00 00       	push   $0x2200
     c3c:	e8 5f 07 00 00       	call   13a0 <strchr>
     c41:	83 c4 10             	add    $0x10,%esp
     c44:	85 c0                	test   %eax,%eax
     c46:	75 1f                	jne    c67 <gettoken+0x107>
      s++;
     c48:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     c4b:	39 fb                	cmp    %edi,%ebx
     c4d:	74 4d                	je     c9c <gettoken+0x13c>
     c4f:	0f be 07             	movsbl (%edi),%eax
     c52:	83 ec 08             	sub    $0x8,%esp
     c55:	50                   	push   %eax
     c56:	68 08 22 00 00       	push   $0x2208
     c5b:	e8 40 07 00 00       	call   13a0 <strchr>
     c60:	83 c4 10             	add    $0x10,%esp
     c63:	85 c0                	test   %eax,%eax
     c65:	74 c9                	je     c30 <gettoken+0xd0>
    ret = 'a';
     c67:	be 61 00 00 00       	mov    $0x61,%esi
     c6c:	e9 49 ff ff ff       	jmp    bba <gettoken+0x5a>
     c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     c78:	3c 3e                	cmp    $0x3e,%al
     c7a:	75 a4                	jne    c20 <gettoken+0xc0>
    if(*s == '>'){
     c7c:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     c80:	74 0d                	je     c8f <gettoken+0x12f>
    s++;
     c82:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     c85:	be 3e 00 00 00       	mov    $0x3e,%esi
     c8a:	e9 2b ff ff ff       	jmp    bba <gettoken+0x5a>
      s++;
     c8f:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     c92:	be 2b 00 00 00       	mov    $0x2b,%esi
     c97:	e9 1e ff ff ff       	jmp    bba <gettoken+0x5a>
  if(eq)
     c9c:	8b 45 14             	mov    0x14(%ebp),%eax
     c9f:	85 c0                	test   %eax,%eax
     ca1:	74 05                	je     ca8 <gettoken+0x148>
    *eq = s;
     ca3:	8b 45 14             	mov    0x14(%ebp),%eax
     ca6:	89 18                	mov    %ebx,(%eax)
  while(s < es && strchr(whitespace, *s))
     ca8:	89 df                	mov    %ebx,%edi
    ret = 'a';
     caa:	be 61 00 00 00       	mov    $0x61,%esi
     caf:	e9 3b ff ff ff       	jmp    bef <gettoken+0x8f>
  if(eq)
     cb4:	8b 55 14             	mov    0x14(%ebp),%edx
     cb7:	85 d2                	test   %edx,%edx
     cb9:	74 ef                	je     caa <gettoken+0x14a>
    *eq = s;
     cbb:	8b 45 14             	mov    0x14(%ebp),%eax
     cbe:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     cc0:	eb e8                	jmp    caa <gettoken+0x14a>
     cc2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     cc9:	00 
     cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000cd0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	57                   	push   %edi
     cd4:	56                   	push   %esi
     cd5:	53                   	push   %ebx
     cd6:	83 ec 0c             	sub    $0xc,%esp
     cd9:	8b 7d 08             	mov    0x8(%ebp),%edi
     cdc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     cdf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     ce1:	39 f3                	cmp    %esi,%ebx
     ce3:	72 12                	jb     cf7 <peek+0x27>
     ce5:	eb 28                	jmp    d0f <peek+0x3f>
     ce7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     cee:	00 
     cef:	90                   	nop
    s++;
     cf0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     cf3:	39 de                	cmp    %ebx,%esi
     cf5:	74 18                	je     d0f <peek+0x3f>
     cf7:	0f be 03             	movsbl (%ebx),%eax
     cfa:	83 ec 08             	sub    $0x8,%esp
     cfd:	50                   	push   %eax
     cfe:	68 08 22 00 00       	push   $0x2208
     d03:	e8 98 06 00 00       	call   13a0 <strchr>
     d08:	83 c4 10             	add    $0x10,%esp
     d0b:	85 c0                	test   %eax,%eax
     d0d:	75 e1                	jne    cf0 <peek+0x20>
  *ps = s;
     d0f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     d11:	0f be 03             	movsbl (%ebx),%eax
     d14:	31 d2                	xor    %edx,%edx
     d16:	84 c0                	test   %al,%al
     d18:	75 0e                	jne    d28 <peek+0x58>
}
     d1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d1d:	89 d0                	mov    %edx,%eax
     d1f:	5b                   	pop    %ebx
     d20:	5e                   	pop    %esi
     d21:	5f                   	pop    %edi
     d22:	5d                   	pop    %ebp
     d23:	c3                   	ret
     d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     d28:	83 ec 08             	sub    $0x8,%esp
     d2b:	50                   	push   %eax
     d2c:	ff 75 10             	push   0x10(%ebp)
     d2f:	e8 6c 06 00 00       	call   13a0 <strchr>
     d34:	83 c4 10             	add    $0x10,%esp
     d37:	31 d2                	xor    %edx,%edx
     d39:	85 c0                	test   %eax,%eax
     d3b:	0f 95 c2             	setne  %dl
}
     d3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d41:	5b                   	pop    %ebx
     d42:	89 d0                	mov    %edx,%eax
     d44:	5e                   	pop    %esi
     d45:	5f                   	pop    %edi
     d46:	5d                   	pop    %ebp
     d47:	c3                   	ret
     d48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d4f:	00 

00000d50 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	57                   	push   %edi
     d54:	56                   	push   %esi
     d55:	53                   	push   %ebx
     d56:	83 ec 2c             	sub    $0x2c,%esp
     d59:	8b 75 0c             	mov    0xc(%ebp),%esi
     d5c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     d5f:	90                   	nop
     d60:	83 ec 04             	sub    $0x4,%esp
     d63:	68 de 19 00 00       	push   $0x19de
     d68:	53                   	push   %ebx
     d69:	56                   	push   %esi
     d6a:	e8 61 ff ff ff       	call   cd0 <peek>
     d6f:	83 c4 10             	add    $0x10,%esp
     d72:	85 c0                	test   %eax,%eax
     d74:	0f 84 f6 00 00 00    	je     e70 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     d7a:	6a 00                	push   $0x0
     d7c:	6a 00                	push   $0x0
     d7e:	53                   	push   %ebx
     d7f:	56                   	push   %esi
     d80:	e8 db fd ff ff       	call   b60 <gettoken>
     d85:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     d87:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     d8a:	50                   	push   %eax
     d8b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     d8e:	50                   	push   %eax
     d8f:	53                   	push   %ebx
     d90:	56                   	push   %esi
     d91:	e8 ca fd ff ff       	call   b60 <gettoken>
     d96:	83 c4 20             	add    $0x20,%esp
     d99:	83 f8 61             	cmp    $0x61,%eax
     d9c:	0f 85 d9 00 00 00    	jne    e7b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     da2:	83 ff 3c             	cmp    $0x3c,%edi
     da5:	74 69                	je     e10 <parseredirs+0xc0>
     da7:	83 ff 3e             	cmp    $0x3e,%edi
     daa:	74 05                	je     db1 <parseredirs+0x61>
     dac:	83 ff 2b             	cmp    $0x2b,%edi
     daf:	75 af                	jne    d60 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     db1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     db4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     db7:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     dba:	89 55 d0             	mov    %edx,-0x30(%ebp)
     dbd:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     dc0:	6a 18                	push   $0x18
     dc2:	e8 b9 0a 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     dc7:	83 c4 0c             	add    $0xc,%esp
     dca:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     dcc:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     dce:	6a 00                	push   $0x0
     dd0:	50                   	push   %eax
     dd1:	e8 aa 05 00 00       	call   1380 <memset>
  cmd->type = REDIR;
     dd6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     ddc:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     ddf:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     de2:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     de5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     de8:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     deb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     dee:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     df5:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     df8:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     dff:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     e02:	e9 59 ff ff ff       	jmp    d60 <parseredirs+0x10>
     e07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e0e:	00 
     e0f:	90                   	nop
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     e10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     e13:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     e16:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     e19:	89 55 d0             	mov    %edx,-0x30(%ebp)
     e1c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     e1f:	6a 18                	push   $0x18
     e21:	e8 5a 0a 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     e26:	83 c4 0c             	add    $0xc,%esp
     e29:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     e2b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     e2d:	6a 00                	push   $0x0
     e2f:	50                   	push   %eax
     e30:	e8 4b 05 00 00       	call   1380 <memset>
  cmd->cmd = subcmd;
     e35:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     e38:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     e3b:	83 c4 10             	add    $0x10,%esp
  cmd->efile = efile;
     e3e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     e41:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     e47:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     e4a:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     e4d:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     e50:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     e57:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     e5e:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     e61:	e9 fa fe ff ff       	jmp    d60 <parseredirs+0x10>
     e66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e6d:	00 
     e6e:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     e70:	8b 45 08             	mov    0x8(%ebp),%eax
     e73:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e76:	5b                   	pop    %ebx
     e77:	5e                   	pop    %esi
     e78:	5f                   	pop    %edi
     e79:	5d                   	pop    %ebp
     e7a:	c3                   	ret
      panic("missing file for redirection");
     e7b:	83 ec 0c             	sub    $0xc,%esp
     e7e:	68 c1 19 00 00       	push   $0x19c1
     e83:	e8 d8 f9 ff ff       	call   860 <panic>
     e88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e8f:	00 

00000e90 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	57                   	push   %edi
     e94:	56                   	push   %esi
     e95:	53                   	push   %ebx
     e96:	83 ec 30             	sub    $0x30,%esp
     e99:	8b 5d 08             	mov    0x8(%ebp),%ebx
     e9c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     e9f:	68 e1 19 00 00       	push   $0x19e1
     ea4:	56                   	push   %esi
     ea5:	53                   	push   %ebx
     ea6:	e8 25 fe ff ff       	call   cd0 <peek>
     eab:	83 c4 10             	add    $0x10,%esp
     eae:	85 c0                	test   %eax,%eax
     eb0:	0f 85 aa 00 00 00    	jne    f60 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     eb6:	83 ec 0c             	sub    $0xc,%esp
     eb9:	89 c7                	mov    %eax,%edi
     ebb:	6a 54                	push   $0x54
     ebd:	e8 be 09 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     ec2:	83 c4 0c             	add    $0xc,%esp
     ec5:	6a 54                	push   $0x54
     ec7:	6a 00                	push   $0x0
     ec9:	89 45 d0             	mov    %eax,-0x30(%ebp)
     ecc:	50                   	push   %eax
     ecd:	e8 ae 04 00 00       	call   1380 <memset>
  cmd->type = EXEC;
     ed2:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     ed5:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     ed8:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     ede:	56                   	push   %esi
     edf:	53                   	push   %ebx
     ee0:	50                   	push   %eax
     ee1:	e8 6a fe ff ff       	call   d50 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     ee6:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     ee9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     eec:	eb 15                	jmp    f03 <parseexec+0x73>
     eee:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     ef0:	83 ec 04             	sub    $0x4,%esp
     ef3:	56                   	push   %esi
     ef4:	53                   	push   %ebx
     ef5:	ff 75 d4             	push   -0x2c(%ebp)
     ef8:	e8 53 fe ff ff       	call   d50 <parseredirs>
     efd:	83 c4 10             	add    $0x10,%esp
     f00:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     f03:	83 ec 04             	sub    $0x4,%esp
     f06:	68 f8 19 00 00       	push   $0x19f8
     f0b:	56                   	push   %esi
     f0c:	53                   	push   %ebx
     f0d:	e8 be fd ff ff       	call   cd0 <peek>
     f12:	83 c4 10             	add    $0x10,%esp
     f15:	85 c0                	test   %eax,%eax
     f17:	75 5f                	jne    f78 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     f19:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     f1c:	50                   	push   %eax
     f1d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     f20:	50                   	push   %eax
     f21:	56                   	push   %esi
     f22:	53                   	push   %ebx
     f23:	e8 38 fc ff ff       	call   b60 <gettoken>
     f28:	83 c4 10             	add    $0x10,%esp
     f2b:	85 c0                	test   %eax,%eax
     f2d:	74 49                	je     f78 <parseexec+0xe8>
    if(tok != 'a')
     f2f:	83 f8 61             	cmp    $0x61,%eax
     f32:	75 62                	jne    f96 <parseexec+0x106>
    cmd->argv[argc] = q;
     f34:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f37:	8b 55 d0             	mov    -0x30(%ebp),%edx
     f3a:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     f3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f41:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     f45:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     f48:	83 ff 0a             	cmp    $0xa,%edi
     f4b:	75 a3                	jne    ef0 <parseexec+0x60>
      panic("too many args");
     f4d:	83 ec 0c             	sub    $0xc,%esp
     f50:	68 ea 19 00 00       	push   $0x19ea
     f55:	e8 06 f9 ff ff       	call   860 <panic>
     f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     f60:	89 75 0c             	mov    %esi,0xc(%ebp)
     f63:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     f66:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f69:	5b                   	pop    %ebx
     f6a:	5e                   	pop    %esi
     f6b:	5f                   	pop    %edi
     f6c:	5d                   	pop    %ebp
    return parseblock(ps, es);
     f6d:	e9 ae 01 00 00       	jmp    1120 <parseblock>
     f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     f78:	8b 45 d0             	mov    -0x30(%ebp),%eax
     f7b:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     f82:	00 
  cmd->eargv[argc] = 0;
     f83:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     f8a:	00 
}
     f8b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f91:	5b                   	pop    %ebx
     f92:	5e                   	pop    %esi
     f93:	5f                   	pop    %edi
     f94:	5d                   	pop    %ebp
     f95:	c3                   	ret
      panic("syntax");
     f96:	83 ec 0c             	sub    $0xc,%esp
     f99:	68 e3 19 00 00       	push   $0x19e3
     f9e:	e8 bd f8 ff ff       	call   860 <panic>
     fa3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     faa:	00 
     fab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000fb0 <parsepipe>:
{
     fb0:	55                   	push   %ebp
     fb1:	89 e5                	mov    %esp,%ebp
     fb3:	57                   	push   %edi
     fb4:	56                   	push   %esi
     fb5:	53                   	push   %ebx
     fb6:	83 ec 14             	sub    $0x14,%esp
     fb9:	8b 75 08             	mov    0x8(%ebp),%esi
     fbc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     fbf:	57                   	push   %edi
     fc0:	56                   	push   %esi
     fc1:	e8 ca fe ff ff       	call   e90 <parseexec>
  if(peek(ps, es, "|")){
     fc6:	83 c4 0c             	add    $0xc,%esp
     fc9:	68 fd 19 00 00       	push   $0x19fd
  cmd = parseexec(ps, es);
     fce:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     fd0:	57                   	push   %edi
     fd1:	56                   	push   %esi
     fd2:	e8 f9 fc ff ff       	call   cd0 <peek>
     fd7:	83 c4 10             	add    $0x10,%esp
     fda:	85 c0                	test   %eax,%eax
     fdc:	75 12                	jne    ff0 <parsepipe+0x40>
}
     fde:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fe1:	89 d8                	mov    %ebx,%eax
     fe3:	5b                   	pop    %ebx
     fe4:	5e                   	pop    %esi
     fe5:	5f                   	pop    %edi
     fe6:	5d                   	pop    %ebp
     fe7:	c3                   	ret
     fe8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     fef:	00 
    gettoken(ps, es, 0, 0);
     ff0:	6a 00                	push   $0x0
     ff2:	6a 00                	push   $0x0
     ff4:	57                   	push   %edi
     ff5:	56                   	push   %esi
     ff6:	e8 65 fb ff ff       	call   b60 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     ffb:	58                   	pop    %eax
     ffc:	5a                   	pop    %edx
     ffd:	57                   	push   %edi
     ffe:	56                   	push   %esi
     fff:	e8 ac ff ff ff       	call   fb0 <parsepipe>
  cmd = malloc(sizeof(*cmd));
    1004:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
    100b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
    100d:	e8 6e 08 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    1012:	83 c4 0c             	add    $0xc,%esp
    1015:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
    1017:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
    1019:	6a 00                	push   $0x0
    101b:	50                   	push   %eax
    101c:	e8 5f 03 00 00       	call   1380 <memset>
  cmd->left = left;
    1021:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
    1024:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
    1027:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
    1029:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
    102f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
    1031:	89 7e 08             	mov    %edi,0x8(%esi)
}
    1034:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1037:	5b                   	pop    %ebx
    1038:	5e                   	pop    %esi
    1039:	5f                   	pop    %edi
    103a:	5d                   	pop    %ebp
    103b:	c3                   	ret
    103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001040 <parseline>:
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	57                   	push   %edi
    1044:	56                   	push   %esi
    1045:	53                   	push   %ebx
    1046:	83 ec 24             	sub    $0x24,%esp
    1049:	8b 75 08             	mov    0x8(%ebp),%esi
    104c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
    104f:	57                   	push   %edi
    1050:	56                   	push   %esi
    1051:	e8 5a ff ff ff       	call   fb0 <parsepipe>
  while(peek(ps, es, "&")){
    1056:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
    1059:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
    105b:	eb 3b                	jmp    1098 <parseline+0x58>
    105d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
    1060:	6a 00                	push   $0x0
    1062:	6a 00                	push   $0x0
    1064:	57                   	push   %edi
    1065:	56                   	push   %esi
    1066:	e8 f5 fa ff ff       	call   b60 <gettoken>
  cmd = malloc(sizeof(*cmd));
    106b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1072:	e8 09 08 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    1077:	83 c4 0c             	add    $0xc,%esp
    107a:	6a 08                	push   $0x8
    107c:	6a 00                	push   $0x0
    107e:	50                   	push   %eax
    107f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1082:	e8 f9 02 00 00       	call   1380 <memset>
  cmd->type = BACK;
    1087:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
    108a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
    108d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
    1093:	89 5a 04             	mov    %ebx,0x4(%edx)
    cmd = backcmd(cmd);
    1096:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
    1098:	83 ec 04             	sub    $0x4,%esp
    109b:	68 ff 19 00 00       	push   $0x19ff
    10a0:	57                   	push   %edi
    10a1:	56                   	push   %esi
    10a2:	e8 29 fc ff ff       	call   cd0 <peek>
    10a7:	83 c4 10             	add    $0x10,%esp
    10aa:	85 c0                	test   %eax,%eax
    10ac:	75 b2                	jne    1060 <parseline+0x20>
  if(peek(ps, es, ";")){
    10ae:	83 ec 04             	sub    $0x4,%esp
    10b1:	68 fb 19 00 00       	push   $0x19fb
    10b6:	57                   	push   %edi
    10b7:	56                   	push   %esi
    10b8:	e8 13 fc ff ff       	call   cd0 <peek>
    10bd:	83 c4 10             	add    $0x10,%esp
    10c0:	85 c0                	test   %eax,%eax
    10c2:	75 0c                	jne    10d0 <parseline+0x90>
}
    10c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10c7:	89 d8                	mov    %ebx,%eax
    10c9:	5b                   	pop    %ebx
    10ca:	5e                   	pop    %esi
    10cb:	5f                   	pop    %edi
    10cc:	5d                   	pop    %ebp
    10cd:	c3                   	ret
    10ce:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
    10d0:	6a 00                	push   $0x0
    10d2:	6a 00                	push   $0x0
    10d4:	57                   	push   %edi
    10d5:	56                   	push   %esi
    10d6:	e8 85 fa ff ff       	call   b60 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
    10db:	58                   	pop    %eax
    10dc:	5a                   	pop    %edx
    10dd:	57                   	push   %edi
    10de:	56                   	push   %esi
    10df:	e8 5c ff ff ff       	call   1040 <parseline>
  cmd = malloc(sizeof(*cmd));
    10e4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
    10eb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
    10ed:	e8 8e 07 00 00       	call   1880 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    10f2:	83 c4 0c             	add    $0xc,%esp
    10f5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
    10f7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
    10f9:	6a 00                	push   $0x0
    10fb:	50                   	push   %eax
    10fc:	e8 7f 02 00 00       	call   1380 <memset>
  cmd->left = left;
    1101:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
    1104:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
    1107:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
    1109:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
    110f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
    1111:	89 7e 08             	mov    %edi,0x8(%esi)
}
    1114:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1117:	5b                   	pop    %ebx
    1118:	5e                   	pop    %esi
    1119:	5f                   	pop    %edi
    111a:	5d                   	pop    %ebp
    111b:	c3                   	ret
    111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001120 <parseblock>:
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	57                   	push   %edi
    1124:	56                   	push   %esi
    1125:	53                   	push   %ebx
    1126:	83 ec 10             	sub    $0x10,%esp
    1129:	8b 5d 08             	mov    0x8(%ebp),%ebx
    112c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
    112f:	68 e1 19 00 00       	push   $0x19e1
    1134:	56                   	push   %esi
    1135:	53                   	push   %ebx
    1136:	e8 95 fb ff ff       	call   cd0 <peek>
    113b:	83 c4 10             	add    $0x10,%esp
    113e:	85 c0                	test   %eax,%eax
    1140:	74 4a                	je     118c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
    1142:	6a 00                	push   $0x0
    1144:	6a 00                	push   $0x0
    1146:	56                   	push   %esi
    1147:	53                   	push   %ebx
    1148:	e8 13 fa ff ff       	call   b60 <gettoken>
  cmd = parseline(ps, es);
    114d:	58                   	pop    %eax
    114e:	5a                   	pop    %edx
    114f:	56                   	push   %esi
    1150:	53                   	push   %ebx
    1151:	e8 ea fe ff ff       	call   1040 <parseline>
  if(!peek(ps, es, ")"))
    1156:	83 c4 0c             	add    $0xc,%esp
    1159:	68 1d 1a 00 00       	push   $0x1a1d
  cmd = parseline(ps, es);
    115e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
    1160:	56                   	push   %esi
    1161:	53                   	push   %ebx
    1162:	e8 69 fb ff ff       	call   cd0 <peek>
    1167:	83 c4 10             	add    $0x10,%esp
    116a:	85 c0                	test   %eax,%eax
    116c:	74 2b                	je     1199 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
    116e:	6a 00                	push   $0x0
    1170:	6a 00                	push   $0x0
    1172:	56                   	push   %esi
    1173:	53                   	push   %ebx
    1174:	e8 e7 f9 ff ff       	call   b60 <gettoken>
  cmd = parseredirs(cmd, ps, es);
    1179:	83 c4 0c             	add    $0xc,%esp
    117c:	56                   	push   %esi
    117d:	53                   	push   %ebx
    117e:	57                   	push   %edi
    117f:	e8 cc fb ff ff       	call   d50 <parseredirs>
}
    1184:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1187:	5b                   	pop    %ebx
    1188:	5e                   	pop    %esi
    1189:	5f                   	pop    %edi
    118a:	5d                   	pop    %ebp
    118b:	c3                   	ret
    panic("parseblock");
    118c:	83 ec 0c             	sub    $0xc,%esp
    118f:	68 01 1a 00 00       	push   $0x1a01
    1194:	e8 c7 f6 ff ff       	call   860 <panic>
    panic("syntax - missing )");
    1199:	83 ec 0c             	sub    $0xc,%esp
    119c:	68 0c 1a 00 00       	push   $0x1a0c
    11a1:	e8 ba f6 ff ff       	call   860 <panic>
    11a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    11ad:	00 
    11ae:	66 90                	xchg   %ax,%ax

000011b0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	53                   	push   %ebx
    11b4:	83 ec 04             	sub    $0x4,%esp
    11b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    11ba:	85 db                	test   %ebx,%ebx
    11bc:	74 29                	je     11e7 <nulterminate+0x37>
    return 0;

  switch(cmd->type){
    11be:	83 3b 05             	cmpl   $0x5,(%ebx)
    11c1:	77 24                	ja     11e7 <nulterminate+0x37>
    11c3:	8b 03                	mov    (%ebx),%eax
    11c5:	ff 24 85 a4 1a 00 00 	jmp    *0x1aa4(,%eax,4)
    11cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
    11d0:	83 ec 0c             	sub    $0xc,%esp
    11d3:	ff 73 04             	push   0x4(%ebx)
    11d6:	e8 d5 ff ff ff       	call   11b0 <nulterminate>
    nulterminate(lcmd->right);
    11db:	58                   	pop    %eax
    11dc:	ff 73 08             	push   0x8(%ebx)
    11df:	e8 cc ff ff ff       	call   11b0 <nulterminate>
    break;
    11e4:	83 c4 10             	add    $0x10,%esp
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
    11e7:	89 d8                	mov    %ebx,%eax
    11e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11ec:	c9                   	leave
    11ed:	c3                   	ret
    11ee:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
    11f0:	83 ec 0c             	sub    $0xc,%esp
    11f3:	ff 73 04             	push   0x4(%ebx)
    11f6:	e8 b5 ff ff ff       	call   11b0 <nulterminate>
}
    11fb:	89 d8                	mov    %ebx,%eax
    break;
    11fd:	83 c4 10             	add    $0x10,%esp
}
    1200:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1203:	c9                   	leave
    1204:	c3                   	ret
    1205:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
    1208:	8b 4b 04             	mov    0x4(%ebx),%ecx
    120b:	85 c9                	test   %ecx,%ecx
    120d:	74 d8                	je     11e7 <nulterminate+0x37>
    120f:	8d 43 08             	lea    0x8(%ebx),%eax
    1212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
    1218:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
    121b:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
    121e:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
    1221:	8b 50 fc             	mov    -0x4(%eax),%edx
    1224:	85 d2                	test   %edx,%edx
    1226:	75 f0                	jne    1218 <nulterminate+0x68>
}
    1228:	89 d8                	mov    %ebx,%eax
    122a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    122d:	c9                   	leave
    122e:	c3                   	ret
    122f:	90                   	nop
    nulterminate(rcmd->cmd);
    1230:	83 ec 0c             	sub    $0xc,%esp
    1233:	ff 73 04             	push   0x4(%ebx)
    1236:	e8 75 ff ff ff       	call   11b0 <nulterminate>
    *rcmd->efile = 0;
    123b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
    123e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
    1241:	c6 00 00             	movb   $0x0,(%eax)
}
    1244:	89 d8                	mov    %ebx,%eax
    1246:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1249:	c9                   	leave
    124a:	c3                   	ret
    124b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00001250 <parsecmd>:
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	57                   	push   %edi
    1254:	56                   	push   %esi
  cmd = parseline(&s, es);
    1255:	8d 7d 08             	lea    0x8(%ebp),%edi
{
    1258:	53                   	push   %ebx
    1259:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
    125c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    125f:	53                   	push   %ebx
    1260:	e8 eb 00 00 00       	call   1350 <strlen>
  cmd = parseline(&s, es);
    1265:	59                   	pop    %ecx
    1266:	5e                   	pop    %esi
  es = s + strlen(s);
    1267:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
    1269:	53                   	push   %ebx
    126a:	57                   	push   %edi
    126b:	e8 d0 fd ff ff       	call   1040 <parseline>
  peek(&s, es, "");
    1270:	83 c4 0c             	add    $0xc,%esp
    1273:	68 8c 19 00 00       	push   $0x198c
  cmd = parseline(&s, es);
    1278:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
    127a:	53                   	push   %ebx
    127b:	57                   	push   %edi
    127c:	e8 4f fa ff ff       	call   cd0 <peek>
  if(s != es){
    1281:	8b 45 08             	mov    0x8(%ebp),%eax
    1284:	83 c4 10             	add    $0x10,%esp
    1287:	39 d8                	cmp    %ebx,%eax
    1289:	75 13                	jne    129e <parsecmd+0x4e>
  nulterminate(cmd);
    128b:	83 ec 0c             	sub    $0xc,%esp
    128e:	56                   	push   %esi
    128f:	e8 1c ff ff ff       	call   11b0 <nulterminate>
}
    1294:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1297:	89 f0                	mov    %esi,%eax
    1299:	5b                   	pop    %ebx
    129a:	5e                   	pop    %esi
    129b:	5f                   	pop    %edi
    129c:	5d                   	pop    %ebp
    129d:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
    129e:	52                   	push   %edx
    129f:	50                   	push   %eax
    12a0:	68 1f 1a 00 00       	push   $0x1a1f
    12a5:	6a 02                	push   $0x2
    12a7:	e8 b4 03 00 00       	call   1660 <printf>
    panic("syntax");
    12ac:	c7 04 24 e3 19 00 00 	movl   $0x19e3,(%esp)
    12b3:	e8 a8 f5 ff ff       	call   860 <panic>
    12b8:	66 90                	xchg   %ax,%ax
    12ba:	66 90                	xchg   %ax,%ax
    12bc:	66 90                	xchg   %ax,%ax
    12be:	66 90                	xchg   %ax,%ax

000012c0 <strcpy>:
    12c0:	55                   	push   %ebp
    12c1:	31 c0                	xor    %eax,%eax
    12c3:	89 e5                	mov    %esp,%ebp
    12c5:	53                   	push   %ebx
    12c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    12c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    12cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    12d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    12d7:	83 c0 01             	add    $0x1,%eax
    12da:	84 d2                	test   %dl,%dl
    12dc:	75 f2                	jne    12d0 <strcpy+0x10>
    12de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12e1:	89 c8                	mov    %ecx,%eax
    12e3:	c9                   	leave
    12e4:	c3                   	ret
    12e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    12ec:	00 
    12ed:	8d 76 00             	lea    0x0(%esi),%esi

000012f0 <strcmp>:
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	53                   	push   %ebx
    12f4:	8b 55 08             	mov    0x8(%ebp),%edx
    12f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    12fa:	0f b6 02             	movzbl (%edx),%eax
    12fd:	84 c0                	test   %al,%al
    12ff:	75 17                	jne    1318 <strcmp+0x28>
    1301:	eb 3a                	jmp    133d <strcmp+0x4d>
    1303:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1308:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    130c:	83 c2 01             	add    $0x1,%edx
    130f:	8d 59 01             	lea    0x1(%ecx),%ebx
    1312:	84 c0                	test   %al,%al
    1314:	74 1a                	je     1330 <strcmp+0x40>
    1316:	89 d9                	mov    %ebx,%ecx
    1318:	0f b6 19             	movzbl (%ecx),%ebx
    131b:	38 c3                	cmp    %al,%bl
    131d:	74 e9                	je     1308 <strcmp+0x18>
    131f:	29 d8                	sub    %ebx,%eax
    1321:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1324:	c9                   	leave
    1325:	c3                   	ret
    1326:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    132d:	00 
    132e:	66 90                	xchg   %ax,%ax
    1330:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    1334:	31 c0                	xor    %eax,%eax
    1336:	29 d8                	sub    %ebx,%eax
    1338:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    133b:	c9                   	leave
    133c:	c3                   	ret
    133d:	0f b6 19             	movzbl (%ecx),%ebx
    1340:	31 c0                	xor    %eax,%eax
    1342:	eb db                	jmp    131f <strcmp+0x2f>
    1344:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    134b:	00 
    134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001350 <strlen>:
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	8b 55 08             	mov    0x8(%ebp),%edx
    1356:	80 3a 00             	cmpb   $0x0,(%edx)
    1359:	74 15                	je     1370 <strlen+0x20>
    135b:	31 c0                	xor    %eax,%eax
    135d:	8d 76 00             	lea    0x0(%esi),%esi
    1360:	83 c0 01             	add    $0x1,%eax
    1363:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1367:	89 c1                	mov    %eax,%ecx
    1369:	75 f5                	jne    1360 <strlen+0x10>
    136b:	89 c8                	mov    %ecx,%eax
    136d:	5d                   	pop    %ebp
    136e:	c3                   	ret
    136f:	90                   	nop
    1370:	31 c9                	xor    %ecx,%ecx
    1372:	5d                   	pop    %ebp
    1373:	89 c8                	mov    %ecx,%eax
    1375:	c3                   	ret
    1376:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    137d:	00 
    137e:	66 90                	xchg   %ax,%ax

00001380 <memset>:
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	57                   	push   %edi
    1384:	8b 55 08             	mov    0x8(%ebp),%edx
    1387:	8b 4d 10             	mov    0x10(%ebp),%ecx
    138a:	8b 45 0c             	mov    0xc(%ebp),%eax
    138d:	89 d7                	mov    %edx,%edi
    138f:	fc                   	cld
    1390:	f3 aa                	rep stos %al,%es:(%edi)
    1392:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1395:	89 d0                	mov    %edx,%eax
    1397:	c9                   	leave
    1398:	c3                   	ret
    1399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013a0 <strchr>:
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	8b 45 08             	mov    0x8(%ebp),%eax
    13a6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    13aa:	0f b6 10             	movzbl (%eax),%edx
    13ad:	84 d2                	test   %dl,%dl
    13af:	75 12                	jne    13c3 <strchr+0x23>
    13b1:	eb 1d                	jmp    13d0 <strchr+0x30>
    13b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    13b8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    13bc:	83 c0 01             	add    $0x1,%eax
    13bf:	84 d2                	test   %dl,%dl
    13c1:	74 0d                	je     13d0 <strchr+0x30>
    13c3:	38 d1                	cmp    %dl,%cl
    13c5:	75 f1                	jne    13b8 <strchr+0x18>
    13c7:	5d                   	pop    %ebp
    13c8:	c3                   	ret
    13c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13d0:	31 c0                	xor    %eax,%eax
    13d2:	5d                   	pop    %ebp
    13d3:	c3                   	ret
    13d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    13db:	00 
    13dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000013e0 <gets>:
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	57                   	push   %edi
    13e4:	56                   	push   %esi
    13e5:	8d 7d e7             	lea    -0x19(%ebp),%edi
    13e8:	53                   	push   %ebx
    13e9:	31 db                	xor    %ebx,%ebx
    13eb:	8d 73 01             	lea    0x1(%ebx),%esi
    13ee:	83 ec 1c             	sub    $0x1c,%esp
    13f1:	3b 75 0c             	cmp    0xc(%ebp),%esi
    13f4:	7d 3b                	jge    1431 <gets+0x51>
    13f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    13fd:	00 
    13fe:	66 90                	xchg   %ax,%ax
    1400:	83 ec 04             	sub    $0x4,%esp
    1403:	6a 01                	push   $0x1
    1405:	57                   	push   %edi
    1406:	6a 00                	push   $0x0
    1408:	e8 1e 01 00 00       	call   152b <read>
    140d:	83 c4 10             	add    $0x10,%esp
    1410:	85 c0                	test   %eax,%eax
    1412:	7e 1d                	jle    1431 <gets+0x51>
    1414:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1418:	8b 55 08             	mov    0x8(%ebp),%edx
    141b:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    141f:	3c 0a                	cmp    $0xa,%al
    1421:	7f 25                	jg     1448 <gets+0x68>
    1423:	3c 08                	cmp    $0x8,%al
    1425:	7f 0c                	jg     1433 <gets+0x53>
    1427:	89 f3                	mov    %esi,%ebx
    1429:	8d 73 01             	lea    0x1(%ebx),%esi
    142c:	3b 75 0c             	cmp    0xc(%ebp),%esi
    142f:	7c cf                	jl     1400 <gets+0x20>
    1431:	89 de                	mov    %ebx,%esi
    1433:	8b 45 08             	mov    0x8(%ebp),%eax
    1436:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    143a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    143d:	5b                   	pop    %ebx
    143e:	5e                   	pop    %esi
    143f:	5f                   	pop    %edi
    1440:	5d                   	pop    %ebp
    1441:	c3                   	ret
    1442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1448:	3c 0d                	cmp    $0xd,%al
    144a:	74 e7                	je     1433 <gets+0x53>
    144c:	89 f3                	mov    %esi,%ebx
    144e:	eb d9                	jmp    1429 <gets+0x49>

00001450 <stat>:
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	56                   	push   %esi
    1454:	53                   	push   %ebx
    1455:	83 ec 08             	sub    $0x8,%esp
    1458:	6a 00                	push   $0x0
    145a:	ff 75 08             	push   0x8(%ebp)
    145d:	e8 f1 00 00 00       	call   1553 <open>
    1462:	83 c4 10             	add    $0x10,%esp
    1465:	85 c0                	test   %eax,%eax
    1467:	78 27                	js     1490 <stat+0x40>
    1469:	83 ec 08             	sub    $0x8,%esp
    146c:	ff 75 0c             	push   0xc(%ebp)
    146f:	89 c3                	mov    %eax,%ebx
    1471:	50                   	push   %eax
    1472:	e8 f4 00 00 00       	call   156b <fstat>
    1477:	89 1c 24             	mov    %ebx,(%esp)
    147a:	89 c6                	mov    %eax,%esi
    147c:	e8 ba 00 00 00       	call   153b <close>
    1481:	83 c4 10             	add    $0x10,%esp
    1484:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1487:	89 f0                	mov    %esi,%eax
    1489:	5b                   	pop    %ebx
    148a:	5e                   	pop    %esi
    148b:	5d                   	pop    %ebp
    148c:	c3                   	ret
    148d:	8d 76 00             	lea    0x0(%esi),%esi
    1490:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1495:	eb ed                	jmp    1484 <stat+0x34>
    1497:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    149e:	00 
    149f:	90                   	nop

000014a0 <atoi>:
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    14a3:	53                   	push   %ebx
    14a4:	8b 55 08             	mov    0x8(%ebp),%edx
    14a7:	0f be 02             	movsbl (%edx),%eax
    14aa:	8d 48 d0             	lea    -0x30(%eax),%ecx
    14ad:	80 f9 09             	cmp    $0x9,%cl
    14b0:	b9 00 00 00 00       	mov    $0x0,%ecx
    14b5:	77 1e                	ja     14d5 <atoi+0x35>
    14b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    14be:	00 
    14bf:	90                   	nop
    14c0:	83 c2 01             	add    $0x1,%edx
    14c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    14c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
    14ca:	0f be 02             	movsbl (%edx),%eax
    14cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
    14d0:	80 fb 09             	cmp    $0x9,%bl
    14d3:	76 eb                	jbe    14c0 <atoi+0x20>
    14d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14d8:	89 c8                	mov    %ecx,%eax
    14da:	c9                   	leave
    14db:	c3                   	ret
    14dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000014e0 <memmove>:
    14e0:	55                   	push   %ebp
    14e1:	89 e5                	mov    %esp,%ebp
    14e3:	57                   	push   %edi
    14e4:	8b 45 10             	mov    0x10(%ebp),%eax
    14e7:	8b 55 08             	mov    0x8(%ebp),%edx
    14ea:	56                   	push   %esi
    14eb:	8b 75 0c             	mov    0xc(%ebp),%esi
    14ee:	85 c0                	test   %eax,%eax
    14f0:	7e 13                	jle    1505 <memmove+0x25>
    14f2:	01 d0                	add    %edx,%eax
    14f4:	89 d7                	mov    %edx,%edi
    14f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    14fd:	00 
    14fe:	66 90                	xchg   %ax,%ax
    1500:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    1501:	39 f8                	cmp    %edi,%eax
    1503:	75 fb                	jne    1500 <memmove+0x20>
    1505:	5e                   	pop    %esi
    1506:	89 d0                	mov    %edx,%eax
    1508:	5f                   	pop    %edi
    1509:	5d                   	pop    %ebp
    150a:	c3                   	ret

0000150b <fork>:
    150b:	b8 01 00 00 00       	mov    $0x1,%eax
    1510:	cd 40                	int    $0x40
    1512:	c3                   	ret

00001513 <exit>:
    1513:	b8 02 00 00 00       	mov    $0x2,%eax
    1518:	cd 40                	int    $0x40
    151a:	c3                   	ret

0000151b <wait>:
    151b:	b8 03 00 00 00       	mov    $0x3,%eax
    1520:	cd 40                	int    $0x40
    1522:	c3                   	ret

00001523 <pipe>:
    1523:	b8 04 00 00 00       	mov    $0x4,%eax
    1528:	cd 40                	int    $0x40
    152a:	c3                   	ret

0000152b <read>:
    152b:	b8 05 00 00 00       	mov    $0x5,%eax
    1530:	cd 40                	int    $0x40
    1532:	c3                   	ret

00001533 <write>:
    1533:	b8 10 00 00 00       	mov    $0x10,%eax
    1538:	cd 40                	int    $0x40
    153a:	c3                   	ret

0000153b <close>:
    153b:	b8 15 00 00 00       	mov    $0x15,%eax
    1540:	cd 40                	int    $0x40
    1542:	c3                   	ret

00001543 <kill>:
    1543:	b8 06 00 00 00       	mov    $0x6,%eax
    1548:	cd 40                	int    $0x40
    154a:	c3                   	ret

0000154b <exec>:
    154b:	b8 07 00 00 00       	mov    $0x7,%eax
    1550:	cd 40                	int    $0x40
    1552:	c3                   	ret

00001553 <open>:
    1553:	b8 0f 00 00 00       	mov    $0xf,%eax
    1558:	cd 40                	int    $0x40
    155a:	c3                   	ret

0000155b <mknod>:
    155b:	b8 11 00 00 00       	mov    $0x11,%eax
    1560:	cd 40                	int    $0x40
    1562:	c3                   	ret

00001563 <unlink>:
    1563:	b8 12 00 00 00       	mov    $0x12,%eax
    1568:	cd 40                	int    $0x40
    156a:	c3                   	ret

0000156b <fstat>:
    156b:	b8 08 00 00 00       	mov    $0x8,%eax
    1570:	cd 40                	int    $0x40
    1572:	c3                   	ret

00001573 <link>:
    1573:	b8 13 00 00 00       	mov    $0x13,%eax
    1578:	cd 40                	int    $0x40
    157a:	c3                   	ret

0000157b <mkdir>:
    157b:	b8 14 00 00 00       	mov    $0x14,%eax
    1580:	cd 40                	int    $0x40
    1582:	c3                   	ret

00001583 <chdir>:
    1583:	b8 09 00 00 00       	mov    $0x9,%eax
    1588:	cd 40                	int    $0x40
    158a:	c3                   	ret

0000158b <dup>:
    158b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1590:	cd 40                	int    $0x40
    1592:	c3                   	ret

00001593 <getpid>:
    1593:	b8 0b 00 00 00       	mov    $0xb,%eax
    1598:	cd 40                	int    $0x40
    159a:	c3                   	ret

0000159b <sbrk>:
    159b:	b8 0c 00 00 00       	mov    $0xc,%eax
    15a0:	cd 40                	int    $0x40
    15a2:	c3                   	ret

000015a3 <sleep>:
    15a3:	b8 0d 00 00 00       	mov    $0xd,%eax
    15a8:	cd 40                	int    $0x40
    15aa:	c3                   	ret

000015ab <uptime>:
    15ab:	b8 0e 00 00 00       	mov    $0xe,%eax
    15b0:	cd 40                	int    $0x40
    15b2:	c3                   	ret
    15b3:	66 90                	xchg   %ax,%ax
    15b5:	66 90                	xchg   %ax,%ax
    15b7:	66 90                	xchg   %ax,%ax
    15b9:	66 90                	xchg   %ax,%ax
    15bb:	66 90                	xchg   %ax,%ax
    15bd:	66 90                	xchg   %ax,%ax
    15bf:	90                   	nop

000015c0 <printint>:
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	57                   	push   %edi
    15c4:	56                   	push   %esi
    15c5:	53                   	push   %ebx
    15c6:	89 cb                	mov    %ecx,%ebx
    15c8:	89 d1                	mov    %edx,%ecx
    15ca:	83 ec 3c             	sub    $0x3c,%esp
    15cd:	89 45 c0             	mov    %eax,-0x40(%ebp)
    15d0:	85 d2                	test   %edx,%edx
    15d2:	0f 89 80 00 00 00    	jns    1658 <printint+0x98>
    15d8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    15dc:	74 7a                	je     1658 <printint+0x98>
    15de:	f7 d9                	neg    %ecx
    15e0:	b8 01 00 00 00       	mov    $0x1,%eax
    15e5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    15e8:	31 f6                	xor    %esi,%esi
    15ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    15f0:	89 c8                	mov    %ecx,%eax
    15f2:	31 d2                	xor    %edx,%edx
    15f4:	89 f7                	mov    %esi,%edi
    15f6:	f7 f3                	div    %ebx
    15f8:	8d 76 01             	lea    0x1(%esi),%esi
    15fb:	0f b6 92 14 1b 00 00 	movzbl 0x1b14(%edx),%edx
    1602:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
    1606:	89 ca                	mov    %ecx,%edx
    1608:	89 c1                	mov    %eax,%ecx
    160a:	39 da                	cmp    %ebx,%edx
    160c:	73 e2                	jae    15f0 <printint+0x30>
    160e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1611:	85 c0                	test   %eax,%eax
    1613:	74 07                	je     161c <printint+0x5c>
    1615:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    161a:	89 f7                	mov    %esi,%edi
    161c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    161f:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1622:	01 df                	add    %ebx,%edi
    1624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1628:	0f b6 07             	movzbl (%edi),%eax
    162b:	83 ec 04             	sub    $0x4,%esp
    162e:	88 45 d7             	mov    %al,-0x29(%ebp)
    1631:	8d 45 d7             	lea    -0x29(%ebp),%eax
    1634:	6a 01                	push   $0x1
    1636:	50                   	push   %eax
    1637:	56                   	push   %esi
    1638:	e8 f6 fe ff ff       	call   1533 <write>
    163d:	89 f8                	mov    %edi,%eax
    163f:	83 c4 10             	add    $0x10,%esp
    1642:	83 ef 01             	sub    $0x1,%edi
    1645:	39 c3                	cmp    %eax,%ebx
    1647:	75 df                	jne    1628 <printint+0x68>
    1649:	8d 65 f4             	lea    -0xc(%ebp),%esp
    164c:	5b                   	pop    %ebx
    164d:	5e                   	pop    %esi
    164e:	5f                   	pop    %edi
    164f:	5d                   	pop    %ebp
    1650:	c3                   	ret
    1651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1658:	31 c0                	xor    %eax,%eax
    165a:	eb 89                	jmp    15e5 <printint+0x25>
    165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001660 <printf>:
    1660:	55                   	push   %ebp
    1661:	89 e5                	mov    %esp,%ebp
    1663:	57                   	push   %edi
    1664:	56                   	push   %esi
    1665:	53                   	push   %ebx
    1666:	83 ec 2c             	sub    $0x2c,%esp
    1669:	8b 75 0c             	mov    0xc(%ebp),%esi
    166c:	8b 7d 08             	mov    0x8(%ebp),%edi
    166f:	0f b6 1e             	movzbl (%esi),%ebx
    1672:	83 c6 01             	add    $0x1,%esi
    1675:	84 db                	test   %bl,%bl
    1677:	74 67                	je     16e0 <printf+0x80>
    1679:	8d 4d 10             	lea    0x10(%ebp),%ecx
    167c:	31 d2                	xor    %edx,%edx
    167e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1681:	eb 34                	jmp    16b7 <printf+0x57>
    1683:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1688:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    168b:	ba 25 00 00 00       	mov    $0x25,%edx
    1690:	83 f8 25             	cmp    $0x25,%eax
    1693:	74 18                	je     16ad <printf+0x4d>
    1695:	83 ec 04             	sub    $0x4,%esp
    1698:	8d 45 e7             	lea    -0x19(%ebp),%eax
    169b:	88 5d e7             	mov    %bl,-0x19(%ebp)
    169e:	6a 01                	push   $0x1
    16a0:	50                   	push   %eax
    16a1:	57                   	push   %edi
    16a2:	e8 8c fe ff ff       	call   1533 <write>
    16a7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    16aa:	83 c4 10             	add    $0x10,%esp
    16ad:	0f b6 1e             	movzbl (%esi),%ebx
    16b0:	83 c6 01             	add    $0x1,%esi
    16b3:	84 db                	test   %bl,%bl
    16b5:	74 29                	je     16e0 <printf+0x80>
    16b7:	0f b6 c3             	movzbl %bl,%eax
    16ba:	85 d2                	test   %edx,%edx
    16bc:	74 ca                	je     1688 <printf+0x28>
    16be:	83 fa 25             	cmp    $0x25,%edx
    16c1:	75 ea                	jne    16ad <printf+0x4d>
    16c3:	83 f8 25             	cmp    $0x25,%eax
    16c6:	0f 84 04 01 00 00    	je     17d0 <printf+0x170>
    16cc:	83 e8 63             	sub    $0x63,%eax
    16cf:	83 f8 15             	cmp    $0x15,%eax
    16d2:	77 1c                	ja     16f0 <printf+0x90>
    16d4:	ff 24 85 bc 1a 00 00 	jmp    *0x1abc(,%eax,4)
    16db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    16e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16e3:	5b                   	pop    %ebx
    16e4:	5e                   	pop    %esi
    16e5:	5f                   	pop    %edi
    16e6:	5d                   	pop    %ebp
    16e7:	c3                   	ret
    16e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    16ef:	00 
    16f0:	83 ec 04             	sub    $0x4,%esp
    16f3:	8d 55 e7             	lea    -0x19(%ebp),%edx
    16f6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    16fa:	6a 01                	push   $0x1
    16fc:	52                   	push   %edx
    16fd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    1700:	57                   	push   %edi
    1701:	e8 2d fe ff ff       	call   1533 <write>
    1706:	83 c4 0c             	add    $0xc,%esp
    1709:	88 5d e7             	mov    %bl,-0x19(%ebp)
    170c:	6a 01                	push   $0x1
    170e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1711:	52                   	push   %edx
    1712:	57                   	push   %edi
    1713:	e8 1b fe ff ff       	call   1533 <write>
    1718:	83 c4 10             	add    $0x10,%esp
    171b:	31 d2                	xor    %edx,%edx
    171d:	eb 8e                	jmp    16ad <printf+0x4d>
    171f:	90                   	nop
    1720:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1723:	83 ec 0c             	sub    $0xc,%esp
    1726:	b9 10 00 00 00       	mov    $0x10,%ecx
    172b:	8b 13                	mov    (%ebx),%edx
    172d:	6a 00                	push   $0x0
    172f:	89 f8                	mov    %edi,%eax
    1731:	83 c3 04             	add    $0x4,%ebx
    1734:	e8 87 fe ff ff       	call   15c0 <printint>
    1739:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    173c:	83 c4 10             	add    $0x10,%esp
    173f:	31 d2                	xor    %edx,%edx
    1741:	e9 67 ff ff ff       	jmp    16ad <printf+0x4d>
    1746:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1749:	8b 18                	mov    (%eax),%ebx
    174b:	83 c0 04             	add    $0x4,%eax
    174e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1751:	85 db                	test   %ebx,%ebx
    1753:	0f 84 87 00 00 00    	je     17e0 <printf+0x180>
    1759:	0f b6 03             	movzbl (%ebx),%eax
    175c:	31 d2                	xor    %edx,%edx
    175e:	84 c0                	test   %al,%al
    1760:	0f 84 47 ff ff ff    	je     16ad <printf+0x4d>
    1766:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1769:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    176c:	89 de                	mov    %ebx,%esi
    176e:	89 d3                	mov    %edx,%ebx
    1770:	83 ec 04             	sub    $0x4,%esp
    1773:	88 45 e7             	mov    %al,-0x19(%ebp)
    1776:	83 c6 01             	add    $0x1,%esi
    1779:	6a 01                	push   $0x1
    177b:	53                   	push   %ebx
    177c:	57                   	push   %edi
    177d:	e8 b1 fd ff ff       	call   1533 <write>
    1782:	0f b6 06             	movzbl (%esi),%eax
    1785:	83 c4 10             	add    $0x10,%esp
    1788:	84 c0                	test   %al,%al
    178a:	75 e4                	jne    1770 <printf+0x110>
    178c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    178f:	31 d2                	xor    %edx,%edx
    1791:	e9 17 ff ff ff       	jmp    16ad <printf+0x4d>
    1796:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1799:	83 ec 0c             	sub    $0xc,%esp
    179c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    17a1:	8b 13                	mov    (%ebx),%edx
    17a3:	6a 01                	push   $0x1
    17a5:	eb 88                	jmp    172f <printf+0xcf>
    17a7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    17aa:	83 ec 04             	sub    $0x4,%esp
    17ad:	8d 55 e7             	lea    -0x19(%ebp),%edx
    17b0:	8b 03                	mov    (%ebx),%eax
    17b2:	83 c3 04             	add    $0x4,%ebx
    17b5:	88 45 e7             	mov    %al,-0x19(%ebp)
    17b8:	6a 01                	push   $0x1
    17ba:	52                   	push   %edx
    17bb:	57                   	push   %edi
    17bc:	e8 72 fd ff ff       	call   1533 <write>
    17c1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    17c4:	83 c4 10             	add    $0x10,%esp
    17c7:	31 d2                	xor    %edx,%edx
    17c9:	e9 df fe ff ff       	jmp    16ad <printf+0x4d>
    17ce:	66 90                	xchg   %ax,%ax
    17d0:	83 ec 04             	sub    $0x4,%esp
    17d3:	88 5d e7             	mov    %bl,-0x19(%ebp)
    17d6:	8d 55 e7             	lea    -0x19(%ebp),%edx
    17d9:	6a 01                	push   $0x1
    17db:	e9 31 ff ff ff       	jmp    1711 <printf+0xb1>
    17e0:	b8 28 00 00 00       	mov    $0x28,%eax
    17e5:	bb 83 1a 00 00       	mov    $0x1a83,%ebx
    17ea:	e9 77 ff ff ff       	jmp    1766 <printf+0x106>
    17ef:	90                   	nop

000017f0 <free>:
    17f0:	55                   	push   %ebp
    17f1:	a1 c4 22 00 00       	mov    0x22c4,%eax
    17f6:	89 e5                	mov    %esp,%ebp
    17f8:	57                   	push   %edi
    17f9:	56                   	push   %esi
    17fa:	53                   	push   %ebx
    17fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    17fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1808:	8b 10                	mov    (%eax),%edx
    180a:	39 c8                	cmp    %ecx,%eax
    180c:	73 32                	jae    1840 <free+0x50>
    180e:	39 d1                	cmp    %edx,%ecx
    1810:	72 04                	jb     1816 <free+0x26>
    1812:	39 d0                	cmp    %edx,%eax
    1814:	72 32                	jb     1848 <free+0x58>
    1816:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1819:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    181c:	39 fa                	cmp    %edi,%edx
    181e:	74 30                	je     1850 <free+0x60>
    1820:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1823:	8b 50 04             	mov    0x4(%eax),%edx
    1826:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1829:	39 f1                	cmp    %esi,%ecx
    182b:	74 3a                	je     1867 <free+0x77>
    182d:	89 08                	mov    %ecx,(%eax)
    182f:	5b                   	pop    %ebx
    1830:	a3 c4 22 00 00       	mov    %eax,0x22c4
    1835:	5e                   	pop    %esi
    1836:	5f                   	pop    %edi
    1837:	5d                   	pop    %ebp
    1838:	c3                   	ret
    1839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1840:	39 d0                	cmp    %edx,%eax
    1842:	72 04                	jb     1848 <free+0x58>
    1844:	39 d1                	cmp    %edx,%ecx
    1846:	72 ce                	jb     1816 <free+0x26>
    1848:	89 d0                	mov    %edx,%eax
    184a:	eb bc                	jmp    1808 <free+0x18>
    184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1850:	03 72 04             	add    0x4(%edx),%esi
    1853:	89 73 fc             	mov    %esi,-0x4(%ebx)
    1856:	8b 10                	mov    (%eax),%edx
    1858:	8b 12                	mov    (%edx),%edx
    185a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    185d:	8b 50 04             	mov    0x4(%eax),%edx
    1860:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1863:	39 f1                	cmp    %esi,%ecx
    1865:	75 c6                	jne    182d <free+0x3d>
    1867:	03 53 fc             	add    -0x4(%ebx),%edx
    186a:	a3 c4 22 00 00       	mov    %eax,0x22c4
    186f:	89 50 04             	mov    %edx,0x4(%eax)
    1872:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1875:	89 08                	mov    %ecx,(%eax)
    1877:	5b                   	pop    %ebx
    1878:	5e                   	pop    %esi
    1879:	5f                   	pop    %edi
    187a:	5d                   	pop    %ebp
    187b:	c3                   	ret
    187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001880 <malloc>:
    1880:	55                   	push   %ebp
    1881:	89 e5                	mov    %esp,%ebp
    1883:	57                   	push   %edi
    1884:	56                   	push   %esi
    1885:	53                   	push   %ebx
    1886:	83 ec 0c             	sub    $0xc,%esp
    1889:	8b 45 08             	mov    0x8(%ebp),%eax
    188c:	8b 15 c4 22 00 00    	mov    0x22c4,%edx
    1892:	8d 78 07             	lea    0x7(%eax),%edi
    1895:	c1 ef 03             	shr    $0x3,%edi
    1898:	83 c7 01             	add    $0x1,%edi
    189b:	85 d2                	test   %edx,%edx
    189d:	0f 84 8d 00 00 00    	je     1930 <malloc+0xb0>
    18a3:	8b 02                	mov    (%edx),%eax
    18a5:	8b 48 04             	mov    0x4(%eax),%ecx
    18a8:	39 f9                	cmp    %edi,%ecx
    18aa:	73 64                	jae    1910 <malloc+0x90>
    18ac:	bb 00 10 00 00       	mov    $0x1000,%ebx
    18b1:	39 df                	cmp    %ebx,%edi
    18b3:	0f 43 df             	cmovae %edi,%ebx
    18b6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    18bd:	eb 0a                	jmp    18c9 <malloc+0x49>
    18bf:	90                   	nop
    18c0:	8b 02                	mov    (%edx),%eax
    18c2:	8b 48 04             	mov    0x4(%eax),%ecx
    18c5:	39 f9                	cmp    %edi,%ecx
    18c7:	73 47                	jae    1910 <malloc+0x90>
    18c9:	89 c2                	mov    %eax,%edx
    18cb:	3b 05 c4 22 00 00    	cmp    0x22c4,%eax
    18d1:	75 ed                	jne    18c0 <malloc+0x40>
    18d3:	83 ec 0c             	sub    $0xc,%esp
    18d6:	56                   	push   %esi
    18d7:	e8 bf fc ff ff       	call   159b <sbrk>
    18dc:	83 c4 10             	add    $0x10,%esp
    18df:	83 f8 ff             	cmp    $0xffffffff,%eax
    18e2:	74 1c                	je     1900 <malloc+0x80>
    18e4:	89 58 04             	mov    %ebx,0x4(%eax)
    18e7:	83 ec 0c             	sub    $0xc,%esp
    18ea:	83 c0 08             	add    $0x8,%eax
    18ed:	50                   	push   %eax
    18ee:	e8 fd fe ff ff       	call   17f0 <free>
    18f3:	8b 15 c4 22 00 00    	mov    0x22c4,%edx
    18f9:	83 c4 10             	add    $0x10,%esp
    18fc:	85 d2                	test   %edx,%edx
    18fe:	75 c0                	jne    18c0 <malloc+0x40>
    1900:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1903:	31 c0                	xor    %eax,%eax
    1905:	5b                   	pop    %ebx
    1906:	5e                   	pop    %esi
    1907:	5f                   	pop    %edi
    1908:	5d                   	pop    %ebp
    1909:	c3                   	ret
    190a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1910:	39 cf                	cmp    %ecx,%edi
    1912:	74 4c                	je     1960 <malloc+0xe0>
    1914:	29 f9                	sub    %edi,%ecx
    1916:	89 48 04             	mov    %ecx,0x4(%eax)
    1919:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
    191c:	89 78 04             	mov    %edi,0x4(%eax)
    191f:	89 15 c4 22 00 00    	mov    %edx,0x22c4
    1925:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1928:	83 c0 08             	add    $0x8,%eax
    192b:	5b                   	pop    %ebx
    192c:	5e                   	pop    %esi
    192d:	5f                   	pop    %edi
    192e:	5d                   	pop    %ebp
    192f:	c3                   	ret
    1930:	c7 05 c4 22 00 00 c8 	movl   $0x22c8,0x22c4
    1937:	22 00 00 
    193a:	b8 c8 22 00 00       	mov    $0x22c8,%eax
    193f:	c7 05 c8 22 00 00 c8 	movl   $0x22c8,0x22c8
    1946:	22 00 00 
    1949:	c7 05 cc 22 00 00 00 	movl   $0x0,0x22cc
    1950:	00 00 00 
    1953:	e9 54 ff ff ff       	jmp    18ac <malloc+0x2c>
    1958:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    195f:	00 
    1960:	8b 08                	mov    (%eax),%ecx
    1962:	89 0a                	mov    %ecx,(%edx)
    1964:	eb b9                	jmp    191f <malloc+0x9f>
