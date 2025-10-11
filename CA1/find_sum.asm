
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
  7b:	68 92 08 00 00       	push   $0x892
  80:	e8 ee 03 00 00       	call   473 <unlink>


  int fd = open(OUTPUT, O_CREATE | O_WRONLY); // create or open file
  85:	5e                   	pop    %esi
  86:	5f                   	pop    %edi
  87:	68 01 02 00 00       	push   $0x201
  8c:	68 92 08 00 00       	push   $0x892
  91:	e8 cd 03 00 00       	call   463 <open>

  
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
 138:	e8 06 03 00 00       	call   443 <write>
  write(fd, "\n", 1);
 13d:	83 c4 0c             	add    $0xc,%esp
 140:	6a 01                	push   $0x1
 142:	68 90 08 00 00       	push   $0x890
 147:	56                   	push   %esi
 148:	e8 f6 02 00 00       	call   443 <write>
  close(fd);
 14d:	89 34 24             	mov    %esi,(%esp)
 150:	e8 f6 02 00 00       	call   44b <close>


  exit();
 155:	e8 c9 02 00 00       	call   423 <exit>
    printf(2, "Usage: find_sum <string>\n");
 15a:	50                   	push   %eax
 15b:	50                   	push   %eax
 15c:	68 78 08 00 00       	push   $0x878
 161:	6a 02                	push   $0x2
 163:	e8 08 04 00 00       	call   570 <printf>
    exit();
 168:	e8 b6 02 00 00       	call   423 <exit>
  unlink(OUTPUT); // works like rm 
 16d:	83 ec 0c             	sub    $0xc,%esp
 170:	68 92 08 00 00       	push   $0x892
 175:	e8 f9 02 00 00       	call   473 <unlink>
  int fd = open(OUTPUT, O_CREATE | O_WRONLY); // create or open file
 17a:	58                   	pop    %eax
 17b:	5a                   	pop    %edx
 17c:	68 01 02 00 00       	push   $0x201
 181:	68 92 08 00 00       	push   $0x892
 186:	e8 d8 02 00 00       	call   463 <open>
  if (fd < 0) {
 18b:	83 c4 10             	add    $0x10,%esp
  int fd = open(OUTPUT, O_CREATE | O_WRONLY); // create or open file
 18e:	89 c6                	mov    %eax,%esi
  if (fd < 0) {
 190:	85 c0                	test   %eax,%eax
 192:	79 17                	jns    1ab <main+0x1ab>
    printf(2, "find_sum: cannot create %s\n", OUTPUT);
 194:	53                   	push   %ebx
 195:	68 92 08 00 00       	push   $0x892
 19a:	68 9d 08 00 00       	push   $0x89d
 19f:	6a 02                	push   $0x2
 1a1:	e8 ca 03 00 00       	call   570 <printf>
    exit();
 1a6:	e8 78 02 00 00       	call   423 <exit>
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
 305:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 308:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 309:	31 db                	xor    %ebx,%ebx
{
 30b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 30e:	eb 27                	jmp    337 <gets+0x37>
    cc = read(0, &c, 1);
 310:	83 ec 04             	sub    $0x4,%esp
 313:	6a 01                	push   $0x1
 315:	56                   	push   %esi
 316:	6a 00                	push   $0x0
 318:	e8 1e 01 00 00       	call   43b <read>
    if(cc < 1)
 31d:	83 c4 10             	add    $0x10,%esp
 320:	85 c0                	test   %eax,%eax
 322:	7e 1d                	jle    341 <gets+0x41>
      break;
    buf[i++] = c;
 324:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 328:	8b 55 08             	mov    0x8(%ebp),%edx
 32b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 32f:	3c 0a                	cmp    $0xa,%al
 331:	74 10                	je     343 <gets+0x43>
 333:	3c 0d                	cmp    $0xd,%al
 335:	74 0c                	je     343 <gets+0x43>
  for(i=0; i+1 < max; ){
 337:	89 df                	mov    %ebx,%edi
 339:	83 c3 01             	add    $0x1,%ebx
 33c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 33f:	7c cf                	jl     310 <gets+0x10>
 341:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 34a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 34d:	5b                   	pop    %ebx
 34e:	5e                   	pop    %esi
 34f:	5f                   	pop    %edi
 350:	5d                   	pop    %ebp
 351:	c3                   	ret
 352:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 359:	00 
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <stat>:

int
stat(const char *n, struct stat *st)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 365:	83 ec 08             	sub    $0x8,%esp
 368:	6a 00                	push   $0x0
 36a:	ff 75 08             	push   0x8(%ebp)
 36d:	e8 f1 00 00 00       	call   463 <open>
  if(fd < 0)
 372:	83 c4 10             	add    $0x10,%esp
 375:	85 c0                	test   %eax,%eax
 377:	78 27                	js     3a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 379:	83 ec 08             	sub    $0x8,%esp
 37c:	ff 75 0c             	push   0xc(%ebp)
 37f:	89 c3                	mov    %eax,%ebx
 381:	50                   	push   %eax
 382:	e8 f4 00 00 00       	call   47b <fstat>
  close(fd);
 387:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 38a:	89 c6                	mov    %eax,%esi
  close(fd);
 38c:	e8 ba 00 00 00       	call   44b <close>
  return r;
 391:	83 c4 10             	add    $0x10,%esp
}
 394:	8d 65 f8             	lea    -0x8(%ebp),%esp
 397:	89 f0                	mov    %esi,%eax
 399:	5b                   	pop    %ebx
 39a:	5e                   	pop    %esi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3a5:	eb ed                	jmp    394 <stat+0x34>
 3a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ae:	00 
 3af:	90                   	nop

000003b0 <atoi>:

int
atoi(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b7:	0f be 02             	movsbl (%edx),%eax
 3ba:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3bd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3c0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3c5:	77 1e                	ja     3e5 <atoi+0x35>
 3c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ce:	00 
 3cf:	90                   	nop
    n = n*10 + *s++ - '0';
 3d0:	83 c2 01             	add    $0x1,%edx
 3d3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3d6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3da:	0f be 02             	movsbl (%edx),%eax
 3dd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3e0:	80 fb 09             	cmp    $0x9,%bl
 3e3:	76 eb                	jbe    3d0 <atoi+0x20>
  return n;
}
 3e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3e8:	89 c8                	mov    %ecx,%eax
 3ea:	c9                   	leave
 3eb:	c3                   	ret
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	8b 45 10             	mov    0x10(%ebp),%eax
 3f7:	8b 55 08             	mov    0x8(%ebp),%edx
 3fa:	56                   	push   %esi
 3fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3fe:	85 c0                	test   %eax,%eax
 400:	7e 13                	jle    415 <memmove+0x25>
 402:	01 d0                	add    %edx,%eax
  dst = vdst;
 404:	89 d7                	mov    %edx,%edi
 406:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40d:	00 
 40e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 410:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 411:	39 f8                	cmp    %edi,%eax
 413:	75 fb                	jne    410 <memmove+0x20>
  return vdst;
}
 415:	5e                   	pop    %esi
 416:	89 d0                	mov    %edx,%eax
 418:	5f                   	pop    %edi
 419:	5d                   	pop    %ebp
 41a:	c3                   	ret

0000041b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 41b:	b8 01 00 00 00       	mov    $0x1,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <exit>:
SYSCALL(exit)
 423:	b8 02 00 00 00       	mov    $0x2,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <wait>:
SYSCALL(wait)
 42b:	b8 03 00 00 00       	mov    $0x3,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <pipe>:
SYSCALL(pipe)
 433:	b8 04 00 00 00       	mov    $0x4,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <read>:
SYSCALL(read)
 43b:	b8 05 00 00 00       	mov    $0x5,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <write>:
SYSCALL(write)
 443:	b8 10 00 00 00       	mov    $0x10,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <close>:
SYSCALL(close)
 44b:	b8 15 00 00 00       	mov    $0x15,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <kill>:
SYSCALL(kill)
 453:	b8 06 00 00 00       	mov    $0x6,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <exec>:
SYSCALL(exec)
 45b:	b8 07 00 00 00       	mov    $0x7,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <open>:
SYSCALL(open)
 463:	b8 0f 00 00 00       	mov    $0xf,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <mknod>:
SYSCALL(mknod)
 46b:	b8 11 00 00 00       	mov    $0x11,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <unlink>:
SYSCALL(unlink)
 473:	b8 12 00 00 00       	mov    $0x12,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <fstat>:
SYSCALL(fstat)
 47b:	b8 08 00 00 00       	mov    $0x8,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <link>:
SYSCALL(link)
 483:	b8 13 00 00 00       	mov    $0x13,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <mkdir>:
SYSCALL(mkdir)
 48b:	b8 14 00 00 00       	mov    $0x14,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <chdir>:
SYSCALL(chdir)
 493:	b8 09 00 00 00       	mov    $0x9,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <dup>:
SYSCALL(dup)
 49b:	b8 0a 00 00 00       	mov    $0xa,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

000004a3 <getpid>:
SYSCALL(getpid)
 4a3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

000004ab <sbrk>:
SYSCALL(sbrk)
 4ab:	b8 0c 00 00 00       	mov    $0xc,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

000004b3 <sleep>:
SYSCALL(sleep)
 4b3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

000004bb <uptime>:
SYSCALL(uptime)
 4bb:	b8 0e 00 00 00       	mov    $0xe,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret
 4c3:	66 90                	xchg   %ax,%ax
 4c5:	66 90                	xchg   %ax,%ax
 4c7:	66 90                	xchg   %ax,%ax
 4c9:	66 90                	xchg   %ax,%ax
 4cb:	66 90                	xchg   %ax,%ax
 4cd:	66 90                	xchg   %ax,%ax
 4cf:	90                   	nop

000004d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4d8:	89 d1                	mov    %edx,%ecx
{
 4da:	83 ec 3c             	sub    $0x3c,%esp
 4dd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 4e0:	85 d2                	test   %edx,%edx
 4e2:	0f 89 80 00 00 00    	jns    568 <printint+0x98>
 4e8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4ec:	74 7a                	je     568 <printint+0x98>
    x = -xx;
 4ee:	f7 d9                	neg    %ecx
    neg = 1;
 4f0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4f5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 4f8:	31 f6                	xor    %esi,%esi
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 500:	89 c8                	mov    %ecx,%eax
 502:	31 d2                	xor    %edx,%edx
 504:	89 f7                	mov    %esi,%edi
 506:	f7 f3                	div    %ebx
 508:	8d 76 01             	lea    0x1(%esi),%esi
 50b:	0f b6 92 18 09 00 00 	movzbl 0x918(%edx),%edx
 512:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 516:	89 ca                	mov    %ecx,%edx
 518:	89 c1                	mov    %eax,%ecx
 51a:	39 da                	cmp    %ebx,%edx
 51c:	73 e2                	jae    500 <printint+0x30>
  if(neg)
 51e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 521:	85 c0                	test   %eax,%eax
 523:	74 07                	je     52c <printint+0x5c>
    buf[i++] = '-';
 525:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 52a:	89 f7                	mov    %esi,%edi
 52c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 52f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 532:	01 df                	add    %ebx,%edi
 534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 538:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 53b:	83 ec 04             	sub    $0x4,%esp
 53e:	88 45 d7             	mov    %al,-0x29(%ebp)
 541:	8d 45 d7             	lea    -0x29(%ebp),%eax
 544:	6a 01                	push   $0x1
 546:	50                   	push   %eax
 547:	56                   	push   %esi
 548:	e8 f6 fe ff ff       	call   443 <write>
  while(--i >= 0)
 54d:	89 f8                	mov    %edi,%eax
 54f:	83 c4 10             	add    $0x10,%esp
 552:	83 ef 01             	sub    $0x1,%edi
 555:	39 c3                	cmp    %eax,%ebx
 557:	75 df                	jne    538 <printint+0x68>
}
 559:	8d 65 f4             	lea    -0xc(%ebp),%esp
 55c:	5b                   	pop    %ebx
 55d:	5e                   	pop    %esi
 55e:	5f                   	pop    %edi
 55f:	5d                   	pop    %ebp
 560:	c3                   	ret
 561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 568:	31 c0                	xor    %eax,%eax
 56a:	eb 89                	jmp    4f5 <printint+0x25>
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000570 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	57                   	push   %edi
 574:	56                   	push   %esi
 575:	53                   	push   %ebx
 576:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 579:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 57c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 57f:	0f b6 1e             	movzbl (%esi),%ebx
 582:	83 c6 01             	add    $0x1,%esi
 585:	84 db                	test   %bl,%bl
 587:	74 67                	je     5f0 <printf+0x80>
 589:	8d 4d 10             	lea    0x10(%ebp),%ecx
 58c:	31 d2                	xor    %edx,%edx
 58e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 591:	eb 34                	jmp    5c7 <printf+0x57>
 593:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 598:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 59b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5a0:	83 f8 25             	cmp    $0x25,%eax
 5a3:	74 18                	je     5bd <printf+0x4d>
  write(fd, &c, 1);
 5a5:	83 ec 04             	sub    $0x4,%esp
 5a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5ab:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5ae:	6a 01                	push   $0x1
 5b0:	50                   	push   %eax
 5b1:	57                   	push   %edi
 5b2:	e8 8c fe ff ff       	call   443 <write>
 5b7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5ba:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5bd:	0f b6 1e             	movzbl (%esi),%ebx
 5c0:	83 c6 01             	add    $0x1,%esi
 5c3:	84 db                	test   %bl,%bl
 5c5:	74 29                	je     5f0 <printf+0x80>
    c = fmt[i] & 0xff;
 5c7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5ca:	85 d2                	test   %edx,%edx
 5cc:	74 ca                	je     598 <printf+0x28>
      }
    } else if(state == '%'){
 5ce:	83 fa 25             	cmp    $0x25,%edx
 5d1:	75 ea                	jne    5bd <printf+0x4d>
      if(c == 'd'){
 5d3:	83 f8 25             	cmp    $0x25,%eax
 5d6:	0f 84 04 01 00 00    	je     6e0 <printf+0x170>
 5dc:	83 e8 63             	sub    $0x63,%eax
 5df:	83 f8 15             	cmp    $0x15,%eax
 5e2:	77 1c                	ja     600 <printf+0x90>
 5e4:	ff 24 85 c0 08 00 00 	jmp    *0x8c0(,%eax,4)
 5eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f3:	5b                   	pop    %ebx
 5f4:	5e                   	pop    %esi
 5f5:	5f                   	pop    %edi
 5f6:	5d                   	pop    %ebp
 5f7:	c3                   	ret
 5f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ff:	00 
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
 603:	8d 55 e7             	lea    -0x19(%ebp),%edx
 606:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 60a:	6a 01                	push   $0x1
 60c:	52                   	push   %edx
 60d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 610:	57                   	push   %edi
 611:	e8 2d fe ff ff       	call   443 <write>
 616:	83 c4 0c             	add    $0xc,%esp
 619:	88 5d e7             	mov    %bl,-0x19(%ebp)
 61c:	6a 01                	push   $0x1
 61e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 621:	52                   	push   %edx
 622:	57                   	push   %edi
 623:	e8 1b fe ff ff       	call   443 <write>
        putc(fd, c);
 628:	83 c4 10             	add    $0x10,%esp
      state = 0;
 62b:	31 d2                	xor    %edx,%edx
 62d:	eb 8e                	jmp    5bd <printf+0x4d>
 62f:	90                   	nop
        printint(fd, *ap, 16, 0);
 630:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 633:	83 ec 0c             	sub    $0xc,%esp
 636:	b9 10 00 00 00       	mov    $0x10,%ecx
 63b:	8b 13                	mov    (%ebx),%edx
 63d:	6a 00                	push   $0x0
 63f:	89 f8                	mov    %edi,%eax
        ap++;
 641:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 644:	e8 87 fe ff ff       	call   4d0 <printint>
        ap++;
 649:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 64c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 64f:	31 d2                	xor    %edx,%edx
 651:	e9 67 ff ff ff       	jmp    5bd <printf+0x4d>
        s = (char*)*ap;
 656:	8b 45 d0             	mov    -0x30(%ebp),%eax
 659:	8b 18                	mov    (%eax),%ebx
        ap++;
 65b:	83 c0 04             	add    $0x4,%eax
 65e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 661:	85 db                	test   %ebx,%ebx
 663:	0f 84 87 00 00 00    	je     6f0 <printf+0x180>
        while(*s != 0){
 669:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 66c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 66e:	84 c0                	test   %al,%al
 670:	0f 84 47 ff ff ff    	je     5bd <printf+0x4d>
 676:	8d 55 e7             	lea    -0x19(%ebp),%edx
 679:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 67c:	89 de                	mov    %ebx,%esi
 67e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 686:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 689:	6a 01                	push   $0x1
 68b:	53                   	push   %ebx
 68c:	57                   	push   %edi
 68d:	e8 b1 fd ff ff       	call   443 <write>
        while(*s != 0){
 692:	0f b6 06             	movzbl (%esi),%eax
 695:	83 c4 10             	add    $0x10,%esp
 698:	84 c0                	test   %al,%al
 69a:	75 e4                	jne    680 <printf+0x110>
      state = 0;
 69c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 69f:	31 d2                	xor    %edx,%edx
 6a1:	e9 17 ff ff ff       	jmp    5bd <printf+0x4d>
        printint(fd, *ap, 10, 1);
 6a6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6a9:	83 ec 0c             	sub    $0xc,%esp
 6ac:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6b1:	8b 13                	mov    (%ebx),%edx
 6b3:	6a 01                	push   $0x1
 6b5:	eb 88                	jmp    63f <printf+0xcf>
        putc(fd, *ap);
 6b7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6ba:	83 ec 04             	sub    $0x4,%esp
 6bd:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 6c0:	8b 03                	mov    (%ebx),%eax
        ap++;
 6c2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 6c5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6c8:	6a 01                	push   $0x1
 6ca:	52                   	push   %edx
 6cb:	57                   	push   %edi
 6cc:	e8 72 fd ff ff       	call   443 <write>
        ap++;
 6d1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6d4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6d7:	31 d2                	xor    %edx,%edx
 6d9:	e9 df fe ff ff       	jmp    5bd <printf+0x4d>
 6de:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6e6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6e9:	6a 01                	push   $0x1
 6eb:	e9 31 ff ff ff       	jmp    621 <printf+0xb1>
 6f0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 6f5:	bb b9 08 00 00       	mov    $0x8b9,%ebx
 6fa:	e9 77 ff ff ff       	jmp    676 <printf+0x106>
 6ff:	90                   	nop

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 c0 0b 00 00       	mov    0xbc0,%eax
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 70e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 718:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71a:	39 c8                	cmp    %ecx,%eax
 71c:	73 32                	jae    750 <free+0x50>
 71e:	39 d1                	cmp    %edx,%ecx
 720:	72 04                	jb     726 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 722:	39 d0                	cmp    %edx,%eax
 724:	72 32                	jb     758 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 726:	8b 73 fc             	mov    -0x4(%ebx),%esi
 729:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 72c:	39 fa                	cmp    %edi,%edx
 72e:	74 30                	je     760 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 730:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 733:	8b 50 04             	mov    0x4(%eax),%edx
 736:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 739:	39 f1                	cmp    %esi,%ecx
 73b:	74 3a                	je     777 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 73d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 73f:	5b                   	pop    %ebx
  freep = p;
 740:	a3 c0 0b 00 00       	mov    %eax,0xbc0
}
 745:	5e                   	pop    %esi
 746:	5f                   	pop    %edi
 747:	5d                   	pop    %ebp
 748:	c3                   	ret
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 750:	39 d0                	cmp    %edx,%eax
 752:	72 04                	jb     758 <free+0x58>
 754:	39 d1                	cmp    %edx,%ecx
 756:	72 ce                	jb     726 <free+0x26>
{
 758:	89 d0                	mov    %edx,%eax
 75a:	eb bc                	jmp    718 <free+0x18>
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 760:	03 72 04             	add    0x4(%edx),%esi
 763:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 766:	8b 10                	mov    (%eax),%edx
 768:	8b 12                	mov    (%edx),%edx
 76a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 76d:	8b 50 04             	mov    0x4(%eax),%edx
 770:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 773:	39 f1                	cmp    %esi,%ecx
 775:	75 c6                	jne    73d <free+0x3d>
    p->s.size += bp->s.size;
 777:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 77a:	a3 c0 0b 00 00       	mov    %eax,0xbc0
    p->s.size += bp->s.size;
 77f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 782:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 785:	89 08                	mov    %ecx,(%eax)
}
 787:	5b                   	pop    %ebx
 788:	5e                   	pop    %esi
 789:	5f                   	pop    %edi
 78a:	5d                   	pop    %ebp
 78b:	c3                   	ret
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 79c:	8b 15 c0 0b 00 00    	mov    0xbc0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	8d 78 07             	lea    0x7(%eax),%edi
 7a5:	c1 ef 03             	shr    $0x3,%edi
 7a8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7ab:	85 d2                	test   %edx,%edx
 7ad:	0f 84 8d 00 00 00    	je     840 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7b5:	8b 48 04             	mov    0x4(%eax),%ecx
 7b8:	39 f9                	cmp    %edi,%ecx
 7ba:	73 64                	jae    820 <malloc+0x90>
  if(nu < 4096)
 7bc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7c1:	39 df                	cmp    %ebx,%edi
 7c3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7c6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7cd:	eb 0a                	jmp    7d9 <malloc+0x49>
 7cf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7d2:	8b 48 04             	mov    0x4(%eax),%ecx
 7d5:	39 f9                	cmp    %edi,%ecx
 7d7:	73 47                	jae    820 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7d9:	89 c2                	mov    %eax,%edx
 7db:	3b 05 c0 0b 00 00    	cmp    0xbc0,%eax
 7e1:	75 ed                	jne    7d0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7e3:	83 ec 0c             	sub    $0xc,%esp
 7e6:	56                   	push   %esi
 7e7:	e8 bf fc ff ff       	call   4ab <sbrk>
  if(p == (char*)-1)
 7ec:	83 c4 10             	add    $0x10,%esp
 7ef:	83 f8 ff             	cmp    $0xffffffff,%eax
 7f2:	74 1c                	je     810 <malloc+0x80>
  hp->s.size = nu;
 7f4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7f7:	83 ec 0c             	sub    $0xc,%esp
 7fa:	83 c0 08             	add    $0x8,%eax
 7fd:	50                   	push   %eax
 7fe:	e8 fd fe ff ff       	call   700 <free>
  return freep;
 803:	8b 15 c0 0b 00 00    	mov    0xbc0,%edx
      if((p = morecore(nunits)) == 0)
 809:	83 c4 10             	add    $0x10,%esp
 80c:	85 d2                	test   %edx,%edx
 80e:	75 c0                	jne    7d0 <malloc+0x40>
        return 0;
  }
}
 810:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 813:	31 c0                	xor    %eax,%eax
}
 815:	5b                   	pop    %ebx
 816:	5e                   	pop    %esi
 817:	5f                   	pop    %edi
 818:	5d                   	pop    %ebp
 819:	c3                   	ret
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 820:	39 cf                	cmp    %ecx,%edi
 822:	74 4c                	je     870 <malloc+0xe0>
        p->s.size -= nunits;
 824:	29 f9                	sub    %edi,%ecx
 826:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 829:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 82c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 82f:	89 15 c0 0b 00 00    	mov    %edx,0xbc0
}
 835:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 838:	83 c0 08             	add    $0x8,%eax
}
 83b:	5b                   	pop    %ebx
 83c:	5e                   	pop    %esi
 83d:	5f                   	pop    %edi
 83e:	5d                   	pop    %ebp
 83f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 840:	c7 05 c0 0b 00 00 c4 	movl   $0xbc4,0xbc0
 847:	0b 00 00 
    base.s.size = 0;
 84a:	b8 c4 0b 00 00       	mov    $0xbc4,%eax
    base.s.ptr = freep = prevp = &base;
 84f:	c7 05 c4 0b 00 00 c4 	movl   $0xbc4,0xbc4
 856:	0b 00 00 
    base.s.size = 0;
 859:	c7 05 c8 0b 00 00 00 	movl   $0x0,0xbc8
 860:	00 00 00 
    if(p->s.size >= nunits){
 863:	e9 54 ff ff ff       	jmp    7bc <malloc+0x2c>
 868:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 86f:	00 
        prevp->s.ptr = p->s.ptr;
 870:	8b 08                	mov    (%eax),%ecx
 872:	89 0a                	mov    %ecx,(%edx)
 874:	eb b9                	jmp    82f <malloc+0x9f>
