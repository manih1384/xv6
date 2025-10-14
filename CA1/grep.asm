
_grep:     file format elf32-i386


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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 6f                	jle    90 <main+0x90>
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  24:	83 c3 08             	add    $0x8,%ebx
  27:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  2b:	be 02 00 00 00       	mov    $0x2,%esi
  30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  33:	75 2d                	jne    62 <main+0x62>
  35:	eb 6c                	jmp    a3 <main+0xa3>
  37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  3e:	00 
  3f:	90                   	nop
  40:	83 ec 08             	sub    $0x8,%esp
  43:	83 c6 01             	add    $0x1,%esi
  46:	83 c3 04             	add    $0x4,%ebx
  49:	50                   	push   %eax
  4a:	ff 75 e0             	push   -0x20(%ebp)
  4d:	e8 9e 01 00 00       	call   1f0 <grep>
  52:	89 3c 24             	mov    %edi,(%esp)
  55:	e8 c1 05 00 00       	call   61b <close>
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  60:	7e 29                	jle    8b <main+0x8b>
  62:	83 ec 08             	sub    $0x8,%esp
  65:	6a 00                	push   $0x0
  67:	ff 33                	push   (%ebx)
  69:	e8 c5 05 00 00       	call   633 <open>
  6e:	83 c4 10             	add    $0x10,%esp
  71:	89 c7                	mov    %eax,%edi
  73:	85 c0                	test   %eax,%eax
  75:	79 c9                	jns    40 <main+0x40>
  77:	50                   	push   %eax
  78:	ff 33                	push   (%ebx)
  7a:	68 68 0a 00 00       	push   $0xa68
  7f:	6a 01                	push   $0x1
  81:	e8 ba 06 00 00       	call   740 <printf>
  86:	e8 68 05 00 00       	call   5f3 <exit>
  8b:	e8 63 05 00 00       	call   5f3 <exit>
  90:	51                   	push   %ecx
  91:	51                   	push   %ecx
  92:	68 48 0a 00 00       	push   $0xa48
  97:	6a 02                	push   $0x2
  99:	e8 a2 06 00 00       	call   740 <printf>
  9e:	e8 50 05 00 00       	call   5f3 <exit>
  a3:	52                   	push   %edx
  a4:	52                   	push   %edx
  a5:	6a 00                	push   $0x0
  a7:	50                   	push   %eax
  a8:	e8 43 01 00 00       	call   1f0 <grep>
  ad:	e8 41 05 00 00       	call   5f3 <exit>
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <matchhere>:
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 0c             	sub    $0xc,%esp
  c9:	8b 7d 08             	mov    0x8(%ebp),%edi
  cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  cf:	0f b6 0f             	movzbl (%edi),%ecx
  d2:	84 c9                	test   %cl,%cl
  d4:	0f 84 96 00 00 00    	je     170 <matchhere+0xb0>
  da:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  de:	3c 2a                	cmp    $0x2a,%al
  e0:	74 2d                	je     10f <matchhere+0x4f>
  e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  e8:	0f b6 33             	movzbl (%ebx),%esi
  eb:	80 f9 24             	cmp    $0x24,%cl
  ee:	74 50                	je     140 <matchhere+0x80>
  f0:	89 f2                	mov    %esi,%edx
  f2:	84 d2                	test   %dl,%dl
  f4:	74 6e                	je     164 <matchhere+0xa4>
  f6:	80 f9 2e             	cmp    $0x2e,%cl
  f9:	75 65                	jne    160 <matchhere+0xa0>
  fb:	83 c3 01             	add    $0x1,%ebx
  fe:	83 c7 01             	add    $0x1,%edi
 101:	84 c0                	test   %al,%al
 103:	74 6b                	je     170 <matchhere+0xb0>
 105:	89 c1                	mov    %eax,%ecx
 107:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 10b:	3c 2a                	cmp    $0x2a,%al
 10d:	75 d9                	jne    e8 <matchhere+0x28>
 10f:	8d 77 02             	lea    0x2(%edi),%esi
 112:	0f be f9             	movsbl %cl,%edi
 115:	8d 76 00             	lea    0x0(%esi),%esi
 118:	83 ec 08             	sub    $0x8,%esp
 11b:	53                   	push   %ebx
 11c:	56                   	push   %esi
 11d:	e8 9e ff ff ff       	call   c0 <matchhere>
 122:	83 c4 10             	add    $0x10,%esp
 125:	85 c0                	test   %eax,%eax
 127:	75 47                	jne    170 <matchhere+0xb0>
 129:	0f be 13             	movsbl (%ebx),%edx
 12c:	84 d2                	test   %dl,%dl
 12e:	74 45                	je     175 <matchhere+0xb5>
 130:	83 c3 01             	add    $0x1,%ebx
 133:	39 fa                	cmp    %edi,%edx
 135:	74 e1                	je     118 <matchhere+0x58>
 137:	83 ff 2e             	cmp    $0x2e,%edi
 13a:	74 dc                	je     118 <matchhere+0x58>
 13c:	eb 37                	jmp    175 <matchhere+0xb5>
 13e:	66 90                	xchg   %ax,%ax
 140:	84 c0                	test   %al,%al
 142:	74 39                	je     17d <matchhere+0xbd>
 144:	89 f2                	mov    %esi,%edx
 146:	84 d2                	test   %dl,%dl
 148:	74 1a                	je     164 <matchhere+0xa4>
 14a:	80 fa 24             	cmp    $0x24,%dl
 14d:	75 15                	jne    164 <matchhere+0xa4>
 14f:	83 c3 01             	add    $0x1,%ebx
 152:	83 c7 01             	add    $0x1,%edi
 155:	89 c1                	mov    %eax,%ecx
 157:	eb ae                	jmp    107 <matchhere+0x47>
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	38 ca                	cmp    %cl,%dl
 162:	74 97                	je     fb <matchhere+0x3b>
 164:	8d 65 f4             	lea    -0xc(%ebp),%esp
 167:	31 c0                	xor    %eax,%eax
 169:	5b                   	pop    %ebx
 16a:	5e                   	pop    %esi
 16b:	5f                   	pop    %edi
 16c:	5d                   	pop    %ebp
 16d:	c3                   	ret
 16e:	66 90                	xchg   %ax,%ax
 170:	b8 01 00 00 00       	mov    $0x1,%eax
 175:	8d 65 f4             	lea    -0xc(%ebp),%esp
 178:	5b                   	pop    %ebx
 179:	5e                   	pop    %esi
 17a:	5f                   	pop    %edi
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret
 17d:	89 f0                	mov    %esi,%eax
 17f:	84 c0                	test   %al,%al
 181:	0f 94 c0             	sete   %al
 184:	0f b6 c0             	movzbl %al,%eax
 187:	eb ec                	jmp    175 <matchhere+0xb5>
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000190 <match>:
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	56                   	push   %esi
 194:	53                   	push   %ebx
 195:	8b 5d 08             	mov    0x8(%ebp),%ebx
 198:	8b 75 0c             	mov    0xc(%ebp),%esi
 19b:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 19e:	75 11                	jne    1b1 <match+0x21>
 1a0:	eb 2e                	jmp    1d0 <match+0x40>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a8:	83 c6 01             	add    $0x1,%esi
 1ab:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 1af:	74 16                	je     1c7 <match+0x37>
 1b1:	83 ec 08             	sub    $0x8,%esp
 1b4:	56                   	push   %esi
 1b5:	53                   	push   %ebx
 1b6:	e8 05 ff ff ff       	call   c0 <matchhere>
 1bb:	83 c4 10             	add    $0x10,%esp
 1be:	85 c0                	test   %eax,%eax
 1c0:	74 e6                	je     1a8 <match+0x18>
 1c2:	b8 01 00 00 00       	mov    $0x1,%eax
 1c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1ca:	5b                   	pop    %ebx
 1cb:	5e                   	pop    %esi
 1cc:	5d                   	pop    %ebp
 1cd:	c3                   	ret
 1ce:	66 90                	xchg   %ax,%ax
 1d0:	83 c3 01             	add    $0x1,%ebx
 1d3:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1d9:	5b                   	pop    %ebx
 1da:	5e                   	pop    %esi
 1db:	5d                   	pop    %ebp
 1dc:	e9 df fe ff ff       	jmp    c0 <matchhere>
 1e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1e8:	00 
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <grep>:
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	31 ff                	xor    %edi,%edi
 1f6:	56                   	push   %esi
 1f7:	53                   	push   %ebx
 1f8:	83 ec 1c             	sub    $0x1c,%esp
 1fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1fe:	89 7d e0             	mov    %edi,-0x20(%ebp)
 201:	8d 43 01             	lea    0x1(%ebx),%eax
 204:	89 45 dc             	mov    %eax,-0x24(%ebp)
 207:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20e:	00 
 20f:	90                   	nop
 210:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 213:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 218:	83 ec 04             	sub    $0x4,%esp
 21b:	29 c8                	sub    %ecx,%eax
 21d:	50                   	push   %eax
 21e:	8d 81 80 0e 00 00    	lea    0xe80(%ecx),%eax
 224:	50                   	push   %eax
 225:	ff 75 0c             	push   0xc(%ebp)
 228:	e8 de 03 00 00       	call   60b <read>
 22d:	83 c4 10             	add    $0x10,%esp
 230:	85 c0                	test   %eax,%eax
 232:	0f 8e fd 00 00 00    	jle    335 <grep+0x145>
 238:	01 45 e0             	add    %eax,-0x20(%ebp)
 23b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 23e:	bf 80 0e 00 00       	mov    $0xe80,%edi
 243:	89 de                	mov    %ebx,%esi
 245:	c6 81 80 0e 00 00 00 	movb   $0x0,0xe80(%ecx)
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 250:	83 ec 08             	sub    $0x8,%esp
 253:	6a 0a                	push   $0xa
 255:	57                   	push   %edi
 256:	e8 25 02 00 00       	call   480 <strchr>
 25b:	83 c4 10             	add    $0x10,%esp
 25e:	89 c2                	mov    %eax,%edx
 260:	85 c0                	test   %eax,%eax
 262:	0f 84 88 00 00 00    	je     2f0 <grep+0x100>
 268:	c6 02 00             	movb   $0x0,(%edx)
 26b:	80 3e 5e             	cmpb   $0x5e,(%esi)
 26e:	74 58                	je     2c8 <grep+0xd8>
 270:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 273:	89 d3                	mov    %edx,%ebx
 275:	eb 12                	jmp    289 <grep+0x99>
 277:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27e:	00 
 27f:	90                   	nop
 280:	83 c7 01             	add    $0x1,%edi
 283:	80 7f ff 00          	cmpb   $0x0,-0x1(%edi)
 287:	74 37                	je     2c0 <grep+0xd0>
 289:	83 ec 08             	sub    $0x8,%esp
 28c:	57                   	push   %edi
 28d:	56                   	push   %esi
 28e:	e8 2d fe ff ff       	call   c0 <matchhere>
 293:	83 c4 10             	add    $0x10,%esp
 296:	85 c0                	test   %eax,%eax
 298:	74 e6                	je     280 <grep+0x90>
 29a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 29d:	89 da                	mov    %ebx,%edx
 29f:	8d 5b 01             	lea    0x1(%ebx),%ebx
 2a2:	89 d8                	mov    %ebx,%eax
 2a4:	83 ec 04             	sub    $0x4,%esp
 2a7:	c6 02 0a             	movb   $0xa,(%edx)
 2aa:	29 f8                	sub    %edi,%eax
 2ac:	50                   	push   %eax
 2ad:	57                   	push   %edi
 2ae:	89 df                	mov    %ebx,%edi
 2b0:	6a 01                	push   $0x1
 2b2:	e8 5c 03 00 00       	call   613 <write>
 2b7:	83 c4 10             	add    $0x10,%esp
 2ba:	eb 94                	jmp    250 <grep+0x60>
 2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c0:	8d 7b 01             	lea    0x1(%ebx),%edi
 2c3:	eb 8b                	jmp    250 <grep+0x60>
 2c5:	8d 76 00             	lea    0x0(%esi),%esi
 2c8:	83 ec 08             	sub    $0x8,%esp
 2cb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 2ce:	57                   	push   %edi
 2cf:	ff 75 dc             	push   -0x24(%ebp)
 2d2:	e8 e9 fd ff ff       	call   c0 <matchhere>
 2d7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 2da:	83 c4 10             	add    $0x10,%esp
 2dd:	8d 5a 01             	lea    0x1(%edx),%ebx
 2e0:	85 c0                	test   %eax,%eax
 2e2:	75 be                	jne    2a2 <grep+0xb2>
 2e4:	89 df                	mov    %ebx,%edi
 2e6:	e9 65 ff ff ff       	jmp    250 <grep+0x60>
 2eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 2f0:	89 f3                	mov    %esi,%ebx
 2f2:	81 ff 80 0e 00 00    	cmp    $0xe80,%edi
 2f8:	74 2f                	je     329 <grep+0x139>
 2fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
 2fd:	85 c0                	test   %eax,%eax
 2ff:	0f 8e 0b ff ff ff    	jle    210 <grep+0x20>
 305:	89 f8                	mov    %edi,%eax
 307:	83 ec 04             	sub    $0x4,%esp
 30a:	2d 80 0e 00 00       	sub    $0xe80,%eax
 30f:	29 45 e0             	sub    %eax,-0x20(%ebp)
 312:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 315:	51                   	push   %ecx
 316:	57                   	push   %edi
 317:	68 80 0e 00 00       	push   $0xe80
 31c:	e8 9f 02 00 00       	call   5c0 <memmove>
 321:	83 c4 10             	add    $0x10,%esp
 324:	e9 e7 fe ff ff       	jmp    210 <grep+0x20>
 329:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 330:	e9 db fe ff ff       	jmp    210 <grep+0x20>
 335:	8d 65 f4             	lea    -0xc(%ebp),%esp
 338:	5b                   	pop    %ebx
 339:	5e                   	pop    %esi
 33a:	5f                   	pop    %edi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret
 33d:	8d 76 00             	lea    0x0(%esi),%esi

