
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	b8 30 00 00 00       	mov    $0x30,%eax
   c:	ff 71 fc             	push   -0x4(%ecx)
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %edi
  13:	56                   	push   %esi
  14:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
  1a:	53                   	push   %ebx
  1b:	31 db                	xor    %ebx,%ebx
  1d:	51                   	push   %ecx
  1e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  24:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  2b:	68 c8 07 00 00       	push   $0x7c8
  30:	6a 01                	push   $0x1
  32:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  39:	74 72 65 
  3c:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  43:	73 66 73 
  46:	e8 75 04 00 00       	call   4c0 <printf>
  4b:	83 c4 0c             	add    $0xc,%esp
  4e:	68 00 02 00 00       	push   $0x200
  53:	6a 61                	push   $0x61
  55:	56                   	push   %esi
  56:	e8 85 01 00 00       	call   1e0 <memset>
  5b:	83 c4 10             	add    $0x10,%esp
  5e:	e8 08 03 00 00       	call   36b <fork>
  63:	85 c0                	test   %eax,%eax
  65:	7f 08                	jg     6f <main+0x6f>
  67:	83 c3 01             	add    $0x1,%ebx
  6a:	83 fb 04             	cmp    $0x4,%ebx
  6d:	75 ef                	jne    5e <main+0x5e>
  6f:	83 ec 04             	sub    $0x4,%esp
  72:	53                   	push   %ebx
  73:	68 db 07 00 00       	push   $0x7db
  78:	6a 01                	push   $0x1
  7a:	e8 41 04 00 00       	call   4c0 <printf>
  7f:	5f                   	pop    %edi
  80:	58                   	pop    %eax
  81:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  87:	68 02 02 00 00       	push   $0x202
  8c:	50                   	push   %eax
  8d:	00 9d e6 fd ff ff    	add    %bl,-0x21a(%ebp)
  93:	bb 14 00 00 00       	mov    $0x14,%ebx
  98:	e8 16 03 00 00       	call   3b3 <open>
  9d:	83 c4 10             	add    $0x10,%esp
  a0:	89 c7                	mov    %eax,%edi
  a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a8:	83 ec 04             	sub    $0x4,%esp
  ab:	68 00 02 00 00       	push   $0x200
  b0:	56                   	push   %esi
  b1:	57                   	push   %edi
  b2:	e8 dc 02 00 00       	call   393 <write>
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	83 eb 01             	sub    $0x1,%ebx
  bd:	75 e9                	jne    a8 <main+0xa8>
  bf:	83 ec 0c             	sub    $0xc,%esp
  c2:	57                   	push   %edi
  c3:	e8 d3 02 00 00       	call   39b <close>
  c8:	58                   	pop    %eax
  c9:	5a                   	pop    %edx
  ca:	68 e5 07 00 00       	push   $0x7e5
  cf:	6a 01                	push   $0x1
  d1:	e8 ea 03 00 00       	call   4c0 <printf>
  d6:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  dc:	59                   	pop    %ecx
  dd:	5b                   	pop    %ebx
  de:	6a 00                	push   $0x0
  e0:	bb 14 00 00 00       	mov    $0x14,%ebx
  e5:	50                   	push   %eax
  e6:	e8 c8 02 00 00       	call   3b3 <open>
  eb:	83 c4 10             	add    $0x10,%esp
  ee:	89 c7                	mov    %eax,%edi
  f0:	83 ec 04             	sub    $0x4,%esp
  f3:	68 00 02 00 00       	push   $0x200
  f8:	56                   	push   %esi
  f9:	57                   	push   %edi
  fa:	e8 8c 02 00 00       	call   38b <read>
  ff:	83 c4 10             	add    $0x10,%esp
 102:	83 eb 01             	sub    $0x1,%ebx
 105:	75 e9                	jne    f0 <main+0xf0>
 107:	83 ec 0c             	sub    $0xc,%esp
 10a:	57                   	push   %edi
 10b:	e8 8b 02 00 00       	call   39b <close>
 110:	e8 66 02 00 00       	call   37b <wait>
 115:	e8 59 02 00 00       	call   373 <exit>
 11a:	66 90                	xchg   %ax,%ax
 11c:	66 90                	xchg   %ax,%ax
 11e:	66 90                	xchg   %ax,%ax

