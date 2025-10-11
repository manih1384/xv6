
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 98 07 00 00       	push   $0x798
  19:	e8 65 03 00 00       	call   383 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 af 00 00 00    	js     d8 <main+0xd8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 88 03 00 00       	call   3bb <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 7c 03 00 00       	call   3bb <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 a0 07 00 00       	push   $0x7a0
  50:	6a 01                	push   $0x1
  52:	e8 39 04 00 00       	call   490 <printf>
    pid = fork();
  57:	e8 df 02 00 00       	call   33b <fork>
    if(pid < 0){
  5c:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  5f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  61:	85 c0                	test   %eax,%eax
  63:	78 3c                	js     a1 <main+0xa1>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  65:	74 4d                	je     b4 <main+0xb4>
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    printf(1, "Hamid, Mani, SHAYAN\n"); // edited
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 df 07 00 00       	push   $0x7df
  6f:	6a 01                	push   $0x1
  71:	e8 1a 04 00 00       	call   490 <printf>
    while((wpid=wait()) >= 0 && wpid != pid)
  76:	83 c4 10             	add    $0x10,%esp
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  80:	e8 c6 02 00 00       	call   34b <wait>
  85:	85 c0                	test   %eax,%eax
  87:	78 bf                	js     48 <main+0x48>
  89:	39 c3                	cmp    %eax,%ebx
  8b:	74 bb                	je     48 <main+0x48>
      printf(1, "zombie!\n");
  8d:	83 ec 08             	sub    $0x8,%esp
  90:	68 f4 07 00 00       	push   $0x7f4
  95:	6a 01                	push   $0x1
  97:	e8 f4 03 00 00       	call   490 <printf>
  9c:	83 c4 10             	add    $0x10,%esp
  9f:	eb df                	jmp    80 <main+0x80>
      printf(1, "init: fork failed\n");
  a1:	53                   	push   %ebx
  a2:	53                   	push   %ebx
  a3:	68 b3 07 00 00       	push   $0x7b3
  a8:	6a 01                	push   $0x1
  aa:	e8 e1 03 00 00       	call   490 <printf>
      exit();
  af:	e8 8f 02 00 00       	call   343 <exit>
      exec("sh", argv);
  b4:	50                   	push   %eax
  b5:	50                   	push   %eax
  b6:	68 fc 0a 00 00       	push   $0xafc
  bb:	68 c6 07 00 00       	push   $0x7c6
  c0:	e8 b6 02 00 00       	call   37b <exec>
      printf(1, "init: exec sh failed\n");
  c5:	5a                   	pop    %edx
  c6:	59                   	pop    %ecx
  c7:	68 c9 07 00 00       	push   $0x7c9
  cc:	6a 01                	push   $0x1
  ce:	e8 bd 03 00 00       	call   490 <printf>
      exit();
  d3:	e8 6b 02 00 00       	call   343 <exit>
    mknod("console", 1, 1);
  d8:	50                   	push   %eax
  d9:	6a 01                	push   $0x1
  db:	6a 01                	push   $0x1
  dd:	68 98 07 00 00       	push   $0x798
  e2:	e8 a4 02 00 00       	call   38b <mknod>
    open("console", O_RDWR);
  e7:	58                   	pop    %eax
  e8:	5a                   	pop    %edx
  e9:	6a 02                	push   $0x2
  eb:	68 98 07 00 00       	push   $0x798
  f0:	e8 8e 02 00 00       	call   383 <open>
  f5:	83 c4 10             	add    $0x10,%esp
  f8:	e9 2c ff ff ff       	jmp    29 <main+0x29>
  fd:	66 90                	xchg   %ax,%ax
  ff:	90                   	nop

00000100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 100:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 101:	31 c0                	xor    %eax,%eax
{
 103:	89 e5                	mov    %esp,%ebp
 105:	53                   	push   %ebx
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 110:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 114:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 117:	83 c0 01             	add    $0x1,%eax
 11a:	84 d2                	test   %dl,%dl
 11c:	75 f2                	jne    110 <strcpy+0x10>
    ;
  return os;
}
 11e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 121:	89 c8                	mov    %ecx,%eax
 123:	c9                   	leave
 124:	c3                   	ret
 125:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12c:	00 
 12d:	8d 76 00             	lea    0x0(%esi),%esi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	75 17                	jne    158 <strcmp+0x28>
 141:	eb 3a                	jmp    17d <strcmp+0x4d>
 143:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 148:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 14c:	83 c2 01             	add    $0x1,%edx
 14f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 152:	84 c0                	test   %al,%al
 154:	74 1a                	je     170 <strcmp+0x40>
 156:	89 d9                	mov    %ebx,%ecx
 158:	0f b6 19             	movzbl (%ecx),%ebx
 15b:	38 c3                	cmp    %al,%bl
 15d:	74 e9                	je     148 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 15f:	29 d8                	sub    %ebx,%eax
}
 161:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 164:	c9                   	leave
 165:	c3                   	ret
 166:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16d:	00 
 16e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 170:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 174:	31 c0                	xor    %eax,%eax
 176:	29 d8                	sub    %ebx,%eax
}
 178:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 17b:	c9                   	leave
 17c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 17d:	0f b6 19             	movzbl (%ecx),%ebx
 180:	31 c0                	xor    %eax,%eax
 182:	eb db                	jmp    15f <strcmp+0x2f>
 184:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18b:	00 
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <strlen>:

