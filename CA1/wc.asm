
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	be 01 00 00 00       	mov    $0x1,%esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  21:	83 c3 04             	add    $0x4,%ebx
  24:	83 f8 01             	cmp    $0x1,%eax
  27:	7f 28                	jg     51 <main+0x51>
  29:	eb 54                	jmp    7f <main+0x7f>
  2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  30:	83 ec 08             	sub    $0x8,%esp
  33:	ff 33                	push   (%ebx)
  35:	83 c6 01             	add    $0x1,%esi
  38:	83 c3 04             	add    $0x4,%ebx
  3b:	50                   	push   %eax
  3c:	e8 5f 00 00 00       	call   a0 <wc>
  41:	89 3c 24             	mov    %edi,(%esp)
  44:	e8 b2 03 00 00       	call   3fb <close>
  49:	83 c4 10             	add    $0x10,%esp
  4c:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  4f:	74 29                	je     7a <main+0x7a>
  51:	83 ec 08             	sub    $0x8,%esp
  54:	6a 00                	push   $0x0
  56:	ff 33                	push   (%ebx)
  58:	e8 b6 03 00 00       	call   413 <open>
  5d:	83 c4 10             	add    $0x10,%esp
  60:	89 c7                	mov    %eax,%edi
  62:	85 c0                	test   %eax,%eax
  64:	79 ca                	jns    30 <main+0x30>
  66:	50                   	push   %eax
  67:	ff 33                	push   (%ebx)
  69:	68 4b 08 00 00       	push   $0x84b
  6e:	6a 01                	push   $0x1
  70:	e8 ab 04 00 00       	call   520 <printf>
  75:	e8 59 03 00 00       	call   3d3 <exit>
  7a:	e8 54 03 00 00       	call   3d3 <exit>
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 3d 08 00 00       	push   $0x83d
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
  8d:	e8 41 03 00 00       	call   3d3 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
  a0:	55                   	push   %ebp
  a1:	31 d2                	xor    %edx,%edx
  a3:	89 e5                	mov    %esp,%ebp
  a5:	57                   	push   %edi
  a6:	56                   	push   %esi
  a7:	31 f6                	xor    %esi,%esi
  a9:	53                   	push   %ebx
  aa:	31 db                	xor    %ebx,%ebx
  ac:	83 ec 1c             	sub    $0x1c,%esp
  af:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b6:	89 55 dc             	mov    %edx,-0x24(%ebp)
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 a0 0b 00 00       	push   $0xba0
  cd:	ff 75 08             	push   0x8(%ebp)
  d0:	e8 16 03 00 00       	call   3eb <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	89 c1                	mov    %eax,%ecx
  da:	85 c0                	test   %eax,%eax
  dc:	7e 62                	jle    140 <wc+0xa0>
  de:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  e1:	31 ff                	xor    %edi,%edi
  e3:	eb 0d                	jmp    f2 <wc+0x52>
  e5:	8d 76 00             	lea    0x0(%esi),%esi
  e8:	31 f6                	xor    %esi,%esi
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  f0:	74 3e                	je     130 <wc+0x90>
  f2:	0f be 87 a0 0b 00 00 	movsbl 0xba0(%edi),%eax
  f9:	31 c9                	xor    %ecx,%ecx
  fb:	3c 0a                	cmp    $0xa,%al
  fd:	0f 94 c1             	sete   %cl
 100:	83 ec 08             	sub    $0x8,%esp
 103:	50                   	push   %eax
 104:	01 cb                	add    %ecx,%ebx
 106:	68 28 08 00 00       	push   $0x828
 10b:	e8 50 01 00 00       	call   260 <strchr>
 110:	83 c4 10             	add    $0x10,%esp
 113:	85 c0                	test   %eax,%eax
 115:	75 d1                	jne    e8 <wc+0x48>
 117:	85 f6                	test   %esi,%esi
 119:	75 cf                	jne    ea <wc+0x4a>
 11b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
 11f:	be 01 00 00 00       	mov    $0x1,%esi
 124:	83 c7 01             	add    $0x1,%edi
 127:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 12a:	75 c6                	jne    f2 <wc+0x52>
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 133:	01 4d dc             	add    %ecx,-0x24(%ebp)
 136:	eb 88                	jmp    c0 <wc+0x20>
 138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13f:	00 
 140:	8b 55 dc             	mov    -0x24(%ebp),%edx
 143:	75 22                	jne    167 <wc+0xc7>
 145:	83 ec 08             	sub    $0x8,%esp
 148:	ff 75 0c             	push   0xc(%ebp)
 14b:	52                   	push   %edx
 14c:	ff 75 e0             	push   -0x20(%ebp)
 14f:	53                   	push   %ebx
 150:	68 3e 08 00 00       	push   $0x83e
 155:	6a 01                	push   $0x1
 157:	e8 c4 03 00 00       	call   520 <printf>
 15c:	83 c4 20             	add    $0x20,%esp
 15f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 162:	5b                   	pop    %ebx
 163:	5e                   	pop    %esi
 164:	5f                   	pop    %edi
 165:	5d                   	pop    %ebp
 166:	c3                   	ret
 167:	50                   	push   %eax
 168:	50                   	push   %eax
 169:	68 2e 08 00 00       	push   $0x82e
 16e:	6a 01                	push   $0x1
 170:	e8 ab 03 00 00       	call   520 <printf>
 175:	e8 59 02 00 00       	call   3d3 <exit>
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
 180:	55                   	push   %ebp
 181:	31 c0                	xor    %eax,%eax
 183:	89 e5                	mov    %esp,%ebp
 185:	53                   	push   %ebx
 186:	8b 4d 08             	mov    0x8(%ebp),%ecx
 189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 197:	83 c0 01             	add    $0x1,%eax
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strcpy+0x10>
 19e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a1:	89 c8                	mov    %ecx,%eax
 1a3:	c9                   	leave
 1a4:	c3                   	ret
 1a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ac:	00 
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <strcmp>:
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	75 17                	jne    1d8 <strcmp+0x28>
 1c1:	eb 3a                	jmp    1fd <strcmp+0x4d>
 1c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
 1cc:	83 c2 01             	add    $0x1,%edx
 1cf:	8d 59 01             	lea    0x1(%ecx),%ebx
 1d2:	84 c0                	test   %al,%al
 1d4:	74 1a                	je     1f0 <strcmp+0x40>
 1d6:	89 d9                	mov    %ebx,%ecx
 1d8:	0f b6 19             	movzbl (%ecx),%ebx
 1db:	38 c3                	cmp    %al,%bl
 1dd:	74 e9                	je     1c8 <strcmp+0x18>
 1df:	29 d8                	sub    %ebx,%eax
 1e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1e4:	c9                   	leave
 1e5:	c3                   	ret
 1e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ed:	00 
 1ee:	66 90                	xchg   %ax,%ax
 1f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1f4:	31 c0                	xor    %eax,%eax
 1f6:	29 d8                	sub    %ebx,%eax
 1f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fb:	c9                   	leave
 1fc:	c3                   	ret
 1fd:	0f b6 19             	movzbl (%ecx),%ebx
 200:	31 c0                	xor    %eax,%eax
 202:	eb db                	jmp    1df <strcmp+0x2f>
 204:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20b:	00 
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <strlen>:
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
 216:	80 3a 00             	cmpb   $0x0,(%edx)
 219:	74 15                	je     230 <strlen+0x20>
 21b:	31 c0                	xor    %eax,%eax
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	83 c0 01             	add    $0x1,%eax
 223:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 227:	89 c1                	mov    %eax,%ecx
 229:	75 f5                	jne    220 <strlen+0x10>
 22b:	89 c8                	mov    %ecx,%eax
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret
 22f:	90                   	nop
 230:	31 c9                	xor    %ecx,%ecx
 232:	5d                   	pop    %ebp
 233:	89 c8                	mov    %ecx,%eax
 235:	c3                   	ret
 236:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23d:	00 
 23e:	66 90                	xchg   %ax,%ax

