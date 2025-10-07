
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
80100028:	bc d0 54 11 80       	mov    $0x801154d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 50 31 10 80       	mov    $0x80103150,%eax
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
8010004c:	68 80 72 10 80       	push   $0x80107280
80100051:	68 20 a5 10 80       	push   $0x8010a520
80100056:	e8 75 44 00 00       	call   801044d0 <initlock>
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
80100092:	68 87 72 10 80       	push   $0x80107287
80100097:	50                   	push   %eax
80100098:	e8 03 43 00 00       	call   801043a0 <initsleeplock>
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
801000e4:	e8 d7 45 00 00       	call   801046c0 <acquire>
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
80100162:	e8 f9 44 00 00       	call   80104660 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 42 00 00       	call   801043e0 <acquiresleep>
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
8010018c:	e8 5f 22 00 00       	call   801023f0 <iderw>
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
801001a1:	68 8e 72 10 80       	push   $0x8010728e
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
801001be:	e8 bd 42 00 00       	call   80104480 <holdingsleep>
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
801001d4:	e9 17 22 00 00       	jmp    801023f0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 9f 72 10 80       	push   $0x8010729f
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
801001ff:	e8 7c 42 00 00       	call   80104480 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 2c 42 00 00       	call   80104440 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010021b:	e8 a0 44 00 00       	call   801046c0 <acquire>
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
80100269:	e9 f2 43 00 00       	jmp    80104660 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 a6 72 10 80       	push   $0x801072a6
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
80100294:	e8 07 17 00 00       	call   801019a0 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
801002a0:	e8 1b 44 00 00       	call   801046c0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002b5:	39 05 04 ef 10 80    	cmp    %eax,0x8010ef04
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
801002c3:	68 20 ef 10 80       	push   $0x8010ef20
801002c8:	68 00 ef 10 80       	push   $0x8010ef00
801002cd:	e8 6e 3e 00 00       	call   80104140 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 99 37 00 00       	call   80103a80 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ef 10 80       	push   $0x8010ef20
801002f6:	e8 65 43 00 00       	call   80104660 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 bc 15 00 00       	call   801018c0 <ilock>
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
8010031b:	89 15 00 ef 10 80    	mov    %edx,0x8010ef00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 ee 10 80 	movsbl -0x7fef1180(%edx),%ecx
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
80100347:	68 20 ef 10 80       	push   $0x8010ef20
8010034c:	e8 0f 43 00 00       	call   80104660 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 66 15 00 00       	call   801018c0 <ilock>
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
8010036d:	a3 00 ef 10 80       	mov    %eax,0x8010ef00
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
80100389:	c7 05 54 ef 10 80 00 	movl   $0x0,0x8010ef54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 52 26 00 00       	call   801029f0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 ad 72 10 80       	push   $0x801072ad
801003a7:	e8 04 03 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 fb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 2f 77 10 80 	movl   $0x8010772f,(%esp)
801003bc:	e8 ef 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 23 41 00 00       	call   801044f0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 c1 72 10 80       	push   $0x801072c1
801003dd:	e8 ce 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ef 10 80 01 	movl   $0x1,0x8010ef58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801003fc:	00 
801003fd:	8d 76 00             	lea    0x0(%esi),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
80100409:	3d 00 01 00 00       	cmp    $0x100,%eax
8010040e:	0f 84 cc 00 00 00    	je     801004e0 <consputc.part.0+0xe0>
    uartputc(c);
80100414:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100417:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010041c:	89 c3                	mov    %eax,%ebx
8010041e:	50                   	push   %eax
8010041f:	e8 ac 59 00 00       	call   80105dd0 <uartputc>
80100424:	b8 0e 00 00 00       	mov    $0xe,%eax
80100429:	89 fa                	mov    %edi,%edx
8010042b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042c:	be d5 03 00 00       	mov    $0x3d5,%esi
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100434:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100437:	89 fa                	mov    %edi,%edx
80100439:	b8 0f 00 00 00       	mov    $0xf,%eax
8010043e:	c1 e1 08             	shl    $0x8,%ecx
80100441:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100442:	89 f2                	mov    %esi,%edx
80100444:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100445:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
80100448:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	75 76                	jne    801004c8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100452:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100457:	f7 e2                	mul    %edx
80100459:	c1 ea 06             	shr    $0x6,%edx
8010045c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010045f:	c1 e0 04             	shl    $0x4,%eax
80100462:	8d 70 50             	lea    0x50(%eax),%esi
  if(pos < 0 || pos > 25*80)
80100465:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
8010046b:	0f 8f 2f 01 00 00    	jg     801005a0 <consputc.part.0+0x1a0>
  if((pos/80) >= 24){  // Scroll up.
80100471:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100477:	0f 8f c3 00 00 00    	jg     80100540 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
8010047d:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
8010047f:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100486:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100489:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048c:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100491:	b8 0e 00 00 00       	mov    $0xe,%eax
80100496:	89 da                	mov    %ebx,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010049e:	89 f8                	mov    %edi,%eax
801004a0:	89 ca                	mov    %ecx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b8 0f 00 00 00       	mov    $0xf,%eax
801004a8:	89 da                	mov    %ebx,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004af:	89 ca                	mov    %ecx,%edx
801004b1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b2:	b8 20 07 00 00       	mov    $0x720,%eax
801004b7:	66 89 06             	mov    %ax,(%esi)
}
801004ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004bd:	5b                   	pop    %ebx
801004be:	5e                   	pop    %esi
801004bf:	5f                   	pop    %edi
801004c0:	5d                   	pop    %ebp
801004c1:	c3                   	ret
801004c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004c8:	0f b6 db             	movzbl %bl,%ebx
801004cb:	8d 70 01             	lea    0x1(%eax),%esi
801004ce:	80 cf 07             	or     $0x7,%bh
801004d1:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004d8:	80 
801004d9:	eb 8a                	jmp    80100465 <consputc.part.0+0x65>
801004db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e0:	83 ec 0c             	sub    $0xc,%esp
801004e3:	be d4 03 00 00       	mov    $0x3d4,%esi
801004e8:	6a 08                	push   $0x8
801004ea:	e8 e1 58 00 00       	call   80105dd0 <uartputc>
801004ef:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f6:	e8 d5 58 00 00       	call   80105dd0 <uartputc>
801004fb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100502:	e8 c9 58 00 00       	call   80105dd0 <uartputc>
80100507:	b8 0e 00 00 00       	mov    $0xe,%eax
8010050c:	89 f2                	mov    %esi,%edx
8010050e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010050f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100514:	89 da                	mov    %ebx,%edx
80100516:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100517:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010051a:	89 f2                	mov    %esi,%edx
8010051c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100521:	c1 e1 08             	shl    $0x8,%ecx
80100524:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100525:	89 da                	mov    %ebx,%edx
80100527:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100528:	0f b6 f0             	movzbl %al,%esi
    if(pos > 0) --pos;
8010052b:	83 c4 10             	add    $0x10,%esp
8010052e:	09 ce                	or     %ecx,%esi
80100530:	74 5e                	je     80100590 <consputc.part.0+0x190>
80100532:	83 ee 01             	sub    $0x1,%esi
80100535:	e9 2b ff ff ff       	jmp    80100465 <consputc.part.0+0x65>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 ea 42 00 00       	call   80104850 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 45 42 00 00       	call   801047c0 <memset>
  outb(CRTPORT+1, pos);
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 06 ff ff ff       	jmp    8010048c <consputc.part.0+0x8c>
80100586:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010058d:	00 
8010058e:	66 90                	xchg   %ax,%ax
80100590:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80100594:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100599:	31 ff                	xor    %edi,%edi
8010059b:	e9 ec fe ff ff       	jmp    8010048c <consputc.part.0+0x8c>
    panic("pos under/overflow");
801005a0:	83 ec 0c             	sub    $0xc,%esp
801005a3:	68 c5 72 10 80       	push   $0x801072c5
801005a8:	e8 d3 fd ff ff       	call   80100380 <panic>
801005ad:	8d 76 00             	lea    0x0(%esi),%esi

801005b0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005b0:	55                   	push   %ebp
801005b1:	89 e5                	mov    %esp,%ebp
801005b3:	57                   	push   %edi
801005b4:	56                   	push   %esi
801005b5:	53                   	push   %ebx
801005b6:	83 ec 18             	sub    $0x18,%esp
801005b9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005bc:	ff 75 08             	push   0x8(%ebp)
801005bf:	e8 dc 13 00 00       	call   801019a0 <iunlock>
  acquire(&cons.lock);
801005c4:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
801005cb:	e8 f0 40 00 00       	call   801046c0 <acquire>
  for(i = 0; i < n; i++)
801005d0:	83 c4 10             	add    $0x10,%esp
801005d3:	85 f6                	test   %esi,%esi
801005d5:	7e 25                	jle    801005fc <consolewrite+0x4c>
801005d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005da:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005dd:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
    consputc(buf[i] & 0xff);
801005e3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005e6:	85 d2                	test   %edx,%edx
801005e8:	74 06                	je     801005f0 <consolewrite+0x40>
  asm volatile("cli");
801005ea:	fa                   	cli
    for(;;)
801005eb:	eb fe                	jmp    801005eb <consolewrite+0x3b>
801005ed:	8d 76 00             	lea    0x0(%esi),%esi
801005f0:	e8 0b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005f5:	83 c3 01             	add    $0x1,%ebx
801005f8:	39 fb                	cmp    %edi,%ebx
801005fa:	75 e1                	jne    801005dd <consolewrite+0x2d>
  release(&cons.lock);
801005fc:	83 ec 0c             	sub    $0xc,%esp
801005ff:	68 20 ef 10 80       	push   $0x8010ef20
80100604:	e8 57 40 00 00       	call   80104660 <release>
  ilock(ip);
80100609:	58                   	pop    %eax
8010060a:	ff 75 08             	push   0x8(%ebp)
8010060d:	e8 ae 12 00 00       	call   801018c0 <ilock>

  return n;
}
80100612:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100615:	89 f0                	mov    %esi,%eax
80100617:	5b                   	pop    %ebx
80100618:	5e                   	pop    %esi
80100619:	5f                   	pop    %edi
8010061a:	5d                   	pop    %ebp
8010061b:	c3                   	ret
8010061c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100620 <printint>:
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	53                   	push   %ebx
80100626:	89 d3                	mov    %edx,%ebx
80100628:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010062b:	85 c0                	test   %eax,%eax
8010062d:	79 05                	jns    80100634 <printint+0x14>
8010062f:	83 e1 01             	and    $0x1,%ecx
80100632:	75 64                	jne    80100698 <printint+0x78>
    x = xx;
80100634:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010063b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010063d:	31 f6                	xor    %esi,%esi
8010063f:	90                   	nop
    buf[i++] = digits[x % base];
80100640:	89 c8                	mov    %ecx,%eax
80100642:	31 d2                	xor    %edx,%edx
80100644:	89 f7                	mov    %esi,%edi
80100646:	f7 f3                	div    %ebx
80100648:	8d 76 01             	lea    0x1(%esi),%esi
8010064b:	0f b6 92 d8 77 10 80 	movzbl -0x7fef8828(%edx),%edx
80100652:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100656:	89 ca                	mov    %ecx,%edx
80100658:	89 c1                	mov    %eax,%ecx
8010065a:	39 da                	cmp    %ebx,%edx
8010065c:	73 e2                	jae    80100640 <printint+0x20>
  if(sign)
8010065e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80100661:	85 c9                	test   %ecx,%ecx
80100663:	74 07                	je     8010066c <printint+0x4c>
    buf[i++] = '-';
80100665:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010066a:	89 f7                	mov    %esi,%edi
8010066c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010066f:	01 df                	add    %ebx,%edi
  if(panicked){
80100671:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
    consputc(buf[i]);
80100677:	0f be 07             	movsbl (%edi),%eax
  if(panicked){
8010067a:	85 d2                	test   %edx,%edx
8010067c:	74 0a                	je     80100688 <printint+0x68>
8010067e:	fa                   	cli
    for(;;)
8010067f:	eb fe                	jmp    8010067f <printint+0x5f>
80100681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100688:	e8 73 fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
8010068d:	8d 47 ff             	lea    -0x1(%edi),%eax
80100690:	39 df                	cmp    %ebx,%edi
80100692:	74 11                	je     801006a5 <printint+0x85>
80100694:	89 c7                	mov    %eax,%edi
80100696:	eb d9                	jmp    80100671 <printint+0x51>
    x = -xx;
80100698:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
8010069a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801006a1:	89 c1                	mov    %eax,%ecx
801006a3:	eb 98                	jmp    8010063d <printint+0x1d>
}
801006a5:	83 c4 2c             	add    $0x2c,%esp
801006a8:	5b                   	pop    %ebx
801006a9:	5e                   	pop    %esi
801006aa:	5f                   	pop    %edi
801006ab:	5d                   	pop    %ebp
801006ac:	c3                   	ret
801006ad:	8d 76 00             	lea    0x0(%esi),%esi

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	8b 3d 54 ef 10 80    	mov    0x8010ef54,%edi
  if (fmt == 0)
801006bf:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801006c2:	85 ff                	test   %edi,%edi
801006c4:	0f 85 06 01 00 00    	jne    801007d0 <cprintf+0x120>
  if (fmt == 0)
801006ca:	85 f6                	test   %esi,%esi
801006cc:	0f 84 b7 01 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d2:	0f b6 06             	movzbl (%esi),%eax
801006d5:	85 c0                	test   %eax,%eax
801006d7:	74 5f                	je     80100738 <cprintf+0x88>
  argp = (uint*)(void*)(&fmt + 1);
801006d9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006dc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801006df:	31 db                	xor    %ebx,%ebx
801006e1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	75 58                	jne    80100740 <cprintf+0x90>
    c = fmt[++i] & 0xff;
801006e8:	83 c3 01             	add    $0x1,%ebx
801006eb:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006ef:	85 c9                	test   %ecx,%ecx
801006f1:	74 3a                	je     8010072d <cprintf+0x7d>
    switch(c){
801006f3:	83 f9 70             	cmp    $0x70,%ecx
801006f6:	0f 84 b4 00 00 00    	je     801007b0 <cprintf+0x100>
801006fc:	7f 72                	jg     80100770 <cprintf+0xc0>
801006fe:	83 f9 25             	cmp    $0x25,%ecx
80100701:	74 4d                	je     80100750 <cprintf+0xa0>
80100703:	83 f9 64             	cmp    $0x64,%ecx
80100706:	75 76                	jne    8010077e <cprintf+0xce>
      printint(*argp++, 10, 1);
80100708:	8d 47 04             	lea    0x4(%edi),%eax
8010070b:	b9 01 00 00 00       	mov    $0x1,%ecx
80100710:	ba 0a 00 00 00       	mov    $0xa,%edx
80100715:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100718:	8b 07                	mov    (%edi),%eax
8010071a:	e8 01 ff ff ff       	call   80100620 <printint>
8010071f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100722:	83 c3 01             	add    $0x1,%ebx
80100725:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	75 b6                	jne    801006e3 <cprintf+0x33>
8010072d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
80100730:	85 ff                	test   %edi,%edi
80100732:	0f 85 bb 00 00 00    	jne    801007f3 <cprintf+0x143>
}
80100738:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010073b:	5b                   	pop    %ebx
8010073c:	5e                   	pop    %esi
8010073d:	5f                   	pop    %edi
8010073e:	5d                   	pop    %ebp
8010073f:	c3                   	ret
  if(panicked){
80100740:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
80100746:	85 c9                	test   %ecx,%ecx
80100748:	74 19                	je     80100763 <cprintf+0xb3>
8010074a:	fa                   	cli
    for(;;)
8010074b:	eb fe                	jmp    8010074b <cprintf+0x9b>
8010074d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100750:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
80100756:	85 c9                	test   %ecx,%ecx
80100758:	0f 85 f2 00 00 00    	jne    80100850 <cprintf+0x1a0>
8010075e:	b8 25 00 00 00       	mov    $0x25,%eax
80100763:	e8 98 fc ff ff       	call   80100400 <consputc.part.0>
      break;
80100768:	eb b8                	jmp    80100722 <cprintf+0x72>
8010076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100770:	83 f9 73             	cmp    $0x73,%ecx
80100773:	0f 84 8f 00 00 00    	je     80100808 <cprintf+0x158>
80100779:	83 f9 78             	cmp    $0x78,%ecx
8010077c:	74 32                	je     801007b0 <cprintf+0x100>
  if(panicked){
8010077e:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
80100784:	85 d2                	test   %edx,%edx
80100786:	0f 85 b8 00 00 00    	jne    80100844 <cprintf+0x194>
8010078c:	b8 25 00 00 00       	mov    $0x25,%eax
80100791:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100794:	e8 67 fc ff ff       	call   80100400 <consputc.part.0>
80100799:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
8010079e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801007a1:	85 c0                	test   %eax,%eax
801007a3:	0f 84 cd 00 00 00    	je     80100876 <cprintf+0x1c6>
801007a9:	fa                   	cli
    for(;;)
801007aa:	eb fe                	jmp    801007aa <cprintf+0xfa>
801007ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801007b0:	8d 47 04             	lea    0x4(%edi),%eax
801007b3:	31 c9                	xor    %ecx,%ecx
801007b5:	ba 10 00 00 00       	mov    $0x10,%edx
801007ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007bd:	8b 07                	mov    (%edi),%eax
801007bf:	e8 5c fe ff ff       	call   80100620 <printint>
801007c4:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
801007c7:	e9 56 ff ff ff       	jmp    80100722 <cprintf+0x72>
801007cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007d0:	83 ec 0c             	sub    $0xc,%esp
801007d3:	68 20 ef 10 80       	push   $0x8010ef20
801007d8:	e8 e3 3e 00 00       	call   801046c0 <acquire>
  if (fmt == 0)
801007dd:	83 c4 10             	add    $0x10,%esp
801007e0:	85 f6                	test   %esi,%esi
801007e2:	0f 84 a1 00 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007e8:	0f b6 06             	movzbl (%esi),%eax
801007eb:	85 c0                	test   %eax,%eax
801007ed:	0f 85 e6 fe ff ff    	jne    801006d9 <cprintf+0x29>
    release(&cons.lock);
801007f3:	83 ec 0c             	sub    $0xc,%esp
801007f6:	68 20 ef 10 80       	push   $0x8010ef20
801007fb:	e8 60 3e 00 00       	call   80104660 <release>
80100800:	83 c4 10             	add    $0x10,%esp
80100803:	e9 30 ff ff ff       	jmp    80100738 <cprintf+0x88>
      if((s = (char*)*argp++) == 0)
80100808:	8b 17                	mov    (%edi),%edx
8010080a:	8d 47 04             	lea    0x4(%edi),%eax
8010080d:	85 d2                	test   %edx,%edx
8010080f:	74 27                	je     80100838 <cprintf+0x188>
      for(; *s; s++)
80100811:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100814:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100816:	84 c9                	test   %cl,%cl
80100818:	74 68                	je     80100882 <cprintf+0x1d2>
8010081a:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010081d:	89 fb                	mov    %edi,%ebx
8010081f:	89 f7                	mov    %esi,%edi
80100821:	89 c6                	mov    %eax,%esi
80100823:	0f be c1             	movsbl %cl,%eax
  if(panicked){
80100826:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
8010082c:	85 d2                	test   %edx,%edx
8010082e:	74 28                	je     80100858 <cprintf+0x1a8>
80100830:	fa                   	cli
    for(;;)
80100831:	eb fe                	jmp    80100831 <cprintf+0x181>
80100833:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100838:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
8010083d:	bf d8 72 10 80       	mov    $0x801072d8,%edi
80100842:	eb d6                	jmp    8010081a <cprintf+0x16a>
80100844:	fa                   	cli
    for(;;)
80100845:	eb fe                	jmp    80100845 <cprintf+0x195>
80100847:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010084e:	00 
8010084f:	90                   	nop
80100850:	fa                   	cli
80100851:	eb fe                	jmp    80100851 <cprintf+0x1a1>
80100853:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100858:	e8 a3 fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
8010085d:	0f be 43 01          	movsbl 0x1(%ebx),%eax
80100861:	83 c3 01             	add    $0x1,%ebx
80100864:	84 c0                	test   %al,%al
80100866:	75 be                	jne    80100826 <cprintf+0x176>
      if((s = (char*)*argp++) == 0)
80100868:	89 f0                	mov    %esi,%eax
8010086a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010086d:	89 fe                	mov    %edi,%esi
8010086f:	89 c7                	mov    %eax,%edi
80100871:	e9 ac fe ff ff       	jmp    80100722 <cprintf+0x72>
80100876:	89 c8                	mov    %ecx,%eax
80100878:	e8 83 fb ff ff       	call   80100400 <consputc.part.0>
      break;
8010087d:	e9 a0 fe ff ff       	jmp    80100722 <cprintf+0x72>
      if((s = (char*)*argp++) == 0)
80100882:	89 c7                	mov    %eax,%edi
80100884:	e9 99 fe ff ff       	jmp    80100722 <cprintf+0x72>
    panic("null fmt");
80100889:	83 ec 0c             	sub    $0xc,%esp
8010088c:	68 df 72 10 80       	push   $0x801072df
80100891:	e8 ea fa ff ff       	call   80100380 <panic>
80100896:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010089d:	00 
8010089e:	66 90                	xchg   %ax,%ax

801008a0 <consoleintr>:
{
801008a0:	55                   	push   %ebp
801008a1:	89 e5                	mov    %esp,%ebp
801008a3:	57                   	push   %edi
801008a4:	56                   	push   %esi
  int c, doprocdump = 0;
801008a5:	31 f6                	xor    %esi,%esi
{
801008a7:	53                   	push   %ebx
801008a8:	83 ec 28             	sub    $0x28,%esp
801008ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801008ae:	68 20 ef 10 80       	push   $0x8010ef20
801008b3:	e8 08 3e 00 00       	call   801046c0 <acquire>
  while((c = getc()) >= 0){
801008b8:	83 c4 10             	add    $0x10,%esp
801008bb:	ff d3                	call   *%ebx
801008bd:	89 c7                	mov    %eax,%edi
801008bf:	85 c0                	test   %eax,%eax
801008c1:	0f 88 24 01 00 00    	js     801009eb <consoleintr+0x14b>
    switch(c){
801008c7:	83 ff 15             	cmp    $0x15,%edi
801008ca:	7f 54                	jg     80100920 <consoleintr+0x80>
801008cc:	85 ff                	test   %edi,%edi
801008ce:	74 eb                	je     801008bb <consoleintr+0x1b>
801008d0:	83 ff 15             	cmp    $0x15,%edi
801008d3:	0f 87 c3 01 00 00    	ja     80100a9c <consoleintr+0x1fc>
801008d9:	ff 24 bd 80 77 10 80 	jmp    *-0x7fef8880(,%edi,4)
801008e0:	b8 00 01 00 00       	mov    $0x100,%eax
801008e5:	e8 16 fb ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
801008ea:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
801008ef:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801008f5:	74 c4                	je     801008bb <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008f7:	83 e8 01             	sub    $0x1,%eax
801008fa:	89 c2                	mov    %eax,%edx
801008fc:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801008ff:	80 ba 80 ee 10 80 0a 	cmpb   $0xa,-0x7fef1180(%edx)
80100906:	74 b3                	je     801008bb <consoleintr+0x1b>
  if(panicked){
80100908:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
        input.e--;
8010090e:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
80100913:	85 d2                	test   %edx,%edx
80100915:	74 c9                	je     801008e0 <consoleintr+0x40>
80100917:	fa                   	cli
    for(;;)
80100918:	eb fe                	jmp    80100918 <consoleintr+0x78>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100920:	81 ff e4 00 00 00    	cmp    $0xe4,%edi
80100926:	74 40                	je     80100968 <consoleintr+0xc8>
80100928:	81 ff e5 00 00 00    	cmp    $0xe5,%edi
8010092e:	74 8b                	je     801008bb <consoleintr+0x1b>
80100930:	83 ff 7f             	cmp    $0x7f,%edi
80100933:	0f 85 e0 00 00 00    	jne    80100a19 <consoleintr+0x179>
      if(input.e != input.w){
80100939:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
8010093e:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100944:	0f 84 71 ff ff ff    	je     801008bb <consoleintr+0x1b>
        input.e--;
8010094a:	83 e8 01             	sub    $0x1,%eax
8010094d:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
80100952:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100957:	85 c0                	test   %eax,%eax
80100959:	0f 84 14 01 00 00    	je     80100a73 <consoleintr+0x1d3>
8010095f:	fa                   	cli
    for(;;)
80100960:	eb fe                	jmp    80100960 <consoleintr+0xc0>
80100962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        uartputc('\b');
80100968:	83 ec 0c             	sub    $0xc,%esp
        input.e--;
8010096b:	83 2d 08 ef 10 80 01 	subl   $0x1,0x8010ef08
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100972:	bf d4 03 00 00       	mov    $0x3d4,%edi
        uartputc('\b');
80100977:	6a 08                	push   $0x8
80100979:	e8 52 54 00 00       	call   80105dd0 <uartputc>
8010097e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100983:	89 fa                	mov    %edi,%edx
80100985:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100986:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010098b:	89 ca                	mov    %ecx,%edx
8010098d:	ec                   	in     (%dx),%al
void move_cursor_visually(){
  int pos;

  // get cursor position
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
8010098e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100991:	89 fa                	mov    %edi,%edx
80100993:	c1 e0 08             	shl    $0x8,%eax
80100996:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100999:	b8 0f 00 00 00       	mov    $0xf,%eax
8010099e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010099f:	89 ca                	mov    %ecx,%edx
801009a1:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  // move back
  if(pos>0)
801009a2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  pos |= inb(CRTPORT+1);
801009a5:	0f b6 c0             	movzbl %al,%eax
  if(pos>0)
801009a8:	83 c4 10             	add    $0x10,%esp
801009ab:	09 c8                	or     %ecx,%eax
801009ad:	75 5c                	jne    80100a0b <consoleintr+0x16b>
801009af:	c6 45 e3 00          	movb   $0x0,-0x1d(%ebp)
801009b3:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801009b7:	bf d4 03 00 00       	mov    $0x3d4,%edi
801009bc:	b8 0e 00 00 00       	mov    $0xe,%eax
801009c1:	89 fa                	mov    %edi,%edx
801009c3:	ee                   	out    %al,(%dx)
801009c4:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801009c9:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
801009cd:	89 ca                	mov    %ecx,%edx
801009cf:	ee                   	out    %al,(%dx)
801009d0:	b8 0f 00 00 00       	mov    $0xf,%eax
801009d5:	89 fa                	mov    %edi,%edx
801009d7:	ee                   	out    %al,(%dx)
801009d8:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
801009dc:	89 ca                	mov    %ecx,%edx
801009de:	ee                   	out    %al,(%dx)
  while((c = getc()) >= 0){
801009df:	ff d3                	call   *%ebx
801009e1:	89 c7                	mov    %eax,%edi
801009e3:	85 c0                	test   %eax,%eax
801009e5:	0f 89 dc fe ff ff    	jns    801008c7 <consoleintr+0x27>
  release(&cons.lock);
801009eb:	83 ec 0c             	sub    $0xc,%esp
801009ee:	68 20 ef 10 80       	push   $0x8010ef20
801009f3:	e8 68 3c 00 00       	call   80104660 <release>
  if(doprocdump) {
801009f8:	83 c4 10             	add    $0x10,%esp
801009fb:	85 f6                	test   %esi,%esi
801009fd:	0f 85 8d 00 00 00    	jne    80100a90 <consoleintr+0x1f0>
}
80100a03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a06:	5b                   	pop    %ebx
80100a07:	5e                   	pop    %esi
80100a08:	5f                   	pop    %edi
80100a09:	5d                   	pop    %ebp
80100a0a:	c3                   	ret
    pos--;
80100a0b:	83 e8 01             	sub    $0x1,%eax

  // reset cursor
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
80100a0e:	0f b6 cc             	movzbl %ah,%ecx
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
80100a11:	88 45 e3             	mov    %al,-0x1d(%ebp)
  outb(CRTPORT+1, pos>>8);
80100a14:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100a17:	eb 9e                	jmp    801009b7 <consoleintr+0x117>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a19:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100a1e:	89 c2                	mov    %eax,%edx
80100a20:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
80100a26:	83 fa 7f             	cmp    $0x7f,%edx
80100a29:	0f 87 8c fe ff ff    	ja     801008bb <consoleintr+0x1b>
  if(panicked){
80100a2f:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100a35:	8d 48 01             	lea    0x1(%eax),%ecx
80100a38:	83 e0 7f             	and    $0x7f,%eax
80100a3b:	89 0d 08 ef 10 80    	mov    %ecx,0x8010ef08
80100a41:	89 f9                	mov    %edi,%ecx
80100a43:	88 88 80 ee 10 80    	mov    %cl,-0x7fef1180(%eax)
  if(panicked){
80100a49:	85 d2                	test   %edx,%edx
80100a4b:	75 3f                	jne    80100a8c <consoleintr+0x1ec>
80100a4d:	89 f8                	mov    %edi,%eax
80100a4f:	e8 ac f9 ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100a54:	83 ff 0a             	cmp    $0xa,%edi
80100a57:	0f 84 85 00 00 00    	je     80100ae2 <consoleintr+0x242>
80100a5d:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
80100a62:	83 e8 80             	sub    $0xffffff80,%eax
80100a65:	39 05 08 ef 10 80    	cmp    %eax,0x8010ef08
80100a6b:	0f 85 4a fe ff ff    	jne    801008bb <consoleintr+0x1b>
80100a71:	eb 74                	jmp    80100ae7 <consoleintr+0x247>
80100a73:	b8 00 01 00 00       	mov    $0x100,%eax
80100a78:	e8 83 f9 ff ff       	call   80100400 <consputc.part.0>
80100a7d:	e9 39 fe ff ff       	jmp    801008bb <consoleintr+0x1b>
    switch(c){
80100a82:	be 01 00 00 00       	mov    $0x1,%esi
80100a87:	e9 2f fe ff ff       	jmp    801008bb <consoleintr+0x1b>
  asm volatile("cli");
80100a8c:	fa                   	cli
    for(;;)
80100a8d:	eb fe                	jmp    80100a8d <consoleintr+0x1ed>
80100a8f:	90                   	nop
}
80100a90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a93:	5b                   	pop    %ebx
80100a94:	5e                   	pop    %esi
80100a95:	5f                   	pop    %edi
80100a96:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a97:	e9 44 38 00 00       	jmp    801042e0 <procdump>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a9c:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100aa1:	89 c2                	mov    %eax,%edx
80100aa3:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
80100aa9:	83 fa 7f             	cmp    $0x7f,%edx
80100aac:	0f 87 09 fe ff ff    	ja     801008bb <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100ab2:	8d 48 01             	lea    0x1(%eax),%ecx
  if(panicked){
80100ab5:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100abb:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100abe:	83 ff 0d             	cmp    $0xd,%edi
80100ac1:	0f 85 74 ff ff ff    	jne    80100a3b <consoleintr+0x19b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100ac7:	89 0d 08 ef 10 80    	mov    %ecx,0x8010ef08
80100acd:	c6 80 80 ee 10 80 0a 	movb   $0xa,-0x7fef1180(%eax)
  if(panicked){
80100ad4:	85 d2                	test   %edx,%edx
80100ad6:	75 b4                	jne    80100a8c <consoleintr+0x1ec>
80100ad8:	b8 0a 00 00 00       	mov    $0xa,%eax
80100add:	e8 1e f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100ae2:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
          wakeup(&input.r);
80100ae7:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100aea:	a3 04 ef 10 80       	mov    %eax,0x8010ef04
          wakeup(&input.r);
80100aef:	68 00 ef 10 80       	push   $0x8010ef00
80100af4:	e8 07 37 00 00       	call   80104200 <wakeup>
80100af9:	83 c4 10             	add    $0x10,%esp
80100afc:	e9 ba fd ff ff       	jmp    801008bb <consoleintr+0x1b>
80100b01:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100b08:	00 
80100b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100b10 <consoleinit>:
{
80100b10:	55                   	push   %ebp
80100b11:	89 e5                	mov    %esp,%ebp
80100b13:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b16:	68 e8 72 10 80       	push   $0x801072e8
80100b1b:	68 20 ef 10 80       	push   $0x8010ef20
80100b20:	e8 ab 39 00 00       	call   801044d0 <initlock>
  ioapicenable(IRQ_KBD, 0);
80100b25:	58                   	pop    %eax
80100b26:	5a                   	pop    %edx
80100b27:	6a 00                	push   $0x0
80100b29:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100b2b:	c7 05 0c f9 10 80 b0 	movl   $0x801005b0,0x8010f90c
80100b32:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100b35:	c7 05 08 f9 10 80 80 	movl   $0x80100280,0x8010f908
80100b3c:	02 10 80 
  cons.locking = 1;
80100b3f:	c7 05 54 ef 10 80 01 	movl   $0x1,0x8010ef54
80100b46:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100b49:	e8 32 1a 00 00       	call   80102580 <ioapicenable>
}
80100b4e:	83 c4 10             	add    $0x10,%esp
80100b51:	c9                   	leave
80100b52:	c3                   	ret
80100b53:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100b5a:	00 
80100b5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100b60 <move_cursor_visually>:
void move_cursor_visually(){
80100b60:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b61:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b66:	89 e5                	mov    %esp,%ebp
80100b68:	57                   	push   %edi
80100b69:	56                   	push   %esi
80100b6a:	be d4 03 00 00       	mov    $0x3d4,%esi
80100b6f:	53                   	push   %ebx
80100b70:	89 f2                	mov    %esi,%edx
80100b72:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b73:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100b78:	89 da                	mov    %ebx,%edx
80100b7a:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100b7b:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b7e:	89 f2                	mov    %esi,%edx
80100b80:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b85:	c1 e1 08             	shl    $0x8,%ecx
80100b88:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b89:	89 da                	mov    %ebx,%edx
80100b8b:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100b8c:	0f b6 c0             	movzbl %al,%eax
  if(pos>0)
80100b8f:	09 c8                	or     %ecx,%eax
80100b91:	74 35                	je     80100bc8 <move_cursor_visually+0x68>
    pos--;
80100b93:	8d 48 ff             	lea    -0x1(%eax),%ecx
  outb(CRTPORT+1, pos>>8);
80100b96:	0f b6 f5             	movzbl %ch,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b99:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100b9e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100ba3:	89 fa                	mov    %edi,%edx
80100ba5:	ee                   	out    %al,(%dx)
80100ba6:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100bab:	89 f0                	mov    %esi,%eax
80100bad:	89 da                	mov    %ebx,%edx
80100baf:	ee                   	out    %al,(%dx)
80100bb0:	b8 0f 00 00 00       	mov    $0xf,%eax
80100bb5:	89 fa                	mov    %edi,%edx
80100bb7:	ee                   	out    %al,(%dx)
80100bb8:	89 c8                	mov    %ecx,%eax
80100bba:	89 da                	mov    %ebx,%edx
80100bbc:	ee                   	out    %al,(%dx)
80100bbd:	5b                   	pop    %ebx
80100bbe:	5e                   	pop    %esi
80100bbf:	5f                   	pop    %edi
80100bc0:	5d                   	pop    %ebp
80100bc1:	c3                   	ret
80100bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100bc8:	31 c9                	xor    %ecx,%ecx
80100bca:	31 f6                	xor    %esi,%esi
80100bcc:	eb cb                	jmp    80100b99 <move_cursor_visually+0x39>
80100bce:	66 90                	xchg   %ax,%ax

80100bd0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100bd0:	55                   	push   %ebp
80100bd1:	89 e5                	mov    %esp,%ebp
80100bd3:	57                   	push   %edi
80100bd4:	56                   	push   %esi
80100bd5:	53                   	push   %ebx
80100bd6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100bdc:	e8 9f 2e 00 00       	call   80103a80 <myproc>
80100be1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100be7:	e8 74 22 00 00       	call   80102e60 <begin_op>

  if((ip = namei(path)) == 0){
80100bec:	83 ec 0c             	sub    $0xc,%esp
80100bef:	ff 75 08             	push   0x8(%ebp)
80100bf2:	e8 a9 15 00 00       	call   801021a0 <namei>
80100bf7:	83 c4 10             	add    $0x10,%esp
80100bfa:	85 c0                	test   %eax,%eax
80100bfc:	0f 84 30 03 00 00    	je     80100f32 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100c02:	83 ec 0c             	sub    $0xc,%esp
80100c05:	89 c7                	mov    %eax,%edi
80100c07:	50                   	push   %eax
80100c08:	e8 b3 0c 00 00       	call   801018c0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100c0d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100c13:	6a 34                	push   $0x34
80100c15:	6a 00                	push   $0x0
80100c17:	50                   	push   %eax
80100c18:	57                   	push   %edi
80100c19:	e8 b2 0f 00 00       	call   80101bd0 <readi>
80100c1e:	83 c4 20             	add    $0x20,%esp
80100c21:	83 f8 34             	cmp    $0x34,%eax
80100c24:	0f 85 01 01 00 00    	jne    80100d2b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c2a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100c31:	45 4c 46 
80100c34:	0f 85 f1 00 00 00    	jne    80100d2b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100c3a:	e8 01 63 00 00       	call   80106f40 <setupkvm>
80100c3f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100c45:	85 c0                	test   %eax,%eax
80100c47:	0f 84 de 00 00 00    	je     80100d2b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c4d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100c54:	00 
80100c55:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100c5b:	0f 84 a1 02 00 00    	je     80100f02 <exec+0x332>
  sz = 0;
80100c61:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100c68:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c6b:	31 db                	xor    %ebx,%ebx
80100c6d:	e9 8c 00 00 00       	jmp    80100cfe <exec+0x12e>
80100c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c78:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100c7f:	75 6c                	jne    80100ced <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100c81:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100c87:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100c8d:	0f 82 87 00 00 00    	jb     80100d1a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c93:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100c99:	72 7f                	jb     80100d1a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c9b:	83 ec 04             	sub    $0x4,%esp
80100c9e:	50                   	push   %eax
80100c9f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100ca5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100cab:	e8 c0 60 00 00       	call   80106d70 <allocuvm>
80100cb0:	83 c4 10             	add    $0x10,%esp
80100cb3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100cb9:	85 c0                	test   %eax,%eax
80100cbb:	74 5d                	je     80100d1a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100cbd:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100cc3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100cc8:	75 50                	jne    80100d1a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100cca:	83 ec 0c             	sub    $0xc,%esp
80100ccd:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100cd3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100cd9:	57                   	push   %edi
80100cda:	50                   	push   %eax
80100cdb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ce1:	e8 ba 5f 00 00       	call   80106ca0 <loaduvm>
80100ce6:	83 c4 20             	add    $0x20,%esp
80100ce9:	85 c0                	test   %eax,%eax
80100ceb:	78 2d                	js     80100d1a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ced:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100cf4:	83 c3 01             	add    $0x1,%ebx
80100cf7:	83 c6 20             	add    $0x20,%esi
80100cfa:	39 d8                	cmp    %ebx,%eax
80100cfc:	7e 52                	jle    80100d50 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100cfe:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100d04:	6a 20                	push   $0x20
80100d06:	56                   	push   %esi
80100d07:	50                   	push   %eax
80100d08:	57                   	push   %edi
80100d09:	e8 c2 0e 00 00       	call   80101bd0 <readi>
80100d0e:	83 c4 10             	add    $0x10,%esp
80100d11:	83 f8 20             	cmp    $0x20,%eax
80100d14:	0f 84 5e ff ff ff    	je     80100c78 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100d1a:	83 ec 0c             	sub    $0xc,%esp
80100d1d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d23:	e8 98 61 00 00       	call   80106ec0 <freevm>
  if(ip){
80100d28:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100d2b:	83 ec 0c             	sub    $0xc,%esp
80100d2e:	57                   	push   %edi
80100d2f:	e8 1c 0e 00 00       	call   80101b50 <iunlockput>
    end_op();
80100d34:	e8 97 21 00 00       	call   80102ed0 <end_op>
80100d39:	83 c4 10             	add    $0x10,%esp
    return -1;
80100d3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100d41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d44:	5b                   	pop    %ebx
80100d45:	5e                   	pop    %esi
80100d46:	5f                   	pop    %edi
80100d47:	5d                   	pop    %ebp
80100d48:	c3                   	ret
80100d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100d50:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100d56:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100d5c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d62:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100d68:	83 ec 0c             	sub    $0xc,%esp
80100d6b:	57                   	push   %edi
80100d6c:	e8 df 0d 00 00       	call   80101b50 <iunlockput>
  end_op();
80100d71:	e8 5a 21 00 00       	call   80102ed0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d76:	83 c4 0c             	add    $0xc,%esp
80100d79:	53                   	push   %ebx
80100d7a:	56                   	push   %esi
80100d7b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100d81:	56                   	push   %esi
80100d82:	e8 e9 5f 00 00       	call   80106d70 <allocuvm>
80100d87:	83 c4 10             	add    $0x10,%esp
80100d8a:	89 c7                	mov    %eax,%edi
80100d8c:	85 c0                	test   %eax,%eax
80100d8e:	0f 84 86 00 00 00    	je     80100e1a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d94:	83 ec 08             	sub    $0x8,%esp
80100d97:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100d9d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d9f:	50                   	push   %eax
80100da0:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100da1:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100da3:	e8 38 62 00 00       	call   80106fe0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100da8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dab:	83 c4 10             	add    $0x10,%esp
80100dae:	8b 10                	mov    (%eax),%edx
80100db0:	85 d2                	test   %edx,%edx
80100db2:	0f 84 56 01 00 00    	je     80100f0e <exec+0x33e>
80100db8:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100dbe:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100dc1:	eb 23                	jmp    80100de6 <exec+0x216>
80100dc3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100dc8:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100dcb:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100dd2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100dd8:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100ddb:	85 d2                	test   %edx,%edx
80100ddd:	74 51                	je     80100e30 <exec+0x260>
    if(argc >= MAXARG)
80100ddf:	83 f8 20             	cmp    $0x20,%eax
80100de2:	74 36                	je     80100e1a <exec+0x24a>
80100de4:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100de6:	83 ec 0c             	sub    $0xc,%esp
80100de9:	52                   	push   %edx
80100dea:	e8 c1 3b 00 00       	call   801049b0 <strlen>
80100def:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100df1:	58                   	pop    %eax
80100df2:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100df5:	83 eb 01             	sub    $0x1,%ebx
80100df8:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100dfb:	e8 b0 3b 00 00       	call   801049b0 <strlen>
80100e00:	83 c0 01             	add    $0x1,%eax
80100e03:	50                   	push   %eax
80100e04:	ff 34 b7             	push   (%edi,%esi,4)
80100e07:	53                   	push   %ebx
80100e08:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100e0e:	e8 9d 63 00 00       	call   801071b0 <copyout>
80100e13:	83 c4 20             	add    $0x20,%esp
80100e16:	85 c0                	test   %eax,%eax
80100e18:	79 ae                	jns    80100dc8 <exec+0x1f8>
    freevm(pgdir);
80100e1a:	83 ec 0c             	sub    $0xc,%esp
80100e1d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100e23:	e8 98 60 00 00       	call   80106ec0 <freevm>
80100e28:	83 c4 10             	add    $0x10,%esp
80100e2b:	e9 0c ff ff ff       	jmp    80100d3c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e30:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100e37:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100e3d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100e43:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100e46:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100e49:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100e50:	00 00 00 00 
  ustack[1] = argc;
80100e54:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100e5a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e61:	ff ff ff 
  ustack[1] = argc;
80100e64:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e6a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100e6c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e6e:	29 d0                	sub    %edx,%eax
80100e70:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e76:	56                   	push   %esi
80100e77:	51                   	push   %ecx
80100e78:	53                   	push   %ebx
80100e79:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100e7f:	e8 2c 63 00 00       	call   801071b0 <copyout>
80100e84:	83 c4 10             	add    $0x10,%esp
80100e87:	85 c0                	test   %eax,%eax
80100e89:	78 8f                	js     80100e1a <exec+0x24a>
  for(last=s=path; *s; s++)
80100e8b:	8b 45 08             	mov    0x8(%ebp),%eax
80100e8e:	8b 55 08             	mov    0x8(%ebp),%edx
80100e91:	0f b6 00             	movzbl (%eax),%eax
80100e94:	84 c0                	test   %al,%al
80100e96:	74 17                	je     80100eaf <exec+0x2df>
80100e98:	89 d1                	mov    %edx,%ecx
80100e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100ea0:	83 c1 01             	add    $0x1,%ecx
80100ea3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100ea5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100ea8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100eab:	84 c0                	test   %al,%al
80100ead:	75 f1                	jne    80100ea0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100eaf:	83 ec 04             	sub    $0x4,%esp
80100eb2:	6a 10                	push   $0x10
80100eb4:	52                   	push   %edx
80100eb5:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100ebb:	8d 46 6c             	lea    0x6c(%esi),%eax
80100ebe:	50                   	push   %eax
80100ebf:	e8 ac 3a 00 00       	call   80104970 <safestrcpy>
  curproc->pgdir = pgdir;
80100ec4:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100eca:	89 f0                	mov    %esi,%eax
80100ecc:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100ecf:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100ed1:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100ed4:	89 c1                	mov    %eax,%ecx
80100ed6:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100edc:	8b 40 18             	mov    0x18(%eax),%eax
80100edf:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100ee2:	8b 41 18             	mov    0x18(%ecx),%eax
80100ee5:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100ee8:	89 0c 24             	mov    %ecx,(%esp)
80100eeb:	e8 20 5c 00 00       	call   80106b10 <switchuvm>
  freevm(oldpgdir);
80100ef0:	89 34 24             	mov    %esi,(%esp)
80100ef3:	e8 c8 5f 00 00       	call   80106ec0 <freevm>
  return 0;
80100ef8:	83 c4 10             	add    $0x10,%esp
80100efb:	31 c0                	xor    %eax,%eax
80100efd:	e9 3f fe ff ff       	jmp    80100d41 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f02:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100f07:	31 f6                	xor    %esi,%esi
80100f09:	e9 5a fe ff ff       	jmp    80100d68 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100f0e:	be 10 00 00 00       	mov    $0x10,%esi
80100f13:	ba 04 00 00 00       	mov    $0x4,%edx
80100f18:	b8 03 00 00 00       	mov    $0x3,%eax
80100f1d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100f24:	00 00 00 
80100f27:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100f2d:	e9 17 ff ff ff       	jmp    80100e49 <exec+0x279>
    end_op();
80100f32:	e8 99 1f 00 00       	call   80102ed0 <end_op>
    cprintf("exec: fail\n");
80100f37:	83 ec 0c             	sub    $0xc,%esp
80100f3a:	68 f0 72 10 80       	push   $0x801072f0
80100f3f:	e8 6c f7 ff ff       	call   801006b0 <cprintf>
    return -1;
80100f44:	83 c4 10             	add    $0x10,%esp
80100f47:	e9 f0 fd ff ff       	jmp    80100d3c <exec+0x16c>
80100f4c:	66 90                	xchg   %ax,%ax
80100f4e:	66 90                	xchg   %ax,%ax

80100f50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f56:	68 fc 72 10 80       	push   $0x801072fc
80100f5b:	68 60 ef 10 80       	push   $0x8010ef60
80100f60:	e8 6b 35 00 00       	call   801044d0 <initlock>
}
80100f65:	83 c4 10             	add    $0x10,%esp
80100f68:	c9                   	leave
80100f69:	c3                   	ret
80100f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f70:	55                   	push   %ebp
80100f71:	89 e5                	mov    %esp,%ebp
80100f73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f74:	bb 94 ef 10 80       	mov    $0x8010ef94,%ebx
{
80100f79:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100f7c:	68 60 ef 10 80       	push   $0x8010ef60
80100f81:	e8 3a 37 00 00       	call   801046c0 <acquire>
80100f86:	83 c4 10             	add    $0x10,%esp
80100f89:	eb 10                	jmp    80100f9b <filealloc+0x2b>
80100f8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f90:	83 c3 18             	add    $0x18,%ebx
80100f93:	81 fb f4 f8 10 80    	cmp    $0x8010f8f4,%ebx
80100f99:	74 25                	je     80100fc0 <filealloc+0x50>
    if(f->ref == 0){
80100f9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f9e:	85 c0                	test   %eax,%eax
80100fa0:	75 ee                	jne    80100f90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100fa2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100fa5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100fac:	68 60 ef 10 80       	push   $0x8010ef60
80100fb1:	e8 aa 36 00 00       	call   80104660 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100fb6:	89 d8                	mov    %ebx,%eax
      return f;
80100fb8:	83 c4 10             	add    $0x10,%esp
}
80100fbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fbe:	c9                   	leave
80100fbf:	c3                   	ret
  release(&ftable.lock);
80100fc0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100fc3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100fc5:	68 60 ef 10 80       	push   $0x8010ef60
80100fca:	e8 91 36 00 00       	call   80104660 <release>
}
80100fcf:	89 d8                	mov    %ebx,%eax
  return 0;
80100fd1:	83 c4 10             	add    $0x10,%esp
}
80100fd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fd7:	c9                   	leave
80100fd8:	c3                   	ret
80100fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100fe0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	53                   	push   %ebx
80100fe4:	83 ec 10             	sub    $0x10,%esp
80100fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100fea:	68 60 ef 10 80       	push   $0x8010ef60
80100fef:	e8 cc 36 00 00       	call   801046c0 <acquire>
  if(f->ref < 1)
80100ff4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ff7:	83 c4 10             	add    $0x10,%esp
80100ffa:	85 c0                	test   %eax,%eax
80100ffc:	7e 1a                	jle    80101018 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ffe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101001:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101004:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101007:	68 60 ef 10 80       	push   $0x8010ef60
8010100c:	e8 4f 36 00 00       	call   80104660 <release>
  return f;
}
80101011:	89 d8                	mov    %ebx,%eax
80101013:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101016:	c9                   	leave
80101017:	c3                   	ret
    panic("filedup");
80101018:	83 ec 0c             	sub    $0xc,%esp
8010101b:	68 03 73 10 80       	push   $0x80107303
80101020:	e8 5b f3 ff ff       	call   80100380 <panic>
80101025:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010102c:	00 
8010102d:	8d 76 00             	lea    0x0(%esi),%esi

80101030 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	57                   	push   %edi
80101034:	56                   	push   %esi
80101035:	53                   	push   %ebx
80101036:	83 ec 28             	sub    $0x28,%esp
80101039:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010103c:	68 60 ef 10 80       	push   $0x8010ef60
80101041:	e8 7a 36 00 00       	call   801046c0 <acquire>
  if(f->ref < 1)
80101046:	8b 53 04             	mov    0x4(%ebx),%edx
80101049:	83 c4 10             	add    $0x10,%esp
8010104c:	85 d2                	test   %edx,%edx
8010104e:	0f 8e a5 00 00 00    	jle    801010f9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101054:	83 ea 01             	sub    $0x1,%edx
80101057:	89 53 04             	mov    %edx,0x4(%ebx)
8010105a:	75 44                	jne    801010a0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010105c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101060:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101063:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101065:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010106b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010106e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101071:	8b 43 10             	mov    0x10(%ebx),%eax
80101074:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101077:	68 60 ef 10 80       	push   $0x8010ef60
8010107c:	e8 df 35 00 00       	call   80104660 <release>

  if(ff.type == FD_PIPE)
80101081:	83 c4 10             	add    $0x10,%esp
80101084:	83 ff 01             	cmp    $0x1,%edi
80101087:	74 57                	je     801010e0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101089:	83 ff 02             	cmp    $0x2,%edi
8010108c:	74 2a                	je     801010b8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010108e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101091:	5b                   	pop    %ebx
80101092:	5e                   	pop    %esi
80101093:	5f                   	pop    %edi
80101094:	5d                   	pop    %ebp
80101095:	c3                   	ret
80101096:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010109d:	00 
8010109e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
801010a0:	c7 45 08 60 ef 10 80 	movl   $0x8010ef60,0x8(%ebp)
}
801010a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010aa:	5b                   	pop    %ebx
801010ab:	5e                   	pop    %esi
801010ac:	5f                   	pop    %edi
801010ad:	5d                   	pop    %ebp
    release(&ftable.lock);
801010ae:	e9 ad 35 00 00       	jmp    80104660 <release>
801010b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
801010b8:	e8 a3 1d 00 00       	call   80102e60 <begin_op>
    iput(ff.ip);
801010bd:	83 ec 0c             	sub    $0xc,%esp
801010c0:	ff 75 e0             	push   -0x20(%ebp)
801010c3:	e8 28 09 00 00       	call   801019f0 <iput>
    end_op();
801010c8:	83 c4 10             	add    $0x10,%esp
}
801010cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010ce:	5b                   	pop    %ebx
801010cf:	5e                   	pop    %esi
801010d0:	5f                   	pop    %edi
801010d1:	5d                   	pop    %ebp
    end_op();
801010d2:	e9 f9 1d 00 00       	jmp    80102ed0 <end_op>
801010d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010de:	00 
801010df:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
801010e0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801010e4:	83 ec 08             	sub    $0x8,%esp
801010e7:	53                   	push   %ebx
801010e8:	56                   	push   %esi
801010e9:	e8 32 25 00 00       	call   80103620 <pipeclose>
801010ee:	83 c4 10             	add    $0x10,%esp
}
801010f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010f4:	5b                   	pop    %ebx
801010f5:	5e                   	pop    %esi
801010f6:	5f                   	pop    %edi
801010f7:	5d                   	pop    %ebp
801010f8:	c3                   	ret
    panic("fileclose");
801010f9:	83 ec 0c             	sub    $0xc,%esp
801010fc:	68 0b 73 10 80       	push   $0x8010730b
80101101:	e8 7a f2 ff ff       	call   80100380 <panic>
80101106:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010110d:	00 
8010110e:	66 90                	xchg   %ax,%ax

80101110 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	53                   	push   %ebx
80101114:	83 ec 04             	sub    $0x4,%esp
80101117:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010111a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010111d:	75 31                	jne    80101150 <filestat+0x40>
    ilock(f->ip);
8010111f:	83 ec 0c             	sub    $0xc,%esp
80101122:	ff 73 10             	push   0x10(%ebx)
80101125:	e8 96 07 00 00       	call   801018c0 <ilock>
    stati(f->ip, st);
8010112a:	58                   	pop    %eax
8010112b:	5a                   	pop    %edx
8010112c:	ff 75 0c             	push   0xc(%ebp)
8010112f:	ff 73 10             	push   0x10(%ebx)
80101132:	e8 69 0a 00 00       	call   80101ba0 <stati>
    iunlock(f->ip);
80101137:	59                   	pop    %ecx
80101138:	ff 73 10             	push   0x10(%ebx)
8010113b:	e8 60 08 00 00       	call   801019a0 <iunlock>
    return 0;
  }
  return -1;
}
80101140:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101143:	83 c4 10             	add    $0x10,%esp
80101146:	31 c0                	xor    %eax,%eax
}
80101148:	c9                   	leave
80101149:	c3                   	ret
8010114a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101150:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101153:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101158:	c9                   	leave
80101159:	c3                   	ret
8010115a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101160 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101160:	55                   	push   %ebp
80101161:	89 e5                	mov    %esp,%ebp
80101163:	57                   	push   %edi
80101164:	56                   	push   %esi
80101165:	53                   	push   %ebx
80101166:	83 ec 0c             	sub    $0xc,%esp
80101169:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010116c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010116f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101172:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101176:	74 60                	je     801011d8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101178:	8b 03                	mov    (%ebx),%eax
8010117a:	83 f8 01             	cmp    $0x1,%eax
8010117d:	74 41                	je     801011c0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010117f:	83 f8 02             	cmp    $0x2,%eax
80101182:	75 5b                	jne    801011df <fileread+0x7f>
    ilock(f->ip);
80101184:	83 ec 0c             	sub    $0xc,%esp
80101187:	ff 73 10             	push   0x10(%ebx)
8010118a:	e8 31 07 00 00       	call   801018c0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010118f:	57                   	push   %edi
80101190:	ff 73 14             	push   0x14(%ebx)
80101193:	56                   	push   %esi
80101194:	ff 73 10             	push   0x10(%ebx)
80101197:	e8 34 0a 00 00       	call   80101bd0 <readi>
8010119c:	83 c4 20             	add    $0x20,%esp
8010119f:	89 c6                	mov    %eax,%esi
801011a1:	85 c0                	test   %eax,%eax
801011a3:	7e 03                	jle    801011a8 <fileread+0x48>
      f->off += r;
801011a5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801011a8:	83 ec 0c             	sub    $0xc,%esp
801011ab:	ff 73 10             	push   0x10(%ebx)
801011ae:	e8 ed 07 00 00       	call   801019a0 <iunlock>
    return r;
801011b3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801011b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011b9:	89 f0                	mov    %esi,%eax
801011bb:	5b                   	pop    %ebx
801011bc:	5e                   	pop    %esi
801011bd:	5f                   	pop    %edi
801011be:	5d                   	pop    %ebp
801011bf:	c3                   	ret
    return piperead(f->pipe, addr, n);
801011c0:	8b 43 0c             	mov    0xc(%ebx),%eax
801011c3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011c9:	5b                   	pop    %ebx
801011ca:	5e                   	pop    %esi
801011cb:	5f                   	pop    %edi
801011cc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801011cd:	e9 0e 26 00 00       	jmp    801037e0 <piperead>
801011d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801011d8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801011dd:	eb d7                	jmp    801011b6 <fileread+0x56>
  panic("fileread");
801011df:	83 ec 0c             	sub    $0xc,%esp
801011e2:	68 15 73 10 80       	push   $0x80107315
801011e7:	e8 94 f1 ff ff       	call   80100380 <panic>
801011ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011f0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011f0:	55                   	push   %ebp
801011f1:	89 e5                	mov    %esp,%ebp
801011f3:	57                   	push   %edi
801011f4:	56                   	push   %esi
801011f5:	53                   	push   %ebx
801011f6:	83 ec 1c             	sub    $0x1c,%esp
801011f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801011fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801011ff:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101202:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101205:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101209:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010120c:	0f 84 bb 00 00 00    	je     801012cd <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101212:	8b 03                	mov    (%ebx),%eax
80101214:	83 f8 01             	cmp    $0x1,%eax
80101217:	0f 84 bf 00 00 00    	je     801012dc <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010121d:	83 f8 02             	cmp    $0x2,%eax
80101220:	0f 85 c8 00 00 00    	jne    801012ee <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101226:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101229:	31 f6                	xor    %esi,%esi
    while(i < n){
8010122b:	85 c0                	test   %eax,%eax
8010122d:	7f 30                	jg     8010125f <filewrite+0x6f>
8010122f:	e9 94 00 00 00       	jmp    801012c8 <filewrite+0xd8>
80101234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101238:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010123b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010123e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101241:	ff 73 10             	push   0x10(%ebx)
80101244:	e8 57 07 00 00       	call   801019a0 <iunlock>
      end_op();
80101249:	e8 82 1c 00 00       	call   80102ed0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010124e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101251:	83 c4 10             	add    $0x10,%esp
80101254:	39 c7                	cmp    %eax,%edi
80101256:	75 5c                	jne    801012b4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101258:	01 fe                	add    %edi,%esi
    while(i < n){
8010125a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010125d:	7e 69                	jle    801012c8 <filewrite+0xd8>
      int n1 = n - i;
8010125f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101262:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101267:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101269:	39 c7                	cmp    %eax,%edi
8010126b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010126e:	e8 ed 1b 00 00       	call   80102e60 <begin_op>
      ilock(f->ip);
80101273:	83 ec 0c             	sub    $0xc,%esp
80101276:	ff 73 10             	push   0x10(%ebx)
80101279:	e8 42 06 00 00       	call   801018c0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010127e:	57                   	push   %edi
8010127f:	ff 73 14             	push   0x14(%ebx)
80101282:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101285:	01 f0                	add    %esi,%eax
80101287:	50                   	push   %eax
80101288:	ff 73 10             	push   0x10(%ebx)
8010128b:	e8 40 0a 00 00       	call   80101cd0 <writei>
80101290:	83 c4 20             	add    $0x20,%esp
80101293:	85 c0                	test   %eax,%eax
80101295:	7f a1                	jg     80101238 <filewrite+0x48>
80101297:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010129a:	83 ec 0c             	sub    $0xc,%esp
8010129d:	ff 73 10             	push   0x10(%ebx)
801012a0:	e8 fb 06 00 00       	call   801019a0 <iunlock>
      end_op();
801012a5:	e8 26 1c 00 00       	call   80102ed0 <end_op>
      if(r < 0)
801012aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801012ad:	83 c4 10             	add    $0x10,%esp
801012b0:	85 c0                	test   %eax,%eax
801012b2:	75 14                	jne    801012c8 <filewrite+0xd8>
        panic("short filewrite");
801012b4:	83 ec 0c             	sub    $0xc,%esp
801012b7:	68 1e 73 10 80       	push   $0x8010731e
801012bc:	e8 bf f0 ff ff       	call   80100380 <panic>
801012c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
801012c8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801012cb:	74 05                	je     801012d2 <filewrite+0xe2>
801012cd:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
801012d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d5:	89 f0                	mov    %esi,%eax
801012d7:	5b                   	pop    %ebx
801012d8:	5e                   	pop    %esi
801012d9:	5f                   	pop    %edi
801012da:	5d                   	pop    %ebp
801012db:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
801012dc:	8b 43 0c             	mov    0xc(%ebx),%eax
801012df:	89 45 08             	mov    %eax,0x8(%ebp)
}
801012e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012e5:	5b                   	pop    %ebx
801012e6:	5e                   	pop    %esi
801012e7:	5f                   	pop    %edi
801012e8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801012e9:	e9 d2 23 00 00       	jmp    801036c0 <pipewrite>
  panic("filewrite");
801012ee:	83 ec 0c             	sub    $0xc,%esp
801012f1:	68 24 73 10 80       	push   $0x80107324
801012f6:	e8 85 f0 ff ff       	call   80100380 <panic>
801012fb:	66 90                	xchg   %ax,%ax
801012fd:	66 90                	xchg   %ax,%ax
801012ff:	90                   	nop

80101300 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	57                   	push   %edi
80101304:	56                   	push   %esi
80101305:	53                   	push   %ebx
80101306:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101309:	8b 0d b4 15 11 80    	mov    0x801115b4,%ecx
{
8010130f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101312:	85 c9                	test   %ecx,%ecx
80101314:	0f 84 8c 00 00 00    	je     801013a6 <balloc+0xa6>
8010131a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010131c:	89 f8                	mov    %edi,%eax
8010131e:	83 ec 08             	sub    $0x8,%esp
80101321:	89 fe                	mov    %edi,%esi
80101323:	c1 f8 0c             	sar    $0xc,%eax
80101326:	03 05 cc 15 11 80    	add    0x801115cc,%eax
8010132c:	50                   	push   %eax
8010132d:	ff 75 dc             	push   -0x24(%ebp)
80101330:	e8 9b ed ff ff       	call   801000d0 <bread>
80101335:	83 c4 10             	add    $0x10,%esp
80101338:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010133b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010133e:	a1 b4 15 11 80       	mov    0x801115b4,%eax
80101343:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101346:	31 c0                	xor    %eax,%eax
80101348:	eb 32                	jmp    8010137c <balloc+0x7c>
8010134a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101350:	89 c1                	mov    %eax,%ecx
80101352:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101357:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010135a:	83 e1 07             	and    $0x7,%ecx
8010135d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010135f:	89 c1                	mov    %eax,%ecx
80101361:	c1 f9 03             	sar    $0x3,%ecx
80101364:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101369:	89 fa                	mov    %edi,%edx
8010136b:	85 df                	test   %ebx,%edi
8010136d:	74 49                	je     801013b8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010136f:	83 c0 01             	add    $0x1,%eax
80101372:	83 c6 01             	add    $0x1,%esi
80101375:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010137a:	74 07                	je     80101383 <balloc+0x83>
8010137c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010137f:	39 d6                	cmp    %edx,%esi
80101381:	72 cd                	jb     80101350 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101383:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101386:	83 ec 0c             	sub    $0xc,%esp
80101389:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010138c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101392:	e8 59 ee ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101397:	83 c4 10             	add    $0x10,%esp
8010139a:	3b 3d b4 15 11 80    	cmp    0x801115b4,%edi
801013a0:	0f 82 76 ff ff ff    	jb     8010131c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
801013a6:	83 ec 0c             	sub    $0xc,%esp
801013a9:	68 2e 73 10 80       	push   $0x8010732e
801013ae:	e8 cd ef ff ff       	call   80100380 <panic>
801013b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801013b8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801013bb:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801013be:	09 da                	or     %ebx,%edx
801013c0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801013c4:	57                   	push   %edi
801013c5:	e8 76 1c 00 00       	call   80103040 <log_write>
        brelse(bp);
801013ca:	89 3c 24             	mov    %edi,(%esp)
801013cd:	e8 1e ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801013d2:	58                   	pop    %eax
801013d3:	5a                   	pop    %edx
801013d4:	56                   	push   %esi
801013d5:	ff 75 dc             	push   -0x24(%ebp)
801013d8:	e8 f3 ec ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801013dd:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801013e0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801013e2:	8d 40 5c             	lea    0x5c(%eax),%eax
801013e5:	68 00 02 00 00       	push   $0x200
801013ea:	6a 00                	push   $0x0
801013ec:	50                   	push   %eax
801013ed:	e8 ce 33 00 00       	call   801047c0 <memset>
  log_write(bp);
801013f2:	89 1c 24             	mov    %ebx,(%esp)
801013f5:	e8 46 1c 00 00       	call   80103040 <log_write>
  brelse(bp);
801013fa:	89 1c 24             	mov    %ebx,(%esp)
801013fd:	e8 ee ed ff ff       	call   801001f0 <brelse>
}
80101402:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101405:	89 f0                	mov    %esi,%eax
80101407:	5b                   	pop    %ebx
80101408:	5e                   	pop    %esi
80101409:	5f                   	pop    %edi
8010140a:	5d                   	pop    %ebp
8010140b:	c3                   	ret
8010140c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101410 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101414:	31 ff                	xor    %edi,%edi
{
80101416:	56                   	push   %esi
80101417:	89 c6                	mov    %eax,%esi
80101419:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010141a:	bb 94 f9 10 80       	mov    $0x8010f994,%ebx
{
8010141f:	83 ec 28             	sub    $0x28,%esp
80101422:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101425:	68 60 f9 10 80       	push   $0x8010f960
8010142a:	e8 91 32 00 00       	call   801046c0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010142f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101432:	83 c4 10             	add    $0x10,%esp
80101435:	eb 1b                	jmp    80101452 <iget+0x42>
80101437:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010143e:	00 
8010143f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101440:	39 33                	cmp    %esi,(%ebx)
80101442:	74 6c                	je     801014b0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101444:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010144a:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101450:	74 26                	je     80101478 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101452:	8b 43 08             	mov    0x8(%ebx),%eax
80101455:	85 c0                	test   %eax,%eax
80101457:	7f e7                	jg     80101440 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101459:	85 ff                	test   %edi,%edi
8010145b:	75 e7                	jne    80101444 <iget+0x34>
8010145d:	85 c0                	test   %eax,%eax
8010145f:	75 76                	jne    801014d7 <iget+0xc7>
      empty = ip;
80101461:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101463:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101469:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
8010146f:	75 e1                	jne    80101452 <iget+0x42>
80101471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101478:	85 ff                	test   %edi,%edi
8010147a:	74 79                	je     801014f5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010147c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010147f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101481:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101484:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010148b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80101492:	68 60 f9 10 80       	push   $0x8010f960
80101497:	e8 c4 31 00 00       	call   80104660 <release>

  return ip;
8010149c:	83 c4 10             	add    $0x10,%esp
}
8010149f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a2:	89 f8                	mov    %edi,%eax
801014a4:	5b                   	pop    %ebx
801014a5:	5e                   	pop    %esi
801014a6:	5f                   	pop    %edi
801014a7:	5d                   	pop    %ebp
801014a8:	c3                   	ret
801014a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014b0:	39 53 04             	cmp    %edx,0x4(%ebx)
801014b3:	75 8f                	jne    80101444 <iget+0x34>
      ip->ref++;
801014b5:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
801014b8:	83 ec 0c             	sub    $0xc,%esp
      return ip;
801014bb:	89 df                	mov    %ebx,%edi
      ip->ref++;
801014bd:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801014c0:	68 60 f9 10 80       	push   $0x8010f960
801014c5:	e8 96 31 00 00       	call   80104660 <release>
      return ip;
801014ca:	83 c4 10             	add    $0x10,%esp
}
801014cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014d0:	89 f8                	mov    %edi,%eax
801014d2:	5b                   	pop    %ebx
801014d3:	5e                   	pop    %esi
801014d4:	5f                   	pop    %edi
801014d5:	5d                   	pop    %ebp
801014d6:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014d7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014dd:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
801014e3:	74 10                	je     801014f5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014e5:	8b 43 08             	mov    0x8(%ebx),%eax
801014e8:	85 c0                	test   %eax,%eax
801014ea:	0f 8f 50 ff ff ff    	jg     80101440 <iget+0x30>
801014f0:	e9 68 ff ff ff       	jmp    8010145d <iget+0x4d>
    panic("iget: no inodes");
801014f5:	83 ec 0c             	sub    $0xc,%esp
801014f8:	68 44 73 10 80       	push   $0x80107344
801014fd:	e8 7e ee ff ff       	call   80100380 <panic>
80101502:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101509:	00 
8010150a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101510 <bfree>:
{
80101510:	55                   	push   %ebp
80101511:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101513:	89 d0                	mov    %edx,%eax
80101515:	c1 e8 0c             	shr    $0xc,%eax
{
80101518:	89 e5                	mov    %esp,%ebp
8010151a:	56                   	push   %esi
8010151b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
8010151c:	03 05 cc 15 11 80    	add    0x801115cc,%eax
{
80101522:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101524:	83 ec 08             	sub    $0x8,%esp
80101527:	50                   	push   %eax
80101528:	51                   	push   %ecx
80101529:	e8 a2 eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010152e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101530:	c1 fb 03             	sar    $0x3,%ebx
80101533:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101536:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101538:	83 e1 07             	and    $0x7,%ecx
8010153b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101540:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101546:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101548:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010154d:	85 c1                	test   %eax,%ecx
8010154f:	74 23                	je     80101574 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101551:	f7 d0                	not    %eax
  log_write(bp);
80101553:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101556:	21 c8                	and    %ecx,%eax
80101558:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010155c:	56                   	push   %esi
8010155d:	e8 de 1a 00 00       	call   80103040 <log_write>
  brelse(bp);
80101562:	89 34 24             	mov    %esi,(%esp)
80101565:	e8 86 ec ff ff       	call   801001f0 <brelse>
}
8010156a:	83 c4 10             	add    $0x10,%esp
8010156d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101570:	5b                   	pop    %ebx
80101571:	5e                   	pop    %esi
80101572:	5d                   	pop    %ebp
80101573:	c3                   	ret
    panic("freeing free block");
80101574:	83 ec 0c             	sub    $0xc,%esp
80101577:	68 54 73 10 80       	push   $0x80107354
8010157c:	e8 ff ed ff ff       	call   80100380 <panic>
80101581:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101588:	00 
80101589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101590 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	57                   	push   %edi
80101594:	56                   	push   %esi
80101595:	89 c6                	mov    %eax,%esi
80101597:	53                   	push   %ebx
80101598:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010159b:	83 fa 0b             	cmp    $0xb,%edx
8010159e:	0f 86 8c 00 00 00    	jbe    80101630 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801015a4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801015a7:	83 fb 7f             	cmp    $0x7f,%ebx
801015aa:	0f 87 a2 00 00 00    	ja     80101652 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801015b0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801015b6:	85 c0                	test   %eax,%eax
801015b8:	74 5e                	je     80101618 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801015ba:	83 ec 08             	sub    $0x8,%esp
801015bd:	50                   	push   %eax
801015be:	ff 36                	push   (%esi)
801015c0:	e8 0b eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801015c5:	83 c4 10             	add    $0x10,%esp
801015c8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801015cc:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801015ce:	8b 3b                	mov    (%ebx),%edi
801015d0:	85 ff                	test   %edi,%edi
801015d2:	74 1c                	je     801015f0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801015d4:	83 ec 0c             	sub    $0xc,%esp
801015d7:	52                   	push   %edx
801015d8:	e8 13 ec ff ff       	call   801001f0 <brelse>
801015dd:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801015e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015e3:	89 f8                	mov    %edi,%eax
801015e5:	5b                   	pop    %ebx
801015e6:	5e                   	pop    %esi
801015e7:	5f                   	pop    %edi
801015e8:	5d                   	pop    %ebp
801015e9:	c3                   	ret
801015ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801015f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801015f3:	8b 06                	mov    (%esi),%eax
801015f5:	e8 06 fd ff ff       	call   80101300 <balloc>
      log_write(bp);
801015fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015fd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101600:	89 03                	mov    %eax,(%ebx)
80101602:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101604:	52                   	push   %edx
80101605:	e8 36 1a 00 00       	call   80103040 <log_write>
8010160a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010160d:	83 c4 10             	add    $0x10,%esp
80101610:	eb c2                	jmp    801015d4 <bmap+0x44>
80101612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101618:	8b 06                	mov    (%esi),%eax
8010161a:	e8 e1 fc ff ff       	call   80101300 <balloc>
8010161f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101625:	eb 93                	jmp    801015ba <bmap+0x2a>
80101627:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010162e:	00 
8010162f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101630:	8d 5a 14             	lea    0x14(%edx),%ebx
80101633:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101637:	85 ff                	test   %edi,%edi
80101639:	75 a5                	jne    801015e0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010163b:	8b 00                	mov    (%eax),%eax
8010163d:	e8 be fc ff ff       	call   80101300 <balloc>
80101642:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101646:	89 c7                	mov    %eax,%edi
}
80101648:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010164b:	5b                   	pop    %ebx
8010164c:	89 f8                	mov    %edi,%eax
8010164e:	5e                   	pop    %esi
8010164f:	5f                   	pop    %edi
80101650:	5d                   	pop    %ebp
80101651:	c3                   	ret
  panic("bmap: out of range");
80101652:	83 ec 0c             	sub    $0xc,%esp
80101655:	68 67 73 10 80       	push   $0x80107367
8010165a:	e8 21 ed ff ff       	call   80100380 <panic>
8010165f:	90                   	nop

80101660 <readsb>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	56                   	push   %esi
80101664:	53                   	push   %ebx
80101665:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101668:	83 ec 08             	sub    $0x8,%esp
8010166b:	6a 01                	push   $0x1
8010166d:	ff 75 08             	push   0x8(%ebp)
80101670:	e8 5b ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101675:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101678:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010167a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010167d:	6a 1c                	push   $0x1c
8010167f:	50                   	push   %eax
80101680:	56                   	push   %esi
80101681:	e8 ca 31 00 00       	call   80104850 <memmove>
  brelse(bp);
80101686:	83 c4 10             	add    $0x10,%esp
80101689:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010168c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010168f:	5b                   	pop    %ebx
80101690:	5e                   	pop    %esi
80101691:	5d                   	pop    %ebp
  brelse(bp);
80101692:	e9 59 eb ff ff       	jmp    801001f0 <brelse>
80101697:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010169e:	00 
8010169f:	90                   	nop

801016a0 <iinit>:
{
801016a0:	55                   	push   %ebp
801016a1:	89 e5                	mov    %esp,%ebp
801016a3:	53                   	push   %ebx
801016a4:	bb a0 f9 10 80       	mov    $0x8010f9a0,%ebx
801016a9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801016ac:	68 7a 73 10 80       	push   $0x8010737a
801016b1:	68 60 f9 10 80       	push   $0x8010f960
801016b6:	e8 15 2e 00 00       	call   801044d0 <initlock>
  for(i = 0; i < NINODE; i++) {
801016bb:	83 c4 10             	add    $0x10,%esp
801016be:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801016c0:	83 ec 08             	sub    $0x8,%esp
801016c3:	68 81 73 10 80       	push   $0x80107381
801016c8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801016c9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801016cf:	e8 cc 2c 00 00       	call   801043a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801016d4:	83 c4 10             	add    $0x10,%esp
801016d7:	81 fb c0 15 11 80    	cmp    $0x801115c0,%ebx
801016dd:	75 e1                	jne    801016c0 <iinit+0x20>
  bp = bread(dev, 1);
801016df:	83 ec 08             	sub    $0x8,%esp
801016e2:	6a 01                	push   $0x1
801016e4:	ff 75 08             	push   0x8(%ebp)
801016e7:	e8 e4 e9 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801016ec:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801016ef:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801016f1:	8d 40 5c             	lea    0x5c(%eax),%eax
801016f4:	6a 1c                	push   $0x1c
801016f6:	50                   	push   %eax
801016f7:	68 b4 15 11 80       	push   $0x801115b4
801016fc:	e8 4f 31 00 00       	call   80104850 <memmove>
  brelse(bp);
80101701:	89 1c 24             	mov    %ebx,(%esp)
80101704:	e8 e7 ea ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101709:	ff 35 cc 15 11 80    	push   0x801115cc
8010170f:	ff 35 c8 15 11 80    	push   0x801115c8
80101715:	ff 35 c4 15 11 80    	push   0x801115c4
8010171b:	ff 35 c0 15 11 80    	push   0x801115c0
80101721:	ff 35 bc 15 11 80    	push   0x801115bc
80101727:	ff 35 b8 15 11 80    	push   0x801115b8
8010172d:	ff 35 b4 15 11 80    	push   0x801115b4
80101733:	68 ec 77 10 80       	push   $0x801077ec
80101738:	e8 73 ef ff ff       	call   801006b0 <cprintf>
}
8010173d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101740:	83 c4 30             	add    $0x30,%esp
80101743:	c9                   	leave
80101744:	c3                   	ret
80101745:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010174c:	00 
8010174d:	8d 76 00             	lea    0x0(%esi),%esi

80101750 <ialloc>:
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	57                   	push   %edi
80101754:	56                   	push   %esi
80101755:	53                   	push   %ebx
80101756:	83 ec 1c             	sub    $0x1c,%esp
80101759:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010175c:	83 3d bc 15 11 80 01 	cmpl   $0x1,0x801115bc
{
80101763:	8b 75 08             	mov    0x8(%ebp),%esi
80101766:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101769:	0f 86 91 00 00 00    	jbe    80101800 <ialloc+0xb0>
8010176f:	bf 01 00 00 00       	mov    $0x1,%edi
80101774:	eb 21                	jmp    80101797 <ialloc+0x47>
80101776:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010177d:	00 
8010177e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101780:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101783:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101786:	53                   	push   %ebx
80101787:	e8 64 ea ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010178c:	83 c4 10             	add    $0x10,%esp
8010178f:	3b 3d bc 15 11 80    	cmp    0x801115bc,%edi
80101795:	73 69                	jae    80101800 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101797:	89 f8                	mov    %edi,%eax
80101799:	83 ec 08             	sub    $0x8,%esp
8010179c:	c1 e8 03             	shr    $0x3,%eax
8010179f:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801017a5:	50                   	push   %eax
801017a6:	56                   	push   %esi
801017a7:	e8 24 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801017ac:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801017af:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801017b1:	89 f8                	mov    %edi,%eax
801017b3:	83 e0 07             	and    $0x7,%eax
801017b6:	c1 e0 06             	shl    $0x6,%eax
801017b9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801017bd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801017c1:	75 bd                	jne    80101780 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801017c3:	83 ec 04             	sub    $0x4,%esp
801017c6:	6a 40                	push   $0x40
801017c8:	6a 00                	push   $0x0
801017ca:	51                   	push   %ecx
801017cb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801017ce:	e8 ed 2f 00 00       	call   801047c0 <memset>
      dip->type = type;
801017d3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801017d7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017da:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801017dd:	89 1c 24             	mov    %ebx,(%esp)
801017e0:	e8 5b 18 00 00       	call   80103040 <log_write>
      brelse(bp);
801017e5:	89 1c 24             	mov    %ebx,(%esp)
801017e8:	e8 03 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801017ed:	83 c4 10             	add    $0x10,%esp
}
801017f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801017f3:	89 fa                	mov    %edi,%edx
}
801017f5:	5b                   	pop    %ebx
      return iget(dev, inum);
801017f6:	89 f0                	mov    %esi,%eax
}
801017f8:	5e                   	pop    %esi
801017f9:	5f                   	pop    %edi
801017fa:	5d                   	pop    %ebp
      return iget(dev, inum);
801017fb:	e9 10 fc ff ff       	jmp    80101410 <iget>
  panic("ialloc: no inodes");
80101800:	83 ec 0c             	sub    $0xc,%esp
80101803:	68 87 73 10 80       	push   $0x80107387
80101808:	e8 73 eb ff ff       	call   80100380 <panic>
8010180d:	8d 76 00             	lea    0x0(%esi),%esi

80101810 <iupdate>:
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	56                   	push   %esi
80101814:	53                   	push   %ebx
80101815:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101818:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010181b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010181e:	83 ec 08             	sub    $0x8,%esp
80101821:	c1 e8 03             	shr    $0x3,%eax
80101824:	03 05 c8 15 11 80    	add    0x801115c8,%eax
8010182a:	50                   	push   %eax
8010182b:	ff 73 a4             	push   -0x5c(%ebx)
8010182e:	e8 9d e8 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101833:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101837:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010183a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010183c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010183f:	83 e0 07             	and    $0x7,%eax
80101842:	c1 e0 06             	shl    $0x6,%eax
80101845:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101849:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010184c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101850:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101853:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101857:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010185b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010185f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101863:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101867:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010186a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010186d:	6a 34                	push   $0x34
8010186f:	53                   	push   %ebx
80101870:	50                   	push   %eax
80101871:	e8 da 2f 00 00       	call   80104850 <memmove>
  log_write(bp);
80101876:	89 34 24             	mov    %esi,(%esp)
80101879:	e8 c2 17 00 00       	call   80103040 <log_write>
  brelse(bp);
8010187e:	83 c4 10             	add    $0x10,%esp
80101881:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101884:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101887:	5b                   	pop    %ebx
80101888:	5e                   	pop    %esi
80101889:	5d                   	pop    %ebp
  brelse(bp);
8010188a:	e9 61 e9 ff ff       	jmp    801001f0 <brelse>
8010188f:	90                   	nop

80101890 <idup>:
{
80101890:	55                   	push   %ebp
80101891:	89 e5                	mov    %esp,%ebp
80101893:	53                   	push   %ebx
80101894:	83 ec 10             	sub    $0x10,%esp
80101897:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010189a:	68 60 f9 10 80       	push   $0x8010f960
8010189f:	e8 1c 2e 00 00       	call   801046c0 <acquire>
  ip->ref++;
801018a4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018a8:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801018af:	e8 ac 2d 00 00       	call   80104660 <release>
}
801018b4:	89 d8                	mov    %ebx,%eax
801018b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018b9:	c9                   	leave
801018ba:	c3                   	ret
801018bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801018c0 <ilock>:
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	56                   	push   %esi
801018c4:	53                   	push   %ebx
801018c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801018c8:	85 db                	test   %ebx,%ebx
801018ca:	0f 84 b7 00 00 00    	je     80101987 <ilock+0xc7>
801018d0:	8b 53 08             	mov    0x8(%ebx),%edx
801018d3:	85 d2                	test   %edx,%edx
801018d5:	0f 8e ac 00 00 00    	jle    80101987 <ilock+0xc7>
  acquiresleep(&ip->lock);
801018db:	83 ec 0c             	sub    $0xc,%esp
801018de:	8d 43 0c             	lea    0xc(%ebx),%eax
801018e1:	50                   	push   %eax
801018e2:	e8 f9 2a 00 00       	call   801043e0 <acquiresleep>
  if(ip->valid == 0){
801018e7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801018ea:	83 c4 10             	add    $0x10,%esp
801018ed:	85 c0                	test   %eax,%eax
801018ef:	74 0f                	je     80101900 <ilock+0x40>
}
801018f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018f4:	5b                   	pop    %ebx
801018f5:	5e                   	pop    %esi
801018f6:	5d                   	pop    %ebp
801018f7:	c3                   	ret
801018f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018ff:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101900:	8b 43 04             	mov    0x4(%ebx),%eax
80101903:	83 ec 08             	sub    $0x8,%esp
80101906:	c1 e8 03             	shr    $0x3,%eax
80101909:	03 05 c8 15 11 80    	add    0x801115c8,%eax
8010190f:	50                   	push   %eax
80101910:	ff 33                	push   (%ebx)
80101912:	e8 b9 e7 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101917:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010191a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010191c:	8b 43 04             	mov    0x4(%ebx),%eax
8010191f:	83 e0 07             	and    $0x7,%eax
80101922:	c1 e0 06             	shl    $0x6,%eax
80101925:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101929:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010192c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010192f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101933:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101937:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010193b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010193f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101943:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101947:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010194b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010194e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101951:	6a 34                	push   $0x34
80101953:	50                   	push   %eax
80101954:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101957:	50                   	push   %eax
80101958:	e8 f3 2e 00 00       	call   80104850 <memmove>
    brelse(bp);
8010195d:	89 34 24             	mov    %esi,(%esp)
80101960:	e8 8b e8 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101965:	83 c4 10             	add    $0x10,%esp
80101968:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010196d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101974:	0f 85 77 ff ff ff    	jne    801018f1 <ilock+0x31>
      panic("ilock: no type");
8010197a:	83 ec 0c             	sub    $0xc,%esp
8010197d:	68 9f 73 10 80       	push   $0x8010739f
80101982:	e8 f9 e9 ff ff       	call   80100380 <panic>
    panic("ilock");
80101987:	83 ec 0c             	sub    $0xc,%esp
8010198a:	68 99 73 10 80       	push   $0x80107399
8010198f:	e8 ec e9 ff ff       	call   80100380 <panic>
80101994:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010199b:	00 
8010199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019a0 <iunlock>:
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	56                   	push   %esi
801019a4:	53                   	push   %ebx
801019a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801019a8:	85 db                	test   %ebx,%ebx
801019aa:	74 28                	je     801019d4 <iunlock+0x34>
801019ac:	83 ec 0c             	sub    $0xc,%esp
801019af:	8d 73 0c             	lea    0xc(%ebx),%esi
801019b2:	56                   	push   %esi
801019b3:	e8 c8 2a 00 00       	call   80104480 <holdingsleep>
801019b8:	83 c4 10             	add    $0x10,%esp
801019bb:	85 c0                	test   %eax,%eax
801019bd:	74 15                	je     801019d4 <iunlock+0x34>
801019bf:	8b 43 08             	mov    0x8(%ebx),%eax
801019c2:	85 c0                	test   %eax,%eax
801019c4:	7e 0e                	jle    801019d4 <iunlock+0x34>
  releasesleep(&ip->lock);
801019c6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801019c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019cc:	5b                   	pop    %ebx
801019cd:	5e                   	pop    %esi
801019ce:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801019cf:	e9 6c 2a 00 00       	jmp    80104440 <releasesleep>
    panic("iunlock");
801019d4:	83 ec 0c             	sub    $0xc,%esp
801019d7:	68 ae 73 10 80       	push   $0x801073ae
801019dc:	e8 9f e9 ff ff       	call   80100380 <panic>
801019e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801019e8:	00 
801019e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801019f0 <iput>:
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	57                   	push   %edi
801019f4:	56                   	push   %esi
801019f5:	53                   	push   %ebx
801019f6:	83 ec 28             	sub    $0x28,%esp
801019f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801019fc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801019ff:	57                   	push   %edi
80101a00:	e8 db 29 00 00       	call   801043e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101a05:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101a08:	83 c4 10             	add    $0x10,%esp
80101a0b:	85 d2                	test   %edx,%edx
80101a0d:	74 07                	je     80101a16 <iput+0x26>
80101a0f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101a14:	74 32                	je     80101a48 <iput+0x58>
  releasesleep(&ip->lock);
80101a16:	83 ec 0c             	sub    $0xc,%esp
80101a19:	57                   	push   %edi
80101a1a:	e8 21 2a 00 00       	call   80104440 <releasesleep>
  acquire(&icache.lock);
80101a1f:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101a26:	e8 95 2c 00 00       	call   801046c0 <acquire>
  ip->ref--;
80101a2b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101a2f:	83 c4 10             	add    $0x10,%esp
80101a32:	c7 45 08 60 f9 10 80 	movl   $0x8010f960,0x8(%ebp)
}
80101a39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a3c:	5b                   	pop    %ebx
80101a3d:	5e                   	pop    %esi
80101a3e:	5f                   	pop    %edi
80101a3f:	5d                   	pop    %ebp
  release(&icache.lock);
80101a40:	e9 1b 2c 00 00       	jmp    80104660 <release>
80101a45:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101a48:	83 ec 0c             	sub    $0xc,%esp
80101a4b:	68 60 f9 10 80       	push   $0x8010f960
80101a50:	e8 6b 2c 00 00       	call   801046c0 <acquire>
    int r = ip->ref;
80101a55:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101a58:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101a5f:	e8 fc 2b 00 00       	call   80104660 <release>
    if(r == 1){
80101a64:	83 c4 10             	add    $0x10,%esp
80101a67:	83 fe 01             	cmp    $0x1,%esi
80101a6a:	75 aa                	jne    80101a16 <iput+0x26>
80101a6c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101a72:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a75:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101a78:	89 df                	mov    %ebx,%edi
80101a7a:	89 cb                	mov    %ecx,%ebx
80101a7c:	eb 09                	jmp    80101a87 <iput+0x97>
80101a7e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a80:	83 c6 04             	add    $0x4,%esi
80101a83:	39 de                	cmp    %ebx,%esi
80101a85:	74 19                	je     80101aa0 <iput+0xb0>
    if(ip->addrs[i]){
80101a87:	8b 16                	mov    (%esi),%edx
80101a89:	85 d2                	test   %edx,%edx
80101a8b:	74 f3                	je     80101a80 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a8d:	8b 07                	mov    (%edi),%eax
80101a8f:	e8 7c fa ff ff       	call   80101510 <bfree>
      ip->addrs[i] = 0;
80101a94:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101a9a:	eb e4                	jmp    80101a80 <iput+0x90>
80101a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101aa0:	89 fb                	mov    %edi,%ebx
80101aa2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101aa5:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101aab:	85 c0                	test   %eax,%eax
80101aad:	75 2d                	jne    80101adc <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101aaf:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101ab2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101ab9:	53                   	push   %ebx
80101aba:	e8 51 fd ff ff       	call   80101810 <iupdate>
      ip->type = 0;
80101abf:	31 c0                	xor    %eax,%eax
80101ac1:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101ac5:	89 1c 24             	mov    %ebx,(%esp)
80101ac8:	e8 43 fd ff ff       	call   80101810 <iupdate>
      ip->valid = 0;
80101acd:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101ad4:	83 c4 10             	add    $0x10,%esp
80101ad7:	e9 3a ff ff ff       	jmp    80101a16 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101adc:	83 ec 08             	sub    $0x8,%esp
80101adf:	50                   	push   %eax
80101ae0:	ff 33                	push   (%ebx)
80101ae2:	e8 e9 e5 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101ae7:	83 c4 10             	add    $0x10,%esp
80101aea:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101aed:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101af3:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101af6:	8d 70 5c             	lea    0x5c(%eax),%esi
80101af9:	89 cf                	mov    %ecx,%edi
80101afb:	eb 0a                	jmp    80101b07 <iput+0x117>
80101afd:	8d 76 00             	lea    0x0(%esi),%esi
80101b00:	83 c6 04             	add    $0x4,%esi
80101b03:	39 fe                	cmp    %edi,%esi
80101b05:	74 0f                	je     80101b16 <iput+0x126>
      if(a[j])
80101b07:	8b 16                	mov    (%esi),%edx
80101b09:	85 d2                	test   %edx,%edx
80101b0b:	74 f3                	je     80101b00 <iput+0x110>
        bfree(ip->dev, a[j]);
80101b0d:	8b 03                	mov    (%ebx),%eax
80101b0f:	e8 fc f9 ff ff       	call   80101510 <bfree>
80101b14:	eb ea                	jmp    80101b00 <iput+0x110>
    brelse(bp);
80101b16:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b19:	83 ec 0c             	sub    $0xc,%esp
80101b1c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101b1f:	50                   	push   %eax
80101b20:	e8 cb e6 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101b25:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101b2b:	8b 03                	mov    (%ebx),%eax
80101b2d:	e8 de f9 ff ff       	call   80101510 <bfree>
    ip->addrs[NDIRECT] = 0;
80101b32:	83 c4 10             	add    $0x10,%esp
80101b35:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101b3c:	00 00 00 
80101b3f:	e9 6b ff ff ff       	jmp    80101aaf <iput+0xbf>
80101b44:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b4b:	00 
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b50 <iunlockput>:
{
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	56                   	push   %esi
80101b54:	53                   	push   %ebx
80101b55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b58:	85 db                	test   %ebx,%ebx
80101b5a:	74 34                	je     80101b90 <iunlockput+0x40>
80101b5c:	83 ec 0c             	sub    $0xc,%esp
80101b5f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b62:	56                   	push   %esi
80101b63:	e8 18 29 00 00       	call   80104480 <holdingsleep>
80101b68:	83 c4 10             	add    $0x10,%esp
80101b6b:	85 c0                	test   %eax,%eax
80101b6d:	74 21                	je     80101b90 <iunlockput+0x40>
80101b6f:	8b 43 08             	mov    0x8(%ebx),%eax
80101b72:	85 c0                	test   %eax,%eax
80101b74:	7e 1a                	jle    80101b90 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101b76:	83 ec 0c             	sub    $0xc,%esp
80101b79:	56                   	push   %esi
80101b7a:	e8 c1 28 00 00       	call   80104440 <releasesleep>
  iput(ip);
80101b7f:	83 c4 10             	add    $0x10,%esp
80101b82:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101b85:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b88:	5b                   	pop    %ebx
80101b89:	5e                   	pop    %esi
80101b8a:	5d                   	pop    %ebp
  iput(ip);
80101b8b:	e9 60 fe ff ff       	jmp    801019f0 <iput>
    panic("iunlock");
80101b90:	83 ec 0c             	sub    $0xc,%esp
80101b93:	68 ae 73 10 80       	push   $0x801073ae
80101b98:	e8 e3 e7 ff ff       	call   80100380 <panic>
80101b9d:	8d 76 00             	lea    0x0(%esi),%esi

80101ba0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ba6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ba9:	8b 0a                	mov    (%edx),%ecx
80101bab:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101bae:	8b 4a 04             	mov    0x4(%edx),%ecx
80101bb1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101bb4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101bb8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101bbb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101bbf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101bc3:	8b 52 58             	mov    0x58(%edx),%edx
80101bc6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101bc9:	5d                   	pop    %ebp
80101bca:	c3                   	ret
80101bcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101bd0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	57                   	push   %edi
80101bd4:	56                   	push   %esi
80101bd5:	53                   	push   %ebx
80101bd6:	83 ec 1c             	sub    $0x1c,%esp
80101bd9:	8b 75 08             	mov    0x8(%ebp),%esi
80101bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bdf:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101be2:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101be7:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101bea:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101bed:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101bf0:	0f 84 aa 00 00 00    	je     80101ca0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101bf6:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101bf9:	8b 56 58             	mov    0x58(%esi),%edx
80101bfc:	39 fa                	cmp    %edi,%edx
80101bfe:	0f 82 bd 00 00 00    	jb     80101cc1 <readi+0xf1>
80101c04:	89 f9                	mov    %edi,%ecx
80101c06:	31 db                	xor    %ebx,%ebx
80101c08:	01 c1                	add    %eax,%ecx
80101c0a:	0f 92 c3             	setb   %bl
80101c0d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101c10:	0f 82 ab 00 00 00    	jb     80101cc1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101c16:	89 d3                	mov    %edx,%ebx
80101c18:	29 fb                	sub    %edi,%ebx
80101c1a:	39 ca                	cmp    %ecx,%edx
80101c1c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c1f:	85 c0                	test   %eax,%eax
80101c21:	74 73                	je     80101c96 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101c23:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101c26:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c30:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101c33:	89 fa                	mov    %edi,%edx
80101c35:	c1 ea 09             	shr    $0x9,%edx
80101c38:	89 d8                	mov    %ebx,%eax
80101c3a:	e8 51 f9 ff ff       	call   80101590 <bmap>
80101c3f:	83 ec 08             	sub    $0x8,%esp
80101c42:	50                   	push   %eax
80101c43:	ff 33                	push   (%ebx)
80101c45:	e8 86 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c4a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c4d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c52:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c54:	89 f8                	mov    %edi,%eax
80101c56:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c5b:	29 f3                	sub    %esi,%ebx
80101c5d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101c5f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c63:	39 d9                	cmp    %ebx,%ecx
80101c65:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c68:	83 c4 0c             	add    $0xc,%esp
80101c6b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c6c:	01 de                	add    %ebx,%esi
80101c6e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101c70:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101c73:	50                   	push   %eax
80101c74:	ff 75 e0             	push   -0x20(%ebp)
80101c77:	e8 d4 2b 00 00       	call   80104850 <memmove>
    brelse(bp);
80101c7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c7f:	89 14 24             	mov    %edx,(%esp)
80101c82:	e8 69 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c87:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101c8a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c8d:	83 c4 10             	add    $0x10,%esp
80101c90:	39 de                	cmp    %ebx,%esi
80101c92:	72 9c                	jb     80101c30 <readi+0x60>
80101c94:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101c96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c99:	5b                   	pop    %ebx
80101c9a:	5e                   	pop    %esi
80101c9b:	5f                   	pop    %edi
80101c9c:	5d                   	pop    %ebp
80101c9d:	c3                   	ret
80101c9e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ca0:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101ca4:	66 83 fa 09          	cmp    $0x9,%dx
80101ca8:	77 17                	ja     80101cc1 <readi+0xf1>
80101caa:	8b 14 d5 00 f9 10 80 	mov    -0x7fef0700(,%edx,8),%edx
80101cb1:	85 d2                	test   %edx,%edx
80101cb3:	74 0c                	je     80101cc1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101cb5:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101cb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cbb:	5b                   	pop    %ebx
80101cbc:	5e                   	pop    %esi
80101cbd:	5f                   	pop    %edi
80101cbe:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101cbf:	ff e2                	jmp    *%edx
      return -1;
80101cc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cc6:	eb ce                	jmp    80101c96 <readi+0xc6>
80101cc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ccf:	00 

80101cd0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101cd0:	55                   	push   %ebp
80101cd1:	89 e5                	mov    %esp,%ebp
80101cd3:	57                   	push   %edi
80101cd4:	56                   	push   %esi
80101cd5:	53                   	push   %ebx
80101cd6:	83 ec 1c             	sub    $0x1c,%esp
80101cd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cdc:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101cdf:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ce2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ce7:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101cea:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101ced:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101cf0:	0f 84 ba 00 00 00    	je     80101db0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101cf6:	39 78 58             	cmp    %edi,0x58(%eax)
80101cf9:	0f 82 ea 00 00 00    	jb     80101de9 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101cff:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101d02:	89 f2                	mov    %esi,%edx
80101d04:	01 fa                	add    %edi,%edx
80101d06:	0f 82 dd 00 00 00    	jb     80101de9 <writei+0x119>
80101d0c:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101d12:	0f 87 d1 00 00 00    	ja     80101de9 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d18:	85 f6                	test   %esi,%esi
80101d1a:	0f 84 85 00 00 00    	je     80101da5 <writei+0xd5>
80101d20:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101d27:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d30:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101d33:	89 fa                	mov    %edi,%edx
80101d35:	c1 ea 09             	shr    $0x9,%edx
80101d38:	89 f0                	mov    %esi,%eax
80101d3a:	e8 51 f8 ff ff       	call   80101590 <bmap>
80101d3f:	83 ec 08             	sub    $0x8,%esp
80101d42:	50                   	push   %eax
80101d43:	ff 36                	push   (%esi)
80101d45:	e8 86 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d4a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d4d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d50:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d55:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101d57:	89 f8                	mov    %edi,%eax
80101d59:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d5e:	29 d3                	sub    %edx,%ebx
80101d60:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d62:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d66:	39 d9                	cmp    %ebx,%ecx
80101d68:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d6b:	83 c4 0c             	add    $0xc,%esp
80101d6e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d6f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101d71:	ff 75 dc             	push   -0x24(%ebp)
80101d74:	50                   	push   %eax
80101d75:	e8 d6 2a 00 00       	call   80104850 <memmove>
    log_write(bp);
80101d7a:	89 34 24             	mov    %esi,(%esp)
80101d7d:	e8 be 12 00 00       	call   80103040 <log_write>
    brelse(bp);
80101d82:	89 34 24             	mov    %esi,(%esp)
80101d85:	e8 66 e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d8a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d90:	83 c4 10             	add    $0x10,%esp
80101d93:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101d96:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d99:	39 d8                	cmp    %ebx,%eax
80101d9b:	72 93                	jb     80101d30 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101d9d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101da0:	39 78 58             	cmp    %edi,0x58(%eax)
80101da3:	72 33                	jb     80101dd8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101da5:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101da8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dab:	5b                   	pop    %ebx
80101dac:	5e                   	pop    %esi
80101dad:	5f                   	pop    %edi
80101dae:	5d                   	pop    %ebp
80101daf:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101db0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101db4:	66 83 f8 09          	cmp    $0x9,%ax
80101db8:	77 2f                	ja     80101de9 <writei+0x119>
80101dba:	8b 04 c5 04 f9 10 80 	mov    -0x7fef06fc(,%eax,8),%eax
80101dc1:	85 c0                	test   %eax,%eax
80101dc3:	74 24                	je     80101de9 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101dc5:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101dc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dcb:	5b                   	pop    %ebx
80101dcc:	5e                   	pop    %esi
80101dcd:	5f                   	pop    %edi
80101dce:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101dcf:	ff e0                	jmp    *%eax
80101dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101dd8:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101ddb:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101dde:	50                   	push   %eax
80101ddf:	e8 2c fa ff ff       	call   80101810 <iupdate>
80101de4:	83 c4 10             	add    $0x10,%esp
80101de7:	eb bc                	jmp    80101da5 <writei+0xd5>
      return -1;
80101de9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dee:	eb b8                	jmp    80101da8 <writei+0xd8>

80101df0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101df6:	6a 0e                	push   $0xe
80101df8:	ff 75 0c             	push   0xc(%ebp)
80101dfb:	ff 75 08             	push   0x8(%ebp)
80101dfe:	e8 bd 2a 00 00       	call   801048c0 <strncmp>
}
80101e03:	c9                   	leave
80101e04:	c3                   	ret
80101e05:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e0c:	00 
80101e0d:	8d 76 00             	lea    0x0(%esi),%esi

80101e10 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101e10:	55                   	push   %ebp
80101e11:	89 e5                	mov    %esp,%ebp
80101e13:	57                   	push   %edi
80101e14:	56                   	push   %esi
80101e15:	53                   	push   %ebx
80101e16:	83 ec 1c             	sub    $0x1c,%esp
80101e19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101e1c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101e21:	0f 85 85 00 00 00    	jne    80101eac <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101e27:	8b 53 58             	mov    0x58(%ebx),%edx
80101e2a:	31 ff                	xor    %edi,%edi
80101e2c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e2f:	85 d2                	test   %edx,%edx
80101e31:	74 3e                	je     80101e71 <dirlookup+0x61>
80101e33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e38:	6a 10                	push   $0x10
80101e3a:	57                   	push   %edi
80101e3b:	56                   	push   %esi
80101e3c:	53                   	push   %ebx
80101e3d:	e8 8e fd ff ff       	call   80101bd0 <readi>
80101e42:	83 c4 10             	add    $0x10,%esp
80101e45:	83 f8 10             	cmp    $0x10,%eax
80101e48:	75 55                	jne    80101e9f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101e4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e4f:	74 18                	je     80101e69 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101e51:	83 ec 04             	sub    $0x4,%esp
80101e54:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e57:	6a 0e                	push   $0xe
80101e59:	50                   	push   %eax
80101e5a:	ff 75 0c             	push   0xc(%ebp)
80101e5d:	e8 5e 2a 00 00       	call   801048c0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e62:	83 c4 10             	add    $0x10,%esp
80101e65:	85 c0                	test   %eax,%eax
80101e67:	74 17                	je     80101e80 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e69:	83 c7 10             	add    $0x10,%edi
80101e6c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e6f:	72 c7                	jb     80101e38 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101e74:	31 c0                	xor    %eax,%eax
}
80101e76:	5b                   	pop    %ebx
80101e77:	5e                   	pop    %esi
80101e78:	5f                   	pop    %edi
80101e79:	5d                   	pop    %ebp
80101e7a:	c3                   	ret
80101e7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101e80:	8b 45 10             	mov    0x10(%ebp),%eax
80101e83:	85 c0                	test   %eax,%eax
80101e85:	74 05                	je     80101e8c <dirlookup+0x7c>
        *poff = off;
80101e87:	8b 45 10             	mov    0x10(%ebp),%eax
80101e8a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101e8c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101e90:	8b 03                	mov    (%ebx),%eax
80101e92:	e8 79 f5 ff ff       	call   80101410 <iget>
}
80101e97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e9a:	5b                   	pop    %ebx
80101e9b:	5e                   	pop    %esi
80101e9c:	5f                   	pop    %edi
80101e9d:	5d                   	pop    %ebp
80101e9e:	c3                   	ret
      panic("dirlookup read");
80101e9f:	83 ec 0c             	sub    $0xc,%esp
80101ea2:	68 c8 73 10 80       	push   $0x801073c8
80101ea7:	e8 d4 e4 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101eac:	83 ec 0c             	sub    $0xc,%esp
80101eaf:	68 b6 73 10 80       	push   $0x801073b6
80101eb4:	e8 c7 e4 ff ff       	call   80100380 <panic>
80101eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ec0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
80101ec3:	57                   	push   %edi
80101ec4:	56                   	push   %esi
80101ec5:	53                   	push   %ebx
80101ec6:	89 c3                	mov    %eax,%ebx
80101ec8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101ecb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101ece:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ed1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101ed4:	0f 84 9e 01 00 00    	je     80102078 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101eda:	e8 a1 1b 00 00       	call   80103a80 <myproc>
  acquire(&icache.lock);
80101edf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ee2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ee5:	68 60 f9 10 80       	push   $0x8010f960
80101eea:	e8 d1 27 00 00       	call   801046c0 <acquire>
  ip->ref++;
80101eef:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ef3:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101efa:	e8 61 27 00 00       	call   80104660 <release>
80101eff:	83 c4 10             	add    $0x10,%esp
80101f02:	eb 07                	jmp    80101f0b <namex+0x4b>
80101f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101f08:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f0b:	0f b6 03             	movzbl (%ebx),%eax
80101f0e:	3c 2f                	cmp    $0x2f,%al
80101f10:	74 f6                	je     80101f08 <namex+0x48>
  if(*path == 0)
80101f12:	84 c0                	test   %al,%al
80101f14:	0f 84 06 01 00 00    	je     80102020 <namex+0x160>
  while(*path != '/' && *path != 0)
80101f1a:	0f b6 03             	movzbl (%ebx),%eax
80101f1d:	84 c0                	test   %al,%al
80101f1f:	0f 84 10 01 00 00    	je     80102035 <namex+0x175>
80101f25:	89 df                	mov    %ebx,%edi
80101f27:	3c 2f                	cmp    $0x2f,%al
80101f29:	0f 84 06 01 00 00    	je     80102035 <namex+0x175>
80101f2f:	90                   	nop
80101f30:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101f34:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101f37:	3c 2f                	cmp    $0x2f,%al
80101f39:	74 04                	je     80101f3f <namex+0x7f>
80101f3b:	84 c0                	test   %al,%al
80101f3d:	75 f1                	jne    80101f30 <namex+0x70>
  len = path - s;
80101f3f:	89 f8                	mov    %edi,%eax
80101f41:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101f43:	83 f8 0d             	cmp    $0xd,%eax
80101f46:	0f 8e ac 00 00 00    	jle    80101ff8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101f4c:	83 ec 04             	sub    $0x4,%esp
80101f4f:	6a 0e                	push   $0xe
80101f51:	53                   	push   %ebx
80101f52:	89 fb                	mov    %edi,%ebx
80101f54:	ff 75 e4             	push   -0x1c(%ebp)
80101f57:	e8 f4 28 00 00       	call   80104850 <memmove>
80101f5c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f5f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101f62:	75 0c                	jne    80101f70 <namex+0xb0>
80101f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101f68:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f6b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f6e:	74 f8                	je     80101f68 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f70:	83 ec 0c             	sub    $0xc,%esp
80101f73:	56                   	push   %esi
80101f74:	e8 47 f9 ff ff       	call   801018c0 <ilock>
    if(ip->type != T_DIR){
80101f79:	83 c4 10             	add    $0x10,%esp
80101f7c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f81:	0f 85 b7 00 00 00    	jne    8010203e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f87:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f8a:	85 c0                	test   %eax,%eax
80101f8c:	74 09                	je     80101f97 <namex+0xd7>
80101f8e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f91:	0f 84 f7 00 00 00    	je     8010208e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f97:	83 ec 04             	sub    $0x4,%esp
80101f9a:	6a 00                	push   $0x0
80101f9c:	ff 75 e4             	push   -0x1c(%ebp)
80101f9f:	56                   	push   %esi
80101fa0:	e8 6b fe ff ff       	call   80101e10 <dirlookup>
80101fa5:	83 c4 10             	add    $0x10,%esp
80101fa8:	89 c7                	mov    %eax,%edi
80101faa:	85 c0                	test   %eax,%eax
80101fac:	0f 84 8c 00 00 00    	je     8010203e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fb2:	83 ec 0c             	sub    $0xc,%esp
80101fb5:	8d 4e 0c             	lea    0xc(%esi),%ecx
80101fb8:	51                   	push   %ecx
80101fb9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101fbc:	e8 bf 24 00 00       	call   80104480 <holdingsleep>
80101fc1:	83 c4 10             	add    $0x10,%esp
80101fc4:	85 c0                	test   %eax,%eax
80101fc6:	0f 84 02 01 00 00    	je     801020ce <namex+0x20e>
80101fcc:	8b 56 08             	mov    0x8(%esi),%edx
80101fcf:	85 d2                	test   %edx,%edx
80101fd1:	0f 8e f7 00 00 00    	jle    801020ce <namex+0x20e>
  releasesleep(&ip->lock);
80101fd7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101fda:	83 ec 0c             	sub    $0xc,%esp
80101fdd:	51                   	push   %ecx
80101fde:	e8 5d 24 00 00       	call   80104440 <releasesleep>
  iput(ip);
80101fe3:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101fe6:	89 fe                	mov    %edi,%esi
  iput(ip);
80101fe8:	e8 03 fa ff ff       	call   801019f0 <iput>
80101fed:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101ff0:	e9 16 ff ff ff       	jmp    80101f0b <namex+0x4b>
80101ff5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101ff8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ffb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80101ffe:	83 ec 04             	sub    $0x4,%esp
80102001:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102004:	50                   	push   %eax
80102005:	53                   	push   %ebx
    name[len] = 0;
80102006:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102008:	ff 75 e4             	push   -0x1c(%ebp)
8010200b:	e8 40 28 00 00       	call   80104850 <memmove>
    name[len] = 0;
80102010:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102013:	83 c4 10             	add    $0x10,%esp
80102016:	c6 01 00             	movb   $0x0,(%ecx)
80102019:	e9 41 ff ff ff       	jmp    80101f5f <namex+0x9f>
8010201e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80102020:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102023:	85 c0                	test   %eax,%eax
80102025:	0f 85 93 00 00 00    	jne    801020be <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
8010202b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010202e:	89 f0                	mov    %esi,%eax
80102030:	5b                   	pop    %ebx
80102031:	5e                   	pop    %esi
80102032:	5f                   	pop    %edi
80102033:	5d                   	pop    %ebp
80102034:	c3                   	ret
  while(*path != '/' && *path != 0)
80102035:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102038:	89 df                	mov    %ebx,%edi
8010203a:	31 c0                	xor    %eax,%eax
8010203c:	eb c0                	jmp    80101ffe <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010203e:	83 ec 0c             	sub    $0xc,%esp
80102041:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102044:	53                   	push   %ebx
80102045:	e8 36 24 00 00       	call   80104480 <holdingsleep>
8010204a:	83 c4 10             	add    $0x10,%esp
8010204d:	85 c0                	test   %eax,%eax
8010204f:	74 7d                	je     801020ce <namex+0x20e>
80102051:	8b 4e 08             	mov    0x8(%esi),%ecx
80102054:	85 c9                	test   %ecx,%ecx
80102056:	7e 76                	jle    801020ce <namex+0x20e>
  releasesleep(&ip->lock);
80102058:	83 ec 0c             	sub    $0xc,%esp
8010205b:	53                   	push   %ebx
8010205c:	e8 df 23 00 00       	call   80104440 <releasesleep>
  iput(ip);
80102061:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102064:	31 f6                	xor    %esi,%esi
  iput(ip);
80102066:	e8 85 f9 ff ff       	call   801019f0 <iput>
      return 0;
8010206b:	83 c4 10             	add    $0x10,%esp
}
8010206e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102071:	89 f0                	mov    %esi,%eax
80102073:	5b                   	pop    %ebx
80102074:	5e                   	pop    %esi
80102075:	5f                   	pop    %edi
80102076:	5d                   	pop    %ebp
80102077:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102078:	ba 01 00 00 00       	mov    $0x1,%edx
8010207d:	b8 01 00 00 00       	mov    $0x1,%eax
80102082:	e8 89 f3 ff ff       	call   80101410 <iget>
80102087:	89 c6                	mov    %eax,%esi
80102089:	e9 7d fe ff ff       	jmp    80101f0b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010208e:	83 ec 0c             	sub    $0xc,%esp
80102091:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102094:	53                   	push   %ebx
80102095:	e8 e6 23 00 00       	call   80104480 <holdingsleep>
8010209a:	83 c4 10             	add    $0x10,%esp
8010209d:	85 c0                	test   %eax,%eax
8010209f:	74 2d                	je     801020ce <namex+0x20e>
801020a1:	8b 7e 08             	mov    0x8(%esi),%edi
801020a4:	85 ff                	test   %edi,%edi
801020a6:	7e 26                	jle    801020ce <namex+0x20e>
  releasesleep(&ip->lock);
801020a8:	83 ec 0c             	sub    $0xc,%esp
801020ab:	53                   	push   %ebx
801020ac:	e8 8f 23 00 00       	call   80104440 <releasesleep>
}
801020b1:	83 c4 10             	add    $0x10,%esp
}
801020b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b7:	89 f0                	mov    %esi,%eax
801020b9:	5b                   	pop    %ebx
801020ba:	5e                   	pop    %esi
801020bb:	5f                   	pop    %edi
801020bc:	5d                   	pop    %ebp
801020bd:	c3                   	ret
    iput(ip);
801020be:	83 ec 0c             	sub    $0xc,%esp
801020c1:	56                   	push   %esi
      return 0;
801020c2:	31 f6                	xor    %esi,%esi
    iput(ip);
801020c4:	e8 27 f9 ff ff       	call   801019f0 <iput>
    return 0;
801020c9:	83 c4 10             	add    $0x10,%esp
801020cc:	eb a0                	jmp    8010206e <namex+0x1ae>
    panic("iunlock");
801020ce:	83 ec 0c             	sub    $0xc,%esp
801020d1:	68 ae 73 10 80       	push   $0x801073ae
801020d6:	e8 a5 e2 ff ff       	call   80100380 <panic>
801020db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801020e0 <dirlink>:
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	57                   	push   %edi
801020e4:	56                   	push   %esi
801020e5:	53                   	push   %ebx
801020e6:	83 ec 20             	sub    $0x20,%esp
801020e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801020ec:	6a 00                	push   $0x0
801020ee:	ff 75 0c             	push   0xc(%ebp)
801020f1:	53                   	push   %ebx
801020f2:	e8 19 fd ff ff       	call   80101e10 <dirlookup>
801020f7:	83 c4 10             	add    $0x10,%esp
801020fa:	85 c0                	test   %eax,%eax
801020fc:	75 67                	jne    80102165 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801020fe:	8b 7b 58             	mov    0x58(%ebx),%edi
80102101:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102104:	85 ff                	test   %edi,%edi
80102106:	74 29                	je     80102131 <dirlink+0x51>
80102108:	31 ff                	xor    %edi,%edi
8010210a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010210d:	eb 09                	jmp    80102118 <dirlink+0x38>
8010210f:	90                   	nop
80102110:	83 c7 10             	add    $0x10,%edi
80102113:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102116:	73 19                	jae    80102131 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102118:	6a 10                	push   $0x10
8010211a:	57                   	push   %edi
8010211b:	56                   	push   %esi
8010211c:	53                   	push   %ebx
8010211d:	e8 ae fa ff ff       	call   80101bd0 <readi>
80102122:	83 c4 10             	add    $0x10,%esp
80102125:	83 f8 10             	cmp    $0x10,%eax
80102128:	75 4e                	jne    80102178 <dirlink+0x98>
    if(de.inum == 0)
8010212a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010212f:	75 df                	jne    80102110 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102131:	83 ec 04             	sub    $0x4,%esp
80102134:	8d 45 da             	lea    -0x26(%ebp),%eax
80102137:	6a 0e                	push   $0xe
80102139:	ff 75 0c             	push   0xc(%ebp)
8010213c:	50                   	push   %eax
8010213d:	e8 ce 27 00 00       	call   80104910 <strncpy>
  de.inum = inum;
80102142:	8b 45 10             	mov    0x10(%ebp),%eax
80102145:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102149:	6a 10                	push   $0x10
8010214b:	57                   	push   %edi
8010214c:	56                   	push   %esi
8010214d:	53                   	push   %ebx
8010214e:	e8 7d fb ff ff       	call   80101cd0 <writei>
80102153:	83 c4 20             	add    $0x20,%esp
80102156:	83 f8 10             	cmp    $0x10,%eax
80102159:	75 2a                	jne    80102185 <dirlink+0xa5>
  return 0;
8010215b:	31 c0                	xor    %eax,%eax
}
8010215d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102160:	5b                   	pop    %ebx
80102161:	5e                   	pop    %esi
80102162:	5f                   	pop    %edi
80102163:	5d                   	pop    %ebp
80102164:	c3                   	ret
    iput(ip);
80102165:	83 ec 0c             	sub    $0xc,%esp
80102168:	50                   	push   %eax
80102169:	e8 82 f8 ff ff       	call   801019f0 <iput>
    return -1;
8010216e:	83 c4 10             	add    $0x10,%esp
80102171:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102176:	eb e5                	jmp    8010215d <dirlink+0x7d>
      panic("dirlink read");
80102178:	83 ec 0c             	sub    $0xc,%esp
8010217b:	68 d7 73 10 80       	push   $0x801073d7
80102180:	e8 fb e1 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102185:	83 ec 0c             	sub    $0xc,%esp
80102188:	68 33 76 10 80       	push   $0x80107633
8010218d:	e8 ee e1 ff ff       	call   80100380 <panic>
80102192:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102199:	00 
8010219a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801021a0 <namei>:

struct inode*
namei(char *path)
{
801021a0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801021a1:	31 d2                	xor    %edx,%edx
{
801021a3:	89 e5                	mov    %esp,%ebp
801021a5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801021a8:	8b 45 08             	mov    0x8(%ebp),%eax
801021ab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801021ae:	e8 0d fd ff ff       	call   80101ec0 <namex>
}
801021b3:	c9                   	leave
801021b4:	c3                   	ret
801021b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021bc:	00 
801021bd:	8d 76 00             	lea    0x0(%esi),%esi

801021c0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801021c0:	55                   	push   %ebp
  return namex(path, 1, name);
801021c1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801021c6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801021c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801021cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801021ce:	5d                   	pop    %ebp
  return namex(path, 1, name);
801021cf:	e9 ec fc ff ff       	jmp    80101ec0 <namex>
801021d4:	66 90                	xchg   %ax,%ax
801021d6:	66 90                	xchg   %ax,%ax
801021d8:	66 90                	xchg   %ax,%ax
801021da:	66 90                	xchg   %ax,%ax
801021dc:	66 90                	xchg   %ax,%ax
801021de:	66 90                	xchg   %ax,%ax

801021e0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801021e0:	55                   	push   %ebp
801021e1:	89 e5                	mov    %esp,%ebp
801021e3:	57                   	push   %edi
801021e4:	56                   	push   %esi
801021e5:	53                   	push   %ebx
801021e6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801021e9:	85 c0                	test   %eax,%eax
801021eb:	0f 84 b4 00 00 00    	je     801022a5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801021f1:	8b 70 08             	mov    0x8(%eax),%esi
801021f4:	89 c3                	mov    %eax,%ebx
801021f6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801021fc:	0f 87 96 00 00 00    	ja     80102298 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102202:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102207:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010220e:	00 
8010220f:	90                   	nop
80102210:	89 ca                	mov    %ecx,%edx
80102212:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102213:	83 e0 c0             	and    $0xffffffc0,%eax
80102216:	3c 40                	cmp    $0x40,%al
80102218:	75 f6                	jne    80102210 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010221a:	31 ff                	xor    %edi,%edi
8010221c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102221:	89 f8                	mov    %edi,%eax
80102223:	ee                   	out    %al,(%dx)
80102224:	b8 01 00 00 00       	mov    $0x1,%eax
80102229:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010222e:	ee                   	out    %al,(%dx)
8010222f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102234:	89 f0                	mov    %esi,%eax
80102236:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102237:	89 f0                	mov    %esi,%eax
80102239:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010223e:	c1 f8 08             	sar    $0x8,%eax
80102241:	ee                   	out    %al,(%dx)
80102242:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102247:	89 f8                	mov    %edi,%eax
80102249:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010224a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010224e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102253:	c1 e0 04             	shl    $0x4,%eax
80102256:	83 e0 10             	and    $0x10,%eax
80102259:	83 c8 e0             	or     $0xffffffe0,%eax
8010225c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010225d:	f6 03 04             	testb  $0x4,(%ebx)
80102260:	75 16                	jne    80102278 <idestart+0x98>
80102262:	b8 20 00 00 00       	mov    $0x20,%eax
80102267:	89 ca                	mov    %ecx,%edx
80102269:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010226a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010226d:	5b                   	pop    %ebx
8010226e:	5e                   	pop    %esi
8010226f:	5f                   	pop    %edi
80102270:	5d                   	pop    %ebp
80102271:	c3                   	ret
80102272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102278:	b8 30 00 00 00       	mov    $0x30,%eax
8010227d:	89 ca                	mov    %ecx,%edx
8010227f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102280:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102285:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102288:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010228d:	fc                   	cld
8010228e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102290:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102293:	5b                   	pop    %ebx
80102294:	5e                   	pop    %esi
80102295:	5f                   	pop    %edi
80102296:	5d                   	pop    %ebp
80102297:	c3                   	ret
    panic("incorrect blockno");
80102298:	83 ec 0c             	sub    $0xc,%esp
8010229b:	68 ed 73 10 80       	push   $0x801073ed
801022a0:	e8 db e0 ff ff       	call   80100380 <panic>
    panic("idestart");
801022a5:	83 ec 0c             	sub    $0xc,%esp
801022a8:	68 e4 73 10 80       	push   $0x801073e4
801022ad:	e8 ce e0 ff ff       	call   80100380 <panic>
801022b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022b9:	00 
801022ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801022c0 <ideinit>:
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801022c6:	68 ff 73 10 80       	push   $0x801073ff
801022cb:	68 00 16 11 80       	push   $0x80111600
801022d0:	e8 fb 21 00 00       	call   801044d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801022d5:	58                   	pop    %eax
801022d6:	a1 84 17 11 80       	mov    0x80111784,%eax
801022db:	5a                   	pop    %edx
801022dc:	83 e8 01             	sub    $0x1,%eax
801022df:	50                   	push   %eax
801022e0:	6a 0e                	push   $0xe
801022e2:	e8 99 02 00 00       	call   80102580 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022e7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022ea:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801022ef:	90                   	nop
801022f0:	89 ca                	mov    %ecx,%edx
801022f2:	ec                   	in     (%dx),%al
801022f3:	83 e0 c0             	and    $0xffffffc0,%eax
801022f6:	3c 40                	cmp    $0x40,%al
801022f8:	75 f6                	jne    801022f0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022fa:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801022ff:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102304:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102305:	89 ca                	mov    %ecx,%edx
80102307:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102308:	84 c0                	test   %al,%al
8010230a:	75 1e                	jne    8010232a <ideinit+0x6a>
8010230c:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102311:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102316:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010231d:	00 
8010231e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102320:	83 e9 01             	sub    $0x1,%ecx
80102323:	74 0f                	je     80102334 <ideinit+0x74>
80102325:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102326:	84 c0                	test   %al,%al
80102328:	74 f6                	je     80102320 <ideinit+0x60>
      havedisk1 = 1;
8010232a:	c7 05 e0 15 11 80 01 	movl   $0x1,0x801115e0
80102331:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102334:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102339:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010233e:	ee                   	out    %al,(%dx)
}
8010233f:	c9                   	leave
80102340:	c3                   	ret
80102341:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102348:	00 
80102349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102350 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102350:	55                   	push   %ebp
80102351:	89 e5                	mov    %esp,%ebp
80102353:	57                   	push   %edi
80102354:	56                   	push   %esi
80102355:	53                   	push   %ebx
80102356:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102359:	68 00 16 11 80       	push   $0x80111600
8010235e:	e8 5d 23 00 00       	call   801046c0 <acquire>

  if((b = idequeue) == 0){
80102363:	8b 1d e4 15 11 80    	mov    0x801115e4,%ebx
80102369:	83 c4 10             	add    $0x10,%esp
8010236c:	85 db                	test   %ebx,%ebx
8010236e:	74 63                	je     801023d3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102370:	8b 43 58             	mov    0x58(%ebx),%eax
80102373:	a3 e4 15 11 80       	mov    %eax,0x801115e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102378:	8b 33                	mov    (%ebx),%esi
8010237a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102380:	75 2f                	jne    801023b1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102382:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102387:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010238e:	00 
8010238f:	90                   	nop
80102390:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102391:	89 c1                	mov    %eax,%ecx
80102393:	83 e1 c0             	and    $0xffffffc0,%ecx
80102396:	80 f9 40             	cmp    $0x40,%cl
80102399:	75 f5                	jne    80102390 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010239b:	a8 21                	test   $0x21,%al
8010239d:	75 12                	jne    801023b1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010239f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801023a2:	b9 80 00 00 00       	mov    $0x80,%ecx
801023a7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801023ac:	fc                   	cld
801023ad:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801023af:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801023b1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801023b4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801023b7:	83 ce 02             	or     $0x2,%esi
801023ba:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801023bc:	53                   	push   %ebx
801023bd:	e8 3e 1e 00 00       	call   80104200 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801023c2:	a1 e4 15 11 80       	mov    0x801115e4,%eax
801023c7:	83 c4 10             	add    $0x10,%esp
801023ca:	85 c0                	test   %eax,%eax
801023cc:	74 05                	je     801023d3 <ideintr+0x83>
    idestart(idequeue);
801023ce:	e8 0d fe ff ff       	call   801021e0 <idestart>
    release(&idelock);
801023d3:	83 ec 0c             	sub    $0xc,%esp
801023d6:	68 00 16 11 80       	push   $0x80111600
801023db:	e8 80 22 00 00       	call   80104660 <release>

  release(&idelock);
}
801023e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023e3:	5b                   	pop    %ebx
801023e4:	5e                   	pop    %esi
801023e5:	5f                   	pop    %edi
801023e6:	5d                   	pop    %ebp
801023e7:	c3                   	ret
801023e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801023ef:	00 

801023f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	53                   	push   %ebx
801023f4:	83 ec 10             	sub    $0x10,%esp
801023f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801023fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801023fd:	50                   	push   %eax
801023fe:	e8 7d 20 00 00       	call   80104480 <holdingsleep>
80102403:	83 c4 10             	add    $0x10,%esp
80102406:	85 c0                	test   %eax,%eax
80102408:	0f 84 c3 00 00 00    	je     801024d1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010240e:	8b 03                	mov    (%ebx),%eax
80102410:	83 e0 06             	and    $0x6,%eax
80102413:	83 f8 02             	cmp    $0x2,%eax
80102416:	0f 84 a8 00 00 00    	je     801024c4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010241c:	8b 53 04             	mov    0x4(%ebx),%edx
8010241f:	85 d2                	test   %edx,%edx
80102421:	74 0d                	je     80102430 <iderw+0x40>
80102423:	a1 e0 15 11 80       	mov    0x801115e0,%eax
80102428:	85 c0                	test   %eax,%eax
8010242a:	0f 84 87 00 00 00    	je     801024b7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102430:	83 ec 0c             	sub    $0xc,%esp
80102433:	68 00 16 11 80       	push   $0x80111600
80102438:	e8 83 22 00 00       	call   801046c0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010243d:	a1 e4 15 11 80       	mov    0x801115e4,%eax
  b->qnext = 0;
80102442:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102449:	83 c4 10             	add    $0x10,%esp
8010244c:	85 c0                	test   %eax,%eax
8010244e:	74 60                	je     801024b0 <iderw+0xc0>
80102450:	89 c2                	mov    %eax,%edx
80102452:	8b 40 58             	mov    0x58(%eax),%eax
80102455:	85 c0                	test   %eax,%eax
80102457:	75 f7                	jne    80102450 <iderw+0x60>
80102459:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010245c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010245e:	39 1d e4 15 11 80    	cmp    %ebx,0x801115e4
80102464:	74 3a                	je     801024a0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102466:	8b 03                	mov    (%ebx),%eax
80102468:	83 e0 06             	and    $0x6,%eax
8010246b:	83 f8 02             	cmp    $0x2,%eax
8010246e:	74 1b                	je     8010248b <iderw+0x9b>
    sleep(b, &idelock);
80102470:	83 ec 08             	sub    $0x8,%esp
80102473:	68 00 16 11 80       	push   $0x80111600
80102478:	53                   	push   %ebx
80102479:	e8 c2 1c 00 00       	call   80104140 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010247e:	8b 03                	mov    (%ebx),%eax
80102480:	83 c4 10             	add    $0x10,%esp
80102483:	83 e0 06             	and    $0x6,%eax
80102486:	83 f8 02             	cmp    $0x2,%eax
80102489:	75 e5                	jne    80102470 <iderw+0x80>
  }


  release(&idelock);
8010248b:	c7 45 08 00 16 11 80 	movl   $0x80111600,0x8(%ebp)
}
80102492:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102495:	c9                   	leave
  release(&idelock);
80102496:	e9 c5 21 00 00       	jmp    80104660 <release>
8010249b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
801024a0:	89 d8                	mov    %ebx,%eax
801024a2:	e8 39 fd ff ff       	call   801021e0 <idestart>
801024a7:	eb bd                	jmp    80102466 <iderw+0x76>
801024a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024b0:	ba e4 15 11 80       	mov    $0x801115e4,%edx
801024b5:	eb a5                	jmp    8010245c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801024b7:	83 ec 0c             	sub    $0xc,%esp
801024ba:	68 2e 74 10 80       	push   $0x8010742e
801024bf:	e8 bc de ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801024c4:	83 ec 0c             	sub    $0xc,%esp
801024c7:	68 19 74 10 80       	push   $0x80107419
801024cc:	e8 af de ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801024d1:	83 ec 0c             	sub    $0xc,%esp
801024d4:	68 03 74 10 80       	push   $0x80107403
801024d9:	e8 a2 de ff ff       	call   80100380 <panic>
801024de:	66 90                	xchg   %ax,%ax

801024e0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801024e0:	55                   	push   %ebp
801024e1:	89 e5                	mov    %esp,%ebp
801024e3:	56                   	push   %esi
801024e4:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801024e5:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
801024ec:	00 c0 fe 
  ioapic->reg = reg;
801024ef:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801024f6:	00 00 00 
  return ioapic->data;
801024f9:	8b 15 34 16 11 80    	mov    0x80111634,%edx
801024ff:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102502:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102508:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010250e:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102515:	c1 ee 10             	shr    $0x10,%esi
80102518:	89 f0                	mov    %esi,%eax
8010251a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010251d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102520:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102523:	39 c2                	cmp    %eax,%edx
80102525:	74 16                	je     8010253d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102527:	83 ec 0c             	sub    $0xc,%esp
8010252a:	68 40 78 10 80       	push   $0x80107840
8010252f:	e8 7c e1 ff ff       	call   801006b0 <cprintf>
  ioapic->reg = reg;
80102534:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
8010253a:	83 c4 10             	add    $0x10,%esp
{
8010253d:	ba 10 00 00 00       	mov    $0x10,%edx
80102542:	31 c0                	xor    %eax,%eax
80102544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102548:	89 13                	mov    %edx,(%ebx)
8010254a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010254d:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102553:	83 c0 01             	add    $0x1,%eax
80102556:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010255c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010255f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80102562:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102565:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102567:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
8010256d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80102574:	39 c6                	cmp    %eax,%esi
80102576:	7d d0                	jge    80102548 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102578:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010257b:	5b                   	pop    %ebx
8010257c:	5e                   	pop    %esi
8010257d:	5d                   	pop    %ebp
8010257e:	c3                   	ret
8010257f:	90                   	nop

80102580 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102580:	55                   	push   %ebp
  ioapic->reg = reg;
80102581:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
{
80102587:	89 e5                	mov    %esp,%ebp
80102589:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010258c:	8d 50 20             	lea    0x20(%eax),%edx
8010258f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102593:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102595:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010259b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010259e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801025a4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801025a6:	a1 34 16 11 80       	mov    0x80111634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025ab:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801025ae:	89 50 10             	mov    %edx,0x10(%eax)
}
801025b1:	5d                   	pop    %ebp
801025b2:	c3                   	ret
801025b3:	66 90                	xchg   %ax,%ax
801025b5:	66 90                	xchg   %ax,%ax
801025b7:	66 90                	xchg   %ax,%ax
801025b9:	66 90                	xchg   %ax,%ax
801025bb:	66 90                	xchg   %ax,%ax
801025bd:	66 90                	xchg   %ax,%ax
801025bf:	90                   	nop

801025c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	53                   	push   %ebx
801025c4:	83 ec 04             	sub    $0x4,%esp
801025c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801025ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801025d0:	75 76                	jne    80102648 <kfree+0x88>
801025d2:	81 fb d0 54 11 80    	cmp    $0x801154d0,%ebx
801025d8:	72 6e                	jb     80102648 <kfree+0x88>
801025da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801025e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801025e5:	77 61                	ja     80102648 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801025e7:	83 ec 04             	sub    $0x4,%esp
801025ea:	68 00 10 00 00       	push   $0x1000
801025ef:	6a 01                	push   $0x1
801025f1:	53                   	push   %ebx
801025f2:	e8 c9 21 00 00       	call   801047c0 <memset>

  if(kmem.use_lock)
801025f7:	8b 15 74 16 11 80    	mov    0x80111674,%edx
801025fd:	83 c4 10             	add    $0x10,%esp
80102600:	85 d2                	test   %edx,%edx
80102602:	75 1c                	jne    80102620 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102604:	a1 78 16 11 80       	mov    0x80111678,%eax
80102609:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010260b:	a1 74 16 11 80       	mov    0x80111674,%eax
  kmem.freelist = r;
80102610:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
80102616:	85 c0                	test   %eax,%eax
80102618:	75 1e                	jne    80102638 <kfree+0x78>
    release(&kmem.lock);
}
8010261a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010261d:	c9                   	leave
8010261e:	c3                   	ret
8010261f:	90                   	nop
    acquire(&kmem.lock);
80102620:	83 ec 0c             	sub    $0xc,%esp
80102623:	68 40 16 11 80       	push   $0x80111640
80102628:	e8 93 20 00 00       	call   801046c0 <acquire>
8010262d:	83 c4 10             	add    $0x10,%esp
80102630:	eb d2                	jmp    80102604 <kfree+0x44>
80102632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102638:	c7 45 08 40 16 11 80 	movl   $0x80111640,0x8(%ebp)
}
8010263f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102642:	c9                   	leave
    release(&kmem.lock);
80102643:	e9 18 20 00 00       	jmp    80104660 <release>
    panic("kfree");
80102648:	83 ec 0c             	sub    $0xc,%esp
8010264b:	68 4c 74 10 80       	push   $0x8010744c
80102650:	e8 2b dd ff ff       	call   80100380 <panic>
80102655:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010265c:	00 
8010265d:	8d 76 00             	lea    0x0(%esi),%esi

80102660 <freerange>:
{
80102660:	55                   	push   %ebp
80102661:	89 e5                	mov    %esp,%ebp
80102663:	56                   	push   %esi
80102664:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102665:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102668:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010266b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102671:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102677:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010267d:	39 de                	cmp    %ebx,%esi
8010267f:	72 23                	jb     801026a4 <freerange+0x44>
80102681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102688:	83 ec 0c             	sub    $0xc,%esp
8010268b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102691:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102697:	50                   	push   %eax
80102698:	e8 23 ff ff ff       	call   801025c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010269d:	83 c4 10             	add    $0x10,%esp
801026a0:	39 de                	cmp    %ebx,%esi
801026a2:	73 e4                	jae    80102688 <freerange+0x28>
}
801026a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026a7:	5b                   	pop    %ebx
801026a8:	5e                   	pop    %esi
801026a9:	5d                   	pop    %ebp
801026aa:	c3                   	ret
801026ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801026b0 <kinit2>:
{
801026b0:	55                   	push   %ebp
801026b1:	89 e5                	mov    %esp,%ebp
801026b3:	56                   	push   %esi
801026b4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801026b5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801026bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026cd:	39 de                	cmp    %ebx,%esi
801026cf:	72 23                	jb     801026f4 <kinit2+0x44>
801026d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801026d8:	83 ec 0c             	sub    $0xc,%esp
801026db:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026e7:	50                   	push   %eax
801026e8:	e8 d3 fe ff ff       	call   801025c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026ed:	83 c4 10             	add    $0x10,%esp
801026f0:	39 de                	cmp    %ebx,%esi
801026f2:	73 e4                	jae    801026d8 <kinit2+0x28>
  kmem.use_lock = 1;
801026f4:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
801026fb:	00 00 00 
}
801026fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102701:	5b                   	pop    %ebx
80102702:	5e                   	pop    %esi
80102703:	5d                   	pop    %ebp
80102704:	c3                   	ret
80102705:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010270c:	00 
8010270d:	8d 76 00             	lea    0x0(%esi),%esi

80102710 <kinit1>:
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	56                   	push   %esi
80102714:	53                   	push   %ebx
80102715:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102718:	83 ec 08             	sub    $0x8,%esp
8010271b:	68 52 74 10 80       	push   $0x80107452
80102720:	68 40 16 11 80       	push   $0x80111640
80102725:	e8 a6 1d 00 00       	call   801044d0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010272a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010272d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102730:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
80102737:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010273a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102740:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102746:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010274c:	39 de                	cmp    %ebx,%esi
8010274e:	72 1c                	jb     8010276c <kinit1+0x5c>
    kfree(p);
80102750:	83 ec 0c             	sub    $0xc,%esp
80102753:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102759:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010275f:	50                   	push   %eax
80102760:	e8 5b fe ff ff       	call   801025c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102765:	83 c4 10             	add    $0x10,%esp
80102768:	39 de                	cmp    %ebx,%esi
8010276a:	73 e4                	jae    80102750 <kinit1+0x40>
}
8010276c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010276f:	5b                   	pop    %ebx
80102770:	5e                   	pop    %esi
80102771:	5d                   	pop    %ebp
80102772:	c3                   	ret
80102773:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010277a:	00 
8010277b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102780 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	53                   	push   %ebx
80102784:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102787:	a1 74 16 11 80       	mov    0x80111674,%eax
8010278c:	85 c0                	test   %eax,%eax
8010278e:	75 20                	jne    801027b0 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102790:	8b 1d 78 16 11 80    	mov    0x80111678,%ebx
  if(r)
80102796:	85 db                	test   %ebx,%ebx
80102798:	74 07                	je     801027a1 <kalloc+0x21>
    kmem.freelist = r->next;
8010279a:	8b 03                	mov    (%ebx),%eax
8010279c:	a3 78 16 11 80       	mov    %eax,0x80111678
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801027a1:	89 d8                	mov    %ebx,%eax
801027a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027a6:	c9                   	leave
801027a7:	c3                   	ret
801027a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801027af:	00 
    acquire(&kmem.lock);
801027b0:	83 ec 0c             	sub    $0xc,%esp
801027b3:	68 40 16 11 80       	push   $0x80111640
801027b8:	e8 03 1f 00 00       	call   801046c0 <acquire>
  r = kmem.freelist;
801027bd:	8b 1d 78 16 11 80    	mov    0x80111678,%ebx
  if(kmem.use_lock)
801027c3:	a1 74 16 11 80       	mov    0x80111674,%eax
  if(r)
801027c8:	83 c4 10             	add    $0x10,%esp
801027cb:	85 db                	test   %ebx,%ebx
801027cd:	74 08                	je     801027d7 <kalloc+0x57>
    kmem.freelist = r->next;
801027cf:	8b 13                	mov    (%ebx),%edx
801027d1:	89 15 78 16 11 80    	mov    %edx,0x80111678
  if(kmem.use_lock)
801027d7:	85 c0                	test   %eax,%eax
801027d9:	74 c6                	je     801027a1 <kalloc+0x21>
    release(&kmem.lock);
801027db:	83 ec 0c             	sub    $0xc,%esp
801027de:	68 40 16 11 80       	push   $0x80111640
801027e3:	e8 78 1e 00 00       	call   80104660 <release>
}
801027e8:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
801027ea:	83 c4 10             	add    $0x10,%esp
}
801027ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027f0:	c9                   	leave
801027f1:	c3                   	ret
801027f2:	66 90                	xchg   %ax,%ax
801027f4:	66 90                	xchg   %ax,%ax
801027f6:	66 90                	xchg   %ax,%ax
801027f8:	66 90                	xchg   %ax,%ax
801027fa:	66 90                	xchg   %ax,%ax
801027fc:	66 90                	xchg   %ax,%ax
801027fe:	66 90                	xchg   %ax,%ax

80102800 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102800:	ba 64 00 00 00       	mov    $0x64,%edx
80102805:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102806:	a8 01                	test   $0x1,%al
80102808:	0f 84 c2 00 00 00    	je     801028d0 <kbdgetc+0xd0>
{
8010280e:	55                   	push   %ebp
8010280f:	ba 60 00 00 00       	mov    $0x60,%edx
80102814:	89 e5                	mov    %esp,%ebp
80102816:	53                   	push   %ebx
80102817:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102818:	8b 1d 7c 16 11 80    	mov    0x8011167c,%ebx
  data = inb(KBDATAP);
8010281e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102821:	3c e0                	cmp    $0xe0,%al
80102823:	74 5b                	je     80102880 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102825:	89 da                	mov    %ebx,%edx
80102827:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010282a:	84 c0                	test   %al,%al
8010282c:	78 62                	js     80102890 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010282e:	85 d2                	test   %edx,%edx
80102830:	74 09                	je     8010283b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102832:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102835:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102838:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010283b:	0f b6 91 a0 7a 10 80 	movzbl -0x7fef8560(%ecx),%edx
  shift ^= togglecode[data];
80102842:	0f b6 81 a0 79 10 80 	movzbl -0x7fef8660(%ecx),%eax
  shift |= shiftcode[data];
80102849:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010284b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010284d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010284f:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  c = charcode[shift & (CTL | SHIFT)][data];
80102855:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102858:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010285b:	8b 04 85 80 79 10 80 	mov    -0x7fef8680(,%eax,4),%eax
80102862:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102866:	74 0b                	je     80102873 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102868:	8d 50 9f             	lea    -0x61(%eax),%edx
8010286b:	83 fa 19             	cmp    $0x19,%edx
8010286e:	77 48                	ja     801028b8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102870:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102873:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102876:	c9                   	leave
80102877:	c3                   	ret
80102878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010287f:	00 
    shift |= E0ESC;
80102880:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102883:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102885:	89 1d 7c 16 11 80    	mov    %ebx,0x8011167c
}
8010288b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010288e:	c9                   	leave
8010288f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102890:	83 e0 7f             	and    $0x7f,%eax
80102893:	85 d2                	test   %edx,%edx
80102895:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102898:	0f b6 81 a0 7a 10 80 	movzbl -0x7fef8560(%ecx),%eax
8010289f:	83 c8 40             	or     $0x40,%eax
801028a2:	0f b6 c0             	movzbl %al,%eax
801028a5:	f7 d0                	not    %eax
801028a7:	21 d8                	and    %ebx,%eax
801028a9:	a3 7c 16 11 80       	mov    %eax,0x8011167c
    return 0;
801028ae:	31 c0                	xor    %eax,%eax
801028b0:	eb d9                	jmp    8010288b <kbdgetc+0x8b>
801028b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801028b8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801028bb:	8d 50 20             	lea    0x20(%eax),%edx
}
801028be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028c1:	c9                   	leave
      c += 'a' - 'A';
801028c2:	83 f9 1a             	cmp    $0x1a,%ecx
801028c5:	0f 42 c2             	cmovb  %edx,%eax
}
801028c8:	c3                   	ret
801028c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801028d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801028d5:	c3                   	ret
801028d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028dd:	00 
801028de:	66 90                	xchg   %ax,%ax

801028e0 <kbdintr>:

void
kbdintr(void)
{
801028e0:	55                   	push   %ebp
801028e1:	89 e5                	mov    %esp,%ebp
801028e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801028e6:	68 00 28 10 80       	push   $0x80102800
801028eb:	e8 b0 df ff ff       	call   801008a0 <consoleintr>
}
801028f0:	83 c4 10             	add    $0x10,%esp
801028f3:	c9                   	leave
801028f4:	c3                   	ret
801028f5:	66 90                	xchg   %ax,%ax
801028f7:	66 90                	xchg   %ax,%ax
801028f9:	66 90                	xchg   %ax,%ax
801028fb:	66 90                	xchg   %ax,%ax
801028fd:	66 90                	xchg   %ax,%ax
801028ff:	90                   	nop

80102900 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102900:	a1 80 16 11 80       	mov    0x80111680,%eax
80102905:	85 c0                	test   %eax,%eax
80102907:	0f 84 c3 00 00 00    	je     801029d0 <lapicinit+0xd0>
  lapic[index] = value;
8010290d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102914:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102917:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010291a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102921:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102924:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102927:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010292e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102931:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102934:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010293b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010293e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102941:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102948:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010294b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010294e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102955:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102958:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010295b:	8b 50 30             	mov    0x30(%eax),%edx
8010295e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102964:	75 72                	jne    801029d8 <lapicinit+0xd8>
  lapic[index] = value;
80102966:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010296d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102970:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102973:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010297a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010297d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102980:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102987:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010298a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010298d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102994:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102997:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010299a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801029a1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029a4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029a7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801029ae:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801029b1:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801029b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029b8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801029be:	80 e6 10             	and    $0x10,%dh
801029c1:	75 f5                	jne    801029b8 <lapicinit+0xb8>
  lapic[index] = value;
801029c3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801029ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029cd:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801029d0:	c3                   	ret
801029d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801029d8:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801029df:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029e2:	8b 50 20             	mov    0x20(%eax),%edx
}
801029e5:	e9 7c ff ff ff       	jmp    80102966 <lapicinit+0x66>
801029ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801029f0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801029f0:	a1 80 16 11 80       	mov    0x80111680,%eax
801029f5:	85 c0                	test   %eax,%eax
801029f7:	74 07                	je     80102a00 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801029f9:	8b 40 20             	mov    0x20(%eax),%eax
801029fc:	c1 e8 18             	shr    $0x18,%eax
801029ff:	c3                   	ret
    return 0;
80102a00:	31 c0                	xor    %eax,%eax
}
80102a02:	c3                   	ret
80102a03:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a0a:	00 
80102a0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102a10 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102a10:	a1 80 16 11 80       	mov    0x80111680,%eax
80102a15:	85 c0                	test   %eax,%eax
80102a17:	74 0d                	je     80102a26 <lapiceoi+0x16>
  lapic[index] = value;
80102a19:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a20:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a23:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102a26:	c3                   	ret
80102a27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a2e:	00 
80102a2f:	90                   	nop

80102a30 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102a30:	c3                   	ret
80102a31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a38:	00 
80102a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102a40 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102a40:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a41:	b8 0f 00 00 00       	mov    $0xf,%eax
80102a46:	ba 70 00 00 00       	mov    $0x70,%edx
80102a4b:	89 e5                	mov    %esp,%ebp
80102a4d:	53                   	push   %ebx
80102a4e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102a51:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102a54:	ee                   	out    %al,(%dx)
80102a55:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a5a:	ba 71 00 00 00       	mov    $0x71,%edx
80102a5f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102a60:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102a62:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102a65:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102a6b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a6d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102a70:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102a72:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a75:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102a78:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102a7e:	a1 80 16 11 80       	mov    0x80111680,%eax
80102a83:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a89:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a8c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102a93:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a96:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a99:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102aa0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102aa3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102aa6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102aac:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102aaf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ab5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ab8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102abe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ac1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ac7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102aca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102acd:	c9                   	leave
80102ace:	c3                   	ret
80102acf:	90                   	nop

80102ad0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102ad0:	55                   	push   %ebp
80102ad1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102ad6:	ba 70 00 00 00       	mov    $0x70,%edx
80102adb:	89 e5                	mov    %esp,%ebp
80102add:	57                   	push   %edi
80102ade:	56                   	push   %esi
80102adf:	53                   	push   %ebx
80102ae0:	83 ec 4c             	sub    $0x4c,%esp
80102ae3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae4:	ba 71 00 00 00       	mov    $0x71,%edx
80102ae9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102aea:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aed:	bf 70 00 00 00       	mov    $0x70,%edi
80102af2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102af5:	8d 76 00             	lea    0x0(%esi),%esi
80102af8:	31 c0                	xor    %eax,%eax
80102afa:	89 fa                	mov    %edi,%edx
80102afc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102afd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102b02:	89 ca                	mov    %ecx,%edx
80102b04:	ec                   	in     (%dx),%al
80102b05:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b08:	89 fa                	mov    %edi,%edx
80102b0a:	b8 02 00 00 00       	mov    $0x2,%eax
80102b0f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b10:	89 ca                	mov    %ecx,%edx
80102b12:	ec                   	in     (%dx),%al
80102b13:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b16:	89 fa                	mov    %edi,%edx
80102b18:	b8 04 00 00 00       	mov    $0x4,%eax
80102b1d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b1e:	89 ca                	mov    %ecx,%edx
80102b20:	ec                   	in     (%dx),%al
80102b21:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b24:	89 fa                	mov    %edi,%edx
80102b26:	b8 07 00 00 00       	mov    $0x7,%eax
80102b2b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b2c:	89 ca                	mov    %ecx,%edx
80102b2e:	ec                   	in     (%dx),%al
80102b2f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b32:	89 fa                	mov    %edi,%edx
80102b34:	b8 08 00 00 00       	mov    $0x8,%eax
80102b39:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b3a:	89 ca                	mov    %ecx,%edx
80102b3c:	ec                   	in     (%dx),%al
80102b3d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b3f:	89 fa                	mov    %edi,%edx
80102b41:	b8 09 00 00 00       	mov    $0x9,%eax
80102b46:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b47:	89 ca                	mov    %ecx,%edx
80102b49:	ec                   	in     (%dx),%al
80102b4a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b4d:	89 fa                	mov    %edi,%edx
80102b4f:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b54:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b55:	89 ca                	mov    %ecx,%edx
80102b57:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102b58:	84 c0                	test   %al,%al
80102b5a:	78 9c                	js     80102af8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102b5c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102b60:	89 f2                	mov    %esi,%edx
80102b62:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102b65:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b68:	89 fa                	mov    %edi,%edx
80102b6a:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102b6d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102b71:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102b74:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102b77:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102b7b:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102b7e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102b82:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102b85:	31 c0                	xor    %eax,%eax
80102b87:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b88:	89 ca                	mov    %ecx,%edx
80102b8a:	ec                   	in     (%dx),%al
80102b8b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b8e:	89 fa                	mov    %edi,%edx
80102b90:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102b93:	b8 02 00 00 00       	mov    $0x2,%eax
80102b98:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b99:	89 ca                	mov    %ecx,%edx
80102b9b:	ec                   	in     (%dx),%al
80102b9c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b9f:	89 fa                	mov    %edi,%edx
80102ba1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102ba4:	b8 04 00 00 00       	mov    $0x4,%eax
80102ba9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102baa:	89 ca                	mov    %ecx,%edx
80102bac:	ec                   	in     (%dx),%al
80102bad:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bb0:	89 fa                	mov    %edi,%edx
80102bb2:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102bb5:	b8 07 00 00 00       	mov    $0x7,%eax
80102bba:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bbb:	89 ca                	mov    %ecx,%edx
80102bbd:	ec                   	in     (%dx),%al
80102bbe:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bc1:	89 fa                	mov    %edi,%edx
80102bc3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102bc6:	b8 08 00 00 00       	mov    $0x8,%eax
80102bcb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bcc:	89 ca                	mov    %ecx,%edx
80102bce:	ec                   	in     (%dx),%al
80102bcf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd2:	89 fa                	mov    %edi,%edx
80102bd4:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102bd7:	b8 09 00 00 00       	mov    $0x9,%eax
80102bdc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bdd:	89 ca                	mov    %ecx,%edx
80102bdf:	ec                   	in     (%dx),%al
80102be0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102be3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102be6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102be9:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102bec:	6a 18                	push   $0x18
80102bee:	50                   	push   %eax
80102bef:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102bf2:	50                   	push   %eax
80102bf3:	e8 08 1c 00 00       	call   80104800 <memcmp>
80102bf8:	83 c4 10             	add    $0x10,%esp
80102bfb:	85 c0                	test   %eax,%eax
80102bfd:	0f 85 f5 fe ff ff    	jne    80102af8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102c03:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102c07:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102c0a:	89 f0                	mov    %esi,%eax
80102c0c:	84 c0                	test   %al,%al
80102c0e:	75 78                	jne    80102c88 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102c10:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102c13:	89 c2                	mov    %eax,%edx
80102c15:	83 e0 0f             	and    $0xf,%eax
80102c18:	c1 ea 04             	shr    $0x4,%edx
80102c1b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c1e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c21:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102c24:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c27:	89 c2                	mov    %eax,%edx
80102c29:	83 e0 0f             	and    $0xf,%eax
80102c2c:	c1 ea 04             	shr    $0x4,%edx
80102c2f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c32:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c35:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102c38:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c3b:	89 c2                	mov    %eax,%edx
80102c3d:	83 e0 0f             	and    $0xf,%eax
80102c40:	c1 ea 04             	shr    $0x4,%edx
80102c43:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c46:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c49:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102c4c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c4f:	89 c2                	mov    %eax,%edx
80102c51:	83 e0 0f             	and    $0xf,%eax
80102c54:	c1 ea 04             	shr    $0x4,%edx
80102c57:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c5a:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c5d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102c60:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c63:	89 c2                	mov    %eax,%edx
80102c65:	83 e0 0f             	and    $0xf,%eax
80102c68:	c1 ea 04             	shr    $0x4,%edx
80102c6b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c6e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c71:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102c74:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c77:	89 c2                	mov    %eax,%edx
80102c79:	83 e0 0f             	and    $0xf,%eax
80102c7c:	c1 ea 04             	shr    $0x4,%edx
80102c7f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c82:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c85:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102c88:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102c8b:	89 03                	mov    %eax,(%ebx)
80102c8d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c90:	89 43 04             	mov    %eax,0x4(%ebx)
80102c93:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c96:	89 43 08             	mov    %eax,0x8(%ebx)
80102c99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c9c:	89 43 0c             	mov    %eax,0xc(%ebx)
80102c9f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ca2:	89 43 10             	mov    %eax,0x10(%ebx)
80102ca5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ca8:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102cab:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102cb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cb5:	5b                   	pop    %ebx
80102cb6:	5e                   	pop    %esi
80102cb7:	5f                   	pop    %edi
80102cb8:	5d                   	pop    %ebp
80102cb9:	c3                   	ret
80102cba:	66 90                	xchg   %ax,%ax
80102cbc:	66 90                	xchg   %ax,%ax
80102cbe:	66 90                	xchg   %ax,%ax

80102cc0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102cc0:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102cc6:	85 c9                	test   %ecx,%ecx
80102cc8:	0f 8e 8a 00 00 00    	jle    80102d58 <install_trans+0x98>
{
80102cce:	55                   	push   %ebp
80102ccf:	89 e5                	mov    %esp,%ebp
80102cd1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102cd2:	31 ff                	xor    %edi,%edi
{
80102cd4:	56                   	push   %esi
80102cd5:	53                   	push   %ebx
80102cd6:	83 ec 0c             	sub    $0xc,%esp
80102cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ce0:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102ce5:	83 ec 08             	sub    $0x8,%esp
80102ce8:	01 f8                	add    %edi,%eax
80102cea:	83 c0 01             	add    $0x1,%eax
80102ced:	50                   	push   %eax
80102cee:	ff 35 e4 16 11 80    	push   0x801116e4
80102cf4:	e8 d7 d3 ff ff       	call   801000d0 <bread>
80102cf9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cfb:	58                   	pop    %eax
80102cfc:	5a                   	pop    %edx
80102cfd:	ff 34 bd ec 16 11 80 	push   -0x7feee914(,%edi,4)
80102d04:	ff 35 e4 16 11 80    	push   0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d0a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d0d:	e8 be d3 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102d12:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d15:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102d17:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d1a:	68 00 02 00 00       	push   $0x200
80102d1f:	50                   	push   %eax
80102d20:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102d23:	50                   	push   %eax
80102d24:	e8 27 1b 00 00       	call   80104850 <memmove>
    bwrite(dbuf);  // write dst to disk
80102d29:	89 1c 24             	mov    %ebx,(%esp)
80102d2c:	e8 7f d4 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102d31:	89 34 24             	mov    %esi,(%esp)
80102d34:	e8 b7 d4 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102d39:	89 1c 24             	mov    %ebx,(%esp)
80102d3c:	e8 af d4 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d41:	83 c4 10             	add    $0x10,%esp
80102d44:	39 3d e8 16 11 80    	cmp    %edi,0x801116e8
80102d4a:	7f 94                	jg     80102ce0 <install_trans+0x20>
  }
}
80102d4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d4f:	5b                   	pop    %ebx
80102d50:	5e                   	pop    %esi
80102d51:	5f                   	pop    %edi
80102d52:	5d                   	pop    %ebp
80102d53:	c3                   	ret
80102d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d58:	c3                   	ret
80102d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	53                   	push   %ebx
80102d64:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d67:	ff 35 d4 16 11 80    	push   0x801116d4
80102d6d:	ff 35 e4 16 11 80    	push   0x801116e4
80102d73:	e8 58 d3 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102d78:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d7b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102d7d:	a1 e8 16 11 80       	mov    0x801116e8,%eax
80102d82:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102d85:	85 c0                	test   %eax,%eax
80102d87:	7e 19                	jle    80102da2 <write_head+0x42>
80102d89:	31 d2                	xor    %edx,%edx
80102d8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102d90:	8b 0c 95 ec 16 11 80 	mov    -0x7feee914(,%edx,4),%ecx
80102d97:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d9b:	83 c2 01             	add    $0x1,%edx
80102d9e:	39 d0                	cmp    %edx,%eax
80102da0:	75 ee                	jne    80102d90 <write_head+0x30>
  }
  bwrite(buf);
80102da2:	83 ec 0c             	sub    $0xc,%esp
80102da5:	53                   	push   %ebx
80102da6:	e8 05 d4 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102dab:	89 1c 24             	mov    %ebx,(%esp)
80102dae:	e8 3d d4 ff ff       	call   801001f0 <brelse>
}
80102db3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102db6:	83 c4 10             	add    $0x10,%esp
80102db9:	c9                   	leave
80102dba:	c3                   	ret
80102dbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102dc0 <initlog>:
{
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	53                   	push   %ebx
80102dc4:	83 ec 2c             	sub    $0x2c,%esp
80102dc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102dca:	68 57 74 10 80       	push   $0x80107457
80102dcf:	68 a0 16 11 80       	push   $0x801116a0
80102dd4:	e8 f7 16 00 00       	call   801044d0 <initlock>
  readsb(dev, &sb);
80102dd9:	58                   	pop    %eax
80102dda:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102ddd:	5a                   	pop    %edx
80102dde:	50                   	push   %eax
80102ddf:	53                   	push   %ebx
80102de0:	e8 7b e8 ff ff       	call   80101660 <readsb>
  log.start = sb.logstart;
80102de5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102de8:	59                   	pop    %ecx
  log.dev = dev;
80102de9:	89 1d e4 16 11 80    	mov    %ebx,0x801116e4
  log.size = sb.nlog;
80102def:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102df2:	a3 d4 16 11 80       	mov    %eax,0x801116d4
  log.size = sb.nlog;
80102df7:	89 15 d8 16 11 80    	mov    %edx,0x801116d8
  struct buf *buf = bread(log.dev, log.start);
80102dfd:	5a                   	pop    %edx
80102dfe:	50                   	push   %eax
80102dff:	53                   	push   %ebx
80102e00:	e8 cb d2 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102e05:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102e08:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102e0b:	89 1d e8 16 11 80    	mov    %ebx,0x801116e8
  for (i = 0; i < log.lh.n; i++) {
80102e11:	85 db                	test   %ebx,%ebx
80102e13:	7e 1d                	jle    80102e32 <initlog+0x72>
80102e15:	31 d2                	xor    %edx,%edx
80102e17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e1e:	00 
80102e1f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102e20:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102e24:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102e2b:	83 c2 01             	add    $0x1,%edx
80102e2e:	39 d3                	cmp    %edx,%ebx
80102e30:	75 ee                	jne    80102e20 <initlog+0x60>
  brelse(buf);
80102e32:	83 ec 0c             	sub    $0xc,%esp
80102e35:	50                   	push   %eax
80102e36:	e8 b5 d3 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102e3b:	e8 80 fe ff ff       	call   80102cc0 <install_trans>
  log.lh.n = 0;
80102e40:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102e47:	00 00 00 
  write_head(); // clear the log
80102e4a:	e8 11 ff ff ff       	call   80102d60 <write_head>
}
80102e4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e52:	83 c4 10             	add    $0x10,%esp
80102e55:	c9                   	leave
80102e56:	c3                   	ret
80102e57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e5e:	00 
80102e5f:	90                   	nop

80102e60 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102e66:	68 a0 16 11 80       	push   $0x801116a0
80102e6b:	e8 50 18 00 00       	call   801046c0 <acquire>
80102e70:	83 c4 10             	add    $0x10,%esp
80102e73:	eb 18                	jmp    80102e8d <begin_op+0x2d>
80102e75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102e78:	83 ec 08             	sub    $0x8,%esp
80102e7b:	68 a0 16 11 80       	push   $0x801116a0
80102e80:	68 a0 16 11 80       	push   $0x801116a0
80102e85:	e8 b6 12 00 00       	call   80104140 <sleep>
80102e8a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102e8d:	a1 e0 16 11 80       	mov    0x801116e0,%eax
80102e92:	85 c0                	test   %eax,%eax
80102e94:	75 e2                	jne    80102e78 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102e96:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80102e9b:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80102ea1:	83 c0 01             	add    $0x1,%eax
80102ea4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ea7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102eaa:	83 fa 1e             	cmp    $0x1e,%edx
80102ead:	7f c9                	jg     80102e78 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102eaf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102eb2:	a3 dc 16 11 80       	mov    %eax,0x801116dc
      release(&log.lock);
80102eb7:	68 a0 16 11 80       	push   $0x801116a0
80102ebc:	e8 9f 17 00 00       	call   80104660 <release>
      break;
    }
  }
}
80102ec1:	83 c4 10             	add    $0x10,%esp
80102ec4:	c9                   	leave
80102ec5:	c3                   	ret
80102ec6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ecd:	00 
80102ece:	66 90                	xchg   %ax,%ax

80102ed0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ed0:	55                   	push   %ebp
80102ed1:	89 e5                	mov    %esp,%ebp
80102ed3:	57                   	push   %edi
80102ed4:	56                   	push   %esi
80102ed5:	53                   	push   %ebx
80102ed6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ed9:	68 a0 16 11 80       	push   $0x801116a0
80102ede:	e8 dd 17 00 00       	call   801046c0 <acquire>
  log.outstanding -= 1;
80102ee3:	a1 dc 16 11 80       	mov    0x801116dc,%eax
  if(log.committing)
80102ee8:	8b 35 e0 16 11 80    	mov    0x801116e0,%esi
80102eee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102ef1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102ef4:	89 1d dc 16 11 80    	mov    %ebx,0x801116dc
  if(log.committing)
80102efa:	85 f6                	test   %esi,%esi
80102efc:	0f 85 22 01 00 00    	jne    80103024 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102f02:	85 db                	test   %ebx,%ebx
80102f04:	0f 85 f6 00 00 00    	jne    80103000 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102f0a:	c7 05 e0 16 11 80 01 	movl   $0x1,0x801116e0
80102f11:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102f14:	83 ec 0c             	sub    $0xc,%esp
80102f17:	68 a0 16 11 80       	push   $0x801116a0
80102f1c:	e8 3f 17 00 00       	call   80104660 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102f21:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102f27:	83 c4 10             	add    $0x10,%esp
80102f2a:	85 c9                	test   %ecx,%ecx
80102f2c:	7f 42                	jg     80102f70 <end_op+0xa0>
    acquire(&log.lock);
80102f2e:	83 ec 0c             	sub    $0xc,%esp
80102f31:	68 a0 16 11 80       	push   $0x801116a0
80102f36:	e8 85 17 00 00       	call   801046c0 <acquire>
    log.committing = 0;
80102f3b:	c7 05 e0 16 11 80 00 	movl   $0x0,0x801116e0
80102f42:	00 00 00 
    wakeup(&log);
80102f45:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102f4c:	e8 af 12 00 00       	call   80104200 <wakeup>
    release(&log.lock);
80102f51:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102f58:	e8 03 17 00 00       	call   80104660 <release>
80102f5d:	83 c4 10             	add    $0x10,%esp
}
80102f60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f63:	5b                   	pop    %ebx
80102f64:	5e                   	pop    %esi
80102f65:	5f                   	pop    %edi
80102f66:	5d                   	pop    %ebp
80102f67:	c3                   	ret
80102f68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f6f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102f70:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102f75:	83 ec 08             	sub    $0x8,%esp
80102f78:	01 d8                	add    %ebx,%eax
80102f7a:	83 c0 01             	add    $0x1,%eax
80102f7d:	50                   	push   %eax
80102f7e:	ff 35 e4 16 11 80    	push   0x801116e4
80102f84:	e8 47 d1 ff ff       	call   801000d0 <bread>
80102f89:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f8b:	58                   	pop    %eax
80102f8c:	5a                   	pop    %edx
80102f8d:	ff 34 9d ec 16 11 80 	push   -0x7feee914(,%ebx,4)
80102f94:	ff 35 e4 16 11 80    	push   0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102f9a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f9d:	e8 2e d1 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102fa2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102fa5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102fa7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102faa:	68 00 02 00 00       	push   $0x200
80102faf:	50                   	push   %eax
80102fb0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102fb3:	50                   	push   %eax
80102fb4:	e8 97 18 00 00       	call   80104850 <memmove>
    bwrite(to);  // write the log
80102fb9:	89 34 24             	mov    %esi,(%esp)
80102fbc:	e8 ef d1 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102fc1:	89 3c 24             	mov    %edi,(%esp)
80102fc4:	e8 27 d2 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102fc9:	89 34 24             	mov    %esi,(%esp)
80102fcc:	e8 1f d2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102fd1:	83 c4 10             	add    $0x10,%esp
80102fd4:	3b 1d e8 16 11 80    	cmp    0x801116e8,%ebx
80102fda:	7c 94                	jl     80102f70 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102fdc:	e8 7f fd ff ff       	call   80102d60 <write_head>
    install_trans(); // Now install writes to home locations
80102fe1:	e8 da fc ff ff       	call   80102cc0 <install_trans>
    log.lh.n = 0;
80102fe6:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102fed:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ff0:	e8 6b fd ff ff       	call   80102d60 <write_head>
80102ff5:	e9 34 ff ff ff       	jmp    80102f2e <end_op+0x5e>
80102ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103000:	83 ec 0c             	sub    $0xc,%esp
80103003:	68 a0 16 11 80       	push   $0x801116a0
80103008:	e8 f3 11 00 00       	call   80104200 <wakeup>
  release(&log.lock);
8010300d:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80103014:	e8 47 16 00 00       	call   80104660 <release>
80103019:	83 c4 10             	add    $0x10,%esp
}
8010301c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010301f:	5b                   	pop    %ebx
80103020:	5e                   	pop    %esi
80103021:	5f                   	pop    %edi
80103022:	5d                   	pop    %ebp
80103023:	c3                   	ret
    panic("log.committing");
80103024:	83 ec 0c             	sub    $0xc,%esp
80103027:	68 5b 74 10 80       	push   $0x8010745b
8010302c:	e8 4f d3 ff ff       	call   80100380 <panic>
80103031:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103038:	00 
80103039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103040 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	53                   	push   %ebx
80103044:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103047:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
{
8010304d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103050:	83 fa 1d             	cmp    $0x1d,%edx
80103053:	7f 7d                	jg     801030d2 <log_write+0x92>
80103055:	a1 d8 16 11 80       	mov    0x801116d8,%eax
8010305a:	83 e8 01             	sub    $0x1,%eax
8010305d:	39 c2                	cmp    %eax,%edx
8010305f:	7d 71                	jge    801030d2 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103061:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80103066:	85 c0                	test   %eax,%eax
80103068:	7e 75                	jle    801030df <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010306a:	83 ec 0c             	sub    $0xc,%esp
8010306d:	68 a0 16 11 80       	push   $0x801116a0
80103072:	e8 49 16 00 00       	call   801046c0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103077:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010307a:	83 c4 10             	add    $0x10,%esp
8010307d:	31 c0                	xor    %eax,%eax
8010307f:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80103085:	85 d2                	test   %edx,%edx
80103087:	7f 0e                	jg     80103097 <log_write+0x57>
80103089:	eb 15                	jmp    801030a0 <log_write+0x60>
8010308b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103090:	83 c0 01             	add    $0x1,%eax
80103093:	39 c2                	cmp    %eax,%edx
80103095:	74 29                	je     801030c0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103097:	39 0c 85 ec 16 11 80 	cmp    %ecx,-0x7feee914(,%eax,4)
8010309e:	75 f0                	jne    80103090 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
801030a0:	89 0c 85 ec 16 11 80 	mov    %ecx,-0x7feee914(,%eax,4)
  if (i == log.lh.n)
801030a7:	39 c2                	cmp    %eax,%edx
801030a9:	74 1c                	je     801030c7 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
801030ab:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
801030ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
801030b1:	c7 45 08 a0 16 11 80 	movl   $0x801116a0,0x8(%ebp)
}
801030b8:	c9                   	leave
  release(&log.lock);
801030b9:	e9 a2 15 00 00       	jmp    80104660 <release>
801030be:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
801030c0:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
    log.lh.n++;
801030c7:	83 c2 01             	add    $0x1,%edx
801030ca:	89 15 e8 16 11 80    	mov    %edx,0x801116e8
801030d0:	eb d9                	jmp    801030ab <log_write+0x6b>
    panic("too big a transaction");
801030d2:	83 ec 0c             	sub    $0xc,%esp
801030d5:	68 6a 74 10 80       	push   $0x8010746a
801030da:	e8 a1 d2 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
801030df:	83 ec 0c             	sub    $0xc,%esp
801030e2:	68 80 74 10 80       	push   $0x80107480
801030e7:	e8 94 d2 ff ff       	call   80100380 <panic>
801030ec:	66 90                	xchg   %ax,%ax
801030ee:	66 90                	xchg   %ax,%ax

801030f0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801030f0:	55                   	push   %ebp
801030f1:	89 e5                	mov    %esp,%ebp
801030f3:	53                   	push   %ebx
801030f4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801030f7:	e8 64 09 00 00       	call   80103a60 <cpuid>
801030fc:	89 c3                	mov    %eax,%ebx
801030fe:	e8 5d 09 00 00       	call   80103a60 <cpuid>
80103103:	83 ec 04             	sub    $0x4,%esp
80103106:	53                   	push   %ebx
80103107:	50                   	push   %eax
80103108:	68 9b 74 10 80       	push   $0x8010749b
8010310d:	e8 9e d5 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80103112:	e8 e9 28 00 00       	call   80105a00 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103117:	e8 e4 08 00 00       	call   80103a00 <mycpu>
8010311c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010311e:	b8 01 00 00 00       	mov    $0x1,%eax
80103123:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010312a:	e8 01 0c 00 00       	call   80103d30 <scheduler>
8010312f:	90                   	nop

80103130 <mpenter>:
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103136:	e8 c5 39 00 00       	call   80106b00 <switchkvm>
  seginit();
8010313b:	e8 30 39 00 00       	call   80106a70 <seginit>
  lapicinit();
80103140:	e8 bb f7 ff ff       	call   80102900 <lapicinit>
  mpmain();
80103145:	e8 a6 ff ff ff       	call   801030f0 <mpmain>
8010314a:	66 90                	xchg   %ax,%ax
8010314c:	66 90                	xchg   %ax,%ax
8010314e:	66 90                	xchg   %ax,%ax

80103150 <main>:
{
80103150:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103154:	83 e4 f0             	and    $0xfffffff0,%esp
80103157:	ff 71 fc             	push   -0x4(%ecx)
8010315a:	55                   	push   %ebp
8010315b:	89 e5                	mov    %esp,%ebp
8010315d:	53                   	push   %ebx
8010315e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010315f:	83 ec 08             	sub    $0x8,%esp
80103162:	68 00 00 40 80       	push   $0x80400000
80103167:	68 d0 54 11 80       	push   $0x801154d0
8010316c:	e8 9f f5 ff ff       	call   80102710 <kinit1>
  kvmalloc();      // kernel page table
80103171:	e8 4a 3e 00 00       	call   80106fc0 <kvmalloc>
  mpinit();        // detect other processors
80103176:	e8 85 01 00 00       	call   80103300 <mpinit>
  lapicinit();     // interrupt controller
8010317b:	e8 80 f7 ff ff       	call   80102900 <lapicinit>
  seginit();       // segment descriptors
80103180:	e8 eb 38 00 00       	call   80106a70 <seginit>
  picinit();       // disable pic
80103185:	e8 86 03 00 00       	call   80103510 <picinit>
  ioapicinit();    // another interrupt controller
8010318a:	e8 51 f3 ff ff       	call   801024e0 <ioapicinit>
  consoleinit();   // console hardware
8010318f:	e8 7c d9 ff ff       	call   80100b10 <consoleinit>
  uartinit();      // serial port
80103194:	e8 47 2b 00 00       	call   80105ce0 <uartinit>
  pinit();         // process table
80103199:	e8 42 08 00 00       	call   801039e0 <pinit>
  tvinit();        // trap vectors
8010319e:	e8 dd 27 00 00       	call   80105980 <tvinit>
  binit();         // buffer cache
801031a3:	e8 98 ce ff ff       	call   80100040 <binit>
  fileinit();      // file table
801031a8:	e8 a3 dd ff ff       	call   80100f50 <fileinit>
  ideinit();       // disk 
801031ad:	e8 0e f1 ff ff       	call   801022c0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801031b2:	83 c4 0c             	add    $0xc,%esp
801031b5:	68 8a 00 00 00       	push   $0x8a
801031ba:	68 8c a4 10 80       	push   $0x8010a48c
801031bf:	68 00 70 00 80       	push   $0x80007000
801031c4:	e8 87 16 00 00       	call   80104850 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801031c9:	83 c4 10             	add    $0x10,%esp
801031cc:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
801031d3:	00 00 00 
801031d6:	05 a0 17 11 80       	add    $0x801117a0,%eax
801031db:	3d a0 17 11 80       	cmp    $0x801117a0,%eax
801031e0:	76 7e                	jbe    80103260 <main+0x110>
801031e2:	bb a0 17 11 80       	mov    $0x801117a0,%ebx
801031e7:	eb 20                	jmp    80103209 <main+0xb9>
801031e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031f0:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
801031f7:	00 00 00 
801031fa:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103200:	05 a0 17 11 80       	add    $0x801117a0,%eax
80103205:	39 c3                	cmp    %eax,%ebx
80103207:	73 57                	jae    80103260 <main+0x110>
    if(c == mycpu())  // We've started already.
80103209:	e8 f2 07 00 00       	call   80103a00 <mycpu>
8010320e:	39 c3                	cmp    %eax,%ebx
80103210:	74 de                	je     801031f0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103212:	e8 69 f5 ff ff       	call   80102780 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103217:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010321a:	c7 05 f8 6f 00 80 30 	movl   $0x80103130,0x80006ff8
80103221:	31 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103224:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010322b:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010322e:	05 00 10 00 00       	add    $0x1000,%eax
80103233:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103238:	0f b6 03             	movzbl (%ebx),%eax
8010323b:	68 00 70 00 00       	push   $0x7000
80103240:	50                   	push   %eax
80103241:	e8 fa f7 ff ff       	call   80102a40 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103246:	83 c4 10             	add    $0x10,%esp
80103249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103250:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103256:	85 c0                	test   %eax,%eax
80103258:	74 f6                	je     80103250 <main+0x100>
8010325a:	eb 94                	jmp    801031f0 <main+0xa0>
8010325c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103260:	83 ec 08             	sub    $0x8,%esp
80103263:	68 00 00 00 8e       	push   $0x8e000000
80103268:	68 00 00 40 80       	push   $0x80400000
8010326d:	e8 3e f4 ff ff       	call   801026b0 <kinit2>
  userinit();      // first user process
80103272:	e8 39 08 00 00       	call   80103ab0 <userinit>
  mpmain();        // finish this processor's setup
80103277:	e8 74 fe ff ff       	call   801030f0 <mpmain>
8010327c:	66 90                	xchg   %ax,%ax
8010327e:	66 90                	xchg   %ax,%ax

80103280 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103280:	55                   	push   %ebp
80103281:	89 e5                	mov    %esp,%ebp
80103283:	57                   	push   %edi
80103284:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103285:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010328b:	53                   	push   %ebx
  e = addr+len;
8010328c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010328f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103292:	39 de                	cmp    %ebx,%esi
80103294:	72 10                	jb     801032a6 <mpsearch1+0x26>
80103296:	eb 50                	jmp    801032e8 <mpsearch1+0x68>
80103298:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010329f:	00 
801032a0:	89 fe                	mov    %edi,%esi
801032a2:	39 df                	cmp    %ebx,%edi
801032a4:	73 42                	jae    801032e8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801032a6:	83 ec 04             	sub    $0x4,%esp
801032a9:	8d 7e 10             	lea    0x10(%esi),%edi
801032ac:	6a 04                	push   $0x4
801032ae:	68 af 74 10 80       	push   $0x801074af
801032b3:	56                   	push   %esi
801032b4:	e8 47 15 00 00       	call   80104800 <memcmp>
801032b9:	83 c4 10             	add    $0x10,%esp
801032bc:	85 c0                	test   %eax,%eax
801032be:	75 e0                	jne    801032a0 <mpsearch1+0x20>
801032c0:	89 f2                	mov    %esi,%edx
801032c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801032c8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801032cb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801032ce:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801032d0:	39 fa                	cmp    %edi,%edx
801032d2:	75 f4                	jne    801032c8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801032d4:	84 c0                	test   %al,%al
801032d6:	75 c8                	jne    801032a0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801032d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032db:	89 f0                	mov    %esi,%eax
801032dd:	5b                   	pop    %ebx
801032de:	5e                   	pop    %esi
801032df:	5f                   	pop    %edi
801032e0:	5d                   	pop    %ebp
801032e1:	c3                   	ret
801032e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801032e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801032eb:	31 f6                	xor    %esi,%esi
}
801032ed:	5b                   	pop    %ebx
801032ee:	89 f0                	mov    %esi,%eax
801032f0:	5e                   	pop    %esi
801032f1:	5f                   	pop    %edi
801032f2:	5d                   	pop    %ebp
801032f3:	c3                   	ret
801032f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032fb:	00 
801032fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103300 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103300:	55                   	push   %ebp
80103301:	89 e5                	mov    %esp,%ebp
80103303:	57                   	push   %edi
80103304:	56                   	push   %esi
80103305:	53                   	push   %ebx
80103306:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103309:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103310:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103317:	c1 e0 08             	shl    $0x8,%eax
8010331a:	09 d0                	or     %edx,%eax
8010331c:	c1 e0 04             	shl    $0x4,%eax
8010331f:	75 1b                	jne    8010333c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103321:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103328:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010332f:	c1 e0 08             	shl    $0x8,%eax
80103332:	09 d0                	or     %edx,%eax
80103334:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103337:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010333c:	ba 00 04 00 00       	mov    $0x400,%edx
80103341:	e8 3a ff ff ff       	call   80103280 <mpsearch1>
80103346:	89 c3                	mov    %eax,%ebx
80103348:	85 c0                	test   %eax,%eax
8010334a:	0f 84 58 01 00 00    	je     801034a8 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103350:	8b 73 04             	mov    0x4(%ebx),%esi
80103353:	85 f6                	test   %esi,%esi
80103355:	0f 84 3d 01 00 00    	je     80103498 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
8010335b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010335e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103364:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103367:	6a 04                	push   $0x4
80103369:	68 b4 74 10 80       	push   $0x801074b4
8010336e:	50                   	push   %eax
8010336f:	e8 8c 14 00 00       	call   80104800 <memcmp>
80103374:	83 c4 10             	add    $0x10,%esp
80103377:	85 c0                	test   %eax,%eax
80103379:	0f 85 19 01 00 00    	jne    80103498 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
8010337f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103386:	3c 01                	cmp    $0x1,%al
80103388:	74 08                	je     80103392 <mpinit+0x92>
8010338a:	3c 04                	cmp    $0x4,%al
8010338c:	0f 85 06 01 00 00    	jne    80103498 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80103392:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103399:	66 85 d2             	test   %dx,%dx
8010339c:	74 22                	je     801033c0 <mpinit+0xc0>
8010339e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801033a1:	89 f0                	mov    %esi,%eax
  sum = 0;
801033a3:	31 d2                	xor    %edx,%edx
801033a5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801033a8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801033af:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801033b2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801033b4:	39 f8                	cmp    %edi,%eax
801033b6:	75 f0                	jne    801033a8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801033b8:	84 d2                	test   %dl,%dl
801033ba:	0f 85 d8 00 00 00    	jne    80103498 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801033c0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033c6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801033c9:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
801033cc:	a3 80 16 11 80       	mov    %eax,0x80111680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033d1:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801033d8:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801033de:	01 d7                	add    %edx,%edi
801033e0:	89 fa                	mov    %edi,%edx
  ismp = 1;
801033e2:	bf 01 00 00 00       	mov    $0x1,%edi
801033e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033ee:	00 
801033ef:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033f0:	39 d0                	cmp    %edx,%eax
801033f2:	73 19                	jae    8010340d <mpinit+0x10d>
    switch(*p){
801033f4:	0f b6 08             	movzbl (%eax),%ecx
801033f7:	80 f9 02             	cmp    $0x2,%cl
801033fa:	0f 84 80 00 00 00    	je     80103480 <mpinit+0x180>
80103400:	77 6e                	ja     80103470 <mpinit+0x170>
80103402:	84 c9                	test   %cl,%cl
80103404:	74 3a                	je     80103440 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103406:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103409:	39 d0                	cmp    %edx,%eax
8010340b:	72 e7                	jb     801033f4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010340d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103410:	85 ff                	test   %edi,%edi
80103412:	0f 84 dd 00 00 00    	je     801034f5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103418:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010341c:	74 15                	je     80103433 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010341e:	b8 70 00 00 00       	mov    $0x70,%eax
80103423:	ba 22 00 00 00       	mov    $0x22,%edx
80103428:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103429:	ba 23 00 00 00       	mov    $0x23,%edx
8010342e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010342f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103432:	ee                   	out    %al,(%dx)
  }
}
80103433:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103436:	5b                   	pop    %ebx
80103437:	5e                   	pop    %esi
80103438:	5f                   	pop    %edi
80103439:	5d                   	pop    %ebp
8010343a:	c3                   	ret
8010343b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103440:	8b 0d 84 17 11 80    	mov    0x80111784,%ecx
80103446:	83 f9 07             	cmp    $0x7,%ecx
80103449:	7f 19                	jg     80103464 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010344b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80103451:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103455:	83 c1 01             	add    $0x1,%ecx
80103458:	89 0d 84 17 11 80    	mov    %ecx,0x80111784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010345e:	88 9e a0 17 11 80    	mov    %bl,-0x7feee860(%esi)
      p += sizeof(struct mpproc);
80103464:	83 c0 14             	add    $0x14,%eax
      continue;
80103467:	eb 87                	jmp    801033f0 <mpinit+0xf0>
80103469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103470:	83 e9 03             	sub    $0x3,%ecx
80103473:	80 f9 01             	cmp    $0x1,%cl
80103476:	76 8e                	jbe    80103406 <mpinit+0x106>
80103478:	31 ff                	xor    %edi,%edi
8010347a:	e9 71 ff ff ff       	jmp    801033f0 <mpinit+0xf0>
8010347f:	90                   	nop
      ioapicid = ioapic->apicno;
80103480:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103484:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103487:	88 0d 80 17 11 80    	mov    %cl,0x80111780
      continue;
8010348d:	e9 5e ff ff ff       	jmp    801033f0 <mpinit+0xf0>
80103492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103498:	83 ec 0c             	sub    $0xc,%esp
8010349b:	68 b9 74 10 80       	push   $0x801074b9
801034a0:	e8 db ce ff ff       	call   80100380 <panic>
801034a5:	8d 76 00             	lea    0x0(%esi),%esi
{
801034a8:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801034ad:	eb 0b                	jmp    801034ba <mpinit+0x1ba>
801034af:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
801034b0:	89 f3                	mov    %esi,%ebx
801034b2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801034b8:	74 de                	je     80103498 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801034ba:	83 ec 04             	sub    $0x4,%esp
801034bd:	8d 73 10             	lea    0x10(%ebx),%esi
801034c0:	6a 04                	push   $0x4
801034c2:	68 af 74 10 80       	push   $0x801074af
801034c7:	53                   	push   %ebx
801034c8:	e8 33 13 00 00       	call   80104800 <memcmp>
801034cd:	83 c4 10             	add    $0x10,%esp
801034d0:	85 c0                	test   %eax,%eax
801034d2:	75 dc                	jne    801034b0 <mpinit+0x1b0>
801034d4:	89 da                	mov    %ebx,%edx
801034d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034dd:	00 
801034de:	66 90                	xchg   %ax,%ax
    sum += addr[i];
801034e0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801034e3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801034e6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801034e8:	39 d6                	cmp    %edx,%esi
801034ea:	75 f4                	jne    801034e0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801034ec:	84 c0                	test   %al,%al
801034ee:	75 c0                	jne    801034b0 <mpinit+0x1b0>
801034f0:	e9 5b fe ff ff       	jmp    80103350 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801034f5:	83 ec 0c             	sub    $0xc,%esp
801034f8:	68 74 78 10 80       	push   $0x80107874
801034fd:	e8 7e ce ff ff       	call   80100380 <panic>
80103502:	66 90                	xchg   %ax,%ax
80103504:	66 90                	xchg   %ax,%ax
80103506:	66 90                	xchg   %ax,%ax
80103508:	66 90                	xchg   %ax,%ax
8010350a:	66 90                	xchg   %ax,%ax
8010350c:	66 90                	xchg   %ax,%ax
8010350e:	66 90                	xchg   %ax,%ax

80103510 <picinit>:
80103510:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103515:	ba 21 00 00 00       	mov    $0x21,%edx
8010351a:	ee                   	out    %al,(%dx)
8010351b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103520:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103521:	c3                   	ret
80103522:	66 90                	xchg   %ax,%ax
80103524:	66 90                	xchg   %ax,%ax
80103526:	66 90                	xchg   %ax,%ax
80103528:	66 90                	xchg   %ax,%ax
8010352a:	66 90                	xchg   %ax,%ax
8010352c:	66 90                	xchg   %ax,%ax
8010352e:	66 90                	xchg   %ax,%ax

80103530 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	57                   	push   %edi
80103534:	56                   	push   %esi
80103535:	53                   	push   %ebx
80103536:	83 ec 0c             	sub    $0xc,%esp
80103539:	8b 75 08             	mov    0x8(%ebp),%esi
8010353c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010353f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103545:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010354b:	e8 20 da ff ff       	call   80100f70 <filealloc>
80103550:	89 06                	mov    %eax,(%esi)
80103552:	85 c0                	test   %eax,%eax
80103554:	0f 84 a5 00 00 00    	je     801035ff <pipealloc+0xcf>
8010355a:	e8 11 da ff ff       	call   80100f70 <filealloc>
8010355f:	89 07                	mov    %eax,(%edi)
80103561:	85 c0                	test   %eax,%eax
80103563:	0f 84 84 00 00 00    	je     801035ed <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103569:	e8 12 f2 ff ff       	call   80102780 <kalloc>
8010356e:	89 c3                	mov    %eax,%ebx
80103570:	85 c0                	test   %eax,%eax
80103572:	0f 84 a0 00 00 00    	je     80103618 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103578:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010357f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103582:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103585:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010358c:	00 00 00 
  p->nwrite = 0;
8010358f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103596:	00 00 00 
  p->nread = 0;
80103599:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801035a0:	00 00 00 
  initlock(&p->lock, "pipe");
801035a3:	68 d1 74 10 80       	push   $0x801074d1
801035a8:	50                   	push   %eax
801035a9:	e8 22 0f 00 00       	call   801044d0 <initlock>
  (*f0)->type = FD_PIPE;
801035ae:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801035b0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801035b3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801035b9:	8b 06                	mov    (%esi),%eax
801035bb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801035bf:	8b 06                	mov    (%esi),%eax
801035c1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801035c5:	8b 06                	mov    (%esi),%eax
801035c7:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801035ca:	8b 07                	mov    (%edi),%eax
801035cc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801035d2:	8b 07                	mov    (%edi),%eax
801035d4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801035d8:	8b 07                	mov    (%edi),%eax
801035da:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801035de:	8b 07                	mov    (%edi),%eax
801035e0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
801035e3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801035e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035e8:	5b                   	pop    %ebx
801035e9:	5e                   	pop    %esi
801035ea:	5f                   	pop    %edi
801035eb:	5d                   	pop    %ebp
801035ec:	c3                   	ret
  if(*f0)
801035ed:	8b 06                	mov    (%esi),%eax
801035ef:	85 c0                	test   %eax,%eax
801035f1:	74 1e                	je     80103611 <pipealloc+0xe1>
    fileclose(*f0);
801035f3:	83 ec 0c             	sub    $0xc,%esp
801035f6:	50                   	push   %eax
801035f7:	e8 34 da ff ff       	call   80101030 <fileclose>
801035fc:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801035ff:	8b 07                	mov    (%edi),%eax
80103601:	85 c0                	test   %eax,%eax
80103603:	74 0c                	je     80103611 <pipealloc+0xe1>
    fileclose(*f1);
80103605:	83 ec 0c             	sub    $0xc,%esp
80103608:	50                   	push   %eax
80103609:	e8 22 da ff ff       	call   80101030 <fileclose>
8010360e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103611:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103616:	eb cd                	jmp    801035e5 <pipealloc+0xb5>
  if(*f0)
80103618:	8b 06                	mov    (%esi),%eax
8010361a:	85 c0                	test   %eax,%eax
8010361c:	75 d5                	jne    801035f3 <pipealloc+0xc3>
8010361e:	eb df                	jmp    801035ff <pipealloc+0xcf>

80103620 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	56                   	push   %esi
80103624:	53                   	push   %ebx
80103625:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103628:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010362b:	83 ec 0c             	sub    $0xc,%esp
8010362e:	53                   	push   %ebx
8010362f:	e8 8c 10 00 00       	call   801046c0 <acquire>
  if(writable){
80103634:	83 c4 10             	add    $0x10,%esp
80103637:	85 f6                	test   %esi,%esi
80103639:	74 65                	je     801036a0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010363b:	83 ec 0c             	sub    $0xc,%esp
8010363e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103644:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010364b:	00 00 00 
    wakeup(&p->nread);
8010364e:	50                   	push   %eax
8010364f:	e8 ac 0b 00 00       	call   80104200 <wakeup>
80103654:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103657:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010365d:	85 d2                	test   %edx,%edx
8010365f:	75 0a                	jne    8010366b <pipeclose+0x4b>
80103661:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103667:	85 c0                	test   %eax,%eax
80103669:	74 15                	je     80103680 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010366b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010366e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103671:	5b                   	pop    %ebx
80103672:	5e                   	pop    %esi
80103673:	5d                   	pop    %ebp
    release(&p->lock);
80103674:	e9 e7 0f 00 00       	jmp    80104660 <release>
80103679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103680:	83 ec 0c             	sub    $0xc,%esp
80103683:	53                   	push   %ebx
80103684:	e8 d7 0f 00 00       	call   80104660 <release>
    kfree((char*)p);
80103689:	83 c4 10             	add    $0x10,%esp
8010368c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010368f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103692:	5b                   	pop    %ebx
80103693:	5e                   	pop    %esi
80103694:	5d                   	pop    %ebp
    kfree((char*)p);
80103695:	e9 26 ef ff ff       	jmp    801025c0 <kfree>
8010369a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801036a0:	83 ec 0c             	sub    $0xc,%esp
801036a3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801036a9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801036b0:	00 00 00 
    wakeup(&p->nwrite);
801036b3:	50                   	push   %eax
801036b4:	e8 47 0b 00 00       	call   80104200 <wakeup>
801036b9:	83 c4 10             	add    $0x10,%esp
801036bc:	eb 99                	jmp    80103657 <pipeclose+0x37>
801036be:	66 90                	xchg   %ax,%ax

801036c0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	57                   	push   %edi
801036c4:	56                   	push   %esi
801036c5:	53                   	push   %ebx
801036c6:	83 ec 28             	sub    $0x28,%esp
801036c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036cc:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
801036cf:	53                   	push   %ebx
801036d0:	e8 eb 0f 00 00       	call   801046c0 <acquire>
  for(i = 0; i < n; i++){
801036d5:	83 c4 10             	add    $0x10,%esp
801036d8:	85 ff                	test   %edi,%edi
801036da:	0f 8e ce 00 00 00    	jle    801037ae <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036e0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801036e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801036e9:	89 7d 10             	mov    %edi,0x10(%ebp)
801036ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801036ef:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801036f2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801036f5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036fb:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103701:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103707:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010370d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103710:	0f 85 b6 00 00 00    	jne    801037cc <pipewrite+0x10c>
80103716:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103719:	eb 3b                	jmp    80103756 <pipewrite+0x96>
8010371b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103720:	e8 5b 03 00 00       	call   80103a80 <myproc>
80103725:	8b 48 24             	mov    0x24(%eax),%ecx
80103728:	85 c9                	test   %ecx,%ecx
8010372a:	75 34                	jne    80103760 <pipewrite+0xa0>
      wakeup(&p->nread);
8010372c:	83 ec 0c             	sub    $0xc,%esp
8010372f:	56                   	push   %esi
80103730:	e8 cb 0a 00 00       	call   80104200 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103735:	58                   	pop    %eax
80103736:	5a                   	pop    %edx
80103737:	53                   	push   %ebx
80103738:	57                   	push   %edi
80103739:	e8 02 0a 00 00       	call   80104140 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010373e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103744:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010374a:	83 c4 10             	add    $0x10,%esp
8010374d:	05 00 02 00 00       	add    $0x200,%eax
80103752:	39 c2                	cmp    %eax,%edx
80103754:	75 2a                	jne    80103780 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103756:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010375c:	85 c0                	test   %eax,%eax
8010375e:	75 c0                	jne    80103720 <pipewrite+0x60>
        release(&p->lock);
80103760:	83 ec 0c             	sub    $0xc,%esp
80103763:	53                   	push   %ebx
80103764:	e8 f7 0e 00 00       	call   80104660 <release>
        return -1;
80103769:	83 c4 10             	add    $0x10,%esp
8010376c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103771:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103774:	5b                   	pop    %ebx
80103775:	5e                   	pop    %esi
80103776:	5f                   	pop    %edi
80103777:	5d                   	pop    %ebp
80103778:	c3                   	ret
80103779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103780:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103783:	8d 42 01             	lea    0x1(%edx),%eax
80103786:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010378c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010378f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103795:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103798:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010379c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801037a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801037a3:	39 c1                	cmp    %eax,%ecx
801037a5:	0f 85 50 ff ff ff    	jne    801036fb <pipewrite+0x3b>
801037ab:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801037ae:	83 ec 0c             	sub    $0xc,%esp
801037b1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801037b7:	50                   	push   %eax
801037b8:	e8 43 0a 00 00       	call   80104200 <wakeup>
  release(&p->lock);
801037bd:	89 1c 24             	mov    %ebx,(%esp)
801037c0:	e8 9b 0e 00 00       	call   80104660 <release>
  return n;
801037c5:	83 c4 10             	add    $0x10,%esp
801037c8:	89 f8                	mov    %edi,%eax
801037ca:	eb a5                	jmp    80103771 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801037cf:	eb b2                	jmp    80103783 <pipewrite+0xc3>
801037d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801037d8:	00 
801037d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801037e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	57                   	push   %edi
801037e4:	56                   	push   %esi
801037e5:	53                   	push   %ebx
801037e6:	83 ec 18             	sub    $0x18,%esp
801037e9:	8b 75 08             	mov    0x8(%ebp),%esi
801037ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801037ef:	56                   	push   %esi
801037f0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801037f6:	e8 c5 0e 00 00       	call   801046c0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037fb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103801:	83 c4 10             	add    $0x10,%esp
80103804:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010380a:	74 2f                	je     8010383b <piperead+0x5b>
8010380c:	eb 37                	jmp    80103845 <piperead+0x65>
8010380e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103810:	e8 6b 02 00 00       	call   80103a80 <myproc>
80103815:	8b 40 24             	mov    0x24(%eax),%eax
80103818:	85 c0                	test   %eax,%eax
8010381a:	0f 85 80 00 00 00    	jne    801038a0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103820:	83 ec 08             	sub    $0x8,%esp
80103823:	56                   	push   %esi
80103824:	53                   	push   %ebx
80103825:	e8 16 09 00 00       	call   80104140 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010382a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103830:	83 c4 10             	add    $0x10,%esp
80103833:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103839:	75 0a                	jne    80103845 <piperead+0x65>
8010383b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103841:	85 d2                	test   %edx,%edx
80103843:	75 cb                	jne    80103810 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103845:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103848:	31 db                	xor    %ebx,%ebx
8010384a:	85 c9                	test   %ecx,%ecx
8010384c:	7f 26                	jg     80103874 <piperead+0x94>
8010384e:	eb 2c                	jmp    8010387c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103850:	8d 48 01             	lea    0x1(%eax),%ecx
80103853:	25 ff 01 00 00       	and    $0x1ff,%eax
80103858:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010385e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103863:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103866:	83 c3 01             	add    $0x1,%ebx
80103869:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010386c:	74 0e                	je     8010387c <piperead+0x9c>
8010386e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103874:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010387a:	75 d4                	jne    80103850 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010387c:	83 ec 0c             	sub    $0xc,%esp
8010387f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103885:	50                   	push   %eax
80103886:	e8 75 09 00 00       	call   80104200 <wakeup>
  release(&p->lock);
8010388b:	89 34 24             	mov    %esi,(%esp)
8010388e:	e8 cd 0d 00 00       	call   80104660 <release>
  return i;
80103893:	83 c4 10             	add    $0x10,%esp
}
80103896:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103899:	89 d8                	mov    %ebx,%eax
8010389b:	5b                   	pop    %ebx
8010389c:	5e                   	pop    %esi
8010389d:	5f                   	pop    %edi
8010389e:	5d                   	pop    %ebp
8010389f:	c3                   	ret
      release(&p->lock);
801038a0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801038a3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801038a8:	56                   	push   %esi
801038a9:	e8 b2 0d 00 00       	call   80104660 <release>
      return -1;
801038ae:	83 c4 10             	add    $0x10,%esp
}
801038b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038b4:	89 d8                	mov    %ebx,%eax
801038b6:	5b                   	pop    %ebx
801038b7:	5e                   	pop    %esi
801038b8:	5f                   	pop    %edi
801038b9:	5d                   	pop    %ebp
801038ba:	c3                   	ret
801038bb:	66 90                	xchg   %ax,%ax
801038bd:	66 90                	xchg   %ax,%ax
801038bf:	90                   	nop

801038c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038c4:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
{
801038c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801038cc:	68 20 1d 11 80       	push   $0x80111d20
801038d1:	e8 ea 0d 00 00       	call   801046c0 <acquire>
801038d6:	83 c4 10             	add    $0x10,%esp
801038d9:	eb 10                	jmp    801038eb <allocproc+0x2b>
801038db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038e0:	83 c3 7c             	add    $0x7c,%ebx
801038e3:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801038e9:	74 75                	je     80103960 <allocproc+0xa0>
    if(p->state == UNUSED)
801038eb:	8b 43 0c             	mov    0xc(%ebx),%eax
801038ee:	85 c0                	test   %eax,%eax
801038f0:	75 ee                	jne    801038e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801038f2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801038f7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801038fa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103901:	89 43 10             	mov    %eax,0x10(%ebx)
80103904:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103907:	68 20 1d 11 80       	push   $0x80111d20
  p->pid = nextpid++;
8010390c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103912:	e8 49 0d 00 00       	call   80104660 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103917:	e8 64 ee ff ff       	call   80102780 <kalloc>
8010391c:	83 c4 10             	add    $0x10,%esp
8010391f:	89 43 08             	mov    %eax,0x8(%ebx)
80103922:	85 c0                	test   %eax,%eax
80103924:	74 53                	je     80103979 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103926:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010392c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010392f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103934:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103937:	c7 40 14 72 59 10 80 	movl   $0x80105972,0x14(%eax)
  p->context = (struct context*)sp;
8010393e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103941:	6a 14                	push   $0x14
80103943:	6a 00                	push   $0x0
80103945:	50                   	push   %eax
80103946:	e8 75 0e 00 00       	call   801047c0 <memset>
  p->context->eip = (uint)forkret;
8010394b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010394e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103951:	c7 40 10 90 39 10 80 	movl   $0x80103990,0x10(%eax)
}
80103958:	89 d8                	mov    %ebx,%eax
8010395a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010395d:	c9                   	leave
8010395e:	c3                   	ret
8010395f:	90                   	nop
  release(&ptable.lock);
80103960:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103963:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103965:	68 20 1d 11 80       	push   $0x80111d20
8010396a:	e8 f1 0c 00 00       	call   80104660 <release>
  return 0;
8010396f:	83 c4 10             	add    $0x10,%esp
}
80103972:	89 d8                	mov    %ebx,%eax
80103974:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103977:	c9                   	leave
80103978:	c3                   	ret
    p->state = UNUSED;
80103979:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103980:	31 db                	xor    %ebx,%ebx
80103982:	eb ee                	jmp    80103972 <allocproc+0xb2>
80103984:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010398b:	00 
8010398c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103990 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103996:	68 20 1d 11 80       	push   $0x80111d20
8010399b:	e8 c0 0c 00 00       	call   80104660 <release>

  if (first) {
801039a0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801039a5:	83 c4 10             	add    $0x10,%esp
801039a8:	85 c0                	test   %eax,%eax
801039aa:	75 04                	jne    801039b0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801039ac:	c9                   	leave
801039ad:	c3                   	ret
801039ae:	66 90                	xchg   %ax,%ax
    first = 0;
801039b0:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801039b7:	00 00 00 
    iinit(ROOTDEV);
801039ba:	83 ec 0c             	sub    $0xc,%esp
801039bd:	6a 01                	push   $0x1
801039bf:	e8 dc dc ff ff       	call   801016a0 <iinit>
    initlog(ROOTDEV);
801039c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801039cb:	e8 f0 f3 ff ff       	call   80102dc0 <initlog>
}
801039d0:	83 c4 10             	add    $0x10,%esp
801039d3:	c9                   	leave
801039d4:	c3                   	ret
801039d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039dc:	00 
801039dd:	8d 76 00             	lea    0x0(%esi),%esi

801039e0 <pinit>:
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801039e6:	68 d6 74 10 80       	push   $0x801074d6
801039eb:	68 20 1d 11 80       	push   $0x80111d20
801039f0:	e8 db 0a 00 00       	call   801044d0 <initlock>
}
801039f5:	83 c4 10             	add    $0x10,%esp
801039f8:	c9                   	leave
801039f9:	c3                   	ret
801039fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a00 <mycpu>:
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	56                   	push   %esi
80103a04:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a05:	9c                   	pushf
80103a06:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103a07:	f6 c4 02             	test   $0x2,%ah
80103a0a:	75 46                	jne    80103a52 <mycpu+0x52>
  apicid = lapicid();
80103a0c:	e8 df ef ff ff       	call   801029f0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103a11:	8b 35 84 17 11 80    	mov    0x80111784,%esi
80103a17:	85 f6                	test   %esi,%esi
80103a19:	7e 2a                	jle    80103a45 <mycpu+0x45>
80103a1b:	31 d2                	xor    %edx,%edx
80103a1d:	eb 08                	jmp    80103a27 <mycpu+0x27>
80103a1f:	90                   	nop
80103a20:	83 c2 01             	add    $0x1,%edx
80103a23:	39 f2                	cmp    %esi,%edx
80103a25:	74 1e                	je     80103a45 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103a27:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103a2d:	0f b6 99 a0 17 11 80 	movzbl -0x7feee860(%ecx),%ebx
80103a34:	39 c3                	cmp    %eax,%ebx
80103a36:	75 e8                	jne    80103a20 <mycpu+0x20>
}
80103a38:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103a3b:	8d 81 a0 17 11 80    	lea    -0x7feee860(%ecx),%eax
}
80103a41:	5b                   	pop    %ebx
80103a42:	5e                   	pop    %esi
80103a43:	5d                   	pop    %ebp
80103a44:	c3                   	ret
  panic("unknown apicid\n");
80103a45:	83 ec 0c             	sub    $0xc,%esp
80103a48:	68 dd 74 10 80       	push   $0x801074dd
80103a4d:	e8 2e c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103a52:	83 ec 0c             	sub    $0xc,%esp
80103a55:	68 94 78 10 80       	push   $0x80107894
80103a5a:	e8 21 c9 ff ff       	call   80100380 <panic>
80103a5f:	90                   	nop

80103a60 <cpuid>:
cpuid() {
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103a66:	e8 95 ff ff ff       	call   80103a00 <mycpu>
}
80103a6b:	c9                   	leave
  return mycpu()-cpus;
80103a6c:	2d a0 17 11 80       	sub    $0x801117a0,%eax
80103a71:	c1 f8 04             	sar    $0x4,%eax
80103a74:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103a7a:	c3                   	ret
80103a7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103a80 <myproc>:
myproc(void) {
80103a80:	55                   	push   %ebp
80103a81:	89 e5                	mov    %esp,%ebp
80103a83:	53                   	push   %ebx
80103a84:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103a87:	e8 e4 0a 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103a8c:	e8 6f ff ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103a91:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a97:	e8 24 0b 00 00       	call   801045c0 <popcli>
}
80103a9c:	89 d8                	mov    %ebx,%eax
80103a9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103aa1:	c9                   	leave
80103aa2:	c3                   	ret
80103aa3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103aaa:	00 
80103aab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103ab0 <userinit>:
{
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	53                   	push   %ebx
80103ab4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103ab7:	e8 04 fe ff ff       	call   801038c0 <allocproc>
80103abc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103abe:	a3 54 3c 11 80       	mov    %eax,0x80113c54
  if((p->pgdir = setupkvm()) == 0)
80103ac3:	e8 78 34 00 00       	call   80106f40 <setupkvm>
80103ac8:	89 43 04             	mov    %eax,0x4(%ebx)
80103acb:	85 c0                	test   %eax,%eax
80103acd:	0f 84 bd 00 00 00    	je     80103b90 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ad3:	83 ec 04             	sub    $0x4,%esp
80103ad6:	68 2c 00 00 00       	push   $0x2c
80103adb:	68 60 a4 10 80       	push   $0x8010a460
80103ae0:	50                   	push   %eax
80103ae1:	e8 3a 31 00 00       	call   80106c20 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ae6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ae9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103aef:	6a 4c                	push   $0x4c
80103af1:	6a 00                	push   $0x0
80103af3:	ff 73 18             	push   0x18(%ebx)
80103af6:	e8 c5 0c 00 00       	call   801047c0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103afb:	8b 43 18             	mov    0x18(%ebx),%eax
80103afe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b03:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b06:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b0b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b0f:	8b 43 18             	mov    0x18(%ebx),%eax
80103b12:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b16:	8b 43 18             	mov    0x18(%ebx),%eax
80103b19:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b1d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103b21:	8b 43 18             	mov    0x18(%ebx),%eax
80103b24:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b28:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103b2c:	8b 43 18             	mov    0x18(%ebx),%eax
80103b2f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103b36:	8b 43 18             	mov    0x18(%ebx),%eax
80103b39:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103b40:	8b 43 18             	mov    0x18(%ebx),%eax
80103b43:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b4a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b4d:	6a 10                	push   $0x10
80103b4f:	68 06 75 10 80       	push   $0x80107506
80103b54:	50                   	push   %eax
80103b55:	e8 16 0e 00 00       	call   80104970 <safestrcpy>
  p->cwd = namei("/");
80103b5a:	c7 04 24 0f 75 10 80 	movl   $0x8010750f,(%esp)
80103b61:	e8 3a e6 ff ff       	call   801021a0 <namei>
80103b66:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103b69:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103b70:	e8 4b 0b 00 00       	call   801046c0 <acquire>
  p->state = RUNNABLE;
80103b75:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103b7c:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103b83:	e8 d8 0a 00 00       	call   80104660 <release>
}
80103b88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b8b:	83 c4 10             	add    $0x10,%esp
80103b8e:	c9                   	leave
80103b8f:	c3                   	ret
    panic("userinit: out of memory?");
80103b90:	83 ec 0c             	sub    $0xc,%esp
80103b93:	68 ed 74 10 80       	push   $0x801074ed
80103b98:	e8 e3 c7 ff ff       	call   80100380 <panic>
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi

80103ba0 <growproc>:
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	56                   	push   %esi
80103ba4:	53                   	push   %ebx
80103ba5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103ba8:	e8 c3 09 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103bad:	e8 4e fe ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103bb2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bb8:	e8 03 0a 00 00       	call   801045c0 <popcli>
  sz = curproc->sz;
80103bbd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103bbf:	85 f6                	test   %esi,%esi
80103bc1:	7f 1d                	jg     80103be0 <growproc+0x40>
  } else if(n < 0){
80103bc3:	75 3b                	jne    80103c00 <growproc+0x60>
  switchuvm(curproc);
80103bc5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103bc8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103bca:	53                   	push   %ebx
80103bcb:	e8 40 2f 00 00       	call   80106b10 <switchuvm>
  return 0;
80103bd0:	83 c4 10             	add    $0x10,%esp
80103bd3:	31 c0                	xor    %eax,%eax
}
80103bd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bd8:	5b                   	pop    %ebx
80103bd9:	5e                   	pop    %esi
80103bda:	5d                   	pop    %ebp
80103bdb:	c3                   	ret
80103bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103be0:	83 ec 04             	sub    $0x4,%esp
80103be3:	01 c6                	add    %eax,%esi
80103be5:	56                   	push   %esi
80103be6:	50                   	push   %eax
80103be7:	ff 73 04             	push   0x4(%ebx)
80103bea:	e8 81 31 00 00       	call   80106d70 <allocuvm>
80103bef:	83 c4 10             	add    $0x10,%esp
80103bf2:	85 c0                	test   %eax,%eax
80103bf4:	75 cf                	jne    80103bc5 <growproc+0x25>
      return -1;
80103bf6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bfb:	eb d8                	jmp    80103bd5 <growproc+0x35>
80103bfd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c00:	83 ec 04             	sub    $0x4,%esp
80103c03:	01 c6                	add    %eax,%esi
80103c05:	56                   	push   %esi
80103c06:	50                   	push   %eax
80103c07:	ff 73 04             	push   0x4(%ebx)
80103c0a:	e8 81 32 00 00       	call   80106e90 <deallocuvm>
80103c0f:	83 c4 10             	add    $0x10,%esp
80103c12:	85 c0                	test   %eax,%eax
80103c14:	75 af                	jne    80103bc5 <growproc+0x25>
80103c16:	eb de                	jmp    80103bf6 <growproc+0x56>
80103c18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c1f:	00 

80103c20 <fork>:
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	57                   	push   %edi
80103c24:	56                   	push   %esi
80103c25:	53                   	push   %ebx
80103c26:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c29:	e8 42 09 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103c2e:	e8 cd fd ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103c33:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c39:	e8 82 09 00 00       	call   801045c0 <popcli>
  if((np = allocproc()) == 0){
80103c3e:	e8 7d fc ff ff       	call   801038c0 <allocproc>
80103c43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c46:	85 c0                	test   %eax,%eax
80103c48:	0f 84 d6 00 00 00    	je     80103d24 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103c4e:	83 ec 08             	sub    $0x8,%esp
80103c51:	ff 33                	push   (%ebx)
80103c53:	89 c7                	mov    %eax,%edi
80103c55:	ff 73 04             	push   0x4(%ebx)
80103c58:	e8 d3 33 00 00       	call   80107030 <copyuvm>
80103c5d:	83 c4 10             	add    $0x10,%esp
80103c60:	89 47 04             	mov    %eax,0x4(%edi)
80103c63:	85 c0                	test   %eax,%eax
80103c65:	0f 84 9a 00 00 00    	je     80103d05 <fork+0xe5>
  np->sz = curproc->sz;
80103c6b:	8b 03                	mov    (%ebx),%eax
80103c6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103c70:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103c72:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103c75:	89 c8                	mov    %ecx,%eax
80103c77:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103c7a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103c7f:	8b 73 18             	mov    0x18(%ebx),%esi
80103c82:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103c84:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103c86:	8b 40 18             	mov    0x18(%eax),%eax
80103c89:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103c90:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c94:	85 c0                	test   %eax,%eax
80103c96:	74 13                	je     80103cab <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c98:	83 ec 0c             	sub    $0xc,%esp
80103c9b:	50                   	push   %eax
80103c9c:	e8 3f d3 ff ff       	call   80100fe0 <filedup>
80103ca1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ca4:	83 c4 10             	add    $0x10,%esp
80103ca7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103cab:	83 c6 01             	add    $0x1,%esi
80103cae:	83 fe 10             	cmp    $0x10,%esi
80103cb1:	75 dd                	jne    80103c90 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103cb3:	83 ec 0c             	sub    $0xc,%esp
80103cb6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cb9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103cbc:	e8 cf db ff ff       	call   80101890 <idup>
80103cc1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cc4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103cc7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cca:	8d 47 6c             	lea    0x6c(%edi),%eax
80103ccd:	6a 10                	push   $0x10
80103ccf:	53                   	push   %ebx
80103cd0:	50                   	push   %eax
80103cd1:	e8 9a 0c 00 00       	call   80104970 <safestrcpy>
  pid = np->pid;
80103cd6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103cd9:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103ce0:	e8 db 09 00 00       	call   801046c0 <acquire>
  np->state = RUNNABLE;
80103ce5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103cec:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103cf3:	e8 68 09 00 00       	call   80104660 <release>
  return pid;
80103cf8:	83 c4 10             	add    $0x10,%esp
}
80103cfb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cfe:	89 d8                	mov    %ebx,%eax
80103d00:	5b                   	pop    %ebx
80103d01:	5e                   	pop    %esi
80103d02:	5f                   	pop    %edi
80103d03:	5d                   	pop    %ebp
80103d04:	c3                   	ret
    kfree(np->kstack);
80103d05:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103d08:	83 ec 0c             	sub    $0xc,%esp
80103d0b:	ff 73 08             	push   0x8(%ebx)
80103d0e:	e8 ad e8 ff ff       	call   801025c0 <kfree>
    np->kstack = 0;
80103d13:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103d1a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103d1d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103d24:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d29:	eb d0                	jmp    80103cfb <fork+0xdb>
80103d2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103d30 <scheduler>:
{
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	57                   	push   %edi
80103d34:	56                   	push   %esi
80103d35:	53                   	push   %ebx
80103d36:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103d39:	e8 c2 fc ff ff       	call   80103a00 <mycpu>
  c->proc = 0;
80103d3e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d45:	00 00 00 
  struct cpu *c = mycpu();
80103d48:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103d4a:	8d 78 04             	lea    0x4(%eax),%edi
80103d4d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103d50:	fb                   	sti
    acquire(&ptable.lock);
80103d51:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d54:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
    acquire(&ptable.lock);
80103d59:	68 20 1d 11 80       	push   $0x80111d20
80103d5e:	e8 5d 09 00 00       	call   801046c0 <acquire>
80103d63:	83 c4 10             	add    $0x10,%esp
80103d66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d6d:	00 
80103d6e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103d70:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103d74:	75 33                	jne    80103da9 <scheduler+0x79>
      switchuvm(p);
80103d76:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103d79:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103d7f:	53                   	push   %ebx
80103d80:	e8 8b 2d 00 00       	call   80106b10 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103d85:	58                   	pop    %eax
80103d86:	5a                   	pop    %edx
80103d87:	ff 73 1c             	push   0x1c(%ebx)
80103d8a:	57                   	push   %edi
      p->state = RUNNING;
80103d8b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103d92:	e8 34 0c 00 00       	call   801049cb <swtch>
      switchkvm();
80103d97:	e8 64 2d 00 00       	call   80106b00 <switchkvm>
      c->proc = 0;
80103d9c:	83 c4 10             	add    $0x10,%esp
80103d9f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103da6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103da9:	83 c3 7c             	add    $0x7c,%ebx
80103dac:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103db2:	75 bc                	jne    80103d70 <scheduler+0x40>
    release(&ptable.lock);
80103db4:	83 ec 0c             	sub    $0xc,%esp
80103db7:	68 20 1d 11 80       	push   $0x80111d20
80103dbc:	e8 9f 08 00 00       	call   80104660 <release>
    sti();
80103dc1:	83 c4 10             	add    $0x10,%esp
80103dc4:	eb 8a                	jmp    80103d50 <scheduler+0x20>
80103dc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103dcd:	00 
80103dce:	66 90                	xchg   %ax,%ax

80103dd0 <sched>:
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	56                   	push   %esi
80103dd4:	53                   	push   %ebx
  pushcli();
80103dd5:	e8 96 07 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103dda:	e8 21 fc ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103ddf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103de5:	e8 d6 07 00 00       	call   801045c0 <popcli>
  if(!holding(&ptable.lock))
80103dea:	83 ec 0c             	sub    $0xc,%esp
80103ded:	68 20 1d 11 80       	push   $0x80111d20
80103df2:	e8 29 08 00 00       	call   80104620 <holding>
80103df7:	83 c4 10             	add    $0x10,%esp
80103dfa:	85 c0                	test   %eax,%eax
80103dfc:	74 4f                	je     80103e4d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103dfe:	e8 fd fb ff ff       	call   80103a00 <mycpu>
80103e03:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103e0a:	75 68                	jne    80103e74 <sched+0xa4>
  if(p->state == RUNNING)
80103e0c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e10:	74 55                	je     80103e67 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e12:	9c                   	pushf
80103e13:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e14:	f6 c4 02             	test   $0x2,%ah
80103e17:	75 41                	jne    80103e5a <sched+0x8a>
  intena = mycpu()->intena;
80103e19:	e8 e2 fb ff ff       	call   80103a00 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e1e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103e21:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e27:	e8 d4 fb ff ff       	call   80103a00 <mycpu>
80103e2c:	83 ec 08             	sub    $0x8,%esp
80103e2f:	ff 70 04             	push   0x4(%eax)
80103e32:	53                   	push   %ebx
80103e33:	e8 93 0b 00 00       	call   801049cb <swtch>
  mycpu()->intena = intena;
80103e38:	e8 c3 fb ff ff       	call   80103a00 <mycpu>
}
80103e3d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e40:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e46:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e49:	5b                   	pop    %ebx
80103e4a:	5e                   	pop    %esi
80103e4b:	5d                   	pop    %ebp
80103e4c:	c3                   	ret
    panic("sched ptable.lock");
80103e4d:	83 ec 0c             	sub    $0xc,%esp
80103e50:	68 11 75 10 80       	push   $0x80107511
80103e55:	e8 26 c5 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 3d 75 10 80       	push   $0x8010753d
80103e62:	e8 19 c5 ff ff       	call   80100380 <panic>
    panic("sched running");
80103e67:	83 ec 0c             	sub    $0xc,%esp
80103e6a:	68 2f 75 10 80       	push   $0x8010752f
80103e6f:	e8 0c c5 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103e74:	83 ec 0c             	sub    $0xc,%esp
80103e77:	68 23 75 10 80       	push   $0x80107523
80103e7c:	e8 ff c4 ff ff       	call   80100380 <panic>
80103e81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e88:	00 
80103e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e90 <exit>:
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	57                   	push   %edi
80103e94:	56                   	push   %esi
80103e95:	53                   	push   %ebx
80103e96:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103e99:	e8 e2 fb ff ff       	call   80103a80 <myproc>
  if(curproc == initproc)
80103e9e:	39 05 54 3c 11 80    	cmp    %eax,0x80113c54
80103ea4:	0f 84 fd 00 00 00    	je     80103fa7 <exit+0x117>
80103eaa:	89 c3                	mov    %eax,%ebx
80103eac:	8d 70 28             	lea    0x28(%eax),%esi
80103eaf:	8d 78 68             	lea    0x68(%eax),%edi
80103eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103eb8:	8b 06                	mov    (%esi),%eax
80103eba:	85 c0                	test   %eax,%eax
80103ebc:	74 12                	je     80103ed0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103ebe:	83 ec 0c             	sub    $0xc,%esp
80103ec1:	50                   	push   %eax
80103ec2:	e8 69 d1 ff ff       	call   80101030 <fileclose>
      curproc->ofile[fd] = 0;
80103ec7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103ecd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103ed0:	83 c6 04             	add    $0x4,%esi
80103ed3:	39 f7                	cmp    %esi,%edi
80103ed5:	75 e1                	jne    80103eb8 <exit+0x28>
  begin_op();
80103ed7:	e8 84 ef ff ff       	call   80102e60 <begin_op>
  iput(curproc->cwd);
80103edc:	83 ec 0c             	sub    $0xc,%esp
80103edf:	ff 73 68             	push   0x68(%ebx)
80103ee2:	e8 09 db ff ff       	call   801019f0 <iput>
  end_op();
80103ee7:	e8 e4 ef ff ff       	call   80102ed0 <end_op>
  curproc->cwd = 0;
80103eec:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103ef3:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103efa:	e8 c1 07 00 00       	call   801046c0 <acquire>
  wakeup1(curproc->parent);
80103eff:	8b 53 14             	mov    0x14(%ebx),%edx
80103f02:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f05:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103f0a:	eb 0e                	jmp    80103f1a <exit+0x8a>
80103f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f10:	83 c0 7c             	add    $0x7c,%eax
80103f13:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103f18:	74 1c                	je     80103f36 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80103f1a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f1e:	75 f0                	jne    80103f10 <exit+0x80>
80103f20:	3b 50 20             	cmp    0x20(%eax),%edx
80103f23:	75 eb                	jne    80103f10 <exit+0x80>
      p->state = RUNNABLE;
80103f25:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f2c:	83 c0 7c             	add    $0x7c,%eax
80103f2f:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103f34:	75 e4                	jne    80103f1a <exit+0x8a>
      p->parent = initproc;
80103f36:	8b 0d 54 3c 11 80    	mov    0x80113c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f3c:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
80103f41:	eb 10                	jmp    80103f53 <exit+0xc3>
80103f43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f48:	83 c2 7c             	add    $0x7c,%edx
80103f4b:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
80103f51:	74 3b                	je     80103f8e <exit+0xfe>
    if(p->parent == curproc){
80103f53:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103f56:	75 f0                	jne    80103f48 <exit+0xb8>
      if(p->state == ZOMBIE)
80103f58:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103f5c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f5f:	75 e7                	jne    80103f48 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f61:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103f66:	eb 12                	jmp    80103f7a <exit+0xea>
80103f68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f6f:	00 
80103f70:	83 c0 7c             	add    $0x7c,%eax
80103f73:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103f78:	74 ce                	je     80103f48 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80103f7a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f7e:	75 f0                	jne    80103f70 <exit+0xe0>
80103f80:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f83:	75 eb                	jne    80103f70 <exit+0xe0>
      p->state = RUNNABLE;
80103f85:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f8c:	eb e2                	jmp    80103f70 <exit+0xe0>
  curproc->state = ZOMBIE;
80103f8e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f95:	e8 36 fe ff ff       	call   80103dd0 <sched>
  panic("zombie exit");
80103f9a:	83 ec 0c             	sub    $0xc,%esp
80103f9d:	68 5e 75 10 80       	push   $0x8010755e
80103fa2:	e8 d9 c3 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103fa7:	83 ec 0c             	sub    $0xc,%esp
80103faa:	68 51 75 10 80       	push   $0x80107551
80103faf:	e8 cc c3 ff ff       	call   80100380 <panic>
80103fb4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fbb:	00 
80103fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103fc0 <wait>:
{
80103fc0:	55                   	push   %ebp
80103fc1:	89 e5                	mov    %esp,%ebp
80103fc3:	56                   	push   %esi
80103fc4:	53                   	push   %ebx
  pushcli();
80103fc5:	e8 a6 05 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103fca:	e8 31 fa ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103fcf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fd5:	e8 e6 05 00 00       	call   801045c0 <popcli>
  acquire(&ptable.lock);
80103fda:	83 ec 0c             	sub    $0xc,%esp
80103fdd:	68 20 1d 11 80       	push   $0x80111d20
80103fe2:	e8 d9 06 00 00       	call   801046c0 <acquire>
80103fe7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103fea:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fec:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
80103ff1:	eb 10                	jmp    80104003 <wait+0x43>
80103ff3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ff8:	83 c3 7c             	add    $0x7c,%ebx
80103ffb:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80104001:	74 1b                	je     8010401e <wait+0x5e>
      if(p->parent != curproc)
80104003:	39 73 14             	cmp    %esi,0x14(%ebx)
80104006:	75 f0                	jne    80103ff8 <wait+0x38>
      if(p->state == ZOMBIE){
80104008:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010400c:	74 62                	je     80104070 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010400e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104011:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104016:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
8010401c:	75 e5                	jne    80104003 <wait+0x43>
    if(!havekids || curproc->killed){
8010401e:	85 c0                	test   %eax,%eax
80104020:	0f 84 a0 00 00 00    	je     801040c6 <wait+0x106>
80104026:	8b 46 24             	mov    0x24(%esi),%eax
80104029:	85 c0                	test   %eax,%eax
8010402b:	0f 85 95 00 00 00    	jne    801040c6 <wait+0x106>
  pushcli();
80104031:	e8 3a 05 00 00       	call   80104570 <pushcli>
  c = mycpu();
80104036:	e8 c5 f9 ff ff       	call   80103a00 <mycpu>
  p = c->proc;
8010403b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104041:	e8 7a 05 00 00       	call   801045c0 <popcli>
  if(p == 0)
80104046:	85 db                	test   %ebx,%ebx
80104048:	0f 84 8f 00 00 00    	je     801040dd <wait+0x11d>
  p->chan = chan;
8010404e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104051:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104058:	e8 73 fd ff ff       	call   80103dd0 <sched>
  p->chan = 0;
8010405d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104064:	eb 84                	jmp    80103fea <wait+0x2a>
80104066:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010406d:	00 
8010406e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104070:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104073:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104076:	ff 73 08             	push   0x8(%ebx)
80104079:	e8 42 e5 ff ff       	call   801025c0 <kfree>
        p->kstack = 0;
8010407e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104085:	5a                   	pop    %edx
80104086:	ff 73 04             	push   0x4(%ebx)
80104089:	e8 32 2e 00 00       	call   80106ec0 <freevm>
        p->pid = 0;
8010408e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104095:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010409c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801040a0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801040a7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801040ae:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801040b5:	e8 a6 05 00 00       	call   80104660 <release>
        return pid;
801040ba:	83 c4 10             	add    $0x10,%esp
}
801040bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040c0:	89 f0                	mov    %esi,%eax
801040c2:	5b                   	pop    %ebx
801040c3:	5e                   	pop    %esi
801040c4:	5d                   	pop    %ebp
801040c5:	c3                   	ret
      release(&ptable.lock);
801040c6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801040c9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801040ce:	68 20 1d 11 80       	push   $0x80111d20
801040d3:	e8 88 05 00 00       	call   80104660 <release>
      return -1;
801040d8:	83 c4 10             	add    $0x10,%esp
801040db:	eb e0                	jmp    801040bd <wait+0xfd>
    panic("sleep");
801040dd:	83 ec 0c             	sub    $0xc,%esp
801040e0:	68 6a 75 10 80       	push   $0x8010756a
801040e5:	e8 96 c2 ff ff       	call   80100380 <panic>
801040ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040f0 <yield>:
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	53                   	push   %ebx
801040f4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801040f7:	68 20 1d 11 80       	push   $0x80111d20
801040fc:	e8 bf 05 00 00       	call   801046c0 <acquire>
  pushcli();
80104101:	e8 6a 04 00 00       	call   80104570 <pushcli>
  c = mycpu();
80104106:	e8 f5 f8 ff ff       	call   80103a00 <mycpu>
  p = c->proc;
8010410b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104111:	e8 aa 04 00 00       	call   801045c0 <popcli>
  myproc()->state = RUNNABLE;
80104116:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010411d:	e8 ae fc ff ff       	call   80103dd0 <sched>
  release(&ptable.lock);
80104122:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80104129:	e8 32 05 00 00       	call   80104660 <release>
}
8010412e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104131:	83 c4 10             	add    $0x10,%esp
80104134:	c9                   	leave
80104135:	c3                   	ret
80104136:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010413d:	00 
8010413e:	66 90                	xchg   %ax,%ax

80104140 <sleep>:
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	57                   	push   %edi
80104144:	56                   	push   %esi
80104145:	53                   	push   %ebx
80104146:	83 ec 0c             	sub    $0xc,%esp
80104149:	8b 7d 08             	mov    0x8(%ebp),%edi
8010414c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010414f:	e8 1c 04 00 00       	call   80104570 <pushcli>
  c = mycpu();
80104154:	e8 a7 f8 ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80104159:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010415f:	e8 5c 04 00 00       	call   801045c0 <popcli>
  if(p == 0)
80104164:	85 db                	test   %ebx,%ebx
80104166:	0f 84 87 00 00 00    	je     801041f3 <sleep+0xb3>
  if(lk == 0)
8010416c:	85 f6                	test   %esi,%esi
8010416e:	74 76                	je     801041e6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104170:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
80104176:	74 50                	je     801041c8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104178:	83 ec 0c             	sub    $0xc,%esp
8010417b:	68 20 1d 11 80       	push   $0x80111d20
80104180:	e8 3b 05 00 00       	call   801046c0 <acquire>
    release(lk);
80104185:	89 34 24             	mov    %esi,(%esp)
80104188:	e8 d3 04 00 00       	call   80104660 <release>
  p->chan = chan;
8010418d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104190:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104197:	e8 34 fc ff ff       	call   80103dd0 <sched>
  p->chan = 0;
8010419c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801041a3:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801041aa:	e8 b1 04 00 00       	call   80104660 <release>
    acquire(lk);
801041af:	83 c4 10             	add    $0x10,%esp
801041b2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801041b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041b8:	5b                   	pop    %ebx
801041b9:	5e                   	pop    %esi
801041ba:	5f                   	pop    %edi
801041bb:	5d                   	pop    %ebp
    acquire(lk);
801041bc:	e9 ff 04 00 00       	jmp    801046c0 <acquire>
801041c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801041c8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801041cb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801041d2:	e8 f9 fb ff ff       	call   80103dd0 <sched>
  p->chan = 0;
801041d7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801041de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041e1:	5b                   	pop    %ebx
801041e2:	5e                   	pop    %esi
801041e3:	5f                   	pop    %edi
801041e4:	5d                   	pop    %ebp
801041e5:	c3                   	ret
    panic("sleep without lk");
801041e6:	83 ec 0c             	sub    $0xc,%esp
801041e9:	68 70 75 10 80       	push   $0x80107570
801041ee:	e8 8d c1 ff ff       	call   80100380 <panic>
    panic("sleep");
801041f3:	83 ec 0c             	sub    $0xc,%esp
801041f6:	68 6a 75 10 80       	push   $0x8010756a
801041fb:	e8 80 c1 ff ff       	call   80100380 <panic>

80104200 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	53                   	push   %ebx
80104204:	83 ec 10             	sub    $0x10,%esp
80104207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010420a:	68 20 1d 11 80       	push   $0x80111d20
8010420f:	e8 ac 04 00 00       	call   801046c0 <acquire>
80104214:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104217:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010421c:	eb 0c                	jmp    8010422a <wakeup+0x2a>
8010421e:	66 90                	xchg   %ax,%ax
80104220:	83 c0 7c             	add    $0x7c,%eax
80104223:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104228:	74 1c                	je     80104246 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010422a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010422e:	75 f0                	jne    80104220 <wakeup+0x20>
80104230:	3b 58 20             	cmp    0x20(%eax),%ebx
80104233:	75 eb                	jne    80104220 <wakeup+0x20>
      p->state = RUNNABLE;
80104235:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010423c:	83 c0 7c             	add    $0x7c,%eax
8010423f:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104244:	75 e4                	jne    8010422a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104246:	c7 45 08 20 1d 11 80 	movl   $0x80111d20,0x8(%ebp)
}
8010424d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104250:	c9                   	leave
  release(&ptable.lock);
80104251:	e9 0a 04 00 00       	jmp    80104660 <release>
80104256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010425d:	00 
8010425e:	66 90                	xchg   %ax,%ax

80104260 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	53                   	push   %ebx
80104264:	83 ec 10             	sub    $0x10,%esp
80104267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010426a:	68 20 1d 11 80       	push   $0x80111d20
8010426f:	e8 4c 04 00 00       	call   801046c0 <acquire>
80104274:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104277:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010427c:	eb 0c                	jmp    8010428a <kill+0x2a>
8010427e:	66 90                	xchg   %ax,%ax
80104280:	83 c0 7c             	add    $0x7c,%eax
80104283:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104288:	74 36                	je     801042c0 <kill+0x60>
    if(p->pid == pid){
8010428a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010428d:	75 f1                	jne    80104280 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010428f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104293:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010429a:	75 07                	jne    801042a3 <kill+0x43>
        p->state = RUNNABLE;
8010429c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801042a3:	83 ec 0c             	sub    $0xc,%esp
801042a6:	68 20 1d 11 80       	push   $0x80111d20
801042ab:	e8 b0 03 00 00       	call   80104660 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801042b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801042b3:	83 c4 10             	add    $0x10,%esp
801042b6:	31 c0                	xor    %eax,%eax
}
801042b8:	c9                   	leave
801042b9:	c3                   	ret
801042ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801042c0:	83 ec 0c             	sub    $0xc,%esp
801042c3:	68 20 1d 11 80       	push   $0x80111d20
801042c8:	e8 93 03 00 00       	call   80104660 <release>
}
801042cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801042d0:	83 c4 10             	add    $0x10,%esp
801042d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801042d8:	c9                   	leave
801042d9:	c3                   	ret
801042da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	57                   	push   %edi
801042e4:	56                   	push   %esi
801042e5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801042e8:	53                   	push   %ebx
801042e9:	bb c0 1d 11 80       	mov    $0x80111dc0,%ebx
801042ee:	83 ec 3c             	sub    $0x3c,%esp
801042f1:	eb 24                	jmp    80104317 <procdump+0x37>
801042f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801042f8:	83 ec 0c             	sub    $0xc,%esp
801042fb:	68 2f 77 10 80       	push   $0x8010772f
80104300:	e8 ab c3 ff ff       	call   801006b0 <cprintf>
80104305:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104308:	83 c3 7c             	add    $0x7c,%ebx
8010430b:	81 fb c0 3c 11 80    	cmp    $0x80113cc0,%ebx
80104311:	0f 84 81 00 00 00    	je     80104398 <procdump+0xb8>
    if(p->state == UNUSED)
80104317:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010431a:	85 c0                	test   %eax,%eax
8010431c:	74 ea                	je     80104308 <procdump+0x28>
      state = "???";
8010431e:	ba 81 75 10 80       	mov    $0x80107581,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104323:	83 f8 05             	cmp    $0x5,%eax
80104326:	77 11                	ja     80104339 <procdump+0x59>
80104328:	8b 14 85 a0 7b 10 80 	mov    -0x7fef8460(,%eax,4),%edx
      state = "???";
8010432f:	b8 81 75 10 80       	mov    $0x80107581,%eax
80104334:	85 d2                	test   %edx,%edx
80104336:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104339:	53                   	push   %ebx
8010433a:	52                   	push   %edx
8010433b:	ff 73 a4             	push   -0x5c(%ebx)
8010433e:	68 85 75 10 80       	push   $0x80107585
80104343:	e8 68 c3 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104348:	83 c4 10             	add    $0x10,%esp
8010434b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010434f:	75 a7                	jne    801042f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104351:	83 ec 08             	sub    $0x8,%esp
80104354:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104357:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010435a:	50                   	push   %eax
8010435b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010435e:	8b 40 0c             	mov    0xc(%eax),%eax
80104361:	83 c0 08             	add    $0x8,%eax
80104364:	50                   	push   %eax
80104365:	e8 86 01 00 00       	call   801044f0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010436a:	83 c4 10             	add    $0x10,%esp
8010436d:	8d 76 00             	lea    0x0(%esi),%esi
80104370:	8b 17                	mov    (%edi),%edx
80104372:	85 d2                	test   %edx,%edx
80104374:	74 82                	je     801042f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104376:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104379:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010437c:	52                   	push   %edx
8010437d:	68 c1 72 10 80       	push   $0x801072c1
80104382:	e8 29 c3 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104387:	83 c4 10             	add    $0x10,%esp
8010438a:	39 f7                	cmp    %esi,%edi
8010438c:	75 e2                	jne    80104370 <procdump+0x90>
8010438e:	e9 65 ff ff ff       	jmp    801042f8 <procdump+0x18>
80104393:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104398:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010439b:	5b                   	pop    %ebx
8010439c:	5e                   	pop    %esi
8010439d:	5f                   	pop    %edi
8010439e:	5d                   	pop    %ebp
8010439f:	c3                   	ret

801043a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	53                   	push   %ebx
801043a4:	83 ec 0c             	sub    $0xc,%esp
801043a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801043aa:	68 b8 75 10 80       	push   $0x801075b8
801043af:	8d 43 04             	lea    0x4(%ebx),%eax
801043b2:	50                   	push   %eax
801043b3:	e8 18 01 00 00       	call   801044d0 <initlock>
  lk->name = name;
801043b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801043bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801043c1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801043c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801043cb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801043ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043d1:	c9                   	leave
801043d2:	c3                   	ret
801043d3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043da:	00 
801043db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801043e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
801043e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043e8:	8d 73 04             	lea    0x4(%ebx),%esi
801043eb:	83 ec 0c             	sub    $0xc,%esp
801043ee:	56                   	push   %esi
801043ef:	e8 cc 02 00 00       	call   801046c0 <acquire>
  while (lk->locked) {
801043f4:	8b 13                	mov    (%ebx),%edx
801043f6:	83 c4 10             	add    $0x10,%esp
801043f9:	85 d2                	test   %edx,%edx
801043fb:	74 16                	je     80104413 <acquiresleep+0x33>
801043fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104400:	83 ec 08             	sub    $0x8,%esp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	e8 36 fd ff ff       	call   80104140 <sleep>
  while (lk->locked) {
8010440a:	8b 03                	mov    (%ebx),%eax
8010440c:	83 c4 10             	add    $0x10,%esp
8010440f:	85 c0                	test   %eax,%eax
80104411:	75 ed                	jne    80104400 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104413:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104419:	e8 62 f6 ff ff       	call   80103a80 <myproc>
8010441e:	8b 40 10             	mov    0x10(%eax),%eax
80104421:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104424:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104427:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010442a:	5b                   	pop    %ebx
8010442b:	5e                   	pop    %esi
8010442c:	5d                   	pop    %ebp
  release(&lk->lk);
8010442d:	e9 2e 02 00 00       	jmp    80104660 <release>
80104432:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104439:	00 
8010443a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104440 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	56                   	push   %esi
80104444:	53                   	push   %ebx
80104445:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104448:	8d 73 04             	lea    0x4(%ebx),%esi
8010444b:	83 ec 0c             	sub    $0xc,%esp
8010444e:	56                   	push   %esi
8010444f:	e8 6c 02 00 00       	call   801046c0 <acquire>
  lk->locked = 0;
80104454:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010445a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104461:	89 1c 24             	mov    %ebx,(%esp)
80104464:	e8 97 fd ff ff       	call   80104200 <wakeup>
  release(&lk->lk);
80104469:	83 c4 10             	add    $0x10,%esp
8010446c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010446f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104472:	5b                   	pop    %ebx
80104473:	5e                   	pop    %esi
80104474:	5d                   	pop    %ebp
  release(&lk->lk);
80104475:	e9 e6 01 00 00       	jmp    80104660 <release>
8010447a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104480 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	57                   	push   %edi
80104484:	31 ff                	xor    %edi,%edi
80104486:	56                   	push   %esi
80104487:	53                   	push   %ebx
80104488:	83 ec 18             	sub    $0x18,%esp
8010448b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010448e:	8d 73 04             	lea    0x4(%ebx),%esi
80104491:	56                   	push   %esi
80104492:	e8 29 02 00 00       	call   801046c0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104497:	8b 03                	mov    (%ebx),%eax
80104499:	83 c4 10             	add    $0x10,%esp
8010449c:	85 c0                	test   %eax,%eax
8010449e:	75 18                	jne    801044b8 <holdingsleep+0x38>
  release(&lk->lk);
801044a0:	83 ec 0c             	sub    $0xc,%esp
801044a3:	56                   	push   %esi
801044a4:	e8 b7 01 00 00       	call   80104660 <release>
  return r;
}
801044a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044ac:	89 f8                	mov    %edi,%eax
801044ae:	5b                   	pop    %ebx
801044af:	5e                   	pop    %esi
801044b0:	5f                   	pop    %edi
801044b1:	5d                   	pop    %ebp
801044b2:	c3                   	ret
801044b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
801044b8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801044bb:	e8 c0 f5 ff ff       	call   80103a80 <myproc>
801044c0:	39 58 10             	cmp    %ebx,0x10(%eax)
801044c3:	0f 94 c0             	sete   %al
801044c6:	0f b6 c0             	movzbl %al,%eax
801044c9:	89 c7                	mov    %eax,%edi
801044cb:	eb d3                	jmp    801044a0 <holdingsleep+0x20>
801044cd:	66 90                	xchg   %ax,%ax
801044cf:	90                   	nop

801044d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801044d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801044d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801044df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801044e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801044e9:	5d                   	pop    %ebp
801044ea:	c3                   	ret
801044eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801044f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	53                   	push   %ebx
801044f4:	8b 45 08             	mov    0x8(%ebp),%eax
801044f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044fa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044fd:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104502:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104507:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010450c:	76 10                	jbe    8010451e <getcallerpcs+0x2e>
8010450e:	eb 28                	jmp    80104538 <getcallerpcs+0x48>
80104510:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104516:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010451c:	77 1a                	ja     80104538 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010451e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104521:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104524:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104527:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104529:	83 f8 0a             	cmp    $0xa,%eax
8010452c:	75 e2                	jne    80104510 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010452e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104531:	c9                   	leave
80104532:	c3                   	ret
80104533:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104538:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010453b:	83 c1 28             	add    $0x28,%ecx
8010453e:	89 ca                	mov    %ecx,%edx
80104540:	29 c2                	sub    %eax,%edx
80104542:	83 e2 04             	and    $0x4,%edx
80104545:	74 11                	je     80104558 <getcallerpcs+0x68>
    pcs[i] = 0;
80104547:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010454d:	83 c0 04             	add    $0x4,%eax
80104550:	39 c1                	cmp    %eax,%ecx
80104552:	74 da                	je     8010452e <getcallerpcs+0x3e>
80104554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104558:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010455e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104561:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104568:	39 c1                	cmp    %eax,%ecx
8010456a:	75 ec                	jne    80104558 <getcallerpcs+0x68>
8010456c:	eb c0                	jmp    8010452e <getcallerpcs+0x3e>
8010456e:	66 90                	xchg   %ax,%ax

80104570 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	53                   	push   %ebx
80104574:	83 ec 04             	sub    $0x4,%esp
80104577:	9c                   	pushf
80104578:	5b                   	pop    %ebx
  asm volatile("cli");
80104579:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010457a:	e8 81 f4 ff ff       	call   80103a00 <mycpu>
8010457f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104585:	85 c0                	test   %eax,%eax
80104587:	74 17                	je     801045a0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104589:	e8 72 f4 ff ff       	call   80103a00 <mycpu>
8010458e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104595:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104598:	c9                   	leave
80104599:	c3                   	ret
8010459a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
801045a0:	e8 5b f4 ff ff       	call   80103a00 <mycpu>
801045a5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801045ab:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801045b1:	eb d6                	jmp    80104589 <pushcli+0x19>
801045b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045ba:	00 
801045bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801045c0 <popcli>:

void
popcli(void)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045c6:	9c                   	pushf
801045c7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045c8:	f6 c4 02             	test   $0x2,%ah
801045cb:	75 35                	jne    80104602 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801045cd:	e8 2e f4 ff ff       	call   80103a00 <mycpu>
801045d2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801045d9:	78 34                	js     8010460f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045db:	e8 20 f4 ff ff       	call   80103a00 <mycpu>
801045e0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801045e6:	85 d2                	test   %edx,%edx
801045e8:	74 06                	je     801045f0 <popcli+0x30>
    sti();
}
801045ea:	c9                   	leave
801045eb:	c3                   	ret
801045ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045f0:	e8 0b f4 ff ff       	call   80103a00 <mycpu>
801045f5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801045fb:	85 c0                	test   %eax,%eax
801045fd:	74 eb                	je     801045ea <popcli+0x2a>
  asm volatile("sti");
801045ff:	fb                   	sti
}
80104600:	c9                   	leave
80104601:	c3                   	ret
    panic("popcli - interruptible");
80104602:	83 ec 0c             	sub    $0xc,%esp
80104605:	68 c3 75 10 80       	push   $0x801075c3
8010460a:	e8 71 bd ff ff       	call   80100380 <panic>
    panic("popcli");
8010460f:	83 ec 0c             	sub    $0xc,%esp
80104612:	68 da 75 10 80       	push   $0x801075da
80104617:	e8 64 bd ff ff       	call   80100380 <panic>
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104620 <holding>:
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	56                   	push   %esi
80104624:	53                   	push   %ebx
80104625:	8b 75 08             	mov    0x8(%ebp),%esi
80104628:	31 db                	xor    %ebx,%ebx
  pushcli();
8010462a:	e8 41 ff ff ff       	call   80104570 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010462f:	8b 06                	mov    (%esi),%eax
80104631:	85 c0                	test   %eax,%eax
80104633:	75 0b                	jne    80104640 <holding+0x20>
  popcli();
80104635:	e8 86 ff ff ff       	call   801045c0 <popcli>
}
8010463a:	89 d8                	mov    %ebx,%eax
8010463c:	5b                   	pop    %ebx
8010463d:	5e                   	pop    %esi
8010463e:	5d                   	pop    %ebp
8010463f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80104640:	8b 5e 08             	mov    0x8(%esi),%ebx
80104643:	e8 b8 f3 ff ff       	call   80103a00 <mycpu>
80104648:	39 c3                	cmp    %eax,%ebx
8010464a:	0f 94 c3             	sete   %bl
  popcli();
8010464d:	e8 6e ff ff ff       	call   801045c0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104652:	0f b6 db             	movzbl %bl,%ebx
}
80104655:	89 d8                	mov    %ebx,%eax
80104657:	5b                   	pop    %ebx
80104658:	5e                   	pop    %esi
80104659:	5d                   	pop    %ebp
8010465a:	c3                   	ret
8010465b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104660 <release>:
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	56                   	push   %esi
80104664:	53                   	push   %ebx
80104665:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104668:	e8 03 ff ff ff       	call   80104570 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010466d:	8b 03                	mov    (%ebx),%eax
8010466f:	85 c0                	test   %eax,%eax
80104671:	75 15                	jne    80104688 <release+0x28>
  popcli();
80104673:	e8 48 ff ff ff       	call   801045c0 <popcli>
    panic("release");
80104678:	83 ec 0c             	sub    $0xc,%esp
8010467b:	68 e1 75 10 80       	push   $0x801075e1
80104680:	e8 fb bc ff ff       	call   80100380 <panic>
80104685:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104688:	8b 73 08             	mov    0x8(%ebx),%esi
8010468b:	e8 70 f3 ff ff       	call   80103a00 <mycpu>
80104690:	39 c6                	cmp    %eax,%esi
80104692:	75 df                	jne    80104673 <release+0x13>
  popcli();
80104694:	e8 27 ff ff ff       	call   801045c0 <popcli>
  lk->pcs[0] = 0;
80104699:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801046a0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801046a7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801046ac:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801046b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046b5:	5b                   	pop    %ebx
801046b6:	5e                   	pop    %esi
801046b7:	5d                   	pop    %ebp
  popcli();
801046b8:	e9 03 ff ff ff       	jmp    801045c0 <popcli>
801046bd:	8d 76 00             	lea    0x0(%esi),%esi

801046c0 <acquire>:
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	53                   	push   %ebx
801046c4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801046c7:	e8 a4 fe ff ff       	call   80104570 <pushcli>
  if(holding(lk))
801046cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801046cf:	e8 9c fe ff ff       	call   80104570 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801046d4:	8b 03                	mov    (%ebx),%eax
801046d6:	85 c0                	test   %eax,%eax
801046d8:	0f 85 b2 00 00 00    	jne    80104790 <acquire+0xd0>
  popcli();
801046de:	e8 dd fe ff ff       	call   801045c0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801046e3:	b9 01 00 00 00       	mov    $0x1,%ecx
801046e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046ef:	00 
  while(xchg(&lk->locked, 1) != 0)
801046f0:	8b 55 08             	mov    0x8(%ebp),%edx
801046f3:	89 c8                	mov    %ecx,%eax
801046f5:	f0 87 02             	lock xchg %eax,(%edx)
801046f8:	85 c0                	test   %eax,%eax
801046fa:	75 f4                	jne    801046f0 <acquire+0x30>
  __sync_synchronize();
801046fc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104701:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104704:	e8 f7 f2 ff ff       	call   80103a00 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104709:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
8010470c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
8010470e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104711:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80104717:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010471c:	77 32                	ja     80104750 <acquire+0x90>
  ebp = (uint*)v - 2;
8010471e:	89 e8                	mov    %ebp,%eax
80104720:	eb 14                	jmp    80104736 <acquire+0x76>
80104722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104728:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010472e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104734:	77 1a                	ja     80104750 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80104736:	8b 58 04             	mov    0x4(%eax),%ebx
80104739:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010473d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104740:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104742:	83 fa 0a             	cmp    $0xa,%edx
80104745:	75 e1                	jne    80104728 <acquire+0x68>
}
80104747:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010474a:	c9                   	leave
8010474b:	c3                   	ret
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104750:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80104754:	83 c1 34             	add    $0x34,%ecx
80104757:	89 ca                	mov    %ecx,%edx
80104759:	29 c2                	sub    %eax,%edx
8010475b:	83 e2 04             	and    $0x4,%edx
8010475e:	74 10                	je     80104770 <acquire+0xb0>
    pcs[i] = 0;
80104760:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104766:	83 c0 04             	add    $0x4,%eax
80104769:	39 c1                	cmp    %eax,%ecx
8010476b:	74 da                	je     80104747 <acquire+0x87>
8010476d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104770:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104776:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104779:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104780:	39 c1                	cmp    %eax,%ecx
80104782:	75 ec                	jne    80104770 <acquire+0xb0>
80104784:	eb c1                	jmp    80104747 <acquire+0x87>
80104786:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010478d:	00 
8010478e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80104790:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104793:	e8 68 f2 ff ff       	call   80103a00 <mycpu>
80104798:	39 c3                	cmp    %eax,%ebx
8010479a:	0f 85 3e ff ff ff    	jne    801046de <acquire+0x1e>
  popcli();
801047a0:	e8 1b fe ff ff       	call   801045c0 <popcli>
    panic("acquire");
801047a5:	83 ec 0c             	sub    $0xc,%esp
801047a8:	68 e9 75 10 80       	push   $0x801075e9
801047ad:	e8 ce bb ff ff       	call   80100380 <panic>
801047b2:	66 90                	xchg   %ax,%ax
801047b4:	66 90                	xchg   %ax,%ax
801047b6:	66 90                	xchg   %ax,%ax
801047b8:	66 90                	xchg   %ax,%ax
801047ba:	66 90                	xchg   %ax,%ax
801047bc:	66 90                	xchg   %ax,%ax
801047be:	66 90                	xchg   %ax,%ax

801047c0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	57                   	push   %edi
801047c4:	8b 55 08             	mov    0x8(%ebp),%edx
801047c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801047ca:	89 d0                	mov    %edx,%eax
801047cc:	09 c8                	or     %ecx,%eax
801047ce:	a8 03                	test   $0x3,%al
801047d0:	75 1e                	jne    801047f0 <memset+0x30>
    c &= 0xFF;
801047d2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801047d6:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
801047d9:	89 d7                	mov    %edx,%edi
801047db:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
801047e1:	fc                   	cld
801047e2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801047e4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801047e7:	89 d0                	mov    %edx,%eax
801047e9:	c9                   	leave
801047ea:	c3                   	ret
801047eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801047f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801047f3:	89 d7                	mov    %edx,%edi
801047f5:	fc                   	cld
801047f6:	f3 aa                	rep stos %al,%es:(%edi)
801047f8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801047fb:	89 d0                	mov    %edx,%eax
801047fd:	c9                   	leave
801047fe:	c3                   	ret
801047ff:	90                   	nop

80104800 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	56                   	push   %esi
80104804:	8b 75 10             	mov    0x10(%ebp),%esi
80104807:	8b 45 08             	mov    0x8(%ebp),%eax
8010480a:	53                   	push   %ebx
8010480b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010480e:	85 f6                	test   %esi,%esi
80104810:	74 2e                	je     80104840 <memcmp+0x40>
80104812:	01 c6                	add    %eax,%esi
80104814:	eb 14                	jmp    8010482a <memcmp+0x2a>
80104816:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010481d:	00 
8010481e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104820:	83 c0 01             	add    $0x1,%eax
80104823:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104826:	39 f0                	cmp    %esi,%eax
80104828:	74 16                	je     80104840 <memcmp+0x40>
    if(*s1 != *s2)
8010482a:	0f b6 08             	movzbl (%eax),%ecx
8010482d:	0f b6 1a             	movzbl (%edx),%ebx
80104830:	38 d9                	cmp    %bl,%cl
80104832:	74 ec                	je     80104820 <memcmp+0x20>
      return *s1 - *s2;
80104834:	0f b6 c1             	movzbl %cl,%eax
80104837:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104839:	5b                   	pop    %ebx
8010483a:	5e                   	pop    %esi
8010483b:	5d                   	pop    %ebp
8010483c:	c3                   	ret
8010483d:	8d 76 00             	lea    0x0(%esi),%esi
80104840:	5b                   	pop    %ebx
  return 0;
80104841:	31 c0                	xor    %eax,%eax
}
80104843:	5e                   	pop    %esi
80104844:	5d                   	pop    %ebp
80104845:	c3                   	ret
80104846:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010484d:	00 
8010484e:	66 90                	xchg   %ax,%ax

80104850 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	57                   	push   %edi
80104854:	8b 55 08             	mov    0x8(%ebp),%edx
80104857:	8b 45 10             	mov    0x10(%ebp),%eax
8010485a:	56                   	push   %esi
8010485b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010485e:	39 d6                	cmp    %edx,%esi
80104860:	73 26                	jae    80104888 <memmove+0x38>
80104862:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104865:	39 ca                	cmp    %ecx,%edx
80104867:	73 1f                	jae    80104888 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104869:	85 c0                	test   %eax,%eax
8010486b:	74 0f                	je     8010487c <memmove+0x2c>
8010486d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104870:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104874:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104877:	83 e8 01             	sub    $0x1,%eax
8010487a:	73 f4                	jae    80104870 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010487c:	5e                   	pop    %esi
8010487d:	89 d0                	mov    %edx,%eax
8010487f:	5f                   	pop    %edi
80104880:	5d                   	pop    %ebp
80104881:	c3                   	ret
80104882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104888:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010488b:	89 d7                	mov    %edx,%edi
8010488d:	85 c0                	test   %eax,%eax
8010488f:	74 eb                	je     8010487c <memmove+0x2c>
80104891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104898:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104899:	39 ce                	cmp    %ecx,%esi
8010489b:	75 fb                	jne    80104898 <memmove+0x48>
}
8010489d:	5e                   	pop    %esi
8010489e:	89 d0                	mov    %edx,%eax
801048a0:	5f                   	pop    %edi
801048a1:	5d                   	pop    %ebp
801048a2:	c3                   	ret
801048a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048aa:	00 
801048ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801048b0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801048b0:	eb 9e                	jmp    80104850 <memmove>
801048b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048b9:	00 
801048ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801048c0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	53                   	push   %ebx
801048c4:	8b 55 10             	mov    0x10(%ebp),%edx
801048c7:	8b 45 08             	mov    0x8(%ebp),%eax
801048ca:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
801048cd:	85 d2                	test   %edx,%edx
801048cf:	75 16                	jne    801048e7 <strncmp+0x27>
801048d1:	eb 2d                	jmp    80104900 <strncmp+0x40>
801048d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801048d8:	3a 19                	cmp    (%ecx),%bl
801048da:	75 12                	jne    801048ee <strncmp+0x2e>
    n--, p++, q++;
801048dc:	83 c0 01             	add    $0x1,%eax
801048df:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801048e2:	83 ea 01             	sub    $0x1,%edx
801048e5:	74 19                	je     80104900 <strncmp+0x40>
801048e7:	0f b6 18             	movzbl (%eax),%ebx
801048ea:	84 db                	test   %bl,%bl
801048ec:	75 ea                	jne    801048d8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801048ee:	0f b6 00             	movzbl (%eax),%eax
801048f1:	0f b6 11             	movzbl (%ecx),%edx
}
801048f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048f7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
801048f8:	29 d0                	sub    %edx,%eax
}
801048fa:	c3                   	ret
801048fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104900:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104903:	31 c0                	xor    %eax,%eax
}
80104905:	c9                   	leave
80104906:	c3                   	ret
80104907:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010490e:	00 
8010490f:	90                   	nop

80104910 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	57                   	push   %edi
80104914:	56                   	push   %esi
80104915:	8b 75 08             	mov    0x8(%ebp),%esi
80104918:	53                   	push   %ebx
80104919:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010491c:	89 f0                	mov    %esi,%eax
8010491e:	eb 15                	jmp    80104935 <strncpy+0x25>
80104920:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104924:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104927:	83 c0 01             	add    $0x1,%eax
8010492a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
8010492e:	88 48 ff             	mov    %cl,-0x1(%eax)
80104931:	84 c9                	test   %cl,%cl
80104933:	74 13                	je     80104948 <strncpy+0x38>
80104935:	89 d3                	mov    %edx,%ebx
80104937:	83 ea 01             	sub    $0x1,%edx
8010493a:	85 db                	test   %ebx,%ebx
8010493c:	7f e2                	jg     80104920 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
8010493e:	5b                   	pop    %ebx
8010493f:	89 f0                	mov    %esi,%eax
80104941:	5e                   	pop    %esi
80104942:	5f                   	pop    %edi
80104943:	5d                   	pop    %ebp
80104944:	c3                   	ret
80104945:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104948:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
8010494b:	83 e9 01             	sub    $0x1,%ecx
8010494e:	85 d2                	test   %edx,%edx
80104950:	74 ec                	je     8010493e <strncpy+0x2e>
80104952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104958:	83 c0 01             	add    $0x1,%eax
8010495b:	89 ca                	mov    %ecx,%edx
8010495d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104961:	29 c2                	sub    %eax,%edx
80104963:	85 d2                	test   %edx,%edx
80104965:	7f f1                	jg     80104958 <strncpy+0x48>
}
80104967:	5b                   	pop    %ebx
80104968:	89 f0                	mov    %esi,%eax
8010496a:	5e                   	pop    %esi
8010496b:	5f                   	pop    %edi
8010496c:	5d                   	pop    %ebp
8010496d:	c3                   	ret
8010496e:	66 90                	xchg   %ax,%ax

80104970 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	8b 55 10             	mov    0x10(%ebp),%edx
80104977:	8b 75 08             	mov    0x8(%ebp),%esi
8010497a:	53                   	push   %ebx
8010497b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010497e:	85 d2                	test   %edx,%edx
80104980:	7e 25                	jle    801049a7 <safestrcpy+0x37>
80104982:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104986:	89 f2                	mov    %esi,%edx
80104988:	eb 16                	jmp    801049a0 <safestrcpy+0x30>
8010498a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104990:	0f b6 08             	movzbl (%eax),%ecx
80104993:	83 c0 01             	add    $0x1,%eax
80104996:	83 c2 01             	add    $0x1,%edx
80104999:	88 4a ff             	mov    %cl,-0x1(%edx)
8010499c:	84 c9                	test   %cl,%cl
8010499e:	74 04                	je     801049a4 <safestrcpy+0x34>
801049a0:	39 d8                	cmp    %ebx,%eax
801049a2:	75 ec                	jne    80104990 <safestrcpy+0x20>
    ;
  *s = 0;
801049a4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801049a7:	89 f0                	mov    %esi,%eax
801049a9:	5b                   	pop    %ebx
801049aa:	5e                   	pop    %esi
801049ab:	5d                   	pop    %ebp
801049ac:	c3                   	ret
801049ad:	8d 76 00             	lea    0x0(%esi),%esi

801049b0 <strlen>:

int
strlen(const char *s)
{
801049b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801049b1:	31 c0                	xor    %eax,%eax
{
801049b3:	89 e5                	mov    %esp,%ebp
801049b5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801049b8:	80 3a 00             	cmpb   $0x0,(%edx)
801049bb:	74 0c                	je     801049c9 <strlen+0x19>
801049bd:	8d 76 00             	lea    0x0(%esi),%esi
801049c0:	83 c0 01             	add    $0x1,%eax
801049c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801049c7:	75 f7                	jne    801049c0 <strlen+0x10>
    ;
  return n;
}
801049c9:	5d                   	pop    %ebp
801049ca:	c3                   	ret

801049cb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801049cb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801049cf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801049d3:	55                   	push   %ebp
  pushl %ebx
801049d4:	53                   	push   %ebx
  pushl %esi
801049d5:	56                   	push   %esi
  pushl %edi
801049d6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801049d7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801049d9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801049db:	5f                   	pop    %edi
  popl %esi
801049dc:	5e                   	pop    %esi
  popl %ebx
801049dd:	5b                   	pop    %ebx
  popl %ebp
801049de:	5d                   	pop    %ebp
  ret
801049df:	c3                   	ret

801049e0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	53                   	push   %ebx
801049e4:	83 ec 04             	sub    $0x4,%esp
801049e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801049ea:	e8 91 f0 ff ff       	call   80103a80 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049ef:	8b 00                	mov    (%eax),%eax
801049f1:	39 c3                	cmp    %eax,%ebx
801049f3:	73 1b                	jae    80104a10 <fetchint+0x30>
801049f5:	8d 53 04             	lea    0x4(%ebx),%edx
801049f8:	39 d0                	cmp    %edx,%eax
801049fa:	72 14                	jb     80104a10 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801049fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801049ff:	8b 13                	mov    (%ebx),%edx
80104a01:	89 10                	mov    %edx,(%eax)
  return 0;
80104a03:	31 c0                	xor    %eax,%eax
}
80104a05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a08:	c9                   	leave
80104a09:	c3                   	ret
80104a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a15:	eb ee                	jmp    80104a05 <fetchint+0x25>
80104a17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a1e:	00 
80104a1f:	90                   	nop

80104a20 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	53                   	push   %ebx
80104a24:	83 ec 04             	sub    $0x4,%esp
80104a27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104a2a:	e8 51 f0 ff ff       	call   80103a80 <myproc>

  if(addr >= curproc->sz)
80104a2f:	3b 18                	cmp    (%eax),%ebx
80104a31:	73 2d                	jae    80104a60 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104a33:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a36:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104a38:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104a3a:	39 d3                	cmp    %edx,%ebx
80104a3c:	73 22                	jae    80104a60 <fetchstr+0x40>
80104a3e:	89 d8                	mov    %ebx,%eax
80104a40:	eb 0d                	jmp    80104a4f <fetchstr+0x2f>
80104a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a48:	83 c0 01             	add    $0x1,%eax
80104a4b:	39 d0                	cmp    %edx,%eax
80104a4d:	73 11                	jae    80104a60 <fetchstr+0x40>
    if(*s == 0)
80104a4f:	80 38 00             	cmpb   $0x0,(%eax)
80104a52:	75 f4                	jne    80104a48 <fetchstr+0x28>
      return s - *pp;
80104a54:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104a56:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a59:	c9                   	leave
80104a5a:	c3                   	ret
80104a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104a63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a68:	c9                   	leave
80104a69:	c3                   	ret
80104a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a70 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	56                   	push   %esi
80104a74:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a75:	e8 06 f0 ff ff       	call   80103a80 <myproc>
80104a7a:	8b 55 08             	mov    0x8(%ebp),%edx
80104a7d:	8b 40 18             	mov    0x18(%eax),%eax
80104a80:	8b 40 44             	mov    0x44(%eax),%eax
80104a83:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a86:	e8 f5 ef ff ff       	call   80103a80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a8b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a8e:	8b 00                	mov    (%eax),%eax
80104a90:	39 c6                	cmp    %eax,%esi
80104a92:	73 1c                	jae    80104ab0 <argint+0x40>
80104a94:	8d 53 08             	lea    0x8(%ebx),%edx
80104a97:	39 d0                	cmp    %edx,%eax
80104a99:	72 15                	jb     80104ab0 <argint+0x40>
  *ip = *(int*)(addr);
80104a9b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a9e:	8b 53 04             	mov    0x4(%ebx),%edx
80104aa1:	89 10                	mov    %edx,(%eax)
  return 0;
80104aa3:	31 c0                	xor    %eax,%eax
}
80104aa5:	5b                   	pop    %ebx
80104aa6:	5e                   	pop    %esi
80104aa7:	5d                   	pop    %ebp
80104aa8:	c3                   	ret
80104aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ab5:	eb ee                	jmp    80104aa5 <argint+0x35>
80104ab7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104abe:	00 
80104abf:	90                   	nop

80104ac0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	57                   	push   %edi
80104ac4:	56                   	push   %esi
80104ac5:	53                   	push   %ebx
80104ac6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104ac9:	e8 b2 ef ff ff       	call   80103a80 <myproc>
80104ace:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ad0:	e8 ab ef ff ff       	call   80103a80 <myproc>
80104ad5:	8b 55 08             	mov    0x8(%ebp),%edx
80104ad8:	8b 40 18             	mov    0x18(%eax),%eax
80104adb:	8b 40 44             	mov    0x44(%eax),%eax
80104ade:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104ae1:	e8 9a ef ff ff       	call   80103a80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ae6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ae9:	8b 00                	mov    (%eax),%eax
80104aeb:	39 c7                	cmp    %eax,%edi
80104aed:	73 31                	jae    80104b20 <argptr+0x60>
80104aef:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104af2:	39 c8                	cmp    %ecx,%eax
80104af4:	72 2a                	jb     80104b20 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104af6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104af9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104afc:	85 d2                	test   %edx,%edx
80104afe:	78 20                	js     80104b20 <argptr+0x60>
80104b00:	8b 16                	mov    (%esi),%edx
80104b02:	39 d0                	cmp    %edx,%eax
80104b04:	73 1a                	jae    80104b20 <argptr+0x60>
80104b06:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104b09:	01 c3                	add    %eax,%ebx
80104b0b:	39 da                	cmp    %ebx,%edx
80104b0d:	72 11                	jb     80104b20 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104b0f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b12:	89 02                	mov    %eax,(%edx)
  return 0;
80104b14:	31 c0                	xor    %eax,%eax
}
80104b16:	83 c4 0c             	add    $0xc,%esp
80104b19:	5b                   	pop    %ebx
80104b1a:	5e                   	pop    %esi
80104b1b:	5f                   	pop    %edi
80104b1c:	5d                   	pop    %ebp
80104b1d:	c3                   	ret
80104b1e:	66 90                	xchg   %ax,%ax
    return -1;
80104b20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b25:	eb ef                	jmp    80104b16 <argptr+0x56>
80104b27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b2e:	00 
80104b2f:	90                   	nop

80104b30 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b35:	e8 46 ef ff ff       	call   80103a80 <myproc>
80104b3a:	8b 55 08             	mov    0x8(%ebp),%edx
80104b3d:	8b 40 18             	mov    0x18(%eax),%eax
80104b40:	8b 40 44             	mov    0x44(%eax),%eax
80104b43:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104b46:	e8 35 ef ff ff       	call   80103a80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b4b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b4e:	8b 00                	mov    (%eax),%eax
80104b50:	39 c6                	cmp    %eax,%esi
80104b52:	73 44                	jae    80104b98 <argstr+0x68>
80104b54:	8d 53 08             	lea    0x8(%ebx),%edx
80104b57:	39 d0                	cmp    %edx,%eax
80104b59:	72 3d                	jb     80104b98 <argstr+0x68>
  *ip = *(int*)(addr);
80104b5b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104b5e:	e8 1d ef ff ff       	call   80103a80 <myproc>
  if(addr >= curproc->sz)
80104b63:	3b 18                	cmp    (%eax),%ebx
80104b65:	73 31                	jae    80104b98 <argstr+0x68>
  *pp = (char*)addr;
80104b67:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b6a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104b6c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104b6e:	39 d3                	cmp    %edx,%ebx
80104b70:	73 26                	jae    80104b98 <argstr+0x68>
80104b72:	89 d8                	mov    %ebx,%eax
80104b74:	eb 11                	jmp    80104b87 <argstr+0x57>
80104b76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b7d:	00 
80104b7e:	66 90                	xchg   %ax,%ax
80104b80:	83 c0 01             	add    $0x1,%eax
80104b83:	39 d0                	cmp    %edx,%eax
80104b85:	73 11                	jae    80104b98 <argstr+0x68>
    if(*s == 0)
80104b87:	80 38 00             	cmpb   $0x0,(%eax)
80104b8a:	75 f4                	jne    80104b80 <argstr+0x50>
      return s - *pp;
80104b8c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104b8e:	5b                   	pop    %ebx
80104b8f:	5e                   	pop    %esi
80104b90:	5d                   	pop    %ebp
80104b91:	c3                   	ret
80104b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b98:	5b                   	pop    %ebx
    return -1;
80104b99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b9e:	5e                   	pop    %esi
80104b9f:	5d                   	pop    %ebp
80104ba0:	c3                   	ret
80104ba1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ba8:	00 
80104ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104bb0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	53                   	push   %ebx
80104bb4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104bb7:	e8 c4 ee ff ff       	call   80103a80 <myproc>
80104bbc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104bbe:	8b 40 18             	mov    0x18(%eax),%eax
80104bc1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104bc4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104bc7:	83 fa 14             	cmp    $0x14,%edx
80104bca:	77 24                	ja     80104bf0 <syscall+0x40>
80104bcc:	8b 14 85 c0 7b 10 80 	mov    -0x7fef8440(,%eax,4),%edx
80104bd3:	85 d2                	test   %edx,%edx
80104bd5:	74 19                	je     80104bf0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104bd7:	ff d2                	call   *%edx
80104bd9:	89 c2                	mov    %eax,%edx
80104bdb:	8b 43 18             	mov    0x18(%ebx),%eax
80104bde:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104be1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104be4:	c9                   	leave
80104be5:	c3                   	ret
80104be6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bed:	00 
80104bee:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104bf0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104bf1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104bf4:	50                   	push   %eax
80104bf5:	ff 73 10             	push   0x10(%ebx)
80104bf8:	68 f1 75 10 80       	push   $0x801075f1
80104bfd:	e8 ae ba ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80104c02:	8b 43 18             	mov    0x18(%ebx),%eax
80104c05:	83 c4 10             	add    $0x10,%esp
80104c08:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104c0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c12:	c9                   	leave
80104c13:	c3                   	ret
80104c14:	66 90                	xchg   %ax,%ax
80104c16:	66 90                	xchg   %ax,%ax
80104c18:	66 90                	xchg   %ax,%ax
80104c1a:	66 90                	xchg   %ax,%ax
80104c1c:	66 90                	xchg   %ax,%ax
80104c1e:	66 90                	xchg   %ax,%ax

80104c20 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	57                   	push   %edi
80104c24:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104c25:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104c28:	53                   	push   %ebx
80104c29:	83 ec 34             	sub    $0x34,%esp
80104c2c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104c2f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104c32:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104c35:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104c38:	57                   	push   %edi
80104c39:	50                   	push   %eax
80104c3a:	e8 81 d5 ff ff       	call   801021c0 <nameiparent>
80104c3f:	83 c4 10             	add    $0x10,%esp
80104c42:	85 c0                	test   %eax,%eax
80104c44:	74 5e                	je     80104ca4 <create+0x84>
    return 0;
  ilock(dp);
80104c46:	83 ec 0c             	sub    $0xc,%esp
80104c49:	89 c3                	mov    %eax,%ebx
80104c4b:	50                   	push   %eax
80104c4c:	e8 6f cc ff ff       	call   801018c0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104c51:	83 c4 0c             	add    $0xc,%esp
80104c54:	6a 00                	push   $0x0
80104c56:	57                   	push   %edi
80104c57:	53                   	push   %ebx
80104c58:	e8 b3 d1 ff ff       	call   80101e10 <dirlookup>
80104c5d:	83 c4 10             	add    $0x10,%esp
80104c60:	89 c6                	mov    %eax,%esi
80104c62:	85 c0                	test   %eax,%eax
80104c64:	74 4a                	je     80104cb0 <create+0x90>
    iunlockput(dp);
80104c66:	83 ec 0c             	sub    $0xc,%esp
80104c69:	53                   	push   %ebx
80104c6a:	e8 e1 ce ff ff       	call   80101b50 <iunlockput>
    ilock(ip);
80104c6f:	89 34 24             	mov    %esi,(%esp)
80104c72:	e8 49 cc ff ff       	call   801018c0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104c77:	83 c4 10             	add    $0x10,%esp
80104c7a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104c7f:	75 17                	jne    80104c98 <create+0x78>
80104c81:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104c86:	75 10                	jne    80104c98 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c8b:	89 f0                	mov    %esi,%eax
80104c8d:	5b                   	pop    %ebx
80104c8e:	5e                   	pop    %esi
80104c8f:	5f                   	pop    %edi
80104c90:	5d                   	pop    %ebp
80104c91:	c3                   	ret
80104c92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80104c98:	83 ec 0c             	sub    $0xc,%esp
80104c9b:	56                   	push   %esi
80104c9c:	e8 af ce ff ff       	call   80101b50 <iunlockput>
    return 0;
80104ca1:	83 c4 10             	add    $0x10,%esp
}
80104ca4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104ca7:	31 f6                	xor    %esi,%esi
}
80104ca9:	5b                   	pop    %ebx
80104caa:	89 f0                	mov    %esi,%eax
80104cac:	5e                   	pop    %esi
80104cad:	5f                   	pop    %edi
80104cae:	5d                   	pop    %ebp
80104caf:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104cb0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104cb4:	83 ec 08             	sub    $0x8,%esp
80104cb7:	50                   	push   %eax
80104cb8:	ff 33                	push   (%ebx)
80104cba:	e8 91 ca ff ff       	call   80101750 <ialloc>
80104cbf:	83 c4 10             	add    $0x10,%esp
80104cc2:	89 c6                	mov    %eax,%esi
80104cc4:	85 c0                	test   %eax,%eax
80104cc6:	0f 84 bc 00 00 00    	je     80104d88 <create+0x168>
  ilock(ip);
80104ccc:	83 ec 0c             	sub    $0xc,%esp
80104ccf:	50                   	push   %eax
80104cd0:	e8 eb cb ff ff       	call   801018c0 <ilock>
  ip->major = major;
80104cd5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104cd9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104cdd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104ce1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104ce5:	b8 01 00 00 00       	mov    $0x1,%eax
80104cea:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104cee:	89 34 24             	mov    %esi,(%esp)
80104cf1:	e8 1a cb ff ff       	call   80101810 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104cf6:	83 c4 10             	add    $0x10,%esp
80104cf9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104cfe:	74 30                	je     80104d30 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104d00:	83 ec 04             	sub    $0x4,%esp
80104d03:	ff 76 04             	push   0x4(%esi)
80104d06:	57                   	push   %edi
80104d07:	53                   	push   %ebx
80104d08:	e8 d3 d3 ff ff       	call   801020e0 <dirlink>
80104d0d:	83 c4 10             	add    $0x10,%esp
80104d10:	85 c0                	test   %eax,%eax
80104d12:	78 67                	js     80104d7b <create+0x15b>
  iunlockput(dp);
80104d14:	83 ec 0c             	sub    $0xc,%esp
80104d17:	53                   	push   %ebx
80104d18:	e8 33 ce ff ff       	call   80101b50 <iunlockput>
  return ip;
80104d1d:	83 c4 10             	add    $0x10,%esp
}
80104d20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d23:	89 f0                	mov    %esi,%eax
80104d25:	5b                   	pop    %ebx
80104d26:	5e                   	pop    %esi
80104d27:	5f                   	pop    %edi
80104d28:	5d                   	pop    %ebp
80104d29:	c3                   	ret
80104d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104d30:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104d33:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104d38:	53                   	push   %ebx
80104d39:	e8 d2 ca ff ff       	call   80101810 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104d3e:	83 c4 0c             	add    $0xc,%esp
80104d41:	ff 76 04             	push   0x4(%esi)
80104d44:	68 29 76 10 80       	push   $0x80107629
80104d49:	56                   	push   %esi
80104d4a:	e8 91 d3 ff ff       	call   801020e0 <dirlink>
80104d4f:	83 c4 10             	add    $0x10,%esp
80104d52:	85 c0                	test   %eax,%eax
80104d54:	78 18                	js     80104d6e <create+0x14e>
80104d56:	83 ec 04             	sub    $0x4,%esp
80104d59:	ff 73 04             	push   0x4(%ebx)
80104d5c:	68 28 76 10 80       	push   $0x80107628
80104d61:	56                   	push   %esi
80104d62:	e8 79 d3 ff ff       	call   801020e0 <dirlink>
80104d67:	83 c4 10             	add    $0x10,%esp
80104d6a:	85 c0                	test   %eax,%eax
80104d6c:	79 92                	jns    80104d00 <create+0xe0>
      panic("create dots");
80104d6e:	83 ec 0c             	sub    $0xc,%esp
80104d71:	68 1c 76 10 80       	push   $0x8010761c
80104d76:	e8 05 b6 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104d7b:	83 ec 0c             	sub    $0xc,%esp
80104d7e:	68 2b 76 10 80       	push   $0x8010762b
80104d83:	e8 f8 b5 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104d88:	83 ec 0c             	sub    $0xc,%esp
80104d8b:	68 0d 76 10 80       	push   $0x8010760d
80104d90:	e8 eb b5 ff ff       	call   80100380 <panic>
80104d95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d9c:	00 
80104d9d:	8d 76 00             	lea    0x0(%esi),%esi

80104da0 <sys_dup>:
{
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	56                   	push   %esi
80104da4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104da5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104da8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104dab:	50                   	push   %eax
80104dac:	6a 00                	push   $0x0
80104dae:	e8 bd fc ff ff       	call   80104a70 <argint>
80104db3:	83 c4 10             	add    $0x10,%esp
80104db6:	85 c0                	test   %eax,%eax
80104db8:	78 36                	js     80104df0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104dba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104dbe:	77 30                	ja     80104df0 <sys_dup+0x50>
80104dc0:	e8 bb ec ff ff       	call   80103a80 <myproc>
80104dc5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104dc8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104dcc:	85 f6                	test   %esi,%esi
80104dce:	74 20                	je     80104df0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104dd0:	e8 ab ec ff ff       	call   80103a80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104dd5:	31 db                	xor    %ebx,%ebx
80104dd7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104dde:	00 
80104ddf:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104de0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104de4:	85 d2                	test   %edx,%edx
80104de6:	74 18                	je     80104e00 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104de8:	83 c3 01             	add    $0x1,%ebx
80104deb:	83 fb 10             	cmp    $0x10,%ebx
80104dee:	75 f0                	jne    80104de0 <sys_dup+0x40>
}
80104df0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104df3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104df8:	89 d8                	mov    %ebx,%eax
80104dfa:	5b                   	pop    %ebx
80104dfb:	5e                   	pop    %esi
80104dfc:	5d                   	pop    %ebp
80104dfd:	c3                   	ret
80104dfe:	66 90                	xchg   %ax,%ax
  filedup(f);
80104e00:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104e03:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104e07:	56                   	push   %esi
80104e08:	e8 d3 c1 ff ff       	call   80100fe0 <filedup>
  return fd;
80104e0d:	83 c4 10             	add    $0x10,%esp
}
80104e10:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e13:	89 d8                	mov    %ebx,%eax
80104e15:	5b                   	pop    %ebx
80104e16:	5e                   	pop    %esi
80104e17:	5d                   	pop    %ebp
80104e18:	c3                   	ret
80104e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e20 <sys_read>:
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	56                   	push   %esi
80104e24:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104e25:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104e28:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e2b:	53                   	push   %ebx
80104e2c:	6a 00                	push   $0x0
80104e2e:	e8 3d fc ff ff       	call   80104a70 <argint>
80104e33:	83 c4 10             	add    $0x10,%esp
80104e36:	85 c0                	test   %eax,%eax
80104e38:	78 5e                	js     80104e98 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e3a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e3e:	77 58                	ja     80104e98 <sys_read+0x78>
80104e40:	e8 3b ec ff ff       	call   80103a80 <myproc>
80104e45:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e48:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104e4c:	85 f6                	test   %esi,%esi
80104e4e:	74 48                	je     80104e98 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e50:	83 ec 08             	sub    $0x8,%esp
80104e53:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e56:	50                   	push   %eax
80104e57:	6a 02                	push   $0x2
80104e59:	e8 12 fc ff ff       	call   80104a70 <argint>
80104e5e:	83 c4 10             	add    $0x10,%esp
80104e61:	85 c0                	test   %eax,%eax
80104e63:	78 33                	js     80104e98 <sys_read+0x78>
80104e65:	83 ec 04             	sub    $0x4,%esp
80104e68:	ff 75 f0             	push   -0x10(%ebp)
80104e6b:	53                   	push   %ebx
80104e6c:	6a 01                	push   $0x1
80104e6e:	e8 4d fc ff ff       	call   80104ac0 <argptr>
80104e73:	83 c4 10             	add    $0x10,%esp
80104e76:	85 c0                	test   %eax,%eax
80104e78:	78 1e                	js     80104e98 <sys_read+0x78>
  return fileread(f, p, n);
80104e7a:	83 ec 04             	sub    $0x4,%esp
80104e7d:	ff 75 f0             	push   -0x10(%ebp)
80104e80:	ff 75 f4             	push   -0xc(%ebp)
80104e83:	56                   	push   %esi
80104e84:	e8 d7 c2 ff ff       	call   80101160 <fileread>
80104e89:	83 c4 10             	add    $0x10,%esp
}
80104e8c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e8f:	5b                   	pop    %ebx
80104e90:	5e                   	pop    %esi
80104e91:	5d                   	pop    %ebp
80104e92:	c3                   	ret
80104e93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104e98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e9d:	eb ed                	jmp    80104e8c <sys_read+0x6c>
80104e9f:	90                   	nop

80104ea0 <sys_write>:
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	56                   	push   %esi
80104ea4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104ea5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104ea8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104eab:	53                   	push   %ebx
80104eac:	6a 00                	push   $0x0
80104eae:	e8 bd fb ff ff       	call   80104a70 <argint>
80104eb3:	83 c4 10             	add    $0x10,%esp
80104eb6:	85 c0                	test   %eax,%eax
80104eb8:	78 5e                	js     80104f18 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104eba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ebe:	77 58                	ja     80104f18 <sys_write+0x78>
80104ec0:	e8 bb eb ff ff       	call   80103a80 <myproc>
80104ec5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ec8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104ecc:	85 f6                	test   %esi,%esi
80104ece:	74 48                	je     80104f18 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ed0:	83 ec 08             	sub    $0x8,%esp
80104ed3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ed6:	50                   	push   %eax
80104ed7:	6a 02                	push   $0x2
80104ed9:	e8 92 fb ff ff       	call   80104a70 <argint>
80104ede:	83 c4 10             	add    $0x10,%esp
80104ee1:	85 c0                	test   %eax,%eax
80104ee3:	78 33                	js     80104f18 <sys_write+0x78>
80104ee5:	83 ec 04             	sub    $0x4,%esp
80104ee8:	ff 75 f0             	push   -0x10(%ebp)
80104eeb:	53                   	push   %ebx
80104eec:	6a 01                	push   $0x1
80104eee:	e8 cd fb ff ff       	call   80104ac0 <argptr>
80104ef3:	83 c4 10             	add    $0x10,%esp
80104ef6:	85 c0                	test   %eax,%eax
80104ef8:	78 1e                	js     80104f18 <sys_write+0x78>
  return filewrite(f, p, n);
80104efa:	83 ec 04             	sub    $0x4,%esp
80104efd:	ff 75 f0             	push   -0x10(%ebp)
80104f00:	ff 75 f4             	push   -0xc(%ebp)
80104f03:	56                   	push   %esi
80104f04:	e8 e7 c2 ff ff       	call   801011f0 <filewrite>
80104f09:	83 c4 10             	add    $0x10,%esp
}
80104f0c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f0f:	5b                   	pop    %ebx
80104f10:	5e                   	pop    %esi
80104f11:	5d                   	pop    %ebp
80104f12:	c3                   	ret
80104f13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104f18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f1d:	eb ed                	jmp    80104f0c <sys_write+0x6c>
80104f1f:	90                   	nop

80104f20 <sys_close>:
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	56                   	push   %esi
80104f24:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f25:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104f28:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f2b:	50                   	push   %eax
80104f2c:	6a 00                	push   $0x0
80104f2e:	e8 3d fb ff ff       	call   80104a70 <argint>
80104f33:	83 c4 10             	add    $0x10,%esp
80104f36:	85 c0                	test   %eax,%eax
80104f38:	78 3e                	js     80104f78 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f3a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f3e:	77 38                	ja     80104f78 <sys_close+0x58>
80104f40:	e8 3b eb ff ff       	call   80103a80 <myproc>
80104f45:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f48:	8d 5a 08             	lea    0x8(%edx),%ebx
80104f4b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80104f4f:	85 f6                	test   %esi,%esi
80104f51:	74 25                	je     80104f78 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80104f53:	e8 28 eb ff ff       	call   80103a80 <myproc>
  fileclose(f);
80104f58:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104f5b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80104f62:	00 
  fileclose(f);
80104f63:	56                   	push   %esi
80104f64:	e8 c7 c0 ff ff       	call   80101030 <fileclose>
  return 0;
80104f69:	83 c4 10             	add    $0x10,%esp
80104f6c:	31 c0                	xor    %eax,%eax
}
80104f6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f71:	5b                   	pop    %ebx
80104f72:	5e                   	pop    %esi
80104f73:	5d                   	pop    %ebp
80104f74:	c3                   	ret
80104f75:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104f78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f7d:	eb ef                	jmp    80104f6e <sys_close+0x4e>
80104f7f:	90                   	nop

80104f80 <sys_fstat>:
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	56                   	push   %esi
80104f84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f85:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f8b:	53                   	push   %ebx
80104f8c:	6a 00                	push   $0x0
80104f8e:	e8 dd fa ff ff       	call   80104a70 <argint>
80104f93:	83 c4 10             	add    $0x10,%esp
80104f96:	85 c0                	test   %eax,%eax
80104f98:	78 46                	js     80104fe0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f9e:	77 40                	ja     80104fe0 <sys_fstat+0x60>
80104fa0:	e8 db ea ff ff       	call   80103a80 <myproc>
80104fa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104fa8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104fac:	85 f6                	test   %esi,%esi
80104fae:	74 30                	je     80104fe0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104fb0:	83 ec 04             	sub    $0x4,%esp
80104fb3:	6a 14                	push   $0x14
80104fb5:	53                   	push   %ebx
80104fb6:	6a 01                	push   $0x1
80104fb8:	e8 03 fb ff ff       	call   80104ac0 <argptr>
80104fbd:	83 c4 10             	add    $0x10,%esp
80104fc0:	85 c0                	test   %eax,%eax
80104fc2:	78 1c                	js     80104fe0 <sys_fstat+0x60>
  return filestat(f, st);
80104fc4:	83 ec 08             	sub    $0x8,%esp
80104fc7:	ff 75 f4             	push   -0xc(%ebp)
80104fca:	56                   	push   %esi
80104fcb:	e8 40 c1 ff ff       	call   80101110 <filestat>
80104fd0:	83 c4 10             	add    $0x10,%esp
}
80104fd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fd6:	5b                   	pop    %ebx
80104fd7:	5e                   	pop    %esi
80104fd8:	5d                   	pop    %ebp
80104fd9:	c3                   	ret
80104fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fe5:	eb ec                	jmp    80104fd3 <sys_fstat+0x53>
80104fe7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fee:	00 
80104fef:	90                   	nop

80104ff0 <sys_link>:
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	57                   	push   %edi
80104ff4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ff5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104ff8:	53                   	push   %ebx
80104ff9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ffc:	50                   	push   %eax
80104ffd:	6a 00                	push   $0x0
80104fff:	e8 2c fb ff ff       	call   80104b30 <argstr>
80105004:	83 c4 10             	add    $0x10,%esp
80105007:	85 c0                	test   %eax,%eax
80105009:	0f 88 fb 00 00 00    	js     8010510a <sys_link+0x11a>
8010500f:	83 ec 08             	sub    $0x8,%esp
80105012:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105015:	50                   	push   %eax
80105016:	6a 01                	push   $0x1
80105018:	e8 13 fb ff ff       	call   80104b30 <argstr>
8010501d:	83 c4 10             	add    $0x10,%esp
80105020:	85 c0                	test   %eax,%eax
80105022:	0f 88 e2 00 00 00    	js     8010510a <sys_link+0x11a>
  begin_op();
80105028:	e8 33 de ff ff       	call   80102e60 <begin_op>
  if((ip = namei(old)) == 0){
8010502d:	83 ec 0c             	sub    $0xc,%esp
80105030:	ff 75 d4             	push   -0x2c(%ebp)
80105033:	e8 68 d1 ff ff       	call   801021a0 <namei>
80105038:	83 c4 10             	add    $0x10,%esp
8010503b:	89 c3                	mov    %eax,%ebx
8010503d:	85 c0                	test   %eax,%eax
8010503f:	0f 84 df 00 00 00    	je     80105124 <sys_link+0x134>
  ilock(ip);
80105045:	83 ec 0c             	sub    $0xc,%esp
80105048:	50                   	push   %eax
80105049:	e8 72 c8 ff ff       	call   801018c0 <ilock>
  if(ip->type == T_DIR){
8010504e:	83 c4 10             	add    $0x10,%esp
80105051:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105056:	0f 84 b5 00 00 00    	je     80105111 <sys_link+0x121>
  iupdate(ip);
8010505c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010505f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105064:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105067:	53                   	push   %ebx
80105068:	e8 a3 c7 ff ff       	call   80101810 <iupdate>
  iunlock(ip);
8010506d:	89 1c 24             	mov    %ebx,(%esp)
80105070:	e8 2b c9 ff ff       	call   801019a0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105075:	58                   	pop    %eax
80105076:	5a                   	pop    %edx
80105077:	57                   	push   %edi
80105078:	ff 75 d0             	push   -0x30(%ebp)
8010507b:	e8 40 d1 ff ff       	call   801021c0 <nameiparent>
80105080:	83 c4 10             	add    $0x10,%esp
80105083:	89 c6                	mov    %eax,%esi
80105085:	85 c0                	test   %eax,%eax
80105087:	74 5b                	je     801050e4 <sys_link+0xf4>
  ilock(dp);
80105089:	83 ec 0c             	sub    $0xc,%esp
8010508c:	50                   	push   %eax
8010508d:	e8 2e c8 ff ff       	call   801018c0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105092:	8b 03                	mov    (%ebx),%eax
80105094:	83 c4 10             	add    $0x10,%esp
80105097:	39 06                	cmp    %eax,(%esi)
80105099:	75 3d                	jne    801050d8 <sys_link+0xe8>
8010509b:	83 ec 04             	sub    $0x4,%esp
8010509e:	ff 73 04             	push   0x4(%ebx)
801050a1:	57                   	push   %edi
801050a2:	56                   	push   %esi
801050a3:	e8 38 d0 ff ff       	call   801020e0 <dirlink>
801050a8:	83 c4 10             	add    $0x10,%esp
801050ab:	85 c0                	test   %eax,%eax
801050ad:	78 29                	js     801050d8 <sys_link+0xe8>
  iunlockput(dp);
801050af:	83 ec 0c             	sub    $0xc,%esp
801050b2:	56                   	push   %esi
801050b3:	e8 98 ca ff ff       	call   80101b50 <iunlockput>
  iput(ip);
801050b8:	89 1c 24             	mov    %ebx,(%esp)
801050bb:	e8 30 c9 ff ff       	call   801019f0 <iput>
  end_op();
801050c0:	e8 0b de ff ff       	call   80102ed0 <end_op>
  return 0;
801050c5:	83 c4 10             	add    $0x10,%esp
801050c8:	31 c0                	xor    %eax,%eax
}
801050ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050cd:	5b                   	pop    %ebx
801050ce:	5e                   	pop    %esi
801050cf:	5f                   	pop    %edi
801050d0:	5d                   	pop    %ebp
801050d1:	c3                   	ret
801050d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801050d8:	83 ec 0c             	sub    $0xc,%esp
801050db:	56                   	push   %esi
801050dc:	e8 6f ca ff ff       	call   80101b50 <iunlockput>
    goto bad;
801050e1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801050e4:	83 ec 0c             	sub    $0xc,%esp
801050e7:	53                   	push   %ebx
801050e8:	e8 d3 c7 ff ff       	call   801018c0 <ilock>
  ip->nlink--;
801050ed:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050f2:	89 1c 24             	mov    %ebx,(%esp)
801050f5:	e8 16 c7 ff ff       	call   80101810 <iupdate>
  iunlockput(ip);
801050fa:	89 1c 24             	mov    %ebx,(%esp)
801050fd:	e8 4e ca ff ff       	call   80101b50 <iunlockput>
  end_op();
80105102:	e8 c9 dd ff ff       	call   80102ed0 <end_op>
  return -1;
80105107:	83 c4 10             	add    $0x10,%esp
    return -1;
8010510a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010510f:	eb b9                	jmp    801050ca <sys_link+0xda>
    iunlockput(ip);
80105111:	83 ec 0c             	sub    $0xc,%esp
80105114:	53                   	push   %ebx
80105115:	e8 36 ca ff ff       	call   80101b50 <iunlockput>
    end_op();
8010511a:	e8 b1 dd ff ff       	call   80102ed0 <end_op>
    return -1;
8010511f:	83 c4 10             	add    $0x10,%esp
80105122:	eb e6                	jmp    8010510a <sys_link+0x11a>
    end_op();
80105124:	e8 a7 dd ff ff       	call   80102ed0 <end_op>
    return -1;
80105129:	eb df                	jmp    8010510a <sys_link+0x11a>
8010512b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105130 <sys_unlink>:
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	57                   	push   %edi
80105134:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105135:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105138:	53                   	push   %ebx
80105139:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010513c:	50                   	push   %eax
8010513d:	6a 00                	push   $0x0
8010513f:	e8 ec f9 ff ff       	call   80104b30 <argstr>
80105144:	83 c4 10             	add    $0x10,%esp
80105147:	85 c0                	test   %eax,%eax
80105149:	0f 88 54 01 00 00    	js     801052a3 <sys_unlink+0x173>
  begin_op();
8010514f:	e8 0c dd ff ff       	call   80102e60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105154:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105157:	83 ec 08             	sub    $0x8,%esp
8010515a:	53                   	push   %ebx
8010515b:	ff 75 c0             	push   -0x40(%ebp)
8010515e:	e8 5d d0 ff ff       	call   801021c0 <nameiparent>
80105163:	83 c4 10             	add    $0x10,%esp
80105166:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105169:	85 c0                	test   %eax,%eax
8010516b:	0f 84 58 01 00 00    	je     801052c9 <sys_unlink+0x199>
  ilock(dp);
80105171:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105174:	83 ec 0c             	sub    $0xc,%esp
80105177:	57                   	push   %edi
80105178:	e8 43 c7 ff ff       	call   801018c0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010517d:	58                   	pop    %eax
8010517e:	5a                   	pop    %edx
8010517f:	68 29 76 10 80       	push   $0x80107629
80105184:	53                   	push   %ebx
80105185:	e8 66 cc ff ff       	call   80101df0 <namecmp>
8010518a:	83 c4 10             	add    $0x10,%esp
8010518d:	85 c0                	test   %eax,%eax
8010518f:	0f 84 fb 00 00 00    	je     80105290 <sys_unlink+0x160>
80105195:	83 ec 08             	sub    $0x8,%esp
80105198:	68 28 76 10 80       	push   $0x80107628
8010519d:	53                   	push   %ebx
8010519e:	e8 4d cc ff ff       	call   80101df0 <namecmp>
801051a3:	83 c4 10             	add    $0x10,%esp
801051a6:	85 c0                	test   %eax,%eax
801051a8:	0f 84 e2 00 00 00    	je     80105290 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
801051ae:	83 ec 04             	sub    $0x4,%esp
801051b1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801051b4:	50                   	push   %eax
801051b5:	53                   	push   %ebx
801051b6:	57                   	push   %edi
801051b7:	e8 54 cc ff ff       	call   80101e10 <dirlookup>
801051bc:	83 c4 10             	add    $0x10,%esp
801051bf:	89 c3                	mov    %eax,%ebx
801051c1:	85 c0                	test   %eax,%eax
801051c3:	0f 84 c7 00 00 00    	je     80105290 <sys_unlink+0x160>
  ilock(ip);
801051c9:	83 ec 0c             	sub    $0xc,%esp
801051cc:	50                   	push   %eax
801051cd:	e8 ee c6 ff ff       	call   801018c0 <ilock>
  if(ip->nlink < 1)
801051d2:	83 c4 10             	add    $0x10,%esp
801051d5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801051da:	0f 8e 0a 01 00 00    	jle    801052ea <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
801051e0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051e5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801051e8:	74 66                	je     80105250 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801051ea:	83 ec 04             	sub    $0x4,%esp
801051ed:	6a 10                	push   $0x10
801051ef:	6a 00                	push   $0x0
801051f1:	57                   	push   %edi
801051f2:	e8 c9 f5 ff ff       	call   801047c0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051f7:	6a 10                	push   $0x10
801051f9:	ff 75 c4             	push   -0x3c(%ebp)
801051fc:	57                   	push   %edi
801051fd:	ff 75 b4             	push   -0x4c(%ebp)
80105200:	e8 cb ca ff ff       	call   80101cd0 <writei>
80105205:	83 c4 20             	add    $0x20,%esp
80105208:	83 f8 10             	cmp    $0x10,%eax
8010520b:	0f 85 cc 00 00 00    	jne    801052dd <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105211:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105216:	0f 84 94 00 00 00    	je     801052b0 <sys_unlink+0x180>
  iunlockput(dp);
8010521c:	83 ec 0c             	sub    $0xc,%esp
8010521f:	ff 75 b4             	push   -0x4c(%ebp)
80105222:	e8 29 c9 ff ff       	call   80101b50 <iunlockput>
  ip->nlink--;
80105227:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010522c:	89 1c 24             	mov    %ebx,(%esp)
8010522f:	e8 dc c5 ff ff       	call   80101810 <iupdate>
  iunlockput(ip);
80105234:	89 1c 24             	mov    %ebx,(%esp)
80105237:	e8 14 c9 ff ff       	call   80101b50 <iunlockput>
  end_op();
8010523c:	e8 8f dc ff ff       	call   80102ed0 <end_op>
  return 0;
80105241:	83 c4 10             	add    $0x10,%esp
80105244:	31 c0                	xor    %eax,%eax
}
80105246:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105249:	5b                   	pop    %ebx
8010524a:	5e                   	pop    %esi
8010524b:	5f                   	pop    %edi
8010524c:	5d                   	pop    %ebp
8010524d:	c3                   	ret
8010524e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105250:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105254:	76 94                	jbe    801051ea <sys_unlink+0xba>
80105256:	be 20 00 00 00       	mov    $0x20,%esi
8010525b:	eb 0b                	jmp    80105268 <sys_unlink+0x138>
8010525d:	8d 76 00             	lea    0x0(%esi),%esi
80105260:	83 c6 10             	add    $0x10,%esi
80105263:	3b 73 58             	cmp    0x58(%ebx),%esi
80105266:	73 82                	jae    801051ea <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105268:	6a 10                	push   $0x10
8010526a:	56                   	push   %esi
8010526b:	57                   	push   %edi
8010526c:	53                   	push   %ebx
8010526d:	e8 5e c9 ff ff       	call   80101bd0 <readi>
80105272:	83 c4 10             	add    $0x10,%esp
80105275:	83 f8 10             	cmp    $0x10,%eax
80105278:	75 56                	jne    801052d0 <sys_unlink+0x1a0>
    if(de.inum != 0)
8010527a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010527f:	74 df                	je     80105260 <sys_unlink+0x130>
    iunlockput(ip);
80105281:	83 ec 0c             	sub    $0xc,%esp
80105284:	53                   	push   %ebx
80105285:	e8 c6 c8 ff ff       	call   80101b50 <iunlockput>
    goto bad;
8010528a:	83 c4 10             	add    $0x10,%esp
8010528d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105290:	83 ec 0c             	sub    $0xc,%esp
80105293:	ff 75 b4             	push   -0x4c(%ebp)
80105296:	e8 b5 c8 ff ff       	call   80101b50 <iunlockput>
  end_op();
8010529b:	e8 30 dc ff ff       	call   80102ed0 <end_op>
  return -1;
801052a0:	83 c4 10             	add    $0x10,%esp
    return -1;
801052a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052a8:	eb 9c                	jmp    80105246 <sys_unlink+0x116>
801052aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
801052b0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801052b3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801052b6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801052bb:	50                   	push   %eax
801052bc:	e8 4f c5 ff ff       	call   80101810 <iupdate>
801052c1:	83 c4 10             	add    $0x10,%esp
801052c4:	e9 53 ff ff ff       	jmp    8010521c <sys_unlink+0xec>
    end_op();
801052c9:	e8 02 dc ff ff       	call   80102ed0 <end_op>
    return -1;
801052ce:	eb d3                	jmp    801052a3 <sys_unlink+0x173>
      panic("isdirempty: readi");
801052d0:	83 ec 0c             	sub    $0xc,%esp
801052d3:	68 4d 76 10 80       	push   $0x8010764d
801052d8:	e8 a3 b0 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
801052dd:	83 ec 0c             	sub    $0xc,%esp
801052e0:	68 5f 76 10 80       	push   $0x8010765f
801052e5:	e8 96 b0 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
801052ea:	83 ec 0c             	sub    $0xc,%esp
801052ed:	68 3b 76 10 80       	push   $0x8010763b
801052f2:	e8 89 b0 ff ff       	call   80100380 <panic>
801052f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052fe:	00 
801052ff:	90                   	nop

80105300 <sys_open>:

int
sys_open(void)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	57                   	push   %edi
80105304:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105305:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105308:	53                   	push   %ebx
80105309:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010530c:	50                   	push   %eax
8010530d:	6a 00                	push   $0x0
8010530f:	e8 1c f8 ff ff       	call   80104b30 <argstr>
80105314:	83 c4 10             	add    $0x10,%esp
80105317:	85 c0                	test   %eax,%eax
80105319:	0f 88 8e 00 00 00    	js     801053ad <sys_open+0xad>
8010531f:	83 ec 08             	sub    $0x8,%esp
80105322:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105325:	50                   	push   %eax
80105326:	6a 01                	push   $0x1
80105328:	e8 43 f7 ff ff       	call   80104a70 <argint>
8010532d:	83 c4 10             	add    $0x10,%esp
80105330:	85 c0                	test   %eax,%eax
80105332:	78 79                	js     801053ad <sys_open+0xad>
    return -1;

  begin_op();
80105334:	e8 27 db ff ff       	call   80102e60 <begin_op>

  if(omode & O_CREATE){
80105339:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010533d:	75 79                	jne    801053b8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010533f:	83 ec 0c             	sub    $0xc,%esp
80105342:	ff 75 e0             	push   -0x20(%ebp)
80105345:	e8 56 ce ff ff       	call   801021a0 <namei>
8010534a:	83 c4 10             	add    $0x10,%esp
8010534d:	89 c6                	mov    %eax,%esi
8010534f:	85 c0                	test   %eax,%eax
80105351:	0f 84 7e 00 00 00    	je     801053d5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105357:	83 ec 0c             	sub    $0xc,%esp
8010535a:	50                   	push   %eax
8010535b:	e8 60 c5 ff ff       	call   801018c0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105360:	83 c4 10             	add    $0x10,%esp
80105363:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105368:	0f 84 ba 00 00 00    	je     80105428 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010536e:	e8 fd bb ff ff       	call   80100f70 <filealloc>
80105373:	89 c7                	mov    %eax,%edi
80105375:	85 c0                	test   %eax,%eax
80105377:	74 23                	je     8010539c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105379:	e8 02 e7 ff ff       	call   80103a80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010537e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105380:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105384:	85 d2                	test   %edx,%edx
80105386:	74 58                	je     801053e0 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105388:	83 c3 01             	add    $0x1,%ebx
8010538b:	83 fb 10             	cmp    $0x10,%ebx
8010538e:	75 f0                	jne    80105380 <sys_open+0x80>
    if(f)
      fileclose(f);
80105390:	83 ec 0c             	sub    $0xc,%esp
80105393:	57                   	push   %edi
80105394:	e8 97 bc ff ff       	call   80101030 <fileclose>
80105399:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010539c:	83 ec 0c             	sub    $0xc,%esp
8010539f:	56                   	push   %esi
801053a0:	e8 ab c7 ff ff       	call   80101b50 <iunlockput>
    end_op();
801053a5:	e8 26 db ff ff       	call   80102ed0 <end_op>
    return -1;
801053aa:	83 c4 10             	add    $0x10,%esp
    return -1;
801053ad:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801053b2:	eb 65                	jmp    80105419 <sys_open+0x119>
801053b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801053b8:	83 ec 0c             	sub    $0xc,%esp
801053bb:	31 c9                	xor    %ecx,%ecx
801053bd:	ba 02 00 00 00       	mov    $0x2,%edx
801053c2:	6a 00                	push   $0x0
801053c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801053c7:	e8 54 f8 ff ff       	call   80104c20 <create>
    if(ip == 0){
801053cc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801053cf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801053d1:	85 c0                	test   %eax,%eax
801053d3:	75 99                	jne    8010536e <sys_open+0x6e>
      end_op();
801053d5:	e8 f6 da ff ff       	call   80102ed0 <end_op>
      return -1;
801053da:	eb d1                	jmp    801053ad <sys_open+0xad>
801053dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801053e0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801053e3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801053e7:	56                   	push   %esi
801053e8:	e8 b3 c5 ff ff       	call   801019a0 <iunlock>
  end_op();
801053ed:	e8 de da ff ff       	call   80102ed0 <end_op>

  f->type = FD_INODE;
801053f2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801053f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053fb:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801053fe:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105401:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105403:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010540a:	f7 d0                	not    %eax
8010540c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010540f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105412:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105415:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105419:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010541c:	89 d8                	mov    %ebx,%eax
8010541e:	5b                   	pop    %ebx
8010541f:	5e                   	pop    %esi
80105420:	5f                   	pop    %edi
80105421:	5d                   	pop    %ebp
80105422:	c3                   	ret
80105423:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105428:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010542b:	85 c9                	test   %ecx,%ecx
8010542d:	0f 84 3b ff ff ff    	je     8010536e <sys_open+0x6e>
80105433:	e9 64 ff ff ff       	jmp    8010539c <sys_open+0x9c>
80105438:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010543f:	00 

80105440 <sys_mkdir>:

int
sys_mkdir(void)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105446:	e8 15 da ff ff       	call   80102e60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010544b:	83 ec 08             	sub    $0x8,%esp
8010544e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105451:	50                   	push   %eax
80105452:	6a 00                	push   $0x0
80105454:	e8 d7 f6 ff ff       	call   80104b30 <argstr>
80105459:	83 c4 10             	add    $0x10,%esp
8010545c:	85 c0                	test   %eax,%eax
8010545e:	78 30                	js     80105490 <sys_mkdir+0x50>
80105460:	83 ec 0c             	sub    $0xc,%esp
80105463:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105466:	31 c9                	xor    %ecx,%ecx
80105468:	ba 01 00 00 00       	mov    $0x1,%edx
8010546d:	6a 00                	push   $0x0
8010546f:	e8 ac f7 ff ff       	call   80104c20 <create>
80105474:	83 c4 10             	add    $0x10,%esp
80105477:	85 c0                	test   %eax,%eax
80105479:	74 15                	je     80105490 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010547b:	83 ec 0c             	sub    $0xc,%esp
8010547e:	50                   	push   %eax
8010547f:	e8 cc c6 ff ff       	call   80101b50 <iunlockput>
  end_op();
80105484:	e8 47 da ff ff       	call   80102ed0 <end_op>
  return 0;
80105489:	83 c4 10             	add    $0x10,%esp
8010548c:	31 c0                	xor    %eax,%eax
}
8010548e:	c9                   	leave
8010548f:	c3                   	ret
    end_op();
80105490:	e8 3b da ff ff       	call   80102ed0 <end_op>
    return -1;
80105495:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010549a:	c9                   	leave
8010549b:	c3                   	ret
8010549c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054a0 <sys_mknod>:

int
sys_mknod(void)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801054a6:	e8 b5 d9 ff ff       	call   80102e60 <begin_op>
  if((argstr(0, &path)) < 0 ||
801054ab:	83 ec 08             	sub    $0x8,%esp
801054ae:	8d 45 ec             	lea    -0x14(%ebp),%eax
801054b1:	50                   	push   %eax
801054b2:	6a 00                	push   $0x0
801054b4:	e8 77 f6 ff ff       	call   80104b30 <argstr>
801054b9:	83 c4 10             	add    $0x10,%esp
801054bc:	85 c0                	test   %eax,%eax
801054be:	78 60                	js     80105520 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801054c0:	83 ec 08             	sub    $0x8,%esp
801054c3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054c6:	50                   	push   %eax
801054c7:	6a 01                	push   $0x1
801054c9:	e8 a2 f5 ff ff       	call   80104a70 <argint>
  if((argstr(0, &path)) < 0 ||
801054ce:	83 c4 10             	add    $0x10,%esp
801054d1:	85 c0                	test   %eax,%eax
801054d3:	78 4b                	js     80105520 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801054d5:	83 ec 08             	sub    $0x8,%esp
801054d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054db:	50                   	push   %eax
801054dc:	6a 02                	push   $0x2
801054de:	e8 8d f5 ff ff       	call   80104a70 <argint>
     argint(1, &major) < 0 ||
801054e3:	83 c4 10             	add    $0x10,%esp
801054e6:	85 c0                	test   %eax,%eax
801054e8:	78 36                	js     80105520 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801054ea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801054ee:	83 ec 0c             	sub    $0xc,%esp
801054f1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801054f5:	ba 03 00 00 00       	mov    $0x3,%edx
801054fa:	50                   	push   %eax
801054fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801054fe:	e8 1d f7 ff ff       	call   80104c20 <create>
     argint(2, &minor) < 0 ||
80105503:	83 c4 10             	add    $0x10,%esp
80105506:	85 c0                	test   %eax,%eax
80105508:	74 16                	je     80105520 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010550a:	83 ec 0c             	sub    $0xc,%esp
8010550d:	50                   	push   %eax
8010550e:	e8 3d c6 ff ff       	call   80101b50 <iunlockput>
  end_op();
80105513:	e8 b8 d9 ff ff       	call   80102ed0 <end_op>
  return 0;
80105518:	83 c4 10             	add    $0x10,%esp
8010551b:	31 c0                	xor    %eax,%eax
}
8010551d:	c9                   	leave
8010551e:	c3                   	ret
8010551f:	90                   	nop
    end_op();
80105520:	e8 ab d9 ff ff       	call   80102ed0 <end_op>
    return -1;
80105525:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010552a:	c9                   	leave
8010552b:	c3                   	ret
8010552c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105530 <sys_chdir>:

int
sys_chdir(void)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	56                   	push   %esi
80105534:	53                   	push   %ebx
80105535:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105538:	e8 43 e5 ff ff       	call   80103a80 <myproc>
8010553d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010553f:	e8 1c d9 ff ff       	call   80102e60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105544:	83 ec 08             	sub    $0x8,%esp
80105547:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010554a:	50                   	push   %eax
8010554b:	6a 00                	push   $0x0
8010554d:	e8 de f5 ff ff       	call   80104b30 <argstr>
80105552:	83 c4 10             	add    $0x10,%esp
80105555:	85 c0                	test   %eax,%eax
80105557:	78 77                	js     801055d0 <sys_chdir+0xa0>
80105559:	83 ec 0c             	sub    $0xc,%esp
8010555c:	ff 75 f4             	push   -0xc(%ebp)
8010555f:	e8 3c cc ff ff       	call   801021a0 <namei>
80105564:	83 c4 10             	add    $0x10,%esp
80105567:	89 c3                	mov    %eax,%ebx
80105569:	85 c0                	test   %eax,%eax
8010556b:	74 63                	je     801055d0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010556d:	83 ec 0c             	sub    $0xc,%esp
80105570:	50                   	push   %eax
80105571:	e8 4a c3 ff ff       	call   801018c0 <ilock>
  if(ip->type != T_DIR){
80105576:	83 c4 10             	add    $0x10,%esp
80105579:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010557e:	75 30                	jne    801055b0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105580:	83 ec 0c             	sub    $0xc,%esp
80105583:	53                   	push   %ebx
80105584:	e8 17 c4 ff ff       	call   801019a0 <iunlock>
  iput(curproc->cwd);
80105589:	58                   	pop    %eax
8010558a:	ff 76 68             	push   0x68(%esi)
8010558d:	e8 5e c4 ff ff       	call   801019f0 <iput>
  end_op();
80105592:	e8 39 d9 ff ff       	call   80102ed0 <end_op>
  curproc->cwd = ip;
80105597:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010559a:	83 c4 10             	add    $0x10,%esp
8010559d:	31 c0                	xor    %eax,%eax
}
8010559f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055a2:	5b                   	pop    %ebx
801055a3:	5e                   	pop    %esi
801055a4:	5d                   	pop    %ebp
801055a5:	c3                   	ret
801055a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055ad:	00 
801055ae:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801055b0:	83 ec 0c             	sub    $0xc,%esp
801055b3:	53                   	push   %ebx
801055b4:	e8 97 c5 ff ff       	call   80101b50 <iunlockput>
    end_op();
801055b9:	e8 12 d9 ff ff       	call   80102ed0 <end_op>
    return -1;
801055be:	83 c4 10             	add    $0x10,%esp
    return -1;
801055c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055c6:	eb d7                	jmp    8010559f <sys_chdir+0x6f>
801055c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055cf:	00 
    end_op();
801055d0:	e8 fb d8 ff ff       	call   80102ed0 <end_op>
    return -1;
801055d5:	eb ea                	jmp    801055c1 <sys_chdir+0x91>
801055d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055de:	00 
801055df:	90                   	nop

801055e0 <sys_exec>:

int
sys_exec(void)
{
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	57                   	push   %edi
801055e4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801055e5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801055eb:	53                   	push   %ebx
801055ec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801055f2:	50                   	push   %eax
801055f3:	6a 00                	push   $0x0
801055f5:	e8 36 f5 ff ff       	call   80104b30 <argstr>
801055fa:	83 c4 10             	add    $0x10,%esp
801055fd:	85 c0                	test   %eax,%eax
801055ff:	0f 88 87 00 00 00    	js     8010568c <sys_exec+0xac>
80105605:	83 ec 08             	sub    $0x8,%esp
80105608:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010560e:	50                   	push   %eax
8010560f:	6a 01                	push   $0x1
80105611:	e8 5a f4 ff ff       	call   80104a70 <argint>
80105616:	83 c4 10             	add    $0x10,%esp
80105619:	85 c0                	test   %eax,%eax
8010561b:	78 6f                	js     8010568c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010561d:	83 ec 04             	sub    $0x4,%esp
80105620:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105626:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105628:	68 80 00 00 00       	push   $0x80
8010562d:	6a 00                	push   $0x0
8010562f:	56                   	push   %esi
80105630:	e8 8b f1 ff ff       	call   801047c0 <memset>
80105635:	83 c4 10             	add    $0x10,%esp
80105638:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010563f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105640:	83 ec 08             	sub    $0x8,%esp
80105643:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105649:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105650:	50                   	push   %eax
80105651:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105657:	01 f8                	add    %edi,%eax
80105659:	50                   	push   %eax
8010565a:	e8 81 f3 ff ff       	call   801049e0 <fetchint>
8010565f:	83 c4 10             	add    $0x10,%esp
80105662:	85 c0                	test   %eax,%eax
80105664:	78 26                	js     8010568c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105666:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010566c:	85 c0                	test   %eax,%eax
8010566e:	74 30                	je     801056a0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105670:	83 ec 08             	sub    $0x8,%esp
80105673:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105676:	52                   	push   %edx
80105677:	50                   	push   %eax
80105678:	e8 a3 f3 ff ff       	call   80104a20 <fetchstr>
8010567d:	83 c4 10             	add    $0x10,%esp
80105680:	85 c0                	test   %eax,%eax
80105682:	78 08                	js     8010568c <sys_exec+0xac>
  for(i=0;; i++){
80105684:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105687:	83 fb 20             	cmp    $0x20,%ebx
8010568a:	75 b4                	jne    80105640 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010568c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010568f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105694:	5b                   	pop    %ebx
80105695:	5e                   	pop    %esi
80105696:	5f                   	pop    %edi
80105697:	5d                   	pop    %ebp
80105698:	c3                   	ret
80105699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801056a0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801056a7:	00 00 00 00 
  return exec(path, argv);
801056ab:	83 ec 08             	sub    $0x8,%esp
801056ae:	56                   	push   %esi
801056af:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801056b5:	e8 16 b5 ff ff       	call   80100bd0 <exec>
801056ba:	83 c4 10             	add    $0x10,%esp
}
801056bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056c0:	5b                   	pop    %ebx
801056c1:	5e                   	pop    %esi
801056c2:	5f                   	pop    %edi
801056c3:	5d                   	pop    %ebp
801056c4:	c3                   	ret
801056c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801056cc:	00 
801056cd:	8d 76 00             	lea    0x0(%esi),%esi

801056d0 <sys_pipe>:

int
sys_pipe(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	57                   	push   %edi
801056d4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801056d5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801056d8:	53                   	push   %ebx
801056d9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801056dc:	6a 08                	push   $0x8
801056de:	50                   	push   %eax
801056df:	6a 00                	push   $0x0
801056e1:	e8 da f3 ff ff       	call   80104ac0 <argptr>
801056e6:	83 c4 10             	add    $0x10,%esp
801056e9:	85 c0                	test   %eax,%eax
801056eb:	0f 88 8b 00 00 00    	js     8010577c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801056f1:	83 ec 08             	sub    $0x8,%esp
801056f4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801056f7:	50                   	push   %eax
801056f8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801056fb:	50                   	push   %eax
801056fc:	e8 2f de ff ff       	call   80103530 <pipealloc>
80105701:	83 c4 10             	add    $0x10,%esp
80105704:	85 c0                	test   %eax,%eax
80105706:	78 74                	js     8010577c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105708:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010570b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010570d:	e8 6e e3 ff ff       	call   80103a80 <myproc>
    if(curproc->ofile[fd] == 0){
80105712:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105716:	85 f6                	test   %esi,%esi
80105718:	74 16                	je     80105730 <sys_pipe+0x60>
8010571a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105720:	83 c3 01             	add    $0x1,%ebx
80105723:	83 fb 10             	cmp    $0x10,%ebx
80105726:	74 3d                	je     80105765 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80105728:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010572c:	85 f6                	test   %esi,%esi
8010572e:	75 f0                	jne    80105720 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105730:	8d 73 08             	lea    0x8(%ebx),%esi
80105733:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105737:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010573a:	e8 41 e3 ff ff       	call   80103a80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010573f:	31 d2                	xor    %edx,%edx
80105741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105748:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010574c:	85 c9                	test   %ecx,%ecx
8010574e:	74 38                	je     80105788 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80105750:	83 c2 01             	add    $0x1,%edx
80105753:	83 fa 10             	cmp    $0x10,%edx
80105756:	75 f0                	jne    80105748 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105758:	e8 23 e3 ff ff       	call   80103a80 <myproc>
8010575d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105764:	00 
    fileclose(rf);
80105765:	83 ec 0c             	sub    $0xc,%esp
80105768:	ff 75 e0             	push   -0x20(%ebp)
8010576b:	e8 c0 b8 ff ff       	call   80101030 <fileclose>
    fileclose(wf);
80105770:	58                   	pop    %eax
80105771:	ff 75 e4             	push   -0x1c(%ebp)
80105774:	e8 b7 b8 ff ff       	call   80101030 <fileclose>
    return -1;
80105779:	83 c4 10             	add    $0x10,%esp
    return -1;
8010577c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105781:	eb 16                	jmp    80105799 <sys_pipe+0xc9>
80105783:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105788:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010578c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010578f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105791:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105794:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105797:	31 c0                	xor    %eax,%eax
}
80105799:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010579c:	5b                   	pop    %ebx
8010579d:	5e                   	pop    %esi
8010579e:	5f                   	pop    %edi
8010579f:	5d                   	pop    %ebp
801057a0:	c3                   	ret
801057a1:	66 90                	xchg   %ax,%ax
801057a3:	66 90                	xchg   %ax,%ax
801057a5:	66 90                	xchg   %ax,%ax
801057a7:	66 90                	xchg   %ax,%ax
801057a9:	66 90                	xchg   %ax,%ax
801057ab:	66 90                	xchg   %ax,%ax
801057ad:	66 90                	xchg   %ax,%ax
801057af:	90                   	nop

801057b0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801057b0:	e9 6b e4 ff ff       	jmp    80103c20 <fork>
801057b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057bc:	00 
801057bd:	8d 76 00             	lea    0x0(%esi),%esi

801057c0 <sys_exit>:
}

int
sys_exit(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	83 ec 08             	sub    $0x8,%esp
  exit();
801057c6:	e8 c5 e6 ff ff       	call   80103e90 <exit>
  return 0;  // not reached
}
801057cb:	31 c0                	xor    %eax,%eax
801057cd:	c9                   	leave
801057ce:	c3                   	ret
801057cf:	90                   	nop

801057d0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
801057d0:	e9 eb e7 ff ff       	jmp    80103fc0 <wait>
801057d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057dc:	00 
801057dd:	8d 76 00             	lea    0x0(%esi),%esi

801057e0 <sys_kill>:
}

int
sys_kill(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801057e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057e9:	50                   	push   %eax
801057ea:	6a 00                	push   $0x0
801057ec:	e8 7f f2 ff ff       	call   80104a70 <argint>
801057f1:	83 c4 10             	add    $0x10,%esp
801057f4:	85 c0                	test   %eax,%eax
801057f6:	78 18                	js     80105810 <sys_kill+0x30>
    return -1;
  return kill(pid);
801057f8:	83 ec 0c             	sub    $0xc,%esp
801057fb:	ff 75 f4             	push   -0xc(%ebp)
801057fe:	e8 5d ea ff ff       	call   80104260 <kill>
80105803:	83 c4 10             	add    $0x10,%esp
}
80105806:	c9                   	leave
80105807:	c3                   	ret
80105808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010580f:	00 
80105810:	c9                   	leave
    return -1;
80105811:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105816:	c3                   	ret
80105817:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010581e:	00 
8010581f:	90                   	nop

80105820 <sys_getpid>:

int
sys_getpid(void)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105826:	e8 55 e2 ff ff       	call   80103a80 <myproc>
8010582b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010582e:	c9                   	leave
8010582f:	c3                   	ret

80105830 <sys_sbrk>:

int
sys_sbrk(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105834:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105837:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010583a:	50                   	push   %eax
8010583b:	6a 00                	push   $0x0
8010583d:	e8 2e f2 ff ff       	call   80104a70 <argint>
80105842:	83 c4 10             	add    $0x10,%esp
80105845:	85 c0                	test   %eax,%eax
80105847:	78 27                	js     80105870 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105849:	e8 32 e2 ff ff       	call   80103a80 <myproc>
  if(growproc(n) < 0)
8010584e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105851:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105853:	ff 75 f4             	push   -0xc(%ebp)
80105856:	e8 45 e3 ff ff       	call   80103ba0 <growproc>
8010585b:	83 c4 10             	add    $0x10,%esp
8010585e:	85 c0                	test   %eax,%eax
80105860:	78 0e                	js     80105870 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105862:	89 d8                	mov    %ebx,%eax
80105864:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105867:	c9                   	leave
80105868:	c3                   	ret
80105869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105870:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105875:	eb eb                	jmp    80105862 <sys_sbrk+0x32>
80105877:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010587e:	00 
8010587f:	90                   	nop

80105880 <sys_sleep>:

int
sys_sleep(void)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105884:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105887:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010588a:	50                   	push   %eax
8010588b:	6a 00                	push   $0x0
8010588d:	e8 de f1 ff ff       	call   80104a70 <argint>
80105892:	83 c4 10             	add    $0x10,%esp
80105895:	85 c0                	test   %eax,%eax
80105897:	78 64                	js     801058fd <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105899:	83 ec 0c             	sub    $0xc,%esp
8010589c:	68 80 3c 11 80       	push   $0x80113c80
801058a1:	e8 1a ee ff ff       	call   801046c0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801058a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801058a9:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  while(ticks - ticks0 < n){
801058af:	83 c4 10             	add    $0x10,%esp
801058b2:	85 d2                	test   %edx,%edx
801058b4:	75 2b                	jne    801058e1 <sys_sleep+0x61>
801058b6:	eb 58                	jmp    80105910 <sys_sleep+0x90>
801058b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058bf:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801058c0:	83 ec 08             	sub    $0x8,%esp
801058c3:	68 80 3c 11 80       	push   $0x80113c80
801058c8:	68 60 3c 11 80       	push   $0x80113c60
801058cd:	e8 6e e8 ff ff       	call   80104140 <sleep>
  while(ticks - ticks0 < n){
801058d2:	a1 60 3c 11 80       	mov    0x80113c60,%eax
801058d7:	83 c4 10             	add    $0x10,%esp
801058da:	29 d8                	sub    %ebx,%eax
801058dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801058df:	73 2f                	jae    80105910 <sys_sleep+0x90>
    if(myproc()->killed){
801058e1:	e8 9a e1 ff ff       	call   80103a80 <myproc>
801058e6:	8b 40 24             	mov    0x24(%eax),%eax
801058e9:	85 c0                	test   %eax,%eax
801058eb:	74 d3                	je     801058c0 <sys_sleep+0x40>
      release(&tickslock);
801058ed:	83 ec 0c             	sub    $0xc,%esp
801058f0:	68 80 3c 11 80       	push   $0x80113c80
801058f5:	e8 66 ed ff ff       	call   80104660 <release>
      return -1;
801058fa:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
801058fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105905:	c9                   	leave
80105906:	c3                   	ret
80105907:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010590e:	00 
8010590f:	90                   	nop
  release(&tickslock);
80105910:	83 ec 0c             	sub    $0xc,%esp
80105913:	68 80 3c 11 80       	push   $0x80113c80
80105918:	e8 43 ed ff ff       	call   80104660 <release>
}
8010591d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80105920:	83 c4 10             	add    $0x10,%esp
80105923:	31 c0                	xor    %eax,%eax
}
80105925:	c9                   	leave
80105926:	c3                   	ret
80105927:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010592e:	00 
8010592f:	90                   	nop

80105930 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	53                   	push   %ebx
80105934:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105937:	68 80 3c 11 80       	push   $0x80113c80
8010593c:	e8 7f ed ff ff       	call   801046c0 <acquire>
  xticks = ticks;
80105941:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  release(&tickslock);
80105947:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
8010594e:	e8 0d ed ff ff       	call   80104660 <release>
  return xticks;
}
80105953:	89 d8                	mov    %ebx,%eax
80105955:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105958:	c9                   	leave
80105959:	c3                   	ret

8010595a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010595a:	1e                   	push   %ds
  pushl %es
8010595b:	06                   	push   %es
  pushl %fs
8010595c:	0f a0                	push   %fs
  pushl %gs
8010595e:	0f a8                	push   %gs
  pushal
80105960:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105961:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105965:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105967:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105969:	54                   	push   %esp
  call trap
8010596a:	e8 c1 00 00 00       	call   80105a30 <trap>
  addl $4, %esp
8010596f:	83 c4 04             	add    $0x4,%esp

80105972 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105972:	61                   	popa
  popl %gs
80105973:	0f a9                	pop    %gs
  popl %fs
80105975:	0f a1                	pop    %fs
  popl %es
80105977:	07                   	pop    %es
  popl %ds
80105978:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105979:	83 c4 08             	add    $0x8,%esp
  iret
8010597c:	cf                   	iret
8010597d:	66 90                	xchg   %ax,%ax
8010597f:	90                   	nop

80105980 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105980:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105981:	31 c0                	xor    %eax,%eax
{
80105983:	89 e5                	mov    %esp,%ebp
80105985:	83 ec 08             	sub    $0x8,%esp
80105988:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010598f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105990:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105997:	c7 04 c5 c2 3c 11 80 	movl   $0x8e000008,-0x7feec33e(,%eax,8)
8010599e:	08 00 00 8e 
801059a2:	66 89 14 c5 c0 3c 11 	mov    %dx,-0x7feec340(,%eax,8)
801059a9:	80 
801059aa:	c1 ea 10             	shr    $0x10,%edx
801059ad:	66 89 14 c5 c6 3c 11 	mov    %dx,-0x7feec33a(,%eax,8)
801059b4:	80 
  for(i = 0; i < 256; i++)
801059b5:	83 c0 01             	add    $0x1,%eax
801059b8:	3d 00 01 00 00       	cmp    $0x100,%eax
801059bd:	75 d1                	jne    80105990 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801059bf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059c2:	a1 08 a1 10 80       	mov    0x8010a108,%eax
801059c7:	c7 05 c2 3e 11 80 08 	movl   $0xef000008,0x80113ec2
801059ce:	00 00 ef 
  initlock(&tickslock, "time");
801059d1:	68 6e 76 10 80       	push   $0x8010766e
801059d6:	68 80 3c 11 80       	push   $0x80113c80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059db:	66 a3 c0 3e 11 80    	mov    %ax,0x80113ec0
801059e1:	c1 e8 10             	shr    $0x10,%eax
801059e4:	66 a3 c6 3e 11 80    	mov    %ax,0x80113ec6
  initlock(&tickslock, "time");
801059ea:	e8 e1 ea ff ff       	call   801044d0 <initlock>
}
801059ef:	83 c4 10             	add    $0x10,%esp
801059f2:	c9                   	leave
801059f3:	c3                   	ret
801059f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059fb:	00 
801059fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a00 <idtinit>:

void
idtinit(void)
{
80105a00:	55                   	push   %ebp
  pd[0] = size-1;
80105a01:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a06:	89 e5                	mov    %esp,%ebp
80105a08:	83 ec 10             	sub    $0x10,%esp
80105a0b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a0f:	b8 c0 3c 11 80       	mov    $0x80113cc0,%eax
80105a14:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a18:	c1 e8 10             	shr    $0x10,%eax
80105a1b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105a1f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a22:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a25:	c9                   	leave
80105a26:	c3                   	ret
80105a27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a2e:	00 
80105a2f:	90                   	nop

80105a30 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	57                   	push   %edi
80105a34:	56                   	push   %esi
80105a35:	53                   	push   %ebx
80105a36:	83 ec 1c             	sub    $0x1c,%esp
80105a39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105a3c:	8b 43 30             	mov    0x30(%ebx),%eax
80105a3f:	83 f8 40             	cmp    $0x40,%eax
80105a42:	0f 84 58 01 00 00    	je     80105ba0 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a48:	83 e8 20             	sub    $0x20,%eax
80105a4b:	83 f8 1f             	cmp    $0x1f,%eax
80105a4e:	0f 87 7c 00 00 00    	ja     80105ad0 <trap+0xa0>
80105a54:	ff 24 85 18 7c 10 80 	jmp    *-0x7fef83e8(,%eax,4)
80105a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105a60:	e8 eb c8 ff ff       	call   80102350 <ideintr>
    lapiceoi();
80105a65:	e8 a6 cf ff ff       	call   80102a10 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a6a:	e8 11 e0 ff ff       	call   80103a80 <myproc>
80105a6f:	85 c0                	test   %eax,%eax
80105a71:	74 1a                	je     80105a8d <trap+0x5d>
80105a73:	e8 08 e0 ff ff       	call   80103a80 <myproc>
80105a78:	8b 50 24             	mov    0x24(%eax),%edx
80105a7b:	85 d2                	test   %edx,%edx
80105a7d:	74 0e                	je     80105a8d <trap+0x5d>
80105a7f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a83:	f7 d0                	not    %eax
80105a85:	a8 03                	test   $0x3,%al
80105a87:	0f 84 db 01 00 00    	je     80105c68 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105a8d:	e8 ee df ff ff       	call   80103a80 <myproc>
80105a92:	85 c0                	test   %eax,%eax
80105a94:	74 0f                	je     80105aa5 <trap+0x75>
80105a96:	e8 e5 df ff ff       	call   80103a80 <myproc>
80105a9b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a9f:	0f 84 ab 00 00 00    	je     80105b50 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105aa5:	e8 d6 df ff ff       	call   80103a80 <myproc>
80105aaa:	85 c0                	test   %eax,%eax
80105aac:	74 1a                	je     80105ac8 <trap+0x98>
80105aae:	e8 cd df ff ff       	call   80103a80 <myproc>
80105ab3:	8b 40 24             	mov    0x24(%eax),%eax
80105ab6:	85 c0                	test   %eax,%eax
80105ab8:	74 0e                	je     80105ac8 <trap+0x98>
80105aba:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105abe:	f7 d0                	not    %eax
80105ac0:	a8 03                	test   $0x3,%al
80105ac2:	0f 84 05 01 00 00    	je     80105bcd <trap+0x19d>
    exit();
}
80105ac8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105acb:	5b                   	pop    %ebx
80105acc:	5e                   	pop    %esi
80105acd:	5f                   	pop    %edi
80105ace:	5d                   	pop    %ebp
80105acf:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80105ad0:	e8 ab df ff ff       	call   80103a80 <myproc>
80105ad5:	8b 7b 38             	mov    0x38(%ebx),%edi
80105ad8:	85 c0                	test   %eax,%eax
80105ada:	0f 84 a2 01 00 00    	je     80105c82 <trap+0x252>
80105ae0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105ae4:	0f 84 98 01 00 00    	je     80105c82 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105aea:	0f 20 d1             	mov    %cr2,%ecx
80105aed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105af0:	e8 6b df ff ff       	call   80103a60 <cpuid>
80105af5:	8b 73 30             	mov    0x30(%ebx),%esi
80105af8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105afb:	8b 43 34             	mov    0x34(%ebx),%eax
80105afe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105b01:	e8 7a df ff ff       	call   80103a80 <myproc>
80105b06:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105b09:	e8 72 df ff ff       	call   80103a80 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b0e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105b11:	51                   	push   %ecx
80105b12:	57                   	push   %edi
80105b13:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105b16:	52                   	push   %edx
80105b17:	ff 75 e4             	push   -0x1c(%ebp)
80105b1a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105b1b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105b1e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b21:	56                   	push   %esi
80105b22:	ff 70 10             	push   0x10(%eax)
80105b25:	68 14 79 10 80       	push   $0x80107914
80105b2a:	e8 81 ab ff ff       	call   801006b0 <cprintf>
    myproc()->killed = 1;
80105b2f:	83 c4 20             	add    $0x20,%esp
80105b32:	e8 49 df ff ff       	call   80103a80 <myproc>
80105b37:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b3e:	e8 3d df ff ff       	call   80103a80 <myproc>
80105b43:	85 c0                	test   %eax,%eax
80105b45:	0f 85 28 ff ff ff    	jne    80105a73 <trap+0x43>
80105b4b:	e9 3d ff ff ff       	jmp    80105a8d <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80105b50:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105b54:	0f 85 4b ff ff ff    	jne    80105aa5 <trap+0x75>
    yield();
80105b5a:	e8 91 e5 ff ff       	call   801040f0 <yield>
80105b5f:	e9 41 ff ff ff       	jmp    80105aa5 <trap+0x75>
80105b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b68:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b6b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b6f:	e8 ec de ff ff       	call   80103a60 <cpuid>
80105b74:	57                   	push   %edi
80105b75:	56                   	push   %esi
80105b76:	50                   	push   %eax
80105b77:	68 bc 78 10 80       	push   $0x801078bc
80105b7c:	e8 2f ab ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80105b81:	e8 8a ce ff ff       	call   80102a10 <lapiceoi>
    break;
80105b86:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b89:	e8 f2 de ff ff       	call   80103a80 <myproc>
80105b8e:	85 c0                	test   %eax,%eax
80105b90:	0f 85 dd fe ff ff    	jne    80105a73 <trap+0x43>
80105b96:	e9 f2 fe ff ff       	jmp    80105a8d <trap+0x5d>
80105b9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105ba0:	e8 db de ff ff       	call   80103a80 <myproc>
80105ba5:	8b 70 24             	mov    0x24(%eax),%esi
80105ba8:	85 f6                	test   %esi,%esi
80105baa:	0f 85 c8 00 00 00    	jne    80105c78 <trap+0x248>
    myproc()->tf = tf;
80105bb0:	e8 cb de ff ff       	call   80103a80 <myproc>
80105bb5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105bb8:	e8 f3 ef ff ff       	call   80104bb0 <syscall>
    if(myproc()->killed)
80105bbd:	e8 be de ff ff       	call   80103a80 <myproc>
80105bc2:	8b 48 24             	mov    0x24(%eax),%ecx
80105bc5:	85 c9                	test   %ecx,%ecx
80105bc7:	0f 84 fb fe ff ff    	je     80105ac8 <trap+0x98>
}
80105bcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bd0:	5b                   	pop    %ebx
80105bd1:	5e                   	pop    %esi
80105bd2:	5f                   	pop    %edi
80105bd3:	5d                   	pop    %ebp
      exit();
80105bd4:	e9 b7 e2 ff ff       	jmp    80103e90 <exit>
80105bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105be0:	e8 4b 02 00 00       	call   80105e30 <uartintr>
    lapiceoi();
80105be5:	e8 26 ce ff ff       	call   80102a10 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bea:	e8 91 de ff ff       	call   80103a80 <myproc>
80105bef:	85 c0                	test   %eax,%eax
80105bf1:	0f 85 7c fe ff ff    	jne    80105a73 <trap+0x43>
80105bf7:	e9 91 fe ff ff       	jmp    80105a8d <trap+0x5d>
80105bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105c00:	e8 db cc ff ff       	call   801028e0 <kbdintr>
    lapiceoi();
80105c05:	e8 06 ce ff ff       	call   80102a10 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c0a:	e8 71 de ff ff       	call   80103a80 <myproc>
80105c0f:	85 c0                	test   %eax,%eax
80105c11:	0f 85 5c fe ff ff    	jne    80105a73 <trap+0x43>
80105c17:	e9 71 fe ff ff       	jmp    80105a8d <trap+0x5d>
80105c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105c20:	e8 3b de ff ff       	call   80103a60 <cpuid>
80105c25:	85 c0                	test   %eax,%eax
80105c27:	0f 85 38 fe ff ff    	jne    80105a65 <trap+0x35>
      acquire(&tickslock);
80105c2d:	83 ec 0c             	sub    $0xc,%esp
80105c30:	68 80 3c 11 80       	push   $0x80113c80
80105c35:	e8 86 ea ff ff       	call   801046c0 <acquire>
      ticks++;
80105c3a:	83 05 60 3c 11 80 01 	addl   $0x1,0x80113c60
      wakeup(&ticks);
80105c41:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
80105c48:	e8 b3 e5 ff ff       	call   80104200 <wakeup>
      release(&tickslock);
80105c4d:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105c54:	e8 07 ea ff ff       	call   80104660 <release>
80105c59:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105c5c:	e9 04 fe ff ff       	jmp    80105a65 <trap+0x35>
80105c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105c68:	e8 23 e2 ff ff       	call   80103e90 <exit>
80105c6d:	e9 1b fe ff ff       	jmp    80105a8d <trap+0x5d>
80105c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105c78:	e8 13 e2 ff ff       	call   80103e90 <exit>
80105c7d:	e9 2e ff ff ff       	jmp    80105bb0 <trap+0x180>
80105c82:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c85:	e8 d6 dd ff ff       	call   80103a60 <cpuid>
80105c8a:	83 ec 0c             	sub    $0xc,%esp
80105c8d:	56                   	push   %esi
80105c8e:	57                   	push   %edi
80105c8f:	50                   	push   %eax
80105c90:	ff 73 30             	push   0x30(%ebx)
80105c93:	68 e0 78 10 80       	push   $0x801078e0
80105c98:	e8 13 aa ff ff       	call   801006b0 <cprintf>
      panic("trap");
80105c9d:	83 c4 14             	add    $0x14,%esp
80105ca0:	68 73 76 10 80       	push   $0x80107673
80105ca5:	e8 d6 a6 ff ff       	call   80100380 <panic>
80105caa:	66 90                	xchg   %ax,%ax
80105cac:	66 90                	xchg   %ax,%ax
80105cae:	66 90                	xchg   %ax,%ax

80105cb0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105cb0:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105cb5:	85 c0                	test   %eax,%eax
80105cb7:	74 17                	je     80105cd0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cb9:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cbe:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105cbf:	a8 01                	test   $0x1,%al
80105cc1:	74 0d                	je     80105cd0 <uartgetc+0x20>
80105cc3:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cc8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105cc9:	0f b6 c0             	movzbl %al,%eax
80105ccc:	c3                   	ret
80105ccd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cd5:	c3                   	ret
80105cd6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cdd:	00 
80105cde:	66 90                	xchg   %ax,%ax

80105ce0 <uartinit>:
{
80105ce0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ce1:	31 c9                	xor    %ecx,%ecx
80105ce3:	89 c8                	mov    %ecx,%eax
80105ce5:	89 e5                	mov    %esp,%ebp
80105ce7:	57                   	push   %edi
80105ce8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105ced:	56                   	push   %esi
80105cee:	89 fa                	mov    %edi,%edx
80105cf0:	53                   	push   %ebx
80105cf1:	83 ec 1c             	sub    $0x1c,%esp
80105cf4:	ee                   	out    %al,(%dx)
80105cf5:	be fb 03 00 00       	mov    $0x3fb,%esi
80105cfa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105cff:	89 f2                	mov    %esi,%edx
80105d01:	ee                   	out    %al,(%dx)
80105d02:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d07:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d0c:	ee                   	out    %al,(%dx)
80105d0d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105d12:	89 c8                	mov    %ecx,%eax
80105d14:	89 da                	mov    %ebx,%edx
80105d16:	ee                   	out    %al,(%dx)
80105d17:	b8 03 00 00 00       	mov    $0x3,%eax
80105d1c:	89 f2                	mov    %esi,%edx
80105d1e:	ee                   	out    %al,(%dx)
80105d1f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d24:	89 c8                	mov    %ecx,%eax
80105d26:	ee                   	out    %al,(%dx)
80105d27:	b8 01 00 00 00       	mov    $0x1,%eax
80105d2c:	89 da                	mov    %ebx,%edx
80105d2e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d2f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d34:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105d35:	3c ff                	cmp    $0xff,%al
80105d37:	0f 84 7c 00 00 00    	je     80105db9 <uartinit+0xd9>
  uart = 1;
80105d3d:	c7 05 c0 44 11 80 01 	movl   $0x1,0x801144c0
80105d44:	00 00 00 
80105d47:	89 fa                	mov    %edi,%edx
80105d49:	ec                   	in     (%dx),%al
80105d4a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d4f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105d50:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105d53:	bf 78 76 10 80       	mov    $0x80107678,%edi
80105d58:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105d5d:	6a 00                	push   $0x0
80105d5f:	6a 04                	push   $0x4
80105d61:	e8 1a c8 ff ff       	call   80102580 <ioapicenable>
80105d66:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105d69:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80105d6d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80105d70:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105d75:	85 c0                	test   %eax,%eax
80105d77:	74 32                	je     80105dab <uartinit+0xcb>
80105d79:	89 f2                	mov    %esi,%edx
80105d7b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d7c:	a8 20                	test   $0x20,%al
80105d7e:	75 21                	jne    80105da1 <uartinit+0xc1>
80105d80:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d85:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105d88:	83 ec 0c             	sub    $0xc,%esp
80105d8b:	6a 0a                	push   $0xa
80105d8d:	e8 9e cc ff ff       	call   80102a30 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d92:	83 c4 10             	add    $0x10,%esp
80105d95:	83 eb 01             	sub    $0x1,%ebx
80105d98:	74 07                	je     80105da1 <uartinit+0xc1>
80105d9a:	89 f2                	mov    %esi,%edx
80105d9c:	ec                   	in     (%dx),%al
80105d9d:	a8 20                	test   $0x20,%al
80105d9f:	74 e7                	je     80105d88 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105da1:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105da6:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105daa:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105dab:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105daf:	83 c7 01             	add    $0x1,%edi
80105db2:	88 45 e7             	mov    %al,-0x19(%ebp)
80105db5:	84 c0                	test   %al,%al
80105db7:	75 b7                	jne    80105d70 <uartinit+0x90>
}
80105db9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dbc:	5b                   	pop    %ebx
80105dbd:	5e                   	pop    %esi
80105dbe:	5f                   	pop    %edi
80105dbf:	5d                   	pop    %ebp
80105dc0:	c3                   	ret
80105dc1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105dc8:	00 
80105dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105dd0 <uartputc>:
  if(!uart)
80105dd0:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105dd5:	85 c0                	test   %eax,%eax
80105dd7:	74 4f                	je     80105e28 <uartputc+0x58>
{
80105dd9:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105dda:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ddf:	89 e5                	mov    %esp,%ebp
80105de1:	56                   	push   %esi
80105de2:	53                   	push   %ebx
80105de3:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105de4:	a8 20                	test   $0x20,%al
80105de6:	75 29                	jne    80105e11 <uartputc+0x41>
80105de8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105ded:	be fd 03 00 00       	mov    $0x3fd,%esi
80105df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80105df8:	83 ec 0c             	sub    $0xc,%esp
80105dfb:	6a 0a                	push   $0xa
80105dfd:	e8 2e cc ff ff       	call   80102a30 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e02:	83 c4 10             	add    $0x10,%esp
80105e05:	83 eb 01             	sub    $0x1,%ebx
80105e08:	74 07                	je     80105e11 <uartputc+0x41>
80105e0a:	89 f2                	mov    %esi,%edx
80105e0c:	ec                   	in     (%dx),%al
80105e0d:	a8 20                	test   $0x20,%al
80105e0f:	74 e7                	je     80105df8 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e11:	8b 45 08             	mov    0x8(%ebp),%eax
80105e14:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e19:	ee                   	out    %al,(%dx)
}
80105e1a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105e1d:	5b                   	pop    %ebx
80105e1e:	5e                   	pop    %esi
80105e1f:	5d                   	pop    %ebp
80105e20:	c3                   	ret
80105e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e28:	c3                   	ret
80105e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e30 <uartintr>:

void
uartintr(void)
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e36:	68 b0 5c 10 80       	push   $0x80105cb0
80105e3b:	e8 60 aa ff ff       	call   801008a0 <consoleintr>
}
80105e40:	83 c4 10             	add    $0x10,%esp
80105e43:	c9                   	leave
80105e44:	c3                   	ret

80105e45 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e45:	6a 00                	push   $0x0
  pushl $0
80105e47:	6a 00                	push   $0x0
  jmp alltraps
80105e49:	e9 0c fb ff ff       	jmp    8010595a <alltraps>

80105e4e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e4e:	6a 00                	push   $0x0
  pushl $1
80105e50:	6a 01                	push   $0x1
  jmp alltraps
80105e52:	e9 03 fb ff ff       	jmp    8010595a <alltraps>

80105e57 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e57:	6a 00                	push   $0x0
  pushl $2
80105e59:	6a 02                	push   $0x2
  jmp alltraps
80105e5b:	e9 fa fa ff ff       	jmp    8010595a <alltraps>

80105e60 <vector3>:
.globl vector3
vector3:
  pushl $0
80105e60:	6a 00                	push   $0x0
  pushl $3
80105e62:	6a 03                	push   $0x3
  jmp alltraps
80105e64:	e9 f1 fa ff ff       	jmp    8010595a <alltraps>

80105e69 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e69:	6a 00                	push   $0x0
  pushl $4
80105e6b:	6a 04                	push   $0x4
  jmp alltraps
80105e6d:	e9 e8 fa ff ff       	jmp    8010595a <alltraps>

80105e72 <vector5>:
.globl vector5
vector5:
  pushl $0
80105e72:	6a 00                	push   $0x0
  pushl $5
80105e74:	6a 05                	push   $0x5
  jmp alltraps
80105e76:	e9 df fa ff ff       	jmp    8010595a <alltraps>

80105e7b <vector6>:
.globl vector6
vector6:
  pushl $0
80105e7b:	6a 00                	push   $0x0
  pushl $6
80105e7d:	6a 06                	push   $0x6
  jmp alltraps
80105e7f:	e9 d6 fa ff ff       	jmp    8010595a <alltraps>

80105e84 <vector7>:
.globl vector7
vector7:
  pushl $0
80105e84:	6a 00                	push   $0x0
  pushl $7
80105e86:	6a 07                	push   $0x7
  jmp alltraps
80105e88:	e9 cd fa ff ff       	jmp    8010595a <alltraps>

80105e8d <vector8>:
.globl vector8
vector8:
  pushl $8
80105e8d:	6a 08                	push   $0x8
  jmp alltraps
80105e8f:	e9 c6 fa ff ff       	jmp    8010595a <alltraps>

80105e94 <vector9>:
.globl vector9
vector9:
  pushl $0
80105e94:	6a 00                	push   $0x0
  pushl $9
80105e96:	6a 09                	push   $0x9
  jmp alltraps
80105e98:	e9 bd fa ff ff       	jmp    8010595a <alltraps>

80105e9d <vector10>:
.globl vector10
vector10:
  pushl $10
80105e9d:	6a 0a                	push   $0xa
  jmp alltraps
80105e9f:	e9 b6 fa ff ff       	jmp    8010595a <alltraps>

80105ea4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105ea4:	6a 0b                	push   $0xb
  jmp alltraps
80105ea6:	e9 af fa ff ff       	jmp    8010595a <alltraps>

80105eab <vector12>:
.globl vector12
vector12:
  pushl $12
80105eab:	6a 0c                	push   $0xc
  jmp alltraps
80105ead:	e9 a8 fa ff ff       	jmp    8010595a <alltraps>

80105eb2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105eb2:	6a 0d                	push   $0xd
  jmp alltraps
80105eb4:	e9 a1 fa ff ff       	jmp    8010595a <alltraps>

80105eb9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105eb9:	6a 0e                	push   $0xe
  jmp alltraps
80105ebb:	e9 9a fa ff ff       	jmp    8010595a <alltraps>

80105ec0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105ec0:	6a 00                	push   $0x0
  pushl $15
80105ec2:	6a 0f                	push   $0xf
  jmp alltraps
80105ec4:	e9 91 fa ff ff       	jmp    8010595a <alltraps>

80105ec9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105ec9:	6a 00                	push   $0x0
  pushl $16
80105ecb:	6a 10                	push   $0x10
  jmp alltraps
80105ecd:	e9 88 fa ff ff       	jmp    8010595a <alltraps>

80105ed2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105ed2:	6a 11                	push   $0x11
  jmp alltraps
80105ed4:	e9 81 fa ff ff       	jmp    8010595a <alltraps>

80105ed9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105ed9:	6a 00                	push   $0x0
  pushl $18
80105edb:	6a 12                	push   $0x12
  jmp alltraps
80105edd:	e9 78 fa ff ff       	jmp    8010595a <alltraps>

80105ee2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105ee2:	6a 00                	push   $0x0
  pushl $19
80105ee4:	6a 13                	push   $0x13
  jmp alltraps
80105ee6:	e9 6f fa ff ff       	jmp    8010595a <alltraps>

80105eeb <vector20>:
.globl vector20
vector20:
  pushl $0
80105eeb:	6a 00                	push   $0x0
  pushl $20
80105eed:	6a 14                	push   $0x14
  jmp alltraps
80105eef:	e9 66 fa ff ff       	jmp    8010595a <alltraps>

80105ef4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105ef4:	6a 00                	push   $0x0
  pushl $21
80105ef6:	6a 15                	push   $0x15
  jmp alltraps
80105ef8:	e9 5d fa ff ff       	jmp    8010595a <alltraps>

80105efd <vector22>:
.globl vector22
vector22:
  pushl $0
80105efd:	6a 00                	push   $0x0
  pushl $22
80105eff:	6a 16                	push   $0x16
  jmp alltraps
80105f01:	e9 54 fa ff ff       	jmp    8010595a <alltraps>

80105f06 <vector23>:
.globl vector23
vector23:
  pushl $0
80105f06:	6a 00                	push   $0x0
  pushl $23
80105f08:	6a 17                	push   $0x17
  jmp alltraps
80105f0a:	e9 4b fa ff ff       	jmp    8010595a <alltraps>

80105f0f <vector24>:
.globl vector24
vector24:
  pushl $0
80105f0f:	6a 00                	push   $0x0
  pushl $24
80105f11:	6a 18                	push   $0x18
  jmp alltraps
80105f13:	e9 42 fa ff ff       	jmp    8010595a <alltraps>

80105f18 <vector25>:
.globl vector25
vector25:
  pushl $0
80105f18:	6a 00                	push   $0x0
  pushl $25
80105f1a:	6a 19                	push   $0x19
  jmp alltraps
80105f1c:	e9 39 fa ff ff       	jmp    8010595a <alltraps>

80105f21 <vector26>:
.globl vector26
vector26:
  pushl $0
80105f21:	6a 00                	push   $0x0
  pushl $26
80105f23:	6a 1a                	push   $0x1a
  jmp alltraps
80105f25:	e9 30 fa ff ff       	jmp    8010595a <alltraps>

80105f2a <vector27>:
.globl vector27
vector27:
  pushl $0
80105f2a:	6a 00                	push   $0x0
  pushl $27
80105f2c:	6a 1b                	push   $0x1b
  jmp alltraps
80105f2e:	e9 27 fa ff ff       	jmp    8010595a <alltraps>

80105f33 <vector28>:
.globl vector28
vector28:
  pushl $0
80105f33:	6a 00                	push   $0x0
  pushl $28
80105f35:	6a 1c                	push   $0x1c
  jmp alltraps
80105f37:	e9 1e fa ff ff       	jmp    8010595a <alltraps>

80105f3c <vector29>:
.globl vector29
vector29:
  pushl $0
80105f3c:	6a 00                	push   $0x0
  pushl $29
80105f3e:	6a 1d                	push   $0x1d
  jmp alltraps
80105f40:	e9 15 fa ff ff       	jmp    8010595a <alltraps>

80105f45 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f45:	6a 00                	push   $0x0
  pushl $30
80105f47:	6a 1e                	push   $0x1e
  jmp alltraps
80105f49:	e9 0c fa ff ff       	jmp    8010595a <alltraps>

80105f4e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f4e:	6a 00                	push   $0x0
  pushl $31
80105f50:	6a 1f                	push   $0x1f
  jmp alltraps
80105f52:	e9 03 fa ff ff       	jmp    8010595a <alltraps>

80105f57 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f57:	6a 00                	push   $0x0
  pushl $32
80105f59:	6a 20                	push   $0x20
  jmp alltraps
80105f5b:	e9 fa f9 ff ff       	jmp    8010595a <alltraps>

80105f60 <vector33>:
.globl vector33
vector33:
  pushl $0
80105f60:	6a 00                	push   $0x0
  pushl $33
80105f62:	6a 21                	push   $0x21
  jmp alltraps
80105f64:	e9 f1 f9 ff ff       	jmp    8010595a <alltraps>

80105f69 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f69:	6a 00                	push   $0x0
  pushl $34
80105f6b:	6a 22                	push   $0x22
  jmp alltraps
80105f6d:	e9 e8 f9 ff ff       	jmp    8010595a <alltraps>

80105f72 <vector35>:
.globl vector35
vector35:
  pushl $0
80105f72:	6a 00                	push   $0x0
  pushl $35
80105f74:	6a 23                	push   $0x23
  jmp alltraps
80105f76:	e9 df f9 ff ff       	jmp    8010595a <alltraps>

80105f7b <vector36>:
.globl vector36
vector36:
  pushl $0
80105f7b:	6a 00                	push   $0x0
  pushl $36
80105f7d:	6a 24                	push   $0x24
  jmp alltraps
80105f7f:	e9 d6 f9 ff ff       	jmp    8010595a <alltraps>

80105f84 <vector37>:
.globl vector37
vector37:
  pushl $0
80105f84:	6a 00                	push   $0x0
  pushl $37
80105f86:	6a 25                	push   $0x25
  jmp alltraps
80105f88:	e9 cd f9 ff ff       	jmp    8010595a <alltraps>

80105f8d <vector38>:
.globl vector38
vector38:
  pushl $0
80105f8d:	6a 00                	push   $0x0
  pushl $38
80105f8f:	6a 26                	push   $0x26
  jmp alltraps
80105f91:	e9 c4 f9 ff ff       	jmp    8010595a <alltraps>

80105f96 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f96:	6a 00                	push   $0x0
  pushl $39
80105f98:	6a 27                	push   $0x27
  jmp alltraps
80105f9a:	e9 bb f9 ff ff       	jmp    8010595a <alltraps>

80105f9f <vector40>:
.globl vector40
vector40:
  pushl $0
80105f9f:	6a 00                	push   $0x0
  pushl $40
80105fa1:	6a 28                	push   $0x28
  jmp alltraps
80105fa3:	e9 b2 f9 ff ff       	jmp    8010595a <alltraps>

80105fa8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105fa8:	6a 00                	push   $0x0
  pushl $41
80105faa:	6a 29                	push   $0x29
  jmp alltraps
80105fac:	e9 a9 f9 ff ff       	jmp    8010595a <alltraps>

80105fb1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105fb1:	6a 00                	push   $0x0
  pushl $42
80105fb3:	6a 2a                	push   $0x2a
  jmp alltraps
80105fb5:	e9 a0 f9 ff ff       	jmp    8010595a <alltraps>

80105fba <vector43>:
.globl vector43
vector43:
  pushl $0
80105fba:	6a 00                	push   $0x0
  pushl $43
80105fbc:	6a 2b                	push   $0x2b
  jmp alltraps
80105fbe:	e9 97 f9 ff ff       	jmp    8010595a <alltraps>

80105fc3 <vector44>:
.globl vector44
vector44:
  pushl $0
80105fc3:	6a 00                	push   $0x0
  pushl $44
80105fc5:	6a 2c                	push   $0x2c
  jmp alltraps
80105fc7:	e9 8e f9 ff ff       	jmp    8010595a <alltraps>

80105fcc <vector45>:
.globl vector45
vector45:
  pushl $0
80105fcc:	6a 00                	push   $0x0
  pushl $45
80105fce:	6a 2d                	push   $0x2d
  jmp alltraps
80105fd0:	e9 85 f9 ff ff       	jmp    8010595a <alltraps>

80105fd5 <vector46>:
.globl vector46
vector46:
  pushl $0
80105fd5:	6a 00                	push   $0x0
  pushl $46
80105fd7:	6a 2e                	push   $0x2e
  jmp alltraps
80105fd9:	e9 7c f9 ff ff       	jmp    8010595a <alltraps>

80105fde <vector47>:
.globl vector47
vector47:
  pushl $0
80105fde:	6a 00                	push   $0x0
  pushl $47
80105fe0:	6a 2f                	push   $0x2f
  jmp alltraps
80105fe2:	e9 73 f9 ff ff       	jmp    8010595a <alltraps>

80105fe7 <vector48>:
.globl vector48
vector48:
  pushl $0
80105fe7:	6a 00                	push   $0x0
  pushl $48
80105fe9:	6a 30                	push   $0x30
  jmp alltraps
80105feb:	e9 6a f9 ff ff       	jmp    8010595a <alltraps>

80105ff0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105ff0:	6a 00                	push   $0x0
  pushl $49
80105ff2:	6a 31                	push   $0x31
  jmp alltraps
80105ff4:	e9 61 f9 ff ff       	jmp    8010595a <alltraps>

80105ff9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105ff9:	6a 00                	push   $0x0
  pushl $50
80105ffb:	6a 32                	push   $0x32
  jmp alltraps
80105ffd:	e9 58 f9 ff ff       	jmp    8010595a <alltraps>

80106002 <vector51>:
.globl vector51
vector51:
  pushl $0
80106002:	6a 00                	push   $0x0
  pushl $51
80106004:	6a 33                	push   $0x33
  jmp alltraps
80106006:	e9 4f f9 ff ff       	jmp    8010595a <alltraps>

8010600b <vector52>:
.globl vector52
vector52:
  pushl $0
8010600b:	6a 00                	push   $0x0
  pushl $52
8010600d:	6a 34                	push   $0x34
  jmp alltraps
8010600f:	e9 46 f9 ff ff       	jmp    8010595a <alltraps>

80106014 <vector53>:
.globl vector53
vector53:
  pushl $0
80106014:	6a 00                	push   $0x0
  pushl $53
80106016:	6a 35                	push   $0x35
  jmp alltraps
80106018:	e9 3d f9 ff ff       	jmp    8010595a <alltraps>

8010601d <vector54>:
.globl vector54
vector54:
  pushl $0
8010601d:	6a 00                	push   $0x0
  pushl $54
8010601f:	6a 36                	push   $0x36
  jmp alltraps
80106021:	e9 34 f9 ff ff       	jmp    8010595a <alltraps>

80106026 <vector55>:
.globl vector55
vector55:
  pushl $0
80106026:	6a 00                	push   $0x0
  pushl $55
80106028:	6a 37                	push   $0x37
  jmp alltraps
8010602a:	e9 2b f9 ff ff       	jmp    8010595a <alltraps>

8010602f <vector56>:
.globl vector56
vector56:
  pushl $0
8010602f:	6a 00                	push   $0x0
  pushl $56
80106031:	6a 38                	push   $0x38
  jmp alltraps
80106033:	e9 22 f9 ff ff       	jmp    8010595a <alltraps>

80106038 <vector57>:
.globl vector57
vector57:
  pushl $0
80106038:	6a 00                	push   $0x0
  pushl $57
8010603a:	6a 39                	push   $0x39
  jmp alltraps
8010603c:	e9 19 f9 ff ff       	jmp    8010595a <alltraps>

80106041 <vector58>:
.globl vector58
vector58:
  pushl $0
80106041:	6a 00                	push   $0x0
  pushl $58
80106043:	6a 3a                	push   $0x3a
  jmp alltraps
80106045:	e9 10 f9 ff ff       	jmp    8010595a <alltraps>

8010604a <vector59>:
.globl vector59
vector59:
  pushl $0
8010604a:	6a 00                	push   $0x0
  pushl $59
8010604c:	6a 3b                	push   $0x3b
  jmp alltraps
8010604e:	e9 07 f9 ff ff       	jmp    8010595a <alltraps>

80106053 <vector60>:
.globl vector60
vector60:
  pushl $0
80106053:	6a 00                	push   $0x0
  pushl $60
80106055:	6a 3c                	push   $0x3c
  jmp alltraps
80106057:	e9 fe f8 ff ff       	jmp    8010595a <alltraps>

8010605c <vector61>:
.globl vector61
vector61:
  pushl $0
8010605c:	6a 00                	push   $0x0
  pushl $61
8010605e:	6a 3d                	push   $0x3d
  jmp alltraps
80106060:	e9 f5 f8 ff ff       	jmp    8010595a <alltraps>

80106065 <vector62>:
.globl vector62
vector62:
  pushl $0
80106065:	6a 00                	push   $0x0
  pushl $62
80106067:	6a 3e                	push   $0x3e
  jmp alltraps
80106069:	e9 ec f8 ff ff       	jmp    8010595a <alltraps>

8010606e <vector63>:
.globl vector63
vector63:
  pushl $0
8010606e:	6a 00                	push   $0x0
  pushl $63
80106070:	6a 3f                	push   $0x3f
  jmp alltraps
80106072:	e9 e3 f8 ff ff       	jmp    8010595a <alltraps>

80106077 <vector64>:
.globl vector64
vector64:
  pushl $0
80106077:	6a 00                	push   $0x0
  pushl $64
80106079:	6a 40                	push   $0x40
  jmp alltraps
8010607b:	e9 da f8 ff ff       	jmp    8010595a <alltraps>

80106080 <vector65>:
.globl vector65
vector65:
  pushl $0
80106080:	6a 00                	push   $0x0
  pushl $65
80106082:	6a 41                	push   $0x41
  jmp alltraps
80106084:	e9 d1 f8 ff ff       	jmp    8010595a <alltraps>

80106089 <vector66>:
.globl vector66
vector66:
  pushl $0
80106089:	6a 00                	push   $0x0
  pushl $66
8010608b:	6a 42                	push   $0x42
  jmp alltraps
8010608d:	e9 c8 f8 ff ff       	jmp    8010595a <alltraps>

80106092 <vector67>:
.globl vector67
vector67:
  pushl $0
80106092:	6a 00                	push   $0x0
  pushl $67
80106094:	6a 43                	push   $0x43
  jmp alltraps
80106096:	e9 bf f8 ff ff       	jmp    8010595a <alltraps>

8010609b <vector68>:
.globl vector68
vector68:
  pushl $0
8010609b:	6a 00                	push   $0x0
  pushl $68
8010609d:	6a 44                	push   $0x44
  jmp alltraps
8010609f:	e9 b6 f8 ff ff       	jmp    8010595a <alltraps>

801060a4 <vector69>:
.globl vector69
vector69:
  pushl $0
801060a4:	6a 00                	push   $0x0
  pushl $69
801060a6:	6a 45                	push   $0x45
  jmp alltraps
801060a8:	e9 ad f8 ff ff       	jmp    8010595a <alltraps>

801060ad <vector70>:
.globl vector70
vector70:
  pushl $0
801060ad:	6a 00                	push   $0x0
  pushl $70
801060af:	6a 46                	push   $0x46
  jmp alltraps
801060b1:	e9 a4 f8 ff ff       	jmp    8010595a <alltraps>

801060b6 <vector71>:
.globl vector71
vector71:
  pushl $0
801060b6:	6a 00                	push   $0x0
  pushl $71
801060b8:	6a 47                	push   $0x47
  jmp alltraps
801060ba:	e9 9b f8 ff ff       	jmp    8010595a <alltraps>

801060bf <vector72>:
.globl vector72
vector72:
  pushl $0
801060bf:	6a 00                	push   $0x0
  pushl $72
801060c1:	6a 48                	push   $0x48
  jmp alltraps
801060c3:	e9 92 f8 ff ff       	jmp    8010595a <alltraps>

801060c8 <vector73>:
.globl vector73
vector73:
  pushl $0
801060c8:	6a 00                	push   $0x0
  pushl $73
801060ca:	6a 49                	push   $0x49
  jmp alltraps
801060cc:	e9 89 f8 ff ff       	jmp    8010595a <alltraps>

801060d1 <vector74>:
.globl vector74
vector74:
  pushl $0
801060d1:	6a 00                	push   $0x0
  pushl $74
801060d3:	6a 4a                	push   $0x4a
  jmp alltraps
801060d5:	e9 80 f8 ff ff       	jmp    8010595a <alltraps>

801060da <vector75>:
.globl vector75
vector75:
  pushl $0
801060da:	6a 00                	push   $0x0
  pushl $75
801060dc:	6a 4b                	push   $0x4b
  jmp alltraps
801060de:	e9 77 f8 ff ff       	jmp    8010595a <alltraps>

801060e3 <vector76>:
.globl vector76
vector76:
  pushl $0
801060e3:	6a 00                	push   $0x0
  pushl $76
801060e5:	6a 4c                	push   $0x4c
  jmp alltraps
801060e7:	e9 6e f8 ff ff       	jmp    8010595a <alltraps>

801060ec <vector77>:
.globl vector77
vector77:
  pushl $0
801060ec:	6a 00                	push   $0x0
  pushl $77
801060ee:	6a 4d                	push   $0x4d
  jmp alltraps
801060f0:	e9 65 f8 ff ff       	jmp    8010595a <alltraps>

801060f5 <vector78>:
.globl vector78
vector78:
  pushl $0
801060f5:	6a 00                	push   $0x0
  pushl $78
801060f7:	6a 4e                	push   $0x4e
  jmp alltraps
801060f9:	e9 5c f8 ff ff       	jmp    8010595a <alltraps>

801060fe <vector79>:
.globl vector79
vector79:
  pushl $0
801060fe:	6a 00                	push   $0x0
  pushl $79
80106100:	6a 4f                	push   $0x4f
  jmp alltraps
80106102:	e9 53 f8 ff ff       	jmp    8010595a <alltraps>

80106107 <vector80>:
.globl vector80
vector80:
  pushl $0
80106107:	6a 00                	push   $0x0
  pushl $80
80106109:	6a 50                	push   $0x50
  jmp alltraps
8010610b:	e9 4a f8 ff ff       	jmp    8010595a <alltraps>

80106110 <vector81>:
.globl vector81
vector81:
  pushl $0
80106110:	6a 00                	push   $0x0
  pushl $81
80106112:	6a 51                	push   $0x51
  jmp alltraps
80106114:	e9 41 f8 ff ff       	jmp    8010595a <alltraps>

80106119 <vector82>:
.globl vector82
vector82:
  pushl $0
80106119:	6a 00                	push   $0x0
  pushl $82
8010611b:	6a 52                	push   $0x52
  jmp alltraps
8010611d:	e9 38 f8 ff ff       	jmp    8010595a <alltraps>

80106122 <vector83>:
.globl vector83
vector83:
  pushl $0
80106122:	6a 00                	push   $0x0
  pushl $83
80106124:	6a 53                	push   $0x53
  jmp alltraps
80106126:	e9 2f f8 ff ff       	jmp    8010595a <alltraps>

8010612b <vector84>:
.globl vector84
vector84:
  pushl $0
8010612b:	6a 00                	push   $0x0
  pushl $84
8010612d:	6a 54                	push   $0x54
  jmp alltraps
8010612f:	e9 26 f8 ff ff       	jmp    8010595a <alltraps>

80106134 <vector85>:
.globl vector85
vector85:
  pushl $0
80106134:	6a 00                	push   $0x0
  pushl $85
80106136:	6a 55                	push   $0x55
  jmp alltraps
80106138:	e9 1d f8 ff ff       	jmp    8010595a <alltraps>

8010613d <vector86>:
.globl vector86
vector86:
  pushl $0
8010613d:	6a 00                	push   $0x0
  pushl $86
8010613f:	6a 56                	push   $0x56
  jmp alltraps
80106141:	e9 14 f8 ff ff       	jmp    8010595a <alltraps>

80106146 <vector87>:
.globl vector87
vector87:
  pushl $0
80106146:	6a 00                	push   $0x0
  pushl $87
80106148:	6a 57                	push   $0x57
  jmp alltraps
8010614a:	e9 0b f8 ff ff       	jmp    8010595a <alltraps>

8010614f <vector88>:
.globl vector88
vector88:
  pushl $0
8010614f:	6a 00                	push   $0x0
  pushl $88
80106151:	6a 58                	push   $0x58
  jmp alltraps
80106153:	e9 02 f8 ff ff       	jmp    8010595a <alltraps>

80106158 <vector89>:
.globl vector89
vector89:
  pushl $0
80106158:	6a 00                	push   $0x0
  pushl $89
8010615a:	6a 59                	push   $0x59
  jmp alltraps
8010615c:	e9 f9 f7 ff ff       	jmp    8010595a <alltraps>

80106161 <vector90>:
.globl vector90
vector90:
  pushl $0
80106161:	6a 00                	push   $0x0
  pushl $90
80106163:	6a 5a                	push   $0x5a
  jmp alltraps
80106165:	e9 f0 f7 ff ff       	jmp    8010595a <alltraps>

8010616a <vector91>:
.globl vector91
vector91:
  pushl $0
8010616a:	6a 00                	push   $0x0
  pushl $91
8010616c:	6a 5b                	push   $0x5b
  jmp alltraps
8010616e:	e9 e7 f7 ff ff       	jmp    8010595a <alltraps>

80106173 <vector92>:
.globl vector92
vector92:
  pushl $0
80106173:	6a 00                	push   $0x0
  pushl $92
80106175:	6a 5c                	push   $0x5c
  jmp alltraps
80106177:	e9 de f7 ff ff       	jmp    8010595a <alltraps>

8010617c <vector93>:
.globl vector93
vector93:
  pushl $0
8010617c:	6a 00                	push   $0x0
  pushl $93
8010617e:	6a 5d                	push   $0x5d
  jmp alltraps
80106180:	e9 d5 f7 ff ff       	jmp    8010595a <alltraps>

80106185 <vector94>:
.globl vector94
vector94:
  pushl $0
80106185:	6a 00                	push   $0x0
  pushl $94
80106187:	6a 5e                	push   $0x5e
  jmp alltraps
80106189:	e9 cc f7 ff ff       	jmp    8010595a <alltraps>

8010618e <vector95>:
.globl vector95
vector95:
  pushl $0
8010618e:	6a 00                	push   $0x0
  pushl $95
80106190:	6a 5f                	push   $0x5f
  jmp alltraps
80106192:	e9 c3 f7 ff ff       	jmp    8010595a <alltraps>

80106197 <vector96>:
.globl vector96
vector96:
  pushl $0
80106197:	6a 00                	push   $0x0
  pushl $96
80106199:	6a 60                	push   $0x60
  jmp alltraps
8010619b:	e9 ba f7 ff ff       	jmp    8010595a <alltraps>

801061a0 <vector97>:
.globl vector97
vector97:
  pushl $0
801061a0:	6a 00                	push   $0x0
  pushl $97
801061a2:	6a 61                	push   $0x61
  jmp alltraps
801061a4:	e9 b1 f7 ff ff       	jmp    8010595a <alltraps>

801061a9 <vector98>:
.globl vector98
vector98:
  pushl $0
801061a9:	6a 00                	push   $0x0
  pushl $98
801061ab:	6a 62                	push   $0x62
  jmp alltraps
801061ad:	e9 a8 f7 ff ff       	jmp    8010595a <alltraps>

801061b2 <vector99>:
.globl vector99
vector99:
  pushl $0
801061b2:	6a 00                	push   $0x0
  pushl $99
801061b4:	6a 63                	push   $0x63
  jmp alltraps
801061b6:	e9 9f f7 ff ff       	jmp    8010595a <alltraps>

801061bb <vector100>:
.globl vector100
vector100:
  pushl $0
801061bb:	6a 00                	push   $0x0
  pushl $100
801061bd:	6a 64                	push   $0x64
  jmp alltraps
801061bf:	e9 96 f7 ff ff       	jmp    8010595a <alltraps>

801061c4 <vector101>:
.globl vector101
vector101:
  pushl $0
801061c4:	6a 00                	push   $0x0
  pushl $101
801061c6:	6a 65                	push   $0x65
  jmp alltraps
801061c8:	e9 8d f7 ff ff       	jmp    8010595a <alltraps>

801061cd <vector102>:
.globl vector102
vector102:
  pushl $0
801061cd:	6a 00                	push   $0x0
  pushl $102
801061cf:	6a 66                	push   $0x66
  jmp alltraps
801061d1:	e9 84 f7 ff ff       	jmp    8010595a <alltraps>

801061d6 <vector103>:
.globl vector103
vector103:
  pushl $0
801061d6:	6a 00                	push   $0x0
  pushl $103
801061d8:	6a 67                	push   $0x67
  jmp alltraps
801061da:	e9 7b f7 ff ff       	jmp    8010595a <alltraps>

801061df <vector104>:
.globl vector104
vector104:
  pushl $0
801061df:	6a 00                	push   $0x0
  pushl $104
801061e1:	6a 68                	push   $0x68
  jmp alltraps
801061e3:	e9 72 f7 ff ff       	jmp    8010595a <alltraps>

801061e8 <vector105>:
.globl vector105
vector105:
  pushl $0
801061e8:	6a 00                	push   $0x0
  pushl $105
801061ea:	6a 69                	push   $0x69
  jmp alltraps
801061ec:	e9 69 f7 ff ff       	jmp    8010595a <alltraps>

801061f1 <vector106>:
.globl vector106
vector106:
  pushl $0
801061f1:	6a 00                	push   $0x0
  pushl $106
801061f3:	6a 6a                	push   $0x6a
  jmp alltraps
801061f5:	e9 60 f7 ff ff       	jmp    8010595a <alltraps>

801061fa <vector107>:
.globl vector107
vector107:
  pushl $0
801061fa:	6a 00                	push   $0x0
  pushl $107
801061fc:	6a 6b                	push   $0x6b
  jmp alltraps
801061fe:	e9 57 f7 ff ff       	jmp    8010595a <alltraps>

80106203 <vector108>:
.globl vector108
vector108:
  pushl $0
80106203:	6a 00                	push   $0x0
  pushl $108
80106205:	6a 6c                	push   $0x6c
  jmp alltraps
80106207:	e9 4e f7 ff ff       	jmp    8010595a <alltraps>

8010620c <vector109>:
.globl vector109
vector109:
  pushl $0
8010620c:	6a 00                	push   $0x0
  pushl $109
8010620e:	6a 6d                	push   $0x6d
  jmp alltraps
80106210:	e9 45 f7 ff ff       	jmp    8010595a <alltraps>

80106215 <vector110>:
.globl vector110
vector110:
  pushl $0
80106215:	6a 00                	push   $0x0
  pushl $110
80106217:	6a 6e                	push   $0x6e
  jmp alltraps
80106219:	e9 3c f7 ff ff       	jmp    8010595a <alltraps>

8010621e <vector111>:
.globl vector111
vector111:
  pushl $0
8010621e:	6a 00                	push   $0x0
  pushl $111
80106220:	6a 6f                	push   $0x6f
  jmp alltraps
80106222:	e9 33 f7 ff ff       	jmp    8010595a <alltraps>

80106227 <vector112>:
.globl vector112
vector112:
  pushl $0
80106227:	6a 00                	push   $0x0
  pushl $112
80106229:	6a 70                	push   $0x70
  jmp alltraps
8010622b:	e9 2a f7 ff ff       	jmp    8010595a <alltraps>

80106230 <vector113>:
.globl vector113
vector113:
  pushl $0
80106230:	6a 00                	push   $0x0
  pushl $113
80106232:	6a 71                	push   $0x71
  jmp alltraps
80106234:	e9 21 f7 ff ff       	jmp    8010595a <alltraps>

80106239 <vector114>:
.globl vector114
vector114:
  pushl $0
80106239:	6a 00                	push   $0x0
  pushl $114
8010623b:	6a 72                	push   $0x72
  jmp alltraps
8010623d:	e9 18 f7 ff ff       	jmp    8010595a <alltraps>

80106242 <vector115>:
.globl vector115
vector115:
  pushl $0
80106242:	6a 00                	push   $0x0
  pushl $115
80106244:	6a 73                	push   $0x73
  jmp alltraps
80106246:	e9 0f f7 ff ff       	jmp    8010595a <alltraps>

8010624b <vector116>:
.globl vector116
vector116:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $116
8010624d:	6a 74                	push   $0x74
  jmp alltraps
8010624f:	e9 06 f7 ff ff       	jmp    8010595a <alltraps>

80106254 <vector117>:
.globl vector117
vector117:
  pushl $0
80106254:	6a 00                	push   $0x0
  pushl $117
80106256:	6a 75                	push   $0x75
  jmp alltraps
80106258:	e9 fd f6 ff ff       	jmp    8010595a <alltraps>

8010625d <vector118>:
.globl vector118
vector118:
  pushl $0
8010625d:	6a 00                	push   $0x0
  pushl $118
8010625f:	6a 76                	push   $0x76
  jmp alltraps
80106261:	e9 f4 f6 ff ff       	jmp    8010595a <alltraps>

80106266 <vector119>:
.globl vector119
vector119:
  pushl $0
80106266:	6a 00                	push   $0x0
  pushl $119
80106268:	6a 77                	push   $0x77
  jmp alltraps
8010626a:	e9 eb f6 ff ff       	jmp    8010595a <alltraps>

8010626f <vector120>:
.globl vector120
vector120:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $120
80106271:	6a 78                	push   $0x78
  jmp alltraps
80106273:	e9 e2 f6 ff ff       	jmp    8010595a <alltraps>

80106278 <vector121>:
.globl vector121
vector121:
  pushl $0
80106278:	6a 00                	push   $0x0
  pushl $121
8010627a:	6a 79                	push   $0x79
  jmp alltraps
8010627c:	e9 d9 f6 ff ff       	jmp    8010595a <alltraps>

80106281 <vector122>:
.globl vector122
vector122:
  pushl $0
80106281:	6a 00                	push   $0x0
  pushl $122
80106283:	6a 7a                	push   $0x7a
  jmp alltraps
80106285:	e9 d0 f6 ff ff       	jmp    8010595a <alltraps>

8010628a <vector123>:
.globl vector123
vector123:
  pushl $0
8010628a:	6a 00                	push   $0x0
  pushl $123
8010628c:	6a 7b                	push   $0x7b
  jmp alltraps
8010628e:	e9 c7 f6 ff ff       	jmp    8010595a <alltraps>

80106293 <vector124>:
.globl vector124
vector124:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $124
80106295:	6a 7c                	push   $0x7c
  jmp alltraps
80106297:	e9 be f6 ff ff       	jmp    8010595a <alltraps>

8010629c <vector125>:
.globl vector125
vector125:
  pushl $0
8010629c:	6a 00                	push   $0x0
  pushl $125
8010629e:	6a 7d                	push   $0x7d
  jmp alltraps
801062a0:	e9 b5 f6 ff ff       	jmp    8010595a <alltraps>

801062a5 <vector126>:
.globl vector126
vector126:
  pushl $0
801062a5:	6a 00                	push   $0x0
  pushl $126
801062a7:	6a 7e                	push   $0x7e
  jmp alltraps
801062a9:	e9 ac f6 ff ff       	jmp    8010595a <alltraps>

801062ae <vector127>:
.globl vector127
vector127:
  pushl $0
801062ae:	6a 00                	push   $0x0
  pushl $127
801062b0:	6a 7f                	push   $0x7f
  jmp alltraps
801062b2:	e9 a3 f6 ff ff       	jmp    8010595a <alltraps>

801062b7 <vector128>:
.globl vector128
vector128:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $128
801062b9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801062be:	e9 97 f6 ff ff       	jmp    8010595a <alltraps>

801062c3 <vector129>:
.globl vector129
vector129:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $129
801062c5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801062ca:	e9 8b f6 ff ff       	jmp    8010595a <alltraps>

801062cf <vector130>:
.globl vector130
vector130:
  pushl $0
801062cf:	6a 00                	push   $0x0
  pushl $130
801062d1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801062d6:	e9 7f f6 ff ff       	jmp    8010595a <alltraps>

801062db <vector131>:
.globl vector131
vector131:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $131
801062dd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801062e2:	e9 73 f6 ff ff       	jmp    8010595a <alltraps>

801062e7 <vector132>:
.globl vector132
vector132:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $132
801062e9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801062ee:	e9 67 f6 ff ff       	jmp    8010595a <alltraps>

801062f3 <vector133>:
.globl vector133
vector133:
  pushl $0
801062f3:	6a 00                	push   $0x0
  pushl $133
801062f5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801062fa:	e9 5b f6 ff ff       	jmp    8010595a <alltraps>

801062ff <vector134>:
.globl vector134
vector134:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $134
80106301:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106306:	e9 4f f6 ff ff       	jmp    8010595a <alltraps>

8010630b <vector135>:
.globl vector135
vector135:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $135
8010630d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106312:	e9 43 f6 ff ff       	jmp    8010595a <alltraps>

80106317 <vector136>:
.globl vector136
vector136:
  pushl $0
80106317:	6a 00                	push   $0x0
  pushl $136
80106319:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010631e:	e9 37 f6 ff ff       	jmp    8010595a <alltraps>

80106323 <vector137>:
.globl vector137
vector137:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $137
80106325:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010632a:	e9 2b f6 ff ff       	jmp    8010595a <alltraps>

8010632f <vector138>:
.globl vector138
vector138:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $138
80106331:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106336:	e9 1f f6 ff ff       	jmp    8010595a <alltraps>

8010633b <vector139>:
.globl vector139
vector139:
  pushl $0
8010633b:	6a 00                	push   $0x0
  pushl $139
8010633d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106342:	e9 13 f6 ff ff       	jmp    8010595a <alltraps>

80106347 <vector140>:
.globl vector140
vector140:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $140
80106349:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010634e:	e9 07 f6 ff ff       	jmp    8010595a <alltraps>

80106353 <vector141>:
.globl vector141
vector141:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $141
80106355:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010635a:	e9 fb f5 ff ff       	jmp    8010595a <alltraps>

8010635f <vector142>:
.globl vector142
vector142:
  pushl $0
8010635f:	6a 00                	push   $0x0
  pushl $142
80106361:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106366:	e9 ef f5 ff ff       	jmp    8010595a <alltraps>

8010636b <vector143>:
.globl vector143
vector143:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $143
8010636d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106372:	e9 e3 f5 ff ff       	jmp    8010595a <alltraps>

80106377 <vector144>:
.globl vector144
vector144:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $144
80106379:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010637e:	e9 d7 f5 ff ff       	jmp    8010595a <alltraps>

80106383 <vector145>:
.globl vector145
vector145:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $145
80106385:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010638a:	e9 cb f5 ff ff       	jmp    8010595a <alltraps>

8010638f <vector146>:
.globl vector146
vector146:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $146
80106391:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106396:	e9 bf f5 ff ff       	jmp    8010595a <alltraps>

8010639b <vector147>:
.globl vector147
vector147:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $147
8010639d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801063a2:	e9 b3 f5 ff ff       	jmp    8010595a <alltraps>

801063a7 <vector148>:
.globl vector148
vector148:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $148
801063a9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801063ae:	e9 a7 f5 ff ff       	jmp    8010595a <alltraps>

801063b3 <vector149>:
.globl vector149
vector149:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $149
801063b5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801063ba:	e9 9b f5 ff ff       	jmp    8010595a <alltraps>

801063bf <vector150>:
.globl vector150
vector150:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $150
801063c1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801063c6:	e9 8f f5 ff ff       	jmp    8010595a <alltraps>

801063cb <vector151>:
.globl vector151
vector151:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $151
801063cd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801063d2:	e9 83 f5 ff ff       	jmp    8010595a <alltraps>

801063d7 <vector152>:
.globl vector152
vector152:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $152
801063d9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801063de:	e9 77 f5 ff ff       	jmp    8010595a <alltraps>

801063e3 <vector153>:
.globl vector153
vector153:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $153
801063e5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801063ea:	e9 6b f5 ff ff       	jmp    8010595a <alltraps>

801063ef <vector154>:
.globl vector154
vector154:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $154
801063f1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801063f6:	e9 5f f5 ff ff       	jmp    8010595a <alltraps>

801063fb <vector155>:
.globl vector155
vector155:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $155
801063fd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106402:	e9 53 f5 ff ff       	jmp    8010595a <alltraps>

80106407 <vector156>:
.globl vector156
vector156:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $156
80106409:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010640e:	e9 47 f5 ff ff       	jmp    8010595a <alltraps>

80106413 <vector157>:
.globl vector157
vector157:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $157
80106415:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010641a:	e9 3b f5 ff ff       	jmp    8010595a <alltraps>

8010641f <vector158>:
.globl vector158
vector158:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $158
80106421:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106426:	e9 2f f5 ff ff       	jmp    8010595a <alltraps>

8010642b <vector159>:
.globl vector159
vector159:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $159
8010642d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106432:	e9 23 f5 ff ff       	jmp    8010595a <alltraps>

80106437 <vector160>:
.globl vector160
vector160:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $160
80106439:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010643e:	e9 17 f5 ff ff       	jmp    8010595a <alltraps>

80106443 <vector161>:
.globl vector161
vector161:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $161
80106445:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010644a:	e9 0b f5 ff ff       	jmp    8010595a <alltraps>

8010644f <vector162>:
.globl vector162
vector162:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $162
80106451:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106456:	e9 ff f4 ff ff       	jmp    8010595a <alltraps>

8010645b <vector163>:
.globl vector163
vector163:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $163
8010645d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106462:	e9 f3 f4 ff ff       	jmp    8010595a <alltraps>

80106467 <vector164>:
.globl vector164
vector164:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $164
80106469:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010646e:	e9 e7 f4 ff ff       	jmp    8010595a <alltraps>

80106473 <vector165>:
.globl vector165
vector165:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $165
80106475:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010647a:	e9 db f4 ff ff       	jmp    8010595a <alltraps>

8010647f <vector166>:
.globl vector166
vector166:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $166
80106481:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106486:	e9 cf f4 ff ff       	jmp    8010595a <alltraps>

8010648b <vector167>:
.globl vector167
vector167:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $167
8010648d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106492:	e9 c3 f4 ff ff       	jmp    8010595a <alltraps>

80106497 <vector168>:
.globl vector168
vector168:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $168
80106499:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010649e:	e9 b7 f4 ff ff       	jmp    8010595a <alltraps>

801064a3 <vector169>:
.globl vector169
vector169:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $169
801064a5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801064aa:	e9 ab f4 ff ff       	jmp    8010595a <alltraps>

801064af <vector170>:
.globl vector170
vector170:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $170
801064b1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801064b6:	e9 9f f4 ff ff       	jmp    8010595a <alltraps>

801064bb <vector171>:
.globl vector171
vector171:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $171
801064bd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801064c2:	e9 93 f4 ff ff       	jmp    8010595a <alltraps>

801064c7 <vector172>:
.globl vector172
vector172:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $172
801064c9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801064ce:	e9 87 f4 ff ff       	jmp    8010595a <alltraps>

801064d3 <vector173>:
.globl vector173
vector173:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $173
801064d5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801064da:	e9 7b f4 ff ff       	jmp    8010595a <alltraps>

801064df <vector174>:
.globl vector174
vector174:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $174
801064e1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801064e6:	e9 6f f4 ff ff       	jmp    8010595a <alltraps>

801064eb <vector175>:
.globl vector175
vector175:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $175
801064ed:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801064f2:	e9 63 f4 ff ff       	jmp    8010595a <alltraps>

801064f7 <vector176>:
.globl vector176
vector176:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $176
801064f9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801064fe:	e9 57 f4 ff ff       	jmp    8010595a <alltraps>

80106503 <vector177>:
.globl vector177
vector177:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $177
80106505:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010650a:	e9 4b f4 ff ff       	jmp    8010595a <alltraps>

8010650f <vector178>:
.globl vector178
vector178:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $178
80106511:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106516:	e9 3f f4 ff ff       	jmp    8010595a <alltraps>

8010651b <vector179>:
.globl vector179
vector179:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $179
8010651d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106522:	e9 33 f4 ff ff       	jmp    8010595a <alltraps>

80106527 <vector180>:
.globl vector180
vector180:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $180
80106529:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010652e:	e9 27 f4 ff ff       	jmp    8010595a <alltraps>

80106533 <vector181>:
.globl vector181
vector181:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $181
80106535:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010653a:	e9 1b f4 ff ff       	jmp    8010595a <alltraps>

8010653f <vector182>:
.globl vector182
vector182:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $182
80106541:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106546:	e9 0f f4 ff ff       	jmp    8010595a <alltraps>

8010654b <vector183>:
.globl vector183
vector183:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $183
8010654d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106552:	e9 03 f4 ff ff       	jmp    8010595a <alltraps>

80106557 <vector184>:
.globl vector184
vector184:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $184
80106559:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010655e:	e9 f7 f3 ff ff       	jmp    8010595a <alltraps>

80106563 <vector185>:
.globl vector185
vector185:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $185
80106565:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010656a:	e9 eb f3 ff ff       	jmp    8010595a <alltraps>

8010656f <vector186>:
.globl vector186
vector186:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $186
80106571:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106576:	e9 df f3 ff ff       	jmp    8010595a <alltraps>

8010657b <vector187>:
.globl vector187
vector187:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $187
8010657d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106582:	e9 d3 f3 ff ff       	jmp    8010595a <alltraps>

80106587 <vector188>:
.globl vector188
vector188:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $188
80106589:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010658e:	e9 c7 f3 ff ff       	jmp    8010595a <alltraps>

80106593 <vector189>:
.globl vector189
vector189:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $189
80106595:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010659a:	e9 bb f3 ff ff       	jmp    8010595a <alltraps>

8010659f <vector190>:
.globl vector190
vector190:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $190
801065a1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801065a6:	e9 af f3 ff ff       	jmp    8010595a <alltraps>

801065ab <vector191>:
.globl vector191
vector191:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $191
801065ad:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801065b2:	e9 a3 f3 ff ff       	jmp    8010595a <alltraps>

801065b7 <vector192>:
.globl vector192
vector192:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $192
801065b9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801065be:	e9 97 f3 ff ff       	jmp    8010595a <alltraps>

801065c3 <vector193>:
.globl vector193
vector193:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $193
801065c5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801065ca:	e9 8b f3 ff ff       	jmp    8010595a <alltraps>

801065cf <vector194>:
.globl vector194
vector194:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $194
801065d1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801065d6:	e9 7f f3 ff ff       	jmp    8010595a <alltraps>

801065db <vector195>:
.globl vector195
vector195:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $195
801065dd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801065e2:	e9 73 f3 ff ff       	jmp    8010595a <alltraps>

801065e7 <vector196>:
.globl vector196
vector196:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $196
801065e9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801065ee:	e9 67 f3 ff ff       	jmp    8010595a <alltraps>

801065f3 <vector197>:
.globl vector197
vector197:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $197
801065f5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801065fa:	e9 5b f3 ff ff       	jmp    8010595a <alltraps>

801065ff <vector198>:
.globl vector198
vector198:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $198
80106601:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106606:	e9 4f f3 ff ff       	jmp    8010595a <alltraps>

8010660b <vector199>:
.globl vector199
vector199:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $199
8010660d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106612:	e9 43 f3 ff ff       	jmp    8010595a <alltraps>

80106617 <vector200>:
.globl vector200
vector200:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $200
80106619:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010661e:	e9 37 f3 ff ff       	jmp    8010595a <alltraps>

80106623 <vector201>:
.globl vector201
vector201:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $201
80106625:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010662a:	e9 2b f3 ff ff       	jmp    8010595a <alltraps>

8010662f <vector202>:
.globl vector202
vector202:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $202
80106631:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106636:	e9 1f f3 ff ff       	jmp    8010595a <alltraps>

8010663b <vector203>:
.globl vector203
vector203:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $203
8010663d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106642:	e9 13 f3 ff ff       	jmp    8010595a <alltraps>

80106647 <vector204>:
.globl vector204
vector204:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $204
80106649:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010664e:	e9 07 f3 ff ff       	jmp    8010595a <alltraps>

80106653 <vector205>:
.globl vector205
vector205:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $205
80106655:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010665a:	e9 fb f2 ff ff       	jmp    8010595a <alltraps>

8010665f <vector206>:
.globl vector206
vector206:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $206
80106661:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106666:	e9 ef f2 ff ff       	jmp    8010595a <alltraps>

8010666b <vector207>:
.globl vector207
vector207:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $207
8010666d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106672:	e9 e3 f2 ff ff       	jmp    8010595a <alltraps>

80106677 <vector208>:
.globl vector208
vector208:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $208
80106679:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010667e:	e9 d7 f2 ff ff       	jmp    8010595a <alltraps>

80106683 <vector209>:
.globl vector209
vector209:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $209
80106685:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010668a:	e9 cb f2 ff ff       	jmp    8010595a <alltraps>

8010668f <vector210>:
.globl vector210
vector210:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $210
80106691:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106696:	e9 bf f2 ff ff       	jmp    8010595a <alltraps>

8010669b <vector211>:
.globl vector211
vector211:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $211
8010669d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801066a2:	e9 b3 f2 ff ff       	jmp    8010595a <alltraps>

801066a7 <vector212>:
.globl vector212
vector212:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $212
801066a9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801066ae:	e9 a7 f2 ff ff       	jmp    8010595a <alltraps>

801066b3 <vector213>:
.globl vector213
vector213:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $213
801066b5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801066ba:	e9 9b f2 ff ff       	jmp    8010595a <alltraps>

801066bf <vector214>:
.globl vector214
vector214:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $214
801066c1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801066c6:	e9 8f f2 ff ff       	jmp    8010595a <alltraps>

801066cb <vector215>:
.globl vector215
vector215:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $215
801066cd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801066d2:	e9 83 f2 ff ff       	jmp    8010595a <alltraps>

801066d7 <vector216>:
.globl vector216
vector216:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $216
801066d9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801066de:	e9 77 f2 ff ff       	jmp    8010595a <alltraps>

801066e3 <vector217>:
.globl vector217
vector217:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $217
801066e5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801066ea:	e9 6b f2 ff ff       	jmp    8010595a <alltraps>

801066ef <vector218>:
.globl vector218
vector218:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $218
801066f1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801066f6:	e9 5f f2 ff ff       	jmp    8010595a <alltraps>

801066fb <vector219>:
.globl vector219
vector219:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $219
801066fd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106702:	e9 53 f2 ff ff       	jmp    8010595a <alltraps>

80106707 <vector220>:
.globl vector220
vector220:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $220
80106709:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010670e:	e9 47 f2 ff ff       	jmp    8010595a <alltraps>

80106713 <vector221>:
.globl vector221
vector221:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $221
80106715:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010671a:	e9 3b f2 ff ff       	jmp    8010595a <alltraps>

8010671f <vector222>:
.globl vector222
vector222:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $222
80106721:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106726:	e9 2f f2 ff ff       	jmp    8010595a <alltraps>

8010672b <vector223>:
.globl vector223
vector223:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $223
8010672d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106732:	e9 23 f2 ff ff       	jmp    8010595a <alltraps>

80106737 <vector224>:
.globl vector224
vector224:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $224
80106739:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010673e:	e9 17 f2 ff ff       	jmp    8010595a <alltraps>

80106743 <vector225>:
.globl vector225
vector225:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $225
80106745:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010674a:	e9 0b f2 ff ff       	jmp    8010595a <alltraps>

8010674f <vector226>:
.globl vector226
vector226:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $226
80106751:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106756:	e9 ff f1 ff ff       	jmp    8010595a <alltraps>

8010675b <vector227>:
.globl vector227
vector227:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $227
8010675d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106762:	e9 f3 f1 ff ff       	jmp    8010595a <alltraps>

80106767 <vector228>:
.globl vector228
vector228:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $228
80106769:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010676e:	e9 e7 f1 ff ff       	jmp    8010595a <alltraps>

80106773 <vector229>:
.globl vector229
vector229:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $229
80106775:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010677a:	e9 db f1 ff ff       	jmp    8010595a <alltraps>

8010677f <vector230>:
.globl vector230
vector230:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $230
80106781:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106786:	e9 cf f1 ff ff       	jmp    8010595a <alltraps>

8010678b <vector231>:
.globl vector231
vector231:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $231
8010678d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106792:	e9 c3 f1 ff ff       	jmp    8010595a <alltraps>

80106797 <vector232>:
.globl vector232
vector232:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $232
80106799:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010679e:	e9 b7 f1 ff ff       	jmp    8010595a <alltraps>

801067a3 <vector233>:
.globl vector233
vector233:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $233
801067a5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801067aa:	e9 ab f1 ff ff       	jmp    8010595a <alltraps>

801067af <vector234>:
.globl vector234
vector234:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $234
801067b1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801067b6:	e9 9f f1 ff ff       	jmp    8010595a <alltraps>

801067bb <vector235>:
.globl vector235
vector235:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $235
801067bd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801067c2:	e9 93 f1 ff ff       	jmp    8010595a <alltraps>

801067c7 <vector236>:
.globl vector236
vector236:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $236
801067c9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801067ce:	e9 87 f1 ff ff       	jmp    8010595a <alltraps>

801067d3 <vector237>:
.globl vector237
vector237:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $237
801067d5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801067da:	e9 7b f1 ff ff       	jmp    8010595a <alltraps>

801067df <vector238>:
.globl vector238
vector238:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $238
801067e1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801067e6:	e9 6f f1 ff ff       	jmp    8010595a <alltraps>

801067eb <vector239>:
.globl vector239
vector239:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $239
801067ed:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801067f2:	e9 63 f1 ff ff       	jmp    8010595a <alltraps>

801067f7 <vector240>:
.globl vector240
vector240:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $240
801067f9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801067fe:	e9 57 f1 ff ff       	jmp    8010595a <alltraps>

80106803 <vector241>:
.globl vector241
vector241:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $241
80106805:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010680a:	e9 4b f1 ff ff       	jmp    8010595a <alltraps>

8010680f <vector242>:
.globl vector242
vector242:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $242
80106811:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106816:	e9 3f f1 ff ff       	jmp    8010595a <alltraps>

8010681b <vector243>:
.globl vector243
vector243:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $243
8010681d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106822:	e9 33 f1 ff ff       	jmp    8010595a <alltraps>

80106827 <vector244>:
.globl vector244
vector244:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $244
80106829:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010682e:	e9 27 f1 ff ff       	jmp    8010595a <alltraps>

80106833 <vector245>:
.globl vector245
vector245:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $245
80106835:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010683a:	e9 1b f1 ff ff       	jmp    8010595a <alltraps>

8010683f <vector246>:
.globl vector246
vector246:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $246
80106841:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106846:	e9 0f f1 ff ff       	jmp    8010595a <alltraps>

8010684b <vector247>:
.globl vector247
vector247:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $247
8010684d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106852:	e9 03 f1 ff ff       	jmp    8010595a <alltraps>

80106857 <vector248>:
.globl vector248
vector248:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $248
80106859:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010685e:	e9 f7 f0 ff ff       	jmp    8010595a <alltraps>

80106863 <vector249>:
.globl vector249
vector249:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $249
80106865:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010686a:	e9 eb f0 ff ff       	jmp    8010595a <alltraps>

8010686f <vector250>:
.globl vector250
vector250:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $250
80106871:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106876:	e9 df f0 ff ff       	jmp    8010595a <alltraps>

8010687b <vector251>:
.globl vector251
vector251:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $251
8010687d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106882:	e9 d3 f0 ff ff       	jmp    8010595a <alltraps>

80106887 <vector252>:
.globl vector252
vector252:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $252
80106889:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010688e:	e9 c7 f0 ff ff       	jmp    8010595a <alltraps>

80106893 <vector253>:
.globl vector253
vector253:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $253
80106895:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010689a:	e9 bb f0 ff ff       	jmp    8010595a <alltraps>

8010689f <vector254>:
.globl vector254
vector254:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $254
801068a1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801068a6:	e9 af f0 ff ff       	jmp    8010595a <alltraps>

801068ab <vector255>:
.globl vector255
vector255:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $255
801068ad:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801068b2:	e9 a3 f0 ff ff       	jmp    8010595a <alltraps>
801068b7:	66 90                	xchg   %ax,%ax
801068b9:	66 90                	xchg   %ax,%ax
801068bb:	66 90                	xchg   %ax,%ax
801068bd:	66 90                	xchg   %ax,%ax
801068bf:	90                   	nop

801068c0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	57                   	push   %edi
801068c4:	56                   	push   %esi
801068c5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801068c6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801068cc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068d2:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
801068d5:	39 d3                	cmp    %edx,%ebx
801068d7:	73 56                	jae    8010692f <deallocuvm.part.0+0x6f>
801068d9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801068dc:	89 c6                	mov    %eax,%esi
801068de:	89 d7                	mov    %edx,%edi
801068e0:	eb 12                	jmp    801068f4 <deallocuvm.part.0+0x34>
801068e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801068e8:	83 c2 01             	add    $0x1,%edx
801068eb:	89 d3                	mov    %edx,%ebx
801068ed:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
801068f0:	39 fb                	cmp    %edi,%ebx
801068f2:	73 38                	jae    8010692c <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
801068f4:	89 da                	mov    %ebx,%edx
801068f6:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801068f9:	8b 04 96             	mov    (%esi,%edx,4),%eax
801068fc:	a8 01                	test   $0x1,%al
801068fe:	74 e8                	je     801068e8 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106900:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106902:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106907:	c1 e9 0a             	shr    $0xa,%ecx
8010690a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106910:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106917:	85 c0                	test   %eax,%eax
80106919:	74 cd                	je     801068e8 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
8010691b:	8b 10                	mov    (%eax),%edx
8010691d:	f6 c2 01             	test   $0x1,%dl
80106920:	75 1e                	jne    80106940 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80106922:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106928:	39 fb                	cmp    %edi,%ebx
8010692a:	72 c8                	jb     801068f4 <deallocuvm.part.0+0x34>
8010692c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
8010692f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106932:	89 c8                	mov    %ecx,%eax
80106934:	5b                   	pop    %ebx
80106935:	5e                   	pop    %esi
80106936:	5f                   	pop    %edi
80106937:	5d                   	pop    %ebp
80106938:	c3                   	ret
80106939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106940:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106946:	74 26                	je     8010696e <deallocuvm.part.0+0xae>
      kfree(v);
80106948:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010694b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106951:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106954:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
8010695a:	52                   	push   %edx
8010695b:	e8 60 bc ff ff       	call   801025c0 <kfree>
      *pte = 0;
80106960:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106963:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106966:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010696c:	eb 82                	jmp    801068f0 <deallocuvm.part.0+0x30>
        panic("kfree");
8010696e:	83 ec 0c             	sub    $0xc,%esp
80106971:	68 4c 74 10 80       	push   $0x8010744c
80106976:	e8 05 9a ff ff       	call   80100380 <panic>
8010697b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106980 <mappages>:
{
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	56                   	push   %esi
80106985:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106986:	89 d3                	mov    %edx,%ebx
80106988:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010698e:	83 ec 1c             	sub    $0x1c,%esp
80106991:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106994:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106998:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010699d:	89 45 dc             	mov    %eax,-0x24(%ebp)
801069a0:	8b 45 08             	mov    0x8(%ebp),%eax
801069a3:	29 d8                	sub    %ebx,%eax
801069a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069a8:	eb 3f                	jmp    801069e9 <mappages+0x69>
801069aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801069b0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801069b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801069b7:	c1 ea 0a             	shr    $0xa,%edx
801069ba:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801069c0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801069c7:	85 c0                	test   %eax,%eax
801069c9:	74 75                	je     80106a40 <mappages+0xc0>
    if(*pte & PTE_P)
801069cb:	f6 00 01             	testb  $0x1,(%eax)
801069ce:	0f 85 86 00 00 00    	jne    80106a5a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801069d4:	0b 75 0c             	or     0xc(%ebp),%esi
801069d7:	83 ce 01             	or     $0x1,%esi
801069da:	89 30                	mov    %esi,(%eax)
    if(a == last)
801069dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801069df:	39 c3                	cmp    %eax,%ebx
801069e1:	74 6d                	je     80106a50 <mappages+0xd0>
    a += PGSIZE;
801069e3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801069e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
801069ec:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801069ef:	8d 34 03             	lea    (%ebx,%eax,1),%esi
801069f2:	89 d8                	mov    %ebx,%eax
801069f4:	c1 e8 16             	shr    $0x16,%eax
801069f7:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801069fa:	8b 07                	mov    (%edi),%eax
801069fc:	a8 01                	test   $0x1,%al
801069fe:	75 b0                	jne    801069b0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106a00:	e8 7b bd ff ff       	call   80102780 <kalloc>
80106a05:	85 c0                	test   %eax,%eax
80106a07:	74 37                	je     80106a40 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106a09:	83 ec 04             	sub    $0x4,%esp
80106a0c:	68 00 10 00 00       	push   $0x1000
80106a11:	6a 00                	push   $0x0
80106a13:	50                   	push   %eax
80106a14:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106a17:	e8 a4 dd ff ff       	call   801047c0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106a1c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106a1f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106a22:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106a28:	83 c8 07             	or     $0x7,%eax
80106a2b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106a2d:	89 d8                	mov    %ebx,%eax
80106a2f:	c1 e8 0a             	shr    $0xa,%eax
80106a32:	25 fc 0f 00 00       	and    $0xffc,%eax
80106a37:	01 d0                	add    %edx,%eax
80106a39:	eb 90                	jmp    801069cb <mappages+0x4b>
80106a3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80106a40:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106a43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a48:	5b                   	pop    %ebx
80106a49:	5e                   	pop    %esi
80106a4a:	5f                   	pop    %edi
80106a4b:	5d                   	pop    %ebp
80106a4c:	c3                   	ret
80106a4d:	8d 76 00             	lea    0x0(%esi),%esi
80106a50:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106a53:	31 c0                	xor    %eax,%eax
}
80106a55:	5b                   	pop    %ebx
80106a56:	5e                   	pop    %esi
80106a57:	5f                   	pop    %edi
80106a58:	5d                   	pop    %ebp
80106a59:	c3                   	ret
      panic("remap");
80106a5a:	83 ec 0c             	sub    $0xc,%esp
80106a5d:	68 80 76 10 80       	push   $0x80107680
80106a62:	e8 19 99 ff ff       	call   80100380 <panic>
80106a67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106a6e:	00 
80106a6f:	90                   	nop

80106a70 <seginit>:
{
80106a70:	55                   	push   %ebp
80106a71:	89 e5                	mov    %esp,%ebp
80106a73:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106a76:	e8 e5 cf ff ff       	call   80103a60 <cpuid>
  pd[0] = size-1;
80106a7b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a80:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a86:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106a8a:	c7 80 18 18 11 80 ff 	movl   $0xffff,-0x7feee7e8(%eax)
80106a91:	ff 00 00 
80106a94:	c7 80 1c 18 11 80 00 	movl   $0xcf9a00,-0x7feee7e4(%eax)
80106a9b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a9e:	c7 80 20 18 11 80 ff 	movl   $0xffff,-0x7feee7e0(%eax)
80106aa5:	ff 00 00 
80106aa8:	c7 80 24 18 11 80 00 	movl   $0xcf9200,-0x7feee7dc(%eax)
80106aaf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ab2:	c7 80 28 18 11 80 ff 	movl   $0xffff,-0x7feee7d8(%eax)
80106ab9:	ff 00 00 
80106abc:	c7 80 2c 18 11 80 00 	movl   $0xcffa00,-0x7feee7d4(%eax)
80106ac3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ac6:	c7 80 30 18 11 80 ff 	movl   $0xffff,-0x7feee7d0(%eax)
80106acd:	ff 00 00 
80106ad0:	c7 80 34 18 11 80 00 	movl   $0xcff200,-0x7feee7cc(%eax)
80106ad7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106ada:	05 10 18 11 80       	add    $0x80111810,%eax
  pd[1] = (uint)p;
80106adf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106ae3:	c1 e8 10             	shr    $0x10,%eax
80106ae6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106aea:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106aed:	0f 01 10             	lgdtl  (%eax)
}
80106af0:	c9                   	leave
80106af1:	c3                   	ret
80106af2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106af9:	00 
80106afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b00 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b00:	a1 c4 44 11 80       	mov    0x801144c4,%eax
80106b05:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b0a:	0f 22 d8             	mov    %eax,%cr3
}
80106b0d:	c3                   	ret
80106b0e:	66 90                	xchg   %ax,%ax

80106b10 <switchuvm>:
{
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	57                   	push   %edi
80106b14:	56                   	push   %esi
80106b15:	53                   	push   %ebx
80106b16:	83 ec 1c             	sub    $0x1c,%esp
80106b19:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106b1c:	85 f6                	test   %esi,%esi
80106b1e:	0f 84 cb 00 00 00    	je     80106bef <switchuvm+0xdf>
  if(p->kstack == 0)
80106b24:	8b 46 08             	mov    0x8(%esi),%eax
80106b27:	85 c0                	test   %eax,%eax
80106b29:	0f 84 da 00 00 00    	je     80106c09 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106b2f:	8b 46 04             	mov    0x4(%esi),%eax
80106b32:	85 c0                	test   %eax,%eax
80106b34:	0f 84 c2 00 00 00    	je     80106bfc <switchuvm+0xec>
  pushcli();
80106b3a:	e8 31 da ff ff       	call   80104570 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b3f:	e8 bc ce ff ff       	call   80103a00 <mycpu>
80106b44:	89 c3                	mov    %eax,%ebx
80106b46:	e8 b5 ce ff ff       	call   80103a00 <mycpu>
80106b4b:	89 c7                	mov    %eax,%edi
80106b4d:	e8 ae ce ff ff       	call   80103a00 <mycpu>
80106b52:	83 c7 08             	add    $0x8,%edi
80106b55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b58:	e8 a3 ce ff ff       	call   80103a00 <mycpu>
80106b5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b60:	ba 67 00 00 00       	mov    $0x67,%edx
80106b65:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106b6c:	83 c0 08             	add    $0x8,%eax
80106b6f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b76:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b7b:	83 c1 08             	add    $0x8,%ecx
80106b7e:	c1 e8 18             	shr    $0x18,%eax
80106b81:	c1 e9 10             	shr    $0x10,%ecx
80106b84:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106b8a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106b90:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106b95:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b9c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106ba1:	e8 5a ce ff ff       	call   80103a00 <mycpu>
80106ba6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106bad:	e8 4e ce ff ff       	call   80103a00 <mycpu>
80106bb2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106bb6:	8b 5e 08             	mov    0x8(%esi),%ebx
80106bb9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bbf:	e8 3c ce ff ff       	call   80103a00 <mycpu>
80106bc4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106bc7:	e8 34 ce ff ff       	call   80103a00 <mycpu>
80106bcc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106bd0:	b8 28 00 00 00       	mov    $0x28,%eax
80106bd5:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106bd8:	8b 46 04             	mov    0x4(%esi),%eax
80106bdb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106be0:	0f 22 d8             	mov    %eax,%cr3
}
80106be3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106be6:	5b                   	pop    %ebx
80106be7:	5e                   	pop    %esi
80106be8:	5f                   	pop    %edi
80106be9:	5d                   	pop    %ebp
  popcli();
80106bea:	e9 d1 d9 ff ff       	jmp    801045c0 <popcli>
    panic("switchuvm: no process");
80106bef:	83 ec 0c             	sub    $0xc,%esp
80106bf2:	68 86 76 10 80       	push   $0x80107686
80106bf7:	e8 84 97 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106bfc:	83 ec 0c             	sub    $0xc,%esp
80106bff:	68 b1 76 10 80       	push   $0x801076b1
80106c04:	e8 77 97 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106c09:	83 ec 0c             	sub    $0xc,%esp
80106c0c:	68 9c 76 10 80       	push   $0x8010769c
80106c11:	e8 6a 97 ff ff       	call   80100380 <panic>
80106c16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106c1d:	00 
80106c1e:	66 90                	xchg   %ax,%ax

80106c20 <inituvm>:
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	57                   	push   %edi
80106c24:	56                   	push   %esi
80106c25:	53                   	push   %ebx
80106c26:	83 ec 1c             	sub    $0x1c,%esp
80106c29:	8b 45 08             	mov    0x8(%ebp),%eax
80106c2c:	8b 75 10             	mov    0x10(%ebp),%esi
80106c2f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106c32:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106c35:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106c3b:	77 49                	ja     80106c86 <inituvm+0x66>
  mem = kalloc();
80106c3d:	e8 3e bb ff ff       	call   80102780 <kalloc>
  memset(mem, 0, PGSIZE);
80106c42:	83 ec 04             	sub    $0x4,%esp
80106c45:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106c4a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c4c:	6a 00                	push   $0x0
80106c4e:	50                   	push   %eax
80106c4f:	e8 6c db ff ff       	call   801047c0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c54:	58                   	pop    %eax
80106c55:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c5b:	5a                   	pop    %edx
80106c5c:	6a 06                	push   $0x6
80106c5e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c63:	31 d2                	xor    %edx,%edx
80106c65:	50                   	push   %eax
80106c66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c69:	e8 12 fd ff ff       	call   80106980 <mappages>
  memmove(mem, init, sz);
80106c6e:	83 c4 10             	add    $0x10,%esp
80106c71:	89 75 10             	mov    %esi,0x10(%ebp)
80106c74:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106c77:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106c7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c7d:	5b                   	pop    %ebx
80106c7e:	5e                   	pop    %esi
80106c7f:	5f                   	pop    %edi
80106c80:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106c81:	e9 ca db ff ff       	jmp    80104850 <memmove>
    panic("inituvm: more than a page");
80106c86:	83 ec 0c             	sub    $0xc,%esp
80106c89:	68 c5 76 10 80       	push   $0x801076c5
80106c8e:	e8 ed 96 ff ff       	call   80100380 <panic>
80106c93:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106c9a:	00 
80106c9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106ca0 <loaduvm>:
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	57                   	push   %edi
80106ca4:	56                   	push   %esi
80106ca5:	53                   	push   %ebx
80106ca6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106ca9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
80106cac:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
80106caf:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106cb5:	0f 85 a2 00 00 00    	jne    80106d5d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
80106cbb:	85 ff                	test   %edi,%edi
80106cbd:	74 7d                	je     80106d3c <loaduvm+0x9c>
80106cbf:	90                   	nop
  pde = &pgdir[PDX(va)];
80106cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106cc3:	8b 55 08             	mov    0x8(%ebp),%edx
80106cc6:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80106cc8:	89 c1                	mov    %eax,%ecx
80106cca:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106ccd:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80106cd0:	f6 c1 01             	test   $0x1,%cl
80106cd3:	75 13                	jne    80106ce8 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80106cd5:	83 ec 0c             	sub    $0xc,%esp
80106cd8:	68 df 76 10 80       	push   $0x801076df
80106cdd:	e8 9e 96 ff ff       	call   80100380 <panic>
80106ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106ce8:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106ceb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106cf1:	25 fc 0f 00 00       	and    $0xffc,%eax
80106cf6:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106cfd:	85 c9                	test   %ecx,%ecx
80106cff:	74 d4                	je     80106cd5 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80106d01:	89 fb                	mov    %edi,%ebx
80106d03:	b8 00 10 00 00       	mov    $0x1000,%eax
80106d08:	29 f3                	sub    %esi,%ebx
80106d0a:	39 c3                	cmp    %eax,%ebx
80106d0c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d0f:	53                   	push   %ebx
80106d10:	8b 45 14             	mov    0x14(%ebp),%eax
80106d13:	01 f0                	add    %esi,%eax
80106d15:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80106d16:	8b 01                	mov    (%ecx),%eax
80106d18:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d1d:	05 00 00 00 80       	add    $0x80000000,%eax
80106d22:	50                   	push   %eax
80106d23:	ff 75 10             	push   0x10(%ebp)
80106d26:	e8 a5 ae ff ff       	call   80101bd0 <readi>
80106d2b:	83 c4 10             	add    $0x10,%esp
80106d2e:	39 d8                	cmp    %ebx,%eax
80106d30:	75 1e                	jne    80106d50 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80106d32:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106d38:	39 fe                	cmp    %edi,%esi
80106d3a:	72 84                	jb     80106cc0 <loaduvm+0x20>
}
80106d3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106d3f:	31 c0                	xor    %eax,%eax
}
80106d41:	5b                   	pop    %ebx
80106d42:	5e                   	pop    %esi
80106d43:	5f                   	pop    %edi
80106d44:	5d                   	pop    %ebp
80106d45:	c3                   	ret
80106d46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d4d:	00 
80106d4e:	66 90                	xchg   %ax,%ax
80106d50:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106d53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d58:	5b                   	pop    %ebx
80106d59:	5e                   	pop    %esi
80106d5a:	5f                   	pop    %edi
80106d5b:	5d                   	pop    %ebp
80106d5c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
80106d5d:	83 ec 0c             	sub    $0xc,%esp
80106d60:	68 58 79 10 80       	push   $0x80107958
80106d65:	e8 16 96 ff ff       	call   80100380 <panic>
80106d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d70 <allocuvm>:
{
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
80106d76:	83 ec 1c             	sub    $0x1c,%esp
80106d79:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
80106d7c:	85 f6                	test   %esi,%esi
80106d7e:	0f 88 98 00 00 00    	js     80106e1c <allocuvm+0xac>
80106d84:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80106d86:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106d89:	0f 82 a1 00 00 00    	jb     80106e30 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106d8f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d92:	05 ff 0f 00 00       	add    $0xfff,%eax
80106d97:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d9c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
80106d9e:	39 f0                	cmp    %esi,%eax
80106da0:	0f 83 8d 00 00 00    	jae    80106e33 <allocuvm+0xc3>
80106da6:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80106da9:	eb 44                	jmp    80106def <allocuvm+0x7f>
80106dab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106db0:	83 ec 04             	sub    $0x4,%esp
80106db3:	68 00 10 00 00       	push   $0x1000
80106db8:	6a 00                	push   $0x0
80106dba:	50                   	push   %eax
80106dbb:	e8 00 da ff ff       	call   801047c0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106dc0:	58                   	pop    %eax
80106dc1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106dc7:	5a                   	pop    %edx
80106dc8:	6a 06                	push   $0x6
80106dca:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dcf:	89 fa                	mov    %edi,%edx
80106dd1:	50                   	push   %eax
80106dd2:	8b 45 08             	mov    0x8(%ebp),%eax
80106dd5:	e8 a6 fb ff ff       	call   80106980 <mappages>
80106dda:	83 c4 10             	add    $0x10,%esp
80106ddd:	85 c0                	test   %eax,%eax
80106ddf:	78 5f                	js     80106e40 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80106de1:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106de7:	39 f7                	cmp    %esi,%edi
80106de9:	0f 83 89 00 00 00    	jae    80106e78 <allocuvm+0x108>
    mem = kalloc();
80106def:	e8 8c b9 ff ff       	call   80102780 <kalloc>
80106df4:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106df6:	85 c0                	test   %eax,%eax
80106df8:	75 b6                	jne    80106db0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106dfa:	83 ec 0c             	sub    $0xc,%esp
80106dfd:	68 fd 76 10 80       	push   $0x801076fd
80106e02:	e8 a9 98 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80106e07:	83 c4 10             	add    $0x10,%esp
80106e0a:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106e0d:	74 0d                	je     80106e1c <allocuvm+0xac>
80106e0f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e12:	8b 45 08             	mov    0x8(%ebp),%eax
80106e15:	89 f2                	mov    %esi,%edx
80106e17:	e8 a4 fa ff ff       	call   801068c0 <deallocuvm.part.0>
    return 0;
80106e1c:	31 d2                	xor    %edx,%edx
}
80106e1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e21:	89 d0                	mov    %edx,%eax
80106e23:	5b                   	pop    %ebx
80106e24:	5e                   	pop    %esi
80106e25:	5f                   	pop    %edi
80106e26:	5d                   	pop    %ebp
80106e27:	c3                   	ret
80106e28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e2f:	00 
    return oldsz;
80106e30:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80106e33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e36:	89 d0                	mov    %edx,%eax
80106e38:	5b                   	pop    %ebx
80106e39:	5e                   	pop    %esi
80106e3a:	5f                   	pop    %edi
80106e3b:	5d                   	pop    %ebp
80106e3c:	c3                   	ret
80106e3d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106e40:	83 ec 0c             	sub    $0xc,%esp
80106e43:	68 15 77 10 80       	push   $0x80107715
80106e48:	e8 63 98 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80106e4d:	83 c4 10             	add    $0x10,%esp
80106e50:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106e53:	74 0d                	je     80106e62 <allocuvm+0xf2>
80106e55:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e58:	8b 45 08             	mov    0x8(%ebp),%eax
80106e5b:	89 f2                	mov    %esi,%edx
80106e5d:	e8 5e fa ff ff       	call   801068c0 <deallocuvm.part.0>
      kfree(mem);
80106e62:	83 ec 0c             	sub    $0xc,%esp
80106e65:	53                   	push   %ebx
80106e66:	e8 55 b7 ff ff       	call   801025c0 <kfree>
      return 0;
80106e6b:	83 c4 10             	add    $0x10,%esp
    return 0;
80106e6e:	31 d2                	xor    %edx,%edx
80106e70:	eb ac                	jmp    80106e1e <allocuvm+0xae>
80106e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e78:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
80106e7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e7e:	5b                   	pop    %ebx
80106e7f:	5e                   	pop    %esi
80106e80:	89 d0                	mov    %edx,%eax
80106e82:	5f                   	pop    %edi
80106e83:	5d                   	pop    %ebp
80106e84:	c3                   	ret
80106e85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e8c:	00 
80106e8d:	8d 76 00             	lea    0x0(%esi),%esi

80106e90 <deallocuvm>:
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e96:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e99:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106e9c:	39 d1                	cmp    %edx,%ecx
80106e9e:	73 10                	jae    80106eb0 <deallocuvm+0x20>
}
80106ea0:	5d                   	pop    %ebp
80106ea1:	e9 1a fa ff ff       	jmp    801068c0 <deallocuvm.part.0>
80106ea6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106ead:	00 
80106eae:	66 90                	xchg   %ax,%ax
80106eb0:	89 d0                	mov    %edx,%eax
80106eb2:	5d                   	pop    %ebp
80106eb3:	c3                   	ret
80106eb4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106ebb:	00 
80106ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ec0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	57                   	push   %edi
80106ec4:	56                   	push   %esi
80106ec5:	53                   	push   %ebx
80106ec6:	83 ec 0c             	sub    $0xc,%esp
80106ec9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106ecc:	85 f6                	test   %esi,%esi
80106ece:	74 59                	je     80106f29 <freevm+0x69>
  if(newsz >= oldsz)
80106ed0:	31 c9                	xor    %ecx,%ecx
80106ed2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106ed7:	89 f0                	mov    %esi,%eax
80106ed9:	89 f3                	mov    %esi,%ebx
80106edb:	e8 e0 f9 ff ff       	call   801068c0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106ee0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ee6:	eb 0f                	jmp    80106ef7 <freevm+0x37>
80106ee8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106eef:	00 
80106ef0:	83 c3 04             	add    $0x4,%ebx
80106ef3:	39 fb                	cmp    %edi,%ebx
80106ef5:	74 23                	je     80106f1a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106ef7:	8b 03                	mov    (%ebx),%eax
80106ef9:	a8 01                	test   $0x1,%al
80106efb:	74 f3                	je     80106ef0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106efd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106f02:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106f05:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f08:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106f0d:	50                   	push   %eax
80106f0e:	e8 ad b6 ff ff       	call   801025c0 <kfree>
80106f13:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106f16:	39 fb                	cmp    %edi,%ebx
80106f18:	75 dd                	jne    80106ef7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106f1a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f20:	5b                   	pop    %ebx
80106f21:	5e                   	pop    %esi
80106f22:	5f                   	pop    %edi
80106f23:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106f24:	e9 97 b6 ff ff       	jmp    801025c0 <kfree>
    panic("freevm: no pgdir");
80106f29:	83 ec 0c             	sub    $0xc,%esp
80106f2c:	68 31 77 10 80       	push   $0x80107731
80106f31:	e8 4a 94 ff ff       	call   80100380 <panic>
80106f36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f3d:	00 
80106f3e:	66 90                	xchg   %ax,%ax

80106f40 <setupkvm>:
{
80106f40:	55                   	push   %ebp
80106f41:	89 e5                	mov    %esp,%ebp
80106f43:	56                   	push   %esi
80106f44:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106f45:	e8 36 b8 ff ff       	call   80102780 <kalloc>
80106f4a:	85 c0                	test   %eax,%eax
80106f4c:	74 5e                	je     80106fac <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
80106f4e:	83 ec 04             	sub    $0x4,%esp
80106f51:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f53:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106f58:	68 00 10 00 00       	push   $0x1000
80106f5d:	6a 00                	push   $0x0
80106f5f:	50                   	push   %eax
80106f60:	e8 5b d8 ff ff       	call   801047c0 <memset>
80106f65:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106f68:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f6b:	83 ec 08             	sub    $0x8,%esp
80106f6e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f71:	8b 13                	mov    (%ebx),%edx
80106f73:	ff 73 0c             	push   0xc(%ebx)
80106f76:	50                   	push   %eax
80106f77:	29 c1                	sub    %eax,%ecx
80106f79:	89 f0                	mov    %esi,%eax
80106f7b:	e8 00 fa ff ff       	call   80106980 <mappages>
80106f80:	83 c4 10             	add    $0x10,%esp
80106f83:	85 c0                	test   %eax,%eax
80106f85:	78 19                	js     80106fa0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f87:	83 c3 10             	add    $0x10,%ebx
80106f8a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106f90:	75 d6                	jne    80106f68 <setupkvm+0x28>
}
80106f92:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f95:	89 f0                	mov    %esi,%eax
80106f97:	5b                   	pop    %ebx
80106f98:	5e                   	pop    %esi
80106f99:	5d                   	pop    %ebp
80106f9a:	c3                   	ret
80106f9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106fa0:	83 ec 0c             	sub    $0xc,%esp
80106fa3:	56                   	push   %esi
80106fa4:	e8 17 ff ff ff       	call   80106ec0 <freevm>
      return 0;
80106fa9:	83 c4 10             	add    $0x10,%esp
}
80106fac:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106faf:	31 f6                	xor    %esi,%esi
}
80106fb1:	89 f0                	mov    %esi,%eax
80106fb3:	5b                   	pop    %ebx
80106fb4:	5e                   	pop    %esi
80106fb5:	5d                   	pop    %ebp
80106fb6:	c3                   	ret
80106fb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106fbe:	00 
80106fbf:	90                   	nop

80106fc0 <kvmalloc>:
{
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106fc6:	e8 75 ff ff ff       	call   80106f40 <setupkvm>
80106fcb:	a3 c4 44 11 80       	mov    %eax,0x801144c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106fd0:	05 00 00 00 80       	add    $0x80000000,%eax
80106fd5:	0f 22 d8             	mov    %eax,%cr3
}
80106fd8:	c9                   	leave
80106fd9:	c3                   	ret
80106fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fe0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	83 ec 08             	sub    $0x8,%esp
80106fe6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106fe9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80106fec:	89 c1                	mov    %eax,%ecx
80106fee:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106ff1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80106ff4:	f6 c2 01             	test   $0x1,%dl
80106ff7:	75 17                	jne    80107010 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106ff9:	83 ec 0c             	sub    $0xc,%esp
80106ffc:	68 42 77 10 80       	push   $0x80107742
80107001:	e8 7a 93 ff ff       	call   80100380 <panic>
80107006:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010700d:	00 
8010700e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107010:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107013:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107019:	25 fc 0f 00 00       	and    $0xffc,%eax
8010701e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107025:	85 c0                	test   %eax,%eax
80107027:	74 d0                	je     80106ff9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107029:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010702c:	c9                   	leave
8010702d:	c3                   	ret
8010702e:	66 90                	xchg   %ax,%ax

80107030 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	57                   	push   %edi
80107034:	56                   	push   %esi
80107035:	53                   	push   %ebx
80107036:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107039:	e8 02 ff ff ff       	call   80106f40 <setupkvm>
8010703e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107041:	85 c0                	test   %eax,%eax
80107043:	0f 84 e9 00 00 00    	je     80107132 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107049:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010704c:	85 c9                	test   %ecx,%ecx
8010704e:	0f 84 b2 00 00 00    	je     80107106 <copyuvm+0xd6>
80107054:	31 f6                	xor    %esi,%esi
80107056:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010705d:	00 
8010705e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107060:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107063:	89 f0                	mov    %esi,%eax
80107065:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107068:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010706b:	a8 01                	test   $0x1,%al
8010706d:	75 11                	jne    80107080 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010706f:	83 ec 0c             	sub    $0xc,%esp
80107072:	68 4c 77 10 80       	push   $0x8010774c
80107077:	e8 04 93 ff ff       	call   80100380 <panic>
8010707c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107080:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107082:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107087:	c1 ea 0a             	shr    $0xa,%edx
8010708a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107090:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107097:	85 c0                	test   %eax,%eax
80107099:	74 d4                	je     8010706f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010709b:	8b 00                	mov    (%eax),%eax
8010709d:	a8 01                	test   $0x1,%al
8010709f:	0f 84 9f 00 00 00    	je     80107144 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801070a5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801070a7:	25 ff 0f 00 00       	and    $0xfff,%eax
801070ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801070af:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801070b5:	e8 c6 b6 ff ff       	call   80102780 <kalloc>
801070ba:	89 c3                	mov    %eax,%ebx
801070bc:	85 c0                	test   %eax,%eax
801070be:	74 64                	je     80107124 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801070c0:	83 ec 04             	sub    $0x4,%esp
801070c3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801070c9:	68 00 10 00 00       	push   $0x1000
801070ce:	57                   	push   %edi
801070cf:	50                   	push   %eax
801070d0:	e8 7b d7 ff ff       	call   80104850 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801070d5:	58                   	pop    %eax
801070d6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801070dc:	5a                   	pop    %edx
801070dd:	ff 75 e4             	push   -0x1c(%ebp)
801070e0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070e5:	89 f2                	mov    %esi,%edx
801070e7:	50                   	push   %eax
801070e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070eb:	e8 90 f8 ff ff       	call   80106980 <mappages>
801070f0:	83 c4 10             	add    $0x10,%esp
801070f3:	85 c0                	test   %eax,%eax
801070f5:	78 21                	js     80107118 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801070f7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801070fd:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107100:	0f 82 5a ff ff ff    	jb     80107060 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107106:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107109:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010710c:	5b                   	pop    %ebx
8010710d:	5e                   	pop    %esi
8010710e:	5f                   	pop    %edi
8010710f:	5d                   	pop    %ebp
80107110:	c3                   	ret
80107111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107118:	83 ec 0c             	sub    $0xc,%esp
8010711b:	53                   	push   %ebx
8010711c:	e8 9f b4 ff ff       	call   801025c0 <kfree>
      goto bad;
80107121:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107124:	83 ec 0c             	sub    $0xc,%esp
80107127:	ff 75 e0             	push   -0x20(%ebp)
8010712a:	e8 91 fd ff ff       	call   80106ec0 <freevm>
  return 0;
8010712f:	83 c4 10             	add    $0x10,%esp
    return 0;
80107132:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107139:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010713c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010713f:	5b                   	pop    %ebx
80107140:	5e                   	pop    %esi
80107141:	5f                   	pop    %edi
80107142:	5d                   	pop    %ebp
80107143:	c3                   	ret
      panic("copyuvm: page not present");
80107144:	83 ec 0c             	sub    $0xc,%esp
80107147:	68 66 77 10 80       	push   $0x80107766
8010714c:	e8 2f 92 ff ff       	call   80100380 <panic>
80107151:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107158:	00 
80107159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107160 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107166:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107169:	89 c1                	mov    %eax,%ecx
8010716b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010716e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107171:	f6 c2 01             	test   $0x1,%dl
80107174:	0f 84 f8 00 00 00    	je     80107272 <uva2ka.cold>
  return &pgtab[PTX(va)];
8010717a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010717d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107183:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107184:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107189:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107190:	89 d0                	mov    %edx,%eax
80107192:	f7 d2                	not    %edx
80107194:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107199:	05 00 00 00 80       	add    $0x80000000,%eax
8010719e:	83 e2 05             	and    $0x5,%edx
801071a1:	ba 00 00 00 00       	mov    $0x0,%edx
801071a6:	0f 45 c2             	cmovne %edx,%eax
}
801071a9:	c3                   	ret
801071aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801071b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	57                   	push   %edi
801071b4:	56                   	push   %esi
801071b5:	53                   	push   %ebx
801071b6:	83 ec 0c             	sub    $0xc,%esp
801071b9:	8b 75 14             	mov    0x14(%ebp),%esi
801071bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801071bf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801071c2:	85 f6                	test   %esi,%esi
801071c4:	75 51                	jne    80107217 <copyout+0x67>
801071c6:	e9 9d 00 00 00       	jmp    80107268 <copyout+0xb8>
801071cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
801071d0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801071d6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801071dc:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801071e2:	74 74                	je     80107258 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
801071e4:	89 fb                	mov    %edi,%ebx
801071e6:	29 c3                	sub    %eax,%ebx
801071e8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801071ee:	39 f3                	cmp    %esi,%ebx
801071f0:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801071f3:	29 f8                	sub    %edi,%eax
801071f5:	83 ec 04             	sub    $0x4,%esp
801071f8:	01 c1                	add    %eax,%ecx
801071fa:	53                   	push   %ebx
801071fb:	52                   	push   %edx
801071fc:	89 55 10             	mov    %edx,0x10(%ebp)
801071ff:	51                   	push   %ecx
80107200:	e8 4b d6 ff ff       	call   80104850 <memmove>
    len -= n;
    buf += n;
80107205:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107208:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010720e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107211:	01 da                	add    %ebx,%edx
  while(len > 0){
80107213:	29 de                	sub    %ebx,%esi
80107215:	74 51                	je     80107268 <copyout+0xb8>
  if(*pde & PTE_P){
80107217:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010721a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010721c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010721e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107221:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107227:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010722a:	f6 c1 01             	test   $0x1,%cl
8010722d:	0f 84 46 00 00 00    	je     80107279 <copyout.cold>
  return &pgtab[PTX(va)];
80107233:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107235:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010723b:	c1 eb 0c             	shr    $0xc,%ebx
8010723e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107244:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010724b:	89 d9                	mov    %ebx,%ecx
8010724d:	f7 d1                	not    %ecx
8010724f:	83 e1 05             	and    $0x5,%ecx
80107252:	0f 84 78 ff ff ff    	je     801071d0 <copyout+0x20>
  }
  return 0;
}
80107258:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010725b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107260:	5b                   	pop    %ebx
80107261:	5e                   	pop    %esi
80107262:	5f                   	pop    %edi
80107263:	5d                   	pop    %ebp
80107264:	c3                   	ret
80107265:	8d 76 00             	lea    0x0(%esi),%esi
80107268:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010726b:	31 c0                	xor    %eax,%eax
}
8010726d:	5b                   	pop    %ebx
8010726e:	5e                   	pop    %esi
8010726f:	5f                   	pop    %edi
80107270:	5d                   	pop    %ebp
80107271:	c3                   	ret

80107272 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107272:	a1 00 00 00 00       	mov    0x0,%eax
80107277:	0f 0b                	ud2

80107279 <copyout.cold>:
80107279:	a1 00 00 00 00       	mov    0x0,%eax
8010727e:	0f 0b                	ud2
