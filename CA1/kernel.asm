
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc f0 64 11 80       	mov    $0x801164f0,%esp
8010002d:	b8 30 3d 10 80       	mov    $0x80103d30,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
80100049:	83 ec 0c             	sub    $0xc,%esp
8010004c:	68 60 7e 10 80       	push   $0x80107e60
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 55 50 00 00       	call   801050b0 <initlock>
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
80100092:	68 67 7e 10 80       	push   $0x80107e67
80100097:	50                   	push   %eax
80100098:	e8 e3 4e 00 00       	call   80104f80 <initsleeplock>
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 b7 51 00 00       	call   801052a0 <acquire>
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 d9 50 00 00       	call   80105240 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 4e 4e 00 00       	call   80104fc0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 3f 2e 00 00       	call   80102fd0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 6e 7e 10 80       	push   $0x80107e6e
801001a6:	e8 e5 08 00 00       	call   80100a90 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 9d 4e 00 00       	call   80105060 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
801001d4:	e9 f7 2d 00 00       	jmp    80102fd0 <iderw>
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 7f 7e 10 80       	push   $0x80107e7f
801001e1:	e8 aa 08 00 00       	call   80100a90 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 5c 4e 00 00       	call   80105060 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 0c 4e 00 00       	call   80105020 <releasesleep>
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 80 50 00 00       	call   801052a0 <acquire>
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100223:	83 c4 10             	add    $0x10,%esp
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
8010023f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100244:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
8010024e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
80100256:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
8010025c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
80100269:	e9 d2 4f 00 00       	jmp    80105240 <release>
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 86 7e 10 80       	push   $0x80107e86
80100276:	e8 15 08 00 00       	call   80100a90 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:



int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 e7 22 00 00       	call   80102580 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801002a0:	e8 fb 4f 00 00       	call   801052a0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 96 00 00 00    	jle    80100346 <consoleread+0xc6>
    // Wait for the writer (consoleintr or consolewrite) to provide input.
    while(input.r == input.w){
801002b0:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801002b5:	39 05 24 ff 10 80    	cmp    %eax,0x8010ff24
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 40 ff 10 80       	push   $0x8010ff40
801002c8:	68 20 ff 10 80       	push   $0x8010ff20
801002cd:	e8 4e 4a 00 00       	call   80104d20 <sleep>
    while(input.r == input.w){
801002d2:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 79 43 00 00       	call   80104660 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 40 ff 10 80       	push   $0x8010ff40
801002f6:	e8 45 4f 00 00       	call   80105240 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 9c 21 00 00       	call   801024a0 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 20 ff 10 80    	mov    %edx,0x8010ff20
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 92 a0 fe 10 80 	movsbl -0x7fef0160(%edx),%edx
    if(c == C('D')){  // Handle EOF
8010032d:	80 fa 04             	cmp    $0x4,%dl
80100330:	74 39                	je     8010036b <consoleread+0xeb>
    *dst++ = c;
80100332:	88 16                	mov    %dl,(%esi)
    if(c == '\n' || c == '\t')
80100334:	83 ea 09             	sub    $0x9,%edx
    *dst++ = c;
80100337:	83 c6 01             	add    $0x1,%esi
    --n;
8010033a:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n' || c == '\t')
8010033d:	83 fa 01             	cmp    $0x1,%edx
80100340:	0f 87 62 ff ff ff    	ja     801002a8 <consoleread+0x28>
  release(&cons.lock);
80100346:	83 ec 0c             	sub    $0xc,%esp
80100349:	68 40 ff 10 80       	push   $0x8010ff40
8010034e:	e8 ed 4e 00 00       	call   80105240 <release>
  ilock(ip);
80100353:	58                   	pop    %eax
80100354:	ff 75 08             	push   0x8(%ebp)
80100357:	e8 44 21 00 00       	call   801024a0 <ilock>
  return target - n;
8010035c:	89 f8                	mov    %edi,%eax
8010035e:	83 c4 10             	add    $0x10,%esp
}
80100361:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100364:	29 d8                	sub    %ebx,%eax
}
80100366:	5b                   	pop    %ebx
80100367:	5e                   	pop    %esi
80100368:	5f                   	pop    %edi
80100369:	5d                   	pop    %ebp
8010036a:	c3                   	ret
      if(n < target){
8010036b:	39 fb                	cmp    %edi,%ebx
8010036d:	73 d7                	jae    80100346 <consoleread+0xc6>
        input.r--;
8010036f:	a3 20 ff 10 80       	mov    %eax,0x8010ff20
80100374:	eb d0                	jmp    80100346 <consoleread+0xc6>
80100376:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037d:	00 
8010037e:	66 90                	xchg   %ax,%ax

80100380 <append_cga_pos>:
    if (cga_pos_sequence.size >= cga_pos_sequence.cap) {
80100380:	a1 20 94 10 80       	mov    0x80109420,%eax
80100385:	3b 05 24 94 10 80    	cmp    0x80109424,%eax
8010038b:	7d 1b                	jge    801003a8 <append_cga_pos+0x28>
void append_cga_pos(int pos) {
8010038d:	55                   	push   %ebp
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
8010038e:	8d 50 01             	lea    0x1(%eax),%edx
80100391:	89 15 20 94 10 80    	mov    %edx,0x80109420
void append_cga_pos(int pos) {
80100397:	89 e5                	mov    %esp,%ebp
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
80100399:	8b 55 08             	mov    0x8(%ebp),%edx
}
8010039c:	5d                   	pop    %ebp
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
8010039d:	89 14 85 20 92 10 80 	mov    %edx,-0x7fef6de0(,%eax,4)
}
801003a4:	c3                   	ret
801003a5:	8d 76 00             	lea    0x0(%esi),%esi
801003a8:	c3                   	ret
801003a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801003b0 <last_cga_pos>:
    if (cga_pos_sequence.size == 0) return -1;
801003b0:	a1 20 94 10 80       	mov    0x80109420,%eax
801003b5:	85 c0                	test   %eax,%eax
801003b7:	74 0f                	je     801003c8 <last_cga_pos+0x18>
    return cga_pos_sequence.pos_data[cga_pos_sequence.size - 1];
801003b9:	8b 04 85 1c 92 10 80 	mov    -0x7fef6de4(,%eax,4),%eax
801003c0:	c3                   	ret
801003c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (cga_pos_sequence.size == 0) return -1;
801003c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801003cd:	c3                   	ret
801003ce:	66 90                	xchg   %ax,%ax

801003d0 <delete_last_cga_pos>:
    if (cga_pos_sequence.size > 0) {
801003d0:	a1 20 94 10 80       	mov    0x80109420,%eax
801003d5:	85 c0                	test   %eax,%eax
801003d7:	7e 08                	jle    801003e1 <delete_last_cga_pos+0x11>
        cga_pos_sequence.size--;
801003d9:	83 e8 01             	sub    $0x1,%eax
801003dc:	a3 20 94 10 80       	mov    %eax,0x80109420
}
801003e1:	c3                   	ret
801003e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801003e9:	00 
801003ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801003f0 <clear_cga_pos_sequence>:
    cga_pos_sequence.size = 0;
801003f0:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
801003f7:	00 00 00 
}
801003fa:	c3                   	ret
801003fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100400 <delete_from_cga_pos_sequence>:
void delete_from_cga_pos_sequence(int pos) {
80100400:	55                   	push   %ebp
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100401:	8b 15 20 94 10 80    	mov    0x80109420,%edx
void delete_from_cga_pos_sequence(int pos) {
80100407:	89 e5                	mov    %esp,%ebp
80100409:	53                   	push   %ebx
8010040a:	8b 5d 08             	mov    0x8(%ebp),%ebx
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010040d:	85 d2                	test   %edx,%edx
8010040f:	7e 5b                	jle    8010046c <delete_from_cga_pos_sequence+0x6c>
80100411:	31 c0                	xor    %eax,%eax
80100413:	eb 0a                	jmp    8010041f <delete_from_cga_pos_sequence+0x1f>
80100415:	8d 76 00             	lea    0x0(%esi),%esi
80100418:	83 c0 01             	add    $0x1,%eax
8010041b:	39 d0                	cmp    %edx,%eax
8010041d:	74 4d                	je     8010046c <delete_from_cga_pos_sequence+0x6c>
        if (cga_pos_sequence.pos_data[i] == pos) {
8010041f:	39 1c 85 20 92 10 80 	cmp    %ebx,-0x7fef6de0(,%eax,4)
80100426:	75 f0                	jne    80100418 <delete_from_cga_pos_sequence+0x18>
    for (int i = idx; i < cga_pos_sequence.size - 1; i++) {
80100428:	83 ea 01             	sub    $0x1,%edx
8010042b:	39 c2                	cmp    %eax,%edx
8010042d:	7e 42                	jle    80100471 <delete_from_cga_pos_sequence+0x71>
8010042f:	90                   	nop
        cga_pos_sequence.pos_data[i] = cga_pos_sequence.pos_data[i + 1];
80100430:	83 c0 01             	add    $0x1,%eax
80100433:	8b 0c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ecx
8010043a:	89 0c 85 1c 92 10 80 	mov    %ecx,-0x7fef6de4(,%eax,4)
    for (int i = idx; i < cga_pos_sequence.size - 1; i++) {
80100441:	39 d0                	cmp    %edx,%eax
80100443:	75 eb                	jne    80100430 <delete_from_cga_pos_sequence+0x30>
    cga_pos_sequence.size--;
80100445:	89 15 20 94 10 80    	mov    %edx,0x80109420
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010044b:	31 c0                	xor    %eax,%eax
8010044d:	8d 76 00             	lea    0x0(%esi),%esi
        if (cga_pos_sequence.pos_data[i] > pos) {
80100450:	8b 0c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ecx
80100457:	39 d9                	cmp    %ebx,%ecx
80100459:	7e 0a                	jle    80100465 <delete_from_cga_pos_sequence+0x65>
            cga_pos_sequence.pos_data[i]--;
8010045b:	83 e9 01             	sub    $0x1,%ecx
8010045e:	89 0c 85 20 92 10 80 	mov    %ecx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100465:	83 c0 01             	add    $0x1,%eax
80100468:	39 d0                	cmp    %edx,%eax
8010046a:	75 e4                	jne    80100450 <delete_from_cga_pos_sequence+0x50>
}
8010046c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010046f:	c9                   	leave
80100470:	c3                   	ret
    cga_pos_sequence.size--;
80100471:	89 15 20 94 10 80    	mov    %edx,0x80109420
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100477:	85 d2                	test   %edx,%edx
80100479:	75 d0                	jne    8010044b <delete_from_cga_pos_sequence+0x4b>
8010047b:	eb ef                	jmp    8010046c <delete_from_cga_pos_sequence+0x6c>
8010047d:	8d 76 00             	lea    0x0(%esi),%esi

80100480 <cgaputc>:
{
80100480:	55                   	push   %ebp
80100481:	89 c1                	mov    %eax,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100483:	b8 0e 00 00 00       	mov    $0xe,%eax
80100488:	89 e5                	mov    %esp,%ebp
8010048a:	57                   	push   %edi
8010048b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100490:	56                   	push   %esi
80100491:	89 fa                	mov    %edi,%edx
80100493:	53                   	push   %ebx
80100494:	83 ec 1c             	sub    $0x1c,%esp
80100497:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100498:	be d5 03 00 00       	mov    $0x3d5,%esi
8010049d:	89 f2                	mov    %esi,%edx
8010049f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801004a0:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004aa:	c1 e3 08             	shl    $0x8,%ebx
801004ad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004ae:	89 f2                	mov    %esi,%edx
801004b0:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801004b1:	0f b6 f0             	movzbl %al,%esi
801004b4:	09 de                	or     %ebx,%esi
  if(c == '\n'){
801004b6:	83 f9 0a             	cmp    $0xa,%ecx
801004b9:	0f 84 89 01 00 00    	je     80100648 <cgaputc+0x1c8>
    else if(c == BACKSPACE){
801004bf:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
801004c5:	0f 84 f5 00 00 00    	je     801005c0 <cgaputc+0x140>
    if (cga_pos_sequence.size == 0) return -1;
801004cb:	8b 1d 20 94 10 80    	mov    0x80109420,%ebx
else if (c == UNDO_BS) {
801004d1:	81 f9 01 01 00 00    	cmp    $0x101,%ecx
801004d7:	0f 84 f3 01 00 00    	je     801006d0 <cgaputc+0x250>
    if (cga_pos_sequence.size >= cga_pos_sequence.cap) {
801004dd:	39 1d 24 94 10 80    	cmp    %ebx,0x80109424
801004e3:	0f 8e d7 01 00 00    	jle    801006c0 <cgaputc+0x240>
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
801004e9:	8d 43 01             	lea    0x1(%ebx),%eax
801004ec:	89 34 9d 20 92 10 80 	mov    %esi,-0x7fef6de0(,%ebx,4)
801004f3:	a3 20 94 10 80       	mov    %eax,0x80109420
    for (int i = 0; i < cga_pos_sequence.size - 1; i++) { // size-1 because we just added the new one
801004f8:	31 c0                	xor    %eax,%eax
801004fa:	85 db                	test   %ebx,%ebx
801004fc:	7e 1e                	jle    8010051c <cgaputc+0x9c>
801004fe:	66 90                	xchg   %ax,%ax
        if (cga_pos_sequence.pos_data[i] >= pos) {
80100500:	8b 14 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%edx
80100507:	39 f2                	cmp    %esi,%edx
80100509:	7c 0a                	jl     80100515 <cgaputc+0x95>
            cga_pos_sequence.pos_data[i]++;
8010050b:	83 c2 01             	add    $0x1,%edx
8010050e:	89 14 85 20 92 10 80 	mov    %edx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size - 1; i++) { // size-1 because we just added the new one
80100515:	83 c0 01             	add    $0x1,%eax
80100518:	39 d8                	cmp    %ebx,%eax
8010051a:	75 e4                	jne    80100500 <cgaputc+0x80>
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
8010051c:	a1 30 ff 10 80       	mov    0x8010ff30,%eax
80100521:	01 f0                	add    %esi,%eax
80100523:	39 c6                	cmp    %eax,%esi
80100525:	7d 1f                	jge    80100546 <cgaputc+0xc6>
80100527:	8d 84 00 fe 7f 0b 80 	lea    -0x7ff48002(%eax,%eax,1),%eax
8010052e:	8d 9c 36 fe 7f 0b 80 	lea    -0x7ff48002(%esi,%esi,1),%ebx
80100535:	8d 76 00             	lea    0x0(%esi),%esi
      crt[i] = crt[i - 1];
80100538:	0f b7 10             	movzwl (%eax),%edx
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
8010053b:	83 e8 02             	sub    $0x2,%eax
      crt[i] = crt[i - 1];
8010053e:	66 89 50 04          	mov    %dx,0x4(%eax)
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
80100542:	39 c3                	cmp    %eax,%ebx
80100544:	75 f2                	jne    80100538 <cgaputc+0xb8>
    crt[pos++] = (c&0xff) | 0x0700;
80100546:	0f b6 c9             	movzbl %cl,%ecx
80100549:	8d 5e 01             	lea    0x1(%esi),%ebx
8010054c:	80 cd 07             	or     $0x7,%ch
8010054f:	66 89 8c 36 00 80 0b 	mov    %cx,-0x7ff48000(%esi,%esi,1)
80100556:	80 
  if(pos < 0 || pos > 25*80)
80100557:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010055d:	0f 87 30 02 00 00    	ja     80100793 <cgaputc+0x313>
  if((pos/80) >= 24){  // Scroll up.
80100563:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100569:	0f 8f 01 01 00 00    	jg     80100670 <cgaputc+0x1f0>
  outb(CRTPORT+1, pos);
8010056f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100572:	0f b6 ff             	movzbl %bh,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100575:	be d4 03 00 00       	mov    $0x3d4,%esi
8010057a:	b8 0e 00 00 00       	mov    $0xe,%eax
8010057f:	89 f2                	mov    %esi,%edx
80100581:	ee                   	out    %al,(%dx)
80100582:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100587:	89 f8                	mov    %edi,%eax
80100589:	89 ca                	mov    %ecx,%edx
8010058b:	ee                   	out    %al,(%dx)
8010058c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100591:	89 f2                	mov    %esi,%edx
80100593:	ee                   	out    %al,(%dx)
80100594:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80100598:	89 ca                	mov    %ecx,%edx
8010059a:	ee                   	out    %al,(%dx)
  crt[pos+left_key_pressed_count] = ' ' | 0x0700;
8010059b:	b8 20 07 00 00       	mov    $0x720,%eax
801005a0:	03 1d 30 ff 10 80    	add    0x8010ff30,%ebx
801005a6:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801005ad:	80 
}
801005ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005b1:	5b                   	pop    %ebx
801005b2:	5e                   	pop    %esi
801005b3:	5f                   	pop    %edi
801005b4:	5d                   	pop    %ebp
801005b5:	c3                   	ret
801005b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801005bd:	00 
801005be:	66 90                	xchg   %ax,%ax
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
801005c0:	8b 0d 30 ff 10 80    	mov    0x8010ff30,%ecx
    int deleted_pos = pos - 1;
801005c6:	8d 5e ff             	lea    -0x1(%esi),%ebx
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
801005c9:	8d 84 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%eax
801005d0:	89 da                	mov    %ebx,%edx
801005d2:	85 c9                	test   %ecx,%ecx
801005d4:	78 23                	js     801005f9 <cgaputc+0x179>
801005d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801005dd:	00 
801005de:	66 90                	xchg   %ax,%ax
      crt[i] = crt[i + 1];
801005e0:	0f b7 08             	movzwl (%eax),%ecx
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
801005e3:	83 c2 01             	add    $0x1,%edx
801005e6:	83 c0 02             	add    $0x2,%eax
      crt[i] = crt[i + 1];
801005e9:	66 89 48 fc          	mov    %cx,-0x4(%eax)
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
801005ed:	8b 0d 30 ff 10 80    	mov    0x8010ff30,%ecx
801005f3:	01 f1                	add    %esi,%ecx
801005f5:	39 d1                	cmp    %edx,%ecx
801005f7:	7f e7                	jg     801005e0 <cgaputc+0x160>
    for (int i = 0; i < cga_pos_sequence.size; i++) {
801005f9:	8b 0d 20 94 10 80    	mov    0x80109420,%ecx
801005ff:	31 c0                	xor    %eax,%eax
80100601:	85 c9                	test   %ecx,%ecx
80100603:	7e 1f                	jle    80100624 <cgaputc+0x1a4>
80100605:	8d 76 00             	lea    0x0(%esi),%esi
        if (cga_pos_sequence.pos_data[i] > deleted_pos) {
80100608:	8b 14 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%edx
8010060f:	39 da                	cmp    %ebx,%edx
80100611:	7e 0a                	jle    8010061d <cgaputc+0x19d>
            cga_pos_sequence.pos_data[i]--;
80100613:	83 ea 01             	sub    $0x1,%edx
80100616:	89 14 85 20 92 10 80 	mov    %edx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010061d:	83 c0 01             	add    $0x1,%eax
80100620:	39 c8                	cmp    %ecx,%eax
80100622:	75 e4                	jne    80100608 <cgaputc+0x188>
    delete_from_cga_pos_sequence(deleted_pos);
80100624:	83 ec 0c             	sub    $0xc,%esp
80100627:	53                   	push   %ebx
80100628:	e8 d3 fd ff ff       	call   80100400 <delete_from_cga_pos_sequence>
    if(pos > 0) --pos;
8010062d:	83 c4 10             	add    $0x10,%esp
80100630:	85 f6                	test   %esi,%esi
80100632:	0f 85 1f ff ff ff    	jne    80100557 <cgaputc+0xd7>
80100638:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  pos |= inb(CRTPORT+1);
8010063c:	31 db                	xor    %ebx,%ebx
8010063e:	31 ff                	xor    %edi,%edi
80100640:	e9 30 ff ff ff       	jmp    80100575 <cgaputc+0xf5>
80100645:	8d 76 00             	lea    0x0(%esi),%esi
    cga_pos_sequence.size = 0;
80100648:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
8010064f:	00 00 00 
    pos += 80 - pos%80;
80100652:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
80100657:	f7 e6                	mul    %esi
80100659:	c1 ea 06             	shr    $0x6,%edx
8010065c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010065f:	c1 e0 04             	shl    $0x4,%eax
80100662:	8d 58 50             	lea    0x50(%eax),%ebx
}
80100665:	e9 ed fe ff ff       	jmp    80100557 <cgaputc+0xd7>
8010066a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100670:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100673:	83 eb 50             	sub    $0x50,%ebx
  outb(CRTPORT+1, pos);
80100676:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010067b:	68 60 0e 00 00       	push   $0xe60
80100680:	68 a0 80 0b 80       	push   $0x800b80a0
80100685:	68 00 80 0b 80       	push   $0x800b8000
8010068a:	e8 a1 4d 00 00       	call   80105430 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010068f:	b8 80 07 00 00       	mov    $0x780,%eax
80100694:	83 c4 0c             	add    $0xc,%esp
80100697:	29 d8                	sub    %ebx,%eax
80100699:	01 c0                	add    %eax,%eax
8010069b:	50                   	push   %eax
8010069c:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
801006a3:	6a 00                	push   $0x0
801006a5:	50                   	push   %eax
801006a6:	e8 f5 4c 00 00       	call   801053a0 <memset>
  outb(CRTPORT+1, pos);
801006ab:	88 5d e7             	mov    %bl,-0x19(%ebp)
801006ae:	83 c4 10             	add    $0x10,%esp
801006b1:	e9 bf fe ff ff       	jmp    80100575 <cgaputc+0xf5>
801006b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801006bd:	00 
801006be:	66 90                	xchg   %ax,%ax
    for (int i = 0; i < cga_pos_sequence.size - 1; i++) { // size-1 because we just added the new one
801006c0:	83 eb 01             	sub    $0x1,%ebx
801006c3:	e9 30 fe ff ff       	jmp    801004f8 <cgaputc+0x78>
801006c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801006cf:	00 
    if (cga_pos_sequence.size == 0) return -1;
801006d0:	85 db                	test   %ebx,%ebx
801006d2:	0f 84 d6 fe ff ff    	je     801005ae <cgaputc+0x12e>
    return cga_pos_sequence.pos_data[cga_pos_sequence.size - 1];
801006d8:	8d 43 ff             	lea    -0x1(%ebx),%eax
801006db:	8b 0c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ecx
    if (undo_pos == -1) return;
801006e2:	83 f9 ff             	cmp    $0xffffffff,%ecx
801006e5:	0f 84 c3 fe ff ff    	je     801005ae <cgaputc+0x12e>
    if (cga_pos_sequence.size > 0) {
801006eb:	85 db                	test   %ebx,%ebx
801006ed:	0f 8e 8d 00 00 00    	jle    80100780 <cgaputc+0x300>
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
801006f3:	8b 15 30 ff 10 80    	mov    0x8010ff30,%edx
        cga_pos_sequence.size--;
801006f9:	a3 20 94 10 80       	mov    %eax,0x80109420
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
801006fe:	8d 04 16             	lea    (%esi,%edx,1),%eax
80100701:	39 c1                	cmp    %eax,%ecx
80100703:	7d 25                	jge    8010072a <cgaputc+0x2aa>
80100705:	8d 84 09 02 80 0b 80 	lea    -0x7ff47ffe(%ecx,%ecx,1),%eax
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010070c:	89 cb                	mov    %ecx,%ebx
8010070e:	66 90                	xchg   %ax,%ax
        crt[i] = crt[i + 1];
80100710:	0f b7 10             	movzwl (%eax),%edx
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
80100713:	83 c3 01             	add    $0x1,%ebx
80100716:	83 c0 02             	add    $0x2,%eax
        crt[i] = crt[i + 1];
80100719:	66 89 50 fc          	mov    %dx,-0x4(%eax)
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
8010071d:	8b 15 30 ff 10 80    	mov    0x8010ff30,%edx
80100723:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80100726:	39 df                	cmp    %ebx,%edi
80100728:	7f e6                	jg     80100710 <cgaputc+0x290>
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010072a:	8b 3d 20 94 10 80    	mov    0x80109420,%edi
80100730:	31 c0                	xor    %eax,%eax
80100732:	85 ff                	test   %edi,%edi
80100734:	7e 26                	jle    8010075c <cgaputc+0x2dc>
80100736:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010073d:	00 
8010073e:	66 90                	xchg   %ax,%ax
        if (cga_pos_sequence.pos_data[i] > undo_pos) {
80100740:	8b 1c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ebx
80100747:	39 cb                	cmp    %ecx,%ebx
80100749:	7e 0a                	jle    80100755 <cgaputc+0x2d5>
            cga_pos_sequence.pos_data[i]--;
8010074b:	83 eb 01             	sub    $0x1,%ebx
8010074e:	89 1c 85 20 92 10 80 	mov    %ebx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100755:	83 c0 01             	add    $0x1,%eax
80100758:	39 c7                	cmp    %eax,%edi
8010075a:	75 e4                	jne    80100740 <cgaputc+0x2c0>
    if(pos > pos + left_key_pressed_count-1) --pos;
8010075c:	8d 5e ff             	lea    -0x1(%esi),%ebx
8010075f:	85 d2                	test   %edx,%edx
80100761:	0f 8e f0 fd ff ff    	jle    80100557 <cgaputc+0xd7>
      left_key_pressed_count--;
80100767:	83 ea 01             	sub    $0x1,%edx
  pos |= inb(CRTPORT+1);
8010076a:	89 f3                	mov    %esi,%ebx
      left_key_pressed_count--;
8010076c:	89 15 30 ff 10 80    	mov    %edx,0x8010ff30
80100772:	e9 e0 fd ff ff       	jmp    80100557 <cgaputc+0xd7>
80100777:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010077e:	00 
8010077f:	90                   	nop
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
80100780:	8b 15 30 ff 10 80    	mov    0x8010ff30,%edx
80100786:	8d 04 16             	lea    (%esi,%edx,1),%eax
80100789:	39 c1                	cmp    %eax,%ecx
8010078b:	0f 8c 74 ff ff ff    	jl     80100705 <cgaputc+0x285>
80100791:	eb c9                	jmp    8010075c <cgaputc+0x2dc>
    panic("pos under/overflow");
80100793:	83 ec 0c             	sub    $0xc,%esp
80100796:	68 8d 7e 10 80       	push   $0x80107e8d
8010079b:	e8 f0 02 00 00       	call   80100a90 <panic>

801007a0 <printint>:
{
801007a0:	55                   	push   %ebp
801007a1:	89 e5                	mov    %esp,%ebp
801007a3:	57                   	push   %edi
801007a4:	56                   	push   %esi
801007a5:	53                   	push   %ebx
801007a6:	89 d3                	mov    %edx,%ebx
801007a8:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
801007ab:	85 c0                	test   %eax,%eax
801007ad:	79 05                	jns    801007b4 <printint+0x14>
801007af:	83 e1 01             	and    $0x1,%ecx
801007b2:	75 6a                	jne    8010081e <printint+0x7e>
    x = xx;
801007b4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
801007bb:	89 c1                	mov    %eax,%ecx
  i = 0;
801007bd:	31 f6                	xor    %esi,%esi
801007bf:	90                   	nop
    buf[i++] = digits[x % base];
801007c0:	89 c8                	mov    %ecx,%eax
801007c2:	31 d2                	xor    %edx,%edx
801007c4:	89 f7                	mov    %esi,%edi
801007c6:	f7 f3                	div    %ebx
801007c8:	8d 76 01             	lea    0x1(%esi),%esi
801007cb:	0f b6 92 d0 83 10 80 	movzbl -0x7fef7c30(%edx),%edx
801007d2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
801007d6:	89 ca                	mov    %ecx,%edx
801007d8:	89 c1                	mov    %eax,%ecx
801007da:	39 da                	cmp    %ebx,%edx
801007dc:	73 e2                	jae    801007c0 <printint+0x20>
  if(sign)
801007de:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801007e1:	85 d2                	test   %edx,%edx
801007e3:	74 07                	je     801007ec <printint+0x4c>
    buf[i++] = '-';
801007e5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
801007ea:	89 f7                	mov    %esi,%edi
801007ec:	8d 75 d8             	lea    -0x28(%ebp),%esi
801007ef:	01 f7                	add    %esi,%edi
  if(panicked){
801007f1:	a1 78 ff 10 80       	mov    0x8010ff78,%eax
    consputc(buf[i]);
801007f6:	0f be 1f             	movsbl (%edi),%ebx
  if(panicked){
801007f9:	85 c0                	test   %eax,%eax
801007fb:	74 03                	je     80100800 <printint+0x60>
}

static inline void
cli(void)
{
  asm volatile("cli");
801007fd:	fa                   	cli
    for(;;)
801007fe:	eb fe                	jmp    801007fe <printint+0x5e>
    uartputc(c);
80100800:	83 ec 0c             	sub    $0xc,%esp
80100803:	53                   	push   %ebx
80100804:	e8 a7 61 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80100809:	89 d8                	mov    %ebx,%eax
8010080b:	e8 70 fc ff ff       	call   80100480 <cgaputc>
  while(--i >= 0)
80100810:	8d 47 ff             	lea    -0x1(%edi),%eax
80100813:	83 c4 10             	add    $0x10,%esp
80100816:	39 f7                	cmp    %esi,%edi
80100818:	74 11                	je     8010082b <printint+0x8b>
8010081a:	89 c7                	mov    %eax,%edi
8010081c:	eb d3                	jmp    801007f1 <printint+0x51>
    x = -xx;
8010081e:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
80100820:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
80100827:	89 c1                	mov    %eax,%ecx
80100829:	eb 92                	jmp    801007bd <printint+0x1d>
}
8010082b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010082e:	5b                   	pop    %ebx
8010082f:	5e                   	pop    %esi
80100830:	5f                   	pop    %edi
80100831:	5d                   	pop    %ebp
80100832:	c3                   	ret
80100833:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010083a:	00 
8010083b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100840 <cprintf>:
{
80100840:	55                   	push   %ebp
80100841:	89 e5                	mov    %esp,%ebp
80100843:	57                   	push   %edi
80100844:	56                   	push   %esi
80100845:	53                   	push   %ebx
80100846:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100849:	8b 3d 74 ff 10 80    	mov    0x8010ff74,%edi
  if (fmt == 0)
8010084f:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100852:	85 ff                	test   %edi,%edi
80100854:	0f 85 36 01 00 00    	jne    80100990 <cprintf+0x150>
  if (fmt == 0)
8010085a:	85 f6                	test   %esi,%esi
8010085c:	0f 84 1c 02 00 00    	je     80100a7e <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100862:	0f b6 06             	movzbl (%esi),%eax
80100865:	85 c0                	test   %eax,%eax
80100867:	74 67                	je     801008d0 <cprintf+0x90>
  argp = (uint*)(void*)(&fmt + 1);
80100869:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010086c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010086f:	31 db                	xor    %ebx,%ebx
80100871:	89 d7                	mov    %edx,%edi
    if(c != '%'){
80100873:	83 f8 25             	cmp    $0x25,%eax
80100876:	75 68                	jne    801008e0 <cprintf+0xa0>
    c = fmt[++i] & 0xff;
80100878:	83 c3 01             	add    $0x1,%ebx
8010087b:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
8010087f:	85 c9                	test   %ecx,%ecx
80100881:	74 42                	je     801008c5 <cprintf+0x85>
    switch(c){
80100883:	83 f9 70             	cmp    $0x70,%ecx
80100886:	0f 84 e4 00 00 00    	je     80100970 <cprintf+0x130>
8010088c:	0f 8f 8e 00 00 00    	jg     80100920 <cprintf+0xe0>
80100892:	83 f9 25             	cmp    $0x25,%ecx
80100895:	74 72                	je     80100909 <cprintf+0xc9>
80100897:	83 f9 64             	cmp    $0x64,%ecx
8010089a:	0f 85 8e 00 00 00    	jne    8010092e <cprintf+0xee>
      printint(*argp++, 10, 1);
801008a0:	8d 47 04             	lea    0x4(%edi),%eax
801008a3:	b9 01 00 00 00       	mov    $0x1,%ecx
801008a8:	ba 0a 00 00 00       	mov    $0xa,%edx
801008ad:	89 45 e0             	mov    %eax,-0x20(%ebp)
801008b0:	8b 07                	mov    (%edi),%eax
801008b2:	e8 e9 fe ff ff       	call   801007a0 <printint>
801008b7:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008ba:	83 c3 01             	add    $0x1,%ebx
801008bd:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801008c1:	85 c0                	test   %eax,%eax
801008c3:	75 ae                	jne    80100873 <cprintf+0x33>
801008c5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
801008c8:	85 ff                	test   %edi,%edi
801008ca:	0f 85 e3 00 00 00    	jne    801009b3 <cprintf+0x173>
}
801008d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801008d3:	5b                   	pop    %ebx
801008d4:	5e                   	pop    %esi
801008d5:	5f                   	pop    %edi
801008d6:	5d                   	pop    %ebp
801008d7:	c3                   	ret
801008d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801008df:	00 
  if(panicked){
801008e0:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
801008e6:	85 d2                	test   %edx,%edx
801008e8:	74 06                	je     801008f0 <cprintf+0xb0>
801008ea:	fa                   	cli
    for(;;)
801008eb:	eb fe                	jmp    801008eb <cprintf+0xab>
801008ed:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
801008f0:	83 ec 0c             	sub    $0xc,%esp
801008f3:	50                   	push   %eax
801008f4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801008f7:	e8 b4 60 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
801008fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801008ff:	e8 7c fb ff ff       	call   80100480 <cgaputc>
      continue;
80100904:	83 c4 10             	add    $0x10,%esp
80100907:	eb b1                	jmp    801008ba <cprintf+0x7a>
  if(panicked){
80100909:	8b 0d 78 ff 10 80    	mov    0x8010ff78,%ecx
8010090f:	85 c9                	test   %ecx,%ecx
80100911:	0f 84 f9 00 00 00    	je     80100a10 <cprintf+0x1d0>
80100917:	fa                   	cli
    for(;;)
80100918:	eb fe                	jmp    80100918 <cprintf+0xd8>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100920:	83 f9 73             	cmp    $0x73,%ecx
80100923:	0f 84 9f 00 00 00    	je     801009c8 <cprintf+0x188>
80100929:	83 f9 78             	cmp    $0x78,%ecx
8010092c:	74 42                	je     80100970 <cprintf+0x130>
  if(panicked){
8010092e:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
80100934:	85 d2                	test   %edx,%edx
80100936:	0f 85 d0 00 00 00    	jne    80100a0c <cprintf+0x1cc>
    uartputc(c);
8010093c:	83 ec 0c             	sub    $0xc,%esp
8010093f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100942:	6a 25                	push   $0x25
80100944:	e8 67 60 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80100949:	b8 25 00 00 00       	mov    $0x25,%eax
8010094e:	e8 2d fb ff ff       	call   80100480 <cgaputc>
  if(panicked){
80100953:	a1 78 ff 10 80       	mov    0x8010ff78,%eax
80100958:	83 c4 10             	add    $0x10,%esp
8010095b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010095e:	85 c0                	test   %eax,%eax
80100960:	0f 84 f5 00 00 00    	je     80100a5b <cprintf+0x21b>
80100966:	fa                   	cli
    for(;;)
80100967:	eb fe                	jmp    80100967 <cprintf+0x127>
80100969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
80100970:	8d 47 04             	lea    0x4(%edi),%eax
80100973:	31 c9                	xor    %ecx,%ecx
80100975:	ba 10 00 00 00       	mov    $0x10,%edx
8010097a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010097d:	8b 07                	mov    (%edi),%eax
8010097f:	e8 1c fe ff ff       	call   801007a0 <printint>
80100984:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100987:	e9 2e ff ff ff       	jmp    801008ba <cprintf+0x7a>
8010098c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
80100990:	83 ec 0c             	sub    $0xc,%esp
80100993:	68 40 ff 10 80       	push   $0x8010ff40
80100998:	e8 03 49 00 00       	call   801052a0 <acquire>
  if (fmt == 0)
8010099d:	83 c4 10             	add    $0x10,%esp
801009a0:	85 f6                	test   %esi,%esi
801009a2:	0f 84 d6 00 00 00    	je     80100a7e <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801009a8:	0f b6 06             	movzbl (%esi),%eax
801009ab:	85 c0                	test   %eax,%eax
801009ad:	0f 85 b6 fe ff ff    	jne    80100869 <cprintf+0x29>
    release(&cons.lock);
801009b3:	83 ec 0c             	sub    $0xc,%esp
801009b6:	68 40 ff 10 80       	push   $0x8010ff40
801009bb:	e8 80 48 00 00       	call   80105240 <release>
801009c0:	83 c4 10             	add    $0x10,%esp
801009c3:	e9 08 ff ff ff       	jmp    801008d0 <cprintf+0x90>
      if((s = (char*)*argp++) == 0)
801009c8:	8b 17                	mov    (%edi),%edx
801009ca:	8d 47 04             	lea    0x4(%edi),%eax
801009cd:	85 d2                	test   %edx,%edx
801009cf:	74 2f                	je     80100a00 <cprintf+0x1c0>
      for(; *s; s++)
801009d1:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
801009d4:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
801009d6:	84 c9                	test   %cl,%cl
801009d8:	0f 84 99 00 00 00    	je     80100a77 <cprintf+0x237>
801009de:	89 5d e0             	mov    %ebx,-0x20(%ebp)
801009e1:	89 fb                	mov    %edi,%ebx
801009e3:	89 f7                	mov    %esi,%edi
801009e5:	89 45 dc             	mov    %eax,-0x24(%ebp)
801009e8:	89 c8                	mov    %ecx,%eax
  if(panicked){
801009ea:	8b 35 78 ff 10 80    	mov    0x8010ff78,%esi
801009f0:	85 f6                	test   %esi,%esi
801009f2:	74 38                	je     80100a2c <cprintf+0x1ec>
801009f4:	fa                   	cli
    for(;;)
801009f5:	eb fe                	jmp    801009f5 <cprintf+0x1b5>
801009f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801009fe:	00 
801009ff:	90                   	nop
80100a00:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
80100a05:	bf a0 7e 10 80       	mov    $0x80107ea0,%edi
80100a0a:	eb d2                	jmp    801009de <cprintf+0x19e>
80100a0c:	fa                   	cli
    for(;;)
80100a0d:	eb fe                	jmp    80100a0d <cprintf+0x1cd>
80100a0f:	90                   	nop
    uartputc(c);
80100a10:	83 ec 0c             	sub    $0xc,%esp
80100a13:	6a 25                	push   $0x25
80100a15:	e8 96 5f 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80100a1a:	b8 25 00 00 00       	mov    $0x25,%eax
80100a1f:	e8 5c fa ff ff       	call   80100480 <cgaputc>
}
80100a24:	83 c4 10             	add    $0x10,%esp
80100a27:	e9 8e fe ff ff       	jmp    801008ba <cprintf+0x7a>
    uartputc(c);
80100a2c:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
80100a2f:	0f be f0             	movsbl %al,%esi
      for(; *s; s++)
80100a32:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100a35:	56                   	push   %esi
80100a36:	e8 75 5f 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80100a3b:	89 f0                	mov    %esi,%eax
80100a3d:	e8 3e fa ff ff       	call   80100480 <cgaputc>
      for(; *s; s++)
80100a42:	0f b6 03             	movzbl (%ebx),%eax
80100a45:	83 c4 10             	add    $0x10,%esp
80100a48:	84 c0                	test   %al,%al
80100a4a:	75 9e                	jne    801009ea <cprintf+0x1aa>
      if((s = (char*)*argp++) == 0)
80100a4c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100a4f:	89 fe                	mov    %edi,%esi
80100a51:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100a54:	89 c7                	mov    %eax,%edi
80100a56:	e9 5f fe ff ff       	jmp    801008ba <cprintf+0x7a>
    uartputc(c);
80100a5b:	83 ec 0c             	sub    $0xc,%esp
80100a5e:	51                   	push   %ecx
80100a5f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100a62:	e8 49 5f 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80100a67:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100a6a:	e8 11 fa ff ff       	call   80100480 <cgaputc>
}
80100a6f:	83 c4 10             	add    $0x10,%esp
80100a72:	e9 43 fe ff ff       	jmp    801008ba <cprintf+0x7a>
      if((s = (char*)*argp++) == 0)
80100a77:	89 c7                	mov    %eax,%edi
80100a79:	e9 3c fe ff ff       	jmp    801008ba <cprintf+0x7a>
    panic("null fmt");
80100a7e:	83 ec 0c             	sub    $0xc,%esp
80100a81:	68 a7 7e 10 80       	push   $0x80107ea7
80100a86:	e8 05 00 00 00       	call   80100a90 <panic>
80100a8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100a90 <panic>:
{
80100a90:	55                   	push   %ebp
80100a91:	89 e5                	mov    %esp,%ebp
80100a93:	56                   	push   %esi
80100a94:	53                   	push   %ebx
80100a95:	83 ec 30             	sub    $0x30,%esp
80100a98:	fa                   	cli
  cons.locking = 0;
80100a99:	c7 05 74 ff 10 80 00 	movl   $0x0,0x8010ff74
80100aa0:	00 00 00 
  getcallerpcs(&s, pcs);
80100aa3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100aa6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100aa9:	e8 22 2b 00 00       	call   801035d0 <lapicid>
80100aae:	83 ec 08             	sub    $0x8,%esp
80100ab1:	50                   	push   %eax
80100ab2:	68 b0 7e 10 80       	push   $0x80107eb0
80100ab7:	e8 84 fd ff ff       	call   80100840 <cprintf>
  cprintf(s);
80100abc:	58                   	pop    %eax
80100abd:	ff 75 08             	push   0x8(%ebp)
80100ac0:	e8 7b fd ff ff       	call   80100840 <cprintf>
  cprintf("\n");
80100ac5:	c7 04 24 11 83 10 80 	movl   $0x80108311,(%esp)
80100acc:	e8 6f fd ff ff       	call   80100840 <cprintf>
  getcallerpcs(&s, pcs);
80100ad1:	8d 45 08             	lea    0x8(%ebp),%eax
80100ad4:	5a                   	pop    %edx
80100ad5:	59                   	pop    %ecx
80100ad6:	53                   	push   %ebx
80100ad7:	50                   	push   %eax
80100ad8:	e8 f3 45 00 00       	call   801050d0 <getcallerpcs>
  for(i=0; i<10; i++)
80100add:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100ae0:	83 ec 08             	sub    $0x8,%esp
80100ae3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100ae5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100ae8:	68 c4 7e 10 80       	push   $0x80107ec4
80100aed:	e8 4e fd ff ff       	call   80100840 <cprintf>
  for(i=0; i<10; i++)
80100af2:	83 c4 10             	add    $0x10,%esp
80100af5:	39 f3                	cmp    %esi,%ebx
80100af7:	75 e7                	jne    80100ae0 <panic+0x50>
  panicked = 1; // freeze other CPU
80100af9:	c7 05 78 ff 10 80 01 	movl   $0x1,0x8010ff78
80100b00:	00 00 00 
  for(;;)
80100b03:	eb fe                	jmp    80100b03 <panic+0x73>
80100b05:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100b0c:	00 
80100b0d:	8d 76 00             	lea    0x0(%esi),%esi

80100b10 <consolewrite>:
// }


int
consolewrite(struct inode *ip, char *buf, int n)
{
80100b10:	55                   	push   %ebp
80100b11:	89 e5                	mov    %esp,%ebp
80100b13:	57                   	push   %edi
80100b14:	56                   	push   %esi
80100b15:	53                   	push   %ebx
80100b16:	83 ec 28             	sub    $0x28,%esp
80100b19:	8b 75 0c             	mov    0xc(%ebp),%esi
  int i;
  // These flags manage the tab completion protocol
  int tabcomplete = 0;
  int writestdin = 0; 

  iunlock(ip);
80100b1c:	ff 75 08             	push   0x8(%ebp)
80100b1f:	e8 5c 1a 00 00       	call   80102580 <iunlock>
  acquire(&cons.lock);
80100b24:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80100b2b:	e8 70 47 00 00       	call   801052a0 <acquire>
  
  for(i = 0; i < n; i++){
80100b30:	8b 45 10             	mov    0x10(%ebp),%eax
80100b33:	83 c4 10             	add    $0x10,%esp
80100b36:	85 c0                	test   %eax,%eax
80100b38:	0f 8e a7 00 00 00    	jle    80100be5 <consolewrite+0xd5>
    char c = buf[i] & 0xff;
80100b3e:	0f b6 16             	movzbl (%esi),%edx

    // STEP 1: Detect the special tab completion message from the shell.
    // A single '\t' at the start of a write() call initiates the protocol.
    if(i == 0 && c == '\t') {
80100b41:	80 fa 09             	cmp    $0x9,%dl
80100b44:	0f 85 7f 01 00 00    	jne    80100cc9 <consolewrite+0x1b9>
  for(i = 0; i < n; i++){
80100b4a:	83 7d 10 01          	cmpl   $0x1,0x10(%ebp)
80100b4e:	0f 84 b6 01 00 00    	je     80100d0a <consolewrite+0x1fa>
    char c = buf[i] & 0xff;
80100b54:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100b5b:	0f b6 56 01          	movzbl 0x1(%esi),%edx
  for(i = 0; i < n; i++){
80100b5f:	bb 01 00 00 00       	mov    $0x1,%ebx
    }

    if(tabcomplete) {
      // STEP 2: A second '\t' in the message means the shell wants us to 
      // not only add the text to the buffer but also echo it to the screen.
      if (c == '\t') {
80100b64:	80 fa 09             	cmp    $0x9,%dl
80100b67:	0f 84 43 01 00 00    	je     80100cb0 <consolewrite+0x1a0>
        continue;
      }

      // STEP 3: Stuff the completion characters into the kernel's input buffer.
      // This is the "backdoor" that lets the shell modify the command line.
      if(input.e-input.r < INPUT_BUF) {
80100b6d:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100b72:	89 c1                	mov    %eax,%ecx
80100b74:	2b 0d 20 ff 10 80    	sub    0x8010ff20,%ecx
80100b7a:	83 f9 7f             	cmp    $0x7f,%ecx
80100b7d:	76 29                	jbe    80100ba8 <consolewrite+0x98>
  for(i = 0; i < n; i++){
80100b7f:	83 c3 01             	add    $0x1,%ebx
80100b82:	bf 01 00 00 00       	mov    $0x1,%edi
80100b87:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80100b8a:	74 44                	je     80100bd0 <consolewrite+0xc0>
    char c = buf[i] & 0xff;
80100b8c:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(tabcomplete) {
80100b90:	85 ff                	test   %edi,%edi
80100b92:	75 d0                	jne    80100b64 <consolewrite+0x54>
  if(panicked){
80100b94:	8b 3d 78 ff 10 80    	mov    0x8010ff78,%edi
80100b9a:	85 ff                	test   %edi,%edi
80100b9c:	74 68                	je     80100c06 <consolewrite+0xf6>
80100b9e:	fa                   	cli
    for(;;)
80100b9f:	eb fe                	jmp    80100b9f <consolewrite+0x8f>
80100ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          if (writestdin) {
80100ba8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
            // We need to simulate typing, so we handle insertions and screen updates correctly.
            shift_buffer_right();
            input.buf[(input.e++ - left_key_pressed_count) % INPUT_BUF] = c;
80100bab:	8d 48 01             	lea    0x1(%eax),%ecx
          if (writestdin) {
80100bae:	85 ff                	test   %edi,%edi
80100bb0:	75 7c                	jne    80100c2e <consolewrite+0x11e>
            consputc(c);
          } else {
            // If writestdin is false, we only update the buffer without echoing.
            // (This is not used in the current shell logic, but is good practice to have)
            input.buf[input.e++ % INPUT_BUF] = c;
80100bb2:	83 e0 7f             	and    $0x7f,%eax
80100bb5:	89 0d 28 ff 10 80    	mov    %ecx,0x8010ff28
  for(i = 0; i < n; i++){
80100bbb:	83 c3 01             	add    $0x1,%ebx
80100bbe:	bf 01 00 00 00       	mov    $0x1,%edi
            input.buf[input.e++ % INPUT_BUF] = c;
80100bc3:	88 90 a0 fe 10 80    	mov    %dl,-0x7fef0160(%eax)
  for(i = 0; i < n; i++){
80100bc9:	89 c8                	mov    %ecx,%eax
80100bcb:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80100bce:	75 bc                	jne    80100b8c <consolewrite+0x7c>
  }

  // After the shell has modified our buffer, wake it up so it can re-read the now-completed line.
  if (tabcomplete) {
      input.w = input.e;
      wakeup(&input.r);
80100bd0:	83 ec 0c             	sub    $0xc,%esp
      input.w = input.e;
80100bd3:	a3 24 ff 10 80       	mov    %eax,0x8010ff24
      wakeup(&input.r);
80100bd8:	68 20 ff 10 80       	push   $0x8010ff20
80100bdd:	e8 fe 41 00 00       	call   80104de0 <wakeup>
80100be2:	83 c4 10             	add    $0x10,%esp
  }

  release(&cons.lock);
80100be5:	83 ec 0c             	sub    $0xc,%esp
80100be8:	68 40 ff 10 80       	push   $0x8010ff40
80100bed:	e8 4e 46 00 00       	call   80105240 <release>
  ilock(ip);
80100bf2:	58                   	pop    %eax
80100bf3:	ff 75 08             	push   0x8(%ebp)
80100bf6:	e8 a5 18 00 00       	call   801024a0 <ilock>

  return n;
}
80100bfb:	8b 45 10             	mov    0x10(%ebp),%eax
80100bfe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c01:	5b                   	pop    %ebx
80100c02:	5e                   	pop    %esi
80100c03:	5f                   	pop    %edi
80100c04:	5d                   	pop    %ebp
80100c05:	c3                   	ret
      consputc(c);
80100c06:	0f be c2             	movsbl %dl,%eax
    uartputc(c);
80100c09:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < n; i++){
80100c0c:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100c0f:	50                   	push   %eax
80100c10:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c13:	e8 98 5d 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80100c18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c1b:	e8 60 f8 ff ff       	call   80100480 <cgaputc>
  for(i = 0; i < n; i++){
80100c20:	83 c4 10             	add    $0x10,%esp
80100c23:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80100c26:	0f 85 60 ff ff ff    	jne    80100b8c <consolewrite+0x7c>
80100c2c:	eb b7                	jmp    80100be5 <consolewrite+0xd5>
   int cursor= input.e-left_key_pressed_count;
80100c2e:	89 c7                	mov    %eax,%edi
80100c30:	2b 3d 30 ff 10 80    	sub    0x8010ff30,%edi
  for (int i = input.e; i > cursor; i--)
80100c36:	39 c7                	cmp    %eax,%edi
80100c38:	7d 4e                	jge    80100c88 <consolewrite+0x178>
80100c3a:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100c3d:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100c40:	89 75 0c             	mov    %esi,0xc(%ebp)
80100c43:	89 d6                	mov    %edx,%esi
80100c45:	8d 76 00             	lea    0x0(%esi),%esi
    input.buf[(i) % INPUT_BUF] = input.buf[(i-1) % INPUT_BUF]; // Shift elements to right
80100c48:	89 c1                	mov    %eax,%ecx
80100c4a:	83 e8 01             	sub    $0x1,%eax
80100c4d:	89 c3                	mov    %eax,%ebx
80100c4f:	c1 fb 1f             	sar    $0x1f,%ebx
80100c52:	c1 eb 19             	shr    $0x19,%ebx
80100c55:	8d 14 18             	lea    (%eax,%ebx,1),%edx
80100c58:	83 e2 7f             	and    $0x7f,%edx
80100c5b:	29 da                	sub    %ebx,%edx
80100c5d:	89 cb                	mov    %ecx,%ebx
80100c5f:	c1 fb 1f             	sar    $0x1f,%ebx
80100c62:	0f b6 92 a0 fe 10 80 	movzbl -0x7fef0160(%edx),%edx
80100c69:	c1 eb 19             	shr    $0x19,%ebx
80100c6c:	01 d9                	add    %ebx,%ecx
80100c6e:	83 e1 7f             	and    $0x7f,%ecx
80100c71:	29 d9                	sub    %ebx,%ecx
80100c73:	88 91 a0 fe 10 80    	mov    %dl,-0x7fef0160(%ecx)
  for (int i = input.e; i > cursor; i--)
80100c79:	39 c7                	cmp    %eax,%edi
80100c7b:	75 cb                	jne    80100c48 <consolewrite+0x138>
80100c7d:	89 f2                	mov    %esi,%edx
80100c7f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100c82:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80100c85:	8b 75 0c             	mov    0xc(%ebp),%esi
            input.buf[(input.e++ - left_key_pressed_count) % INPUT_BUF] = c;
80100c88:	89 0d 28 ff 10 80    	mov    %ecx,0x8010ff28
80100c8e:	89 f8                	mov    %edi,%eax
  if(panicked){
80100c90:	8b 0d 78 ff 10 80    	mov    0x8010ff78,%ecx
            input.buf[(input.e++ - left_key_pressed_count) % INPUT_BUF] = c;
80100c96:	83 e0 7f             	and    $0x7f,%eax
80100c99:	88 90 a0 fe 10 80    	mov    %dl,-0x7fef0160(%eax)
  if(panicked){
80100c9f:	85 c9                	test   %ecx,%ecx
80100ca1:	74 42                	je     80100ce5 <consolewrite+0x1d5>
80100ca3:	fa                   	cli
    for(;;)
80100ca4:	eb fe                	jmp    80100ca4 <consolewrite+0x194>
80100ca6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100cad:	00 
80100cae:	66 90                	xchg   %ax,%ax
  for(i = 0; i < n; i++){
80100cb0:	83 c3 01             	add    $0x1,%ebx
80100cb3:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80100cb6:	74 52                	je     80100d0a <consolewrite+0x1fa>
        writestdin = 1; 
80100cb8:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  for(i = 0; i < n; i++){
80100cbf:	bf 01 00 00 00       	mov    $0x1,%edi
80100cc4:	e9 c3 fe ff ff       	jmp    80100b8c <consolewrite+0x7c>
  if(panicked){
80100cc9:	8b 3d 78 ff 10 80    	mov    0x8010ff78,%edi
80100ccf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100cd6:	31 db                	xor    %ebx,%ebx
80100cd8:	85 ff                	test   %edi,%edi
80100cda:	0f 84 26 ff ff ff    	je     80100c06 <consolewrite+0xf6>
80100ce0:	e9 b9 fe ff ff       	jmp    80100b9e <consolewrite+0x8e>
            consputc(c);
80100ce5:	0f be fa             	movsbl %dl,%edi
    uartputc(c);
80100ce8:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < n; i++){
80100ceb:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100cee:	57                   	push   %edi
80100cef:	e8 bc 5c 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80100cf4:	89 f8                	mov    %edi,%eax
80100cf6:	e8 85 f7 ff ff       	call   80100480 <cgaputc>
  for(i = 0; i < n; i++){
80100cfb:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100cfe:	83 c4 10             	add    $0x10,%esp
80100d01:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80100d04:	0f 85 82 fe ff ff    	jne    80100b8c <consolewrite+0x7c>
80100d0a:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100d0f:	e9 bc fe ff ff       	jmp    80100bd0 <consolewrite+0xc0>
80100d14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d1b:	00 
80100d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100d20 <append_sequence>:
    if (input_sequence.size >= input_sequence.cap) {
80100d20:	a1 00 92 10 80       	mov    0x80109200,%eax
80100d25:	3b 05 04 92 10 80    	cmp    0x80109204,%eax
80100d2b:	7d 1b                	jge    80100d48 <append_sequence+0x28>
void append_sequence(int value) {
80100d2d:	55                   	push   %ebp
    input_sequence.data[input_sequence.size++] = value;
80100d2e:	8d 50 01             	lea    0x1(%eax),%edx
80100d31:	89 15 00 92 10 80    	mov    %edx,0x80109200
void append_sequence(int value) {
80100d37:	89 e5                	mov    %esp,%ebp
    input_sequence.data[input_sequence.size++] = value;
80100d39:	8b 55 08             	mov    0x8(%ebp),%edx
}
80100d3c:	5d                   	pop    %ebp
    input_sequence.data[input_sequence.size++] = value;
80100d3d:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
}
80100d44:	c3                   	ret
80100d45:	8d 76 00             	lea    0x0(%esi),%esi
80100d48:	c3                   	ret
80100d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100d50 <delete_from_sequence>:
void delete_from_sequence(int value) {
80100d50:	55                   	push   %ebp
    for (int i = 0; i < input_sequence.size; i++) {
80100d51:	8b 15 00 92 10 80    	mov    0x80109200,%edx
void delete_from_sequence(int value) {
80100d57:	89 e5                	mov    %esp,%ebp
80100d59:	8b 4d 08             	mov    0x8(%ebp),%ecx
    for (int i = 0; i < input_sequence.size; i++) {
80100d5c:	85 d2                	test   %edx,%edx
80100d5e:	7e 3b                	jle    80100d9b <delete_from_sequence+0x4b>
80100d60:	31 c0                	xor    %eax,%eax
80100d62:	eb 0b                	jmp    80100d6f <delete_from_sequence+0x1f>
80100d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100d68:	83 c0 01             	add    $0x1,%eax
80100d6b:	39 d0                	cmp    %edx,%eax
80100d6d:	74 2c                	je     80100d9b <delete_from_sequence+0x4b>
        if (input_sequence.data[i] == value) {
80100d6f:	39 0c 85 00 90 10 80 	cmp    %ecx,-0x7fef7000(,%eax,4)
80100d76:	75 f0                	jne    80100d68 <delete_from_sequence+0x18>
    for (int i = idx; i < input_sequence.size - 1; i++)
80100d78:	83 ea 01             	sub    $0x1,%edx
80100d7b:	39 c2                	cmp    %eax,%edx
80100d7d:	7e 16                	jle    80100d95 <delete_from_sequence+0x45>
80100d7f:	90                   	nop
        input_sequence.data[i] = input_sequence.data[i + 1];
80100d80:	83 c0 01             	add    $0x1,%eax
80100d83:	8b 0c 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%ecx
80100d8a:	89 0c 85 fc 8f 10 80 	mov    %ecx,-0x7fef7004(,%eax,4)
    for (int i = idx; i < input_sequence.size - 1; i++)
80100d91:	39 d0                	cmp    %edx,%eax
80100d93:	75 eb                	jne    80100d80 <delete_from_sequence+0x30>
    input_sequence.size--;
80100d95:	89 15 00 92 10 80    	mov    %edx,0x80109200
}
80100d9b:	5d                   	pop    %ebp
80100d9c:	c3                   	ret
80100d9d:	8d 76 00             	lea    0x0(%esi),%esi

80100da0 <last_sequence>:
    if (input_sequence.size == 0) return -1;
80100da0:	a1 00 92 10 80       	mov    0x80109200,%eax
80100da5:	85 c0                	test   %eax,%eax
80100da7:	74 0f                	je     80100db8 <last_sequence+0x18>
    return input_sequence.data[input_sequence.size - 1];
80100da9:	8b 04 85 fc 8f 10 80 	mov    -0x7fef7004(,%eax,4),%eax
80100db0:	c3                   	ret
80100db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (input_sequence.size == 0) return -1;
80100db8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100dbd:	c3                   	ret
80100dbe:	66 90                	xchg   %ax,%ax

80100dc0 <clear_sequence>:
    input_sequence.size = 0;
80100dc0:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80100dc7:	00 00 00 
}
80100dca:	c3                   	ret
80100dcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100dd0 <print_array>:
void print_array(char *buffer){
80100dd0:	55                   	push   %ebp
      for (int i = 0; i < input.e; i++)
80100dd1:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
void print_array(char *buffer){
80100dd6:	89 e5                	mov    %esp,%ebp
80100dd8:	56                   	push   %esi
80100dd9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ddc:	53                   	push   %ebx
      for (int i = 0; i < input.e; i++)
80100ddd:	85 c0                	test   %eax,%eax
80100ddf:	74 1b                	je     80100dfc <print_array+0x2c>
80100de1:	31 db                	xor    %ebx,%ebx
80100de3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      cgaputc(buffer[i]);
80100de8:	0f be 04 1e          	movsbl (%esi,%ebx,1),%eax
      for (int i = 0; i < input.e; i++)
80100dec:	83 c3 01             	add    $0x1,%ebx
      cgaputc(buffer[i]);
80100def:	e8 8c f6 ff ff       	call   80100480 <cgaputc>
      for (int i = 0; i < input.e; i++)
80100df4:	3b 1d 28 ff 10 80    	cmp    0x8010ff28,%ebx
80100dfa:	72 ec                	jb     80100de8 <print_array+0x18>
}
80100dfc:	5b                   	pop    %ebx
80100dfd:	5e                   	pop    %esi
80100dfe:	5d                   	pop    %ebp
80100dff:	c3                   	ret

80100e00 <consoleinit>:



void
consoleinit(void)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100e06:	68 c8 7e 10 80       	push   $0x80107ec8
80100e0b:	68 40 ff 10 80       	push   $0x8010ff40
80100e10:	e8 9b 42 00 00       	call   801050b0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100e15:	58                   	pop    %eax
80100e16:	5a                   	pop    %edx
80100e17:	6a 00                	push   $0x0
80100e19:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100e1b:	c7 05 2c 09 11 80 10 	movl   $0x80100b10,0x8011092c
80100e22:	0b 10 80 
  devsw[CONSOLE].read = consoleread;
80100e25:	c7 05 28 09 11 80 80 	movl   $0x80100280,0x80110928
80100e2c:	02 10 80 
  cons.locking = 1;
80100e2f:	c7 05 74 ff 10 80 01 	movl   $0x1,0x8010ff74
80100e36:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100e39:	e8 22 23 00 00       	call   80103160 <ioapicenable>
}
80100e3e:	83 c4 10             	add    $0x10,%esp
80100e41:	c9                   	leave
80100e42:	c3                   	ret
80100e43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100e4a:	00 
80100e4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100e50 <move_cursor_left>:





void move_cursor_left(void){
80100e50:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100e51:	b8 0e 00 00 00       	mov    $0xe,%eax
80100e56:	89 e5                	mov    %esp,%ebp
80100e58:	56                   	push   %esi
80100e59:	be d4 03 00 00       	mov    $0x3d4,%esi
80100e5e:	53                   	push   %ebx
80100e5f:	89 f2                	mov    %esi,%edx
80100e61:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100e62:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100e67:	89 ca                	mov    %ecx,%edx
80100e69:	ec                   	in     (%dx),%al
  int pos;

  // get cursor position
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100e6a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100e6d:	89 f2                	mov    %esi,%edx
80100e6f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100e74:	c1 e3 08             	shl    $0x8,%ebx
80100e77:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100e78:	89 ca                	mov    %ecx,%edx
80100e7a:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100e7b:	0f b6 c8             	movzbl %al,%ecx
80100e7e:	09 d9                	or     %ebx,%ecx




  if(crt[pos - 2] != ('$' | 0x0700))
80100e80:	66 81 bc 09 fc 7f 0b 	cmpw   $0x724,-0x7ff48004(%ecx,%ecx,1)
80100e87:	80 24 07 
80100e8a:	74 03                	je     80100e8f <move_cursor_left+0x3f>
    pos--;
80100e8c:	83 e9 01             	sub    $0x1,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100e8f:	be d4 03 00 00       	mov    $0x3d4,%esi
80100e94:	b8 0e 00 00 00       	mov    $0xe,%eax
80100e99:	89 f2                	mov    %esi,%edx
80100e9b:	ee                   	out    %al,(%dx)
80100e9c:	bb d5 03 00 00       	mov    $0x3d5,%ebx

  // reset cursor
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
80100ea1:	89 c8                	mov    %ecx,%eax
80100ea3:	c1 f8 08             	sar    $0x8,%eax
80100ea6:	89 da                	mov    %ebx,%edx
80100ea8:	ee                   	out    %al,(%dx)
80100ea9:	b8 0f 00 00 00       	mov    $0xf,%eax
80100eae:	89 f2                	mov    %esi,%edx
80100eb0:	ee                   	out    %al,(%dx)
80100eb1:	89 c8                	mov    %ecx,%eax
80100eb3:	89 da                	mov    %ebx,%edx
80100eb5:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
}
80100eb6:	5b                   	pop    %ebx
80100eb7:	5e                   	pop    %esi
80100eb8:	5d                   	pop    %ebp
80100eb9:	c3                   	ret
80100eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ec0 <consoleintr>:
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	57                   	push   %edi
80100ec4:	56                   	push   %esi
80100ec5:	53                   	push   %ebx
80100ec6:	83 ec 28             	sub    $0x28,%esp
80100ec9:	8b 45 08             	mov    0x8(%ebp),%eax
80100ecc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  acquire(&cons.lock);
80100ecf:	68 40 ff 10 80       	push   $0x8010ff40
80100ed4:	e8 c7 43 00 00       	call   801052a0 <acquire>
  while((c = getc()) >= 0){
80100ed9:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
80100edc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((c = getc()) >= 0){
80100ee3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ee6:	ff d0                	call   *%eax
80100ee8:	89 c3                	mov    %eax,%ebx
80100eea:	85 c0                	test   %eax,%eax
80100eec:	78 62                	js     80100f50 <consoleintr+0x90>
    switch(c){
80100eee:	83 fb 1a             	cmp    $0x1a,%ebx
80100ef1:	7f 1d                	jg     80100f10 <consoleintr+0x50>
80100ef3:	85 db                	test   %ebx,%ebx
80100ef5:	74 ec                	je     80100ee3 <consoleintr+0x23>
80100ef7:	83 fb 1a             	cmp    $0x1a,%ebx
80100efa:	0f 87 88 00 00 00    	ja     80100f88 <consoleintr+0xc8>
80100f00:	ff 24 9d 64 83 10 80 	jmp    *-0x7fef7c9c(,%ebx,4)
80100f07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f0e:	00 
80100f0f:	90                   	nop
80100f10:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100f16:	0f 84 14 05 00 00    	je     80101430 <consoleintr+0x570>
80100f1c:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100f22:	75 54                	jne    80100f78 <consoleintr+0xb8>
      int cursor1 = input.e-left_key_pressed_count;
80100f24:	8b 15 28 ff 10 80    	mov    0x8010ff28,%edx
80100f2a:	a1 30 ff 10 80       	mov    0x8010ff30,%eax
80100f2f:	89 d1                	mov    %edx,%ecx
80100f31:	29 c1                	sub    %eax,%ecx
      if(input.e>cursor1){
80100f33:	39 d1                	cmp    %edx,%ecx
80100f35:	0f 82 dd 05 00 00    	jb     80101518 <consoleintr+0x658>
        left_key_pressed=0;
80100f3b:	c7 05 34 ff 10 80 00 	movl   $0x0,0x8010ff34
80100f42:	00 00 00 
  while((c = getc()) >= 0){
80100f45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f48:	ff d0                	call   *%eax
80100f4a:	89 c3                	mov    %eax,%ebx
80100f4c:	85 c0                	test   %eax,%eax
80100f4e:	79 9e                	jns    80100eee <consoleintr+0x2e>
  release(&cons.lock);
80100f50:	83 ec 0c             	sub    $0xc,%esp
80100f53:	68 40 ff 10 80       	push   $0x8010ff40
80100f58:	e8 e3 42 00 00       	call   80105240 <release>
  if(doprocdump) {
80100f5d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100f60:	83 c4 10             	add    $0x10,%esp
80100f63:	85 c0                	test   %eax,%eax
80100f65:	0f 85 65 05 00 00    	jne    801014d0 <consoleintr+0x610>
}
80100f6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6e:	5b                   	pop    %ebx
80100f6f:	5e                   	pop    %esi
80100f70:	5f                   	pop    %edi
80100f71:	5d                   	pop    %ebp
80100f72:	c3                   	ret
80100f73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    switch(c){
80100f78:	83 fb 7f             	cmp    $0x7f,%ebx
80100f7b:	0f 84 af 00 00 00    	je     80101030 <consoleintr+0x170>
80100f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100f88:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100f8d:	89 c2                	mov    %eax,%edx
80100f8f:	2b 15 20 ff 10 80    	sub    0x8010ff20,%edx
80100f95:	83 fa 7f             	cmp    $0x7f,%edx
80100f98:	0f 87 45 ff ff ff    	ja     80100ee3 <consoleintr+0x23>
  if(panicked){
80100f9e:	8b 0d 78 ff 10 80    	mov    0x8010ff78,%ecx
          input.buf[(input.e++) % INPUT_BUF] = c;
80100fa4:	8d 50 01             	lea    0x1(%eax),%edx
        if (c=='\n')
80100fa7:	83 fb 0a             	cmp    $0xa,%ebx
80100faa:	74 09                	je     80100fb5 <consoleintr+0xf5>
80100fac:	83 fb 0d             	cmp    $0xd,%ebx
80100faf:	0f 85 23 06 00 00    	jne    801015d8 <consoleintr+0x718>
          input.buf[(input.e++) % INPUT_BUF] = c;
80100fb5:	83 e0 7f             	and    $0x7f,%eax
80100fb8:	89 15 28 ff 10 80    	mov    %edx,0x8010ff28
80100fbe:	c6 80 a0 fe 10 80 0a 	movb   $0xa,-0x7fef0160(%eax)
    input_sequence.size = 0;
80100fc5:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80100fcc:	00 00 00 
  if(panicked){
80100fcf:	85 c9                	test   %ecx,%ecx
80100fd1:	0f 85 f9 05 00 00    	jne    801015d0 <consoleintr+0x710>
    uartputc(c);
80100fd7:	83 ec 0c             	sub    $0xc,%esp
80100fda:	6a 0a                	push   $0xa
80100fdc:	e8 cf 59 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80100fe1:	b8 0a 00 00 00       	mov    $0xa,%eax
80100fe6:	e8 95 f4 ff ff       	call   80100480 <cgaputc>
          input.w = input.e;
80100feb:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100ff0:	83 c4 10             	add    $0x10,%esp
    input_sequence.size = 0;
80100ff3:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80100ffa:	00 00 00 
          wakeup(&input.r);
80100ffd:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80101000:	a3 24 ff 10 80       	mov    %eax,0x8010ff24
          left_key_pressed=0;
80101005:	c7 05 34 ff 10 80 00 	movl   $0x0,0x8010ff34
8010100c:	00 00 00 
          left_key_pressed_count=0;
8010100f:	c7 05 30 ff 10 80 00 	movl   $0x0,0x8010ff30
80101016:	00 00 00 
          wakeup(&input.r);
80101019:	68 20 ff 10 80       	push   $0x8010ff20
8010101e:	e8 bd 3d 00 00       	call   80104de0 <wakeup>
80101023:	83 c4 10             	add    $0x10,%esp
80101026:	e9 b8 fe ff ff       	jmp    80100ee3 <consoleintr+0x23>
8010102b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(input.e != input.w && input.e - input.w > left_key_pressed_count){
80101030:	8b 1d 28 ff 10 80    	mov    0x8010ff28,%ebx
80101036:	a1 24 ff 10 80       	mov    0x8010ff24,%eax
8010103b:	39 c3                	cmp    %eax,%ebx
8010103d:	0f 84 a0 fe ff ff    	je     80100ee3 <consoleintr+0x23>
80101043:	89 d9                	mov    %ebx,%ecx
80101045:	8b 15 30 ff 10 80    	mov    0x8010ff30,%edx
8010104b:	29 c1                	sub    %eax,%ecx
8010104d:	39 ca                	cmp    %ecx,%edx
8010104f:	0f 83 8e fe ff ff    	jae    80100ee3 <consoleintr+0x23>
  int shift_idx= shift_from_seq ? last_sequence(): input.e-left_key_pressed_count;
80101055:	89 df                	mov    %ebx,%edi
80101057:	89 de                	mov    %ebx,%esi
80101059:	29 d7                	sub    %edx,%edi
  for (int i = shift_idx - 1; i < input.e; i++)
8010105b:	8d 57 ff             	lea    -0x1(%edi),%edx
8010105e:	39 da                	cmp    %ebx,%edx
80101060:	73 3d                	jae    8010109f <consoleintr+0x1df>
80101062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
80101068:	89 d0                	mov    %edx,%eax
8010106a:	83 c2 01             	add    $0x1,%edx
8010106d:	89 d3                	mov    %edx,%ebx
8010106f:	c1 fb 1f             	sar    $0x1f,%ebx
80101072:	c1 eb 19             	shr    $0x19,%ebx
80101075:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80101078:	83 e1 7f             	and    $0x7f,%ecx
8010107b:	29 d9                	sub    %ebx,%ecx
8010107d:	0f b6 99 a0 fe 10 80 	movzbl -0x7fef0160(%ecx),%ebx
80101084:	89 c1                	mov    %eax,%ecx
80101086:	c1 f9 1f             	sar    $0x1f,%ecx
80101089:	c1 e9 19             	shr    $0x19,%ecx
8010108c:	01 c8                	add    %ecx,%eax
8010108e:	83 e0 7f             	and    $0x7f,%eax
80101091:	29 c8                	sub    %ecx,%eax
80101093:	88 98 a0 fe 10 80    	mov    %bl,-0x7fef0160(%eax)
  for (int i = shift_idx - 1; i < input.e; i++)
80101099:	39 f2                	cmp    %esi,%edx
8010109b:	72 cb                	jb     80101068 <consoleintr+0x1a8>
8010109d:	89 f3                	mov    %esi,%ebx
        delete_from_sequence(input.e-left_key_pressed_count);
8010109f:	83 ec 0c             	sub    $0xc,%esp
  input.buf[input.e] = ' ';
801010a2:	c6 83 a0 fe 10 80 20 	movb   $0x20,-0x7fef0160(%ebx)
        delete_from_sequence(input.e-left_key_pressed_count);
801010a9:	57                   	push   %edi
801010aa:	e8 a1 fc ff ff       	call   80100d50 <delete_from_sequence>
        for(int i=0;i<input_sequence.size;i++)
801010af:	8b 1d 00 92 10 80    	mov    0x80109200,%ebx
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 db                	test   %ebx,%ebx
801010ba:	0f 8e 5e 06 00 00    	jle    8010171e <consoleintr+0x85e>
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
801010c0:	8b 35 28 ff 10 80    	mov    0x8010ff28,%esi
        for(int i=0;i<input_sequence.size;i++)
801010c6:	31 c0                	xor    %eax,%eax
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
801010c8:	89 f1                	mov    %esi,%ecx
801010ca:	2b 0d 30 ff 10 80    	sub    0x8010ff30,%ecx
801010d0:	83 e1 7f             	and    $0x7f,%ecx
801010d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801010d8:	8b 14 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%edx
801010df:	39 d1                	cmp    %edx,%ecx
801010e1:	73 0a                	jae    801010ed <consoleintr+0x22d>
              input_sequence.data[i]--;
801010e3:	83 ea 01             	sub    $0x1,%edx
801010e6:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
        for(int i=0;i<input_sequence.size;i++)
801010ed:	83 c0 01             	add    $0x1,%eax
801010f0:	39 c3                	cmp    %eax,%ebx
801010f2:	75 e4                	jne    801010d8 <consoleintr+0x218>
  if(panicked){
801010f4:	8b 1d 78 ff 10 80    	mov    0x8010ff78,%ebx
        input.e--;
801010fa:	83 ee 01             	sub    $0x1,%esi
801010fd:	89 35 28 ff 10 80    	mov    %esi,0x8010ff28
  if(panicked){
80101103:	85 db                	test   %ebx,%ebx
80101105:	0f 84 d0 05 00 00    	je     801016db <consoleintr+0x81b>
  asm volatile("cli");
8010110b:	fa                   	cli
    for(;;)
8010110c:	eb fe                	jmp    8010110c <consoleintr+0x24c>
8010110e:	66 90                	xchg   %ax,%ax
        cgaputc("0"+input.e);
80101110:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80101115:	05 d0 7e 10 80       	add    $0x80107ed0,%eax
8010111a:	e8 61 f3 ff ff       	call   80100480 <cgaputc>
         cgaputc(cga_pos_sequence.pos_data[cga_pos_sequence.size-1]);
8010111f:	a1 20 94 10 80       	mov    0x80109420,%eax
80101124:	8b 04 85 1c 92 10 80 	mov    -0x7fef6de4(,%eax,4),%eax
8010112b:	e8 50 f3 ff ff       	call   80100480 <cgaputc>
      break;
80101130:	e9 ae fd ff ff       	jmp    80100ee3 <consoleintr+0x23>
        int pos = input.e-left_key_pressed_count;
80101135:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
8010113a:	8b 3d 30 ff 10 80    	mov    0x8010ff30,%edi
80101140:	89 c2                	mov    %eax,%edx
80101142:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101145:	29 fa                	sub    %edi,%edx
        int distance = pos - (input.e-left_key_pressed_count);
80101147:	29 c7                	sub    %eax,%edi
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
80101149:	89 d3                	mov    %edx,%ebx
        int distance = pos - (input.e-left_key_pressed_count);
8010114b:	89 fe                	mov    %edi,%esi
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
8010114d:	c1 fb 1f             	sar    $0x1f,%ebx
80101150:	c1 eb 19             	shr    $0x19,%ebx
80101153:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80101156:	83 e1 7f             	and    $0x7f,%ecx
80101159:	29 d9                	sub    %ebx,%ecx
8010115b:	80 b9 a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ecx)
80101162:	74 2c                	je     80101190 <consoleintr+0x2d0>
80101164:	39 c2                	cmp    %eax,%edx
80101166:	72 0c                	jb     80101174 <consoleintr+0x2b4>
80101168:	e9 b6 00 00 00       	jmp    80101223 <consoleintr+0x363>
8010116d:	8d 76 00             	lea    0x0(%esi),%esi
80101170:	39 c2                	cmp    %eax,%edx
80101172:	73 38                	jae    801011ac <consoleintr+0x2ec>
            pos++;
80101174:	83 c2 01             	add    $0x1,%edx
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
80101177:	89 d3                	mov    %edx,%ebx
80101179:	c1 fb 1f             	sar    $0x1f,%ebx
8010117c:	c1 eb 19             	shr    $0x19,%ebx
8010117f:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80101182:	83 e1 7f             	and    $0x7f,%ecx
80101185:	29 d9                	sub    %ebx,%ecx
80101187:	80 b9 a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ecx)
8010118e:	75 e0                	jne    80101170 <consoleintr+0x2b0>
            pos++;
80101190:	83 c2 01             	add    $0x1,%edx
            while (input.buf[pos % INPUT_BUF] == ' '){
80101193:	89 d3                	mov    %edx,%ebx
80101195:	c1 fb 1f             	sar    $0x1f,%ebx
80101198:	c1 eb 19             	shr    $0x19,%ebx
8010119b:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
8010119e:	83 e1 7f             	and    $0x7f,%ecx
801011a1:	29 d9                	sub    %ebx,%ecx
801011a3:	80 b9 a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ecx)
801011aa:	74 e4                	je     80101190 <consoleintr+0x2d0>
        left_key_pressed_count = input.e-pos;
801011ac:	29 d0                	sub    %edx,%eax
        int distance = pos - (input.e-left_key_pressed_count);
801011ae:	01 f2                	add    %esi,%edx
        left_key_pressed_count = input.e-pos;
801011b0:	89 45 d8             	mov    %eax,-0x28(%ebp)
        for (int i = 0; i < distance; i++)
801011b3:	85 d2                	test   %edx,%edx
801011b5:	7e 6c                	jle    80101223 <consoleintr+0x363>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801011b7:	89 55 e0             	mov    %edx,-0x20(%ebp)
801011ba:	31 f6                	xor    %esi,%esi
801011bc:	bf 0e 00 00 00       	mov    $0xe,%edi
801011c1:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801011c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801011cd:	00 
801011ce:	66 90                	xchg   %ax,%ax
801011d0:	89 f8                	mov    %edi,%eax
801011d2:	89 da                	mov    %ebx,%edx
801011d4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801011d5:	ba d5 03 00 00       	mov    $0x3d5,%edx
801011da:	ec                   	in     (%dx),%al

void move_cursor_right(void) {
    int pos;

    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
801011db:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801011de:	89 da                	mov    %ebx,%edx
801011e0:	b8 0f 00 00 00       	mov    $0xf,%eax
801011e5:	c1 e1 08             	shl    $0x8,%ecx
801011e8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801011e9:	ba d5 03 00 00       	mov    $0x3d5,%edx
801011ee:	ec                   	in     (%dx),%al
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
801011ef:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801011f2:	89 da                	mov    %ebx,%edx
801011f4:	09 c1                	or     %eax,%ecx
801011f6:	89 f8                	mov    %edi,%eax

    pos++;
801011f8:	83 c1 01             	add    $0x1,%ecx
801011fb:	ee                   	out    %al,(%dx)

    outb(CRTPORT, 14);
    outb(CRTPORT+1, pos >> 8);
801011fc:	89 ca                	mov    %ecx,%edx
801011fe:	c1 fa 08             	sar    $0x8,%edx
80101201:	89 d0                	mov    %edx,%eax
80101203:	ba d5 03 00 00       	mov    $0x3d5,%edx
80101208:	ee                   	out    %al,(%dx)
80101209:	b8 0f 00 00 00       	mov    $0xf,%eax
8010120e:	89 da                	mov    %ebx,%edx
80101210:	ee                   	out    %al,(%dx)
80101211:	ba d5 03 00 00       	mov    $0x3d5,%edx
80101216:	89 c8                	mov    %ecx,%eax
80101218:	ee                   	out    %al,(%dx)
        for (int i = 0; i < distance; i++)
80101219:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010121c:	83 c6 01             	add    $0x1,%esi
8010121f:	39 c6                	cmp    %eax,%esi
80101221:	75 ad                	jne    801011d0 <consoleintr+0x310>
        left_key_pressed_count = input.e-pos;
80101223:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101226:	a3 30 ff 10 80       	mov    %eax,0x8010ff30
        break;
8010122b:	e9 b3 fc ff ff       	jmp    80100ee3 <consoleintr+0x23>
      if(input.e != input.w){
80101230:	a1 24 ff 10 80       	mov    0x8010ff24,%eax
80101235:	39 05 28 ff 10 80    	cmp    %eax,0x8010ff28
8010123b:	0f 84 a2 fc ff ff    	je     80100ee3 <consoleintr+0x23>
    if (input_sequence.size == 0) return -1;
80101241:	a1 00 92 10 80       	mov    0x80109200,%eax
    return input_sequence.data[input_sequence.size - 1];
80101246:	8d 50 ff             	lea    -0x1(%eax),%edx
    if (input_sequence.size == 0) return -1;
80101249:	85 c0                	test   %eax,%eax
8010124b:	0f 84 be 04 00 00    	je     8010170f <consoleintr+0x84f>
  for (int i = shift_idx - 1; i < input.e; i++)
80101251:	8b 04 95 00 90 10 80 	mov    -0x7fef7000(,%edx,4),%eax
80101258:	8d 58 ff             	lea    -0x1(%eax),%ebx
8010125b:	89 de                	mov    %ebx,%esi
    (delete_from_sequence(input_sequence.size-1));
8010125d:	83 ec 0c             	sub    $0xc,%esp
80101260:	52                   	push   %edx
80101261:	e8 ea fa ff ff       	call   80100d50 <delete_from_sequence>
  for (int i = shift_idx - 1; i < input.e; i++)
80101266:	8b 0d 28 ff 10 80    	mov    0x8010ff28,%ecx
8010126c:	83 c4 10             	add    $0x10,%esp
8010126f:	39 ce                	cmp    %ecx,%esi
80101271:	73 38                	jae    801012ab <consoleintr+0x3eb>
80101273:	89 ce                	mov    %ecx,%esi
80101275:	8d 76 00             	lea    0x0(%esi),%esi
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
80101278:	89 d8                	mov    %ebx,%eax
8010127a:	83 c3 01             	add    $0x1,%ebx
8010127d:	89 d9                	mov    %ebx,%ecx
8010127f:	c1 f9 1f             	sar    $0x1f,%ecx
80101282:	c1 e9 19             	shr    $0x19,%ecx
80101285:	8d 14 0b             	lea    (%ebx,%ecx,1),%edx
80101288:	83 e2 7f             	and    $0x7f,%edx
8010128b:	29 ca                	sub    %ecx,%edx
8010128d:	0f b6 8a a0 fe 10 80 	movzbl -0x7fef0160(%edx),%ecx
80101294:	99                   	cltd
80101295:	c1 ea 19             	shr    $0x19,%edx
80101298:	01 d0                	add    %edx,%eax
8010129a:	83 e0 7f             	and    $0x7f,%eax
8010129d:	29 d0                	sub    %edx,%eax
8010129f:	88 88 a0 fe 10 80    	mov    %cl,-0x7fef0160(%eax)
  for (int i = shift_idx - 1; i < input.e; i++)
801012a5:	39 f3                	cmp    %esi,%ebx
801012a7:	72 cf                	jb     80101278 <consoleintr+0x3b8>
801012a9:	89 f1                	mov    %esi,%ecx
  if(panicked){
801012ab:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
  input.buf[input.e] = ' ';
801012b1:	c6 81 a0 fe 10 80 20 	movb   $0x20,-0x7fef0160(%ecx)
        input.e--;
801012b8:	83 e9 01             	sub    $0x1,%ecx
801012bb:	89 0d 28 ff 10 80    	mov    %ecx,0x8010ff28
  if(panicked){
801012c1:	85 d2                	test   %edx,%edx
801012c3:	0f 84 aa 02 00 00    	je     80101573 <consoleintr+0x6b3>
  asm volatile("cli");
801012c9:	fa                   	cli
    for(;;)
801012ca:	eb fe                	jmp    801012ca <consoleintr+0x40a>
801012cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
801012d0:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
801012d5:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
801012db:	0f 84 02 fc ff ff    	je     80100ee3 <consoleintr+0x23>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801012e1:	83 e8 01             	sub    $0x1,%eax
801012e4:	89 c2                	mov    %eax,%edx
801012e6:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801012e9:	80 ba a0 fe 10 80 0a 	cmpb   $0xa,-0x7fef0160(%edx)
801012f0:	0f 84 ed fb ff ff    	je     80100ee3 <consoleintr+0x23>
  if(panicked){
801012f6:	8b 35 78 ff 10 80    	mov    0x8010ff78,%esi
        input.e--;
801012fc:	a3 28 ff 10 80       	mov    %eax,0x8010ff28
  if(panicked){
80101301:	85 f6                	test   %esi,%esi
80101303:	0f 84 67 01 00 00    	je     80101470 <consoleintr+0x5b0>
80101309:	fa                   	cli
    for(;;)
8010130a:	eb fe                	jmp    8010130a <consoleintr+0x44a>
8010130c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
         int posA = input.e-left_key_pressed_count;
80101310:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80101315:	89 c2                	mov    %eax,%edx
80101317:	2b 15 30 ff 10 80    	sub    0x8010ff30,%edx
8010131d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80101320:	89 d1                	mov    %edx,%ecx
         int posA = input.e-left_key_pressed_count;
80101322:	89 d0                	mov    %edx,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80101324:	89 d3                	mov    %edx,%ebx
80101326:	c1 f9 1f             	sar    $0x1f,%ecx
80101329:	c1 e9 19             	shr    $0x19,%ecx
8010132c:	8d 34 0a             	lea    (%edx,%ecx,1),%esi
8010132f:	83 e6 7f             	and    $0x7f,%esi
80101332:	29 ce                	sub    %ecx,%esi
      while(input.e != input.w &&
80101334:	8b 0d 24 ff 10 80    	mov    0x8010ff24,%ecx
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
8010133a:	80 be 9f fe 10 80 20 	cmpb   $0x20,-0x7fef0161(%esi)
80101341:	74 25                	je     80101368 <consoleintr+0x4a8>
80101343:	eb 29                	jmp    8010136e <consoleintr+0x4ae>
80101345:	8d 76 00             	lea    0x0(%esi),%esi
            posA--;
80101348:	83 e8 01             	sub    $0x1,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
8010134b:	89 c3                	mov    %eax,%ebx
8010134d:	c1 fb 1f             	sar    $0x1f,%ebx
80101350:	c1 eb 19             	shr    $0x19,%ebx
80101353:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80101356:	83 e6 7f             	and    $0x7f,%esi
80101359:	29 de                	sub    %ebx,%esi
8010135b:	80 be 9f fe 10 80 20 	cmpb   $0x20,-0x7fef0161(%esi)
80101362:	0f 85 8f 01 00 00    	jne    801014f7 <consoleintr+0x637>
80101368:	89 c3                	mov    %eax,%ebx
8010136a:	39 c1                	cmp    %eax,%ecx
8010136c:	72 da                	jb     80101348 <consoleintr+0x488>
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
8010136e:	80 be a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%esi)
80101375:	0f 84 8b 01 00 00    	je     80101506 <consoleintr+0x646>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
8010137b:	89 c7                	mov    %eax,%edi
8010137d:	c1 ff 1f             	sar    $0x1f,%edi
80101380:	c1 ef 19             	shr    $0x19,%edi
80101383:	8d 34 38             	lea    (%eax,%edi,1),%esi
80101386:	83 e6 7f             	and    $0x7f,%esi
80101389:	29 fe                	sub    %edi,%esi
8010138b:	80 be a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%esi)
80101392:	75 2c                	jne    801013c0 <consoleintr+0x500>
80101394:	e9 51 01 00 00       	jmp    801014ea <consoleintr+0x62a>
80101399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            posA--;
801013a0:	83 e8 01             	sub    $0x1,%eax
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
801013a3:	89 c6                	mov    %eax,%esi
801013a5:	c1 fe 1f             	sar    $0x1f,%esi
801013a8:	c1 ee 19             	shr    $0x19,%esi
801013ab:	8d 1c 30             	lea    (%eax,%esi,1),%ebx
801013ae:	83 e3 7f             	and    $0x7f,%ebx
801013b1:	29 f3                	sub    %esi,%ebx
801013b3:	80 bb a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ebx)
801013ba:	0f 84 28 01 00 00    	je     801014e8 <consoleintr+0x628>
801013c0:	89 c3                	mov    %eax,%ebx
801013c2:	39 c1                	cmp    %eax,%ecx
801013c4:	72 da                	jb     801013a0 <consoleintr+0x4e0>
        int distanceA = input.e-left_key_pressed_count-posA;
801013c6:	89 d6                	mov    %edx,%esi
801013c8:	29 de                	sub    %ebx,%esi
        for (int i = distanceA; i > 0; i--)
801013ca:	85 f6                	test   %esi,%esi
801013cc:	7e 29                	jle    801013f7 <consoleintr+0x537>
801013ce:	8d 7e ff             	lea    -0x1(%esi),%edi
801013d1:	f7 c6 01 00 00 00    	test   $0x1,%esi
801013d7:	74 0f                	je     801013e8 <consoleintr+0x528>
            move_cursor_left();
801013d9:	e8 72 fa ff ff       	call   80100e50 <move_cursor_left>
        for (int i = distanceA; i > 0; i--)
801013de:	89 fe                	mov    %edi,%esi
801013e0:	85 ff                	test   %edi,%edi
801013e2:	74 13                	je     801013f7 <consoleintr+0x537>
801013e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            move_cursor_left();
801013e8:	e8 63 fa ff ff       	call   80100e50 <move_cursor_left>
801013ed:	e8 5e fa ff ff       	call   80100e50 <move_cursor_left>
        for (int i = distanceA; i > 0; i--)
801013f2:	83 ee 02             	sub    $0x2,%esi
801013f5:	75 f1                	jne    801013e8 <consoleintr+0x528>
        left_key_pressed_count = input.e-posA;     
801013f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013fa:	29 d8                	sub    %ebx,%eax
801013fc:	a3 30 ff 10 80       	mov    %eax,0x8010ff30
      break;
80101401:	e9 dd fa ff ff       	jmp    80100ee3 <consoleintr+0x23>
      input.tabr=input.r;
80101406:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
      wakeup(&input.r);
8010140b:	83 ec 0c             	sub    $0xc,%esp
      tab_flag=1;
8010140e:	c7 05 80 fe 10 80 01 	movl   $0x1,0x8010fe80
80101415:	00 00 00 
      input.tabr=input.r;
80101418:	a3 2c ff 10 80       	mov    %eax,0x8010ff2c
      wakeup(&input.r);
8010141d:	68 20 ff 10 80       	push   $0x8010ff20
80101422:	e8 b9 39 00 00       	call   80104de0 <wakeup>
      break;
80101427:	83 c4 10             	add    $0x10,%esp
8010142a:	e9 b4 fa ff ff       	jmp    80100ee3 <consoleintr+0x23>
8010142f:	90                   	nop
        int cursor = input.e-left_key_pressed_count;
80101430:	8b 1d 30 ff 10 80    	mov    0x8010ff30,%ebx
80101436:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
8010143b:	29 d8                	sub    %ebx,%eax
        if (input.w < cursor)
8010143d:	39 05 24 ff 10 80    	cmp    %eax,0x8010ff24
80101443:	0f 83 9a fa ff ff    	jae    80100ee3 <consoleintr+0x23>
          if (left_key_pressed==0)
80101449:	8b 0d 34 ff 10 80    	mov    0x8010ff34,%ecx
8010144f:	85 c9                	test   %ecx,%ecx
80101451:	75 0a                	jne    8010145d <consoleintr+0x59d>
            left_key_pressed=1;
80101453:	c7 05 34 ff 10 80 01 	movl   $0x1,0x8010ff34
8010145a:	00 00 00 
          move_cursor_left();
8010145d:	e8 ee f9 ff ff       	call   80100e50 <move_cursor_left>
          left_key_pressed_count++;
80101462:	83 c3 01             	add    $0x1,%ebx
80101465:	89 1d 30 ff 10 80    	mov    %ebx,0x8010ff30
8010146b:	e9 73 fa ff ff       	jmp    80100ee3 <consoleintr+0x23>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101470:	83 ec 0c             	sub    $0xc,%esp
80101473:	6a 08                	push   $0x8
80101475:	e8 36 55 00 00       	call   801069b0 <uartputc>
8010147a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101481:	e8 2a 55 00 00       	call   801069b0 <uartputc>
80101486:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010148d:	e8 1e 55 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80101492:	b8 00 01 00 00       	mov    $0x100,%eax
80101497:	e8 e4 ef ff ff       	call   80100480 <cgaputc>
      while(input.e != input.w &&
8010149c:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
801014a1:	83 c4 10             	add    $0x10,%esp
    input_sequence.size = 0;
801014a4:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
801014ab:	00 00 00 
    cga_pos_sequence.size = 0;
801014ae:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
801014b5:	00 00 00 
      while(input.e != input.w &&
801014b8:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
801014be:	0f 85 1d fe ff ff    	jne    801012e1 <consoleintr+0x421>
801014c4:	e9 1a fa ff ff       	jmp    80100ee3 <consoleintr+0x23>
801014c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801014d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014d3:	5b                   	pop    %ebx
801014d4:	5e                   	pop    %esi
801014d5:	5f                   	pop    %edi
801014d6:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
801014d7:	e9 e4 39 00 00       	jmp    80104ec0 <procdump>
    switch(c){
801014dc:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
801014e3:	e9 fb f9 ff ff       	jmp    80100ee3 <consoleintr+0x23>
        int distanceA = input.e-left_key_pressed_count-posA;
801014e8:	89 c3                	mov    %eax,%ebx
          posA++;
801014ea:	83 c0 01             	add    $0x1,%eax
801014ed:	39 d9                	cmp    %ebx,%ecx
801014ef:	0f 42 d8             	cmovb  %eax,%ebx
801014f2:	e9 cf fe ff ff       	jmp    801013c6 <consoleintr+0x506>
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
801014f7:	80 be a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%esi)
801014fe:	89 c3                	mov    %eax,%ebx
80101500:	0f 85 75 fe ff ff    	jne    8010137b <consoleintr+0x4bb>
80101506:	39 d9                	cmp    %ebx,%ecx
80101508:	0f 83 99 00 00 00    	jae    801015a7 <consoleintr+0x6e7>
          posA--;
8010150e:	83 e8 01             	sub    $0x1,%eax
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
80101511:	89 c3                	mov    %eax,%ebx
80101513:	e9 63 fe ff ff       	jmp    8010137b <consoleintr+0x4bb>
        left_key_pressed_count--;
80101518:	83 e8 01             	sub    $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010151b:	bf 0e 00 00 00       	mov    $0xe,%edi
80101520:	be d4 03 00 00       	mov    $0x3d4,%esi
80101525:	a3 30 ff 10 80       	mov    %eax,0x8010ff30
8010152a:	89 f2                	mov    %esi,%edx
8010152c:	89 f8                	mov    %edi,%eax
8010152e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010152f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80101534:	89 da                	mov    %ebx,%edx
80101536:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80101537:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010153a:	89 f2                	mov    %esi,%edx
8010153c:	c1 e0 08             	shl    $0x8,%eax
8010153f:	89 c1                	mov    %eax,%ecx
80101541:	b8 0f 00 00 00       	mov    $0xf,%eax
80101546:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101547:	89 da                	mov    %ebx,%edx
80101549:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
8010154a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010154d:	89 f2                	mov    %esi,%edx
8010154f:	09 c1                	or     %eax,%ecx
80101551:	89 f8                	mov    %edi,%eax
    pos++;
80101553:	83 c1 01             	add    $0x1,%ecx
80101556:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80101557:	89 cf                	mov    %ecx,%edi
80101559:	89 da                	mov    %ebx,%edx
8010155b:	c1 ff 08             	sar    $0x8,%edi
8010155e:	89 f8                	mov    %edi,%eax
80101560:	ee                   	out    %al,(%dx)
80101561:	b8 0f 00 00 00       	mov    $0xf,%eax
80101566:	89 f2                	mov    %esi,%edx
80101568:	ee                   	out    %al,(%dx)
80101569:	89 c8                	mov    %ecx,%eax
8010156b:	89 da                	mov    %ebx,%edx
8010156d:	ee                   	out    %al,(%dx)
    outb(CRTPORT, 15);
    outb(CRTPORT+1, pos);
}
8010156e:	e9 70 f9 ff ff       	jmp    80100ee3 <consoleintr+0x23>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101573:	83 ec 0c             	sub    $0xc,%esp
80101576:	6a 08                	push   $0x8
80101578:	e8 33 54 00 00       	call   801069b0 <uartputc>
8010157d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101584:	e8 27 54 00 00       	call   801069b0 <uartputc>
80101589:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101590:	e8 1b 54 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80101595:	b8 01 01 00 00       	mov    $0x101,%eax
8010159a:	e8 e1 ee ff ff       	call   80100480 <cgaputc>
}
8010159f:	83 c4 10             	add    $0x10,%esp
801015a2:	e9 3c f9 ff ff       	jmp    80100ee3 <consoleintr+0x23>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
801015a7:	89 c7                	mov    %eax,%edi
801015a9:	c1 ff 1f             	sar    $0x1f,%edi
801015ac:	c1 ef 19             	shr    $0x19,%edi
801015af:	8d 34 38             	lea    (%eax,%edi,1),%esi
801015b2:	83 e6 7f             	and    $0x7f,%esi
801015b5:	29 fe                	sub    %edi,%esi
801015b7:	80 be a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%esi)
801015be:	0f 85 fc fd ff ff    	jne    801013c0 <consoleintr+0x500>
801015c4:	e9 fd fd ff ff       	jmp    801013c6 <consoleintr+0x506>
801015c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cli");
801015d0:	fa                   	cli
    for(;;)
801015d1:	eb fe                	jmp    801015d1 <consoleintr+0x711>
801015d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
   int cursor= input.e-left_key_pressed_count;
801015d8:	89 c6                	mov    %eax,%esi
801015da:	2b 35 30 ff 10 80    	sub    0x8010ff30,%esi
  for (int i = input.e; i > cursor; i--)
801015e0:	39 c6                	cmp    %eax,%esi
801015e2:	7d 45                	jge    80101629 <consoleintr+0x769>
801015e4:	89 5d e0             	mov    %ebx,-0x20(%ebp)
801015e7:	89 cf                	mov    %ecx,%edi
801015e9:	89 55 d8             	mov    %edx,-0x28(%ebp)
    input.buf[(i) % INPUT_BUF] = input.buf[(i-1) % INPUT_BUF]; // Shift elements to right
801015ec:	89 c2                	mov    %eax,%edx
801015ee:	83 e8 01             	sub    $0x1,%eax
801015f1:	89 c3                	mov    %eax,%ebx
801015f3:	c1 fb 1f             	sar    $0x1f,%ebx
801015f6:	c1 eb 19             	shr    $0x19,%ebx
801015f9:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801015fc:	83 e1 7f             	and    $0x7f,%ecx
801015ff:	29 d9                	sub    %ebx,%ecx
80101601:	89 d3                	mov    %edx,%ebx
80101603:	c1 fb 1f             	sar    $0x1f,%ebx
80101606:	0f b6 89 a0 fe 10 80 	movzbl -0x7fef0160(%ecx),%ecx
8010160d:	c1 eb 19             	shr    $0x19,%ebx
80101610:	01 da                	add    %ebx,%edx
80101612:	83 e2 7f             	and    $0x7f,%edx
80101615:	29 da                	sub    %ebx,%edx
80101617:	88 8a a0 fe 10 80    	mov    %cl,-0x7fef0160(%edx)
  for (int i = input.e; i > cursor; i--)
8010161d:	39 c6                	cmp    %eax,%esi
8010161f:	75 cb                	jne    801015ec <consoleintr+0x72c>
80101621:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101624:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101627:	89 f9                	mov    %edi,%ecx
    if (input_sequence.size >= input_sequence.cap) {
80101629:	8b 3d 00 92 10 80    	mov    0x80109200,%edi
8010162f:	83 e6 7f             	and    $0x7f,%esi
80101632:	3b 3d 04 92 10 80    	cmp    0x80109204,%edi
80101638:	7d 11                	jge    8010164b <consoleintr+0x78b>
    input_sequence.data[input_sequence.size++] = value;
8010163a:	8d 47 01             	lea    0x1(%edi),%eax
8010163d:	89 34 bd 00 90 10 80 	mov    %esi,-0x7fef7000(,%edi,4)
80101644:	a3 00 92 10 80       	mov    %eax,0x80109200
80101649:	89 c7                	mov    %eax,%edi
          for(int i=0;i<input_sequence.size;i++)
8010164b:	31 c0                	xor    %eax,%eax
8010164d:	85 ff                	test   %edi,%edi
8010164f:	7e 22                	jle    80101673 <consoleintr+0x7b3>
80101651:	89 5d e0             	mov    %ebx,-0x20(%ebp)
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
80101654:	8b 1c 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%ebx
8010165b:	39 de                	cmp    %ebx,%esi
8010165d:	73 0a                	jae    80101669 <consoleintr+0x7a9>
              input_sequence.data[i]++;
8010165f:	83 c3 01             	add    $0x1,%ebx
80101662:	89 1c 85 00 90 10 80 	mov    %ebx,-0x7fef7000(,%eax,4)
          for(int i=0;i<input_sequence.size;i++)
80101669:	83 c0 01             	add    $0x1,%eax
8010166c:	39 f8                	cmp    %edi,%eax
8010166e:	75 e4                	jne    80101654 <consoleintr+0x794>
80101670:	8b 5d e0             	mov    -0x20(%ebp),%ebx
          input.buf[(input.e++-left_key_pressed_count) % INPUT_BUF] = c;
80101673:	89 15 28 ff 10 80    	mov    %edx,0x8010ff28
80101679:	88 9e a0 fe 10 80    	mov    %bl,-0x7fef0160(%esi)
  if(panicked){
8010167f:	85 c9                	test   %ecx,%ecx
80101681:	0f 85 49 ff ff ff    	jne    801015d0 <consoleintr+0x710>
  if(c == BACKSPACE || c==UNDO_BS){
80101687:	8d 83 00 ff ff ff    	lea    -0x100(%ebx),%eax
8010168d:	83 f8 01             	cmp    $0x1,%eax
80101690:	0f 87 93 00 00 00    	ja     80101729 <consoleintr+0x869>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101696:	83 ec 0c             	sub    $0xc,%esp
80101699:	6a 08                	push   $0x8
8010169b:	e8 10 53 00 00       	call   801069b0 <uartputc>
801016a0:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801016a7:	e8 04 53 00 00       	call   801069b0 <uartputc>
801016ac:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801016b3:	e8 f8 52 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
801016b8:	89 d8                	mov    %ebx,%eax
801016ba:	e8 c1 ed ff ff       	call   80100480 <cgaputc>
801016bf:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801016c2:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801016c7:	83 e8 80             	sub    $0xffffff80,%eax
801016ca:	39 05 28 ff 10 80    	cmp    %eax,0x8010ff28
801016d0:	0f 85 0d f8 ff ff    	jne    80100ee3 <consoleintr+0x23>
801016d6:	e9 22 f9 ff ff       	jmp    80100ffd <consoleintr+0x13d>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801016db:	83 ec 0c             	sub    $0xc,%esp
801016de:	6a 08                	push   $0x8
801016e0:	e8 cb 52 00 00       	call   801069b0 <uartputc>
801016e5:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801016ec:	e8 bf 52 00 00       	call   801069b0 <uartputc>
801016f1:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801016f8:	e8 b3 52 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
801016fd:	b8 00 01 00 00       	mov    $0x100,%eax
80101702:	e8 79 ed ff ff       	call   80100480 <cgaputc>
}
80101707:	83 c4 10             	add    $0x10,%esp
8010170a:	e9 d4 f7 ff ff       	jmp    80100ee3 <consoleintr+0x23>
8010170f:	be fe ff ff ff       	mov    $0xfffffffe,%esi
80101714:	bb fe ff ff ff       	mov    $0xfffffffe,%ebx
80101719:	e9 3f fb ff ff       	jmp    8010125d <consoleintr+0x39d>
        input.e--;
8010171e:	8b 35 28 ff 10 80    	mov    0x8010ff28,%esi
80101724:	e9 cb f9 ff ff       	jmp    801010f4 <consoleintr+0x234>
    uartputc(c);
80101729:	83 ec 0c             	sub    $0xc,%esp
8010172c:	53                   	push   %ebx
8010172d:	e8 7e 52 00 00       	call   801069b0 <uartputc>
  cgaputc(c);
80101732:	89 d8                	mov    %ebx,%eax
80101734:	e8 47 ed ff ff       	call   80100480 <cgaputc>
80101739:	83 c4 10             	add    $0x10,%esp
8010173c:	eb 84                	jmp    801016c2 <consoleintr+0x802>
8010173e:	66 90                	xchg   %ax,%ax

80101740 <move_cursor_right>:
void move_cursor_right(void) {
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	57                   	push   %edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101744:	bf 0e 00 00 00       	mov    $0xe,%edi
80101749:	56                   	push   %esi
8010174a:	89 f8                	mov    %edi,%eax
8010174c:	53                   	push   %ebx
8010174d:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80101752:	89 da                	mov    %ebx,%edx
80101754:	83 ec 04             	sub    $0x4,%esp
80101757:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101758:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010175d:	89 ca                	mov    %ecx,%edx
8010175f:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80101760:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101763:	be 0f 00 00 00       	mov    $0xf,%esi
80101768:	89 da                	mov    %ebx,%edx
8010176a:	c1 e0 08             	shl    $0x8,%eax
8010176d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101770:	89 f0                	mov    %esi,%eax
80101772:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101773:	89 ca                	mov    %ecx,%edx
80101775:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80101776:	8b 55 f0             	mov    -0x10(%ebp),%edx
80101779:	0f b6 c0             	movzbl %al,%eax
8010177c:	09 d0                	or     %edx,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010177e:	89 da                	mov    %ebx,%edx
    pos++;
80101780:	83 c0 01             	add    $0x1,%eax
80101783:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101786:	89 f8                	mov    %edi,%eax
80101788:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80101789:	8b 7d f0             	mov    -0x10(%ebp),%edi
8010178c:	89 ca                	mov    %ecx,%edx
8010178e:	89 f8                	mov    %edi,%eax
80101790:	c1 f8 08             	sar    $0x8,%eax
80101793:	ee                   	out    %al,(%dx)
80101794:	89 f0                	mov    %esi,%eax
80101796:	89 da                	mov    %ebx,%edx
80101798:	ee                   	out    %al,(%dx)
80101799:	89 f8                	mov    %edi,%eax
8010179b:	89 ca                	mov    %ecx,%edx
8010179d:	ee                   	out    %al,(%dx)
}
8010179e:	83 c4 04             	add    $0x4,%esp
801017a1:	5b                   	pop    %ebx
801017a2:	5e                   	pop    %esi
801017a3:	5f                   	pop    %edi
801017a4:	5d                   	pop    %ebp
801017a5:	c3                   	ret
801017a6:	66 90                	xchg   %ax,%ax
801017a8:	66 90                	xchg   %ax,%ax
801017aa:	66 90                	xchg   %ax,%ax
801017ac:	66 90                	xchg   %ax,%ax
801017ae:	66 90                	xchg   %ax,%ax

801017b0 <exec>:
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
801017bc:	e8 9f 2e 00 00       	call   80104660 <myproc>
801017c1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
801017c7:	e8 74 22 00 00       	call   80103a40 <begin_op>
801017cc:	83 ec 0c             	sub    $0xc,%esp
801017cf:	ff 75 08             	push   0x8(%ebp)
801017d2:	e8 a9 15 00 00       	call   80102d80 <namei>
801017d7:	83 c4 10             	add    $0x10,%esp
801017da:	85 c0                	test   %eax,%eax
801017dc:	0f 84 30 03 00 00    	je     80101b12 <exec+0x362>
801017e2:	83 ec 0c             	sub    $0xc,%esp
801017e5:	89 c7                	mov    %eax,%edi
801017e7:	50                   	push   %eax
801017e8:	e8 b3 0c 00 00       	call   801024a0 <ilock>
801017ed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801017f3:	6a 34                	push   $0x34
801017f5:	6a 00                	push   $0x0
801017f7:	50                   	push   %eax
801017f8:	57                   	push   %edi
801017f9:	e8 b2 0f 00 00       	call   801027b0 <readi>
801017fe:	83 c4 20             	add    $0x20,%esp
80101801:	83 f8 34             	cmp    $0x34,%eax
80101804:	0f 85 01 01 00 00    	jne    8010190b <exec+0x15b>
8010180a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101811:	45 4c 46 
80101814:	0f 85 f1 00 00 00    	jne    8010190b <exec+0x15b>
8010181a:	e8 01 63 00 00       	call   80107b20 <setupkvm>
8010181f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101825:	85 c0                	test   %eax,%eax
80101827:	0f 84 de 00 00 00    	je     8010190b <exec+0x15b>
8010182d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101834:	00 
80101835:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
8010183b:	0f 84 a1 02 00 00    	je     80101ae2 <exec+0x332>
80101841:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101848:	00 00 00 
8010184b:	31 db                	xor    %ebx,%ebx
8010184d:	e9 8c 00 00 00       	jmp    801018de <exec+0x12e>
80101852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101858:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
8010185f:	75 6c                	jne    801018cd <exec+0x11d>
80101861:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80101867:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
8010186d:	0f 82 87 00 00 00    	jb     801018fa <exec+0x14a>
80101873:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101879:	72 7f                	jb     801018fa <exec+0x14a>
8010187b:	83 ec 04             	sub    $0x4,%esp
8010187e:	50                   	push   %eax
8010187f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80101885:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010188b:	e8 c0 60 00 00       	call   80107950 <allocuvm>
80101890:	83 c4 10             	add    $0x10,%esp
80101893:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101899:	85 c0                	test   %eax,%eax
8010189b:	74 5d                	je     801018fa <exec+0x14a>
8010189d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801018a3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801018a8:	75 50                	jne    801018fa <exec+0x14a>
801018aa:	83 ec 0c             	sub    $0xc,%esp
801018ad:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
801018b3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
801018b9:	57                   	push   %edi
801018ba:	50                   	push   %eax
801018bb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801018c1:	e8 ba 5f 00 00       	call   80107880 <loaduvm>
801018c6:	83 c4 20             	add    $0x20,%esp
801018c9:	85 c0                	test   %eax,%eax
801018cb:	78 2d                	js     801018fa <exec+0x14a>
801018cd:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801018d4:	83 c3 01             	add    $0x1,%ebx
801018d7:	83 c6 20             	add    $0x20,%esi
801018da:	39 d8                	cmp    %ebx,%eax
801018dc:	7e 52                	jle    80101930 <exec+0x180>
801018de:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801018e4:	6a 20                	push   $0x20
801018e6:	56                   	push   %esi
801018e7:	50                   	push   %eax
801018e8:	57                   	push   %edi
801018e9:	e8 c2 0e 00 00       	call   801027b0 <readi>
801018ee:	83 c4 10             	add    $0x10,%esp
801018f1:	83 f8 20             	cmp    $0x20,%eax
801018f4:	0f 84 5e ff ff ff    	je     80101858 <exec+0xa8>
801018fa:	83 ec 0c             	sub    $0xc,%esp
801018fd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101903:	e8 98 61 00 00       	call   80107aa0 <freevm>
80101908:	83 c4 10             	add    $0x10,%esp
8010190b:	83 ec 0c             	sub    $0xc,%esp
8010190e:	57                   	push   %edi
8010190f:	e8 1c 0e 00 00       	call   80102730 <iunlockput>
80101914:	e8 97 21 00 00       	call   80103ab0 <end_op>
80101919:	83 c4 10             	add    $0x10,%esp
8010191c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101921:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101924:	5b                   	pop    %ebx
80101925:	5e                   	pop    %esi
80101926:	5f                   	pop    %edi
80101927:	5d                   	pop    %ebp
80101928:	c3                   	ret
80101929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101930:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80101936:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
8010193c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80101942:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
80101948:	83 ec 0c             	sub    $0xc,%esp
8010194b:	57                   	push   %edi
8010194c:	e8 df 0d 00 00       	call   80102730 <iunlockput>
80101951:	e8 5a 21 00 00       	call   80103ab0 <end_op>
80101956:	83 c4 0c             	add    $0xc,%esp
80101959:	53                   	push   %ebx
8010195a:	56                   	push   %esi
8010195b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80101961:	56                   	push   %esi
80101962:	e8 e9 5f 00 00       	call   80107950 <allocuvm>
80101967:	83 c4 10             	add    $0x10,%esp
8010196a:	89 c7                	mov    %eax,%edi
8010196c:	85 c0                	test   %eax,%eax
8010196e:	0f 84 86 00 00 00    	je     801019fa <exec+0x24a>
80101974:	83 ec 08             	sub    $0x8,%esp
80101977:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
8010197d:	89 fb                	mov    %edi,%ebx
8010197f:	50                   	push   %eax
80101980:	56                   	push   %esi
80101981:	31 f6                	xor    %esi,%esi
80101983:	e8 38 62 00 00       	call   80107bc0 <clearpteu>
80101988:	8b 45 0c             	mov    0xc(%ebp),%eax
8010198b:	83 c4 10             	add    $0x10,%esp
8010198e:	8b 10                	mov    (%eax),%edx
80101990:	85 d2                	test   %edx,%edx
80101992:	0f 84 56 01 00 00    	je     80101aee <exec+0x33e>
80101998:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
8010199e:	8b 7d 0c             	mov    0xc(%ebp),%edi
801019a1:	eb 23                	jmp    801019c6 <exec+0x216>
801019a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801019a8:	8d 46 01             	lea    0x1(%esi),%eax
801019ab:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
801019b2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
801019b8:	8b 14 87             	mov    (%edi,%eax,4),%edx
801019bb:	85 d2                	test   %edx,%edx
801019bd:	74 51                	je     80101a10 <exec+0x260>
801019bf:	83 f8 20             	cmp    $0x20,%eax
801019c2:	74 36                	je     801019fa <exec+0x24a>
801019c4:	89 c6                	mov    %eax,%esi
801019c6:	83 ec 0c             	sub    $0xc,%esp
801019c9:	52                   	push   %edx
801019ca:	e8 c1 3b 00 00       	call   80105590 <strlen>
801019cf:	29 c3                	sub    %eax,%ebx
801019d1:	58                   	pop    %eax
801019d2:	ff 34 b7             	push   (%edi,%esi,4)
801019d5:	83 eb 01             	sub    $0x1,%ebx
801019d8:	83 e3 fc             	and    $0xfffffffc,%ebx
801019db:	e8 b0 3b 00 00       	call   80105590 <strlen>
801019e0:	83 c0 01             	add    $0x1,%eax
801019e3:	50                   	push   %eax
801019e4:	ff 34 b7             	push   (%edi,%esi,4)
801019e7:	53                   	push   %ebx
801019e8:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801019ee:	e8 9d 63 00 00       	call   80107d90 <copyout>
801019f3:	83 c4 20             	add    $0x20,%esp
801019f6:	85 c0                	test   %eax,%eax
801019f8:	79 ae                	jns    801019a8 <exec+0x1f8>
801019fa:	83 ec 0c             	sub    $0xc,%esp
801019fd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101a03:	e8 98 60 00 00       	call   80107aa0 <freevm>
80101a08:	83 c4 10             	add    $0x10,%esp
80101a0b:	e9 0c ff ff ff       	jmp    8010191c <exec+0x16c>
80101a10:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
80101a17:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101a1d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101a23:	8d 46 04             	lea    0x4(%esi),%eax
80101a26:	8d 72 0c             	lea    0xc(%edx),%esi
80101a29:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80101a30:	00 00 00 00 
80101a34:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80101a3a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101a41:	ff ff ff 
80101a44:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
80101a4a:	89 d8                	mov    %ebx,%eax
80101a4c:	29 f3                	sub    %esi,%ebx
80101a4e:	29 d0                	sub    %edx,%eax
80101a50:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
80101a56:	56                   	push   %esi
80101a57:	51                   	push   %ecx
80101a58:	53                   	push   %ebx
80101a59:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101a5f:	e8 2c 63 00 00       	call   80107d90 <copyout>
80101a64:	83 c4 10             	add    $0x10,%esp
80101a67:	85 c0                	test   %eax,%eax
80101a69:	78 8f                	js     801019fa <exec+0x24a>
80101a6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6e:	8b 55 08             	mov    0x8(%ebp),%edx
80101a71:	0f b6 00             	movzbl (%eax),%eax
80101a74:	84 c0                	test   %al,%al
80101a76:	74 17                	je     80101a8f <exec+0x2df>
80101a78:	89 d1                	mov    %edx,%ecx
80101a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101a80:	83 c1 01             	add    $0x1,%ecx
80101a83:	3c 2f                	cmp    $0x2f,%al
80101a85:	0f b6 01             	movzbl (%ecx),%eax
80101a88:	0f 44 d1             	cmove  %ecx,%edx
80101a8b:	84 c0                	test   %al,%al
80101a8d:	75 f1                	jne    80101a80 <exec+0x2d0>
80101a8f:	83 ec 04             	sub    $0x4,%esp
80101a92:	6a 10                	push   $0x10
80101a94:	52                   	push   %edx
80101a95:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80101a9b:	8d 46 6c             	lea    0x6c(%esi),%eax
80101a9e:	50                   	push   %eax
80101a9f:	e8 ac 3a 00 00       	call   80105550 <safestrcpy>
80101aa4:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80101aaa:	89 f0                	mov    %esi,%eax
80101aac:	8b 76 04             	mov    0x4(%esi),%esi
80101aaf:	89 38                	mov    %edi,(%eax)
80101ab1:	89 48 04             	mov    %ecx,0x4(%eax)
80101ab4:	89 c1                	mov    %eax,%ecx
80101ab6:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80101abc:	8b 40 18             	mov    0x18(%eax),%eax
80101abf:	89 50 38             	mov    %edx,0x38(%eax)
80101ac2:	8b 41 18             	mov    0x18(%ecx),%eax
80101ac5:	89 58 44             	mov    %ebx,0x44(%eax)
80101ac8:	89 0c 24             	mov    %ecx,(%esp)
80101acb:	e8 20 5c 00 00       	call   801076f0 <switchuvm>
80101ad0:	89 34 24             	mov    %esi,(%esp)
80101ad3:	e8 c8 5f 00 00       	call   80107aa0 <freevm>
80101ad8:	83 c4 10             	add    $0x10,%esp
80101adb:	31 c0                	xor    %eax,%eax
80101add:	e9 3f fe ff ff       	jmp    80101921 <exec+0x171>
80101ae2:	bb 00 20 00 00       	mov    $0x2000,%ebx
80101ae7:	31 f6                	xor    %esi,%esi
80101ae9:	e9 5a fe ff ff       	jmp    80101948 <exec+0x198>
80101aee:	be 10 00 00 00       	mov    $0x10,%esi
80101af3:	ba 04 00 00 00       	mov    $0x4,%edx
80101af8:	b8 03 00 00 00       	mov    $0x3,%eax
80101afd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101b04:	00 00 00 
80101b07:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80101b0d:	e9 17 ff ff ff       	jmp    80101a29 <exec+0x279>
80101b12:	e8 99 1f 00 00       	call   80103ab0 <end_op>
80101b17:	83 ec 0c             	sub    $0xc,%esp
80101b1a:	68 d2 7e 10 80       	push   $0x80107ed2
80101b1f:	e8 1c ed ff ff       	call   80100840 <cprintf>
80101b24:	83 c4 10             	add    $0x10,%esp
80101b27:	e9 f0 fd ff ff       	jmp    8010191c <exec+0x16c>
80101b2c:	66 90                	xchg   %ax,%ax
80101b2e:	66 90                	xchg   %ax,%ax

80101b30 <fileinit>:
80101b30:	55                   	push   %ebp
80101b31:	89 e5                	mov    %esp,%ebp
80101b33:	83 ec 10             	sub    $0x10,%esp
80101b36:	68 de 7e 10 80       	push   $0x80107ede
80101b3b:	68 80 ff 10 80       	push   $0x8010ff80
80101b40:	e8 6b 35 00 00       	call   801050b0 <initlock>
80101b45:	83 c4 10             	add    $0x10,%esp
80101b48:	c9                   	leave
80101b49:	c3                   	ret
80101b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b50 <filealloc>:
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	53                   	push   %ebx
80101b54:	bb b4 ff 10 80       	mov    $0x8010ffb4,%ebx
80101b59:	83 ec 10             	sub    $0x10,%esp
80101b5c:	68 80 ff 10 80       	push   $0x8010ff80
80101b61:	e8 3a 37 00 00       	call   801052a0 <acquire>
80101b66:	83 c4 10             	add    $0x10,%esp
80101b69:	eb 10                	jmp    80101b7b <filealloc+0x2b>
80101b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b70:	83 c3 18             	add    $0x18,%ebx
80101b73:	81 fb 14 09 11 80    	cmp    $0x80110914,%ebx
80101b79:	74 25                	je     80101ba0 <filealloc+0x50>
80101b7b:	8b 43 04             	mov    0x4(%ebx),%eax
80101b7e:	85 c0                	test   %eax,%eax
80101b80:	75 ee                	jne    80101b70 <filealloc+0x20>
80101b82:	83 ec 0c             	sub    $0xc,%esp
80101b85:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80101b8c:	68 80 ff 10 80       	push   $0x8010ff80
80101b91:	e8 aa 36 00 00       	call   80105240 <release>
80101b96:	89 d8                	mov    %ebx,%eax
80101b98:	83 c4 10             	add    $0x10,%esp
80101b9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b9e:	c9                   	leave
80101b9f:	c3                   	ret
80101ba0:	83 ec 0c             	sub    $0xc,%esp
80101ba3:	31 db                	xor    %ebx,%ebx
80101ba5:	68 80 ff 10 80       	push   $0x8010ff80
80101baa:	e8 91 36 00 00       	call   80105240 <release>
80101baf:	89 d8                	mov    %ebx,%eax
80101bb1:	83 c4 10             	add    $0x10,%esp
80101bb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bb7:	c9                   	leave
80101bb8:	c3                   	ret
80101bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101bc0 <filedup>:
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	53                   	push   %ebx
80101bc4:	83 ec 10             	sub    $0x10,%esp
80101bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101bca:	68 80 ff 10 80       	push   $0x8010ff80
80101bcf:	e8 cc 36 00 00       	call   801052a0 <acquire>
80101bd4:	8b 43 04             	mov    0x4(%ebx),%eax
80101bd7:	83 c4 10             	add    $0x10,%esp
80101bda:	85 c0                	test   %eax,%eax
80101bdc:	7e 1a                	jle    80101bf8 <filedup+0x38>
80101bde:	83 c0 01             	add    $0x1,%eax
80101be1:	83 ec 0c             	sub    $0xc,%esp
80101be4:	89 43 04             	mov    %eax,0x4(%ebx)
80101be7:	68 80 ff 10 80       	push   $0x8010ff80
80101bec:	e8 4f 36 00 00       	call   80105240 <release>
80101bf1:	89 d8                	mov    %ebx,%eax
80101bf3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bf6:	c9                   	leave
80101bf7:	c3                   	ret
80101bf8:	83 ec 0c             	sub    $0xc,%esp
80101bfb:	68 e5 7e 10 80       	push   $0x80107ee5
80101c00:	e8 8b ee ff ff       	call   80100a90 <panic>
80101c05:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c0c:	00 
80101c0d:	8d 76 00             	lea    0x0(%esi),%esi

80101c10 <fileclose>:
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	57                   	push   %edi
80101c14:	56                   	push   %esi
80101c15:	53                   	push   %ebx
80101c16:	83 ec 28             	sub    $0x28,%esp
80101c19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c1c:	68 80 ff 10 80       	push   $0x8010ff80
80101c21:	e8 7a 36 00 00       	call   801052a0 <acquire>
80101c26:	8b 53 04             	mov    0x4(%ebx),%edx
80101c29:	83 c4 10             	add    $0x10,%esp
80101c2c:	85 d2                	test   %edx,%edx
80101c2e:	0f 8e a5 00 00 00    	jle    80101cd9 <fileclose+0xc9>
80101c34:	83 ea 01             	sub    $0x1,%edx
80101c37:	89 53 04             	mov    %edx,0x4(%ebx)
80101c3a:	75 44                	jne    80101c80 <fileclose+0x70>
80101c3c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80101c40:	83 ec 0c             	sub    $0xc,%esp
80101c43:	8b 3b                	mov    (%ebx),%edi
80101c45:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101c4b:	8b 73 0c             	mov    0xc(%ebx),%esi
80101c4e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101c51:	8b 43 10             	mov    0x10(%ebx),%eax
80101c54:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101c57:	68 80 ff 10 80       	push   $0x8010ff80
80101c5c:	e8 df 35 00 00       	call   80105240 <release>
80101c61:	83 c4 10             	add    $0x10,%esp
80101c64:	83 ff 01             	cmp    $0x1,%edi
80101c67:	74 57                	je     80101cc0 <fileclose+0xb0>
80101c69:	83 ff 02             	cmp    $0x2,%edi
80101c6c:	74 2a                	je     80101c98 <fileclose+0x88>
80101c6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c71:	5b                   	pop    %ebx
80101c72:	5e                   	pop    %esi
80101c73:	5f                   	pop    %edi
80101c74:	5d                   	pop    %ebp
80101c75:	c3                   	ret
80101c76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c7d:	00 
80101c7e:	66 90                	xchg   %ax,%ax
80101c80:	c7 45 08 80 ff 10 80 	movl   $0x8010ff80,0x8(%ebp)
80101c87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c8a:	5b                   	pop    %ebx
80101c8b:	5e                   	pop    %esi
80101c8c:	5f                   	pop    %edi
80101c8d:	5d                   	pop    %ebp
80101c8e:	e9 ad 35 00 00       	jmp    80105240 <release>
80101c93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c98:	e8 a3 1d 00 00       	call   80103a40 <begin_op>
80101c9d:	83 ec 0c             	sub    $0xc,%esp
80101ca0:	ff 75 e0             	push   -0x20(%ebp)
80101ca3:	e8 28 09 00 00       	call   801025d0 <iput>
80101ca8:	83 c4 10             	add    $0x10,%esp
80101cab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cae:	5b                   	pop    %ebx
80101caf:	5e                   	pop    %esi
80101cb0:	5f                   	pop    %edi
80101cb1:	5d                   	pop    %ebp
80101cb2:	e9 f9 1d 00 00       	jmp    80103ab0 <end_op>
80101cb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101cbe:	00 
80101cbf:	90                   	nop
80101cc0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101cc4:	83 ec 08             	sub    $0x8,%esp
80101cc7:	53                   	push   %ebx
80101cc8:	56                   	push   %esi
80101cc9:	e8 32 25 00 00       	call   80104200 <pipeclose>
80101cce:	83 c4 10             	add    $0x10,%esp
80101cd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cd4:	5b                   	pop    %ebx
80101cd5:	5e                   	pop    %esi
80101cd6:	5f                   	pop    %edi
80101cd7:	5d                   	pop    %ebp
80101cd8:	c3                   	ret
80101cd9:	83 ec 0c             	sub    $0xc,%esp
80101cdc:	68 ed 7e 10 80       	push   $0x80107eed
80101ce1:	e8 aa ed ff ff       	call   80100a90 <panic>
80101ce6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ced:	00 
80101cee:	66 90                	xchg   %ax,%ax

80101cf0 <filestat>:
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	53                   	push   %ebx
80101cf4:	83 ec 04             	sub    $0x4,%esp
80101cf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101cfa:	83 3b 02             	cmpl   $0x2,(%ebx)
80101cfd:	75 31                	jne    80101d30 <filestat+0x40>
80101cff:	83 ec 0c             	sub    $0xc,%esp
80101d02:	ff 73 10             	push   0x10(%ebx)
80101d05:	e8 96 07 00 00       	call   801024a0 <ilock>
80101d0a:	58                   	pop    %eax
80101d0b:	5a                   	pop    %edx
80101d0c:	ff 75 0c             	push   0xc(%ebp)
80101d0f:	ff 73 10             	push   0x10(%ebx)
80101d12:	e8 69 0a 00 00       	call   80102780 <stati>
80101d17:	59                   	pop    %ecx
80101d18:	ff 73 10             	push   0x10(%ebx)
80101d1b:	e8 60 08 00 00       	call   80102580 <iunlock>
80101d20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d23:	83 c4 10             	add    $0x10,%esp
80101d26:	31 c0                	xor    %eax,%eax
80101d28:	c9                   	leave
80101d29:	c3                   	ret
80101d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d38:	c9                   	leave
80101d39:	c3                   	ret
80101d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d40 <fileread>:
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	56                   	push   %esi
80101d45:	53                   	push   %ebx
80101d46:	83 ec 0c             	sub    $0xc,%esp
80101d49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d4f:	8b 7d 10             	mov    0x10(%ebp),%edi
80101d52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101d56:	74 60                	je     80101db8 <fileread+0x78>
80101d58:	8b 03                	mov    (%ebx),%eax
80101d5a:	83 f8 01             	cmp    $0x1,%eax
80101d5d:	74 41                	je     80101da0 <fileread+0x60>
80101d5f:	83 f8 02             	cmp    $0x2,%eax
80101d62:	75 5b                	jne    80101dbf <fileread+0x7f>
80101d64:	83 ec 0c             	sub    $0xc,%esp
80101d67:	ff 73 10             	push   0x10(%ebx)
80101d6a:	e8 31 07 00 00       	call   801024a0 <ilock>
80101d6f:	57                   	push   %edi
80101d70:	ff 73 14             	push   0x14(%ebx)
80101d73:	56                   	push   %esi
80101d74:	ff 73 10             	push   0x10(%ebx)
80101d77:	e8 34 0a 00 00       	call   801027b0 <readi>
80101d7c:	83 c4 20             	add    $0x20,%esp
80101d7f:	89 c6                	mov    %eax,%esi
80101d81:	85 c0                	test   %eax,%eax
80101d83:	7e 03                	jle    80101d88 <fileread+0x48>
80101d85:	01 43 14             	add    %eax,0x14(%ebx)
80101d88:	83 ec 0c             	sub    $0xc,%esp
80101d8b:	ff 73 10             	push   0x10(%ebx)
80101d8e:	e8 ed 07 00 00       	call   80102580 <iunlock>
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d99:	89 f0                	mov    %esi,%eax
80101d9b:	5b                   	pop    %ebx
80101d9c:	5e                   	pop    %esi
80101d9d:	5f                   	pop    %edi
80101d9e:	5d                   	pop    %ebp
80101d9f:	c3                   	ret
80101da0:	8b 43 0c             	mov    0xc(%ebx),%eax
80101da3:	89 45 08             	mov    %eax,0x8(%ebp)
80101da6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101da9:	5b                   	pop    %ebx
80101daa:	5e                   	pop    %esi
80101dab:	5f                   	pop    %edi
80101dac:	5d                   	pop    %ebp
80101dad:	e9 0e 26 00 00       	jmp    801043c0 <piperead>
80101db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101db8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101dbd:	eb d7                	jmp    80101d96 <fileread+0x56>
80101dbf:	83 ec 0c             	sub    $0xc,%esp
80101dc2:	68 f7 7e 10 80       	push   $0x80107ef7
80101dc7:	e8 c4 ec ff ff       	call   80100a90 <panic>
80101dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101dd0 <filewrite>:
80101dd0:	55                   	push   %ebp
80101dd1:	89 e5                	mov    %esp,%ebp
80101dd3:	57                   	push   %edi
80101dd4:	56                   	push   %esi
80101dd5:	53                   	push   %ebx
80101dd6:	83 ec 1c             	sub    $0x1c,%esp
80101dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ddc:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101ddf:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101de2:	8b 45 10             	mov    0x10(%ebp),%eax
80101de5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80101de9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101dec:	0f 84 bb 00 00 00    	je     80101ead <filewrite+0xdd>
80101df2:	8b 03                	mov    (%ebx),%eax
80101df4:	83 f8 01             	cmp    $0x1,%eax
80101df7:	0f 84 bf 00 00 00    	je     80101ebc <filewrite+0xec>
80101dfd:	83 f8 02             	cmp    $0x2,%eax
80101e00:	0f 85 c8 00 00 00    	jne    80101ece <filewrite+0xfe>
80101e06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e09:	31 f6                	xor    %esi,%esi
80101e0b:	85 c0                	test   %eax,%eax
80101e0d:	7f 30                	jg     80101e3f <filewrite+0x6f>
80101e0f:	e9 94 00 00 00       	jmp    80101ea8 <filewrite+0xd8>
80101e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e18:	01 43 14             	add    %eax,0x14(%ebx)
80101e1b:	83 ec 0c             	sub    $0xc,%esp
80101e1e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e21:	ff 73 10             	push   0x10(%ebx)
80101e24:	e8 57 07 00 00       	call   80102580 <iunlock>
80101e29:	e8 82 1c 00 00       	call   80103ab0 <end_op>
80101e2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e31:	83 c4 10             	add    $0x10,%esp
80101e34:	39 c7                	cmp    %eax,%edi
80101e36:	75 5c                	jne    80101e94 <filewrite+0xc4>
80101e38:	01 fe                	add    %edi,%esi
80101e3a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101e3d:	7e 69                	jle    80101ea8 <filewrite+0xd8>
80101e3f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e42:	b8 00 06 00 00       	mov    $0x600,%eax
80101e47:	29 f7                	sub    %esi,%edi
80101e49:	39 c7                	cmp    %eax,%edi
80101e4b:	0f 4f f8             	cmovg  %eax,%edi
80101e4e:	e8 ed 1b 00 00       	call   80103a40 <begin_op>
80101e53:	83 ec 0c             	sub    $0xc,%esp
80101e56:	ff 73 10             	push   0x10(%ebx)
80101e59:	e8 42 06 00 00       	call   801024a0 <ilock>
80101e5e:	57                   	push   %edi
80101e5f:	ff 73 14             	push   0x14(%ebx)
80101e62:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e65:	01 f0                	add    %esi,%eax
80101e67:	50                   	push   %eax
80101e68:	ff 73 10             	push   0x10(%ebx)
80101e6b:	e8 40 0a 00 00       	call   801028b0 <writei>
80101e70:	83 c4 20             	add    $0x20,%esp
80101e73:	85 c0                	test   %eax,%eax
80101e75:	7f a1                	jg     80101e18 <filewrite+0x48>
80101e77:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e7a:	83 ec 0c             	sub    $0xc,%esp
80101e7d:	ff 73 10             	push   0x10(%ebx)
80101e80:	e8 fb 06 00 00       	call   80102580 <iunlock>
80101e85:	e8 26 1c 00 00       	call   80103ab0 <end_op>
80101e8a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e8d:	83 c4 10             	add    $0x10,%esp
80101e90:	85 c0                	test   %eax,%eax
80101e92:	75 14                	jne    80101ea8 <filewrite+0xd8>
80101e94:	83 ec 0c             	sub    $0xc,%esp
80101e97:	68 00 7f 10 80       	push   $0x80107f00
80101e9c:	e8 ef eb ff ff       	call   80100a90 <panic>
80101ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ea8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101eab:	74 05                	je     80101eb2 <filewrite+0xe2>
80101ead:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101eb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eb5:	89 f0                	mov    %esi,%eax
80101eb7:	5b                   	pop    %ebx
80101eb8:	5e                   	pop    %esi
80101eb9:	5f                   	pop    %edi
80101eba:	5d                   	pop    %ebp
80101ebb:	c3                   	ret
80101ebc:	8b 43 0c             	mov    0xc(%ebx),%eax
80101ebf:	89 45 08             	mov    %eax,0x8(%ebp)
80101ec2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec5:	5b                   	pop    %ebx
80101ec6:	5e                   	pop    %esi
80101ec7:	5f                   	pop    %edi
80101ec8:	5d                   	pop    %ebp
80101ec9:	e9 d2 23 00 00       	jmp    801042a0 <pipewrite>
80101ece:	83 ec 0c             	sub    $0xc,%esp
80101ed1:	68 06 7f 10 80       	push   $0x80107f06
80101ed6:	e8 b5 eb ff ff       	call   80100a90 <panic>
80101edb:	66 90                	xchg   %ax,%ax
80101edd:	66 90                	xchg   %ax,%ax
80101edf:	90                   	nop

80101ee0 <balloc>:
80101ee0:	55                   	push   %ebp
80101ee1:	89 e5                	mov    %esp,%ebp
80101ee3:	57                   	push   %edi
80101ee4:	56                   	push   %esi
80101ee5:	53                   	push   %ebx
80101ee6:	83 ec 1c             	sub    $0x1c,%esp
80101ee9:	8b 0d d4 25 11 80    	mov    0x801125d4,%ecx
80101eef:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101ef2:	85 c9                	test   %ecx,%ecx
80101ef4:	0f 84 8c 00 00 00    	je     80101f86 <balloc+0xa6>
80101efa:	31 ff                	xor    %edi,%edi
80101efc:	89 f8                	mov    %edi,%eax
80101efe:	83 ec 08             	sub    $0x8,%esp
80101f01:	89 fe                	mov    %edi,%esi
80101f03:	c1 f8 0c             	sar    $0xc,%eax
80101f06:	03 05 ec 25 11 80    	add    0x801125ec,%eax
80101f0c:	50                   	push   %eax
80101f0d:	ff 75 dc             	push   -0x24(%ebp)
80101f10:	e8 bb e1 ff ff       	call   801000d0 <bread>
80101f15:	83 c4 10             	add    $0x10,%esp
80101f18:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101f1b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101f1e:	a1 d4 25 11 80       	mov    0x801125d4,%eax
80101f23:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101f26:	31 c0                	xor    %eax,%eax
80101f28:	eb 32                	jmp    80101f5c <balloc+0x7c>
80101f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f30:	89 c1                	mov    %eax,%ecx
80101f32:	bb 01 00 00 00       	mov    $0x1,%ebx
80101f37:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101f3a:	83 e1 07             	and    $0x7,%ecx
80101f3d:	d3 e3                	shl    %cl,%ebx
80101f3f:	89 c1                	mov    %eax,%ecx
80101f41:	c1 f9 03             	sar    $0x3,%ecx
80101f44:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101f49:	89 fa                	mov    %edi,%edx
80101f4b:	85 df                	test   %ebx,%edi
80101f4d:	74 49                	je     80101f98 <balloc+0xb8>
80101f4f:	83 c0 01             	add    $0x1,%eax
80101f52:	83 c6 01             	add    $0x1,%esi
80101f55:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101f5a:	74 07                	je     80101f63 <balloc+0x83>
80101f5c:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f5f:	39 d6                	cmp    %edx,%esi
80101f61:	72 cd                	jb     80101f30 <balloc+0x50>
80101f63:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101f66:	83 ec 0c             	sub    $0xc,%esp
80101f69:	ff 75 e4             	push   -0x1c(%ebp)
80101f6c:	81 c7 00 10 00 00    	add    $0x1000,%edi
80101f72:	e8 79 e2 ff ff       	call   801001f0 <brelse>
80101f77:	83 c4 10             	add    $0x10,%esp
80101f7a:	3b 3d d4 25 11 80    	cmp    0x801125d4,%edi
80101f80:	0f 82 76 ff ff ff    	jb     80101efc <balloc+0x1c>
80101f86:	83 ec 0c             	sub    $0xc,%esp
80101f89:	68 10 7f 10 80       	push   $0x80107f10
80101f8e:	e8 fd ea ff ff       	call   80100a90 <panic>
80101f93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f98:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101f9b:	83 ec 0c             	sub    $0xc,%esp
80101f9e:	09 da                	or     %ebx,%edx
80101fa0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
80101fa4:	57                   	push   %edi
80101fa5:	e8 76 1c 00 00       	call   80103c20 <log_write>
80101faa:	89 3c 24             	mov    %edi,(%esp)
80101fad:	e8 3e e2 ff ff       	call   801001f0 <brelse>
80101fb2:	58                   	pop    %eax
80101fb3:	5a                   	pop    %edx
80101fb4:	56                   	push   %esi
80101fb5:	ff 75 dc             	push   -0x24(%ebp)
80101fb8:	e8 13 e1 ff ff       	call   801000d0 <bread>
80101fbd:	83 c4 0c             	add    $0xc,%esp
80101fc0:	89 c3                	mov    %eax,%ebx
80101fc2:	8d 40 5c             	lea    0x5c(%eax),%eax
80101fc5:	68 00 02 00 00       	push   $0x200
80101fca:	6a 00                	push   $0x0
80101fcc:	50                   	push   %eax
80101fcd:	e8 ce 33 00 00       	call   801053a0 <memset>
80101fd2:	89 1c 24             	mov    %ebx,(%esp)
80101fd5:	e8 46 1c 00 00       	call   80103c20 <log_write>
80101fda:	89 1c 24             	mov    %ebx,(%esp)
80101fdd:	e8 0e e2 ff ff       	call   801001f0 <brelse>
80101fe2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe5:	89 f0                	mov    %esi,%eax
80101fe7:	5b                   	pop    %ebx
80101fe8:	5e                   	pop    %esi
80101fe9:	5f                   	pop    %edi
80101fea:	5d                   	pop    %ebp
80101feb:	c3                   	ret
80101fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ff0 <iget>:
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	31 ff                	xor    %edi,%edi
80101ff6:	56                   	push   %esi
80101ff7:	89 c6                	mov    %eax,%esi
80101ff9:	53                   	push   %ebx
80101ffa:	bb b4 09 11 80       	mov    $0x801109b4,%ebx
80101fff:	83 ec 28             	sub    $0x28,%esp
80102002:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102005:	68 80 09 11 80       	push   $0x80110980
8010200a:	e8 91 32 00 00       	call   801052a0 <acquire>
8010200f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102012:	83 c4 10             	add    $0x10,%esp
80102015:	eb 1b                	jmp    80102032 <iget+0x42>
80102017:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010201e:	00 
8010201f:	90                   	nop
80102020:	39 33                	cmp    %esi,(%ebx)
80102022:	74 6c                	je     80102090 <iget+0xa0>
80102024:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010202a:	81 fb d4 25 11 80    	cmp    $0x801125d4,%ebx
80102030:	74 26                	je     80102058 <iget+0x68>
80102032:	8b 43 08             	mov    0x8(%ebx),%eax
80102035:	85 c0                	test   %eax,%eax
80102037:	7f e7                	jg     80102020 <iget+0x30>
80102039:	85 ff                	test   %edi,%edi
8010203b:	75 e7                	jne    80102024 <iget+0x34>
8010203d:	85 c0                	test   %eax,%eax
8010203f:	75 76                	jne    801020b7 <iget+0xc7>
80102041:	89 df                	mov    %ebx,%edi
80102043:	81 c3 90 00 00 00    	add    $0x90,%ebx
80102049:	81 fb d4 25 11 80    	cmp    $0x801125d4,%ebx
8010204f:	75 e1                	jne    80102032 <iget+0x42>
80102051:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102058:	85 ff                	test   %edi,%edi
8010205a:	74 79                	je     801020d5 <iget+0xe5>
8010205c:	83 ec 0c             	sub    $0xc,%esp
8010205f:	89 37                	mov    %esi,(%edi)
80102061:	89 57 04             	mov    %edx,0x4(%edi)
80102064:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
8010206b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
80102072:	68 80 09 11 80       	push   $0x80110980
80102077:	e8 c4 31 00 00       	call   80105240 <release>
8010207c:	83 c4 10             	add    $0x10,%esp
8010207f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102082:	89 f8                	mov    %edi,%eax
80102084:	5b                   	pop    %ebx
80102085:	5e                   	pop    %esi
80102086:	5f                   	pop    %edi
80102087:	5d                   	pop    %ebp
80102088:	c3                   	ret
80102089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102090:	39 53 04             	cmp    %edx,0x4(%ebx)
80102093:	75 8f                	jne    80102024 <iget+0x34>
80102095:	83 c0 01             	add    $0x1,%eax
80102098:	83 ec 0c             	sub    $0xc,%esp
8010209b:	89 df                	mov    %ebx,%edi
8010209d:	89 43 08             	mov    %eax,0x8(%ebx)
801020a0:	68 80 09 11 80       	push   $0x80110980
801020a5:	e8 96 31 00 00       	call   80105240 <release>
801020aa:	83 c4 10             	add    $0x10,%esp
801020ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b0:	89 f8                	mov    %edi,%eax
801020b2:	5b                   	pop    %ebx
801020b3:	5e                   	pop    %esi
801020b4:	5f                   	pop    %edi
801020b5:	5d                   	pop    %ebp
801020b6:	c3                   	ret
801020b7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801020bd:	81 fb d4 25 11 80    	cmp    $0x801125d4,%ebx
801020c3:	74 10                	je     801020d5 <iget+0xe5>
801020c5:	8b 43 08             	mov    0x8(%ebx),%eax
801020c8:	85 c0                	test   %eax,%eax
801020ca:	0f 8f 50 ff ff ff    	jg     80102020 <iget+0x30>
801020d0:	e9 68 ff ff ff       	jmp    8010203d <iget+0x4d>
801020d5:	83 ec 0c             	sub    $0xc,%esp
801020d8:	68 26 7f 10 80       	push   $0x80107f26
801020dd:	e8 ae e9 ff ff       	call   80100a90 <panic>
801020e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020e9:	00 
801020ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801020f0 <bfree>:
801020f0:	55                   	push   %ebp
801020f1:	89 c1                	mov    %eax,%ecx
801020f3:	89 d0                	mov    %edx,%eax
801020f5:	c1 e8 0c             	shr    $0xc,%eax
801020f8:	89 e5                	mov    %esp,%ebp
801020fa:	56                   	push   %esi
801020fb:	53                   	push   %ebx
801020fc:	03 05 ec 25 11 80    	add    0x801125ec,%eax
80102102:	89 d3                	mov    %edx,%ebx
80102104:	83 ec 08             	sub    $0x8,%esp
80102107:	50                   	push   %eax
80102108:	51                   	push   %ecx
80102109:	e8 c2 df ff ff       	call   801000d0 <bread>
8010210e:	89 d9                	mov    %ebx,%ecx
80102110:	c1 fb 03             	sar    $0x3,%ebx
80102113:	83 c4 10             	add    $0x10,%esp
80102116:	89 c6                	mov    %eax,%esi
80102118:	83 e1 07             	and    $0x7,%ecx
8010211b:	b8 01 00 00 00       	mov    $0x1,%eax
80102120:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80102126:	d3 e0                	shl    %cl,%eax
80102128:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010212d:	85 c1                	test   %eax,%ecx
8010212f:	74 23                	je     80102154 <bfree+0x64>
80102131:	f7 d0                	not    %eax
80102133:	83 ec 0c             	sub    $0xc,%esp
80102136:	21 c8                	and    %ecx,%eax
80102138:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
8010213c:	56                   	push   %esi
8010213d:	e8 de 1a 00 00       	call   80103c20 <log_write>
80102142:	89 34 24             	mov    %esi,(%esp)
80102145:	e8 a6 e0 ff ff       	call   801001f0 <brelse>
8010214a:	83 c4 10             	add    $0x10,%esp
8010214d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102150:	5b                   	pop    %ebx
80102151:	5e                   	pop    %esi
80102152:	5d                   	pop    %ebp
80102153:	c3                   	ret
80102154:	83 ec 0c             	sub    $0xc,%esp
80102157:	68 36 7f 10 80       	push   $0x80107f36
8010215c:	e8 2f e9 ff ff       	call   80100a90 <panic>
80102161:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102168:	00 
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102170 <bmap>:
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	57                   	push   %edi
80102174:	56                   	push   %esi
80102175:	89 c6                	mov    %eax,%esi
80102177:	53                   	push   %ebx
80102178:	83 ec 1c             	sub    $0x1c,%esp
8010217b:	83 fa 0b             	cmp    $0xb,%edx
8010217e:	0f 86 8c 00 00 00    	jbe    80102210 <bmap+0xa0>
80102184:	8d 5a f4             	lea    -0xc(%edx),%ebx
80102187:	83 fb 7f             	cmp    $0x7f,%ebx
8010218a:	0f 87 a2 00 00 00    	ja     80102232 <bmap+0xc2>
80102190:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102196:	85 c0                	test   %eax,%eax
80102198:	74 5e                	je     801021f8 <bmap+0x88>
8010219a:	83 ec 08             	sub    $0x8,%esp
8010219d:	50                   	push   %eax
8010219e:	ff 36                	push   (%esi)
801021a0:	e8 2b df ff ff       	call   801000d0 <bread>
801021a5:	83 c4 10             	add    $0x10,%esp
801021a8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
801021ac:	89 c2                	mov    %eax,%edx
801021ae:	8b 3b                	mov    (%ebx),%edi
801021b0:	85 ff                	test   %edi,%edi
801021b2:	74 1c                	je     801021d0 <bmap+0x60>
801021b4:	83 ec 0c             	sub    $0xc,%esp
801021b7:	52                   	push   %edx
801021b8:	e8 33 e0 ff ff       	call   801001f0 <brelse>
801021bd:	83 c4 10             	add    $0x10,%esp
801021c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021c3:	89 f8                	mov    %edi,%eax
801021c5:	5b                   	pop    %ebx
801021c6:	5e                   	pop    %esi
801021c7:	5f                   	pop    %edi
801021c8:	5d                   	pop    %ebp
801021c9:	c3                   	ret
801021ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801021d3:	8b 06                	mov    (%esi),%eax
801021d5:	e8 06 fd ff ff       	call   80101ee0 <balloc>
801021da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801021dd:	83 ec 0c             	sub    $0xc,%esp
801021e0:	89 03                	mov    %eax,(%ebx)
801021e2:	89 c7                	mov    %eax,%edi
801021e4:	52                   	push   %edx
801021e5:	e8 36 1a 00 00       	call   80103c20 <log_write>
801021ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801021ed:	83 c4 10             	add    $0x10,%esp
801021f0:	eb c2                	jmp    801021b4 <bmap+0x44>
801021f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021f8:	8b 06                	mov    (%esi),%eax
801021fa:	e8 e1 fc ff ff       	call   80101ee0 <balloc>
801021ff:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102205:	eb 93                	jmp    8010219a <bmap+0x2a>
80102207:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010220e:	00 
8010220f:	90                   	nop
80102210:	8d 5a 14             	lea    0x14(%edx),%ebx
80102213:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80102217:	85 ff                	test   %edi,%edi
80102219:	75 a5                	jne    801021c0 <bmap+0x50>
8010221b:	8b 00                	mov    (%eax),%eax
8010221d:	e8 be fc ff ff       	call   80101ee0 <balloc>
80102222:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102226:	89 c7                	mov    %eax,%edi
80102228:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010222b:	5b                   	pop    %ebx
8010222c:	89 f8                	mov    %edi,%eax
8010222e:	5e                   	pop    %esi
8010222f:	5f                   	pop    %edi
80102230:	5d                   	pop    %ebp
80102231:	c3                   	ret
80102232:	83 ec 0c             	sub    $0xc,%esp
80102235:	68 49 7f 10 80       	push   $0x80107f49
8010223a:	e8 51 e8 ff ff       	call   80100a90 <panic>
8010223f:	90                   	nop

80102240 <readsb>:
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	56                   	push   %esi
80102244:	53                   	push   %ebx
80102245:	8b 75 0c             	mov    0xc(%ebp),%esi
80102248:	83 ec 08             	sub    $0x8,%esp
8010224b:	6a 01                	push   $0x1
8010224d:	ff 75 08             	push   0x8(%ebp)
80102250:	e8 7b de ff ff       	call   801000d0 <bread>
80102255:	83 c4 0c             	add    $0xc,%esp
80102258:	89 c3                	mov    %eax,%ebx
8010225a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010225d:	6a 1c                	push   $0x1c
8010225f:	50                   	push   %eax
80102260:	56                   	push   %esi
80102261:	e8 ca 31 00 00       	call   80105430 <memmove>
80102266:	83 c4 10             	add    $0x10,%esp
80102269:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010226c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010226f:	5b                   	pop    %ebx
80102270:	5e                   	pop    %esi
80102271:	5d                   	pop    %ebp
80102272:	e9 79 df ff ff       	jmp    801001f0 <brelse>
80102277:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010227e:	00 
8010227f:	90                   	nop

80102280 <iinit>:
80102280:	55                   	push   %ebp
80102281:	89 e5                	mov    %esp,%ebp
80102283:	53                   	push   %ebx
80102284:	bb c0 09 11 80       	mov    $0x801109c0,%ebx
80102289:	83 ec 0c             	sub    $0xc,%esp
8010228c:	68 5c 7f 10 80       	push   $0x80107f5c
80102291:	68 80 09 11 80       	push   $0x80110980
80102296:	e8 15 2e 00 00       	call   801050b0 <initlock>
8010229b:	83 c4 10             	add    $0x10,%esp
8010229e:	66 90                	xchg   %ax,%ax
801022a0:	83 ec 08             	sub    $0x8,%esp
801022a3:	68 63 7f 10 80       	push   $0x80107f63
801022a8:	53                   	push   %ebx
801022a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801022af:	e8 cc 2c 00 00       	call   80104f80 <initsleeplock>
801022b4:	83 c4 10             	add    $0x10,%esp
801022b7:	81 fb e0 25 11 80    	cmp    $0x801125e0,%ebx
801022bd:	75 e1                	jne    801022a0 <iinit+0x20>
801022bf:	83 ec 08             	sub    $0x8,%esp
801022c2:	6a 01                	push   $0x1
801022c4:	ff 75 08             	push   0x8(%ebp)
801022c7:	e8 04 de ff ff       	call   801000d0 <bread>
801022cc:	83 c4 0c             	add    $0xc,%esp
801022cf:	89 c3                	mov    %eax,%ebx
801022d1:	8d 40 5c             	lea    0x5c(%eax),%eax
801022d4:	6a 1c                	push   $0x1c
801022d6:	50                   	push   %eax
801022d7:	68 d4 25 11 80       	push   $0x801125d4
801022dc:	e8 4f 31 00 00       	call   80105430 <memmove>
801022e1:	89 1c 24             	mov    %ebx,(%esp)
801022e4:	e8 07 df ff ff       	call   801001f0 <brelse>
801022e9:	ff 35 ec 25 11 80    	push   0x801125ec
801022ef:	ff 35 e8 25 11 80    	push   0x801125e8
801022f5:	ff 35 e4 25 11 80    	push   0x801125e4
801022fb:	ff 35 e0 25 11 80    	push   0x801125e0
80102301:	ff 35 dc 25 11 80    	push   0x801125dc
80102307:	ff 35 d8 25 11 80    	push   0x801125d8
8010230d:	ff 35 d4 25 11 80    	push   0x801125d4
80102313:	68 e4 83 10 80       	push   $0x801083e4
80102318:	e8 23 e5 ff ff       	call   80100840 <cprintf>
8010231d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102320:	83 c4 30             	add    $0x30,%esp
80102323:	c9                   	leave
80102324:	c3                   	ret
80102325:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010232c:	00 
8010232d:	8d 76 00             	lea    0x0(%esi),%esi

80102330 <ialloc>:
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	57                   	push   %edi
80102334:	56                   	push   %esi
80102335:	53                   	push   %ebx
80102336:	83 ec 1c             	sub    $0x1c,%esp
80102339:	8b 45 0c             	mov    0xc(%ebp),%eax
8010233c:	83 3d dc 25 11 80 01 	cmpl   $0x1,0x801125dc
80102343:	8b 75 08             	mov    0x8(%ebp),%esi
80102346:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102349:	0f 86 91 00 00 00    	jbe    801023e0 <ialloc+0xb0>
8010234f:	bf 01 00 00 00       	mov    $0x1,%edi
80102354:	eb 21                	jmp    80102377 <ialloc+0x47>
80102356:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010235d:	00 
8010235e:	66 90                	xchg   %ax,%ax
80102360:	83 ec 0c             	sub    $0xc,%esp
80102363:	83 c7 01             	add    $0x1,%edi
80102366:	53                   	push   %ebx
80102367:	e8 84 de ff ff       	call   801001f0 <brelse>
8010236c:	83 c4 10             	add    $0x10,%esp
8010236f:	3b 3d dc 25 11 80    	cmp    0x801125dc,%edi
80102375:	73 69                	jae    801023e0 <ialloc+0xb0>
80102377:	89 f8                	mov    %edi,%eax
80102379:	83 ec 08             	sub    $0x8,%esp
8010237c:	c1 e8 03             	shr    $0x3,%eax
8010237f:	03 05 e8 25 11 80    	add    0x801125e8,%eax
80102385:	50                   	push   %eax
80102386:	56                   	push   %esi
80102387:	e8 44 dd ff ff       	call   801000d0 <bread>
8010238c:	83 c4 10             	add    $0x10,%esp
8010238f:	89 c3                	mov    %eax,%ebx
80102391:	89 f8                	mov    %edi,%eax
80102393:	83 e0 07             	and    $0x7,%eax
80102396:	c1 e0 06             	shl    $0x6,%eax
80102399:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
8010239d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801023a1:	75 bd                	jne    80102360 <ialloc+0x30>
801023a3:	83 ec 04             	sub    $0x4,%esp
801023a6:	6a 40                	push   $0x40
801023a8:	6a 00                	push   $0x0
801023aa:	51                   	push   %ecx
801023ab:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801023ae:	e8 ed 2f 00 00       	call   801053a0 <memset>
801023b3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801023b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801023ba:	66 89 01             	mov    %ax,(%ecx)
801023bd:	89 1c 24             	mov    %ebx,(%esp)
801023c0:	e8 5b 18 00 00       	call   80103c20 <log_write>
801023c5:	89 1c 24             	mov    %ebx,(%esp)
801023c8:	e8 23 de ff ff       	call   801001f0 <brelse>
801023cd:	83 c4 10             	add    $0x10,%esp
801023d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023d3:	89 fa                	mov    %edi,%edx
801023d5:	5b                   	pop    %ebx
801023d6:	89 f0                	mov    %esi,%eax
801023d8:	5e                   	pop    %esi
801023d9:	5f                   	pop    %edi
801023da:	5d                   	pop    %ebp
801023db:	e9 10 fc ff ff       	jmp    80101ff0 <iget>
801023e0:	83 ec 0c             	sub    $0xc,%esp
801023e3:	68 69 7f 10 80       	push   $0x80107f69
801023e8:	e8 a3 e6 ff ff       	call   80100a90 <panic>
801023ed:	8d 76 00             	lea    0x0(%esi),%esi

801023f0 <iupdate>:
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	56                   	push   %esi
801023f4:	53                   	push   %ebx
801023f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801023f8:	8b 43 04             	mov    0x4(%ebx),%eax
801023fb:	83 c3 5c             	add    $0x5c,%ebx
801023fe:	83 ec 08             	sub    $0x8,%esp
80102401:	c1 e8 03             	shr    $0x3,%eax
80102404:	03 05 e8 25 11 80    	add    0x801125e8,%eax
8010240a:	50                   	push   %eax
8010240b:	ff 73 a4             	push   -0x5c(%ebx)
8010240e:	e8 bd dc ff ff       	call   801000d0 <bread>
80102413:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
80102417:	83 c4 0c             	add    $0xc,%esp
8010241a:	89 c6                	mov    %eax,%esi
8010241c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010241f:	83 e0 07             	and    $0x7,%eax
80102422:	c1 e0 06             	shl    $0x6,%eax
80102425:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80102429:	66 89 10             	mov    %dx,(%eax)
8010242c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
80102430:	83 c0 0c             	add    $0xc,%eax
80102433:	66 89 50 f6          	mov    %dx,-0xa(%eax)
80102437:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010243b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
8010243f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102443:	66 89 50 fa          	mov    %dx,-0x6(%eax)
80102447:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010244a:	89 50 fc             	mov    %edx,-0x4(%eax)
8010244d:	6a 34                	push   $0x34
8010244f:	53                   	push   %ebx
80102450:	50                   	push   %eax
80102451:	e8 da 2f 00 00       	call   80105430 <memmove>
80102456:	89 34 24             	mov    %esi,(%esp)
80102459:	e8 c2 17 00 00       	call   80103c20 <log_write>
8010245e:	83 c4 10             	add    $0x10,%esp
80102461:	89 75 08             	mov    %esi,0x8(%ebp)
80102464:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102467:	5b                   	pop    %ebx
80102468:	5e                   	pop    %esi
80102469:	5d                   	pop    %ebp
8010246a:	e9 81 dd ff ff       	jmp    801001f0 <brelse>
8010246f:	90                   	nop

80102470 <idup>:
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	53                   	push   %ebx
80102474:	83 ec 10             	sub    $0x10,%esp
80102477:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010247a:	68 80 09 11 80       	push   $0x80110980
8010247f:	e8 1c 2e 00 00       	call   801052a0 <acquire>
80102484:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80102488:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
8010248f:	e8 ac 2d 00 00       	call   80105240 <release>
80102494:	89 d8                	mov    %ebx,%eax
80102496:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102499:	c9                   	leave
8010249a:	c3                   	ret
8010249b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801024a0 <ilock>:
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	56                   	push   %esi
801024a4:	53                   	push   %ebx
801024a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801024a8:	85 db                	test   %ebx,%ebx
801024aa:	0f 84 b7 00 00 00    	je     80102567 <ilock+0xc7>
801024b0:	8b 53 08             	mov    0x8(%ebx),%edx
801024b3:	85 d2                	test   %edx,%edx
801024b5:	0f 8e ac 00 00 00    	jle    80102567 <ilock+0xc7>
801024bb:	83 ec 0c             	sub    $0xc,%esp
801024be:	8d 43 0c             	lea    0xc(%ebx),%eax
801024c1:	50                   	push   %eax
801024c2:	e8 f9 2a 00 00       	call   80104fc0 <acquiresleep>
801024c7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801024ca:	83 c4 10             	add    $0x10,%esp
801024cd:	85 c0                	test   %eax,%eax
801024cf:	74 0f                	je     801024e0 <ilock+0x40>
801024d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024d4:	5b                   	pop    %ebx
801024d5:	5e                   	pop    %esi
801024d6:	5d                   	pop    %ebp
801024d7:	c3                   	ret
801024d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024df:	00 
801024e0:	8b 43 04             	mov    0x4(%ebx),%eax
801024e3:	83 ec 08             	sub    $0x8,%esp
801024e6:	c1 e8 03             	shr    $0x3,%eax
801024e9:	03 05 e8 25 11 80    	add    0x801125e8,%eax
801024ef:	50                   	push   %eax
801024f0:	ff 33                	push   (%ebx)
801024f2:	e8 d9 db ff ff       	call   801000d0 <bread>
801024f7:	83 c4 0c             	add    $0xc,%esp
801024fa:	89 c6                	mov    %eax,%esi
801024fc:	8b 43 04             	mov    0x4(%ebx),%eax
801024ff:	83 e0 07             	and    $0x7,%eax
80102502:	c1 e0 06             	shl    $0x6,%eax
80102505:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80102509:	0f b7 10             	movzwl (%eax),%edx
8010250c:	83 c0 0c             	add    $0xc,%eax
8010250f:	66 89 53 50          	mov    %dx,0x50(%ebx)
80102513:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102517:	66 89 53 52          	mov    %dx,0x52(%ebx)
8010251b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010251f:	66 89 53 54          	mov    %dx,0x54(%ebx)
80102523:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102527:	66 89 53 56          	mov    %dx,0x56(%ebx)
8010252b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010252e:	89 53 58             	mov    %edx,0x58(%ebx)
80102531:	6a 34                	push   $0x34
80102533:	50                   	push   %eax
80102534:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102537:	50                   	push   %eax
80102538:	e8 f3 2e 00 00       	call   80105430 <memmove>
8010253d:	89 34 24             	mov    %esi,(%esp)
80102540:	e8 ab dc ff ff       	call   801001f0 <brelse>
80102545:	83 c4 10             	add    $0x10,%esp
80102548:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010254d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
80102554:	0f 85 77 ff ff ff    	jne    801024d1 <ilock+0x31>
8010255a:	83 ec 0c             	sub    $0xc,%esp
8010255d:	68 81 7f 10 80       	push   $0x80107f81
80102562:	e8 29 e5 ff ff       	call   80100a90 <panic>
80102567:	83 ec 0c             	sub    $0xc,%esp
8010256a:	68 7b 7f 10 80       	push   $0x80107f7b
8010256f:	e8 1c e5 ff ff       	call   80100a90 <panic>
80102574:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010257b:	00 
8010257c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102580 <iunlock>:
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	56                   	push   %esi
80102584:	53                   	push   %ebx
80102585:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102588:	85 db                	test   %ebx,%ebx
8010258a:	74 28                	je     801025b4 <iunlock+0x34>
8010258c:	83 ec 0c             	sub    $0xc,%esp
8010258f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102592:	56                   	push   %esi
80102593:	e8 c8 2a 00 00       	call   80105060 <holdingsleep>
80102598:	83 c4 10             	add    $0x10,%esp
8010259b:	85 c0                	test   %eax,%eax
8010259d:	74 15                	je     801025b4 <iunlock+0x34>
8010259f:	8b 43 08             	mov    0x8(%ebx),%eax
801025a2:	85 c0                	test   %eax,%eax
801025a4:	7e 0e                	jle    801025b4 <iunlock+0x34>
801025a6:	89 75 08             	mov    %esi,0x8(%ebp)
801025a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025ac:	5b                   	pop    %ebx
801025ad:	5e                   	pop    %esi
801025ae:	5d                   	pop    %ebp
801025af:	e9 6c 2a 00 00       	jmp    80105020 <releasesleep>
801025b4:	83 ec 0c             	sub    $0xc,%esp
801025b7:	68 90 7f 10 80       	push   $0x80107f90
801025bc:	e8 cf e4 ff ff       	call   80100a90 <panic>
801025c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025c8:	00 
801025c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801025d0 <iput>:
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	57                   	push   %edi
801025d4:	56                   	push   %esi
801025d5:	53                   	push   %ebx
801025d6:	83 ec 28             	sub    $0x28,%esp
801025d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801025dc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801025df:	57                   	push   %edi
801025e0:	e8 db 29 00 00       	call   80104fc0 <acquiresleep>
801025e5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801025e8:	83 c4 10             	add    $0x10,%esp
801025eb:	85 d2                	test   %edx,%edx
801025ed:	74 07                	je     801025f6 <iput+0x26>
801025ef:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801025f4:	74 32                	je     80102628 <iput+0x58>
801025f6:	83 ec 0c             	sub    $0xc,%esp
801025f9:	57                   	push   %edi
801025fa:	e8 21 2a 00 00       	call   80105020 <releasesleep>
801025ff:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
80102606:	e8 95 2c 00 00       	call   801052a0 <acquire>
8010260b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
8010260f:	83 c4 10             	add    $0x10,%esp
80102612:	c7 45 08 80 09 11 80 	movl   $0x80110980,0x8(%ebp)
80102619:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010261c:	5b                   	pop    %ebx
8010261d:	5e                   	pop    %esi
8010261e:	5f                   	pop    %edi
8010261f:	5d                   	pop    %ebp
80102620:	e9 1b 2c 00 00       	jmp    80105240 <release>
80102625:	8d 76 00             	lea    0x0(%esi),%esi
80102628:	83 ec 0c             	sub    $0xc,%esp
8010262b:	68 80 09 11 80       	push   $0x80110980
80102630:	e8 6b 2c 00 00       	call   801052a0 <acquire>
80102635:	8b 73 08             	mov    0x8(%ebx),%esi
80102638:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
8010263f:	e8 fc 2b 00 00       	call   80105240 <release>
80102644:	83 c4 10             	add    $0x10,%esp
80102647:	83 fe 01             	cmp    $0x1,%esi
8010264a:	75 aa                	jne    801025f6 <iput+0x26>
8010264c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102652:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102655:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102658:	89 df                	mov    %ebx,%edi
8010265a:	89 cb                	mov    %ecx,%ebx
8010265c:	eb 09                	jmp    80102667 <iput+0x97>
8010265e:	66 90                	xchg   %ax,%ax
80102660:	83 c6 04             	add    $0x4,%esi
80102663:	39 de                	cmp    %ebx,%esi
80102665:	74 19                	je     80102680 <iput+0xb0>
80102667:	8b 16                	mov    (%esi),%edx
80102669:	85 d2                	test   %edx,%edx
8010266b:	74 f3                	je     80102660 <iput+0x90>
8010266d:	8b 07                	mov    (%edi),%eax
8010266f:	e8 7c fa ff ff       	call   801020f0 <bfree>
80102674:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010267a:	eb e4                	jmp    80102660 <iput+0x90>
8010267c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102680:	89 fb                	mov    %edi,%ebx
80102682:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102685:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010268b:	85 c0                	test   %eax,%eax
8010268d:	75 2d                	jne    801026bc <iput+0xec>
8010268f:	83 ec 0c             	sub    $0xc,%esp
80102692:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80102699:	53                   	push   %ebx
8010269a:	e8 51 fd ff ff       	call   801023f0 <iupdate>
8010269f:	31 c0                	xor    %eax,%eax
801026a1:	66 89 43 50          	mov    %ax,0x50(%ebx)
801026a5:	89 1c 24             	mov    %ebx,(%esp)
801026a8:	e8 43 fd ff ff       	call   801023f0 <iupdate>
801026ad:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801026b4:	83 c4 10             	add    $0x10,%esp
801026b7:	e9 3a ff ff ff       	jmp    801025f6 <iput+0x26>
801026bc:	83 ec 08             	sub    $0x8,%esp
801026bf:	50                   	push   %eax
801026c0:	ff 33                	push   (%ebx)
801026c2:	e8 09 da ff ff       	call   801000d0 <bread>
801026c7:	83 c4 10             	add    $0x10,%esp
801026ca:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801026cd:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801026d3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801026d6:	8d 70 5c             	lea    0x5c(%eax),%esi
801026d9:	89 cf                	mov    %ecx,%edi
801026db:	eb 0a                	jmp    801026e7 <iput+0x117>
801026dd:	8d 76 00             	lea    0x0(%esi),%esi
801026e0:	83 c6 04             	add    $0x4,%esi
801026e3:	39 fe                	cmp    %edi,%esi
801026e5:	74 0f                	je     801026f6 <iput+0x126>
801026e7:	8b 16                	mov    (%esi),%edx
801026e9:	85 d2                	test   %edx,%edx
801026eb:	74 f3                	je     801026e0 <iput+0x110>
801026ed:	8b 03                	mov    (%ebx),%eax
801026ef:	e8 fc f9 ff ff       	call   801020f0 <bfree>
801026f4:	eb ea                	jmp    801026e0 <iput+0x110>
801026f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801026f9:	83 ec 0c             	sub    $0xc,%esp
801026fc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801026ff:	50                   	push   %eax
80102700:	e8 eb da ff ff       	call   801001f0 <brelse>
80102705:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010270b:	8b 03                	mov    (%ebx),%eax
8010270d:	e8 de f9 ff ff       	call   801020f0 <bfree>
80102712:	83 c4 10             	add    $0x10,%esp
80102715:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010271c:	00 00 00 
8010271f:	e9 6b ff ff ff       	jmp    8010268f <iput+0xbf>
80102724:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010272b:	00 
8010272c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102730 <iunlockput>:
80102730:	55                   	push   %ebp
80102731:	89 e5                	mov    %esp,%ebp
80102733:	56                   	push   %esi
80102734:	53                   	push   %ebx
80102735:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102738:	85 db                	test   %ebx,%ebx
8010273a:	74 34                	je     80102770 <iunlockput+0x40>
8010273c:	83 ec 0c             	sub    $0xc,%esp
8010273f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102742:	56                   	push   %esi
80102743:	e8 18 29 00 00       	call   80105060 <holdingsleep>
80102748:	83 c4 10             	add    $0x10,%esp
8010274b:	85 c0                	test   %eax,%eax
8010274d:	74 21                	je     80102770 <iunlockput+0x40>
8010274f:	8b 43 08             	mov    0x8(%ebx),%eax
80102752:	85 c0                	test   %eax,%eax
80102754:	7e 1a                	jle    80102770 <iunlockput+0x40>
80102756:	83 ec 0c             	sub    $0xc,%esp
80102759:	56                   	push   %esi
8010275a:	e8 c1 28 00 00       	call   80105020 <releasesleep>
8010275f:	83 c4 10             	add    $0x10,%esp
80102762:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102765:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102768:	5b                   	pop    %ebx
80102769:	5e                   	pop    %esi
8010276a:	5d                   	pop    %ebp
8010276b:	e9 60 fe ff ff       	jmp    801025d0 <iput>
80102770:	83 ec 0c             	sub    $0xc,%esp
80102773:	68 90 7f 10 80       	push   $0x80107f90
80102778:	e8 13 e3 ff ff       	call   80100a90 <panic>
8010277d:	8d 76 00             	lea    0x0(%esi),%esi

80102780 <stati>:
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	8b 55 08             	mov    0x8(%ebp),%edx
80102786:	8b 45 0c             	mov    0xc(%ebp),%eax
80102789:	8b 0a                	mov    (%edx),%ecx
8010278b:	89 48 04             	mov    %ecx,0x4(%eax)
8010278e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102791:	89 48 08             	mov    %ecx,0x8(%eax)
80102794:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102798:	66 89 08             	mov    %cx,(%eax)
8010279b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010279f:	66 89 48 0c          	mov    %cx,0xc(%eax)
801027a3:	8b 52 58             	mov    0x58(%edx),%edx
801027a6:	89 50 10             	mov    %edx,0x10(%eax)
801027a9:	5d                   	pop    %ebp
801027aa:	c3                   	ret
801027ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801027b0 <readi>:
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	57                   	push   %edi
801027b4:	56                   	push   %esi
801027b5:	53                   	push   %ebx
801027b6:	83 ec 1c             	sub    $0x1c,%esp
801027b9:	8b 75 08             	mov    0x8(%ebp),%esi
801027bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801027bf:	8b 7d 10             	mov    0x10(%ebp),%edi
801027c2:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
801027c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
801027ca:	89 75 d8             	mov    %esi,-0x28(%ebp)
801027cd:	8b 45 14             	mov    0x14(%ebp),%eax
801027d0:	0f 84 aa 00 00 00    	je     80102880 <readi+0xd0>
801027d6:	8b 75 d8             	mov    -0x28(%ebp),%esi
801027d9:	8b 56 58             	mov    0x58(%esi),%edx
801027dc:	39 fa                	cmp    %edi,%edx
801027de:	0f 82 bd 00 00 00    	jb     801028a1 <readi+0xf1>
801027e4:	89 f9                	mov    %edi,%ecx
801027e6:	31 db                	xor    %ebx,%ebx
801027e8:	01 c1                	add    %eax,%ecx
801027ea:	0f 92 c3             	setb   %bl
801027ed:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801027f0:	0f 82 ab 00 00 00    	jb     801028a1 <readi+0xf1>
801027f6:	89 d3                	mov    %edx,%ebx
801027f8:	29 fb                	sub    %edi,%ebx
801027fa:	39 ca                	cmp    %ecx,%edx
801027fc:	0f 42 c3             	cmovb  %ebx,%eax
801027ff:	85 c0                	test   %eax,%eax
80102801:	74 73                	je     80102876 <readi+0xc6>
80102803:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80102806:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102810:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102813:	89 fa                	mov    %edi,%edx
80102815:	c1 ea 09             	shr    $0x9,%edx
80102818:	89 d8                	mov    %ebx,%eax
8010281a:	e8 51 f9 ff ff       	call   80102170 <bmap>
8010281f:	83 ec 08             	sub    $0x8,%esp
80102822:	50                   	push   %eax
80102823:	ff 33                	push   (%ebx)
80102825:	e8 a6 d8 ff ff       	call   801000d0 <bread>
8010282a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010282d:	b9 00 02 00 00       	mov    $0x200,%ecx
80102832:	89 c2                	mov    %eax,%edx
80102834:	89 f8                	mov    %edi,%eax
80102836:	25 ff 01 00 00       	and    $0x1ff,%eax
8010283b:	29 f3                	sub    %esi,%ebx
8010283d:	29 c1                	sub    %eax,%ecx
8010283f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80102843:	39 d9                	cmp    %ebx,%ecx
80102845:	0f 46 d9             	cmovbe %ecx,%ebx
80102848:	83 c4 0c             	add    $0xc,%esp
8010284b:	53                   	push   %ebx
8010284c:	01 de                	add    %ebx,%esi
8010284e:	01 df                	add    %ebx,%edi
80102850:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102853:	50                   	push   %eax
80102854:	ff 75 e0             	push   -0x20(%ebp)
80102857:	e8 d4 2b 00 00       	call   80105430 <memmove>
8010285c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010285f:	89 14 24             	mov    %edx,(%esp)
80102862:	e8 89 d9 ff ff       	call   801001f0 <brelse>
80102867:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010286a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010286d:	83 c4 10             	add    $0x10,%esp
80102870:	39 de                	cmp    %ebx,%esi
80102872:	72 9c                	jb     80102810 <readi+0x60>
80102874:	89 d8                	mov    %ebx,%eax
80102876:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102879:	5b                   	pop    %ebx
8010287a:	5e                   	pop    %esi
8010287b:	5f                   	pop    %edi
8010287c:	5d                   	pop    %ebp
8010287d:	c3                   	ret
8010287e:	66 90                	xchg   %ax,%ax
80102880:	0f bf 56 52          	movswl 0x52(%esi),%edx
80102884:	66 83 fa 09          	cmp    $0x9,%dx
80102888:	77 17                	ja     801028a1 <readi+0xf1>
8010288a:	8b 14 d5 20 09 11 80 	mov    -0x7feef6e0(,%edx,8),%edx
80102891:	85 d2                	test   %edx,%edx
80102893:	74 0c                	je     801028a1 <readi+0xf1>
80102895:	89 45 10             	mov    %eax,0x10(%ebp)
80102898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010289b:	5b                   	pop    %ebx
8010289c:	5e                   	pop    %esi
8010289d:	5f                   	pop    %edi
8010289e:	5d                   	pop    %ebp
8010289f:	ff e2                	jmp    *%edx
801028a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801028a6:	eb ce                	jmp    80102876 <readi+0xc6>
801028a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028af:	00 

801028b0 <writei>:
801028b0:	55                   	push   %ebp
801028b1:	89 e5                	mov    %esp,%ebp
801028b3:	57                   	push   %edi
801028b4:	56                   	push   %esi
801028b5:	53                   	push   %ebx
801028b6:	83 ec 1c             	sub    $0x1c,%esp
801028b9:	8b 45 08             	mov    0x8(%ebp),%eax
801028bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801028bf:	8b 75 14             	mov    0x14(%ebp),%esi
801028c2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
801028c7:	89 7d dc             	mov    %edi,-0x24(%ebp)
801028ca:	89 75 e0             	mov    %esi,-0x20(%ebp)
801028cd:	8b 7d 10             	mov    0x10(%ebp),%edi
801028d0:	0f 84 ba 00 00 00    	je     80102990 <writei+0xe0>
801028d6:	39 78 58             	cmp    %edi,0x58(%eax)
801028d9:	0f 82 ea 00 00 00    	jb     801029c9 <writei+0x119>
801028df:	8b 75 e0             	mov    -0x20(%ebp),%esi
801028e2:	89 f2                	mov    %esi,%edx
801028e4:	01 fa                	add    %edi,%edx
801028e6:	0f 82 dd 00 00 00    	jb     801029c9 <writei+0x119>
801028ec:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
801028f2:	0f 87 d1 00 00 00    	ja     801029c9 <writei+0x119>
801028f8:	85 f6                	test   %esi,%esi
801028fa:	0f 84 85 00 00 00    	je     80102985 <writei+0xd5>
80102900:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102907:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010290a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102910:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102913:	89 fa                	mov    %edi,%edx
80102915:	c1 ea 09             	shr    $0x9,%edx
80102918:	89 f0                	mov    %esi,%eax
8010291a:	e8 51 f8 ff ff       	call   80102170 <bmap>
8010291f:	83 ec 08             	sub    $0x8,%esp
80102922:	50                   	push   %eax
80102923:	ff 36                	push   (%esi)
80102925:	e8 a6 d7 ff ff       	call   801000d0 <bread>
8010292a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010292d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102930:	b9 00 02 00 00       	mov    $0x200,%ecx
80102935:	89 c6                	mov    %eax,%esi
80102937:	89 f8                	mov    %edi,%eax
80102939:	25 ff 01 00 00       	and    $0x1ff,%eax
8010293e:	29 d3                	sub    %edx,%ebx
80102940:	29 c1                	sub    %eax,%ecx
80102942:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80102946:	39 d9                	cmp    %ebx,%ecx
80102948:	0f 46 d9             	cmovbe %ecx,%ebx
8010294b:	83 c4 0c             	add    $0xc,%esp
8010294e:	53                   	push   %ebx
8010294f:	01 df                	add    %ebx,%edi
80102951:	ff 75 dc             	push   -0x24(%ebp)
80102954:	50                   	push   %eax
80102955:	e8 d6 2a 00 00       	call   80105430 <memmove>
8010295a:	89 34 24             	mov    %esi,(%esp)
8010295d:	e8 be 12 00 00       	call   80103c20 <log_write>
80102962:	89 34 24             	mov    %esi,(%esp)
80102965:	e8 86 d8 ff ff       	call   801001f0 <brelse>
8010296a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010296d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102970:	83 c4 10             	add    $0x10,%esp
80102973:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102976:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102979:	39 d8                	cmp    %ebx,%eax
8010297b:	72 93                	jb     80102910 <writei+0x60>
8010297d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102980:	39 78 58             	cmp    %edi,0x58(%eax)
80102983:	72 33                	jb     801029b8 <writei+0x108>
80102985:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102988:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010298b:	5b                   	pop    %ebx
8010298c:	5e                   	pop    %esi
8010298d:	5f                   	pop    %edi
8010298e:	5d                   	pop    %ebp
8010298f:	c3                   	ret
80102990:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102994:	66 83 f8 09          	cmp    $0x9,%ax
80102998:	77 2f                	ja     801029c9 <writei+0x119>
8010299a:	8b 04 c5 24 09 11 80 	mov    -0x7feef6dc(,%eax,8),%eax
801029a1:	85 c0                	test   %eax,%eax
801029a3:	74 24                	je     801029c9 <writei+0x119>
801029a5:	89 75 10             	mov    %esi,0x10(%ebp)
801029a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029ab:	5b                   	pop    %ebx
801029ac:	5e                   	pop    %esi
801029ad:	5f                   	pop    %edi
801029ae:	5d                   	pop    %ebp
801029af:	ff e0                	jmp    *%eax
801029b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029b8:	83 ec 0c             	sub    $0xc,%esp
801029bb:	89 78 58             	mov    %edi,0x58(%eax)
801029be:	50                   	push   %eax
801029bf:	e8 2c fa ff ff       	call   801023f0 <iupdate>
801029c4:	83 c4 10             	add    $0x10,%esp
801029c7:	eb bc                	jmp    80102985 <writei+0xd5>
801029c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801029ce:	eb b8                	jmp    80102988 <writei+0xd8>

801029d0 <namecmp>:
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	83 ec 0c             	sub    $0xc,%esp
801029d6:	6a 0e                	push   $0xe
801029d8:	ff 75 0c             	push   0xc(%ebp)
801029db:	ff 75 08             	push   0x8(%ebp)
801029de:	e8 bd 2a 00 00       	call   801054a0 <strncmp>
801029e3:	c9                   	leave
801029e4:	c3                   	ret
801029e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ec:	00 
801029ed:	8d 76 00             	lea    0x0(%esi),%esi

801029f0 <dirlookup>:
801029f0:	55                   	push   %ebp
801029f1:	89 e5                	mov    %esp,%ebp
801029f3:	57                   	push   %edi
801029f4:	56                   	push   %esi
801029f5:	53                   	push   %ebx
801029f6:	83 ec 1c             	sub    $0x1c,%esp
801029f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801029fc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102a01:	0f 85 85 00 00 00    	jne    80102a8c <dirlookup+0x9c>
80102a07:	8b 53 58             	mov    0x58(%ebx),%edx
80102a0a:	31 ff                	xor    %edi,%edi
80102a0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102a0f:	85 d2                	test   %edx,%edx
80102a11:	74 3e                	je     80102a51 <dirlookup+0x61>
80102a13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a18:	6a 10                	push   $0x10
80102a1a:	57                   	push   %edi
80102a1b:	56                   	push   %esi
80102a1c:	53                   	push   %ebx
80102a1d:	e8 8e fd ff ff       	call   801027b0 <readi>
80102a22:	83 c4 10             	add    $0x10,%esp
80102a25:	83 f8 10             	cmp    $0x10,%eax
80102a28:	75 55                	jne    80102a7f <dirlookup+0x8f>
80102a2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102a2f:	74 18                	je     80102a49 <dirlookup+0x59>
80102a31:	83 ec 04             	sub    $0x4,%esp
80102a34:	8d 45 da             	lea    -0x26(%ebp),%eax
80102a37:	6a 0e                	push   $0xe
80102a39:	50                   	push   %eax
80102a3a:	ff 75 0c             	push   0xc(%ebp)
80102a3d:	e8 5e 2a 00 00       	call   801054a0 <strncmp>
80102a42:	83 c4 10             	add    $0x10,%esp
80102a45:	85 c0                	test   %eax,%eax
80102a47:	74 17                	je     80102a60 <dirlookup+0x70>
80102a49:	83 c7 10             	add    $0x10,%edi
80102a4c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102a4f:	72 c7                	jb     80102a18 <dirlookup+0x28>
80102a51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a54:	31 c0                	xor    %eax,%eax
80102a56:	5b                   	pop    %ebx
80102a57:	5e                   	pop    %esi
80102a58:	5f                   	pop    %edi
80102a59:	5d                   	pop    %ebp
80102a5a:	c3                   	ret
80102a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a60:	8b 45 10             	mov    0x10(%ebp),%eax
80102a63:	85 c0                	test   %eax,%eax
80102a65:	74 05                	je     80102a6c <dirlookup+0x7c>
80102a67:	8b 45 10             	mov    0x10(%ebp),%eax
80102a6a:	89 38                	mov    %edi,(%eax)
80102a6c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80102a70:	8b 03                	mov    (%ebx),%eax
80102a72:	e8 79 f5 ff ff       	call   80101ff0 <iget>
80102a77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a7a:	5b                   	pop    %ebx
80102a7b:	5e                   	pop    %esi
80102a7c:	5f                   	pop    %edi
80102a7d:	5d                   	pop    %ebp
80102a7e:	c3                   	ret
80102a7f:	83 ec 0c             	sub    $0xc,%esp
80102a82:	68 aa 7f 10 80       	push   $0x80107faa
80102a87:	e8 04 e0 ff ff       	call   80100a90 <panic>
80102a8c:	83 ec 0c             	sub    $0xc,%esp
80102a8f:	68 98 7f 10 80       	push   $0x80107f98
80102a94:	e8 f7 df ff ff       	call   80100a90 <panic>
80102a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102aa0 <namex>:
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	57                   	push   %edi
80102aa4:	56                   	push   %esi
80102aa5:	53                   	push   %ebx
80102aa6:	89 c3                	mov    %eax,%ebx
80102aa8:	83 ec 1c             	sub    $0x1c,%esp
80102aab:	80 38 2f             	cmpb   $0x2f,(%eax)
80102aae:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102ab1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102ab4:	0f 84 9e 01 00 00    	je     80102c58 <namex+0x1b8>
80102aba:	e8 a1 1b 00 00       	call   80104660 <myproc>
80102abf:	83 ec 0c             	sub    $0xc,%esp
80102ac2:	8b 70 68             	mov    0x68(%eax),%esi
80102ac5:	68 80 09 11 80       	push   $0x80110980
80102aca:	e8 d1 27 00 00       	call   801052a0 <acquire>
80102acf:	83 46 08 01          	addl   $0x1,0x8(%esi)
80102ad3:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
80102ada:	e8 61 27 00 00       	call   80105240 <release>
80102adf:	83 c4 10             	add    $0x10,%esp
80102ae2:	eb 07                	jmp    80102aeb <namex+0x4b>
80102ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ae8:	83 c3 01             	add    $0x1,%ebx
80102aeb:	0f b6 03             	movzbl (%ebx),%eax
80102aee:	3c 2f                	cmp    $0x2f,%al
80102af0:	74 f6                	je     80102ae8 <namex+0x48>
80102af2:	84 c0                	test   %al,%al
80102af4:	0f 84 06 01 00 00    	je     80102c00 <namex+0x160>
80102afa:	0f b6 03             	movzbl (%ebx),%eax
80102afd:	84 c0                	test   %al,%al
80102aff:	0f 84 10 01 00 00    	je     80102c15 <namex+0x175>
80102b05:	89 df                	mov    %ebx,%edi
80102b07:	3c 2f                	cmp    $0x2f,%al
80102b09:	0f 84 06 01 00 00    	je     80102c15 <namex+0x175>
80102b0f:	90                   	nop
80102b10:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80102b14:	83 c7 01             	add    $0x1,%edi
80102b17:	3c 2f                	cmp    $0x2f,%al
80102b19:	74 04                	je     80102b1f <namex+0x7f>
80102b1b:	84 c0                	test   %al,%al
80102b1d:	75 f1                	jne    80102b10 <namex+0x70>
80102b1f:	89 f8                	mov    %edi,%eax
80102b21:	29 d8                	sub    %ebx,%eax
80102b23:	83 f8 0d             	cmp    $0xd,%eax
80102b26:	0f 8e ac 00 00 00    	jle    80102bd8 <namex+0x138>
80102b2c:	83 ec 04             	sub    $0x4,%esp
80102b2f:	6a 0e                	push   $0xe
80102b31:	53                   	push   %ebx
80102b32:	89 fb                	mov    %edi,%ebx
80102b34:	ff 75 e4             	push   -0x1c(%ebp)
80102b37:	e8 f4 28 00 00       	call   80105430 <memmove>
80102b3c:	83 c4 10             	add    $0x10,%esp
80102b3f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102b42:	75 0c                	jne    80102b50 <namex+0xb0>
80102b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b48:	83 c3 01             	add    $0x1,%ebx
80102b4b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102b4e:	74 f8                	je     80102b48 <namex+0xa8>
80102b50:	83 ec 0c             	sub    $0xc,%esp
80102b53:	56                   	push   %esi
80102b54:	e8 47 f9 ff ff       	call   801024a0 <ilock>
80102b59:	83 c4 10             	add    $0x10,%esp
80102b5c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102b61:	0f 85 b7 00 00 00    	jne    80102c1e <namex+0x17e>
80102b67:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102b6a:	85 c0                	test   %eax,%eax
80102b6c:	74 09                	je     80102b77 <namex+0xd7>
80102b6e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102b71:	0f 84 f7 00 00 00    	je     80102c6e <namex+0x1ce>
80102b77:	83 ec 04             	sub    $0x4,%esp
80102b7a:	6a 00                	push   $0x0
80102b7c:	ff 75 e4             	push   -0x1c(%ebp)
80102b7f:	56                   	push   %esi
80102b80:	e8 6b fe ff ff       	call   801029f0 <dirlookup>
80102b85:	83 c4 10             	add    $0x10,%esp
80102b88:	89 c7                	mov    %eax,%edi
80102b8a:	85 c0                	test   %eax,%eax
80102b8c:	0f 84 8c 00 00 00    	je     80102c1e <namex+0x17e>
80102b92:	83 ec 0c             	sub    $0xc,%esp
80102b95:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102b98:	51                   	push   %ecx
80102b99:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102b9c:	e8 bf 24 00 00       	call   80105060 <holdingsleep>
80102ba1:	83 c4 10             	add    $0x10,%esp
80102ba4:	85 c0                	test   %eax,%eax
80102ba6:	0f 84 02 01 00 00    	je     80102cae <namex+0x20e>
80102bac:	8b 56 08             	mov    0x8(%esi),%edx
80102baf:	85 d2                	test   %edx,%edx
80102bb1:	0f 8e f7 00 00 00    	jle    80102cae <namex+0x20e>
80102bb7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102bba:	83 ec 0c             	sub    $0xc,%esp
80102bbd:	51                   	push   %ecx
80102bbe:	e8 5d 24 00 00       	call   80105020 <releasesleep>
80102bc3:	89 34 24             	mov    %esi,(%esp)
80102bc6:	89 fe                	mov    %edi,%esi
80102bc8:	e8 03 fa ff ff       	call   801025d0 <iput>
80102bcd:	83 c4 10             	add    $0x10,%esp
80102bd0:	e9 16 ff ff ff       	jmp    80102aeb <namex+0x4b>
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
80102bd8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102bdb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80102bde:	83 ec 04             	sub    $0x4,%esp
80102be1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102be4:	50                   	push   %eax
80102be5:	53                   	push   %ebx
80102be6:	89 fb                	mov    %edi,%ebx
80102be8:	ff 75 e4             	push   -0x1c(%ebp)
80102beb:	e8 40 28 00 00       	call   80105430 <memmove>
80102bf0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102bf3:	83 c4 10             	add    $0x10,%esp
80102bf6:	c6 01 00             	movb   $0x0,(%ecx)
80102bf9:	e9 41 ff ff ff       	jmp    80102b3f <namex+0x9f>
80102bfe:	66 90                	xchg   %ax,%ax
80102c00:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102c03:	85 c0                	test   %eax,%eax
80102c05:	0f 85 93 00 00 00    	jne    80102c9e <namex+0x1fe>
80102c0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c0e:	89 f0                	mov    %esi,%eax
80102c10:	5b                   	pop    %ebx
80102c11:	5e                   	pop    %esi
80102c12:	5f                   	pop    %edi
80102c13:	5d                   	pop    %ebp
80102c14:	c3                   	ret
80102c15:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102c18:	89 df                	mov    %ebx,%edi
80102c1a:	31 c0                	xor    %eax,%eax
80102c1c:	eb c0                	jmp    80102bde <namex+0x13e>
80102c1e:	83 ec 0c             	sub    $0xc,%esp
80102c21:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102c24:	53                   	push   %ebx
80102c25:	e8 36 24 00 00       	call   80105060 <holdingsleep>
80102c2a:	83 c4 10             	add    $0x10,%esp
80102c2d:	85 c0                	test   %eax,%eax
80102c2f:	74 7d                	je     80102cae <namex+0x20e>
80102c31:	8b 4e 08             	mov    0x8(%esi),%ecx
80102c34:	85 c9                	test   %ecx,%ecx
80102c36:	7e 76                	jle    80102cae <namex+0x20e>
80102c38:	83 ec 0c             	sub    $0xc,%esp
80102c3b:	53                   	push   %ebx
80102c3c:	e8 df 23 00 00       	call   80105020 <releasesleep>
80102c41:	89 34 24             	mov    %esi,(%esp)
80102c44:	31 f6                	xor    %esi,%esi
80102c46:	e8 85 f9 ff ff       	call   801025d0 <iput>
80102c4b:	83 c4 10             	add    $0x10,%esp
80102c4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c51:	89 f0                	mov    %esi,%eax
80102c53:	5b                   	pop    %ebx
80102c54:	5e                   	pop    %esi
80102c55:	5f                   	pop    %edi
80102c56:	5d                   	pop    %ebp
80102c57:	c3                   	ret
80102c58:	ba 01 00 00 00       	mov    $0x1,%edx
80102c5d:	b8 01 00 00 00       	mov    $0x1,%eax
80102c62:	e8 89 f3 ff ff       	call   80101ff0 <iget>
80102c67:	89 c6                	mov    %eax,%esi
80102c69:	e9 7d fe ff ff       	jmp    80102aeb <namex+0x4b>
80102c6e:	83 ec 0c             	sub    $0xc,%esp
80102c71:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102c74:	53                   	push   %ebx
80102c75:	e8 e6 23 00 00       	call   80105060 <holdingsleep>
80102c7a:	83 c4 10             	add    $0x10,%esp
80102c7d:	85 c0                	test   %eax,%eax
80102c7f:	74 2d                	je     80102cae <namex+0x20e>
80102c81:	8b 7e 08             	mov    0x8(%esi),%edi
80102c84:	85 ff                	test   %edi,%edi
80102c86:	7e 26                	jle    80102cae <namex+0x20e>
80102c88:	83 ec 0c             	sub    $0xc,%esp
80102c8b:	53                   	push   %ebx
80102c8c:	e8 8f 23 00 00       	call   80105020 <releasesleep>
80102c91:	83 c4 10             	add    $0x10,%esp
80102c94:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c97:	89 f0                	mov    %esi,%eax
80102c99:	5b                   	pop    %ebx
80102c9a:	5e                   	pop    %esi
80102c9b:	5f                   	pop    %edi
80102c9c:	5d                   	pop    %ebp
80102c9d:	c3                   	ret
80102c9e:	83 ec 0c             	sub    $0xc,%esp
80102ca1:	56                   	push   %esi
80102ca2:	31 f6                	xor    %esi,%esi
80102ca4:	e8 27 f9 ff ff       	call   801025d0 <iput>
80102ca9:	83 c4 10             	add    $0x10,%esp
80102cac:	eb a0                	jmp    80102c4e <namex+0x1ae>
80102cae:	83 ec 0c             	sub    $0xc,%esp
80102cb1:	68 90 7f 10 80       	push   $0x80107f90
80102cb6:	e8 d5 dd ff ff       	call   80100a90 <panic>
80102cbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102cc0 <dirlink>:
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	57                   	push   %edi
80102cc4:	56                   	push   %esi
80102cc5:	53                   	push   %ebx
80102cc6:	83 ec 20             	sub    $0x20,%esp
80102cc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102ccc:	6a 00                	push   $0x0
80102cce:	ff 75 0c             	push   0xc(%ebp)
80102cd1:	53                   	push   %ebx
80102cd2:	e8 19 fd ff ff       	call   801029f0 <dirlookup>
80102cd7:	83 c4 10             	add    $0x10,%esp
80102cda:	85 c0                	test   %eax,%eax
80102cdc:	75 67                	jne    80102d45 <dirlink+0x85>
80102cde:	8b 7b 58             	mov    0x58(%ebx),%edi
80102ce1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102ce4:	85 ff                	test   %edi,%edi
80102ce6:	74 29                	je     80102d11 <dirlink+0x51>
80102ce8:	31 ff                	xor    %edi,%edi
80102cea:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102ced:	eb 09                	jmp    80102cf8 <dirlink+0x38>
80102cef:	90                   	nop
80102cf0:	83 c7 10             	add    $0x10,%edi
80102cf3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102cf6:	73 19                	jae    80102d11 <dirlink+0x51>
80102cf8:	6a 10                	push   $0x10
80102cfa:	57                   	push   %edi
80102cfb:	56                   	push   %esi
80102cfc:	53                   	push   %ebx
80102cfd:	e8 ae fa ff ff       	call   801027b0 <readi>
80102d02:	83 c4 10             	add    $0x10,%esp
80102d05:	83 f8 10             	cmp    $0x10,%eax
80102d08:	75 4e                	jne    80102d58 <dirlink+0x98>
80102d0a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102d0f:	75 df                	jne    80102cf0 <dirlink+0x30>
80102d11:	83 ec 04             	sub    $0x4,%esp
80102d14:	8d 45 da             	lea    -0x26(%ebp),%eax
80102d17:	6a 0e                	push   $0xe
80102d19:	ff 75 0c             	push   0xc(%ebp)
80102d1c:	50                   	push   %eax
80102d1d:	e8 ce 27 00 00       	call   801054f0 <strncpy>
80102d22:	8b 45 10             	mov    0x10(%ebp),%eax
80102d25:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
80102d29:	6a 10                	push   $0x10
80102d2b:	57                   	push   %edi
80102d2c:	56                   	push   %esi
80102d2d:	53                   	push   %ebx
80102d2e:	e8 7d fb ff ff       	call   801028b0 <writei>
80102d33:	83 c4 20             	add    $0x20,%esp
80102d36:	83 f8 10             	cmp    $0x10,%eax
80102d39:	75 2a                	jne    80102d65 <dirlink+0xa5>
80102d3b:	31 c0                	xor    %eax,%eax
80102d3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d40:	5b                   	pop    %ebx
80102d41:	5e                   	pop    %esi
80102d42:	5f                   	pop    %edi
80102d43:	5d                   	pop    %ebp
80102d44:	c3                   	ret
80102d45:	83 ec 0c             	sub    $0xc,%esp
80102d48:	50                   	push   %eax
80102d49:	e8 82 f8 ff ff       	call   801025d0 <iput>
80102d4e:	83 c4 10             	add    $0x10,%esp
80102d51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d56:	eb e5                	jmp    80102d3d <dirlink+0x7d>
80102d58:	83 ec 0c             	sub    $0xc,%esp
80102d5b:	68 b9 7f 10 80       	push   $0x80107fb9
80102d60:	e8 2b dd ff ff       	call   80100a90 <panic>
80102d65:	83 ec 0c             	sub    $0xc,%esp
80102d68:	68 15 82 10 80       	push   $0x80108215
80102d6d:	e8 1e dd ff ff       	call   80100a90 <panic>
80102d72:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d79:	00 
80102d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102d80 <namei>:
80102d80:	55                   	push   %ebp
80102d81:	31 d2                	xor    %edx,%edx
80102d83:	89 e5                	mov    %esp,%ebp
80102d85:	83 ec 18             	sub    $0x18,%esp
80102d88:	8b 45 08             	mov    0x8(%ebp),%eax
80102d8b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102d8e:	e8 0d fd ff ff       	call   80102aa0 <namex>
80102d93:	c9                   	leave
80102d94:	c3                   	ret
80102d95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d9c:	00 
80102d9d:	8d 76 00             	lea    0x0(%esi),%esi

80102da0 <nameiparent>:
80102da0:	55                   	push   %ebp
80102da1:	ba 01 00 00 00       	mov    $0x1,%edx
80102da6:	89 e5                	mov    %esp,%ebp
80102da8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102dab:	8b 45 08             	mov    0x8(%ebp),%eax
80102dae:	5d                   	pop    %ebp
80102daf:	e9 ec fc ff ff       	jmp    80102aa0 <namex>
80102db4:	66 90                	xchg   %ax,%ax
80102db6:	66 90                	xchg   %ax,%ax
80102db8:	66 90                	xchg   %ax,%ax
80102dba:	66 90                	xchg   %ax,%ax
80102dbc:	66 90                	xchg   %ax,%ax
80102dbe:	66 90                	xchg   %ax,%ax

80102dc0 <idestart>:
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	57                   	push   %edi
80102dc4:	56                   	push   %esi
80102dc5:	53                   	push   %ebx
80102dc6:	83 ec 0c             	sub    $0xc,%esp
80102dc9:	85 c0                	test   %eax,%eax
80102dcb:	0f 84 b4 00 00 00    	je     80102e85 <idestart+0xc5>
80102dd1:	8b 70 08             	mov    0x8(%eax),%esi
80102dd4:	89 c3                	mov    %eax,%ebx
80102dd6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102ddc:	0f 87 96 00 00 00    	ja     80102e78 <idestart+0xb8>
80102de2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102de7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dee:	00 
80102def:	90                   	nop
80102df0:	89 ca                	mov    %ecx,%edx
80102df2:	ec                   	in     (%dx),%al
80102df3:	83 e0 c0             	and    $0xffffffc0,%eax
80102df6:	3c 40                	cmp    $0x40,%al
80102df8:	75 f6                	jne    80102df0 <idestart+0x30>
80102dfa:	31 ff                	xor    %edi,%edi
80102dfc:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102e01:	89 f8                	mov    %edi,%eax
80102e03:	ee                   	out    %al,(%dx)
80102e04:	b8 01 00 00 00       	mov    $0x1,%eax
80102e09:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102e0e:	ee                   	out    %al,(%dx)
80102e0f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102e14:	89 f0                	mov    %esi,%eax
80102e16:	ee                   	out    %al,(%dx)
80102e17:	89 f0                	mov    %esi,%eax
80102e19:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102e1e:	c1 f8 08             	sar    $0x8,%eax
80102e21:	ee                   	out    %al,(%dx)
80102e22:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102e27:	89 f8                	mov    %edi,%eax
80102e29:	ee                   	out    %al,(%dx)
80102e2a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102e2e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102e33:	c1 e0 04             	shl    $0x4,%eax
80102e36:	83 e0 10             	and    $0x10,%eax
80102e39:	83 c8 e0             	or     $0xffffffe0,%eax
80102e3c:	ee                   	out    %al,(%dx)
80102e3d:	f6 03 04             	testb  $0x4,(%ebx)
80102e40:	75 16                	jne    80102e58 <idestart+0x98>
80102e42:	b8 20 00 00 00       	mov    $0x20,%eax
80102e47:	89 ca                	mov    %ecx,%edx
80102e49:	ee                   	out    %al,(%dx)
80102e4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e4d:	5b                   	pop    %ebx
80102e4e:	5e                   	pop    %esi
80102e4f:	5f                   	pop    %edi
80102e50:	5d                   	pop    %ebp
80102e51:	c3                   	ret
80102e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e58:	b8 30 00 00 00       	mov    $0x30,%eax
80102e5d:	89 ca                	mov    %ecx,%edx
80102e5f:	ee                   	out    %al,(%dx)
80102e60:	b9 80 00 00 00       	mov    $0x80,%ecx
80102e65:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102e68:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102e6d:	fc                   	cld
80102e6e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102e70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e73:	5b                   	pop    %ebx
80102e74:	5e                   	pop    %esi
80102e75:	5f                   	pop    %edi
80102e76:	5d                   	pop    %ebp
80102e77:	c3                   	ret
80102e78:	83 ec 0c             	sub    $0xc,%esp
80102e7b:	68 cf 7f 10 80       	push   $0x80107fcf
80102e80:	e8 0b dc ff ff       	call   80100a90 <panic>
80102e85:	83 ec 0c             	sub    $0xc,%esp
80102e88:	68 c6 7f 10 80       	push   $0x80107fc6
80102e8d:	e8 fe db ff ff       	call   80100a90 <panic>
80102e92:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e99:	00 
80102e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ea0 <ideinit>:
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	83 ec 10             	sub    $0x10,%esp
80102ea6:	68 e1 7f 10 80       	push   $0x80107fe1
80102eab:	68 20 26 11 80       	push   $0x80112620
80102eb0:	e8 fb 21 00 00       	call   801050b0 <initlock>
80102eb5:	58                   	pop    %eax
80102eb6:	a1 a4 27 11 80       	mov    0x801127a4,%eax
80102ebb:	5a                   	pop    %edx
80102ebc:	83 e8 01             	sub    $0x1,%eax
80102ebf:	50                   	push   %eax
80102ec0:	6a 0e                	push   $0xe
80102ec2:	e8 99 02 00 00       	call   80103160 <ioapicenable>
80102ec7:	83 c4 10             	add    $0x10,%esp
80102eca:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102ecf:	90                   	nop
80102ed0:	89 ca                	mov    %ecx,%edx
80102ed2:	ec                   	in     (%dx),%al
80102ed3:	83 e0 c0             	and    $0xffffffc0,%eax
80102ed6:	3c 40                	cmp    $0x40,%al
80102ed8:	75 f6                	jne    80102ed0 <ideinit+0x30>
80102eda:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102edf:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102ee4:	ee                   	out    %al,(%dx)
80102ee5:	89 ca                	mov    %ecx,%edx
80102ee7:	ec                   	in     (%dx),%al
80102ee8:	84 c0                	test   %al,%al
80102eea:	75 1e                	jne    80102f0a <ideinit+0x6a>
80102eec:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102ef1:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102ef6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102efd:	00 
80102efe:	66 90                	xchg   %ax,%ax
80102f00:	83 e9 01             	sub    $0x1,%ecx
80102f03:	74 0f                	je     80102f14 <ideinit+0x74>
80102f05:	ec                   	in     (%dx),%al
80102f06:	84 c0                	test   %al,%al
80102f08:	74 f6                	je     80102f00 <ideinit+0x60>
80102f0a:	c7 05 00 26 11 80 01 	movl   $0x1,0x80112600
80102f11:	00 00 00 
80102f14:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102f19:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f1e:	ee                   	out    %al,(%dx)
80102f1f:	c9                   	leave
80102f20:	c3                   	ret
80102f21:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f28:	00 
80102f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f30 <ideintr>:
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	57                   	push   %edi
80102f34:	56                   	push   %esi
80102f35:	53                   	push   %ebx
80102f36:	83 ec 18             	sub    $0x18,%esp
80102f39:	68 20 26 11 80       	push   $0x80112620
80102f3e:	e8 5d 23 00 00       	call   801052a0 <acquire>
80102f43:	8b 1d 04 26 11 80    	mov    0x80112604,%ebx
80102f49:	83 c4 10             	add    $0x10,%esp
80102f4c:	85 db                	test   %ebx,%ebx
80102f4e:	74 63                	je     80102fb3 <ideintr+0x83>
80102f50:	8b 43 58             	mov    0x58(%ebx),%eax
80102f53:	a3 04 26 11 80       	mov    %eax,0x80112604
80102f58:	8b 33                	mov    (%ebx),%esi
80102f5a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102f60:	75 2f                	jne    80102f91 <ideintr+0x61>
80102f62:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102f67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f6e:	00 
80102f6f:	90                   	nop
80102f70:	ec                   	in     (%dx),%al
80102f71:	89 c1                	mov    %eax,%ecx
80102f73:	83 e1 c0             	and    $0xffffffc0,%ecx
80102f76:	80 f9 40             	cmp    $0x40,%cl
80102f79:	75 f5                	jne    80102f70 <ideintr+0x40>
80102f7b:	a8 21                	test   $0x21,%al
80102f7d:	75 12                	jne    80102f91 <ideintr+0x61>
80102f7f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
80102f82:	b9 80 00 00 00       	mov    $0x80,%ecx
80102f87:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102f8c:	fc                   	cld
80102f8d:	f3 6d                	rep insl (%dx),%es:(%edi)
80102f8f:	8b 33                	mov    (%ebx),%esi
80102f91:	83 e6 fb             	and    $0xfffffffb,%esi
80102f94:	83 ec 0c             	sub    $0xc,%esp
80102f97:	83 ce 02             	or     $0x2,%esi
80102f9a:	89 33                	mov    %esi,(%ebx)
80102f9c:	53                   	push   %ebx
80102f9d:	e8 3e 1e 00 00       	call   80104de0 <wakeup>
80102fa2:	a1 04 26 11 80       	mov    0x80112604,%eax
80102fa7:	83 c4 10             	add    $0x10,%esp
80102faa:	85 c0                	test   %eax,%eax
80102fac:	74 05                	je     80102fb3 <ideintr+0x83>
80102fae:	e8 0d fe ff ff       	call   80102dc0 <idestart>
80102fb3:	83 ec 0c             	sub    $0xc,%esp
80102fb6:	68 20 26 11 80       	push   $0x80112620
80102fbb:	e8 80 22 00 00       	call   80105240 <release>
80102fc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fc3:	5b                   	pop    %ebx
80102fc4:	5e                   	pop    %esi
80102fc5:	5f                   	pop    %edi
80102fc6:	5d                   	pop    %ebp
80102fc7:	c3                   	ret
80102fc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fcf:	00 

80102fd0 <iderw>:
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	53                   	push   %ebx
80102fd4:	83 ec 10             	sub    $0x10,%esp
80102fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102fda:	8d 43 0c             	lea    0xc(%ebx),%eax
80102fdd:	50                   	push   %eax
80102fde:	e8 7d 20 00 00       	call   80105060 <holdingsleep>
80102fe3:	83 c4 10             	add    $0x10,%esp
80102fe6:	85 c0                	test   %eax,%eax
80102fe8:	0f 84 c3 00 00 00    	je     801030b1 <iderw+0xe1>
80102fee:	8b 03                	mov    (%ebx),%eax
80102ff0:	83 e0 06             	and    $0x6,%eax
80102ff3:	83 f8 02             	cmp    $0x2,%eax
80102ff6:	0f 84 a8 00 00 00    	je     801030a4 <iderw+0xd4>
80102ffc:	8b 53 04             	mov    0x4(%ebx),%edx
80102fff:	85 d2                	test   %edx,%edx
80103001:	74 0d                	je     80103010 <iderw+0x40>
80103003:	a1 00 26 11 80       	mov    0x80112600,%eax
80103008:	85 c0                	test   %eax,%eax
8010300a:	0f 84 87 00 00 00    	je     80103097 <iderw+0xc7>
80103010:	83 ec 0c             	sub    $0xc,%esp
80103013:	68 20 26 11 80       	push   $0x80112620
80103018:	e8 83 22 00 00       	call   801052a0 <acquire>
8010301d:	a1 04 26 11 80       	mov    0x80112604,%eax
80103022:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80103029:	83 c4 10             	add    $0x10,%esp
8010302c:	85 c0                	test   %eax,%eax
8010302e:	74 60                	je     80103090 <iderw+0xc0>
80103030:	89 c2                	mov    %eax,%edx
80103032:	8b 40 58             	mov    0x58(%eax),%eax
80103035:	85 c0                	test   %eax,%eax
80103037:	75 f7                	jne    80103030 <iderw+0x60>
80103039:	83 c2 58             	add    $0x58,%edx
8010303c:	89 1a                	mov    %ebx,(%edx)
8010303e:	39 1d 04 26 11 80    	cmp    %ebx,0x80112604
80103044:	74 3a                	je     80103080 <iderw+0xb0>
80103046:	8b 03                	mov    (%ebx),%eax
80103048:	83 e0 06             	and    $0x6,%eax
8010304b:	83 f8 02             	cmp    $0x2,%eax
8010304e:	74 1b                	je     8010306b <iderw+0x9b>
80103050:	83 ec 08             	sub    $0x8,%esp
80103053:	68 20 26 11 80       	push   $0x80112620
80103058:	53                   	push   %ebx
80103059:	e8 c2 1c 00 00       	call   80104d20 <sleep>
8010305e:	8b 03                	mov    (%ebx),%eax
80103060:	83 c4 10             	add    $0x10,%esp
80103063:	83 e0 06             	and    $0x6,%eax
80103066:	83 f8 02             	cmp    $0x2,%eax
80103069:	75 e5                	jne    80103050 <iderw+0x80>
8010306b:	c7 45 08 20 26 11 80 	movl   $0x80112620,0x8(%ebp)
80103072:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103075:	c9                   	leave
80103076:	e9 c5 21 00 00       	jmp    80105240 <release>
8010307b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103080:	89 d8                	mov    %ebx,%eax
80103082:	e8 39 fd ff ff       	call   80102dc0 <idestart>
80103087:	eb bd                	jmp    80103046 <iderw+0x76>
80103089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103090:	ba 04 26 11 80       	mov    $0x80112604,%edx
80103095:	eb a5                	jmp    8010303c <iderw+0x6c>
80103097:	83 ec 0c             	sub    $0xc,%esp
8010309a:	68 10 80 10 80       	push   $0x80108010
8010309f:	e8 ec d9 ff ff       	call   80100a90 <panic>
801030a4:	83 ec 0c             	sub    $0xc,%esp
801030a7:	68 fb 7f 10 80       	push   $0x80107ffb
801030ac:	e8 df d9 ff ff       	call   80100a90 <panic>
801030b1:	83 ec 0c             	sub    $0xc,%esp
801030b4:	68 e5 7f 10 80       	push   $0x80107fe5
801030b9:	e8 d2 d9 ff ff       	call   80100a90 <panic>
801030be:	66 90                	xchg   %ax,%ax

801030c0 <ioapicinit>:
801030c0:	55                   	push   %ebp
801030c1:	89 e5                	mov    %esp,%ebp
801030c3:	56                   	push   %esi
801030c4:	53                   	push   %ebx
801030c5:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
801030cc:	00 c0 fe 
801030cf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801030d6:	00 00 00 
801030d9:	8b 15 54 26 11 80    	mov    0x80112654,%edx
801030df:	8b 72 10             	mov    0x10(%edx),%esi
801030e2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
801030e8:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
801030ee:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
801030f5:	c1 ee 10             	shr    $0x10,%esi
801030f8:	89 f0                	mov    %esi,%eax
801030fa:	0f b6 f0             	movzbl %al,%esi
801030fd:	8b 43 10             	mov    0x10(%ebx),%eax
80103100:	c1 e8 18             	shr    $0x18,%eax
80103103:	39 c2                	cmp    %eax,%edx
80103105:	74 16                	je     8010311d <ioapicinit+0x5d>
80103107:	83 ec 0c             	sub    $0xc,%esp
8010310a:	68 38 84 10 80       	push   $0x80108438
8010310f:	e8 2c d7 ff ff       	call   80100840 <cprintf>
80103114:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
8010311a:	83 c4 10             	add    $0x10,%esp
8010311d:	ba 10 00 00 00       	mov    $0x10,%edx
80103122:	31 c0                	xor    %eax,%eax
80103124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103128:	89 13                	mov    %edx,(%ebx)
8010312a:	8d 48 20             	lea    0x20(%eax),%ecx
8010312d:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
80103133:	83 c0 01             	add    $0x1,%eax
80103136:	81 c9 00 00 01 00    	or     $0x10000,%ecx
8010313c:	89 4b 10             	mov    %ecx,0x10(%ebx)
8010313f:	8d 4a 01             	lea    0x1(%edx),%ecx
80103142:	83 c2 02             	add    $0x2,%edx
80103145:	89 0b                	mov    %ecx,(%ebx)
80103147:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
8010314d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80103154:	39 c6                	cmp    %eax,%esi
80103156:	7d d0                	jge    80103128 <ioapicinit+0x68>
80103158:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010315b:	5b                   	pop    %ebx
8010315c:	5e                   	pop    %esi
8010315d:	5d                   	pop    %ebp
8010315e:	c3                   	ret
8010315f:	90                   	nop

80103160 <ioapicenable>:
80103160:	55                   	push   %ebp
80103161:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80103167:	89 e5                	mov    %esp,%ebp
80103169:	8b 45 08             	mov    0x8(%ebp),%eax
8010316c:	8d 50 20             	lea    0x20(%eax),%edx
8010316f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80103173:	89 01                	mov    %eax,(%ecx)
80103175:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
8010317b:	83 c0 01             	add    $0x1,%eax
8010317e:	89 51 10             	mov    %edx,0x10(%ecx)
80103181:	8b 55 0c             	mov    0xc(%ebp),%edx
80103184:	89 01                	mov    %eax,(%ecx)
80103186:	a1 54 26 11 80       	mov    0x80112654,%eax
8010318b:	c1 e2 18             	shl    $0x18,%edx
8010318e:	89 50 10             	mov    %edx,0x10(%eax)
80103191:	5d                   	pop    %ebp
80103192:	c3                   	ret
80103193:	66 90                	xchg   %ax,%ax
80103195:	66 90                	xchg   %ax,%ax
80103197:	66 90                	xchg   %ax,%ax
80103199:	66 90                	xchg   %ax,%ax
8010319b:	66 90                	xchg   %ax,%ax
8010319d:	66 90                	xchg   %ax,%ax
8010319f:	90                   	nop

801031a0 <kfree>:
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	53                   	push   %ebx
801031a4:	83 ec 04             	sub    $0x4,%esp
801031a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801031aa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801031b0:	75 76                	jne    80103228 <kfree+0x88>
801031b2:	81 fb f0 64 11 80    	cmp    $0x801164f0,%ebx
801031b8:	72 6e                	jb     80103228 <kfree+0x88>
801031ba:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801031c0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801031c5:	77 61                	ja     80103228 <kfree+0x88>
801031c7:	83 ec 04             	sub    $0x4,%esp
801031ca:	68 00 10 00 00       	push   $0x1000
801031cf:	6a 01                	push   $0x1
801031d1:	53                   	push   %ebx
801031d2:	e8 c9 21 00 00       	call   801053a0 <memset>
801031d7:	8b 15 94 26 11 80    	mov    0x80112694,%edx
801031dd:	83 c4 10             	add    $0x10,%esp
801031e0:	85 d2                	test   %edx,%edx
801031e2:	75 1c                	jne    80103200 <kfree+0x60>
801031e4:	a1 98 26 11 80       	mov    0x80112698,%eax
801031e9:	89 03                	mov    %eax,(%ebx)
801031eb:	a1 94 26 11 80       	mov    0x80112694,%eax
801031f0:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
801031f6:	85 c0                	test   %eax,%eax
801031f8:	75 1e                	jne    80103218 <kfree+0x78>
801031fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031fd:	c9                   	leave
801031fe:	c3                   	ret
801031ff:	90                   	nop
80103200:	83 ec 0c             	sub    $0xc,%esp
80103203:	68 60 26 11 80       	push   $0x80112660
80103208:	e8 93 20 00 00       	call   801052a0 <acquire>
8010320d:	83 c4 10             	add    $0x10,%esp
80103210:	eb d2                	jmp    801031e4 <kfree+0x44>
80103212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103218:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
8010321f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103222:	c9                   	leave
80103223:	e9 18 20 00 00       	jmp    80105240 <release>
80103228:	83 ec 0c             	sub    $0xc,%esp
8010322b:	68 2e 80 10 80       	push   $0x8010802e
80103230:	e8 5b d8 ff ff       	call   80100a90 <panic>
80103235:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010323c:	00 
8010323d:	8d 76 00             	lea    0x0(%esi),%esi

80103240 <freerange>:
80103240:	55                   	push   %ebp
80103241:	89 e5                	mov    %esp,%ebp
80103243:	56                   	push   %esi
80103244:	53                   	push   %ebx
80103245:	8b 45 08             	mov    0x8(%ebp),%eax
80103248:	8b 75 0c             	mov    0xc(%ebp),%esi
8010324b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103251:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80103257:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010325d:	39 de                	cmp    %ebx,%esi
8010325f:	72 23                	jb     80103284 <freerange+0x44>
80103261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103268:	83 ec 0c             	sub    $0xc,%esp
8010326b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80103271:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80103277:	50                   	push   %eax
80103278:	e8 23 ff ff ff       	call   801031a0 <kfree>
8010327d:	83 c4 10             	add    $0x10,%esp
80103280:	39 de                	cmp    %ebx,%esi
80103282:	73 e4                	jae    80103268 <freerange+0x28>
80103284:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103287:	5b                   	pop    %ebx
80103288:	5e                   	pop    %esi
80103289:	5d                   	pop    %ebp
8010328a:	c3                   	ret
8010328b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103290 <kinit2>:
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	56                   	push   %esi
80103294:	53                   	push   %ebx
80103295:	8b 45 08             	mov    0x8(%ebp),%eax
80103298:	8b 75 0c             	mov    0xc(%ebp),%esi
8010329b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801032a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801032a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801032ad:	39 de                	cmp    %ebx,%esi
801032af:	72 23                	jb     801032d4 <kinit2+0x44>
801032b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032b8:	83 ec 0c             	sub    $0xc,%esp
801032bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801032c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801032c7:	50                   	push   %eax
801032c8:	e8 d3 fe ff ff       	call   801031a0 <kfree>
801032cd:	83 c4 10             	add    $0x10,%esp
801032d0:	39 de                	cmp    %ebx,%esi
801032d2:	73 e4                	jae    801032b8 <kinit2+0x28>
801032d4:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801032db:	00 00 00 
801032de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801032e1:	5b                   	pop    %ebx
801032e2:	5e                   	pop    %esi
801032e3:	5d                   	pop    %ebp
801032e4:	c3                   	ret
801032e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032ec:	00 
801032ed:	8d 76 00             	lea    0x0(%esi),%esi

801032f0 <kinit1>:
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	56                   	push   %esi
801032f4:	53                   	push   %ebx
801032f5:	8b 75 0c             	mov    0xc(%ebp),%esi
801032f8:	83 ec 08             	sub    $0x8,%esp
801032fb:	68 34 80 10 80       	push   $0x80108034
80103300:	68 60 26 11 80       	push   $0x80112660
80103305:	e8 a6 1d 00 00       	call   801050b0 <initlock>
8010330a:	8b 45 08             	mov    0x8(%ebp),%eax
8010330d:	83 c4 10             	add    $0x10,%esp
80103310:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80103317:	00 00 00 
8010331a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103320:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80103326:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010332c:	39 de                	cmp    %ebx,%esi
8010332e:	72 1c                	jb     8010334c <kinit1+0x5c>
80103330:	83 ec 0c             	sub    $0xc,%esp
80103333:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80103339:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010333f:	50                   	push   %eax
80103340:	e8 5b fe ff ff       	call   801031a0 <kfree>
80103345:	83 c4 10             	add    $0x10,%esp
80103348:	39 de                	cmp    %ebx,%esi
8010334a:	73 e4                	jae    80103330 <kinit1+0x40>
8010334c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010334f:	5b                   	pop    %ebx
80103350:	5e                   	pop    %esi
80103351:	5d                   	pop    %ebp
80103352:	c3                   	ret
80103353:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010335a:	00 
8010335b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103360 <kalloc>:
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	53                   	push   %ebx
80103364:	83 ec 04             	sub    $0x4,%esp
80103367:	a1 94 26 11 80       	mov    0x80112694,%eax
8010336c:	85 c0                	test   %eax,%eax
8010336e:	75 20                	jne    80103390 <kalloc+0x30>
80103370:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
80103376:	85 db                	test   %ebx,%ebx
80103378:	74 07                	je     80103381 <kalloc+0x21>
8010337a:	8b 03                	mov    (%ebx),%eax
8010337c:	a3 98 26 11 80       	mov    %eax,0x80112698
80103381:	89 d8                	mov    %ebx,%eax
80103383:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103386:	c9                   	leave
80103387:	c3                   	ret
80103388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010338f:	00 
80103390:	83 ec 0c             	sub    $0xc,%esp
80103393:	68 60 26 11 80       	push   $0x80112660
80103398:	e8 03 1f 00 00       	call   801052a0 <acquire>
8010339d:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
801033a3:	a1 94 26 11 80       	mov    0x80112694,%eax
801033a8:	83 c4 10             	add    $0x10,%esp
801033ab:	85 db                	test   %ebx,%ebx
801033ad:	74 08                	je     801033b7 <kalloc+0x57>
801033af:	8b 13                	mov    (%ebx),%edx
801033b1:	89 15 98 26 11 80    	mov    %edx,0x80112698
801033b7:	85 c0                	test   %eax,%eax
801033b9:	74 c6                	je     80103381 <kalloc+0x21>
801033bb:	83 ec 0c             	sub    $0xc,%esp
801033be:	68 60 26 11 80       	push   $0x80112660
801033c3:	e8 78 1e 00 00       	call   80105240 <release>
801033c8:	89 d8                	mov    %ebx,%eax
801033ca:	83 c4 10             	add    $0x10,%esp
801033cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033d0:	c9                   	leave
801033d1:	c3                   	ret
801033d2:	66 90                	xchg   %ax,%ax
801033d4:	66 90                	xchg   %ax,%ax
801033d6:	66 90                	xchg   %ax,%ax
801033d8:	66 90                	xchg   %ax,%ax
801033da:	66 90                	xchg   %ax,%ax
801033dc:	66 90                	xchg   %ax,%ax
801033de:	66 90                	xchg   %ax,%ax

801033e0 <kbdgetc>:
801033e0:	ba 64 00 00 00       	mov    $0x64,%edx
801033e5:	ec                   	in     (%dx),%al
801033e6:	a8 01                	test   $0x1,%al
801033e8:	0f 84 c2 00 00 00    	je     801034b0 <kbdgetc+0xd0>
801033ee:	55                   	push   %ebp
801033ef:	ba 60 00 00 00       	mov    $0x60,%edx
801033f4:	89 e5                	mov    %esp,%ebp
801033f6:	53                   	push   %ebx
801033f7:	ec                   	in     (%dx),%al
801033f8:	8b 1d 9c 26 11 80    	mov    0x8011269c,%ebx
801033fe:	0f b6 c8             	movzbl %al,%ecx
80103401:	3c e0                	cmp    $0xe0,%al
80103403:	74 5b                	je     80103460 <kbdgetc+0x80>
80103405:	89 da                	mov    %ebx,%edx
80103407:	83 e2 40             	and    $0x40,%edx
8010340a:	84 c0                	test   %al,%al
8010340c:	78 62                	js     80103470 <kbdgetc+0x90>
8010340e:	85 d2                	test   %edx,%edx
80103410:	74 09                	je     8010341b <kbdgetc+0x3b>
80103412:	83 c8 80             	or     $0xffffff80,%eax
80103415:	83 e3 bf             	and    $0xffffffbf,%ebx
80103418:	0f b6 c8             	movzbl %al,%ecx
8010341b:	0f b6 91 a0 86 10 80 	movzbl -0x7fef7960(%ecx),%edx
80103422:	0f b6 81 a0 85 10 80 	movzbl -0x7fef7a60(%ecx),%eax
80103429:	09 da                	or     %ebx,%edx
8010342b:	31 c2                	xor    %eax,%edx
8010342d:	89 d0                	mov    %edx,%eax
8010342f:	89 15 9c 26 11 80    	mov    %edx,0x8011269c
80103435:	83 e0 03             	and    $0x3,%eax
80103438:	83 e2 08             	and    $0x8,%edx
8010343b:	8b 04 85 80 85 10 80 	mov    -0x7fef7a80(,%eax,4),%eax
80103442:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
80103446:	74 0b                	je     80103453 <kbdgetc+0x73>
80103448:	8d 50 9f             	lea    -0x61(%eax),%edx
8010344b:	83 fa 19             	cmp    $0x19,%edx
8010344e:	77 48                	ja     80103498 <kbdgetc+0xb8>
80103450:	83 e8 20             	sub    $0x20,%eax
80103453:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103456:	c9                   	leave
80103457:	c3                   	ret
80103458:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010345f:	00 
80103460:	83 cb 40             	or     $0x40,%ebx
80103463:	31 c0                	xor    %eax,%eax
80103465:	89 1d 9c 26 11 80    	mov    %ebx,0x8011269c
8010346b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010346e:	c9                   	leave
8010346f:	c3                   	ret
80103470:	83 e0 7f             	and    $0x7f,%eax
80103473:	85 d2                	test   %edx,%edx
80103475:	0f 44 c8             	cmove  %eax,%ecx
80103478:	0f b6 81 a0 86 10 80 	movzbl -0x7fef7960(%ecx),%eax
8010347f:	83 c8 40             	or     $0x40,%eax
80103482:	0f b6 c0             	movzbl %al,%eax
80103485:	f7 d0                	not    %eax
80103487:	21 d8                	and    %ebx,%eax
80103489:	a3 9c 26 11 80       	mov    %eax,0x8011269c
8010348e:	31 c0                	xor    %eax,%eax
80103490:	eb d9                	jmp    8010346b <kbdgetc+0x8b>
80103492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103498:	8d 48 bf             	lea    -0x41(%eax),%ecx
8010349b:	8d 50 20             	lea    0x20(%eax),%edx
8010349e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034a1:	c9                   	leave
801034a2:	83 f9 1a             	cmp    $0x1a,%ecx
801034a5:	0f 42 c2             	cmovb  %edx,%eax
801034a8:	c3                   	ret
801034a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801034b5:	c3                   	ret
801034b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034bd:	00 
801034be:	66 90                	xchg   %ax,%ax

801034c0 <kbdintr>:
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	83 ec 14             	sub    $0x14,%esp
801034c6:	68 e0 33 10 80       	push   $0x801033e0
801034cb:	e8 f0 d9 ff ff       	call   80100ec0 <consoleintr>
801034d0:	83 c4 10             	add    $0x10,%esp
801034d3:	c9                   	leave
801034d4:	c3                   	ret
801034d5:	66 90                	xchg   %ax,%ax
801034d7:	66 90                	xchg   %ax,%ax
801034d9:	66 90                	xchg   %ax,%ax
801034db:	66 90                	xchg   %ax,%ax
801034dd:	66 90                	xchg   %ax,%ax
801034df:	90                   	nop

801034e0 <lapicinit>:
801034e0:	a1 a0 26 11 80       	mov    0x801126a0,%eax
801034e5:	85 c0                	test   %eax,%eax
801034e7:	0f 84 c3 00 00 00    	je     801035b0 <lapicinit+0xd0>
801034ed:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801034f4:	01 00 00 
801034f7:	8b 50 20             	mov    0x20(%eax),%edx
801034fa:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103501:	00 00 00 
80103504:	8b 50 20             	mov    0x20(%eax),%edx
80103507:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010350e:	00 02 00 
80103511:	8b 50 20             	mov    0x20(%eax),%edx
80103514:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010351b:	96 98 00 
8010351e:	8b 50 20             	mov    0x20(%eax),%edx
80103521:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103528:	00 01 00 
8010352b:	8b 50 20             	mov    0x20(%eax),%edx
8010352e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103535:	00 01 00 
80103538:	8b 50 20             	mov    0x20(%eax),%edx
8010353b:	8b 50 30             	mov    0x30(%eax),%edx
8010353e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80103544:	75 72                	jne    801035b8 <lapicinit+0xd8>
80103546:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010354d:	00 00 00 
80103550:	8b 50 20             	mov    0x20(%eax),%edx
80103553:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010355a:	00 00 00 
8010355d:	8b 50 20             	mov    0x20(%eax),%edx
80103560:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80103567:	00 00 00 
8010356a:	8b 50 20             	mov    0x20(%eax),%edx
8010356d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103574:	00 00 00 
80103577:	8b 50 20             	mov    0x20(%eax),%edx
8010357a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103581:	00 00 00 
80103584:	8b 50 20             	mov    0x20(%eax),%edx
80103587:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010358e:	85 08 00 
80103591:	8b 50 20             	mov    0x20(%eax),%edx
80103594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103598:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010359e:	80 e6 10             	and    $0x10,%dh
801035a1:	75 f5                	jne    80103598 <lapicinit+0xb8>
801035a3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801035aa:	00 00 00 
801035ad:	8b 40 20             	mov    0x20(%eax),%eax
801035b0:	c3                   	ret
801035b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035b8:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801035bf:	00 01 00 
801035c2:	8b 50 20             	mov    0x20(%eax),%edx
801035c5:	e9 7c ff ff ff       	jmp    80103546 <lapicinit+0x66>
801035ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801035d0 <lapicid>:
801035d0:	a1 a0 26 11 80       	mov    0x801126a0,%eax
801035d5:	85 c0                	test   %eax,%eax
801035d7:	74 07                	je     801035e0 <lapicid+0x10>
801035d9:	8b 40 20             	mov    0x20(%eax),%eax
801035dc:	c1 e8 18             	shr    $0x18,%eax
801035df:	c3                   	ret
801035e0:	31 c0                	xor    %eax,%eax
801035e2:	c3                   	ret
801035e3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801035ea:	00 
801035eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801035f0 <lapiceoi>:
801035f0:	a1 a0 26 11 80       	mov    0x801126a0,%eax
801035f5:	85 c0                	test   %eax,%eax
801035f7:	74 0d                	je     80103606 <lapiceoi+0x16>
801035f9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103600:	00 00 00 
80103603:	8b 40 20             	mov    0x20(%eax),%eax
80103606:	c3                   	ret
80103607:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010360e:	00 
8010360f:	90                   	nop

80103610 <microdelay>:
80103610:	c3                   	ret
80103611:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103618:	00 
80103619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103620 <lapicstartap>:
80103620:	55                   	push   %ebp
80103621:	b8 0f 00 00 00       	mov    $0xf,%eax
80103626:	ba 70 00 00 00       	mov    $0x70,%edx
8010362b:	89 e5                	mov    %esp,%ebp
8010362d:	53                   	push   %ebx
8010362e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103631:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103634:	ee                   	out    %al,(%dx)
80103635:	b8 0a 00 00 00       	mov    $0xa,%eax
8010363a:	ba 71 00 00 00       	mov    $0x71,%edx
8010363f:	ee                   	out    %al,(%dx)
80103640:	31 c0                	xor    %eax,%eax
80103642:	c1 e3 18             	shl    $0x18,%ebx
80103645:	66 a3 67 04 00 80    	mov    %ax,0x80000467
8010364b:	89 c8                	mov    %ecx,%eax
8010364d:	c1 e9 0c             	shr    $0xc,%ecx
80103650:	89 da                	mov    %ebx,%edx
80103652:	c1 e8 04             	shr    $0x4,%eax
80103655:	80 cd 06             	or     $0x6,%ch
80103658:	66 a3 69 04 00 80    	mov    %ax,0x80000469
8010365e:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80103663:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80103669:	8b 58 20             	mov    0x20(%eax),%ebx
8010366c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103673:	c5 00 00 
80103676:	8b 58 20             	mov    0x20(%eax),%ebx
80103679:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103680:	85 00 00 
80103683:	8b 58 20             	mov    0x20(%eax),%ebx
80103686:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010368c:	8b 58 20             	mov    0x20(%eax),%ebx
8010368f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80103695:	8b 58 20             	mov    0x20(%eax),%ebx
80103698:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010369e:	8b 50 20             	mov    0x20(%eax),%edx
801036a1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
801036a7:	8b 40 20             	mov    0x20(%eax),%eax
801036aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036ad:	c9                   	leave
801036ae:	c3                   	ret
801036af:	90                   	nop

801036b0 <cmostime>:
801036b0:	55                   	push   %ebp
801036b1:	b8 0b 00 00 00       	mov    $0xb,%eax
801036b6:	ba 70 00 00 00       	mov    $0x70,%edx
801036bb:	89 e5                	mov    %esp,%ebp
801036bd:	57                   	push   %edi
801036be:	56                   	push   %esi
801036bf:	53                   	push   %ebx
801036c0:	83 ec 4c             	sub    $0x4c,%esp
801036c3:	ee                   	out    %al,(%dx)
801036c4:	ba 71 00 00 00       	mov    $0x71,%edx
801036c9:	ec                   	in     (%dx),%al
801036ca:	83 e0 04             	and    $0x4,%eax
801036cd:	bf 70 00 00 00       	mov    $0x70,%edi
801036d2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801036d5:	8d 76 00             	lea    0x0(%esi),%esi
801036d8:	31 c0                	xor    %eax,%eax
801036da:	89 fa                	mov    %edi,%edx
801036dc:	ee                   	out    %al,(%dx)
801036dd:	b9 71 00 00 00       	mov    $0x71,%ecx
801036e2:	89 ca                	mov    %ecx,%edx
801036e4:	ec                   	in     (%dx),%al
801036e5:	88 45 b7             	mov    %al,-0x49(%ebp)
801036e8:	89 fa                	mov    %edi,%edx
801036ea:	b8 02 00 00 00       	mov    $0x2,%eax
801036ef:	ee                   	out    %al,(%dx)
801036f0:	89 ca                	mov    %ecx,%edx
801036f2:	ec                   	in     (%dx),%al
801036f3:	88 45 b6             	mov    %al,-0x4a(%ebp)
801036f6:	89 fa                	mov    %edi,%edx
801036f8:	b8 04 00 00 00       	mov    $0x4,%eax
801036fd:	ee                   	out    %al,(%dx)
801036fe:	89 ca                	mov    %ecx,%edx
80103700:	ec                   	in     (%dx),%al
80103701:	88 45 b5             	mov    %al,-0x4b(%ebp)
80103704:	89 fa                	mov    %edi,%edx
80103706:	b8 07 00 00 00       	mov    $0x7,%eax
8010370b:	ee                   	out    %al,(%dx)
8010370c:	89 ca                	mov    %ecx,%edx
8010370e:	ec                   	in     (%dx),%al
8010370f:	88 45 b4             	mov    %al,-0x4c(%ebp)
80103712:	89 fa                	mov    %edi,%edx
80103714:	b8 08 00 00 00       	mov    $0x8,%eax
80103719:	ee                   	out    %al,(%dx)
8010371a:	89 ca                	mov    %ecx,%edx
8010371c:	ec                   	in     (%dx),%al
8010371d:	89 c6                	mov    %eax,%esi
8010371f:	89 fa                	mov    %edi,%edx
80103721:	b8 09 00 00 00       	mov    $0x9,%eax
80103726:	ee                   	out    %al,(%dx)
80103727:	89 ca                	mov    %ecx,%edx
80103729:	ec                   	in     (%dx),%al
8010372a:	0f b6 d8             	movzbl %al,%ebx
8010372d:	89 fa                	mov    %edi,%edx
8010372f:	b8 0a 00 00 00       	mov    $0xa,%eax
80103734:	ee                   	out    %al,(%dx)
80103735:	89 ca                	mov    %ecx,%edx
80103737:	ec                   	in     (%dx),%al
80103738:	84 c0                	test   %al,%al
8010373a:	78 9c                	js     801036d8 <cmostime+0x28>
8010373c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103740:	89 f2                	mov    %esi,%edx
80103742:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80103745:	0f b6 f2             	movzbl %dl,%esi
80103748:	89 fa                	mov    %edi,%edx
8010374a:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010374d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103751:	89 75 c8             	mov    %esi,-0x38(%ebp)
80103754:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103757:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010375b:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010375e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103762:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103765:	31 c0                	xor    %eax,%eax
80103767:	ee                   	out    %al,(%dx)
80103768:	89 ca                	mov    %ecx,%edx
8010376a:	ec                   	in     (%dx),%al
8010376b:	0f b6 c0             	movzbl %al,%eax
8010376e:	89 fa                	mov    %edi,%edx
80103770:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103773:	b8 02 00 00 00       	mov    $0x2,%eax
80103778:	ee                   	out    %al,(%dx)
80103779:	89 ca                	mov    %ecx,%edx
8010377b:	ec                   	in     (%dx),%al
8010377c:	0f b6 c0             	movzbl %al,%eax
8010377f:	89 fa                	mov    %edi,%edx
80103781:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103784:	b8 04 00 00 00       	mov    $0x4,%eax
80103789:	ee                   	out    %al,(%dx)
8010378a:	89 ca                	mov    %ecx,%edx
8010378c:	ec                   	in     (%dx),%al
8010378d:	0f b6 c0             	movzbl %al,%eax
80103790:	89 fa                	mov    %edi,%edx
80103792:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103795:	b8 07 00 00 00       	mov    $0x7,%eax
8010379a:	ee                   	out    %al,(%dx)
8010379b:	89 ca                	mov    %ecx,%edx
8010379d:	ec                   	in     (%dx),%al
8010379e:	0f b6 c0             	movzbl %al,%eax
801037a1:	89 fa                	mov    %edi,%edx
801037a3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801037a6:	b8 08 00 00 00       	mov    $0x8,%eax
801037ab:	ee                   	out    %al,(%dx)
801037ac:	89 ca                	mov    %ecx,%edx
801037ae:	ec                   	in     (%dx),%al
801037af:	0f b6 c0             	movzbl %al,%eax
801037b2:	89 fa                	mov    %edi,%edx
801037b4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801037b7:	b8 09 00 00 00       	mov    $0x9,%eax
801037bc:	ee                   	out    %al,(%dx)
801037bd:	89 ca                	mov    %ecx,%edx
801037bf:	ec                   	in     (%dx),%al
801037c0:	0f b6 c0             	movzbl %al,%eax
801037c3:	83 ec 04             	sub    $0x4,%esp
801037c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801037c9:	8d 45 d0             	lea    -0x30(%ebp),%eax
801037cc:	6a 18                	push   $0x18
801037ce:	50                   	push   %eax
801037cf:	8d 45 b8             	lea    -0x48(%ebp),%eax
801037d2:	50                   	push   %eax
801037d3:	e8 08 1c 00 00       	call   801053e0 <memcmp>
801037d8:	83 c4 10             	add    $0x10,%esp
801037db:	85 c0                	test   %eax,%eax
801037dd:	0f 85 f5 fe ff ff    	jne    801036d8 <cmostime+0x28>
801037e3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
801037e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037ea:	89 f0                	mov    %esi,%eax
801037ec:	84 c0                	test   %al,%al
801037ee:	75 78                	jne    80103868 <cmostime+0x1b8>
801037f0:	8b 45 b8             	mov    -0x48(%ebp),%eax
801037f3:	89 c2                	mov    %eax,%edx
801037f5:	83 e0 0f             	and    $0xf,%eax
801037f8:	c1 ea 04             	shr    $0x4,%edx
801037fb:	8d 14 92             	lea    (%edx,%edx,4),%edx
801037fe:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103801:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103804:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103807:	89 c2                	mov    %eax,%edx
80103809:	83 e0 0f             	and    $0xf,%eax
8010380c:	c1 ea 04             	shr    $0x4,%edx
8010380f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103812:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103815:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103818:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010381b:	89 c2                	mov    %eax,%edx
8010381d:	83 e0 0f             	and    $0xf,%eax
80103820:	c1 ea 04             	shr    $0x4,%edx
80103823:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103826:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103829:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010382c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010382f:	89 c2                	mov    %eax,%edx
80103831:	83 e0 0f             	and    $0xf,%eax
80103834:	c1 ea 04             	shr    $0x4,%edx
80103837:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010383a:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010383d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103840:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103843:	89 c2                	mov    %eax,%edx
80103845:	83 e0 0f             	and    $0xf,%eax
80103848:	c1 ea 04             	shr    $0x4,%edx
8010384b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010384e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103851:	89 45 c8             	mov    %eax,-0x38(%ebp)
80103854:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103857:	89 c2                	mov    %eax,%edx
80103859:	83 e0 0f             	and    $0xf,%eax
8010385c:	c1 ea 04             	shr    $0x4,%edx
8010385f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103862:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103865:	89 45 cc             	mov    %eax,-0x34(%ebp)
80103868:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010386b:	89 03                	mov    %eax,(%ebx)
8010386d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103870:	89 43 04             	mov    %eax,0x4(%ebx)
80103873:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103876:	89 43 08             	mov    %eax,0x8(%ebx)
80103879:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010387c:	89 43 0c             	mov    %eax,0xc(%ebx)
8010387f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103882:	89 43 10             	mov    %eax,0x10(%ebx)
80103885:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103888:	89 43 14             	mov    %eax,0x14(%ebx)
8010388b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
80103892:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103895:	5b                   	pop    %ebx
80103896:	5e                   	pop    %esi
80103897:	5f                   	pop    %edi
80103898:	5d                   	pop    %ebp
80103899:	c3                   	ret
8010389a:	66 90                	xchg   %ax,%ax
8010389c:	66 90                	xchg   %ax,%ax
8010389e:	66 90                	xchg   %ax,%ax

801038a0 <install_trans>:
801038a0:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
801038a6:	85 c9                	test   %ecx,%ecx
801038a8:	0f 8e 8a 00 00 00    	jle    80103938 <install_trans+0x98>
801038ae:	55                   	push   %ebp
801038af:	89 e5                	mov    %esp,%ebp
801038b1:	57                   	push   %edi
801038b2:	31 ff                	xor    %edi,%edi
801038b4:	56                   	push   %esi
801038b5:	53                   	push   %ebx
801038b6:	83 ec 0c             	sub    $0xc,%esp
801038b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038c0:	a1 f4 26 11 80       	mov    0x801126f4,%eax
801038c5:	83 ec 08             	sub    $0x8,%esp
801038c8:	01 f8                	add    %edi,%eax
801038ca:	83 c0 01             	add    $0x1,%eax
801038cd:	50                   	push   %eax
801038ce:	ff 35 04 27 11 80    	push   0x80112704
801038d4:	e8 f7 c7 ff ff       	call   801000d0 <bread>
801038d9:	89 c6                	mov    %eax,%esi
801038db:	58                   	pop    %eax
801038dc:	5a                   	pop    %edx
801038dd:	ff 34 bd 0c 27 11 80 	push   -0x7feed8f4(,%edi,4)
801038e4:	ff 35 04 27 11 80    	push   0x80112704
801038ea:	83 c7 01             	add    $0x1,%edi
801038ed:	e8 de c7 ff ff       	call   801000d0 <bread>
801038f2:	83 c4 0c             	add    $0xc,%esp
801038f5:	89 c3                	mov    %eax,%ebx
801038f7:	8d 46 5c             	lea    0x5c(%esi),%eax
801038fa:	68 00 02 00 00       	push   $0x200
801038ff:	50                   	push   %eax
80103900:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103903:	50                   	push   %eax
80103904:	e8 27 1b 00 00       	call   80105430 <memmove>
80103909:	89 1c 24             	mov    %ebx,(%esp)
8010390c:	e8 9f c8 ff ff       	call   801001b0 <bwrite>
80103911:	89 34 24             	mov    %esi,(%esp)
80103914:	e8 d7 c8 ff ff       	call   801001f0 <brelse>
80103919:	89 1c 24             	mov    %ebx,(%esp)
8010391c:	e8 cf c8 ff ff       	call   801001f0 <brelse>
80103921:	83 c4 10             	add    $0x10,%esp
80103924:	39 3d 08 27 11 80    	cmp    %edi,0x80112708
8010392a:	7f 94                	jg     801038c0 <install_trans+0x20>
8010392c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010392f:	5b                   	pop    %ebx
80103930:	5e                   	pop    %esi
80103931:	5f                   	pop    %edi
80103932:	5d                   	pop    %ebp
80103933:	c3                   	ret
80103934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103938:	c3                   	ret
80103939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103940 <write_head>:
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	53                   	push   %ebx
80103944:	83 ec 0c             	sub    $0xc,%esp
80103947:	ff 35 f4 26 11 80    	push   0x801126f4
8010394d:	ff 35 04 27 11 80    	push   0x80112704
80103953:	e8 78 c7 ff ff       	call   801000d0 <bread>
80103958:	83 c4 10             	add    $0x10,%esp
8010395b:	89 c3                	mov    %eax,%ebx
8010395d:	a1 08 27 11 80       	mov    0x80112708,%eax
80103962:	89 43 5c             	mov    %eax,0x5c(%ebx)
80103965:	85 c0                	test   %eax,%eax
80103967:	7e 19                	jle    80103982 <write_head+0x42>
80103969:	31 d2                	xor    %edx,%edx
8010396b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103970:	8b 0c 95 0c 27 11 80 	mov    -0x7feed8f4(,%edx,4),%ecx
80103977:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
8010397b:	83 c2 01             	add    $0x1,%edx
8010397e:	39 d0                	cmp    %edx,%eax
80103980:	75 ee                	jne    80103970 <write_head+0x30>
80103982:	83 ec 0c             	sub    $0xc,%esp
80103985:	53                   	push   %ebx
80103986:	e8 25 c8 ff ff       	call   801001b0 <bwrite>
8010398b:	89 1c 24             	mov    %ebx,(%esp)
8010398e:	e8 5d c8 ff ff       	call   801001f0 <brelse>
80103993:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103996:	83 c4 10             	add    $0x10,%esp
80103999:	c9                   	leave
8010399a:	c3                   	ret
8010399b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801039a0 <initlog>:
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
801039a4:	83 ec 2c             	sub    $0x2c,%esp
801039a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801039aa:	68 39 80 10 80       	push   $0x80108039
801039af:	68 c0 26 11 80       	push   $0x801126c0
801039b4:	e8 f7 16 00 00       	call   801050b0 <initlock>
801039b9:	58                   	pop    %eax
801039ba:	8d 45 dc             	lea    -0x24(%ebp),%eax
801039bd:	5a                   	pop    %edx
801039be:	50                   	push   %eax
801039bf:	53                   	push   %ebx
801039c0:	e8 7b e8 ff ff       	call   80102240 <readsb>
801039c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801039c8:	59                   	pop    %ecx
801039c9:	89 1d 04 27 11 80    	mov    %ebx,0x80112704
801039cf:	8b 55 e8             	mov    -0x18(%ebp),%edx
801039d2:	a3 f4 26 11 80       	mov    %eax,0x801126f4
801039d7:	89 15 f8 26 11 80    	mov    %edx,0x801126f8
801039dd:	5a                   	pop    %edx
801039de:	50                   	push   %eax
801039df:	53                   	push   %ebx
801039e0:	e8 eb c6 ff ff       	call   801000d0 <bread>
801039e5:	83 c4 10             	add    $0x10,%esp
801039e8:	8b 58 5c             	mov    0x5c(%eax),%ebx
801039eb:	89 1d 08 27 11 80    	mov    %ebx,0x80112708
801039f1:	85 db                	test   %ebx,%ebx
801039f3:	7e 1d                	jle    80103a12 <initlog+0x72>
801039f5:	31 d2                	xor    %edx,%edx
801039f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039fe:	00 
801039ff:	90                   	nop
80103a00:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103a04:	89 0c 95 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%edx,4)
80103a0b:	83 c2 01             	add    $0x1,%edx
80103a0e:	39 d3                	cmp    %edx,%ebx
80103a10:	75 ee                	jne    80103a00 <initlog+0x60>
80103a12:	83 ec 0c             	sub    $0xc,%esp
80103a15:	50                   	push   %eax
80103a16:	e8 d5 c7 ff ff       	call   801001f0 <brelse>
80103a1b:	e8 80 fe ff ff       	call   801038a0 <install_trans>
80103a20:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
80103a27:	00 00 00 
80103a2a:	e8 11 ff ff ff       	call   80103940 <write_head>
80103a2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a32:	83 c4 10             	add    $0x10,%esp
80103a35:	c9                   	leave
80103a36:	c3                   	ret
80103a37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a3e:	00 
80103a3f:	90                   	nop

80103a40 <begin_op>:
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	83 ec 14             	sub    $0x14,%esp
80103a46:	68 c0 26 11 80       	push   $0x801126c0
80103a4b:	e8 50 18 00 00       	call   801052a0 <acquire>
80103a50:	83 c4 10             	add    $0x10,%esp
80103a53:	eb 18                	jmp    80103a6d <begin_op+0x2d>
80103a55:	8d 76 00             	lea    0x0(%esi),%esi
80103a58:	83 ec 08             	sub    $0x8,%esp
80103a5b:	68 c0 26 11 80       	push   $0x801126c0
80103a60:	68 c0 26 11 80       	push   $0x801126c0
80103a65:	e8 b6 12 00 00       	call   80104d20 <sleep>
80103a6a:	83 c4 10             	add    $0x10,%esp
80103a6d:	a1 00 27 11 80       	mov    0x80112700,%eax
80103a72:	85 c0                	test   %eax,%eax
80103a74:	75 e2                	jne    80103a58 <begin_op+0x18>
80103a76:	a1 fc 26 11 80       	mov    0x801126fc,%eax
80103a7b:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80103a81:	83 c0 01             	add    $0x1,%eax
80103a84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103a87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103a8a:	83 fa 1e             	cmp    $0x1e,%edx
80103a8d:	7f c9                	jg     80103a58 <begin_op+0x18>
80103a8f:	83 ec 0c             	sub    $0xc,%esp
80103a92:	a3 fc 26 11 80       	mov    %eax,0x801126fc
80103a97:	68 c0 26 11 80       	push   $0x801126c0
80103a9c:	e8 9f 17 00 00       	call   80105240 <release>
80103aa1:	83 c4 10             	add    $0x10,%esp
80103aa4:	c9                   	leave
80103aa5:	c3                   	ret
80103aa6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103aad:	00 
80103aae:	66 90                	xchg   %ax,%ax

80103ab0 <end_op>:
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	57                   	push   %edi
80103ab4:	56                   	push   %esi
80103ab5:	53                   	push   %ebx
80103ab6:	83 ec 18             	sub    $0x18,%esp
80103ab9:	68 c0 26 11 80       	push   $0x801126c0
80103abe:	e8 dd 17 00 00       	call   801052a0 <acquire>
80103ac3:	a1 fc 26 11 80       	mov    0x801126fc,%eax
80103ac8:	8b 35 00 27 11 80    	mov    0x80112700,%esi
80103ace:	83 c4 10             	add    $0x10,%esp
80103ad1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103ad4:	89 1d fc 26 11 80    	mov    %ebx,0x801126fc
80103ada:	85 f6                	test   %esi,%esi
80103adc:	0f 85 22 01 00 00    	jne    80103c04 <end_op+0x154>
80103ae2:	85 db                	test   %ebx,%ebx
80103ae4:	0f 85 f6 00 00 00    	jne    80103be0 <end_op+0x130>
80103aea:	c7 05 00 27 11 80 01 	movl   $0x1,0x80112700
80103af1:	00 00 00 
80103af4:	83 ec 0c             	sub    $0xc,%esp
80103af7:	68 c0 26 11 80       	push   $0x801126c0
80103afc:	e8 3f 17 00 00       	call   80105240 <release>
80103b01:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
80103b07:	83 c4 10             	add    $0x10,%esp
80103b0a:	85 c9                	test   %ecx,%ecx
80103b0c:	7f 42                	jg     80103b50 <end_op+0xa0>
80103b0e:	83 ec 0c             	sub    $0xc,%esp
80103b11:	68 c0 26 11 80       	push   $0x801126c0
80103b16:	e8 85 17 00 00       	call   801052a0 <acquire>
80103b1b:	c7 05 00 27 11 80 00 	movl   $0x0,0x80112700
80103b22:	00 00 00 
80103b25:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
80103b2c:	e8 af 12 00 00       	call   80104de0 <wakeup>
80103b31:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
80103b38:	e8 03 17 00 00       	call   80105240 <release>
80103b3d:	83 c4 10             	add    $0x10,%esp
80103b40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b43:	5b                   	pop    %ebx
80103b44:	5e                   	pop    %esi
80103b45:	5f                   	pop    %edi
80103b46:	5d                   	pop    %ebp
80103b47:	c3                   	ret
80103b48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b4f:	00 
80103b50:	a1 f4 26 11 80       	mov    0x801126f4,%eax
80103b55:	83 ec 08             	sub    $0x8,%esp
80103b58:	01 d8                	add    %ebx,%eax
80103b5a:	83 c0 01             	add    $0x1,%eax
80103b5d:	50                   	push   %eax
80103b5e:	ff 35 04 27 11 80    	push   0x80112704
80103b64:	e8 67 c5 ff ff       	call   801000d0 <bread>
80103b69:	89 c6                	mov    %eax,%esi
80103b6b:	58                   	pop    %eax
80103b6c:	5a                   	pop    %edx
80103b6d:	ff 34 9d 0c 27 11 80 	push   -0x7feed8f4(,%ebx,4)
80103b74:	ff 35 04 27 11 80    	push   0x80112704
80103b7a:	83 c3 01             	add    $0x1,%ebx
80103b7d:	e8 4e c5 ff ff       	call   801000d0 <bread>
80103b82:	83 c4 0c             	add    $0xc,%esp
80103b85:	89 c7                	mov    %eax,%edi
80103b87:	8d 40 5c             	lea    0x5c(%eax),%eax
80103b8a:	68 00 02 00 00       	push   $0x200
80103b8f:	50                   	push   %eax
80103b90:	8d 46 5c             	lea    0x5c(%esi),%eax
80103b93:	50                   	push   %eax
80103b94:	e8 97 18 00 00       	call   80105430 <memmove>
80103b99:	89 34 24             	mov    %esi,(%esp)
80103b9c:	e8 0f c6 ff ff       	call   801001b0 <bwrite>
80103ba1:	89 3c 24             	mov    %edi,(%esp)
80103ba4:	e8 47 c6 ff ff       	call   801001f0 <brelse>
80103ba9:	89 34 24             	mov    %esi,(%esp)
80103bac:	e8 3f c6 ff ff       	call   801001f0 <brelse>
80103bb1:	83 c4 10             	add    $0x10,%esp
80103bb4:	3b 1d 08 27 11 80    	cmp    0x80112708,%ebx
80103bba:	7c 94                	jl     80103b50 <end_op+0xa0>
80103bbc:	e8 7f fd ff ff       	call   80103940 <write_head>
80103bc1:	e8 da fc ff ff       	call   801038a0 <install_trans>
80103bc6:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
80103bcd:	00 00 00 
80103bd0:	e8 6b fd ff ff       	call   80103940 <write_head>
80103bd5:	e9 34 ff ff ff       	jmp    80103b0e <end_op+0x5e>
80103bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103be0:	83 ec 0c             	sub    $0xc,%esp
80103be3:	68 c0 26 11 80       	push   $0x801126c0
80103be8:	e8 f3 11 00 00       	call   80104de0 <wakeup>
80103bed:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
80103bf4:	e8 47 16 00 00       	call   80105240 <release>
80103bf9:	83 c4 10             	add    $0x10,%esp
80103bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bff:	5b                   	pop    %ebx
80103c00:	5e                   	pop    %esi
80103c01:	5f                   	pop    %edi
80103c02:	5d                   	pop    %ebp
80103c03:	c3                   	ret
80103c04:	83 ec 0c             	sub    $0xc,%esp
80103c07:	68 3d 80 10 80       	push   $0x8010803d
80103c0c:	e8 7f ce ff ff       	call   80100a90 <panic>
80103c11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c18:	00 
80103c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c20 <log_write>:
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	53                   	push   %ebx
80103c24:	83 ec 04             	sub    $0x4,%esp
80103c27:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80103c2d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103c30:	83 fa 1d             	cmp    $0x1d,%edx
80103c33:	7f 7d                	jg     80103cb2 <log_write+0x92>
80103c35:	a1 f8 26 11 80       	mov    0x801126f8,%eax
80103c3a:	83 e8 01             	sub    $0x1,%eax
80103c3d:	39 c2                	cmp    %eax,%edx
80103c3f:	7d 71                	jge    80103cb2 <log_write+0x92>
80103c41:	a1 fc 26 11 80       	mov    0x801126fc,%eax
80103c46:	85 c0                	test   %eax,%eax
80103c48:	7e 75                	jle    80103cbf <log_write+0x9f>
80103c4a:	83 ec 0c             	sub    $0xc,%esp
80103c4d:	68 c0 26 11 80       	push   $0x801126c0
80103c52:	e8 49 16 00 00       	call   801052a0 <acquire>
80103c57:	8b 4b 08             	mov    0x8(%ebx),%ecx
80103c5a:	83 c4 10             	add    $0x10,%esp
80103c5d:	31 c0                	xor    %eax,%eax
80103c5f:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80103c65:	85 d2                	test   %edx,%edx
80103c67:	7f 0e                	jg     80103c77 <log_write+0x57>
80103c69:	eb 15                	jmp    80103c80 <log_write+0x60>
80103c6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c70:	83 c0 01             	add    $0x1,%eax
80103c73:	39 c2                	cmp    %eax,%edx
80103c75:	74 29                	je     80103ca0 <log_write+0x80>
80103c77:	39 0c 85 0c 27 11 80 	cmp    %ecx,-0x7feed8f4(,%eax,4)
80103c7e:	75 f0                	jne    80103c70 <log_write+0x50>
80103c80:	89 0c 85 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%eax,4)
80103c87:	39 c2                	cmp    %eax,%edx
80103c89:	74 1c                	je     80103ca7 <log_write+0x87>
80103c8b:	83 0b 04             	orl    $0x4,(%ebx)
80103c8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c91:	c7 45 08 c0 26 11 80 	movl   $0x801126c0,0x8(%ebp)
80103c98:	c9                   	leave
80103c99:	e9 a2 15 00 00       	jmp    80105240 <release>
80103c9e:	66 90                	xchg   %ax,%ax
80103ca0:	89 0c 95 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%edx,4)
80103ca7:	83 c2 01             	add    $0x1,%edx
80103caa:	89 15 08 27 11 80    	mov    %edx,0x80112708
80103cb0:	eb d9                	jmp    80103c8b <log_write+0x6b>
80103cb2:	83 ec 0c             	sub    $0xc,%esp
80103cb5:	68 4c 80 10 80       	push   $0x8010804c
80103cba:	e8 d1 cd ff ff       	call   80100a90 <panic>
80103cbf:	83 ec 0c             	sub    $0xc,%esp
80103cc2:	68 62 80 10 80       	push   $0x80108062
80103cc7:	e8 c4 cd ff ff       	call   80100a90 <panic>
80103ccc:	66 90                	xchg   %ax,%ax
80103cce:	66 90                	xchg   %ax,%ax

80103cd0 <mpmain>:
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	53                   	push   %ebx
80103cd4:	83 ec 04             	sub    $0x4,%esp
80103cd7:	e8 64 09 00 00       	call   80104640 <cpuid>
80103cdc:	89 c3                	mov    %eax,%ebx
80103cde:	e8 5d 09 00 00       	call   80104640 <cpuid>
80103ce3:	83 ec 04             	sub    $0x4,%esp
80103ce6:	53                   	push   %ebx
80103ce7:	50                   	push   %eax
80103ce8:	68 7d 80 10 80       	push   $0x8010807d
80103ced:	e8 4e cb ff ff       	call   80100840 <cprintf>
80103cf2:	e8 e9 28 00 00       	call   801065e0 <idtinit>
80103cf7:	e8 e4 08 00 00       	call   801045e0 <mycpu>
80103cfc:	89 c2                	mov    %eax,%edx
80103cfe:	b8 01 00 00 00       	mov    $0x1,%eax
80103d03:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
80103d0a:	e8 01 0c 00 00       	call   80104910 <scheduler>
80103d0f:	90                   	nop

80103d10 <mpenter>:
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	83 ec 08             	sub    $0x8,%esp
80103d16:	e8 c5 39 00 00       	call   801076e0 <switchkvm>
80103d1b:	e8 30 39 00 00       	call   80107650 <seginit>
80103d20:	e8 bb f7 ff ff       	call   801034e0 <lapicinit>
80103d25:	e8 a6 ff ff ff       	call   80103cd0 <mpmain>
80103d2a:	66 90                	xchg   %ax,%ax
80103d2c:	66 90                	xchg   %ax,%ax
80103d2e:	66 90                	xchg   %ax,%ax

80103d30 <main>:
80103d30:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103d34:	83 e4 f0             	and    $0xfffffff0,%esp
80103d37:	ff 71 fc             	push   -0x4(%ecx)
80103d3a:	55                   	push   %ebp
80103d3b:	89 e5                	mov    %esp,%ebp
80103d3d:	53                   	push   %ebx
80103d3e:	51                   	push   %ecx
80103d3f:	83 ec 08             	sub    $0x8,%esp
80103d42:	68 00 00 40 80       	push   $0x80400000
80103d47:	68 f0 64 11 80       	push   $0x801164f0
80103d4c:	e8 9f f5 ff ff       	call   801032f0 <kinit1>
80103d51:	e8 4a 3e 00 00       	call   80107ba0 <kvmalloc>
80103d56:	e8 85 01 00 00       	call   80103ee0 <mpinit>
80103d5b:	e8 80 f7 ff ff       	call   801034e0 <lapicinit>
80103d60:	e8 eb 38 00 00       	call   80107650 <seginit>
80103d65:	e8 86 03 00 00       	call   801040f0 <picinit>
80103d6a:	e8 51 f3 ff ff       	call   801030c0 <ioapicinit>
80103d6f:	e8 8c d0 ff ff       	call   80100e00 <consoleinit>
80103d74:	e8 47 2b 00 00       	call   801068c0 <uartinit>
80103d79:	e8 42 08 00 00       	call   801045c0 <pinit>
80103d7e:	e8 dd 27 00 00       	call   80106560 <tvinit>
80103d83:	e8 b8 c2 ff ff       	call   80100040 <binit>
80103d88:	e8 a3 dd ff ff       	call   80101b30 <fileinit>
80103d8d:	e8 0e f1 ff ff       	call   80102ea0 <ideinit>
80103d92:	83 c4 0c             	add    $0xc,%esp
80103d95:	68 8a 00 00 00       	push   $0x8a
80103d9a:	68 8c b4 10 80       	push   $0x8010b48c
80103d9f:	68 00 70 00 80       	push   $0x80007000
80103da4:	e8 87 16 00 00       	call   80105430 <memmove>
80103da9:	83 c4 10             	add    $0x10,%esp
80103dac:	69 05 a4 27 11 80 b0 	imul   $0xb0,0x801127a4,%eax
80103db3:	00 00 00 
80103db6:	05 c0 27 11 80       	add    $0x801127c0,%eax
80103dbb:	3d c0 27 11 80       	cmp    $0x801127c0,%eax
80103dc0:	76 7e                	jbe    80103e40 <main+0x110>
80103dc2:	bb c0 27 11 80       	mov    $0x801127c0,%ebx
80103dc7:	eb 20                	jmp    80103de9 <main+0xb9>
80103dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dd0:	69 05 a4 27 11 80 b0 	imul   $0xb0,0x801127a4,%eax
80103dd7:	00 00 00 
80103dda:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103de0:	05 c0 27 11 80       	add    $0x801127c0,%eax
80103de5:	39 c3                	cmp    %eax,%ebx
80103de7:	73 57                	jae    80103e40 <main+0x110>
80103de9:	e8 f2 07 00 00       	call   801045e0 <mycpu>
80103dee:	39 c3                	cmp    %eax,%ebx
80103df0:	74 de                	je     80103dd0 <main+0xa0>
80103df2:	e8 69 f5 ff ff       	call   80103360 <kalloc>
80103df7:	83 ec 08             	sub    $0x8,%esp
80103dfa:	c7 05 f8 6f 00 80 10 	movl   $0x80103d10,0x80006ff8
80103e01:	3d 10 80 
80103e04:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103e0b:	a0 10 00 
80103e0e:	05 00 10 00 00       	add    $0x1000,%eax
80103e13:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
80103e18:	0f b6 03             	movzbl (%ebx),%eax
80103e1b:	68 00 70 00 00       	push   $0x7000
80103e20:	50                   	push   %eax
80103e21:	e8 fa f7 ff ff       	call   80103620 <lapicstartap>
80103e26:	83 c4 10             	add    $0x10,%esp
80103e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e30:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103e36:	85 c0                	test   %eax,%eax
80103e38:	74 f6                	je     80103e30 <main+0x100>
80103e3a:	eb 94                	jmp    80103dd0 <main+0xa0>
80103e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e40:	83 ec 08             	sub    $0x8,%esp
80103e43:	68 00 00 00 8e       	push   $0x8e000000
80103e48:	68 00 00 40 80       	push   $0x80400000
80103e4d:	e8 3e f4 ff ff       	call   80103290 <kinit2>
80103e52:	e8 39 08 00 00       	call   80104690 <userinit>
80103e57:	e8 74 fe ff ff       	call   80103cd0 <mpmain>
80103e5c:	66 90                	xchg   %ax,%ax
80103e5e:	66 90                	xchg   %ax,%ax

80103e60 <mpsearch1>:
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
80103e65:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
80103e6b:	53                   	push   %ebx
80103e6c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
80103e6f:	83 ec 0c             	sub    $0xc,%esp
80103e72:	39 de                	cmp    %ebx,%esi
80103e74:	72 10                	jb     80103e86 <mpsearch1+0x26>
80103e76:	eb 50                	jmp    80103ec8 <mpsearch1+0x68>
80103e78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e7f:	00 
80103e80:	89 fe                	mov    %edi,%esi
80103e82:	39 df                	cmp    %ebx,%edi
80103e84:	73 42                	jae    80103ec8 <mpsearch1+0x68>
80103e86:	83 ec 04             	sub    $0x4,%esp
80103e89:	8d 7e 10             	lea    0x10(%esi),%edi
80103e8c:	6a 04                	push   $0x4
80103e8e:	68 91 80 10 80       	push   $0x80108091
80103e93:	56                   	push   %esi
80103e94:	e8 47 15 00 00       	call   801053e0 <memcmp>
80103e99:	83 c4 10             	add    $0x10,%esp
80103e9c:	85 c0                	test   %eax,%eax
80103e9e:	75 e0                	jne    80103e80 <mpsearch1+0x20>
80103ea0:	89 f2                	mov    %esi,%edx
80103ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103ea8:	0f b6 0a             	movzbl (%edx),%ecx
80103eab:	83 c2 01             	add    $0x1,%edx
80103eae:	01 c8                	add    %ecx,%eax
80103eb0:	39 fa                	cmp    %edi,%edx
80103eb2:	75 f4                	jne    80103ea8 <mpsearch1+0x48>
80103eb4:	84 c0                	test   %al,%al
80103eb6:	75 c8                	jne    80103e80 <mpsearch1+0x20>
80103eb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ebb:	89 f0                	mov    %esi,%eax
80103ebd:	5b                   	pop    %ebx
80103ebe:	5e                   	pop    %esi
80103ebf:	5f                   	pop    %edi
80103ec0:	5d                   	pop    %ebp
80103ec1:	c3                   	ret
80103ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103ec8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ecb:	31 f6                	xor    %esi,%esi
80103ecd:	5b                   	pop    %ebx
80103ece:	89 f0                	mov    %esi,%eax
80103ed0:	5e                   	pop    %esi
80103ed1:	5f                   	pop    %edi
80103ed2:	5d                   	pop    %ebp
80103ed3:	c3                   	ret
80103ed4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103edb:	00 
80103edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ee0 <mpinit>:
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	57                   	push   %edi
80103ee4:	56                   	push   %esi
80103ee5:	53                   	push   %ebx
80103ee6:	83 ec 1c             	sub    $0x1c,%esp
80103ee9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103ef0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103ef7:	c1 e0 08             	shl    $0x8,%eax
80103efa:	09 d0                	or     %edx,%eax
80103efc:	c1 e0 04             	shl    $0x4,%eax
80103eff:	75 1b                	jne    80103f1c <mpinit+0x3c>
80103f01:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103f08:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103f0f:	c1 e0 08             	shl    $0x8,%eax
80103f12:	09 d0                	or     %edx,%eax
80103f14:	c1 e0 0a             	shl    $0xa,%eax
80103f17:	2d 00 04 00 00       	sub    $0x400,%eax
80103f1c:	ba 00 04 00 00       	mov    $0x400,%edx
80103f21:	e8 3a ff ff ff       	call   80103e60 <mpsearch1>
80103f26:	89 c3                	mov    %eax,%ebx
80103f28:	85 c0                	test   %eax,%eax
80103f2a:	0f 84 58 01 00 00    	je     80104088 <mpinit+0x1a8>
80103f30:	8b 73 04             	mov    0x4(%ebx),%esi
80103f33:	85 f6                	test   %esi,%esi
80103f35:	0f 84 3d 01 00 00    	je     80104078 <mpinit+0x198>
80103f3b:	83 ec 04             	sub    $0x4,%esp
80103f3e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103f44:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103f47:	6a 04                	push   $0x4
80103f49:	68 96 80 10 80       	push   $0x80108096
80103f4e:	50                   	push   %eax
80103f4f:	e8 8c 14 00 00       	call   801053e0 <memcmp>
80103f54:	83 c4 10             	add    $0x10,%esp
80103f57:	85 c0                	test   %eax,%eax
80103f59:	0f 85 19 01 00 00    	jne    80104078 <mpinit+0x198>
80103f5f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103f66:	3c 01                	cmp    $0x1,%al
80103f68:	74 08                	je     80103f72 <mpinit+0x92>
80103f6a:	3c 04                	cmp    $0x4,%al
80103f6c:	0f 85 06 01 00 00    	jne    80104078 <mpinit+0x198>
80103f72:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103f79:	66 85 d2             	test   %dx,%dx
80103f7c:	74 22                	je     80103fa0 <mpinit+0xc0>
80103f7e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103f81:	89 f0                	mov    %esi,%eax
80103f83:	31 d2                	xor    %edx,%edx
80103f85:	8d 76 00             	lea    0x0(%esi),%esi
80103f88:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103f8f:	83 c0 01             	add    $0x1,%eax
80103f92:	01 ca                	add    %ecx,%edx
80103f94:	39 f8                	cmp    %edi,%eax
80103f96:	75 f0                	jne    80103f88 <mpinit+0xa8>
80103f98:	84 d2                	test   %dl,%dl
80103f9a:	0f 85 d8 00 00 00    	jne    80104078 <mpinit+0x198>
80103fa0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103fa6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103fa9:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103fac:	a3 a0 26 11 80       	mov    %eax,0x801126a0
80103fb1:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103fb8:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103fbe:	01 d7                	add    %edx,%edi
80103fc0:	89 fa                	mov    %edi,%edx
80103fc2:	bf 01 00 00 00       	mov    $0x1,%edi
80103fc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fce:	00 
80103fcf:	90                   	nop
80103fd0:	39 d0                	cmp    %edx,%eax
80103fd2:	73 19                	jae    80103fed <mpinit+0x10d>
80103fd4:	0f b6 08             	movzbl (%eax),%ecx
80103fd7:	80 f9 02             	cmp    $0x2,%cl
80103fda:	0f 84 80 00 00 00    	je     80104060 <mpinit+0x180>
80103fe0:	77 6e                	ja     80104050 <mpinit+0x170>
80103fe2:	84 c9                	test   %cl,%cl
80103fe4:	74 3a                	je     80104020 <mpinit+0x140>
80103fe6:	83 c0 08             	add    $0x8,%eax
80103fe9:	39 d0                	cmp    %edx,%eax
80103feb:	72 e7                	jb     80103fd4 <mpinit+0xf4>
80103fed:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103ff0:	85 ff                	test   %edi,%edi
80103ff2:	0f 84 dd 00 00 00    	je     801040d5 <mpinit+0x1f5>
80103ff8:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103ffc:	74 15                	je     80104013 <mpinit+0x133>
80103ffe:	b8 70 00 00 00       	mov    $0x70,%eax
80104003:	ba 22 00 00 00       	mov    $0x22,%edx
80104008:	ee                   	out    %al,(%dx)
80104009:	ba 23 00 00 00       	mov    $0x23,%edx
8010400e:	ec                   	in     (%dx),%al
8010400f:	83 c8 01             	or     $0x1,%eax
80104012:	ee                   	out    %al,(%dx)
80104013:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104016:	5b                   	pop    %ebx
80104017:	5e                   	pop    %esi
80104018:	5f                   	pop    %edi
80104019:	5d                   	pop    %ebp
8010401a:	c3                   	ret
8010401b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104020:	8b 0d a4 27 11 80    	mov    0x801127a4,%ecx
80104026:	83 f9 07             	cmp    $0x7,%ecx
80104029:	7f 19                	jg     80104044 <mpinit+0x164>
8010402b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80104031:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
80104035:	83 c1 01             	add    $0x1,%ecx
80104038:	89 0d a4 27 11 80    	mov    %ecx,0x801127a4
8010403e:	88 9e c0 27 11 80    	mov    %bl,-0x7feed840(%esi)
80104044:	83 c0 14             	add    $0x14,%eax
80104047:	eb 87                	jmp    80103fd0 <mpinit+0xf0>
80104049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104050:	83 e9 03             	sub    $0x3,%ecx
80104053:	80 f9 01             	cmp    $0x1,%cl
80104056:	76 8e                	jbe    80103fe6 <mpinit+0x106>
80104058:	31 ff                	xor    %edi,%edi
8010405a:	e9 71 ff ff ff       	jmp    80103fd0 <mpinit+0xf0>
8010405f:	90                   	nop
80104060:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
80104064:	83 c0 08             	add    $0x8,%eax
80104067:	88 0d a0 27 11 80    	mov    %cl,0x801127a0
8010406d:	e9 5e ff ff ff       	jmp    80103fd0 <mpinit+0xf0>
80104072:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104078:	83 ec 0c             	sub    $0xc,%esp
8010407b:	68 9b 80 10 80       	push   $0x8010809b
80104080:	e8 0b ca ff ff       	call   80100a90 <panic>
80104085:	8d 76 00             	lea    0x0(%esi),%esi
80104088:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010408d:	eb 0b                	jmp    8010409a <mpinit+0x1ba>
8010408f:	90                   	nop
80104090:	89 f3                	mov    %esi,%ebx
80104092:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80104098:	74 de                	je     80104078 <mpinit+0x198>
8010409a:	83 ec 04             	sub    $0x4,%esp
8010409d:	8d 73 10             	lea    0x10(%ebx),%esi
801040a0:	6a 04                	push   $0x4
801040a2:	68 91 80 10 80       	push   $0x80108091
801040a7:	53                   	push   %ebx
801040a8:	e8 33 13 00 00       	call   801053e0 <memcmp>
801040ad:	83 c4 10             	add    $0x10,%esp
801040b0:	85 c0                	test   %eax,%eax
801040b2:	75 dc                	jne    80104090 <mpinit+0x1b0>
801040b4:	89 da                	mov    %ebx,%edx
801040b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040bd:	00 
801040be:	66 90                	xchg   %ax,%ax
801040c0:	0f b6 0a             	movzbl (%edx),%ecx
801040c3:	83 c2 01             	add    $0x1,%edx
801040c6:	01 c8                	add    %ecx,%eax
801040c8:	39 d6                	cmp    %edx,%esi
801040ca:	75 f4                	jne    801040c0 <mpinit+0x1e0>
801040cc:	84 c0                	test   %al,%al
801040ce:	75 c0                	jne    80104090 <mpinit+0x1b0>
801040d0:	e9 5b fe ff ff       	jmp    80103f30 <mpinit+0x50>
801040d5:	83 ec 0c             	sub    $0xc,%esp
801040d8:	68 6c 84 10 80       	push   $0x8010846c
801040dd:	e8 ae c9 ff ff       	call   80100a90 <panic>
801040e2:	66 90                	xchg   %ax,%ax
801040e4:	66 90                	xchg   %ax,%ax
801040e6:	66 90                	xchg   %ax,%ax
801040e8:	66 90                	xchg   %ax,%ax
801040ea:	66 90                	xchg   %ax,%ax
801040ec:	66 90                	xchg   %ax,%ax
801040ee:	66 90                	xchg   %ax,%ax

801040f0 <picinit>:
801040f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801040f5:	ba 21 00 00 00       	mov    $0x21,%edx
801040fa:	ee                   	out    %al,(%dx)
801040fb:	ba a1 00 00 00       	mov    $0xa1,%edx
80104100:	ee                   	out    %al,(%dx)
80104101:	c3                   	ret
80104102:	66 90                	xchg   %ax,%ax
80104104:	66 90                	xchg   %ax,%ax
80104106:	66 90                	xchg   %ax,%ax
80104108:	66 90                	xchg   %ax,%ax
8010410a:	66 90                	xchg   %ax,%ax
8010410c:	66 90                	xchg   %ax,%ax
8010410e:	66 90                	xchg   %ax,%ax

80104110 <pipealloc>:
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	57                   	push   %edi
80104114:	56                   	push   %esi
80104115:	53                   	push   %ebx
80104116:	83 ec 0c             	sub    $0xc,%esp
80104119:	8b 75 08             	mov    0x8(%ebp),%esi
8010411c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010411f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80104125:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010412b:	e8 20 da ff ff       	call   80101b50 <filealloc>
80104130:	89 06                	mov    %eax,(%esi)
80104132:	85 c0                	test   %eax,%eax
80104134:	0f 84 a5 00 00 00    	je     801041df <pipealloc+0xcf>
8010413a:	e8 11 da ff ff       	call   80101b50 <filealloc>
8010413f:	89 07                	mov    %eax,(%edi)
80104141:	85 c0                	test   %eax,%eax
80104143:	0f 84 84 00 00 00    	je     801041cd <pipealloc+0xbd>
80104149:	e8 12 f2 ff ff       	call   80103360 <kalloc>
8010414e:	89 c3                	mov    %eax,%ebx
80104150:	85 c0                	test   %eax,%eax
80104152:	0f 84 a0 00 00 00    	je     801041f8 <pipealloc+0xe8>
80104158:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010415f:	00 00 00 
80104162:	83 ec 08             	sub    $0x8,%esp
80104165:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010416c:	00 00 00 
8010416f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104176:	00 00 00 
80104179:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104180:	00 00 00 
80104183:	68 b3 80 10 80       	push   $0x801080b3
80104188:	50                   	push   %eax
80104189:	e8 22 0f 00 00       	call   801050b0 <initlock>
8010418e:	8b 06                	mov    (%esi),%eax
80104190:	83 c4 10             	add    $0x10,%esp
80104193:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80104199:	8b 06                	mov    (%esi),%eax
8010419b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
8010419f:	8b 06                	mov    (%esi),%eax
801041a1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
801041a5:	8b 06                	mov    (%esi),%eax
801041a7:	89 58 0c             	mov    %ebx,0xc(%eax)
801041aa:	8b 07                	mov    (%edi),%eax
801041ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
801041b2:	8b 07                	mov    (%edi),%eax
801041b4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
801041b8:	8b 07                	mov    (%edi),%eax
801041ba:	c6 40 09 01          	movb   $0x1,0x9(%eax)
801041be:	8b 07                	mov    (%edi),%eax
801041c0:	89 58 0c             	mov    %ebx,0xc(%eax)
801041c3:	31 c0                	xor    %eax,%eax
801041c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041c8:	5b                   	pop    %ebx
801041c9:	5e                   	pop    %esi
801041ca:	5f                   	pop    %edi
801041cb:	5d                   	pop    %ebp
801041cc:	c3                   	ret
801041cd:	8b 06                	mov    (%esi),%eax
801041cf:	85 c0                	test   %eax,%eax
801041d1:	74 1e                	je     801041f1 <pipealloc+0xe1>
801041d3:	83 ec 0c             	sub    $0xc,%esp
801041d6:	50                   	push   %eax
801041d7:	e8 34 da ff ff       	call   80101c10 <fileclose>
801041dc:	83 c4 10             	add    $0x10,%esp
801041df:	8b 07                	mov    (%edi),%eax
801041e1:	85 c0                	test   %eax,%eax
801041e3:	74 0c                	je     801041f1 <pipealloc+0xe1>
801041e5:	83 ec 0c             	sub    $0xc,%esp
801041e8:	50                   	push   %eax
801041e9:	e8 22 da ff ff       	call   80101c10 <fileclose>
801041ee:	83 c4 10             	add    $0x10,%esp
801041f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801041f6:	eb cd                	jmp    801041c5 <pipealloc+0xb5>
801041f8:	8b 06                	mov    (%esi),%eax
801041fa:	85 c0                	test   %eax,%eax
801041fc:	75 d5                	jne    801041d3 <pipealloc+0xc3>
801041fe:	eb df                	jmp    801041df <pipealloc+0xcf>

80104200 <pipeclose>:
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	56                   	push   %esi
80104204:	53                   	push   %ebx
80104205:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104208:	8b 75 0c             	mov    0xc(%ebp),%esi
8010420b:	83 ec 0c             	sub    $0xc,%esp
8010420e:	53                   	push   %ebx
8010420f:	e8 8c 10 00 00       	call   801052a0 <acquire>
80104214:	83 c4 10             	add    $0x10,%esp
80104217:	85 f6                	test   %esi,%esi
80104219:	74 65                	je     80104280 <pipeclose+0x80>
8010421b:	83 ec 0c             	sub    $0xc,%esp
8010421e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104224:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010422b:	00 00 00 
8010422e:	50                   	push   %eax
8010422f:	e8 ac 0b 00 00       	call   80104de0 <wakeup>
80104234:	83 c4 10             	add    $0x10,%esp
80104237:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010423d:	85 d2                	test   %edx,%edx
8010423f:	75 0a                	jne    8010424b <pipeclose+0x4b>
80104241:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104247:	85 c0                	test   %eax,%eax
80104249:	74 15                	je     80104260 <pipeclose+0x60>
8010424b:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010424e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104251:	5b                   	pop    %ebx
80104252:	5e                   	pop    %esi
80104253:	5d                   	pop    %ebp
80104254:	e9 e7 0f 00 00       	jmp    80105240 <release>
80104259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104260:	83 ec 0c             	sub    $0xc,%esp
80104263:	53                   	push   %ebx
80104264:	e8 d7 0f 00 00       	call   80105240 <release>
80104269:	83 c4 10             	add    $0x10,%esp
8010426c:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010426f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104272:	5b                   	pop    %ebx
80104273:	5e                   	pop    %esi
80104274:	5d                   	pop    %ebp
80104275:	e9 26 ef ff ff       	jmp    801031a0 <kfree>
8010427a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104280:	83 ec 0c             	sub    $0xc,%esp
80104283:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80104289:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104290:	00 00 00 
80104293:	50                   	push   %eax
80104294:	e8 47 0b 00 00       	call   80104de0 <wakeup>
80104299:	83 c4 10             	add    $0x10,%esp
8010429c:	eb 99                	jmp    80104237 <pipeclose+0x37>
8010429e:	66 90                	xchg   %ax,%ax

801042a0 <pipewrite>:
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	57                   	push   %edi
801042a4:	56                   	push   %esi
801042a5:	53                   	push   %ebx
801042a6:	83 ec 28             	sub    $0x28,%esp
801042a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042ac:	8b 7d 10             	mov    0x10(%ebp),%edi
801042af:	53                   	push   %ebx
801042b0:	e8 eb 0f 00 00       	call   801052a0 <acquire>
801042b5:	83 c4 10             	add    $0x10,%esp
801042b8:	85 ff                	test   %edi,%edi
801042ba:	0f 8e ce 00 00 00    	jle    8010438e <pipewrite+0xee>
801042c0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801042c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801042c9:	89 7d 10             	mov    %edi,0x10(%ebp)
801042cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801042cf:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801042d2:	89 75 e0             	mov    %esi,-0x20(%ebp)
801042d5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801042db:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801042e1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
801042e7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801042ed:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801042f0:	0f 85 b6 00 00 00    	jne    801043ac <pipewrite+0x10c>
801042f6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801042f9:	eb 3b                	jmp    80104336 <pipewrite+0x96>
801042fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104300:	e8 5b 03 00 00       	call   80104660 <myproc>
80104305:	8b 48 24             	mov    0x24(%eax),%ecx
80104308:	85 c9                	test   %ecx,%ecx
8010430a:	75 34                	jne    80104340 <pipewrite+0xa0>
8010430c:	83 ec 0c             	sub    $0xc,%esp
8010430f:	56                   	push   %esi
80104310:	e8 cb 0a 00 00       	call   80104de0 <wakeup>
80104315:	58                   	pop    %eax
80104316:	5a                   	pop    %edx
80104317:	53                   	push   %ebx
80104318:	57                   	push   %edi
80104319:	e8 02 0a 00 00       	call   80104d20 <sleep>
8010431e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80104324:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010432a:	83 c4 10             	add    $0x10,%esp
8010432d:	05 00 02 00 00       	add    $0x200,%eax
80104332:	39 c2                	cmp    %eax,%edx
80104334:	75 2a                	jne    80104360 <pipewrite+0xc0>
80104336:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010433c:	85 c0                	test   %eax,%eax
8010433e:	75 c0                	jne    80104300 <pipewrite+0x60>
80104340:	83 ec 0c             	sub    $0xc,%esp
80104343:	53                   	push   %ebx
80104344:	e8 f7 0e 00 00       	call   80105240 <release>
80104349:	83 c4 10             	add    $0x10,%esp
8010434c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104351:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104354:	5b                   	pop    %ebx
80104355:	5e                   	pop    %esi
80104356:	5f                   	pop    %edi
80104357:	5d                   	pop    %ebp
80104358:	c3                   	ret
80104359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104360:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104363:	8d 42 01             	lea    0x1(%edx),%eax
80104366:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010436c:	83 c1 01             	add    $0x1,%ecx
8010436f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80104375:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104378:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010437c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
80104380:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104383:	39 c1                	cmp    %eax,%ecx
80104385:	0f 85 50 ff ff ff    	jne    801042db <pipewrite+0x3b>
8010438b:	8b 7d 10             	mov    0x10(%ebp),%edi
8010438e:	83 ec 0c             	sub    $0xc,%esp
80104391:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104397:	50                   	push   %eax
80104398:	e8 43 0a 00 00       	call   80104de0 <wakeup>
8010439d:	89 1c 24             	mov    %ebx,(%esp)
801043a0:	e8 9b 0e 00 00       	call   80105240 <release>
801043a5:	83 c4 10             	add    $0x10,%esp
801043a8:	89 f8                	mov    %edi,%eax
801043aa:	eb a5                	jmp    80104351 <pipewrite+0xb1>
801043ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043af:	eb b2                	jmp    80104363 <pipewrite+0xc3>
801043b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043b8:	00 
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043c0 <piperead>:
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	57                   	push   %edi
801043c4:	56                   	push   %esi
801043c5:	53                   	push   %ebx
801043c6:	83 ec 18             	sub    $0x18,%esp
801043c9:	8b 75 08             	mov    0x8(%ebp),%esi
801043cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801043cf:	56                   	push   %esi
801043d0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801043d6:	e8 c5 0e 00 00       	call   801052a0 <acquire>
801043db:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801043e1:	83 c4 10             	add    $0x10,%esp
801043e4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801043ea:	74 2f                	je     8010441b <piperead+0x5b>
801043ec:	eb 37                	jmp    80104425 <piperead+0x65>
801043ee:	66 90                	xchg   %ax,%ax
801043f0:	e8 6b 02 00 00       	call   80104660 <myproc>
801043f5:	8b 40 24             	mov    0x24(%eax),%eax
801043f8:	85 c0                	test   %eax,%eax
801043fa:	0f 85 80 00 00 00    	jne    80104480 <piperead+0xc0>
80104400:	83 ec 08             	sub    $0x8,%esp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	e8 16 09 00 00       	call   80104d20 <sleep>
8010440a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104410:	83 c4 10             	add    $0x10,%esp
80104413:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80104419:	75 0a                	jne    80104425 <piperead+0x65>
8010441b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80104421:	85 d2                	test   %edx,%edx
80104423:	75 cb                	jne    801043f0 <piperead+0x30>
80104425:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104428:	31 db                	xor    %ebx,%ebx
8010442a:	85 c9                	test   %ecx,%ecx
8010442c:	7f 26                	jg     80104454 <piperead+0x94>
8010442e:	eb 2c                	jmp    8010445c <piperead+0x9c>
80104430:	8d 48 01             	lea    0x1(%eax),%ecx
80104433:	25 ff 01 00 00       	and    $0x1ff,%eax
80104438:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010443e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104443:	88 04 1f             	mov    %al,(%edi,%ebx,1)
80104446:	83 c3 01             	add    $0x1,%ebx
80104449:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010444c:	74 0e                	je     8010445c <piperead+0x9c>
8010444e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104454:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010445a:	75 d4                	jne    80104430 <piperead+0x70>
8010445c:	83 ec 0c             	sub    $0xc,%esp
8010445f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104465:	50                   	push   %eax
80104466:	e8 75 09 00 00       	call   80104de0 <wakeup>
8010446b:	89 34 24             	mov    %esi,(%esp)
8010446e:	e8 cd 0d 00 00       	call   80105240 <release>
80104473:	83 c4 10             	add    $0x10,%esp
80104476:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104479:	89 d8                	mov    %ebx,%eax
8010447b:	5b                   	pop    %ebx
8010447c:	5e                   	pop    %esi
8010447d:	5f                   	pop    %edi
8010447e:	5d                   	pop    %ebp
8010447f:	c3                   	ret
80104480:	83 ec 0c             	sub    $0xc,%esp
80104483:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104488:	56                   	push   %esi
80104489:	e8 b2 0d 00 00       	call   80105240 <release>
8010448e:	83 c4 10             	add    $0x10,%esp
80104491:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104494:	89 d8                	mov    %ebx,%eax
80104496:	5b                   	pop    %ebx
80104497:	5e                   	pop    %esi
80104498:	5f                   	pop    %edi
80104499:	5d                   	pop    %ebp
8010449a:	c3                   	ret
8010449b:	66 90                	xchg   %ax,%ax
8010449d:	66 90                	xchg   %ax,%ax
8010449f:	90                   	nop

801044a0 <allocproc>:
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	53                   	push   %ebx
801044a4:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
801044a9:	83 ec 10             	sub    $0x10,%esp
801044ac:	68 40 2d 11 80       	push   $0x80112d40
801044b1:	e8 ea 0d 00 00       	call   801052a0 <acquire>
801044b6:	83 c4 10             	add    $0x10,%esp
801044b9:	eb 10                	jmp    801044cb <allocproc+0x2b>
801044bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801044c0:	83 c3 7c             	add    $0x7c,%ebx
801044c3:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
801044c9:	74 75                	je     80104540 <allocproc+0xa0>
801044cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801044ce:	85 c0                	test   %eax,%eax
801044d0:	75 ee                	jne    801044c0 <allocproc+0x20>
801044d2:	a1 04 b0 10 80       	mov    0x8010b004,%eax
801044d7:	83 ec 0c             	sub    $0xc,%esp
801044da:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
801044e1:	89 43 10             	mov    %eax,0x10(%ebx)
801044e4:	8d 50 01             	lea    0x1(%eax),%edx
801044e7:	68 40 2d 11 80       	push   $0x80112d40
801044ec:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
801044f2:	e8 49 0d 00 00       	call   80105240 <release>
801044f7:	e8 64 ee ff ff       	call   80103360 <kalloc>
801044fc:	83 c4 10             	add    $0x10,%esp
801044ff:	89 43 08             	mov    %eax,0x8(%ebx)
80104502:	85 c0                	test   %eax,%eax
80104504:	74 53                	je     80104559 <allocproc+0xb9>
80104506:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
8010450c:	83 ec 04             	sub    $0x4,%esp
8010450f:	05 9c 0f 00 00       	add    $0xf9c,%eax
80104514:	89 53 18             	mov    %edx,0x18(%ebx)
80104517:	c7 40 14 52 65 10 80 	movl   $0x80106552,0x14(%eax)
8010451e:	89 43 1c             	mov    %eax,0x1c(%ebx)
80104521:	6a 14                	push   $0x14
80104523:	6a 00                	push   $0x0
80104525:	50                   	push   %eax
80104526:	e8 75 0e 00 00       	call   801053a0 <memset>
8010452b:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010452e:	83 c4 10             	add    $0x10,%esp
80104531:	c7 40 10 70 45 10 80 	movl   $0x80104570,0x10(%eax)
80104538:	89 d8                	mov    %ebx,%eax
8010453a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010453d:	c9                   	leave
8010453e:	c3                   	ret
8010453f:	90                   	nop
80104540:	83 ec 0c             	sub    $0xc,%esp
80104543:	31 db                	xor    %ebx,%ebx
80104545:	68 40 2d 11 80       	push   $0x80112d40
8010454a:	e8 f1 0c 00 00       	call   80105240 <release>
8010454f:	83 c4 10             	add    $0x10,%esp
80104552:	89 d8                	mov    %ebx,%eax
80104554:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104557:	c9                   	leave
80104558:	c3                   	ret
80104559:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104560:	31 db                	xor    %ebx,%ebx
80104562:	eb ee                	jmp    80104552 <allocproc+0xb2>
80104564:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010456b:	00 
8010456c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104570 <forkret>:
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	83 ec 14             	sub    $0x14,%esp
80104576:	68 40 2d 11 80       	push   $0x80112d40
8010457b:	e8 c0 0c 00 00       	call   80105240 <release>
80104580:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104585:	83 c4 10             	add    $0x10,%esp
80104588:	85 c0                	test   %eax,%eax
8010458a:	75 04                	jne    80104590 <forkret+0x20>
8010458c:	c9                   	leave
8010458d:	c3                   	ret
8010458e:	66 90                	xchg   %ax,%ax
80104590:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80104597:	00 00 00 
8010459a:	83 ec 0c             	sub    $0xc,%esp
8010459d:	6a 01                	push   $0x1
8010459f:	e8 dc dc ff ff       	call   80102280 <iinit>
801045a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801045ab:	e8 f0 f3 ff ff       	call   801039a0 <initlog>
801045b0:	83 c4 10             	add    $0x10,%esp
801045b3:	c9                   	leave
801045b4:	c3                   	ret
801045b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045bc:	00 
801045bd:	8d 76 00             	lea    0x0(%esi),%esi

801045c0 <pinit>:
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	83 ec 10             	sub    $0x10,%esp
801045c6:	68 b8 80 10 80       	push   $0x801080b8
801045cb:	68 40 2d 11 80       	push   $0x80112d40
801045d0:	e8 db 0a 00 00       	call   801050b0 <initlock>
801045d5:	83 c4 10             	add    $0x10,%esp
801045d8:	c9                   	leave
801045d9:	c3                   	ret
801045da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045e0 <mycpu>:
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	56                   	push   %esi
801045e4:	53                   	push   %ebx
801045e5:	9c                   	pushf
801045e6:	58                   	pop    %eax
801045e7:	f6 c4 02             	test   $0x2,%ah
801045ea:	75 46                	jne    80104632 <mycpu+0x52>
801045ec:	e8 df ef ff ff       	call   801035d0 <lapicid>
801045f1:	8b 35 a4 27 11 80    	mov    0x801127a4,%esi
801045f7:	85 f6                	test   %esi,%esi
801045f9:	7e 2a                	jle    80104625 <mycpu+0x45>
801045fb:	31 d2                	xor    %edx,%edx
801045fd:	eb 08                	jmp    80104607 <mycpu+0x27>
801045ff:	90                   	nop
80104600:	83 c2 01             	add    $0x1,%edx
80104603:	39 f2                	cmp    %esi,%edx
80104605:	74 1e                	je     80104625 <mycpu+0x45>
80104607:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010460d:	0f b6 99 c0 27 11 80 	movzbl -0x7feed840(%ecx),%ebx
80104614:	39 c3                	cmp    %eax,%ebx
80104616:	75 e8                	jne    80104600 <mycpu+0x20>
80104618:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010461b:	8d 81 c0 27 11 80    	lea    -0x7feed840(%ecx),%eax
80104621:	5b                   	pop    %ebx
80104622:	5e                   	pop    %esi
80104623:	5d                   	pop    %ebp
80104624:	c3                   	ret
80104625:	83 ec 0c             	sub    $0xc,%esp
80104628:	68 bf 80 10 80       	push   $0x801080bf
8010462d:	e8 5e c4 ff ff       	call   80100a90 <panic>
80104632:	83 ec 0c             	sub    $0xc,%esp
80104635:	68 8c 84 10 80       	push   $0x8010848c
8010463a:	e8 51 c4 ff ff       	call   80100a90 <panic>
8010463f:	90                   	nop

80104640 <cpuid>:
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	83 ec 08             	sub    $0x8,%esp
80104646:	e8 95 ff ff ff       	call   801045e0 <mycpu>
8010464b:	c9                   	leave
8010464c:	2d c0 27 11 80       	sub    $0x801127c0,%eax
80104651:	c1 f8 04             	sar    $0x4,%eax
80104654:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
8010465a:	c3                   	ret
8010465b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104660 <myproc>:
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	53                   	push   %ebx
80104664:	83 ec 04             	sub    $0x4,%esp
80104667:	e8 e4 0a 00 00       	call   80105150 <pushcli>
8010466c:	e8 6f ff ff ff       	call   801045e0 <mycpu>
80104671:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104677:	e8 24 0b 00 00       	call   801051a0 <popcli>
8010467c:	89 d8                	mov    %ebx,%eax
8010467e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104681:	c9                   	leave
80104682:	c3                   	ret
80104683:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010468a:	00 
8010468b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104690 <userinit>:
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	53                   	push   %ebx
80104694:	83 ec 04             	sub    $0x4,%esp
80104697:	e8 04 fe ff ff       	call   801044a0 <allocproc>
8010469c:	89 c3                	mov    %eax,%ebx
8010469e:	a3 74 4c 11 80       	mov    %eax,0x80114c74
801046a3:	e8 78 34 00 00       	call   80107b20 <setupkvm>
801046a8:	89 43 04             	mov    %eax,0x4(%ebx)
801046ab:	85 c0                	test   %eax,%eax
801046ad:	0f 84 bd 00 00 00    	je     80104770 <userinit+0xe0>
801046b3:	83 ec 04             	sub    $0x4,%esp
801046b6:	68 2c 00 00 00       	push   $0x2c
801046bb:	68 60 b4 10 80       	push   $0x8010b460
801046c0:	50                   	push   %eax
801046c1:	e8 3a 31 00 00       	call   80107800 <inituvm>
801046c6:	83 c4 0c             	add    $0xc,%esp
801046c9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
801046cf:	6a 4c                	push   $0x4c
801046d1:	6a 00                	push   $0x0
801046d3:	ff 73 18             	push   0x18(%ebx)
801046d6:	e8 c5 0c 00 00       	call   801053a0 <memset>
801046db:	8b 43 18             	mov    0x18(%ebx),%eax
801046de:	ba 1b 00 00 00       	mov    $0x1b,%edx
801046e3:	83 c4 0c             	add    $0xc,%esp
801046e6:	b9 23 00 00 00       	mov    $0x23,%ecx
801046eb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
801046ef:	8b 43 18             	mov    0x18(%ebx),%eax
801046f2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
801046f6:	8b 43 18             	mov    0x18(%ebx),%eax
801046f9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801046fd:	66 89 50 28          	mov    %dx,0x28(%eax)
80104701:	8b 43 18             	mov    0x18(%ebx),%eax
80104704:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104708:	66 89 50 48          	mov    %dx,0x48(%eax)
8010470c:	8b 43 18             	mov    0x18(%ebx),%eax
8010470f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
80104716:	8b 43 18             	mov    0x18(%ebx),%eax
80104719:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
80104720:	8b 43 18             	mov    0x18(%ebx),%eax
80104723:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
8010472a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010472d:	6a 10                	push   $0x10
8010472f:	68 e8 80 10 80       	push   $0x801080e8
80104734:	50                   	push   %eax
80104735:	e8 16 0e 00 00       	call   80105550 <safestrcpy>
8010473a:	c7 04 24 f1 80 10 80 	movl   $0x801080f1,(%esp)
80104741:	e8 3a e6 ff ff       	call   80102d80 <namei>
80104746:	89 43 68             	mov    %eax,0x68(%ebx)
80104749:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104750:	e8 4b 0b 00 00       	call   801052a0 <acquire>
80104755:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
8010475c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104763:	e8 d8 0a 00 00       	call   80105240 <release>
80104768:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010476b:	83 c4 10             	add    $0x10,%esp
8010476e:	c9                   	leave
8010476f:	c3                   	ret
80104770:	83 ec 0c             	sub    $0xc,%esp
80104773:	68 cf 80 10 80       	push   $0x801080cf
80104778:	e8 13 c3 ff ff       	call   80100a90 <panic>
8010477d:	8d 76 00             	lea    0x0(%esi),%esi

80104780 <growproc>:
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	56                   	push   %esi
80104784:	53                   	push   %ebx
80104785:	8b 75 08             	mov    0x8(%ebp),%esi
80104788:	e8 c3 09 00 00       	call   80105150 <pushcli>
8010478d:	e8 4e fe ff ff       	call   801045e0 <mycpu>
80104792:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104798:	e8 03 0a 00 00       	call   801051a0 <popcli>
8010479d:	8b 03                	mov    (%ebx),%eax
8010479f:	85 f6                	test   %esi,%esi
801047a1:	7f 1d                	jg     801047c0 <growproc+0x40>
801047a3:	75 3b                	jne    801047e0 <growproc+0x60>
801047a5:	83 ec 0c             	sub    $0xc,%esp
801047a8:	89 03                	mov    %eax,(%ebx)
801047aa:	53                   	push   %ebx
801047ab:	e8 40 2f 00 00       	call   801076f0 <switchuvm>
801047b0:	83 c4 10             	add    $0x10,%esp
801047b3:	31 c0                	xor    %eax,%eax
801047b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047b8:	5b                   	pop    %ebx
801047b9:	5e                   	pop    %esi
801047ba:	5d                   	pop    %ebp
801047bb:	c3                   	ret
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047c0:	83 ec 04             	sub    $0x4,%esp
801047c3:	01 c6                	add    %eax,%esi
801047c5:	56                   	push   %esi
801047c6:	50                   	push   %eax
801047c7:	ff 73 04             	push   0x4(%ebx)
801047ca:	e8 81 31 00 00       	call   80107950 <allocuvm>
801047cf:	83 c4 10             	add    $0x10,%esp
801047d2:	85 c0                	test   %eax,%eax
801047d4:	75 cf                	jne    801047a5 <growproc+0x25>
801047d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047db:	eb d8                	jmp    801047b5 <growproc+0x35>
801047dd:	8d 76 00             	lea    0x0(%esi),%esi
801047e0:	83 ec 04             	sub    $0x4,%esp
801047e3:	01 c6                	add    %eax,%esi
801047e5:	56                   	push   %esi
801047e6:	50                   	push   %eax
801047e7:	ff 73 04             	push   0x4(%ebx)
801047ea:	e8 81 32 00 00       	call   80107a70 <deallocuvm>
801047ef:	83 c4 10             	add    $0x10,%esp
801047f2:	85 c0                	test   %eax,%eax
801047f4:	75 af                	jne    801047a5 <growproc+0x25>
801047f6:	eb de                	jmp    801047d6 <growproc+0x56>
801047f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047ff:	00 

80104800 <fork>:
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	57                   	push   %edi
80104804:	56                   	push   %esi
80104805:	53                   	push   %ebx
80104806:	83 ec 1c             	sub    $0x1c,%esp
80104809:	e8 42 09 00 00       	call   80105150 <pushcli>
8010480e:	e8 cd fd ff ff       	call   801045e0 <mycpu>
80104813:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104819:	e8 82 09 00 00       	call   801051a0 <popcli>
8010481e:	e8 7d fc ff ff       	call   801044a0 <allocproc>
80104823:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104826:	85 c0                	test   %eax,%eax
80104828:	0f 84 d6 00 00 00    	je     80104904 <fork+0x104>
8010482e:	83 ec 08             	sub    $0x8,%esp
80104831:	ff 33                	push   (%ebx)
80104833:	89 c7                	mov    %eax,%edi
80104835:	ff 73 04             	push   0x4(%ebx)
80104838:	e8 d3 33 00 00       	call   80107c10 <copyuvm>
8010483d:	83 c4 10             	add    $0x10,%esp
80104840:	89 47 04             	mov    %eax,0x4(%edi)
80104843:	85 c0                	test   %eax,%eax
80104845:	0f 84 9a 00 00 00    	je     801048e5 <fork+0xe5>
8010484b:	8b 03                	mov    (%ebx),%eax
8010484d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104850:	89 01                	mov    %eax,(%ecx)
80104852:	8b 79 18             	mov    0x18(%ecx),%edi
80104855:	89 c8                	mov    %ecx,%eax
80104857:	89 59 14             	mov    %ebx,0x14(%ecx)
8010485a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010485f:	8b 73 18             	mov    0x18(%ebx),%esi
80104862:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
80104864:	31 f6                	xor    %esi,%esi
80104866:	8b 40 18             	mov    0x18(%eax),%eax
80104869:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80104870:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104874:	85 c0                	test   %eax,%eax
80104876:	74 13                	je     8010488b <fork+0x8b>
80104878:	83 ec 0c             	sub    $0xc,%esp
8010487b:	50                   	push   %eax
8010487c:	e8 3f d3 ff ff       	call   80101bc0 <filedup>
80104881:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104884:	83 c4 10             	add    $0x10,%esp
80104887:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
8010488b:	83 c6 01             	add    $0x1,%esi
8010488e:	83 fe 10             	cmp    $0x10,%esi
80104891:	75 dd                	jne    80104870 <fork+0x70>
80104893:	83 ec 0c             	sub    $0xc,%esp
80104896:	ff 73 68             	push   0x68(%ebx)
80104899:	83 c3 6c             	add    $0x6c,%ebx
8010489c:	e8 cf db ff ff       	call   80102470 <idup>
801048a1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801048a4:	83 c4 0c             	add    $0xc,%esp
801048a7:	89 47 68             	mov    %eax,0x68(%edi)
801048aa:	8d 47 6c             	lea    0x6c(%edi),%eax
801048ad:	6a 10                	push   $0x10
801048af:	53                   	push   %ebx
801048b0:	50                   	push   %eax
801048b1:	e8 9a 0c 00 00       	call   80105550 <safestrcpy>
801048b6:	8b 5f 10             	mov    0x10(%edi),%ebx
801048b9:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801048c0:	e8 db 09 00 00       	call   801052a0 <acquire>
801048c5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
801048cc:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801048d3:	e8 68 09 00 00       	call   80105240 <release>
801048d8:	83 c4 10             	add    $0x10,%esp
801048db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048de:	89 d8                	mov    %ebx,%eax
801048e0:	5b                   	pop    %ebx
801048e1:	5e                   	pop    %esi
801048e2:	5f                   	pop    %edi
801048e3:	5d                   	pop    %ebp
801048e4:	c3                   	ret
801048e5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801048e8:	83 ec 0c             	sub    $0xc,%esp
801048eb:	ff 73 08             	push   0x8(%ebx)
801048ee:	e8 ad e8 ff ff       	call   801031a0 <kfree>
801048f3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
801048fa:	83 c4 10             	add    $0x10,%esp
801048fd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104904:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104909:	eb d0                	jmp    801048db <fork+0xdb>
8010490b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104910 <scheduler>:
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	57                   	push   %edi
80104914:	56                   	push   %esi
80104915:	53                   	push   %ebx
80104916:	83 ec 0c             	sub    $0xc,%esp
80104919:	e8 c2 fc ff ff       	call   801045e0 <mycpu>
8010491e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104925:	00 00 00 
80104928:	89 c6                	mov    %eax,%esi
8010492a:	8d 78 04             	lea    0x4(%eax),%edi
8010492d:	8d 76 00             	lea    0x0(%esi),%esi
80104930:	fb                   	sti
80104931:	83 ec 0c             	sub    $0xc,%esp
80104934:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104939:	68 40 2d 11 80       	push   $0x80112d40
8010493e:	e8 5d 09 00 00       	call   801052a0 <acquire>
80104943:	83 c4 10             	add    $0x10,%esp
80104946:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010494d:	00 
8010494e:	66 90                	xchg   %ax,%ax
80104950:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104954:	75 33                	jne    80104989 <scheduler+0x79>
80104956:	83 ec 0c             	sub    $0xc,%esp
80104959:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
8010495f:	53                   	push   %ebx
80104960:	e8 8b 2d 00 00       	call   801076f0 <switchuvm>
80104965:	58                   	pop    %eax
80104966:	5a                   	pop    %edx
80104967:	ff 73 1c             	push   0x1c(%ebx)
8010496a:	57                   	push   %edi
8010496b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
80104972:	e8 34 0c 00 00       	call   801055ab <swtch>
80104977:	e8 64 2d 00 00       	call   801076e0 <switchkvm>
8010497c:	83 c4 10             	add    $0x10,%esp
8010497f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104986:	00 00 00 
80104989:	83 c3 7c             	add    $0x7c,%ebx
8010498c:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104992:	75 bc                	jne    80104950 <scheduler+0x40>
80104994:	83 ec 0c             	sub    $0xc,%esp
80104997:	68 40 2d 11 80       	push   $0x80112d40
8010499c:	e8 9f 08 00 00       	call   80105240 <release>
801049a1:	83 c4 10             	add    $0x10,%esp
801049a4:	eb 8a                	jmp    80104930 <scheduler+0x20>
801049a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049ad:	00 
801049ae:	66 90                	xchg   %ax,%ax

801049b0 <sched>:
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	56                   	push   %esi
801049b4:	53                   	push   %ebx
801049b5:	e8 96 07 00 00       	call   80105150 <pushcli>
801049ba:	e8 21 fc ff ff       	call   801045e0 <mycpu>
801049bf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801049c5:	e8 d6 07 00 00       	call   801051a0 <popcli>
801049ca:	83 ec 0c             	sub    $0xc,%esp
801049cd:	68 40 2d 11 80       	push   $0x80112d40
801049d2:	e8 29 08 00 00       	call   80105200 <holding>
801049d7:	83 c4 10             	add    $0x10,%esp
801049da:	85 c0                	test   %eax,%eax
801049dc:	74 4f                	je     80104a2d <sched+0x7d>
801049de:	e8 fd fb ff ff       	call   801045e0 <mycpu>
801049e3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801049ea:	75 68                	jne    80104a54 <sched+0xa4>
801049ec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801049f0:	74 55                	je     80104a47 <sched+0x97>
801049f2:	9c                   	pushf
801049f3:	58                   	pop    %eax
801049f4:	f6 c4 02             	test   $0x2,%ah
801049f7:	75 41                	jne    80104a3a <sched+0x8a>
801049f9:	e8 e2 fb ff ff       	call   801045e0 <mycpu>
801049fe:	83 c3 1c             	add    $0x1c,%ebx
80104a01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
80104a07:	e8 d4 fb ff ff       	call   801045e0 <mycpu>
80104a0c:	83 ec 08             	sub    $0x8,%esp
80104a0f:	ff 70 04             	push   0x4(%eax)
80104a12:	53                   	push   %ebx
80104a13:	e8 93 0b 00 00       	call   801055ab <swtch>
80104a18:	e8 c3 fb ff ff       	call   801045e0 <mycpu>
80104a1d:	83 c4 10             	add    $0x10,%esp
80104a20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
80104a26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a29:	5b                   	pop    %ebx
80104a2a:	5e                   	pop    %esi
80104a2b:	5d                   	pop    %ebp
80104a2c:	c3                   	ret
80104a2d:	83 ec 0c             	sub    $0xc,%esp
80104a30:	68 f3 80 10 80       	push   $0x801080f3
80104a35:	e8 56 c0 ff ff       	call   80100a90 <panic>
80104a3a:	83 ec 0c             	sub    $0xc,%esp
80104a3d:	68 1f 81 10 80       	push   $0x8010811f
80104a42:	e8 49 c0 ff ff       	call   80100a90 <panic>
80104a47:	83 ec 0c             	sub    $0xc,%esp
80104a4a:	68 11 81 10 80       	push   $0x80108111
80104a4f:	e8 3c c0 ff ff       	call   80100a90 <panic>
80104a54:	83 ec 0c             	sub    $0xc,%esp
80104a57:	68 05 81 10 80       	push   $0x80108105
80104a5c:	e8 2f c0 ff ff       	call   80100a90 <panic>
80104a61:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a68:	00 
80104a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a70 <exit>:
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	57                   	push   %edi
80104a74:	56                   	push   %esi
80104a75:	53                   	push   %ebx
80104a76:	83 ec 0c             	sub    $0xc,%esp
80104a79:	e8 e2 fb ff ff       	call   80104660 <myproc>
80104a7e:	39 05 74 4c 11 80    	cmp    %eax,0x80114c74
80104a84:	0f 84 fd 00 00 00    	je     80104b87 <exit+0x117>
80104a8a:	89 c3                	mov    %eax,%ebx
80104a8c:	8d 70 28             	lea    0x28(%eax),%esi
80104a8f:	8d 78 68             	lea    0x68(%eax),%edi
80104a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a98:	8b 06                	mov    (%esi),%eax
80104a9a:	85 c0                	test   %eax,%eax
80104a9c:	74 12                	je     80104ab0 <exit+0x40>
80104a9e:	83 ec 0c             	sub    $0xc,%esp
80104aa1:	50                   	push   %eax
80104aa2:	e8 69 d1 ff ff       	call   80101c10 <fileclose>
80104aa7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104aad:	83 c4 10             	add    $0x10,%esp
80104ab0:	83 c6 04             	add    $0x4,%esi
80104ab3:	39 f7                	cmp    %esi,%edi
80104ab5:	75 e1                	jne    80104a98 <exit+0x28>
80104ab7:	e8 84 ef ff ff       	call   80103a40 <begin_op>
80104abc:	83 ec 0c             	sub    $0xc,%esp
80104abf:	ff 73 68             	push   0x68(%ebx)
80104ac2:	e8 09 db ff ff       	call   801025d0 <iput>
80104ac7:	e8 e4 ef ff ff       	call   80103ab0 <end_op>
80104acc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
80104ad3:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104ada:	e8 c1 07 00 00       	call   801052a0 <acquire>
80104adf:	8b 53 14             	mov    0x14(%ebx),%edx
80104ae2:	83 c4 10             	add    $0x10,%esp
80104ae5:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104aea:	eb 0e                	jmp    80104afa <exit+0x8a>
80104aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104af0:	83 c0 7c             	add    $0x7c,%eax
80104af3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104af8:	74 1c                	je     80104b16 <exit+0xa6>
80104afa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104afe:	75 f0                	jne    80104af0 <exit+0x80>
80104b00:	3b 50 20             	cmp    0x20(%eax),%edx
80104b03:	75 eb                	jne    80104af0 <exit+0x80>
80104b05:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104b0c:	83 c0 7c             	add    $0x7c,%eax
80104b0f:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104b14:	75 e4                	jne    80104afa <exit+0x8a>
80104b16:	8b 0d 74 4c 11 80    	mov    0x80114c74,%ecx
80104b1c:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80104b21:	eb 10                	jmp    80104b33 <exit+0xc3>
80104b23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b28:	83 c2 7c             	add    $0x7c,%edx
80104b2b:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80104b31:	74 3b                	je     80104b6e <exit+0xfe>
80104b33:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104b36:	75 f0                	jne    80104b28 <exit+0xb8>
80104b38:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
80104b3c:	89 4a 14             	mov    %ecx,0x14(%edx)
80104b3f:	75 e7                	jne    80104b28 <exit+0xb8>
80104b41:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104b46:	eb 12                	jmp    80104b5a <exit+0xea>
80104b48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b4f:	00 
80104b50:	83 c0 7c             	add    $0x7c,%eax
80104b53:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104b58:	74 ce                	je     80104b28 <exit+0xb8>
80104b5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104b5e:	75 f0                	jne    80104b50 <exit+0xe0>
80104b60:	3b 48 20             	cmp    0x20(%eax),%ecx
80104b63:	75 eb                	jne    80104b50 <exit+0xe0>
80104b65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104b6c:	eb e2                	jmp    80104b50 <exit+0xe0>
80104b6e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
80104b75:	e8 36 fe ff ff       	call   801049b0 <sched>
80104b7a:	83 ec 0c             	sub    $0xc,%esp
80104b7d:	68 40 81 10 80       	push   $0x80108140
80104b82:	e8 09 bf ff ff       	call   80100a90 <panic>
80104b87:	83 ec 0c             	sub    $0xc,%esp
80104b8a:	68 33 81 10 80       	push   $0x80108133
80104b8f:	e8 fc be ff ff       	call   80100a90 <panic>
80104b94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b9b:	00 
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ba0 <wait>:
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	56                   	push   %esi
80104ba4:	53                   	push   %ebx
80104ba5:	e8 a6 05 00 00       	call   80105150 <pushcli>
80104baa:	e8 31 fa ff ff       	call   801045e0 <mycpu>
80104baf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
80104bb5:	e8 e6 05 00 00       	call   801051a0 <popcli>
80104bba:	83 ec 0c             	sub    $0xc,%esp
80104bbd:	68 40 2d 11 80       	push   $0x80112d40
80104bc2:	e8 d9 06 00 00       	call   801052a0 <acquire>
80104bc7:	83 c4 10             	add    $0x10,%esp
80104bca:	31 c0                	xor    %eax,%eax
80104bcc:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104bd1:	eb 10                	jmp    80104be3 <wait+0x43>
80104bd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bd8:	83 c3 7c             	add    $0x7c,%ebx
80104bdb:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104be1:	74 1b                	je     80104bfe <wait+0x5e>
80104be3:	39 73 14             	cmp    %esi,0x14(%ebx)
80104be6:	75 f0                	jne    80104bd8 <wait+0x38>
80104be8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104bec:	74 62                	je     80104c50 <wait+0xb0>
80104bee:	83 c3 7c             	add    $0x7c,%ebx
80104bf1:	b8 01 00 00 00       	mov    $0x1,%eax
80104bf6:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104bfc:	75 e5                	jne    80104be3 <wait+0x43>
80104bfe:	85 c0                	test   %eax,%eax
80104c00:	0f 84 a0 00 00 00    	je     80104ca6 <wait+0x106>
80104c06:	8b 46 24             	mov    0x24(%esi),%eax
80104c09:	85 c0                	test   %eax,%eax
80104c0b:	0f 85 95 00 00 00    	jne    80104ca6 <wait+0x106>
80104c11:	e8 3a 05 00 00       	call   80105150 <pushcli>
80104c16:	e8 c5 f9 ff ff       	call   801045e0 <mycpu>
80104c1b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104c21:	e8 7a 05 00 00       	call   801051a0 <popcli>
80104c26:	85 db                	test   %ebx,%ebx
80104c28:	0f 84 8f 00 00 00    	je     80104cbd <wait+0x11d>
80104c2e:	89 73 20             	mov    %esi,0x20(%ebx)
80104c31:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104c38:	e8 73 fd ff ff       	call   801049b0 <sched>
80104c3d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104c44:	eb 84                	jmp    80104bca <wait+0x2a>
80104c46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c4d:	00 
80104c4e:	66 90                	xchg   %ax,%ax
80104c50:	83 ec 0c             	sub    $0xc,%esp
80104c53:	8b 73 10             	mov    0x10(%ebx),%esi
80104c56:	ff 73 08             	push   0x8(%ebx)
80104c59:	e8 42 e5 ff ff       	call   801031a0 <kfree>
80104c5e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104c65:	5a                   	pop    %edx
80104c66:	ff 73 04             	push   0x4(%ebx)
80104c69:	e8 32 2e 00 00       	call   80107aa0 <freevm>
80104c6e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80104c75:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
80104c7c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
80104c80:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80104c87:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104c8e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104c95:	e8 a6 05 00 00       	call   80105240 <release>
80104c9a:	83 c4 10             	add    $0x10,%esp
80104c9d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ca0:	89 f0                	mov    %esi,%eax
80104ca2:	5b                   	pop    %ebx
80104ca3:	5e                   	pop    %esi
80104ca4:	5d                   	pop    %ebp
80104ca5:	c3                   	ret
80104ca6:	83 ec 0c             	sub    $0xc,%esp
80104ca9:	be ff ff ff ff       	mov    $0xffffffff,%esi
80104cae:	68 40 2d 11 80       	push   $0x80112d40
80104cb3:	e8 88 05 00 00       	call   80105240 <release>
80104cb8:	83 c4 10             	add    $0x10,%esp
80104cbb:	eb e0                	jmp    80104c9d <wait+0xfd>
80104cbd:	83 ec 0c             	sub    $0xc,%esp
80104cc0:	68 4c 81 10 80       	push   $0x8010814c
80104cc5:	e8 c6 bd ff ff       	call   80100a90 <panic>
80104cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104cd0 <yield>:
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	53                   	push   %ebx
80104cd4:	83 ec 10             	sub    $0x10,%esp
80104cd7:	68 40 2d 11 80       	push   $0x80112d40
80104cdc:	e8 bf 05 00 00       	call   801052a0 <acquire>
80104ce1:	e8 6a 04 00 00       	call   80105150 <pushcli>
80104ce6:	e8 f5 f8 ff ff       	call   801045e0 <mycpu>
80104ceb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104cf1:	e8 aa 04 00 00       	call   801051a0 <popcli>
80104cf6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
80104cfd:	e8 ae fc ff ff       	call   801049b0 <sched>
80104d02:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104d09:	e8 32 05 00 00       	call   80105240 <release>
80104d0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d11:	83 c4 10             	add    $0x10,%esp
80104d14:	c9                   	leave
80104d15:	c3                   	ret
80104d16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d1d:	00 
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <sleep>:
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	57                   	push   %edi
80104d24:	56                   	push   %esi
80104d25:	53                   	push   %ebx
80104d26:	83 ec 0c             	sub    $0xc,%esp
80104d29:	8b 7d 08             	mov    0x8(%ebp),%edi
80104d2c:	8b 75 0c             	mov    0xc(%ebp),%esi
80104d2f:	e8 1c 04 00 00       	call   80105150 <pushcli>
80104d34:	e8 a7 f8 ff ff       	call   801045e0 <mycpu>
80104d39:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104d3f:	e8 5c 04 00 00       	call   801051a0 <popcli>
80104d44:	85 db                	test   %ebx,%ebx
80104d46:	0f 84 87 00 00 00    	je     80104dd3 <sleep+0xb3>
80104d4c:	85 f6                	test   %esi,%esi
80104d4e:	74 76                	je     80104dc6 <sleep+0xa6>
80104d50:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80104d56:	74 50                	je     80104da8 <sleep+0x88>
80104d58:	83 ec 0c             	sub    $0xc,%esp
80104d5b:	68 40 2d 11 80       	push   $0x80112d40
80104d60:	e8 3b 05 00 00       	call   801052a0 <acquire>
80104d65:	89 34 24             	mov    %esi,(%esp)
80104d68:	e8 d3 04 00 00       	call   80105240 <release>
80104d6d:	89 7b 20             	mov    %edi,0x20(%ebx)
80104d70:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104d77:	e8 34 fc ff ff       	call   801049b0 <sched>
80104d7c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104d83:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104d8a:	e8 b1 04 00 00       	call   80105240 <release>
80104d8f:	83 c4 10             	add    $0x10,%esp
80104d92:	89 75 08             	mov    %esi,0x8(%ebp)
80104d95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d98:	5b                   	pop    %ebx
80104d99:	5e                   	pop    %esi
80104d9a:	5f                   	pop    %edi
80104d9b:	5d                   	pop    %ebp
80104d9c:	e9 ff 04 00 00       	jmp    801052a0 <acquire>
80104da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104da8:	89 7b 20             	mov    %edi,0x20(%ebx)
80104dab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104db2:	e8 f9 fb ff ff       	call   801049b0 <sched>
80104db7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104dbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104dc1:	5b                   	pop    %ebx
80104dc2:	5e                   	pop    %esi
80104dc3:	5f                   	pop    %edi
80104dc4:	5d                   	pop    %ebp
80104dc5:	c3                   	ret
80104dc6:	83 ec 0c             	sub    $0xc,%esp
80104dc9:	68 52 81 10 80       	push   $0x80108152
80104dce:	e8 bd bc ff ff       	call   80100a90 <panic>
80104dd3:	83 ec 0c             	sub    $0xc,%esp
80104dd6:	68 4c 81 10 80       	push   $0x8010814c
80104ddb:	e8 b0 bc ff ff       	call   80100a90 <panic>

80104de0 <wakeup>:
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
80104de3:	53                   	push   %ebx
80104de4:	83 ec 10             	sub    $0x10,%esp
80104de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104dea:	68 40 2d 11 80       	push   $0x80112d40
80104def:	e8 ac 04 00 00       	call   801052a0 <acquire>
80104df4:	83 c4 10             	add    $0x10,%esp
80104df7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104dfc:	eb 0c                	jmp    80104e0a <wakeup+0x2a>
80104dfe:	66 90                	xchg   %ax,%ax
80104e00:	83 c0 7c             	add    $0x7c,%eax
80104e03:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104e08:	74 1c                	je     80104e26 <wakeup+0x46>
80104e0a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104e0e:	75 f0                	jne    80104e00 <wakeup+0x20>
80104e10:	3b 58 20             	cmp    0x20(%eax),%ebx
80104e13:	75 eb                	jne    80104e00 <wakeup+0x20>
80104e15:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104e1c:	83 c0 7c             	add    $0x7c,%eax
80104e1f:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104e24:	75 e4                	jne    80104e0a <wakeup+0x2a>
80104e26:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
80104e2d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e30:	c9                   	leave
80104e31:	e9 0a 04 00 00       	jmp    80105240 <release>
80104e36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e3d:	00 
80104e3e:	66 90                	xchg   %ax,%ax

80104e40 <kill>:
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	53                   	push   %ebx
80104e44:	83 ec 10             	sub    $0x10,%esp
80104e47:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e4a:	68 40 2d 11 80       	push   $0x80112d40
80104e4f:	e8 4c 04 00 00       	call   801052a0 <acquire>
80104e54:	83 c4 10             	add    $0x10,%esp
80104e57:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104e5c:	eb 0c                	jmp    80104e6a <kill+0x2a>
80104e5e:	66 90                	xchg   %ax,%ax
80104e60:	83 c0 7c             	add    $0x7c,%eax
80104e63:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104e68:	74 36                	je     80104ea0 <kill+0x60>
80104e6a:	39 58 10             	cmp    %ebx,0x10(%eax)
80104e6d:	75 f1                	jne    80104e60 <kill+0x20>
80104e6f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104e73:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80104e7a:	75 07                	jne    80104e83 <kill+0x43>
80104e7c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104e83:	83 ec 0c             	sub    $0xc,%esp
80104e86:	68 40 2d 11 80       	push   $0x80112d40
80104e8b:	e8 b0 03 00 00       	call   80105240 <release>
80104e90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e93:	83 c4 10             	add    $0x10,%esp
80104e96:	31 c0                	xor    %eax,%eax
80104e98:	c9                   	leave
80104e99:	c3                   	ret
80104e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ea0:	83 ec 0c             	sub    $0xc,%esp
80104ea3:	68 40 2d 11 80       	push   $0x80112d40
80104ea8:	e8 93 03 00 00       	call   80105240 <release>
80104ead:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104eb0:	83 c4 10             	add    $0x10,%esp
80104eb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104eb8:	c9                   	leave
80104eb9:	c3                   	ret
80104eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ec0 <procdump>:
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	57                   	push   %edi
80104ec4:	56                   	push   %esi
80104ec5:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104ec8:	53                   	push   %ebx
80104ec9:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
80104ece:	83 ec 3c             	sub    $0x3c,%esp
80104ed1:	eb 24                	jmp    80104ef7 <procdump+0x37>
80104ed3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ed8:	83 ec 0c             	sub    $0xc,%esp
80104edb:	68 11 83 10 80       	push   $0x80108311
80104ee0:	e8 5b b9 ff ff       	call   80100840 <cprintf>
80104ee5:	83 c4 10             	add    $0x10,%esp
80104ee8:	83 c3 7c             	add    $0x7c,%ebx
80104eeb:	81 fb e0 4c 11 80    	cmp    $0x80114ce0,%ebx
80104ef1:	0f 84 81 00 00 00    	je     80104f78 <procdump+0xb8>
80104ef7:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104efa:	85 c0                	test   %eax,%eax
80104efc:	74 ea                	je     80104ee8 <procdump+0x28>
80104efe:	ba 63 81 10 80       	mov    $0x80108163,%edx
80104f03:	83 f8 05             	cmp    $0x5,%eax
80104f06:	77 11                	ja     80104f19 <procdump+0x59>
80104f08:	8b 14 85 a0 87 10 80 	mov    -0x7fef7860(,%eax,4),%edx
80104f0f:	b8 63 81 10 80       	mov    $0x80108163,%eax
80104f14:	85 d2                	test   %edx,%edx
80104f16:	0f 44 d0             	cmove  %eax,%edx
80104f19:	53                   	push   %ebx
80104f1a:	52                   	push   %edx
80104f1b:	ff 73 a4             	push   -0x5c(%ebx)
80104f1e:	68 67 81 10 80       	push   $0x80108167
80104f23:	e8 18 b9 ff ff       	call   80100840 <cprintf>
80104f28:	83 c4 10             	add    $0x10,%esp
80104f2b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104f2f:	75 a7                	jne    80104ed8 <procdump+0x18>
80104f31:	83 ec 08             	sub    $0x8,%esp
80104f34:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104f37:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104f3a:	50                   	push   %eax
80104f3b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104f3e:	8b 40 0c             	mov    0xc(%eax),%eax
80104f41:	83 c0 08             	add    $0x8,%eax
80104f44:	50                   	push   %eax
80104f45:	e8 86 01 00 00       	call   801050d0 <getcallerpcs>
80104f4a:	83 c4 10             	add    $0x10,%esp
80104f4d:	8d 76 00             	lea    0x0(%esi),%esi
80104f50:	8b 17                	mov    (%edi),%edx
80104f52:	85 d2                	test   %edx,%edx
80104f54:	74 82                	je     80104ed8 <procdump+0x18>
80104f56:	83 ec 08             	sub    $0x8,%esp
80104f59:	83 c7 04             	add    $0x4,%edi
80104f5c:	52                   	push   %edx
80104f5d:	68 c4 7e 10 80       	push   $0x80107ec4
80104f62:	e8 d9 b8 ff ff       	call   80100840 <cprintf>
80104f67:	83 c4 10             	add    $0x10,%esp
80104f6a:	39 f7                	cmp    %esi,%edi
80104f6c:	75 e2                	jne    80104f50 <procdump+0x90>
80104f6e:	e9 65 ff ff ff       	jmp    80104ed8 <procdump+0x18>
80104f73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f7b:	5b                   	pop    %ebx
80104f7c:	5e                   	pop    %esi
80104f7d:	5f                   	pop    %edi
80104f7e:	5d                   	pop    %ebp
80104f7f:	c3                   	ret

80104f80 <initsleeplock>:
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	53                   	push   %ebx
80104f84:	83 ec 0c             	sub    $0xc,%esp
80104f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104f8a:	68 9a 81 10 80       	push   $0x8010819a
80104f8f:	8d 43 04             	lea    0x4(%ebx),%eax
80104f92:	50                   	push   %eax
80104f93:	e8 18 01 00 00       	call   801050b0 <initlock>
80104f98:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f9b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104fa1:	83 c4 10             	add    $0x10,%esp
80104fa4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104fab:	89 43 38             	mov    %eax,0x38(%ebx)
80104fae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fb1:	c9                   	leave
80104fb2:	c3                   	ret
80104fb3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fba:	00 
80104fbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104fc0 <acquiresleep>:
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	56                   	push   %esi
80104fc4:	53                   	push   %ebx
80104fc5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104fc8:	8d 73 04             	lea    0x4(%ebx),%esi
80104fcb:	83 ec 0c             	sub    $0xc,%esp
80104fce:	56                   	push   %esi
80104fcf:	e8 cc 02 00 00       	call   801052a0 <acquire>
80104fd4:	8b 13                	mov    (%ebx),%edx
80104fd6:	83 c4 10             	add    $0x10,%esp
80104fd9:	85 d2                	test   %edx,%edx
80104fdb:	74 16                	je     80104ff3 <acquiresleep+0x33>
80104fdd:	8d 76 00             	lea    0x0(%esi),%esi
80104fe0:	83 ec 08             	sub    $0x8,%esp
80104fe3:	56                   	push   %esi
80104fe4:	53                   	push   %ebx
80104fe5:	e8 36 fd ff ff       	call   80104d20 <sleep>
80104fea:	8b 03                	mov    (%ebx),%eax
80104fec:	83 c4 10             	add    $0x10,%esp
80104fef:	85 c0                	test   %eax,%eax
80104ff1:	75 ed                	jne    80104fe0 <acquiresleep+0x20>
80104ff3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
80104ff9:	e8 62 f6 ff ff       	call   80104660 <myproc>
80104ffe:	8b 40 10             	mov    0x10(%eax),%eax
80105001:	89 43 3c             	mov    %eax,0x3c(%ebx)
80105004:	89 75 08             	mov    %esi,0x8(%ebp)
80105007:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010500a:	5b                   	pop    %ebx
8010500b:	5e                   	pop    %esi
8010500c:	5d                   	pop    %ebp
8010500d:	e9 2e 02 00 00       	jmp    80105240 <release>
80105012:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105019:	00 
8010501a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105020 <releasesleep>:
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	56                   	push   %esi
80105024:	53                   	push   %ebx
80105025:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105028:	8d 73 04             	lea    0x4(%ebx),%esi
8010502b:	83 ec 0c             	sub    $0xc,%esp
8010502e:	56                   	push   %esi
8010502f:	e8 6c 02 00 00       	call   801052a0 <acquire>
80105034:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010503a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80105041:	89 1c 24             	mov    %ebx,(%esp)
80105044:	e8 97 fd ff ff       	call   80104de0 <wakeup>
80105049:	83 c4 10             	add    $0x10,%esp
8010504c:	89 75 08             	mov    %esi,0x8(%ebp)
8010504f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105052:	5b                   	pop    %ebx
80105053:	5e                   	pop    %esi
80105054:	5d                   	pop    %ebp
80105055:	e9 e6 01 00 00       	jmp    80105240 <release>
8010505a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105060 <holdingsleep>:
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	57                   	push   %edi
80105064:	31 ff                	xor    %edi,%edi
80105066:	56                   	push   %esi
80105067:	53                   	push   %ebx
80105068:	83 ec 18             	sub    $0x18,%esp
8010506b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010506e:	8d 73 04             	lea    0x4(%ebx),%esi
80105071:	56                   	push   %esi
80105072:	e8 29 02 00 00       	call   801052a0 <acquire>
80105077:	8b 03                	mov    (%ebx),%eax
80105079:	83 c4 10             	add    $0x10,%esp
8010507c:	85 c0                	test   %eax,%eax
8010507e:	75 18                	jne    80105098 <holdingsleep+0x38>
80105080:	83 ec 0c             	sub    $0xc,%esp
80105083:	56                   	push   %esi
80105084:	e8 b7 01 00 00       	call   80105240 <release>
80105089:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010508c:	89 f8                	mov    %edi,%eax
8010508e:	5b                   	pop    %ebx
8010508f:	5e                   	pop    %esi
80105090:	5f                   	pop    %edi
80105091:	5d                   	pop    %ebp
80105092:	c3                   	ret
80105093:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105098:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010509b:	e8 c0 f5 ff ff       	call   80104660 <myproc>
801050a0:	39 58 10             	cmp    %ebx,0x10(%eax)
801050a3:	0f 94 c0             	sete   %al
801050a6:	0f b6 c0             	movzbl %al,%eax
801050a9:	89 c7                	mov    %eax,%edi
801050ab:	eb d3                	jmp    80105080 <holdingsleep+0x20>
801050ad:	66 90                	xchg   %ax,%ax
801050af:	90                   	nop

801050b0 <initlock>:
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	8b 45 08             	mov    0x8(%ebp),%eax
801050b6:	8b 55 0c             	mov    0xc(%ebp),%edx
801050b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801050bf:	89 50 04             	mov    %edx,0x4(%eax)
801050c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
801050c9:	5d                   	pop    %ebp
801050ca:	c3                   	ret
801050cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801050d0 <getcallerpcs>:
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	53                   	push   %ebx
801050d4:	8b 45 08             	mov    0x8(%ebp),%eax
801050d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801050da:	8d 50 f8             	lea    -0x8(%eax),%edx
801050dd:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
801050e2:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
801050e7:	b8 00 00 00 00       	mov    $0x0,%eax
801050ec:	76 10                	jbe    801050fe <getcallerpcs+0x2e>
801050ee:	eb 28                	jmp    80105118 <getcallerpcs+0x48>
801050f0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801050f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801050fc:	77 1a                	ja     80105118 <getcallerpcs+0x48>
801050fe:	8b 5a 04             	mov    0x4(%edx),%ebx
80105101:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
80105104:	83 c0 01             	add    $0x1,%eax
80105107:	8b 12                	mov    (%edx),%edx
80105109:	83 f8 0a             	cmp    $0xa,%eax
8010510c:	75 e2                	jne    801050f0 <getcallerpcs+0x20>
8010510e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105111:	c9                   	leave
80105112:	c3                   	ret
80105113:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105118:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010511b:	83 c1 28             	add    $0x28,%ecx
8010511e:	89 ca                	mov    %ecx,%edx
80105120:	29 c2                	sub    %eax,%edx
80105122:	83 e2 04             	and    $0x4,%edx
80105125:	74 11                	je     80105138 <getcallerpcs+0x68>
80105127:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010512d:	83 c0 04             	add    $0x4,%eax
80105130:	39 c1                	cmp    %eax,%ecx
80105132:	74 da                	je     8010510e <getcallerpcs+0x3e>
80105134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105138:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010513e:	83 c0 08             	add    $0x8,%eax
80105141:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
80105148:	39 c1                	cmp    %eax,%ecx
8010514a:	75 ec                	jne    80105138 <getcallerpcs+0x68>
8010514c:	eb c0                	jmp    8010510e <getcallerpcs+0x3e>
8010514e:	66 90                	xchg   %ax,%ax

80105150 <pushcli>:
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	53                   	push   %ebx
80105154:	83 ec 04             	sub    $0x4,%esp
80105157:	9c                   	pushf
80105158:	5b                   	pop    %ebx
80105159:	fa                   	cli
8010515a:	e8 81 f4 ff ff       	call   801045e0 <mycpu>
8010515f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105165:	85 c0                	test   %eax,%eax
80105167:	74 17                	je     80105180 <pushcli+0x30>
80105169:	e8 72 f4 ff ff       	call   801045e0 <mycpu>
8010516e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80105175:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105178:	c9                   	leave
80105179:	c3                   	ret
8010517a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105180:	e8 5b f4 ff ff       	call   801045e0 <mycpu>
80105185:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010518b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105191:	eb d6                	jmp    80105169 <pushcli+0x19>
80105193:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010519a:	00 
8010519b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801051a0 <popcli>:
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	83 ec 08             	sub    $0x8,%esp
801051a6:	9c                   	pushf
801051a7:	58                   	pop    %eax
801051a8:	f6 c4 02             	test   $0x2,%ah
801051ab:	75 35                	jne    801051e2 <popcli+0x42>
801051ad:	e8 2e f4 ff ff       	call   801045e0 <mycpu>
801051b2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801051b9:	78 34                	js     801051ef <popcli+0x4f>
801051bb:	e8 20 f4 ff ff       	call   801045e0 <mycpu>
801051c0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801051c6:	85 d2                	test   %edx,%edx
801051c8:	74 06                	je     801051d0 <popcli+0x30>
801051ca:	c9                   	leave
801051cb:	c3                   	ret
801051cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051d0:	e8 0b f4 ff ff       	call   801045e0 <mycpu>
801051d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801051db:	85 c0                	test   %eax,%eax
801051dd:	74 eb                	je     801051ca <popcli+0x2a>
801051df:	fb                   	sti
801051e0:	c9                   	leave
801051e1:	c3                   	ret
801051e2:	83 ec 0c             	sub    $0xc,%esp
801051e5:	68 a5 81 10 80       	push   $0x801081a5
801051ea:	e8 a1 b8 ff ff       	call   80100a90 <panic>
801051ef:	83 ec 0c             	sub    $0xc,%esp
801051f2:	68 bc 81 10 80       	push   $0x801081bc
801051f7:	e8 94 b8 ff ff       	call   80100a90 <panic>
801051fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105200 <holding>:
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	56                   	push   %esi
80105204:	53                   	push   %ebx
80105205:	8b 75 08             	mov    0x8(%ebp),%esi
80105208:	31 db                	xor    %ebx,%ebx
8010520a:	e8 41 ff ff ff       	call   80105150 <pushcli>
8010520f:	8b 06                	mov    (%esi),%eax
80105211:	85 c0                	test   %eax,%eax
80105213:	75 0b                	jne    80105220 <holding+0x20>
80105215:	e8 86 ff ff ff       	call   801051a0 <popcli>
8010521a:	89 d8                	mov    %ebx,%eax
8010521c:	5b                   	pop    %ebx
8010521d:	5e                   	pop    %esi
8010521e:	5d                   	pop    %ebp
8010521f:	c3                   	ret
80105220:	8b 5e 08             	mov    0x8(%esi),%ebx
80105223:	e8 b8 f3 ff ff       	call   801045e0 <mycpu>
80105228:	39 c3                	cmp    %eax,%ebx
8010522a:	0f 94 c3             	sete   %bl
8010522d:	e8 6e ff ff ff       	call   801051a0 <popcli>
80105232:	0f b6 db             	movzbl %bl,%ebx
80105235:	89 d8                	mov    %ebx,%eax
80105237:	5b                   	pop    %ebx
80105238:	5e                   	pop    %esi
80105239:	5d                   	pop    %ebp
8010523a:	c3                   	ret
8010523b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105240 <release>:
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	56                   	push   %esi
80105244:	53                   	push   %ebx
80105245:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105248:	e8 03 ff ff ff       	call   80105150 <pushcli>
8010524d:	8b 03                	mov    (%ebx),%eax
8010524f:	85 c0                	test   %eax,%eax
80105251:	75 15                	jne    80105268 <release+0x28>
80105253:	e8 48 ff ff ff       	call   801051a0 <popcli>
80105258:	83 ec 0c             	sub    $0xc,%esp
8010525b:	68 c3 81 10 80       	push   $0x801081c3
80105260:	e8 2b b8 ff ff       	call   80100a90 <panic>
80105265:	8d 76 00             	lea    0x0(%esi),%esi
80105268:	8b 73 08             	mov    0x8(%ebx),%esi
8010526b:	e8 70 f3 ff ff       	call   801045e0 <mycpu>
80105270:	39 c6                	cmp    %eax,%esi
80105272:	75 df                	jne    80105253 <release+0x13>
80105274:	e8 27 ff ff ff       	call   801051a0 <popcli>
80105279:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80105280:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80105287:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
8010528c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80105292:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105295:	5b                   	pop    %ebx
80105296:	5e                   	pop    %esi
80105297:	5d                   	pop    %ebp
80105298:	e9 03 ff ff ff       	jmp    801051a0 <popcli>
8010529d:	8d 76 00             	lea    0x0(%esi),%esi

801052a0 <acquire>:
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	53                   	push   %ebx
801052a4:	83 ec 04             	sub    $0x4,%esp
801052a7:	e8 a4 fe ff ff       	call   80105150 <pushcli>
801052ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052af:	e8 9c fe ff ff       	call   80105150 <pushcli>
801052b4:	8b 03                	mov    (%ebx),%eax
801052b6:	85 c0                	test   %eax,%eax
801052b8:	0f 85 b2 00 00 00    	jne    80105370 <acquire+0xd0>
801052be:	e8 dd fe ff ff       	call   801051a0 <popcli>
801052c3:	b9 01 00 00 00       	mov    $0x1,%ecx
801052c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052cf:	00 
801052d0:	8b 55 08             	mov    0x8(%ebp),%edx
801052d3:	89 c8                	mov    %ecx,%eax
801052d5:	f0 87 02             	lock xchg %eax,(%edx)
801052d8:	85 c0                	test   %eax,%eax
801052da:	75 f4                	jne    801052d0 <acquire+0x30>
801052dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801052e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052e4:	e8 f7 f2 ff ff       	call   801045e0 <mycpu>
801052e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801052ec:	31 d2                	xor    %edx,%edx
801052ee:	89 43 08             	mov    %eax,0x8(%ebx)
801052f1:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
801052f7:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
801052fc:	77 32                	ja     80105330 <acquire+0x90>
801052fe:	89 e8                	mov    %ebp,%eax
80105300:	eb 14                	jmp    80105316 <acquire+0x76>
80105302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105308:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010530e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105314:	77 1a                	ja     80105330 <acquire+0x90>
80105316:	8b 58 04             	mov    0x4(%eax),%ebx
80105319:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
8010531d:	83 c2 01             	add    $0x1,%edx
80105320:	8b 00                	mov    (%eax),%eax
80105322:	83 fa 0a             	cmp    $0xa,%edx
80105325:	75 e1                	jne    80105308 <acquire+0x68>
80105327:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010532a:	c9                   	leave
8010532b:	c3                   	ret
8010532c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105330:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80105334:	83 c1 34             	add    $0x34,%ecx
80105337:	89 ca                	mov    %ecx,%edx
80105339:	29 c2                	sub    %eax,%edx
8010533b:	83 e2 04             	and    $0x4,%edx
8010533e:	74 10                	je     80105350 <acquire+0xb0>
80105340:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105346:	83 c0 04             	add    $0x4,%eax
80105349:	39 c1                	cmp    %eax,%ecx
8010534b:	74 da                	je     80105327 <acquire+0x87>
8010534d:	8d 76 00             	lea    0x0(%esi),%esi
80105350:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105356:	83 c0 08             	add    $0x8,%eax
80105359:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
80105360:	39 c1                	cmp    %eax,%ecx
80105362:	75 ec                	jne    80105350 <acquire+0xb0>
80105364:	eb c1                	jmp    80105327 <acquire+0x87>
80105366:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010536d:	00 
8010536e:	66 90                	xchg   %ax,%ax
80105370:	8b 5b 08             	mov    0x8(%ebx),%ebx
80105373:	e8 68 f2 ff ff       	call   801045e0 <mycpu>
80105378:	39 c3                	cmp    %eax,%ebx
8010537a:	0f 85 3e ff ff ff    	jne    801052be <acquire+0x1e>
80105380:	e8 1b fe ff ff       	call   801051a0 <popcli>
80105385:	83 ec 0c             	sub    $0xc,%esp
80105388:	68 cb 81 10 80       	push   $0x801081cb
8010538d:	e8 fe b6 ff ff       	call   80100a90 <panic>
80105392:	66 90                	xchg   %ax,%ax
80105394:	66 90                	xchg   %ax,%ax
80105396:	66 90                	xchg   %ax,%ax
80105398:	66 90                	xchg   %ax,%ax
8010539a:	66 90                	xchg   %ax,%ax
8010539c:	66 90                	xchg   %ax,%ax
8010539e:	66 90                	xchg   %ax,%ax

801053a0 <memset>:
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	57                   	push   %edi
801053a4:	8b 55 08             	mov    0x8(%ebp),%edx
801053a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801053aa:	89 d0                	mov    %edx,%eax
801053ac:	09 c8                	or     %ecx,%eax
801053ae:	a8 03                	test   $0x3,%al
801053b0:	75 1e                	jne    801053d0 <memset+0x30>
801053b2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
801053b6:	c1 e9 02             	shr    $0x2,%ecx
801053b9:	89 d7                	mov    %edx,%edi
801053bb:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
801053c1:	fc                   	cld
801053c2:	f3 ab                	rep stos %eax,%es:(%edi)
801053c4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801053c7:	89 d0                	mov    %edx,%eax
801053c9:	c9                   	leave
801053ca:	c3                   	ret
801053cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801053d0:	8b 45 0c             	mov    0xc(%ebp),%eax
801053d3:	89 d7                	mov    %edx,%edi
801053d5:	fc                   	cld
801053d6:	f3 aa                	rep stos %al,%es:(%edi)
801053d8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801053db:	89 d0                	mov    %edx,%eax
801053dd:	c9                   	leave
801053de:	c3                   	ret
801053df:	90                   	nop

801053e0 <memcmp>:
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	56                   	push   %esi
801053e4:	8b 75 10             	mov    0x10(%ebp),%esi
801053e7:	8b 45 08             	mov    0x8(%ebp),%eax
801053ea:	53                   	push   %ebx
801053eb:	8b 55 0c             	mov    0xc(%ebp),%edx
801053ee:	85 f6                	test   %esi,%esi
801053f0:	74 2e                	je     80105420 <memcmp+0x40>
801053f2:	01 c6                	add    %eax,%esi
801053f4:	eb 14                	jmp    8010540a <memcmp+0x2a>
801053f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053fd:	00 
801053fe:	66 90                	xchg   %ax,%ax
80105400:	83 c0 01             	add    $0x1,%eax
80105403:	83 c2 01             	add    $0x1,%edx
80105406:	39 f0                	cmp    %esi,%eax
80105408:	74 16                	je     80105420 <memcmp+0x40>
8010540a:	0f b6 08             	movzbl (%eax),%ecx
8010540d:	0f b6 1a             	movzbl (%edx),%ebx
80105410:	38 d9                	cmp    %bl,%cl
80105412:	74 ec                	je     80105400 <memcmp+0x20>
80105414:	0f b6 c1             	movzbl %cl,%eax
80105417:	29 d8                	sub    %ebx,%eax
80105419:	5b                   	pop    %ebx
8010541a:	5e                   	pop    %esi
8010541b:	5d                   	pop    %ebp
8010541c:	c3                   	ret
8010541d:	8d 76 00             	lea    0x0(%esi),%esi
80105420:	5b                   	pop    %ebx
80105421:	31 c0                	xor    %eax,%eax
80105423:	5e                   	pop    %esi
80105424:	5d                   	pop    %ebp
80105425:	c3                   	ret
80105426:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010542d:	00 
8010542e:	66 90                	xchg   %ax,%ax

80105430 <memmove>:
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	8b 55 08             	mov    0x8(%ebp),%edx
80105437:	8b 45 10             	mov    0x10(%ebp),%eax
8010543a:	56                   	push   %esi
8010543b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010543e:	39 d6                	cmp    %edx,%esi
80105440:	73 26                	jae    80105468 <memmove+0x38>
80105442:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80105445:	39 ca                	cmp    %ecx,%edx
80105447:	73 1f                	jae    80105468 <memmove+0x38>
80105449:	85 c0                	test   %eax,%eax
8010544b:	74 0f                	je     8010545c <memmove+0x2c>
8010544d:	83 e8 01             	sub    $0x1,%eax
80105450:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105454:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80105457:	83 e8 01             	sub    $0x1,%eax
8010545a:	73 f4                	jae    80105450 <memmove+0x20>
8010545c:	5e                   	pop    %esi
8010545d:	89 d0                	mov    %edx,%eax
8010545f:	5f                   	pop    %edi
80105460:	5d                   	pop    %ebp
80105461:	c3                   	ret
80105462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105468:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010546b:	89 d7                	mov    %edx,%edi
8010546d:	85 c0                	test   %eax,%eax
8010546f:	74 eb                	je     8010545c <memmove+0x2c>
80105471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105478:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80105479:	39 ce                	cmp    %ecx,%esi
8010547b:	75 fb                	jne    80105478 <memmove+0x48>
8010547d:	5e                   	pop    %esi
8010547e:	89 d0                	mov    %edx,%eax
80105480:	5f                   	pop    %edi
80105481:	5d                   	pop    %ebp
80105482:	c3                   	ret
80105483:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010548a:	00 
8010548b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105490 <memcpy>:
80105490:	eb 9e                	jmp    80105430 <memmove>
80105492:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105499:	00 
8010549a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801054a0 <strncmp>:
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	53                   	push   %ebx
801054a4:	8b 55 10             	mov    0x10(%ebp),%edx
801054a7:	8b 45 08             	mov    0x8(%ebp),%eax
801054aa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801054ad:	85 d2                	test   %edx,%edx
801054af:	75 16                	jne    801054c7 <strncmp+0x27>
801054b1:	eb 2d                	jmp    801054e0 <strncmp+0x40>
801054b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801054b8:	3a 19                	cmp    (%ecx),%bl
801054ba:	75 12                	jne    801054ce <strncmp+0x2e>
801054bc:	83 c0 01             	add    $0x1,%eax
801054bf:	83 c1 01             	add    $0x1,%ecx
801054c2:	83 ea 01             	sub    $0x1,%edx
801054c5:	74 19                	je     801054e0 <strncmp+0x40>
801054c7:	0f b6 18             	movzbl (%eax),%ebx
801054ca:	84 db                	test   %bl,%bl
801054cc:	75 ea                	jne    801054b8 <strncmp+0x18>
801054ce:	0f b6 00             	movzbl (%eax),%eax
801054d1:	0f b6 11             	movzbl (%ecx),%edx
801054d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054d7:	c9                   	leave
801054d8:	29 d0                	sub    %edx,%eax
801054da:	c3                   	ret
801054db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801054e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054e3:	31 c0                	xor    %eax,%eax
801054e5:	c9                   	leave
801054e6:	c3                   	ret
801054e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054ee:	00 
801054ef:	90                   	nop

801054f0 <strncpy>:
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	57                   	push   %edi
801054f4:	56                   	push   %esi
801054f5:	8b 75 08             	mov    0x8(%ebp),%esi
801054f8:	53                   	push   %ebx
801054f9:	8b 55 10             	mov    0x10(%ebp),%edx
801054fc:	89 f0                	mov    %esi,%eax
801054fe:	eb 15                	jmp    80105515 <strncpy+0x25>
80105500:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105504:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105507:	83 c0 01             	add    $0x1,%eax
8010550a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
8010550e:	88 48 ff             	mov    %cl,-0x1(%eax)
80105511:	84 c9                	test   %cl,%cl
80105513:	74 13                	je     80105528 <strncpy+0x38>
80105515:	89 d3                	mov    %edx,%ebx
80105517:	83 ea 01             	sub    $0x1,%edx
8010551a:	85 db                	test   %ebx,%ebx
8010551c:	7f e2                	jg     80105500 <strncpy+0x10>
8010551e:	5b                   	pop    %ebx
8010551f:	89 f0                	mov    %esi,%eax
80105521:	5e                   	pop    %esi
80105522:	5f                   	pop    %edi
80105523:	5d                   	pop    %ebp
80105524:	c3                   	ret
80105525:	8d 76 00             	lea    0x0(%esi),%esi
80105528:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
8010552b:	83 e9 01             	sub    $0x1,%ecx
8010552e:	85 d2                	test   %edx,%edx
80105530:	74 ec                	je     8010551e <strncpy+0x2e>
80105532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105538:	83 c0 01             	add    $0x1,%eax
8010553b:	89 ca                	mov    %ecx,%edx
8010553d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
80105541:	29 c2                	sub    %eax,%edx
80105543:	85 d2                	test   %edx,%edx
80105545:	7f f1                	jg     80105538 <strncpy+0x48>
80105547:	5b                   	pop    %ebx
80105548:	89 f0                	mov    %esi,%eax
8010554a:	5e                   	pop    %esi
8010554b:	5f                   	pop    %edi
8010554c:	5d                   	pop    %ebp
8010554d:	c3                   	ret
8010554e:	66 90                	xchg   %ax,%ax

80105550 <safestrcpy>:
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	56                   	push   %esi
80105554:	8b 55 10             	mov    0x10(%ebp),%edx
80105557:	8b 75 08             	mov    0x8(%ebp),%esi
8010555a:	53                   	push   %ebx
8010555b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010555e:	85 d2                	test   %edx,%edx
80105560:	7e 25                	jle    80105587 <safestrcpy+0x37>
80105562:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105566:	89 f2                	mov    %esi,%edx
80105568:	eb 16                	jmp    80105580 <safestrcpy+0x30>
8010556a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105570:	0f b6 08             	movzbl (%eax),%ecx
80105573:	83 c0 01             	add    $0x1,%eax
80105576:	83 c2 01             	add    $0x1,%edx
80105579:	88 4a ff             	mov    %cl,-0x1(%edx)
8010557c:	84 c9                	test   %cl,%cl
8010557e:	74 04                	je     80105584 <safestrcpy+0x34>
80105580:	39 d8                	cmp    %ebx,%eax
80105582:	75 ec                	jne    80105570 <safestrcpy+0x20>
80105584:	c6 02 00             	movb   $0x0,(%edx)
80105587:	89 f0                	mov    %esi,%eax
80105589:	5b                   	pop    %ebx
8010558a:	5e                   	pop    %esi
8010558b:	5d                   	pop    %ebp
8010558c:	c3                   	ret
8010558d:	8d 76 00             	lea    0x0(%esi),%esi

80105590 <strlen>:
80105590:	55                   	push   %ebp
80105591:	31 c0                	xor    %eax,%eax
80105593:	89 e5                	mov    %esp,%ebp
80105595:	8b 55 08             	mov    0x8(%ebp),%edx
80105598:	80 3a 00             	cmpb   $0x0,(%edx)
8010559b:	74 0c                	je     801055a9 <strlen+0x19>
8010559d:	8d 76 00             	lea    0x0(%esi),%esi
801055a0:	83 c0 01             	add    $0x1,%eax
801055a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801055a7:	75 f7                	jne    801055a0 <strlen+0x10>
801055a9:	5d                   	pop    %ebp
801055aa:	c3                   	ret

801055ab <swtch>:
801055ab:	8b 44 24 04          	mov    0x4(%esp),%eax
801055af:	8b 54 24 08          	mov    0x8(%esp),%edx
801055b3:	55                   	push   %ebp
801055b4:	53                   	push   %ebx
801055b5:	56                   	push   %esi
801055b6:	57                   	push   %edi
801055b7:	89 20                	mov    %esp,(%eax)
801055b9:	89 d4                	mov    %edx,%esp
801055bb:	5f                   	pop    %edi
801055bc:	5e                   	pop    %esi
801055bd:	5b                   	pop    %ebx
801055be:	5d                   	pop    %ebp
801055bf:	c3                   	ret

801055c0 <fetchint>:
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	53                   	push   %ebx
801055c4:	83 ec 04             	sub    $0x4,%esp
801055c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801055ca:	e8 91 f0 ff ff       	call   80104660 <myproc>
801055cf:	8b 00                	mov    (%eax),%eax
801055d1:	39 c3                	cmp    %eax,%ebx
801055d3:	73 1b                	jae    801055f0 <fetchint+0x30>
801055d5:	8d 53 04             	lea    0x4(%ebx),%edx
801055d8:	39 d0                	cmp    %edx,%eax
801055da:	72 14                	jb     801055f0 <fetchint+0x30>
801055dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801055df:	8b 13                	mov    (%ebx),%edx
801055e1:	89 10                	mov    %edx,(%eax)
801055e3:	31 c0                	xor    %eax,%eax
801055e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055e8:	c9                   	leave
801055e9:	c3                   	ret
801055ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055f5:	eb ee                	jmp    801055e5 <fetchint+0x25>
801055f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055fe:	00 
801055ff:	90                   	nop

80105600 <fetchstr>:
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	53                   	push   %ebx
80105604:	83 ec 04             	sub    $0x4,%esp
80105607:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010560a:	e8 51 f0 ff ff       	call   80104660 <myproc>
8010560f:	3b 18                	cmp    (%eax),%ebx
80105611:	73 2d                	jae    80105640 <fetchstr+0x40>
80105613:	8b 55 0c             	mov    0xc(%ebp),%edx
80105616:	89 1a                	mov    %ebx,(%edx)
80105618:	8b 10                	mov    (%eax),%edx
8010561a:	39 d3                	cmp    %edx,%ebx
8010561c:	73 22                	jae    80105640 <fetchstr+0x40>
8010561e:	89 d8                	mov    %ebx,%eax
80105620:	eb 0d                	jmp    8010562f <fetchstr+0x2f>
80105622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105628:	83 c0 01             	add    $0x1,%eax
8010562b:	39 d0                	cmp    %edx,%eax
8010562d:	73 11                	jae    80105640 <fetchstr+0x40>
8010562f:	80 38 00             	cmpb   $0x0,(%eax)
80105632:	75 f4                	jne    80105628 <fetchstr+0x28>
80105634:	29 d8                	sub    %ebx,%eax
80105636:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105639:	c9                   	leave
8010563a:	c3                   	ret
8010563b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105640:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105643:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105648:	c9                   	leave
80105649:	c3                   	ret
8010564a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105650 <argint>:
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	56                   	push   %esi
80105654:	53                   	push   %ebx
80105655:	e8 06 f0 ff ff       	call   80104660 <myproc>
8010565a:	8b 55 08             	mov    0x8(%ebp),%edx
8010565d:	8b 40 18             	mov    0x18(%eax),%eax
80105660:	8b 40 44             	mov    0x44(%eax),%eax
80105663:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80105666:	e8 f5 ef ff ff       	call   80104660 <myproc>
8010566b:	8d 73 04             	lea    0x4(%ebx),%esi
8010566e:	8b 00                	mov    (%eax),%eax
80105670:	39 c6                	cmp    %eax,%esi
80105672:	73 1c                	jae    80105690 <argint+0x40>
80105674:	8d 53 08             	lea    0x8(%ebx),%edx
80105677:	39 d0                	cmp    %edx,%eax
80105679:	72 15                	jb     80105690 <argint+0x40>
8010567b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010567e:	8b 53 04             	mov    0x4(%ebx),%edx
80105681:	89 10                	mov    %edx,(%eax)
80105683:	31 c0                	xor    %eax,%eax
80105685:	5b                   	pop    %ebx
80105686:	5e                   	pop    %esi
80105687:	5d                   	pop    %ebp
80105688:	c3                   	ret
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105690:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105695:	eb ee                	jmp    80105685 <argint+0x35>
80105697:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010569e:	00 
8010569f:	90                   	nop

801056a0 <argptr>:
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	57                   	push   %edi
801056a4:	56                   	push   %esi
801056a5:	53                   	push   %ebx
801056a6:	83 ec 0c             	sub    $0xc,%esp
801056a9:	e8 b2 ef ff ff       	call   80104660 <myproc>
801056ae:	89 c6                	mov    %eax,%esi
801056b0:	e8 ab ef ff ff       	call   80104660 <myproc>
801056b5:	8b 55 08             	mov    0x8(%ebp),%edx
801056b8:	8b 40 18             	mov    0x18(%eax),%eax
801056bb:	8b 40 44             	mov    0x44(%eax),%eax
801056be:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801056c1:	e8 9a ef ff ff       	call   80104660 <myproc>
801056c6:	8d 7b 04             	lea    0x4(%ebx),%edi
801056c9:	8b 00                	mov    (%eax),%eax
801056cb:	39 c7                	cmp    %eax,%edi
801056cd:	73 31                	jae    80105700 <argptr+0x60>
801056cf:	8d 4b 08             	lea    0x8(%ebx),%ecx
801056d2:	39 c8                	cmp    %ecx,%eax
801056d4:	72 2a                	jb     80105700 <argptr+0x60>
801056d6:	8b 55 10             	mov    0x10(%ebp),%edx
801056d9:	8b 43 04             	mov    0x4(%ebx),%eax
801056dc:	85 d2                	test   %edx,%edx
801056de:	78 20                	js     80105700 <argptr+0x60>
801056e0:	8b 16                	mov    (%esi),%edx
801056e2:	39 d0                	cmp    %edx,%eax
801056e4:	73 1a                	jae    80105700 <argptr+0x60>
801056e6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801056e9:	01 c3                	add    %eax,%ebx
801056eb:	39 da                	cmp    %ebx,%edx
801056ed:	72 11                	jb     80105700 <argptr+0x60>
801056ef:	8b 55 0c             	mov    0xc(%ebp),%edx
801056f2:	89 02                	mov    %eax,(%edx)
801056f4:	31 c0                	xor    %eax,%eax
801056f6:	83 c4 0c             	add    $0xc,%esp
801056f9:	5b                   	pop    %ebx
801056fa:	5e                   	pop    %esi
801056fb:	5f                   	pop    %edi
801056fc:	5d                   	pop    %ebp
801056fd:	c3                   	ret
801056fe:	66 90                	xchg   %ax,%ax
80105700:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105705:	eb ef                	jmp    801056f6 <argptr+0x56>
80105707:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010570e:	00 
8010570f:	90                   	nop

80105710 <argstr>:
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	56                   	push   %esi
80105714:	53                   	push   %ebx
80105715:	e8 46 ef ff ff       	call   80104660 <myproc>
8010571a:	8b 55 08             	mov    0x8(%ebp),%edx
8010571d:	8b 40 18             	mov    0x18(%eax),%eax
80105720:	8b 40 44             	mov    0x44(%eax),%eax
80105723:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80105726:	e8 35 ef ff ff       	call   80104660 <myproc>
8010572b:	8d 73 04             	lea    0x4(%ebx),%esi
8010572e:	8b 00                	mov    (%eax),%eax
80105730:	39 c6                	cmp    %eax,%esi
80105732:	73 44                	jae    80105778 <argstr+0x68>
80105734:	8d 53 08             	lea    0x8(%ebx),%edx
80105737:	39 d0                	cmp    %edx,%eax
80105739:	72 3d                	jb     80105778 <argstr+0x68>
8010573b:	8b 5b 04             	mov    0x4(%ebx),%ebx
8010573e:	e8 1d ef ff ff       	call   80104660 <myproc>
80105743:	3b 18                	cmp    (%eax),%ebx
80105745:	73 31                	jae    80105778 <argstr+0x68>
80105747:	8b 55 0c             	mov    0xc(%ebp),%edx
8010574a:	89 1a                	mov    %ebx,(%edx)
8010574c:	8b 10                	mov    (%eax),%edx
8010574e:	39 d3                	cmp    %edx,%ebx
80105750:	73 26                	jae    80105778 <argstr+0x68>
80105752:	89 d8                	mov    %ebx,%eax
80105754:	eb 11                	jmp    80105767 <argstr+0x57>
80105756:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010575d:	00 
8010575e:	66 90                	xchg   %ax,%ax
80105760:	83 c0 01             	add    $0x1,%eax
80105763:	39 d0                	cmp    %edx,%eax
80105765:	73 11                	jae    80105778 <argstr+0x68>
80105767:	80 38 00             	cmpb   $0x0,(%eax)
8010576a:	75 f4                	jne    80105760 <argstr+0x50>
8010576c:	29 d8                	sub    %ebx,%eax
8010576e:	5b                   	pop    %ebx
8010576f:	5e                   	pop    %esi
80105770:	5d                   	pop    %ebp
80105771:	c3                   	ret
80105772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105778:	5b                   	pop    %ebx
80105779:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010577e:	5e                   	pop    %esi
8010577f:	5d                   	pop    %ebp
80105780:	c3                   	ret
80105781:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105788:	00 
80105789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105790 <syscall>:
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	53                   	push   %ebx
80105794:	83 ec 04             	sub    $0x4,%esp
80105797:	e8 c4 ee ff ff       	call   80104660 <myproc>
8010579c:	89 c3                	mov    %eax,%ebx
8010579e:	8b 40 18             	mov    0x18(%eax),%eax
801057a1:	8b 40 1c             	mov    0x1c(%eax),%eax
801057a4:	8d 50 ff             	lea    -0x1(%eax),%edx
801057a7:	83 fa 14             	cmp    $0x14,%edx
801057aa:	77 24                	ja     801057d0 <syscall+0x40>
801057ac:	8b 14 85 c0 87 10 80 	mov    -0x7fef7840(,%eax,4),%edx
801057b3:	85 d2                	test   %edx,%edx
801057b5:	74 19                	je     801057d0 <syscall+0x40>
801057b7:	ff d2                	call   *%edx
801057b9:	89 c2                	mov    %eax,%edx
801057bb:	8b 43 18             	mov    0x18(%ebx),%eax
801057be:	89 50 1c             	mov    %edx,0x1c(%eax)
801057c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057c4:	c9                   	leave
801057c5:	c3                   	ret
801057c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057cd:	00 
801057ce:	66 90                	xchg   %ax,%ax
801057d0:	50                   	push   %eax
801057d1:	8d 43 6c             	lea    0x6c(%ebx),%eax
801057d4:	50                   	push   %eax
801057d5:	ff 73 10             	push   0x10(%ebx)
801057d8:	68 d3 81 10 80       	push   $0x801081d3
801057dd:	e8 5e b0 ff ff       	call   80100840 <cprintf>
801057e2:	8b 43 18             	mov    0x18(%ebx),%eax
801057e5:	83 c4 10             	add    $0x10,%esp
801057e8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
801057ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057f2:	c9                   	leave
801057f3:	c3                   	ret
801057f4:	66 90                	xchg   %ax,%ax
801057f6:	66 90                	xchg   %ax,%ax
801057f8:	66 90                	xchg   %ax,%ax
801057fa:	66 90                	xchg   %ax,%ax
801057fc:	66 90                	xchg   %ax,%ax
801057fe:	66 90                	xchg   %ax,%ax

80105800 <create>:
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	57                   	push   %edi
80105804:	56                   	push   %esi
80105805:	8d 7d da             	lea    -0x26(%ebp),%edi
80105808:	53                   	push   %ebx
80105809:	83 ec 34             	sub    $0x34,%esp
8010580c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010580f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105812:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105815:	89 4d cc             	mov    %ecx,-0x34(%ebp)
80105818:	57                   	push   %edi
80105819:	50                   	push   %eax
8010581a:	e8 81 d5 ff ff       	call   80102da0 <nameiparent>
8010581f:	83 c4 10             	add    $0x10,%esp
80105822:	85 c0                	test   %eax,%eax
80105824:	74 5e                	je     80105884 <create+0x84>
80105826:	83 ec 0c             	sub    $0xc,%esp
80105829:	89 c3                	mov    %eax,%ebx
8010582b:	50                   	push   %eax
8010582c:	e8 6f cc ff ff       	call   801024a0 <ilock>
80105831:	83 c4 0c             	add    $0xc,%esp
80105834:	6a 00                	push   $0x0
80105836:	57                   	push   %edi
80105837:	53                   	push   %ebx
80105838:	e8 b3 d1 ff ff       	call   801029f0 <dirlookup>
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	89 c6                	mov    %eax,%esi
80105842:	85 c0                	test   %eax,%eax
80105844:	74 4a                	je     80105890 <create+0x90>
80105846:	83 ec 0c             	sub    $0xc,%esp
80105849:	53                   	push   %ebx
8010584a:	e8 e1 ce ff ff       	call   80102730 <iunlockput>
8010584f:	89 34 24             	mov    %esi,(%esp)
80105852:	e8 49 cc ff ff       	call   801024a0 <ilock>
80105857:	83 c4 10             	add    $0x10,%esp
8010585a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010585f:	75 17                	jne    80105878 <create+0x78>
80105861:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105866:	75 10                	jne    80105878 <create+0x78>
80105868:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010586b:	89 f0                	mov    %esi,%eax
8010586d:	5b                   	pop    %ebx
8010586e:	5e                   	pop    %esi
8010586f:	5f                   	pop    %edi
80105870:	5d                   	pop    %ebp
80105871:	c3                   	ret
80105872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105878:	83 ec 0c             	sub    $0xc,%esp
8010587b:	56                   	push   %esi
8010587c:	e8 af ce ff ff       	call   80102730 <iunlockput>
80105881:	83 c4 10             	add    $0x10,%esp
80105884:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105887:	31 f6                	xor    %esi,%esi
80105889:	5b                   	pop    %ebx
8010588a:	89 f0                	mov    %esi,%eax
8010588c:	5e                   	pop    %esi
8010588d:	5f                   	pop    %edi
8010588e:	5d                   	pop    %ebp
8010588f:	c3                   	ret
80105890:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105894:	83 ec 08             	sub    $0x8,%esp
80105897:	50                   	push   %eax
80105898:	ff 33                	push   (%ebx)
8010589a:	e8 91 ca ff ff       	call   80102330 <ialloc>
8010589f:	83 c4 10             	add    $0x10,%esp
801058a2:	89 c6                	mov    %eax,%esi
801058a4:	85 c0                	test   %eax,%eax
801058a6:	0f 84 bc 00 00 00    	je     80105968 <create+0x168>
801058ac:	83 ec 0c             	sub    $0xc,%esp
801058af:	50                   	push   %eax
801058b0:	e8 eb cb ff ff       	call   801024a0 <ilock>
801058b5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801058b9:	66 89 46 52          	mov    %ax,0x52(%esi)
801058bd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801058c1:	66 89 46 54          	mov    %ax,0x54(%esi)
801058c5:	b8 01 00 00 00       	mov    $0x1,%eax
801058ca:	66 89 46 56          	mov    %ax,0x56(%esi)
801058ce:	89 34 24             	mov    %esi,(%esp)
801058d1:	e8 1a cb ff ff       	call   801023f0 <iupdate>
801058d6:	83 c4 10             	add    $0x10,%esp
801058d9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801058de:	74 30                	je     80105910 <create+0x110>
801058e0:	83 ec 04             	sub    $0x4,%esp
801058e3:	ff 76 04             	push   0x4(%esi)
801058e6:	57                   	push   %edi
801058e7:	53                   	push   %ebx
801058e8:	e8 d3 d3 ff ff       	call   80102cc0 <dirlink>
801058ed:	83 c4 10             	add    $0x10,%esp
801058f0:	85 c0                	test   %eax,%eax
801058f2:	78 67                	js     8010595b <create+0x15b>
801058f4:	83 ec 0c             	sub    $0xc,%esp
801058f7:	53                   	push   %ebx
801058f8:	e8 33 ce ff ff       	call   80102730 <iunlockput>
801058fd:	83 c4 10             	add    $0x10,%esp
80105900:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105903:	89 f0                	mov    %esi,%eax
80105905:	5b                   	pop    %ebx
80105906:	5e                   	pop    %esi
80105907:	5f                   	pop    %edi
80105908:	5d                   	pop    %ebp
80105909:	c3                   	ret
8010590a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105910:	83 ec 0c             	sub    $0xc,%esp
80105913:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80105918:	53                   	push   %ebx
80105919:	e8 d2 ca ff ff       	call   801023f0 <iupdate>
8010591e:	83 c4 0c             	add    $0xc,%esp
80105921:	ff 76 04             	push   0x4(%esi)
80105924:	68 0b 82 10 80       	push   $0x8010820b
80105929:	56                   	push   %esi
8010592a:	e8 91 d3 ff ff       	call   80102cc0 <dirlink>
8010592f:	83 c4 10             	add    $0x10,%esp
80105932:	85 c0                	test   %eax,%eax
80105934:	78 18                	js     8010594e <create+0x14e>
80105936:	83 ec 04             	sub    $0x4,%esp
80105939:	ff 73 04             	push   0x4(%ebx)
8010593c:	68 0a 82 10 80       	push   $0x8010820a
80105941:	56                   	push   %esi
80105942:	e8 79 d3 ff ff       	call   80102cc0 <dirlink>
80105947:	83 c4 10             	add    $0x10,%esp
8010594a:	85 c0                	test   %eax,%eax
8010594c:	79 92                	jns    801058e0 <create+0xe0>
8010594e:	83 ec 0c             	sub    $0xc,%esp
80105951:	68 fe 81 10 80       	push   $0x801081fe
80105956:	e8 35 b1 ff ff       	call   80100a90 <panic>
8010595b:	83 ec 0c             	sub    $0xc,%esp
8010595e:	68 0d 82 10 80       	push   $0x8010820d
80105963:	e8 28 b1 ff ff       	call   80100a90 <panic>
80105968:	83 ec 0c             	sub    $0xc,%esp
8010596b:	68 ef 81 10 80       	push   $0x801081ef
80105970:	e8 1b b1 ff ff       	call   80100a90 <panic>
80105975:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010597c:	00 
8010597d:	8d 76 00             	lea    0x0(%esi),%esi

80105980 <sys_dup>:
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	56                   	push   %esi
80105984:	53                   	push   %ebx
80105985:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105988:	83 ec 18             	sub    $0x18,%esp
8010598b:	50                   	push   %eax
8010598c:	6a 00                	push   $0x0
8010598e:	e8 bd fc ff ff       	call   80105650 <argint>
80105993:	83 c4 10             	add    $0x10,%esp
80105996:	85 c0                	test   %eax,%eax
80105998:	78 36                	js     801059d0 <sys_dup+0x50>
8010599a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010599e:	77 30                	ja     801059d0 <sys_dup+0x50>
801059a0:	e8 bb ec ff ff       	call   80104660 <myproc>
801059a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059a8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801059ac:	85 f6                	test   %esi,%esi
801059ae:	74 20                	je     801059d0 <sys_dup+0x50>
801059b0:	e8 ab ec ff ff       	call   80104660 <myproc>
801059b5:	31 db                	xor    %ebx,%ebx
801059b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059be:	00 
801059bf:	90                   	nop
801059c0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801059c4:	85 d2                	test   %edx,%edx
801059c6:	74 18                	je     801059e0 <sys_dup+0x60>
801059c8:	83 c3 01             	add    $0x1,%ebx
801059cb:	83 fb 10             	cmp    $0x10,%ebx
801059ce:	75 f0                	jne    801059c0 <sys_dup+0x40>
801059d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059d3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059d8:	89 d8                	mov    %ebx,%eax
801059da:	5b                   	pop    %ebx
801059db:	5e                   	pop    %esi
801059dc:	5d                   	pop    %ebp
801059dd:	c3                   	ret
801059de:	66 90                	xchg   %ax,%ax
801059e0:	83 ec 0c             	sub    $0xc,%esp
801059e3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
801059e7:	56                   	push   %esi
801059e8:	e8 d3 c1 ff ff       	call   80101bc0 <filedup>
801059ed:	83 c4 10             	add    $0x10,%esp
801059f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059f3:	89 d8                	mov    %ebx,%eax
801059f5:	5b                   	pop    %ebx
801059f6:	5e                   	pop    %esi
801059f7:	5d                   	pop    %ebp
801059f8:	c3                   	ret
801059f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a00 <sys_read>:
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	56                   	push   %esi
80105a04:	53                   	push   %ebx
80105a05:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105a08:	83 ec 18             	sub    $0x18,%esp
80105a0b:	53                   	push   %ebx
80105a0c:	6a 00                	push   $0x0
80105a0e:	e8 3d fc ff ff       	call   80105650 <argint>
80105a13:	83 c4 10             	add    $0x10,%esp
80105a16:	85 c0                	test   %eax,%eax
80105a18:	78 5e                	js     80105a78 <sys_read+0x78>
80105a1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a1e:	77 58                	ja     80105a78 <sys_read+0x78>
80105a20:	e8 3b ec ff ff       	call   80104660 <myproc>
80105a25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a28:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105a2c:	85 f6                	test   %esi,%esi
80105a2e:	74 48                	je     80105a78 <sys_read+0x78>
80105a30:	83 ec 08             	sub    $0x8,%esp
80105a33:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a36:	50                   	push   %eax
80105a37:	6a 02                	push   $0x2
80105a39:	e8 12 fc ff ff       	call   80105650 <argint>
80105a3e:	83 c4 10             	add    $0x10,%esp
80105a41:	85 c0                	test   %eax,%eax
80105a43:	78 33                	js     80105a78 <sys_read+0x78>
80105a45:	83 ec 04             	sub    $0x4,%esp
80105a48:	ff 75 f0             	push   -0x10(%ebp)
80105a4b:	53                   	push   %ebx
80105a4c:	6a 01                	push   $0x1
80105a4e:	e8 4d fc ff ff       	call   801056a0 <argptr>
80105a53:	83 c4 10             	add    $0x10,%esp
80105a56:	85 c0                	test   %eax,%eax
80105a58:	78 1e                	js     80105a78 <sys_read+0x78>
80105a5a:	83 ec 04             	sub    $0x4,%esp
80105a5d:	ff 75 f0             	push   -0x10(%ebp)
80105a60:	ff 75 f4             	push   -0xc(%ebp)
80105a63:	56                   	push   %esi
80105a64:	e8 d7 c2 ff ff       	call   80101d40 <fileread>
80105a69:	83 c4 10             	add    $0x10,%esp
80105a6c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a6f:	5b                   	pop    %ebx
80105a70:	5e                   	pop    %esi
80105a71:	5d                   	pop    %ebp
80105a72:	c3                   	ret
80105a73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a7d:	eb ed                	jmp    80105a6c <sys_read+0x6c>
80105a7f:	90                   	nop

80105a80 <sys_write>:
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	56                   	push   %esi
80105a84:	53                   	push   %ebx
80105a85:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105a88:	83 ec 18             	sub    $0x18,%esp
80105a8b:	53                   	push   %ebx
80105a8c:	6a 00                	push   $0x0
80105a8e:	e8 bd fb ff ff       	call   80105650 <argint>
80105a93:	83 c4 10             	add    $0x10,%esp
80105a96:	85 c0                	test   %eax,%eax
80105a98:	78 5e                	js     80105af8 <sys_write+0x78>
80105a9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a9e:	77 58                	ja     80105af8 <sys_write+0x78>
80105aa0:	e8 bb eb ff ff       	call   80104660 <myproc>
80105aa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105aa8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105aac:	85 f6                	test   %esi,%esi
80105aae:	74 48                	je     80105af8 <sys_write+0x78>
80105ab0:	83 ec 08             	sub    $0x8,%esp
80105ab3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ab6:	50                   	push   %eax
80105ab7:	6a 02                	push   $0x2
80105ab9:	e8 92 fb ff ff       	call   80105650 <argint>
80105abe:	83 c4 10             	add    $0x10,%esp
80105ac1:	85 c0                	test   %eax,%eax
80105ac3:	78 33                	js     80105af8 <sys_write+0x78>
80105ac5:	83 ec 04             	sub    $0x4,%esp
80105ac8:	ff 75 f0             	push   -0x10(%ebp)
80105acb:	53                   	push   %ebx
80105acc:	6a 01                	push   $0x1
80105ace:	e8 cd fb ff ff       	call   801056a0 <argptr>
80105ad3:	83 c4 10             	add    $0x10,%esp
80105ad6:	85 c0                	test   %eax,%eax
80105ad8:	78 1e                	js     80105af8 <sys_write+0x78>
80105ada:	83 ec 04             	sub    $0x4,%esp
80105add:	ff 75 f0             	push   -0x10(%ebp)
80105ae0:	ff 75 f4             	push   -0xc(%ebp)
80105ae3:	56                   	push   %esi
80105ae4:	e8 e7 c2 ff ff       	call   80101dd0 <filewrite>
80105ae9:	83 c4 10             	add    $0x10,%esp
80105aec:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105aef:	5b                   	pop    %ebx
80105af0:	5e                   	pop    %esi
80105af1:	5d                   	pop    %ebp
80105af2:	c3                   	ret
80105af3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105af8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105afd:	eb ed                	jmp    80105aec <sys_write+0x6c>
80105aff:	90                   	nop

80105b00 <sys_close>:
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	56                   	push   %esi
80105b04:	53                   	push   %ebx
80105b05:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b08:	83 ec 18             	sub    $0x18,%esp
80105b0b:	50                   	push   %eax
80105b0c:	6a 00                	push   $0x0
80105b0e:	e8 3d fb ff ff       	call   80105650 <argint>
80105b13:	83 c4 10             	add    $0x10,%esp
80105b16:	85 c0                	test   %eax,%eax
80105b18:	78 3e                	js     80105b58 <sys_close+0x58>
80105b1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105b1e:	77 38                	ja     80105b58 <sys_close+0x58>
80105b20:	e8 3b eb ff ff       	call   80104660 <myproc>
80105b25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b28:	8d 5a 08             	lea    0x8(%edx),%ebx
80105b2b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105b2f:	85 f6                	test   %esi,%esi
80105b31:	74 25                	je     80105b58 <sys_close+0x58>
80105b33:	e8 28 eb ff ff       	call   80104660 <myproc>
80105b38:	83 ec 0c             	sub    $0xc,%esp
80105b3b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105b42:	00 
80105b43:	56                   	push   %esi
80105b44:	e8 c7 c0 ff ff       	call   80101c10 <fileclose>
80105b49:	83 c4 10             	add    $0x10,%esp
80105b4c:	31 c0                	xor    %eax,%eax
80105b4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b51:	5b                   	pop    %ebx
80105b52:	5e                   	pop    %esi
80105b53:	5d                   	pop    %ebp
80105b54:	c3                   	ret
80105b55:	8d 76 00             	lea    0x0(%esi),%esi
80105b58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b5d:	eb ef                	jmp    80105b4e <sys_close+0x4e>
80105b5f:	90                   	nop

80105b60 <sys_fstat>:
80105b60:	55                   	push   %ebp
80105b61:	89 e5                	mov    %esp,%ebp
80105b63:	56                   	push   %esi
80105b64:	53                   	push   %ebx
80105b65:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105b68:	83 ec 18             	sub    $0x18,%esp
80105b6b:	53                   	push   %ebx
80105b6c:	6a 00                	push   $0x0
80105b6e:	e8 dd fa ff ff       	call   80105650 <argint>
80105b73:	83 c4 10             	add    $0x10,%esp
80105b76:	85 c0                	test   %eax,%eax
80105b78:	78 46                	js     80105bc0 <sys_fstat+0x60>
80105b7a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105b7e:	77 40                	ja     80105bc0 <sys_fstat+0x60>
80105b80:	e8 db ea ff ff       	call   80104660 <myproc>
80105b85:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b88:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105b8c:	85 f6                	test   %esi,%esi
80105b8e:	74 30                	je     80105bc0 <sys_fstat+0x60>
80105b90:	83 ec 04             	sub    $0x4,%esp
80105b93:	6a 14                	push   $0x14
80105b95:	53                   	push   %ebx
80105b96:	6a 01                	push   $0x1
80105b98:	e8 03 fb ff ff       	call   801056a0 <argptr>
80105b9d:	83 c4 10             	add    $0x10,%esp
80105ba0:	85 c0                	test   %eax,%eax
80105ba2:	78 1c                	js     80105bc0 <sys_fstat+0x60>
80105ba4:	83 ec 08             	sub    $0x8,%esp
80105ba7:	ff 75 f4             	push   -0xc(%ebp)
80105baa:	56                   	push   %esi
80105bab:	e8 40 c1 ff ff       	call   80101cf0 <filestat>
80105bb0:	83 c4 10             	add    $0x10,%esp
80105bb3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105bb6:	5b                   	pop    %ebx
80105bb7:	5e                   	pop    %esi
80105bb8:	5d                   	pop    %ebp
80105bb9:	c3                   	ret
80105bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bc5:	eb ec                	jmp    80105bb3 <sys_fstat+0x53>
80105bc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bce:	00 
80105bcf:	90                   	nop

80105bd0 <sys_link>:
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	57                   	push   %edi
80105bd4:	56                   	push   %esi
80105bd5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105bd8:	53                   	push   %ebx
80105bd9:	83 ec 34             	sub    $0x34,%esp
80105bdc:	50                   	push   %eax
80105bdd:	6a 00                	push   $0x0
80105bdf:	e8 2c fb ff ff       	call   80105710 <argstr>
80105be4:	83 c4 10             	add    $0x10,%esp
80105be7:	85 c0                	test   %eax,%eax
80105be9:	0f 88 fb 00 00 00    	js     80105cea <sys_link+0x11a>
80105bef:	83 ec 08             	sub    $0x8,%esp
80105bf2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105bf5:	50                   	push   %eax
80105bf6:	6a 01                	push   $0x1
80105bf8:	e8 13 fb ff ff       	call   80105710 <argstr>
80105bfd:	83 c4 10             	add    $0x10,%esp
80105c00:	85 c0                	test   %eax,%eax
80105c02:	0f 88 e2 00 00 00    	js     80105cea <sys_link+0x11a>
80105c08:	e8 33 de ff ff       	call   80103a40 <begin_op>
80105c0d:	83 ec 0c             	sub    $0xc,%esp
80105c10:	ff 75 d4             	push   -0x2c(%ebp)
80105c13:	e8 68 d1 ff ff       	call   80102d80 <namei>
80105c18:	83 c4 10             	add    $0x10,%esp
80105c1b:	89 c3                	mov    %eax,%ebx
80105c1d:	85 c0                	test   %eax,%eax
80105c1f:	0f 84 df 00 00 00    	je     80105d04 <sys_link+0x134>
80105c25:	83 ec 0c             	sub    $0xc,%esp
80105c28:	50                   	push   %eax
80105c29:	e8 72 c8 ff ff       	call   801024a0 <ilock>
80105c2e:	83 c4 10             	add    $0x10,%esp
80105c31:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c36:	0f 84 b5 00 00 00    	je     80105cf1 <sys_link+0x121>
80105c3c:	83 ec 0c             	sub    $0xc,%esp
80105c3f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80105c44:	8d 7d da             	lea    -0x26(%ebp),%edi
80105c47:	53                   	push   %ebx
80105c48:	e8 a3 c7 ff ff       	call   801023f0 <iupdate>
80105c4d:	89 1c 24             	mov    %ebx,(%esp)
80105c50:	e8 2b c9 ff ff       	call   80102580 <iunlock>
80105c55:	58                   	pop    %eax
80105c56:	5a                   	pop    %edx
80105c57:	57                   	push   %edi
80105c58:	ff 75 d0             	push   -0x30(%ebp)
80105c5b:	e8 40 d1 ff ff       	call   80102da0 <nameiparent>
80105c60:	83 c4 10             	add    $0x10,%esp
80105c63:	89 c6                	mov    %eax,%esi
80105c65:	85 c0                	test   %eax,%eax
80105c67:	74 5b                	je     80105cc4 <sys_link+0xf4>
80105c69:	83 ec 0c             	sub    $0xc,%esp
80105c6c:	50                   	push   %eax
80105c6d:	e8 2e c8 ff ff       	call   801024a0 <ilock>
80105c72:	8b 03                	mov    (%ebx),%eax
80105c74:	83 c4 10             	add    $0x10,%esp
80105c77:	39 06                	cmp    %eax,(%esi)
80105c79:	75 3d                	jne    80105cb8 <sys_link+0xe8>
80105c7b:	83 ec 04             	sub    $0x4,%esp
80105c7e:	ff 73 04             	push   0x4(%ebx)
80105c81:	57                   	push   %edi
80105c82:	56                   	push   %esi
80105c83:	e8 38 d0 ff ff       	call   80102cc0 <dirlink>
80105c88:	83 c4 10             	add    $0x10,%esp
80105c8b:	85 c0                	test   %eax,%eax
80105c8d:	78 29                	js     80105cb8 <sys_link+0xe8>
80105c8f:	83 ec 0c             	sub    $0xc,%esp
80105c92:	56                   	push   %esi
80105c93:	e8 98 ca ff ff       	call   80102730 <iunlockput>
80105c98:	89 1c 24             	mov    %ebx,(%esp)
80105c9b:	e8 30 c9 ff ff       	call   801025d0 <iput>
80105ca0:	e8 0b de ff ff       	call   80103ab0 <end_op>
80105ca5:	83 c4 10             	add    $0x10,%esp
80105ca8:	31 c0                	xor    %eax,%eax
80105caa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cad:	5b                   	pop    %ebx
80105cae:	5e                   	pop    %esi
80105caf:	5f                   	pop    %edi
80105cb0:	5d                   	pop    %ebp
80105cb1:	c3                   	ret
80105cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cb8:	83 ec 0c             	sub    $0xc,%esp
80105cbb:	56                   	push   %esi
80105cbc:	e8 6f ca ff ff       	call   80102730 <iunlockput>
80105cc1:	83 c4 10             	add    $0x10,%esp
80105cc4:	83 ec 0c             	sub    $0xc,%esp
80105cc7:	53                   	push   %ebx
80105cc8:	e8 d3 c7 ff ff       	call   801024a0 <ilock>
80105ccd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105cd2:	89 1c 24             	mov    %ebx,(%esp)
80105cd5:	e8 16 c7 ff ff       	call   801023f0 <iupdate>
80105cda:	89 1c 24             	mov    %ebx,(%esp)
80105cdd:	e8 4e ca ff ff       	call   80102730 <iunlockput>
80105ce2:	e8 c9 dd ff ff       	call   80103ab0 <end_op>
80105ce7:	83 c4 10             	add    $0x10,%esp
80105cea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cef:	eb b9                	jmp    80105caa <sys_link+0xda>
80105cf1:	83 ec 0c             	sub    $0xc,%esp
80105cf4:	53                   	push   %ebx
80105cf5:	e8 36 ca ff ff       	call   80102730 <iunlockput>
80105cfa:	e8 b1 dd ff ff       	call   80103ab0 <end_op>
80105cff:	83 c4 10             	add    $0x10,%esp
80105d02:	eb e6                	jmp    80105cea <sys_link+0x11a>
80105d04:	e8 a7 dd ff ff       	call   80103ab0 <end_op>
80105d09:	eb df                	jmp    80105cea <sys_link+0x11a>
80105d0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105d10 <sys_unlink>:
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	57                   	push   %edi
80105d14:	56                   	push   %esi
80105d15:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105d18:	53                   	push   %ebx
80105d19:	83 ec 54             	sub    $0x54,%esp
80105d1c:	50                   	push   %eax
80105d1d:	6a 00                	push   $0x0
80105d1f:	e8 ec f9 ff ff       	call   80105710 <argstr>
80105d24:	83 c4 10             	add    $0x10,%esp
80105d27:	85 c0                	test   %eax,%eax
80105d29:	0f 88 54 01 00 00    	js     80105e83 <sys_unlink+0x173>
80105d2f:	e8 0c dd ff ff       	call   80103a40 <begin_op>
80105d34:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105d37:	83 ec 08             	sub    $0x8,%esp
80105d3a:	53                   	push   %ebx
80105d3b:	ff 75 c0             	push   -0x40(%ebp)
80105d3e:	e8 5d d0 ff ff       	call   80102da0 <nameiparent>
80105d43:	83 c4 10             	add    $0x10,%esp
80105d46:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105d49:	85 c0                	test   %eax,%eax
80105d4b:	0f 84 58 01 00 00    	je     80105ea9 <sys_unlink+0x199>
80105d51:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105d54:	83 ec 0c             	sub    $0xc,%esp
80105d57:	57                   	push   %edi
80105d58:	e8 43 c7 ff ff       	call   801024a0 <ilock>
80105d5d:	58                   	pop    %eax
80105d5e:	5a                   	pop    %edx
80105d5f:	68 0b 82 10 80       	push   $0x8010820b
80105d64:	53                   	push   %ebx
80105d65:	e8 66 cc ff ff       	call   801029d0 <namecmp>
80105d6a:	83 c4 10             	add    $0x10,%esp
80105d6d:	85 c0                	test   %eax,%eax
80105d6f:	0f 84 fb 00 00 00    	je     80105e70 <sys_unlink+0x160>
80105d75:	83 ec 08             	sub    $0x8,%esp
80105d78:	68 0a 82 10 80       	push   $0x8010820a
80105d7d:	53                   	push   %ebx
80105d7e:	e8 4d cc ff ff       	call   801029d0 <namecmp>
80105d83:	83 c4 10             	add    $0x10,%esp
80105d86:	85 c0                	test   %eax,%eax
80105d88:	0f 84 e2 00 00 00    	je     80105e70 <sys_unlink+0x160>
80105d8e:	83 ec 04             	sub    $0x4,%esp
80105d91:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105d94:	50                   	push   %eax
80105d95:	53                   	push   %ebx
80105d96:	57                   	push   %edi
80105d97:	e8 54 cc ff ff       	call   801029f0 <dirlookup>
80105d9c:	83 c4 10             	add    $0x10,%esp
80105d9f:	89 c3                	mov    %eax,%ebx
80105da1:	85 c0                	test   %eax,%eax
80105da3:	0f 84 c7 00 00 00    	je     80105e70 <sys_unlink+0x160>
80105da9:	83 ec 0c             	sub    $0xc,%esp
80105dac:	50                   	push   %eax
80105dad:	e8 ee c6 ff ff       	call   801024a0 <ilock>
80105db2:	83 c4 10             	add    $0x10,%esp
80105db5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105dba:	0f 8e 0a 01 00 00    	jle    80105eca <sys_unlink+0x1ba>
80105dc0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105dc5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105dc8:	74 66                	je     80105e30 <sys_unlink+0x120>
80105dca:	83 ec 04             	sub    $0x4,%esp
80105dcd:	6a 10                	push   $0x10
80105dcf:	6a 00                	push   $0x0
80105dd1:	57                   	push   %edi
80105dd2:	e8 c9 f5 ff ff       	call   801053a0 <memset>
80105dd7:	6a 10                	push   $0x10
80105dd9:	ff 75 c4             	push   -0x3c(%ebp)
80105ddc:	57                   	push   %edi
80105ddd:	ff 75 b4             	push   -0x4c(%ebp)
80105de0:	e8 cb ca ff ff       	call   801028b0 <writei>
80105de5:	83 c4 20             	add    $0x20,%esp
80105de8:	83 f8 10             	cmp    $0x10,%eax
80105deb:	0f 85 cc 00 00 00    	jne    80105ebd <sys_unlink+0x1ad>
80105df1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105df6:	0f 84 94 00 00 00    	je     80105e90 <sys_unlink+0x180>
80105dfc:	83 ec 0c             	sub    $0xc,%esp
80105dff:	ff 75 b4             	push   -0x4c(%ebp)
80105e02:	e8 29 c9 ff ff       	call   80102730 <iunlockput>
80105e07:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105e0c:	89 1c 24             	mov    %ebx,(%esp)
80105e0f:	e8 dc c5 ff ff       	call   801023f0 <iupdate>
80105e14:	89 1c 24             	mov    %ebx,(%esp)
80105e17:	e8 14 c9 ff ff       	call   80102730 <iunlockput>
80105e1c:	e8 8f dc ff ff       	call   80103ab0 <end_op>
80105e21:	83 c4 10             	add    $0x10,%esp
80105e24:	31 c0                	xor    %eax,%eax
80105e26:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e29:	5b                   	pop    %ebx
80105e2a:	5e                   	pop    %esi
80105e2b:	5f                   	pop    %edi
80105e2c:	5d                   	pop    %ebp
80105e2d:	c3                   	ret
80105e2e:	66 90                	xchg   %ax,%ax
80105e30:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105e34:	76 94                	jbe    80105dca <sys_unlink+0xba>
80105e36:	be 20 00 00 00       	mov    $0x20,%esi
80105e3b:	eb 0b                	jmp    80105e48 <sys_unlink+0x138>
80105e3d:	8d 76 00             	lea    0x0(%esi),%esi
80105e40:	83 c6 10             	add    $0x10,%esi
80105e43:	3b 73 58             	cmp    0x58(%ebx),%esi
80105e46:	73 82                	jae    80105dca <sys_unlink+0xba>
80105e48:	6a 10                	push   $0x10
80105e4a:	56                   	push   %esi
80105e4b:	57                   	push   %edi
80105e4c:	53                   	push   %ebx
80105e4d:	e8 5e c9 ff ff       	call   801027b0 <readi>
80105e52:	83 c4 10             	add    $0x10,%esp
80105e55:	83 f8 10             	cmp    $0x10,%eax
80105e58:	75 56                	jne    80105eb0 <sys_unlink+0x1a0>
80105e5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105e5f:	74 df                	je     80105e40 <sys_unlink+0x130>
80105e61:	83 ec 0c             	sub    $0xc,%esp
80105e64:	53                   	push   %ebx
80105e65:	e8 c6 c8 ff ff       	call   80102730 <iunlockput>
80105e6a:	83 c4 10             	add    $0x10,%esp
80105e6d:	8d 76 00             	lea    0x0(%esi),%esi
80105e70:	83 ec 0c             	sub    $0xc,%esp
80105e73:	ff 75 b4             	push   -0x4c(%ebp)
80105e76:	e8 b5 c8 ff ff       	call   80102730 <iunlockput>
80105e7b:	e8 30 dc ff ff       	call   80103ab0 <end_op>
80105e80:	83 c4 10             	add    $0x10,%esp
80105e83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e88:	eb 9c                	jmp    80105e26 <sys_unlink+0x116>
80105e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105e90:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80105e93:	83 ec 0c             	sub    $0xc,%esp
80105e96:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
80105e9b:	50                   	push   %eax
80105e9c:	e8 4f c5 ff ff       	call   801023f0 <iupdate>
80105ea1:	83 c4 10             	add    $0x10,%esp
80105ea4:	e9 53 ff ff ff       	jmp    80105dfc <sys_unlink+0xec>
80105ea9:	e8 02 dc ff ff       	call   80103ab0 <end_op>
80105eae:	eb d3                	jmp    80105e83 <sys_unlink+0x173>
80105eb0:	83 ec 0c             	sub    $0xc,%esp
80105eb3:	68 2f 82 10 80       	push   $0x8010822f
80105eb8:	e8 d3 ab ff ff       	call   80100a90 <panic>
80105ebd:	83 ec 0c             	sub    $0xc,%esp
80105ec0:	68 41 82 10 80       	push   $0x80108241
80105ec5:	e8 c6 ab ff ff       	call   80100a90 <panic>
80105eca:	83 ec 0c             	sub    $0xc,%esp
80105ecd:	68 1d 82 10 80       	push   $0x8010821d
80105ed2:	e8 b9 ab ff ff       	call   80100a90 <panic>
80105ed7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ede:	00 
80105edf:	90                   	nop

80105ee0 <sys_open>:
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	57                   	push   %edi
80105ee4:	56                   	push   %esi
80105ee5:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ee8:	53                   	push   %ebx
80105ee9:	83 ec 24             	sub    $0x24,%esp
80105eec:	50                   	push   %eax
80105eed:	6a 00                	push   $0x0
80105eef:	e8 1c f8 ff ff       	call   80105710 <argstr>
80105ef4:	83 c4 10             	add    $0x10,%esp
80105ef7:	85 c0                	test   %eax,%eax
80105ef9:	0f 88 8e 00 00 00    	js     80105f8d <sys_open+0xad>
80105eff:	83 ec 08             	sub    $0x8,%esp
80105f02:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f05:	50                   	push   %eax
80105f06:	6a 01                	push   $0x1
80105f08:	e8 43 f7 ff ff       	call   80105650 <argint>
80105f0d:	83 c4 10             	add    $0x10,%esp
80105f10:	85 c0                	test   %eax,%eax
80105f12:	78 79                	js     80105f8d <sys_open+0xad>
80105f14:	e8 27 db ff ff       	call   80103a40 <begin_op>
80105f19:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105f1d:	75 79                	jne    80105f98 <sys_open+0xb8>
80105f1f:	83 ec 0c             	sub    $0xc,%esp
80105f22:	ff 75 e0             	push   -0x20(%ebp)
80105f25:	e8 56 ce ff ff       	call   80102d80 <namei>
80105f2a:	83 c4 10             	add    $0x10,%esp
80105f2d:	89 c6                	mov    %eax,%esi
80105f2f:	85 c0                	test   %eax,%eax
80105f31:	0f 84 7e 00 00 00    	je     80105fb5 <sys_open+0xd5>
80105f37:	83 ec 0c             	sub    $0xc,%esp
80105f3a:	50                   	push   %eax
80105f3b:	e8 60 c5 ff ff       	call   801024a0 <ilock>
80105f40:	83 c4 10             	add    $0x10,%esp
80105f43:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105f48:	0f 84 ba 00 00 00    	je     80106008 <sys_open+0x128>
80105f4e:	e8 fd bb ff ff       	call   80101b50 <filealloc>
80105f53:	89 c7                	mov    %eax,%edi
80105f55:	85 c0                	test   %eax,%eax
80105f57:	74 23                	je     80105f7c <sys_open+0x9c>
80105f59:	e8 02 e7 ff ff       	call   80104660 <myproc>
80105f5e:	31 db                	xor    %ebx,%ebx
80105f60:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105f64:	85 d2                	test   %edx,%edx
80105f66:	74 58                	je     80105fc0 <sys_open+0xe0>
80105f68:	83 c3 01             	add    $0x1,%ebx
80105f6b:	83 fb 10             	cmp    $0x10,%ebx
80105f6e:	75 f0                	jne    80105f60 <sys_open+0x80>
80105f70:	83 ec 0c             	sub    $0xc,%esp
80105f73:	57                   	push   %edi
80105f74:	e8 97 bc ff ff       	call   80101c10 <fileclose>
80105f79:	83 c4 10             	add    $0x10,%esp
80105f7c:	83 ec 0c             	sub    $0xc,%esp
80105f7f:	56                   	push   %esi
80105f80:	e8 ab c7 ff ff       	call   80102730 <iunlockput>
80105f85:	e8 26 db ff ff       	call   80103ab0 <end_op>
80105f8a:	83 c4 10             	add    $0x10,%esp
80105f8d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105f92:	eb 65                	jmp    80105ff9 <sys_open+0x119>
80105f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f98:	83 ec 0c             	sub    $0xc,%esp
80105f9b:	31 c9                	xor    %ecx,%ecx
80105f9d:	ba 02 00 00 00       	mov    $0x2,%edx
80105fa2:	6a 00                	push   $0x0
80105fa4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105fa7:	e8 54 f8 ff ff       	call   80105800 <create>
80105fac:	83 c4 10             	add    $0x10,%esp
80105faf:	89 c6                	mov    %eax,%esi
80105fb1:	85 c0                	test   %eax,%eax
80105fb3:	75 99                	jne    80105f4e <sys_open+0x6e>
80105fb5:	e8 f6 da ff ff       	call   80103ab0 <end_op>
80105fba:	eb d1                	jmp    80105f8d <sys_open+0xad>
80105fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fc0:	83 ec 0c             	sub    $0xc,%esp
80105fc3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
80105fc7:	56                   	push   %esi
80105fc8:	e8 b3 c5 ff ff       	call   80102580 <iunlock>
80105fcd:	e8 de da ff ff       	call   80103ab0 <end_op>
80105fd2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
80105fd8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105fdb:	83 c4 10             	add    $0x10,%esp
80105fde:	89 77 10             	mov    %esi,0x10(%edi)
80105fe1:	89 d0                	mov    %edx,%eax
80105fe3:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
80105fea:	f7 d0                	not    %eax
80105fec:	83 e0 01             	and    $0x1,%eax
80105fef:	83 e2 03             	and    $0x3,%edx
80105ff2:	88 47 08             	mov    %al,0x8(%edi)
80105ff5:	0f 95 47 09          	setne  0x9(%edi)
80105ff9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ffc:	89 d8                	mov    %ebx,%eax
80105ffe:	5b                   	pop    %ebx
80105fff:	5e                   	pop    %esi
80106000:	5f                   	pop    %edi
80106001:	5d                   	pop    %ebp
80106002:	c3                   	ret
80106003:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106008:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010600b:	85 c9                	test   %ecx,%ecx
8010600d:	0f 84 3b ff ff ff    	je     80105f4e <sys_open+0x6e>
80106013:	e9 64 ff ff ff       	jmp    80105f7c <sys_open+0x9c>
80106018:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010601f:	00 

80106020 <sys_mkdir>:
80106020:	55                   	push   %ebp
80106021:	89 e5                	mov    %esp,%ebp
80106023:	83 ec 18             	sub    $0x18,%esp
80106026:	e8 15 da ff ff       	call   80103a40 <begin_op>
8010602b:	83 ec 08             	sub    $0x8,%esp
8010602e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106031:	50                   	push   %eax
80106032:	6a 00                	push   $0x0
80106034:	e8 d7 f6 ff ff       	call   80105710 <argstr>
80106039:	83 c4 10             	add    $0x10,%esp
8010603c:	85 c0                	test   %eax,%eax
8010603e:	78 30                	js     80106070 <sys_mkdir+0x50>
80106040:	83 ec 0c             	sub    $0xc,%esp
80106043:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106046:	31 c9                	xor    %ecx,%ecx
80106048:	ba 01 00 00 00       	mov    $0x1,%edx
8010604d:	6a 00                	push   $0x0
8010604f:	e8 ac f7 ff ff       	call   80105800 <create>
80106054:	83 c4 10             	add    $0x10,%esp
80106057:	85 c0                	test   %eax,%eax
80106059:	74 15                	je     80106070 <sys_mkdir+0x50>
8010605b:	83 ec 0c             	sub    $0xc,%esp
8010605e:	50                   	push   %eax
8010605f:	e8 cc c6 ff ff       	call   80102730 <iunlockput>
80106064:	e8 47 da ff ff       	call   80103ab0 <end_op>
80106069:	83 c4 10             	add    $0x10,%esp
8010606c:	31 c0                	xor    %eax,%eax
8010606e:	c9                   	leave
8010606f:	c3                   	ret
80106070:	e8 3b da ff ff       	call   80103ab0 <end_op>
80106075:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010607a:	c9                   	leave
8010607b:	c3                   	ret
8010607c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106080 <sys_mknod>:
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	83 ec 18             	sub    $0x18,%esp
80106086:	e8 b5 d9 ff ff       	call   80103a40 <begin_op>
8010608b:	83 ec 08             	sub    $0x8,%esp
8010608e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106091:	50                   	push   %eax
80106092:	6a 00                	push   $0x0
80106094:	e8 77 f6 ff ff       	call   80105710 <argstr>
80106099:	83 c4 10             	add    $0x10,%esp
8010609c:	85 c0                	test   %eax,%eax
8010609e:	78 60                	js     80106100 <sys_mknod+0x80>
801060a0:	83 ec 08             	sub    $0x8,%esp
801060a3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060a6:	50                   	push   %eax
801060a7:	6a 01                	push   $0x1
801060a9:	e8 a2 f5 ff ff       	call   80105650 <argint>
801060ae:	83 c4 10             	add    $0x10,%esp
801060b1:	85 c0                	test   %eax,%eax
801060b3:	78 4b                	js     80106100 <sys_mknod+0x80>
801060b5:	83 ec 08             	sub    $0x8,%esp
801060b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060bb:	50                   	push   %eax
801060bc:	6a 02                	push   $0x2
801060be:	e8 8d f5 ff ff       	call   80105650 <argint>
801060c3:	83 c4 10             	add    $0x10,%esp
801060c6:	85 c0                	test   %eax,%eax
801060c8:	78 36                	js     80106100 <sys_mknod+0x80>
801060ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801060ce:	83 ec 0c             	sub    $0xc,%esp
801060d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801060d5:	ba 03 00 00 00       	mov    $0x3,%edx
801060da:	50                   	push   %eax
801060db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801060de:	e8 1d f7 ff ff       	call   80105800 <create>
801060e3:	83 c4 10             	add    $0x10,%esp
801060e6:	85 c0                	test   %eax,%eax
801060e8:	74 16                	je     80106100 <sys_mknod+0x80>
801060ea:	83 ec 0c             	sub    $0xc,%esp
801060ed:	50                   	push   %eax
801060ee:	e8 3d c6 ff ff       	call   80102730 <iunlockput>
801060f3:	e8 b8 d9 ff ff       	call   80103ab0 <end_op>
801060f8:	83 c4 10             	add    $0x10,%esp
801060fb:	31 c0                	xor    %eax,%eax
801060fd:	c9                   	leave
801060fe:	c3                   	ret
801060ff:	90                   	nop
80106100:	e8 ab d9 ff ff       	call   80103ab0 <end_op>
80106105:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010610a:	c9                   	leave
8010610b:	c3                   	ret
8010610c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106110 <sys_chdir>:
80106110:	55                   	push   %ebp
80106111:	89 e5                	mov    %esp,%ebp
80106113:	56                   	push   %esi
80106114:	53                   	push   %ebx
80106115:	83 ec 10             	sub    $0x10,%esp
80106118:	e8 43 e5 ff ff       	call   80104660 <myproc>
8010611d:	89 c6                	mov    %eax,%esi
8010611f:	e8 1c d9 ff ff       	call   80103a40 <begin_op>
80106124:	83 ec 08             	sub    $0x8,%esp
80106127:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010612a:	50                   	push   %eax
8010612b:	6a 00                	push   $0x0
8010612d:	e8 de f5 ff ff       	call   80105710 <argstr>
80106132:	83 c4 10             	add    $0x10,%esp
80106135:	85 c0                	test   %eax,%eax
80106137:	78 77                	js     801061b0 <sys_chdir+0xa0>
80106139:	83 ec 0c             	sub    $0xc,%esp
8010613c:	ff 75 f4             	push   -0xc(%ebp)
8010613f:	e8 3c cc ff ff       	call   80102d80 <namei>
80106144:	83 c4 10             	add    $0x10,%esp
80106147:	89 c3                	mov    %eax,%ebx
80106149:	85 c0                	test   %eax,%eax
8010614b:	74 63                	je     801061b0 <sys_chdir+0xa0>
8010614d:	83 ec 0c             	sub    $0xc,%esp
80106150:	50                   	push   %eax
80106151:	e8 4a c3 ff ff       	call   801024a0 <ilock>
80106156:	83 c4 10             	add    $0x10,%esp
80106159:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010615e:	75 30                	jne    80106190 <sys_chdir+0x80>
80106160:	83 ec 0c             	sub    $0xc,%esp
80106163:	53                   	push   %ebx
80106164:	e8 17 c4 ff ff       	call   80102580 <iunlock>
80106169:	58                   	pop    %eax
8010616a:	ff 76 68             	push   0x68(%esi)
8010616d:	e8 5e c4 ff ff       	call   801025d0 <iput>
80106172:	e8 39 d9 ff ff       	call   80103ab0 <end_op>
80106177:	89 5e 68             	mov    %ebx,0x68(%esi)
8010617a:	83 c4 10             	add    $0x10,%esp
8010617d:	31 c0                	xor    %eax,%eax
8010617f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106182:	5b                   	pop    %ebx
80106183:	5e                   	pop    %esi
80106184:	5d                   	pop    %ebp
80106185:	c3                   	ret
80106186:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010618d:	00 
8010618e:	66 90                	xchg   %ax,%ax
80106190:	83 ec 0c             	sub    $0xc,%esp
80106193:	53                   	push   %ebx
80106194:	e8 97 c5 ff ff       	call   80102730 <iunlockput>
80106199:	e8 12 d9 ff ff       	call   80103ab0 <end_op>
8010619e:	83 c4 10             	add    $0x10,%esp
801061a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061a6:	eb d7                	jmp    8010617f <sys_chdir+0x6f>
801061a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061af:	00 
801061b0:	e8 fb d8 ff ff       	call   80103ab0 <end_op>
801061b5:	eb ea                	jmp    801061a1 <sys_chdir+0x91>
801061b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061be:	00 
801061bf:	90                   	nop

801061c0 <sys_exec>:
801061c0:	55                   	push   %ebp
801061c1:	89 e5                	mov    %esp,%ebp
801061c3:	57                   	push   %edi
801061c4:	56                   	push   %esi
801061c5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801061cb:	53                   	push   %ebx
801061cc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
801061d2:	50                   	push   %eax
801061d3:	6a 00                	push   $0x0
801061d5:	e8 36 f5 ff ff       	call   80105710 <argstr>
801061da:	83 c4 10             	add    $0x10,%esp
801061dd:	85 c0                	test   %eax,%eax
801061df:	0f 88 87 00 00 00    	js     8010626c <sys_exec+0xac>
801061e5:	83 ec 08             	sub    $0x8,%esp
801061e8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801061ee:	50                   	push   %eax
801061ef:	6a 01                	push   $0x1
801061f1:	e8 5a f4 ff ff       	call   80105650 <argint>
801061f6:	83 c4 10             	add    $0x10,%esp
801061f9:	85 c0                	test   %eax,%eax
801061fb:	78 6f                	js     8010626c <sys_exec+0xac>
801061fd:	83 ec 04             	sub    $0x4,%esp
80106200:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80106206:	31 db                	xor    %ebx,%ebx
80106208:	68 80 00 00 00       	push   $0x80
8010620d:	6a 00                	push   $0x0
8010620f:	56                   	push   %esi
80106210:	e8 8b f1 ff ff       	call   801053a0 <memset>
80106215:	83 c4 10             	add    $0x10,%esp
80106218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010621f:	00 
80106220:	83 ec 08             	sub    $0x8,%esp
80106223:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106229:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106230:	50                   	push   %eax
80106231:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106237:	01 f8                	add    %edi,%eax
80106239:	50                   	push   %eax
8010623a:	e8 81 f3 ff ff       	call   801055c0 <fetchint>
8010623f:	83 c4 10             	add    $0x10,%esp
80106242:	85 c0                	test   %eax,%eax
80106244:	78 26                	js     8010626c <sys_exec+0xac>
80106246:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010624c:	85 c0                	test   %eax,%eax
8010624e:	74 30                	je     80106280 <sys_exec+0xc0>
80106250:	83 ec 08             	sub    $0x8,%esp
80106253:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106256:	52                   	push   %edx
80106257:	50                   	push   %eax
80106258:	e8 a3 f3 ff ff       	call   80105600 <fetchstr>
8010625d:	83 c4 10             	add    $0x10,%esp
80106260:	85 c0                	test   %eax,%eax
80106262:	78 08                	js     8010626c <sys_exec+0xac>
80106264:	83 c3 01             	add    $0x1,%ebx
80106267:	83 fb 20             	cmp    $0x20,%ebx
8010626a:	75 b4                	jne    80106220 <sys_exec+0x60>
8010626c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010626f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106274:	5b                   	pop    %ebx
80106275:	5e                   	pop    %esi
80106276:	5f                   	pop    %edi
80106277:	5d                   	pop    %ebp
80106278:	c3                   	ret
80106279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106280:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106287:	00 00 00 00 
8010628b:	83 ec 08             	sub    $0x8,%esp
8010628e:	56                   	push   %esi
8010628f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80106295:	e8 16 b5 ff ff       	call   801017b0 <exec>
8010629a:	83 c4 10             	add    $0x10,%esp
8010629d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062a0:	5b                   	pop    %ebx
801062a1:	5e                   	pop    %esi
801062a2:	5f                   	pop    %edi
801062a3:	5d                   	pop    %ebp
801062a4:	c3                   	ret
801062a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062ac:	00 
801062ad:	8d 76 00             	lea    0x0(%esi),%esi

801062b0 <sys_pipe>:
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
801062b3:	57                   	push   %edi
801062b4:	56                   	push   %esi
801062b5:	8d 45 dc             	lea    -0x24(%ebp),%eax
801062b8:	53                   	push   %ebx
801062b9:	83 ec 20             	sub    $0x20,%esp
801062bc:	6a 08                	push   $0x8
801062be:	50                   	push   %eax
801062bf:	6a 00                	push   $0x0
801062c1:	e8 da f3 ff ff       	call   801056a0 <argptr>
801062c6:	83 c4 10             	add    $0x10,%esp
801062c9:	85 c0                	test   %eax,%eax
801062cb:	0f 88 8b 00 00 00    	js     8010635c <sys_pipe+0xac>
801062d1:	83 ec 08             	sub    $0x8,%esp
801062d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801062d7:	50                   	push   %eax
801062d8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801062db:	50                   	push   %eax
801062dc:	e8 2f de ff ff       	call   80104110 <pipealloc>
801062e1:	83 c4 10             	add    $0x10,%esp
801062e4:	85 c0                	test   %eax,%eax
801062e6:	78 74                	js     8010635c <sys_pipe+0xac>
801062e8:	8b 7d e0             	mov    -0x20(%ebp),%edi
801062eb:	31 db                	xor    %ebx,%ebx
801062ed:	e8 6e e3 ff ff       	call   80104660 <myproc>
801062f2:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801062f6:	85 f6                	test   %esi,%esi
801062f8:	74 16                	je     80106310 <sys_pipe+0x60>
801062fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106300:	83 c3 01             	add    $0x1,%ebx
80106303:	83 fb 10             	cmp    $0x10,%ebx
80106306:	74 3d                	je     80106345 <sys_pipe+0x95>
80106308:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010630c:	85 f6                	test   %esi,%esi
8010630e:	75 f0                	jne    80106300 <sys_pipe+0x50>
80106310:	8d 73 08             	lea    0x8(%ebx),%esi
80106313:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
80106317:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010631a:	e8 41 e3 ff ff       	call   80104660 <myproc>
8010631f:	31 d2                	xor    %edx,%edx
80106321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106328:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010632c:	85 c9                	test   %ecx,%ecx
8010632e:	74 38                	je     80106368 <sys_pipe+0xb8>
80106330:	83 c2 01             	add    $0x1,%edx
80106333:	83 fa 10             	cmp    $0x10,%edx
80106336:	75 f0                	jne    80106328 <sys_pipe+0x78>
80106338:	e8 23 e3 ff ff       	call   80104660 <myproc>
8010633d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106344:	00 
80106345:	83 ec 0c             	sub    $0xc,%esp
80106348:	ff 75 e0             	push   -0x20(%ebp)
8010634b:	e8 c0 b8 ff ff       	call   80101c10 <fileclose>
80106350:	58                   	pop    %eax
80106351:	ff 75 e4             	push   -0x1c(%ebp)
80106354:	e8 b7 b8 ff ff       	call   80101c10 <fileclose>
80106359:	83 c4 10             	add    $0x10,%esp
8010635c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106361:	eb 16                	jmp    80106379 <sys_pipe+0xc9>
80106363:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106368:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
8010636c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010636f:	89 18                	mov    %ebx,(%eax)
80106371:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106374:	89 50 04             	mov    %edx,0x4(%eax)
80106377:	31 c0                	xor    %eax,%eax
80106379:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010637c:	5b                   	pop    %ebx
8010637d:	5e                   	pop    %esi
8010637e:	5f                   	pop    %edi
8010637f:	5d                   	pop    %ebp
80106380:	c3                   	ret
80106381:	66 90                	xchg   %ax,%ax
80106383:	66 90                	xchg   %ax,%ax
80106385:	66 90                	xchg   %ax,%ax
80106387:	66 90                	xchg   %ax,%ax
80106389:	66 90                	xchg   %ax,%ax
8010638b:	66 90                	xchg   %ax,%ax
8010638d:	66 90                	xchg   %ax,%ax
8010638f:	90                   	nop

80106390 <sys_fork>:
80106390:	e9 6b e4 ff ff       	jmp    80104800 <fork>
80106395:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010639c:	00 
8010639d:	8d 76 00             	lea    0x0(%esi),%esi

801063a0 <sys_exit>:
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	83 ec 08             	sub    $0x8,%esp
801063a6:	e8 c5 e6 ff ff       	call   80104a70 <exit>
801063ab:	31 c0                	xor    %eax,%eax
801063ad:	c9                   	leave
801063ae:	c3                   	ret
801063af:	90                   	nop

801063b0 <sys_wait>:
801063b0:	e9 eb e7 ff ff       	jmp    80104ba0 <wait>
801063b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063bc:	00 
801063bd:	8d 76 00             	lea    0x0(%esi),%esi

801063c0 <sys_kill>:
801063c0:	55                   	push   %ebp
801063c1:	89 e5                	mov    %esp,%ebp
801063c3:	83 ec 20             	sub    $0x20,%esp
801063c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063c9:	50                   	push   %eax
801063ca:	6a 00                	push   $0x0
801063cc:	e8 7f f2 ff ff       	call   80105650 <argint>
801063d1:	83 c4 10             	add    $0x10,%esp
801063d4:	85 c0                	test   %eax,%eax
801063d6:	78 18                	js     801063f0 <sys_kill+0x30>
801063d8:	83 ec 0c             	sub    $0xc,%esp
801063db:	ff 75 f4             	push   -0xc(%ebp)
801063de:	e8 5d ea ff ff       	call   80104e40 <kill>
801063e3:	83 c4 10             	add    $0x10,%esp
801063e6:	c9                   	leave
801063e7:	c3                   	ret
801063e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063ef:	00 
801063f0:	c9                   	leave
801063f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063f6:	c3                   	ret
801063f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063fe:	00 
801063ff:	90                   	nop

80106400 <sys_getpid>:
80106400:	55                   	push   %ebp
80106401:	89 e5                	mov    %esp,%ebp
80106403:	83 ec 08             	sub    $0x8,%esp
80106406:	e8 55 e2 ff ff       	call   80104660 <myproc>
8010640b:	8b 40 10             	mov    0x10(%eax),%eax
8010640e:	c9                   	leave
8010640f:	c3                   	ret

80106410 <sys_sbrk>:
80106410:	55                   	push   %ebp
80106411:	89 e5                	mov    %esp,%ebp
80106413:	53                   	push   %ebx
80106414:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106417:	83 ec 1c             	sub    $0x1c,%esp
8010641a:	50                   	push   %eax
8010641b:	6a 00                	push   $0x0
8010641d:	e8 2e f2 ff ff       	call   80105650 <argint>
80106422:	83 c4 10             	add    $0x10,%esp
80106425:	85 c0                	test   %eax,%eax
80106427:	78 27                	js     80106450 <sys_sbrk+0x40>
80106429:	e8 32 e2 ff ff       	call   80104660 <myproc>
8010642e:	83 ec 0c             	sub    $0xc,%esp
80106431:	8b 18                	mov    (%eax),%ebx
80106433:	ff 75 f4             	push   -0xc(%ebp)
80106436:	e8 45 e3 ff ff       	call   80104780 <growproc>
8010643b:	83 c4 10             	add    $0x10,%esp
8010643e:	85 c0                	test   %eax,%eax
80106440:	78 0e                	js     80106450 <sys_sbrk+0x40>
80106442:	89 d8                	mov    %ebx,%eax
80106444:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106447:	c9                   	leave
80106448:	c3                   	ret
80106449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106450:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106455:	eb eb                	jmp    80106442 <sys_sbrk+0x32>
80106457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010645e:	00 
8010645f:	90                   	nop

80106460 <sys_sleep>:
80106460:	55                   	push   %ebp
80106461:	89 e5                	mov    %esp,%ebp
80106463:	53                   	push   %ebx
80106464:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106467:	83 ec 1c             	sub    $0x1c,%esp
8010646a:	50                   	push   %eax
8010646b:	6a 00                	push   $0x0
8010646d:	e8 de f1 ff ff       	call   80105650 <argint>
80106472:	83 c4 10             	add    $0x10,%esp
80106475:	85 c0                	test   %eax,%eax
80106477:	78 64                	js     801064dd <sys_sleep+0x7d>
80106479:	83 ec 0c             	sub    $0xc,%esp
8010647c:	68 a0 4c 11 80       	push   $0x80114ca0
80106481:	e8 1a ee ff ff       	call   801052a0 <acquire>
80106486:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106489:	8b 1d 80 4c 11 80    	mov    0x80114c80,%ebx
8010648f:	83 c4 10             	add    $0x10,%esp
80106492:	85 d2                	test   %edx,%edx
80106494:	75 2b                	jne    801064c1 <sys_sleep+0x61>
80106496:	eb 58                	jmp    801064f0 <sys_sleep+0x90>
80106498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010649f:	00 
801064a0:	83 ec 08             	sub    $0x8,%esp
801064a3:	68 a0 4c 11 80       	push   $0x80114ca0
801064a8:	68 80 4c 11 80       	push   $0x80114c80
801064ad:	e8 6e e8 ff ff       	call   80104d20 <sleep>
801064b2:	a1 80 4c 11 80       	mov    0x80114c80,%eax
801064b7:	83 c4 10             	add    $0x10,%esp
801064ba:	29 d8                	sub    %ebx,%eax
801064bc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801064bf:	73 2f                	jae    801064f0 <sys_sleep+0x90>
801064c1:	e8 9a e1 ff ff       	call   80104660 <myproc>
801064c6:	8b 40 24             	mov    0x24(%eax),%eax
801064c9:	85 c0                	test   %eax,%eax
801064cb:	74 d3                	je     801064a0 <sys_sleep+0x40>
801064cd:	83 ec 0c             	sub    $0xc,%esp
801064d0:	68 a0 4c 11 80       	push   $0x80114ca0
801064d5:	e8 66 ed ff ff       	call   80105240 <release>
801064da:	83 c4 10             	add    $0x10,%esp
801064dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064e5:	c9                   	leave
801064e6:	c3                   	ret
801064e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064ee:	00 
801064ef:	90                   	nop
801064f0:	83 ec 0c             	sub    $0xc,%esp
801064f3:	68 a0 4c 11 80       	push   $0x80114ca0
801064f8:	e8 43 ed ff ff       	call   80105240 <release>
801064fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106500:	83 c4 10             	add    $0x10,%esp
80106503:	31 c0                	xor    %eax,%eax
80106505:	c9                   	leave
80106506:	c3                   	ret
80106507:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010650e:	00 
8010650f:	90                   	nop

80106510 <sys_uptime>:
80106510:	55                   	push   %ebp
80106511:	89 e5                	mov    %esp,%ebp
80106513:	53                   	push   %ebx
80106514:	83 ec 10             	sub    $0x10,%esp
80106517:	68 a0 4c 11 80       	push   $0x80114ca0
8010651c:	e8 7f ed ff ff       	call   801052a0 <acquire>
80106521:	8b 1d 80 4c 11 80    	mov    0x80114c80,%ebx
80106527:	c7 04 24 a0 4c 11 80 	movl   $0x80114ca0,(%esp)
8010652e:	e8 0d ed ff ff       	call   80105240 <release>
80106533:	89 d8                	mov    %ebx,%eax
80106535:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106538:	c9                   	leave
80106539:	c3                   	ret

8010653a <alltraps>:
8010653a:	1e                   	push   %ds
8010653b:	06                   	push   %es
8010653c:	0f a0                	push   %fs
8010653e:	0f a8                	push   %gs
80106540:	60                   	pusha
80106541:	66 b8 10 00          	mov    $0x10,%ax
80106545:	8e d8                	mov    %eax,%ds
80106547:	8e c0                	mov    %eax,%es
80106549:	54                   	push   %esp
8010654a:	e8 c1 00 00 00       	call   80106610 <trap>
8010654f:	83 c4 04             	add    $0x4,%esp

80106552 <trapret>:
80106552:	61                   	popa
80106553:	0f a9                	pop    %gs
80106555:	0f a1                	pop    %fs
80106557:	07                   	pop    %es
80106558:	1f                   	pop    %ds
80106559:	83 c4 08             	add    $0x8,%esp
8010655c:	cf                   	iret
8010655d:	66 90                	xchg   %ax,%ax
8010655f:	90                   	nop

80106560 <tvinit>:
80106560:	55                   	push   %ebp
80106561:	31 c0                	xor    %eax,%eax
80106563:	89 e5                	mov    %esp,%ebp
80106565:	83 ec 08             	sub    $0x8,%esp
80106568:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010656f:	00 
80106570:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106577:	c7 04 c5 e2 4c 11 80 	movl   $0x8e000008,-0x7feeb31e(,%eax,8)
8010657e:	08 00 00 8e 
80106582:	66 89 14 c5 e0 4c 11 	mov    %dx,-0x7feeb320(,%eax,8)
80106589:	80 
8010658a:	c1 ea 10             	shr    $0x10,%edx
8010658d:	66 89 14 c5 e6 4c 11 	mov    %dx,-0x7feeb31a(,%eax,8)
80106594:	80 
80106595:	83 c0 01             	add    $0x1,%eax
80106598:	3d 00 01 00 00       	cmp    $0x100,%eax
8010659d:	75 d1                	jne    80106570 <tvinit+0x10>
8010659f:	83 ec 08             	sub    $0x8,%esp
801065a2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801065a7:	c7 05 e2 4e 11 80 08 	movl   $0xef000008,0x80114ee2
801065ae:	00 00 ef 
801065b1:	68 50 82 10 80       	push   $0x80108250
801065b6:	68 a0 4c 11 80       	push   $0x80114ca0
801065bb:	66 a3 e0 4e 11 80    	mov    %ax,0x80114ee0
801065c1:	c1 e8 10             	shr    $0x10,%eax
801065c4:	66 a3 e6 4e 11 80    	mov    %ax,0x80114ee6
801065ca:	e8 e1 ea ff ff       	call   801050b0 <initlock>
801065cf:	83 c4 10             	add    $0x10,%esp
801065d2:	c9                   	leave
801065d3:	c3                   	ret
801065d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801065db:	00 
801065dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801065e0 <idtinit>:
801065e0:	55                   	push   %ebp
801065e1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801065e6:	89 e5                	mov    %esp,%ebp
801065e8:	83 ec 10             	sub    $0x10,%esp
801065eb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
801065ef:	b8 e0 4c 11 80       	mov    $0x80114ce0,%eax
801065f4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801065f8:	c1 e8 10             	shr    $0x10,%eax
801065fb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
801065ff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106602:	0f 01 18             	lidtl  (%eax)
80106605:	c9                   	leave
80106606:	c3                   	ret
80106607:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010660e:	00 
8010660f:	90                   	nop

80106610 <trap>:
80106610:	55                   	push   %ebp
80106611:	89 e5                	mov    %esp,%ebp
80106613:	57                   	push   %edi
80106614:	56                   	push   %esi
80106615:	53                   	push   %ebx
80106616:	83 ec 1c             	sub    $0x1c,%esp
80106619:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010661c:	8b 43 30             	mov    0x30(%ebx),%eax
8010661f:	83 f8 40             	cmp    $0x40,%eax
80106622:	0f 84 58 01 00 00    	je     80106780 <trap+0x170>
80106628:	83 e8 20             	sub    $0x20,%eax
8010662b:	83 f8 1f             	cmp    $0x1f,%eax
8010662e:	0f 87 7c 00 00 00    	ja     801066b0 <trap+0xa0>
80106634:	ff 24 85 18 88 10 80 	jmp    *-0x7fef77e8(,%eax,4)
8010663b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106640:	e8 eb c8 ff ff       	call   80102f30 <ideintr>
80106645:	e8 a6 cf ff ff       	call   801035f0 <lapiceoi>
8010664a:	e8 11 e0 ff ff       	call   80104660 <myproc>
8010664f:	85 c0                	test   %eax,%eax
80106651:	74 1a                	je     8010666d <trap+0x5d>
80106653:	e8 08 e0 ff ff       	call   80104660 <myproc>
80106658:	8b 50 24             	mov    0x24(%eax),%edx
8010665b:	85 d2                	test   %edx,%edx
8010665d:	74 0e                	je     8010666d <trap+0x5d>
8010665f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106663:	f7 d0                	not    %eax
80106665:	a8 03                	test   $0x3,%al
80106667:	0f 84 db 01 00 00    	je     80106848 <trap+0x238>
8010666d:	e8 ee df ff ff       	call   80104660 <myproc>
80106672:	85 c0                	test   %eax,%eax
80106674:	74 0f                	je     80106685 <trap+0x75>
80106676:	e8 e5 df ff ff       	call   80104660 <myproc>
8010667b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010667f:	0f 84 ab 00 00 00    	je     80106730 <trap+0x120>
80106685:	e8 d6 df ff ff       	call   80104660 <myproc>
8010668a:	85 c0                	test   %eax,%eax
8010668c:	74 1a                	je     801066a8 <trap+0x98>
8010668e:	e8 cd df ff ff       	call   80104660 <myproc>
80106693:	8b 40 24             	mov    0x24(%eax),%eax
80106696:	85 c0                	test   %eax,%eax
80106698:	74 0e                	je     801066a8 <trap+0x98>
8010669a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010669e:	f7 d0                	not    %eax
801066a0:	a8 03                	test   $0x3,%al
801066a2:	0f 84 05 01 00 00    	je     801067ad <trap+0x19d>
801066a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066ab:	5b                   	pop    %ebx
801066ac:	5e                   	pop    %esi
801066ad:	5f                   	pop    %edi
801066ae:	5d                   	pop    %ebp
801066af:	c3                   	ret
801066b0:	e8 ab df ff ff       	call   80104660 <myproc>
801066b5:	8b 7b 38             	mov    0x38(%ebx),%edi
801066b8:	85 c0                	test   %eax,%eax
801066ba:	0f 84 a2 01 00 00    	je     80106862 <trap+0x252>
801066c0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801066c4:	0f 84 98 01 00 00    	je     80106862 <trap+0x252>
801066ca:	0f 20 d1             	mov    %cr2,%ecx
801066cd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801066d0:	e8 6b df ff ff       	call   80104640 <cpuid>
801066d5:	8b 73 30             	mov    0x30(%ebx),%esi
801066d8:	89 45 dc             	mov    %eax,-0x24(%ebp)
801066db:	8b 43 34             	mov    0x34(%ebx),%eax
801066de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801066e1:	e8 7a df ff ff       	call   80104660 <myproc>
801066e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801066e9:	e8 72 df ff ff       	call   80104660 <myproc>
801066ee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801066f1:	51                   	push   %ecx
801066f2:	57                   	push   %edi
801066f3:	8b 55 dc             	mov    -0x24(%ebp),%edx
801066f6:	52                   	push   %edx
801066f7:	ff 75 e4             	push   -0x1c(%ebp)
801066fa:	56                   	push   %esi
801066fb:	8b 75 e0             	mov    -0x20(%ebp),%esi
801066fe:	83 c6 6c             	add    $0x6c,%esi
80106701:	56                   	push   %esi
80106702:	ff 70 10             	push   0x10(%eax)
80106705:	68 0c 85 10 80       	push   $0x8010850c
8010670a:	e8 31 a1 ff ff       	call   80100840 <cprintf>
8010670f:	83 c4 20             	add    $0x20,%esp
80106712:	e8 49 df ff ff       	call   80104660 <myproc>
80106717:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010671e:	e8 3d df ff ff       	call   80104660 <myproc>
80106723:	85 c0                	test   %eax,%eax
80106725:	0f 85 28 ff ff ff    	jne    80106653 <trap+0x43>
8010672b:	e9 3d ff ff ff       	jmp    8010666d <trap+0x5d>
80106730:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106734:	0f 85 4b ff ff ff    	jne    80106685 <trap+0x75>
8010673a:	e8 91 e5 ff ff       	call   80104cd0 <yield>
8010673f:	e9 41 ff ff ff       	jmp    80106685 <trap+0x75>
80106744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106748:	8b 7b 38             	mov    0x38(%ebx),%edi
8010674b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010674f:	e8 ec de ff ff       	call   80104640 <cpuid>
80106754:	57                   	push   %edi
80106755:	56                   	push   %esi
80106756:	50                   	push   %eax
80106757:	68 b4 84 10 80       	push   $0x801084b4
8010675c:	e8 df a0 ff ff       	call   80100840 <cprintf>
80106761:	e8 8a ce ff ff       	call   801035f0 <lapiceoi>
80106766:	83 c4 10             	add    $0x10,%esp
80106769:	e8 f2 de ff ff       	call   80104660 <myproc>
8010676e:	85 c0                	test   %eax,%eax
80106770:	0f 85 dd fe ff ff    	jne    80106653 <trap+0x43>
80106776:	e9 f2 fe ff ff       	jmp    8010666d <trap+0x5d>
8010677b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106780:	e8 db de ff ff       	call   80104660 <myproc>
80106785:	8b 70 24             	mov    0x24(%eax),%esi
80106788:	85 f6                	test   %esi,%esi
8010678a:	0f 85 c8 00 00 00    	jne    80106858 <trap+0x248>
80106790:	e8 cb de ff ff       	call   80104660 <myproc>
80106795:	89 58 18             	mov    %ebx,0x18(%eax)
80106798:	e8 f3 ef ff ff       	call   80105790 <syscall>
8010679d:	e8 be de ff ff       	call   80104660 <myproc>
801067a2:	8b 48 24             	mov    0x24(%eax),%ecx
801067a5:	85 c9                	test   %ecx,%ecx
801067a7:	0f 84 fb fe ff ff    	je     801066a8 <trap+0x98>
801067ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067b0:	5b                   	pop    %ebx
801067b1:	5e                   	pop    %esi
801067b2:	5f                   	pop    %edi
801067b3:	5d                   	pop    %ebp
801067b4:	e9 b7 e2 ff ff       	jmp    80104a70 <exit>
801067b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067c0:	e8 4b 02 00 00       	call   80106a10 <uartintr>
801067c5:	e8 26 ce ff ff       	call   801035f0 <lapiceoi>
801067ca:	e8 91 de ff ff       	call   80104660 <myproc>
801067cf:	85 c0                	test   %eax,%eax
801067d1:	0f 85 7c fe ff ff    	jne    80106653 <trap+0x43>
801067d7:	e9 91 fe ff ff       	jmp    8010666d <trap+0x5d>
801067dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067e0:	e8 db cc ff ff       	call   801034c0 <kbdintr>
801067e5:	e8 06 ce ff ff       	call   801035f0 <lapiceoi>
801067ea:	e8 71 de ff ff       	call   80104660 <myproc>
801067ef:	85 c0                	test   %eax,%eax
801067f1:	0f 85 5c fe ff ff    	jne    80106653 <trap+0x43>
801067f7:	e9 71 fe ff ff       	jmp    8010666d <trap+0x5d>
801067fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106800:	e8 3b de ff ff       	call   80104640 <cpuid>
80106805:	85 c0                	test   %eax,%eax
80106807:	0f 85 38 fe ff ff    	jne    80106645 <trap+0x35>
8010680d:	83 ec 0c             	sub    $0xc,%esp
80106810:	68 a0 4c 11 80       	push   $0x80114ca0
80106815:	e8 86 ea ff ff       	call   801052a0 <acquire>
8010681a:	83 05 80 4c 11 80 01 	addl   $0x1,0x80114c80
80106821:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80106828:	e8 b3 e5 ff ff       	call   80104de0 <wakeup>
8010682d:	c7 04 24 a0 4c 11 80 	movl   $0x80114ca0,(%esp)
80106834:	e8 07 ea ff ff       	call   80105240 <release>
80106839:	83 c4 10             	add    $0x10,%esp
8010683c:	e9 04 fe ff ff       	jmp    80106645 <trap+0x35>
80106841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106848:	e8 23 e2 ff ff       	call   80104a70 <exit>
8010684d:	e9 1b fe ff ff       	jmp    8010666d <trap+0x5d>
80106852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106858:	e8 13 e2 ff ff       	call   80104a70 <exit>
8010685d:	e9 2e ff ff ff       	jmp    80106790 <trap+0x180>
80106862:	0f 20 d6             	mov    %cr2,%esi
80106865:	e8 d6 dd ff ff       	call   80104640 <cpuid>
8010686a:	83 ec 0c             	sub    $0xc,%esp
8010686d:	56                   	push   %esi
8010686e:	57                   	push   %edi
8010686f:	50                   	push   %eax
80106870:	ff 73 30             	push   0x30(%ebx)
80106873:	68 d8 84 10 80       	push   $0x801084d8
80106878:	e8 c3 9f ff ff       	call   80100840 <cprintf>
8010687d:	83 c4 14             	add    $0x14,%esp
80106880:	68 55 82 10 80       	push   $0x80108255
80106885:	e8 06 a2 ff ff       	call   80100a90 <panic>
8010688a:	66 90                	xchg   %ax,%ax
8010688c:	66 90                	xchg   %ax,%ax
8010688e:	66 90                	xchg   %ax,%ax

80106890 <uartgetc>:
80106890:	a1 e0 54 11 80       	mov    0x801154e0,%eax
80106895:	85 c0                	test   %eax,%eax
80106897:	74 17                	je     801068b0 <uartgetc+0x20>
80106899:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010689e:	ec                   	in     (%dx),%al
8010689f:	a8 01                	test   $0x1,%al
801068a1:	74 0d                	je     801068b0 <uartgetc+0x20>
801068a3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068a8:	ec                   	in     (%dx),%al
801068a9:	0f b6 c0             	movzbl %al,%eax
801068ac:	c3                   	ret
801068ad:	8d 76 00             	lea    0x0(%esi),%esi
801068b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068b5:	c3                   	ret
801068b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801068bd:	00 
801068be:	66 90                	xchg   %ax,%ax

801068c0 <uartinit>:
801068c0:	55                   	push   %ebp
801068c1:	31 c9                	xor    %ecx,%ecx
801068c3:	89 c8                	mov    %ecx,%eax
801068c5:	89 e5                	mov    %esp,%ebp
801068c7:	57                   	push   %edi
801068c8:	bf fa 03 00 00       	mov    $0x3fa,%edi
801068cd:	56                   	push   %esi
801068ce:	89 fa                	mov    %edi,%edx
801068d0:	53                   	push   %ebx
801068d1:	83 ec 1c             	sub    $0x1c,%esp
801068d4:	ee                   	out    %al,(%dx)
801068d5:	be fb 03 00 00       	mov    $0x3fb,%esi
801068da:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801068df:	89 f2                	mov    %esi,%edx
801068e1:	ee                   	out    %al,(%dx)
801068e2:	b8 0c 00 00 00       	mov    $0xc,%eax
801068e7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068ec:	ee                   	out    %al,(%dx)
801068ed:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801068f2:	89 c8                	mov    %ecx,%eax
801068f4:	89 da                	mov    %ebx,%edx
801068f6:	ee                   	out    %al,(%dx)
801068f7:	b8 03 00 00 00       	mov    $0x3,%eax
801068fc:	89 f2                	mov    %esi,%edx
801068fe:	ee                   	out    %al,(%dx)
801068ff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106904:	89 c8                	mov    %ecx,%eax
80106906:	ee                   	out    %al,(%dx)
80106907:	b8 01 00 00 00       	mov    $0x1,%eax
8010690c:	89 da                	mov    %ebx,%edx
8010690e:	ee                   	out    %al,(%dx)
8010690f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106914:	ec                   	in     (%dx),%al
80106915:	3c ff                	cmp    $0xff,%al
80106917:	0f 84 7c 00 00 00    	je     80106999 <uartinit+0xd9>
8010691d:	c7 05 e0 54 11 80 01 	movl   $0x1,0x801154e0
80106924:	00 00 00 
80106927:	89 fa                	mov    %edi,%edx
80106929:	ec                   	in     (%dx),%al
8010692a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010692f:	ec                   	in     (%dx),%al
80106930:	83 ec 08             	sub    $0x8,%esp
80106933:	bf 5a 82 10 80       	mov    $0x8010825a,%edi
80106938:	be fd 03 00 00       	mov    $0x3fd,%esi
8010693d:	6a 00                	push   $0x0
8010693f:	6a 04                	push   $0x4
80106941:	e8 1a c8 ff ff       	call   80103160 <ioapicenable>
80106946:	83 c4 10             	add    $0x10,%esp
80106949:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
8010694d:	8d 76 00             	lea    0x0(%esi),%esi
80106950:	a1 e0 54 11 80       	mov    0x801154e0,%eax
80106955:	85 c0                	test   %eax,%eax
80106957:	74 32                	je     8010698b <uartinit+0xcb>
80106959:	89 f2                	mov    %esi,%edx
8010695b:	ec                   	in     (%dx),%al
8010695c:	a8 20                	test   $0x20,%al
8010695e:	75 21                	jne    80106981 <uartinit+0xc1>
80106960:	bb 80 00 00 00       	mov    $0x80,%ebx
80106965:	8d 76 00             	lea    0x0(%esi),%esi
80106968:	83 ec 0c             	sub    $0xc,%esp
8010696b:	6a 0a                	push   $0xa
8010696d:	e8 9e cc ff ff       	call   80103610 <microdelay>
80106972:	83 c4 10             	add    $0x10,%esp
80106975:	83 eb 01             	sub    $0x1,%ebx
80106978:	74 07                	je     80106981 <uartinit+0xc1>
8010697a:	89 f2                	mov    %esi,%edx
8010697c:	ec                   	in     (%dx),%al
8010697d:	a8 20                	test   $0x20,%al
8010697f:	74 e7                	je     80106968 <uartinit+0xa8>
80106981:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106986:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010698a:	ee                   	out    %al,(%dx)
8010698b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010698f:	83 c7 01             	add    $0x1,%edi
80106992:	88 45 e7             	mov    %al,-0x19(%ebp)
80106995:	84 c0                	test   %al,%al
80106997:	75 b7                	jne    80106950 <uartinit+0x90>
80106999:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010699c:	5b                   	pop    %ebx
8010699d:	5e                   	pop    %esi
8010699e:	5f                   	pop    %edi
8010699f:	5d                   	pop    %ebp
801069a0:	c3                   	ret
801069a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801069a8:	00 
801069a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801069b0 <uartputc>:
801069b0:	a1 e0 54 11 80       	mov    0x801154e0,%eax
801069b5:	85 c0                	test   %eax,%eax
801069b7:	74 4f                	je     80106a08 <uartputc+0x58>
801069b9:	55                   	push   %ebp
801069ba:	ba fd 03 00 00       	mov    $0x3fd,%edx
801069bf:	89 e5                	mov    %esp,%ebp
801069c1:	56                   	push   %esi
801069c2:	53                   	push   %ebx
801069c3:	ec                   	in     (%dx),%al
801069c4:	a8 20                	test   $0x20,%al
801069c6:	75 29                	jne    801069f1 <uartputc+0x41>
801069c8:	bb 80 00 00 00       	mov    $0x80,%ebx
801069cd:	be fd 03 00 00       	mov    $0x3fd,%esi
801069d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801069d8:	83 ec 0c             	sub    $0xc,%esp
801069db:	6a 0a                	push   $0xa
801069dd:	e8 2e cc ff ff       	call   80103610 <microdelay>
801069e2:	83 c4 10             	add    $0x10,%esp
801069e5:	83 eb 01             	sub    $0x1,%ebx
801069e8:	74 07                	je     801069f1 <uartputc+0x41>
801069ea:	89 f2                	mov    %esi,%edx
801069ec:	ec                   	in     (%dx),%al
801069ed:	a8 20                	test   $0x20,%al
801069ef:	74 e7                	je     801069d8 <uartputc+0x28>
801069f1:	8b 45 08             	mov    0x8(%ebp),%eax
801069f4:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069f9:	ee                   	out    %al,(%dx)
801069fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801069fd:	5b                   	pop    %ebx
801069fe:	5e                   	pop    %esi
801069ff:	5d                   	pop    %ebp
80106a00:	c3                   	ret
80106a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a08:	c3                   	ret
80106a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a10 <uartintr>:
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	83 ec 14             	sub    $0x14,%esp
80106a16:	68 90 68 10 80       	push   $0x80106890
80106a1b:	e8 a0 a4 ff ff       	call   80100ec0 <consoleintr>
80106a20:	83 c4 10             	add    $0x10,%esp
80106a23:	c9                   	leave
80106a24:	c3                   	ret

80106a25 <vector0>:
80106a25:	6a 00                	push   $0x0
80106a27:	6a 00                	push   $0x0
80106a29:	e9 0c fb ff ff       	jmp    8010653a <alltraps>

80106a2e <vector1>:
80106a2e:	6a 00                	push   $0x0
80106a30:	6a 01                	push   $0x1
80106a32:	e9 03 fb ff ff       	jmp    8010653a <alltraps>

80106a37 <vector2>:
80106a37:	6a 00                	push   $0x0
80106a39:	6a 02                	push   $0x2
80106a3b:	e9 fa fa ff ff       	jmp    8010653a <alltraps>

80106a40 <vector3>:
80106a40:	6a 00                	push   $0x0
80106a42:	6a 03                	push   $0x3
80106a44:	e9 f1 fa ff ff       	jmp    8010653a <alltraps>

80106a49 <vector4>:
80106a49:	6a 00                	push   $0x0
80106a4b:	6a 04                	push   $0x4
80106a4d:	e9 e8 fa ff ff       	jmp    8010653a <alltraps>

80106a52 <vector5>:
80106a52:	6a 00                	push   $0x0
80106a54:	6a 05                	push   $0x5
80106a56:	e9 df fa ff ff       	jmp    8010653a <alltraps>

80106a5b <vector6>:
80106a5b:	6a 00                	push   $0x0
80106a5d:	6a 06                	push   $0x6
80106a5f:	e9 d6 fa ff ff       	jmp    8010653a <alltraps>

80106a64 <vector7>:
80106a64:	6a 00                	push   $0x0
80106a66:	6a 07                	push   $0x7
80106a68:	e9 cd fa ff ff       	jmp    8010653a <alltraps>

80106a6d <vector8>:
80106a6d:	6a 08                	push   $0x8
80106a6f:	e9 c6 fa ff ff       	jmp    8010653a <alltraps>

80106a74 <vector9>:
80106a74:	6a 00                	push   $0x0
80106a76:	6a 09                	push   $0x9
80106a78:	e9 bd fa ff ff       	jmp    8010653a <alltraps>

80106a7d <vector10>:
80106a7d:	6a 0a                	push   $0xa
80106a7f:	e9 b6 fa ff ff       	jmp    8010653a <alltraps>

80106a84 <vector11>:
80106a84:	6a 0b                	push   $0xb
80106a86:	e9 af fa ff ff       	jmp    8010653a <alltraps>

80106a8b <vector12>:
80106a8b:	6a 0c                	push   $0xc
80106a8d:	e9 a8 fa ff ff       	jmp    8010653a <alltraps>

80106a92 <vector13>:
80106a92:	6a 0d                	push   $0xd
80106a94:	e9 a1 fa ff ff       	jmp    8010653a <alltraps>

80106a99 <vector14>:
80106a99:	6a 0e                	push   $0xe
80106a9b:	e9 9a fa ff ff       	jmp    8010653a <alltraps>

80106aa0 <vector15>:
80106aa0:	6a 00                	push   $0x0
80106aa2:	6a 0f                	push   $0xf
80106aa4:	e9 91 fa ff ff       	jmp    8010653a <alltraps>

80106aa9 <vector16>:
80106aa9:	6a 00                	push   $0x0
80106aab:	6a 10                	push   $0x10
80106aad:	e9 88 fa ff ff       	jmp    8010653a <alltraps>

80106ab2 <vector17>:
80106ab2:	6a 11                	push   $0x11
80106ab4:	e9 81 fa ff ff       	jmp    8010653a <alltraps>

80106ab9 <vector18>:
80106ab9:	6a 00                	push   $0x0
80106abb:	6a 12                	push   $0x12
80106abd:	e9 78 fa ff ff       	jmp    8010653a <alltraps>

80106ac2 <vector19>:
80106ac2:	6a 00                	push   $0x0
80106ac4:	6a 13                	push   $0x13
80106ac6:	e9 6f fa ff ff       	jmp    8010653a <alltraps>

80106acb <vector20>:
80106acb:	6a 00                	push   $0x0
80106acd:	6a 14                	push   $0x14
80106acf:	e9 66 fa ff ff       	jmp    8010653a <alltraps>

80106ad4 <vector21>:
80106ad4:	6a 00                	push   $0x0
80106ad6:	6a 15                	push   $0x15
80106ad8:	e9 5d fa ff ff       	jmp    8010653a <alltraps>

80106add <vector22>:
80106add:	6a 00                	push   $0x0
80106adf:	6a 16                	push   $0x16
80106ae1:	e9 54 fa ff ff       	jmp    8010653a <alltraps>

80106ae6 <vector23>:
80106ae6:	6a 00                	push   $0x0
80106ae8:	6a 17                	push   $0x17
80106aea:	e9 4b fa ff ff       	jmp    8010653a <alltraps>

80106aef <vector24>:
80106aef:	6a 00                	push   $0x0
80106af1:	6a 18                	push   $0x18
80106af3:	e9 42 fa ff ff       	jmp    8010653a <alltraps>

80106af8 <vector25>:
80106af8:	6a 00                	push   $0x0
80106afa:	6a 19                	push   $0x19
80106afc:	e9 39 fa ff ff       	jmp    8010653a <alltraps>

80106b01 <vector26>:
80106b01:	6a 00                	push   $0x0
80106b03:	6a 1a                	push   $0x1a
80106b05:	e9 30 fa ff ff       	jmp    8010653a <alltraps>

80106b0a <vector27>:
80106b0a:	6a 00                	push   $0x0
80106b0c:	6a 1b                	push   $0x1b
80106b0e:	e9 27 fa ff ff       	jmp    8010653a <alltraps>

80106b13 <vector28>:
80106b13:	6a 00                	push   $0x0
80106b15:	6a 1c                	push   $0x1c
80106b17:	e9 1e fa ff ff       	jmp    8010653a <alltraps>

80106b1c <vector29>:
80106b1c:	6a 00                	push   $0x0
80106b1e:	6a 1d                	push   $0x1d
80106b20:	e9 15 fa ff ff       	jmp    8010653a <alltraps>

80106b25 <vector30>:
80106b25:	6a 00                	push   $0x0
80106b27:	6a 1e                	push   $0x1e
80106b29:	e9 0c fa ff ff       	jmp    8010653a <alltraps>

80106b2e <vector31>:
80106b2e:	6a 00                	push   $0x0
80106b30:	6a 1f                	push   $0x1f
80106b32:	e9 03 fa ff ff       	jmp    8010653a <alltraps>

80106b37 <vector32>:
80106b37:	6a 00                	push   $0x0
80106b39:	6a 20                	push   $0x20
80106b3b:	e9 fa f9 ff ff       	jmp    8010653a <alltraps>

80106b40 <vector33>:
80106b40:	6a 00                	push   $0x0
80106b42:	6a 21                	push   $0x21
80106b44:	e9 f1 f9 ff ff       	jmp    8010653a <alltraps>

80106b49 <vector34>:
80106b49:	6a 00                	push   $0x0
80106b4b:	6a 22                	push   $0x22
80106b4d:	e9 e8 f9 ff ff       	jmp    8010653a <alltraps>

80106b52 <vector35>:
80106b52:	6a 00                	push   $0x0
80106b54:	6a 23                	push   $0x23
80106b56:	e9 df f9 ff ff       	jmp    8010653a <alltraps>

80106b5b <vector36>:
80106b5b:	6a 00                	push   $0x0
80106b5d:	6a 24                	push   $0x24
80106b5f:	e9 d6 f9 ff ff       	jmp    8010653a <alltraps>

80106b64 <vector37>:
80106b64:	6a 00                	push   $0x0
80106b66:	6a 25                	push   $0x25
80106b68:	e9 cd f9 ff ff       	jmp    8010653a <alltraps>

80106b6d <vector38>:
80106b6d:	6a 00                	push   $0x0
80106b6f:	6a 26                	push   $0x26
80106b71:	e9 c4 f9 ff ff       	jmp    8010653a <alltraps>

80106b76 <vector39>:
80106b76:	6a 00                	push   $0x0
80106b78:	6a 27                	push   $0x27
80106b7a:	e9 bb f9 ff ff       	jmp    8010653a <alltraps>

80106b7f <vector40>:
80106b7f:	6a 00                	push   $0x0
80106b81:	6a 28                	push   $0x28
80106b83:	e9 b2 f9 ff ff       	jmp    8010653a <alltraps>

80106b88 <vector41>:
80106b88:	6a 00                	push   $0x0
80106b8a:	6a 29                	push   $0x29
80106b8c:	e9 a9 f9 ff ff       	jmp    8010653a <alltraps>

80106b91 <vector42>:
80106b91:	6a 00                	push   $0x0
80106b93:	6a 2a                	push   $0x2a
80106b95:	e9 a0 f9 ff ff       	jmp    8010653a <alltraps>

80106b9a <vector43>:
80106b9a:	6a 00                	push   $0x0
80106b9c:	6a 2b                	push   $0x2b
80106b9e:	e9 97 f9 ff ff       	jmp    8010653a <alltraps>

80106ba3 <vector44>:
80106ba3:	6a 00                	push   $0x0
80106ba5:	6a 2c                	push   $0x2c
80106ba7:	e9 8e f9 ff ff       	jmp    8010653a <alltraps>

80106bac <vector45>:
80106bac:	6a 00                	push   $0x0
80106bae:	6a 2d                	push   $0x2d
80106bb0:	e9 85 f9 ff ff       	jmp    8010653a <alltraps>

80106bb5 <vector46>:
80106bb5:	6a 00                	push   $0x0
80106bb7:	6a 2e                	push   $0x2e
80106bb9:	e9 7c f9 ff ff       	jmp    8010653a <alltraps>

80106bbe <vector47>:
80106bbe:	6a 00                	push   $0x0
80106bc0:	6a 2f                	push   $0x2f
80106bc2:	e9 73 f9 ff ff       	jmp    8010653a <alltraps>

80106bc7 <vector48>:
80106bc7:	6a 00                	push   $0x0
80106bc9:	6a 30                	push   $0x30
80106bcb:	e9 6a f9 ff ff       	jmp    8010653a <alltraps>

80106bd0 <vector49>:
80106bd0:	6a 00                	push   $0x0
80106bd2:	6a 31                	push   $0x31
80106bd4:	e9 61 f9 ff ff       	jmp    8010653a <alltraps>

80106bd9 <vector50>:
80106bd9:	6a 00                	push   $0x0
80106bdb:	6a 32                	push   $0x32
80106bdd:	e9 58 f9 ff ff       	jmp    8010653a <alltraps>

80106be2 <vector51>:
80106be2:	6a 00                	push   $0x0
80106be4:	6a 33                	push   $0x33
80106be6:	e9 4f f9 ff ff       	jmp    8010653a <alltraps>

80106beb <vector52>:
80106beb:	6a 00                	push   $0x0
80106bed:	6a 34                	push   $0x34
80106bef:	e9 46 f9 ff ff       	jmp    8010653a <alltraps>

80106bf4 <vector53>:
80106bf4:	6a 00                	push   $0x0
80106bf6:	6a 35                	push   $0x35
80106bf8:	e9 3d f9 ff ff       	jmp    8010653a <alltraps>

80106bfd <vector54>:
80106bfd:	6a 00                	push   $0x0
80106bff:	6a 36                	push   $0x36
80106c01:	e9 34 f9 ff ff       	jmp    8010653a <alltraps>

80106c06 <vector55>:
80106c06:	6a 00                	push   $0x0
80106c08:	6a 37                	push   $0x37
80106c0a:	e9 2b f9 ff ff       	jmp    8010653a <alltraps>

80106c0f <vector56>:
80106c0f:	6a 00                	push   $0x0
80106c11:	6a 38                	push   $0x38
80106c13:	e9 22 f9 ff ff       	jmp    8010653a <alltraps>

80106c18 <vector57>:
80106c18:	6a 00                	push   $0x0
80106c1a:	6a 39                	push   $0x39
80106c1c:	e9 19 f9 ff ff       	jmp    8010653a <alltraps>

80106c21 <vector58>:
80106c21:	6a 00                	push   $0x0
80106c23:	6a 3a                	push   $0x3a
80106c25:	e9 10 f9 ff ff       	jmp    8010653a <alltraps>

80106c2a <vector59>:
80106c2a:	6a 00                	push   $0x0
80106c2c:	6a 3b                	push   $0x3b
80106c2e:	e9 07 f9 ff ff       	jmp    8010653a <alltraps>

80106c33 <vector60>:
80106c33:	6a 00                	push   $0x0
80106c35:	6a 3c                	push   $0x3c
80106c37:	e9 fe f8 ff ff       	jmp    8010653a <alltraps>

80106c3c <vector61>:
80106c3c:	6a 00                	push   $0x0
80106c3e:	6a 3d                	push   $0x3d
80106c40:	e9 f5 f8 ff ff       	jmp    8010653a <alltraps>

80106c45 <vector62>:
80106c45:	6a 00                	push   $0x0
80106c47:	6a 3e                	push   $0x3e
80106c49:	e9 ec f8 ff ff       	jmp    8010653a <alltraps>

80106c4e <vector63>:
80106c4e:	6a 00                	push   $0x0
80106c50:	6a 3f                	push   $0x3f
80106c52:	e9 e3 f8 ff ff       	jmp    8010653a <alltraps>

80106c57 <vector64>:
80106c57:	6a 00                	push   $0x0
80106c59:	6a 40                	push   $0x40
80106c5b:	e9 da f8 ff ff       	jmp    8010653a <alltraps>

80106c60 <vector65>:
80106c60:	6a 00                	push   $0x0
80106c62:	6a 41                	push   $0x41
80106c64:	e9 d1 f8 ff ff       	jmp    8010653a <alltraps>

80106c69 <vector66>:
80106c69:	6a 00                	push   $0x0
80106c6b:	6a 42                	push   $0x42
80106c6d:	e9 c8 f8 ff ff       	jmp    8010653a <alltraps>

80106c72 <vector67>:
80106c72:	6a 00                	push   $0x0
80106c74:	6a 43                	push   $0x43
80106c76:	e9 bf f8 ff ff       	jmp    8010653a <alltraps>

80106c7b <vector68>:
80106c7b:	6a 00                	push   $0x0
80106c7d:	6a 44                	push   $0x44
80106c7f:	e9 b6 f8 ff ff       	jmp    8010653a <alltraps>

80106c84 <vector69>:
80106c84:	6a 00                	push   $0x0
80106c86:	6a 45                	push   $0x45
80106c88:	e9 ad f8 ff ff       	jmp    8010653a <alltraps>

80106c8d <vector70>:
80106c8d:	6a 00                	push   $0x0
80106c8f:	6a 46                	push   $0x46
80106c91:	e9 a4 f8 ff ff       	jmp    8010653a <alltraps>

80106c96 <vector71>:
80106c96:	6a 00                	push   $0x0
80106c98:	6a 47                	push   $0x47
80106c9a:	e9 9b f8 ff ff       	jmp    8010653a <alltraps>

80106c9f <vector72>:
80106c9f:	6a 00                	push   $0x0
80106ca1:	6a 48                	push   $0x48
80106ca3:	e9 92 f8 ff ff       	jmp    8010653a <alltraps>

80106ca8 <vector73>:
80106ca8:	6a 00                	push   $0x0
80106caa:	6a 49                	push   $0x49
80106cac:	e9 89 f8 ff ff       	jmp    8010653a <alltraps>

80106cb1 <vector74>:
80106cb1:	6a 00                	push   $0x0
80106cb3:	6a 4a                	push   $0x4a
80106cb5:	e9 80 f8 ff ff       	jmp    8010653a <alltraps>

80106cba <vector75>:
80106cba:	6a 00                	push   $0x0
80106cbc:	6a 4b                	push   $0x4b
80106cbe:	e9 77 f8 ff ff       	jmp    8010653a <alltraps>

80106cc3 <vector76>:
80106cc3:	6a 00                	push   $0x0
80106cc5:	6a 4c                	push   $0x4c
80106cc7:	e9 6e f8 ff ff       	jmp    8010653a <alltraps>

80106ccc <vector77>:
80106ccc:	6a 00                	push   $0x0
80106cce:	6a 4d                	push   $0x4d
80106cd0:	e9 65 f8 ff ff       	jmp    8010653a <alltraps>

80106cd5 <vector78>:
80106cd5:	6a 00                	push   $0x0
80106cd7:	6a 4e                	push   $0x4e
80106cd9:	e9 5c f8 ff ff       	jmp    8010653a <alltraps>

80106cde <vector79>:
80106cde:	6a 00                	push   $0x0
80106ce0:	6a 4f                	push   $0x4f
80106ce2:	e9 53 f8 ff ff       	jmp    8010653a <alltraps>

80106ce7 <vector80>:
80106ce7:	6a 00                	push   $0x0
80106ce9:	6a 50                	push   $0x50
80106ceb:	e9 4a f8 ff ff       	jmp    8010653a <alltraps>

80106cf0 <vector81>:
80106cf0:	6a 00                	push   $0x0
80106cf2:	6a 51                	push   $0x51
80106cf4:	e9 41 f8 ff ff       	jmp    8010653a <alltraps>

80106cf9 <vector82>:
80106cf9:	6a 00                	push   $0x0
80106cfb:	6a 52                	push   $0x52
80106cfd:	e9 38 f8 ff ff       	jmp    8010653a <alltraps>

80106d02 <vector83>:
80106d02:	6a 00                	push   $0x0
80106d04:	6a 53                	push   $0x53
80106d06:	e9 2f f8 ff ff       	jmp    8010653a <alltraps>

80106d0b <vector84>:
80106d0b:	6a 00                	push   $0x0
80106d0d:	6a 54                	push   $0x54
80106d0f:	e9 26 f8 ff ff       	jmp    8010653a <alltraps>

80106d14 <vector85>:
80106d14:	6a 00                	push   $0x0
80106d16:	6a 55                	push   $0x55
80106d18:	e9 1d f8 ff ff       	jmp    8010653a <alltraps>

80106d1d <vector86>:
80106d1d:	6a 00                	push   $0x0
80106d1f:	6a 56                	push   $0x56
80106d21:	e9 14 f8 ff ff       	jmp    8010653a <alltraps>

80106d26 <vector87>:
80106d26:	6a 00                	push   $0x0
80106d28:	6a 57                	push   $0x57
80106d2a:	e9 0b f8 ff ff       	jmp    8010653a <alltraps>

80106d2f <vector88>:
80106d2f:	6a 00                	push   $0x0
80106d31:	6a 58                	push   $0x58
80106d33:	e9 02 f8 ff ff       	jmp    8010653a <alltraps>

80106d38 <vector89>:
80106d38:	6a 00                	push   $0x0
80106d3a:	6a 59                	push   $0x59
80106d3c:	e9 f9 f7 ff ff       	jmp    8010653a <alltraps>

80106d41 <vector90>:
80106d41:	6a 00                	push   $0x0
80106d43:	6a 5a                	push   $0x5a
80106d45:	e9 f0 f7 ff ff       	jmp    8010653a <alltraps>

80106d4a <vector91>:
80106d4a:	6a 00                	push   $0x0
80106d4c:	6a 5b                	push   $0x5b
80106d4e:	e9 e7 f7 ff ff       	jmp    8010653a <alltraps>

80106d53 <vector92>:
80106d53:	6a 00                	push   $0x0
80106d55:	6a 5c                	push   $0x5c
80106d57:	e9 de f7 ff ff       	jmp    8010653a <alltraps>

80106d5c <vector93>:
80106d5c:	6a 00                	push   $0x0
80106d5e:	6a 5d                	push   $0x5d
80106d60:	e9 d5 f7 ff ff       	jmp    8010653a <alltraps>

80106d65 <vector94>:
80106d65:	6a 00                	push   $0x0
80106d67:	6a 5e                	push   $0x5e
80106d69:	e9 cc f7 ff ff       	jmp    8010653a <alltraps>

80106d6e <vector95>:
80106d6e:	6a 00                	push   $0x0
80106d70:	6a 5f                	push   $0x5f
80106d72:	e9 c3 f7 ff ff       	jmp    8010653a <alltraps>

80106d77 <vector96>:
80106d77:	6a 00                	push   $0x0
80106d79:	6a 60                	push   $0x60
80106d7b:	e9 ba f7 ff ff       	jmp    8010653a <alltraps>

80106d80 <vector97>:
80106d80:	6a 00                	push   $0x0
80106d82:	6a 61                	push   $0x61
80106d84:	e9 b1 f7 ff ff       	jmp    8010653a <alltraps>

80106d89 <vector98>:
80106d89:	6a 00                	push   $0x0
80106d8b:	6a 62                	push   $0x62
80106d8d:	e9 a8 f7 ff ff       	jmp    8010653a <alltraps>

80106d92 <vector99>:
80106d92:	6a 00                	push   $0x0
80106d94:	6a 63                	push   $0x63
80106d96:	e9 9f f7 ff ff       	jmp    8010653a <alltraps>

80106d9b <vector100>:
80106d9b:	6a 00                	push   $0x0
80106d9d:	6a 64                	push   $0x64
80106d9f:	e9 96 f7 ff ff       	jmp    8010653a <alltraps>

80106da4 <vector101>:
80106da4:	6a 00                	push   $0x0
80106da6:	6a 65                	push   $0x65
80106da8:	e9 8d f7 ff ff       	jmp    8010653a <alltraps>

80106dad <vector102>:
80106dad:	6a 00                	push   $0x0
80106daf:	6a 66                	push   $0x66
80106db1:	e9 84 f7 ff ff       	jmp    8010653a <alltraps>

80106db6 <vector103>:
80106db6:	6a 00                	push   $0x0
80106db8:	6a 67                	push   $0x67
80106dba:	e9 7b f7 ff ff       	jmp    8010653a <alltraps>

80106dbf <vector104>:
80106dbf:	6a 00                	push   $0x0
80106dc1:	6a 68                	push   $0x68
80106dc3:	e9 72 f7 ff ff       	jmp    8010653a <alltraps>

80106dc8 <vector105>:
80106dc8:	6a 00                	push   $0x0
80106dca:	6a 69                	push   $0x69
80106dcc:	e9 69 f7 ff ff       	jmp    8010653a <alltraps>

80106dd1 <vector106>:
80106dd1:	6a 00                	push   $0x0
80106dd3:	6a 6a                	push   $0x6a
80106dd5:	e9 60 f7 ff ff       	jmp    8010653a <alltraps>

80106dda <vector107>:
80106dda:	6a 00                	push   $0x0
80106ddc:	6a 6b                	push   $0x6b
80106dde:	e9 57 f7 ff ff       	jmp    8010653a <alltraps>

80106de3 <vector108>:
80106de3:	6a 00                	push   $0x0
80106de5:	6a 6c                	push   $0x6c
80106de7:	e9 4e f7 ff ff       	jmp    8010653a <alltraps>

80106dec <vector109>:
80106dec:	6a 00                	push   $0x0
80106dee:	6a 6d                	push   $0x6d
80106df0:	e9 45 f7 ff ff       	jmp    8010653a <alltraps>

80106df5 <vector110>:
80106df5:	6a 00                	push   $0x0
80106df7:	6a 6e                	push   $0x6e
80106df9:	e9 3c f7 ff ff       	jmp    8010653a <alltraps>

80106dfe <vector111>:
80106dfe:	6a 00                	push   $0x0
80106e00:	6a 6f                	push   $0x6f
80106e02:	e9 33 f7 ff ff       	jmp    8010653a <alltraps>

80106e07 <vector112>:
80106e07:	6a 00                	push   $0x0
80106e09:	6a 70                	push   $0x70
80106e0b:	e9 2a f7 ff ff       	jmp    8010653a <alltraps>

80106e10 <vector113>:
80106e10:	6a 00                	push   $0x0
80106e12:	6a 71                	push   $0x71
80106e14:	e9 21 f7 ff ff       	jmp    8010653a <alltraps>

80106e19 <vector114>:
80106e19:	6a 00                	push   $0x0
80106e1b:	6a 72                	push   $0x72
80106e1d:	e9 18 f7 ff ff       	jmp    8010653a <alltraps>

80106e22 <vector115>:
80106e22:	6a 00                	push   $0x0
80106e24:	6a 73                	push   $0x73
80106e26:	e9 0f f7 ff ff       	jmp    8010653a <alltraps>

80106e2b <vector116>:
80106e2b:	6a 00                	push   $0x0
80106e2d:	6a 74                	push   $0x74
80106e2f:	e9 06 f7 ff ff       	jmp    8010653a <alltraps>

80106e34 <vector117>:
80106e34:	6a 00                	push   $0x0
80106e36:	6a 75                	push   $0x75
80106e38:	e9 fd f6 ff ff       	jmp    8010653a <alltraps>

80106e3d <vector118>:
80106e3d:	6a 00                	push   $0x0
80106e3f:	6a 76                	push   $0x76
80106e41:	e9 f4 f6 ff ff       	jmp    8010653a <alltraps>

80106e46 <vector119>:
80106e46:	6a 00                	push   $0x0
80106e48:	6a 77                	push   $0x77
80106e4a:	e9 eb f6 ff ff       	jmp    8010653a <alltraps>

80106e4f <vector120>:
80106e4f:	6a 00                	push   $0x0
80106e51:	6a 78                	push   $0x78
80106e53:	e9 e2 f6 ff ff       	jmp    8010653a <alltraps>

80106e58 <vector121>:
80106e58:	6a 00                	push   $0x0
80106e5a:	6a 79                	push   $0x79
80106e5c:	e9 d9 f6 ff ff       	jmp    8010653a <alltraps>

80106e61 <vector122>:
80106e61:	6a 00                	push   $0x0
80106e63:	6a 7a                	push   $0x7a
80106e65:	e9 d0 f6 ff ff       	jmp    8010653a <alltraps>

80106e6a <vector123>:
80106e6a:	6a 00                	push   $0x0
80106e6c:	6a 7b                	push   $0x7b
80106e6e:	e9 c7 f6 ff ff       	jmp    8010653a <alltraps>

80106e73 <vector124>:
80106e73:	6a 00                	push   $0x0
80106e75:	6a 7c                	push   $0x7c
80106e77:	e9 be f6 ff ff       	jmp    8010653a <alltraps>

80106e7c <vector125>:
80106e7c:	6a 00                	push   $0x0
80106e7e:	6a 7d                	push   $0x7d
80106e80:	e9 b5 f6 ff ff       	jmp    8010653a <alltraps>

80106e85 <vector126>:
80106e85:	6a 00                	push   $0x0
80106e87:	6a 7e                	push   $0x7e
80106e89:	e9 ac f6 ff ff       	jmp    8010653a <alltraps>

80106e8e <vector127>:
80106e8e:	6a 00                	push   $0x0
80106e90:	6a 7f                	push   $0x7f
80106e92:	e9 a3 f6 ff ff       	jmp    8010653a <alltraps>

80106e97 <vector128>:
80106e97:	6a 00                	push   $0x0
80106e99:	68 80 00 00 00       	push   $0x80
80106e9e:	e9 97 f6 ff ff       	jmp    8010653a <alltraps>

80106ea3 <vector129>:
80106ea3:	6a 00                	push   $0x0
80106ea5:	68 81 00 00 00       	push   $0x81
80106eaa:	e9 8b f6 ff ff       	jmp    8010653a <alltraps>

80106eaf <vector130>:
80106eaf:	6a 00                	push   $0x0
80106eb1:	68 82 00 00 00       	push   $0x82
80106eb6:	e9 7f f6 ff ff       	jmp    8010653a <alltraps>

80106ebb <vector131>:
80106ebb:	6a 00                	push   $0x0
80106ebd:	68 83 00 00 00       	push   $0x83
80106ec2:	e9 73 f6 ff ff       	jmp    8010653a <alltraps>

80106ec7 <vector132>:
80106ec7:	6a 00                	push   $0x0
80106ec9:	68 84 00 00 00       	push   $0x84
80106ece:	e9 67 f6 ff ff       	jmp    8010653a <alltraps>

80106ed3 <vector133>:
80106ed3:	6a 00                	push   $0x0
80106ed5:	68 85 00 00 00       	push   $0x85
80106eda:	e9 5b f6 ff ff       	jmp    8010653a <alltraps>

80106edf <vector134>:
80106edf:	6a 00                	push   $0x0
80106ee1:	68 86 00 00 00       	push   $0x86
80106ee6:	e9 4f f6 ff ff       	jmp    8010653a <alltraps>

80106eeb <vector135>:
80106eeb:	6a 00                	push   $0x0
80106eed:	68 87 00 00 00       	push   $0x87
80106ef2:	e9 43 f6 ff ff       	jmp    8010653a <alltraps>

80106ef7 <vector136>:
80106ef7:	6a 00                	push   $0x0
80106ef9:	68 88 00 00 00       	push   $0x88
80106efe:	e9 37 f6 ff ff       	jmp    8010653a <alltraps>

80106f03 <vector137>:
80106f03:	6a 00                	push   $0x0
80106f05:	68 89 00 00 00       	push   $0x89
80106f0a:	e9 2b f6 ff ff       	jmp    8010653a <alltraps>

80106f0f <vector138>:
80106f0f:	6a 00                	push   $0x0
80106f11:	68 8a 00 00 00       	push   $0x8a
80106f16:	e9 1f f6 ff ff       	jmp    8010653a <alltraps>

80106f1b <vector139>:
80106f1b:	6a 00                	push   $0x0
80106f1d:	68 8b 00 00 00       	push   $0x8b
80106f22:	e9 13 f6 ff ff       	jmp    8010653a <alltraps>

80106f27 <vector140>:
80106f27:	6a 00                	push   $0x0
80106f29:	68 8c 00 00 00       	push   $0x8c
80106f2e:	e9 07 f6 ff ff       	jmp    8010653a <alltraps>

80106f33 <vector141>:
80106f33:	6a 00                	push   $0x0
80106f35:	68 8d 00 00 00       	push   $0x8d
80106f3a:	e9 fb f5 ff ff       	jmp    8010653a <alltraps>

80106f3f <vector142>:
80106f3f:	6a 00                	push   $0x0
80106f41:	68 8e 00 00 00       	push   $0x8e
80106f46:	e9 ef f5 ff ff       	jmp    8010653a <alltraps>

80106f4b <vector143>:
80106f4b:	6a 00                	push   $0x0
80106f4d:	68 8f 00 00 00       	push   $0x8f
80106f52:	e9 e3 f5 ff ff       	jmp    8010653a <alltraps>

80106f57 <vector144>:
80106f57:	6a 00                	push   $0x0
80106f59:	68 90 00 00 00       	push   $0x90
80106f5e:	e9 d7 f5 ff ff       	jmp    8010653a <alltraps>

80106f63 <vector145>:
80106f63:	6a 00                	push   $0x0
80106f65:	68 91 00 00 00       	push   $0x91
80106f6a:	e9 cb f5 ff ff       	jmp    8010653a <alltraps>

80106f6f <vector146>:
80106f6f:	6a 00                	push   $0x0
80106f71:	68 92 00 00 00       	push   $0x92
80106f76:	e9 bf f5 ff ff       	jmp    8010653a <alltraps>

80106f7b <vector147>:
80106f7b:	6a 00                	push   $0x0
80106f7d:	68 93 00 00 00       	push   $0x93
80106f82:	e9 b3 f5 ff ff       	jmp    8010653a <alltraps>

80106f87 <vector148>:
80106f87:	6a 00                	push   $0x0
80106f89:	68 94 00 00 00       	push   $0x94
80106f8e:	e9 a7 f5 ff ff       	jmp    8010653a <alltraps>

80106f93 <vector149>:
80106f93:	6a 00                	push   $0x0
80106f95:	68 95 00 00 00       	push   $0x95
80106f9a:	e9 9b f5 ff ff       	jmp    8010653a <alltraps>

80106f9f <vector150>:
80106f9f:	6a 00                	push   $0x0
80106fa1:	68 96 00 00 00       	push   $0x96
80106fa6:	e9 8f f5 ff ff       	jmp    8010653a <alltraps>

80106fab <vector151>:
80106fab:	6a 00                	push   $0x0
80106fad:	68 97 00 00 00       	push   $0x97
80106fb2:	e9 83 f5 ff ff       	jmp    8010653a <alltraps>

80106fb7 <vector152>:
80106fb7:	6a 00                	push   $0x0
80106fb9:	68 98 00 00 00       	push   $0x98
80106fbe:	e9 77 f5 ff ff       	jmp    8010653a <alltraps>

80106fc3 <vector153>:
80106fc3:	6a 00                	push   $0x0
80106fc5:	68 99 00 00 00       	push   $0x99
80106fca:	e9 6b f5 ff ff       	jmp    8010653a <alltraps>

80106fcf <vector154>:
80106fcf:	6a 00                	push   $0x0
80106fd1:	68 9a 00 00 00       	push   $0x9a
80106fd6:	e9 5f f5 ff ff       	jmp    8010653a <alltraps>

80106fdb <vector155>:
80106fdb:	6a 00                	push   $0x0
80106fdd:	68 9b 00 00 00       	push   $0x9b
80106fe2:	e9 53 f5 ff ff       	jmp    8010653a <alltraps>

80106fe7 <vector156>:
80106fe7:	6a 00                	push   $0x0
80106fe9:	68 9c 00 00 00       	push   $0x9c
80106fee:	e9 47 f5 ff ff       	jmp    8010653a <alltraps>

80106ff3 <vector157>:
80106ff3:	6a 00                	push   $0x0
80106ff5:	68 9d 00 00 00       	push   $0x9d
80106ffa:	e9 3b f5 ff ff       	jmp    8010653a <alltraps>

80106fff <vector158>:
80106fff:	6a 00                	push   $0x0
80107001:	68 9e 00 00 00       	push   $0x9e
80107006:	e9 2f f5 ff ff       	jmp    8010653a <alltraps>

8010700b <vector159>:
8010700b:	6a 00                	push   $0x0
8010700d:	68 9f 00 00 00       	push   $0x9f
80107012:	e9 23 f5 ff ff       	jmp    8010653a <alltraps>

80107017 <vector160>:
80107017:	6a 00                	push   $0x0
80107019:	68 a0 00 00 00       	push   $0xa0
8010701e:	e9 17 f5 ff ff       	jmp    8010653a <alltraps>

80107023 <vector161>:
80107023:	6a 00                	push   $0x0
80107025:	68 a1 00 00 00       	push   $0xa1
8010702a:	e9 0b f5 ff ff       	jmp    8010653a <alltraps>

8010702f <vector162>:
8010702f:	6a 00                	push   $0x0
80107031:	68 a2 00 00 00       	push   $0xa2
80107036:	e9 ff f4 ff ff       	jmp    8010653a <alltraps>

8010703b <vector163>:
8010703b:	6a 00                	push   $0x0
8010703d:	68 a3 00 00 00       	push   $0xa3
80107042:	e9 f3 f4 ff ff       	jmp    8010653a <alltraps>

80107047 <vector164>:
80107047:	6a 00                	push   $0x0
80107049:	68 a4 00 00 00       	push   $0xa4
8010704e:	e9 e7 f4 ff ff       	jmp    8010653a <alltraps>

80107053 <vector165>:
80107053:	6a 00                	push   $0x0
80107055:	68 a5 00 00 00       	push   $0xa5
8010705a:	e9 db f4 ff ff       	jmp    8010653a <alltraps>

8010705f <vector166>:
8010705f:	6a 00                	push   $0x0
80107061:	68 a6 00 00 00       	push   $0xa6
80107066:	e9 cf f4 ff ff       	jmp    8010653a <alltraps>

8010706b <vector167>:
8010706b:	6a 00                	push   $0x0
8010706d:	68 a7 00 00 00       	push   $0xa7
80107072:	e9 c3 f4 ff ff       	jmp    8010653a <alltraps>

80107077 <vector168>:
80107077:	6a 00                	push   $0x0
80107079:	68 a8 00 00 00       	push   $0xa8
8010707e:	e9 b7 f4 ff ff       	jmp    8010653a <alltraps>

80107083 <vector169>:
80107083:	6a 00                	push   $0x0
80107085:	68 a9 00 00 00       	push   $0xa9
8010708a:	e9 ab f4 ff ff       	jmp    8010653a <alltraps>

8010708f <vector170>:
8010708f:	6a 00                	push   $0x0
80107091:	68 aa 00 00 00       	push   $0xaa
80107096:	e9 9f f4 ff ff       	jmp    8010653a <alltraps>

8010709b <vector171>:
8010709b:	6a 00                	push   $0x0
8010709d:	68 ab 00 00 00       	push   $0xab
801070a2:	e9 93 f4 ff ff       	jmp    8010653a <alltraps>

801070a7 <vector172>:
801070a7:	6a 00                	push   $0x0
801070a9:	68 ac 00 00 00       	push   $0xac
801070ae:	e9 87 f4 ff ff       	jmp    8010653a <alltraps>

801070b3 <vector173>:
801070b3:	6a 00                	push   $0x0
801070b5:	68 ad 00 00 00       	push   $0xad
801070ba:	e9 7b f4 ff ff       	jmp    8010653a <alltraps>

801070bf <vector174>:
801070bf:	6a 00                	push   $0x0
801070c1:	68 ae 00 00 00       	push   $0xae
801070c6:	e9 6f f4 ff ff       	jmp    8010653a <alltraps>

801070cb <vector175>:
801070cb:	6a 00                	push   $0x0
801070cd:	68 af 00 00 00       	push   $0xaf
801070d2:	e9 63 f4 ff ff       	jmp    8010653a <alltraps>

801070d7 <vector176>:
801070d7:	6a 00                	push   $0x0
801070d9:	68 b0 00 00 00       	push   $0xb0
801070de:	e9 57 f4 ff ff       	jmp    8010653a <alltraps>

801070e3 <vector177>:
801070e3:	6a 00                	push   $0x0
801070e5:	68 b1 00 00 00       	push   $0xb1
801070ea:	e9 4b f4 ff ff       	jmp    8010653a <alltraps>

801070ef <vector178>:
801070ef:	6a 00                	push   $0x0
801070f1:	68 b2 00 00 00       	push   $0xb2
801070f6:	e9 3f f4 ff ff       	jmp    8010653a <alltraps>

801070fb <vector179>:
801070fb:	6a 00                	push   $0x0
801070fd:	68 b3 00 00 00       	push   $0xb3
80107102:	e9 33 f4 ff ff       	jmp    8010653a <alltraps>

80107107 <vector180>:
80107107:	6a 00                	push   $0x0
80107109:	68 b4 00 00 00       	push   $0xb4
8010710e:	e9 27 f4 ff ff       	jmp    8010653a <alltraps>

80107113 <vector181>:
80107113:	6a 00                	push   $0x0
80107115:	68 b5 00 00 00       	push   $0xb5
8010711a:	e9 1b f4 ff ff       	jmp    8010653a <alltraps>

8010711f <vector182>:
8010711f:	6a 00                	push   $0x0
80107121:	68 b6 00 00 00       	push   $0xb6
80107126:	e9 0f f4 ff ff       	jmp    8010653a <alltraps>

8010712b <vector183>:
8010712b:	6a 00                	push   $0x0
8010712d:	68 b7 00 00 00       	push   $0xb7
80107132:	e9 03 f4 ff ff       	jmp    8010653a <alltraps>

80107137 <vector184>:
80107137:	6a 00                	push   $0x0
80107139:	68 b8 00 00 00       	push   $0xb8
8010713e:	e9 f7 f3 ff ff       	jmp    8010653a <alltraps>

80107143 <vector185>:
80107143:	6a 00                	push   $0x0
80107145:	68 b9 00 00 00       	push   $0xb9
8010714a:	e9 eb f3 ff ff       	jmp    8010653a <alltraps>

8010714f <vector186>:
8010714f:	6a 00                	push   $0x0
80107151:	68 ba 00 00 00       	push   $0xba
80107156:	e9 df f3 ff ff       	jmp    8010653a <alltraps>

8010715b <vector187>:
8010715b:	6a 00                	push   $0x0
8010715d:	68 bb 00 00 00       	push   $0xbb
80107162:	e9 d3 f3 ff ff       	jmp    8010653a <alltraps>

80107167 <vector188>:
80107167:	6a 00                	push   $0x0
80107169:	68 bc 00 00 00       	push   $0xbc
8010716e:	e9 c7 f3 ff ff       	jmp    8010653a <alltraps>

80107173 <vector189>:
80107173:	6a 00                	push   $0x0
80107175:	68 bd 00 00 00       	push   $0xbd
8010717a:	e9 bb f3 ff ff       	jmp    8010653a <alltraps>

8010717f <vector190>:
8010717f:	6a 00                	push   $0x0
80107181:	68 be 00 00 00       	push   $0xbe
80107186:	e9 af f3 ff ff       	jmp    8010653a <alltraps>

8010718b <vector191>:
8010718b:	6a 00                	push   $0x0
8010718d:	68 bf 00 00 00       	push   $0xbf
80107192:	e9 a3 f3 ff ff       	jmp    8010653a <alltraps>

80107197 <vector192>:
80107197:	6a 00                	push   $0x0
80107199:	68 c0 00 00 00       	push   $0xc0
8010719e:	e9 97 f3 ff ff       	jmp    8010653a <alltraps>

801071a3 <vector193>:
801071a3:	6a 00                	push   $0x0
801071a5:	68 c1 00 00 00       	push   $0xc1
801071aa:	e9 8b f3 ff ff       	jmp    8010653a <alltraps>

801071af <vector194>:
801071af:	6a 00                	push   $0x0
801071b1:	68 c2 00 00 00       	push   $0xc2
801071b6:	e9 7f f3 ff ff       	jmp    8010653a <alltraps>

801071bb <vector195>:
801071bb:	6a 00                	push   $0x0
801071bd:	68 c3 00 00 00       	push   $0xc3
801071c2:	e9 73 f3 ff ff       	jmp    8010653a <alltraps>

801071c7 <vector196>:
801071c7:	6a 00                	push   $0x0
801071c9:	68 c4 00 00 00       	push   $0xc4
801071ce:	e9 67 f3 ff ff       	jmp    8010653a <alltraps>

801071d3 <vector197>:
801071d3:	6a 00                	push   $0x0
801071d5:	68 c5 00 00 00       	push   $0xc5
801071da:	e9 5b f3 ff ff       	jmp    8010653a <alltraps>

801071df <vector198>:
801071df:	6a 00                	push   $0x0
801071e1:	68 c6 00 00 00       	push   $0xc6
801071e6:	e9 4f f3 ff ff       	jmp    8010653a <alltraps>

801071eb <vector199>:
801071eb:	6a 00                	push   $0x0
801071ed:	68 c7 00 00 00       	push   $0xc7
801071f2:	e9 43 f3 ff ff       	jmp    8010653a <alltraps>

801071f7 <vector200>:
801071f7:	6a 00                	push   $0x0
801071f9:	68 c8 00 00 00       	push   $0xc8
801071fe:	e9 37 f3 ff ff       	jmp    8010653a <alltraps>

80107203 <vector201>:
80107203:	6a 00                	push   $0x0
80107205:	68 c9 00 00 00       	push   $0xc9
8010720a:	e9 2b f3 ff ff       	jmp    8010653a <alltraps>

8010720f <vector202>:
8010720f:	6a 00                	push   $0x0
80107211:	68 ca 00 00 00       	push   $0xca
80107216:	e9 1f f3 ff ff       	jmp    8010653a <alltraps>

8010721b <vector203>:
8010721b:	6a 00                	push   $0x0
8010721d:	68 cb 00 00 00       	push   $0xcb
80107222:	e9 13 f3 ff ff       	jmp    8010653a <alltraps>

80107227 <vector204>:
80107227:	6a 00                	push   $0x0
80107229:	68 cc 00 00 00       	push   $0xcc
8010722e:	e9 07 f3 ff ff       	jmp    8010653a <alltraps>

80107233 <vector205>:
80107233:	6a 00                	push   $0x0
80107235:	68 cd 00 00 00       	push   $0xcd
8010723a:	e9 fb f2 ff ff       	jmp    8010653a <alltraps>

8010723f <vector206>:
8010723f:	6a 00                	push   $0x0
80107241:	68 ce 00 00 00       	push   $0xce
80107246:	e9 ef f2 ff ff       	jmp    8010653a <alltraps>

8010724b <vector207>:
8010724b:	6a 00                	push   $0x0
8010724d:	68 cf 00 00 00       	push   $0xcf
80107252:	e9 e3 f2 ff ff       	jmp    8010653a <alltraps>

80107257 <vector208>:
80107257:	6a 00                	push   $0x0
80107259:	68 d0 00 00 00       	push   $0xd0
8010725e:	e9 d7 f2 ff ff       	jmp    8010653a <alltraps>

80107263 <vector209>:
80107263:	6a 00                	push   $0x0
80107265:	68 d1 00 00 00       	push   $0xd1
8010726a:	e9 cb f2 ff ff       	jmp    8010653a <alltraps>

8010726f <vector210>:
8010726f:	6a 00                	push   $0x0
80107271:	68 d2 00 00 00       	push   $0xd2
80107276:	e9 bf f2 ff ff       	jmp    8010653a <alltraps>

8010727b <vector211>:
8010727b:	6a 00                	push   $0x0
8010727d:	68 d3 00 00 00       	push   $0xd3
80107282:	e9 b3 f2 ff ff       	jmp    8010653a <alltraps>

80107287 <vector212>:
80107287:	6a 00                	push   $0x0
80107289:	68 d4 00 00 00       	push   $0xd4
8010728e:	e9 a7 f2 ff ff       	jmp    8010653a <alltraps>

80107293 <vector213>:
80107293:	6a 00                	push   $0x0
80107295:	68 d5 00 00 00       	push   $0xd5
8010729a:	e9 9b f2 ff ff       	jmp    8010653a <alltraps>

8010729f <vector214>:
8010729f:	6a 00                	push   $0x0
801072a1:	68 d6 00 00 00       	push   $0xd6
801072a6:	e9 8f f2 ff ff       	jmp    8010653a <alltraps>

801072ab <vector215>:
801072ab:	6a 00                	push   $0x0
801072ad:	68 d7 00 00 00       	push   $0xd7
801072b2:	e9 83 f2 ff ff       	jmp    8010653a <alltraps>

801072b7 <vector216>:
801072b7:	6a 00                	push   $0x0
801072b9:	68 d8 00 00 00       	push   $0xd8
801072be:	e9 77 f2 ff ff       	jmp    8010653a <alltraps>

801072c3 <vector217>:
801072c3:	6a 00                	push   $0x0
801072c5:	68 d9 00 00 00       	push   $0xd9
801072ca:	e9 6b f2 ff ff       	jmp    8010653a <alltraps>

801072cf <vector218>:
801072cf:	6a 00                	push   $0x0
801072d1:	68 da 00 00 00       	push   $0xda
801072d6:	e9 5f f2 ff ff       	jmp    8010653a <alltraps>

801072db <vector219>:
801072db:	6a 00                	push   $0x0
801072dd:	68 db 00 00 00       	push   $0xdb
801072e2:	e9 53 f2 ff ff       	jmp    8010653a <alltraps>

801072e7 <vector220>:
801072e7:	6a 00                	push   $0x0
801072e9:	68 dc 00 00 00       	push   $0xdc
801072ee:	e9 47 f2 ff ff       	jmp    8010653a <alltraps>

801072f3 <vector221>:
801072f3:	6a 00                	push   $0x0
801072f5:	68 dd 00 00 00       	push   $0xdd
801072fa:	e9 3b f2 ff ff       	jmp    8010653a <alltraps>

801072ff <vector222>:
801072ff:	6a 00                	push   $0x0
80107301:	68 de 00 00 00       	push   $0xde
80107306:	e9 2f f2 ff ff       	jmp    8010653a <alltraps>

8010730b <vector223>:
8010730b:	6a 00                	push   $0x0
8010730d:	68 df 00 00 00       	push   $0xdf
80107312:	e9 23 f2 ff ff       	jmp    8010653a <alltraps>

80107317 <vector224>:
80107317:	6a 00                	push   $0x0
80107319:	68 e0 00 00 00       	push   $0xe0
8010731e:	e9 17 f2 ff ff       	jmp    8010653a <alltraps>

80107323 <vector225>:
80107323:	6a 00                	push   $0x0
80107325:	68 e1 00 00 00       	push   $0xe1
8010732a:	e9 0b f2 ff ff       	jmp    8010653a <alltraps>

8010732f <vector226>:
8010732f:	6a 00                	push   $0x0
80107331:	68 e2 00 00 00       	push   $0xe2
80107336:	e9 ff f1 ff ff       	jmp    8010653a <alltraps>

8010733b <vector227>:
8010733b:	6a 00                	push   $0x0
8010733d:	68 e3 00 00 00       	push   $0xe3
80107342:	e9 f3 f1 ff ff       	jmp    8010653a <alltraps>

80107347 <vector228>:
80107347:	6a 00                	push   $0x0
80107349:	68 e4 00 00 00       	push   $0xe4
8010734e:	e9 e7 f1 ff ff       	jmp    8010653a <alltraps>

80107353 <vector229>:
80107353:	6a 00                	push   $0x0
80107355:	68 e5 00 00 00       	push   $0xe5
8010735a:	e9 db f1 ff ff       	jmp    8010653a <alltraps>

8010735f <vector230>:
8010735f:	6a 00                	push   $0x0
80107361:	68 e6 00 00 00       	push   $0xe6
80107366:	e9 cf f1 ff ff       	jmp    8010653a <alltraps>

8010736b <vector231>:
8010736b:	6a 00                	push   $0x0
8010736d:	68 e7 00 00 00       	push   $0xe7
80107372:	e9 c3 f1 ff ff       	jmp    8010653a <alltraps>

80107377 <vector232>:
80107377:	6a 00                	push   $0x0
80107379:	68 e8 00 00 00       	push   $0xe8
8010737e:	e9 b7 f1 ff ff       	jmp    8010653a <alltraps>

80107383 <vector233>:
80107383:	6a 00                	push   $0x0
80107385:	68 e9 00 00 00       	push   $0xe9
8010738a:	e9 ab f1 ff ff       	jmp    8010653a <alltraps>

8010738f <vector234>:
8010738f:	6a 00                	push   $0x0
80107391:	68 ea 00 00 00       	push   $0xea
80107396:	e9 9f f1 ff ff       	jmp    8010653a <alltraps>

8010739b <vector235>:
8010739b:	6a 00                	push   $0x0
8010739d:	68 eb 00 00 00       	push   $0xeb
801073a2:	e9 93 f1 ff ff       	jmp    8010653a <alltraps>

801073a7 <vector236>:
801073a7:	6a 00                	push   $0x0
801073a9:	68 ec 00 00 00       	push   $0xec
801073ae:	e9 87 f1 ff ff       	jmp    8010653a <alltraps>

801073b3 <vector237>:
801073b3:	6a 00                	push   $0x0
801073b5:	68 ed 00 00 00       	push   $0xed
801073ba:	e9 7b f1 ff ff       	jmp    8010653a <alltraps>

801073bf <vector238>:
801073bf:	6a 00                	push   $0x0
801073c1:	68 ee 00 00 00       	push   $0xee
801073c6:	e9 6f f1 ff ff       	jmp    8010653a <alltraps>

801073cb <vector239>:
801073cb:	6a 00                	push   $0x0
801073cd:	68 ef 00 00 00       	push   $0xef
801073d2:	e9 63 f1 ff ff       	jmp    8010653a <alltraps>

801073d7 <vector240>:
801073d7:	6a 00                	push   $0x0
801073d9:	68 f0 00 00 00       	push   $0xf0
801073de:	e9 57 f1 ff ff       	jmp    8010653a <alltraps>

801073e3 <vector241>:
801073e3:	6a 00                	push   $0x0
801073e5:	68 f1 00 00 00       	push   $0xf1
801073ea:	e9 4b f1 ff ff       	jmp    8010653a <alltraps>

801073ef <vector242>:
801073ef:	6a 00                	push   $0x0
801073f1:	68 f2 00 00 00       	push   $0xf2
801073f6:	e9 3f f1 ff ff       	jmp    8010653a <alltraps>

801073fb <vector243>:
801073fb:	6a 00                	push   $0x0
801073fd:	68 f3 00 00 00       	push   $0xf3
80107402:	e9 33 f1 ff ff       	jmp    8010653a <alltraps>

80107407 <vector244>:
80107407:	6a 00                	push   $0x0
80107409:	68 f4 00 00 00       	push   $0xf4
8010740e:	e9 27 f1 ff ff       	jmp    8010653a <alltraps>

80107413 <vector245>:
80107413:	6a 00                	push   $0x0
80107415:	68 f5 00 00 00       	push   $0xf5
8010741a:	e9 1b f1 ff ff       	jmp    8010653a <alltraps>

8010741f <vector246>:
8010741f:	6a 00                	push   $0x0
80107421:	68 f6 00 00 00       	push   $0xf6
80107426:	e9 0f f1 ff ff       	jmp    8010653a <alltraps>

8010742b <vector247>:
8010742b:	6a 00                	push   $0x0
8010742d:	68 f7 00 00 00       	push   $0xf7
80107432:	e9 03 f1 ff ff       	jmp    8010653a <alltraps>

80107437 <vector248>:
80107437:	6a 00                	push   $0x0
80107439:	68 f8 00 00 00       	push   $0xf8
8010743e:	e9 f7 f0 ff ff       	jmp    8010653a <alltraps>

80107443 <vector249>:
80107443:	6a 00                	push   $0x0
80107445:	68 f9 00 00 00       	push   $0xf9
8010744a:	e9 eb f0 ff ff       	jmp    8010653a <alltraps>

8010744f <vector250>:
8010744f:	6a 00                	push   $0x0
80107451:	68 fa 00 00 00       	push   $0xfa
80107456:	e9 df f0 ff ff       	jmp    8010653a <alltraps>

8010745b <vector251>:
8010745b:	6a 00                	push   $0x0
8010745d:	68 fb 00 00 00       	push   $0xfb
80107462:	e9 d3 f0 ff ff       	jmp    8010653a <alltraps>

80107467 <vector252>:
80107467:	6a 00                	push   $0x0
80107469:	68 fc 00 00 00       	push   $0xfc
8010746e:	e9 c7 f0 ff ff       	jmp    8010653a <alltraps>

80107473 <vector253>:
80107473:	6a 00                	push   $0x0
80107475:	68 fd 00 00 00       	push   $0xfd
8010747a:	e9 bb f0 ff ff       	jmp    8010653a <alltraps>

8010747f <vector254>:
8010747f:	6a 00                	push   $0x0
80107481:	68 fe 00 00 00       	push   $0xfe
80107486:	e9 af f0 ff ff       	jmp    8010653a <alltraps>

8010748b <vector255>:
8010748b:	6a 00                	push   $0x0
8010748d:	68 ff 00 00 00       	push   $0xff
80107492:	e9 a3 f0 ff ff       	jmp    8010653a <alltraps>
80107497:	66 90                	xchg   %ax,%ax
80107499:	66 90                	xchg   %ax,%ax
8010749b:	66 90                	xchg   %ax,%ax
8010749d:	66 90                	xchg   %ax,%ax
8010749f:	90                   	nop

801074a0 <deallocuvm.part.0>:
801074a0:	55                   	push   %ebp
801074a1:	89 e5                	mov    %esp,%ebp
801074a3:	57                   	push   %edi
801074a4:	56                   	push   %esi
801074a5:	53                   	push   %ebx
801074a6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801074ac:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801074b2:	83 ec 1c             	sub    $0x1c,%esp
801074b5:	39 d3                	cmp    %edx,%ebx
801074b7:	73 56                	jae    8010750f <deallocuvm.part.0+0x6f>
801074b9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801074bc:	89 c6                	mov    %eax,%esi
801074be:	89 d7                	mov    %edx,%edi
801074c0:	eb 12                	jmp    801074d4 <deallocuvm.part.0+0x34>
801074c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801074c8:	83 c2 01             	add    $0x1,%edx
801074cb:	89 d3                	mov    %edx,%ebx
801074cd:	c1 e3 16             	shl    $0x16,%ebx
801074d0:	39 fb                	cmp    %edi,%ebx
801074d2:	73 38                	jae    8010750c <deallocuvm.part.0+0x6c>
801074d4:	89 da                	mov    %ebx,%edx
801074d6:	c1 ea 16             	shr    $0x16,%edx
801074d9:	8b 04 96             	mov    (%esi,%edx,4),%eax
801074dc:	a8 01                	test   $0x1,%al
801074de:	74 e8                	je     801074c8 <deallocuvm.part.0+0x28>
801074e0:	89 d9                	mov    %ebx,%ecx
801074e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801074e7:	c1 e9 0a             	shr    $0xa,%ecx
801074ea:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
801074f0:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
801074f7:	85 c0                	test   %eax,%eax
801074f9:	74 cd                	je     801074c8 <deallocuvm.part.0+0x28>
801074fb:	8b 10                	mov    (%eax),%edx
801074fd:	f6 c2 01             	test   $0x1,%dl
80107500:	75 1e                	jne    80107520 <deallocuvm.part.0+0x80>
80107502:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107508:	39 fb                	cmp    %edi,%ebx
8010750a:	72 c8                	jb     801074d4 <deallocuvm.part.0+0x34>
8010750c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010750f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107512:	89 c8                	mov    %ecx,%eax
80107514:	5b                   	pop    %ebx
80107515:	5e                   	pop    %esi
80107516:	5f                   	pop    %edi
80107517:	5d                   	pop    %ebp
80107518:	c3                   	ret
80107519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107520:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107526:	74 26                	je     8010754e <deallocuvm.part.0+0xae>
80107528:	83 ec 0c             	sub    $0xc,%esp
8010752b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107531:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107534:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010753a:	52                   	push   %edx
8010753b:	e8 60 bc ff ff       	call   801031a0 <kfree>
80107540:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107543:	83 c4 10             	add    $0x10,%esp
80107546:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010754c:	eb 82                	jmp    801074d0 <deallocuvm.part.0+0x30>
8010754e:	83 ec 0c             	sub    $0xc,%esp
80107551:	68 2e 80 10 80       	push   $0x8010802e
80107556:	e8 35 95 ff ff       	call   80100a90 <panic>
8010755b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107560 <mappages>:
80107560:	55                   	push   %ebp
80107561:	89 e5                	mov    %esp,%ebp
80107563:	57                   	push   %edi
80107564:	56                   	push   %esi
80107565:	53                   	push   %ebx
80107566:	89 d3                	mov    %edx,%ebx
80107568:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010756e:	83 ec 1c             	sub    $0x1c,%esp
80107571:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107574:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107578:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010757d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107580:	8b 45 08             	mov    0x8(%ebp),%eax
80107583:	29 d8                	sub    %ebx,%eax
80107585:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107588:	eb 3f                	jmp    801075c9 <mappages+0x69>
8010758a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107590:	89 da                	mov    %ebx,%edx
80107592:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107597:	c1 ea 0a             	shr    $0xa,%edx
8010759a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801075a0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
801075a7:	85 c0                	test   %eax,%eax
801075a9:	74 75                	je     80107620 <mappages+0xc0>
801075ab:	f6 00 01             	testb  $0x1,(%eax)
801075ae:	0f 85 86 00 00 00    	jne    8010763a <mappages+0xda>
801075b4:	0b 75 0c             	or     0xc(%ebp),%esi
801075b7:	83 ce 01             	or     $0x1,%esi
801075ba:	89 30                	mov    %esi,(%eax)
801075bc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801075bf:	39 c3                	cmp    %eax,%ebx
801075c1:	74 6d                	je     80107630 <mappages+0xd0>
801075c3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801075c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801075cc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801075cf:	8d 34 03             	lea    (%ebx,%eax,1),%esi
801075d2:	89 d8                	mov    %ebx,%eax
801075d4:	c1 e8 16             	shr    $0x16,%eax
801075d7:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
801075da:	8b 07                	mov    (%edi),%eax
801075dc:	a8 01                	test   $0x1,%al
801075de:	75 b0                	jne    80107590 <mappages+0x30>
801075e0:	e8 7b bd ff ff       	call   80103360 <kalloc>
801075e5:	85 c0                	test   %eax,%eax
801075e7:	74 37                	je     80107620 <mappages+0xc0>
801075e9:	83 ec 04             	sub    $0x4,%esp
801075ec:	68 00 10 00 00       	push   $0x1000
801075f1:	6a 00                	push   $0x0
801075f3:	50                   	push   %eax
801075f4:	89 45 d8             	mov    %eax,-0x28(%ebp)
801075f7:	e8 a4 dd ff ff       	call   801053a0 <memset>
801075fc:	8b 55 d8             	mov    -0x28(%ebp),%edx
801075ff:	83 c4 10             	add    $0x10,%esp
80107602:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107608:	83 c8 07             	or     $0x7,%eax
8010760b:	89 07                	mov    %eax,(%edi)
8010760d:	89 d8                	mov    %ebx,%eax
8010760f:	c1 e8 0a             	shr    $0xa,%eax
80107612:	25 fc 0f 00 00       	and    $0xffc,%eax
80107617:	01 d0                	add    %edx,%eax
80107619:	eb 90                	jmp    801075ab <mappages+0x4b>
8010761b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80107620:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107623:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107628:	5b                   	pop    %ebx
80107629:	5e                   	pop    %esi
8010762a:	5f                   	pop    %edi
8010762b:	5d                   	pop    %ebp
8010762c:	c3                   	ret
8010762d:	8d 76 00             	lea    0x0(%esi),%esi
80107630:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107633:	31 c0                	xor    %eax,%eax
80107635:	5b                   	pop    %ebx
80107636:	5e                   	pop    %esi
80107637:	5f                   	pop    %edi
80107638:	5d                   	pop    %ebp
80107639:	c3                   	ret
8010763a:	83 ec 0c             	sub    $0xc,%esp
8010763d:	68 62 82 10 80       	push   $0x80108262
80107642:	e8 49 94 ff ff       	call   80100a90 <panic>
80107647:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010764e:	00 
8010764f:	90                   	nop

80107650 <seginit>:
80107650:	55                   	push   %ebp
80107651:	89 e5                	mov    %esp,%ebp
80107653:	83 ec 18             	sub    $0x18,%esp
80107656:	e8 e5 cf ff ff       	call   80104640 <cpuid>
8010765b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107660:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107666:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
8010766a:	c7 80 38 28 11 80 ff 	movl   $0xffff,-0x7feed7c8(%eax)
80107671:	ff 00 00 
80107674:	c7 80 3c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7c4(%eax)
8010767b:	9a cf 00 
8010767e:	c7 80 40 28 11 80 ff 	movl   $0xffff,-0x7feed7c0(%eax)
80107685:	ff 00 00 
80107688:	c7 80 44 28 11 80 00 	movl   $0xcf9200,-0x7feed7bc(%eax)
8010768f:	92 cf 00 
80107692:	c7 80 48 28 11 80 ff 	movl   $0xffff,-0x7feed7b8(%eax)
80107699:	ff 00 00 
8010769c:	c7 80 4c 28 11 80 00 	movl   $0xcffa00,-0x7feed7b4(%eax)
801076a3:	fa cf 00 
801076a6:	c7 80 50 28 11 80 ff 	movl   $0xffff,-0x7feed7b0(%eax)
801076ad:	ff 00 00 
801076b0:	c7 80 54 28 11 80 00 	movl   $0xcff200,-0x7feed7ac(%eax)
801076b7:	f2 cf 00 
801076ba:	05 30 28 11 80       	add    $0x80112830,%eax
801076bf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
801076c3:	c1 e8 10             	shr    $0x10,%eax
801076c6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
801076ca:	8d 45 f2             	lea    -0xe(%ebp),%eax
801076cd:	0f 01 10             	lgdtl  (%eax)
801076d0:	c9                   	leave
801076d1:	c3                   	ret
801076d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801076d9:	00 
801076da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801076e0 <switchkvm>:
801076e0:	a1 e4 54 11 80       	mov    0x801154e4,%eax
801076e5:	05 00 00 00 80       	add    $0x80000000,%eax
801076ea:	0f 22 d8             	mov    %eax,%cr3
801076ed:	c3                   	ret
801076ee:	66 90                	xchg   %ax,%ax

801076f0 <switchuvm>:
801076f0:	55                   	push   %ebp
801076f1:	89 e5                	mov    %esp,%ebp
801076f3:	57                   	push   %edi
801076f4:	56                   	push   %esi
801076f5:	53                   	push   %ebx
801076f6:	83 ec 1c             	sub    $0x1c,%esp
801076f9:	8b 75 08             	mov    0x8(%ebp),%esi
801076fc:	85 f6                	test   %esi,%esi
801076fe:	0f 84 cb 00 00 00    	je     801077cf <switchuvm+0xdf>
80107704:	8b 46 08             	mov    0x8(%esi),%eax
80107707:	85 c0                	test   %eax,%eax
80107709:	0f 84 da 00 00 00    	je     801077e9 <switchuvm+0xf9>
8010770f:	8b 46 04             	mov    0x4(%esi),%eax
80107712:	85 c0                	test   %eax,%eax
80107714:	0f 84 c2 00 00 00    	je     801077dc <switchuvm+0xec>
8010771a:	e8 31 da ff ff       	call   80105150 <pushcli>
8010771f:	e8 bc ce ff ff       	call   801045e0 <mycpu>
80107724:	89 c3                	mov    %eax,%ebx
80107726:	e8 b5 ce ff ff       	call   801045e0 <mycpu>
8010772b:	89 c7                	mov    %eax,%edi
8010772d:	e8 ae ce ff ff       	call   801045e0 <mycpu>
80107732:	83 c7 08             	add    $0x8,%edi
80107735:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107738:	e8 a3 ce ff ff       	call   801045e0 <mycpu>
8010773d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107740:	ba 67 00 00 00       	mov    $0x67,%edx
80107745:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010774c:	83 c0 08             	add    $0x8,%eax
8010774f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107756:	bf ff ff ff ff       	mov    $0xffffffff,%edi
8010775b:	83 c1 08             	add    $0x8,%ecx
8010775e:	c1 e8 18             	shr    $0x18,%eax
80107761:	c1 e9 10             	shr    $0x10,%ecx
80107764:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010776a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107770:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107775:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
8010777c:	bb 10 00 00 00       	mov    $0x10,%ebx
80107781:	e8 5a ce ff ff       	call   801045e0 <mycpu>
80107786:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
8010778d:	e8 4e ce ff ff       	call   801045e0 <mycpu>
80107792:	66 89 58 10          	mov    %bx,0x10(%eax)
80107796:	8b 5e 08             	mov    0x8(%esi),%ebx
80107799:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010779f:	e8 3c ce ff ff       	call   801045e0 <mycpu>
801077a4:	89 58 0c             	mov    %ebx,0xc(%eax)
801077a7:	e8 34 ce ff ff       	call   801045e0 <mycpu>
801077ac:	66 89 78 6e          	mov    %di,0x6e(%eax)
801077b0:	b8 28 00 00 00       	mov    $0x28,%eax
801077b5:	0f 00 d8             	ltr    %eax
801077b8:	8b 46 04             	mov    0x4(%esi),%eax
801077bb:	05 00 00 00 80       	add    $0x80000000,%eax
801077c0:	0f 22 d8             	mov    %eax,%cr3
801077c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077c6:	5b                   	pop    %ebx
801077c7:	5e                   	pop    %esi
801077c8:	5f                   	pop    %edi
801077c9:	5d                   	pop    %ebp
801077ca:	e9 d1 d9 ff ff       	jmp    801051a0 <popcli>
801077cf:	83 ec 0c             	sub    $0xc,%esp
801077d2:	68 68 82 10 80       	push   $0x80108268
801077d7:	e8 b4 92 ff ff       	call   80100a90 <panic>
801077dc:	83 ec 0c             	sub    $0xc,%esp
801077df:	68 93 82 10 80       	push   $0x80108293
801077e4:	e8 a7 92 ff ff       	call   80100a90 <panic>
801077e9:	83 ec 0c             	sub    $0xc,%esp
801077ec:	68 7e 82 10 80       	push   $0x8010827e
801077f1:	e8 9a 92 ff ff       	call   80100a90 <panic>
801077f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801077fd:	00 
801077fe:	66 90                	xchg   %ax,%ax

80107800 <inituvm>:
80107800:	55                   	push   %ebp
80107801:	89 e5                	mov    %esp,%ebp
80107803:	57                   	push   %edi
80107804:	56                   	push   %esi
80107805:	53                   	push   %ebx
80107806:	83 ec 1c             	sub    $0x1c,%esp
80107809:	8b 45 08             	mov    0x8(%ebp),%eax
8010780c:	8b 75 10             	mov    0x10(%ebp),%esi
8010780f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107812:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107815:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010781b:	77 49                	ja     80107866 <inituvm+0x66>
8010781d:	e8 3e bb ff ff       	call   80103360 <kalloc>
80107822:	83 ec 04             	sub    $0x4,%esp
80107825:	68 00 10 00 00       	push   $0x1000
8010782a:	89 c3                	mov    %eax,%ebx
8010782c:	6a 00                	push   $0x0
8010782e:	50                   	push   %eax
8010782f:	e8 6c db ff ff       	call   801053a0 <memset>
80107834:	58                   	pop    %eax
80107835:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010783b:	5a                   	pop    %edx
8010783c:	6a 06                	push   $0x6
8010783e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107843:	31 d2                	xor    %edx,%edx
80107845:	50                   	push   %eax
80107846:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107849:	e8 12 fd ff ff       	call   80107560 <mappages>
8010784e:	83 c4 10             	add    $0x10,%esp
80107851:	89 75 10             	mov    %esi,0x10(%ebp)
80107854:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107857:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010785a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010785d:	5b                   	pop    %ebx
8010785e:	5e                   	pop    %esi
8010785f:	5f                   	pop    %edi
80107860:	5d                   	pop    %ebp
80107861:	e9 ca db ff ff       	jmp    80105430 <memmove>
80107866:	83 ec 0c             	sub    $0xc,%esp
80107869:	68 a7 82 10 80       	push   $0x801082a7
8010786e:	e8 1d 92 ff ff       	call   80100a90 <panic>
80107873:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010787a:	00 
8010787b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107880 <loaduvm>:
80107880:	55                   	push   %ebp
80107881:	89 e5                	mov    %esp,%ebp
80107883:	57                   	push   %edi
80107884:	56                   	push   %esi
80107885:	53                   	push   %ebx
80107886:	83 ec 0c             	sub    $0xc,%esp
80107889:	8b 75 0c             	mov    0xc(%ebp),%esi
8010788c:	8b 7d 18             	mov    0x18(%ebp),%edi
8010788f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107895:	0f 85 a2 00 00 00    	jne    8010793d <loaduvm+0xbd>
8010789b:	85 ff                	test   %edi,%edi
8010789d:	74 7d                	je     8010791c <loaduvm+0x9c>
8010789f:	90                   	nop
801078a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801078a3:	8b 55 08             	mov    0x8(%ebp),%edx
801078a6:	01 f0                	add    %esi,%eax
801078a8:	89 c1                	mov    %eax,%ecx
801078aa:	c1 e9 16             	shr    $0x16,%ecx
801078ad:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
801078b0:	f6 c1 01             	test   $0x1,%cl
801078b3:	75 13                	jne    801078c8 <loaduvm+0x48>
801078b5:	83 ec 0c             	sub    $0xc,%esp
801078b8:	68 c1 82 10 80       	push   $0x801082c1
801078bd:	e8 ce 91 ff ff       	call   80100a90 <panic>
801078c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801078c8:	c1 e8 0a             	shr    $0xa,%eax
801078cb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
801078d1:	25 fc 0f 00 00       	and    $0xffc,%eax
801078d6:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
801078dd:	85 c9                	test   %ecx,%ecx
801078df:	74 d4                	je     801078b5 <loaduvm+0x35>
801078e1:	89 fb                	mov    %edi,%ebx
801078e3:	b8 00 10 00 00       	mov    $0x1000,%eax
801078e8:	29 f3                	sub    %esi,%ebx
801078ea:	39 c3                	cmp    %eax,%ebx
801078ec:	0f 47 d8             	cmova  %eax,%ebx
801078ef:	53                   	push   %ebx
801078f0:	8b 45 14             	mov    0x14(%ebp),%eax
801078f3:	01 f0                	add    %esi,%eax
801078f5:	50                   	push   %eax
801078f6:	8b 01                	mov    (%ecx),%eax
801078f8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801078fd:	05 00 00 00 80       	add    $0x80000000,%eax
80107902:	50                   	push   %eax
80107903:	ff 75 10             	push   0x10(%ebp)
80107906:	e8 a5 ae ff ff       	call   801027b0 <readi>
8010790b:	83 c4 10             	add    $0x10,%esp
8010790e:	39 d8                	cmp    %ebx,%eax
80107910:	75 1e                	jne    80107930 <loaduvm+0xb0>
80107912:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107918:	39 fe                	cmp    %edi,%esi
8010791a:	72 84                	jb     801078a0 <loaduvm+0x20>
8010791c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010791f:	31 c0                	xor    %eax,%eax
80107921:	5b                   	pop    %ebx
80107922:	5e                   	pop    %esi
80107923:	5f                   	pop    %edi
80107924:	5d                   	pop    %ebp
80107925:	c3                   	ret
80107926:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010792d:	00 
8010792e:	66 90                	xchg   %ax,%ax
80107930:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107933:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107938:	5b                   	pop    %ebx
80107939:	5e                   	pop    %esi
8010793a:	5f                   	pop    %edi
8010793b:	5d                   	pop    %ebp
8010793c:	c3                   	ret
8010793d:	83 ec 0c             	sub    $0xc,%esp
80107940:	68 50 85 10 80       	push   $0x80108550
80107945:	e8 46 91 ff ff       	call   80100a90 <panic>
8010794a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107950 <allocuvm>:
80107950:	55                   	push   %ebp
80107951:	89 e5                	mov    %esp,%ebp
80107953:	57                   	push   %edi
80107954:	56                   	push   %esi
80107955:	53                   	push   %ebx
80107956:	83 ec 1c             	sub    $0x1c,%esp
80107959:	8b 75 10             	mov    0x10(%ebp),%esi
8010795c:	85 f6                	test   %esi,%esi
8010795e:	0f 88 98 00 00 00    	js     801079fc <allocuvm+0xac>
80107964:	89 f2                	mov    %esi,%edx
80107966:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107969:	0f 82 a1 00 00 00    	jb     80107a10 <allocuvm+0xc0>
8010796f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107972:	05 ff 0f 00 00       	add    $0xfff,%eax
80107977:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010797c:	89 c7                	mov    %eax,%edi
8010797e:	39 f0                	cmp    %esi,%eax
80107980:	0f 83 8d 00 00 00    	jae    80107a13 <allocuvm+0xc3>
80107986:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107989:	eb 44                	jmp    801079cf <allocuvm+0x7f>
8010798b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80107990:	83 ec 04             	sub    $0x4,%esp
80107993:	68 00 10 00 00       	push   $0x1000
80107998:	6a 00                	push   $0x0
8010799a:	50                   	push   %eax
8010799b:	e8 00 da ff ff       	call   801053a0 <memset>
801079a0:	58                   	pop    %eax
801079a1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801079a7:	5a                   	pop    %edx
801079a8:	6a 06                	push   $0x6
801079aa:	b9 00 10 00 00       	mov    $0x1000,%ecx
801079af:	89 fa                	mov    %edi,%edx
801079b1:	50                   	push   %eax
801079b2:	8b 45 08             	mov    0x8(%ebp),%eax
801079b5:	e8 a6 fb ff ff       	call   80107560 <mappages>
801079ba:	83 c4 10             	add    $0x10,%esp
801079bd:	85 c0                	test   %eax,%eax
801079bf:	78 5f                	js     80107a20 <allocuvm+0xd0>
801079c1:	81 c7 00 10 00 00    	add    $0x1000,%edi
801079c7:	39 f7                	cmp    %esi,%edi
801079c9:	0f 83 89 00 00 00    	jae    80107a58 <allocuvm+0x108>
801079cf:	e8 8c b9 ff ff       	call   80103360 <kalloc>
801079d4:	89 c3                	mov    %eax,%ebx
801079d6:	85 c0                	test   %eax,%eax
801079d8:	75 b6                	jne    80107990 <allocuvm+0x40>
801079da:	83 ec 0c             	sub    $0xc,%esp
801079dd:	68 df 82 10 80       	push   $0x801082df
801079e2:	e8 59 8e ff ff       	call   80100840 <cprintf>
801079e7:	83 c4 10             	add    $0x10,%esp
801079ea:	3b 75 0c             	cmp    0xc(%ebp),%esi
801079ed:	74 0d                	je     801079fc <allocuvm+0xac>
801079ef:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801079f2:	8b 45 08             	mov    0x8(%ebp),%eax
801079f5:	89 f2                	mov    %esi,%edx
801079f7:	e8 a4 fa ff ff       	call   801074a0 <deallocuvm.part.0>
801079fc:	31 d2                	xor    %edx,%edx
801079fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a01:	89 d0                	mov    %edx,%eax
80107a03:	5b                   	pop    %ebx
80107a04:	5e                   	pop    %esi
80107a05:	5f                   	pop    %edi
80107a06:	5d                   	pop    %ebp
80107a07:	c3                   	ret
80107a08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a0f:	00 
80107a10:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a16:	89 d0                	mov    %edx,%eax
80107a18:	5b                   	pop    %ebx
80107a19:	5e                   	pop    %esi
80107a1a:	5f                   	pop    %edi
80107a1b:	5d                   	pop    %ebp
80107a1c:	c3                   	ret
80107a1d:	8d 76 00             	lea    0x0(%esi),%esi
80107a20:	83 ec 0c             	sub    $0xc,%esp
80107a23:	68 f7 82 10 80       	push   $0x801082f7
80107a28:	e8 13 8e ff ff       	call   80100840 <cprintf>
80107a2d:	83 c4 10             	add    $0x10,%esp
80107a30:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107a33:	74 0d                	je     80107a42 <allocuvm+0xf2>
80107a35:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107a38:	8b 45 08             	mov    0x8(%ebp),%eax
80107a3b:	89 f2                	mov    %esi,%edx
80107a3d:	e8 5e fa ff ff       	call   801074a0 <deallocuvm.part.0>
80107a42:	83 ec 0c             	sub    $0xc,%esp
80107a45:	53                   	push   %ebx
80107a46:	e8 55 b7 ff ff       	call   801031a0 <kfree>
80107a4b:	83 c4 10             	add    $0x10,%esp
80107a4e:	31 d2                	xor    %edx,%edx
80107a50:	eb ac                	jmp    801079fe <allocuvm+0xae>
80107a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a58:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107a5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a5e:	5b                   	pop    %ebx
80107a5f:	5e                   	pop    %esi
80107a60:	89 d0                	mov    %edx,%eax
80107a62:	5f                   	pop    %edi
80107a63:	5d                   	pop    %ebp
80107a64:	c3                   	ret
80107a65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a6c:	00 
80107a6d:	8d 76 00             	lea    0x0(%esi),%esi

80107a70 <deallocuvm>:
80107a70:	55                   	push   %ebp
80107a71:	89 e5                	mov    %esp,%ebp
80107a73:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a76:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107a79:	8b 45 08             	mov    0x8(%ebp),%eax
80107a7c:	39 d1                	cmp    %edx,%ecx
80107a7e:	73 10                	jae    80107a90 <deallocuvm+0x20>
80107a80:	5d                   	pop    %ebp
80107a81:	e9 1a fa ff ff       	jmp    801074a0 <deallocuvm.part.0>
80107a86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a8d:	00 
80107a8e:	66 90                	xchg   %ax,%ax
80107a90:	89 d0                	mov    %edx,%eax
80107a92:	5d                   	pop    %ebp
80107a93:	c3                   	ret
80107a94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a9b:	00 
80107a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107aa0 <freevm>:
80107aa0:	55                   	push   %ebp
80107aa1:	89 e5                	mov    %esp,%ebp
80107aa3:	57                   	push   %edi
80107aa4:	56                   	push   %esi
80107aa5:	53                   	push   %ebx
80107aa6:	83 ec 0c             	sub    $0xc,%esp
80107aa9:	8b 75 08             	mov    0x8(%ebp),%esi
80107aac:	85 f6                	test   %esi,%esi
80107aae:	74 59                	je     80107b09 <freevm+0x69>
80107ab0:	31 c9                	xor    %ecx,%ecx
80107ab2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107ab7:	89 f0                	mov    %esi,%eax
80107ab9:	89 f3                	mov    %esi,%ebx
80107abb:	e8 e0 f9 ff ff       	call   801074a0 <deallocuvm.part.0>
80107ac0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107ac6:	eb 0f                	jmp    80107ad7 <freevm+0x37>
80107ac8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107acf:	00 
80107ad0:	83 c3 04             	add    $0x4,%ebx
80107ad3:	39 fb                	cmp    %edi,%ebx
80107ad5:	74 23                	je     80107afa <freevm+0x5a>
80107ad7:	8b 03                	mov    (%ebx),%eax
80107ad9:	a8 01                	test   $0x1,%al
80107adb:	74 f3                	je     80107ad0 <freevm+0x30>
80107add:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ae2:	83 ec 0c             	sub    $0xc,%esp
80107ae5:	83 c3 04             	add    $0x4,%ebx
80107ae8:	05 00 00 00 80       	add    $0x80000000,%eax
80107aed:	50                   	push   %eax
80107aee:	e8 ad b6 ff ff       	call   801031a0 <kfree>
80107af3:	83 c4 10             	add    $0x10,%esp
80107af6:	39 fb                	cmp    %edi,%ebx
80107af8:	75 dd                	jne    80107ad7 <freevm+0x37>
80107afa:	89 75 08             	mov    %esi,0x8(%ebp)
80107afd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b00:	5b                   	pop    %ebx
80107b01:	5e                   	pop    %esi
80107b02:	5f                   	pop    %edi
80107b03:	5d                   	pop    %ebp
80107b04:	e9 97 b6 ff ff       	jmp    801031a0 <kfree>
80107b09:	83 ec 0c             	sub    $0xc,%esp
80107b0c:	68 13 83 10 80       	push   $0x80108313
80107b11:	e8 7a 8f ff ff       	call   80100a90 <panic>
80107b16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107b1d:	00 
80107b1e:	66 90                	xchg   %ax,%ax

80107b20 <setupkvm>:
80107b20:	55                   	push   %ebp
80107b21:	89 e5                	mov    %esp,%ebp
80107b23:	56                   	push   %esi
80107b24:	53                   	push   %ebx
80107b25:	e8 36 b8 ff ff       	call   80103360 <kalloc>
80107b2a:	85 c0                	test   %eax,%eax
80107b2c:	74 5e                	je     80107b8c <setupkvm+0x6c>
80107b2e:	83 ec 04             	sub    $0x4,%esp
80107b31:	89 c6                	mov    %eax,%esi
80107b33:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
80107b38:	68 00 10 00 00       	push   $0x1000
80107b3d:	6a 00                	push   $0x0
80107b3f:	50                   	push   %eax
80107b40:	e8 5b d8 ff ff       	call   801053a0 <memset>
80107b45:	83 c4 10             	add    $0x10,%esp
80107b48:	8b 43 04             	mov    0x4(%ebx),%eax
80107b4b:	83 ec 08             	sub    $0x8,%esp
80107b4e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107b51:	8b 13                	mov    (%ebx),%edx
80107b53:	ff 73 0c             	push   0xc(%ebx)
80107b56:	50                   	push   %eax
80107b57:	29 c1                	sub    %eax,%ecx
80107b59:	89 f0                	mov    %esi,%eax
80107b5b:	e8 00 fa ff ff       	call   80107560 <mappages>
80107b60:	83 c4 10             	add    $0x10,%esp
80107b63:	85 c0                	test   %eax,%eax
80107b65:	78 19                	js     80107b80 <setupkvm+0x60>
80107b67:	83 c3 10             	add    $0x10,%ebx
80107b6a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107b70:	75 d6                	jne    80107b48 <setupkvm+0x28>
80107b72:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b75:	89 f0                	mov    %esi,%eax
80107b77:	5b                   	pop    %ebx
80107b78:	5e                   	pop    %esi
80107b79:	5d                   	pop    %ebp
80107b7a:	c3                   	ret
80107b7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80107b80:	83 ec 0c             	sub    $0xc,%esp
80107b83:	56                   	push   %esi
80107b84:	e8 17 ff ff ff       	call   80107aa0 <freevm>
80107b89:	83 c4 10             	add    $0x10,%esp
80107b8c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b8f:	31 f6                	xor    %esi,%esi
80107b91:	89 f0                	mov    %esi,%eax
80107b93:	5b                   	pop    %ebx
80107b94:	5e                   	pop    %esi
80107b95:	5d                   	pop    %ebp
80107b96:	c3                   	ret
80107b97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107b9e:	00 
80107b9f:	90                   	nop

80107ba0 <kvmalloc>:
80107ba0:	55                   	push   %ebp
80107ba1:	89 e5                	mov    %esp,%ebp
80107ba3:	83 ec 08             	sub    $0x8,%esp
80107ba6:	e8 75 ff ff ff       	call   80107b20 <setupkvm>
80107bab:	a3 e4 54 11 80       	mov    %eax,0x801154e4
80107bb0:	05 00 00 00 80       	add    $0x80000000,%eax
80107bb5:	0f 22 d8             	mov    %eax,%cr3
80107bb8:	c9                   	leave
80107bb9:	c3                   	ret
80107bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107bc0 <clearpteu>:
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	83 ec 08             	sub    $0x8,%esp
80107bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
80107bc9:	8b 55 08             	mov    0x8(%ebp),%edx
80107bcc:	89 c1                	mov    %eax,%ecx
80107bce:	c1 e9 16             	shr    $0x16,%ecx
80107bd1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107bd4:	f6 c2 01             	test   $0x1,%dl
80107bd7:	75 17                	jne    80107bf0 <clearpteu+0x30>
80107bd9:	83 ec 0c             	sub    $0xc,%esp
80107bdc:	68 24 83 10 80       	push   $0x80108324
80107be1:	e8 aa 8e ff ff       	call   80100a90 <panic>
80107be6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107bed:	00 
80107bee:	66 90                	xchg   %ax,%ax
80107bf0:	c1 e8 0a             	shr    $0xa,%eax
80107bf3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107bf9:	25 fc 0f 00 00       	and    $0xffc,%eax
80107bfe:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
80107c05:	85 c0                	test   %eax,%eax
80107c07:	74 d0                	je     80107bd9 <clearpteu+0x19>
80107c09:	83 20 fb             	andl   $0xfffffffb,(%eax)
80107c0c:	c9                   	leave
80107c0d:	c3                   	ret
80107c0e:	66 90                	xchg   %ax,%ax

80107c10 <copyuvm>:
80107c10:	55                   	push   %ebp
80107c11:	89 e5                	mov    %esp,%ebp
80107c13:	57                   	push   %edi
80107c14:	56                   	push   %esi
80107c15:	53                   	push   %ebx
80107c16:	83 ec 1c             	sub    $0x1c,%esp
80107c19:	e8 02 ff ff ff       	call   80107b20 <setupkvm>
80107c1e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107c21:	85 c0                	test   %eax,%eax
80107c23:	0f 84 e9 00 00 00    	je     80107d12 <copyuvm+0x102>
80107c29:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107c2c:	85 c9                	test   %ecx,%ecx
80107c2e:	0f 84 b2 00 00 00    	je     80107ce6 <copyuvm+0xd6>
80107c34:	31 f6                	xor    %esi,%esi
80107c36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107c3d:	00 
80107c3e:	66 90                	xchg   %ax,%ax
80107c40:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107c43:	89 f0                	mov    %esi,%eax
80107c45:	c1 e8 16             	shr    $0x16,%eax
80107c48:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107c4b:	a8 01                	test   $0x1,%al
80107c4d:	75 11                	jne    80107c60 <copyuvm+0x50>
80107c4f:	83 ec 0c             	sub    $0xc,%esp
80107c52:	68 2e 83 10 80       	push   $0x8010832e
80107c57:	e8 34 8e ff ff       	call   80100a90 <panic>
80107c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c60:	89 f2                	mov    %esi,%edx
80107c62:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c67:	c1 ea 0a             	shr    $0xa,%edx
80107c6a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107c70:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
80107c77:	85 c0                	test   %eax,%eax
80107c79:	74 d4                	je     80107c4f <copyuvm+0x3f>
80107c7b:	8b 00                	mov    (%eax),%eax
80107c7d:	a8 01                	test   $0x1,%al
80107c7f:	0f 84 9f 00 00 00    	je     80107d24 <copyuvm+0x114>
80107c85:	89 c7                	mov    %eax,%edi
80107c87:	25 ff 0f 00 00       	and    $0xfff,%eax
80107c8c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107c8f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107c95:	e8 c6 b6 ff ff       	call   80103360 <kalloc>
80107c9a:	89 c3                	mov    %eax,%ebx
80107c9c:	85 c0                	test   %eax,%eax
80107c9e:	74 64                	je     80107d04 <copyuvm+0xf4>
80107ca0:	83 ec 04             	sub    $0x4,%esp
80107ca3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107ca9:	68 00 10 00 00       	push   $0x1000
80107cae:	57                   	push   %edi
80107caf:	50                   	push   %eax
80107cb0:	e8 7b d7 ff ff       	call   80105430 <memmove>
80107cb5:	58                   	pop    %eax
80107cb6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107cbc:	5a                   	pop    %edx
80107cbd:	ff 75 e4             	push   -0x1c(%ebp)
80107cc0:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107cc5:	89 f2                	mov    %esi,%edx
80107cc7:	50                   	push   %eax
80107cc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107ccb:	e8 90 f8 ff ff       	call   80107560 <mappages>
80107cd0:	83 c4 10             	add    $0x10,%esp
80107cd3:	85 c0                	test   %eax,%eax
80107cd5:	78 21                	js     80107cf8 <copyuvm+0xe8>
80107cd7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107cdd:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107ce0:	0f 82 5a ff ff ff    	jb     80107c40 <copyuvm+0x30>
80107ce6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107ce9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107cec:	5b                   	pop    %ebx
80107ced:	5e                   	pop    %esi
80107cee:	5f                   	pop    %edi
80107cef:	5d                   	pop    %ebp
80107cf0:	c3                   	ret
80107cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cf8:	83 ec 0c             	sub    $0xc,%esp
80107cfb:	53                   	push   %ebx
80107cfc:	e8 9f b4 ff ff       	call   801031a0 <kfree>
80107d01:	83 c4 10             	add    $0x10,%esp
80107d04:	83 ec 0c             	sub    $0xc,%esp
80107d07:	ff 75 e0             	push   -0x20(%ebp)
80107d0a:	e8 91 fd ff ff       	call   80107aa0 <freevm>
80107d0f:	83 c4 10             	add    $0x10,%esp
80107d12:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107d19:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d1f:	5b                   	pop    %ebx
80107d20:	5e                   	pop    %esi
80107d21:	5f                   	pop    %edi
80107d22:	5d                   	pop    %ebp
80107d23:	c3                   	ret
80107d24:	83 ec 0c             	sub    $0xc,%esp
80107d27:	68 48 83 10 80       	push   $0x80108348
80107d2c:	e8 5f 8d ff ff       	call   80100a90 <panic>
80107d31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107d38:	00 
80107d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107d40 <uva2ka>:
80107d40:	55                   	push   %ebp
80107d41:	89 e5                	mov    %esp,%ebp
80107d43:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d46:	8b 55 08             	mov    0x8(%ebp),%edx
80107d49:	89 c1                	mov    %eax,%ecx
80107d4b:	c1 e9 16             	shr    $0x16,%ecx
80107d4e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107d51:	f6 c2 01             	test   $0x1,%dl
80107d54:	0f 84 f8 00 00 00    	je     80107e52 <uva2ka.cold>
80107d5a:	c1 e8 0c             	shr    $0xc,%eax
80107d5d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107d63:	5d                   	pop    %ebp
80107d64:	25 ff 03 00 00       	and    $0x3ff,%eax
80107d69:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
80107d70:	89 d0                	mov    %edx,%eax
80107d72:	f7 d2                	not    %edx
80107d74:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d79:	05 00 00 00 80       	add    $0x80000000,%eax
80107d7e:	83 e2 05             	and    $0x5,%edx
80107d81:	ba 00 00 00 00       	mov    $0x0,%edx
80107d86:	0f 45 c2             	cmovne %edx,%eax
80107d89:	c3                   	ret
80107d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107d90 <copyout>:
80107d90:	55                   	push   %ebp
80107d91:	89 e5                	mov    %esp,%ebp
80107d93:	57                   	push   %edi
80107d94:	56                   	push   %esi
80107d95:	53                   	push   %ebx
80107d96:	83 ec 0c             	sub    $0xc,%esp
80107d99:	8b 75 14             	mov    0x14(%ebp),%esi
80107d9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d9f:	8b 55 10             	mov    0x10(%ebp),%edx
80107da2:	85 f6                	test   %esi,%esi
80107da4:	75 51                	jne    80107df7 <copyout+0x67>
80107da6:	e9 9d 00 00 00       	jmp    80107e48 <copyout+0xb8>
80107dab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80107db0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107db6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
80107dbc:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107dc2:	74 74                	je     80107e38 <copyout+0xa8>
80107dc4:	89 fb                	mov    %edi,%ebx
80107dc6:	29 c3                	sub    %eax,%ebx
80107dc8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107dce:	39 f3                	cmp    %esi,%ebx
80107dd0:	0f 47 de             	cmova  %esi,%ebx
80107dd3:	29 f8                	sub    %edi,%eax
80107dd5:	83 ec 04             	sub    $0x4,%esp
80107dd8:	01 c1                	add    %eax,%ecx
80107dda:	53                   	push   %ebx
80107ddb:	52                   	push   %edx
80107ddc:	89 55 10             	mov    %edx,0x10(%ebp)
80107ddf:	51                   	push   %ecx
80107de0:	e8 4b d6 ff ff       	call   80105430 <memmove>
80107de5:	8b 55 10             	mov    0x10(%ebp),%edx
80107de8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
80107dee:	83 c4 10             	add    $0x10,%esp
80107df1:	01 da                	add    %ebx,%edx
80107df3:	29 de                	sub    %ebx,%esi
80107df5:	74 51                	je     80107e48 <copyout+0xb8>
80107df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80107dfa:	89 c1                	mov    %eax,%ecx
80107dfc:	89 c7                	mov    %eax,%edi
80107dfe:	c1 e9 16             	shr    $0x16,%ecx
80107e01:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107e07:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107e0a:	f6 c1 01             	test   $0x1,%cl
80107e0d:	0f 84 46 00 00 00    	je     80107e59 <copyout.cold>
80107e13:	89 fb                	mov    %edi,%ebx
80107e15:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107e1b:	c1 eb 0c             	shr    $0xc,%ebx
80107e1e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
80107e24:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
80107e2b:	89 d9                	mov    %ebx,%ecx
80107e2d:	f7 d1                	not    %ecx
80107e2f:	83 e1 05             	and    $0x5,%ecx
80107e32:	0f 84 78 ff ff ff    	je     80107db0 <copyout+0x20>
80107e38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e40:	5b                   	pop    %ebx
80107e41:	5e                   	pop    %esi
80107e42:	5f                   	pop    %edi
80107e43:	5d                   	pop    %ebp
80107e44:	c3                   	ret
80107e45:	8d 76 00             	lea    0x0(%esi),%esi
80107e48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e4b:	31 c0                	xor    %eax,%eax
80107e4d:	5b                   	pop    %ebx
80107e4e:	5e                   	pop    %esi
80107e4f:	5f                   	pop    %edi
80107e50:	5d                   	pop    %ebp
80107e51:	c3                   	ret

80107e52 <uva2ka.cold>:
80107e52:	a1 00 00 00 00       	mov    0x0,%eax
80107e57:	0f 0b                	ud2

80107e59 <copyout.cold>:
80107e59:	a1 00 00 00 00       	mov    0x0,%eax
80107e5e:	0f 0b                	ud2
