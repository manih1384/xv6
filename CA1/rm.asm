
_rm:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	bf 01 00 00 00       	mov    $0x1,%edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  1c:	8b 31                	mov    (%ecx),%esi
  1e:	83 c3 04             	add    $0x4,%ebx
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7f 14                	jg     3a <main+0x3a>
  26:	eb 3a                	jmp    62 <main+0x62>
  28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2f:	00 
  30:	83 c7 01             	add    $0x1,%edi
  33:	83 c3 04             	add    $0x4,%ebx
  36:	39 fe                	cmp    %edi,%esi
  38:	74 23                	je     5d <main+0x5d>
  3a:	83 ec 0c             	sub    $0xc,%esp
  3d:	ff 33                	push   (%ebx)
  3f:	e8 df 02 00 00       	call   323 <unlink>
  44:	83 c4 10             	add    $0x10,%esp
  47:	85 c0                	test   %eax,%eax
  49:	79 e5                	jns    30 <main+0x30>
  4b:	50                   	push   %eax
  4c:	ff 33                	push   (%ebx)
  4e:	68 3c 07 00 00       	push   $0x73c
  53:	6a 02                	push   $0x2
  55:	e8 c6 03 00 00       	call   420 <printf>
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	e8 71 02 00 00       	call   2d3 <exit>
  62:	52                   	push   %edx
  63:	52                   	push   %edx
  64:	68 28 07 00 00       	push   $0x728
  69:	6a 02                	push   $0x2
  6b:	e8 b0 03 00 00       	call   420 <printf>
  70:	e8 5e 02 00 00       	call   2d3 <exit>
  75:	66 90                	xchg   %ax,%ax
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
  80:	55                   	push   %ebp
  81:	31 c0                	xor    %eax,%eax
  83:	89 e5                	mov    %esp,%ebp
  85:	53                   	push   %ebx
  86:	8b 4d 08             	mov    0x8(%ebp),%ecx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  97:	83 c0 01             	add    $0x1,%eax
  9a:	84 d2                	test   %dl,%dl
  9c:	75 f2                	jne    90 <strcpy+0x10>
  9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  a1:	89 c8                	mov    %ecx,%eax
  a3:	c9                   	leave
  a4:	c3                   	ret
  a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ac:	00 
  ad:	8d 76 00             	lea    0x0(%esi),%esi

000000b0 <strcmp>:
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 17                	jne    d8 <strcmp+0x28>
  c1:	eb 3a                	jmp    fd <strcmp+0x4d>
  c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  cc:	83 c2 01             	add    $0x1,%edx
  cf:	8d 59 01             	lea    0x1(%ecx),%ebx
  d2:	84 c0                	test   %al,%al
  d4:	74 1a                	je     f0 <strcmp+0x40>
  d6:	89 d9                	mov    %ebx,%ecx
  d8:	0f b6 19             	movzbl (%ecx),%ebx
  db:	38 c3                	cmp    %al,%bl
  dd:	74 e9                	je     c8 <strcmp+0x18>
  df:	29 d8                	sub    %ebx,%eax
  e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  e4:	c9                   	leave
  e5:	c3                   	ret
  e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ed:	00 
  ee:	66 90                	xchg   %ax,%ax
  f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  f4:	31 c0                	xor    %eax,%eax
  f6:	29 d8                	sub    %ebx,%eax
  f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  fb:	c9                   	leave
  fc:	c3                   	ret
  fd:	0f b6 19             	movzbl (%ecx),%ebx
 100:	31 c0                	xor    %eax,%eax
 102:	eb db                	jmp    df <strcmp+0x2f>
 104:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10b:	00 
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000110 <strlen>:
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	80 3a 00             	cmpb   $0x0,(%edx)
 119:	74 15                	je     130 <strlen+0x20>
 11b:	31 c0                	xor    %eax,%eax
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	83 c0 01             	add    $0x1,%eax
 123:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 127:	89 c1                	mov    %eax,%ecx
 129:	75 f5                	jne    120 <strlen+0x10>
 12b:	89 c8                	mov    %ecx,%eax
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret
 12f:	90                   	nop
 130:	31 c9                	xor    %ecx,%ecx
 132:	5d                   	pop    %ebp
 133:	89 c8                	mov    %ecx,%eax
 135:	c3                   	ret
 136:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13d:	00 
 13e:	66 90                	xchg   %ax,%ax