00000240 <memset>:
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 55 08             	mov    0x8(%ebp),%edx
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld
 250:	f3 aa                	rep stos %al,%es:(%edi)
 252:	8b 7d fc             	mov    -0x4(%ebp),%edi
 255:	89 d0                	mov    %edx,%eax
 257:	c9                   	leave
 258:	c3                   	ret
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000260 <strchr>:
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	75 12                	jne    283 <strchr+0x23>
 271:	eb 1d                	jmp    290 <strchr+0x30>
 273:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 27c:	83 c0 01             	add    $0x1,%eax
 27f:	84 d2                	test   %dl,%dl
 281:	74 0d                	je     290 <strchr+0x30>
 283:	38 d1                	cmp    %dl,%cl
 285:	75 f1                	jne    278 <strchr+0x18>
 287:	5d                   	pop    %ebp
 288:	c3                   	ret
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 290:	31 c0                	xor    %eax,%eax
 292:	5d                   	pop    %ebp
 293:	c3                   	ret
 294:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29b:	00 
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <gets>:
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
 2a5:	8d 7d e7             	lea    -0x19(%ebp),%edi
 2a8:	53                   	push   %ebx
 2a9:	31 db                	xor    %ebx,%ebx
 2ab:	8d 73 01             	lea    0x1(%ebx),%esi
 2ae:	83 ec 1c             	sub    $0x1c,%esp
 2b1:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2b4:	7d 3b                	jge    2f1 <gets+0x51>
 2b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2bd:	00 
 2be:	66 90                	xchg   %ax,%ax
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	6a 01                	push   $0x1
 2c5:	57                   	push   %edi
 2c6:	6a 00                	push   $0x0
 2c8:	e8 1e 01 00 00       	call   3eb <read>
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	85 c0                	test   %eax,%eax
 2d2:	7e 1d                	jle    2f1 <gets+0x51>
 2d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2d8:	8b 55 08             	mov    0x8(%ebp),%edx
 2db:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
 2df:	3c 0a                	cmp    $0xa,%al
 2e1:	7f 25                	jg     308 <gets+0x68>
 2e3:	3c 08                	cmp    $0x8,%al
 2e5:	7f 0c                	jg     2f3 <gets+0x53>
 2e7:	89 f3                	mov    %esi,%ebx
 2e9:	8d 73 01             	lea    0x1(%ebx),%esi
 2ec:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2ef:	7c cf                	jl     2c0 <gets+0x20>
 2f1:	89 de                	mov    %ebx,%esi
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 2fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fd:	5b                   	pop    %ebx
 2fe:	5e                   	pop    %esi
 2ff:	5f                   	pop    %edi
 300:	5d                   	pop    %ebp
 301:	c3                   	ret
 302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 308:	3c 0d                	cmp    $0xd,%al
 30a:	74 e7                	je     2f3 <gets+0x53>
 30c:	89 f3                	mov    %esi,%ebx
 30e:	eb d9                	jmp    2e9 <gets+0x49>