00000340 <matchstar>:
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
 346:	83 ec 0c             	sub    $0xc,%esp
 349:	8b 5d 08             	mov    0x8(%ebp),%ebx
 34c:	8b 75 0c             	mov    0xc(%ebp),%esi
 34f:	8b 7d 10             	mov    0x10(%ebp),%edi
 352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 358:	83 ec 08             	sub    $0x8,%esp
 35b:	57                   	push   %edi
 35c:	56                   	push   %esi
 35d:	e8 5e fd ff ff       	call   c0 <matchhere>
 362:	83 c4 10             	add    $0x10,%esp
 365:	85 c0                	test   %eax,%eax
 367:	75 1f                	jne    388 <matchstar+0x48>
 369:	0f be 17             	movsbl (%edi),%edx
 36c:	84 d2                	test   %dl,%dl
 36e:	74 0c                	je     37c <matchstar+0x3c>
 370:	83 c7 01             	add    $0x1,%edi
 373:	83 fb 2e             	cmp    $0x2e,%ebx
 376:	74 e0                	je     358 <matchstar+0x18>
 378:	39 da                	cmp    %ebx,%edx
 37a:	74 dc                	je     358 <matchstar+0x18>
 37c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 37f:	5b                   	pop    %ebx
 380:	5e                   	pop    %esi
 381:	5f                   	pop    %edi
 382:	5d                   	pop    %ebp
 383:	c3                   	ret
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 388:	8d 65 f4             	lea    -0xc(%ebp),%esp
 38b:	b8 01 00 00 00       	mov    $0x1,%eax
 390:	5b                   	pop    %ebx
 391:	5e                   	pop    %esi
 392:	5f                   	pop    %edi
 393:	5d                   	pop    %ebp
 394:	c3                   	ret
 395:	66 90                	xchg   %ax,%ax
 397:	66 90                	xchg   %ax,%ax
 399:	66 90                	xchg   %ax,%ax
 39b:	66 90                	xchg   %ax,%ax
 39d:	66 90                	xchg   %ax,%ax
 39f:	90                   	nop