00000120 <strcpy>:
 120:	55                   	push   %ebp
 121:	31 c0                	xor    %eax,%eax
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	83 c0 01             	add    $0x1,%eax
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strcpy+0x10>
 13e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 141:	89 c8                	mov    %ecx,%eax
 143:	c9                   	leave
 144:	c3                   	ret
 145:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14c:	00 
 14d:	8d 76 00             	lea    0x0(%esi),%esi

00000150 <strcmp>:
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 55 08             	mov    0x8(%ebp),%edx
 157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 15a:	0f b6 02             	movzbl (%edx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 17                	jne    178 <strcmp+0x28>
 161:	eb 3a                	jmp    19d <strcmp+0x4d>
 163:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 168:	0f b6 42 01          	movzbl 0x1(%edx),%eax
 16c:	83 c2 01             	add    $0x1,%edx
 16f:	8d 59 01             	lea    0x1(%ecx),%ebx
 172:	84 c0                	test   %al,%al
 174:	74 1a                	je     190 <strcmp+0x40>
 176:	89 d9                	mov    %ebx,%ecx
 178:	0f b6 19             	movzbl (%ecx),%ebx
 17b:	38 c3                	cmp    %al,%bl
 17d:	74 e9                	je     168 <strcmp+0x18>
 17f:	29 d8                	sub    %ebx,%eax
 181:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 184:	c9                   	leave
 185:	c3                   	ret
 186:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18d:	00 
 18e:	66 90                	xchg   %ax,%ax
 190:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 194:	31 c0                	xor    %eax,%eax
 196:	29 d8                	sub    %ebx,%eax
 198:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 19b:	c9                   	leave
 19c:	c3                   	ret
 19d:	0f b6 19             	movzbl (%ecx),%ebx
 1a0:	31 c0                	xor    %eax,%eax
 1a2:	eb db                	jmp    17f <strcmp+0x2f>
 1a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ab:	00 
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <strlen>:
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
 1b6:	80 3a 00             	cmpb   $0x0,(%edx)
 1b9:	74 15                	je     1d0 <strlen+0x20>
 1bb:	31 c0                	xor    %eax,%eax
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	83 c0 01             	add    $0x1,%eax
 1c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1c7:	89 c1                	mov    %eax,%ecx
 1c9:	75 f5                	jne    1c0 <strlen+0x10>
 1cb:	89 c8                	mov    %ecx,%eax
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret
 1cf:	90                   	nop
 1d0:	31 c9                	xor    %ecx,%ecx
 1d2:	5d                   	pop    %ebp
 1d3:	89 c8                	mov    %ecx,%eax
 1d5:	c3                   	ret
 1d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1dd:	00 
 1de:	66 90                	xchg   %ax,%ax

000001e0 <memset>:
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
 1e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 d7                	mov    %edx,%edi
 1ef:	fc                   	cld
 1f0:	f3 aa                	rep stos %al,%es:(%edi)
 1f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1f5:	89 d0                	mov    %edx,%eax
 1f7:	c9                   	leave
 1f8:	c3                   	ret
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000200 <strchr>:
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 20a:	0f b6 10             	movzbl (%eax),%edx
 20d:	84 d2                	test   %dl,%dl
 20f:	75 12                	jne    223 <strchr+0x23>
 211:	eb 1d                	jmp    230 <strchr+0x30>
 213:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 218:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 21c:	83 c0 01             	add    $0x1,%eax
 21f:	84 d2                	test   %dl,%dl
 221:	74 0d                	je     230 <strchr+0x30>
 223:	38 d1                	cmp    %dl,%cl
 225:	75 f1                	jne    218 <strchr+0x18>
 227:	5d                   	pop    %ebp
 228:	c3                   	ret
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	31 c0                	xor    %eax,%eax
 232:	5d                   	pop    %ebp
 233:	c3                   	ret
 234:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23b:	00 
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000240 <gets>:
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
 245:	8d 7d e7             	lea    -0x19(%ebp),%edi
 248:	53                   	push   %ebx
 249:	31 db                	xor    %ebx,%ebx
 24b:	8d 73 01             	lea    0x1(%ebx),%esi
 24e:	83 ec 1c             	sub    $0x1c,%esp
 251:	3b 75 0c             	cmp    0xc(%ebp),%esi
 254:	7d 3b                	jge    291 <gets+0x51>
 256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25d:	00 
 25e:	66 90                	xchg   %ax,%ax
 260:	83 ec 04             	sub    $0x4,%esp
 263:	6a 01                	push   $0x1
 265:	57                   	push   %edi
 266:	6a 00                	push   $0x0
 268:	e8 1e 01 00 00       	call   38b <read>
 26d:	83 c4 10             	add    $0x10,%esp
 270:	85 c0                	test   %eax,%eax
 272:	7e 1d                	jle    291 <gets+0x51>
 274:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 278:	8b 55 08             	mov    0x8(%ebp),%edx
 27b:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
 27f:	3c 0a                	cmp    $0xa,%al
 281:	7f 25                	jg     2a8 <gets+0x68>
 283:	3c 08                	cmp    $0x8,%al
 285:	7f 0c                	jg     293 <gets+0x53>
 287:	89 f3                	mov    %esi,%ebx
 289:	8d 73 01             	lea    0x1(%ebx),%esi
 28c:	3b 75 0c             	cmp    0xc(%ebp),%esi
 28f:	7c cf                	jl     260 <gets+0x20>
 291:	89 de                	mov    %ebx,%esi
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 29a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 29d:	5b                   	pop    %ebx
 29e:	5e                   	pop    %esi
 29f:	5f                   	pop    %edi
 2a0:	5d                   	pop    %ebp
 2a1:	c3                   	ret
 2a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2a8:	3c 0d                	cmp    $0xd,%al
 2aa:	74 e7                	je     293 <gets+0x53>
 2ac:	89 f3                	mov    %esi,%ebx
 2ae:	eb d9                	jmp    289 <gets+0x49>

000002b0 <stat>:
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
 2b5:	83 ec 08             	sub    $0x8,%esp
 2b8:	6a 00                	push   $0x0
 2ba:	ff 75 08             	push   0x8(%ebp)
 2bd:	e8 f1 00 00 00       	call   3b3 <open>
 2c2:	83 c4 10             	add    $0x10,%esp
 2c5:	85 c0                	test   %eax,%eax
 2c7:	78 27                	js     2f0 <stat+0x40>
 2c9:	83 ec 08             	sub    $0x8,%esp
 2cc:	ff 75 0c             	push   0xc(%ebp)
 2cf:	89 c3                	mov    %eax,%ebx
 2d1:	50                   	push   %eax
 2d2:	e8 f4 00 00 00       	call   3cb <fstat>
 2d7:	89 1c 24             	mov    %ebx,(%esp)
 2da:	89 c6                	mov    %eax,%esi
 2dc:	e8 ba 00 00 00       	call   39b <close>
 2e1:	83 c4 10             	add    $0x10,%esp
 2e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2e7:	89 f0                	mov    %esi,%eax
 2e9:	5b                   	pop    %ebx
 2ea:	5e                   	pop    %esi
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
 2f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2f5:	eb ed                	jmp    2e4 <stat+0x34>
 2f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2fe:	00 
 2ff:	90                   	nop

00000300 <atoi>:
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	53                   	push   %ebx
 304:	8b 55 08             	mov    0x8(%ebp),%edx
 307:	0f be 02             	movsbl (%edx),%eax
 30a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 30d:	80 f9 09             	cmp    $0x9,%cl
 310:	b9 00 00 00 00       	mov    $0x0,%ecx
 315:	77 1e                	ja     335 <atoi+0x35>
 317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31e:	00 
 31f:	90                   	nop
 320:	83 c2 01             	add    $0x1,%edx
 323:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 326:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 32a:	0f be 02             	movsbl (%edx),%eax
 32d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 330:	80 fb 09             	cmp    $0x9,%bl
 333:	76 eb                	jbe    320 <atoi+0x20>
 335:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 338:	89 c8                	mov    %ecx,%eax
 33a:	c9                   	leave
 33b:	c3                   	ret
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000340 <memmove>:
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	8b 45 10             	mov    0x10(%ebp),%eax
 347:	8b 55 08             	mov    0x8(%ebp),%edx
 34a:	56                   	push   %esi
 34b:	8b 75 0c             	mov    0xc(%ebp),%esi
 34e:	85 c0                	test   %eax,%eax
 350:	7e 13                	jle    365 <memmove+0x25>
 352:	01 d0                	add    %edx,%eax
 354:	89 d7                	mov    %edx,%edi
 356:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35d:	00 
 35e:	66 90                	xchg   %ax,%ax
 360:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 361:	39 f8                	cmp    %edi,%eax
 363:	75 fb                	jne    360 <memmove+0x20>
 365:	5e                   	pop    %esi
 366:	89 d0                	mov    %edx,%eax
 368:	5f                   	pop    %edi
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret

0000036b <fork>:
 36b:	b8 01 00 00 00       	mov    $0x1,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <exit>:
 373:	b8 02 00 00 00       	mov    $0x2,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <wait>:
 37b:	b8 03 00 00 00       	mov    $0x3,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <pipe>:
 383:	b8 04 00 00 00       	mov    $0x4,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <read>:
 38b:	b8 05 00 00 00       	mov    $0x5,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <write>:
 393:	b8 10 00 00 00       	mov    $0x10,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <close>:
 39b:	b8 15 00 00 00       	mov    $0x15,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <kill>:
 3a3:	b8 06 00 00 00       	mov    $0x6,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <exec>:
 3ab:	b8 07 00 00 00       	mov    $0x7,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <open>:
 3b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <mknod>:
 3bb:	b8 11 00 00 00       	mov    $0x11,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <unlink>:
 3c3:	b8 12 00 00 00       	mov    $0x12,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <fstat>:
 3cb:	b8 08 00 00 00       	mov    $0x8,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <link>:
 3d3:	b8 13 00 00 00       	mov    $0x13,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <mkdir>:
 3db:	b8 14 00 00 00       	mov    $0x14,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <chdir>:
 3e3:	b8 09 00 00 00       	mov    $0x9,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <dup>:
 3eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <getpid>:
 3f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <sbrk>:
 3fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <sleep>:
 403:	b8 0d 00 00 00       	mov    $0xd,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <uptime>:
 40b:	b8 0e 00 00 00       	mov    $0xe,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret
 413:	66 90                	xchg   %ax,%ax
 415:	66 90                	xchg   %ax,%ax
 417:	66 90                	xchg   %ax,%ax
 419:	66 90                	xchg   %ax,%ax
 41b:	66 90                	xchg   %ax,%ax
 41d:	66 90                	xchg   %ax,%ax
 41f:	90                   	nop

00000420 <printint>:
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	89 cb                	mov    %ecx,%ebx
 428:	89 d1                	mov    %edx,%ecx
 42a:	83 ec 3c             	sub    $0x3c,%esp
 42d:	89 45 c0             	mov    %eax,-0x40(%ebp)
 430:	85 d2                	test   %edx,%edx
 432:	0f 89 80 00 00 00    	jns    4b8 <printint+0x98>
 438:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 43c:	74 7a                	je     4b8 <printint+0x98>
 43e:	f7 d9                	neg    %ecx
 440:	b8 01 00 00 00       	mov    $0x1,%eax
 445:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 448:	31 f6                	xor    %esi,%esi
 44a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 450:	89 c8                	mov    %ecx,%eax
 452:	31 d2                	xor    %edx,%edx
 454:	89 f7                	mov    %esi,%edi
 456:	f7 f3                	div    %ebx
 458:	8d 76 01             	lea    0x1(%esi),%esi
 45b:	0f b6 92 4c 08 00 00 	movzbl 0x84c(%edx),%edx
 462:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
 466:	89 ca                	mov    %ecx,%edx
 468:	89 c1                	mov    %eax,%ecx
 46a:	39 da                	cmp    %ebx,%edx
 46c:	73 e2                	jae    450 <printint+0x30>
 46e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 471:	85 c0                	test   %eax,%eax
 473:	74 07                	je     47c <printint+0x5c>
 475:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 47a:	89 f7                	mov    %esi,%edi
 47c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 47f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 482:	01 df                	add    %ebx,%edi
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 488:	0f b6 07             	movzbl (%edi),%eax
 48b:	83 ec 04             	sub    $0x4,%esp
 48e:	88 45 d7             	mov    %al,-0x29(%ebp)
 491:	8d 45 d7             	lea    -0x29(%ebp),%eax
 494:	6a 01                	push   $0x1
 496:	50                   	push   %eax
 497:	56                   	push   %esi
 498:	e8 f6 fe ff ff       	call   393 <write>
 49d:	89 f8                	mov    %edi,%eax
 49f:	83 c4 10             	add    $0x10,%esp
 4a2:	83 ef 01             	sub    $0x1,%edi
 4a5:	39 c3                	cmp    %eax,%ebx
 4a7:	75 df                	jne    488 <printint+0x68>
 4a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ac:	5b                   	pop    %ebx
 4ad:	5e                   	pop    %esi
 4ae:	5f                   	pop    %edi
 4af:	5d                   	pop    %ebp
 4b0:	c3                   	ret
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4b8:	31 c0                	xor    %eax,%eax
 4ba:	eb 89                	jmp    445 <printint+0x25>
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004c0 <printf>:
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 2c             	sub    $0x2c,%esp
 4c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4cc:	8b 7d 08             	mov    0x8(%ebp),%edi
 4cf:	0f b6 1e             	movzbl (%esi),%ebx
 4d2:	83 c6 01             	add    $0x1,%esi
 4d5:	84 db                	test   %bl,%bl
 4d7:	74 67                	je     540 <printf+0x80>
 4d9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4dc:	31 d2                	xor    %edx,%edx
 4de:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4e1:	eb 34                	jmp    517 <printf+0x57>
 4e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4e8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4eb:	ba 25 00 00 00       	mov    $0x25,%edx
 4f0:	83 f8 25             	cmp    $0x25,%eax
 4f3:	74 18                	je     50d <printf+0x4d>
 4f5:	83 ec 04             	sub    $0x4,%esp
 4f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4fb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4fe:	6a 01                	push   $0x1
 500:	50                   	push   %eax
 501:	57                   	push   %edi
 502:	e8 8c fe ff ff       	call   393 <write>
 507:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 50a:	83 c4 10             	add    $0x10,%esp
 50d:	0f b6 1e             	movzbl (%esi),%ebx
 510:	83 c6 01             	add    $0x1,%esi
 513:	84 db                	test   %bl,%bl
 515:	74 29                	je     540 <printf+0x80>
 517:	0f b6 c3             	movzbl %bl,%eax
 51a:	85 d2                	test   %edx,%edx
 51c:	74 ca                	je     4e8 <printf+0x28>
 51e:	83 fa 25             	cmp    $0x25,%edx
 521:	75 ea                	jne    50d <printf+0x4d>
 523:	83 f8 25             	cmp    $0x25,%eax
 526:	0f 84 04 01 00 00    	je     630 <printf+0x170>
 52c:	83 e8 63             	sub    $0x63,%eax
 52f:	83 f8 15             	cmp    $0x15,%eax
 532:	77 1c                	ja     550 <printf+0x90>
 534:	ff 24 85 f4 07 00 00 	jmp    *0x7f4(,%eax,4)
 53b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 540:	8d 65 f4             	lea    -0xc(%ebp),%esp
 543:	5b                   	pop    %ebx
 544:	5e                   	pop    %esi
 545:	5f                   	pop    %edi
 546:	5d                   	pop    %ebp
 547:	c3                   	ret
 548:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 54f:	00 
 550:	83 ec 04             	sub    $0x4,%esp
 553:	8d 55 e7             	lea    -0x19(%ebp),%edx
 556:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 55a:	6a 01                	push   $0x1
 55c:	52                   	push   %edx
 55d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 560:	57                   	push   %edi
 561:	e8 2d fe ff ff       	call   393 <write>
 566:	83 c4 0c             	add    $0xc,%esp
 569:	88 5d e7             	mov    %bl,-0x19(%ebp)
 56c:	6a 01                	push   $0x1
 56e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 571:	52                   	push   %edx
 572:	57                   	push   %edi
 573:	e8 1b fe ff ff       	call   393 <write>
 578:	83 c4 10             	add    $0x10,%esp
 57b:	31 d2                	xor    %edx,%edx
 57d:	eb 8e                	jmp    50d <printf+0x4d>
 57f:	90                   	nop
 580:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 583:	83 ec 0c             	sub    $0xc,%esp
 586:	b9 10 00 00 00       	mov    $0x10,%ecx
 58b:	8b 13                	mov    (%ebx),%edx
 58d:	6a 00                	push   $0x0
 58f:	89 f8                	mov    %edi,%eax
 591:	83 c3 04             	add    $0x4,%ebx
 594:	e8 87 fe ff ff       	call   420 <printint>
 599:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 59c:	83 c4 10             	add    $0x10,%esp
 59f:	31 d2                	xor    %edx,%edx
 5a1:	e9 67 ff ff ff       	jmp    50d <printf+0x4d>
 5a6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5a9:	8b 18                	mov    (%eax),%ebx
 5ab:	83 c0 04             	add    $0x4,%eax
 5ae:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5b1:	85 db                	test   %ebx,%ebx
 5b3:	0f 84 87 00 00 00    	je     640 <printf+0x180>
 5b9:	0f b6 03             	movzbl (%ebx),%eax
 5bc:	31 d2                	xor    %edx,%edx
 5be:	84 c0                	test   %al,%al
 5c0:	0f 84 47 ff ff ff    	je     50d <printf+0x4d>
 5c6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5c9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5cc:	89 de                	mov    %ebx,%esi
 5ce:	89 d3                	mov    %edx,%ebx
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	88 45 e7             	mov    %al,-0x19(%ebp)
 5d6:	83 c6 01             	add    $0x1,%esi
 5d9:	6a 01                	push   $0x1
 5db:	53                   	push   %ebx
 5dc:	57                   	push   %edi
 5dd:	e8 b1 fd ff ff       	call   393 <write>
 5e2:	0f b6 06             	movzbl (%esi),%eax
 5e5:	83 c4 10             	add    $0x10,%esp
 5e8:	84 c0                	test   %al,%al
 5ea:	75 e4                	jne    5d0 <printf+0x110>
 5ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5ef:	31 d2                	xor    %edx,%edx
 5f1:	e9 17 ff ff ff       	jmp    50d <printf+0x4d>
 5f6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5f9:	83 ec 0c             	sub    $0xc,%esp
 5fc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 601:	8b 13                	mov    (%ebx),%edx
 603:	6a 01                	push   $0x1
 605:	eb 88                	jmp    58f <printf+0xcf>
 607:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 60a:	83 ec 04             	sub    $0x4,%esp
 60d:	8d 55 e7             	lea    -0x19(%ebp),%edx
 610:	8b 03                	mov    (%ebx),%eax
 612:	83 c3 04             	add    $0x4,%ebx
 615:	88 45 e7             	mov    %al,-0x19(%ebp)
 618:	6a 01                	push   $0x1
 61a:	52                   	push   %edx
 61b:	57                   	push   %edi
 61c:	e8 72 fd ff ff       	call   393 <write>
 621:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 624:	83 c4 10             	add    $0x10,%esp
 627:	31 d2                	xor    %edx,%edx
 629:	e9 df fe ff ff       	jmp    50d <printf+0x4d>
 62e:	66 90                	xchg   %ax,%ax
 630:	83 ec 04             	sub    $0x4,%esp
 633:	88 5d e7             	mov    %bl,-0x19(%ebp)
 636:	8d 55 e7             	lea    -0x19(%ebp),%edx
 639:	6a 01                	push   $0x1
 63b:	e9 31 ff ff ff       	jmp    571 <printf+0xb1>
 640:	b8 28 00 00 00       	mov    $0x28,%eax
 645:	bb eb 07 00 00       	mov    $0x7eb,%ebx
 64a:	e9 77 ff ff ff       	jmp    5c6 <printf+0x106>
 64f:	90                   	nop

00000650 <free>:
 650:	55                   	push   %ebp
 651:	a1 f8 0a 00 00       	mov    0xaf8,%eax
 656:	89 e5                	mov    %esp,%ebp
 658:	57                   	push   %edi
 659:	56                   	push   %esi
 65a:	53                   	push   %ebx
 65b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 65e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 668:	8b 10                	mov    (%eax),%edx
 66a:	39 c8                	cmp    %ecx,%eax
 66c:	73 32                	jae    6a0 <free+0x50>
 66e:	39 d1                	cmp    %edx,%ecx
 670:	72 04                	jb     676 <free+0x26>
 672:	39 d0                	cmp    %edx,%eax
 674:	72 32                	jb     6a8 <free+0x58>
 676:	8b 73 fc             	mov    -0x4(%ebx),%esi
 679:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 67c:	39 fa                	cmp    %edi,%edx
 67e:	74 30                	je     6b0 <free+0x60>
 680:	89 53 f8             	mov    %edx,-0x8(%ebx)
 683:	8b 50 04             	mov    0x4(%eax),%edx
 686:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 689:	39 f1                	cmp    %esi,%ecx
 68b:	74 3a                	je     6c7 <free+0x77>
 68d:	89 08                	mov    %ecx,(%eax)
 68f:	5b                   	pop    %ebx
 690:	a3 f8 0a 00 00       	mov    %eax,0xaf8
 695:	5e                   	pop    %esi
 696:	5f                   	pop    %edi
 697:	5d                   	pop    %ebp
 698:	c3                   	ret
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a0:	39 d0                	cmp    %edx,%eax
 6a2:	72 04                	jb     6a8 <free+0x58>
 6a4:	39 d1                	cmp    %edx,%ecx
 6a6:	72 ce                	jb     676 <free+0x26>
 6a8:	89 d0                	mov    %edx,%eax
 6aa:	eb bc                	jmp    668 <free+0x18>
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6b0:	03 72 04             	add    0x4(%edx),%esi
 6b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
 6b6:	8b 10                	mov    (%eax),%edx
 6b8:	8b 12                	mov    (%edx),%edx
 6ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6bd:	8b 50 04             	mov    0x4(%eax),%edx
 6c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6c3:	39 f1                	cmp    %esi,%ecx
 6c5:	75 c6                	jne    68d <free+0x3d>
 6c7:	03 53 fc             	add    -0x4(%ebx),%edx
 6ca:	a3 f8 0a 00 00       	mov    %eax,0xaf8
 6cf:	89 50 04             	mov    %edx,0x4(%eax)
 6d2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6d5:	89 08                	mov    %ecx,(%eax)
 6d7:	5b                   	pop    %ebx
 6d8:	5e                   	pop    %esi
 6d9:	5f                   	pop    %edi
 6da:	5d                   	pop    %ebp
 6db:	c3                   	ret
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006e0 <malloc>:
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 0c             	sub    $0xc,%esp
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ec:	8b 15 f8 0a 00 00    	mov    0xaf8,%edx
 6f2:	8d 78 07             	lea    0x7(%eax),%edi
 6f5:	c1 ef 03             	shr    $0x3,%edi
 6f8:	83 c7 01             	add    $0x1,%edi
 6fb:	85 d2                	test   %edx,%edx
 6fd:	0f 84 8d 00 00 00    	je     790 <malloc+0xb0>
 703:	8b 02                	mov    (%edx),%eax
 705:	8b 48 04             	mov    0x4(%eax),%ecx
 708:	39 f9                	cmp    %edi,%ecx
 70a:	73 64                	jae    770 <malloc+0x90>
 70c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 711:	39 df                	cmp    %ebx,%edi
 713:	0f 43 df             	cmovae %edi,%ebx
 716:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 71d:	eb 0a                	jmp    729 <malloc+0x49>
 71f:	90                   	nop
 720:	8b 02                	mov    (%edx),%eax
 722:	8b 48 04             	mov    0x4(%eax),%ecx
 725:	39 f9                	cmp    %edi,%ecx
 727:	73 47                	jae    770 <malloc+0x90>
 729:	89 c2                	mov    %eax,%edx
 72b:	3b 05 f8 0a 00 00    	cmp    0xaf8,%eax
 731:	75 ed                	jne    720 <malloc+0x40>
 733:	83 ec 0c             	sub    $0xc,%esp
 736:	56                   	push   %esi
 737:	e8 bf fc ff ff       	call   3fb <sbrk>
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	83 f8 ff             	cmp    $0xffffffff,%eax
 742:	74 1c                	je     760 <malloc+0x80>
 744:	89 58 04             	mov    %ebx,0x4(%eax)
 747:	83 ec 0c             	sub    $0xc,%esp
 74a:	83 c0 08             	add    $0x8,%eax
 74d:	50                   	push   %eax
 74e:	e8 fd fe ff ff       	call   650 <free>
 753:	8b 15 f8 0a 00 00    	mov    0xaf8,%edx
 759:	83 c4 10             	add    $0x10,%esp
 75c:	85 d2                	test   %edx,%edx
 75e:	75 c0                	jne    720 <malloc+0x40>
 760:	8d 65 f4             	lea    -0xc(%ebp),%esp
 763:	31 c0                	xor    %eax,%eax
 765:	5b                   	pop    %ebx
 766:	5e                   	pop    %esi
 767:	5f                   	pop    %edi
 768:	5d                   	pop    %ebp
 769:	c3                   	ret
 76a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 770:	39 cf                	cmp    %ecx,%edi
 772:	74 4c                	je     7c0 <malloc+0xe0>
 774:	29 f9                	sub    %edi,%ecx
 776:	89 48 04             	mov    %ecx,0x4(%eax)
 779:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 77c:	89 78 04             	mov    %edi,0x4(%eax)
 77f:	89 15 f8 0a 00 00    	mov    %edx,0xaf8
 785:	8d 65 f4             	lea    -0xc(%ebp),%esp
 788:	83 c0 08             	add    $0x8,%eax
 78b:	5b                   	pop    %ebx
 78c:	5e                   	pop    %esi
 78d:	5f                   	pop    %edi
 78e:	5d                   	pop    %ebp
 78f:	c3                   	ret
 790:	c7 05 f8 0a 00 00 fc 	movl   $0xafc,0xaf8
 797:	0a 00 00 
 79a:	b8 fc 0a 00 00       	mov    $0xafc,%eax
 79f:	c7 05 fc 0a 00 00 fc 	movl   $0xafc,0xafc
 7a6:	0a 00 00 
 7a9:	c7 05 00 0b 00 00 00 	movl   $0x0,0xb00
 7b0:	00 00 00 
 7b3:	e9 54 ff ff ff       	jmp    70c <malloc+0x2c>
 7b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7bf:	00 
 7c0:	8b 08                	mov    (%eax),%ecx
 7c2:	89 0a                	mov    %ecx,(%edx)
 7c4:	eb b9                	jmp    77f <malloc+0x9f>