00000310 <stat>:
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
 315:	83 ec 08             	sub    $0x8,%esp
 318:	6a 00                	push   $0x0
 31a:	ff 75 08             	push   0x8(%ebp)
 31d:	e8 f1 00 00 00       	call   413 <open>
 322:	83 c4 10             	add    $0x10,%esp
 325:	85 c0                	test   %eax,%eax
 327:	78 27                	js     350 <stat+0x40>
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	ff 75 0c             	push   0xc(%ebp)
 32f:	89 c3                	mov    %eax,%ebx
 331:	50                   	push   %eax
 332:	e8 f4 00 00 00       	call   42b <fstat>
 337:	89 1c 24             	mov    %ebx,(%esp)
 33a:	89 c6                	mov    %eax,%esi
 33c:	e8 ba 00 00 00       	call   3fb <close>
 341:	83 c4 10             	add    $0x10,%esp
 344:	8d 65 f8             	lea    -0x8(%ebp),%esp
 347:	89 f0                	mov    %esi,%eax
 349:	5b                   	pop    %ebx
 34a:	5e                   	pop    %esi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret
 34d:	8d 76 00             	lea    0x0(%esi),%esi
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb ed                	jmp    344 <stat+0x34>
 357:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35e:	00 
 35f:	90                   	nop

