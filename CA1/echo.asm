
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 47                	jle    65 <main+0x65>
  1e:	8b 47 04             	mov    0x4(%edi),%eax
  21:	83 fe 02             	cmp    $0x2,%esi
  24:	74 2a                	je     50 <main+0x50>
  26:	bb 02 00 00 00       	mov    $0x2,%ebx
  2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  30:	68 18 07 00 00       	push   $0x718
  35:	83 c3 01             	add    $0x1,%ebx
  38:	50                   	push   %eax
  39:	68 1a 07 00 00       	push   $0x71a
  3e:	6a 01                	push   $0x1
  40:	e8 cb 03 00 00       	call   410 <printf>
  45:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  49:	83 c4 10             	add    $0x10,%esp
  4c:	39 de                	cmp    %ebx,%esi
  4e:	75 e0                	jne    30 <main+0x30>
  50:	68 1f 07 00 00       	push   $0x71f
  55:	50                   	push   %eax
  56:	68 1a 07 00 00       	push   $0x71a
  5b:	6a 01                	push   $0x1
  5d:	e8 ae 03 00 00       	call   410 <printf>
  62:	83 c4 10             	add    $0x10,%esp
  65:	e8 59 02 00 00       	call   2c3 <exit>
  6a:	66 90                	xchg   %ax,%ax
  6c:	66 90                	xchg   %ax,%ax
  6e:	66 90                	xchg   %ax,%ax

00000070 <strcpy>:
  70:	55                   	push   %ebp
  71:	31 c0                	xor    %eax,%eax
  73:	89 e5                	mov    %esp,%ebp
  75:	53                   	push   %ebx
  76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  84:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  87:	83 c0 01             	add    $0x1,%eax
  8a:	84 d2                	test   %dl,%dl
  8c:	75 f2                	jne    80 <strcpy+0x10>
  8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  91:	89 c8                	mov    %ecx,%eax
  93:	c9                   	leave
  94:	c3                   	ret
  95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  9c:	00 
  9d:	8d 76 00             	lea    0x0(%esi),%esi

