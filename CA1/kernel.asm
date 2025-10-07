
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
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
80100028:	bc f0 64 11 80       	mov    $0x801164f0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 d0 35 10 80       	mov    $0x801035d0,%eax
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
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 77 10 80       	push   $0x80107700
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 f5 48 00 00       	call   80104950 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
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
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 77 10 80       	push   $0x80107707
80100097:	50                   	push   %eax
80100098:	e8 83 47 00 00       	call   80104820 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
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
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 57 4a 00 00       	call   80104b40 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
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
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
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
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 79 49 00 00       	call   80104ae0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 46 00 00       	call   80104860 <acquiresleep>
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
8010018c:	e8 df 26 00 00       	call   80102870 <iderw>
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
801001a1:	68 0e 77 10 80       	push   $0x8010770e
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
801001be:	e8 3d 47 00 00       	call   80104900 <holdingsleep>
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
801001d4:	e9 97 26 00 00       	jmp    80102870 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 1f 77 10 80       	push   $0x8010771f
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
801001ff:	e8 fc 46 00 00       	call   80104900 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 ac 46 00 00       	call   801048c0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 20 49 00 00       	call   80104b40 <acquire>
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
8010023f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 72 48 00 00       	jmp    80104ae0 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 26 77 10 80       	push   $0x80107726
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
80100294:	e8 87 1b 00 00       	call   80101e20 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801002a0:	e8 9b 48 00 00       	call   80104b40 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
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
801002cd:	e8 ee 42 00 00       	call   801045c0 <sleep>
    while(input.r == input.w){
801002d2:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 19 3c 00 00       	call   80103f00 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 40 ff 10 80       	push   $0x8010ff40
801002f6:	e8 e5 47 00 00       	call   80104ae0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 3c 1a 00 00       	call   80101d40 <ilock>
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
80100326:	0f be 8a a0 fe 10 80 	movsbl -0x7fef0160(%edx),%ecx
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
80100347:	68 40 ff 10 80       	push   $0x8010ff40
8010034c:	e8 8f 47 00 00       	call   80104ae0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 e6 19 00 00       	call   80101d40 <ilock>
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
8010036d:	a3 20 ff 10 80       	mov    %eax,0x8010ff20
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
80100389:	c7 05 74 ff 10 80 00 	movl   $0x0,0x8010ff74
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 d2 2a 00 00       	call   80102e70 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 2d 77 10 80       	push   $0x8010772d
801003a7:	e8 b4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 ab 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 af 7b 10 80 	movl   $0x80107baf,(%esp)
801003bc:	e8 9f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 a3 45 00 00       	call   80104970 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 41 77 10 80       	push   $0x80107741
801003dd:	e8 7e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 78 ff 10 80 01 	movl   $0x1,0x8010ff78
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
8010050c:	e8 bf 47 00 00       	call   80104cd0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100511:	b8 80 07 00 00       	mov    $0x780,%eax
80100516:	83 c4 0c             	add    $0xc,%esp
80100519:	29 f8                	sub    %edi,%eax
8010051b:	01 c0                	add    %eax,%eax
8010051d:	50                   	push   %eax
8010051e:	6a 00                	push   $0x0
80100520:	56                   	push   %esi
80100521:	e8 1a 47 00 00       	call   80104c40 <memset>
  outb(CRTPORT+1, pos);
80100526:	83 c4 10             	add    $0x10,%esp
80100529:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010052d:	e9 4d ff ff ff       	jmp    8010047f <cgaputc+0x7f>
    panic("pos under/overflow");
80100532:	83 ec 0c             	sub    $0xc,%esp
80100535:	68 45 77 10 80       	push   $0x80107745
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
8010054c:	e8 cf 18 00 00       	call   80101e20 <iunlock>
  acquire(&cons.lock);
80100551:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80100558:	e8 e3 45 00 00       	call   80104b40 <acquire>
  for(i = 0; i < n; i++)
8010055d:	8b 4d 10             	mov    0x10(%ebp),%ecx
80100560:	83 c4 10             	add    $0x10,%esp
80100563:	85 c9                	test   %ecx,%ecx
80100565:	7e 36                	jle    8010059d <consolewrite+0x5d>
80100567:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010056a:	8b 7d 10             	mov    0x10(%ebp),%edi
8010056d:	01 df                	add    %ebx,%edi
  if(panicked){
8010056f:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
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
8010058a:	e8 c1 5c 00 00       	call   80106250 <uartputc>
  cgaputc(c);
8010058f:	89 f0                	mov    %esi,%eax
80100591:	e8 6a fe ff ff       	call   80100400 <cgaputc>
  for(i = 0; i < n; i++)
80100596:	83 c4 10             	add    $0x10,%esp
80100599:	39 fb                	cmp    %edi,%ebx
8010059b:	75 d2                	jne    8010056f <consolewrite+0x2f>
  release(&cons.lock);
8010059d:	83 ec 0c             	sub    $0xc,%esp
801005a0:	68 40 ff 10 80       	push   $0x8010ff40
801005a5:	e8 36 45 00 00       	call   80104ae0 <release>
  ilock(ip);
801005aa:	58                   	pop    %eax
801005ab:	ff 75 08             	push   0x8(%ebp)
801005ae:	e8 8d 17 00 00       	call   80101d40 <ilock>

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
801005eb:	0f b6 92 58 7c 10 80 	movzbl -0x7fef83a8(%edx),%edx
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
80100611:	a1 78 ff 10 80       	mov    0x8010ff78,%eax
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
80100624:	e8 27 5c 00 00       	call   80106250 <uartputc>
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
80100669:	8b 3d 74 ff 10 80    	mov    0x8010ff74,%edi
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
80100700:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
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
80100717:	e8 34 5b 00 00       	call   80106250 <uartputc>
  cgaputc(c);
8010071c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010071f:	e8 dc fc ff ff       	call   80100400 <cgaputc>
      continue;
80100724:	83 c4 10             	add    $0x10,%esp
80100727:	eb b1                	jmp    801006da <cprintf+0x7a>
  if(panicked){
80100729:	8b 0d 78 ff 10 80    	mov    0x8010ff78,%ecx
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
8010074e:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
80100754:	85 d2                	test   %edx,%edx
80100756:	0f 85 d0 00 00 00    	jne    8010082c <cprintf+0x1cc>
    uartputc(c);
8010075c:	83 ec 0c             	sub    $0xc,%esp
8010075f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100762:	6a 25                	push   $0x25
80100764:	e8 e7 5a 00 00       	call   80106250 <uartputc>
  cgaputc(c);
80100769:	b8 25 00 00 00       	mov    $0x25,%eax
8010076e:	e8 8d fc ff ff       	call   80100400 <cgaputc>
  if(panicked){
80100773:	a1 78 ff 10 80       	mov    0x8010ff78,%eax
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
801007b3:	68 40 ff 10 80       	push   $0x8010ff40
801007b8:	e8 83 43 00 00       	call   80104b40 <acquire>
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
801007d6:	68 40 ff 10 80       	push   $0x8010ff40
801007db:	e8 00 43 00 00       	call   80104ae0 <release>
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
8010080a:	8b 35 78 ff 10 80    	mov    0x8010ff78,%esi
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
80100825:	bf 58 77 10 80       	mov    $0x80107758,%edi
8010082a:	eb d2                	jmp    801007fe <cprintf+0x19e>
8010082c:	fa                   	cli
    for(;;)
8010082d:	eb fe                	jmp    8010082d <cprintf+0x1cd>
8010082f:	90                   	nop
    uartputc(c);
80100830:	83 ec 0c             	sub    $0xc,%esp
80100833:	6a 25                	push   $0x25
80100835:	e8 16 5a 00 00       	call   80106250 <uartputc>
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
80100856:	e8 f5 59 00 00       	call   80106250 <uartputc>
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
80100882:	e8 c9 59 00 00       	call   80106250 <uartputc>
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
801008a1:	68 5f 77 10 80       	push   $0x8010775f
801008a6:	e8 d5 fa ff ff       	call   80100380 <panic>
801008ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801008b0 <consoleintr>:
{
801008b0:	55                   	push   %ebp
801008b1:	89 e5                	mov    %esp,%ebp
801008b3:	57                   	push   %edi
801008b4:	56                   	push   %esi
801008b5:	53                   	push   %ebx
801008b6:	83 ec 28             	sub    $0x28,%esp
801008b9:	8b 45 08             	mov    0x8(%ebp),%eax
801008bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  acquire(&cons.lock);
801008bf:	68 40 ff 10 80       	push   $0x8010ff40
801008c4:	e8 77 42 00 00       	call   80104b40 <acquire>
  while((c = getc()) >= 0){
801008c9:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
801008cc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((c = getc()) >= 0){
801008d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801008d6:	ff d0                	call   *%eax
801008d8:	85 c0                	test   %eax,%eax
801008da:	0f 88 40 01 00 00    	js     80100a20 <consoleintr+0x170>
    switch(c){
801008e0:	83 f8 15             	cmp    $0x15,%eax
801008e3:	7f 13                	jg     801008f8 <consoleintr+0x48>
801008e5:	85 c0                	test   %eax,%eax
801008e7:	74 ea                	je     801008d3 <consoleintr+0x23>
801008e9:	83 f8 15             	cmp    $0x15,%eax
801008ec:	77 52                	ja     80100940 <consoleintr+0x90>
801008ee:	ff 24 85 00 7c 10 80 	jmp    *-0x7fef8400(,%eax,4)
801008f5:	8d 76 00             	lea    0x0(%esi),%esi
801008f8:	3d e4 00 00 00       	cmp    $0xe4,%eax
801008fd:	0f 84 cd 03 00 00    	je     80100cd0 <consoleintr+0x420>
80100903:	3d e5 00 00 00       	cmp    $0xe5,%eax
80100908:	0f 84 e2 00 00 00    	je     801009f0 <consoleintr+0x140>
8010090e:	83 f8 7f             	cmp    $0x7f,%eax
80100911:	75 2d                	jne    80100940 <consoleintr+0x90>
      if(input.e != input.w){
80100913:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100918:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
8010091e:	74 b3                	je     801008d3 <consoleintr+0x23>
  if(panicked){
80100920:	8b 0d 78 ff 10 80    	mov    0x8010ff78,%ecx
        input.e--;
80100926:	83 e8 01             	sub    $0x1,%eax
80100929:	a3 28 ff 10 80       	mov    %eax,0x8010ff28
  if(panicked){
8010092e:	85 c9                	test   %ecx,%ecx
80100930:	0f 84 d7 04 00 00    	je     80100e0d <consoleintr+0x55d>
80100936:	fa                   	cli
    for(;;)
80100937:	eb fe                	jmp    80100937 <consoleintr+0x87>
80100939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100940:	8b 1d 28 ff 10 80    	mov    0x8010ff28,%ebx
80100946:	89 da                	mov    %ebx,%edx
80100948:	2b 15 20 ff 10 80    	sub    0x8010ff20,%edx
8010094e:	83 fa 7f             	cmp    $0x7f,%edx
80100951:	77 80                	ja     801008d3 <consoleintr+0x23>
        input.buf[input.e++ % INPUT_BUF] = c;
80100953:	89 d9                	mov    %ebx,%ecx
80100955:	83 c3 01             	add    $0x1,%ebx
  if(panicked){
80100958:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
8010095e:	89 1d 28 ff 10 80    	mov    %ebx,0x8010ff28
80100964:	83 e1 7f             	and    $0x7f,%ecx
        c = (c == '\r') ? '\n' : c;
80100967:	83 f8 0d             	cmp    $0xd,%eax
8010096a:	0f 84 51 05 00 00    	je     80100ec1 <consoleintr+0x611>
        input.buf[input.e++ % INPUT_BUF] = c;
80100970:	88 81 a0 fe 10 80    	mov    %al,-0x7fef0160(%ecx)
  if(panicked){
80100976:	85 d2                	test   %edx,%edx
80100978:	0f 85 c3 04 00 00    	jne    80100e41 <consoleintr+0x591>
  if(c == BACKSPACE){
8010097e:	3d 00 01 00 00       	cmp    $0x100,%eax
80100983:	0f 85 68 05 00 00    	jne    80100ef1 <consoleintr+0x641>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100989:	83 ec 0c             	sub    $0xc,%esp
8010098c:	6a 08                	push   $0x8
8010098e:	e8 bd 58 00 00       	call   80106250 <uartputc>
80100993:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010099a:	e8 b1 58 00 00       	call   80106250 <uartputc>
8010099f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801009a6:	e8 a5 58 00 00       	call   80106250 <uartputc>
  cgaputc(c);
801009ab:	b8 00 01 00 00       	mov    $0x100,%eax
801009b0:	e8 4b fa ff ff       	call   80100400 <cgaputc>
801009b5:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009b8:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801009bd:	83 e8 80             	sub    $0xffffff80,%eax
801009c0:	39 05 28 ff 10 80    	cmp    %eax,0x8010ff28
801009c6:	0f 85 07 ff ff ff    	jne    801008d3 <consoleintr+0x23>
          wakeup(&input.r);
801009cc:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801009cf:	a3 24 ff 10 80       	mov    %eax,0x8010ff24
          wakeup(&input.r);
801009d4:	68 20 ff 10 80       	push   $0x8010ff20
801009d9:	e8 a2 3c 00 00       	call   80104680 <wakeup>
801009de:	83 c4 10             	add    $0x10,%esp
801009e1:	e9 ed fe ff ff       	jmp    801008d3 <consoleintr+0x23>
801009e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801009ed:	00 
801009ee:	66 90                	xchg   %ax,%ax
      if(end_of_line>input.e){
801009f0:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
801009f5:	3b 05 80 fe 10 80    	cmp    0x8010fe80,%eax
801009fb:	0f 82 53 04 00 00    	jb     80100e54 <consoleintr+0x5a4>
        end_of_line=input.e;
80100a01:	a3 80 fe 10 80       	mov    %eax,0x8010fe80
  while((c = getc()) >= 0){
80100a06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        left_key_pressed=0;
80100a09:	c7 05 84 fe 10 80 00 	movl   $0x0,0x8010fe84
80100a10:	00 00 00 
  while((c = getc()) >= 0){
80100a13:	ff d0                	call   *%eax
80100a15:	85 c0                	test   %eax,%eax
80100a17:	0f 89 c3 fe ff ff    	jns    801008e0 <consoleintr+0x30>
80100a1d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&cons.lock);
80100a20:	83 ec 0c             	sub    $0xc,%esp
80100a23:	68 40 ff 10 80       	push   $0x8010ff40
80100a28:	e8 b3 40 00 00       	call   80104ae0 <release>
  if(doprocdump) {
80100a2d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100a30:	83 c4 10             	add    $0x10,%esp
80100a33:	85 c0                	test   %eax,%eax
80100a35:	0f 85 0d 04 00 00    	jne    80100e48 <consoleintr+0x598>
}
80100a3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a3e:	5b                   	pop    %ebx
80100a3f:	5e                   	pop    %esi
80100a40:	5f                   	pop    %edi
80100a41:	5d                   	pop    %ebp
80100a42:	c3                   	ret
      cgaputc('0' + input.e);
80100a43:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100a48:	83 c0 30             	add    $0x30,%eax
80100a4b:	e8 b0 f9 ff ff       	call   80100400 <cgaputc>
      cgaputc('0' + input.w);
80100a50:	a1 24 ff 10 80       	mov    0x8010ff24,%eax
80100a55:	83 c0 30             	add    $0x30,%eax
80100a58:	e8 a3 f9 ff ff       	call   80100400 <cgaputc>
      cgaputc('0' + input.r);
80100a5d:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
80100a62:	83 c0 30             	add    $0x30,%eax
80100a65:	e8 96 f9 ff ff       	call   80100400 <cgaputc>
      cgaputc('0' + end_of_line);
80100a6a:	a1 80 fe 10 80       	mov    0x8010fe80,%eax
80100a6f:	83 c0 30             	add    $0x30,%eax
80100a72:	e8 89 f9 ff ff       	call   80100400 <cgaputc>
      break;
80100a77:	e9 57 fe ff ff       	jmp    801008d3 <consoleintr+0x23>
        int pos = input.e;
80100a7c:	8b 1d 28 ff 10 80    	mov    0x8010ff28,%ebx
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<end_of_line)
80100a82:	89 d9                	mov    %ebx,%ecx
        int pos = input.e;
80100a84:	89 da                	mov    %ebx,%edx
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<end_of_line)
80100a86:	c1 f9 1f             	sar    $0x1f,%ecx
80100a89:	c1 e9 19             	shr    $0x19,%ecx
80100a8c:	8d 04 0b             	lea    (%ebx,%ecx,1),%eax
80100a8f:	83 e0 7f             	and    $0x7f,%eax
80100a92:	29 c8                	sub    %ecx,%eax
80100a94:	80 b8 a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%eax)
80100a9b:	74 33                	je     80100ad0 <consoleintr+0x220>
80100a9d:	8b 35 80 fe 10 80    	mov    0x8010fe80,%esi
80100aa3:	eb 1f                	jmp    80100ac4 <consoleintr+0x214>
80100aa5:	8d 76 00             	lea    0x0(%esi),%esi
            pos++;
80100aa8:	83 c2 01             	add    $0x1,%edx
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<end_of_line)
80100aab:	89 d1                	mov    %edx,%ecx
80100aad:	c1 f9 1f             	sar    $0x1f,%ecx
80100ab0:	c1 e9 19             	shr    $0x19,%ecx
80100ab3:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80100ab6:	83 e0 7f             	and    $0x7f,%eax
80100ab9:	29 c8                	sub    %ecx,%eax
80100abb:	80 b8 a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%eax)
80100ac2:	74 0c                	je     80100ad0 <consoleintr+0x220>
80100ac4:	39 d6                	cmp    %edx,%esi
80100ac6:	7f e0                	jg     80100aa8 <consoleintr+0x1f8>
80100ac8:	eb 09                	jmp    80100ad3 <consoleintr+0x223>
80100aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            pos++;
80100ad0:	83 c2 01             	add    $0x1,%edx
            while (input.buf[pos % INPUT_BUF] == ' '){
80100ad3:	89 d1                	mov    %edx,%ecx
80100ad5:	c1 f9 1f             	sar    $0x1f,%ecx
80100ad8:	c1 e9 19             	shr    $0x19,%ecx
80100adb:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80100ade:	83 e0 7f             	and    $0x7f,%eax
80100ae1:	29 c8                	sub    %ecx,%eax
80100ae3:	80 b8 a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%eax)
80100aea:	74 e4                	je     80100ad0 <consoleintr+0x220>
        int distance = pos - input.e;
80100aec:	89 d0                	mov    %edx,%eax
80100aee:	29 d8                	sub    %ebx,%eax
80100af0:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < distance; i++)
80100af3:	85 c0                	test   %eax,%eax
80100af5:	7e 6d                	jle    80100b64 <consoleintr+0x2b4>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100af7:	89 55 d8             	mov    %edx,-0x28(%ebp)
80100afa:	31 f6                	xor    %esi,%esi
80100afc:	bf 0e 00 00 00       	mov    $0xe,%edi
80100b01:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100b06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100b0d:	00 
80100b0e:	66 90                	xchg   %ax,%ax
80100b10:	89 f8                	mov    %edi,%eax
80100b12:	89 da                	mov    %ebx,%edx
80100b14:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b15:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100b1a:	ec                   	in     (%dx),%al

void move_cursor_right(void) {
    int pos;

    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
80100b1b:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b1e:	89 da                	mov    %ebx,%edx
80100b20:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b25:	c1 e1 08             	shl    $0x8,%ecx
80100b28:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b29:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100b2e:	ec                   	in     (%dx),%al
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80100b2f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b32:	89 da                	mov    %ebx,%edx
80100b34:	09 c1                	or     %eax,%ecx
80100b36:	89 f8                	mov    %edi,%eax

    pos++;
80100b38:	83 c1 01             	add    $0x1,%ecx
80100b3b:	ee                   	out    %al,(%dx)

    outb(CRTPORT, 14);
    outb(CRTPORT+1, pos >> 8);
80100b3c:	89 ca                	mov    %ecx,%edx
80100b3e:	c1 fa 08             	sar    $0x8,%edx
80100b41:	89 d0                	mov    %edx,%eax
80100b43:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100b48:	ee                   	out    %al,(%dx)
80100b49:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b4e:	89 da                	mov    %ebx,%edx
80100b50:	ee                   	out    %al,(%dx)
80100b51:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100b56:	89 c8                	mov    %ecx,%eax
80100b58:	ee                   	out    %al,(%dx)
        for (int i = 0; i < distance; i++)
80100b59:	83 c6 01             	add    $0x1,%esi
80100b5c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80100b5f:	75 af                	jne    80100b10 <consoleintr+0x260>
80100b61:	8b 55 d8             	mov    -0x28(%ebp),%edx
        input.e = pos;
80100b64:	89 15 28 ff 10 80    	mov    %edx,0x8010ff28
        break;
80100b6a:	e9 64 fd ff ff       	jmp    801008d3 <consoleintr+0x23>
         int posA = input.e;
80100b6f:	8b 15 28 ff 10 80    	mov    0x8010ff28,%edx
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80100b75:	89 d1                	mov    %edx,%ecx
         int posA = input.e;
80100b77:	89 d0                	mov    %edx,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80100b79:	89 d7                	mov    %edx,%edi
80100b7b:	c1 f9 1f             	sar    $0x1f,%ecx
80100b7e:	c1 e9 19             	shr    $0x19,%ecx
80100b81:	8d 1c 0a             	lea    (%edx,%ecx,1),%ebx
80100b84:	83 e3 7f             	and    $0x7f,%ebx
80100b87:	29 cb                	sub    %ecx,%ebx
      while(input.e != input.w &&
80100b89:	8b 0d 24 ff 10 80    	mov    0x8010ff24,%ecx
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80100b8f:	80 bb 9f fe 10 80 20 	cmpb   $0x20,-0x7fef0161(%ebx)
80100b96:	74 28                	je     80100bc0 <consoleintr+0x310>
80100b98:	eb 2c                	jmp    80100bc6 <consoleintr+0x316>
80100b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            posA--;
80100ba0:	83 e8 01             	sub    $0x1,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80100ba3:	89 c6                	mov    %eax,%esi
80100ba5:	c1 fe 1f             	sar    $0x1f,%esi
80100ba8:	c1 ee 19             	shr    $0x19,%esi
80100bab:	8d 1c 30             	lea    (%eax,%esi,1),%ebx
80100bae:	83 e3 7f             	and    $0x7f,%ebx
80100bb1:	29 f3                	sub    %esi,%ebx
80100bb3:	80 bb 9f fe 10 80 20 	cmpb   $0x20,-0x7fef0161(%ebx)
80100bba:	0f 85 08 02 00 00    	jne    80100dc8 <consoleintr+0x518>
80100bc0:	89 c7                	mov    %eax,%edi
80100bc2:	39 c1                	cmp    %eax,%ecx
80100bc4:	72 da                	jb     80100ba0 <consoleintr+0x2f0>
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
80100bc6:	80 bb a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ebx)
80100bcd:	0f 84 04 02 00 00    	je     80100dd7 <consoleintr+0x527>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
80100bd3:	89 c6                	mov    %eax,%esi
80100bd5:	c1 fe 1f             	sar    $0x1f,%esi
80100bd8:	c1 ee 19             	shr    $0x19,%esi
80100bdb:	8d 1c 30             	lea    (%eax,%esi,1),%ebx
80100bde:	83 e3 7f             	and    $0x7f,%ebx
80100be1:	29 f3                	sub    %esi,%ebx
80100be3:	80 bb a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ebx)
80100bea:	75 2c                	jne    80100c18 <consoleintr+0x368>
80100bec:	e9 fa 01 00 00       	jmp    80100deb <consoleintr+0x53b>
80100bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            posA--;
80100bf8:	83 e8 01             	sub    $0x1,%eax
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
80100bfb:	89 c6                	mov    %eax,%esi
80100bfd:	c1 fe 1f             	sar    $0x1f,%esi
80100c00:	c1 ee 19             	shr    $0x19,%esi
80100c03:	8d 1c 30             	lea    (%eax,%esi,1),%ebx
80100c06:	83 e3 7f             	and    $0x7f,%ebx
80100c09:	29 f3                	sub    %esi,%ebx
80100c0b:	80 bb a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ebx)
80100c12:	0f 84 d1 01 00 00    	je     80100de9 <consoleintr+0x539>
80100c18:	89 c7                	mov    %eax,%edi
80100c1a:	39 c1                	cmp    %eax,%ecx
80100c1c:	72 da                	jb     80100bf8 <consoleintr+0x348>
        int distanceA = input.e-posA;
80100c1e:	29 fa                	sub    %edi,%edx
        for (int i = distanceA; i > 0; i--)
80100c20:	85 d2                	test   %edx,%edx
80100c22:	0f 8e 4b 01 00 00    	jle    80100d73 <consoleintr+0x4c3>
80100c28:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100c2b:	be d4 03 00 00       	mov    $0x3d4,%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100c30:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100c35:	89 7d d8             	mov    %edi,-0x28(%ebp)
80100c38:	eb 30                	jmp    80100c6a <consoleintr+0x3ba>
80100c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pos--;
80100c40:	8d 48 ff             	lea    -0x1(%eax),%ecx
  outb(CRTPORT+1, pos>>8);
80100c43:	0f b6 fd             	movzbl %ch,%edi
80100c46:	b8 0e 00 00 00       	mov    $0xe,%eax
80100c4b:	89 f2                	mov    %esi,%edx
80100c4d:	ee                   	out    %al,(%dx)
80100c4e:	89 f8                	mov    %edi,%eax
80100c50:	89 da                	mov    %ebx,%edx
80100c52:	ee                   	out    %al,(%dx)
80100c53:	b8 0f 00 00 00       	mov    $0xf,%eax
80100c58:	89 f2                	mov    %esi,%edx
80100c5a:	ee                   	out    %al,(%dx)
80100c5b:	89 c8                	mov    %ecx,%eax
80100c5d:	89 da                	mov    %ebx,%edx
80100c5f:	ee                   	out    %al,(%dx)
        for (int i = distanceA; i > 0; i--)
80100c60:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
80100c64:	0f 84 06 01 00 00    	je     80100d70 <consoleintr+0x4c0>
80100c6a:	b8 0e 00 00 00       	mov    $0xe,%eax
80100c6f:	89 f2                	mov    %esi,%edx
80100c71:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100c72:	89 da                	mov    %ebx,%edx
80100c74:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100c75:	0f b6 f8             	movzbl %al,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100c78:	89 f2                	mov    %esi,%edx
80100c7a:	b8 0f 00 00 00       	mov    $0xf,%eax
80100c7f:	c1 e7 08             	shl    $0x8,%edi
80100c82:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100c83:	89 da                	mov    %ebx,%edx
80100c85:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100c86:	0f b6 c0             	movzbl %al,%eax
  if(pos>0)
80100c89:	09 f8                	or     %edi,%eax
80100c8b:	75 b3                	jne    80100c40 <consoleintr+0x390>
80100c8d:	31 c9                	xor    %ecx,%ecx
80100c8f:	31 ff                	xor    %edi,%edi
80100c91:	eb b3                	jmp    80100c46 <consoleintr+0x396>
      while(input.e != input.w &&
80100c93:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100c98:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
80100c9e:	0f 84 2f fc ff ff    	je     801008d3 <consoleintr+0x23>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100ca4:	83 e8 01             	sub    $0x1,%eax
80100ca7:	89 c2                	mov    %eax,%edx
80100ca9:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100cac:	80 ba a0 fe 10 80 0a 	cmpb   $0xa,-0x7fef0160(%edx)
80100cb3:	0f 84 1a fc ff ff    	je     801008d3 <consoleintr+0x23>
  if(panicked){
80100cb9:	8b 1d 78 ff 10 80    	mov    0x8010ff78,%ebx
        input.e--;
80100cbf:	a3 28 ff 10 80       	mov    %eax,0x8010ff28
  if(panicked){
80100cc4:	85 db                	test   %ebx,%ebx
80100cc6:	0f 84 b2 00 00 00    	je     80100d7e <consoleintr+0x4ce>
  asm volatile("cli");
80100ccc:	fa                   	cli
    for(;;)
80100ccd:	eb fe                	jmp    80100ccd <consoleintr+0x41d>
80100ccf:	90                   	nop
        if (input.w < (input.e))
80100cd0:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100cd5:	39 05 24 ff 10 80    	cmp    %eax,0x8010ff24
80100cdb:	0f 83 f2 fb ff ff    	jae    801008d3 <consoleintr+0x23>
          if (left_key_pressed==0)
80100ce1:	8b 15 84 fe 10 80    	mov    0x8010fe84,%edx
80100ce7:	85 d2                	test   %edx,%edx
80100ce9:	75 0f                	jne    80100cfa <consoleintr+0x44a>
            end_of_line=input.e;
80100ceb:	a3 80 fe 10 80       	mov    %eax,0x8010fe80
            left_key_pressed=1;
80100cf0:	c7 05 84 fe 10 80 01 	movl   $0x1,0x8010fe84
80100cf7:	00 00 00 
          input.e--;
80100cfa:	83 e8 01             	sub    $0x1,%eax
          uartputc('\b');
80100cfd:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d00:	be d4 03 00 00       	mov    $0x3d4,%esi
          input.e--;
80100d05:	a3 28 ff 10 80       	mov    %eax,0x8010ff28
          uartputc('\b');
80100d0a:	6a 08                	push   $0x8
80100d0c:	e8 3f 55 00 00       	call   80106250 <uartputc>
80100d11:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d16:	89 f2                	mov    %esi,%edx
80100d18:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d19:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100d1e:	89 da                	mov    %ebx,%edx
80100d20:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100d21:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d24:	89 f2                	mov    %esi,%edx
80100d26:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d2b:	c1 e1 08             	shl    $0x8,%ecx
80100d2e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d2f:	89 da                	mov    %ebx,%edx
80100d31:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100d32:	0f b6 c0             	movzbl %al,%eax
  if(pos>0)
80100d35:	83 c4 10             	add    $0x10,%esp
80100d38:	09 c8                	or     %ecx,%eax
80100d3a:	0f 84 c4 00 00 00    	je     80100e04 <consoleintr+0x554>
    pos--;
80100d40:	8d 48 ff             	lea    -0x1(%eax),%ecx
  outb(CRTPORT+1, pos>>8);
80100d43:	0f b6 fd             	movzbl %ch,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d46:	be d4 03 00 00       	mov    $0x3d4,%esi
80100d4b:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d50:	89 f2                	mov    %esi,%edx
80100d52:	ee                   	out    %al,(%dx)
80100d53:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100d58:	89 f8                	mov    %edi,%eax
80100d5a:	89 da                	mov    %ebx,%edx
80100d5c:	ee                   	out    %al,(%dx)
80100d5d:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d62:	89 f2                	mov    %esi,%edx
80100d64:	ee                   	out    %al,(%dx)
80100d65:	89 c8                	mov    %ecx,%eax
80100d67:	89 da                	mov    %ebx,%edx
80100d69:	ee                   	out    %al,(%dx)
    outb(CRTPORT, 15);
    outb(CRTPORT+1, pos);
}
80100d6a:	e9 64 fb ff ff       	jmp    801008d3 <consoleintr+0x23>
80100d6f:	90                   	nop
80100d70:	8b 7d d8             	mov    -0x28(%ebp),%edi
        input.e = posA;     
80100d73:	89 3d 28 ff 10 80    	mov    %edi,0x8010ff28
      break;
80100d79:	e9 55 fb ff ff       	jmp    801008d3 <consoleintr+0x23>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100d7e:	83 ec 0c             	sub    $0xc,%esp
80100d81:	6a 08                	push   $0x8
80100d83:	e8 c8 54 00 00       	call   80106250 <uartputc>
80100d88:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100d8f:	e8 bc 54 00 00       	call   80106250 <uartputc>
80100d94:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100d9b:	e8 b0 54 00 00       	call   80106250 <uartputc>
  cgaputc(c);
80100da0:	b8 00 01 00 00       	mov    $0x100,%eax
80100da5:	e8 56 f6 ff ff       	call   80100400 <cgaputc>
      while(input.e != input.w &&
80100daa:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100daf:	83 c4 10             	add    $0x10,%esp
80100db2:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
80100db8:	0f 85 e6 fe ff ff    	jne    80100ca4 <consoleintr+0x3f4>
80100dbe:	e9 10 fb ff ff       	jmp    801008d3 <consoleintr+0x23>
80100dc3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
80100dc8:	80 bb a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ebx)
80100dcf:	89 c7                	mov    %eax,%edi
80100dd1:	0f 85 fc fd ff ff    	jne    80100bd3 <consoleintr+0x323>
80100dd7:	39 f9                	cmp    %edi,%ecx
80100dd9:	0f 83 c0 00 00 00    	jae    80100e9f <consoleintr+0x5ef>
          posA--;
80100ddf:	83 e8 01             	sub    $0x1,%eax
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
80100de2:	89 c7                	mov    %eax,%edi
80100de4:	e9 ea fd ff ff       	jmp    80100bd3 <consoleintr+0x323>
        int distanceA = input.e-posA;
80100de9:	89 c7                	mov    %eax,%edi
          posA++;
80100deb:	83 c0 01             	add    $0x1,%eax
80100dee:	39 f9                	cmp    %edi,%ecx
80100df0:	0f 42 f8             	cmovb  %eax,%edi
80100df3:	e9 26 fe ff ff       	jmp    80100c1e <consoleintr+0x36e>
    switch(c){
80100df8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
80100dff:	e9 cf fa ff ff       	jmp    801008d3 <consoleintr+0x23>
80100e04:	31 c9                	xor    %ecx,%ecx
80100e06:	31 ff                	xor    %edi,%edi
80100e08:	e9 39 ff ff ff       	jmp    80100d46 <consoleintr+0x496>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100e0d:	83 ec 0c             	sub    $0xc,%esp
80100e10:	6a 08                	push   $0x8
80100e12:	e8 39 54 00 00       	call   80106250 <uartputc>
80100e17:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100e1e:	e8 2d 54 00 00       	call   80106250 <uartputc>
80100e23:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100e2a:	e8 21 54 00 00       	call   80106250 <uartputc>
  cgaputc(c);
80100e2f:	b8 00 01 00 00       	mov    $0x100,%eax
80100e34:	e8 c7 f5 ff ff       	call   80100400 <cgaputc>
}
80100e39:	83 c4 10             	add    $0x10,%esp
80100e3c:	e9 92 fa ff ff       	jmp    801008d3 <consoleintr+0x23>
  asm volatile("cli");
80100e41:	fa                   	cli
    for(;;)
80100e42:	eb fe                	jmp    80100e42 <consoleintr+0x592>
80100e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80100e48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e4b:	5b                   	pop    %ebx
80100e4c:	5e                   	pop    %esi
80100e4d:	5f                   	pop    %edi
80100e4e:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100e4f:	e9 0c 39 00 00       	jmp    80104760 <procdump>
        input.e++;
80100e54:	83 c0 01             	add    $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100e57:	bf 0e 00 00 00       	mov    $0xe,%edi
80100e5c:	be d4 03 00 00       	mov    $0x3d4,%esi
80100e61:	a3 28 ff 10 80       	mov    %eax,0x8010ff28
80100e66:	89 f2                	mov    %esi,%edx
80100e68:	89 f8                	mov    %edi,%eax
80100e6a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100e6b:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100e70:	89 da                	mov    %ebx,%edx
80100e72:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100e73:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100e76:	89 f2                	mov    %esi,%edx
80100e78:	c1 e0 08             	shl    $0x8,%eax
80100e7b:	89 c1                	mov    %eax,%ecx
80100e7d:	b8 0f 00 00 00       	mov    $0xf,%eax
80100e82:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100e83:	89 da                	mov    %ebx,%edx
80100e85:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100e86:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100e89:	89 f2                	mov    %esi,%edx
80100e8b:	09 c1                	or     %eax,%ecx
80100e8d:	89 f8                	mov    %edi,%eax
    pos++;
80100e8f:	83 c1 01             	add    $0x1,%ecx
80100e92:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80100e93:	89 cf                	mov    %ecx,%edi
80100e95:	c1 ff 08             	sar    $0x8,%edi
80100e98:	89 f8                	mov    %edi,%eax
80100e9a:	e9 bb fe ff ff       	jmp    80100d5a <consoleintr+0x4aa>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
80100e9f:	89 c6                	mov    %eax,%esi
80100ea1:	c1 fe 1f             	sar    $0x1f,%esi
80100ea4:	c1 ee 19             	shr    $0x19,%esi
80100ea7:	8d 1c 30             	lea    (%eax,%esi,1),%ebx
80100eaa:	83 e3 7f             	and    $0x7f,%ebx
80100ead:	29 f3                	sub    %esi,%ebx
80100eaf:	80 bb a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ebx)
80100eb6:	0f 85 5c fd ff ff    	jne    80100c18 <consoleintr+0x368>
80100ebc:	e9 5d fd ff ff       	jmp    80100c1e <consoleintr+0x36e>
        input.buf[input.e++ % INPUT_BUF] = c;
80100ec1:	c6 81 a0 fe 10 80 0a 	movb   $0xa,-0x7fef0160(%ecx)
  if(panicked){
80100ec8:	85 d2                	test   %edx,%edx
80100eca:	0f 85 71 ff ff ff    	jne    80100e41 <consoleintr+0x591>
    uartputc(c);
80100ed0:	83 ec 0c             	sub    $0xc,%esp
80100ed3:	6a 0a                	push   $0xa
80100ed5:	e8 76 53 00 00       	call   80106250 <uartputc>
  cgaputc(c);
80100eda:	b8 0a 00 00 00       	mov    $0xa,%eax
80100edf:	e8 1c f5 ff ff       	call   80100400 <cgaputc>
          input.w = input.e;
80100ee4:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100ee9:	83 c4 10             	add    $0x10,%esp
80100eec:	e9 db fa ff ff       	jmp    801009cc <consoleintr+0x11c>
    uartputc(c);
80100ef1:	83 ec 0c             	sub    $0xc,%esp
80100ef4:	50                   	push   %eax
80100ef5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100ef8:	e8 53 53 00 00       	call   80106250 <uartputc>
  cgaputc(c);
80100efd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100f00:	e8 fb f4 ff ff       	call   80100400 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100f05:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100f08:	83 c4 10             	add    $0x10,%esp
80100f0b:	83 f8 0a             	cmp    $0xa,%eax
80100f0e:	0f 85 a4 fa ff ff    	jne    801009b8 <consoleintr+0x108>
80100f14:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100f19:	e9 ae fa ff ff       	jmp    801009cc <consoleintr+0x11c>
80100f1e:	66 90                	xchg   %ax,%ax

80100f20 <consoleinit>:
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100f26:	68 68 77 10 80       	push   $0x80107768
80100f2b:	68 40 ff 10 80       	push   $0x8010ff40
80100f30:	e8 1b 3a 00 00       	call   80104950 <initlock>
  ioapicenable(IRQ_KBD, 0);
80100f35:	58                   	pop    %eax
80100f36:	5a                   	pop    %edx
80100f37:	6a 00                	push   $0x0
80100f39:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100f3b:	c7 05 2c 09 11 80 40 	movl   $0x80100540,0x8011092c
80100f42:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100f45:	c7 05 28 09 11 80 80 	movl   $0x80100280,0x80110928
80100f4c:	02 10 80 
  cons.locking = 1;
80100f4f:	c7 05 74 ff 10 80 01 	movl   $0x1,0x8010ff74
80100f56:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100f59:	e8 a2 1a 00 00       	call   80102a00 <ioapicenable>
}
80100f5e:	83 c4 10             	add    $0x10,%esp
80100f61:	c9                   	leave
80100f62:	c3                   	ret
80100f63:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f6a:	00 
80100f6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100f70 <move_cursor_left>:
void move_cursor_left(void){
80100f70:	55                   	push   %ebp
80100f71:	b8 0e 00 00 00       	mov    $0xe,%eax
80100f76:	89 e5                	mov    %esp,%ebp
80100f78:	57                   	push   %edi
80100f79:	56                   	push   %esi
80100f7a:	be d4 03 00 00       	mov    $0x3d4,%esi
80100f7f:	53                   	push   %ebx
80100f80:	89 f2                	mov    %esi,%edx
80100f82:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100f83:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100f88:	89 da                	mov    %ebx,%edx
80100f8a:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100f8b:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100f8e:	89 f2                	mov    %esi,%edx
80100f90:	b8 0f 00 00 00       	mov    $0xf,%eax
80100f95:	c1 e1 08             	shl    $0x8,%ecx
80100f98:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100f99:	89 da                	mov    %ebx,%edx
80100f9b:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100f9c:	0f b6 c0             	movzbl %al,%eax
  if(pos>0)
80100f9f:	09 c8                	or     %ecx,%eax
80100fa1:	74 35                	je     80100fd8 <move_cursor_left+0x68>
    pos--;
80100fa3:	8d 48 ff             	lea    -0x1(%eax),%ecx
  outb(CRTPORT+1, pos>>8);
80100fa6:	0f b6 f5             	movzbl %ch,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100fa9:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100fae:	b8 0e 00 00 00       	mov    $0xe,%eax
80100fb3:	89 fa                	mov    %edi,%edx
80100fb5:	ee                   	out    %al,(%dx)
80100fb6:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100fbb:	89 f0                	mov    %esi,%eax
80100fbd:	89 da                	mov    %ebx,%edx
80100fbf:	ee                   	out    %al,(%dx)
80100fc0:	b8 0f 00 00 00       	mov    $0xf,%eax
80100fc5:	89 fa                	mov    %edi,%edx
80100fc7:	ee                   	out    %al,(%dx)
80100fc8:	89 c8                	mov    %ecx,%eax
80100fca:	89 da                	mov    %ebx,%edx
80100fcc:	ee                   	out    %al,(%dx)
}
80100fcd:	5b                   	pop    %ebx
80100fce:	5e                   	pop    %esi
80100fcf:	5f                   	pop    %edi
80100fd0:	5d                   	pop    %ebp
80100fd1:	c3                   	ret
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fd8:	31 c9                	xor    %ecx,%ecx
80100fda:	31 f6                	xor    %esi,%esi
80100fdc:	eb cb                	jmp    80100fa9 <move_cursor_left+0x39>
80100fde:	66 90                	xchg   %ax,%ax

80100fe0 <move_cursor_right>:
void move_cursor_right(void) {
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	bf 0e 00 00 00       	mov    $0xe,%edi
80100fe9:	56                   	push   %esi
80100fea:	89 f8                	mov    %edi,%eax
80100fec:	53                   	push   %ebx
80100fed:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100ff2:	89 da                	mov    %ebx,%edx
80100ff4:	83 ec 04             	sub    $0x4,%esp
80100ff7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ff8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100ffd:	89 ca                	mov    %ecx,%edx
80100fff:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80101000:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101003:	be 0f 00 00 00       	mov    $0xf,%esi
80101008:	89 da                	mov    %ebx,%edx
8010100a:	c1 e0 08             	shl    $0x8,%eax
8010100d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101010:	89 f0                	mov    %esi,%eax
80101012:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101013:	89 ca                	mov    %ecx,%edx
80101015:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80101016:	8b 55 f0             	mov    -0x10(%ebp),%edx
80101019:	0f b6 c0             	movzbl %al,%eax
8010101c:	09 d0                	or     %edx,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010101e:	89 da                	mov    %ebx,%edx
    pos++;
80101020:	83 c0 01             	add    $0x1,%eax
80101023:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101026:	89 f8                	mov    %edi,%eax
80101028:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80101029:	8b 7d f0             	mov    -0x10(%ebp),%edi
8010102c:	89 ca                	mov    %ecx,%edx
8010102e:	89 f8                	mov    %edi,%eax
80101030:	c1 f8 08             	sar    $0x8,%eax
80101033:	ee                   	out    %al,(%dx)
80101034:	89 f0                	mov    %esi,%eax
80101036:	89 da                	mov    %ebx,%edx
80101038:	ee                   	out    %al,(%dx)
80101039:	89 f8                	mov    %edi,%eax
8010103b:	89 ca                	mov    %ecx,%edx
8010103d:	ee                   	out    %al,(%dx)
}
8010103e:	83 c4 04             	add    $0x4,%esp
80101041:	5b                   	pop    %ebx
80101042:	5e                   	pop    %esi
80101043:	5f                   	pop    %edi
80101044:	5d                   	pop    %ebp
80101045:	c3                   	ret
80101046:	66 90                	xchg   %ax,%ax
80101048:	66 90                	xchg   %ax,%ax
8010104a:	66 90                	xchg   %ax,%ax
8010104c:	66 90                	xchg   %ax,%ax
8010104e:	66 90                	xchg   %ax,%ax

80101050 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80101050:	55                   	push   %ebp
80101051:	89 e5                	mov    %esp,%ebp
80101053:	57                   	push   %edi
80101054:	56                   	push   %esi
80101055:	53                   	push   %ebx
80101056:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
8010105c:	e8 9f 2e 00 00       	call   80103f00 <myproc>
80101061:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101067:	e8 74 22 00 00       	call   801032e0 <begin_op>

  if((ip = namei(path)) == 0){
8010106c:	83 ec 0c             	sub    $0xc,%esp
8010106f:	ff 75 08             	push   0x8(%ebp)
80101072:	e8 a9 15 00 00       	call   80102620 <namei>
80101077:	83 c4 10             	add    $0x10,%esp
8010107a:	85 c0                	test   %eax,%eax
8010107c:	0f 84 30 03 00 00    	je     801013b2 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101082:	83 ec 0c             	sub    $0xc,%esp
80101085:	89 c7                	mov    %eax,%edi
80101087:	50                   	push   %eax
80101088:	e8 b3 0c 00 00       	call   80101d40 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
8010108d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101093:	6a 34                	push   $0x34
80101095:	6a 00                	push   $0x0
80101097:	50                   	push   %eax
80101098:	57                   	push   %edi
80101099:	e8 b2 0f 00 00       	call   80102050 <readi>
8010109e:	83 c4 20             	add    $0x20,%esp
801010a1:	83 f8 34             	cmp    $0x34,%eax
801010a4:	0f 85 01 01 00 00    	jne    801011ab <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
801010aa:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
801010b1:	45 4c 46 
801010b4:	0f 85 f1 00 00 00    	jne    801011ab <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
801010ba:	e8 01 63 00 00       	call   801073c0 <setupkvm>
801010bf:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
801010c5:	85 c0                	test   %eax,%eax
801010c7:	0f 84 de 00 00 00    	je     801011ab <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801010cd:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
801010d4:	00 
801010d5:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
801010db:	0f 84 a1 02 00 00    	je     80101382 <exec+0x332>
  sz = 0;
801010e1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
801010e8:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801010eb:	31 db                	xor    %ebx,%ebx
801010ed:	e9 8c 00 00 00       	jmp    8010117e <exec+0x12e>
801010f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
801010f8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
801010ff:	75 6c                	jne    8010116d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80101101:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80101107:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
8010110d:	0f 82 87 00 00 00    	jb     8010119a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80101113:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101119:	72 7f                	jb     8010119a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
8010111b:	83 ec 04             	sub    $0x4,%esp
8010111e:	50                   	push   %eax
8010111f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80101125:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010112b:	e8 c0 60 00 00       	call   801071f0 <allocuvm>
80101130:	83 c4 10             	add    $0x10,%esp
80101133:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101139:	85 c0                	test   %eax,%eax
8010113b:	74 5d                	je     8010119a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
8010113d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80101143:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101148:	75 50                	jne    8010119a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
8010114a:	83 ec 0c             	sub    $0xc,%esp
8010114d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80101153:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101159:	57                   	push   %edi
8010115a:	50                   	push   %eax
8010115b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101161:	e8 ba 5f 00 00       	call   80107120 <loaduvm>
80101166:	83 c4 20             	add    $0x20,%esp
80101169:	85 c0                	test   %eax,%eax
8010116b:	78 2d                	js     8010119a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010116d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80101174:	83 c3 01             	add    $0x1,%ebx
80101177:	83 c6 20             	add    $0x20,%esi
8010117a:	39 d8                	cmp    %ebx,%eax
8010117c:	7e 52                	jle    801011d0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
8010117e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80101184:	6a 20                	push   $0x20
80101186:	56                   	push   %esi
80101187:	50                   	push   %eax
80101188:	57                   	push   %edi
80101189:	e8 c2 0e 00 00       	call   80102050 <readi>
8010118e:	83 c4 10             	add    $0x10,%esp
80101191:	83 f8 20             	cmp    $0x20,%eax
80101194:	0f 84 5e ff ff ff    	je     801010f8 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
8010119a:	83 ec 0c             	sub    $0xc,%esp
8010119d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801011a3:	e8 98 61 00 00       	call   80107340 <freevm>
  if(ip){
801011a8:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801011ab:	83 ec 0c             	sub    $0xc,%esp
801011ae:	57                   	push   %edi
801011af:	e8 1c 0e 00 00       	call   80101fd0 <iunlockput>
    end_op();
801011b4:	e8 97 21 00 00       	call   80103350 <end_op>
801011b9:	83 c4 10             	add    $0x10,%esp
    return -1;
801011bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
801011c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011c4:	5b                   	pop    %ebx
801011c5:	5e                   	pop    %esi
801011c6:	5f                   	pop    %edi
801011c7:	5d                   	pop    %ebp
801011c8:	c3                   	ret
801011c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
801011d0:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
801011d6:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
801011dc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
801011e2:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
801011e8:	83 ec 0c             	sub    $0xc,%esp
801011eb:	57                   	push   %edi
801011ec:	e8 df 0d 00 00       	call   80101fd0 <iunlockput>
  end_op();
801011f1:	e8 5a 21 00 00       	call   80103350 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
801011f6:	83 c4 0c             	add    $0xc,%esp
801011f9:	53                   	push   %ebx
801011fa:	56                   	push   %esi
801011fb:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80101201:	56                   	push   %esi
80101202:	e8 e9 5f 00 00       	call   801071f0 <allocuvm>
80101207:	83 c4 10             	add    $0x10,%esp
8010120a:	89 c7                	mov    %eax,%edi
8010120c:	85 c0                	test   %eax,%eax
8010120e:	0f 84 86 00 00 00    	je     8010129a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101214:	83 ec 08             	sub    $0x8,%esp
80101217:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
8010121d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010121f:	50                   	push   %eax
80101220:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80101221:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101223:	e8 38 62 00 00       	call   80107460 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101228:	8b 45 0c             	mov    0xc(%ebp),%eax
8010122b:	83 c4 10             	add    $0x10,%esp
8010122e:	8b 10                	mov    (%eax),%edx
80101230:	85 d2                	test   %edx,%edx
80101232:	0f 84 56 01 00 00    	je     8010138e <exec+0x33e>
80101238:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
8010123e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101241:	eb 23                	jmp    80101266 <exec+0x216>
80101243:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101248:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
8010124b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80101252:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80101258:	8b 14 87             	mov    (%edi,%eax,4),%edx
8010125b:	85 d2                	test   %edx,%edx
8010125d:	74 51                	je     801012b0 <exec+0x260>
    if(argc >= MAXARG)
8010125f:	83 f8 20             	cmp    $0x20,%eax
80101262:	74 36                	je     8010129a <exec+0x24a>
80101264:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101266:	83 ec 0c             	sub    $0xc,%esp
80101269:	52                   	push   %edx
8010126a:	e8 c1 3b 00 00       	call   80104e30 <strlen>
8010126f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101271:	58                   	pop    %eax
80101272:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101275:	83 eb 01             	sub    $0x1,%ebx
80101278:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010127b:	e8 b0 3b 00 00       	call   80104e30 <strlen>
80101280:	83 c0 01             	add    $0x1,%eax
80101283:	50                   	push   %eax
80101284:	ff 34 b7             	push   (%edi,%esi,4)
80101287:	53                   	push   %ebx
80101288:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010128e:	e8 9d 63 00 00       	call   80107630 <copyout>
80101293:	83 c4 20             	add    $0x20,%esp
80101296:	85 c0                	test   %eax,%eax
80101298:	79 ae                	jns    80101248 <exec+0x1f8>
    freevm(pgdir);
8010129a:	83 ec 0c             	sub    $0xc,%esp
8010129d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801012a3:	e8 98 60 00 00       	call   80107340 <freevm>
801012a8:	83 c4 10             	add    $0x10,%esp
801012ab:	e9 0c ff ff ff       	jmp    801011bc <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801012b0:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
801012b7:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801012bd:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801012c3:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
801012c6:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
801012c9:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
801012d0:	00 00 00 00 
  ustack[1] = argc;
801012d4:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
801012da:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
801012e1:	ff ff ff 
  ustack[1] = argc;
801012e4:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801012ea:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
801012ec:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801012ee:	29 d0                	sub    %edx,%eax
801012f0:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801012f6:	56                   	push   %esi
801012f7:	51                   	push   %ecx
801012f8:	53                   	push   %ebx
801012f9:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801012ff:	e8 2c 63 00 00       	call   80107630 <copyout>
80101304:	83 c4 10             	add    $0x10,%esp
80101307:	85 c0                	test   %eax,%eax
80101309:	78 8f                	js     8010129a <exec+0x24a>
  for(last=s=path; *s; s++)
8010130b:	8b 45 08             	mov    0x8(%ebp),%eax
8010130e:	8b 55 08             	mov    0x8(%ebp),%edx
80101311:	0f b6 00             	movzbl (%eax),%eax
80101314:	84 c0                	test   %al,%al
80101316:	74 17                	je     8010132f <exec+0x2df>
80101318:	89 d1                	mov    %edx,%ecx
8010131a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80101320:	83 c1 01             	add    $0x1,%ecx
80101323:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101325:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101328:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010132b:	84 c0                	test   %al,%al
8010132d:	75 f1                	jne    80101320 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010132f:	83 ec 04             	sub    $0x4,%esp
80101332:	6a 10                	push   $0x10
80101334:	52                   	push   %edx
80101335:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
8010133b:	8d 46 6c             	lea    0x6c(%esi),%eax
8010133e:	50                   	push   %eax
8010133f:	e8 ac 3a 00 00       	call   80104df0 <safestrcpy>
  curproc->pgdir = pgdir;
80101344:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010134a:	89 f0                	mov    %esi,%eax
8010134c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
8010134f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80101351:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101354:	89 c1                	mov    %eax,%ecx
80101356:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010135c:	8b 40 18             	mov    0x18(%eax),%eax
8010135f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101362:	8b 41 18             	mov    0x18(%ecx),%eax
80101365:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101368:	89 0c 24             	mov    %ecx,(%esp)
8010136b:	e8 20 5c 00 00       	call   80106f90 <switchuvm>
  freevm(oldpgdir);
80101370:	89 34 24             	mov    %esi,(%esp)
80101373:	e8 c8 5f 00 00       	call   80107340 <freevm>
  return 0;
80101378:	83 c4 10             	add    $0x10,%esp
8010137b:	31 c0                	xor    %eax,%eax
8010137d:	e9 3f fe ff ff       	jmp    801011c1 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101382:	bb 00 20 00 00       	mov    $0x2000,%ebx
80101387:	31 f6                	xor    %esi,%esi
80101389:	e9 5a fe ff ff       	jmp    801011e8 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
8010138e:	be 10 00 00 00       	mov    $0x10,%esi
80101393:	ba 04 00 00 00       	mov    $0x4,%edx
80101398:	b8 03 00 00 00       	mov    $0x3,%eax
8010139d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
801013a4:	00 00 00 
801013a7:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
801013ad:	e9 17 ff ff ff       	jmp    801012c9 <exec+0x279>
    end_op();
801013b2:	e8 99 1f 00 00       	call   80103350 <end_op>
    cprintf("exec: fail\n");
801013b7:	83 ec 0c             	sub    $0xc,%esp
801013ba:	68 70 77 10 80       	push   $0x80107770
801013bf:	e8 9c f2 ff ff       	call   80100660 <cprintf>
    return -1;
801013c4:	83 c4 10             	add    $0x10,%esp
801013c7:	e9 f0 fd ff ff       	jmp    801011bc <exec+0x16c>
801013cc:	66 90                	xchg   %ax,%ax
801013ce:	66 90                	xchg   %ax,%ax

801013d0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801013d6:	68 7c 77 10 80       	push   $0x8010777c
801013db:	68 80 ff 10 80       	push   $0x8010ff80
801013e0:	e8 6b 35 00 00       	call   80104950 <initlock>
}
801013e5:	83 c4 10             	add    $0x10,%esp
801013e8:	c9                   	leave
801013e9:	c3                   	ret
801013ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801013f0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801013f4:	bb b4 ff 10 80       	mov    $0x8010ffb4,%ebx
{
801013f9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801013fc:	68 80 ff 10 80       	push   $0x8010ff80
80101401:	e8 3a 37 00 00       	call   80104b40 <acquire>
80101406:	83 c4 10             	add    $0x10,%esp
80101409:	eb 10                	jmp    8010141b <filealloc+0x2b>
8010140b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101410:	83 c3 18             	add    $0x18,%ebx
80101413:	81 fb 14 09 11 80    	cmp    $0x80110914,%ebx
80101419:	74 25                	je     80101440 <filealloc+0x50>
    if(f->ref == 0){
8010141b:	8b 43 04             	mov    0x4(%ebx),%eax
8010141e:	85 c0                	test   %eax,%eax
80101420:	75 ee                	jne    80101410 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101422:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101425:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010142c:	68 80 ff 10 80       	push   $0x8010ff80
80101431:	e8 aa 36 00 00       	call   80104ae0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101436:	89 d8                	mov    %ebx,%eax
      return f;
80101438:	83 c4 10             	add    $0x10,%esp
}
8010143b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010143e:	c9                   	leave
8010143f:	c3                   	ret
  release(&ftable.lock);
80101440:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101443:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101445:	68 80 ff 10 80       	push   $0x8010ff80
8010144a:	e8 91 36 00 00       	call   80104ae0 <release>
}
8010144f:	89 d8                	mov    %ebx,%eax
  return 0;
80101451:	83 c4 10             	add    $0x10,%esp
}
80101454:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101457:	c9                   	leave
80101458:	c3                   	ret
80101459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101460 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	53                   	push   %ebx
80101464:	83 ec 10             	sub    $0x10,%esp
80101467:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010146a:	68 80 ff 10 80       	push   $0x8010ff80
8010146f:	e8 cc 36 00 00       	call   80104b40 <acquire>
  if(f->ref < 1)
80101474:	8b 43 04             	mov    0x4(%ebx),%eax
80101477:	83 c4 10             	add    $0x10,%esp
8010147a:	85 c0                	test   %eax,%eax
8010147c:	7e 1a                	jle    80101498 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010147e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101481:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101484:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101487:	68 80 ff 10 80       	push   $0x8010ff80
8010148c:	e8 4f 36 00 00       	call   80104ae0 <release>
  return f;
}
80101491:	89 d8                	mov    %ebx,%eax
80101493:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101496:	c9                   	leave
80101497:	c3                   	ret
    panic("filedup");
80101498:	83 ec 0c             	sub    $0xc,%esp
8010149b:	68 83 77 10 80       	push   $0x80107783
801014a0:	e8 db ee ff ff       	call   80100380 <panic>
801014a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801014ac:	00 
801014ad:	8d 76 00             	lea    0x0(%esi),%esi

801014b0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801014b0:	55                   	push   %ebp
801014b1:	89 e5                	mov    %esp,%ebp
801014b3:	57                   	push   %edi
801014b4:	56                   	push   %esi
801014b5:	53                   	push   %ebx
801014b6:	83 ec 28             	sub    $0x28,%esp
801014b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801014bc:	68 80 ff 10 80       	push   $0x8010ff80
801014c1:	e8 7a 36 00 00       	call   80104b40 <acquire>
  if(f->ref < 1)
801014c6:	8b 53 04             	mov    0x4(%ebx),%edx
801014c9:	83 c4 10             	add    $0x10,%esp
801014cc:	85 d2                	test   %edx,%edx
801014ce:	0f 8e a5 00 00 00    	jle    80101579 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
801014d4:	83 ea 01             	sub    $0x1,%edx
801014d7:	89 53 04             	mov    %edx,0x4(%ebx)
801014da:	75 44                	jne    80101520 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
801014dc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801014e0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801014e3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801014e5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801014eb:	8b 73 0c             	mov    0xc(%ebx),%esi
801014ee:	88 45 e7             	mov    %al,-0x19(%ebp)
801014f1:	8b 43 10             	mov    0x10(%ebx),%eax
801014f4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801014f7:	68 80 ff 10 80       	push   $0x8010ff80
801014fc:	e8 df 35 00 00       	call   80104ae0 <release>

  if(ff.type == FD_PIPE)
80101501:	83 c4 10             	add    $0x10,%esp
80101504:	83 ff 01             	cmp    $0x1,%edi
80101507:	74 57                	je     80101560 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101509:	83 ff 02             	cmp    $0x2,%edi
8010150c:	74 2a                	je     80101538 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010150e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101511:	5b                   	pop    %ebx
80101512:	5e                   	pop    %esi
80101513:	5f                   	pop    %edi
80101514:	5d                   	pop    %ebp
80101515:	c3                   	ret
80101516:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010151d:	00 
8010151e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80101520:	c7 45 08 80 ff 10 80 	movl   $0x8010ff80,0x8(%ebp)
}
80101527:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010152a:	5b                   	pop    %ebx
8010152b:	5e                   	pop    %esi
8010152c:	5f                   	pop    %edi
8010152d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010152e:	e9 ad 35 00 00       	jmp    80104ae0 <release>
80101533:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101538:	e8 a3 1d 00 00       	call   801032e0 <begin_op>
    iput(ff.ip);
8010153d:	83 ec 0c             	sub    $0xc,%esp
80101540:	ff 75 e0             	push   -0x20(%ebp)
80101543:	e8 28 09 00 00       	call   80101e70 <iput>
    end_op();
80101548:	83 c4 10             	add    $0x10,%esp
}
8010154b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010154e:	5b                   	pop    %ebx
8010154f:	5e                   	pop    %esi
80101550:	5f                   	pop    %edi
80101551:	5d                   	pop    %ebp
    end_op();
80101552:	e9 f9 1d 00 00       	jmp    80103350 <end_op>
80101557:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010155e:	00 
8010155f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101560:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101564:	83 ec 08             	sub    $0x8,%esp
80101567:	53                   	push   %ebx
80101568:	56                   	push   %esi
80101569:	e8 32 25 00 00       	call   80103aa0 <pipeclose>
8010156e:	83 c4 10             	add    $0x10,%esp
}
80101571:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101574:	5b                   	pop    %ebx
80101575:	5e                   	pop    %esi
80101576:	5f                   	pop    %edi
80101577:	5d                   	pop    %ebp
80101578:	c3                   	ret
    panic("fileclose");
80101579:	83 ec 0c             	sub    $0xc,%esp
8010157c:	68 8b 77 10 80       	push   $0x8010778b
80101581:	e8 fa ed ff ff       	call   80100380 <panic>
80101586:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010158d:	00 
8010158e:	66 90                	xchg   %ax,%ax

80101590 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	53                   	push   %ebx
80101594:	83 ec 04             	sub    $0x4,%esp
80101597:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010159a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010159d:	75 31                	jne    801015d0 <filestat+0x40>
    ilock(f->ip);
8010159f:	83 ec 0c             	sub    $0xc,%esp
801015a2:	ff 73 10             	push   0x10(%ebx)
801015a5:	e8 96 07 00 00       	call   80101d40 <ilock>
    stati(f->ip, st);
801015aa:	58                   	pop    %eax
801015ab:	5a                   	pop    %edx
801015ac:	ff 75 0c             	push   0xc(%ebp)
801015af:	ff 73 10             	push   0x10(%ebx)
801015b2:	e8 69 0a 00 00       	call   80102020 <stati>
    iunlock(f->ip);
801015b7:	59                   	pop    %ecx
801015b8:	ff 73 10             	push   0x10(%ebx)
801015bb:	e8 60 08 00 00       	call   80101e20 <iunlock>
    return 0;
  }
  return -1;
}
801015c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801015c3:	83 c4 10             	add    $0x10,%esp
801015c6:	31 c0                	xor    %eax,%eax
}
801015c8:	c9                   	leave
801015c9:	c3                   	ret
801015ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801015d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801015d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801015d8:	c9                   	leave
801015d9:	c3                   	ret
801015da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801015e0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	57                   	push   %edi
801015e4:	56                   	push   %esi
801015e5:	53                   	push   %ebx
801015e6:	83 ec 0c             	sub    $0xc,%esp
801015e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801015ec:	8b 75 0c             	mov    0xc(%ebp),%esi
801015ef:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801015f2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801015f6:	74 60                	je     80101658 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801015f8:	8b 03                	mov    (%ebx),%eax
801015fa:	83 f8 01             	cmp    $0x1,%eax
801015fd:	74 41                	je     80101640 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801015ff:	83 f8 02             	cmp    $0x2,%eax
80101602:	75 5b                	jne    8010165f <fileread+0x7f>
    ilock(f->ip);
80101604:	83 ec 0c             	sub    $0xc,%esp
80101607:	ff 73 10             	push   0x10(%ebx)
8010160a:	e8 31 07 00 00       	call   80101d40 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010160f:	57                   	push   %edi
80101610:	ff 73 14             	push   0x14(%ebx)
80101613:	56                   	push   %esi
80101614:	ff 73 10             	push   0x10(%ebx)
80101617:	e8 34 0a 00 00       	call   80102050 <readi>
8010161c:	83 c4 20             	add    $0x20,%esp
8010161f:	89 c6                	mov    %eax,%esi
80101621:	85 c0                	test   %eax,%eax
80101623:	7e 03                	jle    80101628 <fileread+0x48>
      f->off += r;
80101625:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101628:	83 ec 0c             	sub    $0xc,%esp
8010162b:	ff 73 10             	push   0x10(%ebx)
8010162e:	e8 ed 07 00 00       	call   80101e20 <iunlock>
    return r;
80101633:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101636:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101639:	89 f0                	mov    %esi,%eax
8010163b:	5b                   	pop    %ebx
8010163c:	5e                   	pop    %esi
8010163d:	5f                   	pop    %edi
8010163e:	5d                   	pop    %ebp
8010163f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101640:	8b 43 0c             	mov    0xc(%ebx),%eax
80101643:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101646:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101649:	5b                   	pop    %ebx
8010164a:	5e                   	pop    %esi
8010164b:	5f                   	pop    %edi
8010164c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010164d:	e9 0e 26 00 00       	jmp    80103c60 <piperead>
80101652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101658:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010165d:	eb d7                	jmp    80101636 <fileread+0x56>
  panic("fileread");
8010165f:	83 ec 0c             	sub    $0xc,%esp
80101662:	68 95 77 10 80       	push   $0x80107795
80101667:	e8 14 ed ff ff       	call   80100380 <panic>
8010166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101670 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	57                   	push   %edi
80101674:	56                   	push   %esi
80101675:	53                   	push   %ebx
80101676:	83 ec 1c             	sub    $0x1c,%esp
80101679:	8b 45 0c             	mov    0xc(%ebp),%eax
8010167c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010167f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101682:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101685:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101689:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010168c:	0f 84 bb 00 00 00    	je     8010174d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101692:	8b 03                	mov    (%ebx),%eax
80101694:	83 f8 01             	cmp    $0x1,%eax
80101697:	0f 84 bf 00 00 00    	je     8010175c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010169d:	83 f8 02             	cmp    $0x2,%eax
801016a0:	0f 85 c8 00 00 00    	jne    8010176e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801016a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801016a9:	31 f6                	xor    %esi,%esi
    while(i < n){
801016ab:	85 c0                	test   %eax,%eax
801016ad:	7f 30                	jg     801016df <filewrite+0x6f>
801016af:	e9 94 00 00 00       	jmp    80101748 <filewrite+0xd8>
801016b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801016b8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801016bb:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
801016be:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801016c1:	ff 73 10             	push   0x10(%ebx)
801016c4:	e8 57 07 00 00       	call   80101e20 <iunlock>
      end_op();
801016c9:	e8 82 1c 00 00       	call   80103350 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801016ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801016d1:	83 c4 10             	add    $0x10,%esp
801016d4:	39 c7                	cmp    %eax,%edi
801016d6:	75 5c                	jne    80101734 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
801016d8:	01 fe                	add    %edi,%esi
    while(i < n){
801016da:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801016dd:	7e 69                	jle    80101748 <filewrite+0xd8>
      int n1 = n - i;
801016df:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
801016e2:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
801016e7:	29 f7                	sub    %esi,%edi
      if(n1 > max)
801016e9:	39 c7                	cmp    %eax,%edi
801016eb:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
801016ee:	e8 ed 1b 00 00       	call   801032e0 <begin_op>
      ilock(f->ip);
801016f3:	83 ec 0c             	sub    $0xc,%esp
801016f6:	ff 73 10             	push   0x10(%ebx)
801016f9:	e8 42 06 00 00       	call   80101d40 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801016fe:	57                   	push   %edi
801016ff:	ff 73 14             	push   0x14(%ebx)
80101702:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101705:	01 f0                	add    %esi,%eax
80101707:	50                   	push   %eax
80101708:	ff 73 10             	push   0x10(%ebx)
8010170b:	e8 40 0a 00 00       	call   80102150 <writei>
80101710:	83 c4 20             	add    $0x20,%esp
80101713:	85 c0                	test   %eax,%eax
80101715:	7f a1                	jg     801016b8 <filewrite+0x48>
80101717:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010171a:	83 ec 0c             	sub    $0xc,%esp
8010171d:	ff 73 10             	push   0x10(%ebx)
80101720:	e8 fb 06 00 00       	call   80101e20 <iunlock>
      end_op();
80101725:	e8 26 1c 00 00       	call   80103350 <end_op>
      if(r < 0)
8010172a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010172d:	83 c4 10             	add    $0x10,%esp
80101730:	85 c0                	test   %eax,%eax
80101732:	75 14                	jne    80101748 <filewrite+0xd8>
        panic("short filewrite");
80101734:	83 ec 0c             	sub    $0xc,%esp
80101737:	68 9e 77 10 80       	push   $0x8010779e
8010173c:	e8 3f ec ff ff       	call   80100380 <panic>
80101741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101748:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010174b:	74 05                	je     80101752 <filewrite+0xe2>
8010174d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101752:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101755:	89 f0                	mov    %esi,%eax
80101757:	5b                   	pop    %ebx
80101758:	5e                   	pop    %esi
80101759:	5f                   	pop    %edi
8010175a:	5d                   	pop    %ebp
8010175b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
8010175c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010175f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101762:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101765:	5b                   	pop    %ebx
80101766:	5e                   	pop    %esi
80101767:	5f                   	pop    %edi
80101768:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101769:	e9 d2 23 00 00       	jmp    80103b40 <pipewrite>
  panic("filewrite");
8010176e:	83 ec 0c             	sub    $0xc,%esp
80101771:	68 a4 77 10 80       	push   $0x801077a4
80101776:	e8 05 ec ff ff       	call   80100380 <panic>
8010177b:	66 90                	xchg   %ax,%ax
8010177d:	66 90                	xchg   %ax,%ax
8010177f:	90                   	nop

80101780 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	57                   	push   %edi
80101784:	56                   	push   %esi
80101785:	53                   	push   %ebx
80101786:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101789:	8b 0d d4 25 11 80    	mov    0x801125d4,%ecx
{
8010178f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101792:	85 c9                	test   %ecx,%ecx
80101794:	0f 84 8c 00 00 00    	je     80101826 <balloc+0xa6>
8010179a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010179c:	89 f8                	mov    %edi,%eax
8010179e:	83 ec 08             	sub    $0x8,%esp
801017a1:	89 fe                	mov    %edi,%esi
801017a3:	c1 f8 0c             	sar    $0xc,%eax
801017a6:	03 05 ec 25 11 80    	add    0x801125ec,%eax
801017ac:	50                   	push   %eax
801017ad:	ff 75 dc             	push   -0x24(%ebp)
801017b0:	e8 1b e9 ff ff       	call   801000d0 <bread>
801017b5:	83 c4 10             	add    $0x10,%esp
801017b8:	89 7d d8             	mov    %edi,-0x28(%ebp)
801017bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801017be:	a1 d4 25 11 80       	mov    0x801125d4,%eax
801017c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801017c6:	31 c0                	xor    %eax,%eax
801017c8:	eb 32                	jmp    801017fc <balloc+0x7c>
801017ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801017d0:	89 c1                	mov    %eax,%ecx
801017d2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801017d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
801017da:	83 e1 07             	and    $0x7,%ecx
801017dd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801017df:	89 c1                	mov    %eax,%ecx
801017e1:	c1 f9 03             	sar    $0x3,%ecx
801017e4:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
801017e9:	89 fa                	mov    %edi,%edx
801017eb:	85 df                	test   %ebx,%edi
801017ed:	74 49                	je     80101838 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801017ef:	83 c0 01             	add    $0x1,%eax
801017f2:	83 c6 01             	add    $0x1,%esi
801017f5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801017fa:	74 07                	je     80101803 <balloc+0x83>
801017fc:	8b 55 e0             	mov    -0x20(%ebp),%edx
801017ff:	39 d6                	cmp    %edx,%esi
80101801:	72 cd                	jb     801017d0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101803:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101806:	83 ec 0c             	sub    $0xc,%esp
80101809:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010180c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101812:	e8 d9 e9 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101817:	83 c4 10             	add    $0x10,%esp
8010181a:	3b 3d d4 25 11 80    	cmp    0x801125d4,%edi
80101820:	0f 82 76 ff ff ff    	jb     8010179c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101826:	83 ec 0c             	sub    $0xc,%esp
80101829:	68 ae 77 10 80       	push   $0x801077ae
8010182e:	e8 4d eb ff ff       	call   80100380 <panic>
80101833:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101838:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
8010183b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
8010183e:	09 da                	or     %ebx,%edx
80101840:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101844:	57                   	push   %edi
80101845:	e8 76 1c 00 00       	call   801034c0 <log_write>
        brelse(bp);
8010184a:	89 3c 24             	mov    %edi,(%esp)
8010184d:	e8 9e e9 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101852:	58                   	pop    %eax
80101853:	5a                   	pop    %edx
80101854:	56                   	push   %esi
80101855:	ff 75 dc             	push   -0x24(%ebp)
80101858:	e8 73 e8 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
8010185d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101860:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101862:	8d 40 5c             	lea    0x5c(%eax),%eax
80101865:	68 00 02 00 00       	push   $0x200
8010186a:	6a 00                	push   $0x0
8010186c:	50                   	push   %eax
8010186d:	e8 ce 33 00 00       	call   80104c40 <memset>
  log_write(bp);
80101872:	89 1c 24             	mov    %ebx,(%esp)
80101875:	e8 46 1c 00 00       	call   801034c0 <log_write>
  brelse(bp);
8010187a:	89 1c 24             	mov    %ebx,(%esp)
8010187d:	e8 6e e9 ff ff       	call   801001f0 <brelse>
}
80101882:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101885:	89 f0                	mov    %esi,%eax
80101887:	5b                   	pop    %ebx
80101888:	5e                   	pop    %esi
80101889:	5f                   	pop    %edi
8010188a:	5d                   	pop    %ebp
8010188b:	c3                   	ret
8010188c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101890 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101890:	55                   	push   %ebp
80101891:	89 e5                	mov    %esp,%ebp
80101893:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101894:	31 ff                	xor    %edi,%edi
{
80101896:	56                   	push   %esi
80101897:	89 c6                	mov    %eax,%esi
80101899:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010189a:	bb b4 09 11 80       	mov    $0x801109b4,%ebx
{
8010189f:	83 ec 28             	sub    $0x28,%esp
801018a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801018a5:	68 80 09 11 80       	push   $0x80110980
801018aa:	e8 91 32 00 00       	call   80104b40 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018af:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801018b2:	83 c4 10             	add    $0x10,%esp
801018b5:	eb 1b                	jmp    801018d2 <iget+0x42>
801018b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018be:	00 
801018bf:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018c0:	39 33                	cmp    %esi,(%ebx)
801018c2:	74 6c                	je     80101930 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018c4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801018ca:	81 fb d4 25 11 80    	cmp    $0x801125d4,%ebx
801018d0:	74 26                	je     801018f8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018d2:	8b 43 08             	mov    0x8(%ebx),%eax
801018d5:	85 c0                	test   %eax,%eax
801018d7:	7f e7                	jg     801018c0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801018d9:	85 ff                	test   %edi,%edi
801018db:	75 e7                	jne    801018c4 <iget+0x34>
801018dd:	85 c0                	test   %eax,%eax
801018df:	75 76                	jne    80101957 <iget+0xc7>
      empty = ip;
801018e1:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018e3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801018e9:	81 fb d4 25 11 80    	cmp    $0x801125d4,%ebx
801018ef:	75 e1                	jne    801018d2 <iget+0x42>
801018f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801018f8:	85 ff                	test   %edi,%edi
801018fa:	74 79                	je     80101975 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801018fc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801018ff:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101901:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101904:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010190b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80101912:	68 80 09 11 80       	push   $0x80110980
80101917:	e8 c4 31 00 00       	call   80104ae0 <release>

  return ip;
8010191c:	83 c4 10             	add    $0x10,%esp
}
8010191f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101922:	89 f8                	mov    %edi,%eax
80101924:	5b                   	pop    %ebx
80101925:	5e                   	pop    %esi
80101926:	5f                   	pop    %edi
80101927:	5d                   	pop    %ebp
80101928:	c3                   	ret
80101929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101930:	39 53 04             	cmp    %edx,0x4(%ebx)
80101933:	75 8f                	jne    801018c4 <iget+0x34>
      ip->ref++;
80101935:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80101938:	83 ec 0c             	sub    $0xc,%esp
      return ip;
8010193b:	89 df                	mov    %ebx,%edi
      ip->ref++;
8010193d:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101940:	68 80 09 11 80       	push   $0x80110980
80101945:	e8 96 31 00 00       	call   80104ae0 <release>
      return ip;
8010194a:	83 c4 10             	add    $0x10,%esp
}
8010194d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101950:	89 f8                	mov    %edi,%eax
80101952:	5b                   	pop    %ebx
80101953:	5e                   	pop    %esi
80101954:	5f                   	pop    %edi
80101955:	5d                   	pop    %ebp
80101956:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101957:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010195d:	81 fb d4 25 11 80    	cmp    $0x801125d4,%ebx
80101963:	74 10                	je     80101975 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101965:	8b 43 08             	mov    0x8(%ebx),%eax
80101968:	85 c0                	test   %eax,%eax
8010196a:	0f 8f 50 ff ff ff    	jg     801018c0 <iget+0x30>
80101970:	e9 68 ff ff ff       	jmp    801018dd <iget+0x4d>
    panic("iget: no inodes");
80101975:	83 ec 0c             	sub    $0xc,%esp
80101978:	68 c4 77 10 80       	push   $0x801077c4
8010197d:	e8 fe e9 ff ff       	call   80100380 <panic>
80101982:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101989:	00 
8010198a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101990 <bfree>:
{
80101990:	55                   	push   %ebp
80101991:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101993:	89 d0                	mov    %edx,%eax
80101995:	c1 e8 0c             	shr    $0xc,%eax
{
80101998:	89 e5                	mov    %esp,%ebp
8010199a:	56                   	push   %esi
8010199b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
8010199c:	03 05 ec 25 11 80    	add    0x801125ec,%eax
{
801019a2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801019a4:	83 ec 08             	sub    $0x8,%esp
801019a7:	50                   	push   %eax
801019a8:	51                   	push   %ecx
801019a9:	e8 22 e7 ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801019ae:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801019b0:	c1 fb 03             	sar    $0x3,%ebx
801019b3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801019b6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801019b8:	83 e1 07             	and    $0x7,%ecx
801019bb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801019c0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801019c6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801019c8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801019cd:	85 c1                	test   %eax,%ecx
801019cf:	74 23                	je     801019f4 <bfree+0x64>
  bp->data[bi/8] &= ~m;
801019d1:	f7 d0                	not    %eax
  log_write(bp);
801019d3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801019d6:	21 c8                	and    %ecx,%eax
801019d8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801019dc:	56                   	push   %esi
801019dd:	e8 de 1a 00 00       	call   801034c0 <log_write>
  brelse(bp);
801019e2:	89 34 24             	mov    %esi,(%esp)
801019e5:	e8 06 e8 ff ff       	call   801001f0 <brelse>
}
801019ea:	83 c4 10             	add    $0x10,%esp
801019ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019f0:	5b                   	pop    %ebx
801019f1:	5e                   	pop    %esi
801019f2:	5d                   	pop    %ebp
801019f3:	c3                   	ret
    panic("freeing free block");
801019f4:	83 ec 0c             	sub    $0xc,%esp
801019f7:	68 d4 77 10 80       	push   $0x801077d4
801019fc:	e8 7f e9 ff ff       	call   80100380 <panic>
80101a01:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a08:	00 
80101a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a10 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	57                   	push   %edi
80101a14:	56                   	push   %esi
80101a15:	89 c6                	mov    %eax,%esi
80101a17:	53                   	push   %ebx
80101a18:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101a1b:	83 fa 0b             	cmp    $0xb,%edx
80101a1e:	0f 86 8c 00 00 00    	jbe    80101ab0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101a24:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101a27:	83 fb 7f             	cmp    $0x7f,%ebx
80101a2a:	0f 87 a2 00 00 00    	ja     80101ad2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101a30:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101a36:	85 c0                	test   %eax,%eax
80101a38:	74 5e                	je     80101a98 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101a3a:	83 ec 08             	sub    $0x8,%esp
80101a3d:	50                   	push   %eax
80101a3e:	ff 36                	push   (%esi)
80101a40:	e8 8b e6 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101a45:	83 c4 10             	add    $0x10,%esp
80101a48:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
80101a4c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
80101a4e:	8b 3b                	mov    (%ebx),%edi
80101a50:	85 ff                	test   %edi,%edi
80101a52:	74 1c                	je     80101a70 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101a54:	83 ec 0c             	sub    $0xc,%esp
80101a57:	52                   	push   %edx
80101a58:	e8 93 e7 ff ff       	call   801001f0 <brelse>
80101a5d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101a60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a63:	89 f8                	mov    %edi,%eax
80101a65:	5b                   	pop    %ebx
80101a66:	5e                   	pop    %esi
80101a67:	5f                   	pop    %edi
80101a68:	5d                   	pop    %ebp
80101a69:	c3                   	ret
80101a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101a70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101a73:	8b 06                	mov    (%esi),%eax
80101a75:	e8 06 fd ff ff       	call   80101780 <balloc>
      log_write(bp);
80101a7a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101a7d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101a80:	89 03                	mov    %eax,(%ebx)
80101a82:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101a84:	52                   	push   %edx
80101a85:	e8 36 1a 00 00       	call   801034c0 <log_write>
80101a8a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101a8d:	83 c4 10             	add    $0x10,%esp
80101a90:	eb c2                	jmp    80101a54 <bmap+0x44>
80101a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101a98:	8b 06                	mov    (%esi),%eax
80101a9a:	e8 e1 fc ff ff       	call   80101780 <balloc>
80101a9f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101aa5:	eb 93                	jmp    80101a3a <bmap+0x2a>
80101aa7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101aae:	00 
80101aaf:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101ab0:	8d 5a 14             	lea    0x14(%edx),%ebx
80101ab3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101ab7:	85 ff                	test   %edi,%edi
80101ab9:	75 a5                	jne    80101a60 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101abb:	8b 00                	mov    (%eax),%eax
80101abd:	e8 be fc ff ff       	call   80101780 <balloc>
80101ac2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101ac6:	89 c7                	mov    %eax,%edi
}
80101ac8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101acb:	5b                   	pop    %ebx
80101acc:	89 f8                	mov    %edi,%eax
80101ace:	5e                   	pop    %esi
80101acf:	5f                   	pop    %edi
80101ad0:	5d                   	pop    %ebp
80101ad1:	c3                   	ret
  panic("bmap: out of range");
80101ad2:	83 ec 0c             	sub    $0xc,%esp
80101ad5:	68 e7 77 10 80       	push   $0x801077e7
80101ada:	e8 a1 e8 ff ff       	call   80100380 <panic>
80101adf:	90                   	nop

80101ae0 <readsb>:
{
80101ae0:	55                   	push   %ebp
80101ae1:	89 e5                	mov    %esp,%ebp
80101ae3:	56                   	push   %esi
80101ae4:	53                   	push   %ebx
80101ae5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101ae8:	83 ec 08             	sub    $0x8,%esp
80101aeb:	6a 01                	push   $0x1
80101aed:	ff 75 08             	push   0x8(%ebp)
80101af0:	e8 db e5 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101af5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101af8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101afa:	8d 40 5c             	lea    0x5c(%eax),%eax
80101afd:	6a 1c                	push   $0x1c
80101aff:	50                   	push   %eax
80101b00:	56                   	push   %esi
80101b01:	e8 ca 31 00 00       	call   80104cd0 <memmove>
  brelse(bp);
80101b06:	83 c4 10             	add    $0x10,%esp
80101b09:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101b0c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b0f:	5b                   	pop    %ebx
80101b10:	5e                   	pop    %esi
80101b11:	5d                   	pop    %ebp
  brelse(bp);
80101b12:	e9 d9 e6 ff ff       	jmp    801001f0 <brelse>
80101b17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b1e:	00 
80101b1f:	90                   	nop

80101b20 <iinit>:
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	53                   	push   %ebx
80101b24:	bb c0 09 11 80       	mov    $0x801109c0,%ebx
80101b29:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101b2c:	68 fa 77 10 80       	push   $0x801077fa
80101b31:	68 80 09 11 80       	push   $0x80110980
80101b36:	e8 15 2e 00 00       	call   80104950 <initlock>
  for(i = 0; i < NINODE; i++) {
80101b3b:	83 c4 10             	add    $0x10,%esp
80101b3e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101b40:	83 ec 08             	sub    $0x8,%esp
80101b43:	68 01 78 10 80       	push   $0x80107801
80101b48:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101b49:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
80101b4f:	e8 cc 2c 00 00       	call   80104820 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101b54:	83 c4 10             	add    $0x10,%esp
80101b57:	81 fb e0 25 11 80    	cmp    $0x801125e0,%ebx
80101b5d:	75 e1                	jne    80101b40 <iinit+0x20>
  bp = bread(dev, 1);
80101b5f:	83 ec 08             	sub    $0x8,%esp
80101b62:	6a 01                	push   $0x1
80101b64:	ff 75 08             	push   0x8(%ebp)
80101b67:	e8 64 e5 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101b6c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101b6f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101b71:	8d 40 5c             	lea    0x5c(%eax),%eax
80101b74:	6a 1c                	push   $0x1c
80101b76:	50                   	push   %eax
80101b77:	68 d4 25 11 80       	push   $0x801125d4
80101b7c:	e8 4f 31 00 00       	call   80104cd0 <memmove>
  brelse(bp);
80101b81:	89 1c 24             	mov    %ebx,(%esp)
80101b84:	e8 67 e6 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101b89:	ff 35 ec 25 11 80    	push   0x801125ec
80101b8f:	ff 35 e8 25 11 80    	push   0x801125e8
80101b95:	ff 35 e4 25 11 80    	push   0x801125e4
80101b9b:	ff 35 e0 25 11 80    	push   0x801125e0
80101ba1:	ff 35 dc 25 11 80    	push   0x801125dc
80101ba7:	ff 35 d8 25 11 80    	push   0x801125d8
80101bad:	ff 35 d4 25 11 80    	push   0x801125d4
80101bb3:	68 6c 7c 10 80       	push   $0x80107c6c
80101bb8:	e8 a3 ea ff ff       	call   80100660 <cprintf>
}
80101bbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bc0:	83 c4 30             	add    $0x30,%esp
80101bc3:	c9                   	leave
80101bc4:	c3                   	ret
80101bc5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101bcc:	00 
80101bcd:	8d 76 00             	lea    0x0(%esi),%esi

80101bd0 <ialloc>:
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	57                   	push   %edi
80101bd4:	56                   	push   %esi
80101bd5:	53                   	push   %ebx
80101bd6:	83 ec 1c             	sub    $0x1c,%esp
80101bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101bdc:	83 3d dc 25 11 80 01 	cmpl   $0x1,0x801125dc
{
80101be3:	8b 75 08             	mov    0x8(%ebp),%esi
80101be6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101be9:	0f 86 91 00 00 00    	jbe    80101c80 <ialloc+0xb0>
80101bef:	bf 01 00 00 00       	mov    $0x1,%edi
80101bf4:	eb 21                	jmp    80101c17 <ialloc+0x47>
80101bf6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101bfd:	00 
80101bfe:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101c00:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101c03:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101c06:	53                   	push   %ebx
80101c07:	e8 e4 e5 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101c0c:	83 c4 10             	add    $0x10,%esp
80101c0f:	3b 3d dc 25 11 80    	cmp    0x801125dc,%edi
80101c15:	73 69                	jae    80101c80 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101c17:	89 f8                	mov    %edi,%eax
80101c19:	83 ec 08             	sub    $0x8,%esp
80101c1c:	c1 e8 03             	shr    $0x3,%eax
80101c1f:	03 05 e8 25 11 80    	add    0x801125e8,%eax
80101c25:	50                   	push   %eax
80101c26:	56                   	push   %esi
80101c27:	e8 a4 e4 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
80101c2c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101c2f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101c31:	89 f8                	mov    %edi,%eax
80101c33:	83 e0 07             	and    $0x7,%eax
80101c36:	c1 e0 06             	shl    $0x6,%eax
80101c39:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101c3d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101c41:	75 bd                	jne    80101c00 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101c43:	83 ec 04             	sub    $0x4,%esp
80101c46:	6a 40                	push   $0x40
80101c48:	6a 00                	push   $0x0
80101c4a:	51                   	push   %ecx
80101c4b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101c4e:	e8 ed 2f 00 00       	call   80104c40 <memset>
      dip->type = type;
80101c53:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101c57:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101c5a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101c5d:	89 1c 24             	mov    %ebx,(%esp)
80101c60:	e8 5b 18 00 00       	call   801034c0 <log_write>
      brelse(bp);
80101c65:	89 1c 24             	mov    %ebx,(%esp)
80101c68:	e8 83 e5 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101c6d:	83 c4 10             	add    $0x10,%esp
}
80101c70:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101c73:	89 fa                	mov    %edi,%edx
}
80101c75:	5b                   	pop    %ebx
      return iget(dev, inum);
80101c76:	89 f0                	mov    %esi,%eax
}
80101c78:	5e                   	pop    %esi
80101c79:	5f                   	pop    %edi
80101c7a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101c7b:	e9 10 fc ff ff       	jmp    80101890 <iget>
  panic("ialloc: no inodes");
80101c80:	83 ec 0c             	sub    $0xc,%esp
80101c83:	68 07 78 10 80       	push   $0x80107807
80101c88:	e8 f3 e6 ff ff       	call   80100380 <panic>
80101c8d:	8d 76 00             	lea    0x0(%esi),%esi

80101c90 <iupdate>:
{
80101c90:	55                   	push   %ebp
80101c91:	89 e5                	mov    %esp,%ebp
80101c93:	56                   	push   %esi
80101c94:	53                   	push   %ebx
80101c95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c98:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101c9b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c9e:	83 ec 08             	sub    $0x8,%esp
80101ca1:	c1 e8 03             	shr    $0x3,%eax
80101ca4:	03 05 e8 25 11 80    	add    0x801125e8,%eax
80101caa:	50                   	push   %eax
80101cab:	ff 73 a4             	push   -0x5c(%ebx)
80101cae:	e8 1d e4 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101cb3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101cb7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101cba:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101cbc:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101cbf:	83 e0 07             	and    $0x7,%eax
80101cc2:	c1 e0 06             	shl    $0x6,%eax
80101cc5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101cc9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101ccc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101cd0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101cd3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101cd7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101cdb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101cdf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101ce3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101ce7:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101cea:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101ced:	6a 34                	push   $0x34
80101cef:	53                   	push   %ebx
80101cf0:	50                   	push   %eax
80101cf1:	e8 da 2f 00 00       	call   80104cd0 <memmove>
  log_write(bp);
80101cf6:	89 34 24             	mov    %esi,(%esp)
80101cf9:	e8 c2 17 00 00       	call   801034c0 <log_write>
  brelse(bp);
80101cfe:	83 c4 10             	add    $0x10,%esp
80101d01:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101d04:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d07:	5b                   	pop    %ebx
80101d08:	5e                   	pop    %esi
80101d09:	5d                   	pop    %ebp
  brelse(bp);
80101d0a:	e9 e1 e4 ff ff       	jmp    801001f0 <brelse>
80101d0f:	90                   	nop

80101d10 <idup>:
{
80101d10:	55                   	push   %ebp
80101d11:	89 e5                	mov    %esp,%ebp
80101d13:	53                   	push   %ebx
80101d14:	83 ec 10             	sub    $0x10,%esp
80101d17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101d1a:	68 80 09 11 80       	push   $0x80110980
80101d1f:	e8 1c 2e 00 00       	call   80104b40 <acquire>
  ip->ref++;
80101d24:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101d28:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
80101d2f:	e8 ac 2d 00 00       	call   80104ae0 <release>
}
80101d34:	89 d8                	mov    %ebx,%eax
80101d36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d39:	c9                   	leave
80101d3a:	c3                   	ret
80101d3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101d40 <ilock>:
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	56                   	push   %esi
80101d44:	53                   	push   %ebx
80101d45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101d48:	85 db                	test   %ebx,%ebx
80101d4a:	0f 84 b7 00 00 00    	je     80101e07 <ilock+0xc7>
80101d50:	8b 53 08             	mov    0x8(%ebx),%edx
80101d53:	85 d2                	test   %edx,%edx
80101d55:	0f 8e ac 00 00 00    	jle    80101e07 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101d5b:	83 ec 0c             	sub    $0xc,%esp
80101d5e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101d61:	50                   	push   %eax
80101d62:	e8 f9 2a 00 00       	call   80104860 <acquiresleep>
  if(ip->valid == 0){
80101d67:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101d6a:	83 c4 10             	add    $0x10,%esp
80101d6d:	85 c0                	test   %eax,%eax
80101d6f:	74 0f                	je     80101d80 <ilock+0x40>
}
80101d71:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d74:	5b                   	pop    %ebx
80101d75:	5e                   	pop    %esi
80101d76:	5d                   	pop    %ebp
80101d77:	c3                   	ret
80101d78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d7f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101d80:	8b 43 04             	mov    0x4(%ebx),%eax
80101d83:	83 ec 08             	sub    $0x8,%esp
80101d86:	c1 e8 03             	shr    $0x3,%eax
80101d89:	03 05 e8 25 11 80    	add    0x801125e8,%eax
80101d8f:	50                   	push   %eax
80101d90:	ff 33                	push   (%ebx)
80101d92:	e8 39 e3 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101d97:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101d9a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101d9c:	8b 43 04             	mov    0x4(%ebx),%eax
80101d9f:	83 e0 07             	and    $0x7,%eax
80101da2:	c1 e0 06             	shl    $0x6,%eax
80101da5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101da9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101dac:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101daf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101db3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101db7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101dbb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101dbf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101dc3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101dc7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101dcb:	8b 50 fc             	mov    -0x4(%eax),%edx
80101dce:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101dd1:	6a 34                	push   $0x34
80101dd3:	50                   	push   %eax
80101dd4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101dd7:	50                   	push   %eax
80101dd8:	e8 f3 2e 00 00       	call   80104cd0 <memmove>
    brelse(bp);
80101ddd:	89 34 24             	mov    %esi,(%esp)
80101de0:	e8 0b e4 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101de5:	83 c4 10             	add    $0x10,%esp
80101de8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101ded:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101df4:	0f 85 77 ff ff ff    	jne    80101d71 <ilock+0x31>
      panic("ilock: no type");
80101dfa:	83 ec 0c             	sub    $0xc,%esp
80101dfd:	68 1f 78 10 80       	push   $0x8010781f
80101e02:	e8 79 e5 ff ff       	call   80100380 <panic>
    panic("ilock");
80101e07:	83 ec 0c             	sub    $0xc,%esp
80101e0a:	68 19 78 10 80       	push   $0x80107819
80101e0f:	e8 6c e5 ff ff       	call   80100380 <panic>
80101e14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e1b:	00 
80101e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e20 <iunlock>:
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	56                   	push   %esi
80101e24:	53                   	push   %ebx
80101e25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e28:	85 db                	test   %ebx,%ebx
80101e2a:	74 28                	je     80101e54 <iunlock+0x34>
80101e2c:	83 ec 0c             	sub    $0xc,%esp
80101e2f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101e32:	56                   	push   %esi
80101e33:	e8 c8 2a 00 00       	call   80104900 <holdingsleep>
80101e38:	83 c4 10             	add    $0x10,%esp
80101e3b:	85 c0                	test   %eax,%eax
80101e3d:	74 15                	je     80101e54 <iunlock+0x34>
80101e3f:	8b 43 08             	mov    0x8(%ebx),%eax
80101e42:	85 c0                	test   %eax,%eax
80101e44:	7e 0e                	jle    80101e54 <iunlock+0x34>
  releasesleep(&ip->lock);
80101e46:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101e49:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101e4c:	5b                   	pop    %ebx
80101e4d:	5e                   	pop    %esi
80101e4e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101e4f:	e9 6c 2a 00 00       	jmp    801048c0 <releasesleep>
    panic("iunlock");
80101e54:	83 ec 0c             	sub    $0xc,%esp
80101e57:	68 2e 78 10 80       	push   $0x8010782e
80101e5c:	e8 1f e5 ff ff       	call   80100380 <panic>
80101e61:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e68:	00 
80101e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e70 <iput>:
{
80101e70:	55                   	push   %ebp
80101e71:	89 e5                	mov    %esp,%ebp
80101e73:	57                   	push   %edi
80101e74:	56                   	push   %esi
80101e75:	53                   	push   %ebx
80101e76:	83 ec 28             	sub    $0x28,%esp
80101e79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101e7c:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101e7f:	57                   	push   %edi
80101e80:	e8 db 29 00 00       	call   80104860 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101e85:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101e88:	83 c4 10             	add    $0x10,%esp
80101e8b:	85 d2                	test   %edx,%edx
80101e8d:	74 07                	je     80101e96 <iput+0x26>
80101e8f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101e94:	74 32                	je     80101ec8 <iput+0x58>
  releasesleep(&ip->lock);
80101e96:	83 ec 0c             	sub    $0xc,%esp
80101e99:	57                   	push   %edi
80101e9a:	e8 21 2a 00 00       	call   801048c0 <releasesleep>
  acquire(&icache.lock);
80101e9f:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
80101ea6:	e8 95 2c 00 00       	call   80104b40 <acquire>
  ip->ref--;
80101eab:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101eaf:	83 c4 10             	add    $0x10,%esp
80101eb2:	c7 45 08 80 09 11 80 	movl   $0x80110980,0x8(%ebp)
}
80101eb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ebc:	5b                   	pop    %ebx
80101ebd:	5e                   	pop    %esi
80101ebe:	5f                   	pop    %edi
80101ebf:	5d                   	pop    %ebp
  release(&icache.lock);
80101ec0:	e9 1b 2c 00 00       	jmp    80104ae0 <release>
80101ec5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101ec8:	83 ec 0c             	sub    $0xc,%esp
80101ecb:	68 80 09 11 80       	push   $0x80110980
80101ed0:	e8 6b 2c 00 00       	call   80104b40 <acquire>
    int r = ip->ref;
80101ed5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101ed8:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
80101edf:	e8 fc 2b 00 00       	call   80104ae0 <release>
    if(r == 1){
80101ee4:	83 c4 10             	add    $0x10,%esp
80101ee7:	83 fe 01             	cmp    $0x1,%esi
80101eea:	75 aa                	jne    80101e96 <iput+0x26>
80101eec:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101ef2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101ef5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101ef8:	89 df                	mov    %ebx,%edi
80101efa:	89 cb                	mov    %ecx,%ebx
80101efc:	eb 09                	jmp    80101f07 <iput+0x97>
80101efe:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101f00:	83 c6 04             	add    $0x4,%esi
80101f03:	39 de                	cmp    %ebx,%esi
80101f05:	74 19                	je     80101f20 <iput+0xb0>
    if(ip->addrs[i]){
80101f07:	8b 16                	mov    (%esi),%edx
80101f09:	85 d2                	test   %edx,%edx
80101f0b:	74 f3                	je     80101f00 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101f0d:	8b 07                	mov    (%edi),%eax
80101f0f:	e8 7c fa ff ff       	call   80101990 <bfree>
      ip->addrs[i] = 0;
80101f14:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101f1a:	eb e4                	jmp    80101f00 <iput+0x90>
80101f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101f20:	89 fb                	mov    %edi,%ebx
80101f22:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101f25:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101f2b:	85 c0                	test   %eax,%eax
80101f2d:	75 2d                	jne    80101f5c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101f2f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101f32:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101f39:	53                   	push   %ebx
80101f3a:	e8 51 fd ff ff       	call   80101c90 <iupdate>
      ip->type = 0;
80101f3f:	31 c0                	xor    %eax,%eax
80101f41:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101f45:	89 1c 24             	mov    %ebx,(%esp)
80101f48:	e8 43 fd ff ff       	call   80101c90 <iupdate>
      ip->valid = 0;
80101f4d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101f54:	83 c4 10             	add    $0x10,%esp
80101f57:	e9 3a ff ff ff       	jmp    80101e96 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101f5c:	83 ec 08             	sub    $0x8,%esp
80101f5f:	50                   	push   %eax
80101f60:	ff 33                	push   (%ebx)
80101f62:	e8 69 e1 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101f67:	83 c4 10             	add    $0x10,%esp
80101f6a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101f6d:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101f73:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101f76:	8d 70 5c             	lea    0x5c(%eax),%esi
80101f79:	89 cf                	mov    %ecx,%edi
80101f7b:	eb 0a                	jmp    80101f87 <iput+0x117>
80101f7d:	8d 76 00             	lea    0x0(%esi),%esi
80101f80:	83 c6 04             	add    $0x4,%esi
80101f83:	39 fe                	cmp    %edi,%esi
80101f85:	74 0f                	je     80101f96 <iput+0x126>
      if(a[j])
80101f87:	8b 16                	mov    (%esi),%edx
80101f89:	85 d2                	test   %edx,%edx
80101f8b:	74 f3                	je     80101f80 <iput+0x110>
        bfree(ip->dev, a[j]);
80101f8d:	8b 03                	mov    (%ebx),%eax
80101f8f:	e8 fc f9 ff ff       	call   80101990 <bfree>
80101f94:	eb ea                	jmp    80101f80 <iput+0x110>
    brelse(bp);
80101f96:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101f99:	83 ec 0c             	sub    $0xc,%esp
80101f9c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101f9f:	50                   	push   %eax
80101fa0:	e8 4b e2 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101fa5:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101fab:	8b 03                	mov    (%ebx),%eax
80101fad:	e8 de f9 ff ff       	call   80101990 <bfree>
    ip->addrs[NDIRECT] = 0;
80101fb2:	83 c4 10             	add    $0x10,%esp
80101fb5:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101fbc:	00 00 00 
80101fbf:	e9 6b ff ff ff       	jmp    80101f2f <iput+0xbf>
80101fc4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101fcb:	00 
80101fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101fd0 <iunlockput>:
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	56                   	push   %esi
80101fd4:	53                   	push   %ebx
80101fd5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fd8:	85 db                	test   %ebx,%ebx
80101fda:	74 34                	je     80102010 <iunlockput+0x40>
80101fdc:	83 ec 0c             	sub    $0xc,%esp
80101fdf:	8d 73 0c             	lea    0xc(%ebx),%esi
80101fe2:	56                   	push   %esi
80101fe3:	e8 18 29 00 00       	call   80104900 <holdingsleep>
80101fe8:	83 c4 10             	add    $0x10,%esp
80101feb:	85 c0                	test   %eax,%eax
80101fed:	74 21                	je     80102010 <iunlockput+0x40>
80101fef:	8b 43 08             	mov    0x8(%ebx),%eax
80101ff2:	85 c0                	test   %eax,%eax
80101ff4:	7e 1a                	jle    80102010 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101ff6:	83 ec 0c             	sub    $0xc,%esp
80101ff9:	56                   	push   %esi
80101ffa:	e8 c1 28 00 00       	call   801048c0 <releasesleep>
  iput(ip);
80101fff:	83 c4 10             	add    $0x10,%esp
80102002:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80102005:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102008:	5b                   	pop    %ebx
80102009:	5e                   	pop    %esi
8010200a:	5d                   	pop    %ebp
  iput(ip);
8010200b:	e9 60 fe ff ff       	jmp    80101e70 <iput>
    panic("iunlock");
80102010:	83 ec 0c             	sub    $0xc,%esp
80102013:	68 2e 78 10 80       	push   $0x8010782e
80102018:	e8 63 e3 ff ff       	call   80100380 <panic>
8010201d:	8d 76 00             	lea    0x0(%esi),%esi

80102020 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	8b 55 08             	mov    0x8(%ebp),%edx
80102026:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102029:	8b 0a                	mov    (%edx),%ecx
8010202b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010202e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102031:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102034:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102038:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010203b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010203f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102043:	8b 52 58             	mov    0x58(%edx),%edx
80102046:	89 50 10             	mov    %edx,0x10(%eax)
}
80102049:	5d                   	pop    %ebp
8010204a:	c3                   	ret
8010204b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102050 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102050:	55                   	push   %ebp
80102051:	89 e5                	mov    %esp,%ebp
80102053:	57                   	push   %edi
80102054:	56                   	push   %esi
80102055:	53                   	push   %ebx
80102056:	83 ec 1c             	sub    $0x1c,%esp
80102059:	8b 75 08             	mov    0x8(%ebp),%esi
8010205c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010205f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102062:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80102067:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010206a:	89 75 d8             	mov    %esi,-0x28(%ebp)
8010206d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80102070:	0f 84 aa 00 00 00    	je     80102120 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80102076:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102079:	8b 56 58             	mov    0x58(%esi),%edx
8010207c:	39 fa                	cmp    %edi,%edx
8010207e:	0f 82 bd 00 00 00    	jb     80102141 <readi+0xf1>
80102084:	89 f9                	mov    %edi,%ecx
80102086:	31 db                	xor    %ebx,%ebx
80102088:	01 c1                	add    %eax,%ecx
8010208a:	0f 92 c3             	setb   %bl
8010208d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80102090:	0f 82 ab 00 00 00    	jb     80102141 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102096:	89 d3                	mov    %edx,%ebx
80102098:	29 fb                	sub    %edi,%ebx
8010209a:	39 ca                	cmp    %ecx,%edx
8010209c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010209f:	85 c0                	test   %eax,%eax
801020a1:	74 73                	je     80102116 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801020a3:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801020a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801020a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020b0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801020b3:	89 fa                	mov    %edi,%edx
801020b5:	c1 ea 09             	shr    $0x9,%edx
801020b8:	89 d8                	mov    %ebx,%eax
801020ba:	e8 51 f9 ff ff       	call   80101a10 <bmap>
801020bf:	83 ec 08             	sub    $0x8,%esp
801020c2:	50                   	push   %eax
801020c3:	ff 33                	push   (%ebx)
801020c5:	e8 06 e0 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801020ca:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801020cd:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020d2:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801020d4:	89 f8                	mov    %edi,%eax
801020d6:	25 ff 01 00 00       	and    $0x1ff,%eax
801020db:	29 f3                	sub    %esi,%ebx
801020dd:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
801020df:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801020e3:	39 d9                	cmp    %ebx,%ecx
801020e5:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801020e8:	83 c4 0c             	add    $0xc,%esp
801020eb:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801020ec:	01 de                	add    %ebx,%esi
801020ee:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
801020f0:	89 55 dc             	mov    %edx,-0x24(%ebp)
801020f3:	50                   	push   %eax
801020f4:	ff 75 e0             	push   -0x20(%ebp)
801020f7:	e8 d4 2b 00 00       	call   80104cd0 <memmove>
    brelse(bp);
801020fc:	8b 55 dc             	mov    -0x24(%ebp),%edx
801020ff:	89 14 24             	mov    %edx,(%esp)
80102102:	e8 e9 e0 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102107:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010210a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010210d:	83 c4 10             	add    $0x10,%esp
80102110:	39 de                	cmp    %ebx,%esi
80102112:	72 9c                	jb     801020b0 <readi+0x60>
80102114:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80102116:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102119:	5b                   	pop    %ebx
8010211a:	5e                   	pop    %esi
8010211b:	5f                   	pop    %edi
8010211c:	5d                   	pop    %ebp
8010211d:	c3                   	ret
8010211e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102120:	0f bf 56 52          	movswl 0x52(%esi),%edx
80102124:	66 83 fa 09          	cmp    $0x9,%dx
80102128:	77 17                	ja     80102141 <readi+0xf1>
8010212a:	8b 14 d5 20 09 11 80 	mov    -0x7feef6e0(,%edx,8),%edx
80102131:	85 d2                	test   %edx,%edx
80102133:	74 0c                	je     80102141 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102135:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102138:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010213b:	5b                   	pop    %ebx
8010213c:	5e                   	pop    %esi
8010213d:	5f                   	pop    %edi
8010213e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010213f:	ff e2                	jmp    *%edx
      return -1;
80102141:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102146:	eb ce                	jmp    80102116 <readi+0xc6>
80102148:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010214f:	00 

80102150 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	57                   	push   %edi
80102154:	56                   	push   %esi
80102155:	53                   	push   %ebx
80102156:	83 ec 1c             	sub    $0x1c,%esp
80102159:	8b 45 08             	mov    0x8(%ebp),%eax
8010215c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010215f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102162:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102167:	89 7d dc             	mov    %edi,-0x24(%ebp)
8010216a:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010216d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80102170:	0f 84 ba 00 00 00    	je     80102230 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102176:	39 78 58             	cmp    %edi,0x58(%eax)
80102179:	0f 82 ea 00 00 00    	jb     80102269 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
8010217f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80102182:	89 f2                	mov    %esi,%edx
80102184:	01 fa                	add    %edi,%edx
80102186:	0f 82 dd 00 00 00    	jb     80102269 <writei+0x119>
8010218c:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80102192:	0f 87 d1 00 00 00    	ja     80102269 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102198:	85 f6                	test   %esi,%esi
8010219a:	0f 84 85 00 00 00    	je     80102225 <writei+0xd5>
801021a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801021a7:	89 45 d8             	mov    %eax,-0x28(%ebp)
801021aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801021b0:	8b 75 d8             	mov    -0x28(%ebp),%esi
801021b3:	89 fa                	mov    %edi,%edx
801021b5:	c1 ea 09             	shr    $0x9,%edx
801021b8:	89 f0                	mov    %esi,%eax
801021ba:	e8 51 f8 ff ff       	call   80101a10 <bmap>
801021bf:	83 ec 08             	sub    $0x8,%esp
801021c2:	50                   	push   %eax
801021c3:	ff 36                	push   (%esi)
801021c5:	e8 06 df ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801021ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801021cd:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801021d0:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801021d5:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
801021d7:	89 f8                	mov    %edi,%eax
801021d9:	25 ff 01 00 00       	and    $0x1ff,%eax
801021de:	29 d3                	sub    %edx,%ebx
801021e0:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
801021e2:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801021e6:	39 d9                	cmp    %ebx,%ecx
801021e8:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
801021eb:	83 c4 0c             	add    $0xc,%esp
801021ee:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801021ef:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
801021f1:	ff 75 dc             	push   -0x24(%ebp)
801021f4:	50                   	push   %eax
801021f5:	e8 d6 2a 00 00       	call   80104cd0 <memmove>
    log_write(bp);
801021fa:	89 34 24             	mov    %esi,(%esp)
801021fd:	e8 be 12 00 00       	call   801034c0 <log_write>
    brelse(bp);
80102202:	89 34 24             	mov    %esi,(%esp)
80102205:	e8 e6 df ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010220a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010220d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102210:	83 c4 10             	add    $0x10,%esp
80102213:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102216:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102219:	39 d8                	cmp    %ebx,%eax
8010221b:	72 93                	jb     801021b0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
8010221d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102220:	39 78 58             	cmp    %edi,0x58(%eax)
80102223:	72 33                	jb     80102258 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102225:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102228:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010222b:	5b                   	pop    %ebx
8010222c:	5e                   	pop    %esi
8010222d:	5f                   	pop    %edi
8010222e:	5d                   	pop    %ebp
8010222f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102230:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102234:	66 83 f8 09          	cmp    $0x9,%ax
80102238:	77 2f                	ja     80102269 <writei+0x119>
8010223a:	8b 04 c5 24 09 11 80 	mov    -0x7feef6dc(,%eax,8),%eax
80102241:	85 c0                	test   %eax,%eax
80102243:	74 24                	je     80102269 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80102245:	89 75 10             	mov    %esi,0x10(%ebp)
}
80102248:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010224b:	5b                   	pop    %ebx
8010224c:	5e                   	pop    %esi
8010224d:	5f                   	pop    %edi
8010224e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010224f:	ff e0                	jmp    *%eax
80102251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80102258:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010225b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
8010225e:	50                   	push   %eax
8010225f:	e8 2c fa ff ff       	call   80101c90 <iupdate>
80102264:	83 c4 10             	add    $0x10,%esp
80102267:	eb bc                	jmp    80102225 <writei+0xd5>
      return -1;
80102269:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010226e:	eb b8                	jmp    80102228 <writei+0xd8>

80102270 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102270:	55                   	push   %ebp
80102271:	89 e5                	mov    %esp,%ebp
80102273:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102276:	6a 0e                	push   $0xe
80102278:	ff 75 0c             	push   0xc(%ebp)
8010227b:	ff 75 08             	push   0x8(%ebp)
8010227e:	e8 bd 2a 00 00       	call   80104d40 <strncmp>
}
80102283:	c9                   	leave
80102284:	c3                   	ret
80102285:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010228c:	00 
8010228d:	8d 76 00             	lea    0x0(%esi),%esi

80102290 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	57                   	push   %edi
80102294:	56                   	push   %esi
80102295:	53                   	push   %ebx
80102296:	83 ec 1c             	sub    $0x1c,%esp
80102299:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010229c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801022a1:	0f 85 85 00 00 00    	jne    8010232c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801022a7:	8b 53 58             	mov    0x58(%ebx),%edx
801022aa:	31 ff                	xor    %edi,%edi
801022ac:	8d 75 d8             	lea    -0x28(%ebp),%esi
801022af:	85 d2                	test   %edx,%edx
801022b1:	74 3e                	je     801022f1 <dirlookup+0x61>
801022b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022b8:	6a 10                	push   $0x10
801022ba:	57                   	push   %edi
801022bb:	56                   	push   %esi
801022bc:	53                   	push   %ebx
801022bd:	e8 8e fd ff ff       	call   80102050 <readi>
801022c2:	83 c4 10             	add    $0x10,%esp
801022c5:	83 f8 10             	cmp    $0x10,%eax
801022c8:	75 55                	jne    8010231f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
801022ca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801022cf:	74 18                	je     801022e9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
801022d1:	83 ec 04             	sub    $0x4,%esp
801022d4:	8d 45 da             	lea    -0x26(%ebp),%eax
801022d7:	6a 0e                	push   $0xe
801022d9:	50                   	push   %eax
801022da:	ff 75 0c             	push   0xc(%ebp)
801022dd:	e8 5e 2a 00 00       	call   80104d40 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801022e2:	83 c4 10             	add    $0x10,%esp
801022e5:	85 c0                	test   %eax,%eax
801022e7:	74 17                	je     80102300 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
801022e9:	83 c7 10             	add    $0x10,%edi
801022ec:	3b 7b 58             	cmp    0x58(%ebx),%edi
801022ef:	72 c7                	jb     801022b8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801022f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801022f4:	31 c0                	xor    %eax,%eax
}
801022f6:	5b                   	pop    %ebx
801022f7:	5e                   	pop    %esi
801022f8:	5f                   	pop    %edi
801022f9:	5d                   	pop    %ebp
801022fa:	c3                   	ret
801022fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80102300:	8b 45 10             	mov    0x10(%ebp),%eax
80102303:	85 c0                	test   %eax,%eax
80102305:	74 05                	je     8010230c <dirlookup+0x7c>
        *poff = off;
80102307:	8b 45 10             	mov    0x10(%ebp),%eax
8010230a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010230c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102310:	8b 03                	mov    (%ebx),%eax
80102312:	e8 79 f5 ff ff       	call   80101890 <iget>
}
80102317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010231a:	5b                   	pop    %ebx
8010231b:	5e                   	pop    %esi
8010231c:	5f                   	pop    %edi
8010231d:	5d                   	pop    %ebp
8010231e:	c3                   	ret
      panic("dirlookup read");
8010231f:	83 ec 0c             	sub    $0xc,%esp
80102322:	68 48 78 10 80       	push   $0x80107848
80102327:	e8 54 e0 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
8010232c:	83 ec 0c             	sub    $0xc,%esp
8010232f:	68 36 78 10 80       	push   $0x80107836
80102334:	e8 47 e0 ff ff       	call   80100380 <panic>
80102339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102340 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	57                   	push   %edi
80102344:	56                   	push   %esi
80102345:	53                   	push   %ebx
80102346:	89 c3                	mov    %eax,%ebx
80102348:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010234b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010234e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102351:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102354:	0f 84 9e 01 00 00    	je     801024f8 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010235a:	e8 a1 1b 00 00       	call   80103f00 <myproc>
  acquire(&icache.lock);
8010235f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102362:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102365:	68 80 09 11 80       	push   $0x80110980
8010236a:	e8 d1 27 00 00       	call   80104b40 <acquire>
  ip->ref++;
8010236f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102373:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
8010237a:	e8 61 27 00 00       	call   80104ae0 <release>
8010237f:	83 c4 10             	add    $0x10,%esp
80102382:	eb 07                	jmp    8010238b <namex+0x4b>
80102384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102388:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010238b:	0f b6 03             	movzbl (%ebx),%eax
8010238e:	3c 2f                	cmp    $0x2f,%al
80102390:	74 f6                	je     80102388 <namex+0x48>
  if(*path == 0)
80102392:	84 c0                	test   %al,%al
80102394:	0f 84 06 01 00 00    	je     801024a0 <namex+0x160>
  while(*path != '/' && *path != 0)
8010239a:	0f b6 03             	movzbl (%ebx),%eax
8010239d:	84 c0                	test   %al,%al
8010239f:	0f 84 10 01 00 00    	je     801024b5 <namex+0x175>
801023a5:	89 df                	mov    %ebx,%edi
801023a7:	3c 2f                	cmp    $0x2f,%al
801023a9:	0f 84 06 01 00 00    	je     801024b5 <namex+0x175>
801023af:	90                   	nop
801023b0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
801023b4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
801023b7:	3c 2f                	cmp    $0x2f,%al
801023b9:	74 04                	je     801023bf <namex+0x7f>
801023bb:	84 c0                	test   %al,%al
801023bd:	75 f1                	jne    801023b0 <namex+0x70>
  len = path - s;
801023bf:	89 f8                	mov    %edi,%eax
801023c1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
801023c3:	83 f8 0d             	cmp    $0xd,%eax
801023c6:	0f 8e ac 00 00 00    	jle    80102478 <namex+0x138>
    memmove(name, s, DIRSIZ);
801023cc:	83 ec 04             	sub    $0x4,%esp
801023cf:	6a 0e                	push   $0xe
801023d1:	53                   	push   %ebx
801023d2:	89 fb                	mov    %edi,%ebx
801023d4:	ff 75 e4             	push   -0x1c(%ebp)
801023d7:	e8 f4 28 00 00       	call   80104cd0 <memmove>
801023dc:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801023df:	80 3f 2f             	cmpb   $0x2f,(%edi)
801023e2:	75 0c                	jne    801023f0 <namex+0xb0>
801023e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801023e8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801023eb:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801023ee:	74 f8                	je     801023e8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801023f0:	83 ec 0c             	sub    $0xc,%esp
801023f3:	56                   	push   %esi
801023f4:	e8 47 f9 ff ff       	call   80101d40 <ilock>
    if(ip->type != T_DIR){
801023f9:	83 c4 10             	add    $0x10,%esp
801023fc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102401:	0f 85 b7 00 00 00    	jne    801024be <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102407:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010240a:	85 c0                	test   %eax,%eax
8010240c:	74 09                	je     80102417 <namex+0xd7>
8010240e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102411:	0f 84 f7 00 00 00    	je     8010250e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102417:	83 ec 04             	sub    $0x4,%esp
8010241a:	6a 00                	push   $0x0
8010241c:	ff 75 e4             	push   -0x1c(%ebp)
8010241f:	56                   	push   %esi
80102420:	e8 6b fe ff ff       	call   80102290 <dirlookup>
80102425:	83 c4 10             	add    $0x10,%esp
80102428:	89 c7                	mov    %eax,%edi
8010242a:	85 c0                	test   %eax,%eax
8010242c:	0f 84 8c 00 00 00    	je     801024be <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102432:	83 ec 0c             	sub    $0xc,%esp
80102435:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102438:	51                   	push   %ecx
80102439:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010243c:	e8 bf 24 00 00       	call   80104900 <holdingsleep>
80102441:	83 c4 10             	add    $0x10,%esp
80102444:	85 c0                	test   %eax,%eax
80102446:	0f 84 02 01 00 00    	je     8010254e <namex+0x20e>
8010244c:	8b 56 08             	mov    0x8(%esi),%edx
8010244f:	85 d2                	test   %edx,%edx
80102451:	0f 8e f7 00 00 00    	jle    8010254e <namex+0x20e>
  releasesleep(&ip->lock);
80102457:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010245a:	83 ec 0c             	sub    $0xc,%esp
8010245d:	51                   	push   %ecx
8010245e:	e8 5d 24 00 00       	call   801048c0 <releasesleep>
  iput(ip);
80102463:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80102466:	89 fe                	mov    %edi,%esi
  iput(ip);
80102468:	e8 03 fa ff ff       	call   80101e70 <iput>
8010246d:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102470:	e9 16 ff ff ff       	jmp    8010238b <namex+0x4b>
80102475:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102478:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010247b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
8010247e:	83 ec 04             	sub    $0x4,%esp
80102481:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102484:	50                   	push   %eax
80102485:	53                   	push   %ebx
    name[len] = 0;
80102486:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102488:	ff 75 e4             	push   -0x1c(%ebp)
8010248b:	e8 40 28 00 00       	call   80104cd0 <memmove>
    name[len] = 0;
80102490:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102493:	83 c4 10             	add    $0x10,%esp
80102496:	c6 01 00             	movb   $0x0,(%ecx)
80102499:	e9 41 ff ff ff       	jmp    801023df <namex+0x9f>
8010249e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
801024a0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801024a3:	85 c0                	test   %eax,%eax
801024a5:	0f 85 93 00 00 00    	jne    8010253e <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
801024ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024ae:	89 f0                	mov    %esi,%eax
801024b0:	5b                   	pop    %ebx
801024b1:	5e                   	pop    %esi
801024b2:	5f                   	pop    %edi
801024b3:	5d                   	pop    %ebp
801024b4:	c3                   	ret
  while(*path != '/' && *path != 0)
801024b5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801024b8:	89 df                	mov    %ebx,%edi
801024ba:	31 c0                	xor    %eax,%eax
801024bc:	eb c0                	jmp    8010247e <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801024be:	83 ec 0c             	sub    $0xc,%esp
801024c1:	8d 5e 0c             	lea    0xc(%esi),%ebx
801024c4:	53                   	push   %ebx
801024c5:	e8 36 24 00 00       	call   80104900 <holdingsleep>
801024ca:	83 c4 10             	add    $0x10,%esp
801024cd:	85 c0                	test   %eax,%eax
801024cf:	74 7d                	je     8010254e <namex+0x20e>
801024d1:	8b 4e 08             	mov    0x8(%esi),%ecx
801024d4:	85 c9                	test   %ecx,%ecx
801024d6:	7e 76                	jle    8010254e <namex+0x20e>
  releasesleep(&ip->lock);
801024d8:	83 ec 0c             	sub    $0xc,%esp
801024db:	53                   	push   %ebx
801024dc:	e8 df 23 00 00       	call   801048c0 <releasesleep>
  iput(ip);
801024e1:	89 34 24             	mov    %esi,(%esp)
      return 0;
801024e4:	31 f6                	xor    %esi,%esi
  iput(ip);
801024e6:	e8 85 f9 ff ff       	call   80101e70 <iput>
      return 0;
801024eb:	83 c4 10             	add    $0x10,%esp
}
801024ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024f1:	89 f0                	mov    %esi,%eax
801024f3:	5b                   	pop    %ebx
801024f4:	5e                   	pop    %esi
801024f5:	5f                   	pop    %edi
801024f6:	5d                   	pop    %ebp
801024f7:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
801024f8:	ba 01 00 00 00       	mov    $0x1,%edx
801024fd:	b8 01 00 00 00       	mov    $0x1,%eax
80102502:	e8 89 f3 ff ff       	call   80101890 <iget>
80102507:	89 c6                	mov    %eax,%esi
80102509:	e9 7d fe ff ff       	jmp    8010238b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010250e:	83 ec 0c             	sub    $0xc,%esp
80102511:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102514:	53                   	push   %ebx
80102515:	e8 e6 23 00 00       	call   80104900 <holdingsleep>
8010251a:	83 c4 10             	add    $0x10,%esp
8010251d:	85 c0                	test   %eax,%eax
8010251f:	74 2d                	je     8010254e <namex+0x20e>
80102521:	8b 7e 08             	mov    0x8(%esi),%edi
80102524:	85 ff                	test   %edi,%edi
80102526:	7e 26                	jle    8010254e <namex+0x20e>
  releasesleep(&ip->lock);
80102528:	83 ec 0c             	sub    $0xc,%esp
8010252b:	53                   	push   %ebx
8010252c:	e8 8f 23 00 00       	call   801048c0 <releasesleep>
}
80102531:	83 c4 10             	add    $0x10,%esp
}
80102534:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102537:	89 f0                	mov    %esi,%eax
80102539:	5b                   	pop    %ebx
8010253a:	5e                   	pop    %esi
8010253b:	5f                   	pop    %edi
8010253c:	5d                   	pop    %ebp
8010253d:	c3                   	ret
    iput(ip);
8010253e:	83 ec 0c             	sub    $0xc,%esp
80102541:	56                   	push   %esi
      return 0;
80102542:	31 f6                	xor    %esi,%esi
    iput(ip);
80102544:	e8 27 f9 ff ff       	call   80101e70 <iput>
    return 0;
80102549:	83 c4 10             	add    $0x10,%esp
8010254c:	eb a0                	jmp    801024ee <namex+0x1ae>
    panic("iunlock");
8010254e:	83 ec 0c             	sub    $0xc,%esp
80102551:	68 2e 78 10 80       	push   $0x8010782e
80102556:	e8 25 de ff ff       	call   80100380 <panic>
8010255b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102560 <dirlink>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	57                   	push   %edi
80102564:	56                   	push   %esi
80102565:	53                   	push   %ebx
80102566:	83 ec 20             	sub    $0x20,%esp
80102569:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010256c:	6a 00                	push   $0x0
8010256e:	ff 75 0c             	push   0xc(%ebp)
80102571:	53                   	push   %ebx
80102572:	e8 19 fd ff ff       	call   80102290 <dirlookup>
80102577:	83 c4 10             	add    $0x10,%esp
8010257a:	85 c0                	test   %eax,%eax
8010257c:	75 67                	jne    801025e5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010257e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102581:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102584:	85 ff                	test   %edi,%edi
80102586:	74 29                	je     801025b1 <dirlink+0x51>
80102588:	31 ff                	xor    %edi,%edi
8010258a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010258d:	eb 09                	jmp    80102598 <dirlink+0x38>
8010258f:	90                   	nop
80102590:	83 c7 10             	add    $0x10,%edi
80102593:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102596:	73 19                	jae    801025b1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102598:	6a 10                	push   $0x10
8010259a:	57                   	push   %edi
8010259b:	56                   	push   %esi
8010259c:	53                   	push   %ebx
8010259d:	e8 ae fa ff ff       	call   80102050 <readi>
801025a2:	83 c4 10             	add    $0x10,%esp
801025a5:	83 f8 10             	cmp    $0x10,%eax
801025a8:	75 4e                	jne    801025f8 <dirlink+0x98>
    if(de.inum == 0)
801025aa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801025af:	75 df                	jne    80102590 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801025b1:	83 ec 04             	sub    $0x4,%esp
801025b4:	8d 45 da             	lea    -0x26(%ebp),%eax
801025b7:	6a 0e                	push   $0xe
801025b9:	ff 75 0c             	push   0xc(%ebp)
801025bc:	50                   	push   %eax
801025bd:	e8 ce 27 00 00       	call   80104d90 <strncpy>
  de.inum = inum;
801025c2:	8b 45 10             	mov    0x10(%ebp),%eax
801025c5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801025c9:	6a 10                	push   $0x10
801025cb:	57                   	push   %edi
801025cc:	56                   	push   %esi
801025cd:	53                   	push   %ebx
801025ce:	e8 7d fb ff ff       	call   80102150 <writei>
801025d3:	83 c4 20             	add    $0x20,%esp
801025d6:	83 f8 10             	cmp    $0x10,%eax
801025d9:	75 2a                	jne    80102605 <dirlink+0xa5>
  return 0;
801025db:	31 c0                	xor    %eax,%eax
}
801025dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025e0:	5b                   	pop    %ebx
801025e1:	5e                   	pop    %esi
801025e2:	5f                   	pop    %edi
801025e3:	5d                   	pop    %ebp
801025e4:	c3                   	ret
    iput(ip);
801025e5:	83 ec 0c             	sub    $0xc,%esp
801025e8:	50                   	push   %eax
801025e9:	e8 82 f8 ff ff       	call   80101e70 <iput>
    return -1;
801025ee:	83 c4 10             	add    $0x10,%esp
801025f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025f6:	eb e5                	jmp    801025dd <dirlink+0x7d>
      panic("dirlink read");
801025f8:	83 ec 0c             	sub    $0xc,%esp
801025fb:	68 57 78 10 80       	push   $0x80107857
80102600:	e8 7b dd ff ff       	call   80100380 <panic>
    panic("dirlink");
80102605:	83 ec 0c             	sub    $0xc,%esp
80102608:	68 b3 7a 10 80       	push   $0x80107ab3
8010260d:	e8 6e dd ff ff       	call   80100380 <panic>
80102612:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102619:	00 
8010261a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102620 <namei>:

struct inode*
namei(char *path)
{
80102620:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102621:	31 d2                	xor    %edx,%edx
{
80102623:	89 e5                	mov    %esp,%ebp
80102625:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102628:	8b 45 08             	mov    0x8(%ebp),%eax
8010262b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010262e:	e8 0d fd ff ff       	call   80102340 <namex>
}
80102633:	c9                   	leave
80102634:	c3                   	ret
80102635:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010263c:	00 
8010263d:	8d 76 00             	lea    0x0(%esi),%esi

80102640 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102640:	55                   	push   %ebp
  return namex(path, 1, name);
80102641:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102646:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102648:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010264b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010264e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010264f:	e9 ec fc ff ff       	jmp    80102340 <namex>
80102654:	66 90                	xchg   %ax,%ax
80102656:	66 90                	xchg   %ax,%ax
80102658:	66 90                	xchg   %ax,%ax
8010265a:	66 90                	xchg   %ax,%ax
8010265c:	66 90                	xchg   %ax,%ax
8010265e:	66 90                	xchg   %ax,%ax

80102660 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102660:	55                   	push   %ebp
80102661:	89 e5                	mov    %esp,%ebp
80102663:	57                   	push   %edi
80102664:	56                   	push   %esi
80102665:	53                   	push   %ebx
80102666:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102669:	85 c0                	test   %eax,%eax
8010266b:	0f 84 b4 00 00 00    	je     80102725 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102671:	8b 70 08             	mov    0x8(%eax),%esi
80102674:	89 c3                	mov    %eax,%ebx
80102676:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010267c:	0f 87 96 00 00 00    	ja     80102718 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102682:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102687:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010268e:	00 
8010268f:	90                   	nop
80102690:	89 ca                	mov    %ecx,%edx
80102692:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102693:	83 e0 c0             	and    $0xffffffc0,%eax
80102696:	3c 40                	cmp    $0x40,%al
80102698:	75 f6                	jne    80102690 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010269a:	31 ff                	xor    %edi,%edi
8010269c:	ba f6 03 00 00       	mov    $0x3f6,%edx
801026a1:	89 f8                	mov    %edi,%eax
801026a3:	ee                   	out    %al,(%dx)
801026a4:	b8 01 00 00 00       	mov    $0x1,%eax
801026a9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801026ae:	ee                   	out    %al,(%dx)
801026af:	ba f3 01 00 00       	mov    $0x1f3,%edx
801026b4:	89 f0                	mov    %esi,%eax
801026b6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801026b7:	89 f0                	mov    %esi,%eax
801026b9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801026be:	c1 f8 08             	sar    $0x8,%eax
801026c1:	ee                   	out    %al,(%dx)
801026c2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801026c7:	89 f8                	mov    %edi,%eax
801026c9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801026ca:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801026ce:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026d3:	c1 e0 04             	shl    $0x4,%eax
801026d6:	83 e0 10             	and    $0x10,%eax
801026d9:	83 c8 e0             	or     $0xffffffe0,%eax
801026dc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801026dd:	f6 03 04             	testb  $0x4,(%ebx)
801026e0:	75 16                	jne    801026f8 <idestart+0x98>
801026e2:	b8 20 00 00 00       	mov    $0x20,%eax
801026e7:	89 ca                	mov    %ecx,%edx
801026e9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801026ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026ed:	5b                   	pop    %ebx
801026ee:	5e                   	pop    %esi
801026ef:	5f                   	pop    %edi
801026f0:	5d                   	pop    %ebp
801026f1:	c3                   	ret
801026f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801026f8:	b8 30 00 00 00       	mov    $0x30,%eax
801026fd:	89 ca                	mov    %ecx,%edx
801026ff:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102700:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102705:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102708:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010270d:	fc                   	cld
8010270e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102710:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102713:	5b                   	pop    %ebx
80102714:	5e                   	pop    %esi
80102715:	5f                   	pop    %edi
80102716:	5d                   	pop    %ebp
80102717:	c3                   	ret
    panic("incorrect blockno");
80102718:	83 ec 0c             	sub    $0xc,%esp
8010271b:	68 6d 78 10 80       	push   $0x8010786d
80102720:	e8 5b dc ff ff       	call   80100380 <panic>
    panic("idestart");
80102725:	83 ec 0c             	sub    $0xc,%esp
80102728:	68 64 78 10 80       	push   $0x80107864
8010272d:	e8 4e dc ff ff       	call   80100380 <panic>
80102732:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102739:	00 
8010273a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102740 <ideinit>:
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
80102743:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102746:	68 7f 78 10 80       	push   $0x8010787f
8010274b:	68 20 26 11 80       	push   $0x80112620
80102750:	e8 fb 21 00 00       	call   80104950 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102755:	58                   	pop    %eax
80102756:	a1 a4 27 11 80       	mov    0x801127a4,%eax
8010275b:	5a                   	pop    %edx
8010275c:	83 e8 01             	sub    $0x1,%eax
8010275f:	50                   	push   %eax
80102760:	6a 0e                	push   $0xe
80102762:	e8 99 02 00 00       	call   80102a00 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102767:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010276a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010276f:	90                   	nop
80102770:	89 ca                	mov    %ecx,%edx
80102772:	ec                   	in     (%dx),%al
80102773:	83 e0 c0             	and    $0xffffffc0,%eax
80102776:	3c 40                	cmp    $0x40,%al
80102778:	75 f6                	jne    80102770 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010277a:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010277f:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102784:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102785:	89 ca                	mov    %ecx,%edx
80102787:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102788:	84 c0                	test   %al,%al
8010278a:	75 1e                	jne    801027aa <ideinit+0x6a>
8010278c:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102791:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102796:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010279d:	00 
8010279e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
801027a0:	83 e9 01             	sub    $0x1,%ecx
801027a3:	74 0f                	je     801027b4 <ideinit+0x74>
801027a5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801027a6:	84 c0                	test   %al,%al
801027a8:	74 f6                	je     801027a0 <ideinit+0x60>
      havedisk1 = 1;
801027aa:	c7 05 00 26 11 80 01 	movl   $0x1,0x80112600
801027b1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801027b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801027be:	ee                   	out    %al,(%dx)
}
801027bf:	c9                   	leave
801027c0:	c3                   	ret
801027c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801027c8:	00 
801027c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801027d0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	57                   	push   %edi
801027d4:	56                   	push   %esi
801027d5:	53                   	push   %ebx
801027d6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801027d9:	68 20 26 11 80       	push   $0x80112620
801027de:	e8 5d 23 00 00       	call   80104b40 <acquire>

  if((b = idequeue) == 0){
801027e3:	8b 1d 04 26 11 80    	mov    0x80112604,%ebx
801027e9:	83 c4 10             	add    $0x10,%esp
801027ec:	85 db                	test   %ebx,%ebx
801027ee:	74 63                	je     80102853 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801027f0:	8b 43 58             	mov    0x58(%ebx),%eax
801027f3:	a3 04 26 11 80       	mov    %eax,0x80112604

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801027f8:	8b 33                	mov    (%ebx),%esi
801027fa:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102800:	75 2f                	jne    80102831 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102802:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102807:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010280e:	00 
8010280f:	90                   	nop
80102810:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102811:	89 c1                	mov    %eax,%ecx
80102813:	83 e1 c0             	and    $0xffffffc0,%ecx
80102816:	80 f9 40             	cmp    $0x40,%cl
80102819:	75 f5                	jne    80102810 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010281b:	a8 21                	test   $0x21,%al
8010281d:	75 12                	jne    80102831 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010281f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102822:	b9 80 00 00 00       	mov    $0x80,%ecx
80102827:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010282c:	fc                   	cld
8010282d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010282f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102831:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102834:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102837:	83 ce 02             	or     $0x2,%esi
8010283a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010283c:	53                   	push   %ebx
8010283d:	e8 3e 1e 00 00       	call   80104680 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102842:	a1 04 26 11 80       	mov    0x80112604,%eax
80102847:	83 c4 10             	add    $0x10,%esp
8010284a:	85 c0                	test   %eax,%eax
8010284c:	74 05                	je     80102853 <ideintr+0x83>
    idestart(idequeue);
8010284e:	e8 0d fe ff ff       	call   80102660 <idestart>
    release(&idelock);
80102853:	83 ec 0c             	sub    $0xc,%esp
80102856:	68 20 26 11 80       	push   $0x80112620
8010285b:	e8 80 22 00 00       	call   80104ae0 <release>

  release(&idelock);
}
80102860:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102863:	5b                   	pop    %ebx
80102864:	5e                   	pop    %esi
80102865:	5f                   	pop    %edi
80102866:	5d                   	pop    %ebp
80102867:	c3                   	ret
80102868:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010286f:	00 

80102870 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
80102873:	53                   	push   %ebx
80102874:	83 ec 10             	sub    $0x10,%esp
80102877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010287a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010287d:	50                   	push   %eax
8010287e:	e8 7d 20 00 00       	call   80104900 <holdingsleep>
80102883:	83 c4 10             	add    $0x10,%esp
80102886:	85 c0                	test   %eax,%eax
80102888:	0f 84 c3 00 00 00    	je     80102951 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010288e:	8b 03                	mov    (%ebx),%eax
80102890:	83 e0 06             	and    $0x6,%eax
80102893:	83 f8 02             	cmp    $0x2,%eax
80102896:	0f 84 a8 00 00 00    	je     80102944 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010289c:	8b 53 04             	mov    0x4(%ebx),%edx
8010289f:	85 d2                	test   %edx,%edx
801028a1:	74 0d                	je     801028b0 <iderw+0x40>
801028a3:	a1 00 26 11 80       	mov    0x80112600,%eax
801028a8:	85 c0                	test   %eax,%eax
801028aa:	0f 84 87 00 00 00    	je     80102937 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801028b0:	83 ec 0c             	sub    $0xc,%esp
801028b3:	68 20 26 11 80       	push   $0x80112620
801028b8:	e8 83 22 00 00       	call   80104b40 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801028bd:	a1 04 26 11 80       	mov    0x80112604,%eax
  b->qnext = 0;
801028c2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801028c9:	83 c4 10             	add    $0x10,%esp
801028cc:	85 c0                	test   %eax,%eax
801028ce:	74 60                	je     80102930 <iderw+0xc0>
801028d0:	89 c2                	mov    %eax,%edx
801028d2:	8b 40 58             	mov    0x58(%eax),%eax
801028d5:	85 c0                	test   %eax,%eax
801028d7:	75 f7                	jne    801028d0 <iderw+0x60>
801028d9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801028dc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801028de:	39 1d 04 26 11 80    	cmp    %ebx,0x80112604
801028e4:	74 3a                	je     80102920 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801028e6:	8b 03                	mov    (%ebx),%eax
801028e8:	83 e0 06             	and    $0x6,%eax
801028eb:	83 f8 02             	cmp    $0x2,%eax
801028ee:	74 1b                	je     8010290b <iderw+0x9b>
    sleep(b, &idelock);
801028f0:	83 ec 08             	sub    $0x8,%esp
801028f3:	68 20 26 11 80       	push   $0x80112620
801028f8:	53                   	push   %ebx
801028f9:	e8 c2 1c 00 00       	call   801045c0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801028fe:	8b 03                	mov    (%ebx),%eax
80102900:	83 c4 10             	add    $0x10,%esp
80102903:	83 e0 06             	and    $0x6,%eax
80102906:	83 f8 02             	cmp    $0x2,%eax
80102909:	75 e5                	jne    801028f0 <iderw+0x80>
  }


  release(&idelock);
8010290b:	c7 45 08 20 26 11 80 	movl   $0x80112620,0x8(%ebp)
}
80102912:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102915:	c9                   	leave
  release(&idelock);
80102916:	e9 c5 21 00 00       	jmp    80104ae0 <release>
8010291b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102920:	89 d8                	mov    %ebx,%eax
80102922:	e8 39 fd ff ff       	call   80102660 <idestart>
80102927:	eb bd                	jmp    801028e6 <iderw+0x76>
80102929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102930:	ba 04 26 11 80       	mov    $0x80112604,%edx
80102935:	eb a5                	jmp    801028dc <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102937:	83 ec 0c             	sub    $0xc,%esp
8010293a:	68 ae 78 10 80       	push   $0x801078ae
8010293f:	e8 3c da ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102944:	83 ec 0c             	sub    $0xc,%esp
80102947:	68 99 78 10 80       	push   $0x80107899
8010294c:	e8 2f da ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102951:	83 ec 0c             	sub    $0xc,%esp
80102954:	68 83 78 10 80       	push   $0x80107883
80102959:	e8 22 da ff ff       	call   80100380 <panic>
8010295e:	66 90                	xchg   %ax,%ax

80102960 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102960:	55                   	push   %ebp
80102961:	89 e5                	mov    %esp,%ebp
80102963:	56                   	push   %esi
80102964:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102965:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
8010296c:	00 c0 fe 
  ioapic->reg = reg;
8010296f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102976:	00 00 00 
  return ioapic->data;
80102979:	8b 15 54 26 11 80    	mov    0x80112654,%edx
8010297f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102982:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102988:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010298e:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102995:	c1 ee 10             	shr    $0x10,%esi
80102998:	89 f0                	mov    %esi,%eax
8010299a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010299d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
801029a0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801029a3:	39 c2                	cmp    %eax,%edx
801029a5:	74 16                	je     801029bd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801029a7:	83 ec 0c             	sub    $0xc,%esp
801029aa:	68 c0 7c 10 80       	push   $0x80107cc0
801029af:	e8 ac dc ff ff       	call   80100660 <cprintf>
  ioapic->reg = reg;
801029b4:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
801029ba:	83 c4 10             	add    $0x10,%esp
{
801029bd:	ba 10 00 00 00       	mov    $0x10,%edx
801029c2:	31 c0                	xor    %eax,%eax
801029c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
801029c8:	89 13                	mov    %edx,(%ebx)
801029ca:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
801029cd:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801029d3:	83 c0 01             	add    $0x1,%eax
801029d6:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
801029dc:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
801029df:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
801029e2:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801029e5:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801029e7:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
801029ed:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
801029f4:	39 c6                	cmp    %eax,%esi
801029f6:	7d d0                	jge    801029c8 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801029f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801029fb:	5b                   	pop    %ebx
801029fc:	5e                   	pop    %esi
801029fd:	5d                   	pop    %ebp
801029fe:	c3                   	ret
801029ff:	90                   	nop

80102a00 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102a00:	55                   	push   %ebp
  ioapic->reg = reg;
80102a01:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
{
80102a07:	89 e5                	mov    %esp,%ebp
80102a09:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102a0c:	8d 50 20             	lea    0x20(%eax),%edx
80102a0f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102a13:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102a15:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a1b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102a1e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a21:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102a24:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102a26:	a1 54 26 11 80       	mov    0x80112654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a2b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102a2e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102a31:	5d                   	pop    %ebp
80102a32:	c3                   	ret
80102a33:	66 90                	xchg   %ax,%ax
80102a35:	66 90                	xchg   %ax,%ax
80102a37:	66 90                	xchg   %ax,%ax
80102a39:	66 90                	xchg   %ax,%ax
80102a3b:	66 90                	xchg   %ax,%ax
80102a3d:	66 90                	xchg   %ax,%ax
80102a3f:	90                   	nop

80102a40 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102a40:	55                   	push   %ebp
80102a41:	89 e5                	mov    %esp,%ebp
80102a43:	53                   	push   %ebx
80102a44:	83 ec 04             	sub    $0x4,%esp
80102a47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102a4a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102a50:	75 76                	jne    80102ac8 <kfree+0x88>
80102a52:	81 fb f0 64 11 80    	cmp    $0x801164f0,%ebx
80102a58:	72 6e                	jb     80102ac8 <kfree+0x88>
80102a5a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102a60:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102a65:	77 61                	ja     80102ac8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102a67:	83 ec 04             	sub    $0x4,%esp
80102a6a:	68 00 10 00 00       	push   $0x1000
80102a6f:	6a 01                	push   $0x1
80102a71:	53                   	push   %ebx
80102a72:	e8 c9 21 00 00       	call   80104c40 <memset>

  if(kmem.use_lock)
80102a77:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102a7d:	83 c4 10             	add    $0x10,%esp
80102a80:	85 d2                	test   %edx,%edx
80102a82:	75 1c                	jne    80102aa0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102a84:	a1 98 26 11 80       	mov    0x80112698,%eax
80102a89:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102a8b:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
80102a90:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
80102a96:	85 c0                	test   %eax,%eax
80102a98:	75 1e                	jne    80102ab8 <kfree+0x78>
    release(&kmem.lock);
}
80102a9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a9d:	c9                   	leave
80102a9e:	c3                   	ret
80102a9f:	90                   	nop
    acquire(&kmem.lock);
80102aa0:	83 ec 0c             	sub    $0xc,%esp
80102aa3:	68 60 26 11 80       	push   $0x80112660
80102aa8:	e8 93 20 00 00       	call   80104b40 <acquire>
80102aad:	83 c4 10             	add    $0x10,%esp
80102ab0:	eb d2                	jmp    80102a84 <kfree+0x44>
80102ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102ab8:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
80102abf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ac2:	c9                   	leave
    release(&kmem.lock);
80102ac3:	e9 18 20 00 00       	jmp    80104ae0 <release>
    panic("kfree");
80102ac8:	83 ec 0c             	sub    $0xc,%esp
80102acb:	68 cc 78 10 80       	push   $0x801078cc
80102ad0:	e8 ab d8 ff ff       	call   80100380 <panic>
80102ad5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102adc:	00 
80102add:	8d 76 00             	lea    0x0(%esi),%esi

80102ae0 <freerange>:
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	56                   	push   %esi
80102ae4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102ae5:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102ae8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102aeb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102af1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102af7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102afd:	39 de                	cmp    %ebx,%esi
80102aff:	72 23                	jb     80102b24 <freerange+0x44>
80102b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102b08:	83 ec 0c             	sub    $0xc,%esp
80102b0b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b11:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102b17:	50                   	push   %eax
80102b18:	e8 23 ff ff ff       	call   80102a40 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b1d:	83 c4 10             	add    $0x10,%esp
80102b20:	39 de                	cmp    %ebx,%esi
80102b22:	73 e4                	jae    80102b08 <freerange+0x28>
}
80102b24:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b27:	5b                   	pop    %ebx
80102b28:	5e                   	pop    %esi
80102b29:	5d                   	pop    %ebp
80102b2a:	c3                   	ret
80102b2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102b30 <kinit2>:
{
80102b30:	55                   	push   %ebp
80102b31:	89 e5                	mov    %esp,%ebp
80102b33:	56                   	push   %esi
80102b34:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102b35:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102b38:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102b3b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102b41:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b47:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102b4d:	39 de                	cmp    %ebx,%esi
80102b4f:	72 23                	jb     80102b74 <kinit2+0x44>
80102b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102b58:	83 ec 0c             	sub    $0xc,%esp
80102b5b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b61:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102b67:	50                   	push   %eax
80102b68:	e8 d3 fe ff ff       	call   80102a40 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b6d:	83 c4 10             	add    $0x10,%esp
80102b70:	39 de                	cmp    %ebx,%esi
80102b72:	73 e4                	jae    80102b58 <kinit2+0x28>
  kmem.use_lock = 1;
80102b74:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
80102b7b:	00 00 00 
}
80102b7e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b81:	5b                   	pop    %ebx
80102b82:	5e                   	pop    %esi
80102b83:	5d                   	pop    %ebp
80102b84:	c3                   	ret
80102b85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b8c:	00 
80102b8d:	8d 76 00             	lea    0x0(%esi),%esi

80102b90 <kinit1>:
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	56                   	push   %esi
80102b94:	53                   	push   %ebx
80102b95:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102b98:	83 ec 08             	sub    $0x8,%esp
80102b9b:	68 d2 78 10 80       	push   $0x801078d2
80102ba0:	68 60 26 11 80       	push   $0x80112660
80102ba5:	e8 a6 1d 00 00       	call   80104950 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102baa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bad:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102bb0:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102bb7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102bba:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102bc0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bc6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102bcc:	39 de                	cmp    %ebx,%esi
80102bce:	72 1c                	jb     80102bec <kinit1+0x5c>
    kfree(p);
80102bd0:	83 ec 0c             	sub    $0xc,%esp
80102bd3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bd9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102bdf:	50                   	push   %eax
80102be0:	e8 5b fe ff ff       	call   80102a40 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102be5:	83 c4 10             	add    $0x10,%esp
80102be8:	39 de                	cmp    %ebx,%esi
80102bea:	73 e4                	jae    80102bd0 <kinit1+0x40>
}
80102bec:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102bef:	5b                   	pop    %ebx
80102bf0:	5e                   	pop    %esi
80102bf1:	5d                   	pop    %ebp
80102bf2:	c3                   	ret
80102bf3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102bfa:	00 
80102bfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102c00 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102c00:	55                   	push   %ebp
80102c01:	89 e5                	mov    %esp,%ebp
80102c03:	53                   	push   %ebx
80102c04:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102c07:	a1 94 26 11 80       	mov    0x80112694,%eax
80102c0c:	85 c0                	test   %eax,%eax
80102c0e:	75 20                	jne    80102c30 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102c10:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102c16:	85 db                	test   %ebx,%ebx
80102c18:	74 07                	je     80102c21 <kalloc+0x21>
    kmem.freelist = r->next;
80102c1a:	8b 03                	mov    (%ebx),%eax
80102c1c:	a3 98 26 11 80       	mov    %eax,0x80112698
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102c21:	89 d8                	mov    %ebx,%eax
80102c23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c26:	c9                   	leave
80102c27:	c3                   	ret
80102c28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c2f:	00 
    acquire(&kmem.lock);
80102c30:	83 ec 0c             	sub    $0xc,%esp
80102c33:	68 60 26 11 80       	push   $0x80112660
80102c38:	e8 03 1f 00 00       	call   80104b40 <acquire>
  r = kmem.freelist;
80102c3d:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(kmem.use_lock)
80102c43:	a1 94 26 11 80       	mov    0x80112694,%eax
  if(r)
80102c48:	83 c4 10             	add    $0x10,%esp
80102c4b:	85 db                	test   %ebx,%ebx
80102c4d:	74 08                	je     80102c57 <kalloc+0x57>
    kmem.freelist = r->next;
80102c4f:	8b 13                	mov    (%ebx),%edx
80102c51:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
80102c57:	85 c0                	test   %eax,%eax
80102c59:	74 c6                	je     80102c21 <kalloc+0x21>
    release(&kmem.lock);
80102c5b:	83 ec 0c             	sub    $0xc,%esp
80102c5e:	68 60 26 11 80       	push   $0x80112660
80102c63:	e8 78 1e 00 00       	call   80104ae0 <release>
}
80102c68:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
80102c6a:	83 c4 10             	add    $0x10,%esp
}
80102c6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c70:	c9                   	leave
80102c71:	c3                   	ret
80102c72:	66 90                	xchg   %ax,%ax
80102c74:	66 90                	xchg   %ax,%ax
80102c76:	66 90                	xchg   %ax,%ax
80102c78:	66 90                	xchg   %ax,%ax
80102c7a:	66 90                	xchg   %ax,%ax
80102c7c:	66 90                	xchg   %ax,%ax
80102c7e:	66 90                	xchg   %ax,%ax

80102c80 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c80:	ba 64 00 00 00       	mov    $0x64,%edx
80102c85:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102c86:	a8 01                	test   $0x1,%al
80102c88:	0f 84 c2 00 00 00    	je     80102d50 <kbdgetc+0xd0>
{
80102c8e:	55                   	push   %ebp
80102c8f:	ba 60 00 00 00       	mov    $0x60,%edx
80102c94:	89 e5                	mov    %esp,%ebp
80102c96:	53                   	push   %ebx
80102c97:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102c98:	8b 1d 9c 26 11 80    	mov    0x8011269c,%ebx
  data = inb(KBDATAP);
80102c9e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102ca1:	3c e0                	cmp    $0xe0,%al
80102ca3:	74 5b                	je     80102d00 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102ca5:	89 da                	mov    %ebx,%edx
80102ca7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
80102caa:	84 c0                	test   %al,%al
80102cac:	78 62                	js     80102d10 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102cae:	85 d2                	test   %edx,%edx
80102cb0:	74 09                	je     80102cbb <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102cb2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102cb5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102cb8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102cbb:	0f b6 91 20 7f 10 80 	movzbl -0x7fef80e0(%ecx),%edx
  shift ^= togglecode[data];
80102cc2:	0f b6 81 20 7e 10 80 	movzbl -0x7fef81e0(%ecx),%eax
  shift |= shiftcode[data];
80102cc9:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102ccb:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102ccd:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80102ccf:	89 15 9c 26 11 80    	mov    %edx,0x8011269c
  c = charcode[shift & (CTL | SHIFT)][data];
80102cd5:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102cd8:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102cdb:	8b 04 85 00 7e 10 80 	mov    -0x7fef8200(,%eax,4),%eax
80102ce2:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102ce6:	74 0b                	je     80102cf3 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102ce8:	8d 50 9f             	lea    -0x61(%eax),%edx
80102ceb:	83 fa 19             	cmp    $0x19,%edx
80102cee:	77 48                	ja     80102d38 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102cf0:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102cf3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cf6:	c9                   	leave
80102cf7:	c3                   	ret
80102cf8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102cff:	00 
    shift |= E0ESC;
80102d00:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102d03:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102d05:	89 1d 9c 26 11 80    	mov    %ebx,0x8011269c
}
80102d0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d0e:	c9                   	leave
80102d0f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102d10:	83 e0 7f             	and    $0x7f,%eax
80102d13:	85 d2                	test   %edx,%edx
80102d15:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102d18:	0f b6 81 20 7f 10 80 	movzbl -0x7fef80e0(%ecx),%eax
80102d1f:	83 c8 40             	or     $0x40,%eax
80102d22:	0f b6 c0             	movzbl %al,%eax
80102d25:	f7 d0                	not    %eax
80102d27:	21 d8                	and    %ebx,%eax
80102d29:	a3 9c 26 11 80       	mov    %eax,0x8011269c
    return 0;
80102d2e:	31 c0                	xor    %eax,%eax
80102d30:	eb d9                	jmp    80102d0b <kbdgetc+0x8b>
80102d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102d38:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102d3b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102d3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d41:	c9                   	leave
      c += 'a' - 'A';
80102d42:	83 f9 1a             	cmp    $0x1a,%ecx
80102d45:	0f 42 c2             	cmovb  %edx,%eax
}
80102d48:	c3                   	ret
80102d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102d55:	c3                   	ret
80102d56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d5d:	00 
80102d5e:	66 90                	xchg   %ax,%ax

80102d60 <kbdintr>:

void
kbdintr(void)
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102d66:	68 80 2c 10 80       	push   $0x80102c80
80102d6b:	e8 40 db ff ff       	call   801008b0 <consoleintr>
}
80102d70:	83 c4 10             	add    $0x10,%esp
80102d73:	c9                   	leave
80102d74:	c3                   	ret
80102d75:	66 90                	xchg   %ax,%ax
80102d77:	66 90                	xchg   %ax,%ax
80102d79:	66 90                	xchg   %ax,%ax
80102d7b:	66 90                	xchg   %ax,%ax
80102d7d:	66 90                	xchg   %ax,%ax
80102d7f:	90                   	nop

80102d80 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102d80:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80102d85:	85 c0                	test   %eax,%eax
80102d87:	0f 84 c3 00 00 00    	je     80102e50 <lapicinit+0xd0>
  lapic[index] = value;
80102d8d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102d94:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d97:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d9a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102da1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102da4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102da7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102dae:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102db1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102db4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102dbb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102dbe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102dc1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102dc8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102dcb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102dce:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102dd5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102dd8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102ddb:	8b 50 30             	mov    0x30(%eax),%edx
80102dde:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102de4:	75 72                	jne    80102e58 <lapicinit+0xd8>
  lapic[index] = value;
80102de6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102ded:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102df0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102df3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102dfa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dfd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e00:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102e07:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e0a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e0d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102e14:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e17:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e1a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102e21:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e24:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e27:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102e2e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102e31:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e38:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102e3e:	80 e6 10             	and    $0x10,%dh
80102e41:	75 f5                	jne    80102e38 <lapicinit+0xb8>
  lapic[index] = value;
80102e43:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102e4a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e4d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102e50:	c3                   	ret
80102e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102e58:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102e5f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102e62:	8b 50 20             	mov    0x20(%eax),%edx
}
80102e65:	e9 7c ff ff ff       	jmp    80102de6 <lapicinit+0x66>
80102e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102e70 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102e70:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80102e75:	85 c0                	test   %eax,%eax
80102e77:	74 07                	je     80102e80 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102e79:	8b 40 20             	mov    0x20(%eax),%eax
80102e7c:	c1 e8 18             	shr    $0x18,%eax
80102e7f:	c3                   	ret
    return 0;
80102e80:	31 c0                	xor    %eax,%eax
}
80102e82:	c3                   	ret
80102e83:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e8a:	00 
80102e8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102e90 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102e90:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80102e95:	85 c0                	test   %eax,%eax
80102e97:	74 0d                	je     80102ea6 <lapiceoi+0x16>
  lapic[index] = value;
80102e99:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ea0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ea3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102ea6:	c3                   	ret
80102ea7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102eae:	00 
80102eaf:	90                   	nop

80102eb0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102eb0:	c3                   	ret
80102eb1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102eb8:	00 
80102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ec0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102ec0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ec1:	b8 0f 00 00 00       	mov    $0xf,%eax
80102ec6:	ba 70 00 00 00       	mov    $0x70,%edx
80102ecb:	89 e5                	mov    %esp,%ebp
80102ecd:	53                   	push   %ebx
80102ece:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102ed1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102ed4:	ee                   	out    %al,(%dx)
80102ed5:	b8 0a 00 00 00       	mov    $0xa,%eax
80102eda:	ba 71 00 00 00       	mov    $0x71,%edx
80102edf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102ee0:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102ee2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102ee5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102eeb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102eed:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102ef0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102ef2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102ef5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102ef8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102efe:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80102f03:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102f09:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102f0c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102f13:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f16:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102f19:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102f20:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f23:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102f26:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102f2c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102f2f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102f35:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102f38:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102f3e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f41:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102f47:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102f4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f4d:	c9                   	leave
80102f4e:	c3                   	ret
80102f4f:	90                   	nop

80102f50 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102f50:	55                   	push   %ebp
80102f51:	b8 0b 00 00 00       	mov    $0xb,%eax
80102f56:	ba 70 00 00 00       	mov    $0x70,%edx
80102f5b:	89 e5                	mov    %esp,%ebp
80102f5d:	57                   	push   %edi
80102f5e:	56                   	push   %esi
80102f5f:	53                   	push   %ebx
80102f60:	83 ec 4c             	sub    $0x4c,%esp
80102f63:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f64:	ba 71 00 00 00       	mov    $0x71,%edx
80102f69:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102f6a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f6d:	bf 70 00 00 00       	mov    $0x70,%edi
80102f72:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102f75:	8d 76 00             	lea    0x0(%esi),%esi
80102f78:	31 c0                	xor    %eax,%eax
80102f7a:	89 fa                	mov    %edi,%edx
80102f7c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f7d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102f82:	89 ca                	mov    %ecx,%edx
80102f84:	ec                   	in     (%dx),%al
80102f85:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f88:	89 fa                	mov    %edi,%edx
80102f8a:	b8 02 00 00 00       	mov    $0x2,%eax
80102f8f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f90:	89 ca                	mov    %ecx,%edx
80102f92:	ec                   	in     (%dx),%al
80102f93:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f96:	89 fa                	mov    %edi,%edx
80102f98:	b8 04 00 00 00       	mov    $0x4,%eax
80102f9d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f9e:	89 ca                	mov    %ecx,%edx
80102fa0:	ec                   	in     (%dx),%al
80102fa1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fa4:	89 fa                	mov    %edi,%edx
80102fa6:	b8 07 00 00 00       	mov    $0x7,%eax
80102fab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fac:	89 ca                	mov    %ecx,%edx
80102fae:	ec                   	in     (%dx),%al
80102faf:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fb2:	89 fa                	mov    %edi,%edx
80102fb4:	b8 08 00 00 00       	mov    $0x8,%eax
80102fb9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fba:	89 ca                	mov    %ecx,%edx
80102fbc:	ec                   	in     (%dx),%al
80102fbd:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fbf:	89 fa                	mov    %edi,%edx
80102fc1:	b8 09 00 00 00       	mov    $0x9,%eax
80102fc6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fc7:	89 ca                	mov    %ecx,%edx
80102fc9:	ec                   	in     (%dx),%al
80102fca:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fcd:	89 fa                	mov    %edi,%edx
80102fcf:	b8 0a 00 00 00       	mov    $0xa,%eax
80102fd4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fd5:	89 ca                	mov    %ecx,%edx
80102fd7:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102fd8:	84 c0                	test   %al,%al
80102fda:	78 9c                	js     80102f78 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102fdc:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102fe0:	89 f2                	mov    %esi,%edx
80102fe2:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102fe5:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fe8:	89 fa                	mov    %edi,%edx
80102fea:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102fed:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102ff1:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102ff4:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102ff7:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102ffb:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102ffe:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103002:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103005:	31 c0                	xor    %eax,%eax
80103007:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103008:	89 ca                	mov    %ecx,%edx
8010300a:	ec                   	in     (%dx),%al
8010300b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010300e:	89 fa                	mov    %edi,%edx
80103010:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103013:	b8 02 00 00 00       	mov    $0x2,%eax
80103018:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103019:	89 ca                	mov    %ecx,%edx
8010301b:	ec                   	in     (%dx),%al
8010301c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010301f:	89 fa                	mov    %edi,%edx
80103021:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103024:	b8 04 00 00 00       	mov    $0x4,%eax
80103029:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010302a:	89 ca                	mov    %ecx,%edx
8010302c:	ec                   	in     (%dx),%al
8010302d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103030:	89 fa                	mov    %edi,%edx
80103032:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103035:	b8 07 00 00 00       	mov    $0x7,%eax
8010303a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010303b:	89 ca                	mov    %ecx,%edx
8010303d:	ec                   	in     (%dx),%al
8010303e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103041:	89 fa                	mov    %edi,%edx
80103043:	89 45 dc             	mov    %eax,-0x24(%ebp)
80103046:	b8 08 00 00 00       	mov    $0x8,%eax
8010304b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010304c:	89 ca                	mov    %ecx,%edx
8010304e:	ec                   	in     (%dx),%al
8010304f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103052:	89 fa                	mov    %edi,%edx
80103054:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103057:	b8 09 00 00 00       	mov    $0x9,%eax
8010305c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010305d:	89 ca                	mov    %ecx,%edx
8010305f:	ec                   	in     (%dx),%al
80103060:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103063:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80103066:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103069:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010306c:	6a 18                	push   $0x18
8010306e:	50                   	push   %eax
8010306f:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103072:	50                   	push   %eax
80103073:	e8 08 1c 00 00       	call   80104c80 <memcmp>
80103078:	83 c4 10             	add    $0x10,%esp
8010307b:	85 c0                	test   %eax,%eax
8010307d:	0f 85 f5 fe ff ff    	jne    80102f78 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103083:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80103087:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010308a:	89 f0                	mov    %esi,%eax
8010308c:	84 c0                	test   %al,%al
8010308e:	75 78                	jne    80103108 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103090:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103093:	89 c2                	mov    %eax,%edx
80103095:	83 e0 0f             	and    $0xf,%eax
80103098:	c1 ea 04             	shr    $0x4,%edx
8010309b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010309e:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030a1:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801030a4:	8b 45 bc             	mov    -0x44(%ebp),%eax
801030a7:	89 c2                	mov    %eax,%edx
801030a9:	83 e0 0f             	and    $0xf,%eax
801030ac:	c1 ea 04             	shr    $0x4,%edx
801030af:	8d 14 92             	lea    (%edx,%edx,4),%edx
801030b2:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030b5:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801030b8:	8b 45 c0             	mov    -0x40(%ebp),%eax
801030bb:	89 c2                	mov    %eax,%edx
801030bd:	83 e0 0f             	and    $0xf,%eax
801030c0:	c1 ea 04             	shr    $0x4,%edx
801030c3:	8d 14 92             	lea    (%edx,%edx,4),%edx
801030c6:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801030cc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801030cf:	89 c2                	mov    %eax,%edx
801030d1:	83 e0 0f             	and    $0xf,%eax
801030d4:	c1 ea 04             	shr    $0x4,%edx
801030d7:	8d 14 92             	lea    (%edx,%edx,4),%edx
801030da:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030dd:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801030e0:	8b 45 c8             	mov    -0x38(%ebp),%eax
801030e3:	89 c2                	mov    %eax,%edx
801030e5:	83 e0 0f             	and    $0xf,%eax
801030e8:	c1 ea 04             	shr    $0x4,%edx
801030eb:	8d 14 92             	lea    (%edx,%edx,4),%edx
801030ee:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030f1:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801030f4:	8b 45 cc             	mov    -0x34(%ebp),%eax
801030f7:	89 c2                	mov    %eax,%edx
801030f9:	83 e0 0f             	and    $0xf,%eax
801030fc:	c1 ea 04             	shr    $0x4,%edx
801030ff:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103102:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103105:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103108:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010310b:	89 03                	mov    %eax,(%ebx)
8010310d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103110:	89 43 04             	mov    %eax,0x4(%ebx)
80103113:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103116:	89 43 08             	mov    %eax,0x8(%ebx)
80103119:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010311c:	89 43 0c             	mov    %eax,0xc(%ebx)
8010311f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103122:	89 43 10             	mov    %eax,0x10(%ebx)
80103125:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103128:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
8010312b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80103132:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103135:	5b                   	pop    %ebx
80103136:	5e                   	pop    %esi
80103137:	5f                   	pop    %edi
80103138:	5d                   	pop    %ebp
80103139:	c3                   	ret
8010313a:	66 90                	xchg   %ax,%ax
8010313c:	66 90                	xchg   %ax,%ax
8010313e:	66 90                	xchg   %ax,%ax

80103140 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103140:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
80103146:	85 c9                	test   %ecx,%ecx
80103148:	0f 8e 8a 00 00 00    	jle    801031d8 <install_trans+0x98>
{
8010314e:	55                   	push   %ebp
8010314f:	89 e5                	mov    %esp,%ebp
80103151:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103152:	31 ff                	xor    %edi,%edi
{
80103154:	56                   	push   %esi
80103155:	53                   	push   %ebx
80103156:	83 ec 0c             	sub    $0xc,%esp
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103160:	a1 f4 26 11 80       	mov    0x801126f4,%eax
80103165:	83 ec 08             	sub    $0x8,%esp
80103168:	01 f8                	add    %edi,%eax
8010316a:	83 c0 01             	add    $0x1,%eax
8010316d:	50                   	push   %eax
8010316e:	ff 35 04 27 11 80    	push   0x80112704
80103174:	e8 57 cf ff ff       	call   801000d0 <bread>
80103179:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010317b:	58                   	pop    %eax
8010317c:	5a                   	pop    %edx
8010317d:	ff 34 bd 0c 27 11 80 	push   -0x7feed8f4(,%edi,4)
80103184:	ff 35 04 27 11 80    	push   0x80112704
  for (tail = 0; tail < log.lh.n; tail++) {
8010318a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010318d:	e8 3e cf ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103192:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103195:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103197:	8d 46 5c             	lea    0x5c(%esi),%eax
8010319a:	68 00 02 00 00       	push   $0x200
8010319f:	50                   	push   %eax
801031a0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801031a3:	50                   	push   %eax
801031a4:	e8 27 1b 00 00       	call   80104cd0 <memmove>
    bwrite(dbuf);  // write dst to disk
801031a9:	89 1c 24             	mov    %ebx,(%esp)
801031ac:	e8 ff cf ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
801031b1:	89 34 24             	mov    %esi,(%esp)
801031b4:	e8 37 d0 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
801031b9:	89 1c 24             	mov    %ebx,(%esp)
801031bc:	e8 2f d0 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801031c1:	83 c4 10             	add    $0x10,%esp
801031c4:	39 3d 08 27 11 80    	cmp    %edi,0x80112708
801031ca:	7f 94                	jg     80103160 <install_trans+0x20>
  }
}
801031cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031cf:	5b                   	pop    %ebx
801031d0:	5e                   	pop    %esi
801031d1:	5f                   	pop    %edi
801031d2:	5d                   	pop    %ebp
801031d3:	c3                   	ret
801031d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031d8:	c3                   	ret
801031d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801031e0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801031e0:	55                   	push   %ebp
801031e1:	89 e5                	mov    %esp,%ebp
801031e3:	53                   	push   %ebx
801031e4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
801031e7:	ff 35 f4 26 11 80    	push   0x801126f4
801031ed:	ff 35 04 27 11 80    	push   0x80112704
801031f3:	e8 d8 ce ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801031f8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
801031fb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
801031fd:	a1 08 27 11 80       	mov    0x80112708,%eax
80103202:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103205:	85 c0                	test   %eax,%eax
80103207:	7e 19                	jle    80103222 <write_head+0x42>
80103209:	31 d2                	xor    %edx,%edx
8010320b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80103210:	8b 0c 95 0c 27 11 80 	mov    -0x7feed8f4(,%edx,4),%ecx
80103217:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010321b:	83 c2 01             	add    $0x1,%edx
8010321e:	39 d0                	cmp    %edx,%eax
80103220:	75 ee                	jne    80103210 <write_head+0x30>
  }
  bwrite(buf);
80103222:	83 ec 0c             	sub    $0xc,%esp
80103225:	53                   	push   %ebx
80103226:	e8 85 cf ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010322b:	89 1c 24             	mov    %ebx,(%esp)
8010322e:	e8 bd cf ff ff       	call   801001f0 <brelse>
}
80103233:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103236:	83 c4 10             	add    $0x10,%esp
80103239:	c9                   	leave
8010323a:	c3                   	ret
8010323b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103240 <initlog>:
{
80103240:	55                   	push   %ebp
80103241:	89 e5                	mov    %esp,%ebp
80103243:	53                   	push   %ebx
80103244:	83 ec 2c             	sub    $0x2c,%esp
80103247:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010324a:	68 d7 78 10 80       	push   $0x801078d7
8010324f:	68 c0 26 11 80       	push   $0x801126c0
80103254:	e8 f7 16 00 00       	call   80104950 <initlock>
  readsb(dev, &sb);
80103259:	58                   	pop    %eax
8010325a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010325d:	5a                   	pop    %edx
8010325e:	50                   	push   %eax
8010325f:	53                   	push   %ebx
80103260:	e8 7b e8 ff ff       	call   80101ae0 <readsb>
  log.start = sb.logstart;
80103265:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103268:	59                   	pop    %ecx
  log.dev = dev;
80103269:	89 1d 04 27 11 80    	mov    %ebx,0x80112704
  log.size = sb.nlog;
8010326f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103272:	a3 f4 26 11 80       	mov    %eax,0x801126f4
  log.size = sb.nlog;
80103277:	89 15 f8 26 11 80    	mov    %edx,0x801126f8
  struct buf *buf = bread(log.dev, log.start);
8010327d:	5a                   	pop    %edx
8010327e:	50                   	push   %eax
8010327f:	53                   	push   %ebx
80103280:	e8 4b ce ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103285:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103288:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010328b:	89 1d 08 27 11 80    	mov    %ebx,0x80112708
  for (i = 0; i < log.lh.n; i++) {
80103291:	85 db                	test   %ebx,%ebx
80103293:	7e 1d                	jle    801032b2 <initlog+0x72>
80103295:	31 d2                	xor    %edx,%edx
80103297:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010329e:	00 
8010329f:	90                   	nop
    log.lh.block[i] = lh->block[i];
801032a0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
801032a4:	89 0c 95 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801032ab:	83 c2 01             	add    $0x1,%edx
801032ae:	39 d3                	cmp    %edx,%ebx
801032b0:	75 ee                	jne    801032a0 <initlog+0x60>
  brelse(buf);
801032b2:	83 ec 0c             	sub    $0xc,%esp
801032b5:	50                   	push   %eax
801032b6:	e8 35 cf ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
801032bb:	e8 80 fe ff ff       	call   80103140 <install_trans>
  log.lh.n = 0;
801032c0:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
801032c7:	00 00 00 
  write_head(); // clear the log
801032ca:	e8 11 ff ff ff       	call   801031e0 <write_head>
}
801032cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801032d2:	83 c4 10             	add    $0x10,%esp
801032d5:	c9                   	leave
801032d6:	c3                   	ret
801032d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032de:	00 
801032df:	90                   	nop

801032e0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
801032e6:	68 c0 26 11 80       	push   $0x801126c0
801032eb:	e8 50 18 00 00       	call   80104b40 <acquire>
801032f0:	83 c4 10             	add    $0x10,%esp
801032f3:	eb 18                	jmp    8010330d <begin_op+0x2d>
801032f5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801032f8:	83 ec 08             	sub    $0x8,%esp
801032fb:	68 c0 26 11 80       	push   $0x801126c0
80103300:	68 c0 26 11 80       	push   $0x801126c0
80103305:	e8 b6 12 00 00       	call   801045c0 <sleep>
8010330a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010330d:	a1 00 27 11 80       	mov    0x80112700,%eax
80103312:	85 c0                	test   %eax,%eax
80103314:	75 e2                	jne    801032f8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103316:	a1 fc 26 11 80       	mov    0x801126fc,%eax
8010331b:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80103321:	83 c0 01             	add    $0x1,%eax
80103324:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103327:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010332a:	83 fa 1e             	cmp    $0x1e,%edx
8010332d:	7f c9                	jg     801032f8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010332f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103332:	a3 fc 26 11 80       	mov    %eax,0x801126fc
      release(&log.lock);
80103337:	68 c0 26 11 80       	push   $0x801126c0
8010333c:	e8 9f 17 00 00       	call   80104ae0 <release>
      break;
    }
  }
}
80103341:	83 c4 10             	add    $0x10,%esp
80103344:	c9                   	leave
80103345:	c3                   	ret
80103346:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010334d:	00 
8010334e:	66 90                	xchg   %ax,%ax

80103350 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	57                   	push   %edi
80103354:	56                   	push   %esi
80103355:	53                   	push   %ebx
80103356:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103359:	68 c0 26 11 80       	push   $0x801126c0
8010335e:	e8 dd 17 00 00       	call   80104b40 <acquire>
  log.outstanding -= 1;
80103363:	a1 fc 26 11 80       	mov    0x801126fc,%eax
  if(log.committing)
80103368:	8b 35 00 27 11 80    	mov    0x80112700,%esi
8010336e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103371:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103374:	89 1d fc 26 11 80    	mov    %ebx,0x801126fc
  if(log.committing)
8010337a:	85 f6                	test   %esi,%esi
8010337c:	0f 85 22 01 00 00    	jne    801034a4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103382:	85 db                	test   %ebx,%ebx
80103384:	0f 85 f6 00 00 00    	jne    80103480 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010338a:	c7 05 00 27 11 80 01 	movl   $0x1,0x80112700
80103391:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103394:	83 ec 0c             	sub    $0xc,%esp
80103397:	68 c0 26 11 80       	push   $0x801126c0
8010339c:	e8 3f 17 00 00       	call   80104ae0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801033a1:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
801033a7:	83 c4 10             	add    $0x10,%esp
801033aa:	85 c9                	test   %ecx,%ecx
801033ac:	7f 42                	jg     801033f0 <end_op+0xa0>
    acquire(&log.lock);
801033ae:	83 ec 0c             	sub    $0xc,%esp
801033b1:	68 c0 26 11 80       	push   $0x801126c0
801033b6:	e8 85 17 00 00       	call   80104b40 <acquire>
    log.committing = 0;
801033bb:	c7 05 00 27 11 80 00 	movl   $0x0,0x80112700
801033c2:	00 00 00 
    wakeup(&log);
801033c5:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
801033cc:	e8 af 12 00 00       	call   80104680 <wakeup>
    release(&log.lock);
801033d1:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
801033d8:	e8 03 17 00 00       	call   80104ae0 <release>
801033dd:	83 c4 10             	add    $0x10,%esp
}
801033e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033e3:	5b                   	pop    %ebx
801033e4:	5e                   	pop    %esi
801033e5:	5f                   	pop    %edi
801033e6:	5d                   	pop    %ebp
801033e7:	c3                   	ret
801033e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033ef:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801033f0:	a1 f4 26 11 80       	mov    0x801126f4,%eax
801033f5:	83 ec 08             	sub    $0x8,%esp
801033f8:	01 d8                	add    %ebx,%eax
801033fa:	83 c0 01             	add    $0x1,%eax
801033fd:	50                   	push   %eax
801033fe:	ff 35 04 27 11 80    	push   0x80112704
80103404:	e8 c7 cc ff ff       	call   801000d0 <bread>
80103409:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010340b:	58                   	pop    %eax
8010340c:	5a                   	pop    %edx
8010340d:	ff 34 9d 0c 27 11 80 	push   -0x7feed8f4(,%ebx,4)
80103414:	ff 35 04 27 11 80    	push   0x80112704
  for (tail = 0; tail < log.lh.n; tail++) {
8010341a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010341d:	e8 ae cc ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103422:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103425:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103427:	8d 40 5c             	lea    0x5c(%eax),%eax
8010342a:	68 00 02 00 00       	push   $0x200
8010342f:	50                   	push   %eax
80103430:	8d 46 5c             	lea    0x5c(%esi),%eax
80103433:	50                   	push   %eax
80103434:	e8 97 18 00 00       	call   80104cd0 <memmove>
    bwrite(to);  // write the log
80103439:	89 34 24             	mov    %esi,(%esp)
8010343c:	e8 6f cd ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103441:	89 3c 24             	mov    %edi,(%esp)
80103444:	e8 a7 cd ff ff       	call   801001f0 <brelse>
    brelse(to);
80103449:	89 34 24             	mov    %esi,(%esp)
8010344c:	e8 9f cd ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103451:	83 c4 10             	add    $0x10,%esp
80103454:	3b 1d 08 27 11 80    	cmp    0x80112708,%ebx
8010345a:	7c 94                	jl     801033f0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010345c:	e8 7f fd ff ff       	call   801031e0 <write_head>
    install_trans(); // Now install writes to home locations
80103461:	e8 da fc ff ff       	call   80103140 <install_trans>
    log.lh.n = 0;
80103466:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
8010346d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103470:	e8 6b fd ff ff       	call   801031e0 <write_head>
80103475:	e9 34 ff ff ff       	jmp    801033ae <end_op+0x5e>
8010347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103480:	83 ec 0c             	sub    $0xc,%esp
80103483:	68 c0 26 11 80       	push   $0x801126c0
80103488:	e8 f3 11 00 00       	call   80104680 <wakeup>
  release(&log.lock);
8010348d:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
80103494:	e8 47 16 00 00       	call   80104ae0 <release>
80103499:	83 c4 10             	add    $0x10,%esp
}
8010349c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010349f:	5b                   	pop    %ebx
801034a0:	5e                   	pop    %esi
801034a1:	5f                   	pop    %edi
801034a2:	5d                   	pop    %ebp
801034a3:	c3                   	ret
    panic("log.committing");
801034a4:	83 ec 0c             	sub    $0xc,%esp
801034a7:	68 db 78 10 80       	push   $0x801078db
801034ac:	e8 cf ce ff ff       	call   80100380 <panic>
801034b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034b8:	00 
801034b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034c0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	53                   	push   %ebx
801034c4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801034c7:	8b 15 08 27 11 80    	mov    0x80112708,%edx
{
801034cd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801034d0:	83 fa 1d             	cmp    $0x1d,%edx
801034d3:	7f 7d                	jg     80103552 <log_write+0x92>
801034d5:	a1 f8 26 11 80       	mov    0x801126f8,%eax
801034da:	83 e8 01             	sub    $0x1,%eax
801034dd:	39 c2                	cmp    %eax,%edx
801034df:	7d 71                	jge    80103552 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
801034e1:	a1 fc 26 11 80       	mov    0x801126fc,%eax
801034e6:	85 c0                	test   %eax,%eax
801034e8:	7e 75                	jle    8010355f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
801034ea:	83 ec 0c             	sub    $0xc,%esp
801034ed:	68 c0 26 11 80       	push   $0x801126c0
801034f2:	e8 49 16 00 00       	call   80104b40 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801034f7:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801034fa:	83 c4 10             	add    $0x10,%esp
801034fd:	31 c0                	xor    %eax,%eax
801034ff:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80103505:	85 d2                	test   %edx,%edx
80103507:	7f 0e                	jg     80103517 <log_write+0x57>
80103509:	eb 15                	jmp    80103520 <log_write+0x60>
8010350b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103510:	83 c0 01             	add    $0x1,%eax
80103513:	39 c2                	cmp    %eax,%edx
80103515:	74 29                	je     80103540 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103517:	39 0c 85 0c 27 11 80 	cmp    %ecx,-0x7feed8f4(,%eax,4)
8010351e:	75 f0                	jne    80103510 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103520:	89 0c 85 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%eax,4)
  if (i == log.lh.n)
80103527:	39 c2                	cmp    %eax,%edx
80103529:	74 1c                	je     80103547 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
8010352b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010352e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103531:	c7 45 08 c0 26 11 80 	movl   $0x801126c0,0x8(%ebp)
}
80103538:	c9                   	leave
  release(&log.lock);
80103539:	e9 a2 15 00 00       	jmp    80104ae0 <release>
8010353e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103540:	89 0c 95 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%edx,4)
    log.lh.n++;
80103547:	83 c2 01             	add    $0x1,%edx
8010354a:	89 15 08 27 11 80    	mov    %edx,0x80112708
80103550:	eb d9                	jmp    8010352b <log_write+0x6b>
    panic("too big a transaction");
80103552:	83 ec 0c             	sub    $0xc,%esp
80103555:	68 ea 78 10 80       	push   $0x801078ea
8010355a:	e8 21 ce ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010355f:	83 ec 0c             	sub    $0xc,%esp
80103562:	68 00 79 10 80       	push   $0x80107900
80103567:	e8 14 ce ff ff       	call   80100380 <panic>
8010356c:	66 90                	xchg   %ax,%ax
8010356e:	66 90                	xchg   %ax,%ax

80103570 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103570:	55                   	push   %ebp
80103571:	89 e5                	mov    %esp,%ebp
80103573:	53                   	push   %ebx
80103574:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103577:	e8 64 09 00 00       	call   80103ee0 <cpuid>
8010357c:	89 c3                	mov    %eax,%ebx
8010357e:	e8 5d 09 00 00       	call   80103ee0 <cpuid>
80103583:	83 ec 04             	sub    $0x4,%esp
80103586:	53                   	push   %ebx
80103587:	50                   	push   %eax
80103588:	68 1b 79 10 80       	push   $0x8010791b
8010358d:	e8 ce d0 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103592:	e8 e9 28 00 00       	call   80105e80 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103597:	e8 e4 08 00 00       	call   80103e80 <mycpu>
8010359c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010359e:	b8 01 00 00 00       	mov    $0x1,%eax
801035a3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801035aa:	e8 01 0c 00 00       	call   801041b0 <scheduler>
801035af:	90                   	nop

801035b0 <mpenter>:
{
801035b0:	55                   	push   %ebp
801035b1:	89 e5                	mov    %esp,%ebp
801035b3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801035b6:	e8 c5 39 00 00       	call   80106f80 <switchkvm>
  seginit();
801035bb:	e8 30 39 00 00       	call   80106ef0 <seginit>
  lapicinit();
801035c0:	e8 bb f7 ff ff       	call   80102d80 <lapicinit>
  mpmain();
801035c5:	e8 a6 ff ff ff       	call   80103570 <mpmain>
801035ca:	66 90                	xchg   %ax,%ax
801035cc:	66 90                	xchg   %ax,%ax
801035ce:	66 90                	xchg   %ax,%ax

801035d0 <main>:
{
801035d0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801035d4:	83 e4 f0             	and    $0xfffffff0,%esp
801035d7:	ff 71 fc             	push   -0x4(%ecx)
801035da:	55                   	push   %ebp
801035db:	89 e5                	mov    %esp,%ebp
801035dd:	53                   	push   %ebx
801035de:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801035df:	83 ec 08             	sub    $0x8,%esp
801035e2:	68 00 00 40 80       	push   $0x80400000
801035e7:	68 f0 64 11 80       	push   $0x801164f0
801035ec:	e8 9f f5 ff ff       	call   80102b90 <kinit1>
  kvmalloc();      // kernel page table
801035f1:	e8 4a 3e 00 00       	call   80107440 <kvmalloc>
  mpinit();        // detect other processors
801035f6:	e8 85 01 00 00       	call   80103780 <mpinit>
  lapicinit();     // interrupt controller
801035fb:	e8 80 f7 ff ff       	call   80102d80 <lapicinit>
  seginit();       // segment descriptors
80103600:	e8 eb 38 00 00       	call   80106ef0 <seginit>
  picinit();       // disable pic
80103605:	e8 86 03 00 00       	call   80103990 <picinit>
  ioapicinit();    // another interrupt controller
8010360a:	e8 51 f3 ff ff       	call   80102960 <ioapicinit>
  consoleinit();   // console hardware
8010360f:	e8 0c d9 ff ff       	call   80100f20 <consoleinit>
  uartinit();      // serial port
80103614:	e8 47 2b 00 00       	call   80106160 <uartinit>
  pinit();         // process table
80103619:	e8 42 08 00 00       	call   80103e60 <pinit>
  tvinit();        // trap vectors
8010361e:	e8 dd 27 00 00       	call   80105e00 <tvinit>
  binit();         // buffer cache
80103623:	e8 18 ca ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103628:	e8 a3 dd ff ff       	call   801013d0 <fileinit>
  ideinit();       // disk 
8010362d:	e8 0e f1 ff ff       	call   80102740 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103632:	83 c4 0c             	add    $0xc,%esp
80103635:	68 8a 00 00 00       	push   $0x8a
8010363a:	68 8c b4 10 80       	push   $0x8010b48c
8010363f:	68 00 70 00 80       	push   $0x80007000
80103644:	e8 87 16 00 00       	call   80104cd0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103649:	83 c4 10             	add    $0x10,%esp
8010364c:	69 05 a4 27 11 80 b0 	imul   $0xb0,0x801127a4,%eax
80103653:	00 00 00 
80103656:	05 c0 27 11 80       	add    $0x801127c0,%eax
8010365b:	3d c0 27 11 80       	cmp    $0x801127c0,%eax
80103660:	76 7e                	jbe    801036e0 <main+0x110>
80103662:	bb c0 27 11 80       	mov    $0x801127c0,%ebx
80103667:	eb 20                	jmp    80103689 <main+0xb9>
80103669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103670:	69 05 a4 27 11 80 b0 	imul   $0xb0,0x801127a4,%eax
80103677:	00 00 00 
8010367a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103680:	05 c0 27 11 80       	add    $0x801127c0,%eax
80103685:	39 c3                	cmp    %eax,%ebx
80103687:	73 57                	jae    801036e0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103689:	e8 f2 07 00 00       	call   80103e80 <mycpu>
8010368e:	39 c3                	cmp    %eax,%ebx
80103690:	74 de                	je     80103670 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103692:	e8 69 f5 ff ff       	call   80102c00 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103697:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010369a:	c7 05 f8 6f 00 80 b0 	movl   $0x801035b0,0x80006ff8
801036a1:	35 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801036a4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801036ab:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801036ae:	05 00 10 00 00       	add    $0x1000,%eax
801036b3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801036b8:	0f b6 03             	movzbl (%ebx),%eax
801036bb:	68 00 70 00 00       	push   $0x7000
801036c0:	50                   	push   %eax
801036c1:	e8 fa f7 ff ff       	call   80102ec0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801036c6:	83 c4 10             	add    $0x10,%esp
801036c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036d0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801036d6:	85 c0                	test   %eax,%eax
801036d8:	74 f6                	je     801036d0 <main+0x100>
801036da:	eb 94                	jmp    80103670 <main+0xa0>
801036dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801036e0:	83 ec 08             	sub    $0x8,%esp
801036e3:	68 00 00 00 8e       	push   $0x8e000000
801036e8:	68 00 00 40 80       	push   $0x80400000
801036ed:	e8 3e f4 ff ff       	call   80102b30 <kinit2>
  userinit();      // first user process
801036f2:	e8 39 08 00 00       	call   80103f30 <userinit>
  mpmain();        // finish this processor's setup
801036f7:	e8 74 fe ff ff       	call   80103570 <mpmain>
801036fc:	66 90                	xchg   %ax,%ax
801036fe:	66 90                	xchg   %ax,%ax

80103700 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	57                   	push   %edi
80103704:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103705:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010370b:	53                   	push   %ebx
  e = addr+len;
8010370c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010370f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103712:	39 de                	cmp    %ebx,%esi
80103714:	72 10                	jb     80103726 <mpsearch1+0x26>
80103716:	eb 50                	jmp    80103768 <mpsearch1+0x68>
80103718:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010371f:	00 
80103720:	89 fe                	mov    %edi,%esi
80103722:	39 df                	cmp    %ebx,%edi
80103724:	73 42                	jae    80103768 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103726:	83 ec 04             	sub    $0x4,%esp
80103729:	8d 7e 10             	lea    0x10(%esi),%edi
8010372c:	6a 04                	push   $0x4
8010372e:	68 2f 79 10 80       	push   $0x8010792f
80103733:	56                   	push   %esi
80103734:	e8 47 15 00 00       	call   80104c80 <memcmp>
80103739:	83 c4 10             	add    $0x10,%esp
8010373c:	85 c0                	test   %eax,%eax
8010373e:	75 e0                	jne    80103720 <mpsearch1+0x20>
80103740:	89 f2                	mov    %esi,%edx
80103742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103748:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010374b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010374e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103750:	39 fa                	cmp    %edi,%edx
80103752:	75 f4                	jne    80103748 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103754:	84 c0                	test   %al,%al
80103756:	75 c8                	jne    80103720 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103758:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010375b:	89 f0                	mov    %esi,%eax
8010375d:	5b                   	pop    %ebx
8010375e:	5e                   	pop    %esi
8010375f:	5f                   	pop    %edi
80103760:	5d                   	pop    %ebp
80103761:	c3                   	ret
80103762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103768:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010376b:	31 f6                	xor    %esi,%esi
}
8010376d:	5b                   	pop    %ebx
8010376e:	89 f0                	mov    %esi,%eax
80103770:	5e                   	pop    %esi
80103771:	5f                   	pop    %edi
80103772:	5d                   	pop    %ebp
80103773:	c3                   	ret
80103774:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010377b:	00 
8010377c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103780 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	57                   	push   %edi
80103784:	56                   	push   %esi
80103785:	53                   	push   %ebx
80103786:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103789:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103790:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103797:	c1 e0 08             	shl    $0x8,%eax
8010379a:	09 d0                	or     %edx,%eax
8010379c:	c1 e0 04             	shl    $0x4,%eax
8010379f:	75 1b                	jne    801037bc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801037a1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801037a8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801037af:	c1 e0 08             	shl    $0x8,%eax
801037b2:	09 d0                	or     %edx,%eax
801037b4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801037b7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801037bc:	ba 00 04 00 00       	mov    $0x400,%edx
801037c1:	e8 3a ff ff ff       	call   80103700 <mpsearch1>
801037c6:	89 c3                	mov    %eax,%ebx
801037c8:	85 c0                	test   %eax,%eax
801037ca:	0f 84 58 01 00 00    	je     80103928 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801037d0:	8b 73 04             	mov    0x4(%ebx),%esi
801037d3:	85 f6                	test   %esi,%esi
801037d5:	0f 84 3d 01 00 00    	je     80103918 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
801037db:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801037de:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801037e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801037e7:	6a 04                	push   $0x4
801037e9:	68 34 79 10 80       	push   $0x80107934
801037ee:	50                   	push   %eax
801037ef:	e8 8c 14 00 00       	call   80104c80 <memcmp>
801037f4:	83 c4 10             	add    $0x10,%esp
801037f7:	85 c0                	test   %eax,%eax
801037f9:	0f 85 19 01 00 00    	jne    80103918 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
801037ff:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103806:	3c 01                	cmp    $0x1,%al
80103808:	74 08                	je     80103812 <mpinit+0x92>
8010380a:	3c 04                	cmp    $0x4,%al
8010380c:	0f 85 06 01 00 00    	jne    80103918 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80103812:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103819:	66 85 d2             	test   %dx,%dx
8010381c:	74 22                	je     80103840 <mpinit+0xc0>
8010381e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103821:	89 f0                	mov    %esi,%eax
  sum = 0;
80103823:	31 d2                	xor    %edx,%edx
80103825:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103828:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010382f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103832:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103834:	39 f8                	cmp    %edi,%eax
80103836:	75 f0                	jne    80103828 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103838:	84 d2                	test   %dl,%dl
8010383a:	0f 85 d8 00 00 00    	jne    80103918 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103840:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103846:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103849:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
8010384c:	a3 a0 26 11 80       	mov    %eax,0x801126a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103851:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103858:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
8010385e:	01 d7                	add    %edx,%edi
80103860:	89 fa                	mov    %edi,%edx
  ismp = 1;
80103862:	bf 01 00 00 00       	mov    $0x1,%edi
80103867:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010386e:	00 
8010386f:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103870:	39 d0                	cmp    %edx,%eax
80103872:	73 19                	jae    8010388d <mpinit+0x10d>
    switch(*p){
80103874:	0f b6 08             	movzbl (%eax),%ecx
80103877:	80 f9 02             	cmp    $0x2,%cl
8010387a:	0f 84 80 00 00 00    	je     80103900 <mpinit+0x180>
80103880:	77 6e                	ja     801038f0 <mpinit+0x170>
80103882:	84 c9                	test   %cl,%cl
80103884:	74 3a                	je     801038c0 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103886:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103889:	39 d0                	cmp    %edx,%eax
8010388b:	72 e7                	jb     80103874 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010388d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103890:	85 ff                	test   %edi,%edi
80103892:	0f 84 dd 00 00 00    	je     80103975 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103898:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010389c:	74 15                	je     801038b3 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010389e:	b8 70 00 00 00       	mov    $0x70,%eax
801038a3:	ba 22 00 00 00       	mov    $0x22,%edx
801038a8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801038a9:	ba 23 00 00 00       	mov    $0x23,%edx
801038ae:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801038af:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801038b2:	ee                   	out    %al,(%dx)
  }
}
801038b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038b6:	5b                   	pop    %ebx
801038b7:	5e                   	pop    %esi
801038b8:	5f                   	pop    %edi
801038b9:	5d                   	pop    %ebp
801038ba:	c3                   	ret
801038bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
801038c0:	8b 0d a4 27 11 80    	mov    0x801127a4,%ecx
801038c6:	83 f9 07             	cmp    $0x7,%ecx
801038c9:	7f 19                	jg     801038e4 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801038cb:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
801038d1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
801038d5:	83 c1 01             	add    $0x1,%ecx
801038d8:	89 0d a4 27 11 80    	mov    %ecx,0x801127a4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801038de:	88 9e c0 27 11 80    	mov    %bl,-0x7feed840(%esi)
      p += sizeof(struct mpproc);
801038e4:	83 c0 14             	add    $0x14,%eax
      continue;
801038e7:	eb 87                	jmp    80103870 <mpinit+0xf0>
801038e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
801038f0:	83 e9 03             	sub    $0x3,%ecx
801038f3:	80 f9 01             	cmp    $0x1,%cl
801038f6:	76 8e                	jbe    80103886 <mpinit+0x106>
801038f8:	31 ff                	xor    %edi,%edi
801038fa:	e9 71 ff ff ff       	jmp    80103870 <mpinit+0xf0>
801038ff:	90                   	nop
      ioapicid = ioapic->apicno;
80103900:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103904:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103907:	88 0d a0 27 11 80    	mov    %cl,0x801127a0
      continue;
8010390d:	e9 5e ff ff ff       	jmp    80103870 <mpinit+0xf0>
80103912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103918:	83 ec 0c             	sub    $0xc,%esp
8010391b:	68 39 79 10 80       	push   $0x80107939
80103920:	e8 5b ca ff ff       	call   80100380 <panic>
80103925:	8d 76 00             	lea    0x0(%esi),%esi
{
80103928:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010392d:	eb 0b                	jmp    8010393a <mpinit+0x1ba>
8010392f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103930:	89 f3                	mov    %esi,%ebx
80103932:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103938:	74 de                	je     80103918 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010393a:	83 ec 04             	sub    $0x4,%esp
8010393d:	8d 73 10             	lea    0x10(%ebx),%esi
80103940:	6a 04                	push   $0x4
80103942:	68 2f 79 10 80       	push   $0x8010792f
80103947:	53                   	push   %ebx
80103948:	e8 33 13 00 00       	call   80104c80 <memcmp>
8010394d:	83 c4 10             	add    $0x10,%esp
80103950:	85 c0                	test   %eax,%eax
80103952:	75 dc                	jne    80103930 <mpinit+0x1b0>
80103954:	89 da                	mov    %ebx,%edx
80103956:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010395d:	00 
8010395e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80103960:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103963:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103966:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103968:	39 d6                	cmp    %edx,%esi
8010396a:	75 f4                	jne    80103960 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010396c:	84 c0                	test   %al,%al
8010396e:	75 c0                	jne    80103930 <mpinit+0x1b0>
80103970:	e9 5b fe ff ff       	jmp    801037d0 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103975:	83 ec 0c             	sub    $0xc,%esp
80103978:	68 f4 7c 10 80       	push   $0x80107cf4
8010397d:	e8 fe c9 ff ff       	call   80100380 <panic>
80103982:	66 90                	xchg   %ax,%ax
80103984:	66 90                	xchg   %ax,%ax
80103986:	66 90                	xchg   %ax,%ax
80103988:	66 90                	xchg   %ax,%ax
8010398a:	66 90                	xchg   %ax,%ax
8010398c:	66 90                	xchg   %ax,%ax
8010398e:	66 90                	xchg   %ax,%ax

80103990 <picinit>:
80103990:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103995:	ba 21 00 00 00       	mov    $0x21,%edx
8010399a:	ee                   	out    %al,(%dx)
8010399b:	ba a1 00 00 00       	mov    $0xa1,%edx
801039a0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801039a1:	c3                   	ret
801039a2:	66 90                	xchg   %ax,%ax
801039a4:	66 90                	xchg   %ax,%ax
801039a6:	66 90                	xchg   %ax,%ax
801039a8:	66 90                	xchg   %ax,%ax
801039aa:	66 90                	xchg   %ax,%ax
801039ac:	66 90                	xchg   %ax,%ax
801039ae:	66 90                	xchg   %ax,%ax

801039b0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	57                   	push   %edi
801039b4:	56                   	push   %esi
801039b5:	53                   	push   %ebx
801039b6:	83 ec 0c             	sub    $0xc,%esp
801039b9:	8b 75 08             	mov    0x8(%ebp),%esi
801039bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801039bf:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
801039c5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801039cb:	e8 20 da ff ff       	call   801013f0 <filealloc>
801039d0:	89 06                	mov    %eax,(%esi)
801039d2:	85 c0                	test   %eax,%eax
801039d4:	0f 84 a5 00 00 00    	je     80103a7f <pipealloc+0xcf>
801039da:	e8 11 da ff ff       	call   801013f0 <filealloc>
801039df:	89 07                	mov    %eax,(%edi)
801039e1:	85 c0                	test   %eax,%eax
801039e3:	0f 84 84 00 00 00    	je     80103a6d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801039e9:	e8 12 f2 ff ff       	call   80102c00 <kalloc>
801039ee:	89 c3                	mov    %eax,%ebx
801039f0:	85 c0                	test   %eax,%eax
801039f2:	0f 84 a0 00 00 00    	je     80103a98 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
801039f8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801039ff:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103a02:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103a05:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103a0c:	00 00 00 
  p->nwrite = 0;
80103a0f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103a16:	00 00 00 
  p->nread = 0;
80103a19:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103a20:	00 00 00 
  initlock(&p->lock, "pipe");
80103a23:	68 51 79 10 80       	push   $0x80107951
80103a28:	50                   	push   %eax
80103a29:	e8 22 0f 00 00       	call   80104950 <initlock>
  (*f0)->type = FD_PIPE;
80103a2e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103a30:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103a33:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103a39:	8b 06                	mov    (%esi),%eax
80103a3b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103a3f:	8b 06                	mov    (%esi),%eax
80103a41:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103a45:	8b 06                	mov    (%esi),%eax
80103a47:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103a4a:	8b 07                	mov    (%edi),%eax
80103a4c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103a52:	8b 07                	mov    (%edi),%eax
80103a54:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103a58:	8b 07                	mov    (%edi),%eax
80103a5a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103a5e:	8b 07                	mov    (%edi),%eax
80103a60:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103a63:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103a65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a68:	5b                   	pop    %ebx
80103a69:	5e                   	pop    %esi
80103a6a:	5f                   	pop    %edi
80103a6b:	5d                   	pop    %ebp
80103a6c:	c3                   	ret
  if(*f0)
80103a6d:	8b 06                	mov    (%esi),%eax
80103a6f:	85 c0                	test   %eax,%eax
80103a71:	74 1e                	je     80103a91 <pipealloc+0xe1>
    fileclose(*f0);
80103a73:	83 ec 0c             	sub    $0xc,%esp
80103a76:	50                   	push   %eax
80103a77:	e8 34 da ff ff       	call   801014b0 <fileclose>
80103a7c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103a7f:	8b 07                	mov    (%edi),%eax
80103a81:	85 c0                	test   %eax,%eax
80103a83:	74 0c                	je     80103a91 <pipealloc+0xe1>
    fileclose(*f1);
80103a85:	83 ec 0c             	sub    $0xc,%esp
80103a88:	50                   	push   %eax
80103a89:	e8 22 da ff ff       	call   801014b0 <fileclose>
80103a8e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103a91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a96:	eb cd                	jmp    80103a65 <pipealloc+0xb5>
  if(*f0)
80103a98:	8b 06                	mov    (%esi),%eax
80103a9a:	85 c0                	test   %eax,%eax
80103a9c:	75 d5                	jne    80103a73 <pipealloc+0xc3>
80103a9e:	eb df                	jmp    80103a7f <pipealloc+0xcf>

80103aa0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	56                   	push   %esi
80103aa4:	53                   	push   %ebx
80103aa5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103aa8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103aab:	83 ec 0c             	sub    $0xc,%esp
80103aae:	53                   	push   %ebx
80103aaf:	e8 8c 10 00 00       	call   80104b40 <acquire>
  if(writable){
80103ab4:	83 c4 10             	add    $0x10,%esp
80103ab7:	85 f6                	test   %esi,%esi
80103ab9:	74 65                	je     80103b20 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
80103abb:	83 ec 0c             	sub    $0xc,%esp
80103abe:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103ac4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103acb:	00 00 00 
    wakeup(&p->nread);
80103ace:	50                   	push   %eax
80103acf:	e8 ac 0b 00 00       	call   80104680 <wakeup>
80103ad4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103ad7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103add:	85 d2                	test   %edx,%edx
80103adf:	75 0a                	jne    80103aeb <pipeclose+0x4b>
80103ae1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103ae7:	85 c0                	test   %eax,%eax
80103ae9:	74 15                	je     80103b00 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103aeb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103aee:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103af1:	5b                   	pop    %ebx
80103af2:	5e                   	pop    %esi
80103af3:	5d                   	pop    %ebp
    release(&p->lock);
80103af4:	e9 e7 0f 00 00       	jmp    80104ae0 <release>
80103af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103b00:	83 ec 0c             	sub    $0xc,%esp
80103b03:	53                   	push   %ebx
80103b04:	e8 d7 0f 00 00       	call   80104ae0 <release>
    kfree((char*)p);
80103b09:	83 c4 10             	add    $0x10,%esp
80103b0c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103b0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b12:	5b                   	pop    %ebx
80103b13:	5e                   	pop    %esi
80103b14:	5d                   	pop    %ebp
    kfree((char*)p);
80103b15:	e9 26 ef ff ff       	jmp    80102a40 <kfree>
80103b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103b20:	83 ec 0c             	sub    $0xc,%esp
80103b23:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103b29:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103b30:	00 00 00 
    wakeup(&p->nwrite);
80103b33:	50                   	push   %eax
80103b34:	e8 47 0b 00 00       	call   80104680 <wakeup>
80103b39:	83 c4 10             	add    $0x10,%esp
80103b3c:	eb 99                	jmp    80103ad7 <pipeclose+0x37>
80103b3e:	66 90                	xchg   %ax,%ax

80103b40 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	57                   	push   %edi
80103b44:	56                   	push   %esi
80103b45:	53                   	push   %ebx
80103b46:	83 ec 28             	sub    $0x28,%esp
80103b49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103b4c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
80103b4f:	53                   	push   %ebx
80103b50:	e8 eb 0f 00 00       	call   80104b40 <acquire>
  for(i = 0; i < n; i++){
80103b55:	83 c4 10             	add    $0x10,%esp
80103b58:	85 ff                	test   %edi,%edi
80103b5a:	0f 8e ce 00 00 00    	jle    80103c2e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b60:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103b66:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103b69:	89 7d 10             	mov    %edi,0x10(%ebp)
80103b6c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b6f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103b72:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103b75:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b7b:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b81:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b87:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
80103b8d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103b90:	0f 85 b6 00 00 00    	jne    80103c4c <pipewrite+0x10c>
80103b96:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103b99:	eb 3b                	jmp    80103bd6 <pipewrite+0x96>
80103b9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103ba0:	e8 5b 03 00 00       	call   80103f00 <myproc>
80103ba5:	8b 48 24             	mov    0x24(%eax),%ecx
80103ba8:	85 c9                	test   %ecx,%ecx
80103baa:	75 34                	jne    80103be0 <pipewrite+0xa0>
      wakeup(&p->nread);
80103bac:	83 ec 0c             	sub    $0xc,%esp
80103baf:	56                   	push   %esi
80103bb0:	e8 cb 0a 00 00       	call   80104680 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103bb5:	58                   	pop    %eax
80103bb6:	5a                   	pop    %edx
80103bb7:	53                   	push   %ebx
80103bb8:	57                   	push   %edi
80103bb9:	e8 02 0a 00 00       	call   801045c0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103bbe:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103bc4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103bca:	83 c4 10             	add    $0x10,%esp
80103bcd:	05 00 02 00 00       	add    $0x200,%eax
80103bd2:	39 c2                	cmp    %eax,%edx
80103bd4:	75 2a                	jne    80103c00 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103bd6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103bdc:	85 c0                	test   %eax,%eax
80103bde:	75 c0                	jne    80103ba0 <pipewrite+0x60>
        release(&p->lock);
80103be0:	83 ec 0c             	sub    $0xc,%esp
80103be3:	53                   	push   %ebx
80103be4:	e8 f7 0e 00 00       	call   80104ae0 <release>
        return -1;
80103be9:	83 c4 10             	add    $0x10,%esp
80103bec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103bf1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bf4:	5b                   	pop    %ebx
80103bf5:	5e                   	pop    %esi
80103bf6:	5f                   	pop    %edi
80103bf7:	5d                   	pop    %ebp
80103bf8:	c3                   	ret
80103bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c00:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103c03:	8d 42 01             	lea    0x1(%edx),%eax
80103c06:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
80103c0c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103c0f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103c15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c18:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
80103c1c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103c20:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103c23:	39 c1                	cmp    %eax,%ecx
80103c25:	0f 85 50 ff ff ff    	jne    80103b7b <pipewrite+0x3b>
80103c2b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103c2e:	83 ec 0c             	sub    $0xc,%esp
80103c31:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103c37:	50                   	push   %eax
80103c38:	e8 43 0a 00 00       	call   80104680 <wakeup>
  release(&p->lock);
80103c3d:	89 1c 24             	mov    %ebx,(%esp)
80103c40:	e8 9b 0e 00 00       	call   80104ae0 <release>
  return n;
80103c45:	83 c4 10             	add    $0x10,%esp
80103c48:	89 f8                	mov    %edi,%eax
80103c4a:	eb a5                	jmp    80103bf1 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103c4c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c4f:	eb b2                	jmp    80103c03 <pipewrite+0xc3>
80103c51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c58:	00 
80103c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c60 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	57                   	push   %edi
80103c64:	56                   	push   %esi
80103c65:	53                   	push   %ebx
80103c66:	83 ec 18             	sub    $0x18,%esp
80103c69:	8b 75 08             	mov    0x8(%ebp),%esi
80103c6c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103c6f:	56                   	push   %esi
80103c70:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103c76:	e8 c5 0e 00 00       	call   80104b40 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103c7b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103c81:	83 c4 10             	add    $0x10,%esp
80103c84:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103c8a:	74 2f                	je     80103cbb <piperead+0x5b>
80103c8c:	eb 37                	jmp    80103cc5 <piperead+0x65>
80103c8e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103c90:	e8 6b 02 00 00       	call   80103f00 <myproc>
80103c95:	8b 40 24             	mov    0x24(%eax),%eax
80103c98:	85 c0                	test   %eax,%eax
80103c9a:	0f 85 80 00 00 00    	jne    80103d20 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103ca0:	83 ec 08             	sub    $0x8,%esp
80103ca3:	56                   	push   %esi
80103ca4:	53                   	push   %ebx
80103ca5:	e8 16 09 00 00       	call   801045c0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103caa:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103cb0:	83 c4 10             	add    $0x10,%esp
80103cb3:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103cb9:	75 0a                	jne    80103cc5 <piperead+0x65>
80103cbb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103cc1:	85 d2                	test   %edx,%edx
80103cc3:	75 cb                	jne    80103c90 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103cc5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103cc8:	31 db                	xor    %ebx,%ebx
80103cca:	85 c9                	test   %ecx,%ecx
80103ccc:	7f 26                	jg     80103cf4 <piperead+0x94>
80103cce:	eb 2c                	jmp    80103cfc <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103cd0:	8d 48 01             	lea    0x1(%eax),%ecx
80103cd3:	25 ff 01 00 00       	and    $0x1ff,%eax
80103cd8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103cde:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103ce3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103ce6:	83 c3 01             	add    $0x1,%ebx
80103ce9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103cec:	74 0e                	je     80103cfc <piperead+0x9c>
80103cee:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103cf4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103cfa:	75 d4                	jne    80103cd0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103cfc:	83 ec 0c             	sub    $0xc,%esp
80103cff:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103d05:	50                   	push   %eax
80103d06:	e8 75 09 00 00       	call   80104680 <wakeup>
  release(&p->lock);
80103d0b:	89 34 24             	mov    %esi,(%esp)
80103d0e:	e8 cd 0d 00 00       	call   80104ae0 <release>
  return i;
80103d13:	83 c4 10             	add    $0x10,%esp
}
80103d16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d19:	89 d8                	mov    %ebx,%eax
80103d1b:	5b                   	pop    %ebx
80103d1c:	5e                   	pop    %esi
80103d1d:	5f                   	pop    %edi
80103d1e:	5d                   	pop    %ebp
80103d1f:	c3                   	ret
      release(&p->lock);
80103d20:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103d23:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103d28:	56                   	push   %esi
80103d29:	e8 b2 0d 00 00       	call   80104ae0 <release>
      return -1;
80103d2e:	83 c4 10             	add    $0x10,%esp
}
80103d31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d34:	89 d8                	mov    %ebx,%eax
80103d36:	5b                   	pop    %ebx
80103d37:	5e                   	pop    %esi
80103d38:	5f                   	pop    %edi
80103d39:	5d                   	pop    %ebp
80103d3a:	c3                   	ret
80103d3b:	66 90                	xchg   %ax,%ax
80103d3d:	66 90                	xchg   %ax,%ax
80103d3f:	90                   	nop

80103d40 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d44:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
80103d49:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103d4c:	68 40 2d 11 80       	push   $0x80112d40
80103d51:	e8 ea 0d 00 00       	call   80104b40 <acquire>
80103d56:	83 c4 10             	add    $0x10,%esp
80103d59:	eb 10                	jmp    80103d6b <allocproc+0x2b>
80103d5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d60:	83 c3 7c             	add    $0x7c,%ebx
80103d63:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103d69:	74 75                	je     80103de0 <allocproc+0xa0>
    if(p->state == UNUSED)
80103d6b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103d6e:	85 c0                	test   %eax,%eax
80103d70:	75 ee                	jne    80103d60 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103d72:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103d77:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103d7a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103d81:	89 43 10             	mov    %eax,0x10(%ebx)
80103d84:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103d87:	68 40 2d 11 80       	push   $0x80112d40
  p->pid = nextpid++;
80103d8c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103d92:	e8 49 0d 00 00       	call   80104ae0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103d97:	e8 64 ee ff ff       	call   80102c00 <kalloc>
80103d9c:	83 c4 10             	add    $0x10,%esp
80103d9f:	89 43 08             	mov    %eax,0x8(%ebx)
80103da2:	85 c0                	test   %eax,%eax
80103da4:	74 53                	je     80103df9 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103da6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103dac:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103daf:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103db4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103db7:	c7 40 14 f2 5d 10 80 	movl   $0x80105df2,0x14(%eax)
  p->context = (struct context*)sp;
80103dbe:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103dc1:	6a 14                	push   $0x14
80103dc3:	6a 00                	push   $0x0
80103dc5:	50                   	push   %eax
80103dc6:	e8 75 0e 00 00       	call   80104c40 <memset>
  p->context->eip = (uint)forkret;
80103dcb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103dce:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103dd1:	c7 40 10 10 3e 10 80 	movl   $0x80103e10,0x10(%eax)
}
80103dd8:	89 d8                	mov    %ebx,%eax
80103dda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ddd:	c9                   	leave
80103dde:	c3                   	ret
80103ddf:	90                   	nop
  release(&ptable.lock);
80103de0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103de3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103de5:	68 40 2d 11 80       	push   $0x80112d40
80103dea:	e8 f1 0c 00 00       	call   80104ae0 <release>
  return 0;
80103def:	83 c4 10             	add    $0x10,%esp
}
80103df2:	89 d8                	mov    %ebx,%eax
80103df4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103df7:	c9                   	leave
80103df8:	c3                   	ret
    p->state = UNUSED;
80103df9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103e00:	31 db                	xor    %ebx,%ebx
80103e02:	eb ee                	jmp    80103df2 <allocproc+0xb2>
80103e04:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e0b:	00 
80103e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e10 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103e16:	68 40 2d 11 80       	push   $0x80112d40
80103e1b:	e8 c0 0c 00 00       	call   80104ae0 <release>

  if (first) {
80103e20:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103e25:	83 c4 10             	add    $0x10,%esp
80103e28:	85 c0                	test   %eax,%eax
80103e2a:	75 04                	jne    80103e30 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103e2c:	c9                   	leave
80103e2d:	c3                   	ret
80103e2e:	66 90                	xchg   %ax,%ax
    first = 0;
80103e30:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103e37:	00 00 00 
    iinit(ROOTDEV);
80103e3a:	83 ec 0c             	sub    $0xc,%esp
80103e3d:	6a 01                	push   $0x1
80103e3f:	e8 dc dc ff ff       	call   80101b20 <iinit>
    initlog(ROOTDEV);
80103e44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103e4b:	e8 f0 f3 ff ff       	call   80103240 <initlog>
}
80103e50:	83 c4 10             	add    $0x10,%esp
80103e53:	c9                   	leave
80103e54:	c3                   	ret
80103e55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e5c:	00 
80103e5d:	8d 76 00             	lea    0x0(%esi),%esi

80103e60 <pinit>:
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103e66:	68 56 79 10 80       	push   $0x80107956
80103e6b:	68 40 2d 11 80       	push   $0x80112d40
80103e70:	e8 db 0a 00 00       	call   80104950 <initlock>
}
80103e75:	83 c4 10             	add    $0x10,%esp
80103e78:	c9                   	leave
80103e79:	c3                   	ret
80103e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e80 <mycpu>:
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	56                   	push   %esi
80103e84:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e85:	9c                   	pushf
80103e86:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e87:	f6 c4 02             	test   $0x2,%ah
80103e8a:	75 46                	jne    80103ed2 <mycpu+0x52>
  apicid = lapicid();
80103e8c:	e8 df ef ff ff       	call   80102e70 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103e91:	8b 35 a4 27 11 80    	mov    0x801127a4,%esi
80103e97:	85 f6                	test   %esi,%esi
80103e99:	7e 2a                	jle    80103ec5 <mycpu+0x45>
80103e9b:	31 d2                	xor    %edx,%edx
80103e9d:	eb 08                	jmp    80103ea7 <mycpu+0x27>
80103e9f:	90                   	nop
80103ea0:	83 c2 01             	add    $0x1,%edx
80103ea3:	39 f2                	cmp    %esi,%edx
80103ea5:	74 1e                	je     80103ec5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103ea7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103ead:	0f b6 99 c0 27 11 80 	movzbl -0x7feed840(%ecx),%ebx
80103eb4:	39 c3                	cmp    %eax,%ebx
80103eb6:	75 e8                	jne    80103ea0 <mycpu+0x20>
}
80103eb8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103ebb:	8d 81 c0 27 11 80    	lea    -0x7feed840(%ecx),%eax
}
80103ec1:	5b                   	pop    %ebx
80103ec2:	5e                   	pop    %esi
80103ec3:	5d                   	pop    %ebp
80103ec4:	c3                   	ret
  panic("unknown apicid\n");
80103ec5:	83 ec 0c             	sub    $0xc,%esp
80103ec8:	68 5d 79 10 80       	push   $0x8010795d
80103ecd:	e8 ae c4 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103ed2:	83 ec 0c             	sub    $0xc,%esp
80103ed5:	68 14 7d 10 80       	push   $0x80107d14
80103eda:	e8 a1 c4 ff ff       	call   80100380 <panic>
80103edf:	90                   	nop

80103ee0 <cpuid>:
cpuid() {
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103ee6:	e8 95 ff ff ff       	call   80103e80 <mycpu>
}
80103eeb:	c9                   	leave
  return mycpu()-cpus;
80103eec:	2d c0 27 11 80       	sub    $0x801127c0,%eax
80103ef1:	c1 f8 04             	sar    $0x4,%eax
80103ef4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103efa:	c3                   	ret
80103efb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103f00 <myproc>:
myproc(void) {
80103f00:	55                   	push   %ebp
80103f01:	89 e5                	mov    %esp,%ebp
80103f03:	53                   	push   %ebx
80103f04:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103f07:	e8 e4 0a 00 00       	call   801049f0 <pushcli>
  c = mycpu();
80103f0c:	e8 6f ff ff ff       	call   80103e80 <mycpu>
  p = c->proc;
80103f11:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f17:	e8 24 0b 00 00       	call   80104a40 <popcli>
}
80103f1c:	89 d8                	mov    %ebx,%eax
80103f1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f21:	c9                   	leave
80103f22:	c3                   	ret
80103f23:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f2a:	00 
80103f2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103f30 <userinit>:
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	53                   	push   %ebx
80103f34:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103f37:	e8 04 fe ff ff       	call   80103d40 <allocproc>
80103f3c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103f3e:	a3 74 4c 11 80       	mov    %eax,0x80114c74
  if((p->pgdir = setupkvm()) == 0)
80103f43:	e8 78 34 00 00       	call   801073c0 <setupkvm>
80103f48:	89 43 04             	mov    %eax,0x4(%ebx)
80103f4b:	85 c0                	test   %eax,%eax
80103f4d:	0f 84 bd 00 00 00    	je     80104010 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103f53:	83 ec 04             	sub    $0x4,%esp
80103f56:	68 2c 00 00 00       	push   $0x2c
80103f5b:	68 60 b4 10 80       	push   $0x8010b460
80103f60:	50                   	push   %eax
80103f61:	e8 3a 31 00 00       	call   801070a0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103f66:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103f69:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103f6f:	6a 4c                	push   $0x4c
80103f71:	6a 00                	push   $0x0
80103f73:	ff 73 18             	push   0x18(%ebx)
80103f76:	e8 c5 0c 00 00       	call   80104c40 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f7b:	8b 43 18             	mov    0x18(%ebx),%eax
80103f7e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103f83:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f86:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f8b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f8f:	8b 43 18             	mov    0x18(%ebx),%eax
80103f92:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103f96:	8b 43 18             	mov    0x18(%ebx),%eax
80103f99:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f9d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103fa1:	8b 43 18             	mov    0x18(%ebx),%eax
80103fa4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103fa8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103fac:	8b 43 18             	mov    0x18(%ebx),%eax
80103faf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103fb6:	8b 43 18             	mov    0x18(%ebx),%eax
80103fb9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103fc0:	8b 43 18             	mov    0x18(%ebx),%eax
80103fc3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103fca:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103fcd:	6a 10                	push   $0x10
80103fcf:	68 86 79 10 80       	push   $0x80107986
80103fd4:	50                   	push   %eax
80103fd5:	e8 16 0e 00 00       	call   80104df0 <safestrcpy>
  p->cwd = namei("/");
80103fda:	c7 04 24 8f 79 10 80 	movl   $0x8010798f,(%esp)
80103fe1:	e8 3a e6 ff ff       	call   80102620 <namei>
80103fe6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103fe9:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103ff0:	e8 4b 0b 00 00       	call   80104b40 <acquire>
  p->state = RUNNABLE;
80103ff5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103ffc:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104003:	e8 d8 0a 00 00       	call   80104ae0 <release>
}
80104008:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010400b:	83 c4 10             	add    $0x10,%esp
8010400e:	c9                   	leave
8010400f:	c3                   	ret
    panic("userinit: out of memory?");
80104010:	83 ec 0c             	sub    $0xc,%esp
80104013:	68 6d 79 10 80       	push   $0x8010796d
80104018:	e8 63 c3 ff ff       	call   80100380 <panic>
8010401d:	8d 76 00             	lea    0x0(%esi),%esi

80104020 <growproc>:
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	56                   	push   %esi
80104024:	53                   	push   %ebx
80104025:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104028:	e8 c3 09 00 00       	call   801049f0 <pushcli>
  c = mycpu();
8010402d:	e8 4e fe ff ff       	call   80103e80 <mycpu>
  p = c->proc;
80104032:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104038:	e8 03 0a 00 00       	call   80104a40 <popcli>
  sz = curproc->sz;
8010403d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
8010403f:	85 f6                	test   %esi,%esi
80104041:	7f 1d                	jg     80104060 <growproc+0x40>
  } else if(n < 0){
80104043:	75 3b                	jne    80104080 <growproc+0x60>
  switchuvm(curproc);
80104045:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104048:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010404a:	53                   	push   %ebx
8010404b:	e8 40 2f 00 00       	call   80106f90 <switchuvm>
  return 0;
80104050:	83 c4 10             	add    $0x10,%esp
80104053:	31 c0                	xor    %eax,%eax
}
80104055:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104058:	5b                   	pop    %ebx
80104059:	5e                   	pop    %esi
8010405a:	5d                   	pop    %ebp
8010405b:	c3                   	ret
8010405c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104060:	83 ec 04             	sub    $0x4,%esp
80104063:	01 c6                	add    %eax,%esi
80104065:	56                   	push   %esi
80104066:	50                   	push   %eax
80104067:	ff 73 04             	push   0x4(%ebx)
8010406a:	e8 81 31 00 00       	call   801071f0 <allocuvm>
8010406f:	83 c4 10             	add    $0x10,%esp
80104072:	85 c0                	test   %eax,%eax
80104074:	75 cf                	jne    80104045 <growproc+0x25>
      return -1;
80104076:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010407b:	eb d8                	jmp    80104055 <growproc+0x35>
8010407d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104080:	83 ec 04             	sub    $0x4,%esp
80104083:	01 c6                	add    %eax,%esi
80104085:	56                   	push   %esi
80104086:	50                   	push   %eax
80104087:	ff 73 04             	push   0x4(%ebx)
8010408a:	e8 81 32 00 00       	call   80107310 <deallocuvm>
8010408f:	83 c4 10             	add    $0x10,%esp
80104092:	85 c0                	test   %eax,%eax
80104094:	75 af                	jne    80104045 <growproc+0x25>
80104096:	eb de                	jmp    80104076 <growproc+0x56>
80104098:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010409f:	00 

801040a0 <fork>:
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	57                   	push   %edi
801040a4:	56                   	push   %esi
801040a5:	53                   	push   %ebx
801040a6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801040a9:	e8 42 09 00 00       	call   801049f0 <pushcli>
  c = mycpu();
801040ae:	e8 cd fd ff ff       	call   80103e80 <mycpu>
  p = c->proc;
801040b3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040b9:	e8 82 09 00 00       	call   80104a40 <popcli>
  if((np = allocproc()) == 0){
801040be:	e8 7d fc ff ff       	call   80103d40 <allocproc>
801040c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801040c6:	85 c0                	test   %eax,%eax
801040c8:	0f 84 d6 00 00 00    	je     801041a4 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801040ce:	83 ec 08             	sub    $0x8,%esp
801040d1:	ff 33                	push   (%ebx)
801040d3:	89 c7                	mov    %eax,%edi
801040d5:	ff 73 04             	push   0x4(%ebx)
801040d8:	e8 d3 33 00 00       	call   801074b0 <copyuvm>
801040dd:	83 c4 10             	add    $0x10,%esp
801040e0:	89 47 04             	mov    %eax,0x4(%edi)
801040e3:	85 c0                	test   %eax,%eax
801040e5:	0f 84 9a 00 00 00    	je     80104185 <fork+0xe5>
  np->sz = curproc->sz;
801040eb:	8b 03                	mov    (%ebx),%eax
801040ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801040f0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
801040f2:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
801040f5:	89 c8                	mov    %ecx,%eax
801040f7:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
801040fa:	b9 13 00 00 00       	mov    $0x13,%ecx
801040ff:	8b 73 18             	mov    0x18(%ebx),%esi
80104102:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104104:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104106:	8b 40 18             	mov    0x18(%eax),%eax
80104109:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104110:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104114:	85 c0                	test   %eax,%eax
80104116:	74 13                	je     8010412b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104118:	83 ec 0c             	sub    $0xc,%esp
8010411b:	50                   	push   %eax
8010411c:	e8 3f d3 ff ff       	call   80101460 <filedup>
80104121:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104124:	83 c4 10             	add    $0x10,%esp
80104127:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
8010412b:	83 c6 01             	add    $0x1,%esi
8010412e:	83 fe 10             	cmp    $0x10,%esi
80104131:	75 dd                	jne    80104110 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104133:	83 ec 0c             	sub    $0xc,%esp
80104136:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104139:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010413c:	e8 cf db ff ff       	call   80101d10 <idup>
80104141:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104144:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104147:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010414a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010414d:	6a 10                	push   $0x10
8010414f:	53                   	push   %ebx
80104150:	50                   	push   %eax
80104151:	e8 9a 0c 00 00       	call   80104df0 <safestrcpy>
  pid = np->pid;
80104156:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104159:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104160:	e8 db 09 00 00       	call   80104b40 <acquire>
  np->state = RUNNABLE;
80104165:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010416c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104173:	e8 68 09 00 00       	call   80104ae0 <release>
  return pid;
80104178:	83 c4 10             	add    $0x10,%esp
}
8010417b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010417e:	89 d8                	mov    %ebx,%eax
80104180:	5b                   	pop    %ebx
80104181:	5e                   	pop    %esi
80104182:	5f                   	pop    %edi
80104183:	5d                   	pop    %ebp
80104184:	c3                   	ret
    kfree(np->kstack);
80104185:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104188:	83 ec 0c             	sub    $0xc,%esp
8010418b:	ff 73 08             	push   0x8(%ebx)
8010418e:	e8 ad e8 ff ff       	call   80102a40 <kfree>
    np->kstack = 0;
80104193:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
8010419a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
8010419d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801041a4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801041a9:	eb d0                	jmp    8010417b <fork+0xdb>
801041ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801041b0 <scheduler>:
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	57                   	push   %edi
801041b4:	56                   	push   %esi
801041b5:	53                   	push   %ebx
801041b6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801041b9:	e8 c2 fc ff ff       	call   80103e80 <mycpu>
  c->proc = 0;
801041be:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801041c5:	00 00 00 
  struct cpu *c = mycpu();
801041c8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801041ca:	8d 78 04             	lea    0x4(%eax),%edi
801041cd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
801041d0:	fb                   	sti
    acquire(&ptable.lock);
801041d1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041d4:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
    acquire(&ptable.lock);
801041d9:	68 40 2d 11 80       	push   $0x80112d40
801041de:	e8 5d 09 00 00       	call   80104b40 <acquire>
801041e3:	83 c4 10             	add    $0x10,%esp
801041e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041ed:	00 
801041ee:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
801041f0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801041f4:	75 33                	jne    80104229 <scheduler+0x79>
      switchuvm(p);
801041f6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
801041f9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801041ff:	53                   	push   %ebx
80104200:	e8 8b 2d 00 00       	call   80106f90 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104205:	58                   	pop    %eax
80104206:	5a                   	pop    %edx
80104207:	ff 73 1c             	push   0x1c(%ebx)
8010420a:	57                   	push   %edi
      p->state = RUNNING;
8010420b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104212:	e8 34 0c 00 00       	call   80104e4b <swtch>
      switchkvm();
80104217:	e8 64 2d 00 00       	call   80106f80 <switchkvm>
      c->proc = 0;
8010421c:	83 c4 10             	add    $0x10,%esp
8010421f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104226:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104229:	83 c3 7c             	add    $0x7c,%ebx
8010422c:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104232:	75 bc                	jne    801041f0 <scheduler+0x40>
    release(&ptable.lock);
80104234:	83 ec 0c             	sub    $0xc,%esp
80104237:	68 40 2d 11 80       	push   $0x80112d40
8010423c:	e8 9f 08 00 00       	call   80104ae0 <release>
    sti();
80104241:	83 c4 10             	add    $0x10,%esp
80104244:	eb 8a                	jmp    801041d0 <scheduler+0x20>
80104246:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010424d:	00 
8010424e:	66 90                	xchg   %ax,%ax

80104250 <sched>:
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	56                   	push   %esi
80104254:	53                   	push   %ebx
  pushcli();
80104255:	e8 96 07 00 00       	call   801049f0 <pushcli>
  c = mycpu();
8010425a:	e8 21 fc ff ff       	call   80103e80 <mycpu>
  p = c->proc;
8010425f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104265:	e8 d6 07 00 00       	call   80104a40 <popcli>
  if(!holding(&ptable.lock))
8010426a:	83 ec 0c             	sub    $0xc,%esp
8010426d:	68 40 2d 11 80       	push   $0x80112d40
80104272:	e8 29 08 00 00       	call   80104aa0 <holding>
80104277:	83 c4 10             	add    $0x10,%esp
8010427a:	85 c0                	test   %eax,%eax
8010427c:	74 4f                	je     801042cd <sched+0x7d>
  if(mycpu()->ncli != 1)
8010427e:	e8 fd fb ff ff       	call   80103e80 <mycpu>
80104283:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010428a:	75 68                	jne    801042f4 <sched+0xa4>
  if(p->state == RUNNING)
8010428c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104290:	74 55                	je     801042e7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104292:	9c                   	pushf
80104293:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104294:	f6 c4 02             	test   $0x2,%ah
80104297:	75 41                	jne    801042da <sched+0x8a>
  intena = mycpu()->intena;
80104299:	e8 e2 fb ff ff       	call   80103e80 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010429e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801042a1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801042a7:	e8 d4 fb ff ff       	call   80103e80 <mycpu>
801042ac:	83 ec 08             	sub    $0x8,%esp
801042af:	ff 70 04             	push   0x4(%eax)
801042b2:	53                   	push   %ebx
801042b3:	e8 93 0b 00 00       	call   80104e4b <swtch>
  mycpu()->intena = intena;
801042b8:	e8 c3 fb ff ff       	call   80103e80 <mycpu>
}
801042bd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801042c0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801042c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042c9:	5b                   	pop    %ebx
801042ca:	5e                   	pop    %esi
801042cb:	5d                   	pop    %ebp
801042cc:	c3                   	ret
    panic("sched ptable.lock");
801042cd:	83 ec 0c             	sub    $0xc,%esp
801042d0:	68 91 79 10 80       	push   $0x80107991
801042d5:	e8 a6 c0 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
801042da:	83 ec 0c             	sub    $0xc,%esp
801042dd:	68 bd 79 10 80       	push   $0x801079bd
801042e2:	e8 99 c0 ff ff       	call   80100380 <panic>
    panic("sched running");
801042e7:	83 ec 0c             	sub    $0xc,%esp
801042ea:	68 af 79 10 80       	push   $0x801079af
801042ef:	e8 8c c0 ff ff       	call   80100380 <panic>
    panic("sched locks");
801042f4:	83 ec 0c             	sub    $0xc,%esp
801042f7:	68 a3 79 10 80       	push   $0x801079a3
801042fc:	e8 7f c0 ff ff       	call   80100380 <panic>
80104301:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104308:	00 
80104309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104310 <exit>:
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	57                   	push   %edi
80104314:	56                   	push   %esi
80104315:	53                   	push   %ebx
80104316:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104319:	e8 e2 fb ff ff       	call   80103f00 <myproc>
  if(curproc == initproc)
8010431e:	39 05 74 4c 11 80    	cmp    %eax,0x80114c74
80104324:	0f 84 fd 00 00 00    	je     80104427 <exit+0x117>
8010432a:	89 c3                	mov    %eax,%ebx
8010432c:	8d 70 28             	lea    0x28(%eax),%esi
8010432f:	8d 78 68             	lea    0x68(%eax),%edi
80104332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104338:	8b 06                	mov    (%esi),%eax
8010433a:	85 c0                	test   %eax,%eax
8010433c:	74 12                	je     80104350 <exit+0x40>
      fileclose(curproc->ofile[fd]);
8010433e:	83 ec 0c             	sub    $0xc,%esp
80104341:	50                   	push   %eax
80104342:	e8 69 d1 ff ff       	call   801014b0 <fileclose>
      curproc->ofile[fd] = 0;
80104347:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010434d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104350:	83 c6 04             	add    $0x4,%esi
80104353:	39 f7                	cmp    %esi,%edi
80104355:	75 e1                	jne    80104338 <exit+0x28>
  begin_op();
80104357:	e8 84 ef ff ff       	call   801032e0 <begin_op>
  iput(curproc->cwd);
8010435c:	83 ec 0c             	sub    $0xc,%esp
8010435f:	ff 73 68             	push   0x68(%ebx)
80104362:	e8 09 db ff ff       	call   80101e70 <iput>
  end_op();
80104367:	e8 e4 ef ff ff       	call   80103350 <end_op>
  curproc->cwd = 0;
8010436c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104373:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010437a:	e8 c1 07 00 00       	call   80104b40 <acquire>
  wakeup1(curproc->parent);
8010437f:	8b 53 14             	mov    0x14(%ebx),%edx
80104382:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104385:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010438a:	eb 0e                	jmp    8010439a <exit+0x8a>
8010438c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104390:	83 c0 7c             	add    $0x7c,%eax
80104393:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104398:	74 1c                	je     801043b6 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
8010439a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010439e:	75 f0                	jne    80104390 <exit+0x80>
801043a0:	3b 50 20             	cmp    0x20(%eax),%edx
801043a3:	75 eb                	jne    80104390 <exit+0x80>
      p->state = RUNNABLE;
801043a5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043ac:	83 c0 7c             	add    $0x7c,%eax
801043af:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801043b4:	75 e4                	jne    8010439a <exit+0x8a>
      p->parent = initproc;
801043b6:	8b 0d 74 4c 11 80    	mov    0x80114c74,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043bc:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
801043c1:	eb 10                	jmp    801043d3 <exit+0xc3>
801043c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801043c8:	83 c2 7c             	add    $0x7c,%edx
801043cb:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
801043d1:	74 3b                	je     8010440e <exit+0xfe>
    if(p->parent == curproc){
801043d3:	39 5a 14             	cmp    %ebx,0x14(%edx)
801043d6:	75 f0                	jne    801043c8 <exit+0xb8>
      if(p->state == ZOMBIE)
801043d8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801043dc:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801043df:	75 e7                	jne    801043c8 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043e1:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801043e6:	eb 12                	jmp    801043fa <exit+0xea>
801043e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043ef:	00 
801043f0:	83 c0 7c             	add    $0x7c,%eax
801043f3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801043f8:	74 ce                	je     801043c8 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
801043fa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801043fe:	75 f0                	jne    801043f0 <exit+0xe0>
80104400:	3b 48 20             	cmp    0x20(%eax),%ecx
80104403:	75 eb                	jne    801043f0 <exit+0xe0>
      p->state = RUNNABLE;
80104405:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010440c:	eb e2                	jmp    801043f0 <exit+0xe0>
  curproc->state = ZOMBIE;
8010440e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104415:	e8 36 fe ff ff       	call   80104250 <sched>
  panic("zombie exit");
8010441a:	83 ec 0c             	sub    $0xc,%esp
8010441d:	68 de 79 10 80       	push   $0x801079de
80104422:	e8 59 bf ff ff       	call   80100380 <panic>
    panic("init exiting");
80104427:	83 ec 0c             	sub    $0xc,%esp
8010442a:	68 d1 79 10 80       	push   $0x801079d1
8010442f:	e8 4c bf ff ff       	call   80100380 <panic>
80104434:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010443b:	00 
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104440 <wait>:
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	56                   	push   %esi
80104444:	53                   	push   %ebx
  pushcli();
80104445:	e8 a6 05 00 00       	call   801049f0 <pushcli>
  c = mycpu();
8010444a:	e8 31 fa ff ff       	call   80103e80 <mycpu>
  p = c->proc;
8010444f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104455:	e8 e6 05 00 00       	call   80104a40 <popcli>
  acquire(&ptable.lock);
8010445a:	83 ec 0c             	sub    $0xc,%esp
8010445d:	68 40 2d 11 80       	push   $0x80112d40
80104462:	e8 d9 06 00 00       	call   80104b40 <acquire>
80104467:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010446a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010446c:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104471:	eb 10                	jmp    80104483 <wait+0x43>
80104473:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104478:	83 c3 7c             	add    $0x7c,%ebx
8010447b:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104481:	74 1b                	je     8010449e <wait+0x5e>
      if(p->parent != curproc)
80104483:	39 73 14             	cmp    %esi,0x14(%ebx)
80104486:	75 f0                	jne    80104478 <wait+0x38>
      if(p->state == ZOMBIE){
80104488:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010448c:	74 62                	je     801044f0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010448e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104491:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104496:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
8010449c:	75 e5                	jne    80104483 <wait+0x43>
    if(!havekids || curproc->killed){
8010449e:	85 c0                	test   %eax,%eax
801044a0:	0f 84 a0 00 00 00    	je     80104546 <wait+0x106>
801044a6:	8b 46 24             	mov    0x24(%esi),%eax
801044a9:	85 c0                	test   %eax,%eax
801044ab:	0f 85 95 00 00 00    	jne    80104546 <wait+0x106>
  pushcli();
801044b1:	e8 3a 05 00 00       	call   801049f0 <pushcli>
  c = mycpu();
801044b6:	e8 c5 f9 ff ff       	call   80103e80 <mycpu>
  p = c->proc;
801044bb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801044c1:	e8 7a 05 00 00       	call   80104a40 <popcli>
  if(p == 0)
801044c6:	85 db                	test   %ebx,%ebx
801044c8:	0f 84 8f 00 00 00    	je     8010455d <wait+0x11d>
  p->chan = chan;
801044ce:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
801044d1:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801044d8:	e8 73 fd ff ff       	call   80104250 <sched>
  p->chan = 0;
801044dd:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801044e4:	eb 84                	jmp    8010446a <wait+0x2a>
801044e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044ed:	00 
801044ee:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
801044f0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801044f3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801044f6:	ff 73 08             	push   0x8(%ebx)
801044f9:	e8 42 e5 ff ff       	call   80102a40 <kfree>
        p->kstack = 0;
801044fe:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104505:	5a                   	pop    %edx
80104506:	ff 73 04             	push   0x4(%ebx)
80104509:	e8 32 2e 00 00       	call   80107340 <freevm>
        p->pid = 0;
8010450e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104515:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010451c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104520:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104527:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010452e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104535:	e8 a6 05 00 00       	call   80104ae0 <release>
        return pid;
8010453a:	83 c4 10             	add    $0x10,%esp
}
8010453d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104540:	89 f0                	mov    %esi,%eax
80104542:	5b                   	pop    %ebx
80104543:	5e                   	pop    %esi
80104544:	5d                   	pop    %ebp
80104545:	c3                   	ret
      release(&ptable.lock);
80104546:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104549:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010454e:	68 40 2d 11 80       	push   $0x80112d40
80104553:	e8 88 05 00 00       	call   80104ae0 <release>
      return -1;
80104558:	83 c4 10             	add    $0x10,%esp
8010455b:	eb e0                	jmp    8010453d <wait+0xfd>
    panic("sleep");
8010455d:	83 ec 0c             	sub    $0xc,%esp
80104560:	68 ea 79 10 80       	push   $0x801079ea
80104565:	e8 16 be ff ff       	call   80100380 <panic>
8010456a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104570 <yield>:
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	53                   	push   %ebx
80104574:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104577:	68 40 2d 11 80       	push   $0x80112d40
8010457c:	e8 bf 05 00 00       	call   80104b40 <acquire>
  pushcli();
80104581:	e8 6a 04 00 00       	call   801049f0 <pushcli>
  c = mycpu();
80104586:	e8 f5 f8 ff ff       	call   80103e80 <mycpu>
  p = c->proc;
8010458b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104591:	e8 aa 04 00 00       	call   80104a40 <popcli>
  myproc()->state = RUNNABLE;
80104596:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010459d:	e8 ae fc ff ff       	call   80104250 <sched>
  release(&ptable.lock);
801045a2:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801045a9:	e8 32 05 00 00       	call   80104ae0 <release>
}
801045ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045b1:	83 c4 10             	add    $0x10,%esp
801045b4:	c9                   	leave
801045b5:	c3                   	ret
801045b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045bd:	00 
801045be:	66 90                	xchg   %ax,%ax

801045c0 <sleep>:
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	57                   	push   %edi
801045c4:	56                   	push   %esi
801045c5:	53                   	push   %ebx
801045c6:	83 ec 0c             	sub    $0xc,%esp
801045c9:	8b 7d 08             	mov    0x8(%ebp),%edi
801045cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801045cf:	e8 1c 04 00 00       	call   801049f0 <pushcli>
  c = mycpu();
801045d4:	e8 a7 f8 ff ff       	call   80103e80 <mycpu>
  p = c->proc;
801045d9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045df:	e8 5c 04 00 00       	call   80104a40 <popcli>
  if(p == 0)
801045e4:	85 db                	test   %ebx,%ebx
801045e6:	0f 84 87 00 00 00    	je     80104673 <sleep+0xb3>
  if(lk == 0)
801045ec:	85 f6                	test   %esi,%esi
801045ee:	74 76                	je     80104666 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801045f0:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
801045f6:	74 50                	je     80104648 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801045f8:	83 ec 0c             	sub    $0xc,%esp
801045fb:	68 40 2d 11 80       	push   $0x80112d40
80104600:	e8 3b 05 00 00       	call   80104b40 <acquire>
    release(lk);
80104605:	89 34 24             	mov    %esi,(%esp)
80104608:	e8 d3 04 00 00       	call   80104ae0 <release>
  p->chan = chan;
8010460d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104610:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104617:	e8 34 fc ff ff       	call   80104250 <sched>
  p->chan = 0;
8010461c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104623:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010462a:	e8 b1 04 00 00       	call   80104ae0 <release>
    acquire(lk);
8010462f:	83 c4 10             	add    $0x10,%esp
80104632:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104638:	5b                   	pop    %ebx
80104639:	5e                   	pop    %esi
8010463a:	5f                   	pop    %edi
8010463b:	5d                   	pop    %ebp
    acquire(lk);
8010463c:	e9 ff 04 00 00       	jmp    80104b40 <acquire>
80104641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104648:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010464b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104652:	e8 f9 fb ff ff       	call   80104250 <sched>
  p->chan = 0;
80104657:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010465e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104661:	5b                   	pop    %ebx
80104662:	5e                   	pop    %esi
80104663:	5f                   	pop    %edi
80104664:	5d                   	pop    %ebp
80104665:	c3                   	ret
    panic("sleep without lk");
80104666:	83 ec 0c             	sub    $0xc,%esp
80104669:	68 f0 79 10 80       	push   $0x801079f0
8010466e:	e8 0d bd ff ff       	call   80100380 <panic>
    panic("sleep");
80104673:	83 ec 0c             	sub    $0xc,%esp
80104676:	68 ea 79 10 80       	push   $0x801079ea
8010467b:	e8 00 bd ff ff       	call   80100380 <panic>

80104680 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	53                   	push   %ebx
80104684:	83 ec 10             	sub    $0x10,%esp
80104687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010468a:	68 40 2d 11 80       	push   $0x80112d40
8010468f:	e8 ac 04 00 00       	call   80104b40 <acquire>
80104694:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104697:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010469c:	eb 0c                	jmp    801046aa <wakeup+0x2a>
8010469e:	66 90                	xchg   %ax,%ax
801046a0:	83 c0 7c             	add    $0x7c,%eax
801046a3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801046a8:	74 1c                	je     801046c6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801046aa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801046ae:	75 f0                	jne    801046a0 <wakeup+0x20>
801046b0:	3b 58 20             	cmp    0x20(%eax),%ebx
801046b3:	75 eb                	jne    801046a0 <wakeup+0x20>
      p->state = RUNNABLE;
801046b5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046bc:	83 c0 7c             	add    $0x7c,%eax
801046bf:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801046c4:	75 e4                	jne    801046aa <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
801046c6:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
801046cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046d0:	c9                   	leave
  release(&ptable.lock);
801046d1:	e9 0a 04 00 00       	jmp    80104ae0 <release>
801046d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046dd:	00 
801046de:	66 90                	xchg   %ax,%ax

801046e0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	53                   	push   %ebx
801046e4:	83 ec 10             	sub    $0x10,%esp
801046e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801046ea:	68 40 2d 11 80       	push   $0x80112d40
801046ef:	e8 4c 04 00 00       	call   80104b40 <acquire>
801046f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046f7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801046fc:	eb 0c                	jmp    8010470a <kill+0x2a>
801046fe:	66 90                	xchg   %ax,%ax
80104700:	83 c0 7c             	add    $0x7c,%eax
80104703:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104708:	74 36                	je     80104740 <kill+0x60>
    if(p->pid == pid){
8010470a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010470d:	75 f1                	jne    80104700 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010470f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104713:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010471a:	75 07                	jne    80104723 <kill+0x43>
        p->state = RUNNABLE;
8010471c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104723:	83 ec 0c             	sub    $0xc,%esp
80104726:	68 40 2d 11 80       	push   $0x80112d40
8010472b:	e8 b0 03 00 00       	call   80104ae0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104730:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104733:	83 c4 10             	add    $0x10,%esp
80104736:	31 c0                	xor    %eax,%eax
}
80104738:	c9                   	leave
80104739:	c3                   	ret
8010473a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104740:	83 ec 0c             	sub    $0xc,%esp
80104743:	68 40 2d 11 80       	push   $0x80112d40
80104748:	e8 93 03 00 00       	call   80104ae0 <release>
}
8010474d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104750:	83 c4 10             	add    $0x10,%esp
80104753:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104758:	c9                   	leave
80104759:	c3                   	ret
8010475a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104760 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	57                   	push   %edi
80104764:	56                   	push   %esi
80104765:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104768:	53                   	push   %ebx
80104769:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
8010476e:	83 ec 3c             	sub    $0x3c,%esp
80104771:	eb 24                	jmp    80104797 <procdump+0x37>
80104773:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104778:	83 ec 0c             	sub    $0xc,%esp
8010477b:	68 af 7b 10 80       	push   $0x80107baf
80104780:	e8 db be ff ff       	call   80100660 <cprintf>
80104785:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104788:	83 c3 7c             	add    $0x7c,%ebx
8010478b:	81 fb e0 4c 11 80    	cmp    $0x80114ce0,%ebx
80104791:	0f 84 81 00 00 00    	je     80104818 <procdump+0xb8>
    if(p->state == UNUSED)
80104797:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010479a:	85 c0                	test   %eax,%eax
8010479c:	74 ea                	je     80104788 <procdump+0x28>
      state = "???";
8010479e:	ba 01 7a 10 80       	mov    $0x80107a01,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801047a3:	83 f8 05             	cmp    $0x5,%eax
801047a6:	77 11                	ja     801047b9 <procdump+0x59>
801047a8:	8b 14 85 20 80 10 80 	mov    -0x7fef7fe0(,%eax,4),%edx
      state = "???";
801047af:	b8 01 7a 10 80       	mov    $0x80107a01,%eax
801047b4:	85 d2                	test   %edx,%edx
801047b6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801047b9:	53                   	push   %ebx
801047ba:	52                   	push   %edx
801047bb:	ff 73 a4             	push   -0x5c(%ebx)
801047be:	68 05 7a 10 80       	push   $0x80107a05
801047c3:	e8 98 be ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801047c8:	83 c4 10             	add    $0x10,%esp
801047cb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801047cf:	75 a7                	jne    80104778 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801047d1:	83 ec 08             	sub    $0x8,%esp
801047d4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801047d7:	8d 7d c0             	lea    -0x40(%ebp),%edi
801047da:	50                   	push   %eax
801047db:	8b 43 b0             	mov    -0x50(%ebx),%eax
801047de:	8b 40 0c             	mov    0xc(%eax),%eax
801047e1:	83 c0 08             	add    $0x8,%eax
801047e4:	50                   	push   %eax
801047e5:	e8 86 01 00 00       	call   80104970 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801047ea:	83 c4 10             	add    $0x10,%esp
801047ed:	8d 76 00             	lea    0x0(%esi),%esi
801047f0:	8b 17                	mov    (%edi),%edx
801047f2:	85 d2                	test   %edx,%edx
801047f4:	74 82                	je     80104778 <procdump+0x18>
        cprintf(" %p", pc[i]);
801047f6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801047f9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801047fc:	52                   	push   %edx
801047fd:	68 41 77 10 80       	push   $0x80107741
80104802:	e8 59 be ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104807:	83 c4 10             	add    $0x10,%esp
8010480a:	39 f7                	cmp    %esi,%edi
8010480c:	75 e2                	jne    801047f0 <procdump+0x90>
8010480e:	e9 65 ff ff ff       	jmp    80104778 <procdump+0x18>
80104813:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104818:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010481b:	5b                   	pop    %ebx
8010481c:	5e                   	pop    %esi
8010481d:	5f                   	pop    %edi
8010481e:	5d                   	pop    %ebp
8010481f:	c3                   	ret

80104820 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	53                   	push   %ebx
80104824:	83 ec 0c             	sub    $0xc,%esp
80104827:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010482a:	68 38 7a 10 80       	push   $0x80107a38
8010482f:	8d 43 04             	lea    0x4(%ebx),%eax
80104832:	50                   	push   %eax
80104833:	e8 18 01 00 00       	call   80104950 <initlock>
  lk->name = name;
80104838:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010483b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104841:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104844:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010484b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010484e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104851:	c9                   	leave
80104852:	c3                   	ret
80104853:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010485a:	00 
8010485b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104860 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	56                   	push   %esi
80104864:	53                   	push   %ebx
80104865:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104868:	8d 73 04             	lea    0x4(%ebx),%esi
8010486b:	83 ec 0c             	sub    $0xc,%esp
8010486e:	56                   	push   %esi
8010486f:	e8 cc 02 00 00       	call   80104b40 <acquire>
  while (lk->locked) {
80104874:	8b 13                	mov    (%ebx),%edx
80104876:	83 c4 10             	add    $0x10,%esp
80104879:	85 d2                	test   %edx,%edx
8010487b:	74 16                	je     80104893 <acquiresleep+0x33>
8010487d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104880:	83 ec 08             	sub    $0x8,%esp
80104883:	56                   	push   %esi
80104884:	53                   	push   %ebx
80104885:	e8 36 fd ff ff       	call   801045c0 <sleep>
  while (lk->locked) {
8010488a:	8b 03                	mov    (%ebx),%eax
8010488c:	83 c4 10             	add    $0x10,%esp
8010488f:	85 c0                	test   %eax,%eax
80104891:	75 ed                	jne    80104880 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104893:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104899:	e8 62 f6 ff ff       	call   80103f00 <myproc>
8010489e:	8b 40 10             	mov    0x10(%eax),%eax
801048a1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801048a4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801048a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048aa:	5b                   	pop    %ebx
801048ab:	5e                   	pop    %esi
801048ac:	5d                   	pop    %ebp
  release(&lk->lk);
801048ad:	e9 2e 02 00 00       	jmp    80104ae0 <release>
801048b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048b9:	00 
801048ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801048c0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	56                   	push   %esi
801048c4:	53                   	push   %ebx
801048c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801048c8:	8d 73 04             	lea    0x4(%ebx),%esi
801048cb:	83 ec 0c             	sub    $0xc,%esp
801048ce:	56                   	push   %esi
801048cf:	e8 6c 02 00 00       	call   80104b40 <acquire>
  lk->locked = 0;
801048d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801048da:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801048e1:	89 1c 24             	mov    %ebx,(%esp)
801048e4:	e8 97 fd ff ff       	call   80104680 <wakeup>
  release(&lk->lk);
801048e9:	83 c4 10             	add    $0x10,%esp
801048ec:	89 75 08             	mov    %esi,0x8(%ebp)
}
801048ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048f2:	5b                   	pop    %ebx
801048f3:	5e                   	pop    %esi
801048f4:	5d                   	pop    %ebp
  release(&lk->lk);
801048f5:	e9 e6 01 00 00       	jmp    80104ae0 <release>
801048fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104900 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	57                   	push   %edi
80104904:	31 ff                	xor    %edi,%edi
80104906:	56                   	push   %esi
80104907:	53                   	push   %ebx
80104908:	83 ec 18             	sub    $0x18,%esp
8010490b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010490e:	8d 73 04             	lea    0x4(%ebx),%esi
80104911:	56                   	push   %esi
80104912:	e8 29 02 00 00       	call   80104b40 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104917:	8b 03                	mov    (%ebx),%eax
80104919:	83 c4 10             	add    $0x10,%esp
8010491c:	85 c0                	test   %eax,%eax
8010491e:	75 18                	jne    80104938 <holdingsleep+0x38>
  release(&lk->lk);
80104920:	83 ec 0c             	sub    $0xc,%esp
80104923:	56                   	push   %esi
80104924:	e8 b7 01 00 00       	call   80104ae0 <release>
  return r;
}
80104929:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010492c:	89 f8                	mov    %edi,%eax
8010492e:	5b                   	pop    %ebx
8010492f:	5e                   	pop    %esi
80104930:	5f                   	pop    %edi
80104931:	5d                   	pop    %ebp
80104932:	c3                   	ret
80104933:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104938:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010493b:	e8 c0 f5 ff ff       	call   80103f00 <myproc>
80104940:	39 58 10             	cmp    %ebx,0x10(%eax)
80104943:	0f 94 c0             	sete   %al
80104946:	0f b6 c0             	movzbl %al,%eax
80104949:	89 c7                	mov    %eax,%edi
8010494b:	eb d3                	jmp    80104920 <holdingsleep+0x20>
8010494d:	66 90                	xchg   %ax,%ax
8010494f:	90                   	nop

80104950 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104956:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104959:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010495f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104962:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104969:	5d                   	pop    %ebp
8010496a:	c3                   	ret
8010496b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104970 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	53                   	push   %ebx
80104974:	8b 45 08             	mov    0x8(%ebp),%eax
80104977:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010497a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010497d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104982:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104987:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010498c:	76 10                	jbe    8010499e <getcallerpcs+0x2e>
8010498e:	eb 28                	jmp    801049b8 <getcallerpcs+0x48>
80104990:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104996:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010499c:	77 1a                	ja     801049b8 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010499e:	8b 5a 04             	mov    0x4(%edx),%ebx
801049a1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801049a4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801049a7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801049a9:	83 f8 0a             	cmp    $0xa,%eax
801049ac:	75 e2                	jne    80104990 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801049ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049b1:	c9                   	leave
801049b2:	c3                   	ret
801049b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801049b8:	8d 04 81             	lea    (%ecx,%eax,4),%eax
801049bb:	83 c1 28             	add    $0x28,%ecx
801049be:	89 ca                	mov    %ecx,%edx
801049c0:	29 c2                	sub    %eax,%edx
801049c2:	83 e2 04             	and    $0x4,%edx
801049c5:	74 11                	je     801049d8 <getcallerpcs+0x68>
    pcs[i] = 0;
801049c7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801049cd:	83 c0 04             	add    $0x4,%eax
801049d0:	39 c1                	cmp    %eax,%ecx
801049d2:	74 da                	je     801049ae <getcallerpcs+0x3e>
801049d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
801049d8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801049de:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
801049e1:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801049e8:	39 c1                	cmp    %eax,%ecx
801049ea:	75 ec                	jne    801049d8 <getcallerpcs+0x68>
801049ec:	eb c0                	jmp    801049ae <getcallerpcs+0x3e>
801049ee:	66 90                	xchg   %ax,%ax

801049f0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	53                   	push   %ebx
801049f4:	83 ec 04             	sub    $0x4,%esp
801049f7:	9c                   	pushf
801049f8:	5b                   	pop    %ebx
  asm volatile("cli");
801049f9:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801049fa:	e8 81 f4 ff ff       	call   80103e80 <mycpu>
801049ff:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104a05:	85 c0                	test   %eax,%eax
80104a07:	74 17                	je     80104a20 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104a09:	e8 72 f4 ff ff       	call   80103e80 <mycpu>
80104a0e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104a15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a18:	c9                   	leave
80104a19:	c3                   	ret
80104a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104a20:	e8 5b f4 ff ff       	call   80103e80 <mycpu>
80104a25:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104a2b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104a31:	eb d6                	jmp    80104a09 <pushcli+0x19>
80104a33:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a3a:	00 
80104a3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104a40 <popcli>:

void
popcli(void)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104a46:	9c                   	pushf
80104a47:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104a48:	f6 c4 02             	test   $0x2,%ah
80104a4b:	75 35                	jne    80104a82 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104a4d:	e8 2e f4 ff ff       	call   80103e80 <mycpu>
80104a52:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104a59:	78 34                	js     80104a8f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104a5b:	e8 20 f4 ff ff       	call   80103e80 <mycpu>
80104a60:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104a66:	85 d2                	test   %edx,%edx
80104a68:	74 06                	je     80104a70 <popcli+0x30>
    sti();
}
80104a6a:	c9                   	leave
80104a6b:	c3                   	ret
80104a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104a70:	e8 0b f4 ff ff       	call   80103e80 <mycpu>
80104a75:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104a7b:	85 c0                	test   %eax,%eax
80104a7d:	74 eb                	je     80104a6a <popcli+0x2a>
  asm volatile("sti");
80104a7f:	fb                   	sti
}
80104a80:	c9                   	leave
80104a81:	c3                   	ret
    panic("popcli - interruptible");
80104a82:	83 ec 0c             	sub    $0xc,%esp
80104a85:	68 43 7a 10 80       	push   $0x80107a43
80104a8a:	e8 f1 b8 ff ff       	call   80100380 <panic>
    panic("popcli");
80104a8f:	83 ec 0c             	sub    $0xc,%esp
80104a92:	68 5a 7a 10 80       	push   $0x80107a5a
80104a97:	e8 e4 b8 ff ff       	call   80100380 <panic>
80104a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104aa0 <holding>:
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	56                   	push   %esi
80104aa4:	53                   	push   %ebx
80104aa5:	8b 75 08             	mov    0x8(%ebp),%esi
80104aa8:	31 db                	xor    %ebx,%ebx
  pushcli();
80104aaa:	e8 41 ff ff ff       	call   801049f0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104aaf:	8b 06                	mov    (%esi),%eax
80104ab1:	85 c0                	test   %eax,%eax
80104ab3:	75 0b                	jne    80104ac0 <holding+0x20>
  popcli();
80104ab5:	e8 86 ff ff ff       	call   80104a40 <popcli>
}
80104aba:	89 d8                	mov    %ebx,%eax
80104abc:	5b                   	pop    %ebx
80104abd:	5e                   	pop    %esi
80104abe:	5d                   	pop    %ebp
80104abf:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80104ac0:	8b 5e 08             	mov    0x8(%esi),%ebx
80104ac3:	e8 b8 f3 ff ff       	call   80103e80 <mycpu>
80104ac8:	39 c3                	cmp    %eax,%ebx
80104aca:	0f 94 c3             	sete   %bl
  popcli();
80104acd:	e8 6e ff ff ff       	call   80104a40 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104ad2:	0f b6 db             	movzbl %bl,%ebx
}
80104ad5:	89 d8                	mov    %ebx,%eax
80104ad7:	5b                   	pop    %ebx
80104ad8:	5e                   	pop    %esi
80104ad9:	5d                   	pop    %ebp
80104ada:	c3                   	ret
80104adb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104ae0 <release>:
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	56                   	push   %esi
80104ae4:	53                   	push   %ebx
80104ae5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104ae8:	e8 03 ff ff ff       	call   801049f0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104aed:	8b 03                	mov    (%ebx),%eax
80104aef:	85 c0                	test   %eax,%eax
80104af1:	75 15                	jne    80104b08 <release+0x28>
  popcli();
80104af3:	e8 48 ff ff ff       	call   80104a40 <popcli>
    panic("release");
80104af8:	83 ec 0c             	sub    $0xc,%esp
80104afb:	68 61 7a 10 80       	push   $0x80107a61
80104b00:	e8 7b b8 ff ff       	call   80100380 <panic>
80104b05:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104b08:	8b 73 08             	mov    0x8(%ebx),%esi
80104b0b:	e8 70 f3 ff ff       	call   80103e80 <mycpu>
80104b10:	39 c6                	cmp    %eax,%esi
80104b12:	75 df                	jne    80104af3 <release+0x13>
  popcli();
80104b14:	e8 27 ff ff ff       	call   80104a40 <popcli>
  lk->pcs[0] = 0;
80104b19:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104b20:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104b27:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104b2c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104b32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b35:	5b                   	pop    %ebx
80104b36:	5e                   	pop    %esi
80104b37:	5d                   	pop    %ebp
  popcli();
80104b38:	e9 03 ff ff ff       	jmp    80104a40 <popcli>
80104b3d:	8d 76 00             	lea    0x0(%esi),%esi

80104b40 <acquire>:
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	53                   	push   %ebx
80104b44:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104b47:	e8 a4 fe ff ff       	call   801049f0 <pushcli>
  if(holding(lk))
80104b4c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104b4f:	e8 9c fe ff ff       	call   801049f0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104b54:	8b 03                	mov    (%ebx),%eax
80104b56:	85 c0                	test   %eax,%eax
80104b58:	0f 85 b2 00 00 00    	jne    80104c10 <acquire+0xd0>
  popcli();
80104b5e:	e8 dd fe ff ff       	call   80104a40 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104b63:	b9 01 00 00 00       	mov    $0x1,%ecx
80104b68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b6f:	00 
  while(xchg(&lk->locked, 1) != 0)
80104b70:	8b 55 08             	mov    0x8(%ebp),%edx
80104b73:	89 c8                	mov    %ecx,%eax
80104b75:	f0 87 02             	lock xchg %eax,(%edx)
80104b78:	85 c0                	test   %eax,%eax
80104b7a:	75 f4                	jne    80104b70 <acquire+0x30>
  __sync_synchronize();
80104b7c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104b81:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104b84:	e8 f7 f2 ff ff       	call   80103e80 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104b89:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
80104b8c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
80104b8e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b91:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80104b97:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
80104b9c:	77 32                	ja     80104bd0 <acquire+0x90>
  ebp = (uint*)v - 2;
80104b9e:	89 e8                	mov    %ebp,%eax
80104ba0:	eb 14                	jmp    80104bb6 <acquire+0x76>
80104ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ba8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104bae:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104bb4:	77 1a                	ja     80104bd0 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80104bb6:	8b 58 04             	mov    0x4(%eax),%ebx
80104bb9:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104bbd:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104bc0:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104bc2:	83 fa 0a             	cmp    $0xa,%edx
80104bc5:	75 e1                	jne    80104ba8 <acquire+0x68>
}
80104bc7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bca:	c9                   	leave
80104bcb:	c3                   	ret
80104bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bd0:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80104bd4:	83 c1 34             	add    $0x34,%ecx
80104bd7:	89 ca                	mov    %ecx,%edx
80104bd9:	29 c2                	sub    %eax,%edx
80104bdb:	83 e2 04             	and    $0x4,%edx
80104bde:	74 10                	je     80104bf0 <acquire+0xb0>
    pcs[i] = 0;
80104be0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104be6:	83 c0 04             	add    $0x4,%eax
80104be9:	39 c1                	cmp    %eax,%ecx
80104beb:	74 da                	je     80104bc7 <acquire+0x87>
80104bed:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104bf0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104bf6:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104bf9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104c00:	39 c1                	cmp    %eax,%ecx
80104c02:	75 ec                	jne    80104bf0 <acquire+0xb0>
80104c04:	eb c1                	jmp    80104bc7 <acquire+0x87>
80104c06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c0d:	00 
80104c0e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80104c10:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104c13:	e8 68 f2 ff ff       	call   80103e80 <mycpu>
80104c18:	39 c3                	cmp    %eax,%ebx
80104c1a:	0f 85 3e ff ff ff    	jne    80104b5e <acquire+0x1e>
  popcli();
80104c20:	e8 1b fe ff ff       	call   80104a40 <popcli>
    panic("acquire");
80104c25:	83 ec 0c             	sub    $0xc,%esp
80104c28:	68 69 7a 10 80       	push   $0x80107a69
80104c2d:	e8 4e b7 ff ff       	call   80100380 <panic>
80104c32:	66 90                	xchg   %ax,%ax
80104c34:	66 90                	xchg   %ax,%ax
80104c36:	66 90                	xchg   %ax,%ax
80104c38:	66 90                	xchg   %ax,%ax
80104c3a:	66 90                	xchg   %ax,%ax
80104c3c:	66 90                	xchg   %ax,%ax
80104c3e:	66 90                	xchg   %ax,%ax

80104c40 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	57                   	push   %edi
80104c44:	8b 55 08             	mov    0x8(%ebp),%edx
80104c47:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104c4a:	89 d0                	mov    %edx,%eax
80104c4c:	09 c8                	or     %ecx,%eax
80104c4e:	a8 03                	test   $0x3,%al
80104c50:	75 1e                	jne    80104c70 <memset+0x30>
    c &= 0xFF;
80104c52:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104c56:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104c59:	89 d7                	mov    %edx,%edi
80104c5b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104c61:	fc                   	cld
80104c62:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104c64:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104c67:	89 d0                	mov    %edx,%eax
80104c69:	c9                   	leave
80104c6a:	c3                   	ret
80104c6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104c70:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c73:	89 d7                	mov    %edx,%edi
80104c75:	fc                   	cld
80104c76:	f3 aa                	rep stos %al,%es:(%edi)
80104c78:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104c7b:	89 d0                	mov    %edx,%eax
80104c7d:	c9                   	leave
80104c7e:	c3                   	ret
80104c7f:	90                   	nop

80104c80 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104c80:	55                   	push   %ebp
80104c81:	89 e5                	mov    %esp,%ebp
80104c83:	56                   	push   %esi
80104c84:	8b 75 10             	mov    0x10(%ebp),%esi
80104c87:	8b 45 08             	mov    0x8(%ebp),%eax
80104c8a:	53                   	push   %ebx
80104c8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104c8e:	85 f6                	test   %esi,%esi
80104c90:	74 2e                	je     80104cc0 <memcmp+0x40>
80104c92:	01 c6                	add    %eax,%esi
80104c94:	eb 14                	jmp    80104caa <memcmp+0x2a>
80104c96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c9d:	00 
80104c9e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104ca0:	83 c0 01             	add    $0x1,%eax
80104ca3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104ca6:	39 f0                	cmp    %esi,%eax
80104ca8:	74 16                	je     80104cc0 <memcmp+0x40>
    if(*s1 != *s2)
80104caa:	0f b6 08             	movzbl (%eax),%ecx
80104cad:	0f b6 1a             	movzbl (%edx),%ebx
80104cb0:	38 d9                	cmp    %bl,%cl
80104cb2:	74 ec                	je     80104ca0 <memcmp+0x20>
      return *s1 - *s2;
80104cb4:	0f b6 c1             	movzbl %cl,%eax
80104cb7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104cb9:	5b                   	pop    %ebx
80104cba:	5e                   	pop    %esi
80104cbb:	5d                   	pop    %ebp
80104cbc:	c3                   	ret
80104cbd:	8d 76 00             	lea    0x0(%esi),%esi
80104cc0:	5b                   	pop    %ebx
  return 0;
80104cc1:	31 c0                	xor    %eax,%eax
}
80104cc3:	5e                   	pop    %esi
80104cc4:	5d                   	pop    %ebp
80104cc5:	c3                   	ret
80104cc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ccd:	00 
80104cce:	66 90                	xchg   %ax,%ax

80104cd0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	57                   	push   %edi
80104cd4:	8b 55 08             	mov    0x8(%ebp),%edx
80104cd7:	8b 45 10             	mov    0x10(%ebp),%eax
80104cda:	56                   	push   %esi
80104cdb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104cde:	39 d6                	cmp    %edx,%esi
80104ce0:	73 26                	jae    80104d08 <memmove+0x38>
80104ce2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104ce5:	39 ca                	cmp    %ecx,%edx
80104ce7:	73 1f                	jae    80104d08 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104ce9:	85 c0                	test   %eax,%eax
80104ceb:	74 0f                	je     80104cfc <memmove+0x2c>
80104ced:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104cf0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104cf4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104cf7:	83 e8 01             	sub    $0x1,%eax
80104cfa:	73 f4                	jae    80104cf0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104cfc:	5e                   	pop    %esi
80104cfd:	89 d0                	mov    %edx,%eax
80104cff:	5f                   	pop    %edi
80104d00:	5d                   	pop    %ebp
80104d01:	c3                   	ret
80104d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104d08:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104d0b:	89 d7                	mov    %edx,%edi
80104d0d:	85 c0                	test   %eax,%eax
80104d0f:	74 eb                	je     80104cfc <memmove+0x2c>
80104d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104d18:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104d19:	39 ce                	cmp    %ecx,%esi
80104d1b:	75 fb                	jne    80104d18 <memmove+0x48>
}
80104d1d:	5e                   	pop    %esi
80104d1e:	89 d0                	mov    %edx,%eax
80104d20:	5f                   	pop    %edi
80104d21:	5d                   	pop    %ebp
80104d22:	c3                   	ret
80104d23:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d2a:	00 
80104d2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104d30 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104d30:	eb 9e                	jmp    80104cd0 <memmove>
80104d32:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d39:	00 
80104d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d40 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	53                   	push   %ebx
80104d44:	8b 55 10             	mov    0x10(%ebp),%edx
80104d47:	8b 45 08             	mov    0x8(%ebp),%eax
80104d4a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104d4d:	85 d2                	test   %edx,%edx
80104d4f:	75 16                	jne    80104d67 <strncmp+0x27>
80104d51:	eb 2d                	jmp    80104d80 <strncmp+0x40>
80104d53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d58:	3a 19                	cmp    (%ecx),%bl
80104d5a:	75 12                	jne    80104d6e <strncmp+0x2e>
    n--, p++, q++;
80104d5c:	83 c0 01             	add    $0x1,%eax
80104d5f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104d62:	83 ea 01             	sub    $0x1,%edx
80104d65:	74 19                	je     80104d80 <strncmp+0x40>
80104d67:	0f b6 18             	movzbl (%eax),%ebx
80104d6a:	84 db                	test   %bl,%bl
80104d6c:	75 ea                	jne    80104d58 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104d6e:	0f b6 00             	movzbl (%eax),%eax
80104d71:	0f b6 11             	movzbl (%ecx),%edx
}
80104d74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d77:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104d78:	29 d0                	sub    %edx,%eax
}
80104d7a:	c3                   	ret
80104d7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104d83:	31 c0                	xor    %eax,%eax
}
80104d85:	c9                   	leave
80104d86:	c3                   	ret
80104d87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d8e:	00 
80104d8f:	90                   	nop

80104d90 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	57                   	push   %edi
80104d94:	56                   	push   %esi
80104d95:	8b 75 08             	mov    0x8(%ebp),%esi
80104d98:	53                   	push   %ebx
80104d99:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104d9c:	89 f0                	mov    %esi,%eax
80104d9e:	eb 15                	jmp    80104db5 <strncpy+0x25>
80104da0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104da4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104da7:	83 c0 01             	add    $0x1,%eax
80104daa:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
80104dae:	88 48 ff             	mov    %cl,-0x1(%eax)
80104db1:	84 c9                	test   %cl,%cl
80104db3:	74 13                	je     80104dc8 <strncpy+0x38>
80104db5:	89 d3                	mov    %edx,%ebx
80104db7:	83 ea 01             	sub    $0x1,%edx
80104dba:	85 db                	test   %ebx,%ebx
80104dbc:	7f e2                	jg     80104da0 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104dbe:	5b                   	pop    %ebx
80104dbf:	89 f0                	mov    %esi,%eax
80104dc1:	5e                   	pop    %esi
80104dc2:	5f                   	pop    %edi
80104dc3:	5d                   	pop    %ebp
80104dc4:	c3                   	ret
80104dc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104dc8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104dcb:	83 e9 01             	sub    $0x1,%ecx
80104dce:	85 d2                	test   %edx,%edx
80104dd0:	74 ec                	je     80104dbe <strncpy+0x2e>
80104dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104dd8:	83 c0 01             	add    $0x1,%eax
80104ddb:	89 ca                	mov    %ecx,%edx
80104ddd:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104de1:	29 c2                	sub    %eax,%edx
80104de3:	85 d2                	test   %edx,%edx
80104de5:	7f f1                	jg     80104dd8 <strncpy+0x48>
}
80104de7:	5b                   	pop    %ebx
80104de8:	89 f0                	mov    %esi,%eax
80104dea:	5e                   	pop    %esi
80104deb:	5f                   	pop    %edi
80104dec:	5d                   	pop    %ebp
80104ded:	c3                   	ret
80104dee:	66 90                	xchg   %ax,%ax

80104df0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	56                   	push   %esi
80104df4:	8b 55 10             	mov    0x10(%ebp),%edx
80104df7:	8b 75 08             	mov    0x8(%ebp),%esi
80104dfa:	53                   	push   %ebx
80104dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104dfe:	85 d2                	test   %edx,%edx
80104e00:	7e 25                	jle    80104e27 <safestrcpy+0x37>
80104e02:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104e06:	89 f2                	mov    %esi,%edx
80104e08:	eb 16                	jmp    80104e20 <safestrcpy+0x30>
80104e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104e10:	0f b6 08             	movzbl (%eax),%ecx
80104e13:	83 c0 01             	add    $0x1,%eax
80104e16:	83 c2 01             	add    $0x1,%edx
80104e19:	88 4a ff             	mov    %cl,-0x1(%edx)
80104e1c:	84 c9                	test   %cl,%cl
80104e1e:	74 04                	je     80104e24 <safestrcpy+0x34>
80104e20:	39 d8                	cmp    %ebx,%eax
80104e22:	75 ec                	jne    80104e10 <safestrcpy+0x20>
    ;
  *s = 0;
80104e24:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104e27:	89 f0                	mov    %esi,%eax
80104e29:	5b                   	pop    %ebx
80104e2a:	5e                   	pop    %esi
80104e2b:	5d                   	pop    %ebp
80104e2c:	c3                   	ret
80104e2d:	8d 76 00             	lea    0x0(%esi),%esi

80104e30 <strlen>:

int
strlen(const char *s)
{
80104e30:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104e31:	31 c0                	xor    %eax,%eax
{
80104e33:	89 e5                	mov    %esp,%ebp
80104e35:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104e38:	80 3a 00             	cmpb   $0x0,(%edx)
80104e3b:	74 0c                	je     80104e49 <strlen+0x19>
80104e3d:	8d 76 00             	lea    0x0(%esi),%esi
80104e40:	83 c0 01             	add    $0x1,%eax
80104e43:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104e47:	75 f7                	jne    80104e40 <strlen+0x10>
    ;
  return n;
}
80104e49:	5d                   	pop    %ebp
80104e4a:	c3                   	ret

80104e4b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104e4b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104e4f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104e53:	55                   	push   %ebp
  pushl %ebx
80104e54:	53                   	push   %ebx
  pushl %esi
80104e55:	56                   	push   %esi
  pushl %edi
80104e56:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104e57:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104e59:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104e5b:	5f                   	pop    %edi
  popl %esi
80104e5c:	5e                   	pop    %esi
  popl %ebx
80104e5d:	5b                   	pop    %ebx
  popl %ebp
80104e5e:	5d                   	pop    %ebp
  ret
80104e5f:	c3                   	ret

80104e60 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	53                   	push   %ebx
80104e64:	83 ec 04             	sub    $0x4,%esp
80104e67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104e6a:	e8 91 f0 ff ff       	call   80103f00 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104e6f:	8b 00                	mov    (%eax),%eax
80104e71:	39 c3                	cmp    %eax,%ebx
80104e73:	73 1b                	jae    80104e90 <fetchint+0x30>
80104e75:	8d 53 04             	lea    0x4(%ebx),%edx
80104e78:	39 d0                	cmp    %edx,%eax
80104e7a:	72 14                	jb     80104e90 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e7f:	8b 13                	mov    (%ebx),%edx
80104e81:	89 10                	mov    %edx,(%eax)
  return 0;
80104e83:	31 c0                	xor    %eax,%eax
}
80104e85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e88:	c9                   	leave
80104e89:	c3                   	ret
80104e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e95:	eb ee                	jmp    80104e85 <fetchint+0x25>
80104e97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e9e:	00 
80104e9f:	90                   	nop

80104ea0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	53                   	push   %ebx
80104ea4:	83 ec 04             	sub    $0x4,%esp
80104ea7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104eaa:	e8 51 f0 ff ff       	call   80103f00 <myproc>

  if(addr >= curproc->sz)
80104eaf:	3b 18                	cmp    (%eax),%ebx
80104eb1:	73 2d                	jae    80104ee0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104eb3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104eb6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104eb8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104eba:	39 d3                	cmp    %edx,%ebx
80104ebc:	73 22                	jae    80104ee0 <fetchstr+0x40>
80104ebe:	89 d8                	mov    %ebx,%eax
80104ec0:	eb 0d                	jmp    80104ecf <fetchstr+0x2f>
80104ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ec8:	83 c0 01             	add    $0x1,%eax
80104ecb:	39 d0                	cmp    %edx,%eax
80104ecd:	73 11                	jae    80104ee0 <fetchstr+0x40>
    if(*s == 0)
80104ecf:	80 38 00             	cmpb   $0x0,(%eax)
80104ed2:	75 f4                	jne    80104ec8 <fetchstr+0x28>
      return s - *pp;
80104ed4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104ed6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ed9:	c9                   	leave
80104eda:	c3                   	ret
80104edb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ee0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104ee3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ee8:	c9                   	leave
80104ee9:	c3                   	ret
80104eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ef0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	56                   	push   %esi
80104ef4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ef5:	e8 06 f0 ff ff       	call   80103f00 <myproc>
80104efa:	8b 55 08             	mov    0x8(%ebp),%edx
80104efd:	8b 40 18             	mov    0x18(%eax),%eax
80104f00:	8b 40 44             	mov    0x44(%eax),%eax
80104f03:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104f06:	e8 f5 ef ff ff       	call   80103f00 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f0b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f0e:	8b 00                	mov    (%eax),%eax
80104f10:	39 c6                	cmp    %eax,%esi
80104f12:	73 1c                	jae    80104f30 <argint+0x40>
80104f14:	8d 53 08             	lea    0x8(%ebx),%edx
80104f17:	39 d0                	cmp    %edx,%eax
80104f19:	72 15                	jb     80104f30 <argint+0x40>
  *ip = *(int*)(addr);
80104f1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f1e:	8b 53 04             	mov    0x4(%ebx),%edx
80104f21:	89 10                	mov    %edx,(%eax)
  return 0;
80104f23:	31 c0                	xor    %eax,%eax
}
80104f25:	5b                   	pop    %ebx
80104f26:	5e                   	pop    %esi
80104f27:	5d                   	pop    %ebp
80104f28:	c3                   	ret
80104f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f35:	eb ee                	jmp    80104f25 <argint+0x35>
80104f37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f3e:	00 
80104f3f:	90                   	nop

80104f40 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	57                   	push   %edi
80104f44:	56                   	push   %esi
80104f45:	53                   	push   %ebx
80104f46:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104f49:	e8 b2 ef ff ff       	call   80103f00 <myproc>
80104f4e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f50:	e8 ab ef ff ff       	call   80103f00 <myproc>
80104f55:	8b 55 08             	mov    0x8(%ebp),%edx
80104f58:	8b 40 18             	mov    0x18(%eax),%eax
80104f5b:	8b 40 44             	mov    0x44(%eax),%eax
80104f5e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104f61:	e8 9a ef ff ff       	call   80103f00 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f66:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f69:	8b 00                	mov    (%eax),%eax
80104f6b:	39 c7                	cmp    %eax,%edi
80104f6d:	73 31                	jae    80104fa0 <argptr+0x60>
80104f6f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104f72:	39 c8                	cmp    %ecx,%eax
80104f74:	72 2a                	jb     80104fa0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104f76:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104f79:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104f7c:	85 d2                	test   %edx,%edx
80104f7e:	78 20                	js     80104fa0 <argptr+0x60>
80104f80:	8b 16                	mov    (%esi),%edx
80104f82:	39 d0                	cmp    %edx,%eax
80104f84:	73 1a                	jae    80104fa0 <argptr+0x60>
80104f86:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104f89:	01 c3                	add    %eax,%ebx
80104f8b:	39 da                	cmp    %ebx,%edx
80104f8d:	72 11                	jb     80104fa0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104f8f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f92:	89 02                	mov    %eax,(%edx)
  return 0;
80104f94:	31 c0                	xor    %eax,%eax
}
80104f96:	83 c4 0c             	add    $0xc,%esp
80104f99:	5b                   	pop    %ebx
80104f9a:	5e                   	pop    %esi
80104f9b:	5f                   	pop    %edi
80104f9c:	5d                   	pop    %ebp
80104f9d:	c3                   	ret
80104f9e:	66 90                	xchg   %ax,%ax
    return -1;
80104fa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fa5:	eb ef                	jmp    80104f96 <argptr+0x56>
80104fa7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fae:	00 
80104faf:	90                   	nop

80104fb0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	56                   	push   %esi
80104fb4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fb5:	e8 46 ef ff ff       	call   80103f00 <myproc>
80104fba:	8b 55 08             	mov    0x8(%ebp),%edx
80104fbd:	8b 40 18             	mov    0x18(%eax),%eax
80104fc0:	8b 40 44             	mov    0x44(%eax),%eax
80104fc3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104fc6:	e8 35 ef ff ff       	call   80103f00 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fcb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104fce:	8b 00                	mov    (%eax),%eax
80104fd0:	39 c6                	cmp    %eax,%esi
80104fd2:	73 44                	jae    80105018 <argstr+0x68>
80104fd4:	8d 53 08             	lea    0x8(%ebx),%edx
80104fd7:	39 d0                	cmp    %edx,%eax
80104fd9:	72 3d                	jb     80105018 <argstr+0x68>
  *ip = *(int*)(addr);
80104fdb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104fde:	e8 1d ef ff ff       	call   80103f00 <myproc>
  if(addr >= curproc->sz)
80104fe3:	3b 18                	cmp    (%eax),%ebx
80104fe5:	73 31                	jae    80105018 <argstr+0x68>
  *pp = (char*)addr;
80104fe7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104fea:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104fec:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104fee:	39 d3                	cmp    %edx,%ebx
80104ff0:	73 26                	jae    80105018 <argstr+0x68>
80104ff2:	89 d8                	mov    %ebx,%eax
80104ff4:	eb 11                	jmp    80105007 <argstr+0x57>
80104ff6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ffd:	00 
80104ffe:	66 90                	xchg   %ax,%ax
80105000:	83 c0 01             	add    $0x1,%eax
80105003:	39 d0                	cmp    %edx,%eax
80105005:	73 11                	jae    80105018 <argstr+0x68>
    if(*s == 0)
80105007:	80 38 00             	cmpb   $0x0,(%eax)
8010500a:	75 f4                	jne    80105000 <argstr+0x50>
      return s - *pp;
8010500c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010500e:	5b                   	pop    %ebx
8010500f:	5e                   	pop    %esi
80105010:	5d                   	pop    %ebp
80105011:	c3                   	ret
80105012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105018:	5b                   	pop    %ebx
    return -1;
80105019:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010501e:	5e                   	pop    %esi
8010501f:	5d                   	pop    %ebp
80105020:	c3                   	ret
80105021:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105028:	00 
80105029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105030 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	53                   	push   %ebx
80105034:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105037:	e8 c4 ee ff ff       	call   80103f00 <myproc>
8010503c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010503e:	8b 40 18             	mov    0x18(%eax),%eax
80105041:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105044:	8d 50 ff             	lea    -0x1(%eax),%edx
80105047:	83 fa 14             	cmp    $0x14,%edx
8010504a:	77 24                	ja     80105070 <syscall+0x40>
8010504c:	8b 14 85 40 80 10 80 	mov    -0x7fef7fc0(,%eax,4),%edx
80105053:	85 d2                	test   %edx,%edx
80105055:	74 19                	je     80105070 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105057:	ff d2                	call   *%edx
80105059:	89 c2                	mov    %eax,%edx
8010505b:	8b 43 18             	mov    0x18(%ebx),%eax
8010505e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105061:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105064:	c9                   	leave
80105065:	c3                   	ret
80105066:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010506d:	00 
8010506e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80105070:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105071:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105074:	50                   	push   %eax
80105075:	ff 73 10             	push   0x10(%ebx)
80105078:	68 71 7a 10 80       	push   $0x80107a71
8010507d:	e8 de b5 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80105082:	8b 43 18             	mov    0x18(%ebx),%eax
80105085:	83 c4 10             	add    $0x10,%esp
80105088:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010508f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105092:	c9                   	leave
80105093:	c3                   	ret
80105094:	66 90                	xchg   %ax,%ax
80105096:	66 90                	xchg   %ax,%ax
80105098:	66 90                	xchg   %ax,%ax
8010509a:	66 90                	xchg   %ax,%ax
8010509c:	66 90                	xchg   %ax,%ax
8010509e:	66 90                	xchg   %ax,%ax

801050a0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	57                   	push   %edi
801050a4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801050a5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801050a8:	53                   	push   %ebx
801050a9:	83 ec 34             	sub    $0x34,%esp
801050ac:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801050af:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050b2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801050b5:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801050b8:	57                   	push   %edi
801050b9:	50                   	push   %eax
801050ba:	e8 81 d5 ff ff       	call   80102640 <nameiparent>
801050bf:	83 c4 10             	add    $0x10,%esp
801050c2:	85 c0                	test   %eax,%eax
801050c4:	74 5e                	je     80105124 <create+0x84>
    return 0;
  ilock(dp);
801050c6:	83 ec 0c             	sub    $0xc,%esp
801050c9:	89 c3                	mov    %eax,%ebx
801050cb:	50                   	push   %eax
801050cc:	e8 6f cc ff ff       	call   80101d40 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801050d1:	83 c4 0c             	add    $0xc,%esp
801050d4:	6a 00                	push   $0x0
801050d6:	57                   	push   %edi
801050d7:	53                   	push   %ebx
801050d8:	e8 b3 d1 ff ff       	call   80102290 <dirlookup>
801050dd:	83 c4 10             	add    $0x10,%esp
801050e0:	89 c6                	mov    %eax,%esi
801050e2:	85 c0                	test   %eax,%eax
801050e4:	74 4a                	je     80105130 <create+0x90>
    iunlockput(dp);
801050e6:	83 ec 0c             	sub    $0xc,%esp
801050e9:	53                   	push   %ebx
801050ea:	e8 e1 ce ff ff       	call   80101fd0 <iunlockput>
    ilock(ip);
801050ef:	89 34 24             	mov    %esi,(%esp)
801050f2:	e8 49 cc ff ff       	call   80101d40 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801050f7:	83 c4 10             	add    $0x10,%esp
801050fa:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801050ff:	75 17                	jne    80105118 <create+0x78>
80105101:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105106:	75 10                	jne    80105118 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105108:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010510b:	89 f0                	mov    %esi,%eax
8010510d:	5b                   	pop    %ebx
8010510e:	5e                   	pop    %esi
8010510f:	5f                   	pop    %edi
80105110:	5d                   	pop    %ebp
80105111:	c3                   	ret
80105112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105118:	83 ec 0c             	sub    $0xc,%esp
8010511b:	56                   	push   %esi
8010511c:	e8 af ce ff ff       	call   80101fd0 <iunlockput>
    return 0;
80105121:	83 c4 10             	add    $0x10,%esp
}
80105124:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105127:	31 f6                	xor    %esi,%esi
}
80105129:	5b                   	pop    %ebx
8010512a:	89 f0                	mov    %esi,%eax
8010512c:	5e                   	pop    %esi
8010512d:	5f                   	pop    %edi
8010512e:	5d                   	pop    %ebp
8010512f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80105130:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105134:	83 ec 08             	sub    $0x8,%esp
80105137:	50                   	push   %eax
80105138:	ff 33                	push   (%ebx)
8010513a:	e8 91 ca ff ff       	call   80101bd0 <ialloc>
8010513f:	83 c4 10             	add    $0x10,%esp
80105142:	89 c6                	mov    %eax,%esi
80105144:	85 c0                	test   %eax,%eax
80105146:	0f 84 bc 00 00 00    	je     80105208 <create+0x168>
  ilock(ip);
8010514c:	83 ec 0c             	sub    $0xc,%esp
8010514f:	50                   	push   %eax
80105150:	e8 eb cb ff ff       	call   80101d40 <ilock>
  ip->major = major;
80105155:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105159:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010515d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105161:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105165:	b8 01 00 00 00       	mov    $0x1,%eax
8010516a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010516e:	89 34 24             	mov    %esi,(%esp)
80105171:	e8 1a cb ff ff       	call   80101c90 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105176:	83 c4 10             	add    $0x10,%esp
80105179:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010517e:	74 30                	je     801051b0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80105180:	83 ec 04             	sub    $0x4,%esp
80105183:	ff 76 04             	push   0x4(%esi)
80105186:	57                   	push   %edi
80105187:	53                   	push   %ebx
80105188:	e8 d3 d3 ff ff       	call   80102560 <dirlink>
8010518d:	83 c4 10             	add    $0x10,%esp
80105190:	85 c0                	test   %eax,%eax
80105192:	78 67                	js     801051fb <create+0x15b>
  iunlockput(dp);
80105194:	83 ec 0c             	sub    $0xc,%esp
80105197:	53                   	push   %ebx
80105198:	e8 33 ce ff ff       	call   80101fd0 <iunlockput>
  return ip;
8010519d:	83 c4 10             	add    $0x10,%esp
}
801051a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051a3:	89 f0                	mov    %esi,%eax
801051a5:	5b                   	pop    %ebx
801051a6:	5e                   	pop    %esi
801051a7:	5f                   	pop    %edi
801051a8:	5d                   	pop    %ebp
801051a9:	c3                   	ret
801051aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801051b0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801051b3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801051b8:	53                   	push   %ebx
801051b9:	e8 d2 ca ff ff       	call   80101c90 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801051be:	83 c4 0c             	add    $0xc,%esp
801051c1:	ff 76 04             	push   0x4(%esi)
801051c4:	68 a9 7a 10 80       	push   $0x80107aa9
801051c9:	56                   	push   %esi
801051ca:	e8 91 d3 ff ff       	call   80102560 <dirlink>
801051cf:	83 c4 10             	add    $0x10,%esp
801051d2:	85 c0                	test   %eax,%eax
801051d4:	78 18                	js     801051ee <create+0x14e>
801051d6:	83 ec 04             	sub    $0x4,%esp
801051d9:	ff 73 04             	push   0x4(%ebx)
801051dc:	68 a8 7a 10 80       	push   $0x80107aa8
801051e1:	56                   	push   %esi
801051e2:	e8 79 d3 ff ff       	call   80102560 <dirlink>
801051e7:	83 c4 10             	add    $0x10,%esp
801051ea:	85 c0                	test   %eax,%eax
801051ec:	79 92                	jns    80105180 <create+0xe0>
      panic("create dots");
801051ee:	83 ec 0c             	sub    $0xc,%esp
801051f1:	68 9c 7a 10 80       	push   $0x80107a9c
801051f6:	e8 85 b1 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
801051fb:	83 ec 0c             	sub    $0xc,%esp
801051fe:	68 ab 7a 10 80       	push   $0x80107aab
80105203:	e8 78 b1 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80105208:	83 ec 0c             	sub    $0xc,%esp
8010520b:	68 8d 7a 10 80       	push   $0x80107a8d
80105210:	e8 6b b1 ff ff       	call   80100380 <panic>
80105215:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010521c:	00 
8010521d:	8d 76 00             	lea    0x0(%esi),%esi

80105220 <sys_dup>:
{
80105220:	55                   	push   %ebp
80105221:	89 e5                	mov    %esp,%ebp
80105223:	56                   	push   %esi
80105224:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105225:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105228:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010522b:	50                   	push   %eax
8010522c:	6a 00                	push   $0x0
8010522e:	e8 bd fc ff ff       	call   80104ef0 <argint>
80105233:	83 c4 10             	add    $0x10,%esp
80105236:	85 c0                	test   %eax,%eax
80105238:	78 36                	js     80105270 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010523a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010523e:	77 30                	ja     80105270 <sys_dup+0x50>
80105240:	e8 bb ec ff ff       	call   80103f00 <myproc>
80105245:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105248:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010524c:	85 f6                	test   %esi,%esi
8010524e:	74 20                	je     80105270 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105250:	e8 ab ec ff ff       	call   80103f00 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105255:	31 db                	xor    %ebx,%ebx
80105257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010525e:	00 
8010525f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105260:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105264:	85 d2                	test   %edx,%edx
80105266:	74 18                	je     80105280 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105268:	83 c3 01             	add    $0x1,%ebx
8010526b:	83 fb 10             	cmp    $0x10,%ebx
8010526e:	75 f0                	jne    80105260 <sys_dup+0x40>
}
80105270:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105273:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105278:	89 d8                	mov    %ebx,%eax
8010527a:	5b                   	pop    %ebx
8010527b:	5e                   	pop    %esi
8010527c:	5d                   	pop    %ebp
8010527d:	c3                   	ret
8010527e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105280:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105283:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105287:	56                   	push   %esi
80105288:	e8 d3 c1 ff ff       	call   80101460 <filedup>
  return fd;
8010528d:	83 c4 10             	add    $0x10,%esp
}
80105290:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105293:	89 d8                	mov    %ebx,%eax
80105295:	5b                   	pop    %ebx
80105296:	5e                   	pop    %esi
80105297:	5d                   	pop    %ebp
80105298:	c3                   	ret
80105299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801052a0 <sys_read>:
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	56                   	push   %esi
801052a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801052a5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801052a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801052ab:	53                   	push   %ebx
801052ac:	6a 00                	push   $0x0
801052ae:	e8 3d fc ff ff       	call   80104ef0 <argint>
801052b3:	83 c4 10             	add    $0x10,%esp
801052b6:	85 c0                	test   %eax,%eax
801052b8:	78 5e                	js     80105318 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801052ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801052be:	77 58                	ja     80105318 <sys_read+0x78>
801052c0:	e8 3b ec ff ff       	call   80103f00 <myproc>
801052c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801052c8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801052cc:	85 f6                	test   %esi,%esi
801052ce:	74 48                	je     80105318 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801052d0:	83 ec 08             	sub    $0x8,%esp
801052d3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052d6:	50                   	push   %eax
801052d7:	6a 02                	push   $0x2
801052d9:	e8 12 fc ff ff       	call   80104ef0 <argint>
801052de:	83 c4 10             	add    $0x10,%esp
801052e1:	85 c0                	test   %eax,%eax
801052e3:	78 33                	js     80105318 <sys_read+0x78>
801052e5:	83 ec 04             	sub    $0x4,%esp
801052e8:	ff 75 f0             	push   -0x10(%ebp)
801052eb:	53                   	push   %ebx
801052ec:	6a 01                	push   $0x1
801052ee:	e8 4d fc ff ff       	call   80104f40 <argptr>
801052f3:	83 c4 10             	add    $0x10,%esp
801052f6:	85 c0                	test   %eax,%eax
801052f8:	78 1e                	js     80105318 <sys_read+0x78>
  return fileread(f, p, n);
801052fa:	83 ec 04             	sub    $0x4,%esp
801052fd:	ff 75 f0             	push   -0x10(%ebp)
80105300:	ff 75 f4             	push   -0xc(%ebp)
80105303:	56                   	push   %esi
80105304:	e8 d7 c2 ff ff       	call   801015e0 <fileread>
80105309:	83 c4 10             	add    $0x10,%esp
}
8010530c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010530f:	5b                   	pop    %ebx
80105310:	5e                   	pop    %esi
80105311:	5d                   	pop    %ebp
80105312:	c3                   	ret
80105313:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010531d:	eb ed                	jmp    8010530c <sys_read+0x6c>
8010531f:	90                   	nop

80105320 <sys_write>:
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105325:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105328:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010532b:	53                   	push   %ebx
8010532c:	6a 00                	push   $0x0
8010532e:	e8 bd fb ff ff       	call   80104ef0 <argint>
80105333:	83 c4 10             	add    $0x10,%esp
80105336:	85 c0                	test   %eax,%eax
80105338:	78 5e                	js     80105398 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010533a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010533e:	77 58                	ja     80105398 <sys_write+0x78>
80105340:	e8 bb eb ff ff       	call   80103f00 <myproc>
80105345:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105348:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010534c:	85 f6                	test   %esi,%esi
8010534e:	74 48                	je     80105398 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105350:	83 ec 08             	sub    $0x8,%esp
80105353:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105356:	50                   	push   %eax
80105357:	6a 02                	push   $0x2
80105359:	e8 92 fb ff ff       	call   80104ef0 <argint>
8010535e:	83 c4 10             	add    $0x10,%esp
80105361:	85 c0                	test   %eax,%eax
80105363:	78 33                	js     80105398 <sys_write+0x78>
80105365:	83 ec 04             	sub    $0x4,%esp
80105368:	ff 75 f0             	push   -0x10(%ebp)
8010536b:	53                   	push   %ebx
8010536c:	6a 01                	push   $0x1
8010536e:	e8 cd fb ff ff       	call   80104f40 <argptr>
80105373:	83 c4 10             	add    $0x10,%esp
80105376:	85 c0                	test   %eax,%eax
80105378:	78 1e                	js     80105398 <sys_write+0x78>
  return filewrite(f, p, n);
8010537a:	83 ec 04             	sub    $0x4,%esp
8010537d:	ff 75 f0             	push   -0x10(%ebp)
80105380:	ff 75 f4             	push   -0xc(%ebp)
80105383:	56                   	push   %esi
80105384:	e8 e7 c2 ff ff       	call   80101670 <filewrite>
80105389:	83 c4 10             	add    $0x10,%esp
}
8010538c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010538f:	5b                   	pop    %ebx
80105390:	5e                   	pop    %esi
80105391:	5d                   	pop    %ebp
80105392:	c3                   	ret
80105393:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105398:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010539d:	eb ed                	jmp    8010538c <sys_write+0x6c>
8010539f:	90                   	nop

801053a0 <sys_close>:
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	56                   	push   %esi
801053a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801053a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801053a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801053ab:	50                   	push   %eax
801053ac:	6a 00                	push   $0x0
801053ae:	e8 3d fb ff ff       	call   80104ef0 <argint>
801053b3:	83 c4 10             	add    $0x10,%esp
801053b6:	85 c0                	test   %eax,%eax
801053b8:	78 3e                	js     801053f8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801053ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801053be:	77 38                	ja     801053f8 <sys_close+0x58>
801053c0:	e8 3b eb ff ff       	call   80103f00 <myproc>
801053c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053c8:	8d 5a 08             	lea    0x8(%edx),%ebx
801053cb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801053cf:	85 f6                	test   %esi,%esi
801053d1:	74 25                	je     801053f8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801053d3:	e8 28 eb ff ff       	call   80103f00 <myproc>
  fileclose(f);
801053d8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801053db:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801053e2:	00 
  fileclose(f);
801053e3:	56                   	push   %esi
801053e4:	e8 c7 c0 ff ff       	call   801014b0 <fileclose>
  return 0;
801053e9:	83 c4 10             	add    $0x10,%esp
801053ec:	31 c0                	xor    %eax,%eax
}
801053ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053f1:	5b                   	pop    %ebx
801053f2:	5e                   	pop    %esi
801053f3:	5d                   	pop    %ebp
801053f4:	c3                   	ret
801053f5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801053f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053fd:	eb ef                	jmp    801053ee <sys_close+0x4e>
801053ff:	90                   	nop

80105400 <sys_fstat>:
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	56                   	push   %esi
80105404:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105405:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105408:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010540b:	53                   	push   %ebx
8010540c:	6a 00                	push   $0x0
8010540e:	e8 dd fa ff ff       	call   80104ef0 <argint>
80105413:	83 c4 10             	add    $0x10,%esp
80105416:	85 c0                	test   %eax,%eax
80105418:	78 46                	js     80105460 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010541a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010541e:	77 40                	ja     80105460 <sys_fstat+0x60>
80105420:	e8 db ea ff ff       	call   80103f00 <myproc>
80105425:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105428:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010542c:	85 f6                	test   %esi,%esi
8010542e:	74 30                	je     80105460 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105430:	83 ec 04             	sub    $0x4,%esp
80105433:	6a 14                	push   $0x14
80105435:	53                   	push   %ebx
80105436:	6a 01                	push   $0x1
80105438:	e8 03 fb ff ff       	call   80104f40 <argptr>
8010543d:	83 c4 10             	add    $0x10,%esp
80105440:	85 c0                	test   %eax,%eax
80105442:	78 1c                	js     80105460 <sys_fstat+0x60>
  return filestat(f, st);
80105444:	83 ec 08             	sub    $0x8,%esp
80105447:	ff 75 f4             	push   -0xc(%ebp)
8010544a:	56                   	push   %esi
8010544b:	e8 40 c1 ff ff       	call   80101590 <filestat>
80105450:	83 c4 10             	add    $0x10,%esp
}
80105453:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105456:	5b                   	pop    %ebx
80105457:	5e                   	pop    %esi
80105458:	5d                   	pop    %ebp
80105459:	c3                   	ret
8010545a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105460:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105465:	eb ec                	jmp    80105453 <sys_fstat+0x53>
80105467:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010546e:	00 
8010546f:	90                   	nop

80105470 <sys_link>:
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	57                   	push   %edi
80105474:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105475:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105478:	53                   	push   %ebx
80105479:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010547c:	50                   	push   %eax
8010547d:	6a 00                	push   $0x0
8010547f:	e8 2c fb ff ff       	call   80104fb0 <argstr>
80105484:	83 c4 10             	add    $0x10,%esp
80105487:	85 c0                	test   %eax,%eax
80105489:	0f 88 fb 00 00 00    	js     8010558a <sys_link+0x11a>
8010548f:	83 ec 08             	sub    $0x8,%esp
80105492:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105495:	50                   	push   %eax
80105496:	6a 01                	push   $0x1
80105498:	e8 13 fb ff ff       	call   80104fb0 <argstr>
8010549d:	83 c4 10             	add    $0x10,%esp
801054a0:	85 c0                	test   %eax,%eax
801054a2:	0f 88 e2 00 00 00    	js     8010558a <sys_link+0x11a>
  begin_op();
801054a8:	e8 33 de ff ff       	call   801032e0 <begin_op>
  if((ip = namei(old)) == 0){
801054ad:	83 ec 0c             	sub    $0xc,%esp
801054b0:	ff 75 d4             	push   -0x2c(%ebp)
801054b3:	e8 68 d1 ff ff       	call   80102620 <namei>
801054b8:	83 c4 10             	add    $0x10,%esp
801054bb:	89 c3                	mov    %eax,%ebx
801054bd:	85 c0                	test   %eax,%eax
801054bf:	0f 84 df 00 00 00    	je     801055a4 <sys_link+0x134>
  ilock(ip);
801054c5:	83 ec 0c             	sub    $0xc,%esp
801054c8:	50                   	push   %eax
801054c9:	e8 72 c8 ff ff       	call   80101d40 <ilock>
  if(ip->type == T_DIR){
801054ce:	83 c4 10             	add    $0x10,%esp
801054d1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054d6:	0f 84 b5 00 00 00    	je     80105591 <sys_link+0x121>
  iupdate(ip);
801054dc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801054df:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801054e4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801054e7:	53                   	push   %ebx
801054e8:	e8 a3 c7 ff ff       	call   80101c90 <iupdate>
  iunlock(ip);
801054ed:	89 1c 24             	mov    %ebx,(%esp)
801054f0:	e8 2b c9 ff ff       	call   80101e20 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801054f5:	58                   	pop    %eax
801054f6:	5a                   	pop    %edx
801054f7:	57                   	push   %edi
801054f8:	ff 75 d0             	push   -0x30(%ebp)
801054fb:	e8 40 d1 ff ff       	call   80102640 <nameiparent>
80105500:	83 c4 10             	add    $0x10,%esp
80105503:	89 c6                	mov    %eax,%esi
80105505:	85 c0                	test   %eax,%eax
80105507:	74 5b                	je     80105564 <sys_link+0xf4>
  ilock(dp);
80105509:	83 ec 0c             	sub    $0xc,%esp
8010550c:	50                   	push   %eax
8010550d:	e8 2e c8 ff ff       	call   80101d40 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105512:	8b 03                	mov    (%ebx),%eax
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	39 06                	cmp    %eax,(%esi)
80105519:	75 3d                	jne    80105558 <sys_link+0xe8>
8010551b:	83 ec 04             	sub    $0x4,%esp
8010551e:	ff 73 04             	push   0x4(%ebx)
80105521:	57                   	push   %edi
80105522:	56                   	push   %esi
80105523:	e8 38 d0 ff ff       	call   80102560 <dirlink>
80105528:	83 c4 10             	add    $0x10,%esp
8010552b:	85 c0                	test   %eax,%eax
8010552d:	78 29                	js     80105558 <sys_link+0xe8>
  iunlockput(dp);
8010552f:	83 ec 0c             	sub    $0xc,%esp
80105532:	56                   	push   %esi
80105533:	e8 98 ca ff ff       	call   80101fd0 <iunlockput>
  iput(ip);
80105538:	89 1c 24             	mov    %ebx,(%esp)
8010553b:	e8 30 c9 ff ff       	call   80101e70 <iput>
  end_op();
80105540:	e8 0b de ff ff       	call   80103350 <end_op>
  return 0;
80105545:	83 c4 10             	add    $0x10,%esp
80105548:	31 c0                	xor    %eax,%eax
}
8010554a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010554d:	5b                   	pop    %ebx
8010554e:	5e                   	pop    %esi
8010554f:	5f                   	pop    %edi
80105550:	5d                   	pop    %ebp
80105551:	c3                   	ret
80105552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105558:	83 ec 0c             	sub    $0xc,%esp
8010555b:	56                   	push   %esi
8010555c:	e8 6f ca ff ff       	call   80101fd0 <iunlockput>
    goto bad;
80105561:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105564:	83 ec 0c             	sub    $0xc,%esp
80105567:	53                   	push   %ebx
80105568:	e8 d3 c7 ff ff       	call   80101d40 <ilock>
  ip->nlink--;
8010556d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105572:	89 1c 24             	mov    %ebx,(%esp)
80105575:	e8 16 c7 ff ff       	call   80101c90 <iupdate>
  iunlockput(ip);
8010557a:	89 1c 24             	mov    %ebx,(%esp)
8010557d:	e8 4e ca ff ff       	call   80101fd0 <iunlockput>
  end_op();
80105582:	e8 c9 dd ff ff       	call   80103350 <end_op>
  return -1;
80105587:	83 c4 10             	add    $0x10,%esp
    return -1;
8010558a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010558f:	eb b9                	jmp    8010554a <sys_link+0xda>
    iunlockput(ip);
80105591:	83 ec 0c             	sub    $0xc,%esp
80105594:	53                   	push   %ebx
80105595:	e8 36 ca ff ff       	call   80101fd0 <iunlockput>
    end_op();
8010559a:	e8 b1 dd ff ff       	call   80103350 <end_op>
    return -1;
8010559f:	83 c4 10             	add    $0x10,%esp
801055a2:	eb e6                	jmp    8010558a <sys_link+0x11a>
    end_op();
801055a4:	e8 a7 dd ff ff       	call   80103350 <end_op>
    return -1;
801055a9:	eb df                	jmp    8010558a <sys_link+0x11a>
801055ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801055b0 <sys_unlink>:
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	57                   	push   %edi
801055b4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801055b5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801055b8:	53                   	push   %ebx
801055b9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801055bc:	50                   	push   %eax
801055bd:	6a 00                	push   $0x0
801055bf:	e8 ec f9 ff ff       	call   80104fb0 <argstr>
801055c4:	83 c4 10             	add    $0x10,%esp
801055c7:	85 c0                	test   %eax,%eax
801055c9:	0f 88 54 01 00 00    	js     80105723 <sys_unlink+0x173>
  begin_op();
801055cf:	e8 0c dd ff ff       	call   801032e0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801055d4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801055d7:	83 ec 08             	sub    $0x8,%esp
801055da:	53                   	push   %ebx
801055db:	ff 75 c0             	push   -0x40(%ebp)
801055de:	e8 5d d0 ff ff       	call   80102640 <nameiparent>
801055e3:	83 c4 10             	add    $0x10,%esp
801055e6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801055e9:	85 c0                	test   %eax,%eax
801055eb:	0f 84 58 01 00 00    	je     80105749 <sys_unlink+0x199>
  ilock(dp);
801055f1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801055f4:	83 ec 0c             	sub    $0xc,%esp
801055f7:	57                   	push   %edi
801055f8:	e8 43 c7 ff ff       	call   80101d40 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801055fd:	58                   	pop    %eax
801055fe:	5a                   	pop    %edx
801055ff:	68 a9 7a 10 80       	push   $0x80107aa9
80105604:	53                   	push   %ebx
80105605:	e8 66 cc ff ff       	call   80102270 <namecmp>
8010560a:	83 c4 10             	add    $0x10,%esp
8010560d:	85 c0                	test   %eax,%eax
8010560f:	0f 84 fb 00 00 00    	je     80105710 <sys_unlink+0x160>
80105615:	83 ec 08             	sub    $0x8,%esp
80105618:	68 a8 7a 10 80       	push   $0x80107aa8
8010561d:	53                   	push   %ebx
8010561e:	e8 4d cc ff ff       	call   80102270 <namecmp>
80105623:	83 c4 10             	add    $0x10,%esp
80105626:	85 c0                	test   %eax,%eax
80105628:	0f 84 e2 00 00 00    	je     80105710 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010562e:	83 ec 04             	sub    $0x4,%esp
80105631:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105634:	50                   	push   %eax
80105635:	53                   	push   %ebx
80105636:	57                   	push   %edi
80105637:	e8 54 cc ff ff       	call   80102290 <dirlookup>
8010563c:	83 c4 10             	add    $0x10,%esp
8010563f:	89 c3                	mov    %eax,%ebx
80105641:	85 c0                	test   %eax,%eax
80105643:	0f 84 c7 00 00 00    	je     80105710 <sys_unlink+0x160>
  ilock(ip);
80105649:	83 ec 0c             	sub    $0xc,%esp
8010564c:	50                   	push   %eax
8010564d:	e8 ee c6 ff ff       	call   80101d40 <ilock>
  if(ip->nlink < 1)
80105652:	83 c4 10             	add    $0x10,%esp
80105655:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010565a:	0f 8e 0a 01 00 00    	jle    8010576a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105660:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105665:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105668:	74 66                	je     801056d0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010566a:	83 ec 04             	sub    $0x4,%esp
8010566d:	6a 10                	push   $0x10
8010566f:	6a 00                	push   $0x0
80105671:	57                   	push   %edi
80105672:	e8 c9 f5 ff ff       	call   80104c40 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105677:	6a 10                	push   $0x10
80105679:	ff 75 c4             	push   -0x3c(%ebp)
8010567c:	57                   	push   %edi
8010567d:	ff 75 b4             	push   -0x4c(%ebp)
80105680:	e8 cb ca ff ff       	call   80102150 <writei>
80105685:	83 c4 20             	add    $0x20,%esp
80105688:	83 f8 10             	cmp    $0x10,%eax
8010568b:	0f 85 cc 00 00 00    	jne    8010575d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105691:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105696:	0f 84 94 00 00 00    	je     80105730 <sys_unlink+0x180>
  iunlockput(dp);
8010569c:	83 ec 0c             	sub    $0xc,%esp
8010569f:	ff 75 b4             	push   -0x4c(%ebp)
801056a2:	e8 29 c9 ff ff       	call   80101fd0 <iunlockput>
  ip->nlink--;
801056a7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801056ac:	89 1c 24             	mov    %ebx,(%esp)
801056af:	e8 dc c5 ff ff       	call   80101c90 <iupdate>
  iunlockput(ip);
801056b4:	89 1c 24             	mov    %ebx,(%esp)
801056b7:	e8 14 c9 ff ff       	call   80101fd0 <iunlockput>
  end_op();
801056bc:	e8 8f dc ff ff       	call   80103350 <end_op>
  return 0;
801056c1:	83 c4 10             	add    $0x10,%esp
801056c4:	31 c0                	xor    %eax,%eax
}
801056c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056c9:	5b                   	pop    %ebx
801056ca:	5e                   	pop    %esi
801056cb:	5f                   	pop    %edi
801056cc:	5d                   	pop    %ebp
801056cd:	c3                   	ret
801056ce:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801056d0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801056d4:	76 94                	jbe    8010566a <sys_unlink+0xba>
801056d6:	be 20 00 00 00       	mov    $0x20,%esi
801056db:	eb 0b                	jmp    801056e8 <sys_unlink+0x138>
801056dd:	8d 76 00             	lea    0x0(%esi),%esi
801056e0:	83 c6 10             	add    $0x10,%esi
801056e3:	3b 73 58             	cmp    0x58(%ebx),%esi
801056e6:	73 82                	jae    8010566a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801056e8:	6a 10                	push   $0x10
801056ea:	56                   	push   %esi
801056eb:	57                   	push   %edi
801056ec:	53                   	push   %ebx
801056ed:	e8 5e c9 ff ff       	call   80102050 <readi>
801056f2:	83 c4 10             	add    $0x10,%esp
801056f5:	83 f8 10             	cmp    $0x10,%eax
801056f8:	75 56                	jne    80105750 <sys_unlink+0x1a0>
    if(de.inum != 0)
801056fa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801056ff:	74 df                	je     801056e0 <sys_unlink+0x130>
    iunlockput(ip);
80105701:	83 ec 0c             	sub    $0xc,%esp
80105704:	53                   	push   %ebx
80105705:	e8 c6 c8 ff ff       	call   80101fd0 <iunlockput>
    goto bad;
8010570a:	83 c4 10             	add    $0x10,%esp
8010570d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105710:	83 ec 0c             	sub    $0xc,%esp
80105713:	ff 75 b4             	push   -0x4c(%ebp)
80105716:	e8 b5 c8 ff ff       	call   80101fd0 <iunlockput>
  end_op();
8010571b:	e8 30 dc ff ff       	call   80103350 <end_op>
  return -1;
80105720:	83 c4 10             	add    $0x10,%esp
    return -1;
80105723:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105728:	eb 9c                	jmp    801056c6 <sys_unlink+0x116>
8010572a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105730:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105733:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105736:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010573b:	50                   	push   %eax
8010573c:	e8 4f c5 ff ff       	call   80101c90 <iupdate>
80105741:	83 c4 10             	add    $0x10,%esp
80105744:	e9 53 ff ff ff       	jmp    8010569c <sys_unlink+0xec>
    end_op();
80105749:	e8 02 dc ff ff       	call   80103350 <end_op>
    return -1;
8010574e:	eb d3                	jmp    80105723 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105750:	83 ec 0c             	sub    $0xc,%esp
80105753:	68 cd 7a 10 80       	push   $0x80107acd
80105758:	e8 23 ac ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010575d:	83 ec 0c             	sub    $0xc,%esp
80105760:	68 df 7a 10 80       	push   $0x80107adf
80105765:	e8 16 ac ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010576a:	83 ec 0c             	sub    $0xc,%esp
8010576d:	68 bb 7a 10 80       	push   $0x80107abb
80105772:	e8 09 ac ff ff       	call   80100380 <panic>
80105777:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010577e:	00 
8010577f:	90                   	nop

80105780 <sys_open>:

int
sys_open(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	57                   	push   %edi
80105784:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105785:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105788:	53                   	push   %ebx
80105789:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010578c:	50                   	push   %eax
8010578d:	6a 00                	push   $0x0
8010578f:	e8 1c f8 ff ff       	call   80104fb0 <argstr>
80105794:	83 c4 10             	add    $0x10,%esp
80105797:	85 c0                	test   %eax,%eax
80105799:	0f 88 8e 00 00 00    	js     8010582d <sys_open+0xad>
8010579f:	83 ec 08             	sub    $0x8,%esp
801057a2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801057a5:	50                   	push   %eax
801057a6:	6a 01                	push   $0x1
801057a8:	e8 43 f7 ff ff       	call   80104ef0 <argint>
801057ad:	83 c4 10             	add    $0x10,%esp
801057b0:	85 c0                	test   %eax,%eax
801057b2:	78 79                	js     8010582d <sys_open+0xad>
    return -1;

  begin_op();
801057b4:	e8 27 db ff ff       	call   801032e0 <begin_op>

  if(omode & O_CREATE){
801057b9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801057bd:	75 79                	jne    80105838 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801057bf:	83 ec 0c             	sub    $0xc,%esp
801057c2:	ff 75 e0             	push   -0x20(%ebp)
801057c5:	e8 56 ce ff ff       	call   80102620 <namei>
801057ca:	83 c4 10             	add    $0x10,%esp
801057cd:	89 c6                	mov    %eax,%esi
801057cf:	85 c0                	test   %eax,%eax
801057d1:	0f 84 7e 00 00 00    	je     80105855 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801057d7:	83 ec 0c             	sub    $0xc,%esp
801057da:	50                   	push   %eax
801057db:	e8 60 c5 ff ff       	call   80101d40 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801057e0:	83 c4 10             	add    $0x10,%esp
801057e3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801057e8:	0f 84 ba 00 00 00    	je     801058a8 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801057ee:	e8 fd bb ff ff       	call   801013f0 <filealloc>
801057f3:	89 c7                	mov    %eax,%edi
801057f5:	85 c0                	test   %eax,%eax
801057f7:	74 23                	je     8010581c <sys_open+0x9c>
  struct proc *curproc = myproc();
801057f9:	e8 02 e7 ff ff       	call   80103f00 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801057fe:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105800:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105804:	85 d2                	test   %edx,%edx
80105806:	74 58                	je     80105860 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105808:	83 c3 01             	add    $0x1,%ebx
8010580b:	83 fb 10             	cmp    $0x10,%ebx
8010580e:	75 f0                	jne    80105800 <sys_open+0x80>
    if(f)
      fileclose(f);
80105810:	83 ec 0c             	sub    $0xc,%esp
80105813:	57                   	push   %edi
80105814:	e8 97 bc ff ff       	call   801014b0 <fileclose>
80105819:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010581c:	83 ec 0c             	sub    $0xc,%esp
8010581f:	56                   	push   %esi
80105820:	e8 ab c7 ff ff       	call   80101fd0 <iunlockput>
    end_op();
80105825:	e8 26 db ff ff       	call   80103350 <end_op>
    return -1;
8010582a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010582d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105832:	eb 65                	jmp    80105899 <sys_open+0x119>
80105834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105838:	83 ec 0c             	sub    $0xc,%esp
8010583b:	31 c9                	xor    %ecx,%ecx
8010583d:	ba 02 00 00 00       	mov    $0x2,%edx
80105842:	6a 00                	push   $0x0
80105844:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105847:	e8 54 f8 ff ff       	call   801050a0 <create>
    if(ip == 0){
8010584c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010584f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105851:	85 c0                	test   %eax,%eax
80105853:	75 99                	jne    801057ee <sys_open+0x6e>
      end_op();
80105855:	e8 f6 da ff ff       	call   80103350 <end_op>
      return -1;
8010585a:	eb d1                	jmp    8010582d <sys_open+0xad>
8010585c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105860:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105863:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105867:	56                   	push   %esi
80105868:	e8 b3 c5 ff ff       	call   80101e20 <iunlock>
  end_op();
8010586d:	e8 de da ff ff       	call   80103350 <end_op>

  f->type = FD_INODE;
80105872:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105878:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010587b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010587e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105881:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105883:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010588a:	f7 d0                	not    %eax
8010588c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010588f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105892:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105895:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105899:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010589c:	89 d8                	mov    %ebx,%eax
8010589e:	5b                   	pop    %ebx
8010589f:	5e                   	pop    %esi
801058a0:	5f                   	pop    %edi
801058a1:	5d                   	pop    %ebp
801058a2:	c3                   	ret
801058a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801058a8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801058ab:	85 c9                	test   %ecx,%ecx
801058ad:	0f 84 3b ff ff ff    	je     801057ee <sys_open+0x6e>
801058b3:	e9 64 ff ff ff       	jmp    8010581c <sys_open+0x9c>
801058b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058bf:	00 

801058c0 <sys_mkdir>:

int
sys_mkdir(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801058c6:	e8 15 da ff ff       	call   801032e0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801058cb:	83 ec 08             	sub    $0x8,%esp
801058ce:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058d1:	50                   	push   %eax
801058d2:	6a 00                	push   $0x0
801058d4:	e8 d7 f6 ff ff       	call   80104fb0 <argstr>
801058d9:	83 c4 10             	add    $0x10,%esp
801058dc:	85 c0                	test   %eax,%eax
801058de:	78 30                	js     80105910 <sys_mkdir+0x50>
801058e0:	83 ec 0c             	sub    $0xc,%esp
801058e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058e6:	31 c9                	xor    %ecx,%ecx
801058e8:	ba 01 00 00 00       	mov    $0x1,%edx
801058ed:	6a 00                	push   $0x0
801058ef:	e8 ac f7 ff ff       	call   801050a0 <create>
801058f4:	83 c4 10             	add    $0x10,%esp
801058f7:	85 c0                	test   %eax,%eax
801058f9:	74 15                	je     80105910 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801058fb:	83 ec 0c             	sub    $0xc,%esp
801058fe:	50                   	push   %eax
801058ff:	e8 cc c6 ff ff       	call   80101fd0 <iunlockput>
  end_op();
80105904:	e8 47 da ff ff       	call   80103350 <end_op>
  return 0;
80105909:	83 c4 10             	add    $0x10,%esp
8010590c:	31 c0                	xor    %eax,%eax
}
8010590e:	c9                   	leave
8010590f:	c3                   	ret
    end_op();
80105910:	e8 3b da ff ff       	call   80103350 <end_op>
    return -1;
80105915:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010591a:	c9                   	leave
8010591b:	c3                   	ret
8010591c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105920 <sys_mknod>:

int
sys_mknod(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105926:	e8 b5 d9 ff ff       	call   801032e0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010592b:	83 ec 08             	sub    $0x8,%esp
8010592e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105931:	50                   	push   %eax
80105932:	6a 00                	push   $0x0
80105934:	e8 77 f6 ff ff       	call   80104fb0 <argstr>
80105939:	83 c4 10             	add    $0x10,%esp
8010593c:	85 c0                	test   %eax,%eax
8010593e:	78 60                	js     801059a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105940:	83 ec 08             	sub    $0x8,%esp
80105943:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105946:	50                   	push   %eax
80105947:	6a 01                	push   $0x1
80105949:	e8 a2 f5 ff ff       	call   80104ef0 <argint>
  if((argstr(0, &path)) < 0 ||
8010594e:	83 c4 10             	add    $0x10,%esp
80105951:	85 c0                	test   %eax,%eax
80105953:	78 4b                	js     801059a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105955:	83 ec 08             	sub    $0x8,%esp
80105958:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010595b:	50                   	push   %eax
8010595c:	6a 02                	push   $0x2
8010595e:	e8 8d f5 ff ff       	call   80104ef0 <argint>
     argint(1, &major) < 0 ||
80105963:	83 c4 10             	add    $0x10,%esp
80105966:	85 c0                	test   %eax,%eax
80105968:	78 36                	js     801059a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010596a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010596e:	83 ec 0c             	sub    $0xc,%esp
80105971:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105975:	ba 03 00 00 00       	mov    $0x3,%edx
8010597a:	50                   	push   %eax
8010597b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010597e:	e8 1d f7 ff ff       	call   801050a0 <create>
     argint(2, &minor) < 0 ||
80105983:	83 c4 10             	add    $0x10,%esp
80105986:	85 c0                	test   %eax,%eax
80105988:	74 16                	je     801059a0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010598a:	83 ec 0c             	sub    $0xc,%esp
8010598d:	50                   	push   %eax
8010598e:	e8 3d c6 ff ff       	call   80101fd0 <iunlockput>
  end_op();
80105993:	e8 b8 d9 ff ff       	call   80103350 <end_op>
  return 0;
80105998:	83 c4 10             	add    $0x10,%esp
8010599b:	31 c0                	xor    %eax,%eax
}
8010599d:	c9                   	leave
8010599e:	c3                   	ret
8010599f:	90                   	nop
    end_op();
801059a0:	e8 ab d9 ff ff       	call   80103350 <end_op>
    return -1;
801059a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059aa:	c9                   	leave
801059ab:	c3                   	ret
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059b0 <sys_chdir>:

int
sys_chdir(void)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	56                   	push   %esi
801059b4:	53                   	push   %ebx
801059b5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801059b8:	e8 43 e5 ff ff       	call   80103f00 <myproc>
801059bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801059bf:	e8 1c d9 ff ff       	call   801032e0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801059c4:	83 ec 08             	sub    $0x8,%esp
801059c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059ca:	50                   	push   %eax
801059cb:	6a 00                	push   $0x0
801059cd:	e8 de f5 ff ff       	call   80104fb0 <argstr>
801059d2:	83 c4 10             	add    $0x10,%esp
801059d5:	85 c0                	test   %eax,%eax
801059d7:	78 77                	js     80105a50 <sys_chdir+0xa0>
801059d9:	83 ec 0c             	sub    $0xc,%esp
801059dc:	ff 75 f4             	push   -0xc(%ebp)
801059df:	e8 3c cc ff ff       	call   80102620 <namei>
801059e4:	83 c4 10             	add    $0x10,%esp
801059e7:	89 c3                	mov    %eax,%ebx
801059e9:	85 c0                	test   %eax,%eax
801059eb:	74 63                	je     80105a50 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801059ed:	83 ec 0c             	sub    $0xc,%esp
801059f0:	50                   	push   %eax
801059f1:	e8 4a c3 ff ff       	call   80101d40 <ilock>
  if(ip->type != T_DIR){
801059f6:	83 c4 10             	add    $0x10,%esp
801059f9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801059fe:	75 30                	jne    80105a30 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105a00:	83 ec 0c             	sub    $0xc,%esp
80105a03:	53                   	push   %ebx
80105a04:	e8 17 c4 ff ff       	call   80101e20 <iunlock>
  iput(curproc->cwd);
80105a09:	58                   	pop    %eax
80105a0a:	ff 76 68             	push   0x68(%esi)
80105a0d:	e8 5e c4 ff ff       	call   80101e70 <iput>
  end_op();
80105a12:	e8 39 d9 ff ff       	call   80103350 <end_op>
  curproc->cwd = ip;
80105a17:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105a1a:	83 c4 10             	add    $0x10,%esp
80105a1d:	31 c0                	xor    %eax,%eax
}
80105a1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a22:	5b                   	pop    %ebx
80105a23:	5e                   	pop    %esi
80105a24:	5d                   	pop    %ebp
80105a25:	c3                   	ret
80105a26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a2d:	00 
80105a2e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105a30:	83 ec 0c             	sub    $0xc,%esp
80105a33:	53                   	push   %ebx
80105a34:	e8 97 c5 ff ff       	call   80101fd0 <iunlockput>
    end_op();
80105a39:	e8 12 d9 ff ff       	call   80103350 <end_op>
    return -1;
80105a3e:	83 c4 10             	add    $0x10,%esp
    return -1;
80105a41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a46:	eb d7                	jmp    80105a1f <sys_chdir+0x6f>
80105a48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a4f:	00 
    end_op();
80105a50:	e8 fb d8 ff ff       	call   80103350 <end_op>
    return -1;
80105a55:	eb ea                	jmp    80105a41 <sys_chdir+0x91>
80105a57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a5e:	00 
80105a5f:	90                   	nop

80105a60 <sys_exec>:

int
sys_exec(void)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	57                   	push   %edi
80105a64:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105a65:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105a6b:	53                   	push   %ebx
80105a6c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105a72:	50                   	push   %eax
80105a73:	6a 00                	push   $0x0
80105a75:	e8 36 f5 ff ff       	call   80104fb0 <argstr>
80105a7a:	83 c4 10             	add    $0x10,%esp
80105a7d:	85 c0                	test   %eax,%eax
80105a7f:	0f 88 87 00 00 00    	js     80105b0c <sys_exec+0xac>
80105a85:	83 ec 08             	sub    $0x8,%esp
80105a88:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105a8e:	50                   	push   %eax
80105a8f:	6a 01                	push   $0x1
80105a91:	e8 5a f4 ff ff       	call   80104ef0 <argint>
80105a96:	83 c4 10             	add    $0x10,%esp
80105a99:	85 c0                	test   %eax,%eax
80105a9b:	78 6f                	js     80105b0c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105a9d:	83 ec 04             	sub    $0x4,%esp
80105aa0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105aa6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105aa8:	68 80 00 00 00       	push   $0x80
80105aad:	6a 00                	push   $0x0
80105aaf:	56                   	push   %esi
80105ab0:	e8 8b f1 ff ff       	call   80104c40 <memset>
80105ab5:	83 c4 10             	add    $0x10,%esp
80105ab8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105abf:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105ac0:	83 ec 08             	sub    $0x8,%esp
80105ac3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105ac9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105ad0:	50                   	push   %eax
80105ad1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105ad7:	01 f8                	add    %edi,%eax
80105ad9:	50                   	push   %eax
80105ada:	e8 81 f3 ff ff       	call   80104e60 <fetchint>
80105adf:	83 c4 10             	add    $0x10,%esp
80105ae2:	85 c0                	test   %eax,%eax
80105ae4:	78 26                	js     80105b0c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105ae6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105aec:	85 c0                	test   %eax,%eax
80105aee:	74 30                	je     80105b20 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105af0:	83 ec 08             	sub    $0x8,%esp
80105af3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105af6:	52                   	push   %edx
80105af7:	50                   	push   %eax
80105af8:	e8 a3 f3 ff ff       	call   80104ea0 <fetchstr>
80105afd:	83 c4 10             	add    $0x10,%esp
80105b00:	85 c0                	test   %eax,%eax
80105b02:	78 08                	js     80105b0c <sys_exec+0xac>
  for(i=0;; i++){
80105b04:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105b07:	83 fb 20             	cmp    $0x20,%ebx
80105b0a:	75 b4                	jne    80105ac0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105b0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105b0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b14:	5b                   	pop    %ebx
80105b15:	5e                   	pop    %esi
80105b16:	5f                   	pop    %edi
80105b17:	5d                   	pop    %ebp
80105b18:	c3                   	ret
80105b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105b20:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105b27:	00 00 00 00 
  return exec(path, argv);
80105b2b:	83 ec 08             	sub    $0x8,%esp
80105b2e:	56                   	push   %esi
80105b2f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105b35:	e8 16 b5 ff ff       	call   80101050 <exec>
80105b3a:	83 c4 10             	add    $0x10,%esp
}
80105b3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b40:	5b                   	pop    %ebx
80105b41:	5e                   	pop    %esi
80105b42:	5f                   	pop    %edi
80105b43:	5d                   	pop    %ebp
80105b44:	c3                   	ret
80105b45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b4c:	00 
80105b4d:	8d 76 00             	lea    0x0(%esi),%esi

80105b50 <sys_pipe>:

int
sys_pipe(void)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	57                   	push   %edi
80105b54:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105b55:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105b58:	53                   	push   %ebx
80105b59:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105b5c:	6a 08                	push   $0x8
80105b5e:	50                   	push   %eax
80105b5f:	6a 00                	push   $0x0
80105b61:	e8 da f3 ff ff       	call   80104f40 <argptr>
80105b66:	83 c4 10             	add    $0x10,%esp
80105b69:	85 c0                	test   %eax,%eax
80105b6b:	0f 88 8b 00 00 00    	js     80105bfc <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105b71:	83 ec 08             	sub    $0x8,%esp
80105b74:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b77:	50                   	push   %eax
80105b78:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105b7b:	50                   	push   %eax
80105b7c:	e8 2f de ff ff       	call   801039b0 <pipealloc>
80105b81:	83 c4 10             	add    $0x10,%esp
80105b84:	85 c0                	test   %eax,%eax
80105b86:	78 74                	js     80105bfc <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105b88:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105b8b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105b8d:	e8 6e e3 ff ff       	call   80103f00 <myproc>
    if(curproc->ofile[fd] == 0){
80105b92:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105b96:	85 f6                	test   %esi,%esi
80105b98:	74 16                	je     80105bb0 <sys_pipe+0x60>
80105b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105ba0:	83 c3 01             	add    $0x1,%ebx
80105ba3:	83 fb 10             	cmp    $0x10,%ebx
80105ba6:	74 3d                	je     80105be5 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80105ba8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105bac:	85 f6                	test   %esi,%esi
80105bae:	75 f0                	jne    80105ba0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105bb0:	8d 73 08             	lea    0x8(%ebx),%esi
80105bb3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105bb7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105bba:	e8 41 e3 ff ff       	call   80103f00 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105bbf:	31 d2                	xor    %edx,%edx
80105bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105bc8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105bcc:	85 c9                	test   %ecx,%ecx
80105bce:	74 38                	je     80105c08 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80105bd0:	83 c2 01             	add    $0x1,%edx
80105bd3:	83 fa 10             	cmp    $0x10,%edx
80105bd6:	75 f0                	jne    80105bc8 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105bd8:	e8 23 e3 ff ff       	call   80103f00 <myproc>
80105bdd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105be4:	00 
    fileclose(rf);
80105be5:	83 ec 0c             	sub    $0xc,%esp
80105be8:	ff 75 e0             	push   -0x20(%ebp)
80105beb:	e8 c0 b8 ff ff       	call   801014b0 <fileclose>
    fileclose(wf);
80105bf0:	58                   	pop    %eax
80105bf1:	ff 75 e4             	push   -0x1c(%ebp)
80105bf4:	e8 b7 b8 ff ff       	call   801014b0 <fileclose>
    return -1;
80105bf9:	83 c4 10             	add    $0x10,%esp
    return -1;
80105bfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c01:	eb 16                	jmp    80105c19 <sys_pipe+0xc9>
80105c03:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105c08:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105c0c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105c0f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105c11:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105c14:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105c17:	31 c0                	xor    %eax,%eax
}
80105c19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c1c:	5b                   	pop    %ebx
80105c1d:	5e                   	pop    %esi
80105c1e:	5f                   	pop    %edi
80105c1f:	5d                   	pop    %ebp
80105c20:	c3                   	ret
80105c21:	66 90                	xchg   %ax,%ax
80105c23:	66 90                	xchg   %ax,%ax
80105c25:	66 90                	xchg   %ax,%ax
80105c27:	66 90                	xchg   %ax,%ax
80105c29:	66 90                	xchg   %ax,%ax
80105c2b:	66 90                	xchg   %ax,%ax
80105c2d:	66 90                	xchg   %ax,%ax
80105c2f:	90                   	nop

80105c30 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105c30:	e9 6b e4 ff ff       	jmp    801040a0 <fork>
80105c35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c3c:	00 
80105c3d:	8d 76 00             	lea    0x0(%esi),%esi

80105c40 <sys_exit>:
}

int
sys_exit(void)
{
80105c40:	55                   	push   %ebp
80105c41:	89 e5                	mov    %esp,%ebp
80105c43:	83 ec 08             	sub    $0x8,%esp
  exit();
80105c46:	e8 c5 e6 ff ff       	call   80104310 <exit>
  return 0;  // not reached
}
80105c4b:	31 c0                	xor    %eax,%eax
80105c4d:	c9                   	leave
80105c4e:	c3                   	ret
80105c4f:	90                   	nop

80105c50 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105c50:	e9 eb e7 ff ff       	jmp    80104440 <wait>
80105c55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c5c:	00 
80105c5d:	8d 76 00             	lea    0x0(%esi),%esi

80105c60 <sys_kill>:
}

int
sys_kill(void)
{
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105c66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c69:	50                   	push   %eax
80105c6a:	6a 00                	push   $0x0
80105c6c:	e8 7f f2 ff ff       	call   80104ef0 <argint>
80105c71:	83 c4 10             	add    $0x10,%esp
80105c74:	85 c0                	test   %eax,%eax
80105c76:	78 18                	js     80105c90 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105c78:	83 ec 0c             	sub    $0xc,%esp
80105c7b:	ff 75 f4             	push   -0xc(%ebp)
80105c7e:	e8 5d ea ff ff       	call   801046e0 <kill>
80105c83:	83 c4 10             	add    $0x10,%esp
}
80105c86:	c9                   	leave
80105c87:	c3                   	ret
80105c88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c8f:	00 
80105c90:	c9                   	leave
    return -1;
80105c91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c96:	c3                   	ret
80105c97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c9e:	00 
80105c9f:	90                   	nop

80105ca0 <sys_getpid>:

int
sys_getpid(void)
{
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105ca6:	e8 55 e2 ff ff       	call   80103f00 <myproc>
80105cab:	8b 40 10             	mov    0x10(%eax),%eax
}
80105cae:	c9                   	leave
80105caf:	c3                   	ret

80105cb0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105cb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105cb7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105cba:	50                   	push   %eax
80105cbb:	6a 00                	push   $0x0
80105cbd:	e8 2e f2 ff ff       	call   80104ef0 <argint>
80105cc2:	83 c4 10             	add    $0x10,%esp
80105cc5:	85 c0                	test   %eax,%eax
80105cc7:	78 27                	js     80105cf0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105cc9:	e8 32 e2 ff ff       	call   80103f00 <myproc>
  if(growproc(n) < 0)
80105cce:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105cd1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105cd3:	ff 75 f4             	push   -0xc(%ebp)
80105cd6:	e8 45 e3 ff ff       	call   80104020 <growproc>
80105cdb:	83 c4 10             	add    $0x10,%esp
80105cde:	85 c0                	test   %eax,%eax
80105ce0:	78 0e                	js     80105cf0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105ce2:	89 d8                	mov    %ebx,%eax
80105ce4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ce7:	c9                   	leave
80105ce8:	c3                   	ret
80105ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105cf0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105cf5:	eb eb                	jmp    80105ce2 <sys_sbrk+0x32>
80105cf7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cfe:	00 
80105cff:	90                   	nop

80105d00 <sys_sleep>:

int
sys_sleep(void)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105d04:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105d07:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105d0a:	50                   	push   %eax
80105d0b:	6a 00                	push   $0x0
80105d0d:	e8 de f1 ff ff       	call   80104ef0 <argint>
80105d12:	83 c4 10             	add    $0x10,%esp
80105d15:	85 c0                	test   %eax,%eax
80105d17:	78 64                	js     80105d7d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105d19:	83 ec 0c             	sub    $0xc,%esp
80105d1c:	68 a0 4c 11 80       	push   $0x80114ca0
80105d21:	e8 1a ee ff ff       	call   80104b40 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105d26:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105d29:	8b 1d 80 4c 11 80    	mov    0x80114c80,%ebx
  while(ticks - ticks0 < n){
80105d2f:	83 c4 10             	add    $0x10,%esp
80105d32:	85 d2                	test   %edx,%edx
80105d34:	75 2b                	jne    80105d61 <sys_sleep+0x61>
80105d36:	eb 58                	jmp    80105d90 <sys_sleep+0x90>
80105d38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d3f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105d40:	83 ec 08             	sub    $0x8,%esp
80105d43:	68 a0 4c 11 80       	push   $0x80114ca0
80105d48:	68 80 4c 11 80       	push   $0x80114c80
80105d4d:	e8 6e e8 ff ff       	call   801045c0 <sleep>
  while(ticks - ticks0 < n){
80105d52:	a1 80 4c 11 80       	mov    0x80114c80,%eax
80105d57:	83 c4 10             	add    $0x10,%esp
80105d5a:	29 d8                	sub    %ebx,%eax
80105d5c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105d5f:	73 2f                	jae    80105d90 <sys_sleep+0x90>
    if(myproc()->killed){
80105d61:	e8 9a e1 ff ff       	call   80103f00 <myproc>
80105d66:	8b 40 24             	mov    0x24(%eax),%eax
80105d69:	85 c0                	test   %eax,%eax
80105d6b:	74 d3                	je     80105d40 <sys_sleep+0x40>
      release(&tickslock);
80105d6d:	83 ec 0c             	sub    $0xc,%esp
80105d70:	68 a0 4c 11 80       	push   $0x80114ca0
80105d75:	e8 66 ed ff ff       	call   80104ae0 <release>
      return -1;
80105d7a:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
80105d7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d85:	c9                   	leave
80105d86:	c3                   	ret
80105d87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d8e:	00 
80105d8f:	90                   	nop
  release(&tickslock);
80105d90:	83 ec 0c             	sub    $0xc,%esp
80105d93:	68 a0 4c 11 80       	push   $0x80114ca0
80105d98:	e8 43 ed ff ff       	call   80104ae0 <release>
}
80105d9d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80105da0:	83 c4 10             	add    $0x10,%esp
80105da3:	31 c0                	xor    %eax,%eax
}
80105da5:	c9                   	leave
80105da6:	c3                   	ret
80105da7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105dae:	00 
80105daf:	90                   	nop

80105db0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	53                   	push   %ebx
80105db4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105db7:	68 a0 4c 11 80       	push   $0x80114ca0
80105dbc:	e8 7f ed ff ff       	call   80104b40 <acquire>
  xticks = ticks;
80105dc1:	8b 1d 80 4c 11 80    	mov    0x80114c80,%ebx
  release(&tickslock);
80105dc7:	c7 04 24 a0 4c 11 80 	movl   $0x80114ca0,(%esp)
80105dce:	e8 0d ed ff ff       	call   80104ae0 <release>
  return xticks;
}
80105dd3:	89 d8                	mov    %ebx,%eax
80105dd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105dd8:	c9                   	leave
80105dd9:	c3                   	ret

80105dda <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105dda:	1e                   	push   %ds
  pushl %es
80105ddb:	06                   	push   %es
  pushl %fs
80105ddc:	0f a0                	push   %fs
  pushl %gs
80105dde:	0f a8                	push   %gs
  pushal
80105de0:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105de1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105de5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105de7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105de9:	54                   	push   %esp
  call trap
80105dea:	e8 c1 00 00 00       	call   80105eb0 <trap>
  addl $4, %esp
80105def:	83 c4 04             	add    $0x4,%esp

80105df2 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105df2:	61                   	popa
  popl %gs
80105df3:	0f a9                	pop    %gs
  popl %fs
80105df5:	0f a1                	pop    %fs
  popl %es
80105df7:	07                   	pop    %es
  popl %ds
80105df8:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105df9:	83 c4 08             	add    $0x8,%esp
  iret
80105dfc:	cf                   	iret
80105dfd:	66 90                	xchg   %ax,%ax
80105dff:	90                   	nop

80105e00 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105e00:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105e01:	31 c0                	xor    %eax,%eax
{
80105e03:	89 e5                	mov    %esp,%ebp
80105e05:	83 ec 08             	sub    $0x8,%esp
80105e08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e0f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105e10:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105e17:	c7 04 c5 e2 4c 11 80 	movl   $0x8e000008,-0x7feeb31e(,%eax,8)
80105e1e:	08 00 00 8e 
80105e22:	66 89 14 c5 e0 4c 11 	mov    %dx,-0x7feeb320(,%eax,8)
80105e29:	80 
80105e2a:	c1 ea 10             	shr    $0x10,%edx
80105e2d:	66 89 14 c5 e6 4c 11 	mov    %dx,-0x7feeb31a(,%eax,8)
80105e34:	80 
  for(i = 0; i < 256; i++)
80105e35:	83 c0 01             	add    $0x1,%eax
80105e38:	3d 00 01 00 00       	cmp    $0x100,%eax
80105e3d:	75 d1                	jne    80105e10 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105e3f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e42:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105e47:	c7 05 e2 4e 11 80 08 	movl   $0xef000008,0x80114ee2
80105e4e:	00 00 ef 
  initlock(&tickslock, "time");
80105e51:	68 ee 7a 10 80       	push   $0x80107aee
80105e56:	68 a0 4c 11 80       	push   $0x80114ca0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e5b:	66 a3 e0 4e 11 80    	mov    %ax,0x80114ee0
80105e61:	c1 e8 10             	shr    $0x10,%eax
80105e64:	66 a3 e6 4e 11 80    	mov    %ax,0x80114ee6
  initlock(&tickslock, "time");
80105e6a:	e8 e1 ea ff ff       	call   80104950 <initlock>
}
80105e6f:	83 c4 10             	add    $0x10,%esp
80105e72:	c9                   	leave
80105e73:	c3                   	ret
80105e74:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e7b:	00 
80105e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e80 <idtinit>:

void
idtinit(void)
{
80105e80:	55                   	push   %ebp
  pd[0] = size-1;
80105e81:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105e86:	89 e5                	mov    %esp,%ebp
80105e88:	83 ec 10             	sub    $0x10,%esp
80105e8b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105e8f:	b8 e0 4c 11 80       	mov    $0x80114ce0,%eax
80105e94:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105e98:	c1 e8 10             	shr    $0x10,%eax
80105e9b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105e9f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ea2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ea5:	c9                   	leave
80105ea6:	c3                   	ret
80105ea7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105eae:	00 
80105eaf:	90                   	nop

80105eb0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	57                   	push   %edi
80105eb4:	56                   	push   %esi
80105eb5:	53                   	push   %ebx
80105eb6:	83 ec 1c             	sub    $0x1c,%esp
80105eb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105ebc:	8b 43 30             	mov    0x30(%ebx),%eax
80105ebf:	83 f8 40             	cmp    $0x40,%eax
80105ec2:	0f 84 58 01 00 00    	je     80106020 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105ec8:	83 e8 20             	sub    $0x20,%eax
80105ecb:	83 f8 1f             	cmp    $0x1f,%eax
80105ece:	0f 87 7c 00 00 00    	ja     80105f50 <trap+0xa0>
80105ed4:	ff 24 85 98 80 10 80 	jmp    *-0x7fef7f68(,%eax,4)
80105edb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105ee0:	e8 eb c8 ff ff       	call   801027d0 <ideintr>
    lapiceoi();
80105ee5:	e8 a6 cf ff ff       	call   80102e90 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105eea:	e8 11 e0 ff ff       	call   80103f00 <myproc>
80105eef:	85 c0                	test   %eax,%eax
80105ef1:	74 1a                	je     80105f0d <trap+0x5d>
80105ef3:	e8 08 e0 ff ff       	call   80103f00 <myproc>
80105ef8:	8b 50 24             	mov    0x24(%eax),%edx
80105efb:	85 d2                	test   %edx,%edx
80105efd:	74 0e                	je     80105f0d <trap+0x5d>
80105eff:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105f03:	f7 d0                	not    %eax
80105f05:	a8 03                	test   $0x3,%al
80105f07:	0f 84 db 01 00 00    	je     801060e8 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105f0d:	e8 ee df ff ff       	call   80103f00 <myproc>
80105f12:	85 c0                	test   %eax,%eax
80105f14:	74 0f                	je     80105f25 <trap+0x75>
80105f16:	e8 e5 df ff ff       	call   80103f00 <myproc>
80105f1b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105f1f:	0f 84 ab 00 00 00    	je     80105fd0 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f25:	e8 d6 df ff ff       	call   80103f00 <myproc>
80105f2a:	85 c0                	test   %eax,%eax
80105f2c:	74 1a                	je     80105f48 <trap+0x98>
80105f2e:	e8 cd df ff ff       	call   80103f00 <myproc>
80105f33:	8b 40 24             	mov    0x24(%eax),%eax
80105f36:	85 c0                	test   %eax,%eax
80105f38:	74 0e                	je     80105f48 <trap+0x98>
80105f3a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105f3e:	f7 d0                	not    %eax
80105f40:	a8 03                	test   $0x3,%al
80105f42:	0f 84 05 01 00 00    	je     8010604d <trap+0x19d>
    exit();
}
80105f48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f4b:	5b                   	pop    %ebx
80105f4c:	5e                   	pop    %esi
80105f4d:	5f                   	pop    %edi
80105f4e:	5d                   	pop    %ebp
80105f4f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80105f50:	e8 ab df ff ff       	call   80103f00 <myproc>
80105f55:	8b 7b 38             	mov    0x38(%ebx),%edi
80105f58:	85 c0                	test   %eax,%eax
80105f5a:	0f 84 a2 01 00 00    	je     80106102 <trap+0x252>
80105f60:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105f64:	0f 84 98 01 00 00    	je     80106102 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105f6a:	0f 20 d1             	mov    %cr2,%ecx
80105f6d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f70:	e8 6b df ff ff       	call   80103ee0 <cpuid>
80105f75:	8b 73 30             	mov    0x30(%ebx),%esi
80105f78:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105f7b:	8b 43 34             	mov    0x34(%ebx),%eax
80105f7e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105f81:	e8 7a df ff ff       	call   80103f00 <myproc>
80105f86:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105f89:	e8 72 df ff ff       	call   80103f00 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f8e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105f91:	51                   	push   %ecx
80105f92:	57                   	push   %edi
80105f93:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105f96:	52                   	push   %edx
80105f97:	ff 75 e4             	push   -0x1c(%ebp)
80105f9a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105f9b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105f9e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105fa1:	56                   	push   %esi
80105fa2:	ff 70 10             	push   0x10(%eax)
80105fa5:	68 94 7d 10 80       	push   $0x80107d94
80105faa:	e8 b1 a6 ff ff       	call   80100660 <cprintf>
    myproc()->killed = 1;
80105faf:	83 c4 20             	add    $0x20,%esp
80105fb2:	e8 49 df ff ff       	call   80103f00 <myproc>
80105fb7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105fbe:	e8 3d df ff ff       	call   80103f00 <myproc>
80105fc3:	85 c0                	test   %eax,%eax
80105fc5:	0f 85 28 ff ff ff    	jne    80105ef3 <trap+0x43>
80105fcb:	e9 3d ff ff ff       	jmp    80105f0d <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80105fd0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105fd4:	0f 85 4b ff ff ff    	jne    80105f25 <trap+0x75>
    yield();
80105fda:	e8 91 e5 ff ff       	call   80104570 <yield>
80105fdf:	e9 41 ff ff ff       	jmp    80105f25 <trap+0x75>
80105fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105fe8:	8b 7b 38             	mov    0x38(%ebx),%edi
80105feb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105fef:	e8 ec de ff ff       	call   80103ee0 <cpuid>
80105ff4:	57                   	push   %edi
80105ff5:	56                   	push   %esi
80105ff6:	50                   	push   %eax
80105ff7:	68 3c 7d 10 80       	push   $0x80107d3c
80105ffc:	e8 5f a6 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106001:	e8 8a ce ff ff       	call   80102e90 <lapiceoi>
    break;
80106006:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106009:	e8 f2 de ff ff       	call   80103f00 <myproc>
8010600e:	85 c0                	test   %eax,%eax
80106010:	0f 85 dd fe ff ff    	jne    80105ef3 <trap+0x43>
80106016:	e9 f2 fe ff ff       	jmp    80105f0d <trap+0x5d>
8010601b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106020:	e8 db de ff ff       	call   80103f00 <myproc>
80106025:	8b 70 24             	mov    0x24(%eax),%esi
80106028:	85 f6                	test   %esi,%esi
8010602a:	0f 85 c8 00 00 00    	jne    801060f8 <trap+0x248>
    myproc()->tf = tf;
80106030:	e8 cb de ff ff       	call   80103f00 <myproc>
80106035:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106038:	e8 f3 ef ff ff       	call   80105030 <syscall>
    if(myproc()->killed)
8010603d:	e8 be de ff ff       	call   80103f00 <myproc>
80106042:	8b 48 24             	mov    0x24(%eax),%ecx
80106045:	85 c9                	test   %ecx,%ecx
80106047:	0f 84 fb fe ff ff    	je     80105f48 <trap+0x98>
}
8010604d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106050:	5b                   	pop    %ebx
80106051:	5e                   	pop    %esi
80106052:	5f                   	pop    %edi
80106053:	5d                   	pop    %ebp
      exit();
80106054:	e9 b7 e2 ff ff       	jmp    80104310 <exit>
80106059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106060:	e8 4b 02 00 00       	call   801062b0 <uartintr>
    lapiceoi();
80106065:	e8 26 ce ff ff       	call   80102e90 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010606a:	e8 91 de ff ff       	call   80103f00 <myproc>
8010606f:	85 c0                	test   %eax,%eax
80106071:	0f 85 7c fe ff ff    	jne    80105ef3 <trap+0x43>
80106077:	e9 91 fe ff ff       	jmp    80105f0d <trap+0x5d>
8010607c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106080:	e8 db cc ff ff       	call   80102d60 <kbdintr>
    lapiceoi();
80106085:	e8 06 ce ff ff       	call   80102e90 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010608a:	e8 71 de ff ff       	call   80103f00 <myproc>
8010608f:	85 c0                	test   %eax,%eax
80106091:	0f 85 5c fe ff ff    	jne    80105ef3 <trap+0x43>
80106097:	e9 71 fe ff ff       	jmp    80105f0d <trap+0x5d>
8010609c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801060a0:	e8 3b de ff ff       	call   80103ee0 <cpuid>
801060a5:	85 c0                	test   %eax,%eax
801060a7:	0f 85 38 fe ff ff    	jne    80105ee5 <trap+0x35>
      acquire(&tickslock);
801060ad:	83 ec 0c             	sub    $0xc,%esp
801060b0:	68 a0 4c 11 80       	push   $0x80114ca0
801060b5:	e8 86 ea ff ff       	call   80104b40 <acquire>
      ticks++;
801060ba:	83 05 80 4c 11 80 01 	addl   $0x1,0x80114c80
      wakeup(&ticks);
801060c1:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
801060c8:	e8 b3 e5 ff ff       	call   80104680 <wakeup>
      release(&tickslock);
801060cd:	c7 04 24 a0 4c 11 80 	movl   $0x80114ca0,(%esp)
801060d4:	e8 07 ea ff ff       	call   80104ae0 <release>
801060d9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801060dc:	e9 04 fe ff ff       	jmp    80105ee5 <trap+0x35>
801060e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
801060e8:	e8 23 e2 ff ff       	call   80104310 <exit>
801060ed:	e9 1b fe ff ff       	jmp    80105f0d <trap+0x5d>
801060f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801060f8:	e8 13 e2 ff ff       	call   80104310 <exit>
801060fd:	e9 2e ff ff ff       	jmp    80106030 <trap+0x180>
80106102:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106105:	e8 d6 dd ff ff       	call   80103ee0 <cpuid>
8010610a:	83 ec 0c             	sub    $0xc,%esp
8010610d:	56                   	push   %esi
8010610e:	57                   	push   %edi
8010610f:	50                   	push   %eax
80106110:	ff 73 30             	push   0x30(%ebx)
80106113:	68 60 7d 10 80       	push   $0x80107d60
80106118:	e8 43 a5 ff ff       	call   80100660 <cprintf>
      panic("trap");
8010611d:	83 c4 14             	add    $0x14,%esp
80106120:	68 f3 7a 10 80       	push   $0x80107af3
80106125:	e8 56 a2 ff ff       	call   80100380 <panic>
8010612a:	66 90                	xchg   %ax,%ax
8010612c:	66 90                	xchg   %ax,%ax
8010612e:	66 90                	xchg   %ax,%ax

80106130 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106130:	a1 e0 54 11 80       	mov    0x801154e0,%eax
80106135:	85 c0                	test   %eax,%eax
80106137:	74 17                	je     80106150 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106139:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010613e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010613f:	a8 01                	test   $0x1,%al
80106141:	74 0d                	je     80106150 <uartgetc+0x20>
80106143:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106148:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106149:	0f b6 c0             	movzbl %al,%eax
8010614c:	c3                   	ret
8010614d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106155:	c3                   	ret
80106156:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010615d:	00 
8010615e:	66 90                	xchg   %ax,%ax

80106160 <uartinit>:
{
80106160:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106161:	31 c9                	xor    %ecx,%ecx
80106163:	89 c8                	mov    %ecx,%eax
80106165:	89 e5                	mov    %esp,%ebp
80106167:	57                   	push   %edi
80106168:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010616d:	56                   	push   %esi
8010616e:	89 fa                	mov    %edi,%edx
80106170:	53                   	push   %ebx
80106171:	83 ec 1c             	sub    $0x1c,%esp
80106174:	ee                   	out    %al,(%dx)
80106175:	be fb 03 00 00       	mov    $0x3fb,%esi
8010617a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010617f:	89 f2                	mov    %esi,%edx
80106181:	ee                   	out    %al,(%dx)
80106182:	b8 0c 00 00 00       	mov    $0xc,%eax
80106187:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010618c:	ee                   	out    %al,(%dx)
8010618d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106192:	89 c8                	mov    %ecx,%eax
80106194:	89 da                	mov    %ebx,%edx
80106196:	ee                   	out    %al,(%dx)
80106197:	b8 03 00 00 00       	mov    $0x3,%eax
8010619c:	89 f2                	mov    %esi,%edx
8010619e:	ee                   	out    %al,(%dx)
8010619f:	ba fc 03 00 00       	mov    $0x3fc,%edx
801061a4:	89 c8                	mov    %ecx,%eax
801061a6:	ee                   	out    %al,(%dx)
801061a7:	b8 01 00 00 00       	mov    $0x1,%eax
801061ac:	89 da                	mov    %ebx,%edx
801061ae:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801061af:	ba fd 03 00 00       	mov    $0x3fd,%edx
801061b4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801061b5:	3c ff                	cmp    $0xff,%al
801061b7:	0f 84 7c 00 00 00    	je     80106239 <uartinit+0xd9>
  uart = 1;
801061bd:	c7 05 e0 54 11 80 01 	movl   $0x1,0x801154e0
801061c4:	00 00 00 
801061c7:	89 fa                	mov    %edi,%edx
801061c9:	ec                   	in     (%dx),%al
801061ca:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061cf:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801061d0:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801061d3:	bf f8 7a 10 80       	mov    $0x80107af8,%edi
801061d8:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801061dd:	6a 00                	push   $0x0
801061df:	6a 04                	push   $0x4
801061e1:	e8 1a c8 ff ff       	call   80102a00 <ioapicenable>
801061e6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801061e9:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
801061ed:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
801061f0:	a1 e0 54 11 80       	mov    0x801154e0,%eax
801061f5:	85 c0                	test   %eax,%eax
801061f7:	74 32                	je     8010622b <uartinit+0xcb>
801061f9:	89 f2                	mov    %esi,%edx
801061fb:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801061fc:	a8 20                	test   $0x20,%al
801061fe:	75 21                	jne    80106221 <uartinit+0xc1>
80106200:	bb 80 00 00 00       	mov    $0x80,%ebx
80106205:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80106208:	83 ec 0c             	sub    $0xc,%esp
8010620b:	6a 0a                	push   $0xa
8010620d:	e8 9e cc ff ff       	call   80102eb0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106212:	83 c4 10             	add    $0x10,%esp
80106215:	83 eb 01             	sub    $0x1,%ebx
80106218:	74 07                	je     80106221 <uartinit+0xc1>
8010621a:	89 f2                	mov    %esi,%edx
8010621c:	ec                   	in     (%dx),%al
8010621d:	a8 20                	test   $0x20,%al
8010621f:	74 e7                	je     80106208 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106221:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106226:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010622a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
8010622b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010622f:	83 c7 01             	add    $0x1,%edi
80106232:	88 45 e7             	mov    %al,-0x19(%ebp)
80106235:	84 c0                	test   %al,%al
80106237:	75 b7                	jne    801061f0 <uartinit+0x90>
}
80106239:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010623c:	5b                   	pop    %ebx
8010623d:	5e                   	pop    %esi
8010623e:	5f                   	pop    %edi
8010623f:	5d                   	pop    %ebp
80106240:	c3                   	ret
80106241:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106248:	00 
80106249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106250 <uartputc>:
  if(!uart)
80106250:	a1 e0 54 11 80       	mov    0x801154e0,%eax
80106255:	85 c0                	test   %eax,%eax
80106257:	74 4f                	je     801062a8 <uartputc+0x58>
{
80106259:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010625a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010625f:	89 e5                	mov    %esp,%ebp
80106261:	56                   	push   %esi
80106262:	53                   	push   %ebx
80106263:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106264:	a8 20                	test   $0x20,%al
80106266:	75 29                	jne    80106291 <uartputc+0x41>
80106268:	bb 80 00 00 00       	mov    $0x80,%ebx
8010626d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106278:	83 ec 0c             	sub    $0xc,%esp
8010627b:	6a 0a                	push   $0xa
8010627d:	e8 2e cc ff ff       	call   80102eb0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106282:	83 c4 10             	add    $0x10,%esp
80106285:	83 eb 01             	sub    $0x1,%ebx
80106288:	74 07                	je     80106291 <uartputc+0x41>
8010628a:	89 f2                	mov    %esi,%edx
8010628c:	ec                   	in     (%dx),%al
8010628d:	a8 20                	test   $0x20,%al
8010628f:	74 e7                	je     80106278 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106291:	8b 45 08             	mov    0x8(%ebp),%eax
80106294:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106299:	ee                   	out    %al,(%dx)
}
8010629a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010629d:	5b                   	pop    %ebx
8010629e:	5e                   	pop    %esi
8010629f:	5d                   	pop    %ebp
801062a0:	c3                   	ret
801062a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062a8:	c3                   	ret
801062a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801062b0 <uartintr>:

void
uartintr(void)
{
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
801062b3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801062b6:	68 30 61 10 80       	push   $0x80106130
801062bb:	e8 f0 a5 ff ff       	call   801008b0 <consoleintr>
}
801062c0:	83 c4 10             	add    $0x10,%esp
801062c3:	c9                   	leave
801062c4:	c3                   	ret

801062c5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801062c5:	6a 00                	push   $0x0
  pushl $0
801062c7:	6a 00                	push   $0x0
  jmp alltraps
801062c9:	e9 0c fb ff ff       	jmp    80105dda <alltraps>

801062ce <vector1>:
.globl vector1
vector1:
  pushl $0
801062ce:	6a 00                	push   $0x0
  pushl $1
801062d0:	6a 01                	push   $0x1
  jmp alltraps
801062d2:	e9 03 fb ff ff       	jmp    80105dda <alltraps>

801062d7 <vector2>:
.globl vector2
vector2:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $2
801062d9:	6a 02                	push   $0x2
  jmp alltraps
801062db:	e9 fa fa ff ff       	jmp    80105dda <alltraps>

801062e0 <vector3>:
.globl vector3
vector3:
  pushl $0
801062e0:	6a 00                	push   $0x0
  pushl $3
801062e2:	6a 03                	push   $0x3
  jmp alltraps
801062e4:	e9 f1 fa ff ff       	jmp    80105dda <alltraps>

801062e9 <vector4>:
.globl vector4
vector4:
  pushl $0
801062e9:	6a 00                	push   $0x0
  pushl $4
801062eb:	6a 04                	push   $0x4
  jmp alltraps
801062ed:	e9 e8 fa ff ff       	jmp    80105dda <alltraps>

801062f2 <vector5>:
.globl vector5
vector5:
  pushl $0
801062f2:	6a 00                	push   $0x0
  pushl $5
801062f4:	6a 05                	push   $0x5
  jmp alltraps
801062f6:	e9 df fa ff ff       	jmp    80105dda <alltraps>

801062fb <vector6>:
.globl vector6
vector6:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $6
801062fd:	6a 06                	push   $0x6
  jmp alltraps
801062ff:	e9 d6 fa ff ff       	jmp    80105dda <alltraps>

80106304 <vector7>:
.globl vector7
vector7:
  pushl $0
80106304:	6a 00                	push   $0x0
  pushl $7
80106306:	6a 07                	push   $0x7
  jmp alltraps
80106308:	e9 cd fa ff ff       	jmp    80105dda <alltraps>

8010630d <vector8>:
.globl vector8
vector8:
  pushl $8
8010630d:	6a 08                	push   $0x8
  jmp alltraps
8010630f:	e9 c6 fa ff ff       	jmp    80105dda <alltraps>

80106314 <vector9>:
.globl vector9
vector9:
  pushl $0
80106314:	6a 00                	push   $0x0
  pushl $9
80106316:	6a 09                	push   $0x9
  jmp alltraps
80106318:	e9 bd fa ff ff       	jmp    80105dda <alltraps>

8010631d <vector10>:
.globl vector10
vector10:
  pushl $10
8010631d:	6a 0a                	push   $0xa
  jmp alltraps
8010631f:	e9 b6 fa ff ff       	jmp    80105dda <alltraps>

80106324 <vector11>:
.globl vector11
vector11:
  pushl $11
80106324:	6a 0b                	push   $0xb
  jmp alltraps
80106326:	e9 af fa ff ff       	jmp    80105dda <alltraps>

8010632b <vector12>:
.globl vector12
vector12:
  pushl $12
8010632b:	6a 0c                	push   $0xc
  jmp alltraps
8010632d:	e9 a8 fa ff ff       	jmp    80105dda <alltraps>

80106332 <vector13>:
.globl vector13
vector13:
  pushl $13
80106332:	6a 0d                	push   $0xd
  jmp alltraps
80106334:	e9 a1 fa ff ff       	jmp    80105dda <alltraps>

80106339 <vector14>:
.globl vector14
vector14:
  pushl $14
80106339:	6a 0e                	push   $0xe
  jmp alltraps
8010633b:	e9 9a fa ff ff       	jmp    80105dda <alltraps>

80106340 <vector15>:
.globl vector15
vector15:
  pushl $0
80106340:	6a 00                	push   $0x0
  pushl $15
80106342:	6a 0f                	push   $0xf
  jmp alltraps
80106344:	e9 91 fa ff ff       	jmp    80105dda <alltraps>

80106349 <vector16>:
.globl vector16
vector16:
  pushl $0
80106349:	6a 00                	push   $0x0
  pushl $16
8010634b:	6a 10                	push   $0x10
  jmp alltraps
8010634d:	e9 88 fa ff ff       	jmp    80105dda <alltraps>

80106352 <vector17>:
.globl vector17
vector17:
  pushl $17
80106352:	6a 11                	push   $0x11
  jmp alltraps
80106354:	e9 81 fa ff ff       	jmp    80105dda <alltraps>

80106359 <vector18>:
.globl vector18
vector18:
  pushl $0
80106359:	6a 00                	push   $0x0
  pushl $18
8010635b:	6a 12                	push   $0x12
  jmp alltraps
8010635d:	e9 78 fa ff ff       	jmp    80105dda <alltraps>

80106362 <vector19>:
.globl vector19
vector19:
  pushl $0
80106362:	6a 00                	push   $0x0
  pushl $19
80106364:	6a 13                	push   $0x13
  jmp alltraps
80106366:	e9 6f fa ff ff       	jmp    80105dda <alltraps>

8010636b <vector20>:
.globl vector20
vector20:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $20
8010636d:	6a 14                	push   $0x14
  jmp alltraps
8010636f:	e9 66 fa ff ff       	jmp    80105dda <alltraps>

80106374 <vector21>:
.globl vector21
vector21:
  pushl $0
80106374:	6a 00                	push   $0x0
  pushl $21
80106376:	6a 15                	push   $0x15
  jmp alltraps
80106378:	e9 5d fa ff ff       	jmp    80105dda <alltraps>

8010637d <vector22>:
.globl vector22
vector22:
  pushl $0
8010637d:	6a 00                	push   $0x0
  pushl $22
8010637f:	6a 16                	push   $0x16
  jmp alltraps
80106381:	e9 54 fa ff ff       	jmp    80105dda <alltraps>

80106386 <vector23>:
.globl vector23
vector23:
  pushl $0
80106386:	6a 00                	push   $0x0
  pushl $23
80106388:	6a 17                	push   $0x17
  jmp alltraps
8010638a:	e9 4b fa ff ff       	jmp    80105dda <alltraps>

8010638f <vector24>:
.globl vector24
vector24:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $24
80106391:	6a 18                	push   $0x18
  jmp alltraps
80106393:	e9 42 fa ff ff       	jmp    80105dda <alltraps>

80106398 <vector25>:
.globl vector25
vector25:
  pushl $0
80106398:	6a 00                	push   $0x0
  pushl $25
8010639a:	6a 19                	push   $0x19
  jmp alltraps
8010639c:	e9 39 fa ff ff       	jmp    80105dda <alltraps>

801063a1 <vector26>:
.globl vector26
vector26:
  pushl $0
801063a1:	6a 00                	push   $0x0
  pushl $26
801063a3:	6a 1a                	push   $0x1a
  jmp alltraps
801063a5:	e9 30 fa ff ff       	jmp    80105dda <alltraps>

801063aa <vector27>:
.globl vector27
vector27:
  pushl $0
801063aa:	6a 00                	push   $0x0
  pushl $27
801063ac:	6a 1b                	push   $0x1b
  jmp alltraps
801063ae:	e9 27 fa ff ff       	jmp    80105dda <alltraps>

801063b3 <vector28>:
.globl vector28
vector28:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $28
801063b5:	6a 1c                	push   $0x1c
  jmp alltraps
801063b7:	e9 1e fa ff ff       	jmp    80105dda <alltraps>

801063bc <vector29>:
.globl vector29
vector29:
  pushl $0
801063bc:	6a 00                	push   $0x0
  pushl $29
801063be:	6a 1d                	push   $0x1d
  jmp alltraps
801063c0:	e9 15 fa ff ff       	jmp    80105dda <alltraps>

801063c5 <vector30>:
.globl vector30
vector30:
  pushl $0
801063c5:	6a 00                	push   $0x0
  pushl $30
801063c7:	6a 1e                	push   $0x1e
  jmp alltraps
801063c9:	e9 0c fa ff ff       	jmp    80105dda <alltraps>

801063ce <vector31>:
.globl vector31
vector31:
  pushl $0
801063ce:	6a 00                	push   $0x0
  pushl $31
801063d0:	6a 1f                	push   $0x1f
  jmp alltraps
801063d2:	e9 03 fa ff ff       	jmp    80105dda <alltraps>

801063d7 <vector32>:
.globl vector32
vector32:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $32
801063d9:	6a 20                	push   $0x20
  jmp alltraps
801063db:	e9 fa f9 ff ff       	jmp    80105dda <alltraps>

801063e0 <vector33>:
.globl vector33
vector33:
  pushl $0
801063e0:	6a 00                	push   $0x0
  pushl $33
801063e2:	6a 21                	push   $0x21
  jmp alltraps
801063e4:	e9 f1 f9 ff ff       	jmp    80105dda <alltraps>

801063e9 <vector34>:
.globl vector34
vector34:
  pushl $0
801063e9:	6a 00                	push   $0x0
  pushl $34
801063eb:	6a 22                	push   $0x22
  jmp alltraps
801063ed:	e9 e8 f9 ff ff       	jmp    80105dda <alltraps>

801063f2 <vector35>:
.globl vector35
vector35:
  pushl $0
801063f2:	6a 00                	push   $0x0
  pushl $35
801063f4:	6a 23                	push   $0x23
  jmp alltraps
801063f6:	e9 df f9 ff ff       	jmp    80105dda <alltraps>

801063fb <vector36>:
.globl vector36
vector36:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $36
801063fd:	6a 24                	push   $0x24
  jmp alltraps
801063ff:	e9 d6 f9 ff ff       	jmp    80105dda <alltraps>

80106404 <vector37>:
.globl vector37
vector37:
  pushl $0
80106404:	6a 00                	push   $0x0
  pushl $37
80106406:	6a 25                	push   $0x25
  jmp alltraps
80106408:	e9 cd f9 ff ff       	jmp    80105dda <alltraps>

8010640d <vector38>:
.globl vector38
vector38:
  pushl $0
8010640d:	6a 00                	push   $0x0
  pushl $38
8010640f:	6a 26                	push   $0x26
  jmp alltraps
80106411:	e9 c4 f9 ff ff       	jmp    80105dda <alltraps>

80106416 <vector39>:
.globl vector39
vector39:
  pushl $0
80106416:	6a 00                	push   $0x0
  pushl $39
80106418:	6a 27                	push   $0x27
  jmp alltraps
8010641a:	e9 bb f9 ff ff       	jmp    80105dda <alltraps>

8010641f <vector40>:
.globl vector40
vector40:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $40
80106421:	6a 28                	push   $0x28
  jmp alltraps
80106423:	e9 b2 f9 ff ff       	jmp    80105dda <alltraps>

80106428 <vector41>:
.globl vector41
vector41:
  pushl $0
80106428:	6a 00                	push   $0x0
  pushl $41
8010642a:	6a 29                	push   $0x29
  jmp alltraps
8010642c:	e9 a9 f9 ff ff       	jmp    80105dda <alltraps>

80106431 <vector42>:
.globl vector42
vector42:
  pushl $0
80106431:	6a 00                	push   $0x0
  pushl $42
80106433:	6a 2a                	push   $0x2a
  jmp alltraps
80106435:	e9 a0 f9 ff ff       	jmp    80105dda <alltraps>

8010643a <vector43>:
.globl vector43
vector43:
  pushl $0
8010643a:	6a 00                	push   $0x0
  pushl $43
8010643c:	6a 2b                	push   $0x2b
  jmp alltraps
8010643e:	e9 97 f9 ff ff       	jmp    80105dda <alltraps>

80106443 <vector44>:
.globl vector44
vector44:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $44
80106445:	6a 2c                	push   $0x2c
  jmp alltraps
80106447:	e9 8e f9 ff ff       	jmp    80105dda <alltraps>

8010644c <vector45>:
.globl vector45
vector45:
  pushl $0
8010644c:	6a 00                	push   $0x0
  pushl $45
8010644e:	6a 2d                	push   $0x2d
  jmp alltraps
80106450:	e9 85 f9 ff ff       	jmp    80105dda <alltraps>

80106455 <vector46>:
.globl vector46
vector46:
  pushl $0
80106455:	6a 00                	push   $0x0
  pushl $46
80106457:	6a 2e                	push   $0x2e
  jmp alltraps
80106459:	e9 7c f9 ff ff       	jmp    80105dda <alltraps>

8010645e <vector47>:
.globl vector47
vector47:
  pushl $0
8010645e:	6a 00                	push   $0x0
  pushl $47
80106460:	6a 2f                	push   $0x2f
  jmp alltraps
80106462:	e9 73 f9 ff ff       	jmp    80105dda <alltraps>

80106467 <vector48>:
.globl vector48
vector48:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $48
80106469:	6a 30                	push   $0x30
  jmp alltraps
8010646b:	e9 6a f9 ff ff       	jmp    80105dda <alltraps>

80106470 <vector49>:
.globl vector49
vector49:
  pushl $0
80106470:	6a 00                	push   $0x0
  pushl $49
80106472:	6a 31                	push   $0x31
  jmp alltraps
80106474:	e9 61 f9 ff ff       	jmp    80105dda <alltraps>

80106479 <vector50>:
.globl vector50
vector50:
  pushl $0
80106479:	6a 00                	push   $0x0
  pushl $50
8010647b:	6a 32                	push   $0x32
  jmp alltraps
8010647d:	e9 58 f9 ff ff       	jmp    80105dda <alltraps>

80106482 <vector51>:
.globl vector51
vector51:
  pushl $0
80106482:	6a 00                	push   $0x0
  pushl $51
80106484:	6a 33                	push   $0x33
  jmp alltraps
80106486:	e9 4f f9 ff ff       	jmp    80105dda <alltraps>

8010648b <vector52>:
.globl vector52
vector52:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $52
8010648d:	6a 34                	push   $0x34
  jmp alltraps
8010648f:	e9 46 f9 ff ff       	jmp    80105dda <alltraps>

80106494 <vector53>:
.globl vector53
vector53:
  pushl $0
80106494:	6a 00                	push   $0x0
  pushl $53
80106496:	6a 35                	push   $0x35
  jmp alltraps
80106498:	e9 3d f9 ff ff       	jmp    80105dda <alltraps>

8010649d <vector54>:
.globl vector54
vector54:
  pushl $0
8010649d:	6a 00                	push   $0x0
  pushl $54
8010649f:	6a 36                	push   $0x36
  jmp alltraps
801064a1:	e9 34 f9 ff ff       	jmp    80105dda <alltraps>

801064a6 <vector55>:
.globl vector55
vector55:
  pushl $0
801064a6:	6a 00                	push   $0x0
  pushl $55
801064a8:	6a 37                	push   $0x37
  jmp alltraps
801064aa:	e9 2b f9 ff ff       	jmp    80105dda <alltraps>

801064af <vector56>:
.globl vector56
vector56:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $56
801064b1:	6a 38                	push   $0x38
  jmp alltraps
801064b3:	e9 22 f9 ff ff       	jmp    80105dda <alltraps>

801064b8 <vector57>:
.globl vector57
vector57:
  pushl $0
801064b8:	6a 00                	push   $0x0
  pushl $57
801064ba:	6a 39                	push   $0x39
  jmp alltraps
801064bc:	e9 19 f9 ff ff       	jmp    80105dda <alltraps>

801064c1 <vector58>:
.globl vector58
vector58:
  pushl $0
801064c1:	6a 00                	push   $0x0
  pushl $58
801064c3:	6a 3a                	push   $0x3a
  jmp alltraps
801064c5:	e9 10 f9 ff ff       	jmp    80105dda <alltraps>

801064ca <vector59>:
.globl vector59
vector59:
  pushl $0
801064ca:	6a 00                	push   $0x0
  pushl $59
801064cc:	6a 3b                	push   $0x3b
  jmp alltraps
801064ce:	e9 07 f9 ff ff       	jmp    80105dda <alltraps>

801064d3 <vector60>:
.globl vector60
vector60:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $60
801064d5:	6a 3c                	push   $0x3c
  jmp alltraps
801064d7:	e9 fe f8 ff ff       	jmp    80105dda <alltraps>

801064dc <vector61>:
.globl vector61
vector61:
  pushl $0
801064dc:	6a 00                	push   $0x0
  pushl $61
801064de:	6a 3d                	push   $0x3d
  jmp alltraps
801064e0:	e9 f5 f8 ff ff       	jmp    80105dda <alltraps>

801064e5 <vector62>:
.globl vector62
vector62:
  pushl $0
801064e5:	6a 00                	push   $0x0
  pushl $62
801064e7:	6a 3e                	push   $0x3e
  jmp alltraps
801064e9:	e9 ec f8 ff ff       	jmp    80105dda <alltraps>

801064ee <vector63>:
.globl vector63
vector63:
  pushl $0
801064ee:	6a 00                	push   $0x0
  pushl $63
801064f0:	6a 3f                	push   $0x3f
  jmp alltraps
801064f2:	e9 e3 f8 ff ff       	jmp    80105dda <alltraps>

801064f7 <vector64>:
.globl vector64
vector64:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $64
801064f9:	6a 40                	push   $0x40
  jmp alltraps
801064fb:	e9 da f8 ff ff       	jmp    80105dda <alltraps>

80106500 <vector65>:
.globl vector65
vector65:
  pushl $0
80106500:	6a 00                	push   $0x0
  pushl $65
80106502:	6a 41                	push   $0x41
  jmp alltraps
80106504:	e9 d1 f8 ff ff       	jmp    80105dda <alltraps>

80106509 <vector66>:
.globl vector66
vector66:
  pushl $0
80106509:	6a 00                	push   $0x0
  pushl $66
8010650b:	6a 42                	push   $0x42
  jmp alltraps
8010650d:	e9 c8 f8 ff ff       	jmp    80105dda <alltraps>

80106512 <vector67>:
.globl vector67
vector67:
  pushl $0
80106512:	6a 00                	push   $0x0
  pushl $67
80106514:	6a 43                	push   $0x43
  jmp alltraps
80106516:	e9 bf f8 ff ff       	jmp    80105dda <alltraps>

8010651b <vector68>:
.globl vector68
vector68:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $68
8010651d:	6a 44                	push   $0x44
  jmp alltraps
8010651f:	e9 b6 f8 ff ff       	jmp    80105dda <alltraps>

80106524 <vector69>:
.globl vector69
vector69:
  pushl $0
80106524:	6a 00                	push   $0x0
  pushl $69
80106526:	6a 45                	push   $0x45
  jmp alltraps
80106528:	e9 ad f8 ff ff       	jmp    80105dda <alltraps>

8010652d <vector70>:
.globl vector70
vector70:
  pushl $0
8010652d:	6a 00                	push   $0x0
  pushl $70
8010652f:	6a 46                	push   $0x46
  jmp alltraps
80106531:	e9 a4 f8 ff ff       	jmp    80105dda <alltraps>

80106536 <vector71>:
.globl vector71
vector71:
  pushl $0
80106536:	6a 00                	push   $0x0
  pushl $71
80106538:	6a 47                	push   $0x47
  jmp alltraps
8010653a:	e9 9b f8 ff ff       	jmp    80105dda <alltraps>

8010653f <vector72>:
.globl vector72
vector72:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $72
80106541:	6a 48                	push   $0x48
  jmp alltraps
80106543:	e9 92 f8 ff ff       	jmp    80105dda <alltraps>

80106548 <vector73>:
.globl vector73
vector73:
  pushl $0
80106548:	6a 00                	push   $0x0
  pushl $73
8010654a:	6a 49                	push   $0x49
  jmp alltraps
8010654c:	e9 89 f8 ff ff       	jmp    80105dda <alltraps>

80106551 <vector74>:
.globl vector74
vector74:
  pushl $0
80106551:	6a 00                	push   $0x0
  pushl $74
80106553:	6a 4a                	push   $0x4a
  jmp alltraps
80106555:	e9 80 f8 ff ff       	jmp    80105dda <alltraps>

8010655a <vector75>:
.globl vector75
vector75:
  pushl $0
8010655a:	6a 00                	push   $0x0
  pushl $75
8010655c:	6a 4b                	push   $0x4b
  jmp alltraps
8010655e:	e9 77 f8 ff ff       	jmp    80105dda <alltraps>

80106563 <vector76>:
.globl vector76
vector76:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $76
80106565:	6a 4c                	push   $0x4c
  jmp alltraps
80106567:	e9 6e f8 ff ff       	jmp    80105dda <alltraps>

8010656c <vector77>:
.globl vector77
vector77:
  pushl $0
8010656c:	6a 00                	push   $0x0
  pushl $77
8010656e:	6a 4d                	push   $0x4d
  jmp alltraps
80106570:	e9 65 f8 ff ff       	jmp    80105dda <alltraps>

80106575 <vector78>:
.globl vector78
vector78:
  pushl $0
80106575:	6a 00                	push   $0x0
  pushl $78
80106577:	6a 4e                	push   $0x4e
  jmp alltraps
80106579:	e9 5c f8 ff ff       	jmp    80105dda <alltraps>

8010657e <vector79>:
.globl vector79
vector79:
  pushl $0
8010657e:	6a 00                	push   $0x0
  pushl $79
80106580:	6a 4f                	push   $0x4f
  jmp alltraps
80106582:	e9 53 f8 ff ff       	jmp    80105dda <alltraps>

80106587 <vector80>:
.globl vector80
vector80:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $80
80106589:	6a 50                	push   $0x50
  jmp alltraps
8010658b:	e9 4a f8 ff ff       	jmp    80105dda <alltraps>

80106590 <vector81>:
.globl vector81
vector81:
  pushl $0
80106590:	6a 00                	push   $0x0
  pushl $81
80106592:	6a 51                	push   $0x51
  jmp alltraps
80106594:	e9 41 f8 ff ff       	jmp    80105dda <alltraps>

80106599 <vector82>:
.globl vector82
vector82:
  pushl $0
80106599:	6a 00                	push   $0x0
  pushl $82
8010659b:	6a 52                	push   $0x52
  jmp alltraps
8010659d:	e9 38 f8 ff ff       	jmp    80105dda <alltraps>

801065a2 <vector83>:
.globl vector83
vector83:
  pushl $0
801065a2:	6a 00                	push   $0x0
  pushl $83
801065a4:	6a 53                	push   $0x53
  jmp alltraps
801065a6:	e9 2f f8 ff ff       	jmp    80105dda <alltraps>

801065ab <vector84>:
.globl vector84
vector84:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $84
801065ad:	6a 54                	push   $0x54
  jmp alltraps
801065af:	e9 26 f8 ff ff       	jmp    80105dda <alltraps>

801065b4 <vector85>:
.globl vector85
vector85:
  pushl $0
801065b4:	6a 00                	push   $0x0
  pushl $85
801065b6:	6a 55                	push   $0x55
  jmp alltraps
801065b8:	e9 1d f8 ff ff       	jmp    80105dda <alltraps>

801065bd <vector86>:
.globl vector86
vector86:
  pushl $0
801065bd:	6a 00                	push   $0x0
  pushl $86
801065bf:	6a 56                	push   $0x56
  jmp alltraps
801065c1:	e9 14 f8 ff ff       	jmp    80105dda <alltraps>

801065c6 <vector87>:
.globl vector87
vector87:
  pushl $0
801065c6:	6a 00                	push   $0x0
  pushl $87
801065c8:	6a 57                	push   $0x57
  jmp alltraps
801065ca:	e9 0b f8 ff ff       	jmp    80105dda <alltraps>

801065cf <vector88>:
.globl vector88
vector88:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $88
801065d1:	6a 58                	push   $0x58
  jmp alltraps
801065d3:	e9 02 f8 ff ff       	jmp    80105dda <alltraps>

801065d8 <vector89>:
.globl vector89
vector89:
  pushl $0
801065d8:	6a 00                	push   $0x0
  pushl $89
801065da:	6a 59                	push   $0x59
  jmp alltraps
801065dc:	e9 f9 f7 ff ff       	jmp    80105dda <alltraps>

801065e1 <vector90>:
.globl vector90
vector90:
  pushl $0
801065e1:	6a 00                	push   $0x0
  pushl $90
801065e3:	6a 5a                	push   $0x5a
  jmp alltraps
801065e5:	e9 f0 f7 ff ff       	jmp    80105dda <alltraps>

801065ea <vector91>:
.globl vector91
vector91:
  pushl $0
801065ea:	6a 00                	push   $0x0
  pushl $91
801065ec:	6a 5b                	push   $0x5b
  jmp alltraps
801065ee:	e9 e7 f7 ff ff       	jmp    80105dda <alltraps>

801065f3 <vector92>:
.globl vector92
vector92:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $92
801065f5:	6a 5c                	push   $0x5c
  jmp alltraps
801065f7:	e9 de f7 ff ff       	jmp    80105dda <alltraps>

801065fc <vector93>:
.globl vector93
vector93:
  pushl $0
801065fc:	6a 00                	push   $0x0
  pushl $93
801065fe:	6a 5d                	push   $0x5d
  jmp alltraps
80106600:	e9 d5 f7 ff ff       	jmp    80105dda <alltraps>

80106605 <vector94>:
.globl vector94
vector94:
  pushl $0
80106605:	6a 00                	push   $0x0
  pushl $94
80106607:	6a 5e                	push   $0x5e
  jmp alltraps
80106609:	e9 cc f7 ff ff       	jmp    80105dda <alltraps>

8010660e <vector95>:
.globl vector95
vector95:
  pushl $0
8010660e:	6a 00                	push   $0x0
  pushl $95
80106610:	6a 5f                	push   $0x5f
  jmp alltraps
80106612:	e9 c3 f7 ff ff       	jmp    80105dda <alltraps>

80106617 <vector96>:
.globl vector96
vector96:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $96
80106619:	6a 60                	push   $0x60
  jmp alltraps
8010661b:	e9 ba f7 ff ff       	jmp    80105dda <alltraps>

80106620 <vector97>:
.globl vector97
vector97:
  pushl $0
80106620:	6a 00                	push   $0x0
  pushl $97
80106622:	6a 61                	push   $0x61
  jmp alltraps
80106624:	e9 b1 f7 ff ff       	jmp    80105dda <alltraps>

80106629 <vector98>:
.globl vector98
vector98:
  pushl $0
80106629:	6a 00                	push   $0x0
  pushl $98
8010662b:	6a 62                	push   $0x62
  jmp alltraps
8010662d:	e9 a8 f7 ff ff       	jmp    80105dda <alltraps>

80106632 <vector99>:
.globl vector99
vector99:
  pushl $0
80106632:	6a 00                	push   $0x0
  pushl $99
80106634:	6a 63                	push   $0x63
  jmp alltraps
80106636:	e9 9f f7 ff ff       	jmp    80105dda <alltraps>

8010663b <vector100>:
.globl vector100
vector100:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $100
8010663d:	6a 64                	push   $0x64
  jmp alltraps
8010663f:	e9 96 f7 ff ff       	jmp    80105dda <alltraps>

80106644 <vector101>:
.globl vector101
vector101:
  pushl $0
80106644:	6a 00                	push   $0x0
  pushl $101
80106646:	6a 65                	push   $0x65
  jmp alltraps
80106648:	e9 8d f7 ff ff       	jmp    80105dda <alltraps>

8010664d <vector102>:
.globl vector102
vector102:
  pushl $0
8010664d:	6a 00                	push   $0x0
  pushl $102
8010664f:	6a 66                	push   $0x66
  jmp alltraps
80106651:	e9 84 f7 ff ff       	jmp    80105dda <alltraps>

80106656 <vector103>:
.globl vector103
vector103:
  pushl $0
80106656:	6a 00                	push   $0x0
  pushl $103
80106658:	6a 67                	push   $0x67
  jmp alltraps
8010665a:	e9 7b f7 ff ff       	jmp    80105dda <alltraps>

8010665f <vector104>:
.globl vector104
vector104:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $104
80106661:	6a 68                	push   $0x68
  jmp alltraps
80106663:	e9 72 f7 ff ff       	jmp    80105dda <alltraps>

80106668 <vector105>:
.globl vector105
vector105:
  pushl $0
80106668:	6a 00                	push   $0x0
  pushl $105
8010666a:	6a 69                	push   $0x69
  jmp alltraps
8010666c:	e9 69 f7 ff ff       	jmp    80105dda <alltraps>

80106671 <vector106>:
.globl vector106
vector106:
  pushl $0
80106671:	6a 00                	push   $0x0
  pushl $106
80106673:	6a 6a                	push   $0x6a
  jmp alltraps
80106675:	e9 60 f7 ff ff       	jmp    80105dda <alltraps>

8010667a <vector107>:
.globl vector107
vector107:
  pushl $0
8010667a:	6a 00                	push   $0x0
  pushl $107
8010667c:	6a 6b                	push   $0x6b
  jmp alltraps
8010667e:	e9 57 f7 ff ff       	jmp    80105dda <alltraps>

80106683 <vector108>:
.globl vector108
vector108:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $108
80106685:	6a 6c                	push   $0x6c
  jmp alltraps
80106687:	e9 4e f7 ff ff       	jmp    80105dda <alltraps>

8010668c <vector109>:
.globl vector109
vector109:
  pushl $0
8010668c:	6a 00                	push   $0x0
  pushl $109
8010668e:	6a 6d                	push   $0x6d
  jmp alltraps
80106690:	e9 45 f7 ff ff       	jmp    80105dda <alltraps>

80106695 <vector110>:
.globl vector110
vector110:
  pushl $0
80106695:	6a 00                	push   $0x0
  pushl $110
80106697:	6a 6e                	push   $0x6e
  jmp alltraps
80106699:	e9 3c f7 ff ff       	jmp    80105dda <alltraps>

8010669e <vector111>:
.globl vector111
vector111:
  pushl $0
8010669e:	6a 00                	push   $0x0
  pushl $111
801066a0:	6a 6f                	push   $0x6f
  jmp alltraps
801066a2:	e9 33 f7 ff ff       	jmp    80105dda <alltraps>

801066a7 <vector112>:
.globl vector112
vector112:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $112
801066a9:	6a 70                	push   $0x70
  jmp alltraps
801066ab:	e9 2a f7 ff ff       	jmp    80105dda <alltraps>

801066b0 <vector113>:
.globl vector113
vector113:
  pushl $0
801066b0:	6a 00                	push   $0x0
  pushl $113
801066b2:	6a 71                	push   $0x71
  jmp alltraps
801066b4:	e9 21 f7 ff ff       	jmp    80105dda <alltraps>

801066b9 <vector114>:
.globl vector114
vector114:
  pushl $0
801066b9:	6a 00                	push   $0x0
  pushl $114
801066bb:	6a 72                	push   $0x72
  jmp alltraps
801066bd:	e9 18 f7 ff ff       	jmp    80105dda <alltraps>

801066c2 <vector115>:
.globl vector115
vector115:
  pushl $0
801066c2:	6a 00                	push   $0x0
  pushl $115
801066c4:	6a 73                	push   $0x73
  jmp alltraps
801066c6:	e9 0f f7 ff ff       	jmp    80105dda <alltraps>

801066cb <vector116>:
.globl vector116
vector116:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $116
801066cd:	6a 74                	push   $0x74
  jmp alltraps
801066cf:	e9 06 f7 ff ff       	jmp    80105dda <alltraps>

801066d4 <vector117>:
.globl vector117
vector117:
  pushl $0
801066d4:	6a 00                	push   $0x0
  pushl $117
801066d6:	6a 75                	push   $0x75
  jmp alltraps
801066d8:	e9 fd f6 ff ff       	jmp    80105dda <alltraps>

801066dd <vector118>:
.globl vector118
vector118:
  pushl $0
801066dd:	6a 00                	push   $0x0
  pushl $118
801066df:	6a 76                	push   $0x76
  jmp alltraps
801066e1:	e9 f4 f6 ff ff       	jmp    80105dda <alltraps>

801066e6 <vector119>:
.globl vector119
vector119:
  pushl $0
801066e6:	6a 00                	push   $0x0
  pushl $119
801066e8:	6a 77                	push   $0x77
  jmp alltraps
801066ea:	e9 eb f6 ff ff       	jmp    80105dda <alltraps>

801066ef <vector120>:
.globl vector120
vector120:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $120
801066f1:	6a 78                	push   $0x78
  jmp alltraps
801066f3:	e9 e2 f6 ff ff       	jmp    80105dda <alltraps>

801066f8 <vector121>:
.globl vector121
vector121:
  pushl $0
801066f8:	6a 00                	push   $0x0
  pushl $121
801066fa:	6a 79                	push   $0x79
  jmp alltraps
801066fc:	e9 d9 f6 ff ff       	jmp    80105dda <alltraps>

80106701 <vector122>:
.globl vector122
vector122:
  pushl $0
80106701:	6a 00                	push   $0x0
  pushl $122
80106703:	6a 7a                	push   $0x7a
  jmp alltraps
80106705:	e9 d0 f6 ff ff       	jmp    80105dda <alltraps>

8010670a <vector123>:
.globl vector123
vector123:
  pushl $0
8010670a:	6a 00                	push   $0x0
  pushl $123
8010670c:	6a 7b                	push   $0x7b
  jmp alltraps
8010670e:	e9 c7 f6 ff ff       	jmp    80105dda <alltraps>

80106713 <vector124>:
.globl vector124
vector124:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $124
80106715:	6a 7c                	push   $0x7c
  jmp alltraps
80106717:	e9 be f6 ff ff       	jmp    80105dda <alltraps>

8010671c <vector125>:
.globl vector125
vector125:
  pushl $0
8010671c:	6a 00                	push   $0x0
  pushl $125
8010671e:	6a 7d                	push   $0x7d
  jmp alltraps
80106720:	e9 b5 f6 ff ff       	jmp    80105dda <alltraps>

80106725 <vector126>:
.globl vector126
vector126:
  pushl $0
80106725:	6a 00                	push   $0x0
  pushl $126
80106727:	6a 7e                	push   $0x7e
  jmp alltraps
80106729:	e9 ac f6 ff ff       	jmp    80105dda <alltraps>

8010672e <vector127>:
.globl vector127
vector127:
  pushl $0
8010672e:	6a 00                	push   $0x0
  pushl $127
80106730:	6a 7f                	push   $0x7f
  jmp alltraps
80106732:	e9 a3 f6 ff ff       	jmp    80105dda <alltraps>

80106737 <vector128>:
.globl vector128
vector128:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $128
80106739:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010673e:	e9 97 f6 ff ff       	jmp    80105dda <alltraps>

80106743 <vector129>:
.globl vector129
vector129:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $129
80106745:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010674a:	e9 8b f6 ff ff       	jmp    80105dda <alltraps>

8010674f <vector130>:
.globl vector130
vector130:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $130
80106751:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106756:	e9 7f f6 ff ff       	jmp    80105dda <alltraps>

8010675b <vector131>:
.globl vector131
vector131:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $131
8010675d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106762:	e9 73 f6 ff ff       	jmp    80105dda <alltraps>

80106767 <vector132>:
.globl vector132
vector132:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $132
80106769:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010676e:	e9 67 f6 ff ff       	jmp    80105dda <alltraps>

80106773 <vector133>:
.globl vector133
vector133:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $133
80106775:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010677a:	e9 5b f6 ff ff       	jmp    80105dda <alltraps>

8010677f <vector134>:
.globl vector134
vector134:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $134
80106781:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106786:	e9 4f f6 ff ff       	jmp    80105dda <alltraps>

8010678b <vector135>:
.globl vector135
vector135:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $135
8010678d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106792:	e9 43 f6 ff ff       	jmp    80105dda <alltraps>

80106797 <vector136>:
.globl vector136
vector136:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $136
80106799:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010679e:	e9 37 f6 ff ff       	jmp    80105dda <alltraps>

801067a3 <vector137>:
.globl vector137
vector137:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $137
801067a5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801067aa:	e9 2b f6 ff ff       	jmp    80105dda <alltraps>

801067af <vector138>:
.globl vector138
vector138:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $138
801067b1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801067b6:	e9 1f f6 ff ff       	jmp    80105dda <alltraps>

801067bb <vector139>:
.globl vector139
vector139:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $139
801067bd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801067c2:	e9 13 f6 ff ff       	jmp    80105dda <alltraps>

801067c7 <vector140>:
.globl vector140
vector140:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $140
801067c9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801067ce:	e9 07 f6 ff ff       	jmp    80105dda <alltraps>

801067d3 <vector141>:
.globl vector141
vector141:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $141
801067d5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801067da:	e9 fb f5 ff ff       	jmp    80105dda <alltraps>

801067df <vector142>:
.globl vector142
vector142:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $142
801067e1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801067e6:	e9 ef f5 ff ff       	jmp    80105dda <alltraps>

801067eb <vector143>:
.globl vector143
vector143:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $143
801067ed:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801067f2:	e9 e3 f5 ff ff       	jmp    80105dda <alltraps>

801067f7 <vector144>:
.globl vector144
vector144:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $144
801067f9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801067fe:	e9 d7 f5 ff ff       	jmp    80105dda <alltraps>

80106803 <vector145>:
.globl vector145
vector145:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $145
80106805:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010680a:	e9 cb f5 ff ff       	jmp    80105dda <alltraps>

8010680f <vector146>:
.globl vector146
vector146:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $146
80106811:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106816:	e9 bf f5 ff ff       	jmp    80105dda <alltraps>

8010681b <vector147>:
.globl vector147
vector147:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $147
8010681d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106822:	e9 b3 f5 ff ff       	jmp    80105dda <alltraps>

80106827 <vector148>:
.globl vector148
vector148:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $148
80106829:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010682e:	e9 a7 f5 ff ff       	jmp    80105dda <alltraps>

80106833 <vector149>:
.globl vector149
vector149:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $149
80106835:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010683a:	e9 9b f5 ff ff       	jmp    80105dda <alltraps>

8010683f <vector150>:
.globl vector150
vector150:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $150
80106841:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106846:	e9 8f f5 ff ff       	jmp    80105dda <alltraps>

8010684b <vector151>:
.globl vector151
vector151:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $151
8010684d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106852:	e9 83 f5 ff ff       	jmp    80105dda <alltraps>

80106857 <vector152>:
.globl vector152
vector152:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $152
80106859:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010685e:	e9 77 f5 ff ff       	jmp    80105dda <alltraps>

80106863 <vector153>:
.globl vector153
vector153:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $153
80106865:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010686a:	e9 6b f5 ff ff       	jmp    80105dda <alltraps>

8010686f <vector154>:
.globl vector154
vector154:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $154
80106871:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106876:	e9 5f f5 ff ff       	jmp    80105dda <alltraps>

8010687b <vector155>:
.globl vector155
vector155:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $155
8010687d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106882:	e9 53 f5 ff ff       	jmp    80105dda <alltraps>

80106887 <vector156>:
.globl vector156
vector156:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $156
80106889:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010688e:	e9 47 f5 ff ff       	jmp    80105dda <alltraps>

80106893 <vector157>:
.globl vector157
vector157:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $157
80106895:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010689a:	e9 3b f5 ff ff       	jmp    80105dda <alltraps>

8010689f <vector158>:
.globl vector158
vector158:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $158
801068a1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801068a6:	e9 2f f5 ff ff       	jmp    80105dda <alltraps>

801068ab <vector159>:
.globl vector159
vector159:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $159
801068ad:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801068b2:	e9 23 f5 ff ff       	jmp    80105dda <alltraps>

801068b7 <vector160>:
.globl vector160
vector160:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $160
801068b9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801068be:	e9 17 f5 ff ff       	jmp    80105dda <alltraps>

801068c3 <vector161>:
.globl vector161
vector161:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $161
801068c5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801068ca:	e9 0b f5 ff ff       	jmp    80105dda <alltraps>

801068cf <vector162>:
.globl vector162
vector162:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $162
801068d1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801068d6:	e9 ff f4 ff ff       	jmp    80105dda <alltraps>

801068db <vector163>:
.globl vector163
vector163:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $163
801068dd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801068e2:	e9 f3 f4 ff ff       	jmp    80105dda <alltraps>

801068e7 <vector164>:
.globl vector164
vector164:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $164
801068e9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801068ee:	e9 e7 f4 ff ff       	jmp    80105dda <alltraps>

801068f3 <vector165>:
.globl vector165
vector165:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $165
801068f5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801068fa:	e9 db f4 ff ff       	jmp    80105dda <alltraps>

801068ff <vector166>:
.globl vector166
vector166:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $166
80106901:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106906:	e9 cf f4 ff ff       	jmp    80105dda <alltraps>

8010690b <vector167>:
.globl vector167
vector167:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $167
8010690d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106912:	e9 c3 f4 ff ff       	jmp    80105dda <alltraps>

80106917 <vector168>:
.globl vector168
vector168:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $168
80106919:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010691e:	e9 b7 f4 ff ff       	jmp    80105dda <alltraps>

80106923 <vector169>:
.globl vector169
vector169:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $169
80106925:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010692a:	e9 ab f4 ff ff       	jmp    80105dda <alltraps>

8010692f <vector170>:
.globl vector170
vector170:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $170
80106931:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106936:	e9 9f f4 ff ff       	jmp    80105dda <alltraps>

8010693b <vector171>:
.globl vector171
vector171:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $171
8010693d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106942:	e9 93 f4 ff ff       	jmp    80105dda <alltraps>

80106947 <vector172>:
.globl vector172
vector172:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $172
80106949:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010694e:	e9 87 f4 ff ff       	jmp    80105dda <alltraps>

80106953 <vector173>:
.globl vector173
vector173:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $173
80106955:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010695a:	e9 7b f4 ff ff       	jmp    80105dda <alltraps>

8010695f <vector174>:
.globl vector174
vector174:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $174
80106961:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106966:	e9 6f f4 ff ff       	jmp    80105dda <alltraps>

8010696b <vector175>:
.globl vector175
vector175:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $175
8010696d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106972:	e9 63 f4 ff ff       	jmp    80105dda <alltraps>

80106977 <vector176>:
.globl vector176
vector176:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $176
80106979:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010697e:	e9 57 f4 ff ff       	jmp    80105dda <alltraps>

80106983 <vector177>:
.globl vector177
vector177:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $177
80106985:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010698a:	e9 4b f4 ff ff       	jmp    80105dda <alltraps>

8010698f <vector178>:
.globl vector178
vector178:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $178
80106991:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106996:	e9 3f f4 ff ff       	jmp    80105dda <alltraps>

8010699b <vector179>:
.globl vector179
vector179:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $179
8010699d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801069a2:	e9 33 f4 ff ff       	jmp    80105dda <alltraps>

801069a7 <vector180>:
.globl vector180
vector180:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $180
801069a9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801069ae:	e9 27 f4 ff ff       	jmp    80105dda <alltraps>

801069b3 <vector181>:
.globl vector181
vector181:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $181
801069b5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801069ba:	e9 1b f4 ff ff       	jmp    80105dda <alltraps>

801069bf <vector182>:
.globl vector182
vector182:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $182
801069c1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801069c6:	e9 0f f4 ff ff       	jmp    80105dda <alltraps>

801069cb <vector183>:
.globl vector183
vector183:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $183
801069cd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801069d2:	e9 03 f4 ff ff       	jmp    80105dda <alltraps>

801069d7 <vector184>:
.globl vector184
vector184:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $184
801069d9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801069de:	e9 f7 f3 ff ff       	jmp    80105dda <alltraps>

801069e3 <vector185>:
.globl vector185
vector185:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $185
801069e5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801069ea:	e9 eb f3 ff ff       	jmp    80105dda <alltraps>

801069ef <vector186>:
.globl vector186
vector186:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $186
801069f1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801069f6:	e9 df f3 ff ff       	jmp    80105dda <alltraps>

801069fb <vector187>:
.globl vector187
vector187:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $187
801069fd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106a02:	e9 d3 f3 ff ff       	jmp    80105dda <alltraps>

80106a07 <vector188>:
.globl vector188
vector188:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $188
80106a09:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106a0e:	e9 c7 f3 ff ff       	jmp    80105dda <alltraps>

80106a13 <vector189>:
.globl vector189
vector189:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $189
80106a15:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106a1a:	e9 bb f3 ff ff       	jmp    80105dda <alltraps>

80106a1f <vector190>:
.globl vector190
vector190:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $190
80106a21:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106a26:	e9 af f3 ff ff       	jmp    80105dda <alltraps>

80106a2b <vector191>:
.globl vector191
vector191:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $191
80106a2d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106a32:	e9 a3 f3 ff ff       	jmp    80105dda <alltraps>

80106a37 <vector192>:
.globl vector192
vector192:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $192
80106a39:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106a3e:	e9 97 f3 ff ff       	jmp    80105dda <alltraps>

80106a43 <vector193>:
.globl vector193
vector193:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $193
80106a45:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106a4a:	e9 8b f3 ff ff       	jmp    80105dda <alltraps>

80106a4f <vector194>:
.globl vector194
vector194:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $194
80106a51:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106a56:	e9 7f f3 ff ff       	jmp    80105dda <alltraps>

80106a5b <vector195>:
.globl vector195
vector195:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $195
80106a5d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106a62:	e9 73 f3 ff ff       	jmp    80105dda <alltraps>

80106a67 <vector196>:
.globl vector196
vector196:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $196
80106a69:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106a6e:	e9 67 f3 ff ff       	jmp    80105dda <alltraps>

80106a73 <vector197>:
.globl vector197
vector197:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $197
80106a75:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106a7a:	e9 5b f3 ff ff       	jmp    80105dda <alltraps>

80106a7f <vector198>:
.globl vector198
vector198:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $198
80106a81:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106a86:	e9 4f f3 ff ff       	jmp    80105dda <alltraps>

80106a8b <vector199>:
.globl vector199
vector199:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $199
80106a8d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106a92:	e9 43 f3 ff ff       	jmp    80105dda <alltraps>

80106a97 <vector200>:
.globl vector200
vector200:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $200
80106a99:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106a9e:	e9 37 f3 ff ff       	jmp    80105dda <alltraps>

80106aa3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $201
80106aa5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106aaa:	e9 2b f3 ff ff       	jmp    80105dda <alltraps>

80106aaf <vector202>:
.globl vector202
vector202:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $202
80106ab1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106ab6:	e9 1f f3 ff ff       	jmp    80105dda <alltraps>

80106abb <vector203>:
.globl vector203
vector203:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $203
80106abd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106ac2:	e9 13 f3 ff ff       	jmp    80105dda <alltraps>

80106ac7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $204
80106ac9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106ace:	e9 07 f3 ff ff       	jmp    80105dda <alltraps>

80106ad3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $205
80106ad5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106ada:	e9 fb f2 ff ff       	jmp    80105dda <alltraps>

80106adf <vector206>:
.globl vector206
vector206:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $206
80106ae1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106ae6:	e9 ef f2 ff ff       	jmp    80105dda <alltraps>

80106aeb <vector207>:
.globl vector207
vector207:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $207
80106aed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106af2:	e9 e3 f2 ff ff       	jmp    80105dda <alltraps>

80106af7 <vector208>:
.globl vector208
vector208:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $208
80106af9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106afe:	e9 d7 f2 ff ff       	jmp    80105dda <alltraps>

80106b03 <vector209>:
.globl vector209
vector209:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $209
80106b05:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106b0a:	e9 cb f2 ff ff       	jmp    80105dda <alltraps>

80106b0f <vector210>:
.globl vector210
vector210:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $210
80106b11:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106b16:	e9 bf f2 ff ff       	jmp    80105dda <alltraps>

80106b1b <vector211>:
.globl vector211
vector211:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $211
80106b1d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106b22:	e9 b3 f2 ff ff       	jmp    80105dda <alltraps>

80106b27 <vector212>:
.globl vector212
vector212:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $212
80106b29:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106b2e:	e9 a7 f2 ff ff       	jmp    80105dda <alltraps>

80106b33 <vector213>:
.globl vector213
vector213:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $213
80106b35:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106b3a:	e9 9b f2 ff ff       	jmp    80105dda <alltraps>

80106b3f <vector214>:
.globl vector214
vector214:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $214
80106b41:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106b46:	e9 8f f2 ff ff       	jmp    80105dda <alltraps>

80106b4b <vector215>:
.globl vector215
vector215:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $215
80106b4d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106b52:	e9 83 f2 ff ff       	jmp    80105dda <alltraps>

80106b57 <vector216>:
.globl vector216
vector216:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $216
80106b59:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106b5e:	e9 77 f2 ff ff       	jmp    80105dda <alltraps>

80106b63 <vector217>:
.globl vector217
vector217:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $217
80106b65:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106b6a:	e9 6b f2 ff ff       	jmp    80105dda <alltraps>

80106b6f <vector218>:
.globl vector218
vector218:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $218
80106b71:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106b76:	e9 5f f2 ff ff       	jmp    80105dda <alltraps>

80106b7b <vector219>:
.globl vector219
vector219:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $219
80106b7d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106b82:	e9 53 f2 ff ff       	jmp    80105dda <alltraps>

80106b87 <vector220>:
.globl vector220
vector220:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $220
80106b89:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106b8e:	e9 47 f2 ff ff       	jmp    80105dda <alltraps>

80106b93 <vector221>:
.globl vector221
vector221:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $221
80106b95:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106b9a:	e9 3b f2 ff ff       	jmp    80105dda <alltraps>

80106b9f <vector222>:
.globl vector222
vector222:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $222
80106ba1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106ba6:	e9 2f f2 ff ff       	jmp    80105dda <alltraps>

80106bab <vector223>:
.globl vector223
vector223:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $223
80106bad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106bb2:	e9 23 f2 ff ff       	jmp    80105dda <alltraps>

80106bb7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $224
80106bb9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106bbe:	e9 17 f2 ff ff       	jmp    80105dda <alltraps>

80106bc3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $225
80106bc5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106bca:	e9 0b f2 ff ff       	jmp    80105dda <alltraps>

80106bcf <vector226>:
.globl vector226
vector226:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $226
80106bd1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106bd6:	e9 ff f1 ff ff       	jmp    80105dda <alltraps>

80106bdb <vector227>:
.globl vector227
vector227:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $227
80106bdd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106be2:	e9 f3 f1 ff ff       	jmp    80105dda <alltraps>

80106be7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $228
80106be9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106bee:	e9 e7 f1 ff ff       	jmp    80105dda <alltraps>

80106bf3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $229
80106bf5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106bfa:	e9 db f1 ff ff       	jmp    80105dda <alltraps>

80106bff <vector230>:
.globl vector230
vector230:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $230
80106c01:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106c06:	e9 cf f1 ff ff       	jmp    80105dda <alltraps>

80106c0b <vector231>:
.globl vector231
vector231:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $231
80106c0d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106c12:	e9 c3 f1 ff ff       	jmp    80105dda <alltraps>

80106c17 <vector232>:
.globl vector232
vector232:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $232
80106c19:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106c1e:	e9 b7 f1 ff ff       	jmp    80105dda <alltraps>

80106c23 <vector233>:
.globl vector233
vector233:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $233
80106c25:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106c2a:	e9 ab f1 ff ff       	jmp    80105dda <alltraps>

80106c2f <vector234>:
.globl vector234
vector234:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $234
80106c31:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106c36:	e9 9f f1 ff ff       	jmp    80105dda <alltraps>

80106c3b <vector235>:
.globl vector235
vector235:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $235
80106c3d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106c42:	e9 93 f1 ff ff       	jmp    80105dda <alltraps>

80106c47 <vector236>:
.globl vector236
vector236:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $236
80106c49:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106c4e:	e9 87 f1 ff ff       	jmp    80105dda <alltraps>

80106c53 <vector237>:
.globl vector237
vector237:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $237
80106c55:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106c5a:	e9 7b f1 ff ff       	jmp    80105dda <alltraps>

80106c5f <vector238>:
.globl vector238
vector238:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $238
80106c61:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106c66:	e9 6f f1 ff ff       	jmp    80105dda <alltraps>

80106c6b <vector239>:
.globl vector239
vector239:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $239
80106c6d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106c72:	e9 63 f1 ff ff       	jmp    80105dda <alltraps>

80106c77 <vector240>:
.globl vector240
vector240:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $240
80106c79:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106c7e:	e9 57 f1 ff ff       	jmp    80105dda <alltraps>

80106c83 <vector241>:
.globl vector241
vector241:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $241
80106c85:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106c8a:	e9 4b f1 ff ff       	jmp    80105dda <alltraps>

80106c8f <vector242>:
.globl vector242
vector242:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $242
80106c91:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106c96:	e9 3f f1 ff ff       	jmp    80105dda <alltraps>

80106c9b <vector243>:
.globl vector243
vector243:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $243
80106c9d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106ca2:	e9 33 f1 ff ff       	jmp    80105dda <alltraps>

80106ca7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $244
80106ca9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106cae:	e9 27 f1 ff ff       	jmp    80105dda <alltraps>

80106cb3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $245
80106cb5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106cba:	e9 1b f1 ff ff       	jmp    80105dda <alltraps>

80106cbf <vector246>:
.globl vector246
vector246:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $246
80106cc1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106cc6:	e9 0f f1 ff ff       	jmp    80105dda <alltraps>

80106ccb <vector247>:
.globl vector247
vector247:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $247
80106ccd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106cd2:	e9 03 f1 ff ff       	jmp    80105dda <alltraps>

80106cd7 <vector248>:
.globl vector248
vector248:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $248
80106cd9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106cde:	e9 f7 f0 ff ff       	jmp    80105dda <alltraps>

80106ce3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106ce3:	6a 00                	push   $0x0
  pushl $249
80106ce5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106cea:	e9 eb f0 ff ff       	jmp    80105dda <alltraps>

80106cef <vector250>:
.globl vector250
vector250:
  pushl $0
80106cef:	6a 00                	push   $0x0
  pushl $250
80106cf1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106cf6:	e9 df f0 ff ff       	jmp    80105dda <alltraps>

80106cfb <vector251>:
.globl vector251
vector251:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $251
80106cfd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106d02:	e9 d3 f0 ff ff       	jmp    80105dda <alltraps>

80106d07 <vector252>:
.globl vector252
vector252:
  pushl $0
80106d07:	6a 00                	push   $0x0
  pushl $252
80106d09:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106d0e:	e9 c7 f0 ff ff       	jmp    80105dda <alltraps>

80106d13 <vector253>:
.globl vector253
vector253:
  pushl $0
80106d13:	6a 00                	push   $0x0
  pushl $253
80106d15:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106d1a:	e9 bb f0 ff ff       	jmp    80105dda <alltraps>

80106d1f <vector254>:
.globl vector254
vector254:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $254
80106d21:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106d26:	e9 af f0 ff ff       	jmp    80105dda <alltraps>

80106d2b <vector255>:
.globl vector255
vector255:
  pushl $0
80106d2b:	6a 00                	push   $0x0
  pushl $255
80106d2d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106d32:	e9 a3 f0 ff ff       	jmp    80105dda <alltraps>
80106d37:	66 90                	xchg   %ax,%ax
80106d39:	66 90                	xchg   %ax,%ax
80106d3b:	66 90                	xchg   %ax,%ax
80106d3d:	66 90                	xchg   %ax,%ax
80106d3f:	90                   	nop

80106d40 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	57                   	push   %edi
80106d44:	56                   	push   %esi
80106d45:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106d46:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106d4c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d52:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106d55:	39 d3                	cmp    %edx,%ebx
80106d57:	73 56                	jae    80106daf <deallocuvm.part.0+0x6f>
80106d59:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106d5c:	89 c6                	mov    %eax,%esi
80106d5e:	89 d7                	mov    %edx,%edi
80106d60:	eb 12                	jmp    80106d74 <deallocuvm.part.0+0x34>
80106d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106d68:	83 c2 01             	add    $0x1,%edx
80106d6b:	89 d3                	mov    %edx,%ebx
80106d6d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106d70:	39 fb                	cmp    %edi,%ebx
80106d72:	73 38                	jae    80106dac <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80106d74:	89 da                	mov    %ebx,%edx
80106d76:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106d79:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106d7c:	a8 01                	test   $0x1,%al
80106d7e:	74 e8                	je     80106d68 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106d80:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106d87:	c1 e9 0a             	shr    $0xa,%ecx
80106d8a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106d90:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106d97:	85 c0                	test   %eax,%eax
80106d99:	74 cd                	je     80106d68 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80106d9b:	8b 10                	mov    (%eax),%edx
80106d9d:	f6 c2 01             	test   $0x1,%dl
80106da0:	75 1e                	jne    80106dc0 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80106da2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106da8:	39 fb                	cmp    %edi,%ebx
80106daa:	72 c8                	jb     80106d74 <deallocuvm.part.0+0x34>
80106dac:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106daf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106db2:	89 c8                	mov    %ecx,%eax
80106db4:	5b                   	pop    %ebx
80106db5:	5e                   	pop    %esi
80106db6:	5f                   	pop    %edi
80106db7:	5d                   	pop    %ebp
80106db8:	c3                   	ret
80106db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106dc0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106dc6:	74 26                	je     80106dee <deallocuvm.part.0+0xae>
      kfree(v);
80106dc8:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106dcb:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106dd1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106dd4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106dda:	52                   	push   %edx
80106ddb:	e8 60 bc ff ff       	call   80102a40 <kfree>
      *pte = 0;
80106de0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106de3:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106de6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106dec:	eb 82                	jmp    80106d70 <deallocuvm.part.0+0x30>
        panic("kfree");
80106dee:	83 ec 0c             	sub    $0xc,%esp
80106df1:	68 cc 78 10 80       	push   $0x801078cc
80106df6:	e8 85 95 ff ff       	call   80100380 <panic>
80106dfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106e00 <mappages>:
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	57                   	push   %edi
80106e04:	56                   	push   %esi
80106e05:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106e06:	89 d3                	mov    %edx,%ebx
80106e08:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106e0e:	83 ec 1c             	sub    $0x1c,%esp
80106e11:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106e14:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106e18:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106e1d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106e20:	8b 45 08             	mov    0x8(%ebp),%eax
80106e23:	29 d8                	sub    %ebx,%eax
80106e25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106e28:	eb 3f                	jmp    80106e69 <mappages+0x69>
80106e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106e30:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106e32:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106e37:	c1 ea 0a             	shr    $0xa,%edx
80106e3a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106e40:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106e47:	85 c0                	test   %eax,%eax
80106e49:	74 75                	je     80106ec0 <mappages+0xc0>
    if(*pte & PTE_P)
80106e4b:	f6 00 01             	testb  $0x1,(%eax)
80106e4e:	0f 85 86 00 00 00    	jne    80106eda <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106e54:	0b 75 0c             	or     0xc(%ebp),%esi
80106e57:	83 ce 01             	or     $0x1,%esi
80106e5a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106e5c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106e5f:	39 c3                	cmp    %eax,%ebx
80106e61:	74 6d                	je     80106ed0 <mappages+0xd0>
    a += PGSIZE;
80106e63:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106e69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106e6c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106e6f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80106e72:	89 d8                	mov    %ebx,%eax
80106e74:	c1 e8 16             	shr    $0x16,%eax
80106e77:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106e7a:	8b 07                	mov    (%edi),%eax
80106e7c:	a8 01                	test   $0x1,%al
80106e7e:	75 b0                	jne    80106e30 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106e80:	e8 7b bd ff ff       	call   80102c00 <kalloc>
80106e85:	85 c0                	test   %eax,%eax
80106e87:	74 37                	je     80106ec0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106e89:	83 ec 04             	sub    $0x4,%esp
80106e8c:	68 00 10 00 00       	push   $0x1000
80106e91:	6a 00                	push   $0x0
80106e93:	50                   	push   %eax
80106e94:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106e97:	e8 a4 dd ff ff       	call   80104c40 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106e9c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106e9f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106ea2:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106ea8:	83 c8 07             	or     $0x7,%eax
80106eab:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106ead:	89 d8                	mov    %ebx,%eax
80106eaf:	c1 e8 0a             	shr    $0xa,%eax
80106eb2:	25 fc 0f 00 00       	and    $0xffc,%eax
80106eb7:	01 d0                	add    %edx,%eax
80106eb9:	eb 90                	jmp    80106e4b <mappages+0x4b>
80106ebb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80106ec0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106ec3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ec8:	5b                   	pop    %ebx
80106ec9:	5e                   	pop    %esi
80106eca:	5f                   	pop    %edi
80106ecb:	5d                   	pop    %ebp
80106ecc:	c3                   	ret
80106ecd:	8d 76 00             	lea    0x0(%esi),%esi
80106ed0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ed3:	31 c0                	xor    %eax,%eax
}
80106ed5:	5b                   	pop    %ebx
80106ed6:	5e                   	pop    %esi
80106ed7:	5f                   	pop    %edi
80106ed8:	5d                   	pop    %ebp
80106ed9:	c3                   	ret
      panic("remap");
80106eda:	83 ec 0c             	sub    $0xc,%esp
80106edd:	68 00 7b 10 80       	push   $0x80107b00
80106ee2:	e8 99 94 ff ff       	call   80100380 <panic>
80106ee7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106eee:	00 
80106eef:	90                   	nop

80106ef0 <seginit>:
{
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106ef6:	e8 e5 cf ff ff       	call   80103ee0 <cpuid>
  pd[0] = size-1;
80106efb:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106f00:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106f06:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106f0a:	c7 80 38 28 11 80 ff 	movl   $0xffff,-0x7feed7c8(%eax)
80106f11:	ff 00 00 
80106f14:	c7 80 3c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7c4(%eax)
80106f1b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106f1e:	c7 80 40 28 11 80 ff 	movl   $0xffff,-0x7feed7c0(%eax)
80106f25:	ff 00 00 
80106f28:	c7 80 44 28 11 80 00 	movl   $0xcf9200,-0x7feed7bc(%eax)
80106f2f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106f32:	c7 80 48 28 11 80 ff 	movl   $0xffff,-0x7feed7b8(%eax)
80106f39:	ff 00 00 
80106f3c:	c7 80 4c 28 11 80 00 	movl   $0xcffa00,-0x7feed7b4(%eax)
80106f43:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f46:	c7 80 50 28 11 80 ff 	movl   $0xffff,-0x7feed7b0(%eax)
80106f4d:	ff 00 00 
80106f50:	c7 80 54 28 11 80 00 	movl   $0xcff200,-0x7feed7ac(%eax)
80106f57:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106f5a:	05 30 28 11 80       	add    $0x80112830,%eax
  pd[1] = (uint)p;
80106f5f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106f63:	c1 e8 10             	shr    $0x10,%eax
80106f66:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106f6a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106f6d:	0f 01 10             	lgdtl  (%eax)
}
80106f70:	c9                   	leave
80106f71:	c3                   	ret
80106f72:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f79:	00 
80106f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f80 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f80:	a1 e4 54 11 80       	mov    0x801154e4,%eax
80106f85:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106f8a:	0f 22 d8             	mov    %eax,%cr3
}
80106f8d:	c3                   	ret
80106f8e:	66 90                	xchg   %ax,%ax

80106f90 <switchuvm>:
{
80106f90:	55                   	push   %ebp
80106f91:	89 e5                	mov    %esp,%ebp
80106f93:	57                   	push   %edi
80106f94:	56                   	push   %esi
80106f95:	53                   	push   %ebx
80106f96:	83 ec 1c             	sub    $0x1c,%esp
80106f99:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106f9c:	85 f6                	test   %esi,%esi
80106f9e:	0f 84 cb 00 00 00    	je     8010706f <switchuvm+0xdf>
  if(p->kstack == 0)
80106fa4:	8b 46 08             	mov    0x8(%esi),%eax
80106fa7:	85 c0                	test   %eax,%eax
80106fa9:	0f 84 da 00 00 00    	je     80107089 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106faf:	8b 46 04             	mov    0x4(%esi),%eax
80106fb2:	85 c0                	test   %eax,%eax
80106fb4:	0f 84 c2 00 00 00    	je     8010707c <switchuvm+0xec>
  pushcli();
80106fba:	e8 31 da ff ff       	call   801049f0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106fbf:	e8 bc ce ff ff       	call   80103e80 <mycpu>
80106fc4:	89 c3                	mov    %eax,%ebx
80106fc6:	e8 b5 ce ff ff       	call   80103e80 <mycpu>
80106fcb:	89 c7                	mov    %eax,%edi
80106fcd:	e8 ae ce ff ff       	call   80103e80 <mycpu>
80106fd2:	83 c7 08             	add    $0x8,%edi
80106fd5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106fd8:	e8 a3 ce ff ff       	call   80103e80 <mycpu>
80106fdd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106fe0:	ba 67 00 00 00       	mov    $0x67,%edx
80106fe5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106fec:	83 c0 08             	add    $0x8,%eax
80106fef:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106ff6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106ffb:	83 c1 08             	add    $0x8,%ecx
80106ffe:	c1 e8 18             	shr    $0x18,%eax
80107001:	c1 e9 10             	shr    $0x10,%ecx
80107004:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010700a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107010:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107015:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010701c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107021:	e8 5a ce ff ff       	call   80103e80 <mycpu>
80107026:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010702d:	e8 4e ce ff ff       	call   80103e80 <mycpu>
80107032:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107036:	8b 5e 08             	mov    0x8(%esi),%ebx
80107039:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010703f:	e8 3c ce ff ff       	call   80103e80 <mycpu>
80107044:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107047:	e8 34 ce ff ff       	call   80103e80 <mycpu>
8010704c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107050:	b8 28 00 00 00       	mov    $0x28,%eax
80107055:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107058:	8b 46 04             	mov    0x4(%esi),%eax
8010705b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107060:	0f 22 d8             	mov    %eax,%cr3
}
80107063:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107066:	5b                   	pop    %ebx
80107067:	5e                   	pop    %esi
80107068:	5f                   	pop    %edi
80107069:	5d                   	pop    %ebp
  popcli();
8010706a:	e9 d1 d9 ff ff       	jmp    80104a40 <popcli>
    panic("switchuvm: no process");
8010706f:	83 ec 0c             	sub    $0xc,%esp
80107072:	68 06 7b 10 80       	push   $0x80107b06
80107077:	e8 04 93 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
8010707c:	83 ec 0c             	sub    $0xc,%esp
8010707f:	68 31 7b 10 80       	push   $0x80107b31
80107084:	e8 f7 92 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80107089:	83 ec 0c             	sub    $0xc,%esp
8010708c:	68 1c 7b 10 80       	push   $0x80107b1c
80107091:	e8 ea 92 ff ff       	call   80100380 <panic>
80107096:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010709d:	00 
8010709e:	66 90                	xchg   %ax,%ax

801070a0 <inituvm>:
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	57                   	push   %edi
801070a4:	56                   	push   %esi
801070a5:	53                   	push   %ebx
801070a6:	83 ec 1c             	sub    $0x1c,%esp
801070a9:	8b 45 08             	mov    0x8(%ebp),%eax
801070ac:	8b 75 10             	mov    0x10(%ebp),%esi
801070af:	8b 7d 0c             	mov    0xc(%ebp),%edi
801070b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801070b5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801070bb:	77 49                	ja     80107106 <inituvm+0x66>
  mem = kalloc();
801070bd:	e8 3e bb ff ff       	call   80102c00 <kalloc>
  memset(mem, 0, PGSIZE);
801070c2:	83 ec 04             	sub    $0x4,%esp
801070c5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801070ca:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801070cc:	6a 00                	push   $0x0
801070ce:	50                   	push   %eax
801070cf:	e8 6c db ff ff       	call   80104c40 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801070d4:	58                   	pop    %eax
801070d5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801070db:	5a                   	pop    %edx
801070dc:	6a 06                	push   $0x6
801070de:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070e3:	31 d2                	xor    %edx,%edx
801070e5:	50                   	push   %eax
801070e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070e9:	e8 12 fd ff ff       	call   80106e00 <mappages>
  memmove(mem, init, sz);
801070ee:	83 c4 10             	add    $0x10,%esp
801070f1:	89 75 10             	mov    %esi,0x10(%ebp)
801070f4:	89 7d 0c             	mov    %edi,0xc(%ebp)
801070f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801070fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070fd:	5b                   	pop    %ebx
801070fe:	5e                   	pop    %esi
801070ff:	5f                   	pop    %edi
80107100:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107101:	e9 ca db ff ff       	jmp    80104cd0 <memmove>
    panic("inituvm: more than a page");
80107106:	83 ec 0c             	sub    $0xc,%esp
80107109:	68 45 7b 10 80       	push   $0x80107b45
8010710e:	e8 6d 92 ff ff       	call   80100380 <panic>
80107113:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010711a:	00 
8010711b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107120 <loaduvm>:
{
80107120:	55                   	push   %ebp
80107121:	89 e5                	mov    %esp,%ebp
80107123:	57                   	push   %edi
80107124:	56                   	push   %esi
80107125:	53                   	push   %ebx
80107126:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107129:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010712c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010712f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107135:	0f 85 a2 00 00 00    	jne    801071dd <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
8010713b:	85 ff                	test   %edi,%edi
8010713d:	74 7d                	je     801071bc <loaduvm+0x9c>
8010713f:	90                   	nop
  pde = &pgdir[PDX(va)];
80107140:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107143:	8b 55 08             	mov    0x8(%ebp),%edx
80107146:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80107148:	89 c1                	mov    %eax,%ecx
8010714a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010714d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107150:	f6 c1 01             	test   $0x1,%cl
80107153:	75 13                	jne    80107168 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80107155:	83 ec 0c             	sub    $0xc,%esp
80107158:	68 5f 7b 10 80       	push   $0x80107b5f
8010715d:	e8 1e 92 ff ff       	call   80100380 <panic>
80107162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107168:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010716b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107171:	25 fc 0f 00 00       	and    $0xffc,%eax
80107176:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010717d:	85 c9                	test   %ecx,%ecx
8010717f:	74 d4                	je     80107155 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80107181:	89 fb                	mov    %edi,%ebx
80107183:	b8 00 10 00 00       	mov    $0x1000,%eax
80107188:	29 f3                	sub    %esi,%ebx
8010718a:	39 c3                	cmp    %eax,%ebx
8010718c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010718f:	53                   	push   %ebx
80107190:	8b 45 14             	mov    0x14(%ebp),%eax
80107193:	01 f0                	add    %esi,%eax
80107195:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80107196:	8b 01                	mov    (%ecx),%eax
80107198:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010719d:	05 00 00 00 80       	add    $0x80000000,%eax
801071a2:	50                   	push   %eax
801071a3:	ff 75 10             	push   0x10(%ebp)
801071a6:	e8 a5 ae ff ff       	call   80102050 <readi>
801071ab:	83 c4 10             	add    $0x10,%esp
801071ae:	39 d8                	cmp    %ebx,%eax
801071b0:	75 1e                	jne    801071d0 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
801071b2:	81 c6 00 10 00 00    	add    $0x1000,%esi
801071b8:	39 fe                	cmp    %edi,%esi
801071ba:	72 84                	jb     80107140 <loaduvm+0x20>
}
801071bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801071bf:	31 c0                	xor    %eax,%eax
}
801071c1:	5b                   	pop    %ebx
801071c2:	5e                   	pop    %esi
801071c3:	5f                   	pop    %edi
801071c4:	5d                   	pop    %ebp
801071c5:	c3                   	ret
801071c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801071cd:	00 
801071ce:	66 90                	xchg   %ax,%ax
801071d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801071d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801071d8:	5b                   	pop    %ebx
801071d9:	5e                   	pop    %esi
801071da:	5f                   	pop    %edi
801071db:	5d                   	pop    %ebp
801071dc:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
801071dd:	83 ec 0c             	sub    $0xc,%esp
801071e0:	68 d8 7d 10 80       	push   $0x80107dd8
801071e5:	e8 96 91 ff ff       	call   80100380 <panic>
801071ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801071f0 <allocuvm>:
{
801071f0:	55                   	push   %ebp
801071f1:	89 e5                	mov    %esp,%ebp
801071f3:	57                   	push   %edi
801071f4:	56                   	push   %esi
801071f5:	53                   	push   %ebx
801071f6:	83 ec 1c             	sub    $0x1c,%esp
801071f9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
801071fc:	85 f6                	test   %esi,%esi
801071fe:	0f 88 98 00 00 00    	js     8010729c <allocuvm+0xac>
80107204:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80107206:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107209:	0f 82 a1 00 00 00    	jb     801072b0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010720f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107212:	05 ff 0f 00 00       	add    $0xfff,%eax
80107217:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010721c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
8010721e:	39 f0                	cmp    %esi,%eax
80107220:	0f 83 8d 00 00 00    	jae    801072b3 <allocuvm+0xc3>
80107226:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107229:	eb 44                	jmp    8010726f <allocuvm+0x7f>
8010722b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107230:	83 ec 04             	sub    $0x4,%esp
80107233:	68 00 10 00 00       	push   $0x1000
80107238:	6a 00                	push   $0x0
8010723a:	50                   	push   %eax
8010723b:	e8 00 da ff ff       	call   80104c40 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107240:	58                   	pop    %eax
80107241:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107247:	5a                   	pop    %edx
80107248:	6a 06                	push   $0x6
8010724a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010724f:	89 fa                	mov    %edi,%edx
80107251:	50                   	push   %eax
80107252:	8b 45 08             	mov    0x8(%ebp),%eax
80107255:	e8 a6 fb ff ff       	call   80106e00 <mappages>
8010725a:	83 c4 10             	add    $0x10,%esp
8010725d:	85 c0                	test   %eax,%eax
8010725f:	78 5f                	js     801072c0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80107261:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107267:	39 f7                	cmp    %esi,%edi
80107269:	0f 83 89 00 00 00    	jae    801072f8 <allocuvm+0x108>
    mem = kalloc();
8010726f:	e8 8c b9 ff ff       	call   80102c00 <kalloc>
80107274:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107276:	85 c0                	test   %eax,%eax
80107278:	75 b6                	jne    80107230 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010727a:	83 ec 0c             	sub    $0xc,%esp
8010727d:	68 7d 7b 10 80       	push   $0x80107b7d
80107282:	e8 d9 93 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80107287:	83 c4 10             	add    $0x10,%esp
8010728a:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010728d:	74 0d                	je     8010729c <allocuvm+0xac>
8010728f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107292:	8b 45 08             	mov    0x8(%ebp),%eax
80107295:	89 f2                	mov    %esi,%edx
80107297:	e8 a4 fa ff ff       	call   80106d40 <deallocuvm.part.0>
    return 0;
8010729c:	31 d2                	xor    %edx,%edx
}
8010729e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072a1:	89 d0                	mov    %edx,%eax
801072a3:	5b                   	pop    %ebx
801072a4:	5e                   	pop    %esi
801072a5:	5f                   	pop    %edi
801072a6:	5d                   	pop    %ebp
801072a7:	c3                   	ret
801072a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801072af:	00 
    return oldsz;
801072b0:	8b 55 0c             	mov    0xc(%ebp),%edx
}
801072b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072b6:	89 d0                	mov    %edx,%eax
801072b8:	5b                   	pop    %ebx
801072b9:	5e                   	pop    %esi
801072ba:	5f                   	pop    %edi
801072bb:	5d                   	pop    %ebp
801072bc:	c3                   	ret
801072bd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801072c0:	83 ec 0c             	sub    $0xc,%esp
801072c3:	68 95 7b 10 80       	push   $0x80107b95
801072c8:	e8 93 93 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801072cd:	83 c4 10             	add    $0x10,%esp
801072d0:	3b 75 0c             	cmp    0xc(%ebp),%esi
801072d3:	74 0d                	je     801072e2 <allocuvm+0xf2>
801072d5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801072d8:	8b 45 08             	mov    0x8(%ebp),%eax
801072db:	89 f2                	mov    %esi,%edx
801072dd:	e8 5e fa ff ff       	call   80106d40 <deallocuvm.part.0>
      kfree(mem);
801072e2:	83 ec 0c             	sub    $0xc,%esp
801072e5:	53                   	push   %ebx
801072e6:	e8 55 b7 ff ff       	call   80102a40 <kfree>
      return 0;
801072eb:	83 c4 10             	add    $0x10,%esp
    return 0;
801072ee:	31 d2                	xor    %edx,%edx
801072f0:	eb ac                	jmp    8010729e <allocuvm+0xae>
801072f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801072f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
801072fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072fe:	5b                   	pop    %ebx
801072ff:	5e                   	pop    %esi
80107300:	89 d0                	mov    %edx,%eax
80107302:	5f                   	pop    %edi
80107303:	5d                   	pop    %ebp
80107304:	c3                   	ret
80107305:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010730c:	00 
8010730d:	8d 76 00             	lea    0x0(%esi),%esi

80107310 <deallocuvm>:
{
80107310:	55                   	push   %ebp
80107311:	89 e5                	mov    %esp,%ebp
80107313:	8b 55 0c             	mov    0xc(%ebp),%edx
80107316:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107319:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010731c:	39 d1                	cmp    %edx,%ecx
8010731e:	73 10                	jae    80107330 <deallocuvm+0x20>
}
80107320:	5d                   	pop    %ebp
80107321:	e9 1a fa ff ff       	jmp    80106d40 <deallocuvm.part.0>
80107326:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010732d:	00 
8010732e:	66 90                	xchg   %ax,%ax
80107330:	89 d0                	mov    %edx,%eax
80107332:	5d                   	pop    %ebp
80107333:	c3                   	ret
80107334:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010733b:	00 
8010733c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107340 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	57                   	push   %edi
80107344:	56                   	push   %esi
80107345:	53                   	push   %ebx
80107346:	83 ec 0c             	sub    $0xc,%esp
80107349:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010734c:	85 f6                	test   %esi,%esi
8010734e:	74 59                	je     801073a9 <freevm+0x69>
  if(newsz >= oldsz)
80107350:	31 c9                	xor    %ecx,%ecx
80107352:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107357:	89 f0                	mov    %esi,%eax
80107359:	89 f3                	mov    %esi,%ebx
8010735b:	e8 e0 f9 ff ff       	call   80106d40 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107360:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107366:	eb 0f                	jmp    80107377 <freevm+0x37>
80107368:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010736f:	00 
80107370:	83 c3 04             	add    $0x4,%ebx
80107373:	39 fb                	cmp    %edi,%ebx
80107375:	74 23                	je     8010739a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107377:	8b 03                	mov    (%ebx),%eax
80107379:	a8 01                	test   $0x1,%al
8010737b:	74 f3                	je     80107370 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010737d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107382:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107385:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107388:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010738d:	50                   	push   %eax
8010738e:	e8 ad b6 ff ff       	call   80102a40 <kfree>
80107393:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107396:	39 fb                	cmp    %edi,%ebx
80107398:	75 dd                	jne    80107377 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010739a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010739d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073a0:	5b                   	pop    %ebx
801073a1:	5e                   	pop    %esi
801073a2:	5f                   	pop    %edi
801073a3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801073a4:	e9 97 b6 ff ff       	jmp    80102a40 <kfree>
    panic("freevm: no pgdir");
801073a9:	83 ec 0c             	sub    $0xc,%esp
801073ac:	68 b1 7b 10 80       	push   $0x80107bb1
801073b1:	e8 ca 8f ff ff       	call   80100380 <panic>
801073b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801073bd:	00 
801073be:	66 90                	xchg   %ax,%ax

801073c0 <setupkvm>:
{
801073c0:	55                   	push   %ebp
801073c1:	89 e5                	mov    %esp,%ebp
801073c3:	56                   	push   %esi
801073c4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801073c5:	e8 36 b8 ff ff       	call   80102c00 <kalloc>
801073ca:	85 c0                	test   %eax,%eax
801073cc:	74 5e                	je     8010742c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
801073ce:	83 ec 04             	sub    $0x4,%esp
801073d1:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801073d3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801073d8:	68 00 10 00 00       	push   $0x1000
801073dd:	6a 00                	push   $0x0
801073df:	50                   	push   %eax
801073e0:	e8 5b d8 ff ff       	call   80104c40 <memset>
801073e5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801073e8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801073eb:	83 ec 08             	sub    $0x8,%esp
801073ee:	8b 4b 08             	mov    0x8(%ebx),%ecx
801073f1:	8b 13                	mov    (%ebx),%edx
801073f3:	ff 73 0c             	push   0xc(%ebx)
801073f6:	50                   	push   %eax
801073f7:	29 c1                	sub    %eax,%ecx
801073f9:	89 f0                	mov    %esi,%eax
801073fb:	e8 00 fa ff ff       	call   80106e00 <mappages>
80107400:	83 c4 10             	add    $0x10,%esp
80107403:	85 c0                	test   %eax,%eax
80107405:	78 19                	js     80107420 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107407:	83 c3 10             	add    $0x10,%ebx
8010740a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107410:	75 d6                	jne    801073e8 <setupkvm+0x28>
}
80107412:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107415:	89 f0                	mov    %esi,%eax
80107417:	5b                   	pop    %ebx
80107418:	5e                   	pop    %esi
80107419:	5d                   	pop    %ebp
8010741a:	c3                   	ret
8010741b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107420:	83 ec 0c             	sub    $0xc,%esp
80107423:	56                   	push   %esi
80107424:	e8 17 ff ff ff       	call   80107340 <freevm>
      return 0;
80107429:	83 c4 10             	add    $0x10,%esp
}
8010742c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010742f:	31 f6                	xor    %esi,%esi
}
80107431:	89 f0                	mov    %esi,%eax
80107433:	5b                   	pop    %ebx
80107434:	5e                   	pop    %esi
80107435:	5d                   	pop    %ebp
80107436:	c3                   	ret
80107437:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010743e:	00 
8010743f:	90                   	nop

80107440 <kvmalloc>:
{
80107440:	55                   	push   %ebp
80107441:	89 e5                	mov    %esp,%ebp
80107443:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107446:	e8 75 ff ff ff       	call   801073c0 <setupkvm>
8010744b:	a3 e4 54 11 80       	mov    %eax,0x801154e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107450:	05 00 00 00 80       	add    $0x80000000,%eax
80107455:	0f 22 d8             	mov    %eax,%cr3
}
80107458:	c9                   	leave
80107459:	c3                   	ret
8010745a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107460 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107460:	55                   	push   %ebp
80107461:	89 e5                	mov    %esp,%ebp
80107463:	83 ec 08             	sub    $0x8,%esp
80107466:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107469:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010746c:	89 c1                	mov    %eax,%ecx
8010746e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107471:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107474:	f6 c2 01             	test   $0x1,%dl
80107477:	75 17                	jne    80107490 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107479:	83 ec 0c             	sub    $0xc,%esp
8010747c:	68 c2 7b 10 80       	push   $0x80107bc2
80107481:	e8 fa 8e ff ff       	call   80100380 <panic>
80107486:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010748d:	00 
8010748e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107490:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107493:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107499:	25 fc 0f 00 00       	and    $0xffc,%eax
8010749e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801074a5:	85 c0                	test   %eax,%eax
801074a7:	74 d0                	je     80107479 <clearpteu+0x19>
  *pte &= ~PTE_U;
801074a9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801074ac:	c9                   	leave
801074ad:	c3                   	ret
801074ae:	66 90                	xchg   %ax,%ax

801074b0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801074b0:	55                   	push   %ebp
801074b1:	89 e5                	mov    %esp,%ebp
801074b3:	57                   	push   %edi
801074b4:	56                   	push   %esi
801074b5:	53                   	push   %ebx
801074b6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801074b9:	e8 02 ff ff ff       	call   801073c0 <setupkvm>
801074be:	89 45 e0             	mov    %eax,-0x20(%ebp)
801074c1:	85 c0                	test   %eax,%eax
801074c3:	0f 84 e9 00 00 00    	je     801075b2 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801074c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801074cc:	85 c9                	test   %ecx,%ecx
801074ce:	0f 84 b2 00 00 00    	je     80107586 <copyuvm+0xd6>
801074d4:	31 f6                	xor    %esi,%esi
801074d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074dd:	00 
801074de:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
801074e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801074e3:	89 f0                	mov    %esi,%eax
801074e5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801074e8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801074eb:	a8 01                	test   $0x1,%al
801074ed:	75 11                	jne    80107500 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801074ef:	83 ec 0c             	sub    $0xc,%esp
801074f2:	68 cc 7b 10 80       	push   $0x80107bcc
801074f7:	e8 84 8e ff ff       	call   80100380 <panic>
801074fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107500:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107502:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107507:	c1 ea 0a             	shr    $0xa,%edx
8010750a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107510:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107517:	85 c0                	test   %eax,%eax
80107519:	74 d4                	je     801074ef <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010751b:	8b 00                	mov    (%eax),%eax
8010751d:	a8 01                	test   $0x1,%al
8010751f:	0f 84 9f 00 00 00    	je     801075c4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107525:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107527:	25 ff 0f 00 00       	and    $0xfff,%eax
8010752c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010752f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107535:	e8 c6 b6 ff ff       	call   80102c00 <kalloc>
8010753a:	89 c3                	mov    %eax,%ebx
8010753c:	85 c0                	test   %eax,%eax
8010753e:	74 64                	je     801075a4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107540:	83 ec 04             	sub    $0x4,%esp
80107543:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107549:	68 00 10 00 00       	push   $0x1000
8010754e:	57                   	push   %edi
8010754f:	50                   	push   %eax
80107550:	e8 7b d7 ff ff       	call   80104cd0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107555:	58                   	pop    %eax
80107556:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010755c:	5a                   	pop    %edx
8010755d:	ff 75 e4             	push   -0x1c(%ebp)
80107560:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107565:	89 f2                	mov    %esi,%edx
80107567:	50                   	push   %eax
80107568:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010756b:	e8 90 f8 ff ff       	call   80106e00 <mappages>
80107570:	83 c4 10             	add    $0x10,%esp
80107573:	85 c0                	test   %eax,%eax
80107575:	78 21                	js     80107598 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107577:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010757d:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107580:	0f 82 5a ff ff ff    	jb     801074e0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107586:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107589:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010758c:	5b                   	pop    %ebx
8010758d:	5e                   	pop    %esi
8010758e:	5f                   	pop    %edi
8010758f:	5d                   	pop    %ebp
80107590:	c3                   	ret
80107591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107598:	83 ec 0c             	sub    $0xc,%esp
8010759b:	53                   	push   %ebx
8010759c:	e8 9f b4 ff ff       	call   80102a40 <kfree>
      goto bad;
801075a1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801075a4:	83 ec 0c             	sub    $0xc,%esp
801075a7:	ff 75 e0             	push   -0x20(%ebp)
801075aa:	e8 91 fd ff ff       	call   80107340 <freevm>
  return 0;
801075af:	83 c4 10             	add    $0x10,%esp
    return 0;
801075b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801075b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801075bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075bf:	5b                   	pop    %ebx
801075c0:	5e                   	pop    %esi
801075c1:	5f                   	pop    %edi
801075c2:	5d                   	pop    %ebp
801075c3:	c3                   	ret
      panic("copyuvm: page not present");
801075c4:	83 ec 0c             	sub    $0xc,%esp
801075c7:	68 e6 7b 10 80       	push   $0x80107be6
801075cc:	e8 af 8d ff ff       	call   80100380 <panic>
801075d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801075d8:	00 
801075d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801075e0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801075e0:	55                   	push   %ebp
801075e1:	89 e5                	mov    %esp,%ebp
801075e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801075e6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801075e9:	89 c1                	mov    %eax,%ecx
801075eb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801075ee:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801075f1:	f6 c2 01             	test   $0x1,%dl
801075f4:	0f 84 f8 00 00 00    	je     801076f2 <uva2ka.cold>
  return &pgtab[PTX(va)];
801075fa:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075fd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107603:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107604:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107609:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107610:	89 d0                	mov    %edx,%eax
80107612:	f7 d2                	not    %edx
80107614:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107619:	05 00 00 00 80       	add    $0x80000000,%eax
8010761e:	83 e2 05             	and    $0x5,%edx
80107621:	ba 00 00 00 00       	mov    $0x0,%edx
80107626:	0f 45 c2             	cmovne %edx,%eax
}
80107629:	c3                   	ret
8010762a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107630 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107630:	55                   	push   %ebp
80107631:	89 e5                	mov    %esp,%ebp
80107633:	57                   	push   %edi
80107634:	56                   	push   %esi
80107635:	53                   	push   %ebx
80107636:	83 ec 0c             	sub    $0xc,%esp
80107639:	8b 75 14             	mov    0x14(%ebp),%esi
8010763c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010763f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107642:	85 f6                	test   %esi,%esi
80107644:	75 51                	jne    80107697 <copyout+0x67>
80107646:	e9 9d 00 00 00       	jmp    801076e8 <copyout+0xb8>
8010764b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107650:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107656:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010765c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107662:	74 74                	je     801076d8 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
80107664:	89 fb                	mov    %edi,%ebx
80107666:	29 c3                	sub    %eax,%ebx
80107668:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010766e:	39 f3                	cmp    %esi,%ebx
80107670:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107673:	29 f8                	sub    %edi,%eax
80107675:	83 ec 04             	sub    $0x4,%esp
80107678:	01 c1                	add    %eax,%ecx
8010767a:	53                   	push   %ebx
8010767b:	52                   	push   %edx
8010767c:	89 55 10             	mov    %edx,0x10(%ebp)
8010767f:	51                   	push   %ecx
80107680:	e8 4b d6 ff ff       	call   80104cd0 <memmove>
    len -= n;
    buf += n;
80107685:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107688:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010768e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107691:	01 da                	add    %ebx,%edx
  while(len > 0){
80107693:	29 de                	sub    %ebx,%esi
80107695:	74 51                	je     801076e8 <copyout+0xb8>
  if(*pde & PTE_P){
80107697:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010769a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010769c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010769e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801076a1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801076a7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801076aa:	f6 c1 01             	test   $0x1,%cl
801076ad:	0f 84 46 00 00 00    	je     801076f9 <copyout.cold>
  return &pgtab[PTX(va)];
801076b3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076b5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801076bb:	c1 eb 0c             	shr    $0xc,%ebx
801076be:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801076c4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801076cb:	89 d9                	mov    %ebx,%ecx
801076cd:	f7 d1                	not    %ecx
801076cf:	83 e1 05             	and    $0x5,%ecx
801076d2:	0f 84 78 ff ff ff    	je     80107650 <copyout+0x20>
  }
  return 0;
}
801076d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801076db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801076e0:	5b                   	pop    %ebx
801076e1:	5e                   	pop    %esi
801076e2:	5f                   	pop    %edi
801076e3:	5d                   	pop    %ebp
801076e4:	c3                   	ret
801076e5:	8d 76 00             	lea    0x0(%esi),%esi
801076e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801076eb:	31 c0                	xor    %eax,%eax
}
801076ed:	5b                   	pop    %ebx
801076ee:	5e                   	pop    %esi
801076ef:	5f                   	pop    %edi
801076f0:	5d                   	pop    %ebp
801076f1:	c3                   	ret

801076f2 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801076f2:	a1 00 00 00 00       	mov    0x0,%eax
801076f7:	0f 0b                	ud2

801076f9 <copyout.cold>:
801076f9:	a1 00 00 00 00       	mov    0x0,%eax
801076fe:	0f 0b                	ud2