00000360 <atoi>:
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	0f be 02             	movsbl (%edx),%eax
 36a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 36d:	80 f9 09             	cmp    $0x9,%cl
 370:	b9 00 00 00 00       	mov    $0x0,%ecx
 375:	77 1e                	ja     395 <atoi+0x35>
 377:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37e:	00 
 37f:	90                   	nop
 380:	83 c2 01             	add    $0x1,%edx
 383:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 386:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 38a:	0f be 02             	movsbl (%edx),%eax
 38d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
 395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 398:	89 c8                	mov    %ecx,%eax
 39a:	c9                   	leave
 39b:	c3                   	ret
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003a0 <memmove>:
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	8b 45 10             	mov    0x10(%ebp),%eax
 3a7:	8b 55 08             	mov    0x8(%ebp),%edx
 3aa:	56                   	push   %esi
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
 3ae:	85 c0                	test   %eax,%eax
 3b0:	7e 13                	jle    3c5 <memmove+0x25>
 3b2:	01 d0                	add    %edx,%eax
 3b4:	89 d7                	mov    %edx,%edi
 3b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bd:	00 
 3be:	66 90                	xchg   %ax,%ax
 3c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 3c1:	39 f8                	cmp    %edi,%eax
 3c3:	75 fb                	jne    3c0 <memmove+0x20>
 3c5:	5e                   	pop    %esi
 3c6:	89 d0                	mov    %edx,%eax
 3c8:	5f                   	pop    %edi
 3c9:	5d                   	pop    %ebp
 3ca:	c3                   	ret

000003cb <fork>:
 3cb:	b8 01 00 00 00       	mov    $0x1,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <exit>:
 3d3:	b8 02 00 00 00       	mov    $0x2,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <wait>:
 3db:	b8 03 00 00 00       	mov    $0x3,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <pipe>:
 3e3:	b8 04 00 00 00       	mov    $0x4,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <read>:
 3eb:	b8 05 00 00 00       	mov    $0x5,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <write>:
 3f3:	b8 10 00 00 00       	mov    $0x10,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <close>:
 3fb:	b8 15 00 00 00       	mov    $0x15,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <kill>:
 403:	b8 06 00 00 00       	mov    $0x6,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <exec>:
 40b:	b8 07 00 00 00       	mov    $0x7,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <open>:
 413:	b8 0f 00 00 00       	mov    $0xf,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <mknod>:
 41b:	b8 11 00 00 00       	mov    $0x11,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <unlink>:
 423:	b8 12 00 00 00       	mov    $0x12,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <fstat>:
 42b:	b8 08 00 00 00       	mov    $0x8,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <link>:
 433:	b8 13 00 00 00       	mov    $0x13,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <mkdir>:
 43b:	b8 14 00 00 00       	mov    $0x14,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <chdir>:
 443:	b8 09 00 00 00       	mov    $0x9,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <dup>:
 44b:	b8 0a 00 00 00       	mov    $0xa,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <getpid>:
 453:	b8 0b 00 00 00       	mov    $0xb,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <sbrk>:
 45b:	b8 0c 00 00 00       	mov    $0xc,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <sleep>:
 463:	b8 0d 00 00 00       	mov    $0xd,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <uptime>:
 46b:	b8 0e 00 00 00       	mov    $0xe,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret
 473:	66 90                	xchg   %ax,%ax
 475:	66 90                	xchg   %ax,%ax
 477:	66 90                	xchg   %ax,%ax
 479:	66 90                	xchg   %ax,%ax
 47b:	66 90                	xchg   %ax,%ax
 47d:	66 90                	xchg   %ax,%ax
 47f:	90                   	nop

