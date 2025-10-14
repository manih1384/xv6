
_find_sum:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:





int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 38             	sub    $0x38,%esp
  if (argc != 2) {
  14:	83 39 02             	cmpl   $0x2,(%ecx)
int main(int argc, char *argv[]) {
  17:	8b 41 04             	mov    0x4(%ecx),%eax
  if (argc != 2) {
  1a:	0f 85 3a 01 00 00    	jne    15a <main+0x15a>
    printf(2, "Usage: find_sum <string>\n");
    exit();
  }

  char *s = argv[1];
  20:	8b 50 04             	mov    0x4(%eax),%edx

  int sum = 0;
  int in_num = 0;
  int cur = 0;

  for (int i = 0; s[i]; i++) {
  23:	0f be 02             	movsbl (%edx),%eax
  26:	84 c0                	test   %al,%al
  28:	0f 84 3f 01 00 00    	je     16d <main+0x16d>
  int cur = 0;
  2e:	31 c9                	xor    %ecx,%ecx
  30:	83 c2 01             	add    $0x1,%edx
  int in_num = 0;
  33:	31 ff                	xor    %edi,%edi
  int sum = 0;
  35:	31 db                	xor    %ebx,%ebx
  37:	89 ce                	mov    %ecx,%esi
  39:	eb 1b                	jmp    56 <main+0x56>
  3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    char c = s[i];
    if (c >= '0' && c <= '9') {
      in_num = 1;
      cur = cur * 10 + (c - '0');
  40:	8d 0c b6             	lea    (%esi,%esi,4),%ecx
      in_num = 1;
  43:	bf 01 00 00 00       	mov    $0x1,%edi
      cur = cur * 10 + (c - '0');
  48:	8d 74 48 d0          	lea    -0x30(%eax,%ecx,2),%esi
  for (int i = 0; s[i]; i++) {
  4c:	0f be 02             	movsbl (%edx),%eax
  4f:	83 c2 01             	add    $0x1,%edx
  52:	84 c0                	test   %al,%al
  54:	74 1c                	je     72 <main+0x72>
    if (c >= '0' && c <= '9') {
  56:	8d 48 d0             	lea    -0x30(%eax),%ecx
  59:	80 f9 09             	cmp    $0x9,%cl
  5c:	76 e2                	jbe    40 <main+0x40>
    } else {
      if (in_num) {
  5e:	85 ff                	test   %edi,%edi
  60:	74 ea                	je     4c <main+0x4c>
  for (int i = 0; s[i]; i++) {
  62:	0f be 02             	movsbl (%edx),%eax
        sum += cur;
  65:	01 f3                	add    %esi,%ebx
  for (int i = 0; s[i]; i++) {
  67:	83 c2 01             	add    $0x1,%edx
        cur = 0;
  6a:	31 f6                	xor    %esi,%esi
        in_num = 0;
  6c:	31 ff                	xor    %edi,%edi
  for (int i = 0; s[i]; i++) {
  6e:	84 c0                	test   %al,%al
  70:	75 e4                	jne    56 <main+0x56>
      }
    }
  }
  if (in_num) sum += cur; 
  72:	85 ff                	test   %edi,%edi
  74:	74 02                	je     78 <main+0x78>
  76:	01 f3                	add    %esi,%ebx



  unlink(OUTPUT); // works like rm 
  78:	83 ec 0c             	sub    $0xc,%esp
  7b:	68 a2 08 00 00       	push   $0x8a2
  80:	e8 fe 03 00 00       	call   483 <unlink>


  int fd = open(OUTPUT, O_CREATE | O_WRONLY); // create or open file
  85:	5e                   	pop    %esi
  86:	5f                   	pop    %edi
  87:	68 01 02 00 00       	push   $0x201
  8c:	68 a2 08 00 00       	push   $0x8a2
  91:	e8 dd 03 00 00       	call   473 <open>

  
  if (fd < 0) {
  96:	83 c4 10             	add    $0x10,%esp
  int fd = open(OUTPUT, O_CREATE | O_WRONLY); // create or open file
  99:	89 c6                	mov    %eax,%esi
  if (fd < 0) {
  9b:	85 c0                	test   %eax,%eax
  9d:	0f 88 f1 00 00 00    	js     194 <main+0x194>
  if (num == 0) {
  a3:	85 db                	test   %ebx,%ebx
  a5:	0f 84 00 01 00 00    	je     1ab <main+0x1ab>
  int neg = 0;
  ab:	b8 00 00 00 00       	mov    $0x0,%eax
  if (num < 0) {
  b0:	79 07                	jns    b9 <main+0xb9>
    num = -num;   
  b2:	f7 db                	neg    %ebx
    neg = 1;
  b4:	b8 01 00 00 00       	mov    $0x1,%eax
  while (num > 0) {
  b9:	89 75 c4             	mov    %esi,-0x3c(%ebp)
      in_num = 1;
  bc:	31 ff                	xor    %edi,%edi
  be:	89 45 c0             	mov    %eax,-0x40(%ebp)
  c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = '0' + (num % 10);
  c8:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
  cd:	89 f9                	mov    %edi,%ecx
  cf:	83 c7 01             	add    $0x1,%edi
  d2:	f7 e3                	mul    %ebx
  d4:	c1 ea 03             	shr    $0x3,%edx
  d7:	8d 04 92             	lea    (%edx,%edx,4),%eax
  da:	01 c0                	add    %eax,%eax
  dc:	29 c3                	sub    %eax,%ebx
  de:	83 c3 30             	add    $0x30,%ebx
  e1:	88 5c 3d c7          	mov    %bl,-0x39(%ebp,%edi,1)
    num /= 10;
  e5:	89 d3                	mov    %edx,%ebx
  while (num > 0) {
  e7:	85 d2                	test   %edx,%edx
  e9:	75 dd                	jne    c8 <main+0xc8>
  eb:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ee:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if (neg) buf[i++] = '-';
  f1:	89 fa                	mov    %edi,%edx
  f3:	85 c0                	test   %eax,%eax
  f5:	0f 84 c3 00 00 00    	je     1be <main+0x1be>
  fb:	c6 44 15 c8 2d       	movb   $0x2d,-0x38(%ebp,%edx,1)
 100:	8d 79 02             	lea    0x2(%ecx),%edi
  int i = 0, j = n - 1;
 103:	83 c1 01             	add    $0x1,%ecx
  while (i < j) {
 106:	8d 45 c8             	lea    -0x38(%ebp),%eax
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    char t = s[i]; s[i] = s[j]; s[j] = t;
 110:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 114:	88 55 c4             	mov    %dl,-0x3c(%ebp)
 117:	0f b6 14 08          	movzbl (%eax,%ecx,1),%edx
 11b:	88 14 18             	mov    %dl,(%eax,%ebx,1)
 11e:	0f b6 55 c4          	movzbl -0x3c(%ebp),%edx
    i++; j--;
 122:	83 c3 01             	add    $0x1,%ebx
    char t = s[i]; s[i] = s[j]; s[j] = t;
 125:	88 14 08             	mov    %dl,(%eax,%ecx,1)
    i++; j--;
 128:	83 e9 01             	sub    $0x1,%ecx
  while (i < j) {
 12b:	39 cb                	cmp    %ecx,%ebx
 12d:	7c e1                	jl     110 <main+0x110>
  buf[i] = '\0';
 12f:	c6 44 3d c8 00       	movb   $0x0,-0x38(%ebp,%edi,1)
    exit();
  }

  char outbuf[32];
  int len = int_to_str(sum, outbuf);
  write(fd, outbuf, len); 
 134:	51                   	push   %ecx
 135:	57                   	push   %edi
 136:	50                   	push   %eax
 137:	56                   	push   %esi
 138:	e8 16 03 00 00       	call   453 <write>
  write(fd, "\n", 1);
 13d:	83 c4 0c             	add    $0xc,%esp
 140:	6a 01                	push   $0x1
 142:	68 a0 08 00 00       	push   $0x8a0
 147:	56                   	push   %esi
 148:	e8 06 03 00 00       	call   453 <write>
  close(fd);
 14d:	89 34 24             	mov    %esi,(%esp)
 150:	e8 06 03 00 00       	call   45b <close>


  exit();
 155:	e8 d9 02 00 00       	call   433 <exit>
    printf(2, "Usage: find_sum <string>\n");
 15a:	50                   	push   %eax
 15b:	50                   	push   %eax
 15c:	68 88 08 00 00       	push   $0x888
 161:	6a 02                	push   $0x2
 163:	e8 18 04 00 00       	call   580 <printf>
    exit();
 168:	e8 c6 02 00 00       	call   433 <exit>
  unlink(OUTPUT); // works like rm 
 16d:	83 ec 0c             	sub    $0xc,%esp
 170:	68 a2 08 00 00       	push   $0x8a2
 175:	e8 09 03 00 00       	call   483 <unlink>
  int fd = open(OUTPUT, O_CREATE | O_WRONLY); // create or open file
 17a:	58                   	pop    %eax
 17b:	5a                   	pop    %edx
 17c:	68 01 02 00 00       	push   $0x201
 181:	68 a2 08 00 00       	push   $0x8a2
 186:	e8 e8 02 00 00       	call   473 <open>
  if (fd < 0) {
 18b:	83 c4 10             	add    $0x10,%esp
  int fd = open(OUTPUT, O_CREATE | O_WRONLY); // create or open file
 18e:	89 c6                	mov    %eax,%esi
  if (fd < 0) {
 190:	85 c0                	test   %eax,%eax
 192:	79 17                	jns    1ab <main+0x1ab>
    printf(2, "find_sum: cannot create %s\n", OUTPUT);
 194:	53                   	push   %ebx
 195:	68 a2 08 00 00       	push   $0x8a2
 19a:	68 ad 08 00 00       	push   $0x8ad
 19f:	6a 02                	push   $0x2
 1a1:	e8 da 03 00 00       	call   580 <printf>
    exit();
 1a6:	e8 88 02 00 00       	call   433 <exit>
    buf[i++] = '0';
 1ab:	66 c7 45 c8 30 00    	movw   $0x30,-0x38(%ebp)
    return i;
 1b1:	bf 01 00 00 00       	mov    $0x1,%edi
 1b6:	8d 45 c8             	lea    -0x38(%ebp),%eax
 1b9:	e9 76 ff ff ff       	jmp    134 <main+0x134>
  while (i < j) {
 1be:	85 c9                	test   %ecx,%ecx
 1c0:	0f 85 40 ff ff ff    	jne    106 <main+0x106>
 1c6:	bf 01 00 00 00       	mov    $0x1,%edi
 1cb:	8d 45 c8             	lea    -0x38(%ebp),%eax
 1ce:	e9 5c ff ff ff       	jmp    12f <main+0x12f>
 1d3:	66 90                	xchg   %ax,%ax
 1d5:	66 90                	xchg   %ax,%ax
 1d7:	66 90                	xchg   %ax,%ax
 1d9:	66 90                	xchg   %ax,%ax
 1db:	66 90                	xchg   %ax,%ax
 1dd:	66 90                	xchg   %ax,%ax
 1df:	90                   	nop

000001e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1e0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1e1:	31 c0                	xor    %eax,%eax
{
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	53                   	push   %ebx
 1e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1f0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1f4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1f7:	83 c0 01             	add    $0x1,%eax
 1fa:	84 d2                	test   %dl,%dl
 1fc:	75 f2                	jne    1f0 <strcpy+0x10>
    ;
  return os;
}
 1fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 201:	89 c8                	mov    %ecx,%eax
 203:	c9                   	leave
 204:	c3                   	ret
 205:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20c:	00 
 20d:	8d 76 00             	lea    0x0(%esi),%esi

00000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 55 08             	mov    0x8(%ebp),%edx
 217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 21a:	0f b6 02             	movzbl (%edx),%eax
 21d:	84 c0                	test   %al,%al
 21f:	75 17                	jne    238 <strcmp+0x28>
 221:	eb 3a                	jmp    25d <strcmp+0x4d>
 223:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 228:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 22c:	83 c2 01             	add    $0x1,%edx
 22f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 232:	84 c0                	test   %al,%al
 234:	74 1a                	je     250 <strcmp+0x40>
 236:	89 d9                	mov    %ebx,%ecx
 238:	0f b6 19             	movzbl (%ecx),%ebx
 23b:	38 c3                	cmp    %al,%bl
 23d:	74 e9                	je     228 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 23f:	29 d8                	sub    %ebx,%eax
}
 241:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 244:	c9                   	leave
 245:	c3                   	ret
 246:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24d:	00 
 24e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 250:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 254:	31 c0                	xor    %eax,%eax
 256:	29 d8                	sub    %ebx,%eax
}
 258:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 25b:	c9                   	leave
 25c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 25d:	0f b6 19             	movzbl (%ecx),%ebx
 260:	31 c0                	xor    %eax,%eax
 262:	eb db                	jmp    23f <strcmp+0x2f>
 264:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26b:	00 
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <strlen>:

uint
strlen(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 276:	80 3a 00             	cmpb   $0x0,(%edx)
 279:	74 15                	je     290 <strlen+0x20>
 27b:	31 c0                	xor    %eax,%eax
 27d:	8d 76 00             	lea    0x0(%esi),%esi
 280:	83 c0 01             	add    $0x1,%eax
 283:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 287:	89 c1                	mov    %eax,%ecx
 289:	75 f5                	jne    280 <strlen+0x10>
    ;
  return n;
}
 28b:	89 c8                	mov    %ecx,%eax
 28d:	5d                   	pop    %ebp
 28e:	c3                   	ret
 28f:	90                   	nop
  for(n = 0; s[n]; n++)
 290:	31 c9                	xor    %ecx,%ecx
}
 292:	5d                   	pop    %ebp
 293:	89 c8                	mov    %ecx,%eax
 295:	c3                   	ret
 296:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29d:	00 
 29e:	66 90                	xchg   %ax,%ax

000002a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 d7                	mov    %edx,%edi
 2af:	fc                   	cld
 2b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2b5:	89 d0                	mov    %edx,%eax
 2b7:	c9                   	leave
 2b8:	c3                   	ret
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002c0 <strchr>:

char*
strchr(const char *s, char c)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2ca:	0f b6 10             	movzbl (%eax),%edx
 2cd:	84 d2                	test   %dl,%dl
 2cf:	75 12                	jne    2e3 <strchr+0x23>
 2d1:	eb 1d                	jmp    2f0 <strchr+0x30>
 2d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 2d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 2dc:	83 c0 01             	add    $0x1,%eax
 2df:	84 d2                	test   %dl,%dl
 2e1:	74 0d                	je     2f0 <strchr+0x30>
    if(*s == c)
 2e3:	38 d1                	cmp    %dl,%cl
 2e5:	75 f1                	jne    2d8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 2e7:	5d                   	pop    %ebp
 2e8:	c3                   	ret
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2f0:	31 c0                	xor    %eax,%eax
}
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret
 2f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2fb:	00 
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <gets>:

char*
gets(char *buf, int max)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 305:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 308:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 309:	31 db                	xor    %ebx,%ebx
 30b:	8d 73 01             	lea    0x1(%ebx),%esi
{
 30e:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 311:	3b 75 0c             	cmp    0xc(%ebp),%esi
 314:	7d 3b                	jge    351 <gets+0x51>
 316:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31d:	00 
 31e:	66 90                	xchg   %ax,%ax
    cc = read(0, &c, 1);
 320:	83 ec 04             	sub    $0x4,%esp
 323:	6a 01                	push   $0x1
 325:	57                   	push   %edi
 326:	6a 00                	push   $0x0
 328:	e8 1e 01 00 00       	call   44b <read>
    // printf(2, "read returned %d, char=%c\n", cc, c);
    if(cc < 1)
 32d:	83 c4 10             	add    $0x10,%esp
 330:	85 c0                	test   %eax,%eax
 332:	7e 1d                	jle    351 <gets+0x51>
      break;
    buf[i++] = c;
 334:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 338:	8b 55 08             	mov    0x8(%ebp),%edx
 33b:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r' || c=='\t')
 33f:	3c 0a                	cmp    $0xa,%al
 341:	7f 25                	jg     368 <gets+0x68>
 343:	3c 08                	cmp    $0x8,%al
 345:	7f 0c                	jg     353 <gets+0x53>
{
 347:	89 f3                	mov    %esi,%ebx
  for(i=0; i+1 < max; ){
 349:	8d 73 01             	lea    0x1(%ebx),%esi
 34c:	3b 75 0c             	cmp    0xc(%ebp),%esi
 34f:	7c cf                	jl     320 <gets+0x20>
 351:	89 de                	mov    %ebx,%esi
      break;
      
  }
  buf[i] = '\0';
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 35a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 35d:	5b                   	pop    %ebx
 35e:	5e                   	pop    %esi
 35f:	5f                   	pop    %edi
 360:	5d                   	pop    %ebp
 361:	c3                   	ret
 362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 368:	3c 0d                	cmp    $0xd,%al
 36a:	74 e7                	je     353 <gets+0x53>
{
 36c:	89 f3                	mov    %esi,%ebx
 36e:	eb d9                	jmp    349 <gets+0x49>

00000370 <stat>:

int
stat(const char *n, struct stat *st)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	56                   	push   %esi
 374:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 375:	83 ec 08             	sub    $0x8,%esp
 378:	6a 00                	push   $0x0
 37a:	ff 75 08             	push   0x8(%ebp)
 37d:	e8 f1 00 00 00       	call   473 <open>
  if(fd < 0)
 382:	83 c4 10             	add    $0x10,%esp
 385:	85 c0                	test   %eax,%eax
 387:	78 27                	js     3b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 389:	83 ec 08             	sub    $0x8,%esp
 38c:	ff 75 0c             	push   0xc(%ebp)
 38f:	89 c3                	mov    %eax,%ebx
 391:	50                   	push   %eax
 392:	e8 f4 00 00 00       	call   48b <fstat>
  close(fd);
 397:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 39a:	89 c6                	mov    %eax,%esi
  close(fd);
 39c:	e8 ba 00 00 00       	call   45b <close>
  return r;
 3a1:	83 c4 10             	add    $0x10,%esp
}
 3a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3a7:	89 f0                	mov    %esi,%eax
 3a9:	5b                   	pop    %ebx
 3aa:	5e                   	pop    %esi
 3ab:	5d                   	pop    %ebp
 3ac:	c3                   	ret
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3b5:	eb ed                	jmp    3a4 <stat+0x34>
 3b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3be:	00 
 3bf:	90                   	nop

000003c0 <atoi>:

int
atoi(const char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c7:	0f be 02             	movsbl (%edx),%eax
 3ca:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3cd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3d0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3d5:	77 1e                	ja     3f5 <atoi+0x35>
 3d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3de:	00 
 3df:	90                   	nop
    n = n*10 + *s++ - '0';
 3e0:	83 c2 01             	add    $0x1,%edx
 3e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3ea:	0f be 02             	movsbl (%edx),%eax
 3ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3f0:	80 fb 09             	cmp    $0x9,%bl
 3f3:	76 eb                	jbe    3e0 <atoi+0x20>
  return n;
}
 3f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3f8:	89 c8                	mov    %ecx,%eax
 3fa:	c9                   	leave
 3fb:	c3                   	ret
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000400 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	8b 45 10             	mov    0x10(%ebp),%eax
 407:	8b 55 08             	mov    0x8(%ebp),%edx
 40a:	56                   	push   %esi
 40b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 40e:	85 c0                	test   %eax,%eax
 410:	7e 13                	jle    425 <memmove+0x25>
 412:	01 d0                	add    %edx,%eax
  dst = vdst;
 414:	89 d7                	mov    %edx,%edi
 416:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41d:	00 
 41e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 420:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 421:	39 f8                	cmp    %edi,%eax
 423:	75 fb                	jne    420 <memmove+0x20>
  return vdst;
}
 425:	5e                   	pop    %esi
 426:	89 d0                	mov    %edx,%eax
 428:	5f                   	pop    %edi
 429:	5d                   	pop    %ebp
 42a:	c3                   	ret

0000042b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 42b:	b8 01 00 00 00       	mov    $0x1,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <exit>:
SYSCALL(exit)
 433:	b8 02 00 00 00       	mov    $0x2,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <wait>:
SYSCALL(wait)
 43b:	b8 03 00 00 00       	mov    $0x3,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <pipe>:
SYSCALL(pipe)
 443:	b8 04 00 00 00       	mov    $0x4,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <read>:
SYSCALL(read)
 44b:	b8 05 00 00 00       	mov    $0x5,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <write>:
SYSCALL(write)
 453:	b8 10 00 00 00       	mov    $0x10,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <close>:
SYSCALL(close)
 45b:	b8 15 00 00 00       	mov    $0x15,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <kill>:
SYSCALL(kill)
 463:	b8 06 00 00 00       	mov    $0x6,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <exec>:
SYSCALL(exec)
 46b:	b8 07 00 00 00       	mov    $0x7,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <open>:
SYSCALL(open)
 473:	b8 0f 00 00 00       	mov    $0xf,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <mknod>:
SYSCALL(mknod)
 47b:	b8 11 00 00 00       	mov    $0x11,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <unlink>:
SYSCALL(unlink)
 483:	b8 12 00 00 00       	mov    $0x12,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <fstat>:
SYSCALL(fstat)
 48b:	b8 08 00 00 00       	mov    $0x8,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <link>:
SYSCALL(link)
 493:	b8 13 00 00 00       	mov    $0x13,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <mkdir>:
SYSCALL(mkdir)
 49b:	b8 14 00 00 00       	mov    $0x14,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

000004a3 <chdir>:
SYSCALL(chdir)
 4a3:	b8 09 00 00 00       	mov    $0x9,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

000004ab <dup>:
SYSCALL(dup)
 4ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

000004b3 <getpid>:
SYSCALL(getpid)
 4b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

000004bb <sbrk>:
SYSCALL(sbrk)
 4bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret

000004c3 <sleep>:
SYSCALL(sleep)
 4c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret

000004cb <uptime>:
SYSCALL(uptime)
 4cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret
 4d3:	66 90                	xchg   %ax,%ax
 4d5:	66 90                	xchg   %ax,%ax
 4d7:	66 90                	xchg   %ax,%ax
 4d9:	66 90                	xchg   %ax,%ax
 4db:	66 90                	xchg   %ax,%ax
 4dd:	66 90                	xchg   %ax,%ax
 4df:	90                   	nop

000004e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4e8:	89 d1                	mov    %edx,%ecx
{
 4ea:	83 ec 3c             	sub    $0x3c,%esp
 4ed:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 4f0:	85 d2                	test   %edx,%edx
 4f2:	0f 89 80 00 00 00    	jns    578 <printint+0x98>
 4f8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4fc:	74 7a                	je     578 <printint+0x98>
    x = -xx;
 4fe:	f7 d9                	neg    %ecx
    neg = 1;
 500:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 505:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 508:	31 f6                	xor    %esi,%esi
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 510:	89 c8                	mov    %ecx,%eax
 512:	31 d2                	xor    %edx,%edx
 514:	89 f7                	mov    %esi,%edi
 516:	f7 f3                	div    %ebx
 518:	8d 76 01             	lea    0x1(%esi),%esi
 51b:	0f b6 92 28 09 00 00 	movzbl 0x928(%edx),%edx
 522:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 526:	89 ca                	mov    %ecx,%edx
 528:	89 c1                	mov    %eax,%ecx
 52a:	39 da                	cmp    %ebx,%edx
 52c:	73 e2                	jae    510 <printint+0x30>
  if(neg)
 52e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 531:	85 c0                	test   %eax,%eax
 533:	74 07                	je     53c <printint+0x5c>
    buf[i++] = '-';
 535:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 53a:	89 f7                	mov    %esi,%edi
 53c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 53f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 542:	01 df                	add    %ebx,%edi
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 548:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 54b:	83 ec 04             	sub    $0x4,%esp
 54e:	88 45 d7             	mov    %al,-0x29(%ebp)
 551:	8d 45 d7             	lea    -0x29(%ebp),%eax
 554:	6a 01                	push   $0x1
 556:	50                   	push   %eax
 557:	56                   	push   %esi
 558:	e8 f6 fe ff ff       	call   453 <write>
  while(--i >= 0)
 55d:	89 f8                	mov    %edi,%eax
 55f:	83 c4 10             	add    $0x10,%esp
 562:	83 ef 01             	sub    $0x1,%edi
 565:	39 c3                	cmp    %eax,%ebx
 567:	75 df                	jne    548 <printint+0x68>
}
 569:	8d 65 f4             	lea    -0xc(%ebp),%esp
 56c:	5b                   	pop    %ebx
 56d:	5e                   	pop    %esi
 56e:	5f                   	pop    %edi
 56f:	5d                   	pop    %ebp
 570:	c3                   	ret
 571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 578:	31 c0                	xor    %eax,%eax
 57a:	eb 89                	jmp    505 <printint+0x25>
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000580 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
 586:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 589:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 58c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 58f:	0f b6 1e             	movzbl (%esi),%ebx
 592:	83 c6 01             	add    $0x1,%esi
 595:	84 db                	test   %bl,%bl
 597:	74 67                	je     600 <printf+0x80>
 599:	8d 4d 10             	lea    0x10(%ebp),%ecx
 59c:	31 d2                	xor    %edx,%edx
 59e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 5a1:	eb 34                	jmp    5d7 <printf+0x57>
 5a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 5a8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5ab:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5b0:	83 f8 25             	cmp    $0x25,%eax
 5b3:	74 18                	je     5cd <printf+0x4d>
  write(fd, &c, 1);
 5b5:	83 ec 04             	sub    $0x4,%esp
 5b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5bb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5be:	6a 01                	push   $0x1
 5c0:	50                   	push   %eax
 5c1:	57                   	push   %edi
 5c2:	e8 8c fe ff ff       	call   453 <write>
 5c7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5ca:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5cd:	0f b6 1e             	movzbl (%esi),%ebx
 5d0:	83 c6 01             	add    $0x1,%esi
 5d3:	84 db                	test   %bl,%bl
 5d5:	74 29                	je     600 <printf+0x80>
    c = fmt[i] & 0xff;
 5d7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5da:	85 d2                	test   %edx,%edx
 5dc:	74 ca                	je     5a8 <printf+0x28>
      }
    } else if(state == '%'){
 5de:	83 fa 25             	cmp    $0x25,%edx
 5e1:	75 ea                	jne    5cd <printf+0x4d>
      if(c == 'd'){
 5e3:	83 f8 25             	cmp    $0x25,%eax
 5e6:	0f 84 04 01 00 00    	je     6f0 <printf+0x170>
 5ec:	83 e8 63             	sub    $0x63,%eax
 5ef:	83 f8 15             	cmp    $0x15,%eax
 5f2:	77 1c                	ja     610 <printf+0x90>
 5f4:	ff 24 85 d0 08 00 00 	jmp    *0x8d0(,%eax,4)
 5fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 600:	8d 65 f4             	lea    -0xc(%ebp),%esp
 603:	5b                   	pop    %ebx
 604:	5e                   	pop    %esi
 605:	5f                   	pop    %edi
 606:	5d                   	pop    %ebp
 607:	c3                   	ret
 608:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 60f:	00 
  write(fd, &c, 1);
 610:	83 ec 04             	sub    $0x4,%esp
 613:	8d 55 e7             	lea    -0x19(%ebp),%edx
 616:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 61a:	6a 01                	push   $0x1
 61c:	52                   	push   %edx
 61d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 620:	57                   	push   %edi
 621:	e8 2d fe ff ff       	call   453 <write>
 626:	83 c4 0c             	add    $0xc,%esp
 629:	88 5d e7             	mov    %bl,-0x19(%ebp)
 62c:	6a 01                	push   $0x1
 62e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 631:	52                   	push   %edx
 632:	57                   	push   %edi
 633:	e8 1b fe ff ff       	call   453 <write>
        putc(fd, c);
 638:	83 c4 10             	add    $0x10,%esp
      state = 0;
 63b:	31 d2                	xor    %edx,%edx
 63d:	eb 8e                	jmp    5cd <printf+0x4d>
 63f:	90                   	nop
        printint(fd, *ap, 16, 0);
 640:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 643:	83 ec 0c             	sub    $0xc,%esp
 646:	b9 10 00 00 00       	mov    $0x10,%ecx
 64b:	8b 13                	mov    (%ebx),%edx
 64d:	6a 00                	push   $0x0
 64f:	89 f8                	mov    %edi,%eax
        ap++;
 651:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 654:	e8 87 fe ff ff       	call   4e0 <printint>
        ap++;
 659:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 65c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 65f:	31 d2                	xor    %edx,%edx
 661:	e9 67 ff ff ff       	jmp    5cd <printf+0x4d>
        s = (char*)*ap;
 666:	8b 45 d0             	mov    -0x30(%ebp),%eax
 669:	8b 18                	mov    (%eax),%ebx
        ap++;
 66b:	83 c0 04             	add    $0x4,%eax
 66e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 671:	85 db                	test   %ebx,%ebx
 673:	0f 84 87 00 00 00    	je     700 <printf+0x180>
        while(*s != 0){
 679:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 67c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 67e:	84 c0                	test   %al,%al
 680:	0f 84 47 ff ff ff    	je     5cd <printf+0x4d>
 686:	8d 55 e7             	lea    -0x19(%ebp),%edx
 689:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 68c:	89 de                	mov    %ebx,%esi
 68e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 690:	83 ec 04             	sub    $0x4,%esp
 693:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 696:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 699:	6a 01                	push   $0x1
 69b:	53                   	push   %ebx
 69c:	57                   	push   %edi
 69d:	e8 b1 fd ff ff       	call   453 <write>
        while(*s != 0){
 6a2:	0f b6 06             	movzbl (%esi),%eax
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	84 c0                	test   %al,%al
 6aa:	75 e4                	jne    690 <printf+0x110>
      state = 0;
 6ac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6af:	31 d2                	xor    %edx,%edx
 6b1:	e9 17 ff ff ff       	jmp    5cd <printf+0x4d>
        printint(fd, *ap, 10, 1);
 6b6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6b9:	83 ec 0c             	sub    $0xc,%esp
 6bc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6c1:	8b 13                	mov    (%ebx),%edx
 6c3:	6a 01                	push   $0x1
 6c5:	eb 88                	jmp    64f <printf+0xcf>
        putc(fd, *ap);
 6c7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6ca:	83 ec 04             	sub    $0x4,%esp
 6cd:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 6d0:	8b 03                	mov    (%ebx),%eax
        ap++;
 6d2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 6d5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6d8:	6a 01                	push   $0x1
 6da:	52                   	push   %edx
 6db:	57                   	push   %edi
 6dc:	e8 72 fd ff ff       	call   453 <write>
        ap++;
 6e1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6e4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6e7:	31 d2                	xor    %edx,%edx
 6e9:	e9 df fe ff ff       	jmp    5cd <printf+0x4d>
 6ee:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 6f0:	83 ec 04             	sub    $0x4,%esp
 6f3:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6f6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6f9:	6a 01                	push   $0x1
 6fb:	e9 31 ff ff ff       	jmp    631 <printf+0xb1>
 700:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 705:	bb c9 08 00 00       	mov    $0x8c9,%ebx
 70a:	e9 77 ff ff ff       	jmp    686 <printf+0x106>
 70f:	90                   	nop

00000710 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 710:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	a1 d0 0b 00 00       	mov    0xbd0,%eax
{
 716:	89 e5                	mov    %esp,%ebp
 718:	57                   	push   %edi
 719:	56                   	push   %esi
 71a:	53                   	push   %ebx
 71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 71e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 728:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72a:	39 c8                	cmp    %ecx,%eax
 72c:	73 32                	jae    760 <free+0x50>
 72e:	39 d1                	cmp    %edx,%ecx
 730:	72 04                	jb     736 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 732:	39 d0                	cmp    %edx,%eax
 734:	72 32                	jb     768 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 736:	8b 73 fc             	mov    -0x4(%ebx),%esi
 739:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 73c:	39 fa                	cmp    %edi,%edx
 73e:	74 30                	je     770 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 740:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 743:	8b 50 04             	mov    0x4(%eax),%edx
 746:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 749:	39 f1                	cmp    %esi,%ecx
 74b:	74 3a                	je     787 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 74d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 74f:	5b                   	pop    %ebx
  freep = p;
 750:	a3 d0 0b 00 00       	mov    %eax,0xbd0
}
 755:	5e                   	pop    %esi
 756:	5f                   	pop    %edi
 757:	5d                   	pop    %ebp
 758:	c3                   	ret
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 760:	39 d0                	cmp    %edx,%eax
 762:	72 04                	jb     768 <free+0x58>
 764:	39 d1                	cmp    %edx,%ecx
 766:	72 ce                	jb     736 <free+0x26>
{
 768:	89 d0                	mov    %edx,%eax
 76a:	eb bc                	jmp    728 <free+0x18>
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 770:	03 72 04             	add    0x4(%edx),%esi
 773:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 776:	8b 10                	mov    (%eax),%edx
 778:	8b 12                	mov    (%edx),%edx
 77a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 77d:	8b 50 04             	mov    0x4(%eax),%edx
 780:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 783:	39 f1                	cmp    %esi,%ecx
 785:	75 c6                	jne    74d <free+0x3d>
    p->s.size += bp->s.size;
 787:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 78a:	a3 d0 0b 00 00       	mov    %eax,0xbd0
    p->s.size += bp->s.size;
 78f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 792:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 795:	89 08                	mov    %ecx,(%eax)
}
 797:	5b                   	pop    %ebx
 798:	5e                   	pop    %esi
 799:	5f                   	pop    %edi
 79a:	5d                   	pop    %ebp
 79b:	c3                   	ret
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ac:	8b 15 d0 0b 00 00    	mov    0xbd0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b2:	8d 78 07             	lea    0x7(%eax),%edi
 7b5:	c1 ef 03             	shr    $0x3,%edi
 7b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7bb:	85 d2                	test   %edx,%edx
 7bd:	0f 84 8d 00 00 00    	je     850 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7c5:	8b 48 04             	mov    0x4(%eax),%ecx
 7c8:	39 f9                	cmp    %edi,%ecx
 7ca:	73 64                	jae    830 <malloc+0x90>
  if(nu < 4096)
 7cc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7d1:	39 df                	cmp    %ebx,%edi
 7d3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7d6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7dd:	eb 0a                	jmp    7e9 <malloc+0x49>
 7df:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7e2:	8b 48 04             	mov    0x4(%eax),%ecx
 7e5:	39 f9                	cmp    %edi,%ecx
 7e7:	73 47                	jae    830 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e9:	89 c2                	mov    %eax,%edx
 7eb:	3b 05 d0 0b 00 00    	cmp    0xbd0,%eax
 7f1:	75 ed                	jne    7e0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7f3:	83 ec 0c             	sub    $0xc,%esp
 7f6:	56                   	push   %esi
 7f7:	e8 bf fc ff ff       	call   4bb <sbrk>
  if(p == (char*)-1)
 7fc:	83 c4 10             	add    $0x10,%esp
 7ff:	83 f8 ff             	cmp    $0xffffffff,%eax
 802:	74 1c                	je     820 <malloc+0x80>
  hp->s.size = nu;
 804:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 807:	83 ec 0c             	sub    $0xc,%esp
 80a:	83 c0 08             	add    $0x8,%eax
 80d:	50                   	push   %eax
 80e:	e8 fd fe ff ff       	call   710 <free>
  return freep;
 813:	8b 15 d0 0b 00 00    	mov    0xbd0,%edx
      if((p = morecore(nunits)) == 0)
 819:	83 c4 10             	add    $0x10,%esp
 81c:	85 d2                	test   %edx,%edx
 81e:	75 c0                	jne    7e0 <malloc+0x40>
        return 0;
  }
}
 820:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 823:	31 c0                	xor    %eax,%eax
}
 825:	5b                   	pop    %ebx
 826:	5e                   	pop    %esi
 827:	5f                   	pop    %edi
 828:	5d                   	pop    %ebp
 829:	c3                   	ret
 82a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 830:	39 cf                	cmp    %ecx,%edi
 832:	74 4c                	je     880 <malloc+0xe0>
        p->s.size -= nunits;
 834:	29 f9                	sub    %edi,%ecx
 836:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 839:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 83c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 83f:	89 15 d0 0b 00 00    	mov    %edx,0xbd0
}
 845:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 848:	83 c0 08             	add    $0x8,%eax
}
 84b:	5b                   	pop    %ebx
 84c:	5e                   	pop    %esi
 84d:	5f                   	pop    %edi
 84e:	5d                   	pop    %ebp
 84f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 850:	c7 05 d0 0b 00 00 d4 	movl   $0xbd4,0xbd0
 857:	0b 00 00 
    base.s.size = 0;
 85a:	b8 d4 0b 00 00       	mov    $0xbd4,%eax
    base.s.ptr = freep = prevp = &base;
 85f:	c7 05 d4 0b 00 00 d4 	movl   $0xbd4,0xbd4
 866:	0b 00 00 
    base.s.size = 0;
 869:	c7 05 d8 0b 00 00 00 	movl   $0x0,0xbd8
 870:	00 00 00 
    if(p->s.size >= nunits){
 873:	e9 54 ff ff ff       	jmp    7cc <malloc+0x2c>
 878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 87f:	00 
        prevp->s.ptr = p->s.ptr;
 880:	8b 08                	mov    (%eax),%ecx
 882:	89 0a                	mov    %ecx,(%edx)
 884:	eb b9                	jmp    83f <malloc+0x9f>