000003a0 <strcpy>:
 3a0:	55                   	push   %ebp
 3a1:	31 c0                	xor    %eax,%eax
 3a3:	89 e5                	mov    %esp,%ebp
 3a5:	53                   	push   %ebx
 3a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 3b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 3b7:	83 c0 01             	add    $0x1,%eax
 3ba:	84 d2                	test   %dl,%dl
 3bc:	75 f2                	jne    3b0 <strcpy+0x10>
 3be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3c1:	89 c8                	mov    %ecx,%eax
 3c3:	c9                   	leave
 3c4:	c3                   	ret
 3c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3cc:	00 
 3cd:	8d 76 00             	lea    0x0(%esi),%esi

000003d0 <strcmp>:
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	8b 55 08             	mov    0x8(%ebp),%edx
 3d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 3da:	0f b6 02             	movzbl (%edx),%eax
 3dd:	84 c0                	test   %al,%al
 3df:	75 17                	jne    3f8 <strcmp+0x28>
 3e1:	eb 3a                	jmp    41d <strcmp+0x4d>
 3e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 3e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
 3ec:	83 c2 01             	add    $0x1,%edx
 3ef:	8d 59 01             	lea    0x1(%ecx),%ebx
 3f2:	84 c0                	test   %al,%al
 3f4:	74 1a                	je     410 <strcmp+0x40>
 3f6:	89 d9                	mov    %ebx,%ecx
 3f8:	0f b6 19             	movzbl (%ecx),%ebx
 3fb:	38 c3                	cmp    %al,%bl
 3fd:	74 e9                	je     3e8 <strcmp+0x18>
 3ff:	29 d8                	sub    %ebx,%eax
 401:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 404:	c9                   	leave
 405:	c3                   	ret
 406:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40d:	00 
 40e:	66 90                	xchg   %ax,%ax
 410:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 414:	31 c0                	xor    %eax,%eax
 416:	29 d8                	sub    %ebx,%eax
 418:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 41b:	c9                   	leave
 41c:	c3                   	ret
 41d:	0f b6 19             	movzbl (%ecx),%ebx
 420:	31 c0                	xor    %eax,%eax
 422:	eb db                	jmp    3ff <strcmp+0x2f>
 424:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 42b:	00 
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000430 <strlen>:
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 55 08             	mov    0x8(%ebp),%edx
 436:	80 3a 00             	cmpb   $0x0,(%edx)
 439:	74 15                	je     450 <strlen+0x20>
 43b:	31 c0                	xor    %eax,%eax
 43d:	8d 76 00             	lea    0x0(%esi),%esi
 440:	83 c0 01             	add    $0x1,%eax
 443:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 447:	89 c1                	mov    %eax,%ecx
 449:	75 f5                	jne    440 <strlen+0x10>
 44b:	89 c8                	mov    %ecx,%eax
 44d:	5d                   	pop    %ebp
 44e:	c3                   	ret
 44f:	90                   	nop
 450:	31 c9                	xor    %ecx,%ecx
 452:	5d                   	pop    %ebp
 453:	89 c8                	mov    %ecx,%eax
 455:	c3                   	ret
 456:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45d:	00 
 45e:	66 90                	xchg   %ax,%ax