00000140 <memset>:
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 d7                	mov    %edx,%edi
 14f:	fc                   	cld
 150:	f3 aa                	rep stos %al,%es:(%edi)
 152:	8b 7d fc             	mov    -0x4(%ebp),%edi
 155:	89 d0                	mov    %edx,%eax
 157:	c9                   	leave
 158:	c3                   	ret
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000160 <strchr>:
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	75 12                	jne    183 <strchr+0x23>
 171:	eb 1d                	jmp    190 <strchr+0x30>
 173:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 178:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 17c:	83 c0 01             	add    $0x1,%eax
 17f:	84 d2                	test   %dl,%dl
 181:	74 0d                	je     190 <strchr+0x30>
 183:	38 d1                	cmp    %dl,%cl
 185:	75 f1                	jne    178 <strchr+0x18>
 187:	5d                   	pop    %ebp
 188:	c3                   	ret
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 190:	31 c0                	xor    %eax,%eax
 192:	5d                   	pop    %ebp
 193:	c3                   	ret
 194:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19b:	00 
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <gets>:
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
 1a5:	8d 7d e7             	lea    -0x19(%ebp),%edi
 1a8:	53                   	push   %ebx
 1a9:	31 db                	xor    %ebx,%ebx
 1ab:	8d 73 01             	lea    0x1(%ebx),%esi
 1ae:	83 ec 1c             	sub    $0x1c,%esp
 1b1:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1b4:	7d 3b                	jge    1f1 <gets+0x51>
 1b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bd:	00 
 1be:	66 90                	xchg   %ax,%ax
 1c0:	83 ec 04             	sub    $0x4,%esp
 1c3:	6a 01                	push   $0x1
 1c5:	57                   	push   %edi
 1c6:	6a 00                	push   $0x0
 1c8:	e8 1e 01 00 00       	call   2eb <read>
 1cd:	83 c4 10             	add    $0x10,%esp
 1d0:	85 c0                	test   %eax,%eax
 1d2:	7e 1d                	jle    1f1 <gets+0x51>
 1d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1d8:	8b 55 08             	mov    0x8(%ebp),%edx
 1db:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
 1df:	3c 0a                	cmp    $0xa,%al
 1e1:	7f 25                	jg     208 <gets+0x68>
 1e3:	3c 08                	cmp    $0x8,%al
 1e5:	7f 0c                	jg     1f3 <gets+0x53>
 1e7:	89 f3                	mov    %esi,%ebx
 1e9:	8d 73 01             	lea    0x1(%ebx),%esi
 1ec:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1ef:	7c cf                	jl     1c0 <gets+0x20>
 1f1:	89 de                	mov    %ebx,%esi
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 1fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fd:	5b                   	pop    %ebx
 1fe:	5e                   	pop    %esi
 1ff:	5f                   	pop    %edi
 200:	5d                   	pop    %ebp
 201:	c3                   	ret
 202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 208:	3c 0d                	cmp    $0xd,%al
 20a:	74 e7                	je     1f3 <gets+0x53>
 20c:	89 f3                	mov    %esi,%ebx
 20e:	eb d9                	jmp    1e9 <gets+0x49>

00000210 <stat>:
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	push   0x8(%ebp)
 21d:	e8 f1 00 00 00       	call   313 <open>
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	push   0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 f4 00 00 00       	call   32b <fstat>
 237:	89 1c 24             	mov    %ebx,(%esp)
 23a:	89 c6                	mov    %eax,%esi
 23c:	e8 ba 00 00 00       	call   2fb <close>
 241:	83 c4 10             	add    $0x10,%esp
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret
 24d:	8d 76 00             	lea    0x0(%esi),%esi
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25e:	00 
 25f:	90                   	nop