000000a0 <strcmp>:
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 55 08             	mov    0x8(%ebp),%edx
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	84 c0                	test   %al,%al
  af:	75 17                	jne    c8 <strcmp+0x28>
  b1:	eb 3a                	jmp    ed <strcmp+0x4d>
  b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  b8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  bc:	83 c2 01             	add    $0x1,%edx
  bf:	8d 59 01             	lea    0x1(%ecx),%ebx
  c2:	84 c0                	test   %al,%al
  c4:	74 1a                	je     e0 <strcmp+0x40>
  c6:	89 d9                	mov    %ebx,%ecx
  c8:	0f b6 19             	movzbl (%ecx),%ebx
  cb:	38 c3                	cmp    %al,%bl
  cd:	74 e9                	je     b8 <strcmp+0x18>
  cf:	29 d8                	sub    %ebx,%eax
  d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  d4:	c9                   	leave
  d5:	c3                   	ret
  d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  dd:	00 
  de:	66 90                	xchg   %ax,%ax
  e0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  e4:	31 c0                	xor    %eax,%eax
  e6:	29 d8                	sub    %ebx,%eax
  e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  eb:	c9                   	leave
  ec:	c3                   	ret
  ed:	0f b6 19             	movzbl (%ecx),%ebx
  f0:	31 c0                	xor    %eax,%eax
  f2:	eb db                	jmp    cf <strcmp+0x2f>
  f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fb:	00 
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000100 <strlen>:
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
 106:	80 3a 00             	cmpb   $0x0,(%edx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 c0                	xor    %eax,%eax
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c0 01             	add    $0x1,%eax
 113:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 117:	89 c1                	mov    %eax,%ecx
 119:	75 f5                	jne    110 <strlen+0x10>
 11b:	89 c8                	mov    %ecx,%eax
 11d:	5d                   	pop    %ebp
 11e:	c3                   	ret
 11f:	90                   	nop
 120:	31 c9                	xor    %ecx,%ecx
 122:	5d                   	pop    %ebp
 123:	89 c8                	mov    %ecx,%eax
 125:	c3                   	ret
 126:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12d:	00 
 12e:	66 90                	xchg   %ax,%ax

00000130 <memset>:
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld
 140:	f3 aa                	rep stos %al,%es:(%edi)
 142:	8b 7d fc             	mov    -0x4(%ebp),%edi
 145:	89 d0                	mov    %edx,%eax
 147:	c9                   	leave
 148:	c3                   	ret
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000150 <strchr>:
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 12                	jne    173 <strchr+0x23>
 161:	eb 1d                	jmp    180 <strchr+0x30>
 163:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 168:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 16c:	83 c0 01             	add    $0x1,%eax
 16f:	84 d2                	test   %dl,%dl
 171:	74 0d                	je     180 <strchr+0x30>
 173:	38 d1                	cmp    %dl,%cl
 175:	75 f1                	jne    168 <strchr+0x18>
 177:	5d                   	pop    %ebp
 178:	c3                   	ret
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 180:	31 c0                	xor    %eax,%eax
 182:	5d                   	pop    %ebp
 183:	c3                   	ret
 184:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18b:	00 
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <gets>:
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
 195:	8d 7d e7             	lea    -0x19(%ebp),%edi
 198:	53                   	push   %ebx
 199:	31 db                	xor    %ebx,%ebx
 19b:	8d 73 01             	lea    0x1(%ebx),%esi
 19e:	83 ec 1c             	sub    $0x1c,%esp
 1a1:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1a4:	7d 3b                	jge    1e1 <gets+0x51>
 1a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ad:	00 
 1ae:	66 90                	xchg   %ax,%ax
 1b0:	83 ec 04             	sub    $0x4,%esp
 1b3:	6a 01                	push   $0x1
 1b5:	57                   	push   %edi
 1b6:	6a 00                	push   $0x0
 1b8:	e8 1e 01 00 00       	call   2db <read>
 1bd:	83 c4 10             	add    $0x10,%esp
 1c0:	85 c0                	test   %eax,%eax
 1c2:	7e 1d                	jle    1e1 <gets+0x51>
 1c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c8:	8b 55 08             	mov    0x8(%ebp),%edx
 1cb:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
 1cf:	3c 0a                	cmp    $0xa,%al
 1d1:	7f 25                	jg     1f8 <gets+0x68>
 1d3:	3c 08                	cmp    $0x8,%al
 1d5:	7f 0c                	jg     1e3 <gets+0x53>
 1d7:	89 f3                	mov    %esi,%ebx
 1d9:	8d 73 01             	lea    0x1(%ebx),%esi
 1dc:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1df:	7c cf                	jl     1b0 <gets+0x20>
 1e1:	89 de                	mov    %ebx,%esi
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 1ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ed:	5b                   	pop    %ebx
 1ee:	5e                   	pop    %esi
 1ef:	5f                   	pop    %edi
 1f0:	5d                   	pop    %ebp
 1f1:	c3                   	ret
 1f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f8:	3c 0d                	cmp    $0xd,%al
 1fa:	74 e7                	je     1e3 <gets+0x53>
 1fc:	89 f3                	mov    %esi,%ebx
 1fe:	eb d9                	jmp    1d9 <gets+0x49>

00000200 <stat>:
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	push   0x8(%ebp)
 20d:	e8 f1 00 00 00       	call   303 <open>
 212:	83 c4 10             	add    $0x10,%esp
 215:	85 c0                	test   %eax,%eax
 217:	78 27                	js     240 <stat+0x40>
 219:	83 ec 08             	sub    $0x8,%esp
 21c:	ff 75 0c             	push   0xc(%ebp)
 21f:	89 c3                	mov    %eax,%ebx
 221:	50                   	push   %eax
 222:	e8 f4 00 00 00       	call   31b <fstat>
 227:	89 1c 24             	mov    %ebx,(%esp)
 22a:	89 c6                	mov    %eax,%esi
 22c:	e8 ba 00 00 00       	call   2eb <close>
 231:	83 c4 10             	add    $0x10,%esp
 234:	8d 65 f8             	lea    -0x8(%ebp),%esp
 237:	89 f0                	mov    %esi,%eax
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb ed                	jmp    234 <stat+0x34>
 247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24e:	00 
 24f:	90                   	nop

00000250 <atoi>:
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 55 08             	mov    0x8(%ebp),%edx
 257:	0f be 02             	movsbl (%edx),%eax
 25a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 25d:	80 f9 09             	cmp    $0x9,%cl
 260:	b9 00 00 00 00       	mov    $0x0,%ecx
 265:	77 1e                	ja     285 <atoi+0x35>
 267:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26e:	00 
 26f:	90                   	nop
 270:	83 c2 01             	add    $0x1,%edx
 273:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 276:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 27a:	0f be 02             	movsbl (%edx),%eax
 27d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
 285:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 288:	89 c8                	mov    %ecx,%eax
 28a:	c9                   	leave
 28b:	c3                   	ret
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000290 <memmove>:
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	8b 45 10             	mov    0x10(%ebp),%eax
 297:	8b 55 08             	mov    0x8(%ebp),%edx
 29a:	56                   	push   %esi
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
 29e:	85 c0                	test   %eax,%eax
 2a0:	7e 13                	jle    2b5 <memmove+0x25>
 2a2:	01 d0                	add    %edx,%eax
 2a4:	89 d7                	mov    %edx,%edi
 2a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ad:	00 
 2ae:	66 90                	xchg   %ax,%ax
 2b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 2b1:	39 f8                	cmp    %edi,%eax
 2b3:	75 fb                	jne    2b0 <memmove+0x20>
 2b5:	5e                   	pop    %esi
 2b6:	89 d0                	mov    %edx,%eax
 2b8:	5f                   	pop    %edi
 2b9:	5d                   	pop    %ebp
 2ba:	c3                   	ret

000002bb <fork>:
 2bb:	b8 01 00 00 00       	mov    $0x1,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <exit>:
 2c3:	b8 02 00 00 00       	mov    $0x2,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <wait>:
 2cb:	b8 03 00 00 00       	mov    $0x3,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <pipe>:
 2d3:	b8 04 00 00 00       	mov    $0x4,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <read>:
 2db:	b8 05 00 00 00       	mov    $0x5,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <write>:
 2e3:	b8 10 00 00 00       	mov    $0x10,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <close>:
 2eb:	b8 15 00 00 00       	mov    $0x15,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <kill>:
 2f3:	b8 06 00 00 00       	mov    $0x6,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <exec>:
 2fb:	b8 07 00 00 00       	mov    $0x7,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <open>:
 303:	b8 0f 00 00 00       	mov    $0xf,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <mknod>:
 30b:	b8 11 00 00 00       	mov    $0x11,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <unlink>:
 313:	b8 12 00 00 00       	mov    $0x12,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <fstat>:
 31b:	b8 08 00 00 00       	mov    $0x8,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <link>:
 323:	b8 13 00 00 00       	mov    $0x13,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <mkdir>:
 32b:	b8 14 00 00 00       	mov    $0x14,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <chdir>:
 333:	b8 09 00 00 00       	mov    $0x9,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <dup>:
 33b:	b8 0a 00 00 00       	mov    $0xa,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <getpid>:
 343:	b8 0b 00 00 00       	mov    $0xb,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <sbrk>:
 34b:	b8 0c 00 00 00       	mov    $0xc,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <sleep>:
 353:	b8 0d 00 00 00       	mov    $0xd,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <uptime>:
 35b:	b8 0e 00 00 00       	mov    $0xe,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret
 363:	66 90                	xchg   %ax,%ax
 365:	66 90                	xchg   %ax,%ax
 367:	66 90                	xchg   %ax,%ax
 369:	66 90                	xchg   %ax,%ax
 36b:	66 90                	xchg   %ax,%ax
 36d:	66 90                	xchg   %ax,%ax
 36f:	90                   	nop

00000370 <printint>:
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	89 cb                	mov    %ecx,%ebx
 378:	89 d1                	mov    %edx,%ecx
 37a:	83 ec 3c             	sub    $0x3c,%esp
 37d:	89 45 c0             	mov    %eax,-0x40(%ebp)
 380:	85 d2                	test   %edx,%edx
 382:	0f 89 80 00 00 00    	jns    408 <printint+0x98>
 388:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 38c:	74 7a                	je     408 <printint+0x98>
 38e:	f7 d9                	neg    %ecx
 390:	b8 01 00 00 00       	mov    $0x1,%eax
 395:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 398:	31 f6                	xor    %esi,%esi
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3a0:	89 c8                	mov    %ecx,%eax
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	89 f7                	mov    %esi,%edi
 3a6:	f7 f3                	div    %ebx
 3a8:	8d 76 01             	lea    0x1(%esi),%esi
 3ab:	0f b6 92 80 07 00 00 	movzbl 0x780(%edx),%edx
 3b2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
 3b6:	89 ca                	mov    %ecx,%edx
 3b8:	89 c1                	mov    %eax,%ecx
 3ba:	39 da                	cmp    %ebx,%edx
 3bc:	73 e2                	jae    3a0 <printint+0x30>
 3be:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3c1:	85 c0                	test   %eax,%eax
 3c3:	74 07                	je     3cc <printint+0x5c>
 3c5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 3ca:	89 f7                	mov    %esi,%edi
 3cc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3cf:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3d2:	01 df                	add    %ebx,%edi
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d8:	0f b6 07             	movzbl (%edi),%eax
 3db:	83 ec 04             	sub    $0x4,%esp
 3de:	88 45 d7             	mov    %al,-0x29(%ebp)
 3e1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 3e4:	6a 01                	push   $0x1
 3e6:	50                   	push   %eax
 3e7:	56                   	push   %esi
 3e8:	e8 f6 fe ff ff       	call   2e3 <write>
 3ed:	89 f8                	mov    %edi,%eax
 3ef:	83 c4 10             	add    $0x10,%esp
 3f2:	83 ef 01             	sub    $0x1,%edi
 3f5:	39 c3                	cmp    %eax,%ebx
 3f7:	75 df                	jne    3d8 <printint+0x68>
 3f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3fc:	5b                   	pop    %ebx
 3fd:	5e                   	pop    %esi
 3fe:	5f                   	pop    %edi
 3ff:	5d                   	pop    %ebp
 400:	c3                   	ret
 401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 408:	31 c0                	xor    %eax,%eax
 40a:	eb 89                	jmp    395 <printint+0x25>
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000410 <printf>:
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 2c             	sub    $0x2c,%esp
 419:	8b 75 0c             	mov    0xc(%ebp),%esi
 41c:	8b 7d 08             	mov    0x8(%ebp),%edi
 41f:	0f b6 1e             	movzbl (%esi),%ebx
 422:	83 c6 01             	add    $0x1,%esi
 425:	84 db                	test   %bl,%bl
 427:	74 67                	je     490 <printf+0x80>
 429:	8d 4d 10             	lea    0x10(%ebp),%ecx
 42c:	31 d2                	xor    %edx,%edx
 42e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 431:	eb 34                	jmp    467 <printf+0x57>
 433:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 438:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 43b:	ba 25 00 00 00       	mov    $0x25,%edx
 440:	83 f8 25             	cmp    $0x25,%eax
 443:	74 18                	je     45d <printf+0x4d>
 445:	83 ec 04             	sub    $0x4,%esp
 448:	8d 45 e7             	lea    -0x19(%ebp),%eax
 44b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 44e:	6a 01                	push   $0x1
 450:	50                   	push   %eax
 451:	57                   	push   %edi
 452:	e8 8c fe ff ff       	call   2e3 <write>
 457:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 45a:	83 c4 10             	add    $0x10,%esp
 45d:	0f b6 1e             	movzbl (%esi),%ebx
 460:	83 c6 01             	add    $0x1,%esi
 463:	84 db                	test   %bl,%bl
 465:	74 29                	je     490 <printf+0x80>
 467:	0f b6 c3             	movzbl %bl,%eax
 46a:	85 d2                	test   %edx,%edx
 46c:	74 ca                	je     438 <printf+0x28>
 46e:	83 fa 25             	cmp    $0x25,%edx
 471:	75 ea                	jne    45d <printf+0x4d>
 473:	83 f8 25             	cmp    $0x25,%eax
 476:	0f 84 04 01 00 00    	je     580 <printf+0x170>
 47c:	83 e8 63             	sub    $0x63,%eax
 47f:	83 f8 15             	cmp    $0x15,%eax
 482:	77 1c                	ja     4a0 <printf+0x90>
 484:	ff 24 85 28 07 00 00 	jmp    *0x728(,%eax,4)
 48b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 490:	8d 65 f4             	lea    -0xc(%ebp),%esp
 493:	5b                   	pop    %ebx
 494:	5e                   	pop    %esi
 495:	5f                   	pop    %edi
 496:	5d                   	pop    %ebp
 497:	c3                   	ret
 498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49f:	00 
 4a0:	83 ec 04             	sub    $0x4,%esp
 4a3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 4a6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4aa:	6a 01                	push   $0x1
 4ac:	52                   	push   %edx
 4ad:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4b0:	57                   	push   %edi
 4b1:	e8 2d fe ff ff       	call   2e3 <write>
 4b6:	83 c4 0c             	add    $0xc,%esp
 4b9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4bc:	6a 01                	push   $0x1
 4be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4c1:	52                   	push   %edx
 4c2:	57                   	push   %edi
 4c3:	e8 1b fe ff ff       	call   2e3 <write>
 4c8:	83 c4 10             	add    $0x10,%esp
 4cb:	31 d2                	xor    %edx,%edx
 4cd:	eb 8e                	jmp    45d <printf+0x4d>
 4cf:	90                   	nop
 4d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4d3:	83 ec 0c             	sub    $0xc,%esp
 4d6:	b9 10 00 00 00       	mov    $0x10,%ecx
 4db:	8b 13                	mov    (%ebx),%edx
 4dd:	6a 00                	push   $0x0
 4df:	89 f8                	mov    %edi,%eax
 4e1:	83 c3 04             	add    $0x4,%ebx
 4e4:	e8 87 fe ff ff       	call   370 <printint>
 4e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 4ec:	83 c4 10             	add    $0x10,%esp
 4ef:	31 d2                	xor    %edx,%edx
 4f1:	e9 67 ff ff ff       	jmp    45d <printf+0x4d>
 4f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4f9:	8b 18                	mov    (%eax),%ebx
 4fb:	83 c0 04             	add    $0x4,%eax
 4fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
 501:	85 db                	test   %ebx,%ebx
 503:	0f 84 87 00 00 00    	je     590 <printf+0x180>
 509:	0f b6 03             	movzbl (%ebx),%eax
 50c:	31 d2                	xor    %edx,%edx
 50e:	84 c0                	test   %al,%al
 510:	0f 84 47 ff ff ff    	je     45d <printf+0x4d>
 516:	8d 55 e7             	lea    -0x19(%ebp),%edx
 519:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 51c:	89 de                	mov    %ebx,%esi
 51e:	89 d3                	mov    %edx,%ebx
 520:	83 ec 04             	sub    $0x4,%esp
 523:	88 45 e7             	mov    %al,-0x19(%ebp)
 526:	83 c6 01             	add    $0x1,%esi
 529:	6a 01                	push   $0x1
 52b:	53                   	push   %ebx
 52c:	57                   	push   %edi
 52d:	e8 b1 fd ff ff       	call   2e3 <write>
 532:	0f b6 06             	movzbl (%esi),%eax
 535:	83 c4 10             	add    $0x10,%esp
 538:	84 c0                	test   %al,%al
 53a:	75 e4                	jne    520 <printf+0x110>
 53c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 53f:	31 d2                	xor    %edx,%edx
 541:	e9 17 ff ff ff       	jmp    45d <printf+0x4d>
 546:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 549:	83 ec 0c             	sub    $0xc,%esp
 54c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 551:	8b 13                	mov    (%ebx),%edx
 553:	6a 01                	push   $0x1
 555:	eb 88                	jmp    4df <printf+0xcf>
 557:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 55a:	83 ec 04             	sub    $0x4,%esp
 55d:	8d 55 e7             	lea    -0x19(%ebp),%edx
 560:	8b 03                	mov    (%ebx),%eax
 562:	83 c3 04             	add    $0x4,%ebx
 565:	88 45 e7             	mov    %al,-0x19(%ebp)
 568:	6a 01                	push   $0x1
 56a:	52                   	push   %edx
 56b:	57                   	push   %edi
 56c:	e8 72 fd ff ff       	call   2e3 <write>
 571:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 574:	83 c4 10             	add    $0x10,%esp
 577:	31 d2                	xor    %edx,%edx
 579:	e9 df fe ff ff       	jmp    45d <printf+0x4d>
 57e:	66 90                	xchg   %ax,%ax
 580:	83 ec 04             	sub    $0x4,%esp
 583:	88 5d e7             	mov    %bl,-0x19(%ebp)
 586:	8d 55 e7             	lea    -0x19(%ebp),%edx
 589:	6a 01                	push   $0x1
 58b:	e9 31 ff ff ff       	jmp    4c1 <printf+0xb1>
 590:	b8 28 00 00 00       	mov    $0x28,%eax
 595:	bb 21 07 00 00       	mov    $0x721,%ebx
 59a:	e9 77 ff ff ff       	jmp    516 <printf+0x106>
 59f:	90                   	nop

000005a0 <free>:
 5a0:	55                   	push   %ebp
 5a1:	a1 28 0a 00 00       	mov    0xa28,%eax
 5a6:	89 e5                	mov    %esp,%ebp
 5a8:	57                   	push   %edi
 5a9:	56                   	push   %esi
 5aa:	53                   	push   %ebx
 5ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5b8:	8b 10                	mov    (%eax),%edx
 5ba:	39 c8                	cmp    %ecx,%eax
 5bc:	73 32                	jae    5f0 <free+0x50>
 5be:	39 d1                	cmp    %edx,%ecx
 5c0:	72 04                	jb     5c6 <free+0x26>
 5c2:	39 d0                	cmp    %edx,%eax
 5c4:	72 32                	jb     5f8 <free+0x58>
 5c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5cc:	39 fa                	cmp    %edi,%edx
 5ce:	74 30                	je     600 <free+0x60>
 5d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5d3:	8b 50 04             	mov    0x4(%eax),%edx
 5d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5d9:	39 f1                	cmp    %esi,%ecx
 5db:	74 3a                	je     617 <free+0x77>
 5dd:	89 08                	mov    %ecx,(%eax)
 5df:	5b                   	pop    %ebx
 5e0:	a3 28 0a 00 00       	mov    %eax,0xa28
 5e5:	5e                   	pop    %esi
 5e6:	5f                   	pop    %edi
 5e7:	5d                   	pop    %ebp
 5e8:	c3                   	ret
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5f0:	39 d0                	cmp    %edx,%eax
 5f2:	72 04                	jb     5f8 <free+0x58>
 5f4:	39 d1                	cmp    %edx,%ecx
 5f6:	72 ce                	jb     5c6 <free+0x26>
 5f8:	89 d0                	mov    %edx,%eax
 5fa:	eb bc                	jmp    5b8 <free+0x18>
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 600:	03 72 04             	add    0x4(%edx),%esi
 603:	89 73 fc             	mov    %esi,-0x4(%ebx)
 606:	8b 10                	mov    (%eax),%edx
 608:	8b 12                	mov    (%edx),%edx
 60a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 60d:	8b 50 04             	mov    0x4(%eax),%edx
 610:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 613:	39 f1                	cmp    %esi,%ecx
 615:	75 c6                	jne    5dd <free+0x3d>
 617:	03 53 fc             	add    -0x4(%ebx),%edx
 61a:	a3 28 0a 00 00       	mov    %eax,0xa28
 61f:	89 50 04             	mov    %edx,0x4(%eax)
 622:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 625:	89 08                	mov    %ecx,(%eax)
 627:	5b                   	pop    %ebx
 628:	5e                   	pop    %esi
 629:	5f                   	pop    %edi
 62a:	5d                   	pop    %ebp
 62b:	c3                   	ret
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000630 <malloc>:
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 0c             	sub    $0xc,%esp
 639:	8b 45 08             	mov    0x8(%ebp),%eax
 63c:	8b 15 28 0a 00 00    	mov    0xa28,%edx
 642:	8d 78 07             	lea    0x7(%eax),%edi
 645:	c1 ef 03             	shr    $0x3,%edi
 648:	83 c7 01             	add    $0x1,%edi
 64b:	85 d2                	test   %edx,%edx
 64d:	0f 84 8d 00 00 00    	je     6e0 <malloc+0xb0>
 653:	8b 02                	mov    (%edx),%eax
 655:	8b 48 04             	mov    0x4(%eax),%ecx
 658:	39 f9                	cmp    %edi,%ecx
 65a:	73 64                	jae    6c0 <malloc+0x90>
 65c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 661:	39 df                	cmp    %ebx,%edi
 663:	0f 43 df             	cmovae %edi,%ebx
 666:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 66d:	eb 0a                	jmp    679 <malloc+0x49>
 66f:	90                   	nop
 670:	8b 02                	mov    (%edx),%eax
 672:	8b 48 04             	mov    0x4(%eax),%ecx
 675:	39 f9                	cmp    %edi,%ecx
 677:	73 47                	jae    6c0 <malloc+0x90>
 679:	89 c2                	mov    %eax,%edx
 67b:	3b 05 28 0a 00 00    	cmp    0xa28,%eax
 681:	75 ed                	jne    670 <malloc+0x40>
 683:	83 ec 0c             	sub    $0xc,%esp
 686:	56                   	push   %esi
 687:	e8 bf fc ff ff       	call   34b <sbrk>
 68c:	83 c4 10             	add    $0x10,%esp
 68f:	83 f8 ff             	cmp    $0xffffffff,%eax
 692:	74 1c                	je     6b0 <malloc+0x80>
 694:	89 58 04             	mov    %ebx,0x4(%eax)
 697:	83 ec 0c             	sub    $0xc,%esp
 69a:	83 c0 08             	add    $0x8,%eax
 69d:	50                   	push   %eax
 69e:	e8 fd fe ff ff       	call   5a0 <free>
 6a3:	8b 15 28 0a 00 00    	mov    0xa28,%edx
 6a9:	83 c4 10             	add    $0x10,%esp
 6ac:	85 d2                	test   %edx,%edx
 6ae:	75 c0                	jne    670 <malloc+0x40>
 6b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6b3:	31 c0                	xor    %eax,%eax
 6b5:	5b                   	pop    %ebx
 6b6:	5e                   	pop    %esi
 6b7:	5f                   	pop    %edi
 6b8:	5d                   	pop    %ebp
 6b9:	c3                   	ret
 6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6c0:	39 cf                	cmp    %ecx,%edi
 6c2:	74 4c                	je     710 <malloc+0xe0>
 6c4:	29 f9                	sub    %edi,%ecx
 6c6:	89 48 04             	mov    %ecx,0x4(%eax)
 6c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 6cc:	89 78 04             	mov    %edi,0x4(%eax)
 6cf:	89 15 28 0a 00 00    	mov    %edx,0xa28
 6d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d8:	83 c0 08             	add    $0x8,%eax
 6db:	5b                   	pop    %ebx
 6dc:	5e                   	pop    %esi
 6dd:	5f                   	pop    %edi
 6de:	5d                   	pop    %ebp
 6df:	c3                   	ret
 6e0:	c7 05 28 0a 00 00 2c 	movl   $0xa2c,0xa28
 6e7:	0a 00 00 
 6ea:	b8 2c 0a 00 00       	mov    $0xa2c,%eax
 6ef:	c7 05 2c 0a 00 00 2c 	movl   $0xa2c,0xa2c
 6f6:	0a 00 00 
 6f9:	c7 05 30 0a 00 00 00 	movl   $0x0,0xa30
 700:	00 00 00 
 703:	e9 54 ff ff ff       	jmp    65c <malloc+0x2c>
 708:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 70f:	00 
 710:	8b 08                	mov    (%eax),%ecx
 712:	89 0a                	mov    %ecx,(%edx)
 714:	eb b9                	jmp    6cf <malloc+0x9f>