uint
strlen(const char *s)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 196:	80 3a 00             	cmpb   $0x0,(%edx)
 199:	74 15                	je     1b0 <strlen+0x20>
 19b:	31 c0                	xor    %eax,%eax
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	83 c0 01             	add    $0x1,%eax
 1a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1a7:	89 c1                	mov    %eax,%ecx
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	89 c8                	mov    %ecx,%eax
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret
 1af:	90                   	nop
  for(n = 0; s[n]; n++)
 1b0:	31 c9                	xor    %ecx,%ecx
}
 1b2:	5d                   	pop    %ebp
 1b3:	89 c8                	mov    %ecx,%eax
 1b5:	c3                   	ret
 1b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bd:	00 
 1be:	66 90                	xchg   %ax,%ax

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1d5:	89 d0                	mov    %edx,%eax
 1d7:	c9                   	leave
 1d8:	c3                   	ret
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	75 12                	jne    203 <strchr+0x23>
 1f1:	eb 1d                	jmp    210 <strchr+0x30>
 1f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1f8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1fc:	83 c0 01             	add    $0x1,%eax
 1ff:	84 d2                	test   %dl,%dl
 201:	74 0d                	je     210 <strchr+0x30>
    if(*s == c)
 203:	38 d1                	cmp    %dl,%cl
 205:	75 f1                	jne    1f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 207:	5d                   	pop    %ebp
 208:	c3                   	ret
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 210:	31 c0                	xor    %eax,%eax
}
 212:	5d                   	pop    %ebp
 213:	c3                   	ret
 214:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21b:	00 
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 225:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 228:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 229:	31 db                	xor    %ebx,%ebx
{
 22b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 22e:	eb 27                	jmp    257 <gets+0x37>
    cc = read(0, &c, 1);
 230:	83 ec 04             	sub    $0x4,%esp
 233:	6a 01                	push   $0x1
 235:	56                   	push   %esi
 236:	6a 00                	push   $0x0
 238:	e8 1e 01 00 00       	call   35b <read>
    if(cc < 1)
 23d:	83 c4 10             	add    $0x10,%esp
 240:	85 c0                	test   %eax,%eax
 242:	7e 1d                	jle    261 <gets+0x41>
      break;
    buf[i++] = c;
 244:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 248:	8b 55 08             	mov    0x8(%ebp),%edx
 24b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 24f:	3c 0a                	cmp    $0xa,%al
 251:	74 10                	je     263 <gets+0x43>
 253:	3c 0d                	cmp    $0xd,%al
 255:	74 0c                	je     263 <gets+0x43>
  for(i=0; i+1 < max; ){
 257:	89 df                	mov    %ebx,%edi
 259:	83 c3 01             	add    $0x1,%ebx
 25c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 25f:	7c cf                	jl     230 <gets+0x10>
 261:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 26a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 26d:	5b                   	pop    %ebx
 26e:	5e                   	pop    %esi
 26f:	5f                   	pop    %edi
 270:	5d                   	pop    %ebp
 271:	c3                   	ret
 272:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 279:	00 
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000280 <stat>:

int
stat(const char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 285:	83 ec 08             	sub    $0x8,%esp
 288:	6a 00                	push   $0x0
 28a:	ff 75 08             	push   0x8(%ebp)
 28d:	e8 f1 00 00 00       	call   383 <open>
  if(fd < 0)
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 27                	js     2c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	push   0xc(%ebp)
 29f:	89 c3                	mov    %eax,%ebx
 2a1:	50                   	push   %eax
 2a2:	e8 f4 00 00 00       	call   39b <fstat>
  close(fd);
 2a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2aa:	89 c6                	mov    %eax,%esi
  close(fd);
 2ac:	e8 ba 00 00 00       	call   36b <close>
  return r;
 2b1:	83 c4 10             	add    $0x10,%esp
}
 2b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b7:	89 f0                	mov    %esi,%eax
 2b9:	5b                   	pop    %ebx
 2ba:	5e                   	pop    %esi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb ed                	jmp    2b4 <stat+0x34>
 2c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ce:	00 
 2cf:	90                   	nop

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 02             	movsbl (%edx),%eax
 2da:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2dd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2e0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2e5:	77 1e                	ja     305 <atoi+0x35>
 2e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ee:	00 
 2ef:	90                   	nop
    n = n*10 + *s++ - '0';
 2f0:	83 c2 01             	add    $0x1,%edx
 2f3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2f6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2fa:	0f be 02             	movsbl (%edx),%eax
 2fd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
  return n;
}
 305:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 308:	89 c8                	mov    %ecx,%eax
 30a:	c9                   	leave
 30b:	c3                   	ret
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	8b 45 10             	mov    0x10(%ebp),%eax
 317:	8b 55 08             	mov    0x8(%ebp),%edx
 31a:	56                   	push   %esi
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	85 c0                	test   %eax,%eax
 320:	7e 13                	jle    335 <memmove+0x25>
 322:	01 d0                	add    %edx,%eax
  dst = vdst;
 324:	89 d7                	mov    %edx,%edi
 326:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 32d:	00 
 32e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 330:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 331:	39 f8                	cmp    %edi,%eax
 333:	75 fb                	jne    330 <memmove+0x20>
  return vdst;
}
 335:	5e                   	pop    %esi
 336:	89 d0                	mov    %edx,%eax
 338:	5f                   	pop    %edi
 339:	5d                   	pop    %ebp
 33a:	c3                   	ret