00000260 <atoi>:
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 55 08             	mov    0x8(%ebp),%edx
 267:	0f be 02             	movsbl (%edx),%eax
 26a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 26d:	80 f9 09             	cmp    $0x9,%cl
 270:	b9 00 00 00 00       	mov    $0x0,%ecx
 275:	77 1e                	ja     295 <atoi+0x35>
 277:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27e:	00 
 27f:	90                   	nop
 280:	83 c2 01             	add    $0x1,%edx
 283:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 286:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 28a:	0f be 02             	movsbl (%edx),%eax
 28d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
 295:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 298:	89 c8                	mov    %ecx,%eax
 29a:	c9                   	leave
 29b:	c3                   	ret
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 45 10             	mov    0x10(%ebp),%eax
 2a7:	8b 55 08             	mov    0x8(%ebp),%edx
 2aa:	56                   	push   %esi
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
 2ae:	85 c0                	test   %eax,%eax
 2b0:	7e 13                	jle    2c5 <memmove+0x25>
 2b2:	01 d0                	add    %edx,%eax
 2b4:	89 d7                	mov    %edx,%edi
 2b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2bd:	00 
 2be:	66 90                	xchg   %ax,%ax
 2c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 2c1:	39 f8                	cmp    %edi,%eax
 2c3:	75 fb                	jne    2c0 <memmove+0x20>
 2c5:	5e                   	pop    %esi
 2c6:	89 d0                	mov    %edx,%eax
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret

000002cb <fork>:
 2cb:	b8 01 00 00 00       	mov    $0x1,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <exit>:
 2d3:	b8 02 00 00 00       	mov    $0x2,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <wait>:
 2db:	b8 03 00 00 00       	mov    $0x3,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <pipe>:
 2e3:	b8 04 00 00 00       	mov    $0x4,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <read>:
 2eb:	b8 05 00 00 00       	mov    $0x5,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <write>:
 2f3:	b8 10 00 00 00       	mov    $0x10,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <close>:
 2fb:	b8 15 00 00 00       	mov    $0x15,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <kill>:
 303:	b8 06 00 00 00       	mov    $0x6,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <exec>:
 30b:	b8 07 00 00 00       	mov    $0x7,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <open>:
 313:	b8 0f 00 00 00       	mov    $0xf,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <mknod>:
 31b:	b8 11 00 00 00       	mov    $0x11,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <unlink>:
 323:	b8 12 00 00 00       	mov    $0x12,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <fstat>:
 32b:	b8 08 00 00 00       	mov    $0x8,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <link>:
 333:	b8 13 00 00 00       	mov    $0x13,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <mkdir>:
 33b:	b8 14 00 00 00       	mov    $0x14,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <chdir>:
 343:	b8 09 00 00 00       	mov    $0x9,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <dup>:
 34b:	b8 0a 00 00 00       	mov    $0xa,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <getpid>:
 353:	b8 0b 00 00 00       	mov    $0xb,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <sbrk>:
 35b:	b8 0c 00 00 00       	mov    $0xc,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <sleep>:
 363:	b8 0d 00 00 00       	mov    $0xd,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <uptime>:
 36b:	b8 0e 00 00 00       	mov    $0xe,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret
 373:	66 90                	xchg   %ax,%ax
 375:	66 90                	xchg   %ax,%ax
 377:	66 90                	xchg   %ax,%ax
 379:	66 90                	xchg   %ax,%ax
 37b:	66 90                	xchg   %ax,%ax
 37d:	66 90                	xchg   %ax,%ax
 37f:	90                   	nop