00000460 <memset>:
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	8b 55 08             	mov    0x8(%ebp),%edx
 467:	8b 4d 10             	mov    0x10(%ebp),%ecx
 46a:	8b 45 0c             	mov    0xc(%ebp),%eax
 46d:	89 d7                	mov    %edx,%edi
 46f:	fc                   	cld
 470:	f3 aa                	rep stos %al,%es:(%edi)
 472:	8b 7d fc             	mov    -0x4(%ebp),%edi
 475:	89 d0                	mov    %edx,%eax
 477:	c9                   	leave
 478:	c3                   	ret
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000480 <strchr>:
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	8b 45 08             	mov    0x8(%ebp),%eax
 486:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 48a:	0f b6 10             	movzbl (%eax),%edx
 48d:	84 d2                	test   %dl,%dl
 48f:	75 12                	jne    4a3 <strchr+0x23>
 491:	eb 1d                	jmp    4b0 <strchr+0x30>
 493:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 498:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 49c:	83 c0 01             	add    $0x1,%eax
 49f:	84 d2                	test   %dl,%dl
 4a1:	74 0d                	je     4b0 <strchr+0x30>
 4a3:	38 d1                	cmp    %dl,%cl
 4a5:	75 f1                	jne    498 <strchr+0x18>
 4a7:	5d                   	pop    %ebp
 4a8:	c3                   	ret
 4a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4b0:	31 c0                	xor    %eax,%eax
 4b2:	5d                   	pop    %ebp
 4b3:	c3                   	ret
 4b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4bb:	00 
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004c0 <gets>:
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4c8:	53                   	push   %ebx
 4c9:	31 db                	xor    %ebx,%ebx
 4cb:	8d 73 01             	lea    0x1(%ebx),%esi
 4ce:	83 ec 1c             	sub    $0x1c,%esp
 4d1:	3b 75 0c             	cmp    0xc(%ebp),%esi
 4d4:	7d 3b                	jge    511 <gets+0x51>
 4d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4dd:	00 
 4de:	66 90                	xchg   %ax,%ax
 4e0:	83 ec 04             	sub    $0x4,%esp
 4e3:	6a 01                	push   $0x1
 4e5:	57                   	push   %edi
 4e6:	6a 00                	push   $0x0
 4e8:	e8 1e 01 00 00       	call   60b <read>
 4ed:	83 c4 10             	add    $0x10,%esp
 4f0:	85 c0                	test   %eax,%eax
 4f2:	7e 1d                	jle    511 <gets+0x51>
 4f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4f8:	8b 55 08             	mov    0x8(%ebp),%edx
 4fb:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
 4ff:	3c 0a                	cmp    $0xa,%al
 501:	7f 25                	jg     528 <gets+0x68>
 503:	3c 08                	cmp    $0x8,%al
 505:	7f 0c                	jg     513 <gets+0x53>
 507:	89 f3                	mov    %esi,%ebx
 509:	8d 73 01             	lea    0x1(%ebx),%esi
 50c:	3b 75 0c             	cmp    0xc(%ebp),%esi
 50f:	7c cf                	jl     4e0 <gets+0x20>
 511:	89 de                	mov    %ebx,%esi
 513:	8b 45 08             	mov    0x8(%ebp),%eax
 516:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 51a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51d:	5b                   	pop    %ebx
 51e:	5e                   	pop    %esi
 51f:	5f                   	pop    %edi
 520:	5d                   	pop    %ebp
 521:	c3                   	ret
 522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 528:	3c 0d                	cmp    $0xd,%al
 52a:	74 e7                	je     513 <gets+0x53>
 52c:	89 f3                	mov    %esi,%ebx
 52e:	eb d9                	jmp    509 <gets+0x49>