0000033b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33b:	b8 01 00 00 00       	mov    $0x1,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <exit>:
SYSCALL(exit)
 343:	b8 02 00 00 00       	mov    $0x2,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <wait>:
SYSCALL(wait)
 34b:	b8 03 00 00 00       	mov    $0x3,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <pipe>:
SYSCALL(pipe)
 353:	b8 04 00 00 00       	mov    $0x4,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <read>:
SYSCALL(read)
 35b:	b8 05 00 00 00       	mov    $0x5,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <write>:
SYSCALL(write)
 363:	b8 10 00 00 00       	mov    $0x10,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <close>:
SYSCALL(close)
 36b:	b8 15 00 00 00       	mov    $0x15,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <kill>:
SYSCALL(kill)
 373:	b8 06 00 00 00       	mov    $0x6,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <exec>:
SYSCALL(exec)
 37b:	b8 07 00 00 00       	mov    $0x7,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <open>:
SYSCALL(open)
 383:	b8 0f 00 00 00       	mov    $0xf,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <mknod>:
SYSCALL(mknod)
 38b:	b8 11 00 00 00       	mov    $0x11,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <unlink>:
SYSCALL(unlink)
 393:	b8 12 00 00 00       	mov    $0x12,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <fstat>:
SYSCALL(fstat)
 39b:	b8 08 00 00 00       	mov    $0x8,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <link>:
SYSCALL(link)
 3a3:	b8 13 00 00 00       	mov    $0x13,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <mkdir>:
SYSCALL(mkdir)
 3ab:	b8 14 00 00 00       	mov    $0x14,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <chdir>:
SYSCALL(chdir)
 3b3:	b8 09 00 00 00       	mov    $0x9,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <dup>:
SYSCALL(dup)
 3bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <getpid>:
SYSCALL(getpid)
 3c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <sbrk>:
SYSCALL(sbrk)
 3cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <sleep>:
SYSCALL(sleep)
 3d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <uptime>:
SYSCALL(uptime)
 3db:	b8 0e 00 00 00       	mov    $0xe,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret
 3e3:	66 90                	xchg   %ax,%ax
 3e5:	66 90                	xchg   %ax,%ax
 3e7:	66 90                	xchg   %ax,%ax
 3e9:	66 90                	xchg   %ax,%ax
 3eb:	66 90                	xchg   %ax,%ax
 3ed:	66 90                	xchg   %ax,%ax
 3ef:	90                   	nop

000003f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3f8:	89 d1                	mov    %edx,%ecx
{
 3fa:	83 ec 3c             	sub    $0x3c,%esp
 3fd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 400:	85 d2                	test   %edx,%edx
 402:	0f 89 80 00 00 00    	jns    488 <printint+0x98>
 408:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 40c:	74 7a                	je     488 <printint+0x98>
    x = -xx;
 40e:	f7 d9                	neg    %ecx
    neg = 1;
 410:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 415:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 418:	31 f6                	xor    %esi,%esi
 41a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 420:	89 c8                	mov    %ecx,%eax
 422:	31 d2                	xor    %edx,%edx
 424:	89 f7                	mov    %esi,%edi
 426:	f7 f3                	div    %ebx
 428:	8d 76 01             	lea    0x1(%esi),%esi
 42b:	0f b6 92 5c 08 00 00 	movzbl 0x85c(%edx),%edx
 432:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 436:	89 ca                	mov    %ecx,%edx
 438:	89 c1                	mov    %eax,%ecx
 43a:	39 da                	cmp    %ebx,%edx
 43c:	73 e2                	jae    420 <printint+0x30>
  if(neg)
 43e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 441:	85 c0                	test   %eax,%eax
 443:	74 07                	je     44c <printint+0x5c>
    buf[i++] = '-';
 445:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 44a:	89 f7                	mov    %esi,%edi
 44c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 44f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 452:	01 df                	add    %ebx,%edi
 454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 458:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 45b:	83 ec 04             	sub    $0x4,%esp
 45e:	88 45 d7             	mov    %al,-0x29(%ebp)
 461:	8d 45 d7             	lea    -0x29(%ebp),%eax
 464:	6a 01                	push   $0x1
 466:	50                   	push   %eax
 467:	56                   	push   %esi
 468:	e8 f6 fe ff ff       	call   363 <write>
  while(--i >= 0)
 46d:	89 f8                	mov    %edi,%eax
 46f:	83 c4 10             	add    $0x10,%esp
 472:	83 ef 01             	sub    $0x1,%edi
 475:	39 c3                	cmp    %eax,%ebx
 477:	75 df                	jne    458 <printint+0x68>
}
 479:	8d 65 f4             	lea    -0xc(%ebp),%esp
 47c:	5b                   	pop    %ebx
 47d:	5e                   	pop    %esi
 47e:	5f                   	pop    %edi
 47f:	5d                   	pop    %ebp
 480:	c3                   	ret
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 488:	31 c0                	xor    %eax,%eax
 48a:	eb 89                	jmp    415 <printint+0x25>
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 499:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 49c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 49f:	0f b6 1e             	movzbl (%esi),%ebx
 4a2:	83 c6 01             	add    $0x1,%esi
 4a5:	84 db                	test   %bl,%bl
 4a7:	74 67                	je     510 <printf+0x80>
 4a9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4ac:	31 d2                	xor    %edx,%edx
 4ae:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4b1:	eb 34                	jmp    4e7 <printf+0x57>
 4b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4b8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4bb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4c0:	83 f8 25             	cmp    $0x25,%eax
 4c3:	74 18                	je     4dd <printf+0x4d>
  write(fd, &c, 1);
 4c5:	83 ec 04             	sub    $0x4,%esp
 4c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4cb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4ce:	6a 01                	push   $0x1
 4d0:	50                   	push   %eax
 4d1:	57                   	push   %edi
 4d2:	e8 8c fe ff ff       	call   363 <write>
 4d7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4da:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4dd:	0f b6 1e             	movzbl (%esi),%ebx
 4e0:	83 c6 01             	add    $0x1,%esi
 4e3:	84 db                	test   %bl,%bl
 4e5:	74 29                	je     510 <printf+0x80>
    c = fmt[i] & 0xff;
 4e7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4ea:	85 d2                	test   %edx,%edx
 4ec:	74 ca                	je     4b8 <printf+0x28>
      }
    } else if(state == '%'){
 4ee:	83 fa 25             	cmp    $0x25,%edx
 4f1:	75 ea                	jne    4dd <printf+0x4d>
      if(c == 'd'){
 4f3:	83 f8 25             	cmp    $0x25,%eax
 4f6:	0f 84 04 01 00 00    	je     600 <printf+0x170>
 4fc:	83 e8 63             	sub    $0x63,%eax
 4ff:	83 f8 15             	cmp    $0x15,%eax
 502:	77 1c                	ja     520 <printf+0x90>
 504:	ff 24 85 04 08 00 00 	jmp    *0x804(,%eax,4)
 50b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 510:	8d 65 f4             	lea    -0xc(%ebp),%esp
 513:	5b                   	pop    %ebx
 514:	5e                   	pop    %esi
 515:	5f                   	pop    %edi
 516:	5d                   	pop    %ebp
 517:	c3                   	ret
 518:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51f:	00 
  write(fd, &c, 1);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	8d 55 e7             	lea    -0x19(%ebp),%edx
 526:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 52a:	6a 01                	push   $0x1
 52c:	52                   	push   %edx
 52d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 530:	57                   	push   %edi
 531:	e8 2d fe ff ff       	call   363 <write>
 536:	83 c4 0c             	add    $0xc,%esp
 539:	88 5d e7             	mov    %bl,-0x19(%ebp)
 53c:	6a 01                	push   $0x1
 53e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 541:	52                   	push   %edx
 542:	57                   	push   %edi
 543:	e8 1b fe ff ff       	call   363 <write>
        putc(fd, c);
 548:	83 c4 10             	add    $0x10,%esp
      state = 0;
 54b:	31 d2                	xor    %edx,%edx
 54d:	eb 8e                	jmp    4dd <printf+0x4d>
 54f:	90                   	nop
        printint(fd, *ap, 16, 0);
 550:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 553:	83 ec 0c             	sub    $0xc,%esp
 556:	b9 10 00 00 00       	mov    $0x10,%ecx
 55b:	8b 13                	mov    (%ebx),%edx
 55d:	6a 00                	push   $0x0
 55f:	89 f8                	mov    %edi,%eax
        ap++;
 561:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 564:	e8 87 fe ff ff       	call   3f0 <printint>
        ap++;
 569:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 56c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 56f:	31 d2                	xor    %edx,%edx
 571:	e9 67 ff ff ff       	jmp    4dd <printf+0x4d>
        s = (char*)*ap;
 576:	8b 45 d0             	mov    -0x30(%ebp),%eax
 579:	8b 18                	mov    (%eax),%ebx
        ap++;
 57b:	83 c0 04             	add    $0x4,%eax
 57e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 581:	85 db                	test   %ebx,%ebx
 583:	0f 84 87 00 00 00    	je     610 <printf+0x180>
        while(*s != 0){
 589:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 58c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 58e:	84 c0                	test   %al,%al
 590:	0f 84 47 ff ff ff    	je     4dd <printf+0x4d>
 596:	8d 55 e7             	lea    -0x19(%ebp),%edx
 599:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 59c:	89 de                	mov    %ebx,%esi
 59e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5a6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5a9:	6a 01                	push   $0x1
 5ab:	53                   	push   %ebx
 5ac:	57                   	push   %edi
 5ad:	e8 b1 fd ff ff       	call   363 <write>
        while(*s != 0){
 5b2:	0f b6 06             	movzbl (%esi),%eax
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	84 c0                	test   %al,%al
 5ba:	75 e4                	jne    5a0 <printf+0x110>
      state = 0;
 5bc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5bf:	31 d2                	xor    %edx,%edx
 5c1:	e9 17 ff ff ff       	jmp    4dd <printf+0x4d>
        printint(fd, *ap, 10, 1);
 5c6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5c9:	83 ec 0c             	sub    $0xc,%esp
 5cc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d1:	8b 13                	mov    (%ebx),%edx
 5d3:	6a 01                	push   $0x1
 5d5:	eb 88                	jmp    55f <printf+0xcf>
        putc(fd, *ap);
 5d7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5da:	83 ec 04             	sub    $0x4,%esp
 5dd:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 5e0:	8b 03                	mov    (%ebx),%eax
        ap++;
 5e2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 5e5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
 5ea:	52                   	push   %edx
 5eb:	57                   	push   %edi
 5ec:	e8 72 fd ff ff       	call   363 <write>
        ap++;
 5f1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5f4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5f7:	31 d2                	xor    %edx,%edx
 5f9:	e9 df fe ff ff       	jmp    4dd <printf+0x4d>
 5fe:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
 603:	88 5d e7             	mov    %bl,-0x19(%ebp)
 606:	8d 55 e7             	lea    -0x19(%ebp),%edx
 609:	6a 01                	push   $0x1
 60b:	e9 31 ff ff ff       	jmp    541 <printf+0xb1>
 610:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 615:	bb fd 07 00 00       	mov    $0x7fd,%ebx
 61a:	e9 77 ff ff ff       	jmp    596 <printf+0x106>
 61f:	90                   	nop

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	a1 04 0b 00 00       	mov    0xb04,%eax
{
 626:	89 e5                	mov    %esp,%ebp
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	53                   	push   %ebx
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 62e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 638:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63a:	39 c8                	cmp    %ecx,%eax
 63c:	73 32                	jae    670 <free+0x50>
 63e:	39 d1                	cmp    %edx,%ecx
 640:	72 04                	jb     646 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 642:	39 d0                	cmp    %edx,%eax
 644:	72 32                	jb     678 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 646:	8b 73 fc             	mov    -0x4(%ebx),%esi
 649:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 64c:	39 fa                	cmp    %edi,%edx
 64e:	74 30                	je     680 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 650:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 653:	8b 50 04             	mov    0x4(%eax),%edx
 656:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 659:	39 f1                	cmp    %esi,%ecx
 65b:	74 3a                	je     697 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 65d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 65f:	5b                   	pop    %ebx
  freep = p;
 660:	a3 04 0b 00 00       	mov    %eax,0xb04
}
 665:	5e                   	pop    %esi
 666:	5f                   	pop    %edi
 667:	5d                   	pop    %ebp
 668:	c3                   	ret
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 670:	39 d0                	cmp    %edx,%eax
 672:	72 04                	jb     678 <free+0x58>
 674:	39 d1                	cmp    %edx,%ecx
 676:	72 ce                	jb     646 <free+0x26>
{
 678:	89 d0                	mov    %edx,%eax
 67a:	eb bc                	jmp    638 <free+0x18>
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 680:	03 72 04             	add    0x4(%edx),%esi
 683:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 686:	8b 10                	mov    (%eax),%edx
 688:	8b 12                	mov    (%edx),%edx
 68a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 68d:	8b 50 04             	mov    0x4(%eax),%edx
 690:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 693:	39 f1                	cmp    %esi,%ecx
 695:	75 c6                	jne    65d <free+0x3d>
    p->s.size += bp->s.size;
 697:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 69a:	a3 04 0b 00 00       	mov    %eax,0xb04
    p->s.size += bp->s.size;
 69f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6a2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6a5:	89 08                	mov    %ecx,(%eax)
}
 6a7:	5b                   	pop    %ebx
 6a8:	5e                   	pop    %esi
 6a9:	5f                   	pop    %edi
 6aa:	5d                   	pop    %ebp
 6ab:	c3                   	ret
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6bc:	8b 15 04 0b 00 00    	mov    0xb04,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c2:	8d 78 07             	lea    0x7(%eax),%edi
 6c5:	c1 ef 03             	shr    $0x3,%edi
 6c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6cb:	85 d2                	test   %edx,%edx
 6cd:	0f 84 8d 00 00 00    	je     760 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6d5:	8b 48 04             	mov    0x4(%eax),%ecx
 6d8:	39 f9                	cmp    %edi,%ecx
 6da:	73 64                	jae    740 <malloc+0x90>
  if(nu < 4096)
 6dc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6e1:	39 df                	cmp    %ebx,%edi
 6e3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6e6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6ed:	eb 0a                	jmp    6f9 <malloc+0x49>
 6ef:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f2:	8b 48 04             	mov    0x4(%eax),%ecx
 6f5:	39 f9                	cmp    %edi,%ecx
 6f7:	73 47                	jae    740 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6f9:	89 c2                	mov    %eax,%edx
 6fb:	3b 05 04 0b 00 00    	cmp    0xb04,%eax
 701:	75 ed                	jne    6f0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 703:	83 ec 0c             	sub    $0xc,%esp
 706:	56                   	push   %esi
 707:	e8 bf fc ff ff       	call   3cb <sbrk>
  if(p == (char*)-1)
 70c:	83 c4 10             	add    $0x10,%esp
 70f:	83 f8 ff             	cmp    $0xffffffff,%eax
 712:	74 1c                	je     730 <malloc+0x80>
  hp->s.size = nu;
 714:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 717:	83 ec 0c             	sub    $0xc,%esp
 71a:	83 c0 08             	add    $0x8,%eax
 71d:	50                   	push   %eax
 71e:	e8 fd fe ff ff       	call   620 <free>
  return freep;
 723:	8b 15 04 0b 00 00    	mov    0xb04,%edx
      if((p = morecore(nunits)) == 0)
 729:	83 c4 10             	add    $0x10,%esp
 72c:	85 d2                	test   %edx,%edx
 72e:	75 c0                	jne    6f0 <malloc+0x40>
        return 0;
  }
}
 730:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 733:	31 c0                	xor    %eax,%eax
}
 735:	5b                   	pop    %ebx
 736:	5e                   	pop    %esi
 737:	5f                   	pop    %edi
 738:	5d                   	pop    %ebp
 739:	c3                   	ret
 73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 740:	39 cf                	cmp    %ecx,%edi
 742:	74 4c                	je     790 <malloc+0xe0>
        p->s.size -= nunits;
 744:	29 f9                	sub    %edi,%ecx
 746:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 749:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 74c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 74f:	89 15 04 0b 00 00    	mov    %edx,0xb04
}
 755:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 758:	83 c0 08             	add    $0x8,%eax
}
 75b:	5b                   	pop    %ebx
 75c:	5e                   	pop    %esi
 75d:	5f                   	pop    %edi
 75e:	5d                   	pop    %ebp
 75f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 760:	c7 05 04 0b 00 00 08 	movl   $0xb08,0xb04
 767:	0b 00 00 
    base.s.size = 0;
 76a:	b8 08 0b 00 00       	mov    $0xb08,%eax
    base.s.ptr = freep = prevp = &base;
 76f:	c7 05 08 0b 00 00 08 	movl   $0xb08,0xb08
 776:	0b 00 00 
    base.s.size = 0;
 779:	c7 05 0c 0b 00 00 00 	movl   $0x0,0xb0c
 780:	00 00 00 
    if(p->s.size >= nunits){
 783:	e9 54 ff ff ff       	jmp    6dc <malloc+0x2c>
 788:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 78f:	00 
        prevp->s.ptr = p->s.ptr;
 790:	8b 08                	mov    (%eax),%ecx
 792:	89 0a                	mov    %ecx,(%edx)
 794:	eb b9                	jmp    74f <malloc+0x9f>
