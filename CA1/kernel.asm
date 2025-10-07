
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc f0 54 11 80       	mov    $0x801154f0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 90 33 10 80       	mov    $0x80103390,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 a5 10 80       	mov    $0x8010a554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 c0 74 10 80       	push   $0x801074c0
80100051:	68 20 a5 10 80       	push   $0x8010a520
80100056:	e8 b5 46 00 00       	call   80104710 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c ec 10 80       	mov    $0x8010ec1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec6c
8010006a:	ec 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec70
80100074:	ec 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 c7 74 10 80       	push   $0x801074c7
80100097:	50                   	push   %eax
80100098:	e8 43 45 00 00       	call   801045e0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 e9 10 80    	cmp    $0x8010e9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 a5 10 80       	push   $0x8010a520
801000e4:	e8 17 48 00 00       	call   80104900 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 ec 10 80    	mov    0x8010ec70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c ec 10 80    	mov    0x8010ec6c,%ebx
80100126:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 a5 10 80       	push   $0x8010a520
80100162:	e8 39 47 00 00       	call   801048a0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ae 44 00 00       	call   80104620 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 9f 24 00 00       	call   80102630 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ce 74 10 80       	push   $0x801074ce
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 fd 44 00 00       	call   801046c0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 57 24 00 00       	jmp    80102630 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 df 74 10 80       	push   $0x801074df
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 bc 44 00 00       	call   801046c0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 6c 44 00 00       	call   80104680 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010021b:	e8 e0 46 00 00       	call   80104900 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010023f:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 a5 10 80 	movl   $0x8010a520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 32 46 00 00       	jmp    801048a0 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 e6 74 10 80       	push   $0x801074e6
80100276:	e8 05 01 00 00       	call   80100380 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:
  }
}

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
80100294:	e8 47 19 00 00       	call   80101be0 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 40 ef 10 80 	movl   $0x8010ef40,(%esp)
801002a0:	e8 5b 46 00 00       	call   80104900 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 20 ef 10 80       	mov    0x8010ef20,%eax
801002b5:	39 05 24 ef 10 80    	cmp    %eax,0x8010ef24
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
801002c3:	68 40 ef 10 80       	push   $0x8010ef40
801002c8:	68 20 ef 10 80       	push   $0x8010ef20
801002cd:	e8 ae 40 00 00       	call   80104380 <sleep>
    while(input.r == input.w){
801002d2:	a1 20 ef 10 80       	mov    0x8010ef20,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 24 ef 10 80    	cmp    0x8010ef24,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 d9 39 00 00       	call   80103cc0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 40 ef 10 80       	push   $0x8010ef40
801002f6:	e8 a5 45 00 00       	call   801048a0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 fc 17 00 00       	call   80101b00 <ilock>
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
8010031b:	89 15 20 ef 10 80    	mov    %edx,0x8010ef20
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a a0 ee 10 80 	movsbl -0x7fef1160(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 40 ef 10 80       	push   $0x8010ef40
8010034c:	e8 4f 45 00 00       	call   801048a0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 a6 17 00 00       	call   80101b00 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 20 ef 10 80       	mov    %eax,0x8010ef20
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037b:	00 
8010037c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli
  cons.locking = 0;
80100389:	c7 05 74 ef 10 80 00 	movl   $0x0,0x8010ef74
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 92 28 00 00       	call   80102c30 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 ed 74 10 80       	push   $0x801074ed
801003a7:	e8 b4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 ab 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 6f 79 10 80 	movl   $0x8010796f,(%esp)
801003bc:	e8 9f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 63 43 00 00       	call   80104730 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 01 75 10 80       	push   $0x80107501
801003dd:	e8 7e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 78 ef 10 80 01 	movl   $0x1,0x8010ef78
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801003fc:	00 
801003fd:	8d 76 00             	lea    0x0(%esi),%esi

80100400 <cgaputc>:
{
80100400:	55                   	push   %ebp
80100401:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100403:	b8 0e 00 00 00       	mov    $0xe,%eax
80100408:	89 e5                	mov    %esp,%ebp
8010040a:	57                   	push   %edi
8010040b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100410:	56                   	push   %esi
80100411:	89 fa                	mov    %edi,%edx
80100413:	53                   	push   %ebx
80100414:	83 ec 1c             	sub    $0x1c,%esp
80100417:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100418:	be d5 03 00 00       	mov    $0x3d5,%esi
8010041d:	89 f2                	mov    %esi,%edx
8010041f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100420:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100423:	89 fa                	mov    %edi,%edx
80100425:	b8 0f 00 00 00       	mov    $0xf,%eax
8010042a:	c1 e3 08             	shl    $0x8,%ebx
8010042d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042e:	89 f2                	mov    %esi,%edx
80100430:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100431:	0f b6 c0             	movzbl %al,%eax
80100434:	09 d8                	or     %ebx,%eax
  if(c == '\n')
80100436:	83 f9 0a             	cmp    $0xa,%ecx
80100439:	0f 84 91 00 00 00    	je     801004d0 <cgaputc+0xd0>
  else if(c == BACKSPACE){
8010043f:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
80100445:	74 71                	je     801004b8 <cgaputc+0xb8>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100447:	0f b6 c9             	movzbl %cl,%ecx
8010044a:	8d 58 01             	lea    0x1(%eax),%ebx
8010044d:	80 cd 07             	or     $0x7,%ch
80100450:	66 89 8c 00 00 80 0b 	mov    %cx,-0x7ff48000(%eax,%eax,1)
80100457:	80 
  if(pos < 0 || pos > 25*80)
80100458:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010045e:	0f 8f ce 00 00 00    	jg     80100532 <cgaputc+0x132>
  if((pos/80) >= 24){  // Scroll up.
80100464:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
8010046a:	0f 8f 80 00 00 00    	jg     801004f0 <cgaputc+0xf0>
  outb(CRTPORT+1, pos>>8);
80100470:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
80100473:	89 df                	mov    %ebx,%edi
  crt[pos] = ' ' | 0x0700;
80100475:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  outb(CRTPORT+1, pos>>8);
8010047c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010047f:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100484:	b8 0e 00 00 00       	mov    $0xe,%eax
80100489:	89 da                	mov    %ebx,%edx
8010048b:	ee                   	out    %al,(%dx)
8010048c:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100491:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
80100495:	89 ca                	mov    %ecx,%edx
80100497:	ee                   	out    %al,(%dx)
80100498:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049d:	89 da                	mov    %ebx,%edx
8010049f:	ee                   	out    %al,(%dx)
801004a0:	89 f8                	mov    %edi,%eax
801004a2:	89 ca                	mov    %ecx,%edx
801004a4:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a5:	b8 20 07 00 00       	mov    $0x720,%eax
801004aa:	66 89 06             	mov    %ax,(%esi)
}
801004ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004b0:	5b                   	pop    %ebx
801004b1:	5e                   	pop    %esi
801004b2:	5f                   	pop    %edi
801004b3:	5d                   	pop    %ebp
801004b4:	c3                   	ret
801004b5:	8d 76 00             	lea    0x0(%esi),%esi
    if(pos > 0) --pos;
801004b8:	8d 58 ff             	lea    -0x1(%eax),%ebx
801004bb:	85 c0                	test   %eax,%eax
801004bd:	75 99                	jne    80100458 <cgaputc+0x58>
801004bf:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
801004c3:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004c8:	31 ff                	xor    %edi,%edi
801004ca:	eb b3                	jmp    8010047f <cgaputc+0x7f>
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004d0:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004d5:	f7 e2                	mul    %edx
801004d7:	c1 ea 06             	shr    $0x6,%edx
801004da:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004dd:	c1 e0 04             	shl    $0x4,%eax
801004e0:	8d 58 50             	lea    0x50(%eax),%ebx
801004e3:	e9 70 ff ff ff       	jmp    80100458 <cgaputc+0x58>
801004e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801004ef:	00 
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f0:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004f3:	8d 7b b0             	lea    -0x50(%ebx),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004f6:	8d b4 1b 60 7f 0b 80 	lea    -0x7ff480a0(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fd:	68 60 0e 00 00       	push   $0xe60
80100502:	68 a0 80 0b 80       	push   $0x800b80a0
80100507:	68 00 80 0b 80       	push   $0x800b8000
8010050c:	e8 7f 45 00 00       	call   80104a90 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100511:	b8 80 07 00 00       	mov    $0x780,%eax
80100516:	83 c4 0c             	add    $0xc,%esp
80100519:	29 f8                	sub    %edi,%eax
8010051b:	01 c0                	add    %eax,%eax
8010051d:	50                   	push   %eax
8010051e:	6a 00                	push   $0x0
80100520:	56                   	push   %esi
80100521:	e8 da 44 00 00       	call   80104a00 <memset>
  outb(CRTPORT+1, pos);
80100526:	83 c4 10             	add    $0x10,%esp
80100529:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010052d:	e9 4d ff ff ff       	jmp    8010047f <cgaputc+0x7f>
    panic("pos under/overflow");
80100532:	83 ec 0c             	sub    $0xc,%esp
80100535:	68 05 75 10 80       	push   $0x80107505
8010053a:	e8 41 fe ff ff       	call   80100380 <panic>
8010053f:	90                   	nop

80100540 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100540:	55                   	push   %ebp
80100541:	89 e5                	mov    %esp,%ebp
80100543:	57                   	push   %edi
80100544:	56                   	push   %esi
80100545:	53                   	push   %ebx
80100546:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100549:	ff 75 08             	push   0x8(%ebp)
8010054c:	e8 8f 16 00 00       	call   80101be0 <iunlock>
  acquire(&cons.lock);
80100551:	c7 04 24 40 ef 10 80 	movl   $0x8010ef40,(%esp)
80100558:	e8 a3 43 00 00       	call   80104900 <acquire>
  for(i = 0; i < n; i++)
8010055d:	8b 4d 10             	mov    0x10(%ebp),%ecx
80100560:	83 c4 10             	add    $0x10,%esp
80100563:	85 c9                	test   %ecx,%ecx
80100565:	7e 36                	jle    8010059d <consolewrite+0x5d>
80100567:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010056a:	8b 7d 10             	mov    0x10(%ebp),%edi
8010056d:	01 df                	add    %ebx,%edi
  if(panicked){
8010056f:	8b 15 78 ef 10 80    	mov    0x8010ef78,%edx
    consputc(buf[i] & 0xff);
80100575:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
80100578:	85 d2                	test   %edx,%edx
8010057a:	74 04                	je     80100580 <consolewrite+0x40>
  asm volatile("cli");
8010057c:	fa                   	cli
    for(;;)
8010057d:	eb fe                	jmp    8010057d <consolewrite+0x3d>
8010057f:	90                   	nop
    uartputc(c);
80100580:	83 ec 0c             	sub    $0xc,%esp
    consputc(buf[i] & 0xff);
80100583:	0f b6 f0             	movzbl %al,%esi
  for(i = 0; i < n; i++)
80100586:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100589:	56                   	push   %esi
8010058a:	e8 81 5a 00 00       	call   80106010 <uartputc>
  cgaputc(c);
8010058f:	89 f0                	mov    %esi,%eax
80100591:	e8 6a fe ff ff       	call   80100400 <cgaputc>
  for(i = 0; i < n; i++)
80100596:	83 c4 10             	add    $0x10,%esp
80100599:	39 fb                	cmp    %edi,%ebx
8010059b:	75 d2                	jne    8010056f <consolewrite+0x2f>
  release(&cons.lock);
8010059d:	83 ec 0c             	sub    $0xc,%esp
801005a0:	68 40 ef 10 80       	push   $0x8010ef40
801005a5:	e8 f6 42 00 00       	call   801048a0 <release>
  ilock(ip);
801005aa:	58                   	pop    %eax
801005ab:	ff 75 08             	push   0x8(%ebp)
801005ae:	e8 4d 15 00 00       	call   80101b00 <ilock>

  return n;
}
801005b3:	8b 45 10             	mov    0x10(%ebp),%eax
801005b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005b9:	5b                   	pop    %ebx
801005ba:	5e                   	pop    %esi
801005bb:	5f                   	pop    %edi
801005bc:	5d                   	pop    %ebp
801005bd:	c3                   	ret
801005be:	66 90                	xchg   %ax,%ax

801005c0 <printint>:
{
801005c0:	55                   	push   %ebp
801005c1:	89 e5                	mov    %esp,%ebp
801005c3:	57                   	push   %edi
801005c4:	56                   	push   %esi
801005c5:	53                   	push   %ebx
801005c6:	89 d3                	mov    %edx,%ebx
801005c8:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
801005cb:	85 c0                	test   %eax,%eax
801005cd:	79 05                	jns    801005d4 <printint+0x14>
801005cf:	83 e1 01             	and    $0x1,%ecx
801005d2:	75 6a                	jne    8010063e <printint+0x7e>
    x = xx;
801005d4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
801005db:	89 c1                	mov    %eax,%ecx
  i = 0;
801005dd:	31 f6                	xor    %esi,%esi
801005df:	90                   	nop
    buf[i++] = digits[x % base];
801005e0:	89 c8                	mov    %ecx,%eax
801005e2:	31 d2                	xor    %edx,%edx
801005e4:	89 f7                	mov    %esi,%edi
801005e6:	f7 f3                	div    %ebx
801005e8:	8d 76 01             	lea    0x1(%esi),%esi
801005eb:	0f b6 92 18 7a 10 80 	movzbl -0x7fef85e8(%edx),%edx
801005f2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
801005f6:	89 ca                	mov    %ecx,%edx
801005f8:	89 c1                	mov    %eax,%ecx
801005fa:	39 da                	cmp    %ebx,%edx
801005fc:	73 e2                	jae    801005e0 <printint+0x20>
  if(sign)
801005fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100601:	85 d2                	test   %edx,%edx
80100603:	74 07                	je     8010060c <printint+0x4c>
    buf[i++] = '-';
80100605:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010060a:	89 f7                	mov    %esi,%edi
8010060c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010060f:	01 f7                	add    %esi,%edi
  if(panicked){
80100611:	a1 78 ef 10 80       	mov    0x8010ef78,%eax
    consputc(buf[i]);
80100616:	0f be 1f             	movsbl (%edi),%ebx
  if(panicked){
80100619:	85 c0                	test   %eax,%eax
8010061b:	74 03                	je     80100620 <printint+0x60>
8010061d:	fa                   	cli
    for(;;)
8010061e:	eb fe                	jmp    8010061e <printint+0x5e>
    uartputc(c);
80100620:	83 ec 0c             	sub    $0xc,%esp
80100623:	53                   	push   %ebx
80100624:	e8 e7 59 00 00       	call   80106010 <uartputc>
  cgaputc(c);
80100629:	89 d8                	mov    %ebx,%eax
8010062b:	e8 d0 fd ff ff       	call   80100400 <cgaputc>
  while(--i >= 0)
80100630:	8d 47 ff             	lea    -0x1(%edi),%eax
80100633:	83 c4 10             	add    $0x10,%esp
80100636:	39 f7                	cmp    %esi,%edi
80100638:	74 11                	je     8010064b <printint+0x8b>
8010063a:	89 c7                	mov    %eax,%edi
8010063c:	eb d3                	jmp    80100611 <printint+0x51>
    x = -xx;
8010063e:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
80100640:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
80100647:	89 c1                	mov    %eax,%ecx
80100649:	eb 92                	jmp    801005dd <printint+0x1d>
}
8010064b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010064e:	5b                   	pop    %ebx
8010064f:	5e                   	pop    %esi
80100650:	5f                   	pop    %edi
80100651:	5d                   	pop    %ebp
80100652:	c3                   	ret
80100653:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010065a:	00 
8010065b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	8b 3d 74 ef 10 80    	mov    0x8010ef74,%edi
  if (fmt == 0)
8010066f:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100672:	85 ff                	test   %edi,%edi
80100674:	0f 85 36 01 00 00    	jne    801007b0 <cprintf+0x150>
  if (fmt == 0)
8010067a:	85 f6                	test   %esi,%esi
8010067c:	0f 84 1c 02 00 00    	je     8010089e <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100682:	0f b6 06             	movzbl (%esi),%eax
80100685:	85 c0                	test   %eax,%eax
80100687:	74 67                	je     801006f0 <cprintf+0x90>
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010068f:	31 db                	xor    %ebx,%ebx
80100691:	89 d7                	mov    %edx,%edi
    if(c != '%'){
80100693:	83 f8 25             	cmp    $0x25,%eax
80100696:	75 68                	jne    80100700 <cprintf+0xa0>
    c = fmt[++i] & 0xff;
80100698:	83 c3 01             	add    $0x1,%ebx
8010069b:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
8010069f:	85 c9                	test   %ecx,%ecx
801006a1:	74 42                	je     801006e5 <cprintf+0x85>
    switch(c){
801006a3:	83 f9 70             	cmp    $0x70,%ecx
801006a6:	0f 84 e4 00 00 00    	je     80100790 <cprintf+0x130>
801006ac:	0f 8f 8e 00 00 00    	jg     80100740 <cprintf+0xe0>
801006b2:	83 f9 25             	cmp    $0x25,%ecx
801006b5:	74 72                	je     80100729 <cprintf+0xc9>
801006b7:	83 f9 64             	cmp    $0x64,%ecx
801006ba:	0f 85 8e 00 00 00    	jne    8010074e <cprintf+0xee>
      printint(*argp++, 10, 1);
801006c0:	8d 47 04             	lea    0x4(%edi),%eax
801006c3:	b9 01 00 00 00       	mov    $0x1,%ecx
801006c8:	ba 0a 00 00 00       	mov    $0xa,%edx
801006cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006d0:	8b 07                	mov    (%edi),%eax
801006d2:	e8 e9 fe ff ff       	call   801005c0 <printint>
801006d7:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006da:	83 c3 01             	add    $0x1,%ebx
801006dd:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006e1:	85 c0                	test   %eax,%eax
801006e3:	75 ae                	jne    80100693 <cprintf+0x33>
801006e5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
801006e8:	85 ff                	test   %edi,%edi
801006ea:	0f 85 e3 00 00 00    	jne    801007d3 <cprintf+0x173>
}
801006f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006f3:	5b                   	pop    %ebx
801006f4:	5e                   	pop    %esi
801006f5:	5f                   	pop    %edi
801006f6:	5d                   	pop    %ebp
801006f7:	c3                   	ret
801006f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801006ff:	00 
  if(panicked){
80100700:	8b 15 78 ef 10 80    	mov    0x8010ef78,%edx
80100706:	85 d2                	test   %edx,%edx
80100708:	74 06                	je     80100710 <cprintf+0xb0>
8010070a:	fa                   	cli
    for(;;)
8010070b:	eb fe                	jmp    8010070b <cprintf+0xab>
8010070d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100710:	83 ec 0c             	sub    $0xc,%esp
80100713:	50                   	push   %eax
80100714:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100717:	e8 f4 58 00 00       	call   80106010 <uartputc>
  cgaputc(c);
8010071c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010071f:	e8 dc fc ff ff       	call   80100400 <cgaputc>
      continue;
80100724:	83 c4 10             	add    $0x10,%esp
80100727:	eb b1                	jmp    801006da <cprintf+0x7a>
  if(panicked){
80100729:	8b 0d 78 ef 10 80    	mov    0x8010ef78,%ecx
8010072f:	85 c9                	test   %ecx,%ecx
80100731:	0f 84 f9 00 00 00    	je     80100830 <cprintf+0x1d0>
80100737:	fa                   	cli
    for(;;)
80100738:	eb fe                	jmp    80100738 <cprintf+0xd8>
8010073a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100740:	83 f9 73             	cmp    $0x73,%ecx
80100743:	0f 84 9f 00 00 00    	je     801007e8 <cprintf+0x188>
80100749:	83 f9 78             	cmp    $0x78,%ecx
8010074c:	74 42                	je     80100790 <cprintf+0x130>
  if(panicked){
8010074e:	8b 15 78 ef 10 80    	mov    0x8010ef78,%edx
80100754:	85 d2                	test   %edx,%edx
80100756:	0f 85 d0 00 00 00    	jne    8010082c <cprintf+0x1cc>
    uartputc(c);
8010075c:	83 ec 0c             	sub    $0xc,%esp
8010075f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100762:	6a 25                	push   $0x25
80100764:	e8 a7 58 00 00       	call   80106010 <uartputc>
  cgaputc(c);
80100769:	b8 25 00 00 00       	mov    $0x25,%eax
8010076e:	e8 8d fc ff ff       	call   80100400 <cgaputc>
  if(panicked){
80100773:	a1 78 ef 10 80       	mov    0x8010ef78,%eax
80100778:	83 c4 10             	add    $0x10,%esp
8010077b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010077e:	85 c0                	test   %eax,%eax
80100780:	0f 84 f5 00 00 00    	je     8010087b <cprintf+0x21b>
80100786:	fa                   	cli
    for(;;)
80100787:	eb fe                	jmp    80100787 <cprintf+0x127>
80100789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
80100790:	8d 47 04             	lea    0x4(%edi),%eax
80100793:	31 c9                	xor    %ecx,%ecx
80100795:	ba 10 00 00 00       	mov    $0x10,%edx
8010079a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010079d:	8b 07                	mov    (%edi),%eax
8010079f:	e8 1c fe ff ff       	call   801005c0 <printint>
801007a4:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
801007a7:	e9 2e ff ff ff       	jmp    801006da <cprintf+0x7a>
801007ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007b0:	83 ec 0c             	sub    $0xc,%esp
801007b3:	68 40 ef 10 80       	push   $0x8010ef40
801007b8:	e8 43 41 00 00       	call   80104900 <acquire>
  if (fmt == 0)
801007bd:	83 c4 10             	add    $0x10,%esp
801007c0:	85 f6                	test   %esi,%esi
801007c2:	0f 84 d6 00 00 00    	je     8010089e <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007c8:	0f b6 06             	movzbl (%esi),%eax
801007cb:	85 c0                	test   %eax,%eax
801007cd:	0f 85 b6 fe ff ff    	jne    80100689 <cprintf+0x29>
    release(&cons.lock);
801007d3:	83 ec 0c             	sub    $0xc,%esp
801007d6:	68 40 ef 10 80       	push   $0x8010ef40
801007db:	e8 c0 40 00 00       	call   801048a0 <release>
801007e0:	83 c4 10             	add    $0x10,%esp
801007e3:	e9 08 ff ff ff       	jmp    801006f0 <cprintf+0x90>
      if((s = (char*)*argp++) == 0)
801007e8:	8b 17                	mov    (%edi),%edx
801007ea:	8d 47 04             	lea    0x4(%edi),%eax
801007ed:	85 d2                	test   %edx,%edx
801007ef:	74 2f                	je     80100820 <cprintf+0x1c0>
      for(; *s; s++)
801007f1:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
801007f4:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
801007f6:	84 c9                	test   %cl,%cl
801007f8:	0f 84 99 00 00 00    	je     80100897 <cprintf+0x237>
801007fe:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100801:	89 fb                	mov    %edi,%ebx
80100803:	89 f7                	mov    %esi,%edi
80100805:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100808:	89 c8                	mov    %ecx,%eax
  if(panicked){
8010080a:	8b 35 78 ef 10 80    	mov    0x8010ef78,%esi
80100810:	85 f6                	test   %esi,%esi
80100812:	74 38                	je     8010084c <cprintf+0x1ec>
80100814:	fa                   	cli
    for(;;)
80100815:	eb fe                	jmp    80100815 <cprintf+0x1b5>
80100817:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010081e:	00 
8010081f:	90                   	nop
80100820:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
80100825:	bf 18 75 10 80       	mov    $0x80107518,%edi
8010082a:	eb d2                	jmp    801007fe <cprintf+0x19e>
8010082c:	fa                   	cli
    for(;;)
8010082d:	eb fe                	jmp    8010082d <cprintf+0x1cd>
8010082f:	90                   	nop
    uartputc(c);
80100830:	83 ec 0c             	sub    $0xc,%esp
80100833:	6a 25                	push   $0x25
80100835:	e8 d6 57 00 00       	call   80106010 <uartputc>
  cgaputc(c);
8010083a:	b8 25 00 00 00       	mov    $0x25,%eax
8010083f:	e8 bc fb ff ff       	call   80100400 <cgaputc>
}
80100844:	83 c4 10             	add    $0x10,%esp
80100847:	e9 8e fe ff ff       	jmp    801006da <cprintf+0x7a>
    uartputc(c);
8010084c:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
8010084f:	0f be f0             	movsbl %al,%esi
      for(; *s; s++)
80100852:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100855:	56                   	push   %esi
80100856:	e8 b5 57 00 00       	call   80106010 <uartputc>
  cgaputc(c);
8010085b:	89 f0                	mov    %esi,%eax
8010085d:	e8 9e fb ff ff       	call   80100400 <cgaputc>
      for(; *s; s++)
80100862:	0f b6 03             	movzbl (%ebx),%eax
80100865:	83 c4 10             	add    $0x10,%esp
80100868:	84 c0                	test   %al,%al
8010086a:	75 9e                	jne    8010080a <cprintf+0x1aa>
      if((s = (char*)*argp++) == 0)
8010086c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010086f:	89 fe                	mov    %edi,%esi
80100871:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100874:	89 c7                	mov    %eax,%edi
80100876:	e9 5f fe ff ff       	jmp    801006da <cprintf+0x7a>
    uartputc(c);
8010087b:	83 ec 0c             	sub    $0xc,%esp
8010087e:	51                   	push   %ecx
8010087f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100882:	e8 89 57 00 00       	call   80106010 <uartputc>
  cgaputc(c);
80100887:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010088a:	e8 71 fb ff ff       	call   80100400 <cgaputc>
}
8010088f:	83 c4 10             	add    $0x10,%esp
80100892:	e9 43 fe ff ff       	jmp    801006da <cprintf+0x7a>
      if((s = (char*)*argp++) == 0)
80100897:	89 c7                	mov    %eax,%edi
80100899:	e9 3c fe ff ff       	jmp    801006da <cprintf+0x7a>
    panic("null fmt");
8010089e:	83 ec 0c             	sub    $0xc,%esp
801008a1:	68 1f 75 10 80       	push   $0x8010751f
801008a6:	e8 d5 fa ff ff       	call   80100380 <panic>
801008ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801008b0 <consoleintr>:
{
801008b0:	55                   	push   %ebp
801008b1:	89 e5                	mov    %esp,%ebp
801008b3:	57                   	push   %edi
  int c, doprocdump = 0;
801008b4:	31 ff                	xor    %edi,%edi
{
801008b6:	56                   	push   %esi
801008b7:	53                   	push   %ebx
801008b8:	83 ec 28             	sub    $0x28,%esp
801008bb:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801008be:	68 40 ef 10 80       	push   $0x8010ef40
801008c3:	e8 38 40 00 00       	call   80104900 <acquire>
  while((c = getc()) >= 0){
801008c8:	83 c4 10             	add    $0x10,%esp
801008cb:	ff d6                	call   *%esi
801008cd:	85 c0                	test   %eax,%eax
801008cf:	0f 88 43 01 00 00    	js     80100a18 <consoleintr+0x168>
    switch(c){
801008d5:	83 f8 15             	cmp    $0x15,%eax
801008d8:	7f 16                	jg     801008f0 <consoleintr+0x40>
801008da:	85 c0                	test   %eax,%eax
801008dc:	74 ed                	je     801008cb <consoleintr+0x1b>
801008de:	83 f8 15             	cmp    $0x15,%eax
801008e1:	0f 87 52 03 00 00    	ja     80100c39 <consoleintr+0x389>
801008e7:	ff 24 85 c0 79 10 80 	jmp    *-0x7fef8640(,%eax,4)
801008ee:	66 90                	xchg   %ax,%ax
801008f0:	3d e4 00 00 00       	cmp    $0xe4,%eax
801008f5:	0f 84 ed 01 00 00    	je     80100ae8 <consoleintr+0x238>
801008fb:	3d e5 00 00 00       	cmp    $0xe5,%eax
80100900:	0f 84 92 00 00 00    	je     80100998 <consoleintr+0xe8>
80100906:	83 f8 7f             	cmp    $0x7f,%eax
80100909:	0f 84 69 01 00 00    	je     80100a78 <consoleintr+0x1c8>
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010090f:	8b 0d 28 ef 10 80    	mov    0x8010ef28,%ecx
80100915:	89 ca                	mov    %ecx,%edx
80100917:	2b 15 20 ef 10 80    	sub    0x8010ef20,%edx
8010091d:	83 fa 7f             	cmp    $0x7f,%edx
80100920:	77 a9                	ja     801008cb <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100922:	8d 51 01             	lea    0x1(%ecx),%edx
80100925:	83 e1 7f             	and    $0x7f,%ecx
80100928:	89 15 28 ef 10 80    	mov    %edx,0x8010ef28
  if(panicked){
8010092e:	8b 15 78 ef 10 80    	mov    0x8010ef78,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100934:	88 81 a0 ee 10 80    	mov    %al,-0x7fef1160(%ecx)
  if(panicked){
8010093a:	85 d2                	test   %edx,%edx
8010093c:	0f 85 d4 02 00 00    	jne    80100c16 <consoleintr+0x366>
  if(c == BACKSPACE){
80100942:	3d 00 01 00 00       	cmp    $0x100,%eax
80100947:	0f 85 67 03 00 00    	jne    80100cb4 <consoleintr+0x404>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010094d:	83 ec 0c             	sub    $0xc,%esp
80100950:	6a 08                	push   $0x8
80100952:	e8 b9 56 00 00       	call   80106010 <uartputc>
80100957:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010095e:	e8 ad 56 00 00       	call   80106010 <uartputc>
80100963:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010096a:	e8 a1 56 00 00       	call   80106010 <uartputc>
  cgaputc(c);
8010096f:	b8 00 01 00 00       	mov    $0x100,%eax
80100974:	e8 87 fa ff ff       	call   80100400 <cgaputc>
80100979:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010097c:	a1 20 ef 10 80       	mov    0x8010ef20,%eax
80100981:	83 e8 80             	sub    $0xffffff80,%eax
80100984:	39 05 28 ef 10 80    	cmp    %eax,0x8010ef28
8010098a:	0f 85 3b ff ff ff    	jne    801008cb <consoleintr+0x1b>
80100990:	e9 fb 02 00 00       	jmp    80100c90 <consoleintr+0x3e0>
80100995:	8d 76 00             	lea    0x0(%esi),%esi
      if(left_key_pressed>0){
80100998:	a1 80 ee 10 80       	mov    0x8010ee80,%eax
8010099d:	85 c0                	test   %eax,%eax
8010099f:	0f 8e 26 ff ff ff    	jle    801008cb <consoleintr+0x1b>
        left_key_pressed--;
801009a5:	83 e8 01             	sub    $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801009a8:	bb d4 03 00 00       	mov    $0x3d4,%ebx
        input.e++;
801009ad:	83 05 28 ef 10 80 01 	addl   $0x1,0x8010ef28
        left_key_pressed--;
801009b4:	a3 80 ee 10 80       	mov    %eax,0x8010ee80
801009b9:	89 da                	mov    %ebx,%edx
801009bb:	b8 0e 00 00 00       	mov    $0xe,%eax
801009c0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801009c1:	ba d5 03 00 00       	mov    $0x3d5,%edx
801009c6:	ec                   	in     (%dx),%al

void move_cursor_right(void) {
    int pos;

    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
801009c7:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801009ca:	89 da                	mov    %ebx,%edx
801009cc:	89 c1                	mov    %eax,%ecx
801009ce:	b8 0f 00 00 00       	mov    $0xf,%eax
801009d3:	c1 e1 08             	shl    $0x8,%ecx
801009d6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801009d7:	ba d5 03 00 00       	mov    $0x3d5,%edx
801009dc:	ec                   	in     (%dx),%al
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
801009dd:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801009e0:	89 da                	mov    %ebx,%edx
801009e2:	09 c1                	or     %eax,%ecx
801009e4:	b8 0e 00 00 00       	mov    $0xe,%eax

    pos++;
801009e9:	83 c1 01             	add    $0x1,%ecx
801009ec:	ee                   	out    %al,(%dx)

    outb(CRTPORT, 14);
    outb(CRTPORT+1, pos >> 8);
801009ed:	89 ca                	mov    %ecx,%edx
801009ef:	c1 fa 08             	sar    $0x8,%edx
801009f2:	89 d0                	mov    %edx,%eax
801009f4:	ba d5 03 00 00       	mov    $0x3d5,%edx
801009f9:	ee                   	out    %al,(%dx)
801009fa:	b8 0f 00 00 00       	mov    $0xf,%eax
801009ff:	89 da                	mov    %ebx,%edx
80100a01:	ee                   	out    %al,(%dx)
80100a02:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100a07:	89 c8                	mov    %ecx,%eax
80100a09:	ee                   	out    %al,(%dx)
  while((c = getc()) >= 0){
80100a0a:	ff d6                	call   *%esi
80100a0c:	85 c0                	test   %eax,%eax
80100a0e:	0f 89 c1 fe ff ff    	jns    801008d5 <consoleintr+0x25>
80100a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100a18:	83 ec 0c             	sub    $0xc,%esp
80100a1b:	68 40 ef 10 80       	push   $0x8010ef40
80100a20:	e8 7b 3e 00 00       	call   801048a0 <release>
  if(doprocdump) {
80100a25:	83 c4 10             	add    $0x10,%esp
80100a28:	85 ff                	test   %edi,%edi
80100a2a:	0f 85 f0 01 00 00    	jne    80100c20 <consoleintr+0x370>
}
80100a30:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a33:	5b                   	pop    %ebx
80100a34:	5e                   	pop    %esi
80100a35:	5f                   	pop    %edi
80100a36:	5d                   	pop    %ebp
80100a37:	c3                   	ret
      while(input.e != input.w &&
80100a38:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100a3d:	3b 05 24 ef 10 80    	cmp    0x8010ef24,%eax
80100a43:	0f 84 82 fe ff ff    	je     801008cb <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a49:	83 e8 01             	sub    $0x1,%eax
80100a4c:	89 c2                	mov    %eax,%edx
80100a4e:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a51:	80 ba a0 ee 10 80 0a 	cmpb   $0xa,-0x7fef1160(%edx)
80100a58:	0f 84 6d fe ff ff    	je     801008cb <consoleintr+0x1b>
  if(panicked){
80100a5e:	8b 1d 78 ef 10 80    	mov    0x8010ef78,%ebx
        input.e--;
80100a64:	a3 28 ef 10 80       	mov    %eax,0x8010ef28
  if(panicked){
80100a69:	85 db                	test   %ebx,%ebx
80100a6b:	0f 84 14 01 00 00    	je     80100b85 <consoleintr+0x2d5>
  asm volatile("cli");
80100a71:	fa                   	cli
    for(;;)
80100a72:	eb fe                	jmp    80100a72 <consoleintr+0x1c2>
80100a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(input.e != input.w){
80100a78:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100a7d:	3b 05 24 ef 10 80    	cmp    0x8010ef24,%eax
80100a83:	0f 84 42 fe ff ff    	je     801008cb <consoleintr+0x1b>
  if(panicked){
80100a89:	8b 0d 78 ef 10 80    	mov    0x8010ef78,%ecx
        input.e--;
80100a8f:	83 e8 01             	sub    $0x1,%eax
80100a92:	a3 28 ef 10 80       	mov    %eax,0x8010ef28
  if(panicked){
80100a97:	85 c9                	test   %ecx,%ecx
80100a99:	0f 84 2b 01 00 00    	je     80100bca <consoleintr+0x31a>
80100a9f:	fa                   	cli
    for(;;)
80100aa0:	eb fe                	jmp    80100aa0 <consoleintr+0x1f0>
80100aa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cgaputc('0' + input.e);
80100aa8:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100aad:	83 c0 30             	add    $0x30,%eax
80100ab0:	e8 4b f9 ff ff       	call   80100400 <cgaputc>
      cgaputc('0' + input.w);
80100ab5:	a1 24 ef 10 80       	mov    0x8010ef24,%eax
80100aba:	83 c0 30             	add    $0x30,%eax
80100abd:	e8 3e f9 ff ff       	call   80100400 <cgaputc>
      cgaputc('0' + input.r);
80100ac2:	a1 20 ef 10 80       	mov    0x8010ef20,%eax
80100ac7:	83 c0 30             	add    $0x30,%eax
80100aca:	e8 31 f9 ff ff       	call   80100400 <cgaputc>
      cgaputc('0' + left_key_pressed);
80100acf:	a1 80 ee 10 80       	mov    0x8010ee80,%eax
80100ad4:	83 c0 30             	add    $0x30,%eax
80100ad7:	e8 24 f9 ff ff       	call   80100400 <cgaputc>
      break;
80100adc:	e9 ea fd ff ff       	jmp    801008cb <consoleintr+0x1b>
80100ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (input.w < (input.e))
80100ae8:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100aed:	39 05 24 ef 10 80    	cmp    %eax,0x8010ef24
80100af3:	0f 83 d2 fd ff ff    	jae    801008cb <consoleintr+0x1b>
          input.e--;
80100af9:	83 e8 01             	sub    $0x1,%eax
          uartputc('\b');
80100afc:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100aff:	bb d4 03 00 00       	mov    $0x3d4,%ebx
          left_key_pressed++;
80100b04:	83 05 80 ee 10 80 01 	addl   $0x1,0x8010ee80
          input.e--;
80100b0b:	a3 28 ef 10 80       	mov    %eax,0x8010ef28
          uartputc('\b');
80100b10:	6a 08                	push   $0x8
80100b12:	e8 f9 54 00 00       	call   80106010 <uartputc>
80100b17:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b1c:	89 da                	mov    %ebx,%edx
80100b1e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b1f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100b24:	89 ca                	mov    %ecx,%edx
80100b26:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100b27:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b2a:	89 da                	mov    %ebx,%edx
80100b2c:	c1 e0 08             	shl    $0x8,%eax
80100b2f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100b32:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b37:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b38:	89 ca                	mov    %ecx,%edx
80100b3a:	ec                   	in     (%dx),%al
  if(pos>0)
80100b3b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  pos |= inb(CRTPORT+1);
80100b3e:	0f b6 c0             	movzbl %al,%eax
  if(pos>0)
80100b41:	83 c4 10             	add    $0x10,%esp
80100b44:	09 d8                	or     %ebx,%eax
80100b46:	0f 84 e0 00 00 00    	je     80100c2c <consoleintr+0x37c>
    pos--;
80100b4c:	83 e8 01             	sub    $0x1,%eax
  outb(CRTPORT+1, pos>>8);
80100b4f:	0f b6 dc             	movzbl %ah,%ebx
  outb(CRTPORT+1, pos);
80100b52:	88 45 e3             	mov    %al,-0x1d(%ebp)
  outb(CRTPORT+1, pos>>8);
80100b55:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b58:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100b5d:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b62:	89 da                	mov    %ebx,%edx
80100b64:	ee                   	out    %al,(%dx)
80100b65:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100b6a:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
80100b6e:	89 ca                	mov    %ecx,%edx
80100b70:	ee                   	out    %al,(%dx)
80100b71:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b76:	89 da                	mov    %ebx,%edx
80100b78:	ee                   	out    %al,(%dx)
80100b79:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
80100b7d:	89 ca                	mov    %ecx,%edx
80100b7f:	ee                   	out    %al,(%dx)
}
80100b80:	e9 46 fd ff ff       	jmp    801008cb <consoleintr+0x1b>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100b85:	83 ec 0c             	sub    $0xc,%esp
80100b88:	6a 08                	push   $0x8
80100b8a:	e8 81 54 00 00       	call   80106010 <uartputc>
80100b8f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100b96:	e8 75 54 00 00       	call   80106010 <uartputc>
80100b9b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100ba2:	e8 69 54 00 00       	call   80106010 <uartputc>
  cgaputc(c);
80100ba7:	b8 00 01 00 00       	mov    $0x100,%eax
80100bac:	e8 4f f8 ff ff       	call   80100400 <cgaputc>
      while(input.e != input.w &&
80100bb1:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100bb6:	83 c4 10             	add    $0x10,%esp
80100bb9:	3b 05 24 ef 10 80    	cmp    0x8010ef24,%eax
80100bbf:	0f 85 84 fe ff ff    	jne    80100a49 <consoleintr+0x199>
80100bc5:	e9 01 fd ff ff       	jmp    801008cb <consoleintr+0x1b>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100bca:	83 ec 0c             	sub    $0xc,%esp
80100bcd:	6a 08                	push   $0x8
80100bcf:	e8 3c 54 00 00       	call   80106010 <uartputc>
80100bd4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100bdb:	e8 30 54 00 00       	call   80106010 <uartputc>
80100be0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100be7:	e8 24 54 00 00       	call   80106010 <uartputc>
  cgaputc(c);
80100bec:	b8 00 01 00 00       	mov    $0x100,%eax
80100bf1:	e8 0a f8 ff ff       	call   80100400 <cgaputc>
}
80100bf6:	83 c4 10             	add    $0x10,%esp
80100bf9:	e9 cd fc ff ff       	jmp    801008cb <consoleintr+0x1b>
    switch(c){
80100bfe:	bf 01 00 00 00       	mov    $0x1,%edi
80100c03:	e9 c3 fc ff ff       	jmp    801008cb <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100c08:	88 83 a0 ee 10 80    	mov    %al,-0x7fef1160(%ebx)
  if(panicked){
80100c0e:	85 c9                	test   %ecx,%ecx
80100c10:	0f 84 9e 00 00 00    	je     80100cb4 <consoleintr+0x404>
  asm volatile("cli");
80100c16:	fa                   	cli
    for(;;)
80100c17:	eb fe                	jmp    80100c17 <consoleintr+0x367>
80100c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80100c20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c23:	5b                   	pop    %ebx
80100c24:	5e                   	pop    %esi
80100c25:	5f                   	pop    %edi
80100c26:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100c27:	e9 f4 38 00 00       	jmp    80104520 <procdump>
80100c2c:	c6 45 e3 00          	movb   $0x0,-0x1d(%ebp)
80100c30:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
80100c34:	e9 1f ff ff ff       	jmp    80100b58 <consoleintr+0x2a8>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100c39:	8b 0d 28 ef 10 80    	mov    0x8010ef28,%ecx
80100c3f:	89 ca                	mov    %ecx,%edx
80100c41:	2b 15 20 ef 10 80    	sub    0x8010ef20,%edx
80100c47:	83 fa 7f             	cmp    $0x7f,%edx
80100c4a:	0f 87 7b fc ff ff    	ja     801008cb <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100c50:	8d 51 01             	lea    0x1(%ecx),%edx
80100c53:	89 cb                	mov    %ecx,%ebx
  if(panicked){
80100c55:	8b 0d 78 ef 10 80    	mov    0x8010ef78,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
80100c5b:	89 15 28 ef 10 80    	mov    %edx,0x8010ef28
80100c61:	83 e3 7f             	and    $0x7f,%ebx
        c = (c == '\r') ? '\n' : c;
80100c64:	83 f8 0d             	cmp    $0xd,%eax
80100c67:	75 9f                	jne    80100c08 <consoleintr+0x358>
        input.buf[input.e++ % INPUT_BUF] = c;
80100c69:	c6 83 a0 ee 10 80 0a 	movb   $0xa,-0x7fef1160(%ebx)
  if(panicked){
80100c70:	85 c9                	test   %ecx,%ecx
80100c72:	75 a2                	jne    80100c16 <consoleintr+0x366>
    uartputc(c);
80100c74:	83 ec 0c             	sub    $0xc,%esp
80100c77:	6a 0a                	push   $0xa
80100c79:	e8 92 53 00 00       	call   80106010 <uartputc>
  cgaputc(c);
80100c7e:	b8 0a 00 00 00       	mov    $0xa,%eax
80100c83:	e8 78 f7 ff ff       	call   80100400 <cgaputc>
          input.w = input.e;
80100c88:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100c8d:	83 c4 10             	add    $0x10,%esp
          wakeup(&input.r);
80100c90:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100c93:	a3 24 ef 10 80       	mov    %eax,0x8010ef24
          left_key_pressed=0;
80100c98:	c7 05 80 ee 10 80 00 	movl   $0x0,0x8010ee80
80100c9f:	00 00 00 
          wakeup(&input.r);
80100ca2:	68 20 ef 10 80       	push   $0x8010ef20
80100ca7:	e8 94 37 00 00       	call   80104440 <wakeup>
80100cac:	83 c4 10             	add    $0x10,%esp
80100caf:	e9 17 fc ff ff       	jmp    801008cb <consoleintr+0x1b>
    uartputc(c);
80100cb4:	83 ec 0c             	sub    $0xc,%esp
80100cb7:	50                   	push   %eax
80100cb8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100cbb:	e8 50 53 00 00       	call   80106010 <uartputc>
  cgaputc(c);
80100cc0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100cc3:	e8 38 f7 ff ff       	call   80100400 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100cc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ccb:	83 c4 10             	add    $0x10,%esp
80100cce:	83 f8 0a             	cmp    $0xa,%eax
80100cd1:	0f 85 a5 fc ff ff    	jne    8010097c <consoleintr+0xcc>
80100cd7:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100cdc:	eb b2                	jmp    80100c90 <consoleintr+0x3e0>
80100cde:	66 90                	xchg   %ax,%ax

80100ce0 <consoleinit>:
{
80100ce0:	55                   	push   %ebp
80100ce1:	89 e5                	mov    %esp,%ebp
80100ce3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100ce6:	68 28 75 10 80       	push   $0x80107528
80100ceb:	68 40 ef 10 80       	push   $0x8010ef40
80100cf0:	e8 1b 3a 00 00       	call   80104710 <initlock>
  ioapicenable(IRQ_KBD, 0);
80100cf5:	58                   	pop    %eax
80100cf6:	5a                   	pop    %edx
80100cf7:	6a 00                	push   $0x0
80100cf9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100cfb:	c7 05 2c f9 10 80 40 	movl   $0x80100540,0x8010f92c
80100d02:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100d05:	c7 05 28 f9 10 80 80 	movl   $0x80100280,0x8010f928
80100d0c:	02 10 80 
  cons.locking = 1;
80100d0f:	c7 05 74 ef 10 80 01 	movl   $0x1,0x8010ef74
80100d16:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100d19:	e8 a2 1a 00 00       	call   801027c0 <ioapicenable>
}
80100d1e:	83 c4 10             	add    $0x10,%esp
80100d21:	c9                   	leave
80100d22:	c3                   	ret
80100d23:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d2a:	00 
80100d2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100d30 <move_cursor_left>:
void move_cursor_left(){
80100d30:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d31:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d36:	89 e5                	mov    %esp,%ebp
80100d38:	57                   	push   %edi
80100d39:	56                   	push   %esi
80100d3a:	be d4 03 00 00       	mov    $0x3d4,%esi
80100d3f:	53                   	push   %ebx
80100d40:	89 f2                	mov    %esi,%edx
80100d42:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d43:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100d48:	89 da                	mov    %ebx,%edx
80100d4a:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100d4b:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d4e:	89 f2                	mov    %esi,%edx
80100d50:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d55:	c1 e1 08             	shl    $0x8,%ecx
80100d58:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d59:	89 da                	mov    %ebx,%edx
80100d5b:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100d5c:	0f b6 c0             	movzbl %al,%eax
  if(pos>0)
80100d5f:	09 c8                	or     %ecx,%eax
80100d61:	74 35                	je     80100d98 <move_cursor_left+0x68>
    pos--;
80100d63:	8d 48 ff             	lea    -0x1(%eax),%ecx
  outb(CRTPORT+1, pos>>8);
80100d66:	0f b6 f5             	movzbl %ch,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d69:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100d6e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d73:	89 fa                	mov    %edi,%edx
80100d75:	ee                   	out    %al,(%dx)
80100d76:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100d7b:	89 f0                	mov    %esi,%eax
80100d7d:	89 da                	mov    %ebx,%edx
80100d7f:	ee                   	out    %al,(%dx)
80100d80:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d85:	89 fa                	mov    %edi,%edx
80100d87:	ee                   	out    %al,(%dx)
80100d88:	89 c8                	mov    %ecx,%eax
80100d8a:	89 da                	mov    %ebx,%edx
80100d8c:	ee                   	out    %al,(%dx)
}
80100d8d:	5b                   	pop    %ebx
80100d8e:	5e                   	pop    %esi
80100d8f:	5f                   	pop    %edi
80100d90:	5d                   	pop    %ebp
80100d91:	c3                   	ret
80100d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100d98:	31 c9                	xor    %ecx,%ecx
80100d9a:	31 f6                	xor    %esi,%esi
80100d9c:	eb cb                	jmp    80100d69 <move_cursor_left+0x39>
80100d9e:	66 90                	xchg   %ax,%ax

80100da0 <move_cursor_right>:
void move_cursor_right(void) {
80100da0:	55                   	push   %ebp
80100da1:	89 e5                	mov    %esp,%ebp
80100da3:	57                   	push   %edi
80100da4:	bf 0e 00 00 00       	mov    $0xe,%edi
80100da9:	56                   	push   %esi
80100daa:	89 f8                	mov    %edi,%eax
80100dac:	53                   	push   %ebx
80100dad:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100db2:	89 da                	mov    %ebx,%edx
80100db4:	83 ec 04             	sub    $0x4,%esp
80100db7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100db8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100dbd:	89 ca                	mov    %ecx,%edx
80100dbf:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100dc0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100dc3:	be 0f 00 00 00       	mov    $0xf,%esi
80100dc8:	89 da                	mov    %ebx,%edx
80100dca:	c1 e0 08             	shl    $0x8,%eax
80100dcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100dd0:	89 f0                	mov    %esi,%eax
80100dd2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100dd3:	89 ca                	mov    %ecx,%edx
80100dd5:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100dd6:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100dd9:	0f b6 c0             	movzbl %al,%eax
80100ddc:	09 d0                	or     %edx,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100dde:	89 da                	mov    %ebx,%edx
    pos++;
80100de0:	83 c0 01             	add    $0x1,%eax
80100de3:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100de6:	89 f8                	mov    %edi,%eax
80100de8:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80100de9:	8b 7d f0             	mov    -0x10(%ebp),%edi
80100dec:	89 ca                	mov    %ecx,%edx
80100dee:	89 f8                	mov    %edi,%eax
80100df0:	c1 f8 08             	sar    $0x8,%eax
80100df3:	ee                   	out    %al,(%dx)
80100df4:	89 f0                	mov    %esi,%eax
80100df6:	89 da                	mov    %ebx,%edx
80100df8:	ee                   	out    %al,(%dx)
80100df9:	89 f8                	mov    %edi,%eax
80100dfb:	89 ca                	mov    %ecx,%edx
80100dfd:	ee                   	out    %al,(%dx)
    outb(CRTPORT, 15);
    outb(CRTPORT+1, pos);
}
80100dfe:	83 c4 04             	add    $0x4,%esp
80100e01:	5b                   	pop    %ebx
80100e02:	5e                   	pop    %esi
80100e03:	5f                   	pop    %edi
80100e04:	5d                   	pop    %ebp
80100e05:	c3                   	ret
80100e06:	66 90                	xchg   %ax,%ax
80100e08:	66 90                	xchg   %ax,%ax
80100e0a:	66 90                	xchg   %ax,%ax
80100e0c:	66 90                	xchg   %ax,%ax
80100e0e:	66 90                	xchg   %ax,%ax

80100e10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	57                   	push   %edi
80100e14:	56                   	push   %esi
80100e15:	53                   	push   %ebx
80100e16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100e1c:	e8 9f 2e 00 00       	call   80103cc0 <myproc>
80100e21:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100e27:	e8 74 22 00 00       	call   801030a0 <begin_op>

  if((ip = namei(path)) == 0){
80100e2c:	83 ec 0c             	sub    $0xc,%esp
80100e2f:	ff 75 08             	push   0x8(%ebp)
80100e32:	e8 a9 15 00 00       	call   801023e0 <namei>
80100e37:	83 c4 10             	add    $0x10,%esp
80100e3a:	85 c0                	test   %eax,%eax
80100e3c:	0f 84 30 03 00 00    	je     80101172 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100e42:	83 ec 0c             	sub    $0xc,%esp
80100e45:	89 c7                	mov    %eax,%edi
80100e47:	50                   	push   %eax
80100e48:	e8 b3 0c 00 00       	call   80101b00 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100e4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100e53:	6a 34                	push   $0x34
80100e55:	6a 00                	push   $0x0
80100e57:	50                   	push   %eax
80100e58:	57                   	push   %edi
80100e59:	e8 b2 0f 00 00       	call   80101e10 <readi>
80100e5e:	83 c4 20             	add    $0x20,%esp
80100e61:	83 f8 34             	cmp    $0x34,%eax
80100e64:	0f 85 01 01 00 00    	jne    80100f6b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100e6a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100e71:	45 4c 46 
80100e74:	0f 85 f1 00 00 00    	jne    80100f6b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100e7a:	e8 01 63 00 00       	call   80107180 <setupkvm>
80100e7f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100e85:	85 c0                	test   %eax,%eax
80100e87:	0f 84 de 00 00 00    	je     80100f6b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e8d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100e94:	00 
80100e95:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100e9b:	0f 84 a1 02 00 00    	je     80101142 <exec+0x332>
  sz = 0;
80100ea1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100ea8:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100eab:	31 db                	xor    %ebx,%ebx
80100ead:	e9 8c 00 00 00       	jmp    80100f3e <exec+0x12e>
80100eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100eb8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ebf:	75 6c                	jne    80100f2d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100ec1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ec7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ecd:	0f 82 87 00 00 00    	jb     80100f5a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ed3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ed9:	72 7f                	jb     80100f5a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100edb:	83 ec 04             	sub    $0x4,%esp
80100ede:	50                   	push   %eax
80100edf:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100ee5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100eeb:	e8 c0 60 00 00       	call   80106fb0 <allocuvm>
80100ef0:	83 c4 10             	add    $0x10,%esp
80100ef3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ef9:	85 c0                	test   %eax,%eax
80100efb:	74 5d                	je     80100f5a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100efd:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100f03:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100f08:	75 50                	jne    80100f5a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100f0a:	83 ec 0c             	sub    $0xc,%esp
80100f0d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100f13:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100f19:	57                   	push   %edi
80100f1a:	50                   	push   %eax
80100f1b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100f21:	e8 ba 5f 00 00       	call   80106ee0 <loaduvm>
80100f26:	83 c4 20             	add    $0x20,%esp
80100f29:	85 c0                	test   %eax,%eax
80100f2b:	78 2d                	js     80100f5a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f2d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100f34:	83 c3 01             	add    $0x1,%ebx
80100f37:	83 c6 20             	add    $0x20,%esi
80100f3a:	39 d8                	cmp    %ebx,%eax
80100f3c:	7e 52                	jle    80100f90 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100f3e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100f44:	6a 20                	push   $0x20
80100f46:	56                   	push   %esi
80100f47:	50                   	push   %eax
80100f48:	57                   	push   %edi
80100f49:	e8 c2 0e 00 00       	call   80101e10 <readi>
80100f4e:	83 c4 10             	add    $0x10,%esp
80100f51:	83 f8 20             	cmp    $0x20,%eax
80100f54:	0f 84 5e ff ff ff    	je     80100eb8 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100f5a:	83 ec 0c             	sub    $0xc,%esp
80100f5d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100f63:	e8 98 61 00 00       	call   80107100 <freevm>
  if(ip){
80100f68:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100f6b:	83 ec 0c             	sub    $0xc,%esp
80100f6e:	57                   	push   %edi
80100f6f:	e8 1c 0e 00 00       	call   80101d90 <iunlockput>
    end_op();
80100f74:	e8 97 21 00 00       	call   80103110 <end_op>
80100f79:	83 c4 10             	add    $0x10,%esp
    return -1;
80100f7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100f81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f84:	5b                   	pop    %ebx
80100f85:	5e                   	pop    %esi
80100f86:	5f                   	pop    %edi
80100f87:	5d                   	pop    %ebp
80100f88:	c3                   	ret
80100f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100f90:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100f96:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100f9c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100fa2:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	57                   	push   %edi
80100fac:	e8 df 0d 00 00       	call   80101d90 <iunlockput>
  end_op();
80100fb1:	e8 5a 21 00 00       	call   80103110 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100fb6:	83 c4 0c             	add    $0xc,%esp
80100fb9:	53                   	push   %ebx
80100fba:	56                   	push   %esi
80100fbb:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100fc1:	56                   	push   %esi
80100fc2:	e8 e9 5f 00 00       	call   80106fb0 <allocuvm>
80100fc7:	83 c4 10             	add    $0x10,%esp
80100fca:	89 c7                	mov    %eax,%edi
80100fcc:	85 c0                	test   %eax,%eax
80100fce:	0f 84 86 00 00 00    	je     8010105a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100fd4:	83 ec 08             	sub    $0x8,%esp
80100fd7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100fdd:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100fdf:	50                   	push   %eax
80100fe0:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100fe1:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100fe3:	e8 38 62 00 00       	call   80107220 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100feb:	83 c4 10             	add    $0x10,%esp
80100fee:	8b 10                	mov    (%eax),%edx
80100ff0:	85 d2                	test   %edx,%edx
80100ff2:	0f 84 56 01 00 00    	je     8010114e <exec+0x33e>
80100ff8:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100ffe:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101001:	eb 23                	jmp    80101026 <exec+0x216>
80101003:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101008:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
8010100b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80101012:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80101018:	8b 14 87             	mov    (%edi,%eax,4),%edx
8010101b:	85 d2                	test   %edx,%edx
8010101d:	74 51                	je     80101070 <exec+0x260>
    if(argc >= MAXARG)
8010101f:	83 f8 20             	cmp    $0x20,%eax
80101022:	74 36                	je     8010105a <exec+0x24a>
80101024:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101026:	83 ec 0c             	sub    $0xc,%esp
80101029:	52                   	push   %edx
8010102a:	e8 c1 3b 00 00       	call   80104bf0 <strlen>
8010102f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101031:	58                   	pop    %eax
80101032:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101035:	83 eb 01             	sub    $0x1,%ebx
80101038:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010103b:	e8 b0 3b 00 00       	call   80104bf0 <strlen>
80101040:	83 c0 01             	add    $0x1,%eax
80101043:	50                   	push   %eax
80101044:	ff 34 b7             	push   (%edi,%esi,4)
80101047:	53                   	push   %ebx
80101048:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010104e:	e8 9d 63 00 00       	call   801073f0 <copyout>
80101053:	83 c4 20             	add    $0x20,%esp
80101056:	85 c0                	test   %eax,%eax
80101058:	79 ae                	jns    80101008 <exec+0x1f8>
    freevm(pgdir);
8010105a:	83 ec 0c             	sub    $0xc,%esp
8010105d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101063:	e8 98 60 00 00       	call   80107100 <freevm>
80101068:	83 c4 10             	add    $0x10,%esp
8010106b:	e9 0c ff ff ff       	jmp    80100f7c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101070:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80101077:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
8010107d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101083:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80101086:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80101089:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80101090:	00 00 00 00 
  ustack[1] = argc;
80101094:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
8010109a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
801010a1:	ff ff ff 
  ustack[1] = argc;
801010a4:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801010aa:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
801010ac:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801010ae:	29 d0                	sub    %edx,%eax
801010b0:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801010b6:	56                   	push   %esi
801010b7:	51                   	push   %ecx
801010b8:	53                   	push   %ebx
801010b9:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801010bf:	e8 2c 63 00 00       	call   801073f0 <copyout>
801010c4:	83 c4 10             	add    $0x10,%esp
801010c7:	85 c0                	test   %eax,%eax
801010c9:	78 8f                	js     8010105a <exec+0x24a>
  for(last=s=path; *s; s++)
801010cb:	8b 45 08             	mov    0x8(%ebp),%eax
801010ce:	8b 55 08             	mov    0x8(%ebp),%edx
801010d1:	0f b6 00             	movzbl (%eax),%eax
801010d4:	84 c0                	test   %al,%al
801010d6:	74 17                	je     801010ef <exec+0x2df>
801010d8:	89 d1                	mov    %edx,%ecx
801010da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
801010e0:	83 c1 01             	add    $0x1,%ecx
801010e3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
801010e5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
801010e8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
801010eb:	84 c0                	test   %al,%al
801010ed:	75 f1                	jne    801010e0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
801010ef:	83 ec 04             	sub    $0x4,%esp
801010f2:	6a 10                	push   $0x10
801010f4:	52                   	push   %edx
801010f5:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
801010fb:	8d 46 6c             	lea    0x6c(%esi),%eax
801010fe:	50                   	push   %eax
801010ff:	e8 ac 3a 00 00       	call   80104bb0 <safestrcpy>
  curproc->pgdir = pgdir;
80101104:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010110a:	89 f0                	mov    %esi,%eax
8010110c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
8010110f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80101111:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101114:	89 c1                	mov    %eax,%ecx
80101116:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010111c:	8b 40 18             	mov    0x18(%eax),%eax
8010111f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101122:	8b 41 18             	mov    0x18(%ecx),%eax
80101125:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101128:	89 0c 24             	mov    %ecx,(%esp)
8010112b:	e8 20 5c 00 00       	call   80106d50 <switchuvm>
  freevm(oldpgdir);
80101130:	89 34 24             	mov    %esi,(%esp)
80101133:	e8 c8 5f 00 00       	call   80107100 <freevm>
  return 0;
80101138:	83 c4 10             	add    $0x10,%esp
8010113b:	31 c0                	xor    %eax,%eax
8010113d:	e9 3f fe ff ff       	jmp    80100f81 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101142:	bb 00 20 00 00       	mov    $0x2000,%ebx
80101147:	31 f6                	xor    %esi,%esi
80101149:	e9 5a fe ff ff       	jmp    80100fa8 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
8010114e:	be 10 00 00 00       	mov    $0x10,%esi
80101153:	ba 04 00 00 00       	mov    $0x4,%edx
80101158:	b8 03 00 00 00       	mov    $0x3,%eax
8010115d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101164:	00 00 00 
80101167:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
8010116d:	e9 17 ff ff ff       	jmp    80101089 <exec+0x279>
    end_op();
80101172:	e8 99 1f 00 00       	call   80103110 <end_op>
    cprintf("exec: fail\n");
80101177:	83 ec 0c             	sub    $0xc,%esp
8010117a:	68 30 75 10 80       	push   $0x80107530
8010117f:	e8 dc f4 ff ff       	call   80100660 <cprintf>
    return -1;
80101184:	83 c4 10             	add    $0x10,%esp
80101187:	e9 f0 fd ff ff       	jmp    80100f7c <exec+0x16c>
8010118c:	66 90                	xchg   %ax,%ax
8010118e:	66 90                	xchg   %ax,%ax

80101190 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101190:	55                   	push   %ebp
80101191:	89 e5                	mov    %esp,%ebp
80101193:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101196:	68 3c 75 10 80       	push   $0x8010753c
8010119b:	68 80 ef 10 80       	push   $0x8010ef80
801011a0:	e8 6b 35 00 00       	call   80104710 <initlock>
}
801011a5:	83 c4 10             	add    $0x10,%esp
801011a8:	c9                   	leave
801011a9:	c3                   	ret
801011aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801011b0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801011b0:	55                   	push   %ebp
801011b1:	89 e5                	mov    %esp,%ebp
801011b3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801011b4:	bb b4 ef 10 80       	mov    $0x8010efb4,%ebx
{
801011b9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801011bc:	68 80 ef 10 80       	push   $0x8010ef80
801011c1:	e8 3a 37 00 00       	call   80104900 <acquire>
801011c6:	83 c4 10             	add    $0x10,%esp
801011c9:	eb 10                	jmp    801011db <filealloc+0x2b>
801011cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801011d0:	83 c3 18             	add    $0x18,%ebx
801011d3:	81 fb 14 f9 10 80    	cmp    $0x8010f914,%ebx
801011d9:	74 25                	je     80101200 <filealloc+0x50>
    if(f->ref == 0){
801011db:	8b 43 04             	mov    0x4(%ebx),%eax
801011de:	85 c0                	test   %eax,%eax
801011e0:	75 ee                	jne    801011d0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
801011e2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
801011e5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
801011ec:	68 80 ef 10 80       	push   $0x8010ef80
801011f1:	e8 aa 36 00 00       	call   801048a0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
801011f6:	89 d8                	mov    %ebx,%eax
      return f;
801011f8:	83 c4 10             	add    $0x10,%esp
}
801011fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801011fe:	c9                   	leave
801011ff:	c3                   	ret
  release(&ftable.lock);
80101200:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101203:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101205:	68 80 ef 10 80       	push   $0x8010ef80
8010120a:	e8 91 36 00 00       	call   801048a0 <release>
}
8010120f:	89 d8                	mov    %ebx,%eax
  return 0;
80101211:	83 c4 10             	add    $0x10,%esp
}
80101214:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101217:	c9                   	leave
80101218:	c3                   	ret
80101219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101220 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	53                   	push   %ebx
80101224:	83 ec 10             	sub    $0x10,%esp
80101227:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010122a:	68 80 ef 10 80       	push   $0x8010ef80
8010122f:	e8 cc 36 00 00       	call   80104900 <acquire>
  if(f->ref < 1)
80101234:	8b 43 04             	mov    0x4(%ebx),%eax
80101237:	83 c4 10             	add    $0x10,%esp
8010123a:	85 c0                	test   %eax,%eax
8010123c:	7e 1a                	jle    80101258 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010123e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101241:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101244:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101247:	68 80 ef 10 80       	push   $0x8010ef80
8010124c:	e8 4f 36 00 00       	call   801048a0 <release>
  return f;
}
80101251:	89 d8                	mov    %ebx,%eax
80101253:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101256:	c9                   	leave
80101257:	c3                   	ret
    panic("filedup");
80101258:	83 ec 0c             	sub    $0xc,%esp
8010125b:	68 43 75 10 80       	push   $0x80107543
80101260:	e8 1b f1 ff ff       	call   80100380 <panic>
80101265:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010126c:	00 
8010126d:	8d 76 00             	lea    0x0(%esi),%esi

80101270 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101270:	55                   	push   %ebp
80101271:	89 e5                	mov    %esp,%ebp
80101273:	57                   	push   %edi
80101274:	56                   	push   %esi
80101275:	53                   	push   %ebx
80101276:	83 ec 28             	sub    $0x28,%esp
80101279:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010127c:	68 80 ef 10 80       	push   $0x8010ef80
80101281:	e8 7a 36 00 00       	call   80104900 <acquire>
  if(f->ref < 1)
80101286:	8b 53 04             	mov    0x4(%ebx),%edx
80101289:	83 c4 10             	add    $0x10,%esp
8010128c:	85 d2                	test   %edx,%edx
8010128e:	0f 8e a5 00 00 00    	jle    80101339 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101294:	83 ea 01             	sub    $0x1,%edx
80101297:	89 53 04             	mov    %edx,0x4(%ebx)
8010129a:	75 44                	jne    801012e0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010129c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801012a0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801012a3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801012a5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801012ab:	8b 73 0c             	mov    0xc(%ebx),%esi
801012ae:	88 45 e7             	mov    %al,-0x19(%ebp)
801012b1:	8b 43 10             	mov    0x10(%ebx),%eax
801012b4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801012b7:	68 80 ef 10 80       	push   $0x8010ef80
801012bc:	e8 df 35 00 00       	call   801048a0 <release>

  if(ff.type == FD_PIPE)
801012c1:	83 c4 10             	add    $0x10,%esp
801012c4:	83 ff 01             	cmp    $0x1,%edi
801012c7:	74 57                	je     80101320 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801012c9:	83 ff 02             	cmp    $0x2,%edi
801012cc:	74 2a                	je     801012f8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801012ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d1:	5b                   	pop    %ebx
801012d2:	5e                   	pop    %esi
801012d3:	5f                   	pop    %edi
801012d4:	5d                   	pop    %ebp
801012d5:	c3                   	ret
801012d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801012dd:	00 
801012de:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
801012e0:	c7 45 08 80 ef 10 80 	movl   $0x8010ef80,0x8(%ebp)
}
801012e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ea:	5b                   	pop    %ebx
801012eb:	5e                   	pop    %esi
801012ec:	5f                   	pop    %edi
801012ed:	5d                   	pop    %ebp
    release(&ftable.lock);
801012ee:	e9 ad 35 00 00       	jmp    801048a0 <release>
801012f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
801012f8:	e8 a3 1d 00 00       	call   801030a0 <begin_op>
    iput(ff.ip);
801012fd:	83 ec 0c             	sub    $0xc,%esp
80101300:	ff 75 e0             	push   -0x20(%ebp)
80101303:	e8 28 09 00 00       	call   80101c30 <iput>
    end_op();
80101308:	83 c4 10             	add    $0x10,%esp
}
8010130b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010130e:	5b                   	pop    %ebx
8010130f:	5e                   	pop    %esi
80101310:	5f                   	pop    %edi
80101311:	5d                   	pop    %ebp
    end_op();
80101312:	e9 f9 1d 00 00       	jmp    80103110 <end_op>
80101317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010131e:	00 
8010131f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101320:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101324:	83 ec 08             	sub    $0x8,%esp
80101327:	53                   	push   %ebx
80101328:	56                   	push   %esi
80101329:	e8 32 25 00 00       	call   80103860 <pipeclose>
8010132e:	83 c4 10             	add    $0x10,%esp
}
80101331:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101334:	5b                   	pop    %ebx
80101335:	5e                   	pop    %esi
80101336:	5f                   	pop    %edi
80101337:	5d                   	pop    %ebp
80101338:	c3                   	ret
    panic("fileclose");
80101339:	83 ec 0c             	sub    $0xc,%esp
8010133c:	68 4b 75 10 80       	push   $0x8010754b
80101341:	e8 3a f0 ff ff       	call   80100380 <panic>
80101346:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010134d:	00 
8010134e:	66 90                	xchg   %ax,%ax

80101350 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	53                   	push   %ebx
80101354:	83 ec 04             	sub    $0x4,%esp
80101357:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010135a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010135d:	75 31                	jne    80101390 <filestat+0x40>
    ilock(f->ip);
8010135f:	83 ec 0c             	sub    $0xc,%esp
80101362:	ff 73 10             	push   0x10(%ebx)
80101365:	e8 96 07 00 00       	call   80101b00 <ilock>
    stati(f->ip, st);
8010136a:	58                   	pop    %eax
8010136b:	5a                   	pop    %edx
8010136c:	ff 75 0c             	push   0xc(%ebp)
8010136f:	ff 73 10             	push   0x10(%ebx)
80101372:	e8 69 0a 00 00       	call   80101de0 <stati>
    iunlock(f->ip);
80101377:	59                   	pop    %ecx
80101378:	ff 73 10             	push   0x10(%ebx)
8010137b:	e8 60 08 00 00       	call   80101be0 <iunlock>
    return 0;
  }
  return -1;
}
80101380:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101383:	83 c4 10             	add    $0x10,%esp
80101386:	31 c0                	xor    %eax,%eax
}
80101388:	c9                   	leave
80101389:	c3                   	ret
8010138a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101390:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101393:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101398:	c9                   	leave
80101399:	c3                   	ret
8010139a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801013a0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	57                   	push   %edi
801013a4:	56                   	push   %esi
801013a5:	53                   	push   %ebx
801013a6:	83 ec 0c             	sub    $0xc,%esp
801013a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801013ac:	8b 75 0c             	mov    0xc(%ebp),%esi
801013af:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801013b2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801013b6:	74 60                	je     80101418 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801013b8:	8b 03                	mov    (%ebx),%eax
801013ba:	83 f8 01             	cmp    $0x1,%eax
801013bd:	74 41                	je     80101400 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801013bf:	83 f8 02             	cmp    $0x2,%eax
801013c2:	75 5b                	jne    8010141f <fileread+0x7f>
    ilock(f->ip);
801013c4:	83 ec 0c             	sub    $0xc,%esp
801013c7:	ff 73 10             	push   0x10(%ebx)
801013ca:	e8 31 07 00 00       	call   80101b00 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801013cf:	57                   	push   %edi
801013d0:	ff 73 14             	push   0x14(%ebx)
801013d3:	56                   	push   %esi
801013d4:	ff 73 10             	push   0x10(%ebx)
801013d7:	e8 34 0a 00 00       	call   80101e10 <readi>
801013dc:	83 c4 20             	add    $0x20,%esp
801013df:	89 c6                	mov    %eax,%esi
801013e1:	85 c0                	test   %eax,%eax
801013e3:	7e 03                	jle    801013e8 <fileread+0x48>
      f->off += r;
801013e5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801013e8:	83 ec 0c             	sub    $0xc,%esp
801013eb:	ff 73 10             	push   0x10(%ebx)
801013ee:	e8 ed 07 00 00       	call   80101be0 <iunlock>
    return r;
801013f3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801013f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013f9:	89 f0                	mov    %esi,%eax
801013fb:	5b                   	pop    %ebx
801013fc:	5e                   	pop    %esi
801013fd:	5f                   	pop    %edi
801013fe:	5d                   	pop    %ebp
801013ff:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101400:	8b 43 0c             	mov    0xc(%ebx),%eax
80101403:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101406:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101409:	5b                   	pop    %ebx
8010140a:	5e                   	pop    %esi
8010140b:	5f                   	pop    %edi
8010140c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010140d:	e9 0e 26 00 00       	jmp    80103a20 <piperead>
80101412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101418:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010141d:	eb d7                	jmp    801013f6 <fileread+0x56>
  panic("fileread");
8010141f:	83 ec 0c             	sub    $0xc,%esp
80101422:	68 55 75 10 80       	push   $0x80107555
80101427:	e8 54 ef ff ff       	call   80100380 <panic>
8010142c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101430 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101430:	55                   	push   %ebp
80101431:	89 e5                	mov    %esp,%ebp
80101433:	57                   	push   %edi
80101434:	56                   	push   %esi
80101435:	53                   	push   %ebx
80101436:	83 ec 1c             	sub    $0x1c,%esp
80101439:	8b 45 0c             	mov    0xc(%ebp),%eax
8010143c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010143f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101442:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101445:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101449:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010144c:	0f 84 bb 00 00 00    	je     8010150d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101452:	8b 03                	mov    (%ebx),%eax
80101454:	83 f8 01             	cmp    $0x1,%eax
80101457:	0f 84 bf 00 00 00    	je     8010151c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010145d:	83 f8 02             	cmp    $0x2,%eax
80101460:	0f 85 c8 00 00 00    	jne    8010152e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101466:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101469:	31 f6                	xor    %esi,%esi
    while(i < n){
8010146b:	85 c0                	test   %eax,%eax
8010146d:	7f 30                	jg     8010149f <filewrite+0x6f>
8010146f:	e9 94 00 00 00       	jmp    80101508 <filewrite+0xd8>
80101474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101478:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010147b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010147e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101481:	ff 73 10             	push   0x10(%ebx)
80101484:	e8 57 07 00 00       	call   80101be0 <iunlock>
      end_op();
80101489:	e8 82 1c 00 00       	call   80103110 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010148e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101491:	83 c4 10             	add    $0x10,%esp
80101494:	39 c7                	cmp    %eax,%edi
80101496:	75 5c                	jne    801014f4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101498:	01 fe                	add    %edi,%esi
    while(i < n){
8010149a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010149d:	7e 69                	jle    80101508 <filewrite+0xd8>
      int n1 = n - i;
8010149f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
801014a2:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
801014a7:	29 f7                	sub    %esi,%edi
      if(n1 > max)
801014a9:	39 c7                	cmp    %eax,%edi
801014ab:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
801014ae:	e8 ed 1b 00 00       	call   801030a0 <begin_op>
      ilock(f->ip);
801014b3:	83 ec 0c             	sub    $0xc,%esp
801014b6:	ff 73 10             	push   0x10(%ebx)
801014b9:	e8 42 06 00 00       	call   80101b00 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801014be:	57                   	push   %edi
801014bf:	ff 73 14             	push   0x14(%ebx)
801014c2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801014c5:	01 f0                	add    %esi,%eax
801014c7:	50                   	push   %eax
801014c8:	ff 73 10             	push   0x10(%ebx)
801014cb:	e8 40 0a 00 00       	call   80101f10 <writei>
801014d0:	83 c4 20             	add    $0x20,%esp
801014d3:	85 c0                	test   %eax,%eax
801014d5:	7f a1                	jg     80101478 <filewrite+0x48>
801014d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801014da:	83 ec 0c             	sub    $0xc,%esp
801014dd:	ff 73 10             	push   0x10(%ebx)
801014e0:	e8 fb 06 00 00       	call   80101be0 <iunlock>
      end_op();
801014e5:	e8 26 1c 00 00       	call   80103110 <end_op>
      if(r < 0)
801014ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
801014ed:	83 c4 10             	add    $0x10,%esp
801014f0:	85 c0                	test   %eax,%eax
801014f2:	75 14                	jne    80101508 <filewrite+0xd8>
        panic("short filewrite");
801014f4:	83 ec 0c             	sub    $0xc,%esp
801014f7:	68 5e 75 10 80       	push   $0x8010755e
801014fc:	e8 7f ee ff ff       	call   80100380 <panic>
80101501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101508:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010150b:	74 05                	je     80101512 <filewrite+0xe2>
8010150d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101512:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101515:	89 f0                	mov    %esi,%eax
80101517:	5b                   	pop    %ebx
80101518:	5e                   	pop    %esi
80101519:	5f                   	pop    %edi
8010151a:	5d                   	pop    %ebp
8010151b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
8010151c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010151f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101522:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101525:	5b                   	pop    %ebx
80101526:	5e                   	pop    %esi
80101527:	5f                   	pop    %edi
80101528:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101529:	e9 d2 23 00 00       	jmp    80103900 <pipewrite>
  panic("filewrite");
8010152e:	83 ec 0c             	sub    $0xc,%esp
80101531:	68 64 75 10 80       	push   $0x80107564
80101536:	e8 45 ee ff ff       	call   80100380 <panic>
8010153b:	66 90                	xchg   %ax,%ax
8010153d:	66 90                	xchg   %ax,%ax
8010153f:	90                   	nop

80101540 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101540:	55                   	push   %ebp
80101541:	89 e5                	mov    %esp,%ebp
80101543:	57                   	push   %edi
80101544:	56                   	push   %esi
80101545:	53                   	push   %ebx
80101546:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101549:	8b 0d d4 15 11 80    	mov    0x801115d4,%ecx
{
8010154f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101552:	85 c9                	test   %ecx,%ecx
80101554:	0f 84 8c 00 00 00    	je     801015e6 <balloc+0xa6>
8010155a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010155c:	89 f8                	mov    %edi,%eax
8010155e:	83 ec 08             	sub    $0x8,%esp
80101561:	89 fe                	mov    %edi,%esi
80101563:	c1 f8 0c             	sar    $0xc,%eax
80101566:	03 05 ec 15 11 80    	add    0x801115ec,%eax
8010156c:	50                   	push   %eax
8010156d:	ff 75 dc             	push   -0x24(%ebp)
80101570:	e8 5b eb ff ff       	call   801000d0 <bread>
80101575:	83 c4 10             	add    $0x10,%esp
80101578:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010157b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010157e:	a1 d4 15 11 80       	mov    0x801115d4,%eax
80101583:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101586:	31 c0                	xor    %eax,%eax
80101588:	eb 32                	jmp    801015bc <balloc+0x7c>
8010158a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101590:	89 c1                	mov    %eax,%ecx
80101592:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101597:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010159a:	83 e1 07             	and    $0x7,%ecx
8010159d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010159f:	89 c1                	mov    %eax,%ecx
801015a1:	c1 f9 03             	sar    $0x3,%ecx
801015a4:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
801015a9:	89 fa                	mov    %edi,%edx
801015ab:	85 df                	test   %ebx,%edi
801015ad:	74 49                	je     801015f8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801015af:	83 c0 01             	add    $0x1,%eax
801015b2:	83 c6 01             	add    $0x1,%esi
801015b5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801015ba:	74 07                	je     801015c3 <balloc+0x83>
801015bc:	8b 55 e0             	mov    -0x20(%ebp),%edx
801015bf:	39 d6                	cmp    %edx,%esi
801015c1:	72 cd                	jb     80101590 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801015c3:	8b 7d d8             	mov    -0x28(%ebp),%edi
801015c6:	83 ec 0c             	sub    $0xc,%esp
801015c9:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801015cc:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
801015d2:	e8 19 ec ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801015d7:	83 c4 10             	add    $0x10,%esp
801015da:	3b 3d d4 15 11 80    	cmp    0x801115d4,%edi
801015e0:	0f 82 76 ff ff ff    	jb     8010155c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
801015e6:	83 ec 0c             	sub    $0xc,%esp
801015e9:	68 6e 75 10 80       	push   $0x8010756e
801015ee:	e8 8d ed ff ff       	call   80100380 <panic>
801015f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801015f8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801015fb:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801015fe:	09 da                	or     %ebx,%edx
80101600:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101604:	57                   	push   %edi
80101605:	e8 76 1c 00 00       	call   80103280 <log_write>
        brelse(bp);
8010160a:	89 3c 24             	mov    %edi,(%esp)
8010160d:	e8 de eb ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101612:	58                   	pop    %eax
80101613:	5a                   	pop    %edx
80101614:	56                   	push   %esi
80101615:	ff 75 dc             	push   -0x24(%ebp)
80101618:	e8 b3 ea ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
8010161d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101620:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101622:	8d 40 5c             	lea    0x5c(%eax),%eax
80101625:	68 00 02 00 00       	push   $0x200
8010162a:	6a 00                	push   $0x0
8010162c:	50                   	push   %eax
8010162d:	e8 ce 33 00 00       	call   80104a00 <memset>
  log_write(bp);
80101632:	89 1c 24             	mov    %ebx,(%esp)
80101635:	e8 46 1c 00 00       	call   80103280 <log_write>
  brelse(bp);
8010163a:	89 1c 24             	mov    %ebx,(%esp)
8010163d:	e8 ae eb ff ff       	call   801001f0 <brelse>
}
80101642:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101645:	89 f0                	mov    %esi,%eax
80101647:	5b                   	pop    %ebx
80101648:	5e                   	pop    %esi
80101649:	5f                   	pop    %edi
8010164a:	5d                   	pop    %ebp
8010164b:	c3                   	ret
8010164c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101650 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101654:	31 ff                	xor    %edi,%edi
{
80101656:	56                   	push   %esi
80101657:	89 c6                	mov    %eax,%esi
80101659:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010165a:	bb b4 f9 10 80       	mov    $0x8010f9b4,%ebx
{
8010165f:	83 ec 28             	sub    $0x28,%esp
80101662:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101665:	68 80 f9 10 80       	push   $0x8010f980
8010166a:	e8 91 32 00 00       	call   80104900 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010166f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101672:	83 c4 10             	add    $0x10,%esp
80101675:	eb 1b                	jmp    80101692 <iget+0x42>
80101677:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010167e:	00 
8010167f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101680:	39 33                	cmp    %esi,(%ebx)
80101682:	74 6c                	je     801016f0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101684:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010168a:	81 fb d4 15 11 80    	cmp    $0x801115d4,%ebx
80101690:	74 26                	je     801016b8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101692:	8b 43 08             	mov    0x8(%ebx),%eax
80101695:	85 c0                	test   %eax,%eax
80101697:	7f e7                	jg     80101680 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101699:	85 ff                	test   %edi,%edi
8010169b:	75 e7                	jne    80101684 <iget+0x34>
8010169d:	85 c0                	test   %eax,%eax
8010169f:	75 76                	jne    80101717 <iget+0xc7>
      empty = ip;
801016a1:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801016a3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801016a9:	81 fb d4 15 11 80    	cmp    $0x801115d4,%ebx
801016af:	75 e1                	jne    80101692 <iget+0x42>
801016b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801016b8:	85 ff                	test   %edi,%edi
801016ba:	74 79                	je     80101735 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801016bc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801016bf:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
801016c1:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
801016c4:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
801016cb:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
801016d2:	68 80 f9 10 80       	push   $0x8010f980
801016d7:	e8 c4 31 00 00       	call   801048a0 <release>

  return ip;
801016dc:	83 c4 10             	add    $0x10,%esp
}
801016df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016e2:	89 f8                	mov    %edi,%eax
801016e4:	5b                   	pop    %ebx
801016e5:	5e                   	pop    %esi
801016e6:	5f                   	pop    %edi
801016e7:	5d                   	pop    %ebp
801016e8:	c3                   	ret
801016e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801016f0:	39 53 04             	cmp    %edx,0x4(%ebx)
801016f3:	75 8f                	jne    80101684 <iget+0x34>
      ip->ref++;
801016f5:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
801016f8:	83 ec 0c             	sub    $0xc,%esp
      return ip;
801016fb:	89 df                	mov    %ebx,%edi
      ip->ref++;
801016fd:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101700:	68 80 f9 10 80       	push   $0x8010f980
80101705:	e8 96 31 00 00       	call   801048a0 <release>
      return ip;
8010170a:	83 c4 10             	add    $0x10,%esp
}
8010170d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101710:	89 f8                	mov    %edi,%eax
80101712:	5b                   	pop    %ebx
80101713:	5e                   	pop    %esi
80101714:	5f                   	pop    %edi
80101715:	5d                   	pop    %ebp
80101716:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101717:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010171d:	81 fb d4 15 11 80    	cmp    $0x801115d4,%ebx
80101723:	74 10                	je     80101735 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101725:	8b 43 08             	mov    0x8(%ebx),%eax
80101728:	85 c0                	test   %eax,%eax
8010172a:	0f 8f 50 ff ff ff    	jg     80101680 <iget+0x30>
80101730:	e9 68 ff ff ff       	jmp    8010169d <iget+0x4d>
    panic("iget: no inodes");
80101735:	83 ec 0c             	sub    $0xc,%esp
80101738:	68 84 75 10 80       	push   $0x80107584
8010173d:	e8 3e ec ff ff       	call   80100380 <panic>
80101742:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101749:	00 
8010174a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101750 <bfree>:
{
80101750:	55                   	push   %ebp
80101751:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101753:	89 d0                	mov    %edx,%eax
80101755:	c1 e8 0c             	shr    $0xc,%eax
{
80101758:	89 e5                	mov    %esp,%ebp
8010175a:	56                   	push   %esi
8010175b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
8010175c:	03 05 ec 15 11 80    	add    0x801115ec,%eax
{
80101762:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101764:	83 ec 08             	sub    $0x8,%esp
80101767:	50                   	push   %eax
80101768:	51                   	push   %ecx
80101769:	e8 62 e9 ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010176e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101770:	c1 fb 03             	sar    $0x3,%ebx
80101773:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101776:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101778:	83 e1 07             	and    $0x7,%ecx
8010177b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101780:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101786:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101788:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010178d:	85 c1                	test   %eax,%ecx
8010178f:	74 23                	je     801017b4 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101791:	f7 d0                	not    %eax
  log_write(bp);
80101793:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101796:	21 c8                	and    %ecx,%eax
80101798:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010179c:	56                   	push   %esi
8010179d:	e8 de 1a 00 00       	call   80103280 <log_write>
  brelse(bp);
801017a2:	89 34 24             	mov    %esi,(%esp)
801017a5:	e8 46 ea ff ff       	call   801001f0 <brelse>
}
801017aa:	83 c4 10             	add    $0x10,%esp
801017ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b0:	5b                   	pop    %ebx
801017b1:	5e                   	pop    %esi
801017b2:	5d                   	pop    %ebp
801017b3:	c3                   	ret
    panic("freeing free block");
801017b4:	83 ec 0c             	sub    $0xc,%esp
801017b7:	68 94 75 10 80       	push   $0x80107594
801017bc:	e8 bf eb ff ff       	call   80100380 <panic>
801017c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801017c8:	00 
801017c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801017d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	57                   	push   %edi
801017d4:	56                   	push   %esi
801017d5:	89 c6                	mov    %eax,%esi
801017d7:	53                   	push   %ebx
801017d8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801017db:	83 fa 0b             	cmp    $0xb,%edx
801017de:	0f 86 8c 00 00 00    	jbe    80101870 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801017e4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801017e7:	83 fb 7f             	cmp    $0x7f,%ebx
801017ea:	0f 87 a2 00 00 00    	ja     80101892 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801017f0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801017f6:	85 c0                	test   %eax,%eax
801017f8:	74 5e                	je     80101858 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801017fa:	83 ec 08             	sub    $0x8,%esp
801017fd:	50                   	push   %eax
801017fe:	ff 36                	push   (%esi)
80101800:	e8 cb e8 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101805:	83 c4 10             	add    $0x10,%esp
80101808:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010180c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010180e:	8b 3b                	mov    (%ebx),%edi
80101810:	85 ff                	test   %edi,%edi
80101812:	74 1c                	je     80101830 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101814:	83 ec 0c             	sub    $0xc,%esp
80101817:	52                   	push   %edx
80101818:	e8 d3 e9 ff ff       	call   801001f0 <brelse>
8010181d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101820:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101823:	89 f8                	mov    %edi,%eax
80101825:	5b                   	pop    %ebx
80101826:	5e                   	pop    %esi
80101827:	5f                   	pop    %edi
80101828:	5d                   	pop    %ebp
80101829:	c3                   	ret
8010182a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101830:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101833:	8b 06                	mov    (%esi),%eax
80101835:	e8 06 fd ff ff       	call   80101540 <balloc>
      log_write(bp);
8010183a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010183d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101840:	89 03                	mov    %eax,(%ebx)
80101842:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101844:	52                   	push   %edx
80101845:	e8 36 1a 00 00       	call   80103280 <log_write>
8010184a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010184d:	83 c4 10             	add    $0x10,%esp
80101850:	eb c2                	jmp    80101814 <bmap+0x44>
80101852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101858:	8b 06                	mov    (%esi),%eax
8010185a:	e8 e1 fc ff ff       	call   80101540 <balloc>
8010185f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101865:	eb 93                	jmp    801017fa <bmap+0x2a>
80101867:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010186e:	00 
8010186f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101870:	8d 5a 14             	lea    0x14(%edx),%ebx
80101873:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101877:	85 ff                	test   %edi,%edi
80101879:	75 a5                	jne    80101820 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010187b:	8b 00                	mov    (%eax),%eax
8010187d:	e8 be fc ff ff       	call   80101540 <balloc>
80101882:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101886:	89 c7                	mov    %eax,%edi
}
80101888:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010188b:	5b                   	pop    %ebx
8010188c:	89 f8                	mov    %edi,%eax
8010188e:	5e                   	pop    %esi
8010188f:	5f                   	pop    %edi
80101890:	5d                   	pop    %ebp
80101891:	c3                   	ret
  panic("bmap: out of range");
80101892:	83 ec 0c             	sub    $0xc,%esp
80101895:	68 a7 75 10 80       	push   $0x801075a7
8010189a:	e8 e1 ea ff ff       	call   80100380 <panic>
8010189f:	90                   	nop

801018a0 <readsb>:
{
801018a0:	55                   	push   %ebp
801018a1:	89 e5                	mov    %esp,%ebp
801018a3:	56                   	push   %esi
801018a4:	53                   	push   %ebx
801018a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801018a8:	83 ec 08             	sub    $0x8,%esp
801018ab:	6a 01                	push   $0x1
801018ad:	ff 75 08             	push   0x8(%ebp)
801018b0:	e8 1b e8 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801018b5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801018b8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801018ba:	8d 40 5c             	lea    0x5c(%eax),%eax
801018bd:	6a 1c                	push   $0x1c
801018bf:	50                   	push   %eax
801018c0:	56                   	push   %esi
801018c1:	e8 ca 31 00 00       	call   80104a90 <memmove>
  brelse(bp);
801018c6:	83 c4 10             	add    $0x10,%esp
801018c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801018cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018cf:	5b                   	pop    %ebx
801018d0:	5e                   	pop    %esi
801018d1:	5d                   	pop    %ebp
  brelse(bp);
801018d2:	e9 19 e9 ff ff       	jmp    801001f0 <brelse>
801018d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018de:	00 
801018df:	90                   	nop

801018e0 <iinit>:
{
801018e0:	55                   	push   %ebp
801018e1:	89 e5                	mov    %esp,%ebp
801018e3:	53                   	push   %ebx
801018e4:	bb c0 f9 10 80       	mov    $0x8010f9c0,%ebx
801018e9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801018ec:	68 ba 75 10 80       	push   $0x801075ba
801018f1:	68 80 f9 10 80       	push   $0x8010f980
801018f6:	e8 15 2e 00 00       	call   80104710 <initlock>
  for(i = 0; i < NINODE; i++) {
801018fb:	83 c4 10             	add    $0x10,%esp
801018fe:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101900:	83 ec 08             	sub    $0x8,%esp
80101903:	68 c1 75 10 80       	push   $0x801075c1
80101908:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101909:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010190f:	e8 cc 2c 00 00       	call   801045e0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101914:	83 c4 10             	add    $0x10,%esp
80101917:	81 fb e0 15 11 80    	cmp    $0x801115e0,%ebx
8010191d:	75 e1                	jne    80101900 <iinit+0x20>
  bp = bread(dev, 1);
8010191f:	83 ec 08             	sub    $0x8,%esp
80101922:	6a 01                	push   $0x1
80101924:	ff 75 08             	push   0x8(%ebp)
80101927:	e8 a4 e7 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010192c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010192f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101931:	8d 40 5c             	lea    0x5c(%eax),%eax
80101934:	6a 1c                	push   $0x1c
80101936:	50                   	push   %eax
80101937:	68 d4 15 11 80       	push   $0x801115d4
8010193c:	e8 4f 31 00 00       	call   80104a90 <memmove>
  brelse(bp);
80101941:	89 1c 24             	mov    %ebx,(%esp)
80101944:	e8 a7 e8 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101949:	ff 35 ec 15 11 80    	push   0x801115ec
8010194f:	ff 35 e8 15 11 80    	push   0x801115e8
80101955:	ff 35 e4 15 11 80    	push   0x801115e4
8010195b:	ff 35 e0 15 11 80    	push   0x801115e0
80101961:	ff 35 dc 15 11 80    	push   0x801115dc
80101967:	ff 35 d8 15 11 80    	push   0x801115d8
8010196d:	ff 35 d4 15 11 80    	push   0x801115d4
80101973:	68 2c 7a 10 80       	push   $0x80107a2c
80101978:	e8 e3 ec ff ff       	call   80100660 <cprintf>
}
8010197d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101980:	83 c4 30             	add    $0x30,%esp
80101983:	c9                   	leave
80101984:	c3                   	ret
80101985:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010198c:	00 
8010198d:	8d 76 00             	lea    0x0(%esi),%esi

80101990 <ialloc>:
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	57                   	push   %edi
80101994:	56                   	push   %esi
80101995:	53                   	push   %ebx
80101996:	83 ec 1c             	sub    $0x1c,%esp
80101999:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010199c:	83 3d dc 15 11 80 01 	cmpl   $0x1,0x801115dc
{
801019a3:	8b 75 08             	mov    0x8(%ebp),%esi
801019a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801019a9:	0f 86 91 00 00 00    	jbe    80101a40 <ialloc+0xb0>
801019af:	bf 01 00 00 00       	mov    $0x1,%edi
801019b4:	eb 21                	jmp    801019d7 <ialloc+0x47>
801019b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801019bd:	00 
801019be:	66 90                	xchg   %ax,%ax
    brelse(bp);
801019c0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801019c3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801019c6:	53                   	push   %ebx
801019c7:	e8 24 e8 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801019cc:	83 c4 10             	add    $0x10,%esp
801019cf:	3b 3d dc 15 11 80    	cmp    0x801115dc,%edi
801019d5:	73 69                	jae    80101a40 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801019d7:	89 f8                	mov    %edi,%eax
801019d9:	83 ec 08             	sub    $0x8,%esp
801019dc:	c1 e8 03             	shr    $0x3,%eax
801019df:	03 05 e8 15 11 80    	add    0x801115e8,%eax
801019e5:	50                   	push   %eax
801019e6:	56                   	push   %esi
801019e7:	e8 e4 e6 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801019ec:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801019ef:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801019f1:	89 f8                	mov    %edi,%eax
801019f3:	83 e0 07             	and    $0x7,%eax
801019f6:	c1 e0 06             	shl    $0x6,%eax
801019f9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801019fd:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101a01:	75 bd                	jne    801019c0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101a03:	83 ec 04             	sub    $0x4,%esp
80101a06:	6a 40                	push   $0x40
80101a08:	6a 00                	push   $0x0
80101a0a:	51                   	push   %ecx
80101a0b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101a0e:	e8 ed 2f 00 00       	call   80104a00 <memset>
      dip->type = type;
80101a13:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101a17:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a1a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101a1d:	89 1c 24             	mov    %ebx,(%esp)
80101a20:	e8 5b 18 00 00       	call   80103280 <log_write>
      brelse(bp);
80101a25:	89 1c 24             	mov    %ebx,(%esp)
80101a28:	e8 c3 e7 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101a2d:	83 c4 10             	add    $0x10,%esp
}
80101a30:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101a33:	89 fa                	mov    %edi,%edx
}
80101a35:	5b                   	pop    %ebx
      return iget(dev, inum);
80101a36:	89 f0                	mov    %esi,%eax
}
80101a38:	5e                   	pop    %esi
80101a39:	5f                   	pop    %edi
80101a3a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101a3b:	e9 10 fc ff ff       	jmp    80101650 <iget>
  panic("ialloc: no inodes");
80101a40:	83 ec 0c             	sub    $0xc,%esp
80101a43:	68 c7 75 10 80       	push   $0x801075c7
80101a48:	e8 33 e9 ff ff       	call   80100380 <panic>
80101a4d:	8d 76 00             	lea    0x0(%esi),%esi

80101a50 <iupdate>:
{
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	56                   	push   %esi
80101a54:	53                   	push   %ebx
80101a55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a58:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a5b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a5e:	83 ec 08             	sub    $0x8,%esp
80101a61:	c1 e8 03             	shr    $0x3,%eax
80101a64:	03 05 e8 15 11 80    	add    0x801115e8,%eax
80101a6a:	50                   	push   %eax
80101a6b:	ff 73 a4             	push   -0x5c(%ebx)
80101a6e:	e8 5d e6 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101a73:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a77:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a7a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a7c:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101a7f:	83 e0 07             	and    $0x7,%eax
80101a82:	c1 e0 06             	shl    $0x6,%eax
80101a85:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101a89:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101a8c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a90:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101a93:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101a97:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101a9b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101a9f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101aa3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101aa7:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101aaa:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101aad:	6a 34                	push   $0x34
80101aaf:	53                   	push   %ebx
80101ab0:	50                   	push   %eax
80101ab1:	e8 da 2f 00 00       	call   80104a90 <memmove>
  log_write(bp);
80101ab6:	89 34 24             	mov    %esi,(%esp)
80101ab9:	e8 c2 17 00 00       	call   80103280 <log_write>
  brelse(bp);
80101abe:	83 c4 10             	add    $0x10,%esp
80101ac1:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101ac4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101ac7:	5b                   	pop    %ebx
80101ac8:	5e                   	pop    %esi
80101ac9:	5d                   	pop    %ebp
  brelse(bp);
80101aca:	e9 21 e7 ff ff       	jmp    801001f0 <brelse>
80101acf:	90                   	nop

80101ad0 <idup>:
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	53                   	push   %ebx
80101ad4:	83 ec 10             	sub    $0x10,%esp
80101ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101ada:	68 80 f9 10 80       	push   $0x8010f980
80101adf:	e8 1c 2e 00 00       	call   80104900 <acquire>
  ip->ref++;
80101ae4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101ae8:	c7 04 24 80 f9 10 80 	movl   $0x8010f980,(%esp)
80101aef:	e8 ac 2d 00 00       	call   801048a0 <release>
}
80101af4:	89 d8                	mov    %ebx,%eax
80101af6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101af9:	c9                   	leave
80101afa:	c3                   	ret
80101afb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101b00 <ilock>:
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	56                   	push   %esi
80101b04:	53                   	push   %ebx
80101b05:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101b08:	85 db                	test   %ebx,%ebx
80101b0a:	0f 84 b7 00 00 00    	je     80101bc7 <ilock+0xc7>
80101b10:	8b 53 08             	mov    0x8(%ebx),%edx
80101b13:	85 d2                	test   %edx,%edx
80101b15:	0f 8e ac 00 00 00    	jle    80101bc7 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101b1b:	83 ec 0c             	sub    $0xc,%esp
80101b1e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101b21:	50                   	push   %eax
80101b22:	e8 f9 2a 00 00       	call   80104620 <acquiresleep>
  if(ip->valid == 0){
80101b27:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101b2a:	83 c4 10             	add    $0x10,%esp
80101b2d:	85 c0                	test   %eax,%eax
80101b2f:	74 0f                	je     80101b40 <ilock+0x40>
}
80101b31:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b34:	5b                   	pop    %ebx
80101b35:	5e                   	pop    %esi
80101b36:	5d                   	pop    %ebp
80101b37:	c3                   	ret
80101b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b3f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b40:	8b 43 04             	mov    0x4(%ebx),%eax
80101b43:	83 ec 08             	sub    $0x8,%esp
80101b46:	c1 e8 03             	shr    $0x3,%eax
80101b49:	03 05 e8 15 11 80    	add    0x801115e8,%eax
80101b4f:	50                   	push   %eax
80101b50:	ff 33                	push   (%ebx)
80101b52:	e8 79 e5 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101b57:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b5a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101b5c:	8b 43 04             	mov    0x4(%ebx),%eax
80101b5f:	83 e0 07             	and    $0x7,%eax
80101b62:	c1 e0 06             	shl    $0x6,%eax
80101b65:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101b69:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101b6c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101b6f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101b73:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101b77:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101b7b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101b7f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101b83:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101b87:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101b8b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101b8e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101b91:	6a 34                	push   $0x34
80101b93:	50                   	push   %eax
80101b94:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101b97:	50                   	push   %eax
80101b98:	e8 f3 2e 00 00       	call   80104a90 <memmove>
    brelse(bp);
80101b9d:	89 34 24             	mov    %esi,(%esp)
80101ba0:	e8 4b e6 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101ba5:	83 c4 10             	add    $0x10,%esp
80101ba8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101bad:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101bb4:	0f 85 77 ff ff ff    	jne    80101b31 <ilock+0x31>
      panic("ilock: no type");
80101bba:	83 ec 0c             	sub    $0xc,%esp
80101bbd:	68 df 75 10 80       	push   $0x801075df
80101bc2:	e8 b9 e7 ff ff       	call   80100380 <panic>
    panic("ilock");
80101bc7:	83 ec 0c             	sub    $0xc,%esp
80101bca:	68 d9 75 10 80       	push   $0x801075d9
80101bcf:	e8 ac e7 ff ff       	call   80100380 <panic>
80101bd4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101bdb:	00 
80101bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101be0 <iunlock>:
{
80101be0:	55                   	push   %ebp
80101be1:	89 e5                	mov    %esp,%ebp
80101be3:	56                   	push   %esi
80101be4:	53                   	push   %ebx
80101be5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101be8:	85 db                	test   %ebx,%ebx
80101bea:	74 28                	je     80101c14 <iunlock+0x34>
80101bec:	83 ec 0c             	sub    $0xc,%esp
80101bef:	8d 73 0c             	lea    0xc(%ebx),%esi
80101bf2:	56                   	push   %esi
80101bf3:	e8 c8 2a 00 00       	call   801046c0 <holdingsleep>
80101bf8:	83 c4 10             	add    $0x10,%esp
80101bfb:	85 c0                	test   %eax,%eax
80101bfd:	74 15                	je     80101c14 <iunlock+0x34>
80101bff:	8b 43 08             	mov    0x8(%ebx),%eax
80101c02:	85 c0                	test   %eax,%eax
80101c04:	7e 0e                	jle    80101c14 <iunlock+0x34>
  releasesleep(&ip->lock);
80101c06:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101c09:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c0c:	5b                   	pop    %ebx
80101c0d:	5e                   	pop    %esi
80101c0e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101c0f:	e9 6c 2a 00 00       	jmp    80104680 <releasesleep>
    panic("iunlock");
80101c14:	83 ec 0c             	sub    $0xc,%esp
80101c17:	68 ee 75 10 80       	push   $0x801075ee
80101c1c:	e8 5f e7 ff ff       	call   80100380 <panic>
80101c21:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c28:	00 
80101c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c30 <iput>:
{
80101c30:	55                   	push   %ebp
80101c31:	89 e5                	mov    %esp,%ebp
80101c33:	57                   	push   %edi
80101c34:	56                   	push   %esi
80101c35:	53                   	push   %ebx
80101c36:	83 ec 28             	sub    $0x28,%esp
80101c39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101c3c:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101c3f:	57                   	push   %edi
80101c40:	e8 db 29 00 00       	call   80104620 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101c45:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101c48:	83 c4 10             	add    $0x10,%esp
80101c4b:	85 d2                	test   %edx,%edx
80101c4d:	74 07                	je     80101c56 <iput+0x26>
80101c4f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101c54:	74 32                	je     80101c88 <iput+0x58>
  releasesleep(&ip->lock);
80101c56:	83 ec 0c             	sub    $0xc,%esp
80101c59:	57                   	push   %edi
80101c5a:	e8 21 2a 00 00       	call   80104680 <releasesleep>
  acquire(&icache.lock);
80101c5f:	c7 04 24 80 f9 10 80 	movl   $0x8010f980,(%esp)
80101c66:	e8 95 2c 00 00       	call   80104900 <acquire>
  ip->ref--;
80101c6b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101c6f:	83 c4 10             	add    $0x10,%esp
80101c72:	c7 45 08 80 f9 10 80 	movl   $0x8010f980,0x8(%ebp)
}
80101c79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c7c:	5b                   	pop    %ebx
80101c7d:	5e                   	pop    %esi
80101c7e:	5f                   	pop    %edi
80101c7f:	5d                   	pop    %ebp
  release(&icache.lock);
80101c80:	e9 1b 2c 00 00       	jmp    801048a0 <release>
80101c85:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101c88:	83 ec 0c             	sub    $0xc,%esp
80101c8b:	68 80 f9 10 80       	push   $0x8010f980
80101c90:	e8 6b 2c 00 00       	call   80104900 <acquire>
    int r = ip->ref;
80101c95:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101c98:	c7 04 24 80 f9 10 80 	movl   $0x8010f980,(%esp)
80101c9f:	e8 fc 2b 00 00       	call   801048a0 <release>
    if(r == 1){
80101ca4:	83 c4 10             	add    $0x10,%esp
80101ca7:	83 fe 01             	cmp    $0x1,%esi
80101caa:	75 aa                	jne    80101c56 <iput+0x26>
80101cac:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101cb2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101cb5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101cb8:	89 df                	mov    %ebx,%edi
80101cba:	89 cb                	mov    %ecx,%ebx
80101cbc:	eb 09                	jmp    80101cc7 <iput+0x97>
80101cbe:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101cc0:	83 c6 04             	add    $0x4,%esi
80101cc3:	39 de                	cmp    %ebx,%esi
80101cc5:	74 19                	je     80101ce0 <iput+0xb0>
    if(ip->addrs[i]){
80101cc7:	8b 16                	mov    (%esi),%edx
80101cc9:	85 d2                	test   %edx,%edx
80101ccb:	74 f3                	je     80101cc0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101ccd:	8b 07                	mov    (%edi),%eax
80101ccf:	e8 7c fa ff ff       	call   80101750 <bfree>
      ip->addrs[i] = 0;
80101cd4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101cda:	eb e4                	jmp    80101cc0 <iput+0x90>
80101cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101ce0:	89 fb                	mov    %edi,%ebx
80101ce2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101ce5:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101ceb:	85 c0                	test   %eax,%eax
80101ced:	75 2d                	jne    80101d1c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101cef:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101cf2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101cf9:	53                   	push   %ebx
80101cfa:	e8 51 fd ff ff       	call   80101a50 <iupdate>
      ip->type = 0;
80101cff:	31 c0                	xor    %eax,%eax
80101d01:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101d05:	89 1c 24             	mov    %ebx,(%esp)
80101d08:	e8 43 fd ff ff       	call   80101a50 <iupdate>
      ip->valid = 0;
80101d0d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101d14:	83 c4 10             	add    $0x10,%esp
80101d17:	e9 3a ff ff ff       	jmp    80101c56 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d1c:	83 ec 08             	sub    $0x8,%esp
80101d1f:	50                   	push   %eax
80101d20:	ff 33                	push   (%ebx)
80101d22:	e8 a9 e3 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101d27:	83 c4 10             	add    $0x10,%esp
80101d2a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101d2d:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101d33:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101d36:	8d 70 5c             	lea    0x5c(%eax),%esi
80101d39:	89 cf                	mov    %ecx,%edi
80101d3b:	eb 0a                	jmp    80101d47 <iput+0x117>
80101d3d:	8d 76 00             	lea    0x0(%esi),%esi
80101d40:	83 c6 04             	add    $0x4,%esi
80101d43:	39 fe                	cmp    %edi,%esi
80101d45:	74 0f                	je     80101d56 <iput+0x126>
      if(a[j])
80101d47:	8b 16                	mov    (%esi),%edx
80101d49:	85 d2                	test   %edx,%edx
80101d4b:	74 f3                	je     80101d40 <iput+0x110>
        bfree(ip->dev, a[j]);
80101d4d:	8b 03                	mov    (%ebx),%eax
80101d4f:	e8 fc f9 ff ff       	call   80101750 <bfree>
80101d54:	eb ea                	jmp    80101d40 <iput+0x110>
    brelse(bp);
80101d56:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d59:	83 ec 0c             	sub    $0xc,%esp
80101d5c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101d5f:	50                   	push   %eax
80101d60:	e8 8b e4 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101d65:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101d6b:	8b 03                	mov    (%ebx),%eax
80101d6d:	e8 de f9 ff ff       	call   80101750 <bfree>
    ip->addrs[NDIRECT] = 0;
80101d72:	83 c4 10             	add    $0x10,%esp
80101d75:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101d7c:	00 00 00 
80101d7f:	e9 6b ff ff ff       	jmp    80101cef <iput+0xbf>
80101d84:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d8b:	00 
80101d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101d90 <iunlockput>:
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	56                   	push   %esi
80101d94:	53                   	push   %ebx
80101d95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101d98:	85 db                	test   %ebx,%ebx
80101d9a:	74 34                	je     80101dd0 <iunlockput+0x40>
80101d9c:	83 ec 0c             	sub    $0xc,%esp
80101d9f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101da2:	56                   	push   %esi
80101da3:	e8 18 29 00 00       	call   801046c0 <holdingsleep>
80101da8:	83 c4 10             	add    $0x10,%esp
80101dab:	85 c0                	test   %eax,%eax
80101dad:	74 21                	je     80101dd0 <iunlockput+0x40>
80101daf:	8b 43 08             	mov    0x8(%ebx),%eax
80101db2:	85 c0                	test   %eax,%eax
80101db4:	7e 1a                	jle    80101dd0 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101db6:	83 ec 0c             	sub    $0xc,%esp
80101db9:	56                   	push   %esi
80101dba:	e8 c1 28 00 00       	call   80104680 <releasesleep>
  iput(ip);
80101dbf:	83 c4 10             	add    $0x10,%esp
80101dc2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101dc5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101dc8:	5b                   	pop    %ebx
80101dc9:	5e                   	pop    %esi
80101dca:	5d                   	pop    %ebp
  iput(ip);
80101dcb:	e9 60 fe ff ff       	jmp    80101c30 <iput>
    panic("iunlock");
80101dd0:	83 ec 0c             	sub    $0xc,%esp
80101dd3:	68 ee 75 10 80       	push   $0x801075ee
80101dd8:	e8 a3 e5 ff ff       	call   80100380 <panic>
80101ddd:	8d 76 00             	lea    0x0(%esi),%esi

80101de0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101de0:	55                   	push   %ebp
80101de1:	89 e5                	mov    %esp,%ebp
80101de3:	8b 55 08             	mov    0x8(%ebp),%edx
80101de6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101de9:	8b 0a                	mov    (%edx),%ecx
80101deb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101dee:	8b 4a 04             	mov    0x4(%edx),%ecx
80101df1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101df4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101df8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101dfb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101dff:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101e03:	8b 52 58             	mov    0x58(%edx),%edx
80101e06:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e09:	5d                   	pop    %ebp
80101e0a:	c3                   	ret
80101e0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101e10 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e10:	55                   	push   %ebp
80101e11:	89 e5                	mov    %esp,%ebp
80101e13:	57                   	push   %edi
80101e14:	56                   	push   %esi
80101e15:	53                   	push   %ebx
80101e16:	83 ec 1c             	sub    $0x1c,%esp
80101e19:	8b 75 08             	mov    0x8(%ebp),%esi
80101e1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e1f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e22:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101e27:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e2a:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101e2d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101e30:	0f 84 aa 00 00 00    	je     80101ee0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101e36:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101e39:	8b 56 58             	mov    0x58(%esi),%edx
80101e3c:	39 fa                	cmp    %edi,%edx
80101e3e:	0f 82 bd 00 00 00    	jb     80101f01 <readi+0xf1>
80101e44:	89 f9                	mov    %edi,%ecx
80101e46:	31 db                	xor    %ebx,%ebx
80101e48:	01 c1                	add    %eax,%ecx
80101e4a:	0f 92 c3             	setb   %bl
80101e4d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101e50:	0f 82 ab 00 00 00    	jb     80101f01 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101e56:	89 d3                	mov    %edx,%ebx
80101e58:	29 fb                	sub    %edi,%ebx
80101e5a:	39 ca                	cmp    %ecx,%edx
80101e5c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101e5f:	85 c0                	test   %eax,%eax
80101e61:	74 73                	je     80101ed6 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101e63:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101e66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e70:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101e73:	89 fa                	mov    %edi,%edx
80101e75:	c1 ea 09             	shr    $0x9,%edx
80101e78:	89 d8                	mov    %ebx,%eax
80101e7a:	e8 51 f9 ff ff       	call   801017d0 <bmap>
80101e7f:	83 ec 08             	sub    $0x8,%esp
80101e82:	50                   	push   %eax
80101e83:	ff 33                	push   (%ebx)
80101e85:	e8 46 e2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101e8a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101e8d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e92:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101e94:	89 f8                	mov    %edi,%eax
80101e96:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e9b:	29 f3                	sub    %esi,%ebx
80101e9d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101e9f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ea3:	39 d9                	cmp    %ebx,%ecx
80101ea5:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ea8:	83 c4 0c             	add    $0xc,%esp
80101eab:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101eac:	01 de                	add    %ebx,%esi
80101eae:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101eb0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101eb3:	50                   	push   %eax
80101eb4:	ff 75 e0             	push   -0x20(%ebp)
80101eb7:	e8 d4 2b 00 00       	call   80104a90 <memmove>
    brelse(bp);
80101ebc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101ebf:	89 14 24             	mov    %edx,(%esp)
80101ec2:	e8 29 e3 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ec7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101eca:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101ecd:	83 c4 10             	add    $0x10,%esp
80101ed0:	39 de                	cmp    %ebx,%esi
80101ed2:	72 9c                	jb     80101e70 <readi+0x60>
80101ed4:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101ed6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed9:	5b                   	pop    %ebx
80101eda:	5e                   	pop    %esi
80101edb:	5f                   	pop    %edi
80101edc:	5d                   	pop    %ebp
80101edd:	c3                   	ret
80101ede:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ee0:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101ee4:	66 83 fa 09          	cmp    $0x9,%dx
80101ee8:	77 17                	ja     80101f01 <readi+0xf1>
80101eea:	8b 14 d5 20 f9 10 80 	mov    -0x7fef06e0(,%edx,8),%edx
80101ef1:	85 d2                	test   %edx,%edx
80101ef3:	74 0c                	je     80101f01 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101ef5:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101ef8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101efb:	5b                   	pop    %ebx
80101efc:	5e                   	pop    %esi
80101efd:	5f                   	pop    %edi
80101efe:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101eff:	ff e2                	jmp    *%edx
      return -1;
80101f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f06:	eb ce                	jmp    80101ed6 <readi+0xc6>
80101f08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f0f:	00 

80101f10 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101f10:	55                   	push   %ebp
80101f11:	89 e5                	mov    %esp,%ebp
80101f13:	57                   	push   %edi
80101f14:	56                   	push   %esi
80101f15:	53                   	push   %ebx
80101f16:	83 ec 1c             	sub    $0x1c,%esp
80101f19:	8b 45 08             	mov    0x8(%ebp),%eax
80101f1c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101f1f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f22:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101f27:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101f2a:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101f2d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101f30:	0f 84 ba 00 00 00    	je     80101ff0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101f36:	39 78 58             	cmp    %edi,0x58(%eax)
80101f39:	0f 82 ea 00 00 00    	jb     80102029 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101f3f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101f42:	89 f2                	mov    %esi,%edx
80101f44:	01 fa                	add    %edi,%edx
80101f46:	0f 82 dd 00 00 00    	jb     80102029 <writei+0x119>
80101f4c:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101f52:	0f 87 d1 00 00 00    	ja     80102029 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101f58:	85 f6                	test   %esi,%esi
80101f5a:	0f 84 85 00 00 00    	je     80101fe5 <writei+0xd5>
80101f60:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101f67:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f70:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101f73:	89 fa                	mov    %edi,%edx
80101f75:	c1 ea 09             	shr    $0x9,%edx
80101f78:	89 f0                	mov    %esi,%eax
80101f7a:	e8 51 f8 ff ff       	call   801017d0 <bmap>
80101f7f:	83 ec 08             	sub    $0x8,%esp
80101f82:	50                   	push   %eax
80101f83:	ff 36                	push   (%esi)
80101f85:	e8 46 e1 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101f8a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f8d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101f90:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f95:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101f97:	89 f8                	mov    %edi,%eax
80101f99:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f9e:	29 d3                	sub    %edx,%ebx
80101fa0:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101fa2:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101fa6:	39 d9                	cmp    %ebx,%ecx
80101fa8:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101fab:	83 c4 0c             	add    $0xc,%esp
80101fae:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101faf:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101fb1:	ff 75 dc             	push   -0x24(%ebp)
80101fb4:	50                   	push   %eax
80101fb5:	e8 d6 2a 00 00       	call   80104a90 <memmove>
    log_write(bp);
80101fba:	89 34 24             	mov    %esi,(%esp)
80101fbd:	e8 be 12 00 00       	call   80103280 <log_write>
    brelse(bp);
80101fc2:	89 34 24             	mov    %esi,(%esp)
80101fc5:	e8 26 e2 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101fca:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101fcd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101fd0:	83 c4 10             	add    $0x10,%esp
80101fd3:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101fd6:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101fd9:	39 d8                	cmp    %ebx,%eax
80101fdb:	72 93                	jb     80101f70 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101fdd:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101fe0:	39 78 58             	cmp    %edi,0x58(%eax)
80101fe3:	72 33                	jb     80102018 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101fe5:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101fe8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101feb:	5b                   	pop    %ebx
80101fec:	5e                   	pop    %esi
80101fed:	5f                   	pop    %edi
80101fee:	5d                   	pop    %ebp
80101fef:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ff0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ff4:	66 83 f8 09          	cmp    $0x9,%ax
80101ff8:	77 2f                	ja     80102029 <writei+0x119>
80101ffa:	8b 04 c5 24 f9 10 80 	mov    -0x7fef06dc(,%eax,8),%eax
80102001:	85 c0                	test   %eax,%eax
80102003:	74 24                	je     80102029 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80102005:	89 75 10             	mov    %esi,0x10(%ebp)
}
80102008:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010200b:	5b                   	pop    %ebx
8010200c:	5e                   	pop    %esi
8010200d:	5f                   	pop    %edi
8010200e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010200f:	ff e0                	jmp    *%eax
80102011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80102018:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010201b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
8010201e:	50                   	push   %eax
8010201f:	e8 2c fa ff ff       	call   80101a50 <iupdate>
80102024:	83 c4 10             	add    $0x10,%esp
80102027:	eb bc                	jmp    80101fe5 <writei+0xd5>
      return -1;
80102029:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010202e:	eb b8                	jmp    80101fe8 <writei+0xd8>

80102030 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102036:	6a 0e                	push   $0xe
80102038:	ff 75 0c             	push   0xc(%ebp)
8010203b:	ff 75 08             	push   0x8(%ebp)
8010203e:	e8 bd 2a 00 00       	call   80104b00 <strncmp>
}
80102043:	c9                   	leave
80102044:	c3                   	ret
80102045:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010204c:	00 
8010204d:	8d 76 00             	lea    0x0(%esi),%esi

80102050 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102050:	55                   	push   %ebp
80102051:	89 e5                	mov    %esp,%ebp
80102053:	57                   	push   %edi
80102054:	56                   	push   %esi
80102055:	53                   	push   %ebx
80102056:	83 ec 1c             	sub    $0x1c,%esp
80102059:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010205c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102061:	0f 85 85 00 00 00    	jne    801020ec <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102067:	8b 53 58             	mov    0x58(%ebx),%edx
8010206a:	31 ff                	xor    %edi,%edi
8010206c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010206f:	85 d2                	test   %edx,%edx
80102071:	74 3e                	je     801020b1 <dirlookup+0x61>
80102073:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102078:	6a 10                	push   $0x10
8010207a:	57                   	push   %edi
8010207b:	56                   	push   %esi
8010207c:	53                   	push   %ebx
8010207d:	e8 8e fd ff ff       	call   80101e10 <readi>
80102082:	83 c4 10             	add    $0x10,%esp
80102085:	83 f8 10             	cmp    $0x10,%eax
80102088:	75 55                	jne    801020df <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
8010208a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010208f:	74 18                	je     801020a9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102091:	83 ec 04             	sub    $0x4,%esp
80102094:	8d 45 da             	lea    -0x26(%ebp),%eax
80102097:	6a 0e                	push   $0xe
80102099:	50                   	push   %eax
8010209a:	ff 75 0c             	push   0xc(%ebp)
8010209d:	e8 5e 2a 00 00       	call   80104b00 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801020a2:	83 c4 10             	add    $0x10,%esp
801020a5:	85 c0                	test   %eax,%eax
801020a7:	74 17                	je     801020c0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
801020a9:	83 c7 10             	add    $0x10,%edi
801020ac:	3b 7b 58             	cmp    0x58(%ebx),%edi
801020af:	72 c7                	jb     80102078 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801020b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801020b4:	31 c0                	xor    %eax,%eax
}
801020b6:	5b                   	pop    %ebx
801020b7:	5e                   	pop    %esi
801020b8:	5f                   	pop    %edi
801020b9:	5d                   	pop    %ebp
801020ba:	c3                   	ret
801020bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
801020c0:	8b 45 10             	mov    0x10(%ebp),%eax
801020c3:	85 c0                	test   %eax,%eax
801020c5:	74 05                	je     801020cc <dirlookup+0x7c>
        *poff = off;
801020c7:	8b 45 10             	mov    0x10(%ebp),%eax
801020ca:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
801020cc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
801020d0:	8b 03                	mov    (%ebx),%eax
801020d2:	e8 79 f5 ff ff       	call   80101650 <iget>
}
801020d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020da:	5b                   	pop    %ebx
801020db:	5e                   	pop    %esi
801020dc:	5f                   	pop    %edi
801020dd:	5d                   	pop    %ebp
801020de:	c3                   	ret
      panic("dirlookup read");
801020df:	83 ec 0c             	sub    $0xc,%esp
801020e2:	68 08 76 10 80       	push   $0x80107608
801020e7:	e8 94 e2 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
801020ec:	83 ec 0c             	sub    $0xc,%esp
801020ef:	68 f6 75 10 80       	push   $0x801075f6
801020f4:	e8 87 e2 ff ff       	call   80100380 <panic>
801020f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102100 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102100:	55                   	push   %ebp
80102101:	89 e5                	mov    %esp,%ebp
80102103:	57                   	push   %edi
80102104:	56                   	push   %esi
80102105:	53                   	push   %ebx
80102106:	89 c3                	mov    %eax,%ebx
80102108:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010210b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010210e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102111:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102114:	0f 84 9e 01 00 00    	je     801022b8 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010211a:	e8 a1 1b 00 00       	call   80103cc0 <myproc>
  acquire(&icache.lock);
8010211f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102122:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102125:	68 80 f9 10 80       	push   $0x8010f980
8010212a:	e8 d1 27 00 00       	call   80104900 <acquire>
  ip->ref++;
8010212f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102133:	c7 04 24 80 f9 10 80 	movl   $0x8010f980,(%esp)
8010213a:	e8 61 27 00 00       	call   801048a0 <release>
8010213f:	83 c4 10             	add    $0x10,%esp
80102142:	eb 07                	jmp    8010214b <namex+0x4b>
80102144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102148:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010214b:	0f b6 03             	movzbl (%ebx),%eax
8010214e:	3c 2f                	cmp    $0x2f,%al
80102150:	74 f6                	je     80102148 <namex+0x48>
  if(*path == 0)
80102152:	84 c0                	test   %al,%al
80102154:	0f 84 06 01 00 00    	je     80102260 <namex+0x160>
  while(*path != '/' && *path != 0)
8010215a:	0f b6 03             	movzbl (%ebx),%eax
8010215d:	84 c0                	test   %al,%al
8010215f:	0f 84 10 01 00 00    	je     80102275 <namex+0x175>
80102165:	89 df                	mov    %ebx,%edi
80102167:	3c 2f                	cmp    $0x2f,%al
80102169:	0f 84 06 01 00 00    	je     80102275 <namex+0x175>
8010216f:	90                   	nop
80102170:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102174:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102177:	3c 2f                	cmp    $0x2f,%al
80102179:	74 04                	je     8010217f <namex+0x7f>
8010217b:	84 c0                	test   %al,%al
8010217d:	75 f1                	jne    80102170 <namex+0x70>
  len = path - s;
8010217f:	89 f8                	mov    %edi,%eax
80102181:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102183:	83 f8 0d             	cmp    $0xd,%eax
80102186:	0f 8e ac 00 00 00    	jle    80102238 <namex+0x138>
    memmove(name, s, DIRSIZ);
8010218c:	83 ec 04             	sub    $0x4,%esp
8010218f:	6a 0e                	push   $0xe
80102191:	53                   	push   %ebx
80102192:	89 fb                	mov    %edi,%ebx
80102194:	ff 75 e4             	push   -0x1c(%ebp)
80102197:	e8 f4 28 00 00       	call   80104a90 <memmove>
8010219c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010219f:	80 3f 2f             	cmpb   $0x2f,(%edi)
801021a2:	75 0c                	jne    801021b0 <namex+0xb0>
801021a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801021a8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801021ab:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801021ae:	74 f8                	je     801021a8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801021b0:	83 ec 0c             	sub    $0xc,%esp
801021b3:	56                   	push   %esi
801021b4:	e8 47 f9 ff ff       	call   80101b00 <ilock>
    if(ip->type != T_DIR){
801021b9:	83 c4 10             	add    $0x10,%esp
801021bc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801021c1:	0f 85 b7 00 00 00    	jne    8010227e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
801021c7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801021ca:	85 c0                	test   %eax,%eax
801021cc:	74 09                	je     801021d7 <namex+0xd7>
801021ce:	80 3b 00             	cmpb   $0x0,(%ebx)
801021d1:	0f 84 f7 00 00 00    	je     801022ce <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801021d7:	83 ec 04             	sub    $0x4,%esp
801021da:	6a 00                	push   $0x0
801021dc:	ff 75 e4             	push   -0x1c(%ebp)
801021df:	56                   	push   %esi
801021e0:	e8 6b fe ff ff       	call   80102050 <dirlookup>
801021e5:	83 c4 10             	add    $0x10,%esp
801021e8:	89 c7                	mov    %eax,%edi
801021ea:	85 c0                	test   %eax,%eax
801021ec:	0f 84 8c 00 00 00    	je     8010227e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801021f2:	83 ec 0c             	sub    $0xc,%esp
801021f5:	8d 4e 0c             	lea    0xc(%esi),%ecx
801021f8:	51                   	push   %ecx
801021f9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801021fc:	e8 bf 24 00 00       	call   801046c0 <holdingsleep>
80102201:	83 c4 10             	add    $0x10,%esp
80102204:	85 c0                	test   %eax,%eax
80102206:	0f 84 02 01 00 00    	je     8010230e <namex+0x20e>
8010220c:	8b 56 08             	mov    0x8(%esi),%edx
8010220f:	85 d2                	test   %edx,%edx
80102211:	0f 8e f7 00 00 00    	jle    8010230e <namex+0x20e>
  releasesleep(&ip->lock);
80102217:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010221a:	83 ec 0c             	sub    $0xc,%esp
8010221d:	51                   	push   %ecx
8010221e:	e8 5d 24 00 00       	call   80104680 <releasesleep>
  iput(ip);
80102223:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80102226:	89 fe                	mov    %edi,%esi
  iput(ip);
80102228:	e8 03 fa ff ff       	call   80101c30 <iput>
8010222d:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102230:	e9 16 ff ff ff       	jmp    8010214b <namex+0x4b>
80102235:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102238:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010223b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
8010223e:	83 ec 04             	sub    $0x4,%esp
80102241:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102244:	50                   	push   %eax
80102245:	53                   	push   %ebx
    name[len] = 0;
80102246:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102248:	ff 75 e4             	push   -0x1c(%ebp)
8010224b:	e8 40 28 00 00       	call   80104a90 <memmove>
    name[len] = 0;
80102250:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102253:	83 c4 10             	add    $0x10,%esp
80102256:	c6 01 00             	movb   $0x0,(%ecx)
80102259:	e9 41 ff ff ff       	jmp    8010219f <namex+0x9f>
8010225e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80102260:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102263:	85 c0                	test   %eax,%eax
80102265:	0f 85 93 00 00 00    	jne    801022fe <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
8010226b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010226e:	89 f0                	mov    %esi,%eax
80102270:	5b                   	pop    %ebx
80102271:	5e                   	pop    %esi
80102272:	5f                   	pop    %edi
80102273:	5d                   	pop    %ebp
80102274:	c3                   	ret
  while(*path != '/' && *path != 0)
80102275:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102278:	89 df                	mov    %ebx,%edi
8010227a:	31 c0                	xor    %eax,%eax
8010227c:	eb c0                	jmp    8010223e <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010227e:	83 ec 0c             	sub    $0xc,%esp
80102281:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102284:	53                   	push   %ebx
80102285:	e8 36 24 00 00       	call   801046c0 <holdingsleep>
8010228a:	83 c4 10             	add    $0x10,%esp
8010228d:	85 c0                	test   %eax,%eax
8010228f:	74 7d                	je     8010230e <namex+0x20e>
80102291:	8b 4e 08             	mov    0x8(%esi),%ecx
80102294:	85 c9                	test   %ecx,%ecx
80102296:	7e 76                	jle    8010230e <namex+0x20e>
  releasesleep(&ip->lock);
80102298:	83 ec 0c             	sub    $0xc,%esp
8010229b:	53                   	push   %ebx
8010229c:	e8 df 23 00 00       	call   80104680 <releasesleep>
  iput(ip);
801022a1:	89 34 24             	mov    %esi,(%esp)
      return 0;
801022a4:	31 f6                	xor    %esi,%esi
  iput(ip);
801022a6:	e8 85 f9 ff ff       	call   80101c30 <iput>
      return 0;
801022ab:	83 c4 10             	add    $0x10,%esp
}
801022ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b1:	89 f0                	mov    %esi,%eax
801022b3:	5b                   	pop    %ebx
801022b4:	5e                   	pop    %esi
801022b5:	5f                   	pop    %edi
801022b6:	5d                   	pop    %ebp
801022b7:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
801022b8:	ba 01 00 00 00       	mov    $0x1,%edx
801022bd:	b8 01 00 00 00       	mov    $0x1,%eax
801022c2:	e8 89 f3 ff ff       	call   80101650 <iget>
801022c7:	89 c6                	mov    %eax,%esi
801022c9:	e9 7d fe ff ff       	jmp    8010214b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801022ce:	83 ec 0c             	sub    $0xc,%esp
801022d1:	8d 5e 0c             	lea    0xc(%esi),%ebx
801022d4:	53                   	push   %ebx
801022d5:	e8 e6 23 00 00       	call   801046c0 <holdingsleep>
801022da:	83 c4 10             	add    $0x10,%esp
801022dd:	85 c0                	test   %eax,%eax
801022df:	74 2d                	je     8010230e <namex+0x20e>
801022e1:	8b 7e 08             	mov    0x8(%esi),%edi
801022e4:	85 ff                	test   %edi,%edi
801022e6:	7e 26                	jle    8010230e <namex+0x20e>
  releasesleep(&ip->lock);
801022e8:	83 ec 0c             	sub    $0xc,%esp
801022eb:	53                   	push   %ebx
801022ec:	e8 8f 23 00 00       	call   80104680 <releasesleep>
}
801022f1:	83 c4 10             	add    $0x10,%esp
}
801022f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022f7:	89 f0                	mov    %esi,%eax
801022f9:	5b                   	pop    %ebx
801022fa:	5e                   	pop    %esi
801022fb:	5f                   	pop    %edi
801022fc:	5d                   	pop    %ebp
801022fd:	c3                   	ret
    iput(ip);
801022fe:	83 ec 0c             	sub    $0xc,%esp
80102301:	56                   	push   %esi
      return 0;
80102302:	31 f6                	xor    %esi,%esi
    iput(ip);
80102304:	e8 27 f9 ff ff       	call   80101c30 <iput>
    return 0;
80102309:	83 c4 10             	add    $0x10,%esp
8010230c:	eb a0                	jmp    801022ae <namex+0x1ae>
    panic("iunlock");
8010230e:	83 ec 0c             	sub    $0xc,%esp
80102311:	68 ee 75 10 80       	push   $0x801075ee
80102316:	e8 65 e0 ff ff       	call   80100380 <panic>
8010231b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102320 <dirlink>:
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	57                   	push   %edi
80102324:	56                   	push   %esi
80102325:	53                   	push   %ebx
80102326:	83 ec 20             	sub    $0x20,%esp
80102329:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010232c:	6a 00                	push   $0x0
8010232e:	ff 75 0c             	push   0xc(%ebp)
80102331:	53                   	push   %ebx
80102332:	e8 19 fd ff ff       	call   80102050 <dirlookup>
80102337:	83 c4 10             	add    $0x10,%esp
8010233a:	85 c0                	test   %eax,%eax
8010233c:	75 67                	jne    801023a5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010233e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102341:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102344:	85 ff                	test   %edi,%edi
80102346:	74 29                	je     80102371 <dirlink+0x51>
80102348:	31 ff                	xor    %edi,%edi
8010234a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010234d:	eb 09                	jmp    80102358 <dirlink+0x38>
8010234f:	90                   	nop
80102350:	83 c7 10             	add    $0x10,%edi
80102353:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102356:	73 19                	jae    80102371 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102358:	6a 10                	push   $0x10
8010235a:	57                   	push   %edi
8010235b:	56                   	push   %esi
8010235c:	53                   	push   %ebx
8010235d:	e8 ae fa ff ff       	call   80101e10 <readi>
80102362:	83 c4 10             	add    $0x10,%esp
80102365:	83 f8 10             	cmp    $0x10,%eax
80102368:	75 4e                	jne    801023b8 <dirlink+0x98>
    if(de.inum == 0)
8010236a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010236f:	75 df                	jne    80102350 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102371:	83 ec 04             	sub    $0x4,%esp
80102374:	8d 45 da             	lea    -0x26(%ebp),%eax
80102377:	6a 0e                	push   $0xe
80102379:	ff 75 0c             	push   0xc(%ebp)
8010237c:	50                   	push   %eax
8010237d:	e8 ce 27 00 00       	call   80104b50 <strncpy>
  de.inum = inum;
80102382:	8b 45 10             	mov    0x10(%ebp),%eax
80102385:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102389:	6a 10                	push   $0x10
8010238b:	57                   	push   %edi
8010238c:	56                   	push   %esi
8010238d:	53                   	push   %ebx
8010238e:	e8 7d fb ff ff       	call   80101f10 <writei>
80102393:	83 c4 20             	add    $0x20,%esp
80102396:	83 f8 10             	cmp    $0x10,%eax
80102399:	75 2a                	jne    801023c5 <dirlink+0xa5>
  return 0;
8010239b:	31 c0                	xor    %eax,%eax
}
8010239d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023a0:	5b                   	pop    %ebx
801023a1:	5e                   	pop    %esi
801023a2:	5f                   	pop    %edi
801023a3:	5d                   	pop    %ebp
801023a4:	c3                   	ret
    iput(ip);
801023a5:	83 ec 0c             	sub    $0xc,%esp
801023a8:	50                   	push   %eax
801023a9:	e8 82 f8 ff ff       	call   80101c30 <iput>
    return -1;
801023ae:	83 c4 10             	add    $0x10,%esp
801023b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801023b6:	eb e5                	jmp    8010239d <dirlink+0x7d>
      panic("dirlink read");
801023b8:	83 ec 0c             	sub    $0xc,%esp
801023bb:	68 17 76 10 80       	push   $0x80107617
801023c0:	e8 bb df ff ff       	call   80100380 <panic>
    panic("dirlink");
801023c5:	83 ec 0c             	sub    $0xc,%esp
801023c8:	68 73 78 10 80       	push   $0x80107873
801023cd:	e8 ae df ff ff       	call   80100380 <panic>
801023d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801023d9:	00 
801023da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801023e0 <namei>:

struct inode*
namei(char *path)
{
801023e0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801023e1:	31 d2                	xor    %edx,%edx
{
801023e3:	89 e5                	mov    %esp,%ebp
801023e5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801023e8:	8b 45 08             	mov    0x8(%ebp),%eax
801023eb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801023ee:	e8 0d fd ff ff       	call   80102100 <namex>
}
801023f3:	c9                   	leave
801023f4:	c3                   	ret
801023f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801023fc:	00 
801023fd:	8d 76 00             	lea    0x0(%esi),%esi

80102400 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102400:	55                   	push   %ebp
  return namex(path, 1, name);
80102401:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102406:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102408:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010240b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010240e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010240f:	e9 ec fc ff ff       	jmp    80102100 <namex>
80102414:	66 90                	xchg   %ax,%ax
80102416:	66 90                	xchg   %ax,%ax
80102418:	66 90                	xchg   %ax,%ax
8010241a:	66 90                	xchg   %ax,%ax
8010241c:	66 90                	xchg   %ax,%ax
8010241e:	66 90                	xchg   %ax,%ax

80102420 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	57                   	push   %edi
80102424:	56                   	push   %esi
80102425:	53                   	push   %ebx
80102426:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102429:	85 c0                	test   %eax,%eax
8010242b:	0f 84 b4 00 00 00    	je     801024e5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102431:	8b 70 08             	mov    0x8(%eax),%esi
80102434:	89 c3                	mov    %eax,%ebx
80102436:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010243c:	0f 87 96 00 00 00    	ja     801024d8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102442:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102447:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010244e:	00 
8010244f:	90                   	nop
80102450:	89 ca                	mov    %ecx,%edx
80102452:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102453:	83 e0 c0             	and    $0xffffffc0,%eax
80102456:	3c 40                	cmp    $0x40,%al
80102458:	75 f6                	jne    80102450 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010245a:	31 ff                	xor    %edi,%edi
8010245c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102461:	89 f8                	mov    %edi,%eax
80102463:	ee                   	out    %al,(%dx)
80102464:	b8 01 00 00 00       	mov    $0x1,%eax
80102469:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010246e:	ee                   	out    %al,(%dx)
8010246f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102474:	89 f0                	mov    %esi,%eax
80102476:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102477:	89 f0                	mov    %esi,%eax
80102479:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010247e:	c1 f8 08             	sar    $0x8,%eax
80102481:	ee                   	out    %al,(%dx)
80102482:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102487:	89 f8                	mov    %edi,%eax
80102489:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010248a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010248e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102493:	c1 e0 04             	shl    $0x4,%eax
80102496:	83 e0 10             	and    $0x10,%eax
80102499:	83 c8 e0             	or     $0xffffffe0,%eax
8010249c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010249d:	f6 03 04             	testb  $0x4,(%ebx)
801024a0:	75 16                	jne    801024b8 <idestart+0x98>
801024a2:	b8 20 00 00 00       	mov    $0x20,%eax
801024a7:	89 ca                	mov    %ecx,%edx
801024a9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801024aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024ad:	5b                   	pop    %ebx
801024ae:	5e                   	pop    %esi
801024af:	5f                   	pop    %edi
801024b0:	5d                   	pop    %ebp
801024b1:	c3                   	ret
801024b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024b8:	b8 30 00 00 00       	mov    $0x30,%eax
801024bd:	89 ca                	mov    %ecx,%edx
801024bf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801024c0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801024c5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801024c8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801024cd:	fc                   	cld
801024ce:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801024d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024d3:	5b                   	pop    %ebx
801024d4:	5e                   	pop    %esi
801024d5:	5f                   	pop    %edi
801024d6:	5d                   	pop    %ebp
801024d7:	c3                   	ret
    panic("incorrect blockno");
801024d8:	83 ec 0c             	sub    $0xc,%esp
801024db:	68 2d 76 10 80       	push   $0x8010762d
801024e0:	e8 9b de ff ff       	call   80100380 <panic>
    panic("idestart");
801024e5:	83 ec 0c             	sub    $0xc,%esp
801024e8:	68 24 76 10 80       	push   $0x80107624
801024ed:	e8 8e de ff ff       	call   80100380 <panic>
801024f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024f9:	00 
801024fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102500 <ideinit>:
{
80102500:	55                   	push   %ebp
80102501:	89 e5                	mov    %esp,%ebp
80102503:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102506:	68 3f 76 10 80       	push   $0x8010763f
8010250b:	68 20 16 11 80       	push   $0x80111620
80102510:	e8 fb 21 00 00       	call   80104710 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102515:	58                   	pop    %eax
80102516:	a1 a4 17 11 80       	mov    0x801117a4,%eax
8010251b:	5a                   	pop    %edx
8010251c:	83 e8 01             	sub    $0x1,%eax
8010251f:	50                   	push   %eax
80102520:	6a 0e                	push   $0xe
80102522:	e8 99 02 00 00       	call   801027c0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102527:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010252a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010252f:	90                   	nop
80102530:	89 ca                	mov    %ecx,%edx
80102532:	ec                   	in     (%dx),%al
80102533:	83 e0 c0             	and    $0xffffffc0,%eax
80102536:	3c 40                	cmp    $0x40,%al
80102538:	75 f6                	jne    80102530 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010253a:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010253f:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102544:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102545:	89 ca                	mov    %ecx,%edx
80102547:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102548:	84 c0                	test   %al,%al
8010254a:	75 1e                	jne    8010256a <ideinit+0x6a>
8010254c:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102551:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102556:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010255d:	00 
8010255e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102560:	83 e9 01             	sub    $0x1,%ecx
80102563:	74 0f                	je     80102574 <ideinit+0x74>
80102565:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102566:	84 c0                	test   %al,%al
80102568:	74 f6                	je     80102560 <ideinit+0x60>
      havedisk1 = 1;
8010256a:	c7 05 00 16 11 80 01 	movl   $0x1,0x80111600
80102571:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102574:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102579:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010257e:	ee                   	out    %al,(%dx)
}
8010257f:	c9                   	leave
80102580:	c3                   	ret
80102581:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102588:	00 
80102589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102590 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102590:	55                   	push   %ebp
80102591:	89 e5                	mov    %esp,%ebp
80102593:	57                   	push   %edi
80102594:	56                   	push   %esi
80102595:	53                   	push   %ebx
80102596:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102599:	68 20 16 11 80       	push   $0x80111620
8010259e:	e8 5d 23 00 00       	call   80104900 <acquire>

  if((b = idequeue) == 0){
801025a3:	8b 1d 04 16 11 80    	mov    0x80111604,%ebx
801025a9:	83 c4 10             	add    $0x10,%esp
801025ac:	85 db                	test   %ebx,%ebx
801025ae:	74 63                	je     80102613 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801025b0:	8b 43 58             	mov    0x58(%ebx),%eax
801025b3:	a3 04 16 11 80       	mov    %eax,0x80111604

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801025b8:	8b 33                	mov    (%ebx),%esi
801025ba:	f7 c6 04 00 00 00    	test   $0x4,%esi
801025c0:	75 2f                	jne    801025f1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025c2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801025c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025ce:	00 
801025cf:	90                   	nop
801025d0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801025d1:	89 c1                	mov    %eax,%ecx
801025d3:	83 e1 c0             	and    $0xffffffc0,%ecx
801025d6:	80 f9 40             	cmp    $0x40,%cl
801025d9:	75 f5                	jne    801025d0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801025db:	a8 21                	test   $0x21,%al
801025dd:	75 12                	jne    801025f1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801025df:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801025e2:	b9 80 00 00 00       	mov    $0x80,%ecx
801025e7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801025ec:	fc                   	cld
801025ed:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801025ef:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801025f1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801025f4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801025f7:	83 ce 02             	or     $0x2,%esi
801025fa:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801025fc:	53                   	push   %ebx
801025fd:	e8 3e 1e 00 00       	call   80104440 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102602:	a1 04 16 11 80       	mov    0x80111604,%eax
80102607:	83 c4 10             	add    $0x10,%esp
8010260a:	85 c0                	test   %eax,%eax
8010260c:	74 05                	je     80102613 <ideintr+0x83>
    idestart(idequeue);
8010260e:	e8 0d fe ff ff       	call   80102420 <idestart>
    release(&idelock);
80102613:	83 ec 0c             	sub    $0xc,%esp
80102616:	68 20 16 11 80       	push   $0x80111620
8010261b:	e8 80 22 00 00       	call   801048a0 <release>

  release(&idelock);
}
80102620:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102623:	5b                   	pop    %ebx
80102624:	5e                   	pop    %esi
80102625:	5f                   	pop    %edi
80102626:	5d                   	pop    %ebp
80102627:	c3                   	ret
80102628:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010262f:	00 

80102630 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	53                   	push   %ebx
80102634:	83 ec 10             	sub    $0x10,%esp
80102637:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010263a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010263d:	50                   	push   %eax
8010263e:	e8 7d 20 00 00       	call   801046c0 <holdingsleep>
80102643:	83 c4 10             	add    $0x10,%esp
80102646:	85 c0                	test   %eax,%eax
80102648:	0f 84 c3 00 00 00    	je     80102711 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010264e:	8b 03                	mov    (%ebx),%eax
80102650:	83 e0 06             	and    $0x6,%eax
80102653:	83 f8 02             	cmp    $0x2,%eax
80102656:	0f 84 a8 00 00 00    	je     80102704 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010265c:	8b 53 04             	mov    0x4(%ebx),%edx
8010265f:	85 d2                	test   %edx,%edx
80102661:	74 0d                	je     80102670 <iderw+0x40>
80102663:	a1 00 16 11 80       	mov    0x80111600,%eax
80102668:	85 c0                	test   %eax,%eax
8010266a:	0f 84 87 00 00 00    	je     801026f7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102670:	83 ec 0c             	sub    $0xc,%esp
80102673:	68 20 16 11 80       	push   $0x80111620
80102678:	e8 83 22 00 00       	call   80104900 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010267d:	a1 04 16 11 80       	mov    0x80111604,%eax
  b->qnext = 0;
80102682:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102689:	83 c4 10             	add    $0x10,%esp
8010268c:	85 c0                	test   %eax,%eax
8010268e:	74 60                	je     801026f0 <iderw+0xc0>
80102690:	89 c2                	mov    %eax,%edx
80102692:	8b 40 58             	mov    0x58(%eax),%eax
80102695:	85 c0                	test   %eax,%eax
80102697:	75 f7                	jne    80102690 <iderw+0x60>
80102699:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010269c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010269e:	39 1d 04 16 11 80    	cmp    %ebx,0x80111604
801026a4:	74 3a                	je     801026e0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801026a6:	8b 03                	mov    (%ebx),%eax
801026a8:	83 e0 06             	and    $0x6,%eax
801026ab:	83 f8 02             	cmp    $0x2,%eax
801026ae:	74 1b                	je     801026cb <iderw+0x9b>
    sleep(b, &idelock);
801026b0:	83 ec 08             	sub    $0x8,%esp
801026b3:	68 20 16 11 80       	push   $0x80111620
801026b8:	53                   	push   %ebx
801026b9:	e8 c2 1c 00 00       	call   80104380 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801026be:	8b 03                	mov    (%ebx),%eax
801026c0:	83 c4 10             	add    $0x10,%esp
801026c3:	83 e0 06             	and    $0x6,%eax
801026c6:	83 f8 02             	cmp    $0x2,%eax
801026c9:	75 e5                	jne    801026b0 <iderw+0x80>
  }


  release(&idelock);
801026cb:	c7 45 08 20 16 11 80 	movl   $0x80111620,0x8(%ebp)
}
801026d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026d5:	c9                   	leave
  release(&idelock);
801026d6:	e9 c5 21 00 00       	jmp    801048a0 <release>
801026db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
801026e0:	89 d8                	mov    %ebx,%eax
801026e2:	e8 39 fd ff ff       	call   80102420 <idestart>
801026e7:	eb bd                	jmp    801026a6 <iderw+0x76>
801026e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801026f0:	ba 04 16 11 80       	mov    $0x80111604,%edx
801026f5:	eb a5                	jmp    8010269c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801026f7:	83 ec 0c             	sub    $0xc,%esp
801026fa:	68 6e 76 10 80       	push   $0x8010766e
801026ff:	e8 7c dc ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102704:	83 ec 0c             	sub    $0xc,%esp
80102707:	68 59 76 10 80       	push   $0x80107659
8010270c:	e8 6f dc ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102711:	83 ec 0c             	sub    $0xc,%esp
80102714:	68 43 76 10 80       	push   $0x80107643
80102719:	e8 62 dc ff ff       	call   80100380 <panic>
8010271e:	66 90                	xchg   %ax,%ax

80102720 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102720:	55                   	push   %ebp
80102721:	89 e5                	mov    %esp,%ebp
80102723:	56                   	push   %esi
80102724:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102725:	c7 05 54 16 11 80 00 	movl   $0xfec00000,0x80111654
8010272c:	00 c0 fe 
  ioapic->reg = reg;
8010272f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102736:	00 00 00 
  return ioapic->data;
80102739:	8b 15 54 16 11 80    	mov    0x80111654,%edx
8010273f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102742:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102748:	8b 1d 54 16 11 80    	mov    0x80111654,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010274e:	0f b6 15 a0 17 11 80 	movzbl 0x801117a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102755:	c1 ee 10             	shr    $0x10,%esi
80102758:	89 f0                	mov    %esi,%eax
8010275a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010275d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102760:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102763:	39 c2                	cmp    %eax,%edx
80102765:	74 16                	je     8010277d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102767:	83 ec 0c             	sub    $0xc,%esp
8010276a:	68 80 7a 10 80       	push   $0x80107a80
8010276f:	e8 ec de ff ff       	call   80100660 <cprintf>
  ioapic->reg = reg;
80102774:	8b 1d 54 16 11 80    	mov    0x80111654,%ebx
8010277a:	83 c4 10             	add    $0x10,%esp
{
8010277d:	ba 10 00 00 00       	mov    $0x10,%edx
80102782:	31 c0                	xor    %eax,%eax
80102784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102788:	89 13                	mov    %edx,(%ebx)
8010278a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010278d:	8b 1d 54 16 11 80    	mov    0x80111654,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102793:	83 c0 01             	add    $0x1,%eax
80102796:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010279c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010279f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
801027a2:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801027a5:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801027a7:	8b 1d 54 16 11 80    	mov    0x80111654,%ebx
801027ad:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
801027b4:	39 c6                	cmp    %eax,%esi
801027b6:	7d d0                	jge    80102788 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801027b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027bb:	5b                   	pop    %ebx
801027bc:	5e                   	pop    %esi
801027bd:	5d                   	pop    %ebp
801027be:	c3                   	ret
801027bf:	90                   	nop

801027c0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801027c0:	55                   	push   %ebp
  ioapic->reg = reg;
801027c1:	8b 0d 54 16 11 80    	mov    0x80111654,%ecx
{
801027c7:	89 e5                	mov    %esp,%ebp
801027c9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801027cc:	8d 50 20             	lea    0x20(%eax),%edx
801027cf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801027d3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801027d5:	8b 0d 54 16 11 80    	mov    0x80111654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027db:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801027de:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801027e4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801027e6:	a1 54 16 11 80       	mov    0x80111654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027eb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801027ee:	89 50 10             	mov    %edx,0x10(%eax)
}
801027f1:	5d                   	pop    %ebp
801027f2:	c3                   	ret
801027f3:	66 90                	xchg   %ax,%ax
801027f5:	66 90                	xchg   %ax,%ax
801027f7:	66 90                	xchg   %ax,%ax
801027f9:	66 90                	xchg   %ax,%ax
801027fb:	66 90                	xchg   %ax,%ax
801027fd:	66 90                	xchg   %ax,%ax
801027ff:	90                   	nop

80102800 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
80102803:	53                   	push   %ebx
80102804:	83 ec 04             	sub    $0x4,%esp
80102807:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010280a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102810:	75 76                	jne    80102888 <kfree+0x88>
80102812:	81 fb f0 54 11 80    	cmp    $0x801154f0,%ebx
80102818:	72 6e                	jb     80102888 <kfree+0x88>
8010281a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102820:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102825:	77 61                	ja     80102888 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102827:	83 ec 04             	sub    $0x4,%esp
8010282a:	68 00 10 00 00       	push   $0x1000
8010282f:	6a 01                	push   $0x1
80102831:	53                   	push   %ebx
80102832:	e8 c9 21 00 00       	call   80104a00 <memset>

  if(kmem.use_lock)
80102837:	8b 15 94 16 11 80    	mov    0x80111694,%edx
8010283d:	83 c4 10             	add    $0x10,%esp
80102840:	85 d2                	test   %edx,%edx
80102842:	75 1c                	jne    80102860 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102844:	a1 98 16 11 80       	mov    0x80111698,%eax
80102849:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010284b:	a1 94 16 11 80       	mov    0x80111694,%eax
  kmem.freelist = r;
80102850:	89 1d 98 16 11 80    	mov    %ebx,0x80111698
  if(kmem.use_lock)
80102856:	85 c0                	test   %eax,%eax
80102858:	75 1e                	jne    80102878 <kfree+0x78>
    release(&kmem.lock);
}
8010285a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010285d:	c9                   	leave
8010285e:	c3                   	ret
8010285f:	90                   	nop
    acquire(&kmem.lock);
80102860:	83 ec 0c             	sub    $0xc,%esp
80102863:	68 60 16 11 80       	push   $0x80111660
80102868:	e8 93 20 00 00       	call   80104900 <acquire>
8010286d:	83 c4 10             	add    $0x10,%esp
80102870:	eb d2                	jmp    80102844 <kfree+0x44>
80102872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102878:	c7 45 08 60 16 11 80 	movl   $0x80111660,0x8(%ebp)
}
8010287f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102882:	c9                   	leave
    release(&kmem.lock);
80102883:	e9 18 20 00 00       	jmp    801048a0 <release>
    panic("kfree");
80102888:	83 ec 0c             	sub    $0xc,%esp
8010288b:	68 8c 76 10 80       	push   $0x8010768c
80102890:	e8 eb da ff ff       	call   80100380 <panic>
80102895:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010289c:	00 
8010289d:	8d 76 00             	lea    0x0(%esi),%esi

801028a0 <freerange>:
{
801028a0:	55                   	push   %ebp
801028a1:	89 e5                	mov    %esp,%ebp
801028a3:	56                   	push   %esi
801028a4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801028a5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801028a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801028ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801028b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801028bd:	39 de                	cmp    %ebx,%esi
801028bf:	72 23                	jb     801028e4 <freerange+0x44>
801028c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801028c8:	83 ec 0c             	sub    $0xc,%esp
801028cb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801028d7:	50                   	push   %eax
801028d8:	e8 23 ff ff ff       	call   80102800 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028dd:	83 c4 10             	add    $0x10,%esp
801028e0:	39 de                	cmp    %ebx,%esi
801028e2:	73 e4                	jae    801028c8 <freerange+0x28>
}
801028e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801028e7:	5b                   	pop    %ebx
801028e8:	5e                   	pop    %esi
801028e9:	5d                   	pop    %ebp
801028ea:	c3                   	ret
801028eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801028f0 <kinit2>:
{
801028f0:	55                   	push   %ebp
801028f1:	89 e5                	mov    %esp,%ebp
801028f3:	56                   	push   %esi
801028f4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801028f5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801028f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801028fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102901:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102907:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010290d:	39 de                	cmp    %ebx,%esi
8010290f:	72 23                	jb     80102934 <kinit2+0x44>
80102911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102918:	83 ec 0c             	sub    $0xc,%esp
8010291b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102921:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102927:	50                   	push   %eax
80102928:	e8 d3 fe ff ff       	call   80102800 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010292d:	83 c4 10             	add    $0x10,%esp
80102930:	39 de                	cmp    %ebx,%esi
80102932:	73 e4                	jae    80102918 <kinit2+0x28>
  kmem.use_lock = 1;
80102934:	c7 05 94 16 11 80 01 	movl   $0x1,0x80111694
8010293b:	00 00 00 
}
8010293e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102941:	5b                   	pop    %ebx
80102942:	5e                   	pop    %esi
80102943:	5d                   	pop    %ebp
80102944:	c3                   	ret
80102945:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010294c:	00 
8010294d:	8d 76 00             	lea    0x0(%esi),%esi

80102950 <kinit1>:
{
80102950:	55                   	push   %ebp
80102951:	89 e5                	mov    %esp,%ebp
80102953:	56                   	push   %esi
80102954:	53                   	push   %ebx
80102955:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102958:	83 ec 08             	sub    $0x8,%esp
8010295b:	68 92 76 10 80       	push   $0x80107692
80102960:	68 60 16 11 80       	push   $0x80111660
80102965:	e8 a6 1d 00 00       	call   80104710 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010296a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010296d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102970:	c7 05 94 16 11 80 00 	movl   $0x0,0x80111694
80102977:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010297a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102980:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102986:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010298c:	39 de                	cmp    %ebx,%esi
8010298e:	72 1c                	jb     801029ac <kinit1+0x5c>
    kfree(p);
80102990:	83 ec 0c             	sub    $0xc,%esp
80102993:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102999:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010299f:	50                   	push   %eax
801029a0:	e8 5b fe ff ff       	call   80102800 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801029a5:	83 c4 10             	add    $0x10,%esp
801029a8:	39 de                	cmp    %ebx,%esi
801029aa:	73 e4                	jae    80102990 <kinit1+0x40>
}
801029ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801029af:	5b                   	pop    %ebx
801029b0:	5e                   	pop    %esi
801029b1:	5d                   	pop    %ebp
801029b2:	c3                   	ret
801029b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ba:	00 
801029bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801029c0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801029c0:	55                   	push   %ebp
801029c1:	89 e5                	mov    %esp,%ebp
801029c3:	53                   	push   %ebx
801029c4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801029c7:	a1 94 16 11 80       	mov    0x80111694,%eax
801029cc:	85 c0                	test   %eax,%eax
801029ce:	75 20                	jne    801029f0 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
801029d0:	8b 1d 98 16 11 80    	mov    0x80111698,%ebx
  if(r)
801029d6:	85 db                	test   %ebx,%ebx
801029d8:	74 07                	je     801029e1 <kalloc+0x21>
    kmem.freelist = r->next;
801029da:	8b 03                	mov    (%ebx),%eax
801029dc:	a3 98 16 11 80       	mov    %eax,0x80111698
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801029e1:	89 d8                	mov    %ebx,%eax
801029e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029e6:	c9                   	leave
801029e7:	c3                   	ret
801029e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ef:	00 
    acquire(&kmem.lock);
801029f0:	83 ec 0c             	sub    $0xc,%esp
801029f3:	68 60 16 11 80       	push   $0x80111660
801029f8:	e8 03 1f 00 00       	call   80104900 <acquire>
  r = kmem.freelist;
801029fd:	8b 1d 98 16 11 80    	mov    0x80111698,%ebx
  if(kmem.use_lock)
80102a03:	a1 94 16 11 80       	mov    0x80111694,%eax
  if(r)
80102a08:	83 c4 10             	add    $0x10,%esp
80102a0b:	85 db                	test   %ebx,%ebx
80102a0d:	74 08                	je     80102a17 <kalloc+0x57>
    kmem.freelist = r->next;
80102a0f:	8b 13                	mov    (%ebx),%edx
80102a11:	89 15 98 16 11 80    	mov    %edx,0x80111698
  if(kmem.use_lock)
80102a17:	85 c0                	test   %eax,%eax
80102a19:	74 c6                	je     801029e1 <kalloc+0x21>
    release(&kmem.lock);
80102a1b:	83 ec 0c             	sub    $0xc,%esp
80102a1e:	68 60 16 11 80       	push   $0x80111660
80102a23:	e8 78 1e 00 00       	call   801048a0 <release>
}
80102a28:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
80102a2a:	83 c4 10             	add    $0x10,%esp
}
80102a2d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a30:	c9                   	leave
80102a31:	c3                   	ret
80102a32:	66 90                	xchg   %ax,%ax
80102a34:	66 90                	xchg   %ax,%ax
80102a36:	66 90                	xchg   %ax,%ax
80102a38:	66 90                	xchg   %ax,%ax
80102a3a:	66 90                	xchg   %ax,%ax
80102a3c:	66 90                	xchg   %ax,%ax
80102a3e:	66 90                	xchg   %ax,%ax

80102a40 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a40:	ba 64 00 00 00       	mov    $0x64,%edx
80102a45:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102a46:	a8 01                	test   $0x1,%al
80102a48:	0f 84 c2 00 00 00    	je     80102b10 <kbdgetc+0xd0>
{
80102a4e:	55                   	push   %ebp
80102a4f:	ba 60 00 00 00       	mov    $0x60,%edx
80102a54:	89 e5                	mov    %esp,%ebp
80102a56:	53                   	push   %ebx
80102a57:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102a58:	8b 1d 9c 16 11 80    	mov    0x8011169c,%ebx
  data = inb(KBDATAP);
80102a5e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102a61:	3c e0                	cmp    $0xe0,%al
80102a63:	74 5b                	je     80102ac0 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102a65:	89 da                	mov    %ebx,%edx
80102a67:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
80102a6a:	84 c0                	test   %al,%al
80102a6c:	78 62                	js     80102ad0 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102a6e:	85 d2                	test   %edx,%edx
80102a70:	74 09                	je     80102a7b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102a72:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102a75:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102a78:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102a7b:	0f b6 91 e0 7c 10 80 	movzbl -0x7fef8320(%ecx),%edx
  shift ^= togglecode[data];
80102a82:	0f b6 81 e0 7b 10 80 	movzbl -0x7fef8420(%ecx),%eax
  shift |= shiftcode[data];
80102a89:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102a8b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102a8d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80102a8f:	89 15 9c 16 11 80    	mov    %edx,0x8011169c
  c = charcode[shift & (CTL | SHIFT)][data];
80102a95:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102a98:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102a9b:	8b 04 85 c0 7b 10 80 	mov    -0x7fef8440(,%eax,4),%eax
80102aa2:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102aa6:	74 0b                	je     80102ab3 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102aa8:	8d 50 9f             	lea    -0x61(%eax),%edx
80102aab:	83 fa 19             	cmp    $0x19,%edx
80102aae:	77 48                	ja     80102af8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102ab0:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102ab3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ab6:	c9                   	leave
80102ab7:	c3                   	ret
80102ab8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102abf:	00 
    shift |= E0ESC;
80102ac0:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102ac3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102ac5:	89 1d 9c 16 11 80    	mov    %ebx,0x8011169c
}
80102acb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ace:	c9                   	leave
80102acf:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102ad0:	83 e0 7f             	and    $0x7f,%eax
80102ad3:	85 d2                	test   %edx,%edx
80102ad5:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102ad8:	0f b6 81 e0 7c 10 80 	movzbl -0x7fef8320(%ecx),%eax
80102adf:	83 c8 40             	or     $0x40,%eax
80102ae2:	0f b6 c0             	movzbl %al,%eax
80102ae5:	f7 d0                	not    %eax
80102ae7:	21 d8                	and    %ebx,%eax
80102ae9:	a3 9c 16 11 80       	mov    %eax,0x8011169c
    return 0;
80102aee:	31 c0                	xor    %eax,%eax
80102af0:	eb d9                	jmp    80102acb <kbdgetc+0x8b>
80102af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102af8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102afb:	8d 50 20             	lea    0x20(%eax),%edx
}
80102afe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b01:	c9                   	leave
      c += 'a' - 'A';
80102b02:	83 f9 1a             	cmp    $0x1a,%ecx
80102b05:	0f 42 c2             	cmovb  %edx,%eax
}
80102b08:	c3                   	ret
80102b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102b10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102b15:	c3                   	ret
80102b16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b1d:	00 
80102b1e:	66 90                	xchg   %ax,%ax

80102b20 <kbdintr>:

void
kbdintr(void)
{
80102b20:	55                   	push   %ebp
80102b21:	89 e5                	mov    %esp,%ebp
80102b23:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102b26:	68 40 2a 10 80       	push   $0x80102a40
80102b2b:	e8 80 dd ff ff       	call   801008b0 <consoleintr>
}
80102b30:	83 c4 10             	add    $0x10,%esp
80102b33:	c9                   	leave
80102b34:	c3                   	ret
80102b35:	66 90                	xchg   %ax,%ax
80102b37:	66 90                	xchg   %ax,%ax
80102b39:	66 90                	xchg   %ax,%ax
80102b3b:	66 90                	xchg   %ax,%ax
80102b3d:	66 90                	xchg   %ax,%ax
80102b3f:	90                   	nop

80102b40 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102b40:	a1 a0 16 11 80       	mov    0x801116a0,%eax
80102b45:	85 c0                	test   %eax,%eax
80102b47:	0f 84 c3 00 00 00    	je     80102c10 <lapicinit+0xd0>
  lapic[index] = value;
80102b4d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102b54:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b57:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b5a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102b61:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b64:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b67:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102b6e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102b71:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b74:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102b7b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102b7e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b81:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102b88:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102b8b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b8e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102b95:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102b98:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102b9b:	8b 50 30             	mov    0x30(%eax),%edx
80102b9e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102ba4:	75 72                	jne    80102c18 <lapicinit+0xd8>
  lapic[index] = value;
80102ba6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102bad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bb0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bb3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102bba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bbd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bc0:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102bc7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bcd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102bd4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bd7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bda:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102be1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102be4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102be7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102bee:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102bf1:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102bf8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102bfe:	80 e6 10             	and    $0x10,%dh
80102c01:	75 f5                	jne    80102bf8 <lapicinit+0xb8>
  lapic[index] = value;
80102c03:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102c0a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c0d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102c10:	c3                   	ret
80102c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102c18:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102c1f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102c22:	8b 50 20             	mov    0x20(%eax),%edx
}
80102c25:	e9 7c ff ff ff       	jmp    80102ba6 <lapicinit+0x66>
80102c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102c30 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102c30:	a1 a0 16 11 80       	mov    0x801116a0,%eax
80102c35:	85 c0                	test   %eax,%eax
80102c37:	74 07                	je     80102c40 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102c39:	8b 40 20             	mov    0x20(%eax),%eax
80102c3c:	c1 e8 18             	shr    $0x18,%eax
80102c3f:	c3                   	ret
    return 0;
80102c40:	31 c0                	xor    %eax,%eax
}
80102c42:	c3                   	ret
80102c43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c4a:	00 
80102c4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102c50 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102c50:	a1 a0 16 11 80       	mov    0x801116a0,%eax
80102c55:	85 c0                	test   %eax,%eax
80102c57:	74 0d                	je     80102c66 <lapiceoi+0x16>
  lapic[index] = value;
80102c59:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102c60:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c63:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102c66:	c3                   	ret
80102c67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c6e:	00 
80102c6f:	90                   	nop

80102c70 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102c70:	c3                   	ret
80102c71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c78:	00 
80102c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c80 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102c80:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c81:	b8 0f 00 00 00       	mov    $0xf,%eax
80102c86:	ba 70 00 00 00       	mov    $0x70,%edx
80102c8b:	89 e5                	mov    %esp,%ebp
80102c8d:	53                   	push   %ebx
80102c8e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102c91:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102c94:	ee                   	out    %al,(%dx)
80102c95:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c9a:	ba 71 00 00 00       	mov    $0x71,%edx
80102c9f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102ca0:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102ca2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102ca5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102cab:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102cad:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102cb0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102cb2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102cb5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102cb8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102cbe:	a1 a0 16 11 80       	mov    0x801116a0,%eax
80102cc3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102cc9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ccc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102cd3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cd6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102cd9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102ce0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ce3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ce6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102cec:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102cef:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102cf5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102cf8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102cfe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d01:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d07:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102d0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d0d:	c9                   	leave
80102d0e:	c3                   	ret
80102d0f:	90                   	nop

80102d10 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102d10:	55                   	push   %ebp
80102d11:	b8 0b 00 00 00       	mov    $0xb,%eax
80102d16:	ba 70 00 00 00       	mov    $0x70,%edx
80102d1b:	89 e5                	mov    %esp,%ebp
80102d1d:	57                   	push   %edi
80102d1e:	56                   	push   %esi
80102d1f:	53                   	push   %ebx
80102d20:	83 ec 4c             	sub    $0x4c,%esp
80102d23:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d24:	ba 71 00 00 00       	mov    $0x71,%edx
80102d29:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102d2a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d2d:	bf 70 00 00 00       	mov    $0x70,%edi
80102d32:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102d35:	8d 76 00             	lea    0x0(%esi),%esi
80102d38:	31 c0                	xor    %eax,%eax
80102d3a:	89 fa                	mov    %edi,%edx
80102d3c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d3d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102d42:	89 ca                	mov    %ecx,%edx
80102d44:	ec                   	in     (%dx),%al
80102d45:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d48:	89 fa                	mov    %edi,%edx
80102d4a:	b8 02 00 00 00       	mov    $0x2,%eax
80102d4f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d50:	89 ca                	mov    %ecx,%edx
80102d52:	ec                   	in     (%dx),%al
80102d53:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d56:	89 fa                	mov    %edi,%edx
80102d58:	b8 04 00 00 00       	mov    $0x4,%eax
80102d5d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d5e:	89 ca                	mov    %ecx,%edx
80102d60:	ec                   	in     (%dx),%al
80102d61:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d64:	89 fa                	mov    %edi,%edx
80102d66:	b8 07 00 00 00       	mov    $0x7,%eax
80102d6b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d6c:	89 ca                	mov    %ecx,%edx
80102d6e:	ec                   	in     (%dx),%al
80102d6f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d72:	89 fa                	mov    %edi,%edx
80102d74:	b8 08 00 00 00       	mov    $0x8,%eax
80102d79:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d7a:	89 ca                	mov    %ecx,%edx
80102d7c:	ec                   	in     (%dx),%al
80102d7d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d7f:	89 fa                	mov    %edi,%edx
80102d81:	b8 09 00 00 00       	mov    $0x9,%eax
80102d86:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d87:	89 ca                	mov    %ecx,%edx
80102d89:	ec                   	in     (%dx),%al
80102d8a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d8d:	89 fa                	mov    %edi,%edx
80102d8f:	b8 0a 00 00 00       	mov    $0xa,%eax
80102d94:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d95:	89 ca                	mov    %ecx,%edx
80102d97:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102d98:	84 c0                	test   %al,%al
80102d9a:	78 9c                	js     80102d38 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102d9c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102da0:	89 f2                	mov    %esi,%edx
80102da2:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102da5:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102da8:	89 fa                	mov    %edi,%edx
80102daa:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102dad:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102db1:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102db4:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102db7:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102dbb:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102dbe:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102dc2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102dc5:	31 c0                	xor    %eax,%eax
80102dc7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dc8:	89 ca                	mov    %ecx,%edx
80102dca:	ec                   	in     (%dx),%al
80102dcb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dce:	89 fa                	mov    %edi,%edx
80102dd0:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102dd3:	b8 02 00 00 00       	mov    $0x2,%eax
80102dd8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dd9:	89 ca                	mov    %ecx,%edx
80102ddb:	ec                   	in     (%dx),%al
80102ddc:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ddf:	89 fa                	mov    %edi,%edx
80102de1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102de4:	b8 04 00 00 00       	mov    $0x4,%eax
80102de9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dea:	89 ca                	mov    %ecx,%edx
80102dec:	ec                   	in     (%dx),%al
80102ded:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102df0:	89 fa                	mov    %edi,%edx
80102df2:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102df5:	b8 07 00 00 00       	mov    $0x7,%eax
80102dfa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dfb:	89 ca                	mov    %ecx,%edx
80102dfd:	ec                   	in     (%dx),%al
80102dfe:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e01:	89 fa                	mov    %edi,%edx
80102e03:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102e06:	b8 08 00 00 00       	mov    $0x8,%eax
80102e0b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e0c:	89 ca                	mov    %ecx,%edx
80102e0e:	ec                   	in     (%dx),%al
80102e0f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e12:	89 fa                	mov    %edi,%edx
80102e14:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102e17:	b8 09 00 00 00       	mov    $0x9,%eax
80102e1c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e1d:	89 ca                	mov    %ecx,%edx
80102e1f:	ec                   	in     (%dx),%al
80102e20:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102e23:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102e26:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102e29:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102e2c:	6a 18                	push   $0x18
80102e2e:	50                   	push   %eax
80102e2f:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102e32:	50                   	push   %eax
80102e33:	e8 08 1c 00 00       	call   80104a40 <memcmp>
80102e38:	83 c4 10             	add    $0x10,%esp
80102e3b:	85 c0                	test   %eax,%eax
80102e3d:	0f 85 f5 fe ff ff    	jne    80102d38 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102e43:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102e47:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e4a:	89 f0                	mov    %esi,%eax
80102e4c:	84 c0                	test   %al,%al
80102e4e:	75 78                	jne    80102ec8 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102e50:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102e53:	89 c2                	mov    %eax,%edx
80102e55:	83 e0 0f             	and    $0xf,%eax
80102e58:	c1 ea 04             	shr    $0x4,%edx
80102e5b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e5e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e61:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102e64:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102e67:	89 c2                	mov    %eax,%edx
80102e69:	83 e0 0f             	and    $0xf,%eax
80102e6c:	c1 ea 04             	shr    $0x4,%edx
80102e6f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e72:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e75:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102e78:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102e7b:	89 c2                	mov    %eax,%edx
80102e7d:	83 e0 0f             	and    $0xf,%eax
80102e80:	c1 ea 04             	shr    $0x4,%edx
80102e83:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e86:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e89:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102e8c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102e8f:	89 c2                	mov    %eax,%edx
80102e91:	83 e0 0f             	and    $0xf,%eax
80102e94:	c1 ea 04             	shr    $0x4,%edx
80102e97:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e9a:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e9d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102ea0:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ea3:	89 c2                	mov    %eax,%edx
80102ea5:	83 e0 0f             	and    $0xf,%eax
80102ea8:	c1 ea 04             	shr    $0x4,%edx
80102eab:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102eae:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102eb1:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102eb4:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102eb7:	89 c2                	mov    %eax,%edx
80102eb9:	83 e0 0f             	and    $0xf,%eax
80102ebc:	c1 ea 04             	shr    $0x4,%edx
80102ebf:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ec2:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ec5:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102ec8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ecb:	89 03                	mov    %eax,(%ebx)
80102ecd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ed0:	89 43 04             	mov    %eax,0x4(%ebx)
80102ed3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ed6:	89 43 08             	mov    %eax,0x8(%ebx)
80102ed9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102edc:	89 43 0c             	mov    %eax,0xc(%ebx)
80102edf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ee2:	89 43 10             	mov    %eax,0x10(%ebx)
80102ee5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ee8:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102eeb:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102ef2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ef5:	5b                   	pop    %ebx
80102ef6:	5e                   	pop    %esi
80102ef7:	5f                   	pop    %edi
80102ef8:	5d                   	pop    %ebp
80102ef9:	c3                   	ret
80102efa:	66 90                	xchg   %ax,%ax
80102efc:	66 90                	xchg   %ax,%ax
80102efe:	66 90                	xchg   %ax,%ax

80102f00 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102f00:	8b 0d 08 17 11 80    	mov    0x80111708,%ecx
80102f06:	85 c9                	test   %ecx,%ecx
80102f08:	0f 8e 8a 00 00 00    	jle    80102f98 <install_trans+0x98>
{
80102f0e:	55                   	push   %ebp
80102f0f:	89 e5                	mov    %esp,%ebp
80102f11:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102f12:	31 ff                	xor    %edi,%edi
{
80102f14:	56                   	push   %esi
80102f15:	53                   	push   %ebx
80102f16:	83 ec 0c             	sub    $0xc,%esp
80102f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102f20:	a1 f4 16 11 80       	mov    0x801116f4,%eax
80102f25:	83 ec 08             	sub    $0x8,%esp
80102f28:	01 f8                	add    %edi,%eax
80102f2a:	83 c0 01             	add    $0x1,%eax
80102f2d:	50                   	push   %eax
80102f2e:	ff 35 04 17 11 80    	push   0x80111704
80102f34:	e8 97 d1 ff ff       	call   801000d0 <bread>
80102f39:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102f3b:	58                   	pop    %eax
80102f3c:	5a                   	pop    %edx
80102f3d:	ff 34 bd 0c 17 11 80 	push   -0x7feee8f4(,%edi,4)
80102f44:	ff 35 04 17 11 80    	push   0x80111704
  for (tail = 0; tail < log.lh.n; tail++) {
80102f4a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102f4d:	e8 7e d1 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102f52:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102f55:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102f57:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f5a:	68 00 02 00 00       	push   $0x200
80102f5f:	50                   	push   %eax
80102f60:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102f63:	50                   	push   %eax
80102f64:	e8 27 1b 00 00       	call   80104a90 <memmove>
    bwrite(dbuf);  // write dst to disk
80102f69:	89 1c 24             	mov    %ebx,(%esp)
80102f6c:	e8 3f d2 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102f71:	89 34 24             	mov    %esi,(%esp)
80102f74:	e8 77 d2 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102f79:	89 1c 24             	mov    %ebx,(%esp)
80102f7c:	e8 6f d2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102f81:	83 c4 10             	add    $0x10,%esp
80102f84:	39 3d 08 17 11 80    	cmp    %edi,0x80111708
80102f8a:	7f 94                	jg     80102f20 <install_trans+0x20>
  }
}
80102f8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f8f:	5b                   	pop    %ebx
80102f90:	5e                   	pop    %esi
80102f91:	5f                   	pop    %edi
80102f92:	5d                   	pop    %ebp
80102f93:	c3                   	ret
80102f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f98:	c3                   	ret
80102f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102fa0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102fa0:	55                   	push   %ebp
80102fa1:	89 e5                	mov    %esp,%ebp
80102fa3:	53                   	push   %ebx
80102fa4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102fa7:	ff 35 f4 16 11 80    	push   0x801116f4
80102fad:	ff 35 04 17 11 80    	push   0x80111704
80102fb3:	e8 18 d1 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102fb8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102fbb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102fbd:	a1 08 17 11 80       	mov    0x80111708,%eax
80102fc2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102fc5:	85 c0                	test   %eax,%eax
80102fc7:	7e 19                	jle    80102fe2 <write_head+0x42>
80102fc9:	31 d2                	xor    %edx,%edx
80102fcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102fd0:	8b 0c 95 0c 17 11 80 	mov    -0x7feee8f4(,%edx,4),%ecx
80102fd7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102fdb:	83 c2 01             	add    $0x1,%edx
80102fde:	39 d0                	cmp    %edx,%eax
80102fe0:	75 ee                	jne    80102fd0 <write_head+0x30>
  }
  bwrite(buf);
80102fe2:	83 ec 0c             	sub    $0xc,%esp
80102fe5:	53                   	push   %ebx
80102fe6:	e8 c5 d1 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102feb:	89 1c 24             	mov    %ebx,(%esp)
80102fee:	e8 fd d1 ff ff       	call   801001f0 <brelse>
}
80102ff3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ff6:	83 c4 10             	add    $0x10,%esp
80102ff9:	c9                   	leave
80102ffa:	c3                   	ret
80102ffb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103000 <initlog>:
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	53                   	push   %ebx
80103004:	83 ec 2c             	sub    $0x2c,%esp
80103007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010300a:	68 97 76 10 80       	push   $0x80107697
8010300f:	68 c0 16 11 80       	push   $0x801116c0
80103014:	e8 f7 16 00 00       	call   80104710 <initlock>
  readsb(dev, &sb);
80103019:	58                   	pop    %eax
8010301a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010301d:	5a                   	pop    %edx
8010301e:	50                   	push   %eax
8010301f:	53                   	push   %ebx
80103020:	e8 7b e8 ff ff       	call   801018a0 <readsb>
  log.start = sb.logstart;
80103025:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103028:	59                   	pop    %ecx
  log.dev = dev;
80103029:	89 1d 04 17 11 80    	mov    %ebx,0x80111704
  log.size = sb.nlog;
8010302f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103032:	a3 f4 16 11 80       	mov    %eax,0x801116f4
  log.size = sb.nlog;
80103037:	89 15 f8 16 11 80    	mov    %edx,0x801116f8
  struct buf *buf = bread(log.dev, log.start);
8010303d:	5a                   	pop    %edx
8010303e:	50                   	push   %eax
8010303f:	53                   	push   %ebx
80103040:	e8 8b d0 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103045:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103048:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010304b:	89 1d 08 17 11 80    	mov    %ebx,0x80111708
  for (i = 0; i < log.lh.n; i++) {
80103051:	85 db                	test   %ebx,%ebx
80103053:	7e 1d                	jle    80103072 <initlog+0x72>
80103055:	31 d2                	xor    %edx,%edx
80103057:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010305e:	00 
8010305f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80103060:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103064:	89 0c 95 0c 17 11 80 	mov    %ecx,-0x7feee8f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010306b:	83 c2 01             	add    $0x1,%edx
8010306e:	39 d3                	cmp    %edx,%ebx
80103070:	75 ee                	jne    80103060 <initlog+0x60>
  brelse(buf);
80103072:	83 ec 0c             	sub    $0xc,%esp
80103075:	50                   	push   %eax
80103076:	e8 75 d1 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010307b:	e8 80 fe ff ff       	call   80102f00 <install_trans>
  log.lh.n = 0;
80103080:	c7 05 08 17 11 80 00 	movl   $0x0,0x80111708
80103087:	00 00 00 
  write_head(); // clear the log
8010308a:	e8 11 ff ff ff       	call   80102fa0 <write_head>
}
8010308f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103092:	83 c4 10             	add    $0x10,%esp
80103095:	c9                   	leave
80103096:	c3                   	ret
80103097:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010309e:	00 
8010309f:	90                   	nop

801030a0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
801030a6:	68 c0 16 11 80       	push   $0x801116c0
801030ab:	e8 50 18 00 00       	call   80104900 <acquire>
801030b0:	83 c4 10             	add    $0x10,%esp
801030b3:	eb 18                	jmp    801030cd <begin_op+0x2d>
801030b5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801030b8:	83 ec 08             	sub    $0x8,%esp
801030bb:	68 c0 16 11 80       	push   $0x801116c0
801030c0:	68 c0 16 11 80       	push   $0x801116c0
801030c5:	e8 b6 12 00 00       	call   80104380 <sleep>
801030ca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801030cd:	a1 00 17 11 80       	mov    0x80111700,%eax
801030d2:	85 c0                	test   %eax,%eax
801030d4:	75 e2                	jne    801030b8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801030d6:	a1 fc 16 11 80       	mov    0x801116fc,%eax
801030db:	8b 15 08 17 11 80    	mov    0x80111708,%edx
801030e1:	83 c0 01             	add    $0x1,%eax
801030e4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801030e7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801030ea:	83 fa 1e             	cmp    $0x1e,%edx
801030ed:	7f c9                	jg     801030b8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801030ef:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801030f2:	a3 fc 16 11 80       	mov    %eax,0x801116fc
      release(&log.lock);
801030f7:	68 c0 16 11 80       	push   $0x801116c0
801030fc:	e8 9f 17 00 00       	call   801048a0 <release>
      break;
    }
  }
}
80103101:	83 c4 10             	add    $0x10,%esp
80103104:	c9                   	leave
80103105:	c3                   	ret
80103106:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010310d:	00 
8010310e:	66 90                	xchg   %ax,%ax

80103110 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	57                   	push   %edi
80103114:	56                   	push   %esi
80103115:	53                   	push   %ebx
80103116:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103119:	68 c0 16 11 80       	push   $0x801116c0
8010311e:	e8 dd 17 00 00       	call   80104900 <acquire>
  log.outstanding -= 1;
80103123:	a1 fc 16 11 80       	mov    0x801116fc,%eax
  if(log.committing)
80103128:	8b 35 00 17 11 80    	mov    0x80111700,%esi
8010312e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103131:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103134:	89 1d fc 16 11 80    	mov    %ebx,0x801116fc
  if(log.committing)
8010313a:	85 f6                	test   %esi,%esi
8010313c:	0f 85 22 01 00 00    	jne    80103264 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103142:	85 db                	test   %ebx,%ebx
80103144:	0f 85 f6 00 00 00    	jne    80103240 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010314a:	c7 05 00 17 11 80 01 	movl   $0x1,0x80111700
80103151:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103154:	83 ec 0c             	sub    $0xc,%esp
80103157:	68 c0 16 11 80       	push   $0x801116c0
8010315c:	e8 3f 17 00 00       	call   801048a0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103161:	8b 0d 08 17 11 80    	mov    0x80111708,%ecx
80103167:	83 c4 10             	add    $0x10,%esp
8010316a:	85 c9                	test   %ecx,%ecx
8010316c:	7f 42                	jg     801031b0 <end_op+0xa0>
    acquire(&log.lock);
8010316e:	83 ec 0c             	sub    $0xc,%esp
80103171:	68 c0 16 11 80       	push   $0x801116c0
80103176:	e8 85 17 00 00       	call   80104900 <acquire>
    log.committing = 0;
8010317b:	c7 05 00 17 11 80 00 	movl   $0x0,0x80111700
80103182:	00 00 00 
    wakeup(&log);
80103185:	c7 04 24 c0 16 11 80 	movl   $0x801116c0,(%esp)
8010318c:	e8 af 12 00 00       	call   80104440 <wakeup>
    release(&log.lock);
80103191:	c7 04 24 c0 16 11 80 	movl   $0x801116c0,(%esp)
80103198:	e8 03 17 00 00       	call   801048a0 <release>
8010319d:	83 c4 10             	add    $0x10,%esp
}
801031a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031a3:	5b                   	pop    %ebx
801031a4:	5e                   	pop    %esi
801031a5:	5f                   	pop    %edi
801031a6:	5d                   	pop    %ebp
801031a7:	c3                   	ret
801031a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031af:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801031b0:	a1 f4 16 11 80       	mov    0x801116f4,%eax
801031b5:	83 ec 08             	sub    $0x8,%esp
801031b8:	01 d8                	add    %ebx,%eax
801031ba:	83 c0 01             	add    $0x1,%eax
801031bd:	50                   	push   %eax
801031be:	ff 35 04 17 11 80    	push   0x80111704
801031c4:	e8 07 cf ff ff       	call   801000d0 <bread>
801031c9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801031cb:	58                   	pop    %eax
801031cc:	5a                   	pop    %edx
801031cd:	ff 34 9d 0c 17 11 80 	push   -0x7feee8f4(,%ebx,4)
801031d4:	ff 35 04 17 11 80    	push   0x80111704
  for (tail = 0; tail < log.lh.n; tail++) {
801031da:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801031dd:	e8 ee ce ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
801031e2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801031e5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801031e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801031ea:	68 00 02 00 00       	push   $0x200
801031ef:	50                   	push   %eax
801031f0:	8d 46 5c             	lea    0x5c(%esi),%eax
801031f3:	50                   	push   %eax
801031f4:	e8 97 18 00 00       	call   80104a90 <memmove>
    bwrite(to);  // write the log
801031f9:	89 34 24             	mov    %esi,(%esp)
801031fc:	e8 af cf ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103201:	89 3c 24             	mov    %edi,(%esp)
80103204:	e8 e7 cf ff ff       	call   801001f0 <brelse>
    brelse(to);
80103209:	89 34 24             	mov    %esi,(%esp)
8010320c:	e8 df cf ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103211:	83 c4 10             	add    $0x10,%esp
80103214:	3b 1d 08 17 11 80    	cmp    0x80111708,%ebx
8010321a:	7c 94                	jl     801031b0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010321c:	e8 7f fd ff ff       	call   80102fa0 <write_head>
    install_trans(); // Now install writes to home locations
80103221:	e8 da fc ff ff       	call   80102f00 <install_trans>
    log.lh.n = 0;
80103226:	c7 05 08 17 11 80 00 	movl   $0x0,0x80111708
8010322d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103230:	e8 6b fd ff ff       	call   80102fa0 <write_head>
80103235:	e9 34 ff ff ff       	jmp    8010316e <end_op+0x5e>
8010323a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103240:	83 ec 0c             	sub    $0xc,%esp
80103243:	68 c0 16 11 80       	push   $0x801116c0
80103248:	e8 f3 11 00 00       	call   80104440 <wakeup>
  release(&log.lock);
8010324d:	c7 04 24 c0 16 11 80 	movl   $0x801116c0,(%esp)
80103254:	e8 47 16 00 00       	call   801048a0 <release>
80103259:	83 c4 10             	add    $0x10,%esp
}
8010325c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010325f:	5b                   	pop    %ebx
80103260:	5e                   	pop    %esi
80103261:	5f                   	pop    %edi
80103262:	5d                   	pop    %ebp
80103263:	c3                   	ret
    panic("log.committing");
80103264:	83 ec 0c             	sub    $0xc,%esp
80103267:	68 9b 76 10 80       	push   $0x8010769b
8010326c:	e8 0f d1 ff ff       	call   80100380 <panic>
80103271:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103278:	00 
80103279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103280 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103280:	55                   	push   %ebp
80103281:	89 e5                	mov    %esp,%ebp
80103283:	53                   	push   %ebx
80103284:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103287:	8b 15 08 17 11 80    	mov    0x80111708,%edx
{
8010328d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103290:	83 fa 1d             	cmp    $0x1d,%edx
80103293:	7f 7d                	jg     80103312 <log_write+0x92>
80103295:	a1 f8 16 11 80       	mov    0x801116f8,%eax
8010329a:	83 e8 01             	sub    $0x1,%eax
8010329d:	39 c2                	cmp    %eax,%edx
8010329f:	7d 71                	jge    80103312 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
801032a1:	a1 fc 16 11 80       	mov    0x801116fc,%eax
801032a6:	85 c0                	test   %eax,%eax
801032a8:	7e 75                	jle    8010331f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
801032aa:	83 ec 0c             	sub    $0xc,%esp
801032ad:	68 c0 16 11 80       	push   $0x801116c0
801032b2:	e8 49 16 00 00       	call   80104900 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801032b7:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801032ba:	83 c4 10             	add    $0x10,%esp
801032bd:	31 c0                	xor    %eax,%eax
801032bf:	8b 15 08 17 11 80    	mov    0x80111708,%edx
801032c5:	85 d2                	test   %edx,%edx
801032c7:	7f 0e                	jg     801032d7 <log_write+0x57>
801032c9:	eb 15                	jmp    801032e0 <log_write+0x60>
801032cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801032d0:	83 c0 01             	add    $0x1,%eax
801032d3:	39 c2                	cmp    %eax,%edx
801032d5:	74 29                	je     80103300 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801032d7:	39 0c 85 0c 17 11 80 	cmp    %ecx,-0x7feee8f4(,%eax,4)
801032de:	75 f0                	jne    801032d0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
801032e0:	89 0c 85 0c 17 11 80 	mov    %ecx,-0x7feee8f4(,%eax,4)
  if (i == log.lh.n)
801032e7:	39 c2                	cmp    %eax,%edx
801032e9:	74 1c                	je     80103307 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
801032eb:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
801032ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
801032f1:	c7 45 08 c0 16 11 80 	movl   $0x801116c0,0x8(%ebp)
}
801032f8:	c9                   	leave
  release(&log.lock);
801032f9:	e9 a2 15 00 00       	jmp    801048a0 <release>
801032fe:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103300:	89 0c 95 0c 17 11 80 	mov    %ecx,-0x7feee8f4(,%edx,4)
    log.lh.n++;
80103307:	83 c2 01             	add    $0x1,%edx
8010330a:	89 15 08 17 11 80    	mov    %edx,0x80111708
80103310:	eb d9                	jmp    801032eb <log_write+0x6b>
    panic("too big a transaction");
80103312:	83 ec 0c             	sub    $0xc,%esp
80103315:	68 aa 76 10 80       	push   $0x801076aa
8010331a:	e8 61 d0 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010331f:	83 ec 0c             	sub    $0xc,%esp
80103322:	68 c0 76 10 80       	push   $0x801076c0
80103327:	e8 54 d0 ff ff       	call   80100380 <panic>
8010332c:	66 90                	xchg   %ax,%ax
8010332e:	66 90                	xchg   %ax,%ax

80103330 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103330:	55                   	push   %ebp
80103331:	89 e5                	mov    %esp,%ebp
80103333:	53                   	push   %ebx
80103334:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103337:	e8 64 09 00 00       	call   80103ca0 <cpuid>
8010333c:	89 c3                	mov    %eax,%ebx
8010333e:	e8 5d 09 00 00       	call   80103ca0 <cpuid>
80103343:	83 ec 04             	sub    $0x4,%esp
80103346:	53                   	push   %ebx
80103347:	50                   	push   %eax
80103348:	68 db 76 10 80       	push   $0x801076db
8010334d:	e8 0e d3 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103352:	e8 e9 28 00 00       	call   80105c40 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103357:	e8 e4 08 00 00       	call   80103c40 <mycpu>
8010335c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010335e:	b8 01 00 00 00       	mov    $0x1,%eax
80103363:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010336a:	e8 01 0c 00 00       	call   80103f70 <scheduler>
8010336f:	90                   	nop

80103370 <mpenter>:
{
80103370:	55                   	push   %ebp
80103371:	89 e5                	mov    %esp,%ebp
80103373:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103376:	e8 c5 39 00 00       	call   80106d40 <switchkvm>
  seginit();
8010337b:	e8 30 39 00 00       	call   80106cb0 <seginit>
  lapicinit();
80103380:	e8 bb f7 ff ff       	call   80102b40 <lapicinit>
  mpmain();
80103385:	e8 a6 ff ff ff       	call   80103330 <mpmain>
8010338a:	66 90                	xchg   %ax,%ax
8010338c:	66 90                	xchg   %ax,%ax
8010338e:	66 90                	xchg   %ax,%ax

80103390 <main>:
{
80103390:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103394:	83 e4 f0             	and    $0xfffffff0,%esp
80103397:	ff 71 fc             	push   -0x4(%ecx)
8010339a:	55                   	push   %ebp
8010339b:	89 e5                	mov    %esp,%ebp
8010339d:	53                   	push   %ebx
8010339e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010339f:	83 ec 08             	sub    $0x8,%esp
801033a2:	68 00 00 40 80       	push   $0x80400000
801033a7:	68 f0 54 11 80       	push   $0x801154f0
801033ac:	e8 9f f5 ff ff       	call   80102950 <kinit1>
  kvmalloc();      // kernel page table
801033b1:	e8 4a 3e 00 00       	call   80107200 <kvmalloc>
  mpinit();        // detect other processors
801033b6:	e8 85 01 00 00       	call   80103540 <mpinit>
  lapicinit();     // interrupt controller
801033bb:	e8 80 f7 ff ff       	call   80102b40 <lapicinit>
  seginit();       // segment descriptors
801033c0:	e8 eb 38 00 00       	call   80106cb0 <seginit>
  picinit();       // disable pic
801033c5:	e8 86 03 00 00       	call   80103750 <picinit>
  ioapicinit();    // another interrupt controller
801033ca:	e8 51 f3 ff ff       	call   80102720 <ioapicinit>
  consoleinit();   // console hardware
801033cf:	e8 0c d9 ff ff       	call   80100ce0 <consoleinit>
  uartinit();      // serial port
801033d4:	e8 47 2b 00 00       	call   80105f20 <uartinit>
  pinit();         // process table
801033d9:	e8 42 08 00 00       	call   80103c20 <pinit>
  tvinit();        // trap vectors
801033de:	e8 dd 27 00 00       	call   80105bc0 <tvinit>
  binit();         // buffer cache
801033e3:	e8 58 cc ff ff       	call   80100040 <binit>
  fileinit();      // file table
801033e8:	e8 a3 dd ff ff       	call   80101190 <fileinit>
  ideinit();       // disk 
801033ed:	e8 0e f1 ff ff       	call   80102500 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801033f2:	83 c4 0c             	add    $0xc,%esp
801033f5:	68 8a 00 00 00       	push   $0x8a
801033fa:	68 8c a4 10 80       	push   $0x8010a48c
801033ff:	68 00 70 00 80       	push   $0x80007000
80103404:	e8 87 16 00 00       	call   80104a90 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103409:	83 c4 10             	add    $0x10,%esp
8010340c:	69 05 a4 17 11 80 b0 	imul   $0xb0,0x801117a4,%eax
80103413:	00 00 00 
80103416:	05 c0 17 11 80       	add    $0x801117c0,%eax
8010341b:	3d c0 17 11 80       	cmp    $0x801117c0,%eax
80103420:	76 7e                	jbe    801034a0 <main+0x110>
80103422:	bb c0 17 11 80       	mov    $0x801117c0,%ebx
80103427:	eb 20                	jmp    80103449 <main+0xb9>
80103429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103430:	69 05 a4 17 11 80 b0 	imul   $0xb0,0x801117a4,%eax
80103437:	00 00 00 
8010343a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103440:	05 c0 17 11 80       	add    $0x801117c0,%eax
80103445:	39 c3                	cmp    %eax,%ebx
80103447:	73 57                	jae    801034a0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103449:	e8 f2 07 00 00       	call   80103c40 <mycpu>
8010344e:	39 c3                	cmp    %eax,%ebx
80103450:	74 de                	je     80103430 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103452:	e8 69 f5 ff ff       	call   801029c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103457:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010345a:	c7 05 f8 6f 00 80 70 	movl   $0x80103370,0x80006ff8
80103461:	33 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103464:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010346b:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010346e:	05 00 10 00 00       	add    $0x1000,%eax
80103473:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103478:	0f b6 03             	movzbl (%ebx),%eax
8010347b:	68 00 70 00 00       	push   $0x7000
80103480:	50                   	push   %eax
80103481:	e8 fa f7 ff ff       	call   80102c80 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103486:	83 c4 10             	add    $0x10,%esp
80103489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103490:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103496:	85 c0                	test   %eax,%eax
80103498:	74 f6                	je     80103490 <main+0x100>
8010349a:	eb 94                	jmp    80103430 <main+0xa0>
8010349c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801034a0:	83 ec 08             	sub    $0x8,%esp
801034a3:	68 00 00 00 8e       	push   $0x8e000000
801034a8:	68 00 00 40 80       	push   $0x80400000
801034ad:	e8 3e f4 ff ff       	call   801028f0 <kinit2>
  userinit();      // first user process
801034b2:	e8 39 08 00 00       	call   80103cf0 <userinit>
  mpmain();        // finish this processor's setup
801034b7:	e8 74 fe ff ff       	call   80103330 <mpmain>
801034bc:	66 90                	xchg   %ax,%ax
801034be:	66 90                	xchg   %ax,%ax

801034c0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	57                   	push   %edi
801034c4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801034c5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801034cb:	53                   	push   %ebx
  e = addr+len;
801034cc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801034cf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801034d2:	39 de                	cmp    %ebx,%esi
801034d4:	72 10                	jb     801034e6 <mpsearch1+0x26>
801034d6:	eb 50                	jmp    80103528 <mpsearch1+0x68>
801034d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034df:	00 
801034e0:	89 fe                	mov    %edi,%esi
801034e2:	39 df                	cmp    %ebx,%edi
801034e4:	73 42                	jae    80103528 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801034e6:	83 ec 04             	sub    $0x4,%esp
801034e9:	8d 7e 10             	lea    0x10(%esi),%edi
801034ec:	6a 04                	push   $0x4
801034ee:	68 ef 76 10 80       	push   $0x801076ef
801034f3:	56                   	push   %esi
801034f4:	e8 47 15 00 00       	call   80104a40 <memcmp>
801034f9:	83 c4 10             	add    $0x10,%esp
801034fc:	85 c0                	test   %eax,%eax
801034fe:	75 e0                	jne    801034e0 <mpsearch1+0x20>
80103500:	89 f2                	mov    %esi,%edx
80103502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103508:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010350b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010350e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103510:	39 fa                	cmp    %edi,%edx
80103512:	75 f4                	jne    80103508 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103514:	84 c0                	test   %al,%al
80103516:	75 c8                	jne    801034e0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103518:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010351b:	89 f0                	mov    %esi,%eax
8010351d:	5b                   	pop    %ebx
8010351e:	5e                   	pop    %esi
8010351f:	5f                   	pop    %edi
80103520:	5d                   	pop    %ebp
80103521:	c3                   	ret
80103522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103528:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010352b:	31 f6                	xor    %esi,%esi
}
8010352d:	5b                   	pop    %ebx
8010352e:	89 f0                	mov    %esi,%eax
80103530:	5e                   	pop    %esi
80103531:	5f                   	pop    %edi
80103532:	5d                   	pop    %ebp
80103533:	c3                   	ret
80103534:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010353b:	00 
8010353c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103540 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	57                   	push   %edi
80103544:	56                   	push   %esi
80103545:	53                   	push   %ebx
80103546:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103549:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103550:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103557:	c1 e0 08             	shl    $0x8,%eax
8010355a:	09 d0                	or     %edx,%eax
8010355c:	c1 e0 04             	shl    $0x4,%eax
8010355f:	75 1b                	jne    8010357c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103561:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103568:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010356f:	c1 e0 08             	shl    $0x8,%eax
80103572:	09 d0                	or     %edx,%eax
80103574:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103577:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010357c:	ba 00 04 00 00       	mov    $0x400,%edx
80103581:	e8 3a ff ff ff       	call   801034c0 <mpsearch1>
80103586:	89 c3                	mov    %eax,%ebx
80103588:	85 c0                	test   %eax,%eax
8010358a:	0f 84 58 01 00 00    	je     801036e8 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103590:	8b 73 04             	mov    0x4(%ebx),%esi
80103593:	85 f6                	test   %esi,%esi
80103595:	0f 84 3d 01 00 00    	je     801036d8 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
8010359b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010359e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801035a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801035a7:	6a 04                	push   $0x4
801035a9:	68 f4 76 10 80       	push   $0x801076f4
801035ae:	50                   	push   %eax
801035af:	e8 8c 14 00 00       	call   80104a40 <memcmp>
801035b4:	83 c4 10             	add    $0x10,%esp
801035b7:	85 c0                	test   %eax,%eax
801035b9:	0f 85 19 01 00 00    	jne    801036d8 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
801035bf:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801035c6:	3c 01                	cmp    $0x1,%al
801035c8:	74 08                	je     801035d2 <mpinit+0x92>
801035ca:	3c 04                	cmp    $0x4,%al
801035cc:	0f 85 06 01 00 00    	jne    801036d8 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
801035d2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801035d9:	66 85 d2             	test   %dx,%dx
801035dc:	74 22                	je     80103600 <mpinit+0xc0>
801035de:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801035e1:	89 f0                	mov    %esi,%eax
  sum = 0;
801035e3:	31 d2                	xor    %edx,%edx
801035e5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801035e8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801035ef:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801035f2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801035f4:	39 f8                	cmp    %edi,%eax
801035f6:	75 f0                	jne    801035e8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801035f8:	84 d2                	test   %dl,%dl
801035fa:	0f 85 d8 00 00 00    	jne    801036d8 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103600:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103606:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103609:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
8010360c:	a3 a0 16 11 80       	mov    %eax,0x801116a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103611:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103618:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
8010361e:	01 d7                	add    %edx,%edi
80103620:	89 fa                	mov    %edi,%edx
  ismp = 1;
80103622:	bf 01 00 00 00       	mov    $0x1,%edi
80103627:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010362e:	00 
8010362f:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103630:	39 d0                	cmp    %edx,%eax
80103632:	73 19                	jae    8010364d <mpinit+0x10d>
    switch(*p){
80103634:	0f b6 08             	movzbl (%eax),%ecx
80103637:	80 f9 02             	cmp    $0x2,%cl
8010363a:	0f 84 80 00 00 00    	je     801036c0 <mpinit+0x180>
80103640:	77 6e                	ja     801036b0 <mpinit+0x170>
80103642:	84 c9                	test   %cl,%cl
80103644:	74 3a                	je     80103680 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103646:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103649:	39 d0                	cmp    %edx,%eax
8010364b:	72 e7                	jb     80103634 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010364d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103650:	85 ff                	test   %edi,%edi
80103652:	0f 84 dd 00 00 00    	je     80103735 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103658:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010365c:	74 15                	je     80103673 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010365e:	b8 70 00 00 00       	mov    $0x70,%eax
80103663:	ba 22 00 00 00       	mov    $0x22,%edx
80103668:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103669:	ba 23 00 00 00       	mov    $0x23,%edx
8010366e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010366f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103672:	ee                   	out    %al,(%dx)
  }
}
80103673:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103676:	5b                   	pop    %ebx
80103677:	5e                   	pop    %esi
80103678:	5f                   	pop    %edi
80103679:	5d                   	pop    %ebp
8010367a:	c3                   	ret
8010367b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103680:	8b 0d a4 17 11 80    	mov    0x801117a4,%ecx
80103686:	83 f9 07             	cmp    $0x7,%ecx
80103689:	7f 19                	jg     801036a4 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010368b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80103691:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103695:	83 c1 01             	add    $0x1,%ecx
80103698:	89 0d a4 17 11 80    	mov    %ecx,0x801117a4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010369e:	88 9e c0 17 11 80    	mov    %bl,-0x7feee840(%esi)
      p += sizeof(struct mpproc);
801036a4:	83 c0 14             	add    $0x14,%eax
      continue;
801036a7:	eb 87                	jmp    80103630 <mpinit+0xf0>
801036a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
801036b0:	83 e9 03             	sub    $0x3,%ecx
801036b3:	80 f9 01             	cmp    $0x1,%cl
801036b6:	76 8e                	jbe    80103646 <mpinit+0x106>
801036b8:	31 ff                	xor    %edi,%edi
801036ba:	e9 71 ff ff ff       	jmp    80103630 <mpinit+0xf0>
801036bf:	90                   	nop
      ioapicid = ioapic->apicno;
801036c0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801036c4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801036c7:	88 0d a0 17 11 80    	mov    %cl,0x801117a0
      continue;
801036cd:	e9 5e ff ff ff       	jmp    80103630 <mpinit+0xf0>
801036d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801036d8:	83 ec 0c             	sub    $0xc,%esp
801036db:	68 f9 76 10 80       	push   $0x801076f9
801036e0:	e8 9b cc ff ff       	call   80100380 <panic>
801036e5:	8d 76 00             	lea    0x0(%esi),%esi
{
801036e8:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801036ed:	eb 0b                	jmp    801036fa <mpinit+0x1ba>
801036ef:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
801036f0:	89 f3                	mov    %esi,%ebx
801036f2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801036f8:	74 de                	je     801036d8 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036fa:	83 ec 04             	sub    $0x4,%esp
801036fd:	8d 73 10             	lea    0x10(%ebx),%esi
80103700:	6a 04                	push   $0x4
80103702:	68 ef 76 10 80       	push   $0x801076ef
80103707:	53                   	push   %ebx
80103708:	e8 33 13 00 00       	call   80104a40 <memcmp>
8010370d:	83 c4 10             	add    $0x10,%esp
80103710:	85 c0                	test   %eax,%eax
80103712:	75 dc                	jne    801036f0 <mpinit+0x1b0>
80103714:	89 da                	mov    %ebx,%edx
80103716:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010371d:	00 
8010371e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80103720:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103723:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103726:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103728:	39 d6                	cmp    %edx,%esi
8010372a:	75 f4                	jne    80103720 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010372c:	84 c0                	test   %al,%al
8010372e:	75 c0                	jne    801036f0 <mpinit+0x1b0>
80103730:	e9 5b fe ff ff       	jmp    80103590 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103735:	83 ec 0c             	sub    $0xc,%esp
80103738:	68 b4 7a 10 80       	push   $0x80107ab4
8010373d:	e8 3e cc ff ff       	call   80100380 <panic>
80103742:	66 90                	xchg   %ax,%ax
80103744:	66 90                	xchg   %ax,%ax
80103746:	66 90                	xchg   %ax,%ax
80103748:	66 90                	xchg   %ax,%ax
8010374a:	66 90                	xchg   %ax,%ax
8010374c:	66 90                	xchg   %ax,%ax
8010374e:	66 90                	xchg   %ax,%ax

80103750 <picinit>:
80103750:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103755:	ba 21 00 00 00       	mov    $0x21,%edx
8010375a:	ee                   	out    %al,(%dx)
8010375b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103760:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103761:	c3                   	ret
80103762:	66 90                	xchg   %ax,%ax
80103764:	66 90                	xchg   %ax,%ax
80103766:	66 90                	xchg   %ax,%ax
80103768:	66 90                	xchg   %ax,%ax
8010376a:	66 90                	xchg   %ax,%ax
8010376c:	66 90                	xchg   %ax,%ax
8010376e:	66 90                	xchg   %ax,%ax

80103770 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	57                   	push   %edi
80103774:	56                   	push   %esi
80103775:	53                   	push   %ebx
80103776:	83 ec 0c             	sub    $0xc,%esp
80103779:	8b 75 08             	mov    0x8(%ebp),%esi
8010377c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010377f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103785:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010378b:	e8 20 da ff ff       	call   801011b0 <filealloc>
80103790:	89 06                	mov    %eax,(%esi)
80103792:	85 c0                	test   %eax,%eax
80103794:	0f 84 a5 00 00 00    	je     8010383f <pipealloc+0xcf>
8010379a:	e8 11 da ff ff       	call   801011b0 <filealloc>
8010379f:	89 07                	mov    %eax,(%edi)
801037a1:	85 c0                	test   %eax,%eax
801037a3:	0f 84 84 00 00 00    	je     8010382d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801037a9:	e8 12 f2 ff ff       	call   801029c0 <kalloc>
801037ae:	89 c3                	mov    %eax,%ebx
801037b0:	85 c0                	test   %eax,%eax
801037b2:	0f 84 a0 00 00 00    	je     80103858 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
801037b8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801037bf:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801037c2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801037c5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801037cc:	00 00 00 
  p->nwrite = 0;
801037cf:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801037d6:	00 00 00 
  p->nread = 0;
801037d9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801037e0:	00 00 00 
  initlock(&p->lock, "pipe");
801037e3:	68 11 77 10 80       	push   $0x80107711
801037e8:	50                   	push   %eax
801037e9:	e8 22 0f 00 00       	call   80104710 <initlock>
  (*f0)->type = FD_PIPE;
801037ee:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801037f0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801037f3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801037f9:	8b 06                	mov    (%esi),%eax
801037fb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801037ff:	8b 06                	mov    (%esi),%eax
80103801:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103805:	8b 06                	mov    (%esi),%eax
80103807:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010380a:	8b 07                	mov    (%edi),%eax
8010380c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103812:	8b 07                	mov    (%edi),%eax
80103814:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103818:	8b 07                	mov    (%edi),%eax
8010381a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010381e:	8b 07                	mov    (%edi),%eax
80103820:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103823:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103825:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103828:	5b                   	pop    %ebx
80103829:	5e                   	pop    %esi
8010382a:	5f                   	pop    %edi
8010382b:	5d                   	pop    %ebp
8010382c:	c3                   	ret
  if(*f0)
8010382d:	8b 06                	mov    (%esi),%eax
8010382f:	85 c0                	test   %eax,%eax
80103831:	74 1e                	je     80103851 <pipealloc+0xe1>
    fileclose(*f0);
80103833:	83 ec 0c             	sub    $0xc,%esp
80103836:	50                   	push   %eax
80103837:	e8 34 da ff ff       	call   80101270 <fileclose>
8010383c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010383f:	8b 07                	mov    (%edi),%eax
80103841:	85 c0                	test   %eax,%eax
80103843:	74 0c                	je     80103851 <pipealloc+0xe1>
    fileclose(*f1);
80103845:	83 ec 0c             	sub    $0xc,%esp
80103848:	50                   	push   %eax
80103849:	e8 22 da ff ff       	call   80101270 <fileclose>
8010384e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103851:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103856:	eb cd                	jmp    80103825 <pipealloc+0xb5>
  if(*f0)
80103858:	8b 06                	mov    (%esi),%eax
8010385a:	85 c0                	test   %eax,%eax
8010385c:	75 d5                	jne    80103833 <pipealloc+0xc3>
8010385e:	eb df                	jmp    8010383f <pipealloc+0xcf>

80103860 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	56                   	push   %esi
80103864:	53                   	push   %ebx
80103865:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103868:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010386b:	83 ec 0c             	sub    $0xc,%esp
8010386e:	53                   	push   %ebx
8010386f:	e8 8c 10 00 00       	call   80104900 <acquire>
  if(writable){
80103874:	83 c4 10             	add    $0x10,%esp
80103877:	85 f6                	test   %esi,%esi
80103879:	74 65                	je     801038e0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010387b:	83 ec 0c             	sub    $0xc,%esp
8010387e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103884:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010388b:	00 00 00 
    wakeup(&p->nread);
8010388e:	50                   	push   %eax
8010388f:	e8 ac 0b 00 00       	call   80104440 <wakeup>
80103894:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103897:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010389d:	85 d2                	test   %edx,%edx
8010389f:	75 0a                	jne    801038ab <pipeclose+0x4b>
801038a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801038a7:	85 c0                	test   %eax,%eax
801038a9:	74 15                	je     801038c0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801038ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801038ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038b1:	5b                   	pop    %ebx
801038b2:	5e                   	pop    %esi
801038b3:	5d                   	pop    %ebp
    release(&p->lock);
801038b4:	e9 e7 0f 00 00       	jmp    801048a0 <release>
801038b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801038c0:	83 ec 0c             	sub    $0xc,%esp
801038c3:	53                   	push   %ebx
801038c4:	e8 d7 0f 00 00       	call   801048a0 <release>
    kfree((char*)p);
801038c9:	83 c4 10             	add    $0x10,%esp
801038cc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801038cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038d2:	5b                   	pop    %ebx
801038d3:	5e                   	pop    %esi
801038d4:	5d                   	pop    %ebp
    kfree((char*)p);
801038d5:	e9 26 ef ff ff       	jmp    80102800 <kfree>
801038da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801038e0:	83 ec 0c             	sub    $0xc,%esp
801038e3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801038e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801038f0:	00 00 00 
    wakeup(&p->nwrite);
801038f3:	50                   	push   %eax
801038f4:	e8 47 0b 00 00       	call   80104440 <wakeup>
801038f9:	83 c4 10             	add    $0x10,%esp
801038fc:	eb 99                	jmp    80103897 <pipeclose+0x37>
801038fe:	66 90                	xchg   %ax,%ax

80103900 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	57                   	push   %edi
80103904:	56                   	push   %esi
80103905:	53                   	push   %ebx
80103906:	83 ec 28             	sub    $0x28,%esp
80103909:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010390c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010390f:	53                   	push   %ebx
80103910:	e8 eb 0f 00 00       	call   80104900 <acquire>
  for(i = 0; i < n; i++){
80103915:	83 c4 10             	add    $0x10,%esp
80103918:	85 ff                	test   %edi,%edi
8010391a:	0f 8e ce 00 00 00    	jle    801039ee <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103920:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103926:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103929:	89 7d 10             	mov    %edi,0x10(%ebp)
8010392c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010392f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103932:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103935:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010393b:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103941:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103947:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010394d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103950:	0f 85 b6 00 00 00    	jne    80103a0c <pipewrite+0x10c>
80103956:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103959:	eb 3b                	jmp    80103996 <pipewrite+0x96>
8010395b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103960:	e8 5b 03 00 00       	call   80103cc0 <myproc>
80103965:	8b 48 24             	mov    0x24(%eax),%ecx
80103968:	85 c9                	test   %ecx,%ecx
8010396a:	75 34                	jne    801039a0 <pipewrite+0xa0>
      wakeup(&p->nread);
8010396c:	83 ec 0c             	sub    $0xc,%esp
8010396f:	56                   	push   %esi
80103970:	e8 cb 0a 00 00       	call   80104440 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103975:	58                   	pop    %eax
80103976:	5a                   	pop    %edx
80103977:	53                   	push   %ebx
80103978:	57                   	push   %edi
80103979:	e8 02 0a 00 00       	call   80104380 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010397e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103984:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010398a:	83 c4 10             	add    $0x10,%esp
8010398d:	05 00 02 00 00       	add    $0x200,%eax
80103992:	39 c2                	cmp    %eax,%edx
80103994:	75 2a                	jne    801039c0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103996:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010399c:	85 c0                	test   %eax,%eax
8010399e:	75 c0                	jne    80103960 <pipewrite+0x60>
        release(&p->lock);
801039a0:	83 ec 0c             	sub    $0xc,%esp
801039a3:	53                   	push   %ebx
801039a4:	e8 f7 0e 00 00       	call   801048a0 <release>
        return -1;
801039a9:	83 c4 10             	add    $0x10,%esp
801039ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801039b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039b4:	5b                   	pop    %ebx
801039b5:	5e                   	pop    %esi
801039b6:	5f                   	pop    %edi
801039b7:	5d                   	pop    %ebp
801039b8:	c3                   	ret
801039b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039c0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801039c3:	8d 42 01             	lea    0x1(%edx),%eax
801039c6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
801039cc:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801039cf:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801039d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039d8:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
801039dc:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801039e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801039e3:	39 c1                	cmp    %eax,%ecx
801039e5:	0f 85 50 ff ff ff    	jne    8010393b <pipewrite+0x3b>
801039eb:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801039ee:	83 ec 0c             	sub    $0xc,%esp
801039f1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801039f7:	50                   	push   %eax
801039f8:	e8 43 0a 00 00       	call   80104440 <wakeup>
  release(&p->lock);
801039fd:	89 1c 24             	mov    %ebx,(%esp)
80103a00:	e8 9b 0e 00 00       	call   801048a0 <release>
  return n;
80103a05:	83 c4 10             	add    $0x10,%esp
80103a08:	89 f8                	mov    %edi,%eax
80103a0a:	eb a5                	jmp    801039b1 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103a0c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a0f:	eb b2                	jmp    801039c3 <pipewrite+0xc3>
80103a11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a18:	00 
80103a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a20 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	57                   	push   %edi
80103a24:	56                   	push   %esi
80103a25:	53                   	push   %ebx
80103a26:	83 ec 18             	sub    $0x18,%esp
80103a29:	8b 75 08             	mov    0x8(%ebp),%esi
80103a2c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103a2f:	56                   	push   %esi
80103a30:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103a36:	e8 c5 0e 00 00       	call   80104900 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103a3b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103a41:	83 c4 10             	add    $0x10,%esp
80103a44:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103a4a:	74 2f                	je     80103a7b <piperead+0x5b>
80103a4c:	eb 37                	jmp    80103a85 <piperead+0x65>
80103a4e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103a50:	e8 6b 02 00 00       	call   80103cc0 <myproc>
80103a55:	8b 40 24             	mov    0x24(%eax),%eax
80103a58:	85 c0                	test   %eax,%eax
80103a5a:	0f 85 80 00 00 00    	jne    80103ae0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103a60:	83 ec 08             	sub    $0x8,%esp
80103a63:	56                   	push   %esi
80103a64:	53                   	push   %ebx
80103a65:	e8 16 09 00 00       	call   80104380 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103a6a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103a70:	83 c4 10             	add    $0x10,%esp
80103a73:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103a79:	75 0a                	jne    80103a85 <piperead+0x65>
80103a7b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103a81:	85 d2                	test   %edx,%edx
80103a83:	75 cb                	jne    80103a50 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103a85:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103a88:	31 db                	xor    %ebx,%ebx
80103a8a:	85 c9                	test   %ecx,%ecx
80103a8c:	7f 26                	jg     80103ab4 <piperead+0x94>
80103a8e:	eb 2c                	jmp    80103abc <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103a90:	8d 48 01             	lea    0x1(%eax),%ecx
80103a93:	25 ff 01 00 00       	and    $0x1ff,%eax
80103a98:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103a9e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103aa3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103aa6:	83 c3 01             	add    $0x1,%ebx
80103aa9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103aac:	74 0e                	je     80103abc <piperead+0x9c>
80103aae:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103ab4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103aba:	75 d4                	jne    80103a90 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103abc:	83 ec 0c             	sub    $0xc,%esp
80103abf:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103ac5:	50                   	push   %eax
80103ac6:	e8 75 09 00 00       	call   80104440 <wakeup>
  release(&p->lock);
80103acb:	89 34 24             	mov    %esi,(%esp)
80103ace:	e8 cd 0d 00 00       	call   801048a0 <release>
  return i;
80103ad3:	83 c4 10             	add    $0x10,%esp
}
80103ad6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ad9:	89 d8                	mov    %ebx,%eax
80103adb:	5b                   	pop    %ebx
80103adc:	5e                   	pop    %esi
80103add:	5f                   	pop    %edi
80103ade:	5d                   	pop    %ebp
80103adf:	c3                   	ret
      release(&p->lock);
80103ae0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103ae3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103ae8:	56                   	push   %esi
80103ae9:	e8 b2 0d 00 00       	call   801048a0 <release>
      return -1;
80103aee:	83 c4 10             	add    $0x10,%esp
}
80103af1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103af4:	89 d8                	mov    %ebx,%eax
80103af6:	5b                   	pop    %ebx
80103af7:	5e                   	pop    %esi
80103af8:	5f                   	pop    %edi
80103af9:	5d                   	pop    %ebp
80103afa:	c3                   	ret
80103afb:	66 90                	xchg   %ax,%ax
80103afd:	66 90                	xchg   %ax,%ax
80103aff:	90                   	nop

80103b00 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b04:	bb 74 1d 11 80       	mov    $0x80111d74,%ebx
{
80103b09:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103b0c:	68 40 1d 11 80       	push   $0x80111d40
80103b11:	e8 ea 0d 00 00       	call   80104900 <acquire>
80103b16:	83 c4 10             	add    $0x10,%esp
80103b19:	eb 10                	jmp    80103b2b <allocproc+0x2b>
80103b1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b20:	83 c3 7c             	add    $0x7c,%ebx
80103b23:	81 fb 74 3c 11 80    	cmp    $0x80113c74,%ebx
80103b29:	74 75                	je     80103ba0 <allocproc+0xa0>
    if(p->state == UNUSED)
80103b2b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103b2e:	85 c0                	test   %eax,%eax
80103b30:	75 ee                	jne    80103b20 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103b32:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103b37:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103b3a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103b41:	89 43 10             	mov    %eax,0x10(%ebx)
80103b44:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103b47:	68 40 1d 11 80       	push   $0x80111d40
  p->pid = nextpid++;
80103b4c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103b52:	e8 49 0d 00 00       	call   801048a0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103b57:	e8 64 ee ff ff       	call   801029c0 <kalloc>
80103b5c:	83 c4 10             	add    $0x10,%esp
80103b5f:	89 43 08             	mov    %eax,0x8(%ebx)
80103b62:	85 c0                	test   %eax,%eax
80103b64:	74 53                	je     80103bb9 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103b66:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103b6c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103b6f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103b74:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103b77:	c7 40 14 b2 5b 10 80 	movl   $0x80105bb2,0x14(%eax)
  p->context = (struct context*)sp;
80103b7e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103b81:	6a 14                	push   $0x14
80103b83:	6a 00                	push   $0x0
80103b85:	50                   	push   %eax
80103b86:	e8 75 0e 00 00       	call   80104a00 <memset>
  p->context->eip = (uint)forkret;
80103b8b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103b8e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103b91:	c7 40 10 d0 3b 10 80 	movl   $0x80103bd0,0x10(%eax)
}
80103b98:	89 d8                	mov    %ebx,%eax
80103b9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b9d:	c9                   	leave
80103b9e:	c3                   	ret
80103b9f:	90                   	nop
  release(&ptable.lock);
80103ba0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103ba3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103ba5:	68 40 1d 11 80       	push   $0x80111d40
80103baa:	e8 f1 0c 00 00       	call   801048a0 <release>
  return 0;
80103baf:	83 c4 10             	add    $0x10,%esp
}
80103bb2:	89 d8                	mov    %ebx,%eax
80103bb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bb7:	c9                   	leave
80103bb8:	c3                   	ret
    p->state = UNUSED;
80103bb9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103bc0:	31 db                	xor    %ebx,%ebx
80103bc2:	eb ee                	jmp    80103bb2 <allocproc+0xb2>
80103bc4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bcb:	00 
80103bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103bd0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103bd6:	68 40 1d 11 80       	push   $0x80111d40
80103bdb:	e8 c0 0c 00 00       	call   801048a0 <release>

  if (first) {
80103be0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103be5:	83 c4 10             	add    $0x10,%esp
80103be8:	85 c0                	test   %eax,%eax
80103bea:	75 04                	jne    80103bf0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103bec:	c9                   	leave
80103bed:	c3                   	ret
80103bee:	66 90                	xchg   %ax,%ax
    first = 0;
80103bf0:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103bf7:	00 00 00 
    iinit(ROOTDEV);
80103bfa:	83 ec 0c             	sub    $0xc,%esp
80103bfd:	6a 01                	push   $0x1
80103bff:	e8 dc dc ff ff       	call   801018e0 <iinit>
    initlog(ROOTDEV);
80103c04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103c0b:	e8 f0 f3 ff ff       	call   80103000 <initlog>
}
80103c10:	83 c4 10             	add    $0x10,%esp
80103c13:	c9                   	leave
80103c14:	c3                   	ret
80103c15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c1c:	00 
80103c1d:	8d 76 00             	lea    0x0(%esi),%esi

80103c20 <pinit>:
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103c26:	68 16 77 10 80       	push   $0x80107716
80103c2b:	68 40 1d 11 80       	push   $0x80111d40
80103c30:	e8 db 0a 00 00       	call   80104710 <initlock>
}
80103c35:	83 c4 10             	add    $0x10,%esp
80103c38:	c9                   	leave
80103c39:	c3                   	ret
80103c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103c40 <mycpu>:
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	56                   	push   %esi
80103c44:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c45:	9c                   	pushf
80103c46:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c47:	f6 c4 02             	test   $0x2,%ah
80103c4a:	75 46                	jne    80103c92 <mycpu+0x52>
  apicid = lapicid();
80103c4c:	e8 df ef ff ff       	call   80102c30 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103c51:	8b 35 a4 17 11 80    	mov    0x801117a4,%esi
80103c57:	85 f6                	test   %esi,%esi
80103c59:	7e 2a                	jle    80103c85 <mycpu+0x45>
80103c5b:	31 d2                	xor    %edx,%edx
80103c5d:	eb 08                	jmp    80103c67 <mycpu+0x27>
80103c5f:	90                   	nop
80103c60:	83 c2 01             	add    $0x1,%edx
80103c63:	39 f2                	cmp    %esi,%edx
80103c65:	74 1e                	je     80103c85 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103c67:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103c6d:	0f b6 99 c0 17 11 80 	movzbl -0x7feee840(%ecx),%ebx
80103c74:	39 c3                	cmp    %eax,%ebx
80103c76:	75 e8                	jne    80103c60 <mycpu+0x20>
}
80103c78:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103c7b:	8d 81 c0 17 11 80    	lea    -0x7feee840(%ecx),%eax
}
80103c81:	5b                   	pop    %ebx
80103c82:	5e                   	pop    %esi
80103c83:	5d                   	pop    %ebp
80103c84:	c3                   	ret
  panic("unknown apicid\n");
80103c85:	83 ec 0c             	sub    $0xc,%esp
80103c88:	68 1d 77 10 80       	push   $0x8010771d
80103c8d:	e8 ee c6 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103c92:	83 ec 0c             	sub    $0xc,%esp
80103c95:	68 d4 7a 10 80       	push   $0x80107ad4
80103c9a:	e8 e1 c6 ff ff       	call   80100380 <panic>
80103c9f:	90                   	nop

80103ca0 <cpuid>:
cpuid() {
80103ca0:	55                   	push   %ebp
80103ca1:	89 e5                	mov    %esp,%ebp
80103ca3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103ca6:	e8 95 ff ff ff       	call   80103c40 <mycpu>
}
80103cab:	c9                   	leave
  return mycpu()-cpus;
80103cac:	2d c0 17 11 80       	sub    $0x801117c0,%eax
80103cb1:	c1 f8 04             	sar    $0x4,%eax
80103cb4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103cba:	c3                   	ret
80103cbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103cc0 <myproc>:
myproc(void) {
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	53                   	push   %ebx
80103cc4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103cc7:	e8 e4 0a 00 00       	call   801047b0 <pushcli>
  c = mycpu();
80103ccc:	e8 6f ff ff ff       	call   80103c40 <mycpu>
  p = c->proc;
80103cd1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cd7:	e8 24 0b 00 00       	call   80104800 <popcli>
}
80103cdc:	89 d8                	mov    %ebx,%eax
80103cde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ce1:	c9                   	leave
80103ce2:	c3                   	ret
80103ce3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103cea:	00 
80103ceb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103cf0 <userinit>:
{
80103cf0:	55                   	push   %ebp
80103cf1:	89 e5                	mov    %esp,%ebp
80103cf3:	53                   	push   %ebx
80103cf4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103cf7:	e8 04 fe ff ff       	call   80103b00 <allocproc>
80103cfc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103cfe:	a3 74 3c 11 80       	mov    %eax,0x80113c74
  if((p->pgdir = setupkvm()) == 0)
80103d03:	e8 78 34 00 00       	call   80107180 <setupkvm>
80103d08:	89 43 04             	mov    %eax,0x4(%ebx)
80103d0b:	85 c0                	test   %eax,%eax
80103d0d:	0f 84 bd 00 00 00    	je     80103dd0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103d13:	83 ec 04             	sub    $0x4,%esp
80103d16:	68 2c 00 00 00       	push   $0x2c
80103d1b:	68 60 a4 10 80       	push   $0x8010a460
80103d20:	50                   	push   %eax
80103d21:	e8 3a 31 00 00       	call   80106e60 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103d26:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103d29:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103d2f:	6a 4c                	push   $0x4c
80103d31:	6a 00                	push   $0x0
80103d33:	ff 73 18             	push   0x18(%ebx)
80103d36:	e8 c5 0c 00 00       	call   80104a00 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103d3b:	8b 43 18             	mov    0x18(%ebx),%eax
80103d3e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d43:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103d46:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103d4b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103d4f:	8b 43 18             	mov    0x18(%ebx),%eax
80103d52:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103d56:	8b 43 18             	mov    0x18(%ebx),%eax
80103d59:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103d5d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103d61:	8b 43 18             	mov    0x18(%ebx),%eax
80103d64:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103d68:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103d6c:	8b 43 18             	mov    0x18(%ebx),%eax
80103d6f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103d76:	8b 43 18             	mov    0x18(%ebx),%eax
80103d79:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103d80:	8b 43 18             	mov    0x18(%ebx),%eax
80103d83:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d8a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103d8d:	6a 10                	push   $0x10
80103d8f:	68 46 77 10 80       	push   $0x80107746
80103d94:	50                   	push   %eax
80103d95:	e8 16 0e 00 00       	call   80104bb0 <safestrcpy>
  p->cwd = namei("/");
80103d9a:	c7 04 24 4f 77 10 80 	movl   $0x8010774f,(%esp)
80103da1:	e8 3a e6 ff ff       	call   801023e0 <namei>
80103da6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103da9:	c7 04 24 40 1d 11 80 	movl   $0x80111d40,(%esp)
80103db0:	e8 4b 0b 00 00       	call   80104900 <acquire>
  p->state = RUNNABLE;
80103db5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103dbc:	c7 04 24 40 1d 11 80 	movl   $0x80111d40,(%esp)
80103dc3:	e8 d8 0a 00 00       	call   801048a0 <release>
}
80103dc8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103dcb:	83 c4 10             	add    $0x10,%esp
80103dce:	c9                   	leave
80103dcf:	c3                   	ret
    panic("userinit: out of memory?");
80103dd0:	83 ec 0c             	sub    $0xc,%esp
80103dd3:	68 2d 77 10 80       	push   $0x8010772d
80103dd8:	e8 a3 c5 ff ff       	call   80100380 <panic>
80103ddd:	8d 76 00             	lea    0x0(%esi),%esi

80103de0 <growproc>:
{
80103de0:	55                   	push   %ebp
80103de1:	89 e5                	mov    %esp,%ebp
80103de3:	56                   	push   %esi
80103de4:	53                   	push   %ebx
80103de5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103de8:	e8 c3 09 00 00       	call   801047b0 <pushcli>
  c = mycpu();
80103ded:	e8 4e fe ff ff       	call   80103c40 <mycpu>
  p = c->proc;
80103df2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103df8:	e8 03 0a 00 00       	call   80104800 <popcli>
  sz = curproc->sz;
80103dfd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103dff:	85 f6                	test   %esi,%esi
80103e01:	7f 1d                	jg     80103e20 <growproc+0x40>
  } else if(n < 0){
80103e03:	75 3b                	jne    80103e40 <growproc+0x60>
  switchuvm(curproc);
80103e05:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103e08:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103e0a:	53                   	push   %ebx
80103e0b:	e8 40 2f 00 00       	call   80106d50 <switchuvm>
  return 0;
80103e10:	83 c4 10             	add    $0x10,%esp
80103e13:	31 c0                	xor    %eax,%eax
}
80103e15:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e18:	5b                   	pop    %ebx
80103e19:	5e                   	pop    %esi
80103e1a:	5d                   	pop    %ebp
80103e1b:	c3                   	ret
80103e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103e20:	83 ec 04             	sub    $0x4,%esp
80103e23:	01 c6                	add    %eax,%esi
80103e25:	56                   	push   %esi
80103e26:	50                   	push   %eax
80103e27:	ff 73 04             	push   0x4(%ebx)
80103e2a:	e8 81 31 00 00       	call   80106fb0 <allocuvm>
80103e2f:	83 c4 10             	add    $0x10,%esp
80103e32:	85 c0                	test   %eax,%eax
80103e34:	75 cf                	jne    80103e05 <growproc+0x25>
      return -1;
80103e36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e3b:	eb d8                	jmp    80103e15 <growproc+0x35>
80103e3d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103e40:	83 ec 04             	sub    $0x4,%esp
80103e43:	01 c6                	add    %eax,%esi
80103e45:	56                   	push   %esi
80103e46:	50                   	push   %eax
80103e47:	ff 73 04             	push   0x4(%ebx)
80103e4a:	e8 81 32 00 00       	call   801070d0 <deallocuvm>
80103e4f:	83 c4 10             	add    $0x10,%esp
80103e52:	85 c0                	test   %eax,%eax
80103e54:	75 af                	jne    80103e05 <growproc+0x25>
80103e56:	eb de                	jmp    80103e36 <growproc+0x56>
80103e58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e5f:	00 

80103e60 <fork>:
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
80103e65:	53                   	push   %ebx
80103e66:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e69:	e8 42 09 00 00       	call   801047b0 <pushcli>
  c = mycpu();
80103e6e:	e8 cd fd ff ff       	call   80103c40 <mycpu>
  p = c->proc;
80103e73:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e79:	e8 82 09 00 00       	call   80104800 <popcli>
  if((np = allocproc()) == 0){
80103e7e:	e8 7d fc ff ff       	call   80103b00 <allocproc>
80103e83:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103e86:	85 c0                	test   %eax,%eax
80103e88:	0f 84 d6 00 00 00    	je     80103f64 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103e8e:	83 ec 08             	sub    $0x8,%esp
80103e91:	ff 33                	push   (%ebx)
80103e93:	89 c7                	mov    %eax,%edi
80103e95:	ff 73 04             	push   0x4(%ebx)
80103e98:	e8 d3 33 00 00       	call   80107270 <copyuvm>
80103e9d:	83 c4 10             	add    $0x10,%esp
80103ea0:	89 47 04             	mov    %eax,0x4(%edi)
80103ea3:	85 c0                	test   %eax,%eax
80103ea5:	0f 84 9a 00 00 00    	je     80103f45 <fork+0xe5>
  np->sz = curproc->sz;
80103eab:	8b 03                	mov    (%ebx),%eax
80103ead:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103eb0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103eb2:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103eb5:	89 c8                	mov    %ecx,%eax
80103eb7:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103eba:	b9 13 00 00 00       	mov    $0x13,%ecx
80103ebf:	8b 73 18             	mov    0x18(%ebx),%esi
80103ec2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103ec4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103ec6:	8b 40 18             	mov    0x18(%eax),%eax
80103ec9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103ed0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ed4:	85 c0                	test   %eax,%eax
80103ed6:	74 13                	je     80103eeb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ed8:	83 ec 0c             	sub    $0xc,%esp
80103edb:	50                   	push   %eax
80103edc:	e8 3f d3 ff ff       	call   80101220 <filedup>
80103ee1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ee4:	83 c4 10             	add    $0x10,%esp
80103ee7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103eeb:	83 c6 01             	add    $0x1,%esi
80103eee:	83 fe 10             	cmp    $0x10,%esi
80103ef1:	75 dd                	jne    80103ed0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ef3:	83 ec 0c             	sub    $0xc,%esp
80103ef6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ef9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103efc:	e8 cf db ff ff       	call   80101ad0 <idup>
80103f01:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103f04:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103f07:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103f0a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103f0d:	6a 10                	push   $0x10
80103f0f:	53                   	push   %ebx
80103f10:	50                   	push   %eax
80103f11:	e8 9a 0c 00 00       	call   80104bb0 <safestrcpy>
  pid = np->pid;
80103f16:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103f19:	c7 04 24 40 1d 11 80 	movl   $0x80111d40,(%esp)
80103f20:	e8 db 09 00 00       	call   80104900 <acquire>
  np->state = RUNNABLE;
80103f25:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103f2c:	c7 04 24 40 1d 11 80 	movl   $0x80111d40,(%esp)
80103f33:	e8 68 09 00 00       	call   801048a0 <release>
  return pid;
80103f38:	83 c4 10             	add    $0x10,%esp
}
80103f3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f3e:	89 d8                	mov    %ebx,%eax
80103f40:	5b                   	pop    %ebx
80103f41:	5e                   	pop    %esi
80103f42:	5f                   	pop    %edi
80103f43:	5d                   	pop    %ebp
80103f44:	c3                   	ret
    kfree(np->kstack);
80103f45:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103f48:	83 ec 0c             	sub    $0xc,%esp
80103f4b:	ff 73 08             	push   0x8(%ebx)
80103f4e:	e8 ad e8 ff ff       	call   80102800 <kfree>
    np->kstack = 0;
80103f53:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103f5a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103f5d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103f64:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f69:	eb d0                	jmp    80103f3b <fork+0xdb>
80103f6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103f70 <scheduler>:
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	57                   	push   %edi
80103f74:	56                   	push   %esi
80103f75:	53                   	push   %ebx
80103f76:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103f79:	e8 c2 fc ff ff       	call   80103c40 <mycpu>
  c->proc = 0;
80103f7e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103f85:	00 00 00 
  struct cpu *c = mycpu();
80103f88:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103f8a:	8d 78 04             	lea    0x4(%eax),%edi
80103f8d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103f90:	fb                   	sti
    acquire(&ptable.lock);
80103f91:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f94:	bb 74 1d 11 80       	mov    $0x80111d74,%ebx
    acquire(&ptable.lock);
80103f99:	68 40 1d 11 80       	push   $0x80111d40
80103f9e:	e8 5d 09 00 00       	call   80104900 <acquire>
80103fa3:	83 c4 10             	add    $0x10,%esp
80103fa6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fad:	00 
80103fae:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103fb0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103fb4:	75 33                	jne    80103fe9 <scheduler+0x79>
      switchuvm(p);
80103fb6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103fb9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103fbf:	53                   	push   %ebx
80103fc0:	e8 8b 2d 00 00       	call   80106d50 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103fc5:	58                   	pop    %eax
80103fc6:	5a                   	pop    %edx
80103fc7:	ff 73 1c             	push   0x1c(%ebx)
80103fca:	57                   	push   %edi
      p->state = RUNNING;
80103fcb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103fd2:	e8 34 0c 00 00       	call   80104c0b <swtch>
      switchkvm();
80103fd7:	e8 64 2d 00 00       	call   80106d40 <switchkvm>
      c->proc = 0;
80103fdc:	83 c4 10             	add    $0x10,%esp
80103fdf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103fe6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fe9:	83 c3 7c             	add    $0x7c,%ebx
80103fec:	81 fb 74 3c 11 80    	cmp    $0x80113c74,%ebx
80103ff2:	75 bc                	jne    80103fb0 <scheduler+0x40>
    release(&ptable.lock);
80103ff4:	83 ec 0c             	sub    $0xc,%esp
80103ff7:	68 40 1d 11 80       	push   $0x80111d40
80103ffc:	e8 9f 08 00 00       	call   801048a0 <release>
    sti();
80104001:	83 c4 10             	add    $0x10,%esp
80104004:	eb 8a                	jmp    80103f90 <scheduler+0x20>
80104006:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010400d:	00 
8010400e:	66 90                	xchg   %ax,%ax

80104010 <sched>:
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	56                   	push   %esi
80104014:	53                   	push   %ebx
  pushcli();
80104015:	e8 96 07 00 00       	call   801047b0 <pushcli>
  c = mycpu();
8010401a:	e8 21 fc ff ff       	call   80103c40 <mycpu>
  p = c->proc;
8010401f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104025:	e8 d6 07 00 00       	call   80104800 <popcli>
  if(!holding(&ptable.lock))
8010402a:	83 ec 0c             	sub    $0xc,%esp
8010402d:	68 40 1d 11 80       	push   $0x80111d40
80104032:	e8 29 08 00 00       	call   80104860 <holding>
80104037:	83 c4 10             	add    $0x10,%esp
8010403a:	85 c0                	test   %eax,%eax
8010403c:	74 4f                	je     8010408d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010403e:	e8 fd fb ff ff       	call   80103c40 <mycpu>
80104043:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010404a:	75 68                	jne    801040b4 <sched+0xa4>
  if(p->state == RUNNING)
8010404c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104050:	74 55                	je     801040a7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104052:	9c                   	pushf
80104053:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104054:	f6 c4 02             	test   $0x2,%ah
80104057:	75 41                	jne    8010409a <sched+0x8a>
  intena = mycpu()->intena;
80104059:	e8 e2 fb ff ff       	call   80103c40 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010405e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104061:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104067:	e8 d4 fb ff ff       	call   80103c40 <mycpu>
8010406c:	83 ec 08             	sub    $0x8,%esp
8010406f:	ff 70 04             	push   0x4(%eax)
80104072:	53                   	push   %ebx
80104073:	e8 93 0b 00 00       	call   80104c0b <swtch>
  mycpu()->intena = intena;
80104078:	e8 c3 fb ff ff       	call   80103c40 <mycpu>
}
8010407d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104080:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104086:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104089:	5b                   	pop    %ebx
8010408a:	5e                   	pop    %esi
8010408b:	5d                   	pop    %ebp
8010408c:	c3                   	ret
    panic("sched ptable.lock");
8010408d:	83 ec 0c             	sub    $0xc,%esp
80104090:	68 51 77 10 80       	push   $0x80107751
80104095:	e8 e6 c2 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
8010409a:	83 ec 0c             	sub    $0xc,%esp
8010409d:	68 7d 77 10 80       	push   $0x8010777d
801040a2:	e8 d9 c2 ff ff       	call   80100380 <panic>
    panic("sched running");
801040a7:	83 ec 0c             	sub    $0xc,%esp
801040aa:	68 6f 77 10 80       	push   $0x8010776f
801040af:	e8 cc c2 ff ff       	call   80100380 <panic>
    panic("sched locks");
801040b4:	83 ec 0c             	sub    $0xc,%esp
801040b7:	68 63 77 10 80       	push   $0x80107763
801040bc:	e8 bf c2 ff ff       	call   80100380 <panic>
801040c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040c8:	00 
801040c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040d0 <exit>:
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	57                   	push   %edi
801040d4:	56                   	push   %esi
801040d5:	53                   	push   %ebx
801040d6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
801040d9:	e8 e2 fb ff ff       	call   80103cc0 <myproc>
  if(curproc == initproc)
801040de:	39 05 74 3c 11 80    	cmp    %eax,0x80113c74
801040e4:	0f 84 fd 00 00 00    	je     801041e7 <exit+0x117>
801040ea:	89 c3                	mov    %eax,%ebx
801040ec:	8d 70 28             	lea    0x28(%eax),%esi
801040ef:	8d 78 68             	lea    0x68(%eax),%edi
801040f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
801040f8:	8b 06                	mov    (%esi),%eax
801040fa:	85 c0                	test   %eax,%eax
801040fc:	74 12                	je     80104110 <exit+0x40>
      fileclose(curproc->ofile[fd]);
801040fe:	83 ec 0c             	sub    $0xc,%esp
80104101:	50                   	push   %eax
80104102:	e8 69 d1 ff ff       	call   80101270 <fileclose>
      curproc->ofile[fd] = 0;
80104107:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010410d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104110:	83 c6 04             	add    $0x4,%esi
80104113:	39 f7                	cmp    %esi,%edi
80104115:	75 e1                	jne    801040f8 <exit+0x28>
  begin_op();
80104117:	e8 84 ef ff ff       	call   801030a0 <begin_op>
  iput(curproc->cwd);
8010411c:	83 ec 0c             	sub    $0xc,%esp
8010411f:	ff 73 68             	push   0x68(%ebx)
80104122:	e8 09 db ff ff       	call   80101c30 <iput>
  end_op();
80104127:	e8 e4 ef ff ff       	call   80103110 <end_op>
  curproc->cwd = 0;
8010412c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104133:	c7 04 24 40 1d 11 80 	movl   $0x80111d40,(%esp)
8010413a:	e8 c1 07 00 00       	call   80104900 <acquire>
  wakeup1(curproc->parent);
8010413f:	8b 53 14             	mov    0x14(%ebx),%edx
80104142:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104145:	b8 74 1d 11 80       	mov    $0x80111d74,%eax
8010414a:	eb 0e                	jmp    8010415a <exit+0x8a>
8010414c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104150:	83 c0 7c             	add    $0x7c,%eax
80104153:	3d 74 3c 11 80       	cmp    $0x80113c74,%eax
80104158:	74 1c                	je     80104176 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
8010415a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010415e:	75 f0                	jne    80104150 <exit+0x80>
80104160:	3b 50 20             	cmp    0x20(%eax),%edx
80104163:	75 eb                	jne    80104150 <exit+0x80>
      p->state = RUNNABLE;
80104165:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010416c:	83 c0 7c             	add    $0x7c,%eax
8010416f:	3d 74 3c 11 80       	cmp    $0x80113c74,%eax
80104174:	75 e4                	jne    8010415a <exit+0x8a>
      p->parent = initproc;
80104176:	8b 0d 74 3c 11 80    	mov    0x80113c74,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010417c:	ba 74 1d 11 80       	mov    $0x80111d74,%edx
80104181:	eb 10                	jmp    80104193 <exit+0xc3>
80104183:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104188:	83 c2 7c             	add    $0x7c,%edx
8010418b:	81 fa 74 3c 11 80    	cmp    $0x80113c74,%edx
80104191:	74 3b                	je     801041ce <exit+0xfe>
    if(p->parent == curproc){
80104193:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104196:	75 f0                	jne    80104188 <exit+0xb8>
      if(p->state == ZOMBIE)
80104198:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010419c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010419f:	75 e7                	jne    80104188 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041a1:	b8 74 1d 11 80       	mov    $0x80111d74,%eax
801041a6:	eb 12                	jmp    801041ba <exit+0xea>
801041a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041af:	00 
801041b0:	83 c0 7c             	add    $0x7c,%eax
801041b3:	3d 74 3c 11 80       	cmp    $0x80113c74,%eax
801041b8:	74 ce                	je     80104188 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
801041ba:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041be:	75 f0                	jne    801041b0 <exit+0xe0>
801041c0:	3b 48 20             	cmp    0x20(%eax),%ecx
801041c3:	75 eb                	jne    801041b0 <exit+0xe0>
      p->state = RUNNABLE;
801041c5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801041cc:	eb e2                	jmp    801041b0 <exit+0xe0>
  curproc->state = ZOMBIE;
801041ce:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801041d5:	e8 36 fe ff ff       	call   80104010 <sched>
  panic("zombie exit");
801041da:	83 ec 0c             	sub    $0xc,%esp
801041dd:	68 9e 77 10 80       	push   $0x8010779e
801041e2:	e8 99 c1 ff ff       	call   80100380 <panic>
    panic("init exiting");
801041e7:	83 ec 0c             	sub    $0xc,%esp
801041ea:	68 91 77 10 80       	push   $0x80107791
801041ef:	e8 8c c1 ff ff       	call   80100380 <panic>
801041f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041fb:	00 
801041fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104200 <wait>:
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	56                   	push   %esi
80104204:	53                   	push   %ebx
  pushcli();
80104205:	e8 a6 05 00 00       	call   801047b0 <pushcli>
  c = mycpu();
8010420a:	e8 31 fa ff ff       	call   80103c40 <mycpu>
  p = c->proc;
8010420f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104215:	e8 e6 05 00 00       	call   80104800 <popcli>
  acquire(&ptable.lock);
8010421a:	83 ec 0c             	sub    $0xc,%esp
8010421d:	68 40 1d 11 80       	push   $0x80111d40
80104222:	e8 d9 06 00 00       	call   80104900 <acquire>
80104227:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010422a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010422c:	bb 74 1d 11 80       	mov    $0x80111d74,%ebx
80104231:	eb 10                	jmp    80104243 <wait+0x43>
80104233:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104238:	83 c3 7c             	add    $0x7c,%ebx
8010423b:	81 fb 74 3c 11 80    	cmp    $0x80113c74,%ebx
80104241:	74 1b                	je     8010425e <wait+0x5e>
      if(p->parent != curproc)
80104243:	39 73 14             	cmp    %esi,0x14(%ebx)
80104246:	75 f0                	jne    80104238 <wait+0x38>
      if(p->state == ZOMBIE){
80104248:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010424c:	74 62                	je     801042b0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010424e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104251:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104256:	81 fb 74 3c 11 80    	cmp    $0x80113c74,%ebx
8010425c:	75 e5                	jne    80104243 <wait+0x43>
    if(!havekids || curproc->killed){
8010425e:	85 c0                	test   %eax,%eax
80104260:	0f 84 a0 00 00 00    	je     80104306 <wait+0x106>
80104266:	8b 46 24             	mov    0x24(%esi),%eax
80104269:	85 c0                	test   %eax,%eax
8010426b:	0f 85 95 00 00 00    	jne    80104306 <wait+0x106>
  pushcli();
80104271:	e8 3a 05 00 00       	call   801047b0 <pushcli>
  c = mycpu();
80104276:	e8 c5 f9 ff ff       	call   80103c40 <mycpu>
  p = c->proc;
8010427b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104281:	e8 7a 05 00 00       	call   80104800 <popcli>
  if(p == 0)
80104286:	85 db                	test   %ebx,%ebx
80104288:	0f 84 8f 00 00 00    	je     8010431d <wait+0x11d>
  p->chan = chan;
8010428e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104291:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104298:	e8 73 fd ff ff       	call   80104010 <sched>
  p->chan = 0;
8010429d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801042a4:	eb 84                	jmp    8010422a <wait+0x2a>
801042a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042ad:	00 
801042ae:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
801042b0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801042b3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801042b6:	ff 73 08             	push   0x8(%ebx)
801042b9:	e8 42 e5 ff ff       	call   80102800 <kfree>
        p->kstack = 0;
801042be:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801042c5:	5a                   	pop    %edx
801042c6:	ff 73 04             	push   0x4(%ebx)
801042c9:	e8 32 2e 00 00       	call   80107100 <freevm>
        p->pid = 0;
801042ce:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801042d5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801042dc:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801042e0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801042e7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801042ee:	c7 04 24 40 1d 11 80 	movl   $0x80111d40,(%esp)
801042f5:	e8 a6 05 00 00       	call   801048a0 <release>
        return pid;
801042fa:	83 c4 10             	add    $0x10,%esp
}
801042fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104300:	89 f0                	mov    %esi,%eax
80104302:	5b                   	pop    %ebx
80104303:	5e                   	pop    %esi
80104304:	5d                   	pop    %ebp
80104305:	c3                   	ret
      release(&ptable.lock);
80104306:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104309:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010430e:	68 40 1d 11 80       	push   $0x80111d40
80104313:	e8 88 05 00 00       	call   801048a0 <release>
      return -1;
80104318:	83 c4 10             	add    $0x10,%esp
8010431b:	eb e0                	jmp    801042fd <wait+0xfd>
    panic("sleep");
8010431d:	83 ec 0c             	sub    $0xc,%esp
80104320:	68 aa 77 10 80       	push   $0x801077aa
80104325:	e8 56 c0 ff ff       	call   80100380 <panic>
8010432a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104330 <yield>:
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	53                   	push   %ebx
80104334:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104337:	68 40 1d 11 80       	push   $0x80111d40
8010433c:	e8 bf 05 00 00       	call   80104900 <acquire>
  pushcli();
80104341:	e8 6a 04 00 00       	call   801047b0 <pushcli>
  c = mycpu();
80104346:	e8 f5 f8 ff ff       	call   80103c40 <mycpu>
  p = c->proc;
8010434b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104351:	e8 aa 04 00 00       	call   80104800 <popcli>
  myproc()->state = RUNNABLE;
80104356:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010435d:	e8 ae fc ff ff       	call   80104010 <sched>
  release(&ptable.lock);
80104362:	c7 04 24 40 1d 11 80 	movl   $0x80111d40,(%esp)
80104369:	e8 32 05 00 00       	call   801048a0 <release>
}
8010436e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104371:	83 c4 10             	add    $0x10,%esp
80104374:	c9                   	leave
80104375:	c3                   	ret
80104376:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010437d:	00 
8010437e:	66 90                	xchg   %ax,%ax

80104380 <sleep>:
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	57                   	push   %edi
80104384:	56                   	push   %esi
80104385:	53                   	push   %ebx
80104386:	83 ec 0c             	sub    $0xc,%esp
80104389:	8b 7d 08             	mov    0x8(%ebp),%edi
8010438c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010438f:	e8 1c 04 00 00       	call   801047b0 <pushcli>
  c = mycpu();
80104394:	e8 a7 f8 ff ff       	call   80103c40 <mycpu>
  p = c->proc;
80104399:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010439f:	e8 5c 04 00 00       	call   80104800 <popcli>
  if(p == 0)
801043a4:	85 db                	test   %ebx,%ebx
801043a6:	0f 84 87 00 00 00    	je     80104433 <sleep+0xb3>
  if(lk == 0)
801043ac:	85 f6                	test   %esi,%esi
801043ae:	74 76                	je     80104426 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801043b0:	81 fe 40 1d 11 80    	cmp    $0x80111d40,%esi
801043b6:	74 50                	je     80104408 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801043b8:	83 ec 0c             	sub    $0xc,%esp
801043bb:	68 40 1d 11 80       	push   $0x80111d40
801043c0:	e8 3b 05 00 00       	call   80104900 <acquire>
    release(lk);
801043c5:	89 34 24             	mov    %esi,(%esp)
801043c8:	e8 d3 04 00 00       	call   801048a0 <release>
  p->chan = chan;
801043cd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801043d0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801043d7:	e8 34 fc ff ff       	call   80104010 <sched>
  p->chan = 0;
801043dc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801043e3:	c7 04 24 40 1d 11 80 	movl   $0x80111d40,(%esp)
801043ea:	e8 b1 04 00 00       	call   801048a0 <release>
    acquire(lk);
801043ef:	83 c4 10             	add    $0x10,%esp
801043f2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043f8:	5b                   	pop    %ebx
801043f9:	5e                   	pop    %esi
801043fa:	5f                   	pop    %edi
801043fb:	5d                   	pop    %ebp
    acquire(lk);
801043fc:	e9 ff 04 00 00       	jmp    80104900 <acquire>
80104401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104408:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010440b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104412:	e8 f9 fb ff ff       	call   80104010 <sched>
  p->chan = 0;
80104417:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010441e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104421:	5b                   	pop    %ebx
80104422:	5e                   	pop    %esi
80104423:	5f                   	pop    %edi
80104424:	5d                   	pop    %ebp
80104425:	c3                   	ret
    panic("sleep without lk");
80104426:	83 ec 0c             	sub    $0xc,%esp
80104429:	68 b0 77 10 80       	push   $0x801077b0
8010442e:	e8 4d bf ff ff       	call   80100380 <panic>
    panic("sleep");
80104433:	83 ec 0c             	sub    $0xc,%esp
80104436:	68 aa 77 10 80       	push   $0x801077aa
8010443b:	e8 40 bf ff ff       	call   80100380 <panic>

80104440 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	53                   	push   %ebx
80104444:	83 ec 10             	sub    $0x10,%esp
80104447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010444a:	68 40 1d 11 80       	push   $0x80111d40
8010444f:	e8 ac 04 00 00       	call   80104900 <acquire>
80104454:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104457:	b8 74 1d 11 80       	mov    $0x80111d74,%eax
8010445c:	eb 0c                	jmp    8010446a <wakeup+0x2a>
8010445e:	66 90                	xchg   %ax,%ax
80104460:	83 c0 7c             	add    $0x7c,%eax
80104463:	3d 74 3c 11 80       	cmp    $0x80113c74,%eax
80104468:	74 1c                	je     80104486 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010446a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010446e:	75 f0                	jne    80104460 <wakeup+0x20>
80104470:	3b 58 20             	cmp    0x20(%eax),%ebx
80104473:	75 eb                	jne    80104460 <wakeup+0x20>
      p->state = RUNNABLE;
80104475:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010447c:	83 c0 7c             	add    $0x7c,%eax
8010447f:	3d 74 3c 11 80       	cmp    $0x80113c74,%eax
80104484:	75 e4                	jne    8010446a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104486:	c7 45 08 40 1d 11 80 	movl   $0x80111d40,0x8(%ebp)
}
8010448d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104490:	c9                   	leave
  release(&ptable.lock);
80104491:	e9 0a 04 00 00       	jmp    801048a0 <release>
80104496:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010449d:	00 
8010449e:	66 90                	xchg   %ax,%ax

801044a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	53                   	push   %ebx
801044a4:	83 ec 10             	sub    $0x10,%esp
801044a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801044aa:	68 40 1d 11 80       	push   $0x80111d40
801044af:	e8 4c 04 00 00       	call   80104900 <acquire>
801044b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044b7:	b8 74 1d 11 80       	mov    $0x80111d74,%eax
801044bc:	eb 0c                	jmp    801044ca <kill+0x2a>
801044be:	66 90                	xchg   %ax,%ax
801044c0:	83 c0 7c             	add    $0x7c,%eax
801044c3:	3d 74 3c 11 80       	cmp    $0x80113c74,%eax
801044c8:	74 36                	je     80104500 <kill+0x60>
    if(p->pid == pid){
801044ca:	39 58 10             	cmp    %ebx,0x10(%eax)
801044cd:	75 f1                	jne    801044c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801044cf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801044d3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801044da:	75 07                	jne    801044e3 <kill+0x43>
        p->state = RUNNABLE;
801044dc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801044e3:	83 ec 0c             	sub    $0xc,%esp
801044e6:	68 40 1d 11 80       	push   $0x80111d40
801044eb:	e8 b0 03 00 00       	call   801048a0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801044f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801044f3:	83 c4 10             	add    $0x10,%esp
801044f6:	31 c0                	xor    %eax,%eax
}
801044f8:	c9                   	leave
801044f9:	c3                   	ret
801044fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104500:	83 ec 0c             	sub    $0xc,%esp
80104503:	68 40 1d 11 80       	push   $0x80111d40
80104508:	e8 93 03 00 00       	call   801048a0 <release>
}
8010450d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104510:	83 c4 10             	add    $0x10,%esp
80104513:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104518:	c9                   	leave
80104519:	c3                   	ret
8010451a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104520 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	57                   	push   %edi
80104524:	56                   	push   %esi
80104525:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104528:	53                   	push   %ebx
80104529:	bb e0 1d 11 80       	mov    $0x80111de0,%ebx
8010452e:	83 ec 3c             	sub    $0x3c,%esp
80104531:	eb 24                	jmp    80104557 <procdump+0x37>
80104533:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104538:	83 ec 0c             	sub    $0xc,%esp
8010453b:	68 6f 79 10 80       	push   $0x8010796f
80104540:	e8 1b c1 ff ff       	call   80100660 <cprintf>
80104545:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104548:	83 c3 7c             	add    $0x7c,%ebx
8010454b:	81 fb e0 3c 11 80    	cmp    $0x80113ce0,%ebx
80104551:	0f 84 81 00 00 00    	je     801045d8 <procdump+0xb8>
    if(p->state == UNUSED)
80104557:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010455a:	85 c0                	test   %eax,%eax
8010455c:	74 ea                	je     80104548 <procdump+0x28>
      state = "???";
8010455e:	ba c1 77 10 80       	mov    $0x801077c1,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104563:	83 f8 05             	cmp    $0x5,%eax
80104566:	77 11                	ja     80104579 <procdump+0x59>
80104568:	8b 14 85 e0 7d 10 80 	mov    -0x7fef8220(,%eax,4),%edx
      state = "???";
8010456f:	b8 c1 77 10 80       	mov    $0x801077c1,%eax
80104574:	85 d2                	test   %edx,%edx
80104576:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104579:	53                   	push   %ebx
8010457a:	52                   	push   %edx
8010457b:	ff 73 a4             	push   -0x5c(%ebx)
8010457e:	68 c5 77 10 80       	push   $0x801077c5
80104583:	e8 d8 c0 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104588:	83 c4 10             	add    $0x10,%esp
8010458b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010458f:	75 a7                	jne    80104538 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104591:	83 ec 08             	sub    $0x8,%esp
80104594:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104597:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010459a:	50                   	push   %eax
8010459b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010459e:	8b 40 0c             	mov    0xc(%eax),%eax
801045a1:	83 c0 08             	add    $0x8,%eax
801045a4:	50                   	push   %eax
801045a5:	e8 86 01 00 00       	call   80104730 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801045aa:	83 c4 10             	add    $0x10,%esp
801045ad:	8d 76 00             	lea    0x0(%esi),%esi
801045b0:	8b 17                	mov    (%edi),%edx
801045b2:	85 d2                	test   %edx,%edx
801045b4:	74 82                	je     80104538 <procdump+0x18>
        cprintf(" %p", pc[i]);
801045b6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801045b9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801045bc:	52                   	push   %edx
801045bd:	68 01 75 10 80       	push   $0x80107501
801045c2:	e8 99 c0 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801045c7:	83 c4 10             	add    $0x10,%esp
801045ca:	39 f7                	cmp    %esi,%edi
801045cc:	75 e2                	jne    801045b0 <procdump+0x90>
801045ce:	e9 65 ff ff ff       	jmp    80104538 <procdump+0x18>
801045d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
801045d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045db:	5b                   	pop    %ebx
801045dc:	5e                   	pop    %esi
801045dd:	5f                   	pop    %edi
801045de:	5d                   	pop    %ebp
801045df:	c3                   	ret

801045e0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	53                   	push   %ebx
801045e4:	83 ec 0c             	sub    $0xc,%esp
801045e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801045ea:	68 f8 77 10 80       	push   $0x801077f8
801045ef:	8d 43 04             	lea    0x4(%ebx),%eax
801045f2:	50                   	push   %eax
801045f3:	e8 18 01 00 00       	call   80104710 <initlock>
  lk->name = name;
801045f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801045fb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104601:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104604:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010460b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010460e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104611:	c9                   	leave
80104612:	c3                   	ret
80104613:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010461a:	00 
8010461b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104620 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	56                   	push   %esi
80104624:	53                   	push   %ebx
80104625:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104628:	8d 73 04             	lea    0x4(%ebx),%esi
8010462b:	83 ec 0c             	sub    $0xc,%esp
8010462e:	56                   	push   %esi
8010462f:	e8 cc 02 00 00       	call   80104900 <acquire>
  while (lk->locked) {
80104634:	8b 13                	mov    (%ebx),%edx
80104636:	83 c4 10             	add    $0x10,%esp
80104639:	85 d2                	test   %edx,%edx
8010463b:	74 16                	je     80104653 <acquiresleep+0x33>
8010463d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104640:	83 ec 08             	sub    $0x8,%esp
80104643:	56                   	push   %esi
80104644:	53                   	push   %ebx
80104645:	e8 36 fd ff ff       	call   80104380 <sleep>
  while (lk->locked) {
8010464a:	8b 03                	mov    (%ebx),%eax
8010464c:	83 c4 10             	add    $0x10,%esp
8010464f:	85 c0                	test   %eax,%eax
80104651:	75 ed                	jne    80104640 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104653:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104659:	e8 62 f6 ff ff       	call   80103cc0 <myproc>
8010465e:	8b 40 10             	mov    0x10(%eax),%eax
80104661:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104664:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104667:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010466a:	5b                   	pop    %ebx
8010466b:	5e                   	pop    %esi
8010466c:	5d                   	pop    %ebp
  release(&lk->lk);
8010466d:	e9 2e 02 00 00       	jmp    801048a0 <release>
80104672:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104679:	00 
8010467a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104680 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	56                   	push   %esi
80104684:	53                   	push   %ebx
80104685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104688:	8d 73 04             	lea    0x4(%ebx),%esi
8010468b:	83 ec 0c             	sub    $0xc,%esp
8010468e:	56                   	push   %esi
8010468f:	e8 6c 02 00 00       	call   80104900 <acquire>
  lk->locked = 0;
80104694:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010469a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801046a1:	89 1c 24             	mov    %ebx,(%esp)
801046a4:	e8 97 fd ff ff       	call   80104440 <wakeup>
  release(&lk->lk);
801046a9:	83 c4 10             	add    $0x10,%esp
801046ac:	89 75 08             	mov    %esi,0x8(%ebp)
}
801046af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046b2:	5b                   	pop    %ebx
801046b3:	5e                   	pop    %esi
801046b4:	5d                   	pop    %ebp
  release(&lk->lk);
801046b5:	e9 e6 01 00 00       	jmp    801048a0 <release>
801046ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046c0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	57                   	push   %edi
801046c4:	31 ff                	xor    %edi,%edi
801046c6:	56                   	push   %esi
801046c7:	53                   	push   %ebx
801046c8:	83 ec 18             	sub    $0x18,%esp
801046cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801046ce:	8d 73 04             	lea    0x4(%ebx),%esi
801046d1:	56                   	push   %esi
801046d2:	e8 29 02 00 00       	call   80104900 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801046d7:	8b 03                	mov    (%ebx),%eax
801046d9:	83 c4 10             	add    $0x10,%esp
801046dc:	85 c0                	test   %eax,%eax
801046de:	75 18                	jne    801046f8 <holdingsleep+0x38>
  release(&lk->lk);
801046e0:	83 ec 0c             	sub    $0xc,%esp
801046e3:	56                   	push   %esi
801046e4:	e8 b7 01 00 00       	call   801048a0 <release>
  return r;
}
801046e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046ec:	89 f8                	mov    %edi,%eax
801046ee:	5b                   	pop    %ebx
801046ef:	5e                   	pop    %esi
801046f0:	5f                   	pop    %edi
801046f1:	5d                   	pop    %ebp
801046f2:	c3                   	ret
801046f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
801046f8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801046fb:	e8 c0 f5 ff ff       	call   80103cc0 <myproc>
80104700:	39 58 10             	cmp    %ebx,0x10(%eax)
80104703:	0f 94 c0             	sete   %al
80104706:	0f b6 c0             	movzbl %al,%eax
80104709:	89 c7                	mov    %eax,%edi
8010470b:	eb d3                	jmp    801046e0 <holdingsleep+0x20>
8010470d:	66 90                	xchg   %ax,%ax
8010470f:	90                   	nop

80104710 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104716:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104719:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010471f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104722:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104729:	5d                   	pop    %ebp
8010472a:	c3                   	ret
8010472b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104730 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	53                   	push   %ebx
80104734:	8b 45 08             	mov    0x8(%ebp),%eax
80104737:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010473a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010473d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104742:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104747:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010474c:	76 10                	jbe    8010475e <getcallerpcs+0x2e>
8010474e:	eb 28                	jmp    80104778 <getcallerpcs+0x48>
80104750:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104756:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010475c:	77 1a                	ja     80104778 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010475e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104761:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104764:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104767:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104769:	83 f8 0a             	cmp    $0xa,%eax
8010476c:	75 e2                	jne    80104750 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010476e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104771:	c9                   	leave
80104772:	c3                   	ret
80104773:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104778:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010477b:	83 c1 28             	add    $0x28,%ecx
8010477e:	89 ca                	mov    %ecx,%edx
80104780:	29 c2                	sub    %eax,%edx
80104782:	83 e2 04             	and    $0x4,%edx
80104785:	74 11                	je     80104798 <getcallerpcs+0x68>
    pcs[i] = 0;
80104787:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010478d:	83 c0 04             	add    $0x4,%eax
80104790:	39 c1                	cmp    %eax,%ecx
80104792:	74 da                	je     8010476e <getcallerpcs+0x3e>
80104794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104798:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010479e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
801047a1:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801047a8:	39 c1                	cmp    %eax,%ecx
801047aa:	75 ec                	jne    80104798 <getcallerpcs+0x68>
801047ac:	eb c0                	jmp    8010476e <getcallerpcs+0x3e>
801047ae:	66 90                	xchg   %ax,%ax

801047b0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	53                   	push   %ebx
801047b4:	83 ec 04             	sub    $0x4,%esp
801047b7:	9c                   	pushf
801047b8:	5b                   	pop    %ebx
  asm volatile("cli");
801047b9:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801047ba:	e8 81 f4 ff ff       	call   80103c40 <mycpu>
801047bf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801047c5:	85 c0                	test   %eax,%eax
801047c7:	74 17                	je     801047e0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801047c9:	e8 72 f4 ff ff       	call   80103c40 <mycpu>
801047ce:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801047d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047d8:	c9                   	leave
801047d9:	c3                   	ret
801047da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
801047e0:	e8 5b f4 ff ff       	call   80103c40 <mycpu>
801047e5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801047eb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801047f1:	eb d6                	jmp    801047c9 <pushcli+0x19>
801047f3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047fa:	00 
801047fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104800 <popcli>:

void
popcli(void)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104806:	9c                   	pushf
80104807:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104808:	f6 c4 02             	test   $0x2,%ah
8010480b:	75 35                	jne    80104842 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010480d:	e8 2e f4 ff ff       	call   80103c40 <mycpu>
80104812:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104819:	78 34                	js     8010484f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010481b:	e8 20 f4 ff ff       	call   80103c40 <mycpu>
80104820:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104826:	85 d2                	test   %edx,%edx
80104828:	74 06                	je     80104830 <popcli+0x30>
    sti();
}
8010482a:	c9                   	leave
8010482b:	c3                   	ret
8010482c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104830:	e8 0b f4 ff ff       	call   80103c40 <mycpu>
80104835:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010483b:	85 c0                	test   %eax,%eax
8010483d:	74 eb                	je     8010482a <popcli+0x2a>
  asm volatile("sti");
8010483f:	fb                   	sti
}
80104840:	c9                   	leave
80104841:	c3                   	ret
    panic("popcli - interruptible");
80104842:	83 ec 0c             	sub    $0xc,%esp
80104845:	68 03 78 10 80       	push   $0x80107803
8010484a:	e8 31 bb ff ff       	call   80100380 <panic>
    panic("popcli");
8010484f:	83 ec 0c             	sub    $0xc,%esp
80104852:	68 1a 78 10 80       	push   $0x8010781a
80104857:	e8 24 bb ff ff       	call   80100380 <panic>
8010485c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104860 <holding>:
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	56                   	push   %esi
80104864:	53                   	push   %ebx
80104865:	8b 75 08             	mov    0x8(%ebp),%esi
80104868:	31 db                	xor    %ebx,%ebx
  pushcli();
8010486a:	e8 41 ff ff ff       	call   801047b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010486f:	8b 06                	mov    (%esi),%eax
80104871:	85 c0                	test   %eax,%eax
80104873:	75 0b                	jne    80104880 <holding+0x20>
  popcli();
80104875:	e8 86 ff ff ff       	call   80104800 <popcli>
}
8010487a:	89 d8                	mov    %ebx,%eax
8010487c:	5b                   	pop    %ebx
8010487d:	5e                   	pop    %esi
8010487e:	5d                   	pop    %ebp
8010487f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80104880:	8b 5e 08             	mov    0x8(%esi),%ebx
80104883:	e8 b8 f3 ff ff       	call   80103c40 <mycpu>
80104888:	39 c3                	cmp    %eax,%ebx
8010488a:	0f 94 c3             	sete   %bl
  popcli();
8010488d:	e8 6e ff ff ff       	call   80104800 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104892:	0f b6 db             	movzbl %bl,%ebx
}
80104895:	89 d8                	mov    %ebx,%eax
80104897:	5b                   	pop    %ebx
80104898:	5e                   	pop    %esi
80104899:	5d                   	pop    %ebp
8010489a:	c3                   	ret
8010489b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801048a0 <release>:
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	56                   	push   %esi
801048a4:	53                   	push   %ebx
801048a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801048a8:	e8 03 ff ff ff       	call   801047b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048ad:	8b 03                	mov    (%ebx),%eax
801048af:	85 c0                	test   %eax,%eax
801048b1:	75 15                	jne    801048c8 <release+0x28>
  popcli();
801048b3:	e8 48 ff ff ff       	call   80104800 <popcli>
    panic("release");
801048b8:	83 ec 0c             	sub    $0xc,%esp
801048bb:	68 21 78 10 80       	push   $0x80107821
801048c0:	e8 bb ba ff ff       	call   80100380 <panic>
801048c5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801048c8:	8b 73 08             	mov    0x8(%ebx),%esi
801048cb:	e8 70 f3 ff ff       	call   80103c40 <mycpu>
801048d0:	39 c6                	cmp    %eax,%esi
801048d2:	75 df                	jne    801048b3 <release+0x13>
  popcli();
801048d4:	e8 27 ff ff ff       	call   80104800 <popcli>
  lk->pcs[0] = 0;
801048d9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801048e0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801048e7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801048ec:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801048f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048f5:	5b                   	pop    %ebx
801048f6:	5e                   	pop    %esi
801048f7:	5d                   	pop    %ebp
  popcli();
801048f8:	e9 03 ff ff ff       	jmp    80104800 <popcli>
801048fd:	8d 76 00             	lea    0x0(%esi),%esi

80104900 <acquire>:
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	53                   	push   %ebx
80104904:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104907:	e8 a4 fe ff ff       	call   801047b0 <pushcli>
  if(holding(lk))
8010490c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010490f:	e8 9c fe ff ff       	call   801047b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104914:	8b 03                	mov    (%ebx),%eax
80104916:	85 c0                	test   %eax,%eax
80104918:	0f 85 b2 00 00 00    	jne    801049d0 <acquire+0xd0>
  popcli();
8010491e:	e8 dd fe ff ff       	call   80104800 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104923:	b9 01 00 00 00       	mov    $0x1,%ecx
80104928:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010492f:	00 
  while(xchg(&lk->locked, 1) != 0)
80104930:	8b 55 08             	mov    0x8(%ebp),%edx
80104933:	89 c8                	mov    %ecx,%eax
80104935:	f0 87 02             	lock xchg %eax,(%edx)
80104938:	85 c0                	test   %eax,%eax
8010493a:	75 f4                	jne    80104930 <acquire+0x30>
  __sync_synchronize();
8010493c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104941:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104944:	e8 f7 f2 ff ff       	call   80103c40 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104949:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
8010494c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
8010494e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104951:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80104957:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010495c:	77 32                	ja     80104990 <acquire+0x90>
  ebp = (uint*)v - 2;
8010495e:	89 e8                	mov    %ebp,%eax
80104960:	eb 14                	jmp    80104976 <acquire+0x76>
80104962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104968:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010496e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104974:	77 1a                	ja     80104990 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80104976:	8b 58 04             	mov    0x4(%eax),%ebx
80104979:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010497d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104980:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104982:	83 fa 0a             	cmp    $0xa,%edx
80104985:	75 e1                	jne    80104968 <acquire+0x68>
}
80104987:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010498a:	c9                   	leave
8010498b:	c3                   	ret
8010498c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104990:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80104994:	83 c1 34             	add    $0x34,%ecx
80104997:	89 ca                	mov    %ecx,%edx
80104999:	29 c2                	sub    %eax,%edx
8010499b:	83 e2 04             	and    $0x4,%edx
8010499e:	74 10                	je     801049b0 <acquire+0xb0>
    pcs[i] = 0;
801049a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801049a6:	83 c0 04             	add    $0x4,%eax
801049a9:	39 c1                	cmp    %eax,%ecx
801049ab:	74 da                	je     80104987 <acquire+0x87>
801049ad:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
801049b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801049b6:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
801049b9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801049c0:	39 c1                	cmp    %eax,%ecx
801049c2:	75 ec                	jne    801049b0 <acquire+0xb0>
801049c4:	eb c1                	jmp    80104987 <acquire+0x87>
801049c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049cd:	00 
801049ce:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
801049d0:	8b 5b 08             	mov    0x8(%ebx),%ebx
801049d3:	e8 68 f2 ff ff       	call   80103c40 <mycpu>
801049d8:	39 c3                	cmp    %eax,%ebx
801049da:	0f 85 3e ff ff ff    	jne    8010491e <acquire+0x1e>
  popcli();
801049e0:	e8 1b fe ff ff       	call   80104800 <popcli>
    panic("acquire");
801049e5:	83 ec 0c             	sub    $0xc,%esp
801049e8:	68 29 78 10 80       	push   $0x80107829
801049ed:	e8 8e b9 ff ff       	call   80100380 <panic>
801049f2:	66 90                	xchg   %ax,%ax
801049f4:	66 90                	xchg   %ax,%ax
801049f6:	66 90                	xchg   %ax,%ax
801049f8:	66 90                	xchg   %ax,%ax
801049fa:	66 90                	xchg   %ax,%ax
801049fc:	66 90                	xchg   %ax,%ax
801049fe:	66 90                	xchg   %ax,%ax

80104a00 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	57                   	push   %edi
80104a04:	8b 55 08             	mov    0x8(%ebp),%edx
80104a07:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104a0a:	89 d0                	mov    %edx,%eax
80104a0c:	09 c8                	or     %ecx,%eax
80104a0e:	a8 03                	test   $0x3,%al
80104a10:	75 1e                	jne    80104a30 <memset+0x30>
    c &= 0xFF;
80104a12:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104a16:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104a19:	89 d7                	mov    %edx,%edi
80104a1b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104a21:	fc                   	cld
80104a22:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104a24:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104a27:	89 d0                	mov    %edx,%eax
80104a29:	c9                   	leave
80104a2a:	c3                   	ret
80104a2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104a30:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a33:	89 d7                	mov    %edx,%edi
80104a35:	fc                   	cld
80104a36:	f3 aa                	rep stos %al,%es:(%edi)
80104a38:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104a3b:	89 d0                	mov    %edx,%eax
80104a3d:	c9                   	leave
80104a3e:	c3                   	ret
80104a3f:	90                   	nop

80104a40 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	56                   	push   %esi
80104a44:	8b 75 10             	mov    0x10(%ebp),%esi
80104a47:	8b 45 08             	mov    0x8(%ebp),%eax
80104a4a:	53                   	push   %ebx
80104a4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a4e:	85 f6                	test   %esi,%esi
80104a50:	74 2e                	je     80104a80 <memcmp+0x40>
80104a52:	01 c6                	add    %eax,%esi
80104a54:	eb 14                	jmp    80104a6a <memcmp+0x2a>
80104a56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a5d:	00 
80104a5e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104a60:	83 c0 01             	add    $0x1,%eax
80104a63:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104a66:	39 f0                	cmp    %esi,%eax
80104a68:	74 16                	je     80104a80 <memcmp+0x40>
    if(*s1 != *s2)
80104a6a:	0f b6 08             	movzbl (%eax),%ecx
80104a6d:	0f b6 1a             	movzbl (%edx),%ebx
80104a70:	38 d9                	cmp    %bl,%cl
80104a72:	74 ec                	je     80104a60 <memcmp+0x20>
      return *s1 - *s2;
80104a74:	0f b6 c1             	movzbl %cl,%eax
80104a77:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104a79:	5b                   	pop    %ebx
80104a7a:	5e                   	pop    %esi
80104a7b:	5d                   	pop    %ebp
80104a7c:	c3                   	ret
80104a7d:	8d 76 00             	lea    0x0(%esi),%esi
80104a80:	5b                   	pop    %ebx
  return 0;
80104a81:	31 c0                	xor    %eax,%eax
}
80104a83:	5e                   	pop    %esi
80104a84:	5d                   	pop    %ebp
80104a85:	c3                   	ret
80104a86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a8d:	00 
80104a8e:	66 90                	xchg   %ax,%ax

80104a90 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	57                   	push   %edi
80104a94:	8b 55 08             	mov    0x8(%ebp),%edx
80104a97:	8b 45 10             	mov    0x10(%ebp),%eax
80104a9a:	56                   	push   %esi
80104a9b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104a9e:	39 d6                	cmp    %edx,%esi
80104aa0:	73 26                	jae    80104ac8 <memmove+0x38>
80104aa2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104aa5:	39 ca                	cmp    %ecx,%edx
80104aa7:	73 1f                	jae    80104ac8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104aa9:	85 c0                	test   %eax,%eax
80104aab:	74 0f                	je     80104abc <memmove+0x2c>
80104aad:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104ab0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104ab4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104ab7:	83 e8 01             	sub    $0x1,%eax
80104aba:	73 f4                	jae    80104ab0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104abc:	5e                   	pop    %esi
80104abd:	89 d0                	mov    %edx,%eax
80104abf:	5f                   	pop    %edi
80104ac0:	5d                   	pop    %ebp
80104ac1:	c3                   	ret
80104ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104ac8:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104acb:	89 d7                	mov    %edx,%edi
80104acd:	85 c0                	test   %eax,%eax
80104acf:	74 eb                	je     80104abc <memmove+0x2c>
80104ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104ad8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104ad9:	39 ce                	cmp    %ecx,%esi
80104adb:	75 fb                	jne    80104ad8 <memmove+0x48>
}
80104add:	5e                   	pop    %esi
80104ade:	89 d0                	mov    %edx,%eax
80104ae0:	5f                   	pop    %edi
80104ae1:	5d                   	pop    %ebp
80104ae2:	c3                   	ret
80104ae3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104aea:	00 
80104aeb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104af0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104af0:	eb 9e                	jmp    80104a90 <memmove>
80104af2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104af9:	00 
80104afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b00 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	53                   	push   %ebx
80104b04:	8b 55 10             	mov    0x10(%ebp),%edx
80104b07:	8b 45 08             	mov    0x8(%ebp),%eax
80104b0a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104b0d:	85 d2                	test   %edx,%edx
80104b0f:	75 16                	jne    80104b27 <strncmp+0x27>
80104b11:	eb 2d                	jmp    80104b40 <strncmp+0x40>
80104b13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b18:	3a 19                	cmp    (%ecx),%bl
80104b1a:	75 12                	jne    80104b2e <strncmp+0x2e>
    n--, p++, q++;
80104b1c:	83 c0 01             	add    $0x1,%eax
80104b1f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104b22:	83 ea 01             	sub    $0x1,%edx
80104b25:	74 19                	je     80104b40 <strncmp+0x40>
80104b27:	0f b6 18             	movzbl (%eax),%ebx
80104b2a:	84 db                	test   %bl,%bl
80104b2c:	75 ea                	jne    80104b18 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104b2e:	0f b6 00             	movzbl (%eax),%eax
80104b31:	0f b6 11             	movzbl (%ecx),%edx
}
80104b34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b37:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104b38:	29 d0                	sub    %edx,%eax
}
80104b3a:	c3                   	ret
80104b3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104b43:	31 c0                	xor    %eax,%eax
}
80104b45:	c9                   	leave
80104b46:	c3                   	ret
80104b47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b4e:	00 
80104b4f:	90                   	nop

80104b50 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	57                   	push   %edi
80104b54:	56                   	push   %esi
80104b55:	8b 75 08             	mov    0x8(%ebp),%esi
80104b58:	53                   	push   %ebx
80104b59:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104b5c:	89 f0                	mov    %esi,%eax
80104b5e:	eb 15                	jmp    80104b75 <strncpy+0x25>
80104b60:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104b64:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104b67:	83 c0 01             	add    $0x1,%eax
80104b6a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
80104b6e:	88 48 ff             	mov    %cl,-0x1(%eax)
80104b71:	84 c9                	test   %cl,%cl
80104b73:	74 13                	je     80104b88 <strncpy+0x38>
80104b75:	89 d3                	mov    %edx,%ebx
80104b77:	83 ea 01             	sub    $0x1,%edx
80104b7a:	85 db                	test   %ebx,%ebx
80104b7c:	7f e2                	jg     80104b60 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104b7e:	5b                   	pop    %ebx
80104b7f:	89 f0                	mov    %esi,%eax
80104b81:	5e                   	pop    %esi
80104b82:	5f                   	pop    %edi
80104b83:	5d                   	pop    %ebp
80104b84:	c3                   	ret
80104b85:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104b88:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104b8b:	83 e9 01             	sub    $0x1,%ecx
80104b8e:	85 d2                	test   %edx,%edx
80104b90:	74 ec                	je     80104b7e <strncpy+0x2e>
80104b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104b98:	83 c0 01             	add    $0x1,%eax
80104b9b:	89 ca                	mov    %ecx,%edx
80104b9d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104ba1:	29 c2                	sub    %eax,%edx
80104ba3:	85 d2                	test   %edx,%edx
80104ba5:	7f f1                	jg     80104b98 <strncpy+0x48>
}
80104ba7:	5b                   	pop    %ebx
80104ba8:	89 f0                	mov    %esi,%eax
80104baa:	5e                   	pop    %esi
80104bab:	5f                   	pop    %edi
80104bac:	5d                   	pop    %ebp
80104bad:	c3                   	ret
80104bae:	66 90                	xchg   %ax,%ax

80104bb0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	56                   	push   %esi
80104bb4:	8b 55 10             	mov    0x10(%ebp),%edx
80104bb7:	8b 75 08             	mov    0x8(%ebp),%esi
80104bba:	53                   	push   %ebx
80104bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104bbe:	85 d2                	test   %edx,%edx
80104bc0:	7e 25                	jle    80104be7 <safestrcpy+0x37>
80104bc2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104bc6:	89 f2                	mov    %esi,%edx
80104bc8:	eb 16                	jmp    80104be0 <safestrcpy+0x30>
80104bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104bd0:	0f b6 08             	movzbl (%eax),%ecx
80104bd3:	83 c0 01             	add    $0x1,%eax
80104bd6:	83 c2 01             	add    $0x1,%edx
80104bd9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104bdc:	84 c9                	test   %cl,%cl
80104bde:	74 04                	je     80104be4 <safestrcpy+0x34>
80104be0:	39 d8                	cmp    %ebx,%eax
80104be2:	75 ec                	jne    80104bd0 <safestrcpy+0x20>
    ;
  *s = 0;
80104be4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104be7:	89 f0                	mov    %esi,%eax
80104be9:	5b                   	pop    %ebx
80104bea:	5e                   	pop    %esi
80104beb:	5d                   	pop    %ebp
80104bec:	c3                   	ret
80104bed:	8d 76 00             	lea    0x0(%esi),%esi

80104bf0 <strlen>:

int
strlen(const char *s)
{
80104bf0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104bf1:	31 c0                	xor    %eax,%eax
{
80104bf3:	89 e5                	mov    %esp,%ebp
80104bf5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104bf8:	80 3a 00             	cmpb   $0x0,(%edx)
80104bfb:	74 0c                	je     80104c09 <strlen+0x19>
80104bfd:	8d 76 00             	lea    0x0(%esi),%esi
80104c00:	83 c0 01             	add    $0x1,%eax
80104c03:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c07:	75 f7                	jne    80104c00 <strlen+0x10>
    ;
  return n;
}
80104c09:	5d                   	pop    %ebp
80104c0a:	c3                   	ret

80104c0b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104c0b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104c0f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104c13:	55                   	push   %ebp
  pushl %ebx
80104c14:	53                   	push   %ebx
  pushl %esi
80104c15:	56                   	push   %esi
  pushl %edi
80104c16:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104c17:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104c19:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104c1b:	5f                   	pop    %edi
  popl %esi
80104c1c:	5e                   	pop    %esi
  popl %ebx
80104c1d:	5b                   	pop    %ebx
  popl %ebp
80104c1e:	5d                   	pop    %ebp
  ret
80104c1f:	c3                   	ret

80104c20 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	53                   	push   %ebx
80104c24:	83 ec 04             	sub    $0x4,%esp
80104c27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104c2a:	e8 91 f0 ff ff       	call   80103cc0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c2f:	8b 00                	mov    (%eax),%eax
80104c31:	39 c3                	cmp    %eax,%ebx
80104c33:	73 1b                	jae    80104c50 <fetchint+0x30>
80104c35:	8d 53 04             	lea    0x4(%ebx),%edx
80104c38:	39 d0                	cmp    %edx,%eax
80104c3a:	72 14                	jb     80104c50 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104c3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c3f:	8b 13                	mov    (%ebx),%edx
80104c41:	89 10                	mov    %edx,(%eax)
  return 0;
80104c43:	31 c0                	xor    %eax,%eax
}
80104c45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c48:	c9                   	leave
80104c49:	c3                   	ret
80104c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c55:	eb ee                	jmp    80104c45 <fetchint+0x25>
80104c57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c5e:	00 
80104c5f:	90                   	nop

80104c60 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	53                   	push   %ebx
80104c64:	83 ec 04             	sub    $0x4,%esp
80104c67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104c6a:	e8 51 f0 ff ff       	call   80103cc0 <myproc>

  if(addr >= curproc->sz)
80104c6f:	3b 18                	cmp    (%eax),%ebx
80104c71:	73 2d                	jae    80104ca0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104c73:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c76:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104c78:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104c7a:	39 d3                	cmp    %edx,%ebx
80104c7c:	73 22                	jae    80104ca0 <fetchstr+0x40>
80104c7e:	89 d8                	mov    %ebx,%eax
80104c80:	eb 0d                	jmp    80104c8f <fetchstr+0x2f>
80104c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c88:	83 c0 01             	add    $0x1,%eax
80104c8b:	39 d0                	cmp    %edx,%eax
80104c8d:	73 11                	jae    80104ca0 <fetchstr+0x40>
    if(*s == 0)
80104c8f:	80 38 00             	cmpb   $0x0,(%eax)
80104c92:	75 f4                	jne    80104c88 <fetchstr+0x28>
      return s - *pp;
80104c94:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104c96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c99:	c9                   	leave
80104c9a:	c3                   	ret
80104c9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ca0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104ca3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ca8:	c9                   	leave
80104ca9:	c3                   	ret
80104caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104cb0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	56                   	push   %esi
80104cb4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cb5:	e8 06 f0 ff ff       	call   80103cc0 <myproc>
80104cba:	8b 55 08             	mov    0x8(%ebp),%edx
80104cbd:	8b 40 18             	mov    0x18(%eax),%eax
80104cc0:	8b 40 44             	mov    0x44(%eax),%eax
80104cc3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104cc6:	e8 f5 ef ff ff       	call   80103cc0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ccb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104cce:	8b 00                	mov    (%eax),%eax
80104cd0:	39 c6                	cmp    %eax,%esi
80104cd2:	73 1c                	jae    80104cf0 <argint+0x40>
80104cd4:	8d 53 08             	lea    0x8(%ebx),%edx
80104cd7:	39 d0                	cmp    %edx,%eax
80104cd9:	72 15                	jb     80104cf0 <argint+0x40>
  *ip = *(int*)(addr);
80104cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cde:	8b 53 04             	mov    0x4(%ebx),%edx
80104ce1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ce3:	31 c0                	xor    %eax,%eax
}
80104ce5:	5b                   	pop    %ebx
80104ce6:	5e                   	pop    %esi
80104ce7:	5d                   	pop    %ebp
80104ce8:	c3                   	ret
80104ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cf5:	eb ee                	jmp    80104ce5 <argint+0x35>
80104cf7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cfe:	00 
80104cff:	90                   	nop

80104d00 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	57                   	push   %edi
80104d04:	56                   	push   %esi
80104d05:	53                   	push   %ebx
80104d06:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104d09:	e8 b2 ef ff ff       	call   80103cc0 <myproc>
80104d0e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d10:	e8 ab ef ff ff       	call   80103cc0 <myproc>
80104d15:	8b 55 08             	mov    0x8(%ebp),%edx
80104d18:	8b 40 18             	mov    0x18(%eax),%eax
80104d1b:	8b 40 44             	mov    0x44(%eax),%eax
80104d1e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d21:	e8 9a ef ff ff       	call   80103cc0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d26:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d29:	8b 00                	mov    (%eax),%eax
80104d2b:	39 c7                	cmp    %eax,%edi
80104d2d:	73 31                	jae    80104d60 <argptr+0x60>
80104d2f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104d32:	39 c8                	cmp    %ecx,%eax
80104d34:	72 2a                	jb     80104d60 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d36:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104d39:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d3c:	85 d2                	test   %edx,%edx
80104d3e:	78 20                	js     80104d60 <argptr+0x60>
80104d40:	8b 16                	mov    (%esi),%edx
80104d42:	39 d0                	cmp    %edx,%eax
80104d44:	73 1a                	jae    80104d60 <argptr+0x60>
80104d46:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104d49:	01 c3                	add    %eax,%ebx
80104d4b:	39 da                	cmp    %ebx,%edx
80104d4d:	72 11                	jb     80104d60 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104d4f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d52:	89 02                	mov    %eax,(%edx)
  return 0;
80104d54:	31 c0                	xor    %eax,%eax
}
80104d56:	83 c4 0c             	add    $0xc,%esp
80104d59:	5b                   	pop    %ebx
80104d5a:	5e                   	pop    %esi
80104d5b:	5f                   	pop    %edi
80104d5c:	5d                   	pop    %ebp
80104d5d:	c3                   	ret
80104d5e:	66 90                	xchg   %ax,%ax
    return -1;
80104d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d65:	eb ef                	jmp    80104d56 <argptr+0x56>
80104d67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d6e:	00 
80104d6f:	90                   	nop

80104d70 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	56                   	push   %esi
80104d74:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d75:	e8 46 ef ff ff       	call   80103cc0 <myproc>
80104d7a:	8b 55 08             	mov    0x8(%ebp),%edx
80104d7d:	8b 40 18             	mov    0x18(%eax),%eax
80104d80:	8b 40 44             	mov    0x44(%eax),%eax
80104d83:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d86:	e8 35 ef ff ff       	call   80103cc0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d8b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d8e:	8b 00                	mov    (%eax),%eax
80104d90:	39 c6                	cmp    %eax,%esi
80104d92:	73 44                	jae    80104dd8 <argstr+0x68>
80104d94:	8d 53 08             	lea    0x8(%ebx),%edx
80104d97:	39 d0                	cmp    %edx,%eax
80104d99:	72 3d                	jb     80104dd8 <argstr+0x68>
  *ip = *(int*)(addr);
80104d9b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104d9e:	e8 1d ef ff ff       	call   80103cc0 <myproc>
  if(addr >= curproc->sz)
80104da3:	3b 18                	cmp    (%eax),%ebx
80104da5:	73 31                	jae    80104dd8 <argstr+0x68>
  *pp = (char*)addr;
80104da7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104daa:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104dac:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104dae:	39 d3                	cmp    %edx,%ebx
80104db0:	73 26                	jae    80104dd8 <argstr+0x68>
80104db2:	89 d8                	mov    %ebx,%eax
80104db4:	eb 11                	jmp    80104dc7 <argstr+0x57>
80104db6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104dbd:	00 
80104dbe:	66 90                	xchg   %ax,%ax
80104dc0:	83 c0 01             	add    $0x1,%eax
80104dc3:	39 d0                	cmp    %edx,%eax
80104dc5:	73 11                	jae    80104dd8 <argstr+0x68>
    if(*s == 0)
80104dc7:	80 38 00             	cmpb   $0x0,(%eax)
80104dca:	75 f4                	jne    80104dc0 <argstr+0x50>
      return s - *pp;
80104dcc:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104dce:	5b                   	pop    %ebx
80104dcf:	5e                   	pop    %esi
80104dd0:	5d                   	pop    %ebp
80104dd1:	c3                   	ret
80104dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104dd8:	5b                   	pop    %ebx
    return -1;
80104dd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dde:	5e                   	pop    %esi
80104ddf:	5d                   	pop    %ebp
80104de0:	c3                   	ret
80104de1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104de8:	00 
80104de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104df0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	53                   	push   %ebx
80104df4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104df7:	e8 c4 ee ff ff       	call   80103cc0 <myproc>
80104dfc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104dfe:	8b 40 18             	mov    0x18(%eax),%eax
80104e01:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104e04:	8d 50 ff             	lea    -0x1(%eax),%edx
80104e07:	83 fa 14             	cmp    $0x14,%edx
80104e0a:	77 24                	ja     80104e30 <syscall+0x40>
80104e0c:	8b 14 85 00 7e 10 80 	mov    -0x7fef8200(,%eax,4),%edx
80104e13:	85 d2                	test   %edx,%edx
80104e15:	74 19                	je     80104e30 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104e17:	ff d2                	call   *%edx
80104e19:	89 c2                	mov    %eax,%edx
80104e1b:	8b 43 18             	mov    0x18(%ebx),%eax
80104e1e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104e21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e24:	c9                   	leave
80104e25:	c3                   	ret
80104e26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e2d:	00 
80104e2e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104e30:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104e31:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104e34:	50                   	push   %eax
80104e35:	ff 73 10             	push   0x10(%ebx)
80104e38:	68 31 78 10 80       	push   $0x80107831
80104e3d:	e8 1e b8 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104e42:	8b 43 18             	mov    0x18(%ebx),%eax
80104e45:	83 c4 10             	add    $0x10,%esp
80104e48:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104e4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e52:	c9                   	leave
80104e53:	c3                   	ret
80104e54:	66 90                	xchg   %ax,%ax
80104e56:	66 90                	xchg   %ax,%ax
80104e58:	66 90                	xchg   %ax,%ax
80104e5a:	66 90                	xchg   %ax,%ax
80104e5c:	66 90                	xchg   %ax,%ax
80104e5e:	66 90                	xchg   %ax,%ax

80104e60 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	57                   	push   %edi
80104e64:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104e65:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104e68:	53                   	push   %ebx
80104e69:	83 ec 34             	sub    $0x34,%esp
80104e6c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104e6f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e72:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104e75:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104e78:	57                   	push   %edi
80104e79:	50                   	push   %eax
80104e7a:	e8 81 d5 ff ff       	call   80102400 <nameiparent>
80104e7f:	83 c4 10             	add    $0x10,%esp
80104e82:	85 c0                	test   %eax,%eax
80104e84:	74 5e                	je     80104ee4 <create+0x84>
    return 0;
  ilock(dp);
80104e86:	83 ec 0c             	sub    $0xc,%esp
80104e89:	89 c3                	mov    %eax,%ebx
80104e8b:	50                   	push   %eax
80104e8c:	e8 6f cc ff ff       	call   80101b00 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104e91:	83 c4 0c             	add    $0xc,%esp
80104e94:	6a 00                	push   $0x0
80104e96:	57                   	push   %edi
80104e97:	53                   	push   %ebx
80104e98:	e8 b3 d1 ff ff       	call   80102050 <dirlookup>
80104e9d:	83 c4 10             	add    $0x10,%esp
80104ea0:	89 c6                	mov    %eax,%esi
80104ea2:	85 c0                	test   %eax,%eax
80104ea4:	74 4a                	je     80104ef0 <create+0x90>
    iunlockput(dp);
80104ea6:	83 ec 0c             	sub    $0xc,%esp
80104ea9:	53                   	push   %ebx
80104eaa:	e8 e1 ce ff ff       	call   80101d90 <iunlockput>
    ilock(ip);
80104eaf:	89 34 24             	mov    %esi,(%esp)
80104eb2:	e8 49 cc ff ff       	call   80101b00 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104eb7:	83 c4 10             	add    $0x10,%esp
80104eba:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104ebf:	75 17                	jne    80104ed8 <create+0x78>
80104ec1:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104ec6:	75 10                	jne    80104ed8 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ec8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ecb:	89 f0                	mov    %esi,%eax
80104ecd:	5b                   	pop    %ebx
80104ece:	5e                   	pop    %esi
80104ecf:	5f                   	pop    %edi
80104ed0:	5d                   	pop    %ebp
80104ed1:	c3                   	ret
80104ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80104ed8:	83 ec 0c             	sub    $0xc,%esp
80104edb:	56                   	push   %esi
80104edc:	e8 af ce ff ff       	call   80101d90 <iunlockput>
    return 0;
80104ee1:	83 c4 10             	add    $0x10,%esp
}
80104ee4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104ee7:	31 f6                	xor    %esi,%esi
}
80104ee9:	5b                   	pop    %ebx
80104eea:	89 f0                	mov    %esi,%eax
80104eec:	5e                   	pop    %esi
80104eed:	5f                   	pop    %edi
80104eee:	5d                   	pop    %ebp
80104eef:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104ef0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104ef4:	83 ec 08             	sub    $0x8,%esp
80104ef7:	50                   	push   %eax
80104ef8:	ff 33                	push   (%ebx)
80104efa:	e8 91 ca ff ff       	call   80101990 <ialloc>
80104eff:	83 c4 10             	add    $0x10,%esp
80104f02:	89 c6                	mov    %eax,%esi
80104f04:	85 c0                	test   %eax,%eax
80104f06:	0f 84 bc 00 00 00    	je     80104fc8 <create+0x168>
  ilock(ip);
80104f0c:	83 ec 0c             	sub    $0xc,%esp
80104f0f:	50                   	push   %eax
80104f10:	e8 eb cb ff ff       	call   80101b00 <ilock>
  ip->major = major;
80104f15:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104f19:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104f1d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104f21:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104f25:	b8 01 00 00 00       	mov    $0x1,%eax
80104f2a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104f2e:	89 34 24             	mov    %esi,(%esp)
80104f31:	e8 1a cb ff ff       	call   80101a50 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104f36:	83 c4 10             	add    $0x10,%esp
80104f39:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104f3e:	74 30                	je     80104f70 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104f40:	83 ec 04             	sub    $0x4,%esp
80104f43:	ff 76 04             	push   0x4(%esi)
80104f46:	57                   	push   %edi
80104f47:	53                   	push   %ebx
80104f48:	e8 d3 d3 ff ff       	call   80102320 <dirlink>
80104f4d:	83 c4 10             	add    $0x10,%esp
80104f50:	85 c0                	test   %eax,%eax
80104f52:	78 67                	js     80104fbb <create+0x15b>
  iunlockput(dp);
80104f54:	83 ec 0c             	sub    $0xc,%esp
80104f57:	53                   	push   %ebx
80104f58:	e8 33 ce ff ff       	call   80101d90 <iunlockput>
  return ip;
80104f5d:	83 c4 10             	add    $0x10,%esp
}
80104f60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f63:	89 f0                	mov    %esi,%eax
80104f65:	5b                   	pop    %ebx
80104f66:	5e                   	pop    %esi
80104f67:	5f                   	pop    %edi
80104f68:	5d                   	pop    %ebp
80104f69:	c3                   	ret
80104f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104f70:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104f73:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104f78:	53                   	push   %ebx
80104f79:	e8 d2 ca ff ff       	call   80101a50 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104f7e:	83 c4 0c             	add    $0xc,%esp
80104f81:	ff 76 04             	push   0x4(%esi)
80104f84:	68 69 78 10 80       	push   $0x80107869
80104f89:	56                   	push   %esi
80104f8a:	e8 91 d3 ff ff       	call   80102320 <dirlink>
80104f8f:	83 c4 10             	add    $0x10,%esp
80104f92:	85 c0                	test   %eax,%eax
80104f94:	78 18                	js     80104fae <create+0x14e>
80104f96:	83 ec 04             	sub    $0x4,%esp
80104f99:	ff 73 04             	push   0x4(%ebx)
80104f9c:	68 68 78 10 80       	push   $0x80107868
80104fa1:	56                   	push   %esi
80104fa2:	e8 79 d3 ff ff       	call   80102320 <dirlink>
80104fa7:	83 c4 10             	add    $0x10,%esp
80104faa:	85 c0                	test   %eax,%eax
80104fac:	79 92                	jns    80104f40 <create+0xe0>
      panic("create dots");
80104fae:	83 ec 0c             	sub    $0xc,%esp
80104fb1:	68 5c 78 10 80       	push   $0x8010785c
80104fb6:	e8 c5 b3 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104fbb:	83 ec 0c             	sub    $0xc,%esp
80104fbe:	68 6b 78 10 80       	push   $0x8010786b
80104fc3:	e8 b8 b3 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104fc8:	83 ec 0c             	sub    $0xc,%esp
80104fcb:	68 4d 78 10 80       	push   $0x8010784d
80104fd0:	e8 ab b3 ff ff       	call   80100380 <panic>
80104fd5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fdc:	00 
80104fdd:	8d 76 00             	lea    0x0(%esi),%esi

80104fe0 <sys_dup>:
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	56                   	push   %esi
80104fe4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104fe5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104fe8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104feb:	50                   	push   %eax
80104fec:	6a 00                	push   $0x0
80104fee:	e8 bd fc ff ff       	call   80104cb0 <argint>
80104ff3:	83 c4 10             	add    $0x10,%esp
80104ff6:	85 c0                	test   %eax,%eax
80104ff8:	78 36                	js     80105030 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104ffa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ffe:	77 30                	ja     80105030 <sys_dup+0x50>
80105000:	e8 bb ec ff ff       	call   80103cc0 <myproc>
80105005:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105008:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010500c:	85 f6                	test   %esi,%esi
8010500e:	74 20                	je     80105030 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105010:	e8 ab ec ff ff       	call   80103cc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105015:	31 db                	xor    %ebx,%ebx
80105017:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010501e:	00 
8010501f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105020:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105024:	85 d2                	test   %edx,%edx
80105026:	74 18                	je     80105040 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105028:	83 c3 01             	add    $0x1,%ebx
8010502b:	83 fb 10             	cmp    $0x10,%ebx
8010502e:	75 f0                	jne    80105020 <sys_dup+0x40>
}
80105030:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105033:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105038:	89 d8                	mov    %ebx,%eax
8010503a:	5b                   	pop    %ebx
8010503b:	5e                   	pop    %esi
8010503c:	5d                   	pop    %ebp
8010503d:	c3                   	ret
8010503e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105040:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105043:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105047:	56                   	push   %esi
80105048:	e8 d3 c1 ff ff       	call   80101220 <filedup>
  return fd;
8010504d:	83 c4 10             	add    $0x10,%esp
}
80105050:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105053:	89 d8                	mov    %ebx,%eax
80105055:	5b                   	pop    %ebx
80105056:	5e                   	pop    %esi
80105057:	5d                   	pop    %ebp
80105058:	c3                   	ret
80105059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105060 <sys_read>:
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	56                   	push   %esi
80105064:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105065:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105068:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010506b:	53                   	push   %ebx
8010506c:	6a 00                	push   $0x0
8010506e:	e8 3d fc ff ff       	call   80104cb0 <argint>
80105073:	83 c4 10             	add    $0x10,%esp
80105076:	85 c0                	test   %eax,%eax
80105078:	78 5e                	js     801050d8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010507a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010507e:	77 58                	ja     801050d8 <sys_read+0x78>
80105080:	e8 3b ec ff ff       	call   80103cc0 <myproc>
80105085:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105088:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010508c:	85 f6                	test   %esi,%esi
8010508e:	74 48                	je     801050d8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105090:	83 ec 08             	sub    $0x8,%esp
80105093:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105096:	50                   	push   %eax
80105097:	6a 02                	push   $0x2
80105099:	e8 12 fc ff ff       	call   80104cb0 <argint>
8010509e:	83 c4 10             	add    $0x10,%esp
801050a1:	85 c0                	test   %eax,%eax
801050a3:	78 33                	js     801050d8 <sys_read+0x78>
801050a5:	83 ec 04             	sub    $0x4,%esp
801050a8:	ff 75 f0             	push   -0x10(%ebp)
801050ab:	53                   	push   %ebx
801050ac:	6a 01                	push   $0x1
801050ae:	e8 4d fc ff ff       	call   80104d00 <argptr>
801050b3:	83 c4 10             	add    $0x10,%esp
801050b6:	85 c0                	test   %eax,%eax
801050b8:	78 1e                	js     801050d8 <sys_read+0x78>
  return fileread(f, p, n);
801050ba:	83 ec 04             	sub    $0x4,%esp
801050bd:	ff 75 f0             	push   -0x10(%ebp)
801050c0:	ff 75 f4             	push   -0xc(%ebp)
801050c3:	56                   	push   %esi
801050c4:	e8 d7 c2 ff ff       	call   801013a0 <fileread>
801050c9:	83 c4 10             	add    $0x10,%esp
}
801050cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050cf:	5b                   	pop    %ebx
801050d0:	5e                   	pop    %esi
801050d1:	5d                   	pop    %ebp
801050d2:	c3                   	ret
801050d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
801050d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050dd:	eb ed                	jmp    801050cc <sys_read+0x6c>
801050df:	90                   	nop

801050e0 <sys_write>:
{
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	56                   	push   %esi
801050e4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801050e5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801050e8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801050eb:	53                   	push   %ebx
801050ec:	6a 00                	push   $0x0
801050ee:	e8 bd fb ff ff       	call   80104cb0 <argint>
801050f3:	83 c4 10             	add    $0x10,%esp
801050f6:	85 c0                	test   %eax,%eax
801050f8:	78 5e                	js     80105158 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801050fa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050fe:	77 58                	ja     80105158 <sys_write+0x78>
80105100:	e8 bb eb ff ff       	call   80103cc0 <myproc>
80105105:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105108:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010510c:	85 f6                	test   %esi,%esi
8010510e:	74 48                	je     80105158 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105110:	83 ec 08             	sub    $0x8,%esp
80105113:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105116:	50                   	push   %eax
80105117:	6a 02                	push   $0x2
80105119:	e8 92 fb ff ff       	call   80104cb0 <argint>
8010511e:	83 c4 10             	add    $0x10,%esp
80105121:	85 c0                	test   %eax,%eax
80105123:	78 33                	js     80105158 <sys_write+0x78>
80105125:	83 ec 04             	sub    $0x4,%esp
80105128:	ff 75 f0             	push   -0x10(%ebp)
8010512b:	53                   	push   %ebx
8010512c:	6a 01                	push   $0x1
8010512e:	e8 cd fb ff ff       	call   80104d00 <argptr>
80105133:	83 c4 10             	add    $0x10,%esp
80105136:	85 c0                	test   %eax,%eax
80105138:	78 1e                	js     80105158 <sys_write+0x78>
  return filewrite(f, p, n);
8010513a:	83 ec 04             	sub    $0x4,%esp
8010513d:	ff 75 f0             	push   -0x10(%ebp)
80105140:	ff 75 f4             	push   -0xc(%ebp)
80105143:	56                   	push   %esi
80105144:	e8 e7 c2 ff ff       	call   80101430 <filewrite>
80105149:	83 c4 10             	add    $0x10,%esp
}
8010514c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010514f:	5b                   	pop    %ebx
80105150:	5e                   	pop    %esi
80105151:	5d                   	pop    %ebp
80105152:	c3                   	ret
80105153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010515d:	eb ed                	jmp    8010514c <sys_write+0x6c>
8010515f:	90                   	nop

80105160 <sys_close>:
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	56                   	push   %esi
80105164:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105165:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105168:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010516b:	50                   	push   %eax
8010516c:	6a 00                	push   $0x0
8010516e:	e8 3d fb ff ff       	call   80104cb0 <argint>
80105173:	83 c4 10             	add    $0x10,%esp
80105176:	85 c0                	test   %eax,%eax
80105178:	78 3e                	js     801051b8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010517a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010517e:	77 38                	ja     801051b8 <sys_close+0x58>
80105180:	e8 3b eb ff ff       	call   80103cc0 <myproc>
80105185:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105188:	8d 5a 08             	lea    0x8(%edx),%ebx
8010518b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010518f:	85 f6                	test   %esi,%esi
80105191:	74 25                	je     801051b8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105193:	e8 28 eb ff ff       	call   80103cc0 <myproc>
  fileclose(f);
80105198:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010519b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801051a2:	00 
  fileclose(f);
801051a3:	56                   	push   %esi
801051a4:	e8 c7 c0 ff ff       	call   80101270 <fileclose>
  return 0;
801051a9:	83 c4 10             	add    $0x10,%esp
801051ac:	31 c0                	xor    %eax,%eax
}
801051ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051b1:	5b                   	pop    %ebx
801051b2:	5e                   	pop    %esi
801051b3:	5d                   	pop    %ebp
801051b4:	c3                   	ret
801051b5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801051b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051bd:	eb ef                	jmp    801051ae <sys_close+0x4e>
801051bf:	90                   	nop

801051c0 <sys_fstat>:
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	56                   	push   %esi
801051c4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801051c5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801051c8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801051cb:	53                   	push   %ebx
801051cc:	6a 00                	push   $0x0
801051ce:	e8 dd fa ff ff       	call   80104cb0 <argint>
801051d3:	83 c4 10             	add    $0x10,%esp
801051d6:	85 c0                	test   %eax,%eax
801051d8:	78 46                	js     80105220 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051da:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051de:	77 40                	ja     80105220 <sys_fstat+0x60>
801051e0:	e8 db ea ff ff       	call   80103cc0 <myproc>
801051e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051e8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801051ec:	85 f6                	test   %esi,%esi
801051ee:	74 30                	je     80105220 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801051f0:	83 ec 04             	sub    $0x4,%esp
801051f3:	6a 14                	push   $0x14
801051f5:	53                   	push   %ebx
801051f6:	6a 01                	push   $0x1
801051f8:	e8 03 fb ff ff       	call   80104d00 <argptr>
801051fd:	83 c4 10             	add    $0x10,%esp
80105200:	85 c0                	test   %eax,%eax
80105202:	78 1c                	js     80105220 <sys_fstat+0x60>
  return filestat(f, st);
80105204:	83 ec 08             	sub    $0x8,%esp
80105207:	ff 75 f4             	push   -0xc(%ebp)
8010520a:	56                   	push   %esi
8010520b:	e8 40 c1 ff ff       	call   80101350 <filestat>
80105210:	83 c4 10             	add    $0x10,%esp
}
80105213:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105216:	5b                   	pop    %ebx
80105217:	5e                   	pop    %esi
80105218:	5d                   	pop    %ebp
80105219:	c3                   	ret
8010521a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105225:	eb ec                	jmp    80105213 <sys_fstat+0x53>
80105227:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010522e:	00 
8010522f:	90                   	nop

80105230 <sys_link>:
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	57                   	push   %edi
80105234:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105235:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105238:	53                   	push   %ebx
80105239:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010523c:	50                   	push   %eax
8010523d:	6a 00                	push   $0x0
8010523f:	e8 2c fb ff ff       	call   80104d70 <argstr>
80105244:	83 c4 10             	add    $0x10,%esp
80105247:	85 c0                	test   %eax,%eax
80105249:	0f 88 fb 00 00 00    	js     8010534a <sys_link+0x11a>
8010524f:	83 ec 08             	sub    $0x8,%esp
80105252:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105255:	50                   	push   %eax
80105256:	6a 01                	push   $0x1
80105258:	e8 13 fb ff ff       	call   80104d70 <argstr>
8010525d:	83 c4 10             	add    $0x10,%esp
80105260:	85 c0                	test   %eax,%eax
80105262:	0f 88 e2 00 00 00    	js     8010534a <sys_link+0x11a>
  begin_op();
80105268:	e8 33 de ff ff       	call   801030a0 <begin_op>
  if((ip = namei(old)) == 0){
8010526d:	83 ec 0c             	sub    $0xc,%esp
80105270:	ff 75 d4             	push   -0x2c(%ebp)
80105273:	e8 68 d1 ff ff       	call   801023e0 <namei>
80105278:	83 c4 10             	add    $0x10,%esp
8010527b:	89 c3                	mov    %eax,%ebx
8010527d:	85 c0                	test   %eax,%eax
8010527f:	0f 84 df 00 00 00    	je     80105364 <sys_link+0x134>
  ilock(ip);
80105285:	83 ec 0c             	sub    $0xc,%esp
80105288:	50                   	push   %eax
80105289:	e8 72 c8 ff ff       	call   80101b00 <ilock>
  if(ip->type == T_DIR){
8010528e:	83 c4 10             	add    $0x10,%esp
80105291:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105296:	0f 84 b5 00 00 00    	je     80105351 <sys_link+0x121>
  iupdate(ip);
8010529c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010529f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801052a4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801052a7:	53                   	push   %ebx
801052a8:	e8 a3 c7 ff ff       	call   80101a50 <iupdate>
  iunlock(ip);
801052ad:	89 1c 24             	mov    %ebx,(%esp)
801052b0:	e8 2b c9 ff ff       	call   80101be0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801052b5:	58                   	pop    %eax
801052b6:	5a                   	pop    %edx
801052b7:	57                   	push   %edi
801052b8:	ff 75 d0             	push   -0x30(%ebp)
801052bb:	e8 40 d1 ff ff       	call   80102400 <nameiparent>
801052c0:	83 c4 10             	add    $0x10,%esp
801052c3:	89 c6                	mov    %eax,%esi
801052c5:	85 c0                	test   %eax,%eax
801052c7:	74 5b                	je     80105324 <sys_link+0xf4>
  ilock(dp);
801052c9:	83 ec 0c             	sub    $0xc,%esp
801052cc:	50                   	push   %eax
801052cd:	e8 2e c8 ff ff       	call   80101b00 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801052d2:	8b 03                	mov    (%ebx),%eax
801052d4:	83 c4 10             	add    $0x10,%esp
801052d7:	39 06                	cmp    %eax,(%esi)
801052d9:	75 3d                	jne    80105318 <sys_link+0xe8>
801052db:	83 ec 04             	sub    $0x4,%esp
801052de:	ff 73 04             	push   0x4(%ebx)
801052e1:	57                   	push   %edi
801052e2:	56                   	push   %esi
801052e3:	e8 38 d0 ff ff       	call   80102320 <dirlink>
801052e8:	83 c4 10             	add    $0x10,%esp
801052eb:	85 c0                	test   %eax,%eax
801052ed:	78 29                	js     80105318 <sys_link+0xe8>
  iunlockput(dp);
801052ef:	83 ec 0c             	sub    $0xc,%esp
801052f2:	56                   	push   %esi
801052f3:	e8 98 ca ff ff       	call   80101d90 <iunlockput>
  iput(ip);
801052f8:	89 1c 24             	mov    %ebx,(%esp)
801052fb:	e8 30 c9 ff ff       	call   80101c30 <iput>
  end_op();
80105300:	e8 0b de ff ff       	call   80103110 <end_op>
  return 0;
80105305:	83 c4 10             	add    $0x10,%esp
80105308:	31 c0                	xor    %eax,%eax
}
8010530a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010530d:	5b                   	pop    %ebx
8010530e:	5e                   	pop    %esi
8010530f:	5f                   	pop    %edi
80105310:	5d                   	pop    %ebp
80105311:	c3                   	ret
80105312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105318:	83 ec 0c             	sub    $0xc,%esp
8010531b:	56                   	push   %esi
8010531c:	e8 6f ca ff ff       	call   80101d90 <iunlockput>
    goto bad;
80105321:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105324:	83 ec 0c             	sub    $0xc,%esp
80105327:	53                   	push   %ebx
80105328:	e8 d3 c7 ff ff       	call   80101b00 <ilock>
  ip->nlink--;
8010532d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105332:	89 1c 24             	mov    %ebx,(%esp)
80105335:	e8 16 c7 ff ff       	call   80101a50 <iupdate>
  iunlockput(ip);
8010533a:	89 1c 24             	mov    %ebx,(%esp)
8010533d:	e8 4e ca ff ff       	call   80101d90 <iunlockput>
  end_op();
80105342:	e8 c9 dd ff ff       	call   80103110 <end_op>
  return -1;
80105347:	83 c4 10             	add    $0x10,%esp
    return -1;
8010534a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010534f:	eb b9                	jmp    8010530a <sys_link+0xda>
    iunlockput(ip);
80105351:	83 ec 0c             	sub    $0xc,%esp
80105354:	53                   	push   %ebx
80105355:	e8 36 ca ff ff       	call   80101d90 <iunlockput>
    end_op();
8010535a:	e8 b1 dd ff ff       	call   80103110 <end_op>
    return -1;
8010535f:	83 c4 10             	add    $0x10,%esp
80105362:	eb e6                	jmp    8010534a <sys_link+0x11a>
    end_op();
80105364:	e8 a7 dd ff ff       	call   80103110 <end_op>
    return -1;
80105369:	eb df                	jmp    8010534a <sys_link+0x11a>
8010536b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105370 <sys_unlink>:
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	57                   	push   %edi
80105374:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105375:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105378:	53                   	push   %ebx
80105379:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010537c:	50                   	push   %eax
8010537d:	6a 00                	push   $0x0
8010537f:	e8 ec f9 ff ff       	call   80104d70 <argstr>
80105384:	83 c4 10             	add    $0x10,%esp
80105387:	85 c0                	test   %eax,%eax
80105389:	0f 88 54 01 00 00    	js     801054e3 <sys_unlink+0x173>
  begin_op();
8010538f:	e8 0c dd ff ff       	call   801030a0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105394:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105397:	83 ec 08             	sub    $0x8,%esp
8010539a:	53                   	push   %ebx
8010539b:	ff 75 c0             	push   -0x40(%ebp)
8010539e:	e8 5d d0 ff ff       	call   80102400 <nameiparent>
801053a3:	83 c4 10             	add    $0x10,%esp
801053a6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801053a9:	85 c0                	test   %eax,%eax
801053ab:	0f 84 58 01 00 00    	je     80105509 <sys_unlink+0x199>
  ilock(dp);
801053b1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801053b4:	83 ec 0c             	sub    $0xc,%esp
801053b7:	57                   	push   %edi
801053b8:	e8 43 c7 ff ff       	call   80101b00 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801053bd:	58                   	pop    %eax
801053be:	5a                   	pop    %edx
801053bf:	68 69 78 10 80       	push   $0x80107869
801053c4:	53                   	push   %ebx
801053c5:	e8 66 cc ff ff       	call   80102030 <namecmp>
801053ca:	83 c4 10             	add    $0x10,%esp
801053cd:	85 c0                	test   %eax,%eax
801053cf:	0f 84 fb 00 00 00    	je     801054d0 <sys_unlink+0x160>
801053d5:	83 ec 08             	sub    $0x8,%esp
801053d8:	68 68 78 10 80       	push   $0x80107868
801053dd:	53                   	push   %ebx
801053de:	e8 4d cc ff ff       	call   80102030 <namecmp>
801053e3:	83 c4 10             	add    $0x10,%esp
801053e6:	85 c0                	test   %eax,%eax
801053e8:	0f 84 e2 00 00 00    	je     801054d0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
801053ee:	83 ec 04             	sub    $0x4,%esp
801053f1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801053f4:	50                   	push   %eax
801053f5:	53                   	push   %ebx
801053f6:	57                   	push   %edi
801053f7:	e8 54 cc ff ff       	call   80102050 <dirlookup>
801053fc:	83 c4 10             	add    $0x10,%esp
801053ff:	89 c3                	mov    %eax,%ebx
80105401:	85 c0                	test   %eax,%eax
80105403:	0f 84 c7 00 00 00    	je     801054d0 <sys_unlink+0x160>
  ilock(ip);
80105409:	83 ec 0c             	sub    $0xc,%esp
8010540c:	50                   	push   %eax
8010540d:	e8 ee c6 ff ff       	call   80101b00 <ilock>
  if(ip->nlink < 1)
80105412:	83 c4 10             	add    $0x10,%esp
80105415:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010541a:	0f 8e 0a 01 00 00    	jle    8010552a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105420:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105425:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105428:	74 66                	je     80105490 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010542a:	83 ec 04             	sub    $0x4,%esp
8010542d:	6a 10                	push   $0x10
8010542f:	6a 00                	push   $0x0
80105431:	57                   	push   %edi
80105432:	e8 c9 f5 ff ff       	call   80104a00 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105437:	6a 10                	push   $0x10
80105439:	ff 75 c4             	push   -0x3c(%ebp)
8010543c:	57                   	push   %edi
8010543d:	ff 75 b4             	push   -0x4c(%ebp)
80105440:	e8 cb ca ff ff       	call   80101f10 <writei>
80105445:	83 c4 20             	add    $0x20,%esp
80105448:	83 f8 10             	cmp    $0x10,%eax
8010544b:	0f 85 cc 00 00 00    	jne    8010551d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105451:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105456:	0f 84 94 00 00 00    	je     801054f0 <sys_unlink+0x180>
  iunlockput(dp);
8010545c:	83 ec 0c             	sub    $0xc,%esp
8010545f:	ff 75 b4             	push   -0x4c(%ebp)
80105462:	e8 29 c9 ff ff       	call   80101d90 <iunlockput>
  ip->nlink--;
80105467:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010546c:	89 1c 24             	mov    %ebx,(%esp)
8010546f:	e8 dc c5 ff ff       	call   80101a50 <iupdate>
  iunlockput(ip);
80105474:	89 1c 24             	mov    %ebx,(%esp)
80105477:	e8 14 c9 ff ff       	call   80101d90 <iunlockput>
  end_op();
8010547c:	e8 8f dc ff ff       	call   80103110 <end_op>
  return 0;
80105481:	83 c4 10             	add    $0x10,%esp
80105484:	31 c0                	xor    %eax,%eax
}
80105486:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105489:	5b                   	pop    %ebx
8010548a:	5e                   	pop    %esi
8010548b:	5f                   	pop    %edi
8010548c:	5d                   	pop    %ebp
8010548d:	c3                   	ret
8010548e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105490:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105494:	76 94                	jbe    8010542a <sys_unlink+0xba>
80105496:	be 20 00 00 00       	mov    $0x20,%esi
8010549b:	eb 0b                	jmp    801054a8 <sys_unlink+0x138>
8010549d:	8d 76 00             	lea    0x0(%esi),%esi
801054a0:	83 c6 10             	add    $0x10,%esi
801054a3:	3b 73 58             	cmp    0x58(%ebx),%esi
801054a6:	73 82                	jae    8010542a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801054a8:	6a 10                	push   $0x10
801054aa:	56                   	push   %esi
801054ab:	57                   	push   %edi
801054ac:	53                   	push   %ebx
801054ad:	e8 5e c9 ff ff       	call   80101e10 <readi>
801054b2:	83 c4 10             	add    $0x10,%esp
801054b5:	83 f8 10             	cmp    $0x10,%eax
801054b8:	75 56                	jne    80105510 <sys_unlink+0x1a0>
    if(de.inum != 0)
801054ba:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801054bf:	74 df                	je     801054a0 <sys_unlink+0x130>
    iunlockput(ip);
801054c1:	83 ec 0c             	sub    $0xc,%esp
801054c4:	53                   	push   %ebx
801054c5:	e8 c6 c8 ff ff       	call   80101d90 <iunlockput>
    goto bad;
801054ca:	83 c4 10             	add    $0x10,%esp
801054cd:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
801054d0:	83 ec 0c             	sub    $0xc,%esp
801054d3:	ff 75 b4             	push   -0x4c(%ebp)
801054d6:	e8 b5 c8 ff ff       	call   80101d90 <iunlockput>
  end_op();
801054db:	e8 30 dc ff ff       	call   80103110 <end_op>
  return -1;
801054e0:	83 c4 10             	add    $0x10,%esp
    return -1;
801054e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054e8:	eb 9c                	jmp    80105486 <sys_unlink+0x116>
801054ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
801054f0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801054f3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801054f6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801054fb:	50                   	push   %eax
801054fc:	e8 4f c5 ff ff       	call   80101a50 <iupdate>
80105501:	83 c4 10             	add    $0x10,%esp
80105504:	e9 53 ff ff ff       	jmp    8010545c <sys_unlink+0xec>
    end_op();
80105509:	e8 02 dc ff ff       	call   80103110 <end_op>
    return -1;
8010550e:	eb d3                	jmp    801054e3 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105510:	83 ec 0c             	sub    $0xc,%esp
80105513:	68 8d 78 10 80       	push   $0x8010788d
80105518:	e8 63 ae ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010551d:	83 ec 0c             	sub    $0xc,%esp
80105520:	68 9f 78 10 80       	push   $0x8010789f
80105525:	e8 56 ae ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010552a:	83 ec 0c             	sub    $0xc,%esp
8010552d:	68 7b 78 10 80       	push   $0x8010787b
80105532:	e8 49 ae ff ff       	call   80100380 <panic>
80105537:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010553e:	00 
8010553f:	90                   	nop

80105540 <sys_open>:

int
sys_open(void)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	57                   	push   %edi
80105544:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105545:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105548:	53                   	push   %ebx
80105549:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010554c:	50                   	push   %eax
8010554d:	6a 00                	push   $0x0
8010554f:	e8 1c f8 ff ff       	call   80104d70 <argstr>
80105554:	83 c4 10             	add    $0x10,%esp
80105557:	85 c0                	test   %eax,%eax
80105559:	0f 88 8e 00 00 00    	js     801055ed <sys_open+0xad>
8010555f:	83 ec 08             	sub    $0x8,%esp
80105562:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105565:	50                   	push   %eax
80105566:	6a 01                	push   $0x1
80105568:	e8 43 f7 ff ff       	call   80104cb0 <argint>
8010556d:	83 c4 10             	add    $0x10,%esp
80105570:	85 c0                	test   %eax,%eax
80105572:	78 79                	js     801055ed <sys_open+0xad>
    return -1;

  begin_op();
80105574:	e8 27 db ff ff       	call   801030a0 <begin_op>

  if(omode & O_CREATE){
80105579:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010557d:	75 79                	jne    801055f8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010557f:	83 ec 0c             	sub    $0xc,%esp
80105582:	ff 75 e0             	push   -0x20(%ebp)
80105585:	e8 56 ce ff ff       	call   801023e0 <namei>
8010558a:	83 c4 10             	add    $0x10,%esp
8010558d:	89 c6                	mov    %eax,%esi
8010558f:	85 c0                	test   %eax,%eax
80105591:	0f 84 7e 00 00 00    	je     80105615 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105597:	83 ec 0c             	sub    $0xc,%esp
8010559a:	50                   	push   %eax
8010559b:	e8 60 c5 ff ff       	call   80101b00 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801055a0:	83 c4 10             	add    $0x10,%esp
801055a3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801055a8:	0f 84 ba 00 00 00    	je     80105668 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801055ae:	e8 fd bb ff ff       	call   801011b0 <filealloc>
801055b3:	89 c7                	mov    %eax,%edi
801055b5:	85 c0                	test   %eax,%eax
801055b7:	74 23                	je     801055dc <sys_open+0x9c>
  struct proc *curproc = myproc();
801055b9:	e8 02 e7 ff ff       	call   80103cc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055be:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801055c0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801055c4:	85 d2                	test   %edx,%edx
801055c6:	74 58                	je     80105620 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
801055c8:	83 c3 01             	add    $0x1,%ebx
801055cb:	83 fb 10             	cmp    $0x10,%ebx
801055ce:	75 f0                	jne    801055c0 <sys_open+0x80>
    if(f)
      fileclose(f);
801055d0:	83 ec 0c             	sub    $0xc,%esp
801055d3:	57                   	push   %edi
801055d4:	e8 97 bc ff ff       	call   80101270 <fileclose>
801055d9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801055dc:	83 ec 0c             	sub    $0xc,%esp
801055df:	56                   	push   %esi
801055e0:	e8 ab c7 ff ff       	call   80101d90 <iunlockput>
    end_op();
801055e5:	e8 26 db ff ff       	call   80103110 <end_op>
    return -1;
801055ea:	83 c4 10             	add    $0x10,%esp
    return -1;
801055ed:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801055f2:	eb 65                	jmp    80105659 <sys_open+0x119>
801055f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801055f8:	83 ec 0c             	sub    $0xc,%esp
801055fb:	31 c9                	xor    %ecx,%ecx
801055fd:	ba 02 00 00 00       	mov    $0x2,%edx
80105602:	6a 00                	push   $0x0
80105604:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105607:	e8 54 f8 ff ff       	call   80104e60 <create>
    if(ip == 0){
8010560c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010560f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105611:	85 c0                	test   %eax,%eax
80105613:	75 99                	jne    801055ae <sys_open+0x6e>
      end_op();
80105615:	e8 f6 da ff ff       	call   80103110 <end_op>
      return -1;
8010561a:	eb d1                	jmp    801055ed <sys_open+0xad>
8010561c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105620:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105623:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105627:	56                   	push   %esi
80105628:	e8 b3 c5 ff ff       	call   80101be0 <iunlock>
  end_op();
8010562d:	e8 de da ff ff       	call   80103110 <end_op>

  f->type = FD_INODE;
80105632:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105638:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010563b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010563e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105641:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105643:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010564a:	f7 d0                	not    %eax
8010564c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010564f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105652:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105655:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105659:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010565c:	89 d8                	mov    %ebx,%eax
8010565e:	5b                   	pop    %ebx
8010565f:	5e                   	pop    %esi
80105660:	5f                   	pop    %edi
80105661:	5d                   	pop    %ebp
80105662:	c3                   	ret
80105663:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105668:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010566b:	85 c9                	test   %ecx,%ecx
8010566d:	0f 84 3b ff ff ff    	je     801055ae <sys_open+0x6e>
80105673:	e9 64 ff ff ff       	jmp    801055dc <sys_open+0x9c>
80105678:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010567f:	00 

80105680 <sys_mkdir>:

int
sys_mkdir(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105686:	e8 15 da ff ff       	call   801030a0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010568b:	83 ec 08             	sub    $0x8,%esp
8010568e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105691:	50                   	push   %eax
80105692:	6a 00                	push   $0x0
80105694:	e8 d7 f6 ff ff       	call   80104d70 <argstr>
80105699:	83 c4 10             	add    $0x10,%esp
8010569c:	85 c0                	test   %eax,%eax
8010569e:	78 30                	js     801056d0 <sys_mkdir+0x50>
801056a0:	83 ec 0c             	sub    $0xc,%esp
801056a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056a6:	31 c9                	xor    %ecx,%ecx
801056a8:	ba 01 00 00 00       	mov    $0x1,%edx
801056ad:	6a 00                	push   $0x0
801056af:	e8 ac f7 ff ff       	call   80104e60 <create>
801056b4:	83 c4 10             	add    $0x10,%esp
801056b7:	85 c0                	test   %eax,%eax
801056b9:	74 15                	je     801056d0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801056bb:	83 ec 0c             	sub    $0xc,%esp
801056be:	50                   	push   %eax
801056bf:	e8 cc c6 ff ff       	call   80101d90 <iunlockput>
  end_op();
801056c4:	e8 47 da ff ff       	call   80103110 <end_op>
  return 0;
801056c9:	83 c4 10             	add    $0x10,%esp
801056cc:	31 c0                	xor    %eax,%eax
}
801056ce:	c9                   	leave
801056cf:	c3                   	ret
    end_op();
801056d0:	e8 3b da ff ff       	call   80103110 <end_op>
    return -1;
801056d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056da:	c9                   	leave
801056db:	c3                   	ret
801056dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056e0 <sys_mknod>:

int
sys_mknod(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801056e6:	e8 b5 d9 ff ff       	call   801030a0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801056eb:	83 ec 08             	sub    $0x8,%esp
801056ee:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056f1:	50                   	push   %eax
801056f2:	6a 00                	push   $0x0
801056f4:	e8 77 f6 ff ff       	call   80104d70 <argstr>
801056f9:	83 c4 10             	add    $0x10,%esp
801056fc:	85 c0                	test   %eax,%eax
801056fe:	78 60                	js     80105760 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105700:	83 ec 08             	sub    $0x8,%esp
80105703:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105706:	50                   	push   %eax
80105707:	6a 01                	push   $0x1
80105709:	e8 a2 f5 ff ff       	call   80104cb0 <argint>
  if((argstr(0, &path)) < 0 ||
8010570e:	83 c4 10             	add    $0x10,%esp
80105711:	85 c0                	test   %eax,%eax
80105713:	78 4b                	js     80105760 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105715:	83 ec 08             	sub    $0x8,%esp
80105718:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010571b:	50                   	push   %eax
8010571c:	6a 02                	push   $0x2
8010571e:	e8 8d f5 ff ff       	call   80104cb0 <argint>
     argint(1, &major) < 0 ||
80105723:	83 c4 10             	add    $0x10,%esp
80105726:	85 c0                	test   %eax,%eax
80105728:	78 36                	js     80105760 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010572a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010572e:	83 ec 0c             	sub    $0xc,%esp
80105731:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105735:	ba 03 00 00 00       	mov    $0x3,%edx
8010573a:	50                   	push   %eax
8010573b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010573e:	e8 1d f7 ff ff       	call   80104e60 <create>
     argint(2, &minor) < 0 ||
80105743:	83 c4 10             	add    $0x10,%esp
80105746:	85 c0                	test   %eax,%eax
80105748:	74 16                	je     80105760 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010574a:	83 ec 0c             	sub    $0xc,%esp
8010574d:	50                   	push   %eax
8010574e:	e8 3d c6 ff ff       	call   80101d90 <iunlockput>
  end_op();
80105753:	e8 b8 d9 ff ff       	call   80103110 <end_op>
  return 0;
80105758:	83 c4 10             	add    $0x10,%esp
8010575b:	31 c0                	xor    %eax,%eax
}
8010575d:	c9                   	leave
8010575e:	c3                   	ret
8010575f:	90                   	nop
    end_op();
80105760:	e8 ab d9 ff ff       	call   80103110 <end_op>
    return -1;
80105765:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010576a:	c9                   	leave
8010576b:	c3                   	ret
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105770 <sys_chdir>:

int
sys_chdir(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	56                   	push   %esi
80105774:	53                   	push   %ebx
80105775:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105778:	e8 43 e5 ff ff       	call   80103cc0 <myproc>
8010577d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010577f:	e8 1c d9 ff ff       	call   801030a0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105784:	83 ec 08             	sub    $0x8,%esp
80105787:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010578a:	50                   	push   %eax
8010578b:	6a 00                	push   $0x0
8010578d:	e8 de f5 ff ff       	call   80104d70 <argstr>
80105792:	83 c4 10             	add    $0x10,%esp
80105795:	85 c0                	test   %eax,%eax
80105797:	78 77                	js     80105810 <sys_chdir+0xa0>
80105799:	83 ec 0c             	sub    $0xc,%esp
8010579c:	ff 75 f4             	push   -0xc(%ebp)
8010579f:	e8 3c cc ff ff       	call   801023e0 <namei>
801057a4:	83 c4 10             	add    $0x10,%esp
801057a7:	89 c3                	mov    %eax,%ebx
801057a9:	85 c0                	test   %eax,%eax
801057ab:	74 63                	je     80105810 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801057ad:	83 ec 0c             	sub    $0xc,%esp
801057b0:	50                   	push   %eax
801057b1:	e8 4a c3 ff ff       	call   80101b00 <ilock>
  if(ip->type != T_DIR){
801057b6:	83 c4 10             	add    $0x10,%esp
801057b9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057be:	75 30                	jne    801057f0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801057c0:	83 ec 0c             	sub    $0xc,%esp
801057c3:	53                   	push   %ebx
801057c4:	e8 17 c4 ff ff       	call   80101be0 <iunlock>
  iput(curproc->cwd);
801057c9:	58                   	pop    %eax
801057ca:	ff 76 68             	push   0x68(%esi)
801057cd:	e8 5e c4 ff ff       	call   80101c30 <iput>
  end_op();
801057d2:	e8 39 d9 ff ff       	call   80103110 <end_op>
  curproc->cwd = ip;
801057d7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801057da:	83 c4 10             	add    $0x10,%esp
801057dd:	31 c0                	xor    %eax,%eax
}
801057df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057e2:	5b                   	pop    %ebx
801057e3:	5e                   	pop    %esi
801057e4:	5d                   	pop    %ebp
801057e5:	c3                   	ret
801057e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057ed:	00 
801057ee:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801057f0:	83 ec 0c             	sub    $0xc,%esp
801057f3:	53                   	push   %ebx
801057f4:	e8 97 c5 ff ff       	call   80101d90 <iunlockput>
    end_op();
801057f9:	e8 12 d9 ff ff       	call   80103110 <end_op>
    return -1;
801057fe:	83 c4 10             	add    $0x10,%esp
    return -1;
80105801:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105806:	eb d7                	jmp    801057df <sys_chdir+0x6f>
80105808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010580f:	00 
    end_op();
80105810:	e8 fb d8 ff ff       	call   80103110 <end_op>
    return -1;
80105815:	eb ea                	jmp    80105801 <sys_chdir+0x91>
80105817:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010581e:	00 
8010581f:	90                   	nop

80105820 <sys_exec>:

int
sys_exec(void)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	57                   	push   %edi
80105824:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105825:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010582b:	53                   	push   %ebx
8010582c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105832:	50                   	push   %eax
80105833:	6a 00                	push   $0x0
80105835:	e8 36 f5 ff ff       	call   80104d70 <argstr>
8010583a:	83 c4 10             	add    $0x10,%esp
8010583d:	85 c0                	test   %eax,%eax
8010583f:	0f 88 87 00 00 00    	js     801058cc <sys_exec+0xac>
80105845:	83 ec 08             	sub    $0x8,%esp
80105848:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010584e:	50                   	push   %eax
8010584f:	6a 01                	push   $0x1
80105851:	e8 5a f4 ff ff       	call   80104cb0 <argint>
80105856:	83 c4 10             	add    $0x10,%esp
80105859:	85 c0                	test   %eax,%eax
8010585b:	78 6f                	js     801058cc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010585d:	83 ec 04             	sub    $0x4,%esp
80105860:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105866:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105868:	68 80 00 00 00       	push   $0x80
8010586d:	6a 00                	push   $0x0
8010586f:	56                   	push   %esi
80105870:	e8 8b f1 ff ff       	call   80104a00 <memset>
80105875:	83 c4 10             	add    $0x10,%esp
80105878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010587f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105880:	83 ec 08             	sub    $0x8,%esp
80105883:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105889:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105890:	50                   	push   %eax
80105891:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105897:	01 f8                	add    %edi,%eax
80105899:	50                   	push   %eax
8010589a:	e8 81 f3 ff ff       	call   80104c20 <fetchint>
8010589f:	83 c4 10             	add    $0x10,%esp
801058a2:	85 c0                	test   %eax,%eax
801058a4:	78 26                	js     801058cc <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801058a6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801058ac:	85 c0                	test   %eax,%eax
801058ae:	74 30                	je     801058e0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801058b0:	83 ec 08             	sub    $0x8,%esp
801058b3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801058b6:	52                   	push   %edx
801058b7:	50                   	push   %eax
801058b8:	e8 a3 f3 ff ff       	call   80104c60 <fetchstr>
801058bd:	83 c4 10             	add    $0x10,%esp
801058c0:	85 c0                	test   %eax,%eax
801058c2:	78 08                	js     801058cc <sys_exec+0xac>
  for(i=0;; i++){
801058c4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801058c7:	83 fb 20             	cmp    $0x20,%ebx
801058ca:	75 b4                	jne    80105880 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801058cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801058cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058d4:	5b                   	pop    %ebx
801058d5:	5e                   	pop    %esi
801058d6:	5f                   	pop    %edi
801058d7:	5d                   	pop    %ebp
801058d8:	c3                   	ret
801058d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801058e0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801058e7:	00 00 00 00 
  return exec(path, argv);
801058eb:	83 ec 08             	sub    $0x8,%esp
801058ee:	56                   	push   %esi
801058ef:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801058f5:	e8 16 b5 ff ff       	call   80100e10 <exec>
801058fa:	83 c4 10             	add    $0x10,%esp
}
801058fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105900:	5b                   	pop    %ebx
80105901:	5e                   	pop    %esi
80105902:	5f                   	pop    %edi
80105903:	5d                   	pop    %ebp
80105904:	c3                   	ret
80105905:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010590c:	00 
8010590d:	8d 76 00             	lea    0x0(%esi),%esi

80105910 <sys_pipe>:

int
sys_pipe(void)
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	57                   	push   %edi
80105914:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105915:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105918:	53                   	push   %ebx
80105919:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010591c:	6a 08                	push   $0x8
8010591e:	50                   	push   %eax
8010591f:	6a 00                	push   $0x0
80105921:	e8 da f3 ff ff       	call   80104d00 <argptr>
80105926:	83 c4 10             	add    $0x10,%esp
80105929:	85 c0                	test   %eax,%eax
8010592b:	0f 88 8b 00 00 00    	js     801059bc <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105931:	83 ec 08             	sub    $0x8,%esp
80105934:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105937:	50                   	push   %eax
80105938:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010593b:	50                   	push   %eax
8010593c:	e8 2f de ff ff       	call   80103770 <pipealloc>
80105941:	83 c4 10             	add    $0x10,%esp
80105944:	85 c0                	test   %eax,%eax
80105946:	78 74                	js     801059bc <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105948:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010594b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010594d:	e8 6e e3 ff ff       	call   80103cc0 <myproc>
    if(curproc->ofile[fd] == 0){
80105952:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105956:	85 f6                	test   %esi,%esi
80105958:	74 16                	je     80105970 <sys_pipe+0x60>
8010595a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105960:	83 c3 01             	add    $0x1,%ebx
80105963:	83 fb 10             	cmp    $0x10,%ebx
80105966:	74 3d                	je     801059a5 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80105968:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010596c:	85 f6                	test   %esi,%esi
8010596e:	75 f0                	jne    80105960 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105970:	8d 73 08             	lea    0x8(%ebx),%esi
80105973:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105977:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010597a:	e8 41 e3 ff ff       	call   80103cc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010597f:	31 d2                	xor    %edx,%edx
80105981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105988:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010598c:	85 c9                	test   %ecx,%ecx
8010598e:	74 38                	je     801059c8 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80105990:	83 c2 01             	add    $0x1,%edx
80105993:	83 fa 10             	cmp    $0x10,%edx
80105996:	75 f0                	jne    80105988 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105998:	e8 23 e3 ff ff       	call   80103cc0 <myproc>
8010599d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801059a4:	00 
    fileclose(rf);
801059a5:	83 ec 0c             	sub    $0xc,%esp
801059a8:	ff 75 e0             	push   -0x20(%ebp)
801059ab:	e8 c0 b8 ff ff       	call   80101270 <fileclose>
    fileclose(wf);
801059b0:	58                   	pop    %eax
801059b1:	ff 75 e4             	push   -0x1c(%ebp)
801059b4:	e8 b7 b8 ff ff       	call   80101270 <fileclose>
    return -1;
801059b9:	83 c4 10             	add    $0x10,%esp
    return -1;
801059bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059c1:	eb 16                	jmp    801059d9 <sys_pipe+0xc9>
801059c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
801059c8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801059cc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801059cf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801059d1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801059d4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801059d7:	31 c0                	xor    %eax,%eax
}
801059d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059dc:	5b                   	pop    %ebx
801059dd:	5e                   	pop    %esi
801059de:	5f                   	pop    %edi
801059df:	5d                   	pop    %ebp
801059e0:	c3                   	ret
801059e1:	66 90                	xchg   %ax,%ax
801059e3:	66 90                	xchg   %ax,%ax
801059e5:	66 90                	xchg   %ax,%ax
801059e7:	66 90                	xchg   %ax,%ax
801059e9:	66 90                	xchg   %ax,%ax
801059eb:	66 90                	xchg   %ax,%ax
801059ed:	66 90                	xchg   %ax,%ax
801059ef:	90                   	nop

801059f0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801059f0:	e9 6b e4 ff ff       	jmp    80103e60 <fork>
801059f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059fc:	00 
801059fd:	8d 76 00             	lea    0x0(%esi),%esi

80105a00 <sys_exit>:
}

int
sys_exit(void)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	83 ec 08             	sub    $0x8,%esp
  exit();
80105a06:	e8 c5 e6 ff ff       	call   801040d0 <exit>
  return 0;  // not reached
}
80105a0b:	31 c0                	xor    %eax,%eax
80105a0d:	c9                   	leave
80105a0e:	c3                   	ret
80105a0f:	90                   	nop

80105a10 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105a10:	e9 eb e7 ff ff       	jmp    80104200 <wait>
80105a15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a1c:	00 
80105a1d:	8d 76 00             	lea    0x0(%esi),%esi

80105a20 <sys_kill>:
}

int
sys_kill(void)
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105a26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a29:	50                   	push   %eax
80105a2a:	6a 00                	push   $0x0
80105a2c:	e8 7f f2 ff ff       	call   80104cb0 <argint>
80105a31:	83 c4 10             	add    $0x10,%esp
80105a34:	85 c0                	test   %eax,%eax
80105a36:	78 18                	js     80105a50 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105a38:	83 ec 0c             	sub    $0xc,%esp
80105a3b:	ff 75 f4             	push   -0xc(%ebp)
80105a3e:	e8 5d ea ff ff       	call   801044a0 <kill>
80105a43:	83 c4 10             	add    $0x10,%esp
}
80105a46:	c9                   	leave
80105a47:	c3                   	ret
80105a48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a4f:	00 
80105a50:	c9                   	leave
    return -1;
80105a51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a56:	c3                   	ret
80105a57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a5e:	00 
80105a5f:	90                   	nop

80105a60 <sys_getpid>:

int
sys_getpid(void)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105a66:	e8 55 e2 ff ff       	call   80103cc0 <myproc>
80105a6b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105a6e:	c9                   	leave
80105a6f:	c3                   	ret

80105a70 <sys_sbrk>:

int
sys_sbrk(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105a74:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a77:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a7a:	50                   	push   %eax
80105a7b:	6a 00                	push   $0x0
80105a7d:	e8 2e f2 ff ff       	call   80104cb0 <argint>
80105a82:	83 c4 10             	add    $0x10,%esp
80105a85:	85 c0                	test   %eax,%eax
80105a87:	78 27                	js     80105ab0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105a89:	e8 32 e2 ff ff       	call   80103cc0 <myproc>
  if(growproc(n) < 0)
80105a8e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105a91:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105a93:	ff 75 f4             	push   -0xc(%ebp)
80105a96:	e8 45 e3 ff ff       	call   80103de0 <growproc>
80105a9b:	83 c4 10             	add    $0x10,%esp
80105a9e:	85 c0                	test   %eax,%eax
80105aa0:	78 0e                	js     80105ab0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105aa2:	89 d8                	mov    %ebx,%eax
80105aa4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105aa7:	c9                   	leave
80105aa8:	c3                   	ret
80105aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ab0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ab5:	eb eb                	jmp    80105aa2 <sys_sbrk+0x32>
80105ab7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105abe:	00 
80105abf:	90                   	nop

80105ac0 <sys_sleep>:

int
sys_sleep(void)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105ac4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105ac7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105aca:	50                   	push   %eax
80105acb:	6a 00                	push   $0x0
80105acd:	e8 de f1 ff ff       	call   80104cb0 <argint>
80105ad2:	83 c4 10             	add    $0x10,%esp
80105ad5:	85 c0                	test   %eax,%eax
80105ad7:	78 64                	js     80105b3d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105ad9:	83 ec 0c             	sub    $0xc,%esp
80105adc:	68 a0 3c 11 80       	push   $0x80113ca0
80105ae1:	e8 1a ee ff ff       	call   80104900 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105ae6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105ae9:	8b 1d 80 3c 11 80    	mov    0x80113c80,%ebx
  while(ticks - ticks0 < n){
80105aef:	83 c4 10             	add    $0x10,%esp
80105af2:	85 d2                	test   %edx,%edx
80105af4:	75 2b                	jne    80105b21 <sys_sleep+0x61>
80105af6:	eb 58                	jmp    80105b50 <sys_sleep+0x90>
80105af8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105aff:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105b00:	83 ec 08             	sub    $0x8,%esp
80105b03:	68 a0 3c 11 80       	push   $0x80113ca0
80105b08:	68 80 3c 11 80       	push   $0x80113c80
80105b0d:	e8 6e e8 ff ff       	call   80104380 <sleep>
  while(ticks - ticks0 < n){
80105b12:	a1 80 3c 11 80       	mov    0x80113c80,%eax
80105b17:	83 c4 10             	add    $0x10,%esp
80105b1a:	29 d8                	sub    %ebx,%eax
80105b1c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105b1f:	73 2f                	jae    80105b50 <sys_sleep+0x90>
    if(myproc()->killed){
80105b21:	e8 9a e1 ff ff       	call   80103cc0 <myproc>
80105b26:	8b 40 24             	mov    0x24(%eax),%eax
80105b29:	85 c0                	test   %eax,%eax
80105b2b:	74 d3                	je     80105b00 <sys_sleep+0x40>
      release(&tickslock);
80105b2d:	83 ec 0c             	sub    $0xc,%esp
80105b30:	68 a0 3c 11 80       	push   $0x80113ca0
80105b35:	e8 66 ed ff ff       	call   801048a0 <release>
      return -1;
80105b3a:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
80105b3d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b45:	c9                   	leave
80105b46:	c3                   	ret
80105b47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b4e:	00 
80105b4f:	90                   	nop
  release(&tickslock);
80105b50:	83 ec 0c             	sub    $0xc,%esp
80105b53:	68 a0 3c 11 80       	push   $0x80113ca0
80105b58:	e8 43 ed ff ff       	call   801048a0 <release>
}
80105b5d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80105b60:	83 c4 10             	add    $0x10,%esp
80105b63:	31 c0                	xor    %eax,%eax
}
80105b65:	c9                   	leave
80105b66:	c3                   	ret
80105b67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b6e:	00 
80105b6f:	90                   	nop

80105b70 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	53                   	push   %ebx
80105b74:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105b77:	68 a0 3c 11 80       	push   $0x80113ca0
80105b7c:	e8 7f ed ff ff       	call   80104900 <acquire>
  xticks = ticks;
80105b81:	8b 1d 80 3c 11 80    	mov    0x80113c80,%ebx
  release(&tickslock);
80105b87:	c7 04 24 a0 3c 11 80 	movl   $0x80113ca0,(%esp)
80105b8e:	e8 0d ed ff ff       	call   801048a0 <release>
  return xticks;
}
80105b93:	89 d8                	mov    %ebx,%eax
80105b95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b98:	c9                   	leave
80105b99:	c3                   	ret

80105b9a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105b9a:	1e                   	push   %ds
  pushl %es
80105b9b:	06                   	push   %es
  pushl %fs
80105b9c:	0f a0                	push   %fs
  pushl %gs
80105b9e:	0f a8                	push   %gs
  pushal
80105ba0:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105ba1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105ba5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105ba7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105ba9:	54                   	push   %esp
  call trap
80105baa:	e8 c1 00 00 00       	call   80105c70 <trap>
  addl $4, %esp
80105baf:	83 c4 04             	add    $0x4,%esp

80105bb2 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105bb2:	61                   	popa
  popl %gs
80105bb3:	0f a9                	pop    %gs
  popl %fs
80105bb5:	0f a1                	pop    %fs
  popl %es
80105bb7:	07                   	pop    %es
  popl %ds
80105bb8:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105bb9:	83 c4 08             	add    $0x8,%esp
  iret
80105bbc:	cf                   	iret
80105bbd:	66 90                	xchg   %ax,%ax
80105bbf:	90                   	nop

80105bc0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105bc0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105bc1:	31 c0                	xor    %eax,%eax
{
80105bc3:	89 e5                	mov    %esp,%ebp
80105bc5:	83 ec 08             	sub    $0x8,%esp
80105bc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bcf:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105bd0:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105bd7:	c7 04 c5 e2 3c 11 80 	movl   $0x8e000008,-0x7feec31e(,%eax,8)
80105bde:	08 00 00 8e 
80105be2:	66 89 14 c5 e0 3c 11 	mov    %dx,-0x7feec320(,%eax,8)
80105be9:	80 
80105bea:	c1 ea 10             	shr    $0x10,%edx
80105bed:	66 89 14 c5 e6 3c 11 	mov    %dx,-0x7feec31a(,%eax,8)
80105bf4:	80 
  for(i = 0; i < 256; i++)
80105bf5:	83 c0 01             	add    $0x1,%eax
80105bf8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105bfd:	75 d1                	jne    80105bd0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105bff:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c02:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105c07:	c7 05 e2 3e 11 80 08 	movl   $0xef000008,0x80113ee2
80105c0e:	00 00 ef 
  initlock(&tickslock, "time");
80105c11:	68 ae 78 10 80       	push   $0x801078ae
80105c16:	68 a0 3c 11 80       	push   $0x80113ca0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c1b:	66 a3 e0 3e 11 80    	mov    %ax,0x80113ee0
80105c21:	c1 e8 10             	shr    $0x10,%eax
80105c24:	66 a3 e6 3e 11 80    	mov    %ax,0x80113ee6
  initlock(&tickslock, "time");
80105c2a:	e8 e1 ea ff ff       	call   80104710 <initlock>
}
80105c2f:	83 c4 10             	add    $0x10,%esp
80105c32:	c9                   	leave
80105c33:	c3                   	ret
80105c34:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c3b:	00 
80105c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c40 <idtinit>:

void
idtinit(void)
{
80105c40:	55                   	push   %ebp
  pd[0] = size-1;
80105c41:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105c46:	89 e5                	mov    %esp,%ebp
80105c48:	83 ec 10             	sub    $0x10,%esp
80105c4b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105c4f:	b8 e0 3c 11 80       	mov    $0x80113ce0,%eax
80105c54:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105c58:	c1 e8 10             	shr    $0x10,%eax
80105c5b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105c5f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105c62:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105c65:	c9                   	leave
80105c66:	c3                   	ret
80105c67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c6e:	00 
80105c6f:	90                   	nop

80105c70 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	57                   	push   %edi
80105c74:	56                   	push   %esi
80105c75:	53                   	push   %ebx
80105c76:	83 ec 1c             	sub    $0x1c,%esp
80105c79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105c7c:	8b 43 30             	mov    0x30(%ebx),%eax
80105c7f:	83 f8 40             	cmp    $0x40,%eax
80105c82:	0f 84 58 01 00 00    	je     80105de0 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105c88:	83 e8 20             	sub    $0x20,%eax
80105c8b:	83 f8 1f             	cmp    $0x1f,%eax
80105c8e:	0f 87 7c 00 00 00    	ja     80105d10 <trap+0xa0>
80105c94:	ff 24 85 58 7e 10 80 	jmp    *-0x7fef81a8(,%eax,4)
80105c9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105ca0:	e8 eb c8 ff ff       	call   80102590 <ideintr>
    lapiceoi();
80105ca5:	e8 a6 cf ff ff       	call   80102c50 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105caa:	e8 11 e0 ff ff       	call   80103cc0 <myproc>
80105caf:	85 c0                	test   %eax,%eax
80105cb1:	74 1a                	je     80105ccd <trap+0x5d>
80105cb3:	e8 08 e0 ff ff       	call   80103cc0 <myproc>
80105cb8:	8b 50 24             	mov    0x24(%eax),%edx
80105cbb:	85 d2                	test   %edx,%edx
80105cbd:	74 0e                	je     80105ccd <trap+0x5d>
80105cbf:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105cc3:	f7 d0                	not    %eax
80105cc5:	a8 03                	test   $0x3,%al
80105cc7:	0f 84 db 01 00 00    	je     80105ea8 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105ccd:	e8 ee df ff ff       	call   80103cc0 <myproc>
80105cd2:	85 c0                	test   %eax,%eax
80105cd4:	74 0f                	je     80105ce5 <trap+0x75>
80105cd6:	e8 e5 df ff ff       	call   80103cc0 <myproc>
80105cdb:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105cdf:	0f 84 ab 00 00 00    	je     80105d90 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ce5:	e8 d6 df ff ff       	call   80103cc0 <myproc>
80105cea:	85 c0                	test   %eax,%eax
80105cec:	74 1a                	je     80105d08 <trap+0x98>
80105cee:	e8 cd df ff ff       	call   80103cc0 <myproc>
80105cf3:	8b 40 24             	mov    0x24(%eax),%eax
80105cf6:	85 c0                	test   %eax,%eax
80105cf8:	74 0e                	je     80105d08 <trap+0x98>
80105cfa:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105cfe:	f7 d0                	not    %eax
80105d00:	a8 03                	test   $0x3,%al
80105d02:	0f 84 05 01 00 00    	je     80105e0d <trap+0x19d>
    exit();
}
80105d08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d0b:	5b                   	pop    %ebx
80105d0c:	5e                   	pop    %esi
80105d0d:	5f                   	pop    %edi
80105d0e:	5d                   	pop    %ebp
80105d0f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80105d10:	e8 ab df ff ff       	call   80103cc0 <myproc>
80105d15:	8b 7b 38             	mov    0x38(%ebx),%edi
80105d18:	85 c0                	test   %eax,%eax
80105d1a:	0f 84 a2 01 00 00    	je     80105ec2 <trap+0x252>
80105d20:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105d24:	0f 84 98 01 00 00    	je     80105ec2 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105d2a:	0f 20 d1             	mov    %cr2,%ecx
80105d2d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d30:	e8 6b df ff ff       	call   80103ca0 <cpuid>
80105d35:	8b 73 30             	mov    0x30(%ebx),%esi
80105d38:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105d3b:	8b 43 34             	mov    0x34(%ebx),%eax
80105d3e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105d41:	e8 7a df ff ff       	call   80103cc0 <myproc>
80105d46:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105d49:	e8 72 df ff ff       	call   80103cc0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d4e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105d51:	51                   	push   %ecx
80105d52:	57                   	push   %edi
80105d53:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105d56:	52                   	push   %edx
80105d57:	ff 75 e4             	push   -0x1c(%ebp)
80105d5a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105d5b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105d5e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d61:	56                   	push   %esi
80105d62:	ff 70 10             	push   0x10(%eax)
80105d65:	68 54 7b 10 80       	push   $0x80107b54
80105d6a:	e8 f1 a8 ff ff       	call   80100660 <cprintf>
    myproc()->killed = 1;
80105d6f:	83 c4 20             	add    $0x20,%esp
80105d72:	e8 49 df ff ff       	call   80103cc0 <myproc>
80105d77:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d7e:	e8 3d df ff ff       	call   80103cc0 <myproc>
80105d83:	85 c0                	test   %eax,%eax
80105d85:	0f 85 28 ff ff ff    	jne    80105cb3 <trap+0x43>
80105d8b:	e9 3d ff ff ff       	jmp    80105ccd <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80105d90:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105d94:	0f 85 4b ff ff ff    	jne    80105ce5 <trap+0x75>
    yield();
80105d9a:	e8 91 e5 ff ff       	call   80104330 <yield>
80105d9f:	e9 41 ff ff ff       	jmp    80105ce5 <trap+0x75>
80105da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105da8:	8b 7b 38             	mov    0x38(%ebx),%edi
80105dab:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105daf:	e8 ec de ff ff       	call   80103ca0 <cpuid>
80105db4:	57                   	push   %edi
80105db5:	56                   	push   %esi
80105db6:	50                   	push   %eax
80105db7:	68 fc 7a 10 80       	push   $0x80107afc
80105dbc:	e8 9f a8 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105dc1:	e8 8a ce ff ff       	call   80102c50 <lapiceoi>
    break;
80105dc6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105dc9:	e8 f2 de ff ff       	call   80103cc0 <myproc>
80105dce:	85 c0                	test   %eax,%eax
80105dd0:	0f 85 dd fe ff ff    	jne    80105cb3 <trap+0x43>
80105dd6:	e9 f2 fe ff ff       	jmp    80105ccd <trap+0x5d>
80105ddb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105de0:	e8 db de ff ff       	call   80103cc0 <myproc>
80105de5:	8b 70 24             	mov    0x24(%eax),%esi
80105de8:	85 f6                	test   %esi,%esi
80105dea:	0f 85 c8 00 00 00    	jne    80105eb8 <trap+0x248>
    myproc()->tf = tf;
80105df0:	e8 cb de ff ff       	call   80103cc0 <myproc>
80105df5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105df8:	e8 f3 ef ff ff       	call   80104df0 <syscall>
    if(myproc()->killed)
80105dfd:	e8 be de ff ff       	call   80103cc0 <myproc>
80105e02:	8b 48 24             	mov    0x24(%eax),%ecx
80105e05:	85 c9                	test   %ecx,%ecx
80105e07:	0f 84 fb fe ff ff    	je     80105d08 <trap+0x98>
}
80105e0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e10:	5b                   	pop    %ebx
80105e11:	5e                   	pop    %esi
80105e12:	5f                   	pop    %edi
80105e13:	5d                   	pop    %ebp
      exit();
80105e14:	e9 b7 e2 ff ff       	jmp    801040d0 <exit>
80105e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105e20:	e8 4b 02 00 00       	call   80106070 <uartintr>
    lapiceoi();
80105e25:	e8 26 ce ff ff       	call   80102c50 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e2a:	e8 91 de ff ff       	call   80103cc0 <myproc>
80105e2f:	85 c0                	test   %eax,%eax
80105e31:	0f 85 7c fe ff ff    	jne    80105cb3 <trap+0x43>
80105e37:	e9 91 fe ff ff       	jmp    80105ccd <trap+0x5d>
80105e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105e40:	e8 db cc ff ff       	call   80102b20 <kbdintr>
    lapiceoi();
80105e45:	e8 06 ce ff ff       	call   80102c50 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e4a:	e8 71 de ff ff       	call   80103cc0 <myproc>
80105e4f:	85 c0                	test   %eax,%eax
80105e51:	0f 85 5c fe ff ff    	jne    80105cb3 <trap+0x43>
80105e57:	e9 71 fe ff ff       	jmp    80105ccd <trap+0x5d>
80105e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105e60:	e8 3b de ff ff       	call   80103ca0 <cpuid>
80105e65:	85 c0                	test   %eax,%eax
80105e67:	0f 85 38 fe ff ff    	jne    80105ca5 <trap+0x35>
      acquire(&tickslock);
80105e6d:	83 ec 0c             	sub    $0xc,%esp
80105e70:	68 a0 3c 11 80       	push   $0x80113ca0
80105e75:	e8 86 ea ff ff       	call   80104900 <acquire>
      ticks++;
80105e7a:	83 05 80 3c 11 80 01 	addl   $0x1,0x80113c80
      wakeup(&ticks);
80105e81:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105e88:	e8 b3 e5 ff ff       	call   80104440 <wakeup>
      release(&tickslock);
80105e8d:	c7 04 24 a0 3c 11 80 	movl   $0x80113ca0,(%esp)
80105e94:	e8 07 ea ff ff       	call   801048a0 <release>
80105e99:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105e9c:	e9 04 fe ff ff       	jmp    80105ca5 <trap+0x35>
80105ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105ea8:	e8 23 e2 ff ff       	call   801040d0 <exit>
80105ead:	e9 1b fe ff ff       	jmp    80105ccd <trap+0x5d>
80105eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105eb8:	e8 13 e2 ff ff       	call   801040d0 <exit>
80105ebd:	e9 2e ff ff ff       	jmp    80105df0 <trap+0x180>
80105ec2:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105ec5:	e8 d6 dd ff ff       	call   80103ca0 <cpuid>
80105eca:	83 ec 0c             	sub    $0xc,%esp
80105ecd:	56                   	push   %esi
80105ece:	57                   	push   %edi
80105ecf:	50                   	push   %eax
80105ed0:	ff 73 30             	push   0x30(%ebx)
80105ed3:	68 20 7b 10 80       	push   $0x80107b20
80105ed8:	e8 83 a7 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105edd:	83 c4 14             	add    $0x14,%esp
80105ee0:	68 b3 78 10 80       	push   $0x801078b3
80105ee5:	e8 96 a4 ff ff       	call   80100380 <panic>
80105eea:	66 90                	xchg   %ax,%ax
80105eec:	66 90                	xchg   %ax,%ax
80105eee:	66 90                	xchg   %ax,%ax

80105ef0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105ef0:	a1 e0 44 11 80       	mov    0x801144e0,%eax
80105ef5:	85 c0                	test   %eax,%eax
80105ef7:	74 17                	je     80105f10 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105ef9:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105efe:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105eff:	a8 01                	test   $0x1,%al
80105f01:	74 0d                	je     80105f10 <uartgetc+0x20>
80105f03:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f08:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105f09:	0f b6 c0             	movzbl %al,%eax
80105f0c:	c3                   	ret
80105f0d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105f10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f15:	c3                   	ret
80105f16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f1d:	00 
80105f1e:	66 90                	xchg   %ax,%ax

80105f20 <uartinit>:
{
80105f20:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f21:	31 c9                	xor    %ecx,%ecx
80105f23:	89 c8                	mov    %ecx,%eax
80105f25:	89 e5                	mov    %esp,%ebp
80105f27:	57                   	push   %edi
80105f28:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105f2d:	56                   	push   %esi
80105f2e:	89 fa                	mov    %edi,%edx
80105f30:	53                   	push   %ebx
80105f31:	83 ec 1c             	sub    $0x1c,%esp
80105f34:	ee                   	out    %al,(%dx)
80105f35:	be fb 03 00 00       	mov    $0x3fb,%esi
80105f3a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105f3f:	89 f2                	mov    %esi,%edx
80105f41:	ee                   	out    %al,(%dx)
80105f42:	b8 0c 00 00 00       	mov    $0xc,%eax
80105f47:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f4c:	ee                   	out    %al,(%dx)
80105f4d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105f52:	89 c8                	mov    %ecx,%eax
80105f54:	89 da                	mov    %ebx,%edx
80105f56:	ee                   	out    %al,(%dx)
80105f57:	b8 03 00 00 00       	mov    $0x3,%eax
80105f5c:	89 f2                	mov    %esi,%edx
80105f5e:	ee                   	out    %al,(%dx)
80105f5f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105f64:	89 c8                	mov    %ecx,%eax
80105f66:	ee                   	out    %al,(%dx)
80105f67:	b8 01 00 00 00       	mov    $0x1,%eax
80105f6c:	89 da                	mov    %ebx,%edx
80105f6e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105f6f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105f74:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105f75:	3c ff                	cmp    $0xff,%al
80105f77:	0f 84 7c 00 00 00    	je     80105ff9 <uartinit+0xd9>
  uart = 1;
80105f7d:	c7 05 e0 44 11 80 01 	movl   $0x1,0x801144e0
80105f84:	00 00 00 
80105f87:	89 fa                	mov    %edi,%edx
80105f89:	ec                   	in     (%dx),%al
80105f8a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f8f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105f90:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105f93:	bf b8 78 10 80       	mov    $0x801078b8,%edi
80105f98:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105f9d:	6a 00                	push   $0x0
80105f9f:	6a 04                	push   $0x4
80105fa1:	e8 1a c8 ff ff       	call   801027c0 <ioapicenable>
80105fa6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105fa9:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80105fad:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80105fb0:	a1 e0 44 11 80       	mov    0x801144e0,%eax
80105fb5:	85 c0                	test   %eax,%eax
80105fb7:	74 32                	je     80105feb <uartinit+0xcb>
80105fb9:	89 f2                	mov    %esi,%edx
80105fbb:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105fbc:	a8 20                	test   $0x20,%al
80105fbe:	75 21                	jne    80105fe1 <uartinit+0xc1>
80105fc0:	bb 80 00 00 00       	mov    $0x80,%ebx
80105fc5:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105fc8:	83 ec 0c             	sub    $0xc,%esp
80105fcb:	6a 0a                	push   $0xa
80105fcd:	e8 9e cc ff ff       	call   80102c70 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105fd2:	83 c4 10             	add    $0x10,%esp
80105fd5:	83 eb 01             	sub    $0x1,%ebx
80105fd8:	74 07                	je     80105fe1 <uartinit+0xc1>
80105fda:	89 f2                	mov    %esi,%edx
80105fdc:	ec                   	in     (%dx),%al
80105fdd:	a8 20                	test   $0x20,%al
80105fdf:	74 e7                	je     80105fc8 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105fe1:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105fe6:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105fea:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105feb:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105fef:	83 c7 01             	add    $0x1,%edi
80105ff2:	88 45 e7             	mov    %al,-0x19(%ebp)
80105ff5:	84 c0                	test   %al,%al
80105ff7:	75 b7                	jne    80105fb0 <uartinit+0x90>
}
80105ff9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ffc:	5b                   	pop    %ebx
80105ffd:	5e                   	pop    %esi
80105ffe:	5f                   	pop    %edi
80105fff:	5d                   	pop    %ebp
80106000:	c3                   	ret
80106001:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106008:	00 
80106009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106010 <uartputc>:
  if(!uart)
80106010:	a1 e0 44 11 80       	mov    0x801144e0,%eax
80106015:	85 c0                	test   %eax,%eax
80106017:	74 4f                	je     80106068 <uartputc+0x58>
{
80106019:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010601a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010601f:	89 e5                	mov    %esp,%ebp
80106021:	56                   	push   %esi
80106022:	53                   	push   %ebx
80106023:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106024:	a8 20                	test   $0x20,%al
80106026:	75 29                	jne    80106051 <uartputc+0x41>
80106028:	bb 80 00 00 00       	mov    $0x80,%ebx
8010602d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106038:	83 ec 0c             	sub    $0xc,%esp
8010603b:	6a 0a                	push   $0xa
8010603d:	e8 2e cc ff ff       	call   80102c70 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106042:	83 c4 10             	add    $0x10,%esp
80106045:	83 eb 01             	sub    $0x1,%ebx
80106048:	74 07                	je     80106051 <uartputc+0x41>
8010604a:	89 f2                	mov    %esi,%edx
8010604c:	ec                   	in     (%dx),%al
8010604d:	a8 20                	test   $0x20,%al
8010604f:	74 e7                	je     80106038 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106051:	8b 45 08             	mov    0x8(%ebp),%eax
80106054:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106059:	ee                   	out    %al,(%dx)
}
8010605a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010605d:	5b                   	pop    %ebx
8010605e:	5e                   	pop    %esi
8010605f:	5d                   	pop    %ebp
80106060:	c3                   	ret
80106061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106068:	c3                   	ret
80106069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106070 <uartintr>:

void
uartintr(void)
{
80106070:	55                   	push   %ebp
80106071:	89 e5                	mov    %esp,%ebp
80106073:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106076:	68 f0 5e 10 80       	push   $0x80105ef0
8010607b:	e8 30 a8 ff ff       	call   801008b0 <consoleintr>
}
80106080:	83 c4 10             	add    $0x10,%esp
80106083:	c9                   	leave
80106084:	c3                   	ret

80106085 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106085:	6a 00                	push   $0x0
  pushl $0
80106087:	6a 00                	push   $0x0
  jmp alltraps
80106089:	e9 0c fb ff ff       	jmp    80105b9a <alltraps>

8010608e <vector1>:
.globl vector1
vector1:
  pushl $0
8010608e:	6a 00                	push   $0x0
  pushl $1
80106090:	6a 01                	push   $0x1
  jmp alltraps
80106092:	e9 03 fb ff ff       	jmp    80105b9a <alltraps>

80106097 <vector2>:
.globl vector2
vector2:
  pushl $0
80106097:	6a 00                	push   $0x0
  pushl $2
80106099:	6a 02                	push   $0x2
  jmp alltraps
8010609b:	e9 fa fa ff ff       	jmp    80105b9a <alltraps>

801060a0 <vector3>:
.globl vector3
vector3:
  pushl $0
801060a0:	6a 00                	push   $0x0
  pushl $3
801060a2:	6a 03                	push   $0x3
  jmp alltraps
801060a4:	e9 f1 fa ff ff       	jmp    80105b9a <alltraps>

801060a9 <vector4>:
.globl vector4
vector4:
  pushl $0
801060a9:	6a 00                	push   $0x0
  pushl $4
801060ab:	6a 04                	push   $0x4
  jmp alltraps
801060ad:	e9 e8 fa ff ff       	jmp    80105b9a <alltraps>

801060b2 <vector5>:
.globl vector5
vector5:
  pushl $0
801060b2:	6a 00                	push   $0x0
  pushl $5
801060b4:	6a 05                	push   $0x5
  jmp alltraps
801060b6:	e9 df fa ff ff       	jmp    80105b9a <alltraps>

801060bb <vector6>:
.globl vector6
vector6:
  pushl $0
801060bb:	6a 00                	push   $0x0
  pushl $6
801060bd:	6a 06                	push   $0x6
  jmp alltraps
801060bf:	e9 d6 fa ff ff       	jmp    80105b9a <alltraps>

801060c4 <vector7>:
.globl vector7
vector7:
  pushl $0
801060c4:	6a 00                	push   $0x0
  pushl $7
801060c6:	6a 07                	push   $0x7
  jmp alltraps
801060c8:	e9 cd fa ff ff       	jmp    80105b9a <alltraps>

801060cd <vector8>:
.globl vector8
vector8:
  pushl $8
801060cd:	6a 08                	push   $0x8
  jmp alltraps
801060cf:	e9 c6 fa ff ff       	jmp    80105b9a <alltraps>

801060d4 <vector9>:
.globl vector9
vector9:
  pushl $0
801060d4:	6a 00                	push   $0x0
  pushl $9
801060d6:	6a 09                	push   $0x9
  jmp alltraps
801060d8:	e9 bd fa ff ff       	jmp    80105b9a <alltraps>

801060dd <vector10>:
.globl vector10
vector10:
  pushl $10
801060dd:	6a 0a                	push   $0xa
  jmp alltraps
801060df:	e9 b6 fa ff ff       	jmp    80105b9a <alltraps>

801060e4 <vector11>:
.globl vector11
vector11:
  pushl $11
801060e4:	6a 0b                	push   $0xb
  jmp alltraps
801060e6:	e9 af fa ff ff       	jmp    80105b9a <alltraps>

801060eb <vector12>:
.globl vector12
vector12:
  pushl $12
801060eb:	6a 0c                	push   $0xc
  jmp alltraps
801060ed:	e9 a8 fa ff ff       	jmp    80105b9a <alltraps>

801060f2 <vector13>:
.globl vector13
vector13:
  pushl $13
801060f2:	6a 0d                	push   $0xd
  jmp alltraps
801060f4:	e9 a1 fa ff ff       	jmp    80105b9a <alltraps>

801060f9 <vector14>:
.globl vector14
vector14:
  pushl $14
801060f9:	6a 0e                	push   $0xe
  jmp alltraps
801060fb:	e9 9a fa ff ff       	jmp    80105b9a <alltraps>

80106100 <vector15>:
.globl vector15
vector15:
  pushl $0
80106100:	6a 00                	push   $0x0
  pushl $15
80106102:	6a 0f                	push   $0xf
  jmp alltraps
80106104:	e9 91 fa ff ff       	jmp    80105b9a <alltraps>

80106109 <vector16>:
.globl vector16
vector16:
  pushl $0
80106109:	6a 00                	push   $0x0
  pushl $16
8010610b:	6a 10                	push   $0x10
  jmp alltraps
8010610d:	e9 88 fa ff ff       	jmp    80105b9a <alltraps>

80106112 <vector17>:
.globl vector17
vector17:
  pushl $17
80106112:	6a 11                	push   $0x11
  jmp alltraps
80106114:	e9 81 fa ff ff       	jmp    80105b9a <alltraps>

80106119 <vector18>:
.globl vector18
vector18:
  pushl $0
80106119:	6a 00                	push   $0x0
  pushl $18
8010611b:	6a 12                	push   $0x12
  jmp alltraps
8010611d:	e9 78 fa ff ff       	jmp    80105b9a <alltraps>

80106122 <vector19>:
.globl vector19
vector19:
  pushl $0
80106122:	6a 00                	push   $0x0
  pushl $19
80106124:	6a 13                	push   $0x13
  jmp alltraps
80106126:	e9 6f fa ff ff       	jmp    80105b9a <alltraps>

8010612b <vector20>:
.globl vector20
vector20:
  pushl $0
8010612b:	6a 00                	push   $0x0
  pushl $20
8010612d:	6a 14                	push   $0x14
  jmp alltraps
8010612f:	e9 66 fa ff ff       	jmp    80105b9a <alltraps>

80106134 <vector21>:
.globl vector21
vector21:
  pushl $0
80106134:	6a 00                	push   $0x0
  pushl $21
80106136:	6a 15                	push   $0x15
  jmp alltraps
80106138:	e9 5d fa ff ff       	jmp    80105b9a <alltraps>

8010613d <vector22>:
.globl vector22
vector22:
  pushl $0
8010613d:	6a 00                	push   $0x0
  pushl $22
8010613f:	6a 16                	push   $0x16
  jmp alltraps
80106141:	e9 54 fa ff ff       	jmp    80105b9a <alltraps>

80106146 <vector23>:
.globl vector23
vector23:
  pushl $0
80106146:	6a 00                	push   $0x0
  pushl $23
80106148:	6a 17                	push   $0x17
  jmp alltraps
8010614a:	e9 4b fa ff ff       	jmp    80105b9a <alltraps>

8010614f <vector24>:
.globl vector24
vector24:
  pushl $0
8010614f:	6a 00                	push   $0x0
  pushl $24
80106151:	6a 18                	push   $0x18
  jmp alltraps
80106153:	e9 42 fa ff ff       	jmp    80105b9a <alltraps>

80106158 <vector25>:
.globl vector25
vector25:
  pushl $0
80106158:	6a 00                	push   $0x0
  pushl $25
8010615a:	6a 19                	push   $0x19
  jmp alltraps
8010615c:	e9 39 fa ff ff       	jmp    80105b9a <alltraps>

80106161 <vector26>:
.globl vector26
vector26:
  pushl $0
80106161:	6a 00                	push   $0x0
  pushl $26
80106163:	6a 1a                	push   $0x1a
  jmp alltraps
80106165:	e9 30 fa ff ff       	jmp    80105b9a <alltraps>

8010616a <vector27>:
.globl vector27
vector27:
  pushl $0
8010616a:	6a 00                	push   $0x0
  pushl $27
8010616c:	6a 1b                	push   $0x1b
  jmp alltraps
8010616e:	e9 27 fa ff ff       	jmp    80105b9a <alltraps>

80106173 <vector28>:
.globl vector28
vector28:
  pushl $0
80106173:	6a 00                	push   $0x0
  pushl $28
80106175:	6a 1c                	push   $0x1c
  jmp alltraps
80106177:	e9 1e fa ff ff       	jmp    80105b9a <alltraps>

8010617c <vector29>:
.globl vector29
vector29:
  pushl $0
8010617c:	6a 00                	push   $0x0
  pushl $29
8010617e:	6a 1d                	push   $0x1d
  jmp alltraps
80106180:	e9 15 fa ff ff       	jmp    80105b9a <alltraps>

80106185 <vector30>:
.globl vector30
vector30:
  pushl $0
80106185:	6a 00                	push   $0x0
  pushl $30
80106187:	6a 1e                	push   $0x1e
  jmp alltraps
80106189:	e9 0c fa ff ff       	jmp    80105b9a <alltraps>

8010618e <vector31>:
.globl vector31
vector31:
  pushl $0
8010618e:	6a 00                	push   $0x0
  pushl $31
80106190:	6a 1f                	push   $0x1f
  jmp alltraps
80106192:	e9 03 fa ff ff       	jmp    80105b9a <alltraps>

80106197 <vector32>:
.globl vector32
vector32:
  pushl $0
80106197:	6a 00                	push   $0x0
  pushl $32
80106199:	6a 20                	push   $0x20
  jmp alltraps
8010619b:	e9 fa f9 ff ff       	jmp    80105b9a <alltraps>

801061a0 <vector33>:
.globl vector33
vector33:
  pushl $0
801061a0:	6a 00                	push   $0x0
  pushl $33
801061a2:	6a 21                	push   $0x21
  jmp alltraps
801061a4:	e9 f1 f9 ff ff       	jmp    80105b9a <alltraps>

801061a9 <vector34>:
.globl vector34
vector34:
  pushl $0
801061a9:	6a 00                	push   $0x0
  pushl $34
801061ab:	6a 22                	push   $0x22
  jmp alltraps
801061ad:	e9 e8 f9 ff ff       	jmp    80105b9a <alltraps>

801061b2 <vector35>:
.globl vector35
vector35:
  pushl $0
801061b2:	6a 00                	push   $0x0
  pushl $35
801061b4:	6a 23                	push   $0x23
  jmp alltraps
801061b6:	e9 df f9 ff ff       	jmp    80105b9a <alltraps>

801061bb <vector36>:
.globl vector36
vector36:
  pushl $0
801061bb:	6a 00                	push   $0x0
  pushl $36
801061bd:	6a 24                	push   $0x24
  jmp alltraps
801061bf:	e9 d6 f9 ff ff       	jmp    80105b9a <alltraps>

801061c4 <vector37>:
.globl vector37
vector37:
  pushl $0
801061c4:	6a 00                	push   $0x0
  pushl $37
801061c6:	6a 25                	push   $0x25
  jmp alltraps
801061c8:	e9 cd f9 ff ff       	jmp    80105b9a <alltraps>

801061cd <vector38>:
.globl vector38
vector38:
  pushl $0
801061cd:	6a 00                	push   $0x0
  pushl $38
801061cf:	6a 26                	push   $0x26
  jmp alltraps
801061d1:	e9 c4 f9 ff ff       	jmp    80105b9a <alltraps>

801061d6 <vector39>:
.globl vector39
vector39:
  pushl $0
801061d6:	6a 00                	push   $0x0
  pushl $39
801061d8:	6a 27                	push   $0x27
  jmp alltraps
801061da:	e9 bb f9 ff ff       	jmp    80105b9a <alltraps>

801061df <vector40>:
.globl vector40
vector40:
  pushl $0
801061df:	6a 00                	push   $0x0
  pushl $40
801061e1:	6a 28                	push   $0x28
  jmp alltraps
801061e3:	e9 b2 f9 ff ff       	jmp    80105b9a <alltraps>

801061e8 <vector41>:
.globl vector41
vector41:
  pushl $0
801061e8:	6a 00                	push   $0x0
  pushl $41
801061ea:	6a 29                	push   $0x29
  jmp alltraps
801061ec:	e9 a9 f9 ff ff       	jmp    80105b9a <alltraps>

801061f1 <vector42>:
.globl vector42
vector42:
  pushl $0
801061f1:	6a 00                	push   $0x0
  pushl $42
801061f3:	6a 2a                	push   $0x2a
  jmp alltraps
801061f5:	e9 a0 f9 ff ff       	jmp    80105b9a <alltraps>

801061fa <vector43>:
.globl vector43
vector43:
  pushl $0
801061fa:	6a 00                	push   $0x0
  pushl $43
801061fc:	6a 2b                	push   $0x2b
  jmp alltraps
801061fe:	e9 97 f9 ff ff       	jmp    80105b9a <alltraps>

80106203 <vector44>:
.globl vector44
vector44:
  pushl $0
80106203:	6a 00                	push   $0x0
  pushl $44
80106205:	6a 2c                	push   $0x2c
  jmp alltraps
80106207:	e9 8e f9 ff ff       	jmp    80105b9a <alltraps>

8010620c <vector45>:
.globl vector45
vector45:
  pushl $0
8010620c:	6a 00                	push   $0x0
  pushl $45
8010620e:	6a 2d                	push   $0x2d
  jmp alltraps
80106210:	e9 85 f9 ff ff       	jmp    80105b9a <alltraps>

80106215 <vector46>:
.globl vector46
vector46:
  pushl $0
80106215:	6a 00                	push   $0x0
  pushl $46
80106217:	6a 2e                	push   $0x2e
  jmp alltraps
80106219:	e9 7c f9 ff ff       	jmp    80105b9a <alltraps>

8010621e <vector47>:
.globl vector47
vector47:
  pushl $0
8010621e:	6a 00                	push   $0x0
  pushl $47
80106220:	6a 2f                	push   $0x2f
  jmp alltraps
80106222:	e9 73 f9 ff ff       	jmp    80105b9a <alltraps>

80106227 <vector48>:
.globl vector48
vector48:
  pushl $0
80106227:	6a 00                	push   $0x0
  pushl $48
80106229:	6a 30                	push   $0x30
  jmp alltraps
8010622b:	e9 6a f9 ff ff       	jmp    80105b9a <alltraps>

80106230 <vector49>:
.globl vector49
vector49:
  pushl $0
80106230:	6a 00                	push   $0x0
  pushl $49
80106232:	6a 31                	push   $0x31
  jmp alltraps
80106234:	e9 61 f9 ff ff       	jmp    80105b9a <alltraps>

80106239 <vector50>:
.globl vector50
vector50:
  pushl $0
80106239:	6a 00                	push   $0x0
  pushl $50
8010623b:	6a 32                	push   $0x32
  jmp alltraps
8010623d:	e9 58 f9 ff ff       	jmp    80105b9a <alltraps>

80106242 <vector51>:
.globl vector51
vector51:
  pushl $0
80106242:	6a 00                	push   $0x0
  pushl $51
80106244:	6a 33                	push   $0x33
  jmp alltraps
80106246:	e9 4f f9 ff ff       	jmp    80105b9a <alltraps>

8010624b <vector52>:
.globl vector52
vector52:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $52
8010624d:	6a 34                	push   $0x34
  jmp alltraps
8010624f:	e9 46 f9 ff ff       	jmp    80105b9a <alltraps>

80106254 <vector53>:
.globl vector53
vector53:
  pushl $0
80106254:	6a 00                	push   $0x0
  pushl $53
80106256:	6a 35                	push   $0x35
  jmp alltraps
80106258:	e9 3d f9 ff ff       	jmp    80105b9a <alltraps>

8010625d <vector54>:
.globl vector54
vector54:
  pushl $0
8010625d:	6a 00                	push   $0x0
  pushl $54
8010625f:	6a 36                	push   $0x36
  jmp alltraps
80106261:	e9 34 f9 ff ff       	jmp    80105b9a <alltraps>

80106266 <vector55>:
.globl vector55
vector55:
  pushl $0
80106266:	6a 00                	push   $0x0
  pushl $55
80106268:	6a 37                	push   $0x37
  jmp alltraps
8010626a:	e9 2b f9 ff ff       	jmp    80105b9a <alltraps>

8010626f <vector56>:
.globl vector56
vector56:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $56
80106271:	6a 38                	push   $0x38
  jmp alltraps
80106273:	e9 22 f9 ff ff       	jmp    80105b9a <alltraps>

80106278 <vector57>:
.globl vector57
vector57:
  pushl $0
80106278:	6a 00                	push   $0x0
  pushl $57
8010627a:	6a 39                	push   $0x39
  jmp alltraps
8010627c:	e9 19 f9 ff ff       	jmp    80105b9a <alltraps>

80106281 <vector58>:
.globl vector58
vector58:
  pushl $0
80106281:	6a 00                	push   $0x0
  pushl $58
80106283:	6a 3a                	push   $0x3a
  jmp alltraps
80106285:	e9 10 f9 ff ff       	jmp    80105b9a <alltraps>

8010628a <vector59>:
.globl vector59
vector59:
  pushl $0
8010628a:	6a 00                	push   $0x0
  pushl $59
8010628c:	6a 3b                	push   $0x3b
  jmp alltraps
8010628e:	e9 07 f9 ff ff       	jmp    80105b9a <alltraps>

80106293 <vector60>:
.globl vector60
vector60:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $60
80106295:	6a 3c                	push   $0x3c
  jmp alltraps
80106297:	e9 fe f8 ff ff       	jmp    80105b9a <alltraps>

8010629c <vector61>:
.globl vector61
vector61:
  pushl $0
8010629c:	6a 00                	push   $0x0
  pushl $61
8010629e:	6a 3d                	push   $0x3d
  jmp alltraps
801062a0:	e9 f5 f8 ff ff       	jmp    80105b9a <alltraps>

801062a5 <vector62>:
.globl vector62
vector62:
  pushl $0
801062a5:	6a 00                	push   $0x0
  pushl $62
801062a7:	6a 3e                	push   $0x3e
  jmp alltraps
801062a9:	e9 ec f8 ff ff       	jmp    80105b9a <alltraps>

801062ae <vector63>:
.globl vector63
vector63:
  pushl $0
801062ae:	6a 00                	push   $0x0
  pushl $63
801062b0:	6a 3f                	push   $0x3f
  jmp alltraps
801062b2:	e9 e3 f8 ff ff       	jmp    80105b9a <alltraps>

801062b7 <vector64>:
.globl vector64
vector64:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $64
801062b9:	6a 40                	push   $0x40
  jmp alltraps
801062bb:	e9 da f8 ff ff       	jmp    80105b9a <alltraps>

801062c0 <vector65>:
.globl vector65
vector65:
  pushl $0
801062c0:	6a 00                	push   $0x0
  pushl $65
801062c2:	6a 41                	push   $0x41
  jmp alltraps
801062c4:	e9 d1 f8 ff ff       	jmp    80105b9a <alltraps>

801062c9 <vector66>:
.globl vector66
vector66:
  pushl $0
801062c9:	6a 00                	push   $0x0
  pushl $66
801062cb:	6a 42                	push   $0x42
  jmp alltraps
801062cd:	e9 c8 f8 ff ff       	jmp    80105b9a <alltraps>

801062d2 <vector67>:
.globl vector67
vector67:
  pushl $0
801062d2:	6a 00                	push   $0x0
  pushl $67
801062d4:	6a 43                	push   $0x43
  jmp alltraps
801062d6:	e9 bf f8 ff ff       	jmp    80105b9a <alltraps>

801062db <vector68>:
.globl vector68
vector68:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $68
801062dd:	6a 44                	push   $0x44
  jmp alltraps
801062df:	e9 b6 f8 ff ff       	jmp    80105b9a <alltraps>

801062e4 <vector69>:
.globl vector69
vector69:
  pushl $0
801062e4:	6a 00                	push   $0x0
  pushl $69
801062e6:	6a 45                	push   $0x45
  jmp alltraps
801062e8:	e9 ad f8 ff ff       	jmp    80105b9a <alltraps>

801062ed <vector70>:
.globl vector70
vector70:
  pushl $0
801062ed:	6a 00                	push   $0x0
  pushl $70
801062ef:	6a 46                	push   $0x46
  jmp alltraps
801062f1:	e9 a4 f8 ff ff       	jmp    80105b9a <alltraps>

801062f6 <vector71>:
.globl vector71
vector71:
  pushl $0
801062f6:	6a 00                	push   $0x0
  pushl $71
801062f8:	6a 47                	push   $0x47
  jmp alltraps
801062fa:	e9 9b f8 ff ff       	jmp    80105b9a <alltraps>

801062ff <vector72>:
.globl vector72
vector72:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $72
80106301:	6a 48                	push   $0x48
  jmp alltraps
80106303:	e9 92 f8 ff ff       	jmp    80105b9a <alltraps>

80106308 <vector73>:
.globl vector73
vector73:
  pushl $0
80106308:	6a 00                	push   $0x0
  pushl $73
8010630a:	6a 49                	push   $0x49
  jmp alltraps
8010630c:	e9 89 f8 ff ff       	jmp    80105b9a <alltraps>

80106311 <vector74>:
.globl vector74
vector74:
  pushl $0
80106311:	6a 00                	push   $0x0
  pushl $74
80106313:	6a 4a                	push   $0x4a
  jmp alltraps
80106315:	e9 80 f8 ff ff       	jmp    80105b9a <alltraps>

8010631a <vector75>:
.globl vector75
vector75:
  pushl $0
8010631a:	6a 00                	push   $0x0
  pushl $75
8010631c:	6a 4b                	push   $0x4b
  jmp alltraps
8010631e:	e9 77 f8 ff ff       	jmp    80105b9a <alltraps>

80106323 <vector76>:
.globl vector76
vector76:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $76
80106325:	6a 4c                	push   $0x4c
  jmp alltraps
80106327:	e9 6e f8 ff ff       	jmp    80105b9a <alltraps>

8010632c <vector77>:
.globl vector77
vector77:
  pushl $0
8010632c:	6a 00                	push   $0x0
  pushl $77
8010632e:	6a 4d                	push   $0x4d
  jmp alltraps
80106330:	e9 65 f8 ff ff       	jmp    80105b9a <alltraps>

80106335 <vector78>:
.globl vector78
vector78:
  pushl $0
80106335:	6a 00                	push   $0x0
  pushl $78
80106337:	6a 4e                	push   $0x4e
  jmp alltraps
80106339:	e9 5c f8 ff ff       	jmp    80105b9a <alltraps>

8010633e <vector79>:
.globl vector79
vector79:
  pushl $0
8010633e:	6a 00                	push   $0x0
  pushl $79
80106340:	6a 4f                	push   $0x4f
  jmp alltraps
80106342:	e9 53 f8 ff ff       	jmp    80105b9a <alltraps>

80106347 <vector80>:
.globl vector80
vector80:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $80
80106349:	6a 50                	push   $0x50
  jmp alltraps
8010634b:	e9 4a f8 ff ff       	jmp    80105b9a <alltraps>

80106350 <vector81>:
.globl vector81
vector81:
  pushl $0
80106350:	6a 00                	push   $0x0
  pushl $81
80106352:	6a 51                	push   $0x51
  jmp alltraps
80106354:	e9 41 f8 ff ff       	jmp    80105b9a <alltraps>

80106359 <vector82>:
.globl vector82
vector82:
  pushl $0
80106359:	6a 00                	push   $0x0
  pushl $82
8010635b:	6a 52                	push   $0x52
  jmp alltraps
8010635d:	e9 38 f8 ff ff       	jmp    80105b9a <alltraps>

80106362 <vector83>:
.globl vector83
vector83:
  pushl $0
80106362:	6a 00                	push   $0x0
  pushl $83
80106364:	6a 53                	push   $0x53
  jmp alltraps
80106366:	e9 2f f8 ff ff       	jmp    80105b9a <alltraps>

8010636b <vector84>:
.globl vector84
vector84:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $84
8010636d:	6a 54                	push   $0x54
  jmp alltraps
8010636f:	e9 26 f8 ff ff       	jmp    80105b9a <alltraps>

80106374 <vector85>:
.globl vector85
vector85:
  pushl $0
80106374:	6a 00                	push   $0x0
  pushl $85
80106376:	6a 55                	push   $0x55
  jmp alltraps
80106378:	e9 1d f8 ff ff       	jmp    80105b9a <alltraps>

8010637d <vector86>:
.globl vector86
vector86:
  pushl $0
8010637d:	6a 00                	push   $0x0
  pushl $86
8010637f:	6a 56                	push   $0x56
  jmp alltraps
80106381:	e9 14 f8 ff ff       	jmp    80105b9a <alltraps>

80106386 <vector87>:
.globl vector87
vector87:
  pushl $0
80106386:	6a 00                	push   $0x0
  pushl $87
80106388:	6a 57                	push   $0x57
  jmp alltraps
8010638a:	e9 0b f8 ff ff       	jmp    80105b9a <alltraps>

8010638f <vector88>:
.globl vector88
vector88:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $88
80106391:	6a 58                	push   $0x58
  jmp alltraps
80106393:	e9 02 f8 ff ff       	jmp    80105b9a <alltraps>

80106398 <vector89>:
.globl vector89
vector89:
  pushl $0
80106398:	6a 00                	push   $0x0
  pushl $89
8010639a:	6a 59                	push   $0x59
  jmp alltraps
8010639c:	e9 f9 f7 ff ff       	jmp    80105b9a <alltraps>

801063a1 <vector90>:
.globl vector90
vector90:
  pushl $0
801063a1:	6a 00                	push   $0x0
  pushl $90
801063a3:	6a 5a                	push   $0x5a
  jmp alltraps
801063a5:	e9 f0 f7 ff ff       	jmp    80105b9a <alltraps>

801063aa <vector91>:
.globl vector91
vector91:
  pushl $0
801063aa:	6a 00                	push   $0x0
  pushl $91
801063ac:	6a 5b                	push   $0x5b
  jmp alltraps
801063ae:	e9 e7 f7 ff ff       	jmp    80105b9a <alltraps>

801063b3 <vector92>:
.globl vector92
vector92:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $92
801063b5:	6a 5c                	push   $0x5c
  jmp alltraps
801063b7:	e9 de f7 ff ff       	jmp    80105b9a <alltraps>

801063bc <vector93>:
.globl vector93
vector93:
  pushl $0
801063bc:	6a 00                	push   $0x0
  pushl $93
801063be:	6a 5d                	push   $0x5d
  jmp alltraps
801063c0:	e9 d5 f7 ff ff       	jmp    80105b9a <alltraps>

801063c5 <vector94>:
.globl vector94
vector94:
  pushl $0
801063c5:	6a 00                	push   $0x0
  pushl $94
801063c7:	6a 5e                	push   $0x5e
  jmp alltraps
801063c9:	e9 cc f7 ff ff       	jmp    80105b9a <alltraps>

801063ce <vector95>:
.globl vector95
vector95:
  pushl $0
801063ce:	6a 00                	push   $0x0
  pushl $95
801063d0:	6a 5f                	push   $0x5f
  jmp alltraps
801063d2:	e9 c3 f7 ff ff       	jmp    80105b9a <alltraps>

801063d7 <vector96>:
.globl vector96
vector96:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $96
801063d9:	6a 60                	push   $0x60
  jmp alltraps
801063db:	e9 ba f7 ff ff       	jmp    80105b9a <alltraps>

801063e0 <vector97>:
.globl vector97
vector97:
  pushl $0
801063e0:	6a 00                	push   $0x0
  pushl $97
801063e2:	6a 61                	push   $0x61
  jmp alltraps
801063e4:	e9 b1 f7 ff ff       	jmp    80105b9a <alltraps>

801063e9 <vector98>:
.globl vector98
vector98:
  pushl $0
801063e9:	6a 00                	push   $0x0
  pushl $98
801063eb:	6a 62                	push   $0x62
  jmp alltraps
801063ed:	e9 a8 f7 ff ff       	jmp    80105b9a <alltraps>

801063f2 <vector99>:
.globl vector99
vector99:
  pushl $0
801063f2:	6a 00                	push   $0x0
  pushl $99
801063f4:	6a 63                	push   $0x63
  jmp alltraps
801063f6:	e9 9f f7 ff ff       	jmp    80105b9a <alltraps>

801063fb <vector100>:
.globl vector100
vector100:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $100
801063fd:	6a 64                	push   $0x64
  jmp alltraps
801063ff:	e9 96 f7 ff ff       	jmp    80105b9a <alltraps>

80106404 <vector101>:
.globl vector101
vector101:
  pushl $0
80106404:	6a 00                	push   $0x0
  pushl $101
80106406:	6a 65                	push   $0x65
  jmp alltraps
80106408:	e9 8d f7 ff ff       	jmp    80105b9a <alltraps>

8010640d <vector102>:
.globl vector102
vector102:
  pushl $0
8010640d:	6a 00                	push   $0x0
  pushl $102
8010640f:	6a 66                	push   $0x66
  jmp alltraps
80106411:	e9 84 f7 ff ff       	jmp    80105b9a <alltraps>

80106416 <vector103>:
.globl vector103
vector103:
  pushl $0
80106416:	6a 00                	push   $0x0
  pushl $103
80106418:	6a 67                	push   $0x67
  jmp alltraps
8010641a:	e9 7b f7 ff ff       	jmp    80105b9a <alltraps>

8010641f <vector104>:
.globl vector104
vector104:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $104
80106421:	6a 68                	push   $0x68
  jmp alltraps
80106423:	e9 72 f7 ff ff       	jmp    80105b9a <alltraps>

80106428 <vector105>:
.globl vector105
vector105:
  pushl $0
80106428:	6a 00                	push   $0x0
  pushl $105
8010642a:	6a 69                	push   $0x69
  jmp alltraps
8010642c:	e9 69 f7 ff ff       	jmp    80105b9a <alltraps>

80106431 <vector106>:
.globl vector106
vector106:
  pushl $0
80106431:	6a 00                	push   $0x0
  pushl $106
80106433:	6a 6a                	push   $0x6a
  jmp alltraps
80106435:	e9 60 f7 ff ff       	jmp    80105b9a <alltraps>

8010643a <vector107>:
.globl vector107
vector107:
  pushl $0
8010643a:	6a 00                	push   $0x0
  pushl $107
8010643c:	6a 6b                	push   $0x6b
  jmp alltraps
8010643e:	e9 57 f7 ff ff       	jmp    80105b9a <alltraps>

80106443 <vector108>:
.globl vector108
vector108:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $108
80106445:	6a 6c                	push   $0x6c
  jmp alltraps
80106447:	e9 4e f7 ff ff       	jmp    80105b9a <alltraps>

8010644c <vector109>:
.globl vector109
vector109:
  pushl $0
8010644c:	6a 00                	push   $0x0
  pushl $109
8010644e:	6a 6d                	push   $0x6d
  jmp alltraps
80106450:	e9 45 f7 ff ff       	jmp    80105b9a <alltraps>

80106455 <vector110>:
.globl vector110
vector110:
  pushl $0
80106455:	6a 00                	push   $0x0
  pushl $110
80106457:	6a 6e                	push   $0x6e
  jmp alltraps
80106459:	e9 3c f7 ff ff       	jmp    80105b9a <alltraps>

8010645e <vector111>:
.globl vector111
vector111:
  pushl $0
8010645e:	6a 00                	push   $0x0
  pushl $111
80106460:	6a 6f                	push   $0x6f
  jmp alltraps
80106462:	e9 33 f7 ff ff       	jmp    80105b9a <alltraps>

80106467 <vector112>:
.globl vector112
vector112:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $112
80106469:	6a 70                	push   $0x70
  jmp alltraps
8010646b:	e9 2a f7 ff ff       	jmp    80105b9a <alltraps>

80106470 <vector113>:
.globl vector113
vector113:
  pushl $0
80106470:	6a 00                	push   $0x0
  pushl $113
80106472:	6a 71                	push   $0x71
  jmp alltraps
80106474:	e9 21 f7 ff ff       	jmp    80105b9a <alltraps>

80106479 <vector114>:
.globl vector114
vector114:
  pushl $0
80106479:	6a 00                	push   $0x0
  pushl $114
8010647b:	6a 72                	push   $0x72
  jmp alltraps
8010647d:	e9 18 f7 ff ff       	jmp    80105b9a <alltraps>

80106482 <vector115>:
.globl vector115
vector115:
  pushl $0
80106482:	6a 00                	push   $0x0
  pushl $115
80106484:	6a 73                	push   $0x73
  jmp alltraps
80106486:	e9 0f f7 ff ff       	jmp    80105b9a <alltraps>

8010648b <vector116>:
.globl vector116
vector116:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $116
8010648d:	6a 74                	push   $0x74
  jmp alltraps
8010648f:	e9 06 f7 ff ff       	jmp    80105b9a <alltraps>

80106494 <vector117>:
.globl vector117
vector117:
  pushl $0
80106494:	6a 00                	push   $0x0
  pushl $117
80106496:	6a 75                	push   $0x75
  jmp alltraps
80106498:	e9 fd f6 ff ff       	jmp    80105b9a <alltraps>

8010649d <vector118>:
.globl vector118
vector118:
  pushl $0
8010649d:	6a 00                	push   $0x0
  pushl $118
8010649f:	6a 76                	push   $0x76
  jmp alltraps
801064a1:	e9 f4 f6 ff ff       	jmp    80105b9a <alltraps>

801064a6 <vector119>:
.globl vector119
vector119:
  pushl $0
801064a6:	6a 00                	push   $0x0
  pushl $119
801064a8:	6a 77                	push   $0x77
  jmp alltraps
801064aa:	e9 eb f6 ff ff       	jmp    80105b9a <alltraps>

801064af <vector120>:
.globl vector120
vector120:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $120
801064b1:	6a 78                	push   $0x78
  jmp alltraps
801064b3:	e9 e2 f6 ff ff       	jmp    80105b9a <alltraps>

801064b8 <vector121>:
.globl vector121
vector121:
  pushl $0
801064b8:	6a 00                	push   $0x0
  pushl $121
801064ba:	6a 79                	push   $0x79
  jmp alltraps
801064bc:	e9 d9 f6 ff ff       	jmp    80105b9a <alltraps>

801064c1 <vector122>:
.globl vector122
vector122:
  pushl $0
801064c1:	6a 00                	push   $0x0
  pushl $122
801064c3:	6a 7a                	push   $0x7a
  jmp alltraps
801064c5:	e9 d0 f6 ff ff       	jmp    80105b9a <alltraps>

801064ca <vector123>:
.globl vector123
vector123:
  pushl $0
801064ca:	6a 00                	push   $0x0
  pushl $123
801064cc:	6a 7b                	push   $0x7b
  jmp alltraps
801064ce:	e9 c7 f6 ff ff       	jmp    80105b9a <alltraps>

801064d3 <vector124>:
.globl vector124
vector124:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $124
801064d5:	6a 7c                	push   $0x7c
  jmp alltraps
801064d7:	e9 be f6 ff ff       	jmp    80105b9a <alltraps>

801064dc <vector125>:
.globl vector125
vector125:
  pushl $0
801064dc:	6a 00                	push   $0x0
  pushl $125
801064de:	6a 7d                	push   $0x7d
  jmp alltraps
801064e0:	e9 b5 f6 ff ff       	jmp    80105b9a <alltraps>

801064e5 <vector126>:
.globl vector126
vector126:
  pushl $0
801064e5:	6a 00                	push   $0x0
  pushl $126
801064e7:	6a 7e                	push   $0x7e
  jmp alltraps
801064e9:	e9 ac f6 ff ff       	jmp    80105b9a <alltraps>

801064ee <vector127>:
.globl vector127
vector127:
  pushl $0
801064ee:	6a 00                	push   $0x0
  pushl $127
801064f0:	6a 7f                	push   $0x7f
  jmp alltraps
801064f2:	e9 a3 f6 ff ff       	jmp    80105b9a <alltraps>

801064f7 <vector128>:
.globl vector128
vector128:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $128
801064f9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801064fe:	e9 97 f6 ff ff       	jmp    80105b9a <alltraps>

80106503 <vector129>:
.globl vector129
vector129:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $129
80106505:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010650a:	e9 8b f6 ff ff       	jmp    80105b9a <alltraps>

8010650f <vector130>:
.globl vector130
vector130:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $130
80106511:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106516:	e9 7f f6 ff ff       	jmp    80105b9a <alltraps>

8010651b <vector131>:
.globl vector131
vector131:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $131
8010651d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106522:	e9 73 f6 ff ff       	jmp    80105b9a <alltraps>

80106527 <vector132>:
.globl vector132
vector132:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $132
80106529:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010652e:	e9 67 f6 ff ff       	jmp    80105b9a <alltraps>

80106533 <vector133>:
.globl vector133
vector133:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $133
80106535:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010653a:	e9 5b f6 ff ff       	jmp    80105b9a <alltraps>

8010653f <vector134>:
.globl vector134
vector134:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $134
80106541:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106546:	e9 4f f6 ff ff       	jmp    80105b9a <alltraps>

8010654b <vector135>:
.globl vector135
vector135:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $135
8010654d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106552:	e9 43 f6 ff ff       	jmp    80105b9a <alltraps>

80106557 <vector136>:
.globl vector136
vector136:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $136
80106559:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010655e:	e9 37 f6 ff ff       	jmp    80105b9a <alltraps>

80106563 <vector137>:
.globl vector137
vector137:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $137
80106565:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010656a:	e9 2b f6 ff ff       	jmp    80105b9a <alltraps>

8010656f <vector138>:
.globl vector138
vector138:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $138
80106571:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106576:	e9 1f f6 ff ff       	jmp    80105b9a <alltraps>

8010657b <vector139>:
.globl vector139
vector139:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $139
8010657d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106582:	e9 13 f6 ff ff       	jmp    80105b9a <alltraps>

80106587 <vector140>:
.globl vector140
vector140:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $140
80106589:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010658e:	e9 07 f6 ff ff       	jmp    80105b9a <alltraps>

80106593 <vector141>:
.globl vector141
vector141:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $141
80106595:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010659a:	e9 fb f5 ff ff       	jmp    80105b9a <alltraps>

8010659f <vector142>:
.globl vector142
vector142:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $142
801065a1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801065a6:	e9 ef f5 ff ff       	jmp    80105b9a <alltraps>

801065ab <vector143>:
.globl vector143
vector143:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $143
801065ad:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801065b2:	e9 e3 f5 ff ff       	jmp    80105b9a <alltraps>

801065b7 <vector144>:
.globl vector144
vector144:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $144
801065b9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801065be:	e9 d7 f5 ff ff       	jmp    80105b9a <alltraps>

801065c3 <vector145>:
.globl vector145
vector145:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $145
801065c5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801065ca:	e9 cb f5 ff ff       	jmp    80105b9a <alltraps>

801065cf <vector146>:
.globl vector146
vector146:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $146
801065d1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801065d6:	e9 bf f5 ff ff       	jmp    80105b9a <alltraps>

801065db <vector147>:
.globl vector147
vector147:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $147
801065dd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801065e2:	e9 b3 f5 ff ff       	jmp    80105b9a <alltraps>

801065e7 <vector148>:
.globl vector148
vector148:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $148
801065e9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801065ee:	e9 a7 f5 ff ff       	jmp    80105b9a <alltraps>

801065f3 <vector149>:
.globl vector149
vector149:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $149
801065f5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801065fa:	e9 9b f5 ff ff       	jmp    80105b9a <alltraps>

801065ff <vector150>:
.globl vector150
vector150:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $150
80106601:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106606:	e9 8f f5 ff ff       	jmp    80105b9a <alltraps>

8010660b <vector151>:
.globl vector151
vector151:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $151
8010660d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106612:	e9 83 f5 ff ff       	jmp    80105b9a <alltraps>

80106617 <vector152>:
.globl vector152
vector152:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $152
80106619:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010661e:	e9 77 f5 ff ff       	jmp    80105b9a <alltraps>

80106623 <vector153>:
.globl vector153
vector153:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $153
80106625:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010662a:	e9 6b f5 ff ff       	jmp    80105b9a <alltraps>

8010662f <vector154>:
.globl vector154
vector154:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $154
80106631:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106636:	e9 5f f5 ff ff       	jmp    80105b9a <alltraps>

8010663b <vector155>:
.globl vector155
vector155:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $155
8010663d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106642:	e9 53 f5 ff ff       	jmp    80105b9a <alltraps>

80106647 <vector156>:
.globl vector156
vector156:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $156
80106649:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010664e:	e9 47 f5 ff ff       	jmp    80105b9a <alltraps>

80106653 <vector157>:
.globl vector157
vector157:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $157
80106655:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010665a:	e9 3b f5 ff ff       	jmp    80105b9a <alltraps>

8010665f <vector158>:
.globl vector158
vector158:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $158
80106661:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106666:	e9 2f f5 ff ff       	jmp    80105b9a <alltraps>

8010666b <vector159>:
.globl vector159
vector159:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $159
8010666d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106672:	e9 23 f5 ff ff       	jmp    80105b9a <alltraps>

80106677 <vector160>:
.globl vector160
vector160:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $160
80106679:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010667e:	e9 17 f5 ff ff       	jmp    80105b9a <alltraps>

80106683 <vector161>:
.globl vector161
vector161:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $161
80106685:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010668a:	e9 0b f5 ff ff       	jmp    80105b9a <alltraps>

8010668f <vector162>:
.globl vector162
vector162:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $162
80106691:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106696:	e9 ff f4 ff ff       	jmp    80105b9a <alltraps>

8010669b <vector163>:
.globl vector163
vector163:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $163
8010669d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801066a2:	e9 f3 f4 ff ff       	jmp    80105b9a <alltraps>

801066a7 <vector164>:
.globl vector164
vector164:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $164
801066a9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801066ae:	e9 e7 f4 ff ff       	jmp    80105b9a <alltraps>

801066b3 <vector165>:
.globl vector165
vector165:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $165
801066b5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801066ba:	e9 db f4 ff ff       	jmp    80105b9a <alltraps>

801066bf <vector166>:
.globl vector166
vector166:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $166
801066c1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801066c6:	e9 cf f4 ff ff       	jmp    80105b9a <alltraps>

801066cb <vector167>:
.globl vector167
vector167:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $167
801066cd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801066d2:	e9 c3 f4 ff ff       	jmp    80105b9a <alltraps>

801066d7 <vector168>:
.globl vector168
vector168:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $168
801066d9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801066de:	e9 b7 f4 ff ff       	jmp    80105b9a <alltraps>

801066e3 <vector169>:
.globl vector169
vector169:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $169
801066e5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801066ea:	e9 ab f4 ff ff       	jmp    80105b9a <alltraps>

801066ef <vector170>:
.globl vector170
vector170:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $170
801066f1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801066f6:	e9 9f f4 ff ff       	jmp    80105b9a <alltraps>

801066fb <vector171>:
.globl vector171
vector171:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $171
801066fd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106702:	e9 93 f4 ff ff       	jmp    80105b9a <alltraps>

80106707 <vector172>:
.globl vector172
vector172:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $172
80106709:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010670e:	e9 87 f4 ff ff       	jmp    80105b9a <alltraps>

80106713 <vector173>:
.globl vector173
vector173:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $173
80106715:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010671a:	e9 7b f4 ff ff       	jmp    80105b9a <alltraps>

8010671f <vector174>:
.globl vector174
vector174:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $174
80106721:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106726:	e9 6f f4 ff ff       	jmp    80105b9a <alltraps>

8010672b <vector175>:
.globl vector175
vector175:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $175
8010672d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106732:	e9 63 f4 ff ff       	jmp    80105b9a <alltraps>

80106737 <vector176>:
.globl vector176
vector176:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $176
80106739:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010673e:	e9 57 f4 ff ff       	jmp    80105b9a <alltraps>

80106743 <vector177>:
.globl vector177
vector177:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $177
80106745:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010674a:	e9 4b f4 ff ff       	jmp    80105b9a <alltraps>

8010674f <vector178>:
.globl vector178
vector178:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $178
80106751:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106756:	e9 3f f4 ff ff       	jmp    80105b9a <alltraps>

8010675b <vector179>:
.globl vector179
vector179:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $179
8010675d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106762:	e9 33 f4 ff ff       	jmp    80105b9a <alltraps>

80106767 <vector180>:
.globl vector180
vector180:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $180
80106769:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010676e:	e9 27 f4 ff ff       	jmp    80105b9a <alltraps>

80106773 <vector181>:
.globl vector181
vector181:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $181
80106775:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010677a:	e9 1b f4 ff ff       	jmp    80105b9a <alltraps>

8010677f <vector182>:
.globl vector182
vector182:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $182
80106781:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106786:	e9 0f f4 ff ff       	jmp    80105b9a <alltraps>

8010678b <vector183>:
.globl vector183
vector183:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $183
8010678d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106792:	e9 03 f4 ff ff       	jmp    80105b9a <alltraps>

80106797 <vector184>:
.globl vector184
vector184:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $184
80106799:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010679e:	e9 f7 f3 ff ff       	jmp    80105b9a <alltraps>

801067a3 <vector185>:
.globl vector185
vector185:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $185
801067a5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801067aa:	e9 eb f3 ff ff       	jmp    80105b9a <alltraps>

801067af <vector186>:
.globl vector186
vector186:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $186
801067b1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801067b6:	e9 df f3 ff ff       	jmp    80105b9a <alltraps>

801067bb <vector187>:
.globl vector187
vector187:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $187
801067bd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801067c2:	e9 d3 f3 ff ff       	jmp    80105b9a <alltraps>

801067c7 <vector188>:
.globl vector188
vector188:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $188
801067c9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801067ce:	e9 c7 f3 ff ff       	jmp    80105b9a <alltraps>

801067d3 <vector189>:
.globl vector189
vector189:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $189
801067d5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801067da:	e9 bb f3 ff ff       	jmp    80105b9a <alltraps>

801067df <vector190>:
.globl vector190
vector190:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $190
801067e1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801067e6:	e9 af f3 ff ff       	jmp    80105b9a <alltraps>

801067eb <vector191>:
.globl vector191
vector191:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $191
801067ed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801067f2:	e9 a3 f3 ff ff       	jmp    80105b9a <alltraps>

801067f7 <vector192>:
.globl vector192
vector192:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $192
801067f9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801067fe:	e9 97 f3 ff ff       	jmp    80105b9a <alltraps>

80106803 <vector193>:
.globl vector193
vector193:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $193
80106805:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010680a:	e9 8b f3 ff ff       	jmp    80105b9a <alltraps>

8010680f <vector194>:
.globl vector194
vector194:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $194
80106811:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106816:	e9 7f f3 ff ff       	jmp    80105b9a <alltraps>

8010681b <vector195>:
.globl vector195
vector195:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $195
8010681d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106822:	e9 73 f3 ff ff       	jmp    80105b9a <alltraps>

80106827 <vector196>:
.globl vector196
vector196:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $196
80106829:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010682e:	e9 67 f3 ff ff       	jmp    80105b9a <alltraps>

80106833 <vector197>:
.globl vector197
vector197:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $197
80106835:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010683a:	e9 5b f3 ff ff       	jmp    80105b9a <alltraps>

8010683f <vector198>:
.globl vector198
vector198:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $198
80106841:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106846:	e9 4f f3 ff ff       	jmp    80105b9a <alltraps>

8010684b <vector199>:
.globl vector199
vector199:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $199
8010684d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106852:	e9 43 f3 ff ff       	jmp    80105b9a <alltraps>

80106857 <vector200>:
.globl vector200
vector200:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $200
80106859:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010685e:	e9 37 f3 ff ff       	jmp    80105b9a <alltraps>

80106863 <vector201>:
.globl vector201
vector201:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $201
80106865:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010686a:	e9 2b f3 ff ff       	jmp    80105b9a <alltraps>

8010686f <vector202>:
.globl vector202
vector202:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $202
80106871:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106876:	e9 1f f3 ff ff       	jmp    80105b9a <alltraps>

8010687b <vector203>:
.globl vector203
vector203:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $203
8010687d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106882:	e9 13 f3 ff ff       	jmp    80105b9a <alltraps>

80106887 <vector204>:
.globl vector204
vector204:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $204
80106889:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010688e:	e9 07 f3 ff ff       	jmp    80105b9a <alltraps>

80106893 <vector205>:
.globl vector205
vector205:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $205
80106895:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010689a:	e9 fb f2 ff ff       	jmp    80105b9a <alltraps>

8010689f <vector206>:
.globl vector206
vector206:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $206
801068a1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801068a6:	e9 ef f2 ff ff       	jmp    80105b9a <alltraps>

801068ab <vector207>:
.globl vector207
vector207:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $207
801068ad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801068b2:	e9 e3 f2 ff ff       	jmp    80105b9a <alltraps>

801068b7 <vector208>:
.globl vector208
vector208:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $208
801068b9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801068be:	e9 d7 f2 ff ff       	jmp    80105b9a <alltraps>

801068c3 <vector209>:
.globl vector209
vector209:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $209
801068c5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801068ca:	e9 cb f2 ff ff       	jmp    80105b9a <alltraps>

801068cf <vector210>:
.globl vector210
vector210:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $210
801068d1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801068d6:	e9 bf f2 ff ff       	jmp    80105b9a <alltraps>

801068db <vector211>:
.globl vector211
vector211:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $211
801068dd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801068e2:	e9 b3 f2 ff ff       	jmp    80105b9a <alltraps>

801068e7 <vector212>:
.globl vector212
vector212:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $212
801068e9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801068ee:	e9 a7 f2 ff ff       	jmp    80105b9a <alltraps>

801068f3 <vector213>:
.globl vector213
vector213:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $213
801068f5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801068fa:	e9 9b f2 ff ff       	jmp    80105b9a <alltraps>

801068ff <vector214>:
.globl vector214
vector214:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $214
80106901:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106906:	e9 8f f2 ff ff       	jmp    80105b9a <alltraps>

8010690b <vector215>:
.globl vector215
vector215:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $215
8010690d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106912:	e9 83 f2 ff ff       	jmp    80105b9a <alltraps>

80106917 <vector216>:
.globl vector216
vector216:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $216
80106919:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010691e:	e9 77 f2 ff ff       	jmp    80105b9a <alltraps>

80106923 <vector217>:
.globl vector217
vector217:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $217
80106925:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010692a:	e9 6b f2 ff ff       	jmp    80105b9a <alltraps>

8010692f <vector218>:
.globl vector218
vector218:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $218
80106931:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106936:	e9 5f f2 ff ff       	jmp    80105b9a <alltraps>

8010693b <vector219>:
.globl vector219
vector219:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $219
8010693d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106942:	e9 53 f2 ff ff       	jmp    80105b9a <alltraps>

80106947 <vector220>:
.globl vector220
vector220:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $220
80106949:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010694e:	e9 47 f2 ff ff       	jmp    80105b9a <alltraps>

80106953 <vector221>:
.globl vector221
vector221:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $221
80106955:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010695a:	e9 3b f2 ff ff       	jmp    80105b9a <alltraps>

8010695f <vector222>:
.globl vector222
vector222:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $222
80106961:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106966:	e9 2f f2 ff ff       	jmp    80105b9a <alltraps>

8010696b <vector223>:
.globl vector223
vector223:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $223
8010696d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106972:	e9 23 f2 ff ff       	jmp    80105b9a <alltraps>

80106977 <vector224>:
.globl vector224
vector224:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $224
80106979:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010697e:	e9 17 f2 ff ff       	jmp    80105b9a <alltraps>

80106983 <vector225>:
.globl vector225
vector225:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $225
80106985:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010698a:	e9 0b f2 ff ff       	jmp    80105b9a <alltraps>

8010698f <vector226>:
.globl vector226
vector226:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $226
80106991:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106996:	e9 ff f1 ff ff       	jmp    80105b9a <alltraps>

8010699b <vector227>:
.globl vector227
vector227:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $227
8010699d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801069a2:	e9 f3 f1 ff ff       	jmp    80105b9a <alltraps>

801069a7 <vector228>:
.globl vector228
vector228:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $228
801069a9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801069ae:	e9 e7 f1 ff ff       	jmp    80105b9a <alltraps>

801069b3 <vector229>:
.globl vector229
vector229:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $229
801069b5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801069ba:	e9 db f1 ff ff       	jmp    80105b9a <alltraps>

801069bf <vector230>:
.globl vector230
vector230:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $230
801069c1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801069c6:	e9 cf f1 ff ff       	jmp    80105b9a <alltraps>

801069cb <vector231>:
.globl vector231
vector231:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $231
801069cd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801069d2:	e9 c3 f1 ff ff       	jmp    80105b9a <alltraps>

801069d7 <vector232>:
.globl vector232
vector232:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $232
801069d9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801069de:	e9 b7 f1 ff ff       	jmp    80105b9a <alltraps>

801069e3 <vector233>:
.globl vector233
vector233:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $233
801069e5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801069ea:	e9 ab f1 ff ff       	jmp    80105b9a <alltraps>

801069ef <vector234>:
.globl vector234
vector234:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $234
801069f1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801069f6:	e9 9f f1 ff ff       	jmp    80105b9a <alltraps>

801069fb <vector235>:
.globl vector235
vector235:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $235
801069fd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106a02:	e9 93 f1 ff ff       	jmp    80105b9a <alltraps>

80106a07 <vector236>:
.globl vector236
vector236:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $236
80106a09:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106a0e:	e9 87 f1 ff ff       	jmp    80105b9a <alltraps>

80106a13 <vector237>:
.globl vector237
vector237:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $237
80106a15:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106a1a:	e9 7b f1 ff ff       	jmp    80105b9a <alltraps>

80106a1f <vector238>:
.globl vector238
vector238:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $238
80106a21:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106a26:	e9 6f f1 ff ff       	jmp    80105b9a <alltraps>

80106a2b <vector239>:
.globl vector239
vector239:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $239
80106a2d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106a32:	e9 63 f1 ff ff       	jmp    80105b9a <alltraps>

80106a37 <vector240>:
.globl vector240
vector240:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $240
80106a39:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106a3e:	e9 57 f1 ff ff       	jmp    80105b9a <alltraps>

80106a43 <vector241>:
.globl vector241
vector241:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $241
80106a45:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106a4a:	e9 4b f1 ff ff       	jmp    80105b9a <alltraps>

80106a4f <vector242>:
.globl vector242
vector242:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $242
80106a51:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106a56:	e9 3f f1 ff ff       	jmp    80105b9a <alltraps>

80106a5b <vector243>:
.globl vector243
vector243:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $243
80106a5d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106a62:	e9 33 f1 ff ff       	jmp    80105b9a <alltraps>

80106a67 <vector244>:
.globl vector244
vector244:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $244
80106a69:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106a6e:	e9 27 f1 ff ff       	jmp    80105b9a <alltraps>

80106a73 <vector245>:
.globl vector245
vector245:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $245
80106a75:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106a7a:	e9 1b f1 ff ff       	jmp    80105b9a <alltraps>

80106a7f <vector246>:
.globl vector246
vector246:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $246
80106a81:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106a86:	e9 0f f1 ff ff       	jmp    80105b9a <alltraps>

80106a8b <vector247>:
.globl vector247
vector247:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $247
80106a8d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106a92:	e9 03 f1 ff ff       	jmp    80105b9a <alltraps>

80106a97 <vector248>:
.globl vector248
vector248:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $248
80106a99:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106a9e:	e9 f7 f0 ff ff       	jmp    80105b9a <alltraps>

80106aa3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $249
80106aa5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106aaa:	e9 eb f0 ff ff       	jmp    80105b9a <alltraps>

80106aaf <vector250>:
.globl vector250
vector250:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $250
80106ab1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106ab6:	e9 df f0 ff ff       	jmp    80105b9a <alltraps>

80106abb <vector251>:
.globl vector251
vector251:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $251
80106abd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106ac2:	e9 d3 f0 ff ff       	jmp    80105b9a <alltraps>

80106ac7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $252
80106ac9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106ace:	e9 c7 f0 ff ff       	jmp    80105b9a <alltraps>

80106ad3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $253
80106ad5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106ada:	e9 bb f0 ff ff       	jmp    80105b9a <alltraps>

80106adf <vector254>:
.globl vector254
vector254:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $254
80106ae1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106ae6:	e9 af f0 ff ff       	jmp    80105b9a <alltraps>

80106aeb <vector255>:
.globl vector255
vector255:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $255
80106aed:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106af2:	e9 a3 f0 ff ff       	jmp    80105b9a <alltraps>
80106af7:	66 90                	xchg   %ax,%ax
80106af9:	66 90                	xchg   %ax,%ax
80106afb:	66 90                	xchg   %ax,%ax
80106afd:	66 90                	xchg   %ax,%ax
80106aff:	90                   	nop

80106b00 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	57                   	push   %edi
80106b04:	56                   	push   %esi
80106b05:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106b06:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106b0c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b12:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106b15:	39 d3                	cmp    %edx,%ebx
80106b17:	73 56                	jae    80106b6f <deallocuvm.part.0+0x6f>
80106b19:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106b1c:	89 c6                	mov    %eax,%esi
80106b1e:	89 d7                	mov    %edx,%edi
80106b20:	eb 12                	jmp    80106b34 <deallocuvm.part.0+0x34>
80106b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106b28:	83 c2 01             	add    $0x1,%edx
80106b2b:	89 d3                	mov    %edx,%ebx
80106b2d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106b30:	39 fb                	cmp    %edi,%ebx
80106b32:	73 38                	jae    80106b6c <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80106b34:	89 da                	mov    %ebx,%edx
80106b36:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106b39:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106b3c:	a8 01                	test   $0x1,%al
80106b3e:	74 e8                	je     80106b28 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106b40:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106b42:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106b47:	c1 e9 0a             	shr    $0xa,%ecx
80106b4a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106b50:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106b57:	85 c0                	test   %eax,%eax
80106b59:	74 cd                	je     80106b28 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80106b5b:	8b 10                	mov    (%eax),%edx
80106b5d:	f6 c2 01             	test   $0x1,%dl
80106b60:	75 1e                	jne    80106b80 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80106b62:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b68:	39 fb                	cmp    %edi,%ebx
80106b6a:	72 c8                	jb     80106b34 <deallocuvm.part.0+0x34>
80106b6c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106b6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b72:	89 c8                	mov    %ecx,%eax
80106b74:	5b                   	pop    %ebx
80106b75:	5e                   	pop    %esi
80106b76:	5f                   	pop    %edi
80106b77:	5d                   	pop    %ebp
80106b78:	c3                   	ret
80106b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106b80:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106b86:	74 26                	je     80106bae <deallocuvm.part.0+0xae>
      kfree(v);
80106b88:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106b8b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106b91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106b94:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106b9a:	52                   	push   %edx
80106b9b:	e8 60 bc ff ff       	call   80102800 <kfree>
      *pte = 0;
80106ba0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106ba3:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106ba6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106bac:	eb 82                	jmp    80106b30 <deallocuvm.part.0+0x30>
        panic("kfree");
80106bae:	83 ec 0c             	sub    $0xc,%esp
80106bb1:	68 8c 76 10 80       	push   $0x8010768c
80106bb6:	e8 c5 97 ff ff       	call   80100380 <panic>
80106bbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106bc0 <mappages>:
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	57                   	push   %edi
80106bc4:	56                   	push   %esi
80106bc5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106bc6:	89 d3                	mov    %edx,%ebx
80106bc8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106bce:	83 ec 1c             	sub    $0x1c,%esp
80106bd1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106bd4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106bd8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106bdd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106be0:	8b 45 08             	mov    0x8(%ebp),%eax
80106be3:	29 d8                	sub    %ebx,%eax
80106be5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106be8:	eb 3f                	jmp    80106c29 <mappages+0x69>
80106bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106bf0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106bf2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106bf7:	c1 ea 0a             	shr    $0xa,%edx
80106bfa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106c00:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106c07:	85 c0                	test   %eax,%eax
80106c09:	74 75                	je     80106c80 <mappages+0xc0>
    if(*pte & PTE_P)
80106c0b:	f6 00 01             	testb  $0x1,(%eax)
80106c0e:	0f 85 86 00 00 00    	jne    80106c9a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106c14:	0b 75 0c             	or     0xc(%ebp),%esi
80106c17:	83 ce 01             	or     $0x1,%esi
80106c1a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106c1c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106c1f:	39 c3                	cmp    %eax,%ebx
80106c21:	74 6d                	je     80106c90 <mappages+0xd0>
    a += PGSIZE;
80106c23:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106c29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106c2c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106c2f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80106c32:	89 d8                	mov    %ebx,%eax
80106c34:	c1 e8 16             	shr    $0x16,%eax
80106c37:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106c3a:	8b 07                	mov    (%edi),%eax
80106c3c:	a8 01                	test   $0x1,%al
80106c3e:	75 b0                	jne    80106bf0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106c40:	e8 7b bd ff ff       	call   801029c0 <kalloc>
80106c45:	85 c0                	test   %eax,%eax
80106c47:	74 37                	je     80106c80 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106c49:	83 ec 04             	sub    $0x4,%esp
80106c4c:	68 00 10 00 00       	push   $0x1000
80106c51:	6a 00                	push   $0x0
80106c53:	50                   	push   %eax
80106c54:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106c57:	e8 a4 dd ff ff       	call   80104a00 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c5c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106c5f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c62:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106c68:	83 c8 07             	or     $0x7,%eax
80106c6b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106c6d:	89 d8                	mov    %ebx,%eax
80106c6f:	c1 e8 0a             	shr    $0xa,%eax
80106c72:	25 fc 0f 00 00       	and    $0xffc,%eax
80106c77:	01 d0                	add    %edx,%eax
80106c79:	eb 90                	jmp    80106c0b <mappages+0x4b>
80106c7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80106c80:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106c83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c88:	5b                   	pop    %ebx
80106c89:	5e                   	pop    %esi
80106c8a:	5f                   	pop    %edi
80106c8b:	5d                   	pop    %ebp
80106c8c:	c3                   	ret
80106c8d:	8d 76 00             	lea    0x0(%esi),%esi
80106c90:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106c93:	31 c0                	xor    %eax,%eax
}
80106c95:	5b                   	pop    %ebx
80106c96:	5e                   	pop    %esi
80106c97:	5f                   	pop    %edi
80106c98:	5d                   	pop    %ebp
80106c99:	c3                   	ret
      panic("remap");
80106c9a:	83 ec 0c             	sub    $0xc,%esp
80106c9d:	68 c0 78 10 80       	push   $0x801078c0
80106ca2:	e8 d9 96 ff ff       	call   80100380 <panic>
80106ca7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106cae:	00 
80106caf:	90                   	nop

80106cb0 <seginit>:
{
80106cb0:	55                   	push   %ebp
80106cb1:	89 e5                	mov    %esp,%ebp
80106cb3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106cb6:	e8 e5 cf ff ff       	call   80103ca0 <cpuid>
  pd[0] = size-1;
80106cbb:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106cc0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106cc6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106cca:	c7 80 38 18 11 80 ff 	movl   $0xffff,-0x7feee7c8(%eax)
80106cd1:	ff 00 00 
80106cd4:	c7 80 3c 18 11 80 00 	movl   $0xcf9a00,-0x7feee7c4(%eax)
80106cdb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106cde:	c7 80 40 18 11 80 ff 	movl   $0xffff,-0x7feee7c0(%eax)
80106ce5:	ff 00 00 
80106ce8:	c7 80 44 18 11 80 00 	movl   $0xcf9200,-0x7feee7bc(%eax)
80106cef:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106cf2:	c7 80 48 18 11 80 ff 	movl   $0xffff,-0x7feee7b8(%eax)
80106cf9:	ff 00 00 
80106cfc:	c7 80 4c 18 11 80 00 	movl   $0xcffa00,-0x7feee7b4(%eax)
80106d03:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106d06:	c7 80 50 18 11 80 ff 	movl   $0xffff,-0x7feee7b0(%eax)
80106d0d:	ff 00 00 
80106d10:	c7 80 54 18 11 80 00 	movl   $0xcff200,-0x7feee7ac(%eax)
80106d17:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106d1a:	05 30 18 11 80       	add    $0x80111830,%eax
  pd[1] = (uint)p;
80106d1f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106d23:	c1 e8 10             	shr    $0x10,%eax
80106d26:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106d2a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106d2d:	0f 01 10             	lgdtl  (%eax)
}
80106d30:	c9                   	leave
80106d31:	c3                   	ret
80106d32:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d39:	00 
80106d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d40 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d40:	a1 e4 44 11 80       	mov    0x801144e4,%eax
80106d45:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d4a:	0f 22 d8             	mov    %eax,%cr3
}
80106d4d:	c3                   	ret
80106d4e:	66 90                	xchg   %ax,%ax

80106d50 <switchuvm>:
{
80106d50:	55                   	push   %ebp
80106d51:	89 e5                	mov    %esp,%ebp
80106d53:	57                   	push   %edi
80106d54:	56                   	push   %esi
80106d55:	53                   	push   %ebx
80106d56:	83 ec 1c             	sub    $0x1c,%esp
80106d59:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106d5c:	85 f6                	test   %esi,%esi
80106d5e:	0f 84 cb 00 00 00    	je     80106e2f <switchuvm+0xdf>
  if(p->kstack == 0)
80106d64:	8b 46 08             	mov    0x8(%esi),%eax
80106d67:	85 c0                	test   %eax,%eax
80106d69:	0f 84 da 00 00 00    	je     80106e49 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106d6f:	8b 46 04             	mov    0x4(%esi),%eax
80106d72:	85 c0                	test   %eax,%eax
80106d74:	0f 84 c2 00 00 00    	je     80106e3c <switchuvm+0xec>
  pushcli();
80106d7a:	e8 31 da ff ff       	call   801047b0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d7f:	e8 bc ce ff ff       	call   80103c40 <mycpu>
80106d84:	89 c3                	mov    %eax,%ebx
80106d86:	e8 b5 ce ff ff       	call   80103c40 <mycpu>
80106d8b:	89 c7                	mov    %eax,%edi
80106d8d:	e8 ae ce ff ff       	call   80103c40 <mycpu>
80106d92:	83 c7 08             	add    $0x8,%edi
80106d95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d98:	e8 a3 ce ff ff       	call   80103c40 <mycpu>
80106d9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106da0:	ba 67 00 00 00       	mov    $0x67,%edx
80106da5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106dac:	83 c0 08             	add    $0x8,%eax
80106daf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106db6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106dbb:	83 c1 08             	add    $0x8,%ecx
80106dbe:	c1 e8 18             	shr    $0x18,%eax
80106dc1:	c1 e9 10             	shr    $0x10,%ecx
80106dc4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106dca:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106dd0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106dd5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106ddc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106de1:	e8 5a ce ff ff       	call   80103c40 <mycpu>
80106de6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106ded:	e8 4e ce ff ff       	call   80103c40 <mycpu>
80106df2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106df6:	8b 5e 08             	mov    0x8(%esi),%ebx
80106df9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106dff:	e8 3c ce ff ff       	call   80103c40 <mycpu>
80106e04:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106e07:	e8 34 ce ff ff       	call   80103c40 <mycpu>
80106e0c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106e10:	b8 28 00 00 00       	mov    $0x28,%eax
80106e15:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106e18:	8b 46 04             	mov    0x4(%esi),%eax
80106e1b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106e20:	0f 22 d8             	mov    %eax,%cr3
}
80106e23:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e26:	5b                   	pop    %ebx
80106e27:	5e                   	pop    %esi
80106e28:	5f                   	pop    %edi
80106e29:	5d                   	pop    %ebp
  popcli();
80106e2a:	e9 d1 d9 ff ff       	jmp    80104800 <popcli>
    panic("switchuvm: no process");
80106e2f:	83 ec 0c             	sub    $0xc,%esp
80106e32:	68 c6 78 10 80       	push   $0x801078c6
80106e37:	e8 44 95 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106e3c:	83 ec 0c             	sub    $0xc,%esp
80106e3f:	68 f1 78 10 80       	push   $0x801078f1
80106e44:	e8 37 95 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106e49:	83 ec 0c             	sub    $0xc,%esp
80106e4c:	68 dc 78 10 80       	push   $0x801078dc
80106e51:	e8 2a 95 ff ff       	call   80100380 <panic>
80106e56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e5d:	00 
80106e5e:	66 90                	xchg   %ax,%ax

80106e60 <inituvm>:
{
80106e60:	55                   	push   %ebp
80106e61:	89 e5                	mov    %esp,%ebp
80106e63:	57                   	push   %edi
80106e64:	56                   	push   %esi
80106e65:	53                   	push   %ebx
80106e66:	83 ec 1c             	sub    $0x1c,%esp
80106e69:	8b 45 08             	mov    0x8(%ebp),%eax
80106e6c:	8b 75 10             	mov    0x10(%ebp),%esi
80106e6f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106e72:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106e75:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106e7b:	77 49                	ja     80106ec6 <inituvm+0x66>
  mem = kalloc();
80106e7d:	e8 3e bb ff ff       	call   801029c0 <kalloc>
  memset(mem, 0, PGSIZE);
80106e82:	83 ec 04             	sub    $0x4,%esp
80106e85:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106e8a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106e8c:	6a 00                	push   $0x0
80106e8e:	50                   	push   %eax
80106e8f:	e8 6c db ff ff       	call   80104a00 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106e94:	58                   	pop    %eax
80106e95:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e9b:	5a                   	pop    %edx
80106e9c:	6a 06                	push   $0x6
80106e9e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ea3:	31 d2                	xor    %edx,%edx
80106ea5:	50                   	push   %eax
80106ea6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ea9:	e8 12 fd ff ff       	call   80106bc0 <mappages>
  memmove(mem, init, sz);
80106eae:	83 c4 10             	add    $0x10,%esp
80106eb1:	89 75 10             	mov    %esi,0x10(%ebp)
80106eb4:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106eb7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ebd:	5b                   	pop    %ebx
80106ebe:	5e                   	pop    %esi
80106ebf:	5f                   	pop    %edi
80106ec0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106ec1:	e9 ca db ff ff       	jmp    80104a90 <memmove>
    panic("inituvm: more than a page");
80106ec6:	83 ec 0c             	sub    $0xc,%esp
80106ec9:	68 05 79 10 80       	push   $0x80107905
80106ece:	e8 ad 94 ff ff       	call   80100380 <panic>
80106ed3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106eda:	00 
80106edb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106ee0 <loaduvm>:
{
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	57                   	push   %edi
80106ee4:	56                   	push   %esi
80106ee5:	53                   	push   %ebx
80106ee6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106ee9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
80106eec:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
80106eef:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106ef5:	0f 85 a2 00 00 00    	jne    80106f9d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
80106efb:	85 ff                	test   %edi,%edi
80106efd:	74 7d                	je     80106f7c <loaduvm+0x9c>
80106eff:	90                   	nop
  pde = &pgdir[PDX(va)];
80106f00:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106f03:	8b 55 08             	mov    0x8(%ebp),%edx
80106f06:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80106f08:	89 c1                	mov    %eax,%ecx
80106f0a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106f0d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80106f10:	f6 c1 01             	test   $0x1,%cl
80106f13:	75 13                	jne    80106f28 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80106f15:	83 ec 0c             	sub    $0xc,%esp
80106f18:	68 1f 79 10 80       	push   $0x8010791f
80106f1d:	e8 5e 94 ff ff       	call   80100380 <panic>
80106f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106f28:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f2b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106f31:	25 fc 0f 00 00       	and    $0xffc,%eax
80106f36:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106f3d:	85 c9                	test   %ecx,%ecx
80106f3f:	74 d4                	je     80106f15 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80106f41:	89 fb                	mov    %edi,%ebx
80106f43:	b8 00 10 00 00       	mov    $0x1000,%eax
80106f48:	29 f3                	sub    %esi,%ebx
80106f4a:	39 c3                	cmp    %eax,%ebx
80106f4c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f4f:	53                   	push   %ebx
80106f50:	8b 45 14             	mov    0x14(%ebp),%eax
80106f53:	01 f0                	add    %esi,%eax
80106f55:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80106f56:	8b 01                	mov    (%ecx),%eax
80106f58:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f5d:	05 00 00 00 80       	add    $0x80000000,%eax
80106f62:	50                   	push   %eax
80106f63:	ff 75 10             	push   0x10(%ebp)
80106f66:	e8 a5 ae ff ff       	call   80101e10 <readi>
80106f6b:	83 c4 10             	add    $0x10,%esp
80106f6e:	39 d8                	cmp    %ebx,%eax
80106f70:	75 1e                	jne    80106f90 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80106f72:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106f78:	39 fe                	cmp    %edi,%esi
80106f7a:	72 84                	jb     80106f00 <loaduvm+0x20>
}
80106f7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f7f:	31 c0                	xor    %eax,%eax
}
80106f81:	5b                   	pop    %ebx
80106f82:	5e                   	pop    %esi
80106f83:	5f                   	pop    %edi
80106f84:	5d                   	pop    %ebp
80106f85:	c3                   	ret
80106f86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f8d:	00 
80106f8e:	66 90                	xchg   %ax,%ax
80106f90:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f98:	5b                   	pop    %ebx
80106f99:	5e                   	pop    %esi
80106f9a:	5f                   	pop    %edi
80106f9b:	5d                   	pop    %ebp
80106f9c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
80106f9d:	83 ec 0c             	sub    $0xc,%esp
80106fa0:	68 98 7b 10 80       	push   $0x80107b98
80106fa5:	e8 d6 93 ff ff       	call   80100380 <panic>
80106faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fb0 <allocuvm>:
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	53                   	push   %ebx
80106fb6:	83 ec 1c             	sub    $0x1c,%esp
80106fb9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
80106fbc:	85 f6                	test   %esi,%esi
80106fbe:	0f 88 98 00 00 00    	js     8010705c <allocuvm+0xac>
80106fc4:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80106fc6:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106fc9:	0f 82 a1 00 00 00    	jb     80107070 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
80106fd2:	05 ff 0f 00 00       	add    $0xfff,%eax
80106fd7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106fdc:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
80106fde:	39 f0                	cmp    %esi,%eax
80106fe0:	0f 83 8d 00 00 00    	jae    80107073 <allocuvm+0xc3>
80106fe6:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80106fe9:	eb 44                	jmp    8010702f <allocuvm+0x7f>
80106feb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106ff0:	83 ec 04             	sub    $0x4,%esp
80106ff3:	68 00 10 00 00       	push   $0x1000
80106ff8:	6a 00                	push   $0x0
80106ffa:	50                   	push   %eax
80106ffb:	e8 00 da ff ff       	call   80104a00 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107000:	58                   	pop    %eax
80107001:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107007:	5a                   	pop    %edx
80107008:	6a 06                	push   $0x6
8010700a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010700f:	89 fa                	mov    %edi,%edx
80107011:	50                   	push   %eax
80107012:	8b 45 08             	mov    0x8(%ebp),%eax
80107015:	e8 a6 fb ff ff       	call   80106bc0 <mappages>
8010701a:	83 c4 10             	add    $0x10,%esp
8010701d:	85 c0                	test   %eax,%eax
8010701f:	78 5f                	js     80107080 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80107021:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107027:	39 f7                	cmp    %esi,%edi
80107029:	0f 83 89 00 00 00    	jae    801070b8 <allocuvm+0x108>
    mem = kalloc();
8010702f:	e8 8c b9 ff ff       	call   801029c0 <kalloc>
80107034:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107036:	85 c0                	test   %eax,%eax
80107038:	75 b6                	jne    80106ff0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010703a:	83 ec 0c             	sub    $0xc,%esp
8010703d:	68 3d 79 10 80       	push   $0x8010793d
80107042:	e8 19 96 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80107047:	83 c4 10             	add    $0x10,%esp
8010704a:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010704d:	74 0d                	je     8010705c <allocuvm+0xac>
8010704f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107052:	8b 45 08             	mov    0x8(%ebp),%eax
80107055:	89 f2                	mov    %esi,%edx
80107057:	e8 a4 fa ff ff       	call   80106b00 <deallocuvm.part.0>
    return 0;
8010705c:	31 d2                	xor    %edx,%edx
}
8010705e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107061:	89 d0                	mov    %edx,%eax
80107063:	5b                   	pop    %ebx
80107064:	5e                   	pop    %esi
80107065:	5f                   	pop    %edi
80107066:	5d                   	pop    %ebp
80107067:	c3                   	ret
80107068:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010706f:	00 
    return oldsz;
80107070:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80107073:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107076:	89 d0                	mov    %edx,%eax
80107078:	5b                   	pop    %ebx
80107079:	5e                   	pop    %esi
8010707a:	5f                   	pop    %edi
8010707b:	5d                   	pop    %ebp
8010707c:	c3                   	ret
8010707d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107080:	83 ec 0c             	sub    $0xc,%esp
80107083:	68 55 79 10 80       	push   $0x80107955
80107088:	e8 d3 95 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010708d:	83 c4 10             	add    $0x10,%esp
80107090:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107093:	74 0d                	je     801070a2 <allocuvm+0xf2>
80107095:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107098:	8b 45 08             	mov    0x8(%ebp),%eax
8010709b:	89 f2                	mov    %esi,%edx
8010709d:	e8 5e fa ff ff       	call   80106b00 <deallocuvm.part.0>
      kfree(mem);
801070a2:	83 ec 0c             	sub    $0xc,%esp
801070a5:	53                   	push   %ebx
801070a6:	e8 55 b7 ff ff       	call   80102800 <kfree>
      return 0;
801070ab:	83 c4 10             	add    $0x10,%esp
    return 0;
801070ae:	31 d2                	xor    %edx,%edx
801070b0:	eb ac                	jmp    8010705e <allocuvm+0xae>
801070b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
801070bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070be:	5b                   	pop    %ebx
801070bf:	5e                   	pop    %esi
801070c0:	89 d0                	mov    %edx,%eax
801070c2:	5f                   	pop    %edi
801070c3:	5d                   	pop    %ebp
801070c4:	c3                   	ret
801070c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070cc:	00 
801070cd:	8d 76 00             	lea    0x0(%esi),%esi

801070d0 <deallocuvm>:
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	8b 55 0c             	mov    0xc(%ebp),%edx
801070d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801070d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801070dc:	39 d1                	cmp    %edx,%ecx
801070de:	73 10                	jae    801070f0 <deallocuvm+0x20>
}
801070e0:	5d                   	pop    %ebp
801070e1:	e9 1a fa ff ff       	jmp    80106b00 <deallocuvm.part.0>
801070e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070ed:	00 
801070ee:	66 90                	xchg   %ax,%ax
801070f0:	89 d0                	mov    %edx,%eax
801070f2:	5d                   	pop    %ebp
801070f3:	c3                   	ret
801070f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070fb:	00 
801070fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107100 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107100:	55                   	push   %ebp
80107101:	89 e5                	mov    %esp,%ebp
80107103:	57                   	push   %edi
80107104:	56                   	push   %esi
80107105:	53                   	push   %ebx
80107106:	83 ec 0c             	sub    $0xc,%esp
80107109:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010710c:	85 f6                	test   %esi,%esi
8010710e:	74 59                	je     80107169 <freevm+0x69>
  if(newsz >= oldsz)
80107110:	31 c9                	xor    %ecx,%ecx
80107112:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107117:	89 f0                	mov    %esi,%eax
80107119:	89 f3                	mov    %esi,%ebx
8010711b:	e8 e0 f9 ff ff       	call   80106b00 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107120:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107126:	eb 0f                	jmp    80107137 <freevm+0x37>
80107128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010712f:	00 
80107130:	83 c3 04             	add    $0x4,%ebx
80107133:	39 fb                	cmp    %edi,%ebx
80107135:	74 23                	je     8010715a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107137:	8b 03                	mov    (%ebx),%eax
80107139:	a8 01                	test   $0x1,%al
8010713b:	74 f3                	je     80107130 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010713d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107142:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107145:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107148:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010714d:	50                   	push   %eax
8010714e:	e8 ad b6 ff ff       	call   80102800 <kfree>
80107153:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107156:	39 fb                	cmp    %edi,%ebx
80107158:	75 dd                	jne    80107137 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010715a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010715d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107160:	5b                   	pop    %ebx
80107161:	5e                   	pop    %esi
80107162:	5f                   	pop    %edi
80107163:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107164:	e9 97 b6 ff ff       	jmp    80102800 <kfree>
    panic("freevm: no pgdir");
80107169:	83 ec 0c             	sub    $0xc,%esp
8010716c:	68 71 79 10 80       	push   $0x80107971
80107171:	e8 0a 92 ff ff       	call   80100380 <panic>
80107176:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010717d:	00 
8010717e:	66 90                	xchg   %ax,%ax

80107180 <setupkvm>:
{
80107180:	55                   	push   %ebp
80107181:	89 e5                	mov    %esp,%ebp
80107183:	56                   	push   %esi
80107184:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107185:	e8 36 b8 ff ff       	call   801029c0 <kalloc>
8010718a:	85 c0                	test   %eax,%eax
8010718c:	74 5e                	je     801071ec <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
8010718e:	83 ec 04             	sub    $0x4,%esp
80107191:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107193:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80107198:	68 00 10 00 00       	push   $0x1000
8010719d:	6a 00                	push   $0x0
8010719f:	50                   	push   %eax
801071a0:	e8 5b d8 ff ff       	call   80104a00 <memset>
801071a5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801071a8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801071ab:	83 ec 08             	sub    $0x8,%esp
801071ae:	8b 4b 08             	mov    0x8(%ebx),%ecx
801071b1:	8b 13                	mov    (%ebx),%edx
801071b3:	ff 73 0c             	push   0xc(%ebx)
801071b6:	50                   	push   %eax
801071b7:	29 c1                	sub    %eax,%ecx
801071b9:	89 f0                	mov    %esi,%eax
801071bb:	e8 00 fa ff ff       	call   80106bc0 <mappages>
801071c0:	83 c4 10             	add    $0x10,%esp
801071c3:	85 c0                	test   %eax,%eax
801071c5:	78 19                	js     801071e0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801071c7:	83 c3 10             	add    $0x10,%ebx
801071ca:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
801071d0:	75 d6                	jne    801071a8 <setupkvm+0x28>
}
801071d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801071d5:	89 f0                	mov    %esi,%eax
801071d7:	5b                   	pop    %ebx
801071d8:	5e                   	pop    %esi
801071d9:	5d                   	pop    %ebp
801071da:	c3                   	ret
801071db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801071e0:	83 ec 0c             	sub    $0xc,%esp
801071e3:	56                   	push   %esi
801071e4:	e8 17 ff ff ff       	call   80107100 <freevm>
      return 0;
801071e9:	83 c4 10             	add    $0x10,%esp
}
801071ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
801071ef:	31 f6                	xor    %esi,%esi
}
801071f1:	89 f0                	mov    %esi,%eax
801071f3:	5b                   	pop    %ebx
801071f4:	5e                   	pop    %esi
801071f5:	5d                   	pop    %ebp
801071f6:	c3                   	ret
801071f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801071fe:	00 
801071ff:	90                   	nop

80107200 <kvmalloc>:
{
80107200:	55                   	push   %ebp
80107201:	89 e5                	mov    %esp,%ebp
80107203:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107206:	e8 75 ff ff ff       	call   80107180 <setupkvm>
8010720b:	a3 e4 44 11 80       	mov    %eax,0x801144e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107210:	05 00 00 00 80       	add    $0x80000000,%eax
80107215:	0f 22 d8             	mov    %eax,%cr3
}
80107218:	c9                   	leave
80107219:	c3                   	ret
8010721a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107220 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107220:	55                   	push   %ebp
80107221:	89 e5                	mov    %esp,%ebp
80107223:	83 ec 08             	sub    $0x8,%esp
80107226:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107229:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010722c:	89 c1                	mov    %eax,%ecx
8010722e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107231:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107234:	f6 c2 01             	test   $0x1,%dl
80107237:	75 17                	jne    80107250 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107239:	83 ec 0c             	sub    $0xc,%esp
8010723c:	68 82 79 10 80       	push   $0x80107982
80107241:	e8 3a 91 ff ff       	call   80100380 <panic>
80107246:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010724d:	00 
8010724e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107250:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107253:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107259:	25 fc 0f 00 00       	and    $0xffc,%eax
8010725e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107265:	85 c0                	test   %eax,%eax
80107267:	74 d0                	je     80107239 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107269:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010726c:	c9                   	leave
8010726d:	c3                   	ret
8010726e:	66 90                	xchg   %ax,%ax

80107270 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	57                   	push   %edi
80107274:	56                   	push   %esi
80107275:	53                   	push   %ebx
80107276:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107279:	e8 02 ff ff ff       	call   80107180 <setupkvm>
8010727e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107281:	85 c0                	test   %eax,%eax
80107283:	0f 84 e9 00 00 00    	je     80107372 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107289:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010728c:	85 c9                	test   %ecx,%ecx
8010728e:	0f 84 b2 00 00 00    	je     80107346 <copyuvm+0xd6>
80107294:	31 f6                	xor    %esi,%esi
80107296:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010729d:	00 
8010729e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
801072a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801072a3:	89 f0                	mov    %esi,%eax
801072a5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801072a8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801072ab:	a8 01                	test   $0x1,%al
801072ad:	75 11                	jne    801072c0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801072af:	83 ec 0c             	sub    $0xc,%esp
801072b2:	68 8c 79 10 80       	push   $0x8010798c
801072b7:	e8 c4 90 ff ff       	call   80100380 <panic>
801072bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801072c0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801072c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801072c7:	c1 ea 0a             	shr    $0xa,%edx
801072ca:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801072d0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801072d7:	85 c0                	test   %eax,%eax
801072d9:	74 d4                	je     801072af <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801072db:	8b 00                	mov    (%eax),%eax
801072dd:	a8 01                	test   $0x1,%al
801072df:	0f 84 9f 00 00 00    	je     80107384 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801072e5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801072e7:	25 ff 0f 00 00       	and    $0xfff,%eax
801072ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801072ef:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801072f5:	e8 c6 b6 ff ff       	call   801029c0 <kalloc>
801072fa:	89 c3                	mov    %eax,%ebx
801072fc:	85 c0                	test   %eax,%eax
801072fe:	74 64                	je     80107364 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107300:	83 ec 04             	sub    $0x4,%esp
80107303:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107309:	68 00 10 00 00       	push   $0x1000
8010730e:	57                   	push   %edi
8010730f:	50                   	push   %eax
80107310:	e8 7b d7 ff ff       	call   80104a90 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107315:	58                   	pop    %eax
80107316:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010731c:	5a                   	pop    %edx
8010731d:	ff 75 e4             	push   -0x1c(%ebp)
80107320:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107325:	89 f2                	mov    %esi,%edx
80107327:	50                   	push   %eax
80107328:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010732b:	e8 90 f8 ff ff       	call   80106bc0 <mappages>
80107330:	83 c4 10             	add    $0x10,%esp
80107333:	85 c0                	test   %eax,%eax
80107335:	78 21                	js     80107358 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107337:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010733d:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107340:	0f 82 5a ff ff ff    	jb     801072a0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107346:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107349:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010734c:	5b                   	pop    %ebx
8010734d:	5e                   	pop    %esi
8010734e:	5f                   	pop    %edi
8010734f:	5d                   	pop    %ebp
80107350:	c3                   	ret
80107351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107358:	83 ec 0c             	sub    $0xc,%esp
8010735b:	53                   	push   %ebx
8010735c:	e8 9f b4 ff ff       	call   80102800 <kfree>
      goto bad;
80107361:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107364:	83 ec 0c             	sub    $0xc,%esp
80107367:	ff 75 e0             	push   -0x20(%ebp)
8010736a:	e8 91 fd ff ff       	call   80107100 <freevm>
  return 0;
8010736f:	83 c4 10             	add    $0x10,%esp
    return 0;
80107372:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107379:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010737c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010737f:	5b                   	pop    %ebx
80107380:	5e                   	pop    %esi
80107381:	5f                   	pop    %edi
80107382:	5d                   	pop    %ebp
80107383:	c3                   	ret
      panic("copyuvm: page not present");
80107384:	83 ec 0c             	sub    $0xc,%esp
80107387:	68 a6 79 10 80       	push   $0x801079a6
8010738c:	e8 ef 8f ff ff       	call   80100380 <panic>
80107391:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107398:	00 
80107399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073a0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801073a6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801073a9:	89 c1                	mov    %eax,%ecx
801073ab:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801073ae:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801073b1:	f6 c2 01             	test   $0x1,%dl
801073b4:	0f 84 f8 00 00 00    	je     801074b2 <uva2ka.cold>
  return &pgtab[PTX(va)];
801073ba:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073bd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801073c3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801073c4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801073c9:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
801073d0:	89 d0                	mov    %edx,%eax
801073d2:	f7 d2                	not    %edx
801073d4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073d9:	05 00 00 00 80       	add    $0x80000000,%eax
801073de:	83 e2 05             	and    $0x5,%edx
801073e1:	ba 00 00 00 00       	mov    $0x0,%edx
801073e6:	0f 45 c2             	cmovne %edx,%eax
}
801073e9:	c3                   	ret
801073ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801073f0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	57                   	push   %edi
801073f4:	56                   	push   %esi
801073f5:	53                   	push   %ebx
801073f6:	83 ec 0c             	sub    $0xc,%esp
801073f9:	8b 75 14             	mov    0x14(%ebp),%esi
801073fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801073ff:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107402:	85 f6                	test   %esi,%esi
80107404:	75 51                	jne    80107457 <copyout+0x67>
80107406:	e9 9d 00 00 00       	jmp    801074a8 <copyout+0xb8>
8010740b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107410:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107416:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010741c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107422:	74 74                	je     80107498 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
80107424:	89 fb                	mov    %edi,%ebx
80107426:	29 c3                	sub    %eax,%ebx
80107428:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010742e:	39 f3                	cmp    %esi,%ebx
80107430:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107433:	29 f8                	sub    %edi,%eax
80107435:	83 ec 04             	sub    $0x4,%esp
80107438:	01 c1                	add    %eax,%ecx
8010743a:	53                   	push   %ebx
8010743b:	52                   	push   %edx
8010743c:	89 55 10             	mov    %edx,0x10(%ebp)
8010743f:	51                   	push   %ecx
80107440:	e8 4b d6 ff ff       	call   80104a90 <memmove>
    len -= n;
    buf += n;
80107445:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107448:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010744e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107451:	01 da                	add    %ebx,%edx
  while(len > 0){
80107453:	29 de                	sub    %ebx,%esi
80107455:	74 51                	je     801074a8 <copyout+0xb8>
  if(*pde & PTE_P){
80107457:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010745a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010745c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010745e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107461:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107467:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010746a:	f6 c1 01             	test   $0x1,%cl
8010746d:	0f 84 46 00 00 00    	je     801074b9 <copyout.cold>
  return &pgtab[PTX(va)];
80107473:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107475:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010747b:	c1 eb 0c             	shr    $0xc,%ebx
8010747e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107484:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010748b:	89 d9                	mov    %ebx,%ecx
8010748d:	f7 d1                	not    %ecx
8010748f:	83 e1 05             	and    $0x5,%ecx
80107492:	0f 84 78 ff ff ff    	je     80107410 <copyout+0x20>
  }
  return 0;
}
80107498:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010749b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801074a0:	5b                   	pop    %ebx
801074a1:	5e                   	pop    %esi
801074a2:	5f                   	pop    %edi
801074a3:	5d                   	pop    %ebp
801074a4:	c3                   	ret
801074a5:	8d 76 00             	lea    0x0(%esi),%esi
801074a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801074ab:	31 c0                	xor    %eax,%eax
}
801074ad:	5b                   	pop    %ebx
801074ae:	5e                   	pop    %esi
801074af:	5f                   	pop    %edi
801074b0:	5d                   	pop    %ebp
801074b1:	c3                   	ret

801074b2 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801074b2:	a1 00 00 00 00       	mov    0x0,%eax
801074b7:	0f 0b                	ud2

801074b9 <copyout.cold>:
801074b9:	a1 00 00 00 00       	mov    0x0,%eax
801074be:	0f 0b                	ud2