00000530 <stat>:
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	56                   	push   %esi
 534:	53                   	push   %ebx
 535:	83 ec 08             	sub    $0x8,%esp
 538:	6a 00                	push   $0x0
 53a:	ff 75 08             	push   0x8(%ebp)
 53d:	e8 f1 00 00 00       	call   633 <open>
 542:	83 c4 10             	add    $0x10,%esp
 545:	85 c0                	test   %eax,%eax
 547:	78 27                	js     570 <stat+0x40>
 549:	83 ec 08             	sub    $0x8,%esp
 54c:	ff 75 0c             	push   0xc(%ebp)
 54f:	89 c3                	mov    %eax,%ebx
 551:	50                   	push   %eax
 552:	e8 f4 00 00 00       	call   64b <fstat>
 557:	89 1c 24             	mov    %ebx,(%esp)
 55a:	89 c6                	mov    %eax,%esi
 55c:	e8 ba 00 00 00       	call   61b <close>
 561:	83 c4 10             	add    $0x10,%esp
 564:	8d 65 f8             	lea    -0x8(%ebp),%esp
 567:	89 f0                	mov    %esi,%eax
 569:	5b                   	pop    %ebx
 56a:	5e                   	pop    %esi
 56b:	5d                   	pop    %ebp
 56c:	c3                   	ret
 56d:	8d 76 00             	lea    0x0(%esi),%esi
 570:	be ff ff ff ff       	mov    $0xffffffff,%esi
 575:	eb ed                	jmp    564 <stat+0x34>
 577:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 57e:	00 
 57f:	90                   	nop

00000580 <atoi>:
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	53                   	push   %ebx
 584:	8b 55 08             	mov    0x8(%ebp),%edx
 587:	0f be 02             	movsbl (%edx),%eax
 58a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 58d:	80 f9 09             	cmp    $0x9,%cl
 590:	b9 00 00 00 00       	mov    $0x0,%ecx
 595:	77 1e                	ja     5b5 <atoi+0x35>
 597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59e:	00 
 59f:	90                   	nop
 5a0:	83 c2 01             	add    $0x1,%edx
 5a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 5a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 5aa:	0f be 02             	movsbl (%edx),%eax
 5ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 5b0:	80 fb 09             	cmp    $0x9,%bl
 5b3:	76 eb                	jbe    5a0 <atoi+0x20>
 5b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5b8:	89 c8                	mov    %ecx,%eax
 5ba:	c9                   	leave
 5bb:	c3                   	ret
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005c0 <memmove>:
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	8b 45 10             	mov    0x10(%ebp),%eax
 5c7:	8b 55 08             	mov    0x8(%ebp),%edx
 5ca:	56                   	push   %esi
 5cb:	8b 75 0c             	mov    0xc(%ebp),%esi
 5ce:	85 c0                	test   %eax,%eax
 5d0:	7e 13                	jle    5e5 <memmove+0x25>
 5d2:	01 d0                	add    %edx,%eax
 5d4:	89 d7                	mov    %edx,%edi
 5d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5dd:	00 
 5de:	66 90                	xchg   %ax,%ax
 5e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 5e1:	39 f8                	cmp    %edi,%eax
 5e3:	75 fb                	jne    5e0 <memmove+0x20>
 5e5:	5e                   	pop    %esi
 5e6:	89 d0                	mov    %edx,%eax
 5e8:	5f                   	pop    %edi
 5e9:	5d                   	pop    %ebp
 5ea:	c3                   	ret

000005eb <fork>:
 5eb:	b8 01 00 00 00       	mov    $0x1,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret

000005f3 <exit>:
 5f3:	b8 02 00 00 00       	mov    $0x2,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret

000005fb <wait>:
 5fb:	b8 03 00 00 00       	mov    $0x3,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret

00000603 <pipe>:
 603:	b8 04 00 00 00       	mov    $0x4,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret

0000060b <read>:
 60b:	b8 05 00 00 00       	mov    $0x5,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret

00000613 <write>:
 613:	b8 10 00 00 00       	mov    $0x10,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret

0000061b <close>:
 61b:	b8 15 00 00 00       	mov    $0x15,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret

00000623 <kill>:
 623:	b8 06 00 00 00       	mov    $0x6,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret

0000062b <exec>:
 62b:	b8 07 00 00 00       	mov    $0x7,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret

00000633 <open>:
 633:	b8 0f 00 00 00       	mov    $0xf,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret

0000063b <mknod>:
 63b:	b8 11 00 00 00       	mov    $0x11,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret

00000643 <unlink>:
 643:	b8 12 00 00 00       	mov    $0x12,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret

0000064b <fstat>:
 64b:	b8 08 00 00 00       	mov    $0x8,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret

00000653 <link>:
 653:	b8 13 00 00 00       	mov    $0x13,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret

0000065b <mkdir>:
 65b:	b8 14 00 00 00       	mov    $0x14,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret

00000663 <chdir>:
 663:	b8 09 00 00 00       	mov    $0x9,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret

0000066b <dup>:
 66b:	b8 0a 00 00 00       	mov    $0xa,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret

00000673 <getpid>:
 673:	b8 0b 00 00 00       	mov    $0xb,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret

0000067b <sbrk>:
 67b:	b8 0c 00 00 00       	mov    $0xc,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret

00000683 <sleep>:
 683:	b8 0d 00 00 00       	mov    $0xd,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret

0000068b <uptime>:
 68b:	b8 0e 00 00 00       	mov    $0xe,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret
 693:	66 90                	xchg   %ax,%ax
 695:	66 90                	xchg   %ax,%ax
 697:	66 90                	xchg   %ax,%ax
 699:	66 90                	xchg   %ax,%ax
 69b:	66 90                	xchg   %ax,%ax
 69d:	66 90                	xchg   %ax,%ax
 69f:	90                   	nop

000006a0 <printint>:
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	89 cb                	mov    %ecx,%ebx
 6a8:	89 d1                	mov    %edx,%ecx
 6aa:	83 ec 3c             	sub    $0x3c,%esp
 6ad:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6b0:	85 d2                	test   %edx,%edx
 6b2:	0f 89 80 00 00 00    	jns    738 <printint+0x98>
 6b8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6bc:	74 7a                	je     738 <printint+0x98>
 6be:	f7 d9                	neg    %ecx
 6c0:	b8 01 00 00 00       	mov    $0x1,%eax
 6c5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 6c8:	31 f6                	xor    %esi,%esi
 6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6d0:	89 c8                	mov    %ecx,%eax
 6d2:	31 d2                	xor    %edx,%edx
 6d4:	89 f7                	mov    %esi,%edi
 6d6:	f7 f3                	div    %ebx
 6d8:	8d 76 01             	lea    0x1(%esi),%esi
 6db:	0f b6 92 e0 0a 00 00 	movzbl 0xae0(%edx),%edx
 6e2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
 6e6:	89 ca                	mov    %ecx,%edx
 6e8:	89 c1                	mov    %eax,%ecx
 6ea:	39 da                	cmp    %ebx,%edx
 6ec:	73 e2                	jae    6d0 <printint+0x30>
 6ee:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 6f1:	85 c0                	test   %eax,%eax
 6f3:	74 07                	je     6fc <printint+0x5c>
 6f5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 6fa:	89 f7                	mov    %esi,%edi
 6fc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 6ff:	8b 75 c0             	mov    -0x40(%ebp),%esi
 702:	01 df                	add    %ebx,%edi
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 708:	0f b6 07             	movzbl (%edi),%eax
 70b:	83 ec 04             	sub    $0x4,%esp
 70e:	88 45 d7             	mov    %al,-0x29(%ebp)
 711:	8d 45 d7             	lea    -0x29(%ebp),%eax
 714:	6a 01                	push   $0x1
 716:	50                   	push   %eax
 717:	56                   	push   %esi
 718:	e8 f6 fe ff ff       	call   613 <write>
 71d:	89 f8                	mov    %edi,%eax
 71f:	83 c4 10             	add    $0x10,%esp
 722:	83 ef 01             	sub    $0x1,%edi
 725:	39 c3                	cmp    %eax,%ebx
 727:	75 df                	jne    708 <printint+0x68>
 729:	8d 65 f4             	lea    -0xc(%ebp),%esp
 72c:	5b                   	pop    %ebx
 72d:	5e                   	pop    %esi
 72e:	5f                   	pop    %edi
 72f:	5d                   	pop    %ebp
 730:	c3                   	ret
 731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 738:	31 c0                	xor    %eax,%eax
 73a:	eb 89                	jmp    6c5 <printint+0x25>
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000740 <printf>:
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 2c             	sub    $0x2c,%esp
 749:	8b 75 0c             	mov    0xc(%ebp),%esi
 74c:	8b 7d 08             	mov    0x8(%ebp),%edi
 74f:	0f b6 1e             	movzbl (%esi),%ebx
 752:	83 c6 01             	add    $0x1,%esi
 755:	84 db                	test   %bl,%bl
 757:	74 67                	je     7c0 <printf+0x80>
 759:	8d 4d 10             	lea    0x10(%ebp),%ecx
 75c:	31 d2                	xor    %edx,%edx
 75e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 761:	eb 34                	jmp    797 <printf+0x57>
 763:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 768:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 76b:	ba 25 00 00 00       	mov    $0x25,%edx
 770:	83 f8 25             	cmp    $0x25,%eax
 773:	74 18                	je     78d <printf+0x4d>
 775:	83 ec 04             	sub    $0x4,%esp
 778:	8d 45 e7             	lea    -0x19(%ebp),%eax
 77b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 77e:	6a 01                	push   $0x1
 780:	50                   	push   %eax
 781:	57                   	push   %edi
 782:	e8 8c fe ff ff       	call   613 <write>
 787:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 78a:	83 c4 10             	add    $0x10,%esp
 78d:	0f b6 1e             	movzbl (%esi),%ebx
 790:	83 c6 01             	add    $0x1,%esi
 793:	84 db                	test   %bl,%bl
 795:	74 29                	je     7c0 <printf+0x80>
 797:	0f b6 c3             	movzbl %bl,%eax
 79a:	85 d2                	test   %edx,%edx
 79c:	74 ca                	je     768 <printf+0x28>
 79e:	83 fa 25             	cmp    $0x25,%edx
 7a1:	75 ea                	jne    78d <printf+0x4d>
 7a3:	83 f8 25             	cmp    $0x25,%eax
 7a6:	0f 84 04 01 00 00    	je     8b0 <printf+0x170>
 7ac:	83 e8 63             	sub    $0x63,%eax
 7af:	83 f8 15             	cmp    $0x15,%eax
 7b2:	77 1c                	ja     7d0 <printf+0x90>
 7b4:	ff 24 85 88 0a 00 00 	jmp    *0xa88(,%eax,4)
 7bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 7c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7c3:	5b                   	pop    %ebx
 7c4:	5e                   	pop    %esi
 7c5:	5f                   	pop    %edi
 7c6:	5d                   	pop    %ebp
 7c7:	c3                   	ret
 7c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7cf:	00 
 7d0:	83 ec 04             	sub    $0x4,%esp
 7d3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 7d6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7da:	6a 01                	push   $0x1
 7dc:	52                   	push   %edx
 7dd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 7e0:	57                   	push   %edi
 7e1:	e8 2d fe ff ff       	call   613 <write>
 7e6:	83 c4 0c             	add    $0xc,%esp
 7e9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 7ec:	6a 01                	push   $0x1
 7ee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 7f1:	52                   	push   %edx
 7f2:	57                   	push   %edi
 7f3:	e8 1b fe ff ff       	call   613 <write>
 7f8:	83 c4 10             	add    $0x10,%esp
 7fb:	31 d2                	xor    %edx,%edx
 7fd:	eb 8e                	jmp    78d <printf+0x4d>
 7ff:	90                   	nop
 800:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 803:	83 ec 0c             	sub    $0xc,%esp
 806:	b9 10 00 00 00       	mov    $0x10,%ecx
 80b:	8b 13                	mov    (%ebx),%edx
 80d:	6a 00                	push   $0x0
 80f:	89 f8                	mov    %edi,%eax
 811:	83 c3 04             	add    $0x4,%ebx
 814:	e8 87 fe ff ff       	call   6a0 <printint>
 819:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 81c:	83 c4 10             	add    $0x10,%esp
 81f:	31 d2                	xor    %edx,%edx
 821:	e9 67 ff ff ff       	jmp    78d <printf+0x4d>
 826:	8b 45 d0             	mov    -0x30(%ebp),%eax
 829:	8b 18                	mov    (%eax),%ebx
 82b:	83 c0 04             	add    $0x4,%eax
 82e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 831:	85 db                	test   %ebx,%ebx
 833:	0f 84 87 00 00 00    	je     8c0 <printf+0x180>
 839:	0f b6 03             	movzbl (%ebx),%eax
 83c:	31 d2                	xor    %edx,%edx
 83e:	84 c0                	test   %al,%al
 840:	0f 84 47 ff ff ff    	je     78d <printf+0x4d>
 846:	8d 55 e7             	lea    -0x19(%ebp),%edx
 849:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 84c:	89 de                	mov    %ebx,%esi
 84e:	89 d3                	mov    %edx,%ebx
 850:	83 ec 04             	sub    $0x4,%esp
 853:	88 45 e7             	mov    %al,-0x19(%ebp)
 856:	83 c6 01             	add    $0x1,%esi
 859:	6a 01                	push   $0x1
 85b:	53                   	push   %ebx
 85c:	57                   	push   %edi
 85d:	e8 b1 fd ff ff       	call   613 <write>
 862:	0f b6 06             	movzbl (%esi),%eax
 865:	83 c4 10             	add    $0x10,%esp
 868:	84 c0                	test   %al,%al
 86a:	75 e4                	jne    850 <printf+0x110>
 86c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 86f:	31 d2                	xor    %edx,%edx
 871:	e9 17 ff ff ff       	jmp    78d <printf+0x4d>
 876:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 879:	83 ec 0c             	sub    $0xc,%esp
 87c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 881:	8b 13                	mov    (%ebx),%edx
 883:	6a 01                	push   $0x1
 885:	eb 88                	jmp    80f <printf+0xcf>
 887:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 88a:	83 ec 04             	sub    $0x4,%esp
 88d:	8d 55 e7             	lea    -0x19(%ebp),%edx
 890:	8b 03                	mov    (%ebx),%eax
 892:	83 c3 04             	add    $0x4,%ebx
 895:	88 45 e7             	mov    %al,-0x19(%ebp)
 898:	6a 01                	push   $0x1
 89a:	52                   	push   %edx
 89b:	57                   	push   %edi
 89c:	e8 72 fd ff ff       	call   613 <write>
 8a1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8a4:	83 c4 10             	add    $0x10,%esp
 8a7:	31 d2                	xor    %edx,%edx
 8a9:	e9 df fe ff ff       	jmp    78d <printf+0x4d>
 8ae:	66 90                	xchg   %ax,%ax
 8b0:	83 ec 04             	sub    $0x4,%esp
 8b3:	88 5d e7             	mov    %bl,-0x19(%ebp)
 8b6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 8b9:	6a 01                	push   $0x1
 8bb:	e9 31 ff ff ff       	jmp    7f1 <printf+0xb1>
 8c0:	b8 28 00 00 00       	mov    $0x28,%eax
 8c5:	bb 7e 0a 00 00       	mov    $0xa7e,%ebx
 8ca:	e9 77 ff ff ff       	jmp    846 <printf+0x106>
 8cf:	90                   	nop