00000380 <printint>:
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	89 cb                	mov    %ecx,%ebx
 388:	89 d1                	mov    %edx,%ecx
 38a:	83 ec 3c             	sub    $0x3c,%esp
 38d:	89 45 c0             	mov    %eax,-0x40(%ebp)
 390:	85 d2                	test   %edx,%edx
 392:	0f 89 80 00 00 00    	jns    418 <printint+0x98>
 398:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 39c:	74 7a                	je     418 <printint+0x98>
 39e:	f7 d9                	neg    %ecx
 3a0:	b8 01 00 00 00       	mov    $0x1,%eax
 3a5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3a8:	31 f6                	xor    %esi,%esi
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3b0:	89 c8                	mov    %ecx,%eax
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	89 f7                	mov    %esi,%edi
 3b6:	f7 f3                	div    %ebx
 3b8:	8d 76 01             	lea    0x1(%esi),%esi
 3bb:	0f b6 92 b4 07 00 00 	movzbl 0x7b4(%edx),%edx
 3c2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
 3c6:	89 ca                	mov    %ecx,%edx
 3c8:	89 c1                	mov    %eax,%ecx
 3ca:	39 da                	cmp    %ebx,%edx
 3cc:	73 e2                	jae    3b0 <printint+0x30>
 3ce:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3d1:	85 c0                	test   %eax,%eax
 3d3:	74 07                	je     3dc <printint+0x5c>
 3d5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 3da:	89 f7                	mov    %esi,%edi
 3dc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3df:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3e2:	01 df                	add    %ebx,%edi
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3e8:	0f b6 07             	movzbl (%edi),%eax
 3eb:	83 ec 04             	sub    $0x4,%esp
 3ee:	88 45 d7             	mov    %al,-0x29(%ebp)
 3f1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 3f4:	6a 01                	push   $0x1
 3f6:	50                   	push   %eax
 3f7:	56                   	push   %esi
 3f8:	e8 f6 fe ff ff       	call   2f3 <write>
 3fd:	89 f8                	mov    %edi,%eax
 3ff:	83 c4 10             	add    $0x10,%esp
 402:	83 ef 01             	sub    $0x1,%edi
 405:	39 c3                	cmp    %eax,%ebx
 407:	75 df                	jne    3e8 <printint+0x68>
 409:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40c:	5b                   	pop    %ebx
 40d:	5e                   	pop    %esi
 40e:	5f                   	pop    %edi
 40f:	5d                   	pop    %ebp
 410:	c3                   	ret
 411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 418:	31 c0                	xor    %eax,%eax
 41a:	eb 89                	jmp    3a5 <printint+0x25>
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000420 <printf>:
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 2c             	sub    $0x2c,%esp
 429:	8b 75 0c             	mov    0xc(%ebp),%esi
 42c:	8b 7d 08             	mov    0x8(%ebp),%edi
 42f:	0f b6 1e             	movzbl (%esi),%ebx
 432:	83 c6 01             	add    $0x1,%esi
 435:	84 db                	test   %bl,%bl
 437:	74 67                	je     4a0 <printf+0x80>
 439:	8d 4d 10             	lea    0x10(%ebp),%ecx
 43c:	31 d2                	xor    %edx,%edx
 43e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 441:	eb 34                	jmp    477 <printf+0x57>
 443:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 448:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 44b:	ba 25 00 00 00       	mov    $0x25,%edx
 450:	83 f8 25             	cmp    $0x25,%eax
 453:	74 18                	je     46d <printf+0x4d>
 455:	83 ec 04             	sub    $0x4,%esp
 458:	8d 45 e7             	lea    -0x19(%ebp),%eax
 45b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 45e:	6a 01                	push   $0x1
 460:	50                   	push   %eax
 461:	57                   	push   %edi
 462:	e8 8c fe ff ff       	call   2f3 <write>
 467:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 46a:	83 c4 10             	add    $0x10,%esp
 46d:	0f b6 1e             	movzbl (%esi),%ebx
 470:	83 c6 01             	add    $0x1,%esi
 473:	84 db                	test   %bl,%bl
 475:	74 29                	je     4a0 <printf+0x80>
 477:	0f b6 c3             	movzbl %bl,%eax
 47a:	85 d2                	test   %edx,%edx
 47c:	74 ca                	je     448 <printf+0x28>
 47e:	83 fa 25             	cmp    $0x25,%edx
 481:	75 ea                	jne    46d <printf+0x4d>
 483:	83 f8 25             	cmp    $0x25,%eax
 486:	0f 84 04 01 00 00    	je     590 <printf+0x170>
 48c:	83 e8 63             	sub    $0x63,%eax
 48f:	83 f8 15             	cmp    $0x15,%eax
 492:	77 1c                	ja     4b0 <printf+0x90>
 494:	ff 24 85 5c 07 00 00 	jmp    *0x75c(,%eax,4)
 49b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4a3:	5b                   	pop    %ebx
 4a4:	5e                   	pop    %esi
 4a5:	5f                   	pop    %edi
 4a6:	5d                   	pop    %ebp
 4a7:	c3                   	ret
 4a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4af:	00 
 4b0:	83 ec 04             	sub    $0x4,%esp
 4b3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 4b6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4ba:	6a 01                	push   $0x1
 4bc:	52                   	push   %edx
 4bd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4c0:	57                   	push   %edi
 4c1:	e8 2d fe ff ff       	call   2f3 <write>
 4c6:	83 c4 0c             	add    $0xc,%esp
 4c9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4cc:	6a 01                	push   $0x1
 4ce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4d1:	52                   	push   %edx
 4d2:	57                   	push   %edi
 4d3:	e8 1b fe ff ff       	call   2f3 <write>
 4d8:	83 c4 10             	add    $0x10,%esp
 4db:	31 d2                	xor    %edx,%edx
 4dd:	eb 8e                	jmp    46d <printf+0x4d>
 4df:	90                   	nop
 4e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4e3:	83 ec 0c             	sub    $0xc,%esp
 4e6:	b9 10 00 00 00       	mov    $0x10,%ecx
 4eb:	8b 13                	mov    (%ebx),%edx
 4ed:	6a 00                	push   $0x0
 4ef:	89 f8                	mov    %edi,%eax
 4f1:	83 c3 04             	add    $0x4,%ebx
 4f4:	e8 87 fe ff ff       	call   380 <printint>
 4f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 4fc:	83 c4 10             	add    $0x10,%esp
 4ff:	31 d2                	xor    %edx,%edx
 501:	e9 67 ff ff ff       	jmp    46d <printf+0x4d>
 506:	8b 45 d0             	mov    -0x30(%ebp),%eax
 509:	8b 18                	mov    (%eax),%ebx
 50b:	83 c0 04             	add    $0x4,%eax
 50e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 511:	85 db                	test   %ebx,%ebx
 513:	0f 84 87 00 00 00    	je     5a0 <printf+0x180>
 519:	0f b6 03             	movzbl (%ebx),%eax
 51c:	31 d2                	xor    %edx,%edx
 51e:	84 c0                	test   %al,%al
 520:	0f 84 47 ff ff ff    	je     46d <printf+0x4d>
 526:	8d 55 e7             	lea    -0x19(%ebp),%edx
 529:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 52c:	89 de                	mov    %ebx,%esi
 52e:	89 d3                	mov    %edx,%ebx
 530:	83 ec 04             	sub    $0x4,%esp
 533:	88 45 e7             	mov    %al,-0x19(%ebp)
 536:	83 c6 01             	add    $0x1,%esi
 539:	6a 01                	push   $0x1
 53b:	53                   	push   %ebx
 53c:	57                   	push   %edi
 53d:	e8 b1 fd ff ff       	call   2f3 <write>
 542:	0f b6 06             	movzbl (%esi),%eax
 545:	83 c4 10             	add    $0x10,%esp
 548:	84 c0                	test   %al,%al
 54a:	75 e4                	jne    530 <printf+0x110>
 54c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 54f:	31 d2                	xor    %edx,%edx
 551:	e9 17 ff ff ff       	jmp    46d <printf+0x4d>
 556:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 559:	83 ec 0c             	sub    $0xc,%esp
 55c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 561:	8b 13                	mov    (%ebx),%edx
 563:	6a 01                	push   $0x1
 565:	eb 88                	jmp    4ef <printf+0xcf>
 567:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 56a:	83 ec 04             	sub    $0x4,%esp
 56d:	8d 55 e7             	lea    -0x19(%ebp),%edx
 570:	8b 03                	mov    (%ebx),%eax
 572:	83 c3 04             	add    $0x4,%ebx
 575:	88 45 e7             	mov    %al,-0x19(%ebp)
 578:	6a 01                	push   $0x1
 57a:	52                   	push   %edx
 57b:	57                   	push   %edi
 57c:	e8 72 fd ff ff       	call   2f3 <write>
 581:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 584:	83 c4 10             	add    $0x10,%esp
 587:	31 d2                	xor    %edx,%edx
 589:	e9 df fe ff ff       	jmp    46d <printf+0x4d>
 58e:	66 90                	xchg   %ax,%ax
 590:	83 ec 04             	sub    $0x4,%esp
 593:	88 5d e7             	mov    %bl,-0x19(%ebp)
 596:	8d 55 e7             	lea    -0x19(%ebp),%edx
 599:	6a 01                	push   $0x1
 59b:	e9 31 ff ff ff       	jmp    4d1 <printf+0xb1>
 5a0:	b8 28 00 00 00       	mov    $0x28,%eax
 5a5:	bb 55 07 00 00       	mov    $0x755,%ebx
 5aa:	e9 77 ff ff ff       	jmp    526 <printf+0x106>
 5af:	90                   	nop