00000480 <printint>:
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	89 cb                	mov    %ecx,%ebx
 488:	89 d1                	mov    %edx,%ecx
 48a:	83 ec 3c             	sub    $0x3c,%esp
 48d:	89 45 c0             	mov    %eax,-0x40(%ebp)
 490:	85 d2                	test   %edx,%edx
 492:	0f 89 80 00 00 00    	jns    518 <printint+0x98>
 498:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 49c:	74 7a                	je     518 <printint+0x98>
 49e:	f7 d9                	neg    %ecx
 4a0:	b8 01 00 00 00       	mov    $0x1,%eax
 4a5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 4a8:	31 f6                	xor    %esi,%esi
 4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4b0:	89 c8                	mov    %ecx,%eax
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	89 f7                	mov    %esi,%edi
 4b6:	f7 f3                	div    %ebx
 4b8:	8d 76 01             	lea    0x1(%esi),%esi
 4bb:	0f b6 92 c0 08 00 00 	movzbl 0x8c0(%edx),%edx
 4c2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
 4c6:	89 ca                	mov    %ecx,%edx
 4c8:	89 c1                	mov    %eax,%ecx
 4ca:	39 da                	cmp    %ebx,%edx
 4cc:	73 e2                	jae    4b0 <printint+0x30>
 4ce:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4d1:	85 c0                	test   %eax,%eax
 4d3:	74 07                	je     4dc <printint+0x5c>
 4d5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 4da:	89 f7                	mov    %esi,%edi
 4dc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4df:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4e2:	01 df                	add    %ebx,%edi
 4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e8:	0f b6 07             	movzbl (%edi),%eax
 4eb:	83 ec 04             	sub    $0x4,%esp
 4ee:	88 45 d7             	mov    %al,-0x29(%ebp)
 4f1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4f4:	6a 01                	push   $0x1
 4f6:	50                   	push   %eax
 4f7:	56                   	push   %esi
 4f8:	e8 f6 fe ff ff       	call   3f3 <write>
 4fd:	89 f8                	mov    %edi,%eax
 4ff:	83 c4 10             	add    $0x10,%esp
 502:	83 ef 01             	sub    $0x1,%edi
 505:	39 c3                	cmp    %eax,%ebx
 507:	75 df                	jne    4e8 <printint+0x68>
 509:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50c:	5b                   	pop    %ebx
 50d:	5e                   	pop    %esi
 50e:	5f                   	pop    %edi
 50f:	5d                   	pop    %ebp
 510:	c3                   	ret
 511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 518:	31 c0                	xor    %eax,%eax
 51a:	eb 89                	jmp    4a5 <printint+0x25>
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000520 <printf>:
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 2c             	sub    $0x2c,%esp
 529:	8b 75 0c             	mov    0xc(%ebp),%esi
 52c:	8b 7d 08             	mov    0x8(%ebp),%edi
 52f:	0f b6 1e             	movzbl (%esi),%ebx
 532:	83 c6 01             	add    $0x1,%esi
 535:	84 db                	test   %bl,%bl
 537:	74 67                	je     5a0 <printf+0x80>
 539:	8d 4d 10             	lea    0x10(%ebp),%ecx
 53c:	31 d2                	xor    %edx,%edx
 53e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 541:	eb 34                	jmp    577 <printf+0x57>
 543:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 548:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 54b:	ba 25 00 00 00       	mov    $0x25,%edx
 550:	83 f8 25             	cmp    $0x25,%eax
 553:	74 18                	je     56d <printf+0x4d>
 555:	83 ec 04             	sub    $0x4,%esp
 558:	8d 45 e7             	lea    -0x19(%ebp),%eax
 55b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 55e:	6a 01                	push   $0x1
 560:	50                   	push   %eax
 561:	57                   	push   %edi
 562:	e8 8c fe ff ff       	call   3f3 <write>
 567:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 56a:	83 c4 10             	add    $0x10,%esp
 56d:	0f b6 1e             	movzbl (%esi),%ebx
 570:	83 c6 01             	add    $0x1,%esi
 573:	84 db                	test   %bl,%bl
 575:	74 29                	je     5a0 <printf+0x80>
 577:	0f b6 c3             	movzbl %bl,%eax
 57a:	85 d2                	test   %edx,%edx
 57c:	74 ca                	je     548 <printf+0x28>
 57e:	83 fa 25             	cmp    $0x25,%edx
 581:	75 ea                	jne    56d <printf+0x4d>
 583:	83 f8 25             	cmp    $0x25,%eax
 586:	0f 84 04 01 00 00    	je     690 <printf+0x170>
 58c:	83 e8 63             	sub    $0x63,%eax
 58f:	83 f8 15             	cmp    $0x15,%eax
 592:	77 1c                	ja     5b0 <printf+0x90>
 594:	ff 24 85 68 08 00 00 	jmp    *0x868(,%eax,4)
 59b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 5a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5a3:	5b                   	pop    %ebx
 5a4:	5e                   	pop    %esi
 5a5:	5f                   	pop    %edi
 5a6:	5d                   	pop    %ebp
 5a7:	c3                   	ret
 5a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5af:	00 
 5b0:	83 ec 04             	sub    $0x4,%esp
 5b3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5b6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5ba:	6a 01                	push   $0x1
 5bc:	52                   	push   %edx
 5bd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5c0:	57                   	push   %edi
 5c1:	e8 2d fe ff ff       	call   3f3 <write>
 5c6:	83 c4 0c             	add    $0xc,%esp
 5c9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5cc:	6a 01                	push   $0x1
 5ce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5d1:	52                   	push   %edx
 5d2:	57                   	push   %edi
 5d3:	e8 1b fe ff ff       	call   3f3 <write>
 5d8:	83 c4 10             	add    $0x10,%esp
 5db:	31 d2                	xor    %edx,%edx
 5dd:	eb 8e                	jmp    56d <printf+0x4d>
 5df:	90                   	nop
 5e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5e3:	83 ec 0c             	sub    $0xc,%esp
 5e6:	b9 10 00 00 00       	mov    $0x10,%ecx
 5eb:	8b 13                	mov    (%ebx),%edx
 5ed:	6a 00                	push   $0x0
 5ef:	89 f8                	mov    %edi,%eax
 5f1:	83 c3 04             	add    $0x4,%ebx
 5f4:	e8 87 fe ff ff       	call   480 <printint>
 5f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5fc:	83 c4 10             	add    $0x10,%esp
 5ff:	31 d2                	xor    %edx,%edx
 601:	e9 67 ff ff ff       	jmp    56d <printf+0x4d>
 606:	8b 45 d0             	mov    -0x30(%ebp),%eax
 609:	8b 18                	mov    (%eax),%ebx
 60b:	83 c0 04             	add    $0x4,%eax
 60e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 611:	85 db                	test   %ebx,%ebx
 613:	0f 84 87 00 00 00    	je     6a0 <printf+0x180>
 619:	0f b6 03             	movzbl (%ebx),%eax
 61c:	31 d2                	xor    %edx,%edx
 61e:	84 c0                	test   %al,%al
 620:	0f 84 47 ff ff ff    	je     56d <printf+0x4d>
 626:	8d 55 e7             	lea    -0x19(%ebp),%edx
 629:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 62c:	89 de                	mov    %ebx,%esi
 62e:	89 d3                	mov    %edx,%ebx
 630:	83 ec 04             	sub    $0x4,%esp
 633:	88 45 e7             	mov    %al,-0x19(%ebp)
 636:	83 c6 01             	add    $0x1,%esi
 639:	6a 01                	push   $0x1
 63b:	53                   	push   %ebx
 63c:	57                   	push   %edi
 63d:	e8 b1 fd ff ff       	call   3f3 <write>
 642:	0f b6 06             	movzbl (%esi),%eax
 645:	83 c4 10             	add    $0x10,%esp
 648:	84 c0                	test   %al,%al
 64a:	75 e4                	jne    630 <printf+0x110>
 64c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 64f:	31 d2                	xor    %edx,%edx
 651:	e9 17 ff ff ff       	jmp    56d <printf+0x4d>
 656:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 659:	83 ec 0c             	sub    $0xc,%esp
 65c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 661:	8b 13                	mov    (%ebx),%edx
 663:	6a 01                	push   $0x1
 665:	eb 88                	jmp    5ef <printf+0xcf>
 667:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 66a:	83 ec 04             	sub    $0x4,%esp
 66d:	8d 55 e7             	lea    -0x19(%ebp),%edx
 670:	8b 03                	mov    (%ebx),%eax
 672:	83 c3 04             	add    $0x4,%ebx
 675:	88 45 e7             	mov    %al,-0x19(%ebp)
 678:	6a 01                	push   $0x1
 67a:	52                   	push   %edx
 67b:	57                   	push   %edi
 67c:	e8 72 fd ff ff       	call   3f3 <write>
 681:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 684:	83 c4 10             	add    $0x10,%esp
 687:	31 d2                	xor    %edx,%edx
 689:	e9 df fe ff ff       	jmp    56d <printf+0x4d>
 68e:	66 90                	xchg   %ax,%ax
 690:	83 ec 04             	sub    $0x4,%esp
 693:	88 5d e7             	mov    %bl,-0x19(%ebp)
 696:	8d 55 e7             	lea    -0x19(%ebp),%edx
 699:	6a 01                	push   $0x1
 69b:	e9 31 ff ff ff       	jmp    5d1 <printf+0xb1>
 6a0:	b8 28 00 00 00       	mov    $0x28,%eax
 6a5:	bb 5f 08 00 00       	mov    $0x85f,%ebx
 6aa:	e9 77 ff ff ff       	jmp    626 <printf+0x106>
 6af:	90                   	nop