000008d0 <free>:
 8d0:	55                   	push   %ebp
 8d1:	a1 80 12 00 00       	mov    0x1280,%eax
 8d6:	89 e5                	mov    %esp,%ebp
 8d8:	57                   	push   %edi
 8d9:	56                   	push   %esi
 8da:	53                   	push   %ebx
 8db:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 8e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8e8:	8b 10                	mov    (%eax),%edx
 8ea:	39 c8                	cmp    %ecx,%eax
 8ec:	73 32                	jae    920 <free+0x50>
 8ee:	39 d1                	cmp    %edx,%ecx
 8f0:	72 04                	jb     8f6 <free+0x26>
 8f2:	39 d0                	cmp    %edx,%eax
 8f4:	72 32                	jb     928 <free+0x58>
 8f6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8f9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8fc:	39 fa                	cmp    %edi,%edx
 8fe:	74 30                	je     930 <free+0x60>
 900:	89 53 f8             	mov    %edx,-0x8(%ebx)
 903:	8b 50 04             	mov    0x4(%eax),%edx
 906:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 909:	39 f1                	cmp    %esi,%ecx
 90b:	74 3a                	je     947 <free+0x77>
 90d:	89 08                	mov    %ecx,(%eax)
 90f:	5b                   	pop    %ebx
 910:	a3 80 12 00 00       	mov    %eax,0x1280
 915:	5e                   	pop    %esi
 916:	5f                   	pop    %edi
 917:	5d                   	pop    %ebp
 918:	c3                   	ret
 919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 920:	39 d0                	cmp    %edx,%eax
 922:	72 04                	jb     928 <free+0x58>
 924:	39 d1                	cmp    %edx,%ecx
 926:	72 ce                	jb     8f6 <free+0x26>
 928:	89 d0                	mov    %edx,%eax
 92a:	eb bc                	jmp    8e8 <free+0x18>
 92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 930:	03 72 04             	add    0x4(%edx),%esi
 933:	89 73 fc             	mov    %esi,-0x4(%ebx)
 936:	8b 10                	mov    (%eax),%edx
 938:	8b 12                	mov    (%edx),%edx
 93a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 93d:	8b 50 04             	mov    0x4(%eax),%edx
 940:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 943:	39 f1                	cmp    %esi,%ecx
 945:	75 c6                	jne    90d <free+0x3d>
 947:	03 53 fc             	add    -0x4(%ebx),%edx
 94a:	a3 80 12 00 00       	mov    %eax,0x1280
 94f:	89 50 04             	mov    %edx,0x4(%eax)
 952:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 955:	89 08                	mov    %ecx,(%eax)
 957:	5b                   	pop    %ebx
 958:	5e                   	pop    %esi
 959:	5f                   	pop    %edi
 95a:	5d                   	pop    %ebp
 95b:	c3                   	ret
 95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000960 <malloc>:
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	57                   	push   %edi
 964:	56                   	push   %esi
 965:	53                   	push   %ebx
 966:	83 ec 0c             	sub    $0xc,%esp
 969:	8b 45 08             	mov    0x8(%ebp),%eax
 96c:	8b 15 80 12 00 00    	mov    0x1280,%edx
 972:	8d 78 07             	lea    0x7(%eax),%edi
 975:	c1 ef 03             	shr    $0x3,%edi
 978:	83 c7 01             	add    $0x1,%edi
 97b:	85 d2                	test   %edx,%edx
 97d:	0f 84 8d 00 00 00    	je     a10 <malloc+0xb0>
 983:	8b 02                	mov    (%edx),%eax
 985:	8b 48 04             	mov    0x4(%eax),%ecx
 988:	39 f9                	cmp    %edi,%ecx
 98a:	73 64                	jae    9f0 <malloc+0x90>
 98c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 991:	39 df                	cmp    %ebx,%edi
 993:	0f 43 df             	cmovae %edi,%ebx
 996:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 99d:	eb 0a                	jmp    9a9 <malloc+0x49>
 99f:	90                   	nop
 9a0:	8b 02                	mov    (%edx),%eax
 9a2:	8b 48 04             	mov    0x4(%eax),%ecx
 9a5:	39 f9                	cmp    %edi,%ecx
 9a7:	73 47                	jae    9f0 <malloc+0x90>
 9a9:	89 c2                	mov    %eax,%edx
 9ab:	3b 05 80 12 00 00    	cmp    0x1280,%eax
 9b1:	75 ed                	jne    9a0 <malloc+0x40>
 9b3:	83 ec 0c             	sub    $0xc,%esp
 9b6:	56                   	push   %esi
 9b7:	e8 bf fc ff ff       	call   67b <sbrk>
 9bc:	83 c4 10             	add    $0x10,%esp
 9bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 9c2:	74 1c                	je     9e0 <malloc+0x80>
 9c4:	89 58 04             	mov    %ebx,0x4(%eax)
 9c7:	83 ec 0c             	sub    $0xc,%esp
 9ca:	83 c0 08             	add    $0x8,%eax
 9cd:	50                   	push   %eax
 9ce:	e8 fd fe ff ff       	call   8d0 <free>
 9d3:	8b 15 80 12 00 00    	mov    0x1280,%edx
 9d9:	83 c4 10             	add    $0x10,%esp
 9dc:	85 d2                	test   %edx,%edx
 9de:	75 c0                	jne    9a0 <malloc+0x40>
 9e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9e3:	31 c0                	xor    %eax,%eax
 9e5:	5b                   	pop    %ebx
 9e6:	5e                   	pop    %esi
 9e7:	5f                   	pop    %edi
 9e8:	5d                   	pop    %ebp
 9e9:	c3                   	ret
 9ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9f0:	39 cf                	cmp    %ecx,%edi
 9f2:	74 4c                	je     a40 <malloc+0xe0>
 9f4:	29 f9                	sub    %edi,%ecx
 9f6:	89 48 04             	mov    %ecx,0x4(%eax)
 9f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 9fc:	89 78 04             	mov    %edi,0x4(%eax)
 9ff:	89 15 80 12 00 00    	mov    %edx,0x1280
 a05:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a08:	83 c0 08             	add    $0x8,%eax
 a0b:	5b                   	pop    %ebx
 a0c:	5e                   	pop    %esi
 a0d:	5f                   	pop    %edi
 a0e:	5d                   	pop    %ebp
 a0f:	c3                   	ret
 a10:	c7 05 80 12 00 00 84 	movl   $0x1284,0x1280
 a17:	12 00 00 
 a1a:	b8 84 12 00 00       	mov    $0x1284,%eax
 a1f:	c7 05 84 12 00 00 84 	movl   $0x1284,0x1284
 a26:	12 00 00 
 a29:	c7 05 88 12 00 00 00 	movl   $0x0,0x1288
 a30:	00 00 00 
 a33:	e9 54 ff ff ff       	jmp    98c <malloc+0x2c>
 a38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a3f:	00 
 a40:	8b 08                	mov    (%eax),%ecx
 a42:	89 0a                	mov    %ecx,(%edx)
 a44:	eb b9                	jmp    9ff <malloc+0x9f>