000005b0 <free>:
 5b0:	55                   	push   %ebp
 5b1:	a1 60 0a 00 00       	mov    0xa60,%eax
 5b6:	89 e5                	mov    %esp,%ebp
 5b8:	57                   	push   %edi
 5b9:	56                   	push   %esi
 5ba:	53                   	push   %ebx
 5bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5c8:	8b 10                	mov    (%eax),%edx
 5ca:	39 c8                	cmp    %ecx,%eax
 5cc:	73 32                	jae    600 <free+0x50>
 5ce:	39 d1                	cmp    %edx,%ecx
 5d0:	72 04                	jb     5d6 <free+0x26>
 5d2:	39 d0                	cmp    %edx,%eax
 5d4:	72 32                	jb     608 <free+0x58>
 5d6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5d9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5dc:	39 fa                	cmp    %edi,%edx
 5de:	74 30                	je     610 <free+0x60>
 5e0:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5e3:	8b 50 04             	mov    0x4(%eax),%edx
 5e6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5e9:	39 f1                	cmp    %esi,%ecx
 5eb:	74 3a                	je     627 <free+0x77>
 5ed:	89 08                	mov    %ecx,(%eax)
 5ef:	5b                   	pop    %ebx
 5f0:	a3 60 0a 00 00       	mov    %eax,0xa60
 5f5:	5e                   	pop    %esi
 5f6:	5f                   	pop    %edi
 5f7:	5d                   	pop    %ebp
 5f8:	c3                   	ret
 5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 600:	39 d0                	cmp    %edx,%eax
 602:	72 04                	jb     608 <free+0x58>
 604:	39 d1                	cmp    %edx,%ecx
 606:	72 ce                	jb     5d6 <free+0x26>
 608:	89 d0                	mov    %edx,%eax
 60a:	eb bc                	jmp    5c8 <free+0x18>
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 610:	03 72 04             	add    0x4(%edx),%esi
 613:	89 73 fc             	mov    %esi,-0x4(%ebx)
 616:	8b 10                	mov    (%eax),%edx
 618:	8b 12                	mov    (%edx),%edx
 61a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 61d:	8b 50 04             	mov    0x4(%eax),%edx
 620:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 623:	39 f1                	cmp    %esi,%ecx
 625:	75 c6                	jne    5ed <free+0x3d>
 627:	03 53 fc             	add    -0x4(%ebx),%edx
 62a:	a3 60 0a 00 00       	mov    %eax,0xa60
 62f:	89 50 04             	mov    %edx,0x4(%eax)
 632:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 635:	89 08                	mov    %ecx,(%eax)
 637:	5b                   	pop    %ebx
 638:	5e                   	pop    %esi
 639:	5f                   	pop    %edi
 63a:	5d                   	pop    %ebp
 63b:	c3                   	ret
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000640 <malloc>:
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	83 ec 0c             	sub    $0xc,%esp
 649:	8b 45 08             	mov    0x8(%ebp),%eax
 64c:	8b 15 60 0a 00 00    	mov    0xa60,%edx
 652:	8d 78 07             	lea    0x7(%eax),%edi
 655:	c1 ef 03             	shr    $0x3,%edi
 658:	83 c7 01             	add    $0x1,%edi
 65b:	85 d2                	test   %edx,%edx
 65d:	0f 84 8d 00 00 00    	je     6f0 <malloc+0xb0>
 663:	8b 02                	mov    (%edx),%eax
 665:	8b 48 04             	mov    0x4(%eax),%ecx
 668:	39 f9                	cmp    %edi,%ecx
 66a:	73 64                	jae    6d0 <malloc+0x90>
 66c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 671:	39 df                	cmp    %ebx,%edi
 673:	0f 43 df             	cmovae %edi,%ebx
 676:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 67d:	eb 0a                	jmp    689 <malloc+0x49>
 67f:	90                   	nop
 680:	8b 02                	mov    (%edx),%eax
 682:	8b 48 04             	mov    0x4(%eax),%ecx
 685:	39 f9                	cmp    %edi,%ecx
 687:	73 47                	jae    6d0 <malloc+0x90>
 689:	89 c2                	mov    %eax,%edx
 68b:	3b 05 60 0a 00 00    	cmp    0xa60,%eax
 691:	75 ed                	jne    680 <malloc+0x40>
 693:	83 ec 0c             	sub    $0xc,%esp
 696:	56                   	push   %esi
 697:	e8 bf fc ff ff       	call   35b <sbrk>
 69c:	83 c4 10             	add    $0x10,%esp
 69f:	83 f8 ff             	cmp    $0xffffffff,%eax
 6a2:	74 1c                	je     6c0 <malloc+0x80>
 6a4:	89 58 04             	mov    %ebx,0x4(%eax)
 6a7:	83 ec 0c             	sub    $0xc,%esp
 6aa:	83 c0 08             	add    $0x8,%eax
 6ad:	50                   	push   %eax
 6ae:	e8 fd fe ff ff       	call   5b0 <free>
 6b3:	8b 15 60 0a 00 00    	mov    0xa60,%edx
 6b9:	83 c4 10             	add    $0x10,%esp
 6bc:	85 d2                	test   %edx,%edx
 6be:	75 c0                	jne    680 <malloc+0x40>
 6c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6c3:	31 c0                	xor    %eax,%eax
 6c5:	5b                   	pop    %ebx
 6c6:	5e                   	pop    %esi
 6c7:	5f                   	pop    %edi
 6c8:	5d                   	pop    %ebp
 6c9:	c3                   	ret
 6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6d0:	39 cf                	cmp    %ecx,%edi
 6d2:	74 4c                	je     720 <malloc+0xe0>
 6d4:	29 f9                	sub    %edi,%ecx
 6d6:	89 48 04             	mov    %ecx,0x4(%eax)
 6d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 6dc:	89 78 04             	mov    %edi,0x4(%eax)
 6df:	89 15 60 0a 00 00    	mov    %edx,0xa60
 6e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6e8:	83 c0 08             	add    $0x8,%eax
 6eb:	5b                   	pop    %ebx
 6ec:	5e                   	pop    %esi
 6ed:	5f                   	pop    %edi
 6ee:	5d                   	pop    %ebp
 6ef:	c3                   	ret
 6f0:	c7 05 60 0a 00 00 64 	movl   $0xa64,0xa60
 6f7:	0a 00 00 
 6fa:	b8 64 0a 00 00       	mov    $0xa64,%eax
 6ff:	c7 05 64 0a 00 00 64 	movl   $0xa64,0xa64
 706:	0a 00 00 
 709:	c7 05 68 0a 00 00 00 	movl   $0x0,0xa68
 710:	00 00 00 
 713:	e9 54 ff ff ff       	jmp    66c <malloc+0x2c>
 718:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 71f:	00 
 720:	8b 08                	mov    (%eax),%ecx
 722:	89 0a                	mov    %ecx,(%edx)
 724:	eb b9                	jmp    6df <malloc+0x9f>