000006b0 <free>:
 6b0:	55                   	push   %ebp
 6b1:	a1 a0 0d 00 00       	mov    0xda0,%eax
 6b6:	89 e5                	mov    %esp,%ebp
 6b8:	57                   	push   %edi
 6b9:	56                   	push   %esi
 6ba:	53                   	push   %ebx
 6bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 6c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6c8:	8b 10                	mov    (%eax),%edx
 6ca:	39 c8                	cmp    %ecx,%eax
 6cc:	73 32                	jae    700 <free+0x50>
 6ce:	39 d1                	cmp    %edx,%ecx
 6d0:	72 04                	jb     6d6 <free+0x26>
 6d2:	39 d0                	cmp    %edx,%eax
 6d4:	72 32                	jb     708 <free+0x58>
 6d6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6d9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6dc:	39 fa                	cmp    %edi,%edx
 6de:	74 30                	je     710 <free+0x60>
 6e0:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6e3:	8b 50 04             	mov    0x4(%eax),%edx
 6e6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6e9:	39 f1                	cmp    %esi,%ecx
 6eb:	74 3a                	je     727 <free+0x77>
 6ed:	89 08                	mov    %ecx,(%eax)
 6ef:	5b                   	pop    %ebx
 6f0:	a3 a0 0d 00 00       	mov    %eax,0xda0
 6f5:	5e                   	pop    %esi
 6f6:	5f                   	pop    %edi
 6f7:	5d                   	pop    %ebp
 6f8:	c3                   	ret
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 700:	39 d0                	cmp    %edx,%eax
 702:	72 04                	jb     708 <free+0x58>
 704:	39 d1                	cmp    %edx,%ecx
 706:	72 ce                	jb     6d6 <free+0x26>
 708:	89 d0                	mov    %edx,%eax
 70a:	eb bc                	jmp    6c8 <free+0x18>
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 710:	03 72 04             	add    0x4(%edx),%esi
 713:	89 73 fc             	mov    %esi,-0x4(%ebx)
 716:	8b 10                	mov    (%eax),%edx
 718:	8b 12                	mov    (%edx),%edx
 71a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 71d:	8b 50 04             	mov    0x4(%eax),%edx
 720:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 723:	39 f1                	cmp    %esi,%ecx
 725:	75 c6                	jne    6ed <free+0x3d>
 727:	03 53 fc             	add    -0x4(%ebx),%edx
 72a:	a3 a0 0d 00 00       	mov    %eax,0xda0
 72f:	89 50 04             	mov    %edx,0x4(%eax)
 732:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 735:	89 08                	mov    %ecx,(%eax)
 737:	5b                   	pop    %ebx
 738:	5e                   	pop    %esi
 739:	5f                   	pop    %edi
 73a:	5d                   	pop    %ebp
 73b:	c3                   	ret
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000740 <malloc>:
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 0c             	sub    $0xc,%esp
 749:	8b 45 08             	mov    0x8(%ebp),%eax
 74c:	8b 15 a0 0d 00 00    	mov    0xda0,%edx
 752:	8d 78 07             	lea    0x7(%eax),%edi
 755:	c1 ef 03             	shr    $0x3,%edi
 758:	83 c7 01             	add    $0x1,%edi
 75b:	85 d2                	test   %edx,%edx
 75d:	0f 84 8d 00 00 00    	je     7f0 <malloc+0xb0>
 763:	8b 02                	mov    (%edx),%eax
 765:	8b 48 04             	mov    0x4(%eax),%ecx
 768:	39 f9                	cmp    %edi,%ecx
 76a:	73 64                	jae    7d0 <malloc+0x90>
 76c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 771:	39 df                	cmp    %ebx,%edi
 773:	0f 43 df             	cmovae %edi,%ebx
 776:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 77d:	eb 0a                	jmp    789 <malloc+0x49>
 77f:	90                   	nop
 780:	8b 02                	mov    (%edx),%eax
 782:	8b 48 04             	mov    0x4(%eax),%ecx
 785:	39 f9                	cmp    %edi,%ecx
 787:	73 47                	jae    7d0 <malloc+0x90>
 789:	89 c2                	mov    %eax,%edx
 78b:	3b 05 a0 0d 00 00    	cmp    0xda0,%eax
 791:	75 ed                	jne    780 <malloc+0x40>
 793:	83 ec 0c             	sub    $0xc,%esp
 796:	56                   	push   %esi
 797:	e8 bf fc ff ff       	call   45b <sbrk>
 79c:	83 c4 10             	add    $0x10,%esp
 79f:	83 f8 ff             	cmp    $0xffffffff,%eax
 7a2:	74 1c                	je     7c0 <malloc+0x80>
 7a4:	89 58 04             	mov    %ebx,0x4(%eax)
 7a7:	83 ec 0c             	sub    $0xc,%esp
 7aa:	83 c0 08             	add    $0x8,%eax
 7ad:	50                   	push   %eax
 7ae:	e8 fd fe ff ff       	call   6b0 <free>
 7b3:	8b 15 a0 0d 00 00    	mov    0xda0,%edx
 7b9:	83 c4 10             	add    $0x10,%esp
 7bc:	85 d2                	test   %edx,%edx
 7be:	75 c0                	jne    780 <malloc+0x40>
 7c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7c3:	31 c0                	xor    %eax,%eax
 7c5:	5b                   	pop    %ebx
 7c6:	5e                   	pop    %esi
 7c7:	5f                   	pop    %edi
 7c8:	5d                   	pop    %ebp
 7c9:	c3                   	ret
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7d0:	39 cf                	cmp    %ecx,%edi
 7d2:	74 4c                	je     820 <malloc+0xe0>
 7d4:	29 f9                	sub    %edi,%ecx
 7d6:	89 48 04             	mov    %ecx,0x4(%eax)
 7d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 7dc:	89 78 04             	mov    %edi,0x4(%eax)
 7df:	89 15 a0 0d 00 00    	mov    %edx,0xda0
 7e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7e8:	83 c0 08             	add    $0x8,%eax
 7eb:	5b                   	pop    %ebx
 7ec:	5e                   	pop    %esi
 7ed:	5f                   	pop    %edi
 7ee:	5d                   	pop    %ebp
 7ef:	c3                   	ret
 7f0:	c7 05 a0 0d 00 00 a4 	movl   $0xda4,0xda0
 7f7:	0d 00 00 
 7fa:	b8 a4 0d 00 00       	mov    $0xda4,%eax
 7ff:	c7 05 a4 0d 00 00 a4 	movl   $0xda4,0xda4
 806:	0d 00 00 
 809:	c7 05 a8 0d 00 00 00 	movl   $0x0,0xda8
 810:	00 00 00 
 813:	e9 54 ff ff ff       	jmp    76c <malloc+0x2c>
 818:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 81f:	00 
 820:	8b 08                	mov    (%eax),%ecx
 822:	89 0a                	mov    %ecx,(%edx)
 824:	eb b9                	jmp    7df <malloc+0x9f>
