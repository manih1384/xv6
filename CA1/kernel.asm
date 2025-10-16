
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
80100028:	bc 70 65 11 80       	mov    $0x80116570,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 60 43 10 80       	mov    $0x80104360,%eax
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
8010004c:	68 a0 84 10 80       	push   $0x801084a0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 75 56 00 00       	call   801056d0 <initlock>
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
80100092:	68 a7 84 10 80       	push   $0x801084a7
80100097:	50                   	push   %eax
80100098:	e8 03 55 00 00       	call   801055a0 <initsleeplock>
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
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
801000e4:	e8 b7 57 00 00       	call   801058a0 <acquire>
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
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
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
80100162:	e8 d9 56 00 00       	call   80105840 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 54 00 00       	call   801055e0 <acquiresleep>
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
8010018c:	e8 4f 34 00 00       	call   801035e0 <iderw>
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
801001a1:	68 ae 84 10 80       	push   $0x801084ae
801001a6:	e8 35 0b 00 00       	call   80100ce0 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

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
801001be:	e8 bd 54 00 00       	call   80105680 <holdingsleep>
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
801001d4:	e9 07 34 00 00       	jmp    801035e0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 bf 84 10 80       	push   $0x801084bf
801001e1:	e8 fa 0a 00 00       	call   80100ce0 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

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
801001ff:	e8 7c 54 00 00       	call   80105680 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 2c 54 00 00       	call   80105640 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 80 56 00 00       	call   801058a0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 cf 55 00 00       	jmp    80105840 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 c6 84 10 80       	push   $0x801084c6
80100279:	e8 62 0a 00 00       	call   80100ce0 <panic>
8010027e:	66 90                	xchg   %ax,%ax

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
80100294:	e8 c7 28 00 00       	call   80102b60 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
801002a0:	e8 fb 55 00 00       	call   801058a0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
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
801002c3:	68 c0 ff 10 80       	push   $0x8010ffc0
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 6e 50 00 00       	call   80105340 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 89 49 00 00       	call   80104c70 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 c0 ff 10 80       	push   $0x8010ffc0
801002f6:	e8 45 55 00 00       	call   80105840 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 7c 27 00 00       	call   80102a80 <ilock>
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
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
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
80100347:	68 c0 ff 10 80       	push   $0x8010ffc0
8010034c:	e8 ef 54 00 00       	call   80105840 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 26 27 00 00       	call   80102a80 <ilock>
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
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <highlight_from_buffer_positions.part.0>:
void highlight_from_buffer_positions(void) {
80100380:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100381:	b8 0e 00 00 00       	mov    $0xe,%eax
80100386:	89 e5                	mov    %esp,%ebp
80100388:	56                   	push   %esi
80100389:	be d4 03 00 00       	mov    $0x3d4,%esi
8010038e:	53                   	push   %ebx
8010038f:	89 f2                	mov    %esi,%edx
80100391:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100392:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100397:	89 ca                	mov    %ecx,%edx
80100399:	ec                   	in     (%dx),%al
  cursor_screen_pos = inb(CRTPORT+1) << 8;
8010039a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010039d:	89 f2                	mov    %esi,%edx
8010039f:	b8 0f 00 00 00       	mov    $0xf,%eax
801003a4:	c1 e3 08             	shl    $0x8,%ebx
801003a7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003a8:	89 ca                	mov    %ecx,%edx
801003aa:	ec                   	in     (%dx),%al
  int line_start = cursor_screen_pos - prompt_length - (input.e - left_key_pressed_count);
801003ab:	8b 0d 08 ff 10 80    	mov    0x8010ff08,%ecx
801003b1:	8b 15 b0 ff 10 80    	mov    0x8010ffb0,%edx
  cursor_screen_pos |= inb(CRTPORT+1);
801003b7:	0f b6 c0             	movzbl %al,%eax
801003ba:	09 d8                	or     %ebx,%eax
  int line_start = cursor_screen_pos - prompt_length - (input.e - left_key_pressed_count);
801003bc:	29 ca                	sub    %ecx,%edx
801003be:	8d 54 10 fe          	lea    -0x2(%eax,%edx,1),%edx
  for (int buf_pos = select_start; buf_pos < select_end && buf_pos < input.e; buf_pos++) {
801003c2:	a1 ac ff 10 80       	mov    0x8010ffac,%eax
801003c7:	3b 05 a8 ff 10 80    	cmp    0x8010ffa8,%eax
801003cd:	7d 31                	jge    80100400 <highlight_from_buffer_positions.part.0+0x80>
801003cf:	8d 54 02 02          	lea    0x2(%edx,%eax,1),%edx
801003d3:	eb 27                	jmp    801003fc <highlight_from_buffer_positions.part.0+0x7c>
801003d5:	8d 76 00             	lea    0x0(%esi),%esi
      if (screen_pos >= 0 && screen_pos < 80*25) {
801003d8:	81 fa cf 07 00 00    	cmp    $0x7cf,%edx
801003de:	77 08                	ja     801003e8 <highlight_from_buffer_positions.part.0+0x68>
          crt[screen_pos] = (crt[screen_pos] & 0x00FF) | 0x7000;
801003e0:	c6 84 12 01 80 0b 80 	movb   $0x70,-0x7ff47fff(%edx,%edx,1)
801003e7:	70 
  for (int buf_pos = select_start; buf_pos < select_end && buf_pos < input.e; buf_pos++) {
801003e8:	83 c0 01             	add    $0x1,%eax
801003eb:	83 c2 01             	add    $0x1,%edx
801003ee:	3b 05 a8 ff 10 80    	cmp    0x8010ffa8,%eax
801003f4:	7d 0a                	jge    80100400 <highlight_from_buffer_positions.part.0+0x80>
801003f6:	8b 0d 08 ff 10 80    	mov    0x8010ff08,%ecx
801003fc:	39 c1                	cmp    %eax,%ecx
801003fe:	77 d8                	ja     801003d8 <highlight_from_buffer_positions.part.0+0x58>
}
80100400:	5b                   	pop    %ebx
80100401:	5e                   	pop    %esi
80100402:	5d                   	pop    %ebp
80100403:	c3                   	ret    
80100404:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010040b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010040f:	90                   	nop

80100410 <clear_highlight_from_buffer.part.0>:
void clear_highlight_from_buffer(void) {
80100410:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100411:	b8 0e 00 00 00       	mov    $0xe,%eax
80100416:	89 e5                	mov    %esp,%ebp
80100418:	56                   	push   %esi
80100419:	be d4 03 00 00       	mov    $0x3d4,%esi
8010041e:	53                   	push   %ebx
8010041f:	89 f2                	mov    %esi,%edx
80100421:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100422:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100427:	89 ca                	mov    %ecx,%edx
80100429:	ec                   	in     (%dx),%al
  cursor_screen_pos = inb(CRTPORT+1) << 8;
8010042a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010042d:	89 f2                	mov    %esi,%edx
8010042f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100434:	c1 e3 08             	shl    $0x8,%ebx
80100437:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100438:	89 ca                	mov    %ecx,%edx
8010043a:	ec                   	in     (%dx),%al
  int line_start = cursor_screen_pos - prompt_length - (input.e - left_key_pressed_count);
8010043b:	8b 0d 08 ff 10 80    	mov    0x8010ff08,%ecx
80100441:	8b 15 b0 ff 10 80    	mov    0x8010ffb0,%edx
  cursor_screen_pos |= inb(CRTPORT+1);
80100447:	0f b6 c0             	movzbl %al,%eax
8010044a:	09 d8                	or     %ebx,%eax
  int line_start = cursor_screen_pos - prompt_length - (input.e - left_key_pressed_count);
8010044c:	29 ca                	sub    %ecx,%edx
8010044e:	8d 54 10 fe          	lea    -0x2(%eax,%edx,1),%edx
  for (int buf_pos = select_start; buf_pos < select_end && buf_pos < input.e; buf_pos++) {
80100452:	a1 ac ff 10 80       	mov    0x8010ffac,%eax
80100457:	3b 05 a8 ff 10 80    	cmp    0x8010ffa8,%eax
8010045d:	7d 31                	jge    80100490 <clear_highlight_from_buffer.part.0+0x80>
8010045f:	8d 54 02 02          	lea    0x2(%edx,%eax,1),%edx
80100463:	eb 27                	jmp    8010048c <clear_highlight_from_buffer.part.0+0x7c>
80100465:	8d 76 00             	lea    0x0(%esi),%esi
      if (screen_pos >= 0 && screen_pos < 80*25) {
80100468:	81 fa cf 07 00 00    	cmp    $0x7cf,%edx
8010046e:	77 08                	ja     80100478 <clear_highlight_from_buffer.part.0+0x68>
          crt[screen_pos] = (crt[screen_pos] & 0x00FF) | 0x0700;
80100470:	c6 84 12 01 80 0b 80 	movb   $0x7,-0x7ff47fff(%edx,%edx,1)
80100477:	07 
  for (int buf_pos = select_start; buf_pos < select_end && buf_pos < input.e; buf_pos++) {
80100478:	83 c0 01             	add    $0x1,%eax
8010047b:	83 c2 01             	add    $0x1,%edx
8010047e:	3b 05 a8 ff 10 80    	cmp    0x8010ffa8,%eax
80100484:	7d 0a                	jge    80100490 <clear_highlight_from_buffer.part.0+0x80>
80100486:	8b 0d 08 ff 10 80    	mov    0x8010ff08,%ecx
8010048c:	39 c1                	cmp    %eax,%ecx
8010048e:	77 d8                	ja     80100468 <clear_highlight_from_buffer.part.0+0x58>
}
80100490:	5b                   	pop    %ebx
80100491:	5e                   	pop    %esi
80100492:	5d                   	pop    %ebp
80100493:	c3                   	ret    
80100494:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010049b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010049f:	90                   	nop

801004a0 <append_cga_pos>:
    if (cga_pos_sequence.size >= cga_pos_sequence.cap) {
801004a0:	a1 20 94 10 80       	mov    0x80109420,%eax
801004a5:	3b 05 24 94 10 80    	cmp    0x80109424,%eax
801004ab:	7d 1b                	jge    801004c8 <append_cga_pos+0x28>
void append_cga_pos(int pos) {
801004ad:	55                   	push   %ebp
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
801004ae:	8d 50 01             	lea    0x1(%eax),%edx
801004b1:	89 15 20 94 10 80    	mov    %edx,0x80109420
void append_cga_pos(int pos) {
801004b7:	89 e5                	mov    %esp,%ebp
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
801004b9:	8b 55 08             	mov    0x8(%ebp),%edx
}
801004bc:	5d                   	pop    %ebp
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
801004bd:	89 14 85 20 92 10 80 	mov    %edx,-0x7fef6de0(,%eax,4)
}
801004c4:	c3                   	ret    
801004c5:	8d 76 00             	lea    0x0(%esi),%esi
801004c8:	c3                   	ret    
801004c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801004d0 <last_cga_pos>:
    if (cga_pos_sequence.size == 0) return -1;
801004d0:	a1 20 94 10 80       	mov    0x80109420,%eax
801004d5:	85 c0                	test   %eax,%eax
801004d7:	74 0f                	je     801004e8 <last_cga_pos+0x18>
    return cga_pos_sequence.pos_data[cga_pos_sequence.size - 1];
801004d9:	8b 04 85 1c 92 10 80 	mov    -0x7fef6de4(,%eax,4),%eax
801004e0:	c3                   	ret    
801004e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (cga_pos_sequence.size == 0) return -1;
801004e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801004ed:	c3                   	ret    
801004ee:	66 90                	xchg   %ax,%ax

801004f0 <delete_last_cga_pos>:
    if (cga_pos_sequence.size > 0) {
801004f0:	a1 20 94 10 80       	mov    0x80109420,%eax
801004f5:	85 c0                	test   %eax,%eax
801004f7:	7e 08                	jle    80100501 <delete_last_cga_pos+0x11>
        cga_pos_sequence.size--;
801004f9:	83 e8 01             	sub    $0x1,%eax
801004fc:	a3 20 94 10 80       	mov    %eax,0x80109420
}
80100501:	c3                   	ret    
80100502:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100510 <clear_cga_pos_sequence>:
    cga_pos_sequence.size = 0;
80100510:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
80100517:	00 00 00 
}
8010051a:	c3                   	ret    
8010051b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010051f:	90                   	nop

80100520 <delete_from_cga_pos_sequence>:
void delete_from_cga_pos_sequence(int pos) {
80100520:	55                   	push   %ebp
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100521:	8b 15 20 94 10 80    	mov    0x80109420,%edx
void delete_from_cga_pos_sequence(int pos) {
80100527:	89 e5                	mov    %esp,%ebp
80100529:	53                   	push   %ebx
8010052a:	8b 5d 08             	mov    0x8(%ebp),%ebx
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010052d:	85 d2                	test   %edx,%edx
8010052f:	7e 5b                	jle    8010058c <delete_from_cga_pos_sequence+0x6c>
80100531:	31 c0                	xor    %eax,%eax
80100533:	eb 0a                	jmp    8010053f <delete_from_cga_pos_sequence+0x1f>
80100535:	8d 76 00             	lea    0x0(%esi),%esi
80100538:	83 c0 01             	add    $0x1,%eax
8010053b:	39 c2                	cmp    %eax,%edx
8010053d:	74 4d                	je     8010058c <delete_from_cga_pos_sequence+0x6c>
        if (cga_pos_sequence.pos_data[i] == pos) {
8010053f:	39 1c 85 20 92 10 80 	cmp    %ebx,-0x7fef6de0(,%eax,4)
80100546:	75 f0                	jne    80100538 <delete_from_cga_pos_sequence+0x18>
    for (int i = idx; i < cga_pos_sequence.size - 1; i++) {
80100548:	83 ea 01             	sub    $0x1,%edx
8010054b:	39 d0                	cmp    %edx,%eax
8010054d:	7d 42                	jge    80100591 <delete_from_cga_pos_sequence+0x71>
8010054f:	90                   	nop
        cga_pos_sequence.pos_data[i] = cga_pos_sequence.pos_data[i + 1];
80100550:	83 c0 01             	add    $0x1,%eax
80100553:	8b 0c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ecx
8010055a:	89 0c 85 1c 92 10 80 	mov    %ecx,-0x7fef6de4(,%eax,4)
    for (int i = idx; i < cga_pos_sequence.size - 1; i++) {
80100561:	39 d0                	cmp    %edx,%eax
80100563:	75 eb                	jne    80100550 <delete_from_cga_pos_sequence+0x30>
    cga_pos_sequence.size--;
80100565:	89 15 20 94 10 80    	mov    %edx,0x80109420
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010056b:	31 c0                	xor    %eax,%eax
8010056d:	8d 76 00             	lea    0x0(%esi),%esi
        if (cga_pos_sequence.pos_data[i] > pos) {
80100570:	8b 0c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ecx
80100577:	39 d9                	cmp    %ebx,%ecx
80100579:	7e 0a                	jle    80100585 <delete_from_cga_pos_sequence+0x65>
            cga_pos_sequence.pos_data[i]--;
8010057b:	83 e9 01             	sub    $0x1,%ecx
8010057e:	89 0c 85 20 92 10 80 	mov    %ecx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100585:	83 c0 01             	add    $0x1,%eax
80100588:	39 d0                	cmp    %edx,%eax
8010058a:	7c e4                	jl     80100570 <delete_from_cga_pos_sequence+0x50>
}
8010058c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010058f:	c9                   	leave  
80100590:	c3                   	ret    
    cga_pos_sequence.size--;
80100591:	89 15 20 94 10 80    	mov    %edx,0x80109420
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100597:	85 d2                	test   %edx,%edx
80100599:	74 f1                	je     8010058c <delete_from_cga_pos_sequence+0x6c>
8010059b:	eb ce                	jmp    8010056b <delete_from_cga_pos_sequence+0x4b>
8010059d:	8d 76 00             	lea    0x0(%esi),%esi

801005a0 <cgaputc>:
{
801005a0:	55                   	push   %ebp
801005a1:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801005a3:	b8 0e 00 00 00       	mov    $0xe,%eax
801005a8:	89 e5                	mov    %esp,%ebp
801005aa:	57                   	push   %edi
801005ab:	bf d4 03 00 00       	mov    $0x3d4,%edi
801005b0:	56                   	push   %esi
801005b1:	89 fa                	mov    %edi,%edx
801005b3:	53                   	push   %ebx
801005b4:	83 ec 1c             	sub    $0x1c,%esp
801005b7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801005b8:	be d5 03 00 00       	mov    $0x3d5,%esi
801005bd:	89 f2                	mov    %esi,%edx
801005bf:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801005c0:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801005c3:	89 fa                	mov    %edi,%edx
801005c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801005ca:	c1 e3 08             	shl    $0x8,%ebx
801005cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801005ce:	89 f2                	mov    %esi,%edx
801005d0:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801005d1:	0f b6 f0             	movzbl %al,%esi
801005d4:	09 de                	or     %ebx,%esi
  if(c == '\n'){
801005d6:	83 f9 0a             	cmp    $0xa,%ecx
801005d9:	0f 84 89 01 00 00    	je     80100768 <cgaputc+0x1c8>
    else if(c == BACKSPACE){
801005df:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
801005e5:	0f 84 f5 00 00 00    	je     801006e0 <cgaputc+0x140>
    if (cga_pos_sequence.size == 0) return -1;
801005eb:	8b 1d 20 94 10 80    	mov    0x80109420,%ebx
else if (c == UNDO_BS) {
801005f1:	81 f9 01 01 00 00    	cmp    $0x101,%ecx
801005f7:	0f 84 f3 01 00 00    	je     801007f0 <cgaputc+0x250>
    if (cga_pos_sequence.size >= cga_pos_sequence.cap) {
801005fd:	39 1d 24 94 10 80    	cmp    %ebx,0x80109424
80100603:	0f 8e d7 01 00 00    	jle    801007e0 <cgaputc+0x240>
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
80100609:	8d 43 01             	lea    0x1(%ebx),%eax
8010060c:	89 34 9d 20 92 10 80 	mov    %esi,-0x7fef6de0(,%ebx,4)
80100613:	a3 20 94 10 80       	mov    %eax,0x80109420
    for (int i = 0; i < cga_pos_sequence.size - 1; i++) { // size-1 because we just added the new one
80100618:	31 c0                	xor    %eax,%eax
8010061a:	85 db                	test   %ebx,%ebx
8010061c:	7e 1e                	jle    8010063c <cgaputc+0x9c>
8010061e:	66 90                	xchg   %ax,%ax
        if (cga_pos_sequence.pos_data[i] >= pos) {
80100620:	8b 14 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%edx
80100627:	39 f2                	cmp    %esi,%edx
80100629:	7c 0a                	jl     80100635 <cgaputc+0x95>
            cga_pos_sequence.pos_data[i]++;
8010062b:	83 c2 01             	add    $0x1,%edx
8010062e:	89 14 85 20 92 10 80 	mov    %edx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size - 1; i++) { // size-1 because we just added the new one
80100635:	83 c0 01             	add    $0x1,%eax
80100638:	39 d8                	cmp    %ebx,%eax
8010063a:	75 e4                	jne    80100620 <cgaputc+0x80>
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
8010063c:	a1 b0 ff 10 80       	mov    0x8010ffb0,%eax
80100641:	01 f0                	add    %esi,%eax
80100643:	39 c6                	cmp    %eax,%esi
80100645:	7d 1f                	jge    80100666 <cgaputc+0xc6>
80100647:	8d 84 00 fe 7f 0b 80 	lea    -0x7ff48002(%eax,%eax,1),%eax
8010064e:	8d 9c 36 fe 7f 0b 80 	lea    -0x7ff48002(%esi,%esi,1),%ebx
80100655:	8d 76 00             	lea    0x0(%esi),%esi
      crt[i] = crt[i - 1];
80100658:	0f b7 10             	movzwl (%eax),%edx
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
8010065b:	83 e8 02             	sub    $0x2,%eax
      crt[i] = crt[i - 1];
8010065e:	66 89 50 04          	mov    %dx,0x4(%eax)
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
80100662:	39 c3                	cmp    %eax,%ebx
80100664:	75 f2                	jne    80100658 <cgaputc+0xb8>
    crt[pos++] = (c&0xff) | 0x0700;
80100666:	0f b6 c9             	movzbl %cl,%ecx
80100669:	8d 5e 01             	lea    0x1(%esi),%ebx
8010066c:	80 cd 07             	or     $0x7,%ch
8010066f:	66 89 8c 36 00 80 0b 	mov    %cx,-0x7ff48000(%esi,%esi,1)
80100676:	80 
  if(pos < 0 || pos > 25*80)
80100677:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010067d:	0f 87 30 02 00 00    	ja     801008b3 <cgaputc+0x313>
  if((pos/80) >= 24){  // Scroll up.
80100683:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100689:	0f 8f 01 01 00 00    	jg     80100790 <cgaputc+0x1f0>
  outb(CRTPORT+1, pos);
8010068f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100692:	0f b6 ff             	movzbl %bh,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100695:	be d4 03 00 00       	mov    $0x3d4,%esi
8010069a:	b8 0e 00 00 00       	mov    $0xe,%eax
8010069f:	89 f2                	mov    %esi,%edx
801006a1:	ee                   	out    %al,(%dx)
801006a2:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801006a7:	89 f8                	mov    %edi,%eax
801006a9:	89 ca                	mov    %ecx,%edx
801006ab:	ee                   	out    %al,(%dx)
801006ac:	b8 0f 00 00 00       	mov    $0xf,%eax
801006b1:	89 f2                	mov    %esi,%edx
801006b3:	ee                   	out    %al,(%dx)
801006b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801006b8:	89 ca                	mov    %ecx,%edx
801006ba:	ee                   	out    %al,(%dx)
  crt[pos+left_key_pressed_count] = ' ' | 0x0700;
801006bb:	b8 20 07 00 00       	mov    $0x720,%eax
801006c0:	03 1d b0 ff 10 80    	add    0x8010ffb0,%ebx
801006c6:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801006cd:	80 
}
801006ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006d1:	5b                   	pop    %ebx
801006d2:	5e                   	pop    %esi
801006d3:	5f                   	pop    %edi
801006d4:	5d                   	pop    %ebp
801006d5:	c3                   	ret    
801006d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006dd:	8d 76 00             	lea    0x0(%esi),%esi
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
801006e0:	8b 0d b0 ff 10 80    	mov    0x8010ffb0,%ecx
    int deleted_pos = pos - 1;
801006e6:	8d 5e ff             	lea    -0x1(%esi),%ebx
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
801006e9:	8d 84 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%eax
    int deleted_pos = pos - 1;
801006f0:	89 da                	mov    %ebx,%edx
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
801006f2:	85 c9                	test   %ecx,%ecx
801006f4:	78 23                	js     80100719 <cgaputc+0x179>
801006f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006fd:	8d 76 00             	lea    0x0(%esi),%esi
      crt[i] = crt[i + 1];
80100700:	0f b7 08             	movzwl (%eax),%ecx
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
80100703:	83 c2 01             	add    $0x1,%edx
80100706:	83 c0 02             	add    $0x2,%eax
      crt[i] = crt[i + 1];
80100709:	66 89 48 fc          	mov    %cx,-0x4(%eax)
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
8010070d:	8b 0d b0 ff 10 80    	mov    0x8010ffb0,%ecx
80100713:	01 f1                	add    %esi,%ecx
80100715:	39 d1                	cmp    %edx,%ecx
80100717:	7f e7                	jg     80100700 <cgaputc+0x160>
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100719:	8b 0d 20 94 10 80    	mov    0x80109420,%ecx
8010071f:	31 c0                	xor    %eax,%eax
80100721:	85 c9                	test   %ecx,%ecx
80100723:	7e 1f                	jle    80100744 <cgaputc+0x1a4>
80100725:	8d 76 00             	lea    0x0(%esi),%esi
        if (cga_pos_sequence.pos_data[i] > deleted_pos) {
80100728:	8b 14 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%edx
8010072f:	39 da                	cmp    %ebx,%edx
80100731:	7e 0a                	jle    8010073d <cgaputc+0x19d>
            cga_pos_sequence.pos_data[i]--;
80100733:	83 ea 01             	sub    $0x1,%edx
80100736:	89 14 85 20 92 10 80 	mov    %edx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010073d:	83 c0 01             	add    $0x1,%eax
80100740:	39 c8                	cmp    %ecx,%eax
80100742:	75 e4                	jne    80100728 <cgaputc+0x188>
    delete_from_cga_pos_sequence(deleted_pos);
80100744:	83 ec 0c             	sub    $0xc,%esp
80100747:	53                   	push   %ebx
80100748:	e8 d3 fd ff ff       	call   80100520 <delete_from_cga_pos_sequence>
    if(pos > 0) --pos;
8010074d:	83 c4 10             	add    $0x10,%esp
80100750:	85 f6                	test   %esi,%esi
80100752:	0f 85 1f ff ff ff    	jne    80100677 <cgaputc+0xd7>
80100758:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
8010075c:	31 db                	xor    %ebx,%ebx
8010075e:	31 ff                	xor    %edi,%edi
80100760:	e9 30 ff ff ff       	jmp    80100695 <cgaputc+0xf5>
80100765:	8d 76 00             	lea    0x0(%esi),%esi
    pos += 80 - pos%80;
80100768:	89 f0                	mov    %esi,%eax
8010076a:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    cga_pos_sequence.size = 0;
8010076f:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
80100776:	00 00 00 
    pos += 80 - pos%80;
80100779:	f7 e2                	mul    %edx
8010077b:	c1 ea 06             	shr    $0x6,%edx
8010077e:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100781:	c1 e0 04             	shl    $0x4,%eax
80100784:	8d 58 50             	lea    0x50(%eax),%ebx
}
80100787:	e9 eb fe ff ff       	jmp    80100677 <cgaputc+0xd7>
8010078c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100790:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100793:	83 eb 50             	sub    $0x50,%ebx
  outb(CRTPORT+1, pos);
80100796:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010079b:	68 60 0e 00 00       	push   $0xe60
801007a0:	68 a0 80 0b 80       	push   $0x800b80a0
801007a5:	68 00 80 0b 80       	push   $0x800b8000
801007aa:	e8 51 52 00 00       	call   80105a00 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801007af:	b8 80 07 00 00       	mov    $0x780,%eax
801007b4:	83 c4 0c             	add    $0xc,%esp
801007b7:	29 d8                	sub    %ebx,%eax
801007b9:	01 c0                	add    %eax,%eax
801007bb:	50                   	push   %eax
801007bc:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
801007c3:	6a 00                	push   $0x0
801007c5:	50                   	push   %eax
801007c6:	e8 95 51 00 00       	call   80105960 <memset>
  outb(CRTPORT+1, pos);
801007cb:	88 5d e7             	mov    %bl,-0x19(%ebp)
801007ce:	83 c4 10             	add    $0x10,%esp
801007d1:	e9 bf fe ff ff       	jmp    80100695 <cgaputc+0xf5>
801007d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007dd:	8d 76 00             	lea    0x0(%esi),%esi
    return cga_pos_sequence.pos_data[cga_pos_sequence.size - 1];
801007e0:	83 eb 01             	sub    $0x1,%ebx
801007e3:	e9 30 fe ff ff       	jmp    80100618 <cgaputc+0x78>
801007e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007ef:	90                   	nop
    if (cga_pos_sequence.size == 0) return -1;
801007f0:	85 db                	test   %ebx,%ebx
801007f2:	0f 84 d6 fe ff ff    	je     801006ce <cgaputc+0x12e>
    return cga_pos_sequence.pos_data[cga_pos_sequence.size - 1];
801007f8:	8d 43 ff             	lea    -0x1(%ebx),%eax
801007fb:	8b 0c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ecx
    if (undo_pos == -1) return;
80100802:	83 f9 ff             	cmp    $0xffffffff,%ecx
80100805:	0f 84 c3 fe ff ff    	je     801006ce <cgaputc+0x12e>
    if (cga_pos_sequence.size > 0) {
8010080b:	85 db                	test   %ebx,%ebx
8010080d:	0f 8e 8d 00 00 00    	jle    801008a0 <cgaputc+0x300>
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
80100813:	8b 15 b0 ff 10 80    	mov    0x8010ffb0,%edx
        cga_pos_sequence.size--;
80100819:	a3 20 94 10 80       	mov    %eax,0x80109420
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
8010081e:	8d 04 32             	lea    (%edx,%esi,1),%eax
80100821:	39 c1                	cmp    %eax,%ecx
80100823:	7d 25                	jge    8010084a <cgaputc+0x2aa>
80100825:	8d 84 09 02 80 0b 80 	lea    -0x7ff47ffe(%ecx,%ecx,1),%eax
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010082c:	89 cb                	mov    %ecx,%ebx
8010082e:	66 90                	xchg   %ax,%ax
        crt[i] = crt[i + 1];
80100830:	0f b7 10             	movzwl (%eax),%edx
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
80100833:	83 c3 01             	add    $0x1,%ebx
80100836:	83 c0 02             	add    $0x2,%eax
        crt[i] = crt[i + 1];
80100839:	66 89 50 fc          	mov    %dx,-0x4(%eax)
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
8010083d:	8b 15 b0 ff 10 80    	mov    0x8010ffb0,%edx
80100843:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80100846:	39 df                	cmp    %ebx,%edi
80100848:	7f e6                	jg     80100830 <cgaputc+0x290>
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010084a:	8b 3d 20 94 10 80    	mov    0x80109420,%edi
80100850:	31 c0                	xor    %eax,%eax
80100852:	85 ff                	test   %edi,%edi
80100854:	7e 26                	jle    8010087c <cgaputc+0x2dc>
80100856:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010085d:	8d 76 00             	lea    0x0(%esi),%esi
        if (cga_pos_sequence.pos_data[i] > undo_pos) {
80100860:	8b 1c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ebx
80100867:	39 cb                	cmp    %ecx,%ebx
80100869:	7e 0a                	jle    80100875 <cgaputc+0x2d5>
            cga_pos_sequence.pos_data[i]--;
8010086b:	83 eb 01             	sub    $0x1,%ebx
8010086e:	89 1c 85 20 92 10 80 	mov    %ebx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100875:	83 c0 01             	add    $0x1,%eax
80100878:	39 f8                	cmp    %edi,%eax
8010087a:	75 e4                	jne    80100860 <cgaputc+0x2c0>
    if(pos > pos + left_key_pressed_count-1) --pos;
8010087c:	8d 5e ff             	lea    -0x1(%esi),%ebx
8010087f:	85 d2                	test   %edx,%edx
80100881:	0f 8e f0 fd ff ff    	jle    80100677 <cgaputc+0xd7>
      left_key_pressed_count--;
80100887:	83 ea 01             	sub    $0x1,%edx
  pos |= inb(CRTPORT+1);
8010088a:	89 f3                	mov    %esi,%ebx
      left_key_pressed_count--;
8010088c:	89 15 b0 ff 10 80    	mov    %edx,0x8010ffb0
80100892:	e9 e0 fd ff ff       	jmp    80100677 <cgaputc+0xd7>
80100897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010089e:	66 90                	xchg   %ax,%ax
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
801008a0:	8b 15 b0 ff 10 80    	mov    0x8010ffb0,%edx
801008a6:	8d 04 32             	lea    (%edx,%esi,1),%eax
801008a9:	39 c1                	cmp    %eax,%ecx
801008ab:	0f 8c 74 ff ff ff    	jl     80100825 <cgaputc+0x285>
801008b1:	eb c9                	jmp    8010087c <cgaputc+0x2dc>
    panic("pos under/overflow");
801008b3:	83 ec 0c             	sub    $0xc,%esp
801008b6:	68 cd 84 10 80       	push   $0x801084cd
801008bb:	e8 20 04 00 00       	call   80100ce0 <panic>

801008c0 <consputc>:
  if(panicked){
801008c0:	8b 15 f8 ff 10 80    	mov    0x8010fff8,%edx
801008c6:	85 d2                	test   %edx,%edx
801008c8:	74 06                	je     801008d0 <consputc+0x10>
}

static inline void
cli(void)
{
  asm volatile("cli");
801008ca:	fa                   	cli    
    for(;;)
801008cb:	eb fe                	jmp    801008cb <consputc+0xb>
801008cd:	8d 76 00             	lea    0x0(%esi),%esi
{
801008d0:	55                   	push   %ebp
801008d1:	89 e5                	mov    %esp,%ebp
801008d3:	53                   	push   %ebx
801008d4:	89 c3                	mov    %eax,%ebx
  if(c == BACKSPACE || c==UNDO_BS){
801008d6:	8d 80 00 ff ff ff    	lea    -0x100(%eax),%eax
{
801008dc:	83 ec 04             	sub    $0x4,%esp
  if(c == BACKSPACE || c==UNDO_BS){
801008df:	83 f8 01             	cmp    $0x1,%eax
801008e2:	76 17                	jbe    801008fb <consputc+0x3b>
    uartputc(c);
801008e4:	83 ec 0c             	sub    $0xc,%esp
801008e7:	53                   	push   %ebx
801008e8:	e8 c3 66 00 00       	call   80106fb0 <uartputc>
801008ed:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801008f0:	89 d8                	mov    %ebx,%eax
}
801008f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801008f5:	c9                   	leave  
  cgaputc(c);
801008f6:	e9 a5 fc ff ff       	jmp    801005a0 <cgaputc>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801008fb:	83 ec 0c             	sub    $0xc,%esp
801008fe:	6a 08                	push   $0x8
80100900:	e8 ab 66 00 00       	call   80106fb0 <uartputc>
80100905:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010090c:	e8 9f 66 00 00       	call   80106fb0 <uartputc>
80100911:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100918:	e8 93 66 00 00       	call   80106fb0 <uartputc>
8010091d:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
80100920:	89 d8                	mov    %ebx,%eax
}
80100922:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100925:	c9                   	leave  
  cgaputc(c);
80100926:	e9 75 fc ff ff       	jmp    801005a0 <cgaputc>
8010092b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010092f:	90                   	nop

80100930 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100930:	55                   	push   %ebp
80100931:	89 e5                	mov    %esp,%ebp
80100933:	57                   	push   %edi
80100934:	56                   	push   %esi
80100935:	53                   	push   %ebx
80100936:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100939:	ff 75 08             	push   0x8(%ebp)
{
8010093c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010093f:	e8 1c 22 00 00       	call   80102b60 <iunlock>
  acquire(&cons.lock);
80100944:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
8010094b:	e8 50 4f 00 00       	call   801058a0 <acquire>
  for(i = 0; i < n; i++)
80100950:	83 c4 10             	add    $0x10,%esp
80100953:	85 f6                	test   %esi,%esi
80100955:	7e 37                	jle    8010098e <consolewrite+0x5e>
80100957:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010095a:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
8010095d:	8b 15 f8 ff 10 80    	mov    0x8010fff8,%edx
    consputc(buf[i] & 0xff);
80100963:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
80100966:	85 d2                	test   %edx,%edx
80100968:	74 06                	je     80100970 <consolewrite+0x40>
8010096a:	fa                   	cli    
    for(;;)
8010096b:	eb fe                	jmp    8010096b <consolewrite+0x3b>
8010096d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100970:	83 ec 0c             	sub    $0xc,%esp
80100973:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < n; i++)
80100976:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100979:	50                   	push   %eax
8010097a:	e8 31 66 00 00       	call   80106fb0 <uartputc>
  cgaputc(c);
8010097f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100982:	e8 19 fc ff ff       	call   801005a0 <cgaputc>
  for(i = 0; i < n; i++)
80100987:	83 c4 10             	add    $0x10,%esp
8010098a:	39 df                	cmp    %ebx,%edi
8010098c:	75 cf                	jne    8010095d <consolewrite+0x2d>
  release(&cons.lock);
8010098e:	83 ec 0c             	sub    $0xc,%esp
80100991:	68 c0 ff 10 80       	push   $0x8010ffc0
80100996:	e8 a5 4e 00 00       	call   80105840 <release>
  ilock(ip);
8010099b:	58                   	pop    %eax
8010099c:	ff 75 08             	push   0x8(%ebp)
8010099f:	e8 dc 20 00 00       	call   80102a80 <ilock>

  return n;
}
801009a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009a7:	89 f0                	mov    %esi,%eax
801009a9:	5b                   	pop    %ebx
801009aa:	5e                   	pop    %esi
801009ab:	5f                   	pop    %edi
801009ac:	5d                   	pop    %ebp
801009ad:	c3                   	ret    
801009ae:	66 90                	xchg   %ax,%ax

801009b0 <printint>:
{
801009b0:	55                   	push   %ebp
801009b1:	89 e5                	mov    %esp,%ebp
801009b3:	57                   	push   %edi
801009b4:	56                   	push   %esi
801009b5:	53                   	push   %ebx
801009b6:	83 ec 2c             	sub    $0x2c,%esp
801009b9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801009bc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
801009bf:	85 c9                	test   %ecx,%ecx
801009c1:	74 04                	je     801009c7 <printint+0x17>
801009c3:	85 c0                	test   %eax,%eax
801009c5:	78 7e                	js     80100a45 <printint+0x95>
    x = xx;
801009c7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801009ce:	89 c1                	mov    %eax,%ecx
  i = 0;
801009d0:	31 db                	xor    %ebx,%ebx
801009d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
801009d8:	89 c8                	mov    %ecx,%eax
801009da:	31 d2                	xor    %edx,%edx
801009dc:	89 de                	mov    %ebx,%esi
801009de:	89 cf                	mov    %ecx,%edi
801009e0:	f7 75 d4             	divl   -0x2c(%ebp)
801009e3:	8d 5b 01             	lea    0x1(%ebx),%ebx
801009e6:	0f b6 92 ec 85 10 80 	movzbl -0x7fef7a14(%edx),%edx
  }while((x /= base) != 0);
801009ed:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
801009ef:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801009f3:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
801009f6:	73 e0                	jae    801009d8 <printint+0x28>
  if(sign)
801009f8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801009fb:	85 c9                	test   %ecx,%ecx
801009fd:	74 0c                	je     80100a0b <printint+0x5b>
    buf[i++] = '-';
801009ff:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100a04:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100a06:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
80100a0b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
  if(panicked){
80100a0f:	a1 f8 ff 10 80       	mov    0x8010fff8,%eax
80100a14:	85 c0                	test   %eax,%eax
80100a16:	74 08                	je     80100a20 <printint+0x70>
80100a18:	fa                   	cli    
    for(;;)
80100a19:	eb fe                	jmp    80100a19 <printint+0x69>
80100a1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a1f:	90                   	nop
    consputc(buf[i]);
80100a20:	0f be f2             	movsbl %dl,%esi
    uartputc(c);
80100a23:	83 ec 0c             	sub    $0xc,%esp
80100a26:	56                   	push   %esi
80100a27:	e8 84 65 00 00       	call   80106fb0 <uartputc>
  cgaputc(c);
80100a2c:	89 f0                	mov    %esi,%eax
80100a2e:	e8 6d fb ff ff       	call   801005a0 <cgaputc>
  while(--i >= 0)
80100a33:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100a36:	83 c4 10             	add    $0x10,%esp
80100a39:	39 d8                	cmp    %ebx,%eax
80100a3b:	74 0e                	je     80100a4b <printint+0x9b>
    consputc(buf[i]);
80100a3d:	0f b6 13             	movzbl (%ebx),%edx
80100a40:	83 eb 01             	sub    $0x1,%ebx
80100a43:	eb ca                	jmp    80100a0f <printint+0x5f>
    x = -xx;
80100a45:	f7 d8                	neg    %eax
80100a47:	89 c1                	mov    %eax,%ecx
80100a49:	eb 85                	jmp    801009d0 <printint+0x20>
}
80100a4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a4e:	5b                   	pop    %ebx
80100a4f:	5e                   	pop    %esi
80100a50:	5f                   	pop    %edi
80100a51:	5d                   	pop    %ebp
80100a52:	c3                   	ret    
80100a53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100a60 <cprintf>:
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	57                   	push   %edi
80100a64:	56                   	push   %esi
80100a65:	53                   	push   %ebx
80100a66:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100a69:	a1 f4 ff 10 80       	mov    0x8010fff4,%eax
80100a6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
80100a71:	85 c0                	test   %eax,%eax
80100a73:	0f 85 2f 01 00 00    	jne    80100ba8 <cprintf+0x148>
  if (fmt == 0)
80100a79:	8b 75 08             	mov    0x8(%ebp),%esi
80100a7c:	85 f6                	test   %esi,%esi
80100a7e:	0f 84 4c 02 00 00    	je     80100cd0 <cprintf+0x270>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100a84:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100a87:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100a8a:	31 db                	xor    %ebx,%ebx
80100a8c:	89 cf                	mov    %ecx,%edi
80100a8e:	85 c0                	test   %eax,%eax
80100a90:	74 56                	je     80100ae8 <cprintf+0x88>
    if(c != '%'){
80100a92:	83 f8 25             	cmp    $0x25,%eax
80100a95:	0f 85 d5 00 00 00    	jne    80100b70 <cprintf+0x110>
    c = fmt[++i] & 0xff;
80100a9b:	83 c3 01             	add    $0x1,%ebx
80100a9e:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100aa2:	85 d2                	test   %edx,%edx
80100aa4:	74 42                	je     80100ae8 <cprintf+0x88>
    switch(c){
80100aa6:	83 fa 70             	cmp    $0x70,%edx
80100aa9:	0f 84 96 00 00 00    	je     80100b45 <cprintf+0xe5>
80100aaf:	7f 4f                	jg     80100b00 <cprintf+0xa0>
80100ab1:	83 fa 25             	cmp    $0x25,%edx
80100ab4:	0f 84 de 00 00 00    	je     80100b98 <cprintf+0x138>
80100aba:	83 fa 64             	cmp    $0x64,%edx
80100abd:	0f 85 c6 00 00 00    	jne    80100b89 <cprintf+0x129>
      printint(*argp++, 10, 1);
80100ac3:	8d 47 04             	lea    0x4(%edi),%eax
80100ac6:	b9 01 00 00 00       	mov    $0x1,%ecx
80100acb:	ba 0a 00 00 00       	mov    $0xa,%edx
80100ad0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100ad3:	8b 07                	mov    (%edi),%eax
80100ad5:	e8 d6 fe ff ff       	call   801009b0 <printint>
80100ada:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100add:	83 c3 01             	add    $0x1,%ebx
80100ae0:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100ae4:	85 c0                	test   %eax,%eax
80100ae6:	75 aa                	jne    80100a92 <cprintf+0x32>
  if(locking)
80100ae8:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100aeb:	85 db                	test   %ebx,%ebx
80100aed:	0f 85 99 01 00 00    	jne    80100c8c <cprintf+0x22c>
}
80100af3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100af6:	5b                   	pop    %ebx
80100af7:	5e                   	pop    %esi
80100af8:	5f                   	pop    %edi
80100af9:	5d                   	pop    %ebp
80100afa:	c3                   	ret    
80100afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100aff:	90                   	nop
    switch(c){
80100b00:	83 fa 73             	cmp    $0x73,%edx
80100b03:	75 3b                	jne    80100b40 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
80100b05:	8d 47 04             	lea    0x4(%edi),%eax
80100b08:	8b 3f                	mov    (%edi),%edi
80100b0a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100b0d:	85 ff                	test   %edi,%edi
80100b0f:	0f 85 1b 01 00 00    	jne    80100c30 <cprintf+0x1d0>
        s = "(null)";
80100b15:	bf e0 84 10 80       	mov    $0x801084e0,%edi
      for(; *s; s++)
80100b1a:	b8 28 00 00 00       	mov    $0x28,%eax
80100b1f:	89 75 dc             	mov    %esi,-0x24(%ebp)
80100b22:	89 fe                	mov    %edi,%esi
80100b24:	89 df                	mov    %ebx,%edi
80100b26:	0f be d8             	movsbl %al,%ebx
  if(panicked){
80100b29:	8b 0d f8 ff 10 80    	mov    0x8010fff8,%ecx
80100b2f:	85 c9                	test   %ecx,%ecx
80100b31:	0f 84 1c 01 00 00    	je     80100c53 <cprintf+0x1f3>
80100b37:	fa                   	cli    
    for(;;)
80100b38:	eb fe                	jmp    80100b38 <cprintf+0xd8>
80100b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100b40:	83 fa 78             	cmp    $0x78,%edx
80100b43:	75 44                	jne    80100b89 <cprintf+0x129>
      printint(*argp++, 16, 0);
80100b45:	8d 47 04             	lea    0x4(%edi),%eax
80100b48:	31 c9                	xor    %ecx,%ecx
80100b4a:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100b4f:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
80100b52:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100b55:	8b 07                	mov    (%edi),%eax
80100b57:	e8 54 fe ff ff       	call   801009b0 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100b5c:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
80100b60:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100b63:	85 c0                	test   %eax,%eax
80100b65:	0f 85 27 ff ff ff    	jne    80100a92 <cprintf+0x32>
80100b6b:	e9 78 ff ff ff       	jmp    80100ae8 <cprintf+0x88>
      consputc(c);
80100b70:	e8 4b fd ff ff       	call   801008c0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100b75:	83 c3 01             	add    $0x1,%ebx
80100b78:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100b7c:	85 c0                	test   %eax,%eax
80100b7e:	0f 85 0e ff ff ff    	jne    80100a92 <cprintf+0x32>
80100b84:	e9 5f ff ff ff       	jmp    80100ae8 <cprintf+0x88>
  if(panicked){
80100b89:	a1 f8 ff 10 80       	mov    0x8010fff8,%eax
80100b8e:	85 c0                	test   %eax,%eax
80100b90:	74 5e                	je     80100bf0 <cprintf+0x190>
80100b92:	fa                   	cli    
    for(;;)
80100b93:	eb fe                	jmp    80100b93 <cprintf+0x133>
80100b95:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100b98:	8b 15 f8 ff 10 80    	mov    0x8010fff8,%edx
80100b9e:	85 d2                	test   %edx,%edx
80100ba0:	74 1b                	je     80100bbd <cprintf+0x15d>
80100ba2:	fa                   	cli    
    for(;;)
80100ba3:	eb fe                	jmp    80100ba3 <cprintf+0x143>
80100ba5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&cons.lock);
80100ba8:	83 ec 0c             	sub    $0xc,%esp
80100bab:	68 c0 ff 10 80       	push   $0x8010ffc0
80100bb0:	e8 eb 4c 00 00       	call   801058a0 <acquire>
80100bb5:	83 c4 10             	add    $0x10,%esp
80100bb8:	e9 bc fe ff ff       	jmp    80100a79 <cprintf+0x19>
    uartputc(c);
80100bbd:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100bc0:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100bc3:	6a 25                	push   $0x25
80100bc5:	e8 e6 63 00 00       	call   80106fb0 <uartputc>
  cgaputc(c);
80100bca:	b8 25 00 00 00       	mov    $0x25,%eax
80100bcf:	e8 cc f9 ff ff       	call   801005a0 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100bd4:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
}
80100bd8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100bdb:	85 c0                	test   %eax,%eax
80100bdd:	0f 85 af fe ff ff    	jne    80100a92 <cprintf+0x32>
80100be3:	e9 00 ff ff ff       	jmp    80100ae8 <cprintf+0x88>
80100be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100bef:	90                   	nop
    uartputc(c);
80100bf0:	83 ec 0c             	sub    $0xc,%esp
80100bf3:	89 55 e0             	mov    %edx,-0x20(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100bf6:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100bf9:	6a 25                	push   $0x25
80100bfb:	e8 b0 63 00 00       	call   80106fb0 <uartputc>
  cgaputc(c);
80100c00:	b8 25 00 00 00       	mov    $0x25,%eax
80100c05:	e8 96 f9 ff ff       	call   801005a0 <cgaputc>
      consputc(c);
80100c0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c0d:	e8 ae fc ff ff       	call   801008c0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100c12:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      break;
80100c16:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	0f 85 71 fe ff ff    	jne    80100a92 <cprintf+0x32>
80100c21:	e9 c2 fe ff ff       	jmp    80100ae8 <cprintf+0x88>
80100c26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c2d:	8d 76 00             	lea    0x0(%esi),%esi
      for(; *s; s++)
80100c30:	0f b6 07             	movzbl (%edi),%eax
80100c33:	84 c0                	test   %al,%al
80100c35:	0f 84 8d 00 00 00    	je     80100cc8 <cprintf+0x268>
  if(panicked){
80100c3b:	8b 0d f8 ff 10 80    	mov    0x8010fff8,%ecx
80100c41:	89 75 dc             	mov    %esi,-0x24(%ebp)
80100c44:	89 fe                	mov    %edi,%esi
80100c46:	89 df                	mov    %ebx,%edi
80100c48:	0f be d8             	movsbl %al,%ebx
80100c4b:	85 c9                	test   %ecx,%ecx
80100c4d:	0f 85 e4 fe ff ff    	jne    80100b37 <cprintf+0xd7>
  if(c == BACKSPACE || c==UNDO_BS){
80100c53:	8d 83 00 ff ff ff    	lea    -0x100(%ebx),%eax
80100c59:	83 f8 01             	cmp    $0x1,%eax
80100c5c:	76 43                	jbe    80100ca1 <cprintf+0x241>
    uartputc(c);
80100c5e:	83 ec 0c             	sub    $0xc,%esp
80100c61:	53                   	push   %ebx
80100c62:	e8 49 63 00 00       	call   80106fb0 <uartputc>
80100c67:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
80100c6a:	89 d8                	mov    %ebx,%eax
      for(; *s; s++)
80100c6c:	83 c6 01             	add    $0x1,%esi
  cgaputc(c);
80100c6f:	e8 2c f9 ff ff       	call   801005a0 <cgaputc>
      for(; *s; s++)
80100c74:	0f be 1e             	movsbl (%esi),%ebx
80100c77:	84 db                	test   %bl,%bl
80100c79:	0f 85 aa fe ff ff    	jne    80100b29 <cprintf+0xc9>
      if((s = (char*)*argp++) == 0)
80100c7f:	89 fb                	mov    %edi,%ebx
80100c81:	8b 75 dc             	mov    -0x24(%ebp),%esi
80100c84:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100c87:	e9 51 fe ff ff       	jmp    80100add <cprintf+0x7d>
    release(&cons.lock);
80100c8c:	83 ec 0c             	sub    $0xc,%esp
80100c8f:	68 c0 ff 10 80       	push   $0x8010ffc0
80100c94:	e8 a7 4b 00 00       	call   80105840 <release>
80100c99:	83 c4 10             	add    $0x10,%esp
}
80100c9c:	e9 52 fe ff ff       	jmp    80100af3 <cprintf+0x93>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100ca1:	83 ec 0c             	sub    $0xc,%esp
80100ca4:	6a 08                	push   $0x8
80100ca6:	e8 05 63 00 00       	call   80106fb0 <uartputc>
80100cab:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100cb2:	e8 f9 62 00 00       	call   80106fb0 <uartputc>
80100cb7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100cbe:	e8 ed 62 00 00       	call   80106fb0 <uartputc>
80100cc3:	83 c4 10             	add    $0x10,%esp
80100cc6:	eb a2                	jmp    80100c6a <cprintf+0x20a>
      if((s = (char*)*argp++) == 0)
80100cc8:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100ccb:	e9 0d fe ff ff       	jmp    80100add <cprintf+0x7d>
    panic("null fmt");
80100cd0:	83 ec 0c             	sub    $0xc,%esp
80100cd3:	68 e7 84 10 80       	push   $0x801084e7
80100cd8:	e8 03 00 00 00       	call   80100ce0 <panic>
80100cdd:	8d 76 00             	lea    0x0(%esi),%esi

80100ce0 <panic>:
{
80100ce0:	55                   	push   %ebp
80100ce1:	89 e5                	mov    %esp,%ebp
80100ce3:	56                   	push   %esi
80100ce4:	53                   	push   %ebx
80100ce5:	83 ec 30             	sub    $0x30,%esp
80100ce8:	fa                   	cli    
  cons.locking = 0;
80100ce9:	c7 05 f4 ff 10 80 00 	movl   $0x0,0x8010fff4
80100cf0:	00 00 00 
  getcallerpcs(&s, pcs);
80100cf3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100cf6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100cf9:	e8 f2 2e 00 00       	call   80103bf0 <lapicid>
80100cfe:	83 ec 08             	sub    $0x8,%esp
80100d01:	50                   	push   %eax
80100d02:	68 f0 84 10 80       	push   $0x801084f0
80100d07:	e8 54 fd ff ff       	call   80100a60 <cprintf>
  cprintf(s);
80100d0c:	58                   	pop    %eax
80100d0d:	ff 75 08             	push   0x8(%ebp)
80100d10:	e8 4b fd ff ff       	call   80100a60 <cprintf>
  cprintf("\n");
80100d15:	c7 04 24 d7 8e 10 80 	movl   $0x80108ed7,(%esp)
80100d1c:	e8 3f fd ff ff       	call   80100a60 <cprintf>
  getcallerpcs(&s, pcs);
80100d21:	8d 45 08             	lea    0x8(%ebp),%eax
80100d24:	5a                   	pop    %edx
80100d25:	59                   	pop    %ecx
80100d26:	53                   	push   %ebx
80100d27:	50                   	push   %eax
80100d28:	e8 c3 49 00 00       	call   801056f0 <getcallerpcs>
  for(i=0; i<10; i++)
80100d2d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100d30:	83 ec 08             	sub    $0x8,%esp
80100d33:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100d35:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100d38:	68 04 85 10 80       	push   $0x80108504
80100d3d:	e8 1e fd ff ff       	call   80100a60 <cprintf>
  for(i=0; i<10; i++)
80100d42:	83 c4 10             	add    $0x10,%esp
80100d45:	39 f3                	cmp    %esi,%ebx
80100d47:	75 e7                	jne    80100d30 <panic+0x50>
  panicked = 1; // freeze other CPU
80100d49:	c7 05 f8 ff 10 80 01 	movl   $0x1,0x8010fff8
80100d50:	00 00 00 
  for(;;)
80100d53:	eb fe                	jmp    80100d53 <panic+0x73>
80100d55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100d60 <append_sequence>:
    if (input_sequence.size >= input_sequence.cap) {
80100d60:	a1 00 92 10 80       	mov    0x80109200,%eax
80100d65:	3b 05 04 92 10 80    	cmp    0x80109204,%eax
80100d6b:	7d 1b                	jge    80100d88 <append_sequence+0x28>
void append_sequence(int value) {
80100d6d:	55                   	push   %ebp
    input_sequence.data[input_sequence.size++] = value;
80100d6e:	8d 50 01             	lea    0x1(%eax),%edx
80100d71:	89 15 00 92 10 80    	mov    %edx,0x80109200
void append_sequence(int value) {
80100d77:	89 e5                	mov    %esp,%ebp
    input_sequence.data[input_sequence.size++] = value;
80100d79:	8b 55 08             	mov    0x8(%ebp),%edx
}
80100d7c:	5d                   	pop    %ebp
    input_sequence.data[input_sequence.size++] = value;
80100d7d:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
}
80100d84:	c3                   	ret    
80100d85:	8d 76 00             	lea    0x0(%esi),%esi
80100d88:	c3                   	ret    
80100d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100d90 <delete_from_sequence>:
void delete_from_sequence(int value) {
80100d90:	55                   	push   %ebp
    for (int i = 0; i < input_sequence.size; i++) {
80100d91:	8b 15 00 92 10 80    	mov    0x80109200,%edx
void delete_from_sequence(int value) {
80100d97:	89 e5                	mov    %esp,%ebp
80100d99:	8b 4d 08             	mov    0x8(%ebp),%ecx
    for (int i = 0; i < input_sequence.size; i++) {
80100d9c:	85 d2                	test   %edx,%edx
80100d9e:	7e 3b                	jle    80100ddb <delete_from_sequence+0x4b>
80100da0:	31 c0                	xor    %eax,%eax
80100da2:	eb 0b                	jmp    80100daf <delete_from_sequence+0x1f>
80100da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100da8:	83 c0 01             	add    $0x1,%eax
80100dab:	39 d0                	cmp    %edx,%eax
80100dad:	74 2c                	je     80100ddb <delete_from_sequence+0x4b>
        if (input_sequence.data[i] == value) {
80100daf:	39 0c 85 00 90 10 80 	cmp    %ecx,-0x7fef7000(,%eax,4)
80100db6:	75 f0                	jne    80100da8 <delete_from_sequence+0x18>
    for (int i = idx; i < input_sequence.size - 1; i++)
80100db8:	83 ea 01             	sub    $0x1,%edx
80100dbb:	39 c2                	cmp    %eax,%edx
80100dbd:	7e 16                	jle    80100dd5 <delete_from_sequence+0x45>
80100dbf:	90                   	nop
        input_sequence.data[i] = input_sequence.data[i + 1];
80100dc0:	83 c0 01             	add    $0x1,%eax
80100dc3:	8b 0c 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%ecx
80100dca:	89 0c 85 fc 8f 10 80 	mov    %ecx,-0x7fef7004(,%eax,4)
    for (int i = idx; i < input_sequence.size - 1; i++)
80100dd1:	39 d0                	cmp    %edx,%eax
80100dd3:	75 eb                	jne    80100dc0 <delete_from_sequence+0x30>
    input_sequence.size--;
80100dd5:	89 15 00 92 10 80    	mov    %edx,0x80109200
}
80100ddb:	5d                   	pop    %ebp
80100ddc:	c3                   	ret    
80100ddd:	8d 76 00             	lea    0x0(%esi),%esi

80100de0 <last_sequence>:
    if (input_sequence.size == 0) return -1;
80100de0:	a1 00 92 10 80       	mov    0x80109200,%eax
80100de5:	85 c0                	test   %eax,%eax
80100de7:	74 0f                	je     80100df8 <last_sequence+0x18>
    return input_sequence.data[input_sequence.size - 1];
80100de9:	8b 04 85 fc 8f 10 80 	mov    -0x7fef7004(,%eax,4),%eax
80100df0:	c3                   	ret    
80100df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (input_sequence.size == 0) return -1;
80100df8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100dfd:	c3                   	ret    
80100dfe:	66 90                	xchg   %ax,%ax

80100e00 <clear_sequence>:
    input_sequence.size = 0;
80100e00:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80100e07:	00 00 00 
}
80100e0a:	c3                   	ret    
80100e0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e0f:	90                   	nop

80100e10 <print_array>:
void print_array(char *buffer){
80100e10:	55                   	push   %ebp
      for (int i = 0; i < input.e; i++)
80100e11:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
void print_array(char *buffer){
80100e16:	89 e5                	mov    %esp,%ebp
80100e18:	56                   	push   %esi
80100e19:	8b 75 08             	mov    0x8(%ebp),%esi
80100e1c:	53                   	push   %ebx
      for (int i = 0; i < input.e; i++)
80100e1d:	85 c0                	test   %eax,%eax
80100e1f:	74 1b                	je     80100e3c <print_array+0x2c>
80100e21:	31 db                	xor    %ebx,%ebx
80100e23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e27:	90                   	nop
      cgaputc(buffer[i]);
80100e28:	0f be 04 1e          	movsbl (%esi,%ebx,1),%eax
      for (int i = 0; i < input.e; i++)
80100e2c:	83 c3 01             	add    $0x1,%ebx
      cgaputc(buffer[i]);
80100e2f:	e8 6c f7 ff ff       	call   801005a0 <cgaputc>
      for (int i = 0; i < input.e; i++)
80100e34:	39 1d 08 ff 10 80    	cmp    %ebx,0x8010ff08
80100e3a:	77 ec                	ja     80100e28 <print_array+0x18>
}
80100e3c:	5b                   	pop    %ebx
80100e3d:	5e                   	pop    %esi
80100e3e:	5d                   	pop    %ebp
80100e3f:	c3                   	ret    

80100e40 <highlight_from_buffer_positions>:
  if (select_mode != 2) return;
80100e40:	83 3d a4 ff 10 80 02 	cmpl   $0x2,0x8010ffa4
80100e47:	75 07                	jne    80100e50 <highlight_from_buffer_positions+0x10>
80100e49:	e9 32 f5 ff ff       	jmp    80100380 <highlight_from_buffer_positions.part.0>
80100e4e:	66 90                	xchg   %ax,%ax
}
80100e50:	c3                   	ret    
80100e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e5f:	90                   	nop

80100e60 <clear_highlight_from_buffer>:
  if (select_mode != 2) return;
80100e60:	83 3d a4 ff 10 80 02 	cmpl   $0x2,0x8010ffa4
80100e67:	75 07                	jne    80100e70 <clear_highlight_from_buffer+0x10>
80100e69:	e9 a2 f5 ff ff       	jmp    80100410 <clear_highlight_from_buffer.part.0>
80100e6e:	66 90                	xchg   %ax,%ax
}
80100e70:	c3                   	ret    
80100e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e7f:	90                   	nop

80100e80 <copy_selected_text>:
void copy_selected_text(void) {
80100e80:	55                   	push   %ebp
  copied_length = 0;
80100e81:	c7 05 0c ff 10 80 00 	movl   $0x0,0x8010ff0c
80100e88:	00 00 00 
void copy_selected_text(void) {
80100e8b:	89 e5                	mov    %esp,%ebp
80100e8d:	56                   	push   %esi
  for (int i = select_start; i < select_end && copied_length < INPUT_BUF - 1; i++) {
80100e8e:	8b 35 ac ff 10 80    	mov    0x8010ffac,%esi
void copy_selected_text(void) {
80100e94:	53                   	push   %ebx
  for (int i = select_start; i < select_end && copied_length < INPUT_BUF - 1; i++) {
80100e95:	8b 1d a8 ff 10 80    	mov    0x8010ffa8,%ebx
80100e9b:	39 de                	cmp    %ebx,%esi
80100e9d:	7d 62                	jge    80100f01 <copy_selected_text+0x81>
80100e9f:	29 f3                	sub    %esi,%ebx
80100ea1:	31 d2                	xor    %edx,%edx
80100ea3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ea7:	90                   	nop
    copied_text[copied_length] = input.buf[i % INPUT_BUF];
80100ea8:	8d 04 32             	lea    (%edx,%esi,1),%eax
    copied_length++;
80100eab:	83 c2 01             	add    $0x1,%edx
    copied_text[copied_length] = input.buf[i % INPUT_BUF];
80100eae:	89 c1                	mov    %eax,%ecx
80100eb0:	c1 f9 1f             	sar    $0x1f,%ecx
80100eb3:	c1 e9 19             	shr    $0x19,%ecx
80100eb6:	01 c8                	add    %ecx,%eax
80100eb8:	83 e0 7f             	and    $0x7f,%eax
80100ebb:	29 c8                	sub    %ecx,%eax
80100ebd:	0f b6 80 80 fe 10 80 	movzbl -0x7fef0180(%eax),%eax
80100ec4:	88 82 1f ff 10 80    	mov    %al,-0x7fef00e1(%edx)
  for (int i = select_start; i < select_end && copied_length < INPUT_BUF - 1; i++) {
80100eca:	39 da                	cmp    %ebx,%edx
80100ecc:	74 22                	je     80100ef0 <copy_selected_text+0x70>
80100ece:	83 fa 7f             	cmp    $0x7f,%edx
80100ed1:	75 d5                	jne    80100ea8 <copy_selected_text+0x28>
80100ed3:	c7 05 0c ff 10 80 7f 	movl   $0x7f,0x8010ff0c
80100eda:	00 00 00 
}
80100edd:	5b                   	pop    %ebx
80100ede:	5e                   	pop    %esi
  copied_text[copied_length] = '\0';
80100edf:	c6 82 20 ff 10 80 00 	movb   $0x0,-0x7fef00e0(%edx)
}
80100ee6:	5d                   	pop    %ebp
80100ee7:	c3                   	ret    
80100ee8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100eef:	90                   	nop
80100ef0:	5b                   	pop    %ebx
80100ef1:	5e                   	pop    %esi
80100ef2:	89 15 0c ff 10 80    	mov    %edx,0x8010ff0c
  copied_text[copied_length] = '\0';
80100ef8:	c6 82 20 ff 10 80 00 	movb   $0x0,-0x7fef00e0(%edx)
}
80100eff:	5d                   	pop    %ebp
80100f00:	c3                   	ret    
  for (int i = select_start; i < select_end && copied_length < INPUT_BUF - 1; i++) {
80100f01:	31 d2                	xor    %edx,%edx
80100f03:	eb d8                	jmp    80100edd <copy_selected_text+0x5d>
80100f05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <consoleinit>:

void
consoleinit(void)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100f16:	68 08 85 10 80       	push   $0x80108508
80100f1b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100f20:	e8 ab 47 00 00       	call   801056d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100f25:	58                   	pop    %eax
80100f26:	5a                   	pop    %edx
80100f27:	6a 00                	push   $0x0
80100f29:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100f2b:	c7 05 ac 09 11 80 30 	movl   $0x80100930,0x801109ac
80100f32:	09 10 80 
  devsw[CONSOLE].read = consoleread;
80100f35:	c7 05 a8 09 11 80 80 	movl   $0x80100280,0x801109a8
80100f3c:	02 10 80 
  cons.locking = 1;
80100f3f:	c7 05 f4 ff 10 80 01 	movl   $0x1,0x8010fff4
80100f46:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100f49:	e8 32 28 00 00       	call   80103780 <ioapicenable>
}
80100f4e:	83 c4 10             	add    $0x10,%esp
80100f51:	c9                   	leave  
80100f52:	c3                   	ret    
80100f53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f60 <move_cursor_left>:





void move_cursor_left(void){
80100f60:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100f61:	b8 0e 00 00 00       	mov    $0xe,%eax
80100f66:	89 e5                	mov    %esp,%ebp
80100f68:	56                   	push   %esi
80100f69:	be d4 03 00 00       	mov    $0x3d4,%esi
80100f6e:	53                   	push   %ebx
80100f6f:	89 f2                	mov    %esi,%edx
80100f71:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100f72:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100f77:	89 ca                	mov    %ecx,%edx
80100f79:	ec                   	in     (%dx),%al
  int pos;

  // get cursor position
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100f7a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100f7d:	89 f2                	mov    %esi,%edx
80100f7f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100f84:	c1 e3 08             	shl    $0x8,%ebx
80100f87:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100f88:	89 ca                	mov    %ecx,%edx
80100f8a:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100f8b:	0f b6 c8             	movzbl %al,%ecx
80100f8e:	09 d9                	or     %ebx,%ecx




  if(crt[pos - 2] != ('$' | 0x0700))
80100f90:	66 81 bc 09 fc 7f 0b 	cmpw   $0x724,-0x7ff48004(%ecx,%ecx,1)
80100f97:	80 24 07 
80100f9a:	74 03                	je     80100f9f <move_cursor_left+0x3f>
    pos--;
80100f9c:	83 e9 01             	sub    $0x1,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100f9f:	be d4 03 00 00       	mov    $0x3d4,%esi
80100fa4:	b8 0e 00 00 00       	mov    $0xe,%eax
80100fa9:	89 f2                	mov    %esi,%edx
80100fab:	ee                   	out    %al,(%dx)
80100fac:	bb d5 03 00 00       	mov    $0x3d5,%ebx

  // reset cursor
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
80100fb1:	89 c8                	mov    %ecx,%eax
80100fb3:	c1 f8 08             	sar    $0x8,%eax
80100fb6:	89 da                	mov    %ebx,%edx
80100fb8:	ee                   	out    %al,(%dx)
80100fb9:	b8 0f 00 00 00       	mov    $0xf,%eax
80100fbe:	89 f2                	mov    %esi,%edx
80100fc0:	ee                   	out    %al,(%dx)
80100fc1:	89 c8                	mov    %ecx,%eax
80100fc3:	89 da                	mov    %ebx,%edx
80100fc5:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
}
80100fc6:	5b                   	pop    %ebx
80100fc7:	5e                   	pop    %esi
80100fc8:	5d                   	pop    %ebp
80100fc9:	c3                   	ret    
80100fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100fd0 <delete_selected_area>:
  if (select_start == select_end) return;
80100fd0:	8b 15 ac ff 10 80    	mov    0x8010ffac,%edx
80100fd6:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100fdb:	39 c2                	cmp    %eax,%edx
80100fdd:	0f 84 50 02 00 00    	je     80101233 <delete_selected_area+0x263>
void delete_selected_area(void) {
80100fe3:	55                   	push   %ebp
80100fe4:	89 e5                	mov    %esp,%ebp
80100fe6:	57                   	push   %edi
  int select_length = select_end - select_start;
80100fe7:	89 c7                	mov    %eax,%edi
void delete_selected_area(void) {
80100fe9:	56                   	push   %esi
  int select_length = select_end - select_start;
80100fea:	29 d7                	sub    %edx,%edi
void delete_selected_area(void) {
80100fec:	53                   	push   %ebx
  int move_distance = select_end - current_pos;
80100fed:	89 c3                	mov    %eax,%ebx
void delete_selected_area(void) {
80100fef:	83 ec 1c             	sub    $0x1c,%esp
  int select_length = select_end - select_start;
80100ff2:	89 7d dc             	mov    %edi,-0x24(%ebp)
  int current_pos = input.e - left_key_pressed_count;
80100ff5:	8b 3d 08 ff 10 80    	mov    0x8010ff08,%edi
80100ffb:	8b 35 b0 ff 10 80    	mov    0x8010ffb0,%esi
80101001:	89 fa                	mov    %edi,%edx
80101003:	29 f2                	sub    %esi,%edx
80101005:	89 75 d8             	mov    %esi,-0x28(%ebp)
  int move_distance = select_end - current_pos;
80101008:	29 d3                	sub    %edx,%ebx
  int current_pos = input.e - left_key_pressed_count;
8010100a:	89 d6                	mov    %edx,%esi
  int move_distance = select_end - current_pos;
8010100c:	89 5d e0             	mov    %ebx,-0x20(%ebp)
  if (move_distance > 0) {
8010100f:	85 db                	test   %ebx,%ebx
80101011:	0f 8e 89 01 00 00    	jle    801011a0 <delete_selected_area+0x1d0>
80101017:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010101a:	31 c0                	xor    %eax,%eax
      for (int i = 0; i < move_distance; i++) {
8010101c:	31 db                	xor    %ebx,%ebx
8010101e:	89 d7                	mov    %edx,%edi
80101020:	eb 0e                	jmp    80101030 <delete_selected_area+0x60>
80101022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101028:	83 c3 01             	add    $0x1,%ebx
8010102b:	39 5d e0             	cmp    %ebx,-0x20(%ebp)
8010102e:	74 6d                	je     8010109d <delete_selected_area+0xcd>
          if(input.e > current_pos) {
80101030:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101033:	76 f3                	jbe    80101028 <delete_selected_area+0x58>
              left_key_pressed_count--;
80101035:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
80101039:	b8 0e 00 00 00       	mov    $0xe,%eax
8010103e:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101043:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101044:	be d5 03 00 00       	mov    $0x3d5,%esi
80101049:	89 f2                	mov    %esi,%edx
8010104b:	ec                   	in     (%dx),%al

void move_cursor_right(void) {
    int pos;

    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
8010104c:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010104f:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101054:	b8 0f 00 00 00       	mov    $0xf,%eax
80101059:	c1 e1 08             	shl    $0x8,%ecx
8010105c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010105d:	89 f2                	mov    %esi,%edx
8010105f:	ec                   	in     (%dx),%al
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80101060:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101063:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101068:	09 c1                	or     %eax,%ecx
8010106a:	b8 0e 00 00 00       	mov    $0xe,%eax

    pos++;
8010106f:	83 c1 01             	add    $0x1,%ecx
80101072:	ee                   	out    %al,(%dx)

    outb(CRTPORT, 14);
    outb(CRTPORT+1, pos >> 8);
80101073:	89 ca                	mov    %ecx,%edx
80101075:	c1 fa 08             	sar    $0x8,%edx
80101078:	89 d0                	mov    %edx,%eax
8010107a:	89 f2                	mov    %esi,%edx
8010107c:	ee                   	out    %al,(%dx)
8010107d:	b8 0f 00 00 00       	mov    $0xf,%eax
80101082:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101087:	ee                   	out    %al,(%dx)
80101088:	89 c8                	mov    %ecx,%eax
8010108a:	89 f2                	mov    %esi,%edx
8010108c:	ee                   	out    %al,(%dx)
              current_pos++;
8010108d:	b8 01 00 00 00       	mov    $0x1,%eax
80101092:	83 c7 01             	add    $0x1,%edi
      for (int i = 0; i < move_distance; i++) {
80101095:	83 c3 01             	add    $0x1,%ebx
80101098:	39 5d e0             	cmp    %ebx,-0x20(%ebp)
8010109b:	75 93                	jne    80101030 <delete_selected_area+0x60>
8010109d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801010a0:	84 c0                	test   %al,%al
801010a2:	74 08                	je     801010ac <delete_selected_area+0xdc>
801010a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
801010a7:	a3 b0 ff 10 80       	mov    %eax,0x8010ffb0
  for (int i = 0; i < select_length; i++) {
801010ac:	8b 55 dc             	mov    -0x24(%ebp),%edx
801010af:	31 f6                	xor    %esi,%esi
801010b1:	85 d2                	test   %edx,%edx
801010b3:	0f 8e 3e 01 00 00    	jle    801011f7 <delete_selected_area+0x227>
      if(input.e != input.w){
801010b9:	39 3d 04 ff 10 80    	cmp    %edi,0x8010ff04
801010bf:	75 21                	jne    801010e2 <delete_selected_area+0x112>
801010c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for (int i = 0; i < select_length; i++) {
801010c8:	83 c6 01             	add    $0x1,%esi
801010cb:	39 75 dc             	cmp    %esi,-0x24(%ebp)
801010ce:	0f 84 23 01 00 00    	je     801011f7 <delete_selected_area+0x227>
      if(input.e != input.w){
801010d4:	8b 3d 08 ff 10 80    	mov    0x8010ff08,%edi
801010da:	39 3d 04 ff 10 80    	cmp    %edi,0x8010ff04
801010e0:	74 e6                	je     801010c8 <delete_selected_area+0xf8>
  int shift_idx= shift_from_seq ? last_sequence(): input.e-left_key_pressed_count;
801010e2:	89 f8                	mov    %edi,%eax
801010e4:	2b 05 b0 ff 10 80    	sub    0x8010ffb0,%eax
  for (int i = shift_idx - 1; i < input.e; i++)
801010ea:	8d 50 ff             	lea    -0x1(%eax),%edx
  int shift_idx= shift_from_seq ? last_sequence(): input.e-left_key_pressed_count;
801010ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for (int i = shift_idx - 1; i < input.e; i++)
801010f0:	39 fa                	cmp    %edi,%edx
801010f2:	73 39                	jae    8010112d <delete_selected_area+0x15d>
801010f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
801010f8:	89 d0                	mov    %edx,%eax
801010fa:	83 c2 01             	add    $0x1,%edx
801010fd:	89 d3                	mov    %edx,%ebx
801010ff:	c1 fb 1f             	sar    $0x1f,%ebx
80101102:	c1 eb 19             	shr    $0x19,%ebx
80101105:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80101108:	83 e1 7f             	and    $0x7f,%ecx
8010110b:	29 d9                	sub    %ebx,%ecx
8010110d:	0f b6 99 80 fe 10 80 	movzbl -0x7fef0180(%ecx),%ebx
80101114:	89 c1                	mov    %eax,%ecx
80101116:	c1 f9 1f             	sar    $0x1f,%ecx
80101119:	c1 e9 19             	shr    $0x19,%ecx
8010111c:	01 c8                	add    %ecx,%eax
8010111e:	83 e0 7f             	and    $0x7f,%eax
80101121:	29 c8                	sub    %ecx,%eax
80101123:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  for (int i = shift_idx - 1; i < input.e; i++)
80101129:	39 d7                	cmp    %edx,%edi
8010112b:	77 cb                	ja     801010f8 <delete_selected_area+0x128>
          delete_from_sequence(input.e - left_key_pressed_count);
8010112d:	83 ec 0c             	sub    $0xc,%esp
80101130:	ff 75 e4             	push   -0x1c(%ebp)
  input.buf[input.e] = ' ';
80101133:	c6 87 80 fe 10 80 20 	movb   $0x20,-0x7fef0180(%edi)
          delete_from_sequence(input.e - left_key_pressed_count);
8010113a:	e8 51 fc ff ff       	call   80100d90 <delete_from_sequence>
          for(int j = 0; j < input_sequence.size; j++) {
8010113f:	8b 1d 00 92 10 80    	mov    0x80109200,%ebx
80101145:	83 c4 10             	add    $0x10,%esp
80101148:	85 db                	test   %ebx,%ebx
8010114a:	0f 8e e4 00 00 00    	jle    80101234 <delete_selected_area+0x264>
              if(input_sequence.data[j] > (input.e - left_key_pressed_count) % INPUT_BUF)
80101150:	8b 3d 08 ff 10 80    	mov    0x8010ff08,%edi
          for(int j = 0; j < input_sequence.size; j++) {
80101156:	31 c0                	xor    %eax,%eax
              if(input_sequence.data[j] > (input.e - left_key_pressed_count) % INPUT_BUF)
80101158:	89 f9                	mov    %edi,%ecx
8010115a:	2b 0d b0 ff 10 80    	sub    0x8010ffb0,%ecx
80101160:	83 e1 7f             	and    $0x7f,%ecx
80101163:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101167:	90                   	nop
80101168:	8b 14 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%edx
8010116f:	39 ca                	cmp    %ecx,%edx
80101171:	76 0a                	jbe    8010117d <delete_selected_area+0x1ad>
                  input_sequence.data[j]--;
80101173:	83 ea 01             	sub    $0x1,%edx
80101176:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
          for(int j = 0; j < input_sequence.size; j++) {
8010117d:	83 c0 01             	add    $0x1,%eax
80101180:	39 c3                	cmp    %eax,%ebx
80101182:	75 e4                	jne    80101168 <delete_selected_area+0x198>
  if(panicked){
80101184:	a1 f8 ff 10 80       	mov    0x8010fff8,%eax
          input.e--;
80101189:	83 ef 01             	sub    $0x1,%edi
8010118c:	89 3d 08 ff 10 80    	mov    %edi,0x8010ff08
  if(panicked){
80101192:	85 c0                	test   %eax,%eax
80101194:	74 69                	je     801011ff <delete_selected_area+0x22f>
  asm volatile("cli");
80101196:	fa                   	cli    
    for(;;)
80101197:	eb fe                	jmp    80101197 <delete_selected_area+0x1c7>
80101199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  } else if (move_distance < 0) {
801011a0:	0f 84 06 ff ff ff    	je     801010ac <delete_selected_area+0xdc>
      for (int i = 0; i < -move_distance; i++) {
801011a6:	89 d1                	mov    %edx,%ecx
801011a8:	29 c1                	sub    %eax,%ecx
801011aa:	85 c9                	test   %ecx,%ecx
801011ac:	0f 8e fa fe ff ff    	jle    801010ac <delete_selected_area+0xdc>
801011b2:	89 7d e0             	mov    %edi,-0x20(%ebp)
          if(input.w < current_pos) {
801011b5:	8b 15 04 ff 10 80    	mov    0x8010ff04,%edx
      for (int i = 0; i < -move_distance; i++) {
801011bb:	31 db                	xor    %ebx,%ebx
801011bd:	89 cf                	mov    %ecx,%edi
801011bf:	eb 0e                	jmp    801011cf <delete_selected_area+0x1ff>
801011c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801011c8:	83 c3 01             	add    $0x1,%ebx
801011cb:	39 df                	cmp    %ebx,%edi
801011cd:	74 20                	je     801011ef <delete_selected_area+0x21f>
          if(input.w < current_pos) {
801011cf:	39 d6                	cmp    %edx,%esi
801011d1:	76 f5                	jbe    801011c8 <delete_selected_area+0x1f8>
      for (int i = 0; i < -move_distance; i++) {
801011d3:	83 c3 01             	add    $0x1,%ebx
801011d6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
              current_pos--;
801011d9:	83 ee 01             	sub    $0x1,%esi
              left_key_pressed_count++;
801011dc:	83 05 b0 ff 10 80 01 	addl   $0x1,0x8010ffb0
              move_cursor_left();
801011e3:	e8 78 fd ff ff       	call   80100f60 <move_cursor_left>
              current_pos--;
801011e8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      for (int i = 0; i < -move_distance; i++) {
801011eb:	39 df                	cmp    %ebx,%edi
801011ed:	75 e0                	jne    801011cf <delete_selected_area+0x1ff>
801011ef:	8b 7d e0             	mov    -0x20(%ebp),%edi
801011f2:	e9 b5 fe ff ff       	jmp    801010ac <delete_selected_area+0xdc>
}
801011f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011fa:	5b                   	pop    %ebx
801011fb:	5e                   	pop    %esi
801011fc:	5f                   	pop    %edi
801011fd:	5d                   	pop    %ebp
801011fe:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801011ff:	83 ec 0c             	sub    $0xc,%esp
80101202:	6a 08                	push   $0x8
80101204:	e8 a7 5d 00 00       	call   80106fb0 <uartputc>
80101209:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101210:	e8 9b 5d 00 00       	call   80106fb0 <uartputc>
80101215:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010121c:	e8 8f 5d 00 00       	call   80106fb0 <uartputc>
  cgaputc(c);
80101221:	b8 00 01 00 00       	mov    $0x100,%eax
80101226:	e8 75 f3 ff ff       	call   801005a0 <cgaputc>
}
8010122b:	83 c4 10             	add    $0x10,%esp
8010122e:	e9 95 fe ff ff       	jmp    801010c8 <delete_selected_area+0xf8>
80101233:	c3                   	ret    
          input.e--;
80101234:	8b 3d 08 ff 10 80    	mov    0x8010ff08,%edi
8010123a:	e9 45 ff ff ff       	jmp    80101184 <delete_selected_area+0x1b4>
8010123f:	90                   	nop

80101240 <paste_text>:
  if (copied_length == 0) return;
80101240:	a1 0c ff 10 80       	mov    0x8010ff0c,%eax
80101245:	85 c0                	test   %eax,%eax
80101247:	0f 84 ec 00 00 00    	je     80101339 <paste_text+0xf9>
void paste_text(void) {
8010124d:	55                   	push   %ebp
8010124e:	89 e5                	mov    %esp,%ebp
80101250:	57                   	push   %edi
80101251:	56                   	push   %esi
80101252:	53                   	push   %ebx
80101253:	83 ec 1c             	sub    $0x1c,%esp
  if (select_mode == 2) {
80101256:	83 3d a4 ff 10 80 02 	cmpl   $0x2,0x8010ffa4
8010125d:	0f 84 d7 00 00 00    	je     8010133a <paste_text+0xfa>
  if (input.e + copied_length >= INPUT_BUF) {
80101263:	8b 3d 08 ff 10 80    	mov    0x8010ff08,%edi
80101269:	8d 14 38             	lea    (%eax,%edi,1),%edx
8010126c:	83 fa 7f             	cmp    $0x7f,%edx
8010126f:	0f 87 8b 00 00 00    	ja     80101300 <paste_text+0xc0>
  for (int i = 0; i < copied_length; i++) {
80101275:	85 c0                	test   %eax,%eax
80101277:	0f 8e 83 00 00 00    	jle    80101300 <paste_text+0xc0>
8010127d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    char c = copied_text[i];
80101284:	8b 45 e4             	mov    -0x1c(%ebp),%eax
   int cursor= input.e-left_key_pressed_count;
80101287:	89 fe                	mov    %edi,%esi
80101289:	2b 35 b0 ff 10 80    	sub    0x8010ffb0,%esi
  for (int i = input.e; i > cursor; i--)
8010128f:	89 fa                	mov    %edi,%edx
    char c = copied_text[i];
80101291:	0f b6 80 20 ff 10 80 	movzbl -0x7fef00e0(%eax),%eax
80101298:	88 45 e3             	mov    %al,-0x1d(%ebp)
  for (int i = input.e; i > cursor; i--)
8010129b:	39 fe                	cmp    %edi,%esi
8010129d:	7d 36                	jge    801012d5 <paste_text+0x95>
8010129f:	90                   	nop
    input.buf[(i) % INPUT_BUF] = input.buf[(i-1) % INPUT_BUF]; // Shift elements to right
801012a0:	89 d0                	mov    %edx,%eax
801012a2:	83 ea 01             	sub    $0x1,%edx
801012a5:	89 d3                	mov    %edx,%ebx
801012a7:	c1 fb 1f             	sar    $0x1f,%ebx
801012aa:	c1 eb 19             	shr    $0x19,%ebx
801012ad:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
801012b0:	83 e1 7f             	and    $0x7f,%ecx
801012b3:	29 d9                	sub    %ebx,%ecx
801012b5:	0f b6 99 80 fe 10 80 	movzbl -0x7fef0180(%ecx),%ebx
801012bc:	89 c1                	mov    %eax,%ecx
801012be:	c1 f9 1f             	sar    $0x1f,%ecx
801012c1:	c1 e9 19             	shr    $0x19,%ecx
801012c4:	01 c8                	add    %ecx,%eax
801012c6:	83 e0 7f             	and    $0x7f,%eax
801012c9:	29 c8                	sub    %ecx,%eax
801012cb:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  for (int i = input.e; i > cursor; i--)
801012d1:	39 d6                	cmp    %edx,%esi
801012d3:	75 cb                	jne    801012a0 <paste_text+0x60>
    input.buf[(input.e - left_key_pressed_count) % INPUT_BUF] = c;
801012d5:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
801012d9:	83 e6 7f             	and    $0x7f,%esi
    input.e++;
801012dc:	83 c7 01             	add    $0x1,%edi
801012df:	89 3d 08 ff 10 80    	mov    %edi,0x8010ff08
    input.buf[(input.e - left_key_pressed_count) % INPUT_BUF] = c;
801012e5:	88 86 80 fe 10 80    	mov    %al,-0x7fef0180(%esi)
  if(panicked){
801012eb:	a1 f8 ff 10 80       	mov    0x8010fff8,%eax
801012f0:	85 c0                	test   %eax,%eax
801012f2:	74 14                	je     80101308 <paste_text+0xc8>
801012f4:	fa                   	cli    
    for(;;)
801012f5:	eb fe                	jmp    801012f5 <paste_text+0xb5>
801012f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012fe:	66 90                	xchg   %ax,%ax
}
80101300:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101303:	5b                   	pop    %ebx
80101304:	5e                   	pop    %esi
80101305:	5f                   	pop    %edi
80101306:	5d                   	pop    %ebp
80101307:	c3                   	ret    
    consputc(c);
80101308:	0f be 5d e3          	movsbl -0x1d(%ebp),%ebx
    uartputc(c);
8010130c:	83 ec 0c             	sub    $0xc,%esp
8010130f:	53                   	push   %ebx
80101310:	e8 9b 5c 00 00       	call   80106fb0 <uartputc>
  cgaputc(c);
80101315:	89 d8                	mov    %ebx,%eax
80101317:	e8 84 f2 ff ff       	call   801005a0 <cgaputc>
  for (int i = 0; i < copied_length; i++) {
8010131c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80101320:	83 c4 10             	add    $0x10,%esp
80101323:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101326:	3b 05 0c ff 10 80    	cmp    0x8010ff0c,%eax
8010132c:	7d d2                	jge    80101300 <paste_text+0xc0>
   int cursor= input.e-left_key_pressed_count;
8010132e:	8b 3d 08 ff 10 80    	mov    0x8010ff08,%edi
80101334:	e9 4b ff ff ff       	jmp    80101284 <paste_text+0x44>
80101339:	c3                   	ret    
      delete_selected_area();
8010133a:	e8 91 fc ff ff       	call   80100fd0 <delete_selected_area>
  if (input.e + copied_length >= INPUT_BUF) {
8010133f:	a1 0c ff 10 80       	mov    0x8010ff0c,%eax
80101344:	e9 1a ff ff ff       	jmp    80101263 <paste_text+0x23>
80101349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101350 <consoleintr>:
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	56                   	push   %esi
80101355:	53                   	push   %ebx
80101356:	83 ec 38             	sub    $0x38,%esp
80101359:	8b 45 08             	mov    0x8(%ebp),%eax
  acquire(&cons.lock);
8010135c:	68 c0 ff 10 80       	push   $0x8010ffc0
{
80101361:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  acquire(&cons.lock);
80101364:	e8 37 45 00 00       	call   801058a0 <acquire>
  int c, doprocdump = 0;
80101369:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((c = getc()) >= 0){
80101370:	83 c4 10             	add    $0x10,%esp
80101373:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101377:	90                   	nop
80101378:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010137b:	ff d0                	call   *%eax
8010137d:	89 c3                	mov    %eax,%ebx
8010137f:	85 c0                	test   %eax,%eax
80101381:	78 7d                	js     80101400 <consoleintr+0xb0>
      if (c != C('S') && select_mode != 0) {
80101383:	0f 84 87 01 00 00    	je     80101510 <consoleintr+0x1c0>
80101389:	83 fb 13             	cmp    $0x13,%ebx
8010138c:	0f 84 7e 01 00 00    	je     80101510 <consoleintr+0x1c0>
80101392:	a1 a4 ff 10 80       	mov    0x8010ffa4,%eax
80101397:	85 c0                	test   %eax,%eax
80101399:	74 12                	je     801013ad <consoleintr+0x5d>
        if (select_mode == 1) {
8010139b:	83 f8 01             	cmp    $0x1,%eax
8010139e:	0f 84 d4 05 00 00    	je     80101978 <consoleintr+0x628>
        else if (select_mode == 2) {  
801013a4:	83 f8 02             	cmp    $0x2,%eax
801013a7:	0f 84 cb 06 00 00    	je     80101a78 <consoleintr+0x728>
    switch(c){
801013ad:	83 fb 1a             	cmp    $0x1a,%ebx
801013b0:	7f 0e                	jg     801013c0 <consoleintr+0x70>
801013b2:	0f 87 00 06 00 00    	ja     801019b8 <consoleintr+0x668>
801013b8:	ff 24 9d 14 85 10 80 	jmp    *-0x7fef7aec(,%ebx,4)
801013bf:	90                   	nop
801013c0:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
801013c6:	0f 84 0c 05 00 00    	je     801018d8 <consoleintr+0x588>
801013cc:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
801013d2:	75 54                	jne    80101428 <consoleintr+0xd8>
      int cursor1 = input.e-left_key_pressed_count;
801013d4:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
801013da:	a1 b0 ff 10 80       	mov    0x8010ffb0,%eax
801013df:	89 d1                	mov    %edx,%ecx
801013e1:	29 c1                	sub    %eax,%ecx
      if(input.e>cursor1){
801013e3:	39 ca                	cmp    %ecx,%edx
801013e5:	0f 87 ee 06 00 00    	ja     80101ad9 <consoleintr+0x789>
        left_key_pressed=0;
801013eb:	c7 05 b4 ff 10 80 00 	movl   $0x0,0x8010ffb4
801013f2:	00 00 00 
  while((c = getc()) >= 0){
801013f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801013f8:	ff d0                	call   *%eax
801013fa:	89 c3                	mov    %eax,%ebx
801013fc:	85 c0                	test   %eax,%eax
801013fe:	79 83                	jns    80101383 <consoleintr+0x33>
  release(&cons.lock);
80101400:	83 ec 0c             	sub    $0xc,%esp
80101403:	68 c0 ff 10 80       	push   $0x8010ffc0
80101408:	e8 33 44 00 00       	call   80105840 <release>
  if(doprocdump) {
8010140d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101410:	83 c4 10             	add    $0x10,%esp
80101413:	85 c0                	test   %eax,%eax
80101415:	0f 85 32 06 00 00    	jne    80101a4d <consoleintr+0x6fd>
}
8010141b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010141e:	5b                   	pop    %ebx
8010141f:	5e                   	pop    %esi
80101420:	5f                   	pop    %edi
80101421:	5d                   	pop    %ebp
80101422:	c3                   	ret    
80101423:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101427:	90                   	nop
    switch(c){
80101428:	83 fb 7f             	cmp    $0x7f,%ebx
8010142b:	0f 85 87 05 00 00    	jne    801019b8 <consoleintr+0x668>
      if (select_mode == 2 && select_end != select_start) {
80101431:	83 3d a4 ff 10 80 02 	cmpl   $0x2,0x8010ffa4
80101438:	0f 84 71 06 00 00    	je     80101aaf <consoleintr+0x75f>
      else if(input.e != input.w && input.e - input.w > left_key_pressed_count){
8010143e:	8b 1d 08 ff 10 80    	mov    0x8010ff08,%ebx
80101444:	a1 04 ff 10 80       	mov    0x8010ff04,%eax
80101449:	39 c3                	cmp    %eax,%ebx
8010144b:	0f 84 27 ff ff ff    	je     80101378 <consoleintr+0x28>
80101451:	89 d9                	mov    %ebx,%ecx
80101453:	8b 15 b0 ff 10 80    	mov    0x8010ffb0,%edx
80101459:	29 c1                	sub    %eax,%ecx
8010145b:	39 d1                	cmp    %edx,%ecx
8010145d:	0f 86 15 ff ff ff    	jbe    80101378 <consoleintr+0x28>
  int shift_idx= shift_from_seq ? last_sequence(): input.e-left_key_pressed_count;
80101463:	89 df                	mov    %ebx,%edi
80101465:	89 de                	mov    %ebx,%esi
80101467:	29 d7                	sub    %edx,%edi
  for (int i = shift_idx - 1; i < input.e; i++)
80101469:	8d 57 ff             	lea    -0x1(%edi),%edx
8010146c:	39 d3                	cmp    %edx,%ebx
8010146e:	76 37                	jbe    801014a7 <consoleintr+0x157>
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
80101470:	89 d0                	mov    %edx,%eax
80101472:	83 c2 01             	add    $0x1,%edx
80101475:	89 d3                	mov    %edx,%ebx
80101477:	c1 fb 1f             	sar    $0x1f,%ebx
8010147a:	c1 eb 19             	shr    $0x19,%ebx
8010147d:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80101480:	83 e1 7f             	and    $0x7f,%ecx
80101483:	29 d9                	sub    %ebx,%ecx
80101485:	0f b6 99 80 fe 10 80 	movzbl -0x7fef0180(%ecx),%ebx
8010148c:	89 c1                	mov    %eax,%ecx
8010148e:	c1 f9 1f             	sar    $0x1f,%ecx
80101491:	c1 e9 19             	shr    $0x19,%ecx
80101494:	01 c8                	add    %ecx,%eax
80101496:	83 e0 7f             	and    $0x7f,%eax
80101499:	29 c8                	sub    %ecx,%eax
8010149b:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  for (int i = shift_idx - 1; i < input.e; i++)
801014a1:	39 d6                	cmp    %edx,%esi
801014a3:	77 cb                	ja     80101470 <consoleintr+0x120>
801014a5:	89 f3                	mov    %esi,%ebx
        delete_from_sequence(input.e-left_key_pressed_count);
801014a7:	83 ec 0c             	sub    $0xc,%esp
  input.buf[input.e] = ' ';
801014aa:	c6 83 80 fe 10 80 20 	movb   $0x20,-0x7fef0180(%ebx)
        delete_from_sequence(input.e-left_key_pressed_count);
801014b1:	57                   	push   %edi
801014b2:	e8 d9 f8 ff ff       	call   80100d90 <delete_from_sequence>
        for(int i=0;i<input_sequence.size;i++) {
801014b7:	8b 1d 00 92 10 80    	mov    0x80109200,%ebx
801014bd:	83 c4 10             	add    $0x10,%esp
801014c0:	85 db                	test   %ebx,%ebx
801014c2:	0f 8e 61 08 00 00    	jle    80101d29 <consoleintr+0x9d9>
          if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
801014c8:	8b 35 08 ff 10 80    	mov    0x8010ff08,%esi
        for(int i=0;i<input_sequence.size;i++) {
801014ce:	31 c0                	xor    %eax,%eax
          if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
801014d0:	89 f1                	mov    %esi,%ecx
801014d2:	2b 0d b0 ff 10 80    	sub    0x8010ffb0,%ecx
801014d8:	83 e1 7f             	and    $0x7f,%ecx
801014db:	8b 14 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%edx
801014e2:	39 ca                	cmp    %ecx,%edx
801014e4:	76 0a                	jbe    801014f0 <consoleintr+0x1a0>
            input_sequence.data[i]--;
801014e6:	83 ea 01             	sub    $0x1,%edx
801014e9:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
        for(int i=0;i<input_sequence.size;i++) {
801014f0:	83 c0 01             	add    $0x1,%eax
801014f3:	39 c3                	cmp    %eax,%ebx
801014f5:	75 e4                	jne    801014db <consoleintr+0x18b>
  if(panicked){
801014f7:	a1 f8 ff 10 80       	mov    0x8010fff8,%eax
        input.e--;
801014fc:	83 ee 01             	sub    $0x1,%esi
801014ff:	89 35 08 ff 10 80    	mov    %esi,0x8010ff08
  if(panicked){
80101505:	85 c0                	test   %eax,%eax
80101507:	0f 84 d9 07 00 00    	je     80101ce6 <consoleintr+0x996>
8010150d:	fa                   	cli    
    for(;;)
8010150e:	eb fe                	jmp    8010150e <consoleintr+0x1be>
    switch(c){
80101510:	83 fb 1a             	cmp    $0x1a,%ebx
80101513:	0f 8f a7 fe ff ff    	jg     801013c0 <consoleintr+0x70>
80101519:	85 db                	test   %ebx,%ebx
8010151b:	0f 84 57 fe ff ff    	je     80101378 <consoleintr+0x28>
80101521:	83 fb 1a             	cmp    $0x1a,%ebx
80101524:	0f 87 80 04 00 00    	ja     801019aa <consoleintr+0x65a>
8010152a:	ff 24 9d 80 85 10 80 	jmp    *-0x7fef7a80(,%ebx,4)
        cgaputc("0"+select_start);
80101531:	a1 ac ff 10 80       	mov    0x8010ffac,%eax
80101536:	05 10 85 10 80       	add    $0x80108510,%eax
8010153b:	e8 60 f0 ff ff       	call   801005a0 <cgaputc>
        cgaputc("0"+select_end);
80101540:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80101545:	05 10 85 10 80       	add    $0x80108510,%eax
8010154a:	e8 51 f0 ff ff       	call   801005a0 <cgaputc>
        cgaputc("0"+select_mode);
8010154f:	a1 a4 ff 10 80       	mov    0x8010ffa4,%eax
80101554:	05 10 85 10 80       	add    $0x80108510,%eax
80101559:	e8 42 f0 ff ff       	call   801005a0 <cgaputc>
      break;
8010155e:	e9 15 fe ff ff       	jmp    80101378 <consoleintr+0x28>
      if(input.e != input.w){
80101563:	a1 04 ff 10 80       	mov    0x8010ff04,%eax
80101568:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
8010156e:	0f 84 04 fe ff ff    	je     80101378 <consoleintr+0x28>
    if (input_sequence.size == 0) return -1;
80101574:	a1 00 92 10 80       	mov    0x80109200,%eax
    return input_sequence.data[input_sequence.size - 1];
80101579:	8d 50 ff             	lea    -0x1(%eax),%edx
    if (input_sequence.size == 0) return -1;
8010157c:	85 c0                	test   %eax,%eax
8010157e:	0f 84 96 07 00 00    	je     80101d1a <consoleintr+0x9ca>
  for (int i = shift_idx - 1; i < input.e; i++)
80101584:	8b 04 95 00 90 10 80 	mov    -0x7fef7000(,%edx,4),%eax
8010158b:	8d 58 ff             	lea    -0x1(%eax),%ebx
8010158e:	89 df                	mov    %ebx,%edi
    (delete_from_sequence(input_sequence.size-1));
80101590:	83 ec 0c             	sub    $0xc,%esp
80101593:	52                   	push   %edx
80101594:	e8 f7 f7 ff ff       	call   80100d90 <delete_from_sequence>
  for (int i = shift_idx - 1; i < input.e; i++)
80101599:	8b 35 08 ff 10 80    	mov    0x8010ff08,%esi
8010159f:	83 c4 10             	add    $0x10,%esp
801015a2:	39 fe                	cmp    %edi,%esi
801015a4:	76 3b                	jbe    801015e1 <consoleintr+0x291>
801015a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015ad:	8d 76 00             	lea    0x0(%esi),%esi
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
801015b0:	89 d8                	mov    %ebx,%eax
801015b2:	83 c3 01             	add    $0x1,%ebx
801015b5:	89 d9                	mov    %ebx,%ecx
801015b7:	c1 f9 1f             	sar    $0x1f,%ecx
801015ba:	c1 e9 19             	shr    $0x19,%ecx
801015bd:	8d 14 0b             	lea    (%ebx,%ecx,1),%edx
801015c0:	83 e2 7f             	and    $0x7f,%edx
801015c3:	29 ca                	sub    %ecx,%edx
801015c5:	0f b6 8a 80 fe 10 80 	movzbl -0x7fef0180(%edx),%ecx
801015cc:	99                   	cltd   
801015cd:	c1 ea 19             	shr    $0x19,%edx
801015d0:	01 d0                	add    %edx,%eax
801015d2:	83 e0 7f             	and    $0x7f,%eax
801015d5:	29 d0                	sub    %edx,%eax
801015d7:	88 88 80 fe 10 80    	mov    %cl,-0x7fef0180(%eax)
  for (int i = shift_idx - 1; i < input.e; i++)
801015dd:	39 f3                	cmp    %esi,%ebx
801015df:	72 cf                	jb     801015b0 <consoleintr+0x260>
  if(panicked){
801015e1:	8b 0d f8 ff 10 80    	mov    0x8010fff8,%ecx
  input.buf[input.e] = ' ';
801015e7:	c6 86 80 fe 10 80 20 	movb   $0x20,-0x7fef0180(%esi)
        input.e--;
801015ee:	83 ee 01             	sub    $0x1,%esi
801015f1:	89 35 08 ff 10 80    	mov    %esi,0x8010ff08
  if(panicked){
801015f7:	85 c9                	test   %ecx,%ecx
801015f9:	0f 84 5d 05 00 00    	je     80101b5c <consoleintr+0x80c>
801015ff:	fa                   	cli    
    for(;;)
80101600:	eb fe                	jmp    80101600 <consoleintr+0x2b0>
80101602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        int pos = input.e-left_key_pressed_count;
80101608:	8b 35 08 ff 10 80    	mov    0x8010ff08,%esi
8010160e:	8b 0d b0 ff 10 80    	mov    0x8010ffb0,%ecx
80101614:	89 f7                	mov    %esi,%edi
80101616:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101619:	29 cf                	sub    %ecx,%edi
        int distance = pos - (input.e-left_key_pressed_count);
8010161b:	29 f1                	sub    %esi,%ecx
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
8010161d:	89 fb                	mov    %edi,%ebx
        int pos = input.e-left_key_pressed_count;
8010161f:	89 f8                	mov    %edi,%eax
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
80101621:	c1 fb 1f             	sar    $0x1f,%ebx
80101624:	c1 eb 19             	shr    $0x19,%ebx
80101627:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
8010162a:	83 e2 7f             	and    $0x7f,%edx
8010162d:	29 da                	sub    %ebx,%edx
8010162f:	80 ba 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%edx)
80101636:	74 38                	je     80101670 <consoleintr+0x320>
80101638:	39 fe                	cmp    %edi,%esi
8010163a:	77 12                	ja     8010164e <consoleintr+0x2fe>
8010163c:	e9 c2 00 00 00       	jmp    80101703 <consoleintr+0x3b3>
80101641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101648:	89 c7                	mov    %eax,%edi
8010164a:	39 c6                	cmp    %eax,%esi
8010164c:	76 40                	jbe    8010168e <consoleintr+0x33e>
            pos++;
8010164e:	83 c0 01             	add    $0x1,%eax
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
80101651:	89 c3                	mov    %eax,%ebx
80101653:	c1 fb 1f             	sar    $0x1f,%ebx
80101656:	c1 eb 19             	shr    $0x19,%ebx
80101659:	8d 14 18             	lea    (%eax,%ebx,1),%edx
8010165c:	83 e2 7f             	and    $0x7f,%edx
8010165f:	29 da                	sub    %ebx,%edx
80101661:	80 ba 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%edx)
80101668:	75 de                	jne    80101648 <consoleintr+0x2f8>
8010166a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            pos++;
80101670:	83 c0 01             	add    $0x1,%eax
            while (input.buf[pos % INPUT_BUF] == ' '){
80101673:	89 c3                	mov    %eax,%ebx
80101675:	c1 fb 1f             	sar    $0x1f,%ebx
80101678:	c1 eb 19             	shr    $0x19,%ebx
8010167b:	8d 14 18             	lea    (%eax,%ebx,1),%edx
8010167e:	83 e2 7f             	and    $0x7f,%edx
80101681:	29 da                	sub    %ebx,%edx
80101683:	80 ba 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%edx)
8010168a:	74 e4                	je     80101670 <consoleintr+0x320>
        int distance = pos - (input.e-left_key_pressed_count);
8010168c:	89 c7                	mov    %eax,%edi
8010168e:	8d 04 0f             	lea    (%edi,%ecx,1),%eax
80101691:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < distance; i++)
80101694:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101697:	85 c0                	test   %eax,%eax
80101699:	7e 68                	jle    80101703 <consoleintr+0x3b3>
8010169b:	31 c0                	xor    %eax,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010169d:	89 7d d4             	mov    %edi,-0x2c(%ebp)
801016a0:	be d4 03 00 00       	mov    $0x3d4,%esi
801016a5:	89 c7                	mov    %eax,%edi
801016a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016ae:	66 90                	xchg   %ax,%ax
801016b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801016b5:	89 f2                	mov    %esi,%edx
801016b7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801016b8:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801016bd:	89 da                	mov    %ebx,%edx
801016bf:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
801016c0:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801016c3:	89 f2                	mov    %esi,%edx
801016c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801016ca:	c1 e1 08             	shl    $0x8,%ecx
801016cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801016ce:	89 da                	mov    %ebx,%edx
801016d0:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
801016d1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801016d4:	89 f2                	mov    %esi,%edx
801016d6:	09 c1                	or     %eax,%ecx
801016d8:	b8 0e 00 00 00       	mov    $0xe,%eax
    pos++;
801016dd:	83 c1 01             	add    $0x1,%ecx
801016e0:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
801016e1:	89 ca                	mov    %ecx,%edx
801016e3:	c1 fa 08             	sar    $0x8,%edx
801016e6:	89 d0                	mov    %edx,%eax
801016e8:	89 da                	mov    %ebx,%edx
801016ea:	ee                   	out    %al,(%dx)
801016eb:	b8 0f 00 00 00       	mov    $0xf,%eax
801016f0:	89 f2                	mov    %esi,%edx
801016f2:	ee                   	out    %al,(%dx)
801016f3:	89 c8                	mov    %ecx,%eax
801016f5:	89 da                	mov    %ebx,%edx
801016f7:	ee                   	out    %al,(%dx)
        for (int i = 0; i < distance; i++)
801016f8:	83 c7 01             	add    $0x1,%edi
801016fb:	3b 7d e0             	cmp    -0x20(%ebp),%edi
801016fe:	75 b0                	jne    801016b0 <consoleintr+0x360>
80101700:	8b 7d d4             	mov    -0x2c(%ebp),%edi
        left_key_pressed_count = input.e-pos;
80101703:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101706:	29 f8                	sub    %edi,%eax
80101708:	a3 b0 ff 10 80       	mov    %eax,0x8010ffb0
        break;
8010170d:	e9 66 fc ff ff       	jmp    80101378 <consoleintr+0x28>
         int posA = input.e-left_key_pressed_count;
80101712:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80101717:	89 c2                	mov    %eax,%edx
80101719:	2b 15 b0 ff 10 80    	sub    0x8010ffb0,%edx
8010171f:	89 45 e0             	mov    %eax,-0x20(%ebp)
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80101722:	89 d1                	mov    %edx,%ecx
         int posA = input.e-left_key_pressed_count;
80101724:	89 d0                	mov    %edx,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80101726:	c1 f9 1f             	sar    $0x1f,%ecx
80101729:	c1 e9 19             	shr    $0x19,%ecx
8010172c:	8d 34 0a             	lea    (%edx,%ecx,1),%esi
8010172f:	83 e6 7f             	and    $0x7f,%esi
80101732:	29 ce                	sub    %ecx,%esi
80101734:	80 be 7f fe 10 80 20 	cmpb   $0x20,-0x7fef0181(%esi)
8010173b:	0f 85 7a 05 00 00    	jne    80101cbb <consoleintr+0x96b>
80101741:	8b 0d 04 ff 10 80    	mov    0x8010ff04,%ecx
80101747:	eb 27                	jmp    80101770 <consoleintr+0x420>
80101749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            posA--;
80101750:	83 e8 01             	sub    $0x1,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80101753:	89 c3                	mov    %eax,%ebx
80101755:	c1 fb 1f             	sar    $0x1f,%ebx
80101758:	c1 eb 19             	shr    $0x19,%ebx
8010175b:	8d 34 18             	lea    (%eax,%ebx,1),%esi
8010175e:	83 e6 7f             	and    $0x7f,%esi
80101761:	29 de                	sub    %ebx,%esi
80101763:	80 be 7f fe 10 80 20 	cmpb   $0x20,-0x7fef0181(%esi)
8010176a:	0f 85 c0 03 00 00    	jne    80101b30 <consoleintr+0x7e0>
80101770:	89 c3                	mov    %eax,%ebx
80101772:	39 c1                	cmp    %eax,%ecx
80101774:	72 da                	jb     80101750 <consoleintr+0x400>
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
80101776:	80 be 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%esi)
8010177d:	0f 84 17 04 00 00    	je     80101b9a <consoleintr+0x84a>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
80101783:	89 c7                	mov    %eax,%edi
80101785:	c1 ff 1f             	sar    $0x1f,%edi
80101788:	c1 ef 19             	shr    $0x19,%edi
8010178b:	8d 34 38             	lea    (%eax,%edi,1),%esi
8010178e:	83 e6 7f             	and    $0x7f,%esi
80101791:	29 fe                	sub    %edi,%esi
80101793:	80 be 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%esi)
8010179a:	75 2c                	jne    801017c8 <consoleintr+0x478>
8010179c:	e9 ae 03 00 00       	jmp    80101b4f <consoleintr+0x7ff>
801017a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            posA--;
801017a8:	83 e8 01             	sub    $0x1,%eax
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
801017ab:	89 c6                	mov    %eax,%esi
801017ad:	c1 fe 1f             	sar    $0x1f,%esi
801017b0:	c1 ee 19             	shr    $0x19,%esi
801017b3:	8d 1c 30             	lea    (%eax,%esi,1),%ebx
801017b6:	83 e3 7f             	and    $0x7f,%ebx
801017b9:	29 f3                	sub    %esi,%ebx
801017bb:	80 bb 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%ebx)
801017c2:	0f 84 85 03 00 00    	je     80101b4d <consoleintr+0x7fd>
801017c8:	89 c3                	mov    %eax,%ebx
801017ca:	39 c8                	cmp    %ecx,%eax
801017cc:	77 da                	ja     801017a8 <consoleintr+0x458>
        int distanceA = input.e-left_key_pressed_count-posA;
801017ce:	89 d6                	mov    %edx,%esi
801017d0:	29 de                	sub    %ebx,%esi
        for (int i = distanceA; i > 0; i--)
801017d2:	85 f6                	test   %esi,%esi
801017d4:	7e 14                	jle    801017ea <consoleintr+0x49a>
801017d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017dd:	8d 76 00             	lea    0x0(%esi),%esi
            move_cursor_left();
801017e0:	e8 7b f7 ff ff       	call   80100f60 <move_cursor_left>
        for (int i = distanceA; i > 0; i--)
801017e5:	83 ee 01             	sub    $0x1,%esi
801017e8:	75 f6                	jne    801017e0 <consoleintr+0x490>
        left_key_pressed_count = input.e-posA;     
801017ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
801017ed:	29 d8                	sub    %ebx,%eax
801017ef:	a3 b0 ff 10 80       	mov    %eax,0x8010ffb0
      break;
801017f4:	e9 7f fb ff ff       	jmp    80101378 <consoleintr+0x28>
      if (select_mode == 2){
801017f9:	83 3d a4 ff 10 80 02 	cmpl   $0x2,0x8010ffa4
80101800:	0f 84 8a 03 00 00    	je     80101b90 <consoleintr+0x840>
      if (copied_length > 0) {
80101806:	8b 15 0c ff 10 80    	mov    0x8010ff0c,%edx
8010180c:	85 d2                	test   %edx,%edx
8010180e:	0f 8e 64 fb ff ff    	jle    80101378 <consoleintr+0x28>
        paste_text();
80101814:	e8 27 fa ff ff       	call   80101240 <paste_text>
        select_mode = 0;
80101819:	c7 05 a4 ff 10 80 00 	movl   $0x0,0x8010ffa4
80101820:	00 00 00 
80101823:	e9 50 fb ff ff       	jmp    80101378 <consoleintr+0x28>
      while(input.e != input.w &&
80101828:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010182d:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80101833:	0f 84 3f fb ff ff    	je     80101378 <consoleintr+0x28>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80101839:	83 e8 01             	sub    $0x1,%eax
8010183c:	89 c2                	mov    %eax,%edx
8010183e:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80101841:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80101848:	0f 84 2a fb ff ff    	je     80101378 <consoleintr+0x28>
        input.e--;
8010184e:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80101853:	a1 f8 ff 10 80       	mov    0x8010fff8,%eax
80101858:	85 c0                	test   %eax,%eax
8010185a:	0f 84 b8 00 00 00    	je     80101918 <consoleintr+0x5c8>
  asm volatile("cli");
80101860:	fa                   	cli    
    for(;;)
80101861:	eb fe                	jmp    80101861 <consoleintr+0x511>
80101863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101867:	90                   	nop
      if (select_mode == 0) {
80101868:	a1 a4 ff 10 80       	mov    0x8010ffa4,%eax
8010186d:	85 c0                	test   %eax,%eax
8010186f:	0f 84 e4 01 00 00    	je     80101a59 <consoleintr+0x709>
      else if (select_mode == 1) {
80101875:	83 f8 01             	cmp    $0x1,%eax
80101878:	0f 84 42 03 00 00    	je     80101bc0 <consoleintr+0x870>
      else if (select_mode == 2) {
8010187e:	83 f8 02             	cmp    $0x2,%eax
80101881:	0f 85 f1 fa ff ff    	jne    80101378 <consoleintr+0x28>
  if (select_mode != 2) return;
80101887:	e8 84 eb ff ff       	call   80100410 <clear_highlight_from_buffer.part.0>
        select_start = input.e - left_key_pressed_count;
8010188c:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80101891:	2b 05 b0 ff 10 80    	sub    0x8010ffb0,%eax
        select_mode = 1;
80101897:	c7 05 a4 ff 10 80 01 	movl   $0x1,0x8010ffa4
8010189e:	00 00 00 
        select_start = input.e - left_key_pressed_count;
801018a1:	a3 ac ff 10 80       	mov    %eax,0x8010ffac
801018a6:	e9 cd fa ff ff       	jmp    80101378 <consoleintr+0x28>
801018ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018af:	90                   	nop
      doprocdump = 1;
801018b0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
801018b7:	e9 bc fa ff ff       	jmp    80101378 <consoleintr+0x28>
      if (select_mode == 2) {
801018bc:	83 3d a4 ff 10 80 02 	cmpl   $0x2,0x8010ffa4
801018c3:	0f 85 af fa ff ff    	jne    80101378 <consoleintr+0x28>
        copy_selected_text();
801018c9:	e8 b2 f5 ff ff       	call   80100e80 <copy_selected_text>
801018ce:	e9 a5 fa ff ff       	jmp    80101378 <consoleintr+0x28>
801018d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018d7:	90                   	nop
        int cursor = input.e-left_key_pressed_count;
801018d8:	8b 1d b0 ff 10 80    	mov    0x8010ffb0,%ebx
801018de:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801018e3:	29 d8                	sub    %ebx,%eax
        if (input.w < cursor)
801018e5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801018eb:	0f 86 87 fa ff ff    	jbe    80101378 <consoleintr+0x28>
          if (left_key_pressed==0)
801018f1:	8b 35 b4 ff 10 80    	mov    0x8010ffb4,%esi
801018f7:	85 f6                	test   %esi,%esi
801018f9:	75 0a                	jne    80101905 <consoleintr+0x5b5>
            left_key_pressed=1;
801018fb:	c7 05 b4 ff 10 80 01 	movl   $0x1,0x8010ffb4
80101902:	00 00 00 
          move_cursor_left();
80101905:	e8 56 f6 ff ff       	call   80100f60 <move_cursor_left>
          left_key_pressed_count++;
8010190a:	83 c3 01             	add    $0x1,%ebx
8010190d:	89 1d b0 ff 10 80    	mov    %ebx,0x8010ffb0
80101913:	e9 60 fa ff ff       	jmp    80101378 <consoleintr+0x28>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101918:	83 ec 0c             	sub    $0xc,%esp
8010191b:	6a 08                	push   $0x8
8010191d:	e8 8e 56 00 00       	call   80106fb0 <uartputc>
80101922:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101929:	e8 82 56 00 00       	call   80106fb0 <uartputc>
8010192e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101935:	e8 76 56 00 00       	call   80106fb0 <uartputc>
  cgaputc(c);
8010193a:	b8 00 01 00 00       	mov    $0x100,%eax
8010193f:	e8 5c ec ff ff       	call   801005a0 <cgaputc>
      while(input.e != input.w &&
80101944:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80101949:	83 c4 10             	add    $0x10,%esp
    input_sequence.size = 0;
8010194c:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80101953:	00 00 00 
    cga_pos_sequence.size = 0;
80101956:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
8010195d:	00 00 00 
      while(input.e != input.w &&
80101960:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80101966:	0f 85 cd fe ff ff    	jne    80101839 <consoleintr+0x4e9>
8010196c:	e9 07 fa ff ff       	jmp    80101378 <consoleintr+0x28>
80101971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            c != C('A') && c != C('D') 
80101978:	83 fb 01             	cmp    $0x1,%ebx
8010197b:	0f 95 c2             	setne  %dl
8010197e:	83 fb 04             	cmp    $0x4,%ebx
80101981:	0f 95 c0             	setne  %al
80101984:	84 c2                	test   %al,%dl
80101986:	0f 84 21 fa ff ff    	je     801013ad <consoleintr+0x5d>
            c != RIGHT_ARROW && c != LEFT_ARROW &&
8010198c:	8d 83 1c ff ff ff    	lea    -0xe4(%ebx),%eax
            c != C('A') && c != C('D') 
80101992:	83 f8 01             	cmp    $0x1,%eax
80101995:	0f 86 12 fa ff ff    	jbe    801013ad <consoleintr+0x5d>
            select_mode = 0;
8010199b:	c7 05 a4 ff 10 80 00 	movl   $0x0,0x8010ffa4
801019a2:	00 00 00 
801019a5:	e9 03 fa ff ff       	jmp    801013ad <consoleintr+0x5d>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801019aa:	85 db                	test   %ebx,%ebx
801019ac:	0f 84 c6 f9 ff ff    	je     80101378 <consoleintr+0x28>
801019b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801019b8:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801019bd:	89 c2                	mov    %eax,%edx
801019bf:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801019c5:	83 fa 7f             	cmp    $0x7f,%edx
801019c8:	0f 87 aa f9 ff ff    	ja     80101378 <consoleintr+0x28>
        if (select_mode == 2) {
801019ce:	83 3d a4 ff 10 80 02 	cmpl   $0x2,0x8010ffa4
801019d5:	0f 84 ed 02 00 00    	je     80101cc8 <consoleintr+0x978>
          input.buf[(input.e++) % INPUT_BUF] = c;
801019db:	8d 78 01             	lea    0x1(%eax),%edi
        if (c=='\n')
801019de:	83 fb 0a             	cmp    $0xa,%ebx
801019e1:	74 09                	je     801019ec <consoleintr+0x69c>
801019e3:	83 fb 0d             	cmp    $0xd,%ebx
801019e6:	0f 85 0d 02 00 00    	jne    80101bf9 <consoleintr+0x8a9>
          input.buf[(input.e++) % INPUT_BUF] = c;
801019ec:	83 e0 7f             	and    $0x7f,%eax
801019ef:	89 3d 08 ff 10 80    	mov    %edi,0x8010ff08
801019f5:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
        consputc(c);
801019fc:	b8 0a 00 00 00       	mov    $0xa,%eax
    input_sequence.size = 0;
80101a01:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80101a08:	00 00 00 
        consputc(c);
80101a0b:	e8 b0 ee ff ff       	call   801008c0 <consputc>
          input.w = input.e;
80101a10:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
    input_sequence.size = 0;
80101a15:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80101a1c:	00 00 00 
          wakeup(&input.r);
80101a1f:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80101a22:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
80101a27:	68 00 ff 10 80       	push   $0x8010ff00
          left_key_pressed=0;
80101a2c:	c7 05 b4 ff 10 80 00 	movl   $0x0,0x8010ffb4
80101a33:	00 00 00 
          left_key_pressed_count=0;
80101a36:	c7 05 b0 ff 10 80 00 	movl   $0x0,0x8010ffb0
80101a3d:	00 00 00 
          wakeup(&input.r);
80101a40:	e8 bb 39 00 00       	call   80105400 <wakeup>
80101a45:	83 c4 10             	add    $0x10,%esp
80101a48:	e9 2b f9 ff ff       	jmp    80101378 <consoleintr+0x28>
}
80101a4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a50:	5b                   	pop    %ebx
80101a51:	5e                   	pop    %esi
80101a52:	5f                   	pop    %edi
80101a53:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80101a54:	e9 87 3a 00 00       	jmp    801054e0 <procdump>
        select_start = input.e - left_key_pressed_count;
80101a59:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80101a5e:	2b 05 b0 ff 10 80    	sub    0x8010ffb0,%eax
        select_mode = 1;
80101a64:	c7 05 a4 ff 10 80 01 	movl   $0x1,0x8010ffa4
80101a6b:	00 00 00 
        select_start = input.e - left_key_pressed_count;
80101a6e:	a3 ac ff 10 80       	mov    %eax,0x8010ffac
        select_mode = 1;
80101a73:	e9 00 f9 ff ff       	jmp    80101378 <consoleintr+0x28>
          else if (c == C('C')) {
80101a78:	83 fb 7f             	cmp    $0x7f,%ebx
80101a7b:	0f 84 b0 f9 ff ff    	je     80101431 <consoleintr+0xe1>
            c != RIGHT_ARROW && c != LEFT_ARROW &&
80101a81:	8d 83 1c ff ff ff    	lea    -0xe4(%ebx),%eax
80101a87:	83 f8 01             	cmp    $0x1,%eax
80101a8a:	0f 97 c0             	seta   %al
            c != C('A') && c != C('D') 
80101a8d:	83 fb 08             	cmp    $0x8,%ebx
80101a90:	7f 0b                	jg     80101a9d <consoleintr+0x74d>
80101a92:	ba e5 fe ff ff       	mov    $0xfffffee5,%edx
80101a97:	89 d9                	mov    %ebx,%ecx
80101a99:	d3 fa                	sar    %cl,%edx
80101a9b:	21 d0                	and    %edx,%eax
80101a9d:	84 c0                	test   %al,%al
80101a9f:	0f 84 08 f9 ff ff    	je     801013ad <consoleintr+0x5d>
            delete_selected_area();
80101aa5:	e8 26 f5 ff ff       	call   80100fd0 <delete_selected_area>
80101aaa:	e9 ec fe ff ff       	jmp    8010199b <consoleintr+0x64b>
      if (select_mode == 2 && select_end != select_start) {
80101aaf:	a1 ac ff 10 80       	mov    0x8010ffac,%eax
80101ab4:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
80101aba:	0f 84 7e f9 ff ff    	je     8010143e <consoleintr+0xee>
  if (select_mode != 2) return;
80101ac0:	e8 4b e9 ff ff       	call   80100410 <clear_highlight_from_buffer.part.0>
        delete_selected_area();
80101ac5:	e8 06 f5 ff ff       	call   80100fd0 <delete_selected_area>
        select_mode = 0;
80101aca:	c7 05 a4 ff 10 80 00 	movl   $0x0,0x8010ffa4
80101ad1:	00 00 00 
80101ad4:	e9 9f f8 ff ff       	jmp    80101378 <consoleintr+0x28>
        left_key_pressed_count--;
80101ad9:	83 e8 01             	sub    $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101adc:	be d4 03 00 00       	mov    $0x3d4,%esi
80101ae1:	a3 b0 ff 10 80       	mov    %eax,0x8010ffb0
80101ae6:	89 f2                	mov    %esi,%edx
80101ae8:	b8 0e 00 00 00       	mov    $0xe,%eax
80101aed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101aee:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80101af3:	89 da                	mov    %ebx,%edx
80101af5:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101af6:	bf 0f 00 00 00       	mov    $0xf,%edi
    pos = inb(CRTPORT+1) << 8;
80101afb:	0f b6 c8             	movzbl %al,%ecx
80101afe:	89 f2                	mov    %esi,%edx
80101b00:	c1 e1 08             	shl    $0x8,%ecx
80101b03:	89 f8                	mov    %edi,%eax
80101b05:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101b06:	89 da                	mov    %ebx,%edx
80101b08:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80101b09:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101b0c:	89 f2                	mov    %esi,%edx
80101b0e:	09 c1                	or     %eax,%ecx
80101b10:	b8 0e 00 00 00       	mov    $0xe,%eax
    pos++;
80101b15:	83 c1 01             	add    $0x1,%ecx
80101b18:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80101b19:	89 c8                	mov    %ecx,%eax
80101b1b:	89 da                	mov    %ebx,%edx
80101b1d:	c1 f8 08             	sar    $0x8,%eax
80101b20:	ee                   	out    %al,(%dx)
80101b21:	89 f8                	mov    %edi,%eax
80101b23:	89 f2                	mov    %esi,%edx
80101b25:	ee                   	out    %al,(%dx)
80101b26:	89 c8                	mov    %ecx,%eax
80101b28:	89 da                	mov    %ebx,%edx
80101b2a:	ee                   	out    %al,(%dx)
    outb(CRTPORT, 15);
    outb(CRTPORT+1, pos);
}
80101b2b:	e9 48 f8 ff ff       	jmp    80101378 <consoleintr+0x28>
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
80101b30:	89 c3                	mov    %eax,%ebx
80101b32:	80 be 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%esi)
80101b39:	0f 85 44 fc ff ff    	jne    80101783 <consoleintr+0x433>
80101b3f:	39 d9                	cmp    %ebx,%ecx
80101b41:	73 57                	jae    80101b9a <consoleintr+0x84a>
          posA--;
80101b43:	83 e8 01             	sub    $0x1,%eax
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
80101b46:	89 c3                	mov    %eax,%ebx
80101b48:	e9 36 fc ff ff       	jmp    80101783 <consoleintr+0x433>
80101b4d:	89 c3                	mov    %eax,%ebx
          posA++;
80101b4f:	83 c0 01             	add    $0x1,%eax
80101b52:	39 cb                	cmp    %ecx,%ebx
80101b54:	0f 47 d8             	cmova  %eax,%ebx
80101b57:	e9 72 fc ff ff       	jmp    801017ce <consoleintr+0x47e>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101b5c:	83 ec 0c             	sub    $0xc,%esp
80101b5f:	6a 08                	push   $0x8
80101b61:	e8 4a 54 00 00       	call   80106fb0 <uartputc>
80101b66:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101b6d:	e8 3e 54 00 00       	call   80106fb0 <uartputc>
80101b72:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101b79:	e8 32 54 00 00       	call   80106fb0 <uartputc>
  cgaputc(c);
80101b7e:	b8 01 01 00 00       	mov    $0x101,%eax
80101b83:	e8 18 ea ff ff       	call   801005a0 <cgaputc>
}
80101b88:	83 c4 10             	add    $0x10,%esp
80101b8b:	e9 e8 f7 ff ff       	jmp    80101378 <consoleintr+0x28>
  if (select_mode != 2) return;
80101b90:	e8 7b e8 ff ff       	call   80100410 <clear_highlight_from_buffer.part.0>
80101b95:	e9 6c fc ff ff       	jmp    80101806 <consoleintr+0x4b6>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
80101b9a:	89 c7                	mov    %eax,%edi
80101b9c:	c1 ff 1f             	sar    $0x1f,%edi
80101b9f:	c1 ef 19             	shr    $0x19,%edi
80101ba2:	8d 34 38             	lea    (%eax,%edi,1),%esi
80101ba5:	83 e6 7f             	and    $0x7f,%esi
80101ba8:	29 fe                	sub    %edi,%esi
80101baa:	80 be 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%esi)
80101bb1:	0f 85 11 fc ff ff    	jne    801017c8 <consoleintr+0x478>
80101bb7:	e9 12 fc ff ff       	jmp    801017ce <consoleintr+0x47e>
80101bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (select_start > select_end) {
80101bc0:	8b 15 ac ff 10 80    	mov    0x8010ffac,%edx
        select_end = input.e - left_key_pressed_count;
80101bc6:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80101bcb:	2b 05 b0 ff 10 80    	sub    0x8010ffb0,%eax
80101bd1:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        if (select_start > select_end) {
80101bd6:	39 d0                	cmp    %edx,%eax
80101bd8:	7d 0b                	jge    80101be5 <consoleintr+0x895>
          select_start = select_end;
80101bda:	a3 ac ff 10 80       	mov    %eax,0x8010ffac
          select_end = temp; 
80101bdf:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        select_mode = 2;
80101be5:	c7 05 a4 ff 10 80 02 	movl   $0x2,0x8010ffa4
80101bec:	00 00 00 
  if (select_mode != 2) return;
80101bef:	e8 8c e7 ff ff       	call   80100380 <highlight_from_buffer_positions.part.0>
80101bf4:	e9 7f f7 ff ff       	jmp    80101378 <consoleintr+0x28>
   int cursor= input.e-left_key_pressed_count;
80101bf9:	89 c1                	mov    %eax,%ecx
80101bfb:	2b 0d b0 ff 10 80    	sub    0x8010ffb0,%ecx
80101c01:	89 de                	mov    %ebx,%esi
80101c03:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for (int i = input.e; i > cursor; i--)
80101c06:	39 c1                	cmp    %eax,%ecx
80101c08:	7d 38                	jge    80101c42 <consoleintr+0x8f2>
    input.buf[(i) % INPUT_BUF] = input.buf[(i-1) % INPUT_BUF]; // Shift elements to right
80101c0a:	89 c2                	mov    %eax,%edx
80101c0c:	83 e8 01             	sub    $0x1,%eax
80101c0f:	89 c3                	mov    %eax,%ebx
80101c11:	c1 fb 1f             	sar    $0x1f,%ebx
80101c14:	c1 eb 19             	shr    $0x19,%ebx
80101c17:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80101c1a:	83 e1 7f             	and    $0x7f,%ecx
80101c1d:	29 d9                	sub    %ebx,%ecx
80101c1f:	0f b6 99 80 fe 10 80 	movzbl -0x7fef0180(%ecx),%ebx
80101c26:	89 d1                	mov    %edx,%ecx
80101c28:	c1 f9 1f             	sar    $0x1f,%ecx
80101c2b:	c1 e9 19             	shr    $0x19,%ecx
80101c2e:	01 ca                	add    %ecx,%edx
80101c30:	83 e2 7f             	and    $0x7f,%edx
80101c33:	29 ca                	sub    %ecx,%edx
80101c35:	88 9a 80 fe 10 80    	mov    %bl,-0x7fef0180(%edx)
  for (int i = input.e; i > cursor; i--)
80101c3b:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c3e:	75 ca                	jne    80101c0a <consoleintr+0x8ba>
80101c40:	89 f3                	mov    %esi,%ebx
    if (input_sequence.size >= input_sequence.cap) {
80101c42:	8b 0d 00 92 10 80    	mov    0x80109200,%ecx
80101c48:	3b 0d 04 92 10 80    	cmp    0x80109204,%ecx
80101c4e:	7d 17                	jge    80101c67 <consoleintr+0x917>
    input_sequence.data[input_sequence.size++] = value;
80101c50:	8d 41 01             	lea    0x1(%ecx),%eax
          append_sequence((input.e-left_key_pressed_count) % INPUT_BUF);
80101c53:	8b 55 e0             	mov    -0x20(%ebp),%edx
    input_sequence.data[input_sequence.size++] = value;
80101c56:	a3 00 92 10 80       	mov    %eax,0x80109200
          append_sequence((input.e-left_key_pressed_count) % INPUT_BUF);
80101c5b:	83 e2 7f             	and    $0x7f,%edx
80101c5e:	89 14 8d 00 90 10 80 	mov    %edx,-0x7fef7000(,%ecx,4)
    input_sequence.data[input_sequence.size++] = value;
80101c65:	89 c1                	mov    %eax,%ecx
          input.buf[(input.e++-left_key_pressed_count) % INPUT_BUF] = c;
80101c67:	8b 75 e0             	mov    -0x20(%ebp),%esi
          for(int i=0;i<input_sequence.size;i++)
80101c6a:	31 c0                	xor    %eax,%eax
          input.buf[(input.e++-left_key_pressed_count) % INPUT_BUF] = c;
80101c6c:	83 e6 7f             	and    $0x7f,%esi
          for(int i=0;i<input_sequence.size;i++)
80101c6f:	85 c9                	test   %ecx,%ecx
80101c71:	7e 1c                	jle    80101c8f <consoleintr+0x93f>
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
80101c73:	8b 14 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%edx
80101c7a:	39 f2                	cmp    %esi,%edx
80101c7c:	76 0a                	jbe    80101c88 <consoleintr+0x938>
              input_sequence.data[i]++;
80101c7e:	83 c2 01             	add    $0x1,%edx
80101c81:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
          for(int i=0;i<input_sequence.size;i++)
80101c88:	83 c0 01             	add    $0x1,%eax
80101c8b:	39 c8                	cmp    %ecx,%eax
80101c8d:	75 e4                	jne    80101c73 <consoleintr+0x923>
        consputc(c);
80101c8f:	89 d8                	mov    %ebx,%eax
          input.buf[(input.e++-left_key_pressed_count) % INPUT_BUF] = c;
80101c91:	89 3d 08 ff 10 80    	mov    %edi,0x8010ff08
80101c97:	88 9e 80 fe 10 80    	mov    %bl,-0x7fef0180(%esi)
        consputc(c);
80101c9d:	e8 1e ec ff ff       	call   801008c0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80101ca2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80101ca7:	83 e8 80             	sub    $0xffffff80,%eax
80101caa:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
80101cb0:	0f 85 c2 f6 ff ff    	jne    80101378 <consoleintr+0x28>
80101cb6:	e9 64 fd ff ff       	jmp    80101a1f <consoleintr+0x6cf>
80101cbb:	8b 0d 04 ff 10 80    	mov    0x8010ff04,%ecx
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80101cc1:	89 d3                	mov    %edx,%ebx
80101cc3:	e9 6a fe ff ff       	jmp    80101b32 <consoleintr+0x7e2>
  if (select_mode != 2) return;
80101cc8:	e8 43 e7 ff ff       	call   80100410 <clear_highlight_from_buffer.part.0>
          delete_selected_area();
80101ccd:	e8 fe f2 ff ff       	call   80100fd0 <delete_selected_area>
          input.buf[(input.e++) % INPUT_BUF] = c;
80101cd2:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
          select_mode = 0;
80101cd7:	c7 05 a4 ff 10 80 00 	movl   $0x0,0x8010ffa4
80101cde:	00 00 00 
80101ce1:	e9 f5 fc ff ff       	jmp    801019db <consoleintr+0x68b>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101ce6:	83 ec 0c             	sub    $0xc,%esp
80101ce9:	6a 08                	push   $0x8
80101ceb:	e8 c0 52 00 00       	call   80106fb0 <uartputc>
80101cf0:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101cf7:	e8 b4 52 00 00       	call   80106fb0 <uartputc>
80101cfc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101d03:	e8 a8 52 00 00       	call   80106fb0 <uartputc>
  cgaputc(c);
80101d08:	b8 00 01 00 00       	mov    $0x100,%eax
80101d0d:	e8 8e e8 ff ff       	call   801005a0 <cgaputc>
}
80101d12:	83 c4 10             	add    $0x10,%esp
80101d15:	e9 5e f6 ff ff       	jmp    80101378 <consoleintr+0x28>
80101d1a:	bf fe ff ff ff       	mov    $0xfffffffe,%edi
80101d1f:	bb fe ff ff ff       	mov    $0xfffffffe,%ebx
80101d24:	e9 67 f8 ff ff       	jmp    80101590 <consoleintr+0x240>
        input.e--;
80101d29:	8b 35 08 ff 10 80    	mov    0x8010ff08,%esi
80101d2f:	e9 c3 f7 ff ff       	jmp    801014f7 <consoleintr+0x1a7>
80101d34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d3f:	90                   	nop

80101d40 <move_cursor_right>:
void move_cursor_right(void) {
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	bf 0e 00 00 00       	mov    $0xe,%edi
80101d49:	56                   	push   %esi
80101d4a:	89 f8                	mov    %edi,%eax
80101d4c:	53                   	push   %ebx
80101d4d:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80101d52:	89 da                	mov    %ebx,%edx
80101d54:	83 ec 04             	sub    $0x4,%esp
80101d57:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101d58:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80101d5d:	89 ca                	mov    %ecx,%edx
80101d5f:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80101d60:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101d63:	be 0f 00 00 00       	mov    $0xf,%esi
80101d68:	89 da                	mov    %ebx,%edx
80101d6a:	c1 e0 08             	shl    $0x8,%eax
80101d6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101d70:	89 f0                	mov    %esi,%eax
80101d72:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101d73:	89 ca                	mov    %ecx,%edx
80101d75:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80101d76:	0f b6 c0             	movzbl %al,%eax
80101d79:	0b 45 f0             	or     -0x10(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101d7c:	89 da                	mov    %ebx,%edx
    pos++;
80101d7e:	83 c0 01             	add    $0x1,%eax
80101d81:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101d84:	89 f8                	mov    %edi,%eax
80101d86:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80101d87:	8b 7d f0             	mov    -0x10(%ebp),%edi
80101d8a:	89 ca                	mov    %ecx,%edx
80101d8c:	89 f8                	mov    %edi,%eax
80101d8e:	c1 f8 08             	sar    $0x8,%eax
80101d91:	ee                   	out    %al,(%dx)
80101d92:	89 f0                	mov    %esi,%eax
80101d94:	89 da                	mov    %ebx,%edx
80101d96:	ee                   	out    %al,(%dx)
80101d97:	89 f8                	mov    %edi,%eax
80101d99:	89 ca                	mov    %ecx,%edx
80101d9b:	ee                   	out    %al,(%dx)
}
80101d9c:	83 c4 04             	add    $0x4,%esp
80101d9f:	5b                   	pop    %ebx
80101da0:	5e                   	pop    %esi
80101da1:	5f                   	pop    %edi
80101da2:	5d                   	pop    %ebp
80101da3:	c3                   	ret    
80101da4:	66 90                	xchg   %ax,%ax
80101da6:	66 90                	xchg   %ax,%ax
80101da8:	66 90                	xchg   %ax,%ax
80101daa:	66 90                	xchg   %ax,%ax
80101dac:	66 90                	xchg   %ax,%ax
80101dae:	66 90                	xchg   %ax,%ax

80101db0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80101db0:	55                   	push   %ebp
80101db1:	89 e5                	mov    %esp,%ebp
80101db3:	57                   	push   %edi
80101db4:	56                   	push   %esi
80101db5:	53                   	push   %ebx
80101db6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80101dbc:	e8 af 2e 00 00       	call   80104c70 <myproc>
80101dc1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101dc7:	e8 94 22 00 00       	call   80104060 <begin_op>

  if((ip = namei(path)) == 0){
80101dcc:	83 ec 0c             	sub    $0xc,%esp
80101dcf:	ff 75 08             	push   0x8(%ebp)
80101dd2:	e8 c9 15 00 00       	call   801033a0 <namei>
80101dd7:	83 c4 10             	add    $0x10,%esp
80101dda:	85 c0                	test   %eax,%eax
80101ddc:	0f 84 02 03 00 00    	je     801020e4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101de2:	83 ec 0c             	sub    $0xc,%esp
80101de5:	89 c3                	mov    %eax,%ebx
80101de7:	50                   	push   %eax
80101de8:	e8 93 0c 00 00       	call   80102a80 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80101ded:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101df3:	6a 34                	push   $0x34
80101df5:	6a 00                	push   $0x0
80101df7:	50                   	push   %eax
80101df8:	53                   	push   %ebx
80101df9:	e8 92 0f 00 00       	call   80102d90 <readi>
80101dfe:	83 c4 20             	add    $0x20,%esp
80101e01:	83 f8 34             	cmp    $0x34,%eax
80101e04:	74 22                	je     80101e28 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80101e06:	83 ec 0c             	sub    $0xc,%esp
80101e09:	53                   	push   %ebx
80101e0a:	e8 01 0f 00 00       	call   80102d10 <iunlockput>
    end_op();
80101e0f:	e8 bc 22 00 00       	call   801040d0 <end_op>
80101e14:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80101e17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101e1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e1f:	5b                   	pop    %ebx
80101e20:	5e                   	pop    %esi
80101e21:	5f                   	pop    %edi
80101e22:	5d                   	pop    %ebp
80101e23:	c3                   	ret    
80101e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80101e28:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101e2f:	45 4c 46 
80101e32:	75 d2                	jne    80101e06 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80101e34:	e8 07 63 00 00       	call   80108140 <setupkvm>
80101e39:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101e3f:	85 c0                	test   %eax,%eax
80101e41:	74 c3                	je     80101e06 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101e43:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101e4a:	00 
80101e4b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101e51:	0f 84 ac 02 00 00    	je     80102103 <exec+0x353>
  sz = 0;
80101e57:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101e5e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101e61:	31 ff                	xor    %edi,%edi
80101e63:	e9 8e 00 00 00       	jmp    80101ef6 <exec+0x146>
80101e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e6f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80101e70:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101e77:	75 6c                	jne    80101ee5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101e79:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80101e7f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101e85:	0f 82 87 00 00 00    	jb     80101f12 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80101e8b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101e91:	72 7f                	jb     80101f12 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101e93:	83 ec 04             	sub    $0x4,%esp
80101e96:	50                   	push   %eax
80101e97:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80101e9d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101ea3:	e8 b8 60 00 00       	call   80107f60 <allocuvm>
80101ea8:	83 c4 10             	add    $0x10,%esp
80101eab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101eb1:	85 c0                	test   %eax,%eax
80101eb3:	74 5d                	je     80101f12 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80101eb5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80101ebb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101ec0:	75 50                	jne    80101f12 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101ec2:	83 ec 0c             	sub    $0xc,%esp
80101ec5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80101ecb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101ed1:	53                   	push   %ebx
80101ed2:	50                   	push   %eax
80101ed3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101ed9:	e8 92 5f 00 00       	call   80107e70 <loaduvm>
80101ede:	83 c4 20             	add    $0x20,%esp
80101ee1:	85 c0                	test   %eax,%eax
80101ee3:	78 2d                	js     80101f12 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101ee5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80101eec:	83 c7 01             	add    $0x1,%edi
80101eef:	83 c6 20             	add    $0x20,%esi
80101ef2:	39 f8                	cmp    %edi,%eax
80101ef4:	7e 3a                	jle    80101f30 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101ef6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80101efc:	6a 20                	push   $0x20
80101efe:	56                   	push   %esi
80101eff:	50                   	push   %eax
80101f00:	53                   	push   %ebx
80101f01:	e8 8a 0e 00 00       	call   80102d90 <readi>
80101f06:	83 c4 10             	add    $0x10,%esp
80101f09:	83 f8 20             	cmp    $0x20,%eax
80101f0c:	0f 84 5e ff ff ff    	je     80101e70 <exec+0xc0>
    freevm(pgdir);
80101f12:	83 ec 0c             	sub    $0xc,%esp
80101f15:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101f1b:	e8 a0 61 00 00       	call   801080c0 <freevm>
  if(ip){
80101f20:	83 c4 10             	add    $0x10,%esp
80101f23:	e9 de fe ff ff       	jmp    80101e06 <exec+0x56>
80101f28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f2f:	90                   	nop
  sz = PGROUNDUP(sz);
80101f30:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101f36:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80101f3c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101f42:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101f48:	83 ec 0c             	sub    $0xc,%esp
80101f4b:	53                   	push   %ebx
80101f4c:	e8 bf 0d 00 00       	call   80102d10 <iunlockput>
  end_op();
80101f51:	e8 7a 21 00 00       	call   801040d0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101f56:	83 c4 0c             	add    $0xc,%esp
80101f59:	56                   	push   %esi
80101f5a:	57                   	push   %edi
80101f5b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101f61:	57                   	push   %edi
80101f62:	e8 f9 5f 00 00       	call   80107f60 <allocuvm>
80101f67:	83 c4 10             	add    $0x10,%esp
80101f6a:	89 c6                	mov    %eax,%esi
80101f6c:	85 c0                	test   %eax,%eax
80101f6e:	0f 84 94 00 00 00    	je     80102008 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101f74:	83 ec 08             	sub    $0x8,%esp
80101f77:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80101f7d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101f7f:	50                   	push   %eax
80101f80:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101f81:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101f83:	e8 58 62 00 00       	call   801081e0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101f88:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f8b:	83 c4 10             	add    $0x10,%esp
80101f8e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101f94:	8b 00                	mov    (%eax),%eax
80101f96:	85 c0                	test   %eax,%eax
80101f98:	0f 84 8b 00 00 00    	je     80102029 <exec+0x279>
80101f9e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101fa4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80101faa:	eb 23                	jmp    80101fcf <exec+0x21f>
80101fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fb0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80101fb3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80101fba:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80101fbd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101fc3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101fc6:	85 c0                	test   %eax,%eax
80101fc8:	74 59                	je     80102023 <exec+0x273>
    if(argc >= MAXARG)
80101fca:	83 ff 20             	cmp    $0x20,%edi
80101fcd:	74 39                	je     80102008 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101fcf:	83 ec 0c             	sub    $0xc,%esp
80101fd2:	50                   	push   %eax
80101fd3:	e8 88 3b 00 00       	call   80105b60 <strlen>
80101fd8:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101fda:	58                   	pop    %eax
80101fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101fde:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101fe1:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101fe4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101fe7:	e8 74 3b 00 00       	call   80105b60 <strlen>
80101fec:	83 c0 01             	add    $0x1,%eax
80101fef:	50                   	push   %eax
80101ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ff3:	ff 34 b8             	push   (%eax,%edi,4)
80101ff6:	53                   	push   %ebx
80101ff7:	56                   	push   %esi
80101ff8:	e8 b3 63 00 00       	call   801083b0 <copyout>
80101ffd:	83 c4 20             	add    $0x20,%esp
80102000:	85 c0                	test   %eax,%eax
80102002:	79 ac                	jns    80101fb0 <exec+0x200>
80102004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80102008:	83 ec 0c             	sub    $0xc,%esp
8010200b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80102011:	e8 aa 60 00 00       	call   801080c0 <freevm>
80102016:	83 c4 10             	add    $0x10,%esp
  return -1;
80102019:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010201e:	e9 f9 fd ff ff       	jmp    80101e1c <exec+0x6c>
80102023:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80102029:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80102030:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80102032:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80102039:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010203d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
8010203f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80102042:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80102048:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010204a:	50                   	push   %eax
8010204b:	52                   	push   %edx
8010204c:	53                   	push   %ebx
8010204d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80102053:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010205a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010205d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80102063:	e8 48 63 00 00       	call   801083b0 <copyout>
80102068:	83 c4 10             	add    $0x10,%esp
8010206b:	85 c0                	test   %eax,%eax
8010206d:	78 99                	js     80102008 <exec+0x258>
  for(last=s=path; *s; s++)
8010206f:	8b 45 08             	mov    0x8(%ebp),%eax
80102072:	8b 55 08             	mov    0x8(%ebp),%edx
80102075:	0f b6 00             	movzbl (%eax),%eax
80102078:	84 c0                	test   %al,%al
8010207a:	74 13                	je     8010208f <exec+0x2df>
8010207c:	89 d1                	mov    %edx,%ecx
8010207e:	66 90                	xchg   %ax,%ax
      last = s+1;
80102080:	83 c1 01             	add    $0x1,%ecx
80102083:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80102085:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80102088:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010208b:	84 c0                	test   %al,%al
8010208d:	75 f1                	jne    80102080 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010208f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80102095:	83 ec 04             	sub    $0x4,%esp
80102098:	6a 10                	push   $0x10
8010209a:	89 f8                	mov    %edi,%eax
8010209c:	52                   	push   %edx
8010209d:	83 c0 6c             	add    $0x6c,%eax
801020a0:	50                   	push   %eax
801020a1:	e8 7a 3a 00 00       	call   80105b20 <safestrcpy>
  curproc->pgdir = pgdir;
801020a6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
801020ac:	89 f8                	mov    %edi,%eax
801020ae:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
801020b1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
801020b3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
801020b6:	89 c1                	mov    %eax,%ecx
801020b8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
801020be:	8b 40 18             	mov    0x18(%eax),%eax
801020c1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
801020c4:	8b 41 18             	mov    0x18(%ecx),%eax
801020c7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
801020ca:	89 0c 24             	mov    %ecx,(%esp)
801020cd:	e8 0e 5c 00 00       	call   80107ce0 <switchuvm>
  freevm(oldpgdir);
801020d2:	89 3c 24             	mov    %edi,(%esp)
801020d5:	e8 e6 5f 00 00       	call   801080c0 <freevm>
  return 0;
801020da:	83 c4 10             	add    $0x10,%esp
801020dd:	31 c0                	xor    %eax,%eax
801020df:	e9 38 fd ff ff       	jmp    80101e1c <exec+0x6c>
    end_op();
801020e4:	e8 e7 1f 00 00       	call   801040d0 <end_op>
    cprintf("exec: fail\n");
801020e9:	83 ec 0c             	sub    $0xc,%esp
801020ec:	68 fd 85 10 80       	push   $0x801085fd
801020f1:	e8 6a e9 ff ff       	call   80100a60 <cprintf>
    return -1;
801020f6:	83 c4 10             	add    $0x10,%esp
801020f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020fe:	e9 19 fd ff ff       	jmp    80101e1c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80102103:	be 00 20 00 00       	mov    $0x2000,%esi
80102108:	31 ff                	xor    %edi,%edi
8010210a:	e9 39 fe ff ff       	jmp    80101f48 <exec+0x198>
8010210f:	90                   	nop

80102110 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80102110:	55                   	push   %ebp
80102111:	89 e5                	mov    %esp,%ebp
80102113:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80102116:	68 09 86 10 80       	push   $0x80108609
8010211b:	68 00 00 11 80       	push   $0x80110000
80102120:	e8 ab 35 00 00       	call   801056d0 <initlock>
}
80102125:	83 c4 10             	add    $0x10,%esp
80102128:	c9                   	leave  
80102129:	c3                   	ret    
8010212a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102130 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80102134:	bb 34 00 11 80       	mov    $0x80110034,%ebx
{
80102139:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
8010213c:	68 00 00 11 80       	push   $0x80110000
80102141:	e8 5a 37 00 00       	call   801058a0 <acquire>
80102146:	83 c4 10             	add    $0x10,%esp
80102149:	eb 10                	jmp    8010215b <filealloc+0x2b>
8010214b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010214f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80102150:	83 c3 18             	add    $0x18,%ebx
80102153:	81 fb 94 09 11 80    	cmp    $0x80110994,%ebx
80102159:	74 25                	je     80102180 <filealloc+0x50>
    if(f->ref == 0){
8010215b:	8b 43 04             	mov    0x4(%ebx),%eax
8010215e:	85 c0                	test   %eax,%eax
80102160:	75 ee                	jne    80102150 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80102162:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80102165:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010216c:	68 00 00 11 80       	push   $0x80110000
80102171:	e8 ca 36 00 00       	call   80105840 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80102176:	89 d8                	mov    %ebx,%eax
      return f;
80102178:	83 c4 10             	add    $0x10,%esp
}
8010217b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010217e:	c9                   	leave  
8010217f:	c3                   	ret    
  release(&ftable.lock);
80102180:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80102183:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80102185:	68 00 00 11 80       	push   $0x80110000
8010218a:	e8 b1 36 00 00       	call   80105840 <release>
}
8010218f:	89 d8                	mov    %ebx,%eax
  return 0;
80102191:	83 c4 10             	add    $0x10,%esp
}
80102194:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102197:	c9                   	leave  
80102198:	c3                   	ret    
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021a0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801021a0:	55                   	push   %ebp
801021a1:	89 e5                	mov    %esp,%ebp
801021a3:	53                   	push   %ebx
801021a4:	83 ec 10             	sub    $0x10,%esp
801021a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
801021aa:	68 00 00 11 80       	push   $0x80110000
801021af:	e8 ec 36 00 00       	call   801058a0 <acquire>
  if(f->ref < 1)
801021b4:	8b 43 04             	mov    0x4(%ebx),%eax
801021b7:	83 c4 10             	add    $0x10,%esp
801021ba:	85 c0                	test   %eax,%eax
801021bc:	7e 1a                	jle    801021d8 <filedup+0x38>
    panic("filedup");
  f->ref++;
801021be:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
801021c1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
801021c4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
801021c7:	68 00 00 11 80       	push   $0x80110000
801021cc:	e8 6f 36 00 00       	call   80105840 <release>
  return f;
}
801021d1:	89 d8                	mov    %ebx,%eax
801021d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021d6:	c9                   	leave  
801021d7:	c3                   	ret    
    panic("filedup");
801021d8:	83 ec 0c             	sub    $0xc,%esp
801021db:	68 10 86 10 80       	push   $0x80108610
801021e0:	e8 fb ea ff ff       	call   80100ce0 <panic>
801021e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801021f0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	57                   	push   %edi
801021f4:	56                   	push   %esi
801021f5:	53                   	push   %ebx
801021f6:	83 ec 28             	sub    $0x28,%esp
801021f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801021fc:	68 00 00 11 80       	push   $0x80110000
80102201:	e8 9a 36 00 00       	call   801058a0 <acquire>
  if(f->ref < 1)
80102206:	8b 53 04             	mov    0x4(%ebx),%edx
80102209:	83 c4 10             	add    $0x10,%esp
8010220c:	85 d2                	test   %edx,%edx
8010220e:	0f 8e a5 00 00 00    	jle    801022b9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80102214:	83 ea 01             	sub    $0x1,%edx
80102217:	89 53 04             	mov    %edx,0x4(%ebx)
8010221a:	75 44                	jne    80102260 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010221c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80102220:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80102223:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80102225:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010222b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010222e:	88 45 e7             	mov    %al,-0x19(%ebp)
80102231:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80102234:	68 00 00 11 80       	push   $0x80110000
  ff = *f;
80102239:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
8010223c:	e8 ff 35 00 00       	call   80105840 <release>

  if(ff.type == FD_PIPE)
80102241:	83 c4 10             	add    $0x10,%esp
80102244:	83 ff 01             	cmp    $0x1,%edi
80102247:	74 57                	je     801022a0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80102249:	83 ff 02             	cmp    $0x2,%edi
8010224c:	74 2a                	je     80102278 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010224e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102251:	5b                   	pop    %ebx
80102252:	5e                   	pop    %esi
80102253:	5f                   	pop    %edi
80102254:	5d                   	pop    %ebp
80102255:	c3                   	ret    
80102256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010225d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80102260:	c7 45 08 00 00 11 80 	movl   $0x80110000,0x8(%ebp)
}
80102267:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010226a:	5b                   	pop    %ebx
8010226b:	5e                   	pop    %esi
8010226c:	5f                   	pop    %edi
8010226d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010226e:	e9 cd 35 00 00       	jmp    80105840 <release>
80102273:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102277:	90                   	nop
    begin_op();
80102278:	e8 e3 1d 00 00       	call   80104060 <begin_op>
    iput(ff.ip);
8010227d:	83 ec 0c             	sub    $0xc,%esp
80102280:	ff 75 e0             	push   -0x20(%ebp)
80102283:	e8 28 09 00 00       	call   80102bb0 <iput>
    end_op();
80102288:	83 c4 10             	add    $0x10,%esp
}
8010228b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010228e:	5b                   	pop    %ebx
8010228f:	5e                   	pop    %esi
80102290:	5f                   	pop    %edi
80102291:	5d                   	pop    %ebp
    end_op();
80102292:	e9 39 1e 00 00       	jmp    801040d0 <end_op>
80102297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010229e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
801022a0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801022a4:	83 ec 08             	sub    $0x8,%esp
801022a7:	53                   	push   %ebx
801022a8:	56                   	push   %esi
801022a9:	e8 82 25 00 00       	call   80104830 <pipeclose>
801022ae:	83 c4 10             	add    $0x10,%esp
}
801022b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b4:	5b                   	pop    %ebx
801022b5:	5e                   	pop    %esi
801022b6:	5f                   	pop    %edi
801022b7:	5d                   	pop    %ebp
801022b8:	c3                   	ret    
    panic("fileclose");
801022b9:	83 ec 0c             	sub    $0xc,%esp
801022bc:	68 18 86 10 80       	push   $0x80108618
801022c1:	e8 1a ea ff ff       	call   80100ce0 <panic>
801022c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022cd:	8d 76 00             	lea    0x0(%esi),%esi

801022d0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	53                   	push   %ebx
801022d4:	83 ec 04             	sub    $0x4,%esp
801022d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801022da:	83 3b 02             	cmpl   $0x2,(%ebx)
801022dd:	75 31                	jne    80102310 <filestat+0x40>
    ilock(f->ip);
801022df:	83 ec 0c             	sub    $0xc,%esp
801022e2:	ff 73 10             	push   0x10(%ebx)
801022e5:	e8 96 07 00 00       	call   80102a80 <ilock>
    stati(f->ip, st);
801022ea:	58                   	pop    %eax
801022eb:	5a                   	pop    %edx
801022ec:	ff 75 0c             	push   0xc(%ebp)
801022ef:	ff 73 10             	push   0x10(%ebx)
801022f2:	e8 69 0a 00 00       	call   80102d60 <stati>
    iunlock(f->ip);
801022f7:	59                   	pop    %ecx
801022f8:	ff 73 10             	push   0x10(%ebx)
801022fb:	e8 60 08 00 00       	call   80102b60 <iunlock>
    return 0;
  }
  return -1;
}
80102300:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80102303:	83 c4 10             	add    $0x10,%esp
80102306:	31 c0                	xor    %eax,%eax
}
80102308:	c9                   	leave  
80102309:	c3                   	ret    
8010230a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102310:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80102313:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102318:	c9                   	leave  
80102319:	c3                   	ret    
8010231a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102320 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	57                   	push   %edi
80102324:	56                   	push   %esi
80102325:	53                   	push   %ebx
80102326:	83 ec 0c             	sub    $0xc,%esp
80102329:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010232c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010232f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80102332:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80102336:	74 60                	je     80102398 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80102338:	8b 03                	mov    (%ebx),%eax
8010233a:	83 f8 01             	cmp    $0x1,%eax
8010233d:	74 41                	je     80102380 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010233f:	83 f8 02             	cmp    $0x2,%eax
80102342:	75 5b                	jne    8010239f <fileread+0x7f>
    ilock(f->ip);
80102344:	83 ec 0c             	sub    $0xc,%esp
80102347:	ff 73 10             	push   0x10(%ebx)
8010234a:	e8 31 07 00 00       	call   80102a80 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010234f:	57                   	push   %edi
80102350:	ff 73 14             	push   0x14(%ebx)
80102353:	56                   	push   %esi
80102354:	ff 73 10             	push   0x10(%ebx)
80102357:	e8 34 0a 00 00       	call   80102d90 <readi>
8010235c:	83 c4 20             	add    $0x20,%esp
8010235f:	89 c6                	mov    %eax,%esi
80102361:	85 c0                	test   %eax,%eax
80102363:	7e 03                	jle    80102368 <fileread+0x48>
      f->off += r;
80102365:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80102368:	83 ec 0c             	sub    $0xc,%esp
8010236b:	ff 73 10             	push   0x10(%ebx)
8010236e:	e8 ed 07 00 00       	call   80102b60 <iunlock>
    return r;
80102373:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80102376:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102379:	89 f0                	mov    %esi,%eax
8010237b:	5b                   	pop    %ebx
8010237c:	5e                   	pop    %esi
8010237d:	5f                   	pop    %edi
8010237e:	5d                   	pop    %ebp
8010237f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80102380:	8b 43 0c             	mov    0xc(%ebx),%eax
80102383:	89 45 08             	mov    %eax,0x8(%ebp)
}
80102386:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102389:	5b                   	pop    %ebx
8010238a:	5e                   	pop    %esi
8010238b:	5f                   	pop    %edi
8010238c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010238d:	e9 3e 26 00 00       	jmp    801049d0 <piperead>
80102392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80102398:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010239d:	eb d7                	jmp    80102376 <fileread+0x56>
  panic("fileread");
8010239f:	83 ec 0c             	sub    $0xc,%esp
801023a2:	68 22 86 10 80       	push   $0x80108622
801023a7:	e8 34 e9 ff ff       	call   80100ce0 <panic>
801023ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023b0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	57                   	push   %edi
801023b4:	56                   	push   %esi
801023b5:	53                   	push   %ebx
801023b6:	83 ec 1c             	sub    $0x1c,%esp
801023b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801023bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801023bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801023c2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801023c5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801023c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801023cc:	0f 84 bd 00 00 00    	je     8010248f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
801023d2:	8b 03                	mov    (%ebx),%eax
801023d4:	83 f8 01             	cmp    $0x1,%eax
801023d7:	0f 84 bf 00 00 00    	je     8010249c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801023dd:	83 f8 02             	cmp    $0x2,%eax
801023e0:	0f 85 c8 00 00 00    	jne    801024ae <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801023e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801023e9:	31 f6                	xor    %esi,%esi
    while(i < n){
801023eb:	85 c0                	test   %eax,%eax
801023ed:	7f 30                	jg     8010241f <filewrite+0x6f>
801023ef:	e9 94 00 00 00       	jmp    80102488 <filewrite+0xd8>
801023f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801023f8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801023fb:	83 ec 0c             	sub    $0xc,%esp
801023fe:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
80102401:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80102404:	e8 57 07 00 00       	call   80102b60 <iunlock>
      end_op();
80102409:	e8 c2 1c 00 00       	call   801040d0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010240e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102411:	83 c4 10             	add    $0x10,%esp
80102414:	39 c7                	cmp    %eax,%edi
80102416:	75 5c                	jne    80102474 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80102418:	01 fe                	add    %edi,%esi
    while(i < n){
8010241a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010241d:	7e 69                	jle    80102488 <filewrite+0xd8>
      int n1 = n - i;
8010241f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102422:	b8 00 06 00 00       	mov    $0x600,%eax
80102427:	29 f7                	sub    %esi,%edi
80102429:	39 c7                	cmp    %eax,%edi
8010242b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010242e:	e8 2d 1c 00 00       	call   80104060 <begin_op>
      ilock(f->ip);
80102433:	83 ec 0c             	sub    $0xc,%esp
80102436:	ff 73 10             	push   0x10(%ebx)
80102439:	e8 42 06 00 00       	call   80102a80 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010243e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102441:	57                   	push   %edi
80102442:	ff 73 14             	push   0x14(%ebx)
80102445:	01 f0                	add    %esi,%eax
80102447:	50                   	push   %eax
80102448:	ff 73 10             	push   0x10(%ebx)
8010244b:	e8 40 0a 00 00       	call   80102e90 <writei>
80102450:	83 c4 20             	add    $0x20,%esp
80102453:	85 c0                	test   %eax,%eax
80102455:	7f a1                	jg     801023f8 <filewrite+0x48>
      iunlock(f->ip);
80102457:	83 ec 0c             	sub    $0xc,%esp
8010245a:	ff 73 10             	push   0x10(%ebx)
8010245d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102460:	e8 fb 06 00 00       	call   80102b60 <iunlock>
      end_op();
80102465:	e8 66 1c 00 00       	call   801040d0 <end_op>
      if(r < 0)
8010246a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	85 c0                	test   %eax,%eax
80102472:	75 1b                	jne    8010248f <filewrite+0xdf>
        panic("short filewrite");
80102474:	83 ec 0c             	sub    $0xc,%esp
80102477:	68 2b 86 10 80       	push   $0x8010862b
8010247c:	e8 5f e8 ff ff       	call   80100ce0 <panic>
80102481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80102488:	89 f0                	mov    %esi,%eax
8010248a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010248d:	74 05                	je     80102494 <filewrite+0xe4>
8010248f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80102494:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102497:	5b                   	pop    %ebx
80102498:	5e                   	pop    %esi
80102499:	5f                   	pop    %edi
8010249a:	5d                   	pop    %ebp
8010249b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010249c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010249f:	89 45 08             	mov    %eax,0x8(%ebp)
}
801024a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024a5:	5b                   	pop    %ebx
801024a6:	5e                   	pop    %esi
801024a7:	5f                   	pop    %edi
801024a8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801024a9:	e9 22 24 00 00       	jmp    801048d0 <pipewrite>
  panic("filewrite");
801024ae:	83 ec 0c             	sub    $0xc,%esp
801024b1:	68 31 86 10 80       	push   $0x80108631
801024b6:	e8 25 e8 ff ff       	call   80100ce0 <panic>
801024bb:	66 90                	xchg   %ax,%ax
801024bd:	66 90                	xchg   %ax,%ax
801024bf:	90                   	nop

801024c0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801024c0:	55                   	push   %ebp
801024c1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801024c3:	89 d0                	mov    %edx,%eax
801024c5:	c1 e8 0c             	shr    $0xc,%eax
801024c8:	03 05 6c 26 11 80    	add    0x8011266c,%eax
{
801024ce:	89 e5                	mov    %esp,%ebp
801024d0:	56                   	push   %esi
801024d1:	53                   	push   %ebx
801024d2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801024d4:	83 ec 08             	sub    $0x8,%esp
801024d7:	50                   	push   %eax
801024d8:	51                   	push   %ecx
801024d9:	e8 f2 db ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801024de:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801024e0:	c1 fb 03             	sar    $0x3,%ebx
801024e3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801024e6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801024e8:	83 e1 07             	and    $0x7,%ecx
801024eb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801024f0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801024f6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801024f8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801024fd:	85 c1                	test   %eax,%ecx
801024ff:	74 23                	je     80102524 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80102501:	f7 d0                	not    %eax
  log_write(bp);
80102503:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80102506:	21 c8                	and    %ecx,%eax
80102508:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010250c:	56                   	push   %esi
8010250d:	e8 2e 1d 00 00       	call   80104240 <log_write>
  brelse(bp);
80102512:	89 34 24             	mov    %esi,(%esp)
80102515:	e8 d6 dc ff ff       	call   801001f0 <brelse>
}
8010251a:	83 c4 10             	add    $0x10,%esp
8010251d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102520:	5b                   	pop    %ebx
80102521:	5e                   	pop    %esi
80102522:	5d                   	pop    %ebp
80102523:	c3                   	ret    
    panic("freeing free block");
80102524:	83 ec 0c             	sub    $0xc,%esp
80102527:	68 3b 86 10 80       	push   $0x8010863b
8010252c:	e8 af e7 ff ff       	call   80100ce0 <panic>
80102531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010253f:	90                   	nop

80102540 <balloc>:
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	57                   	push   %edi
80102544:	56                   	push   %esi
80102545:	53                   	push   %ebx
80102546:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80102549:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
{
8010254f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80102552:	85 c9                	test   %ecx,%ecx
80102554:	0f 84 87 00 00 00    	je     801025e1 <balloc+0xa1>
8010255a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80102561:	8b 75 dc             	mov    -0x24(%ebp),%esi
80102564:	83 ec 08             	sub    $0x8,%esp
80102567:	89 f0                	mov    %esi,%eax
80102569:	c1 f8 0c             	sar    $0xc,%eax
8010256c:	03 05 6c 26 11 80    	add    0x8011266c,%eax
80102572:	50                   	push   %eax
80102573:	ff 75 d8             	push   -0x28(%ebp)
80102576:	e8 55 db ff ff       	call   801000d0 <bread>
8010257b:	83 c4 10             	add    $0x10,%esp
8010257e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80102581:	a1 54 26 11 80       	mov    0x80112654,%eax
80102586:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102589:	31 c0                	xor    %eax,%eax
8010258b:	eb 2f                	jmp    801025bc <balloc+0x7c>
8010258d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80102590:	89 c1                	mov    %eax,%ecx
80102592:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80102597:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010259a:	83 e1 07             	and    $0x7,%ecx
8010259d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010259f:	89 c1                	mov    %eax,%ecx
801025a1:	c1 f9 03             	sar    $0x3,%ecx
801025a4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801025a9:	89 fa                	mov    %edi,%edx
801025ab:	85 df                	test   %ebx,%edi
801025ad:	74 41                	je     801025f0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801025af:	83 c0 01             	add    $0x1,%eax
801025b2:	83 c6 01             	add    $0x1,%esi
801025b5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801025ba:	74 05                	je     801025c1 <balloc+0x81>
801025bc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801025bf:	77 cf                	ja     80102590 <balloc+0x50>
    brelse(bp);
801025c1:	83 ec 0c             	sub    $0xc,%esp
801025c4:	ff 75 e4             	push   -0x1c(%ebp)
801025c7:	e8 24 dc ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801025cc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801025d3:	83 c4 10             	add    $0x10,%esp
801025d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801025d9:	39 05 54 26 11 80    	cmp    %eax,0x80112654
801025df:	77 80                	ja     80102561 <balloc+0x21>
  panic("balloc: out of blocks");
801025e1:	83 ec 0c             	sub    $0xc,%esp
801025e4:	68 4e 86 10 80       	push   $0x8010864e
801025e9:	e8 f2 e6 ff ff       	call   80100ce0 <panic>
801025ee:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801025f0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801025f3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801025f6:	09 da                	or     %ebx,%edx
801025f8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801025fc:	57                   	push   %edi
801025fd:	e8 3e 1c 00 00       	call   80104240 <log_write>
        brelse(bp);
80102602:	89 3c 24             	mov    %edi,(%esp)
80102605:	e8 e6 db ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010260a:	58                   	pop    %eax
8010260b:	5a                   	pop    %edx
8010260c:	56                   	push   %esi
8010260d:	ff 75 d8             	push   -0x28(%ebp)
80102610:	e8 bb da ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80102615:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80102618:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010261a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010261d:	68 00 02 00 00       	push   $0x200
80102622:	6a 00                	push   $0x0
80102624:	50                   	push   %eax
80102625:	e8 36 33 00 00       	call   80105960 <memset>
  log_write(bp);
8010262a:	89 1c 24             	mov    %ebx,(%esp)
8010262d:	e8 0e 1c 00 00       	call   80104240 <log_write>
  brelse(bp);
80102632:	89 1c 24             	mov    %ebx,(%esp)
80102635:	e8 b6 db ff ff       	call   801001f0 <brelse>
}
8010263a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010263d:	89 f0                	mov    %esi,%eax
8010263f:	5b                   	pop    %ebx
80102640:	5e                   	pop    %esi
80102641:	5f                   	pop    %edi
80102642:	5d                   	pop    %ebp
80102643:	c3                   	ret    
80102644:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010264b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010264f:	90                   	nop

80102650 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
80102653:	57                   	push   %edi
80102654:	89 c7                	mov    %eax,%edi
80102656:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80102657:	31 f6                	xor    %esi,%esi
{
80102659:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010265a:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
{
8010265f:	83 ec 28             	sub    $0x28,%esp
80102662:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80102665:	68 00 0a 11 80       	push   $0x80110a00
8010266a:	e8 31 32 00 00       	call   801058a0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010266f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80102672:	83 c4 10             	add    $0x10,%esp
80102675:	eb 1b                	jmp    80102692 <iget+0x42>
80102677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010267e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102680:	39 3b                	cmp    %edi,(%ebx)
80102682:	74 6c                	je     801026f0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102684:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010268a:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80102690:	73 26                	jae    801026b8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102692:	8b 43 08             	mov    0x8(%ebx),%eax
80102695:	85 c0                	test   %eax,%eax
80102697:	7f e7                	jg     80102680 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102699:	85 f6                	test   %esi,%esi
8010269b:	75 e7                	jne    80102684 <iget+0x34>
8010269d:	85 c0                	test   %eax,%eax
8010269f:	75 76                	jne    80102717 <iget+0xc7>
801026a1:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801026a3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801026a9:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801026af:	72 e1                	jb     80102692 <iget+0x42>
801026b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801026b8:	85 f6                	test   %esi,%esi
801026ba:	74 79                	je     80102735 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801026bc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801026bf:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801026c1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801026c4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801026cb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801026d2:	68 00 0a 11 80       	push   $0x80110a00
801026d7:	e8 64 31 00 00       	call   80105840 <release>

  return ip;
801026dc:	83 c4 10             	add    $0x10,%esp
}
801026df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026e2:	89 f0                	mov    %esi,%eax
801026e4:	5b                   	pop    %ebx
801026e5:	5e                   	pop    %esi
801026e6:	5f                   	pop    %edi
801026e7:	5d                   	pop    %ebp
801026e8:	c3                   	ret    
801026e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801026f0:	39 53 04             	cmp    %edx,0x4(%ebx)
801026f3:	75 8f                	jne    80102684 <iget+0x34>
      release(&icache.lock);
801026f5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801026f8:	83 c0 01             	add    $0x1,%eax
      return ip;
801026fb:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801026fd:	68 00 0a 11 80       	push   $0x80110a00
      ip->ref++;
80102702:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80102705:	e8 36 31 00 00       	call   80105840 <release>
      return ip;
8010270a:	83 c4 10             	add    $0x10,%esp
}
8010270d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102710:	89 f0                	mov    %esi,%eax
80102712:	5b                   	pop    %ebx
80102713:	5e                   	pop    %esi
80102714:	5f                   	pop    %edi
80102715:	5d                   	pop    %ebp
80102716:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102717:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010271d:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80102723:	73 10                	jae    80102735 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102725:	8b 43 08             	mov    0x8(%ebx),%eax
80102728:	85 c0                	test   %eax,%eax
8010272a:	0f 8f 50 ff ff ff    	jg     80102680 <iget+0x30>
80102730:	e9 68 ff ff ff       	jmp    8010269d <iget+0x4d>
    panic("iget: no inodes");
80102735:	83 ec 0c             	sub    $0xc,%esp
80102738:	68 64 86 10 80       	push   $0x80108664
8010273d:	e8 9e e5 ff ff       	call   80100ce0 <panic>
80102742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102750 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102750:	55                   	push   %ebp
80102751:	89 e5                	mov    %esp,%ebp
80102753:	57                   	push   %edi
80102754:	56                   	push   %esi
80102755:	89 c6                	mov    %eax,%esi
80102757:	53                   	push   %ebx
80102758:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010275b:	83 fa 0b             	cmp    $0xb,%edx
8010275e:	0f 86 8c 00 00 00    	jbe    801027f0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80102764:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80102767:	83 fb 7f             	cmp    $0x7f,%ebx
8010276a:	0f 87 a2 00 00 00    	ja     80102812 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80102770:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102776:	85 c0                	test   %eax,%eax
80102778:	74 5e                	je     801027d8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010277a:	83 ec 08             	sub    $0x8,%esp
8010277d:	50                   	push   %eax
8010277e:	ff 36                	push   (%esi)
80102780:	e8 4b d9 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80102785:	83 c4 10             	add    $0x10,%esp
80102788:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010278c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010278e:	8b 3b                	mov    (%ebx),%edi
80102790:	85 ff                	test   %edi,%edi
80102792:	74 1c                	je     801027b0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80102794:	83 ec 0c             	sub    $0xc,%esp
80102797:	52                   	push   %edx
80102798:	e8 53 da ff ff       	call   801001f0 <brelse>
8010279d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801027a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027a3:	89 f8                	mov    %edi,%eax
801027a5:	5b                   	pop    %ebx
801027a6:	5e                   	pop    %esi
801027a7:	5f                   	pop    %edi
801027a8:	5d                   	pop    %ebp
801027a9:	c3                   	ret    
801027aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801027b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801027b3:	8b 06                	mov    (%esi),%eax
801027b5:	e8 86 fd ff ff       	call   80102540 <balloc>
      log_write(bp);
801027ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801027bd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801027c0:	89 03                	mov    %eax,(%ebx)
801027c2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801027c4:	52                   	push   %edx
801027c5:	e8 76 1a 00 00       	call   80104240 <log_write>
801027ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801027cd:	83 c4 10             	add    $0x10,%esp
801027d0:	eb c2                	jmp    80102794 <bmap+0x44>
801027d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801027d8:	8b 06                	mov    (%esi),%eax
801027da:	e8 61 fd ff ff       	call   80102540 <balloc>
801027df:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801027e5:	eb 93                	jmp    8010277a <bmap+0x2a>
801027e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ee:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
801027f0:	8d 5a 14             	lea    0x14(%edx),%ebx
801027f3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801027f7:	85 ff                	test   %edi,%edi
801027f9:	75 a5                	jne    801027a0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801027fb:	8b 00                	mov    (%eax),%eax
801027fd:	e8 3e fd ff ff       	call   80102540 <balloc>
80102802:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102806:	89 c7                	mov    %eax,%edi
}
80102808:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010280b:	5b                   	pop    %ebx
8010280c:	89 f8                	mov    %edi,%eax
8010280e:	5e                   	pop    %esi
8010280f:	5f                   	pop    %edi
80102810:	5d                   	pop    %ebp
80102811:	c3                   	ret    
  panic("bmap: out of range");
80102812:	83 ec 0c             	sub    $0xc,%esp
80102815:	68 74 86 10 80       	push   $0x80108674
8010281a:	e8 c1 e4 ff ff       	call   80100ce0 <panic>
8010281f:	90                   	nop

80102820 <readsb>:
{
80102820:	55                   	push   %ebp
80102821:	89 e5                	mov    %esp,%ebp
80102823:	56                   	push   %esi
80102824:	53                   	push   %ebx
80102825:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102828:	83 ec 08             	sub    $0x8,%esp
8010282b:	6a 01                	push   $0x1
8010282d:	ff 75 08             	push   0x8(%ebp)
80102830:	e8 9b d8 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102835:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102838:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010283a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010283d:	6a 1c                	push   $0x1c
8010283f:	50                   	push   %eax
80102840:	56                   	push   %esi
80102841:	e8 ba 31 00 00       	call   80105a00 <memmove>
  brelse(bp);
80102846:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102849:	83 c4 10             	add    $0x10,%esp
}
8010284c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010284f:	5b                   	pop    %ebx
80102850:	5e                   	pop    %esi
80102851:	5d                   	pop    %ebp
  brelse(bp);
80102852:	e9 99 d9 ff ff       	jmp    801001f0 <brelse>
80102857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010285e:	66 90                	xchg   %ax,%ax

80102860 <iinit>:
{
80102860:	55                   	push   %ebp
80102861:	89 e5                	mov    %esp,%ebp
80102863:	53                   	push   %ebx
80102864:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80102869:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010286c:	68 87 86 10 80       	push   $0x80108687
80102871:	68 00 0a 11 80       	push   $0x80110a00
80102876:	e8 55 2e 00 00       	call   801056d0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010287b:	83 c4 10             	add    $0x10,%esp
8010287e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80102880:	83 ec 08             	sub    $0x8,%esp
80102883:	68 8e 86 10 80       	push   $0x8010868e
80102888:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80102889:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010288f:	e8 0c 2d 00 00       	call   801055a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80102894:	83 c4 10             	add    $0x10,%esp
80102897:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
8010289d:	75 e1                	jne    80102880 <iinit+0x20>
  bp = bread(dev, 1);
8010289f:	83 ec 08             	sub    $0x8,%esp
801028a2:	6a 01                	push   $0x1
801028a4:	ff 75 08             	push   0x8(%ebp)
801028a7:	e8 24 d8 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801028ac:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801028af:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801028b1:	8d 40 5c             	lea    0x5c(%eax),%eax
801028b4:	6a 1c                	push   $0x1c
801028b6:	50                   	push   %eax
801028b7:	68 54 26 11 80       	push   $0x80112654
801028bc:	e8 3f 31 00 00       	call   80105a00 <memmove>
  brelse(bp);
801028c1:	89 1c 24             	mov    %ebx,(%esp)
801028c4:	e8 27 d9 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801028c9:	ff 35 6c 26 11 80    	push   0x8011266c
801028cf:	ff 35 68 26 11 80    	push   0x80112668
801028d5:	ff 35 64 26 11 80    	push   0x80112664
801028db:	ff 35 60 26 11 80    	push   0x80112660
801028e1:	ff 35 5c 26 11 80    	push   0x8011265c
801028e7:	ff 35 58 26 11 80    	push   0x80112658
801028ed:	ff 35 54 26 11 80    	push   0x80112654
801028f3:	68 f4 86 10 80       	push   $0x801086f4
801028f8:	e8 63 e1 ff ff       	call   80100a60 <cprintf>
}
801028fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102900:	83 c4 30             	add    $0x30,%esp
80102903:	c9                   	leave  
80102904:	c3                   	ret    
80102905:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102910 <ialloc>:
{
80102910:	55                   	push   %ebp
80102911:	89 e5                	mov    %esp,%ebp
80102913:	57                   	push   %edi
80102914:	56                   	push   %esi
80102915:	53                   	push   %ebx
80102916:	83 ec 1c             	sub    $0x1c,%esp
80102919:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010291c:	83 3d 5c 26 11 80 01 	cmpl   $0x1,0x8011265c
{
80102923:	8b 75 08             	mov    0x8(%ebp),%esi
80102926:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102929:	0f 86 91 00 00 00    	jbe    801029c0 <ialloc+0xb0>
8010292f:	bf 01 00 00 00       	mov    $0x1,%edi
80102934:	eb 21                	jmp    80102957 <ialloc+0x47>
80102936:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010293d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80102940:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102943:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102946:	53                   	push   %ebx
80102947:	e8 a4 d8 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010294c:	83 c4 10             	add    $0x10,%esp
8010294f:	3b 3d 5c 26 11 80    	cmp    0x8011265c,%edi
80102955:	73 69                	jae    801029c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102957:	89 f8                	mov    %edi,%eax
80102959:	83 ec 08             	sub    $0x8,%esp
8010295c:	c1 e8 03             	shr    $0x3,%eax
8010295f:	03 05 68 26 11 80    	add    0x80112668,%eax
80102965:	50                   	push   %eax
80102966:	56                   	push   %esi
80102967:	e8 64 d7 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010296c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010296f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80102971:	89 f8                	mov    %edi,%eax
80102973:	83 e0 07             	and    $0x7,%eax
80102976:	c1 e0 06             	shl    $0x6,%eax
80102979:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010297d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80102981:	75 bd                	jne    80102940 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80102983:	83 ec 04             	sub    $0x4,%esp
80102986:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102989:	6a 40                	push   $0x40
8010298b:	6a 00                	push   $0x0
8010298d:	51                   	push   %ecx
8010298e:	e8 cd 2f 00 00       	call   80105960 <memset>
      dip->type = type;
80102993:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80102997:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010299a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010299d:	89 1c 24             	mov    %ebx,(%esp)
801029a0:	e8 9b 18 00 00       	call   80104240 <log_write>
      brelse(bp);
801029a5:	89 1c 24             	mov    %ebx,(%esp)
801029a8:	e8 43 d8 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801029ad:	83 c4 10             	add    $0x10,%esp
}
801029b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801029b3:	89 fa                	mov    %edi,%edx
}
801029b5:	5b                   	pop    %ebx
      return iget(dev, inum);
801029b6:	89 f0                	mov    %esi,%eax
}
801029b8:	5e                   	pop    %esi
801029b9:	5f                   	pop    %edi
801029ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801029bb:	e9 90 fc ff ff       	jmp    80102650 <iget>
  panic("ialloc: no inodes");
801029c0:	83 ec 0c             	sub    $0xc,%esp
801029c3:	68 94 86 10 80       	push   $0x80108694
801029c8:	e8 13 e3 ff ff       	call   80100ce0 <panic>
801029cd:	8d 76 00             	lea    0x0(%esi),%esi

801029d0 <iupdate>:
{
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	56                   	push   %esi
801029d4:	53                   	push   %ebx
801029d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801029d8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801029db:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801029de:	83 ec 08             	sub    $0x8,%esp
801029e1:	c1 e8 03             	shr    $0x3,%eax
801029e4:	03 05 68 26 11 80    	add    0x80112668,%eax
801029ea:	50                   	push   %eax
801029eb:	ff 73 a4             	push   -0x5c(%ebx)
801029ee:	e8 dd d6 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801029f3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801029f7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801029fa:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801029fc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801029ff:	83 e0 07             	and    $0x7,%eax
80102a02:	c1 e0 06             	shl    $0x6,%eax
80102a05:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80102a09:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80102a0c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102a10:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102a13:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80102a17:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80102a1b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80102a1f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102a23:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102a27:	8b 53 fc             	mov    -0x4(%ebx),%edx
80102a2a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102a2d:	6a 34                	push   $0x34
80102a2f:	53                   	push   %ebx
80102a30:	50                   	push   %eax
80102a31:	e8 ca 2f 00 00       	call   80105a00 <memmove>
  log_write(bp);
80102a36:	89 34 24             	mov    %esi,(%esp)
80102a39:	e8 02 18 00 00       	call   80104240 <log_write>
  brelse(bp);
80102a3e:	89 75 08             	mov    %esi,0x8(%ebp)
80102a41:	83 c4 10             	add    $0x10,%esp
}
80102a44:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a47:	5b                   	pop    %ebx
80102a48:	5e                   	pop    %esi
80102a49:	5d                   	pop    %ebp
  brelse(bp);
80102a4a:	e9 a1 d7 ff ff       	jmp    801001f0 <brelse>
80102a4f:	90                   	nop

80102a50 <idup>:
{
80102a50:	55                   	push   %ebp
80102a51:	89 e5                	mov    %esp,%ebp
80102a53:	53                   	push   %ebx
80102a54:	83 ec 10             	sub    $0x10,%esp
80102a57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80102a5a:	68 00 0a 11 80       	push   $0x80110a00
80102a5f:	e8 3c 2e 00 00       	call   801058a0 <acquire>
  ip->ref++;
80102a64:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102a68:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80102a6f:	e8 cc 2d 00 00       	call   80105840 <release>
}
80102a74:	89 d8                	mov    %ebx,%eax
80102a76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a79:	c9                   	leave  
80102a7a:	c3                   	ret    
80102a7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a7f:	90                   	nop

80102a80 <ilock>:
{
80102a80:	55                   	push   %ebp
80102a81:	89 e5                	mov    %esp,%ebp
80102a83:	56                   	push   %esi
80102a84:	53                   	push   %ebx
80102a85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80102a88:	85 db                	test   %ebx,%ebx
80102a8a:	0f 84 b7 00 00 00    	je     80102b47 <ilock+0xc7>
80102a90:	8b 53 08             	mov    0x8(%ebx),%edx
80102a93:	85 d2                	test   %edx,%edx
80102a95:	0f 8e ac 00 00 00    	jle    80102b47 <ilock+0xc7>
  acquiresleep(&ip->lock);
80102a9b:	83 ec 0c             	sub    $0xc,%esp
80102a9e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102aa1:	50                   	push   %eax
80102aa2:	e8 39 2b 00 00       	call   801055e0 <acquiresleep>
  if(ip->valid == 0){
80102aa7:	8b 43 4c             	mov    0x4c(%ebx),%eax
80102aaa:	83 c4 10             	add    $0x10,%esp
80102aad:	85 c0                	test   %eax,%eax
80102aaf:	74 0f                	je     80102ac0 <ilock+0x40>
}
80102ab1:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ab4:	5b                   	pop    %ebx
80102ab5:	5e                   	pop    %esi
80102ab6:	5d                   	pop    %ebp
80102ab7:	c3                   	ret    
80102ab8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102abf:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102ac0:	8b 43 04             	mov    0x4(%ebx),%eax
80102ac3:	83 ec 08             	sub    $0x8,%esp
80102ac6:	c1 e8 03             	shr    $0x3,%eax
80102ac9:	03 05 68 26 11 80    	add    0x80112668,%eax
80102acf:	50                   	push   %eax
80102ad0:	ff 33                	push   (%ebx)
80102ad2:	e8 f9 d5 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102ad7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102ada:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80102adc:	8b 43 04             	mov    0x4(%ebx),%eax
80102adf:	83 e0 07             	and    $0x7,%eax
80102ae2:	c1 e0 06             	shl    $0x6,%eax
80102ae5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102ae9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102aec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80102aef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80102af3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102af7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80102afb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80102aff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80102b03:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102b07:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80102b0b:	8b 50 fc             	mov    -0x4(%eax),%edx
80102b0e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102b11:	6a 34                	push   $0x34
80102b13:	50                   	push   %eax
80102b14:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102b17:	50                   	push   %eax
80102b18:	e8 e3 2e 00 00       	call   80105a00 <memmove>
    brelse(bp);
80102b1d:	89 34 24             	mov    %esi,(%esp)
80102b20:	e8 cb d6 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102b25:	83 c4 10             	add    $0x10,%esp
80102b28:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80102b2d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102b34:	0f 85 77 ff ff ff    	jne    80102ab1 <ilock+0x31>
      panic("ilock: no type");
80102b3a:	83 ec 0c             	sub    $0xc,%esp
80102b3d:	68 ac 86 10 80       	push   $0x801086ac
80102b42:	e8 99 e1 ff ff       	call   80100ce0 <panic>
    panic("ilock");
80102b47:	83 ec 0c             	sub    $0xc,%esp
80102b4a:	68 a6 86 10 80       	push   $0x801086a6
80102b4f:	e8 8c e1 ff ff       	call   80100ce0 <panic>
80102b54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b5f:	90                   	nop

80102b60 <iunlock>:
{
80102b60:	55                   	push   %ebp
80102b61:	89 e5                	mov    %esp,%ebp
80102b63:	56                   	push   %esi
80102b64:	53                   	push   %ebx
80102b65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102b68:	85 db                	test   %ebx,%ebx
80102b6a:	74 28                	je     80102b94 <iunlock+0x34>
80102b6c:	83 ec 0c             	sub    $0xc,%esp
80102b6f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102b72:	56                   	push   %esi
80102b73:	e8 08 2b 00 00       	call   80105680 <holdingsleep>
80102b78:	83 c4 10             	add    $0x10,%esp
80102b7b:	85 c0                	test   %eax,%eax
80102b7d:	74 15                	je     80102b94 <iunlock+0x34>
80102b7f:	8b 43 08             	mov    0x8(%ebx),%eax
80102b82:	85 c0                	test   %eax,%eax
80102b84:	7e 0e                	jle    80102b94 <iunlock+0x34>
  releasesleep(&ip->lock);
80102b86:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102b89:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b8c:	5b                   	pop    %ebx
80102b8d:	5e                   	pop    %esi
80102b8e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80102b8f:	e9 ac 2a 00 00       	jmp    80105640 <releasesleep>
    panic("iunlock");
80102b94:	83 ec 0c             	sub    $0xc,%esp
80102b97:	68 bb 86 10 80       	push   $0x801086bb
80102b9c:	e8 3f e1 ff ff       	call   80100ce0 <panic>
80102ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ba8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102baf:	90                   	nop

80102bb0 <iput>:
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	57                   	push   %edi
80102bb4:	56                   	push   %esi
80102bb5:	53                   	push   %ebx
80102bb6:	83 ec 28             	sub    $0x28,%esp
80102bb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80102bbc:	8d 7b 0c             	lea    0xc(%ebx),%edi
80102bbf:	57                   	push   %edi
80102bc0:	e8 1b 2a 00 00       	call   801055e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80102bc5:	8b 53 4c             	mov    0x4c(%ebx),%edx
80102bc8:	83 c4 10             	add    $0x10,%esp
80102bcb:	85 d2                	test   %edx,%edx
80102bcd:	74 07                	je     80102bd6 <iput+0x26>
80102bcf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102bd4:	74 32                	je     80102c08 <iput+0x58>
  releasesleep(&ip->lock);
80102bd6:	83 ec 0c             	sub    $0xc,%esp
80102bd9:	57                   	push   %edi
80102bda:	e8 61 2a 00 00       	call   80105640 <releasesleep>
  acquire(&icache.lock);
80102bdf:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80102be6:	e8 b5 2c 00 00       	call   801058a0 <acquire>
  ip->ref--;
80102beb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102bef:	83 c4 10             	add    $0x10,%esp
80102bf2:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
80102bf9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bfc:	5b                   	pop    %ebx
80102bfd:	5e                   	pop    %esi
80102bfe:	5f                   	pop    %edi
80102bff:	5d                   	pop    %ebp
  release(&icache.lock);
80102c00:	e9 3b 2c 00 00       	jmp    80105840 <release>
80102c05:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102c08:	83 ec 0c             	sub    $0xc,%esp
80102c0b:	68 00 0a 11 80       	push   $0x80110a00
80102c10:	e8 8b 2c 00 00       	call   801058a0 <acquire>
    int r = ip->ref;
80102c15:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102c18:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80102c1f:	e8 1c 2c 00 00       	call   80105840 <release>
    if(r == 1){
80102c24:	83 c4 10             	add    $0x10,%esp
80102c27:	83 fe 01             	cmp    $0x1,%esi
80102c2a:	75 aa                	jne    80102bd6 <iput+0x26>
80102c2c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102c32:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102c35:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102c38:	89 cf                	mov    %ecx,%edi
80102c3a:	eb 0b                	jmp    80102c47 <iput+0x97>
80102c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102c40:	83 c6 04             	add    $0x4,%esi
80102c43:	39 fe                	cmp    %edi,%esi
80102c45:	74 19                	je     80102c60 <iput+0xb0>
    if(ip->addrs[i]){
80102c47:	8b 16                	mov    (%esi),%edx
80102c49:	85 d2                	test   %edx,%edx
80102c4b:	74 f3                	je     80102c40 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80102c4d:	8b 03                	mov    (%ebx),%eax
80102c4f:	e8 6c f8 ff ff       	call   801024c0 <bfree>
      ip->addrs[i] = 0;
80102c54:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80102c5a:	eb e4                	jmp    80102c40 <iput+0x90>
80102c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102c60:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80102c66:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102c69:	85 c0                	test   %eax,%eax
80102c6b:	75 2d                	jne    80102c9a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80102c6d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80102c70:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80102c77:	53                   	push   %ebx
80102c78:	e8 53 fd ff ff       	call   801029d0 <iupdate>
      ip->type = 0;
80102c7d:	31 c0                	xor    %eax,%eax
80102c7f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80102c83:	89 1c 24             	mov    %ebx,(%esp)
80102c86:	e8 45 fd ff ff       	call   801029d0 <iupdate>
      ip->valid = 0;
80102c8b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80102c92:	83 c4 10             	add    $0x10,%esp
80102c95:	e9 3c ff ff ff       	jmp    80102bd6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80102c9a:	83 ec 08             	sub    $0x8,%esp
80102c9d:	50                   	push   %eax
80102c9e:	ff 33                	push   (%ebx)
80102ca0:	e8 2b d4 ff ff       	call   801000d0 <bread>
80102ca5:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102ca8:	83 c4 10             	add    $0x10,%esp
80102cab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102cb1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80102cb4:	8d 70 5c             	lea    0x5c(%eax),%esi
80102cb7:	89 cf                	mov    %ecx,%edi
80102cb9:	eb 0c                	jmp    80102cc7 <iput+0x117>
80102cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cbf:	90                   	nop
80102cc0:	83 c6 04             	add    $0x4,%esi
80102cc3:	39 f7                	cmp    %esi,%edi
80102cc5:	74 0f                	je     80102cd6 <iput+0x126>
      if(a[j])
80102cc7:	8b 16                	mov    (%esi),%edx
80102cc9:	85 d2                	test   %edx,%edx
80102ccb:	74 f3                	je     80102cc0 <iput+0x110>
        bfree(ip->dev, a[j]);
80102ccd:	8b 03                	mov    (%ebx),%eax
80102ccf:	e8 ec f7 ff ff       	call   801024c0 <bfree>
80102cd4:	eb ea                	jmp    80102cc0 <iput+0x110>
    brelse(bp);
80102cd6:	83 ec 0c             	sub    $0xc,%esp
80102cd9:	ff 75 e4             	push   -0x1c(%ebp)
80102cdc:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102cdf:	e8 0c d5 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102ce4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80102cea:	8b 03                	mov    (%ebx),%eax
80102cec:	e8 cf f7 ff ff       	call   801024c0 <bfree>
    ip->addrs[NDIRECT] = 0;
80102cf1:	83 c4 10             	add    $0x10,%esp
80102cf4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80102cfb:	00 00 00 
80102cfe:	e9 6a ff ff ff       	jmp    80102c6d <iput+0xbd>
80102d03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102d10 <iunlockput>:
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	56                   	push   %esi
80102d14:	53                   	push   %ebx
80102d15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102d18:	85 db                	test   %ebx,%ebx
80102d1a:	74 34                	je     80102d50 <iunlockput+0x40>
80102d1c:	83 ec 0c             	sub    $0xc,%esp
80102d1f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102d22:	56                   	push   %esi
80102d23:	e8 58 29 00 00       	call   80105680 <holdingsleep>
80102d28:	83 c4 10             	add    $0x10,%esp
80102d2b:	85 c0                	test   %eax,%eax
80102d2d:	74 21                	je     80102d50 <iunlockput+0x40>
80102d2f:	8b 43 08             	mov    0x8(%ebx),%eax
80102d32:	85 c0                	test   %eax,%eax
80102d34:	7e 1a                	jle    80102d50 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102d36:	83 ec 0c             	sub    $0xc,%esp
80102d39:	56                   	push   %esi
80102d3a:	e8 01 29 00 00       	call   80105640 <releasesleep>
  iput(ip);
80102d3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102d42:	83 c4 10             	add    $0x10,%esp
}
80102d45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102d48:	5b                   	pop    %ebx
80102d49:	5e                   	pop    %esi
80102d4a:	5d                   	pop    %ebp
  iput(ip);
80102d4b:	e9 60 fe ff ff       	jmp    80102bb0 <iput>
    panic("iunlock");
80102d50:	83 ec 0c             	sub    $0xc,%esp
80102d53:	68 bb 86 10 80       	push   $0x801086bb
80102d58:	e8 83 df ff ff       	call   80100ce0 <panic>
80102d5d:	8d 76 00             	lea    0x0(%esi),%esi

80102d60 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	8b 55 08             	mov    0x8(%ebp),%edx
80102d66:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102d69:	8b 0a                	mov    (%edx),%ecx
80102d6b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80102d6e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102d71:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102d74:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102d78:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80102d7b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80102d7f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102d83:	8b 52 58             	mov    0x58(%edx),%edx
80102d86:	89 50 10             	mov    %edx,0x10(%eax)
}
80102d89:	5d                   	pop    %ebp
80102d8a:	c3                   	ret    
80102d8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d8f:	90                   	nop

80102d90 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	57                   	push   %edi
80102d94:	56                   	push   %esi
80102d95:	53                   	push   %ebx
80102d96:	83 ec 1c             	sub    $0x1c,%esp
80102d99:	8b 7d 0c             	mov    0xc(%ebp),%edi
80102d9c:	8b 45 08             	mov    0x8(%ebp),%eax
80102d9f:	8b 75 10             	mov    0x10(%ebp),%esi
80102da2:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102da5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102da8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102dad:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102db0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80102db3:	0f 84 a7 00 00 00    	je     80102e60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80102db9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102dbc:	8b 40 58             	mov    0x58(%eax),%eax
80102dbf:	39 c6                	cmp    %eax,%esi
80102dc1:	0f 87 ba 00 00 00    	ja     80102e81 <readi+0xf1>
80102dc7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80102dca:	31 c9                	xor    %ecx,%ecx
80102dcc:	89 da                	mov    %ebx,%edx
80102dce:	01 f2                	add    %esi,%edx
80102dd0:	0f 92 c1             	setb   %cl
80102dd3:	89 cf                	mov    %ecx,%edi
80102dd5:	0f 82 a6 00 00 00    	jb     80102e81 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102ddb:	89 c1                	mov    %eax,%ecx
80102ddd:	29 f1                	sub    %esi,%ecx
80102ddf:	39 d0                	cmp    %edx,%eax
80102de1:	0f 43 cb             	cmovae %ebx,%ecx
80102de4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102de7:	85 c9                	test   %ecx,%ecx
80102de9:	74 67                	je     80102e52 <readi+0xc2>
80102deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102def:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102df0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102df3:	89 f2                	mov    %esi,%edx
80102df5:	c1 ea 09             	shr    $0x9,%edx
80102df8:	89 d8                	mov    %ebx,%eax
80102dfa:	e8 51 f9 ff ff       	call   80102750 <bmap>
80102dff:	83 ec 08             	sub    $0x8,%esp
80102e02:	50                   	push   %eax
80102e03:	ff 33                	push   (%ebx)
80102e05:	e8 c6 d2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80102e0a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80102e0d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102e12:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102e14:	89 f0                	mov    %esi,%eax
80102e16:	25 ff 01 00 00       	and    $0x1ff,%eax
80102e1b:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102e1d:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102e20:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80102e22:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102e26:	39 d9                	cmp    %ebx,%ecx
80102e28:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102e2b:	83 c4 0c             	add    $0xc,%esp
80102e2e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102e2f:	01 df                	add    %ebx,%edi
80102e31:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80102e33:	50                   	push   %eax
80102e34:	ff 75 e0             	push   -0x20(%ebp)
80102e37:	e8 c4 2b 00 00       	call   80105a00 <memmove>
    brelse(bp);
80102e3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80102e3f:	89 14 24             	mov    %edx,(%esp)
80102e42:	e8 a9 d3 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102e47:	01 5d e0             	add    %ebx,-0x20(%ebp)
80102e4a:	83 c4 10             	add    $0x10,%esp
80102e4d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102e50:	77 9e                	ja     80102df0 <readi+0x60>
  }
  return n;
80102e52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102e55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e58:	5b                   	pop    %ebx
80102e59:	5e                   	pop    %esi
80102e5a:	5f                   	pop    %edi
80102e5b:	5d                   	pop    %ebp
80102e5c:	c3                   	ret    
80102e5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102e60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102e64:	66 83 f8 09          	cmp    $0x9,%ax
80102e68:	77 17                	ja     80102e81 <readi+0xf1>
80102e6a:	8b 04 c5 a0 09 11 80 	mov    -0x7feef660(,%eax,8),%eax
80102e71:	85 c0                	test   %eax,%eax
80102e73:	74 0c                	je     80102e81 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102e75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102e78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e7b:	5b                   	pop    %ebx
80102e7c:	5e                   	pop    %esi
80102e7d:	5f                   	pop    %edi
80102e7e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80102e7f:	ff e0                	jmp    *%eax
      return -1;
80102e81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102e86:	eb cd                	jmp    80102e55 <readi+0xc5>
80102e88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e8f:	90                   	nop

80102e90 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	57                   	push   %edi
80102e94:	56                   	push   %esi
80102e95:	53                   	push   %ebx
80102e96:	83 ec 1c             	sub    $0x1c,%esp
80102e99:	8b 45 08             	mov    0x8(%ebp),%eax
80102e9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80102e9f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102ea2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102ea7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80102eaa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ead:	8b 75 10             	mov    0x10(%ebp),%esi
80102eb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80102eb3:	0f 84 b7 00 00 00    	je     80102f70 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102eb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102ebc:	3b 70 58             	cmp    0x58(%eax),%esi
80102ebf:	0f 87 e7 00 00 00    	ja     80102fac <writei+0x11c>
80102ec5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102ec8:	31 d2                	xor    %edx,%edx
80102eca:	89 f8                	mov    %edi,%eax
80102ecc:	01 f0                	add    %esi,%eax
80102ece:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102ed1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102ed6:	0f 87 d0 00 00 00    	ja     80102fac <writei+0x11c>
80102edc:	85 d2                	test   %edx,%edx
80102ede:	0f 85 c8 00 00 00    	jne    80102fac <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102ee4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102eeb:	85 ff                	test   %edi,%edi
80102eed:	74 72                	je     80102f61 <writei+0xd1>
80102eef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102ef0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102ef3:	89 f2                	mov    %esi,%edx
80102ef5:	c1 ea 09             	shr    $0x9,%edx
80102ef8:	89 f8                	mov    %edi,%eax
80102efa:	e8 51 f8 ff ff       	call   80102750 <bmap>
80102eff:	83 ec 08             	sub    $0x8,%esp
80102f02:	50                   	push   %eax
80102f03:	ff 37                	push   (%edi)
80102f05:	e8 c6 d1 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80102f0a:	b9 00 02 00 00       	mov    $0x200,%ecx
80102f0f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102f12:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102f15:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102f17:	89 f0                	mov    %esi,%eax
80102f19:	25 ff 01 00 00       	and    $0x1ff,%eax
80102f1e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102f20:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102f24:	39 d9                	cmp    %ebx,%ecx
80102f26:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80102f29:	83 c4 0c             	add    $0xc,%esp
80102f2c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102f2d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80102f2f:	ff 75 dc             	push   -0x24(%ebp)
80102f32:	50                   	push   %eax
80102f33:	e8 c8 2a 00 00       	call   80105a00 <memmove>
    log_write(bp);
80102f38:	89 3c 24             	mov    %edi,(%esp)
80102f3b:	e8 00 13 00 00       	call   80104240 <log_write>
    brelse(bp);
80102f40:	89 3c 24             	mov    %edi,(%esp)
80102f43:	e8 a8 d2 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102f48:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80102f4b:	83 c4 10             	add    $0x10,%esp
80102f4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102f51:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102f54:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102f57:	77 97                	ja     80102ef0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102f59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102f5c:	3b 70 58             	cmp    0x58(%eax),%esi
80102f5f:	77 37                	ja     80102f98 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102f61:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102f64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f67:	5b                   	pop    %ebx
80102f68:	5e                   	pop    %esi
80102f69:	5f                   	pop    %edi
80102f6a:	5d                   	pop    %ebp
80102f6b:	c3                   	ret    
80102f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102f70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102f74:	66 83 f8 09          	cmp    $0x9,%ax
80102f78:	77 32                	ja     80102fac <writei+0x11c>
80102f7a:	8b 04 c5 a4 09 11 80 	mov    -0x7feef65c(,%eax,8),%eax
80102f81:	85 c0                	test   %eax,%eax
80102f83:	74 27                	je     80102fac <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102f85:	89 55 10             	mov    %edx,0x10(%ebp)
}
80102f88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f8b:	5b                   	pop    %ebx
80102f8c:	5e                   	pop    %esi
80102f8d:	5f                   	pop    %edi
80102f8e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80102f8f:	ff e0                	jmp    *%eax
80102f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102f98:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80102f9b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80102f9e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102fa1:	50                   	push   %eax
80102fa2:	e8 29 fa ff ff       	call   801029d0 <iupdate>
80102fa7:	83 c4 10             	add    $0x10,%esp
80102faa:	eb b5                	jmp    80102f61 <writei+0xd1>
      return -1;
80102fac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102fb1:	eb b1                	jmp    80102f64 <writei+0xd4>
80102fb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102fc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102fc6:	6a 0e                	push   $0xe
80102fc8:	ff 75 0c             	push   0xc(%ebp)
80102fcb:	ff 75 08             	push   0x8(%ebp)
80102fce:	e8 9d 2a 00 00       	call   80105a70 <strncmp>
}
80102fd3:	c9                   	leave  
80102fd4:	c3                   	ret    
80102fd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102fe0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	57                   	push   %edi
80102fe4:	56                   	push   %esi
80102fe5:	53                   	push   %ebx
80102fe6:	83 ec 1c             	sub    $0x1c,%esp
80102fe9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102fec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102ff1:	0f 85 85 00 00 00    	jne    8010307c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102ff7:	8b 53 58             	mov    0x58(%ebx),%edx
80102ffa:	31 ff                	xor    %edi,%edi
80102ffc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102fff:	85 d2                	test   %edx,%edx
80103001:	74 3e                	je     80103041 <dirlookup+0x61>
80103003:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103007:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80103008:	6a 10                	push   $0x10
8010300a:	57                   	push   %edi
8010300b:	56                   	push   %esi
8010300c:	53                   	push   %ebx
8010300d:	e8 7e fd ff ff       	call   80102d90 <readi>
80103012:	83 c4 10             	add    $0x10,%esp
80103015:	83 f8 10             	cmp    $0x10,%eax
80103018:	75 55                	jne    8010306f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
8010301a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010301f:	74 18                	je     80103039 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80103021:	83 ec 04             	sub    $0x4,%esp
80103024:	8d 45 da             	lea    -0x26(%ebp),%eax
80103027:	6a 0e                	push   $0xe
80103029:	50                   	push   %eax
8010302a:	ff 75 0c             	push   0xc(%ebp)
8010302d:	e8 3e 2a 00 00       	call   80105a70 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80103032:	83 c4 10             	add    $0x10,%esp
80103035:	85 c0                	test   %eax,%eax
80103037:	74 17                	je     80103050 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80103039:	83 c7 10             	add    $0x10,%edi
8010303c:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010303f:	72 c7                	jb     80103008 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80103041:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103044:	31 c0                	xor    %eax,%eax
}
80103046:	5b                   	pop    %ebx
80103047:	5e                   	pop    %esi
80103048:	5f                   	pop    %edi
80103049:	5d                   	pop    %ebp
8010304a:	c3                   	ret    
8010304b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010304f:	90                   	nop
      if(poff)
80103050:	8b 45 10             	mov    0x10(%ebp),%eax
80103053:	85 c0                	test   %eax,%eax
80103055:	74 05                	je     8010305c <dirlookup+0x7c>
        *poff = off;
80103057:	8b 45 10             	mov    0x10(%ebp),%eax
8010305a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010305c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80103060:	8b 03                	mov    (%ebx),%eax
80103062:	e8 e9 f5 ff ff       	call   80102650 <iget>
}
80103067:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010306a:	5b                   	pop    %ebx
8010306b:	5e                   	pop    %esi
8010306c:	5f                   	pop    %edi
8010306d:	5d                   	pop    %ebp
8010306e:	c3                   	ret    
      panic("dirlookup read");
8010306f:	83 ec 0c             	sub    $0xc,%esp
80103072:	68 d5 86 10 80       	push   $0x801086d5
80103077:	e8 64 dc ff ff       	call   80100ce0 <panic>
    panic("dirlookup not DIR");
8010307c:	83 ec 0c             	sub    $0xc,%esp
8010307f:	68 c3 86 10 80       	push   $0x801086c3
80103084:	e8 57 dc ff ff       	call   80100ce0 <panic>
80103089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103090 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80103090:	55                   	push   %ebp
80103091:	89 e5                	mov    %esp,%ebp
80103093:	57                   	push   %edi
80103094:	56                   	push   %esi
80103095:	53                   	push   %ebx
80103096:	89 c3                	mov    %eax,%ebx
80103098:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010309b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010309e:	89 55 dc             	mov    %edx,-0x24(%ebp)
801030a1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
801030a4:	0f 84 64 01 00 00    	je     8010320e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
801030aa:	e8 c1 1b 00 00       	call   80104c70 <myproc>
  acquire(&icache.lock);
801030af:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
801030b2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
801030b5:	68 00 0a 11 80       	push   $0x80110a00
801030ba:	e8 e1 27 00 00       	call   801058a0 <acquire>
  ip->ref++;
801030bf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
801030c3:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801030ca:	e8 71 27 00 00       	call   80105840 <release>
801030cf:	83 c4 10             	add    $0x10,%esp
801030d2:	eb 07                	jmp    801030db <namex+0x4b>
801030d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801030d8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801030db:	0f b6 03             	movzbl (%ebx),%eax
801030de:	3c 2f                	cmp    $0x2f,%al
801030e0:	74 f6                	je     801030d8 <namex+0x48>
  if(*path == 0)
801030e2:	84 c0                	test   %al,%al
801030e4:	0f 84 06 01 00 00    	je     801031f0 <namex+0x160>
  while(*path != '/' && *path != 0)
801030ea:	0f b6 03             	movzbl (%ebx),%eax
801030ed:	84 c0                	test   %al,%al
801030ef:	0f 84 10 01 00 00    	je     80103205 <namex+0x175>
801030f5:	89 df                	mov    %ebx,%edi
801030f7:	3c 2f                	cmp    $0x2f,%al
801030f9:	0f 84 06 01 00 00    	je     80103205 <namex+0x175>
801030ff:	90                   	nop
80103100:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80103104:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80103107:	3c 2f                	cmp    $0x2f,%al
80103109:	74 04                	je     8010310f <namex+0x7f>
8010310b:	84 c0                	test   %al,%al
8010310d:	75 f1                	jne    80103100 <namex+0x70>
  len = path - s;
8010310f:	89 f8                	mov    %edi,%eax
80103111:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80103113:	83 f8 0d             	cmp    $0xd,%eax
80103116:	0f 8e ac 00 00 00    	jle    801031c8 <namex+0x138>
    memmove(name, s, DIRSIZ);
8010311c:	83 ec 04             	sub    $0x4,%esp
8010311f:	6a 0e                	push   $0xe
80103121:	53                   	push   %ebx
    path++;
80103122:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80103124:	ff 75 e4             	push   -0x1c(%ebp)
80103127:	e8 d4 28 00 00       	call   80105a00 <memmove>
8010312c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010312f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80103132:	75 0c                	jne    80103140 <namex+0xb0>
80103134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80103138:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010313b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
8010313e:	74 f8                	je     80103138 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80103140:	83 ec 0c             	sub    $0xc,%esp
80103143:	56                   	push   %esi
80103144:	e8 37 f9 ff ff       	call   80102a80 <ilock>
    if(ip->type != T_DIR){
80103149:	83 c4 10             	add    $0x10,%esp
8010314c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80103151:	0f 85 cd 00 00 00    	jne    80103224 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80103157:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010315a:	85 c0                	test   %eax,%eax
8010315c:	74 09                	je     80103167 <namex+0xd7>
8010315e:	80 3b 00             	cmpb   $0x0,(%ebx)
80103161:	0f 84 22 01 00 00    	je     80103289 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80103167:	83 ec 04             	sub    $0x4,%esp
8010316a:	6a 00                	push   $0x0
8010316c:	ff 75 e4             	push   -0x1c(%ebp)
8010316f:	56                   	push   %esi
80103170:	e8 6b fe ff ff       	call   80102fe0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80103175:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80103178:	83 c4 10             	add    $0x10,%esp
8010317b:	89 c7                	mov    %eax,%edi
8010317d:	85 c0                	test   %eax,%eax
8010317f:	0f 84 e1 00 00 00    	je     80103266 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80103185:	83 ec 0c             	sub    $0xc,%esp
80103188:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010318b:	52                   	push   %edx
8010318c:	e8 ef 24 00 00       	call   80105680 <holdingsleep>
80103191:	83 c4 10             	add    $0x10,%esp
80103194:	85 c0                	test   %eax,%eax
80103196:	0f 84 30 01 00 00    	je     801032cc <namex+0x23c>
8010319c:	8b 56 08             	mov    0x8(%esi),%edx
8010319f:	85 d2                	test   %edx,%edx
801031a1:	0f 8e 25 01 00 00    	jle    801032cc <namex+0x23c>
  releasesleep(&ip->lock);
801031a7:	8b 55 e0             	mov    -0x20(%ebp),%edx
801031aa:	83 ec 0c             	sub    $0xc,%esp
801031ad:	52                   	push   %edx
801031ae:	e8 8d 24 00 00       	call   80105640 <releasesleep>
  iput(ip);
801031b3:	89 34 24             	mov    %esi,(%esp)
801031b6:	89 fe                	mov    %edi,%esi
801031b8:	e8 f3 f9 ff ff       	call   80102bb0 <iput>
801031bd:	83 c4 10             	add    $0x10,%esp
801031c0:	e9 16 ff ff ff       	jmp    801030db <namex+0x4b>
801031c5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
801031c8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801031cb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
801031ce:	83 ec 04             	sub    $0x4,%esp
801031d1:	89 55 e0             	mov    %edx,-0x20(%ebp)
801031d4:	50                   	push   %eax
801031d5:	53                   	push   %ebx
    name[len] = 0;
801031d6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
801031d8:	ff 75 e4             	push   -0x1c(%ebp)
801031db:	e8 20 28 00 00       	call   80105a00 <memmove>
    name[len] = 0;
801031e0:	8b 55 e0             	mov    -0x20(%ebp),%edx
801031e3:	83 c4 10             	add    $0x10,%esp
801031e6:	c6 02 00             	movb   $0x0,(%edx)
801031e9:	e9 41 ff ff ff       	jmp    8010312f <namex+0x9f>
801031ee:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801031f0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801031f3:	85 c0                	test   %eax,%eax
801031f5:	0f 85 be 00 00 00    	jne    801032b9 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
801031fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031fe:	89 f0                	mov    %esi,%eax
80103200:	5b                   	pop    %ebx
80103201:	5e                   	pop    %esi
80103202:	5f                   	pop    %edi
80103203:	5d                   	pop    %ebp
80103204:	c3                   	ret    
  while(*path != '/' && *path != 0)
80103205:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103208:	89 df                	mov    %ebx,%edi
8010320a:	31 c0                	xor    %eax,%eax
8010320c:	eb c0                	jmp    801031ce <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
8010320e:	ba 01 00 00 00       	mov    $0x1,%edx
80103213:	b8 01 00 00 00       	mov    $0x1,%eax
80103218:	e8 33 f4 ff ff       	call   80102650 <iget>
8010321d:	89 c6                	mov    %eax,%esi
8010321f:	e9 b7 fe ff ff       	jmp    801030db <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80103224:	83 ec 0c             	sub    $0xc,%esp
80103227:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010322a:	53                   	push   %ebx
8010322b:	e8 50 24 00 00       	call   80105680 <holdingsleep>
80103230:	83 c4 10             	add    $0x10,%esp
80103233:	85 c0                	test   %eax,%eax
80103235:	0f 84 91 00 00 00    	je     801032cc <namex+0x23c>
8010323b:	8b 46 08             	mov    0x8(%esi),%eax
8010323e:	85 c0                	test   %eax,%eax
80103240:	0f 8e 86 00 00 00    	jle    801032cc <namex+0x23c>
  releasesleep(&ip->lock);
80103246:	83 ec 0c             	sub    $0xc,%esp
80103249:	53                   	push   %ebx
8010324a:	e8 f1 23 00 00       	call   80105640 <releasesleep>
  iput(ip);
8010324f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80103252:	31 f6                	xor    %esi,%esi
  iput(ip);
80103254:	e8 57 f9 ff ff       	call   80102bb0 <iput>
      return 0;
80103259:	83 c4 10             	add    $0x10,%esp
}
8010325c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010325f:	89 f0                	mov    %esi,%eax
80103261:	5b                   	pop    %ebx
80103262:	5e                   	pop    %esi
80103263:	5f                   	pop    %edi
80103264:	5d                   	pop    %ebp
80103265:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80103266:	83 ec 0c             	sub    $0xc,%esp
80103269:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010326c:	52                   	push   %edx
8010326d:	e8 0e 24 00 00       	call   80105680 <holdingsleep>
80103272:	83 c4 10             	add    $0x10,%esp
80103275:	85 c0                	test   %eax,%eax
80103277:	74 53                	je     801032cc <namex+0x23c>
80103279:	8b 4e 08             	mov    0x8(%esi),%ecx
8010327c:	85 c9                	test   %ecx,%ecx
8010327e:	7e 4c                	jle    801032cc <namex+0x23c>
  releasesleep(&ip->lock);
80103280:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103283:	83 ec 0c             	sub    $0xc,%esp
80103286:	52                   	push   %edx
80103287:	eb c1                	jmp    8010324a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80103289:	83 ec 0c             	sub    $0xc,%esp
8010328c:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010328f:	53                   	push   %ebx
80103290:	e8 eb 23 00 00       	call   80105680 <holdingsleep>
80103295:	83 c4 10             	add    $0x10,%esp
80103298:	85 c0                	test   %eax,%eax
8010329a:	74 30                	je     801032cc <namex+0x23c>
8010329c:	8b 7e 08             	mov    0x8(%esi),%edi
8010329f:	85 ff                	test   %edi,%edi
801032a1:	7e 29                	jle    801032cc <namex+0x23c>
  releasesleep(&ip->lock);
801032a3:	83 ec 0c             	sub    $0xc,%esp
801032a6:	53                   	push   %ebx
801032a7:	e8 94 23 00 00       	call   80105640 <releasesleep>
}
801032ac:	83 c4 10             	add    $0x10,%esp
}
801032af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032b2:	89 f0                	mov    %esi,%eax
801032b4:	5b                   	pop    %ebx
801032b5:	5e                   	pop    %esi
801032b6:	5f                   	pop    %edi
801032b7:	5d                   	pop    %ebp
801032b8:	c3                   	ret    
    iput(ip);
801032b9:	83 ec 0c             	sub    $0xc,%esp
801032bc:	56                   	push   %esi
    return 0;
801032bd:	31 f6                	xor    %esi,%esi
    iput(ip);
801032bf:	e8 ec f8 ff ff       	call   80102bb0 <iput>
    return 0;
801032c4:	83 c4 10             	add    $0x10,%esp
801032c7:	e9 2f ff ff ff       	jmp    801031fb <namex+0x16b>
    panic("iunlock");
801032cc:	83 ec 0c             	sub    $0xc,%esp
801032cf:	68 bb 86 10 80       	push   $0x801086bb
801032d4:	e8 07 da ff ff       	call   80100ce0 <panic>
801032d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801032e0 <dirlink>:
{
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	57                   	push   %edi
801032e4:	56                   	push   %esi
801032e5:	53                   	push   %ebx
801032e6:	83 ec 20             	sub    $0x20,%esp
801032e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801032ec:	6a 00                	push   $0x0
801032ee:	ff 75 0c             	push   0xc(%ebp)
801032f1:	53                   	push   %ebx
801032f2:	e8 e9 fc ff ff       	call   80102fe0 <dirlookup>
801032f7:	83 c4 10             	add    $0x10,%esp
801032fa:	85 c0                	test   %eax,%eax
801032fc:	75 67                	jne    80103365 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801032fe:	8b 7b 58             	mov    0x58(%ebx),%edi
80103301:	8d 75 d8             	lea    -0x28(%ebp),%esi
80103304:	85 ff                	test   %edi,%edi
80103306:	74 29                	je     80103331 <dirlink+0x51>
80103308:	31 ff                	xor    %edi,%edi
8010330a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010330d:	eb 09                	jmp    80103318 <dirlink+0x38>
8010330f:	90                   	nop
80103310:	83 c7 10             	add    $0x10,%edi
80103313:	3b 7b 58             	cmp    0x58(%ebx),%edi
80103316:	73 19                	jae    80103331 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80103318:	6a 10                	push   $0x10
8010331a:	57                   	push   %edi
8010331b:	56                   	push   %esi
8010331c:	53                   	push   %ebx
8010331d:	e8 6e fa ff ff       	call   80102d90 <readi>
80103322:	83 c4 10             	add    $0x10,%esp
80103325:	83 f8 10             	cmp    $0x10,%eax
80103328:	75 4e                	jne    80103378 <dirlink+0x98>
    if(de.inum == 0)
8010332a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010332f:	75 df                	jne    80103310 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80103331:	83 ec 04             	sub    $0x4,%esp
80103334:	8d 45 da             	lea    -0x26(%ebp),%eax
80103337:	6a 0e                	push   $0xe
80103339:	ff 75 0c             	push   0xc(%ebp)
8010333c:	50                   	push   %eax
8010333d:	e8 7e 27 00 00       	call   80105ac0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80103342:	6a 10                	push   $0x10
  de.inum = inum;
80103344:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80103347:	57                   	push   %edi
80103348:	56                   	push   %esi
80103349:	53                   	push   %ebx
  de.inum = inum;
8010334a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010334e:	e8 3d fb ff ff       	call   80102e90 <writei>
80103353:	83 c4 20             	add    $0x20,%esp
80103356:	83 f8 10             	cmp    $0x10,%eax
80103359:	75 2a                	jne    80103385 <dirlink+0xa5>
  return 0;
8010335b:	31 c0                	xor    %eax,%eax
}
8010335d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103360:	5b                   	pop    %ebx
80103361:	5e                   	pop    %esi
80103362:	5f                   	pop    %edi
80103363:	5d                   	pop    %ebp
80103364:	c3                   	ret    
    iput(ip);
80103365:	83 ec 0c             	sub    $0xc,%esp
80103368:	50                   	push   %eax
80103369:	e8 42 f8 ff ff       	call   80102bb0 <iput>
    return -1;
8010336e:	83 c4 10             	add    $0x10,%esp
80103371:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103376:	eb e5                	jmp    8010335d <dirlink+0x7d>
      panic("dirlink read");
80103378:	83 ec 0c             	sub    $0xc,%esp
8010337b:	68 e4 86 10 80       	push   $0x801086e4
80103380:	e8 5b d9 ff ff       	call   80100ce0 <panic>
    panic("dirlink");
80103385:	83 ec 0c             	sub    $0xc,%esp
80103388:	68 be 8c 10 80       	push   $0x80108cbe
8010338d:	e8 4e d9 ff ff       	call   80100ce0 <panic>
80103392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801033a0 <namei>:

struct inode*
namei(char *path)
{
801033a0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801033a1:	31 d2                	xor    %edx,%edx
{
801033a3:	89 e5                	mov    %esp,%ebp
801033a5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801033a8:	8b 45 08             	mov    0x8(%ebp),%eax
801033ab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801033ae:	e8 dd fc ff ff       	call   80103090 <namex>
}
801033b3:	c9                   	leave  
801033b4:	c3                   	ret    
801033b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801033c0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801033c0:	55                   	push   %ebp
  return namex(path, 1, name);
801033c1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801033c6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801033c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801033cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801033ce:	5d                   	pop    %ebp
  return namex(path, 1, name);
801033cf:	e9 bc fc ff ff       	jmp    80103090 <namex>
801033d4:	66 90                	xchg   %ax,%ax
801033d6:	66 90                	xchg   %ax,%ax
801033d8:	66 90                	xchg   %ax,%ax
801033da:	66 90                	xchg   %ax,%ax
801033dc:	66 90                	xchg   %ax,%ax
801033de:	66 90                	xchg   %ax,%ax

801033e0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801033e9:	85 c0                	test   %eax,%eax
801033eb:	0f 84 b4 00 00 00    	je     801034a5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801033f1:	8b 70 08             	mov    0x8(%eax),%esi
801033f4:	89 c3                	mov    %eax,%ebx
801033f6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801033fc:	0f 87 96 00 00 00    	ja     80103498 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103402:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80103407:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010340e:	66 90                	xchg   %ax,%ax
80103410:	89 ca                	mov    %ecx,%edx
80103412:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80103413:	83 e0 c0             	and    $0xffffffc0,%eax
80103416:	3c 40                	cmp    $0x40,%al
80103418:	75 f6                	jne    80103410 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010341a:	31 ff                	xor    %edi,%edi
8010341c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80103421:	89 f8                	mov    %edi,%eax
80103423:	ee                   	out    %al,(%dx)
80103424:	b8 01 00 00 00       	mov    $0x1,%eax
80103429:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010342e:	ee                   	out    %al,(%dx)
8010342f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80103434:	89 f0                	mov    %esi,%eax
80103436:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80103437:	89 f0                	mov    %esi,%eax
80103439:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010343e:	c1 f8 08             	sar    $0x8,%eax
80103441:	ee                   	out    %al,(%dx)
80103442:	ba f5 01 00 00       	mov    $0x1f5,%edx
80103447:	89 f8                	mov    %edi,%eax
80103449:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010344a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010344e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80103453:	c1 e0 04             	shl    $0x4,%eax
80103456:	83 e0 10             	and    $0x10,%eax
80103459:	83 c8 e0             	or     $0xffffffe0,%eax
8010345c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010345d:	f6 03 04             	testb  $0x4,(%ebx)
80103460:	75 16                	jne    80103478 <idestart+0x98>
80103462:	b8 20 00 00 00       	mov    $0x20,%eax
80103467:	89 ca                	mov    %ecx,%edx
80103469:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010346a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010346d:	5b                   	pop    %ebx
8010346e:	5e                   	pop    %esi
8010346f:	5f                   	pop    %edi
80103470:	5d                   	pop    %ebp
80103471:	c3                   	ret    
80103472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103478:	b8 30 00 00 00       	mov    $0x30,%eax
8010347d:	89 ca                	mov    %ecx,%edx
8010347f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80103480:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80103485:	8d 73 5c             	lea    0x5c(%ebx),%esi
80103488:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010348d:	fc                   	cld    
8010348e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80103490:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103493:	5b                   	pop    %ebx
80103494:	5e                   	pop    %esi
80103495:	5f                   	pop    %edi
80103496:	5d                   	pop    %ebp
80103497:	c3                   	ret    
    panic("incorrect blockno");
80103498:	83 ec 0c             	sub    $0xc,%esp
8010349b:	68 50 87 10 80       	push   $0x80108750
801034a0:	e8 3b d8 ff ff       	call   80100ce0 <panic>
    panic("idestart");
801034a5:	83 ec 0c             	sub    $0xc,%esp
801034a8:	68 47 87 10 80       	push   $0x80108747
801034ad:	e8 2e d8 ff ff       	call   80100ce0 <panic>
801034b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034c0 <ideinit>:
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801034c6:	68 62 87 10 80       	push   $0x80108762
801034cb:	68 a0 26 11 80       	push   $0x801126a0
801034d0:	e8 fb 21 00 00       	call   801056d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801034d5:	58                   	pop    %eax
801034d6:	a1 24 28 11 80       	mov    0x80112824,%eax
801034db:	5a                   	pop    %edx
801034dc:	83 e8 01             	sub    $0x1,%eax
801034df:	50                   	push   %eax
801034e0:	6a 0e                	push   $0xe
801034e2:	e8 99 02 00 00       	call   80103780 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801034e7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034ea:	ba f7 01 00 00       	mov    $0x1f7,%edx
801034ef:	90                   	nop
801034f0:	ec                   	in     (%dx),%al
801034f1:	83 e0 c0             	and    $0xffffffc0,%eax
801034f4:	3c 40                	cmp    $0x40,%al
801034f6:	75 f8                	jne    801034f0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034f8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801034fd:	ba f6 01 00 00       	mov    $0x1f6,%edx
80103502:	ee                   	out    %al,(%dx)
80103503:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103508:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010350d:	eb 06                	jmp    80103515 <ideinit+0x55>
8010350f:	90                   	nop
  for(i=0; i<1000; i++){
80103510:	83 e9 01             	sub    $0x1,%ecx
80103513:	74 0f                	je     80103524 <ideinit+0x64>
80103515:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80103516:	84 c0                	test   %al,%al
80103518:	74 f6                	je     80103510 <ideinit+0x50>
      havedisk1 = 1;
8010351a:	c7 05 80 26 11 80 01 	movl   $0x1,0x80112680
80103521:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103524:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80103529:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010352e:	ee                   	out    %al,(%dx)
}
8010352f:	c9                   	leave  
80103530:	c3                   	ret    
80103531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010353f:	90                   	nop

80103540 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	57                   	push   %edi
80103544:	56                   	push   %esi
80103545:	53                   	push   %ebx
80103546:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80103549:	68 a0 26 11 80       	push   $0x801126a0
8010354e:	e8 4d 23 00 00       	call   801058a0 <acquire>

  if((b = idequeue) == 0){
80103553:	8b 1d 84 26 11 80    	mov    0x80112684,%ebx
80103559:	83 c4 10             	add    $0x10,%esp
8010355c:	85 db                	test   %ebx,%ebx
8010355e:	74 63                	je     801035c3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80103560:	8b 43 58             	mov    0x58(%ebx),%eax
80103563:	a3 84 26 11 80       	mov    %eax,0x80112684

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80103568:	8b 33                	mov    (%ebx),%esi
8010356a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80103570:	75 2f                	jne    801035a1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103572:	ba f7 01 00 00       	mov    $0x1f7,%edx
80103577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010357e:	66 90                	xchg   %ax,%ax
80103580:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80103581:	89 c1                	mov    %eax,%ecx
80103583:	83 e1 c0             	and    $0xffffffc0,%ecx
80103586:	80 f9 40             	cmp    $0x40,%cl
80103589:	75 f5                	jne    80103580 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010358b:	a8 21                	test   $0x21,%al
8010358d:	75 12                	jne    801035a1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010358f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80103592:	b9 80 00 00 00       	mov    $0x80,%ecx
80103597:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010359c:	fc                   	cld    
8010359d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010359f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801035a1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801035a4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801035a7:	83 ce 02             	or     $0x2,%esi
801035aa:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801035ac:	53                   	push   %ebx
801035ad:	e8 4e 1e 00 00       	call   80105400 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801035b2:	a1 84 26 11 80       	mov    0x80112684,%eax
801035b7:	83 c4 10             	add    $0x10,%esp
801035ba:	85 c0                	test   %eax,%eax
801035bc:	74 05                	je     801035c3 <ideintr+0x83>
    idestart(idequeue);
801035be:	e8 1d fe ff ff       	call   801033e0 <idestart>
    release(&idelock);
801035c3:	83 ec 0c             	sub    $0xc,%esp
801035c6:	68 a0 26 11 80       	push   $0x801126a0
801035cb:	e8 70 22 00 00       	call   80105840 <release>

  release(&idelock);
}
801035d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035d3:	5b                   	pop    %ebx
801035d4:	5e                   	pop    %esi
801035d5:	5f                   	pop    %edi
801035d6:	5d                   	pop    %ebp
801035d7:	c3                   	ret    
801035d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035df:	90                   	nop

801035e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	53                   	push   %ebx
801035e4:	83 ec 10             	sub    $0x10,%esp
801035e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801035ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801035ed:	50                   	push   %eax
801035ee:	e8 8d 20 00 00       	call   80105680 <holdingsleep>
801035f3:	83 c4 10             	add    $0x10,%esp
801035f6:	85 c0                	test   %eax,%eax
801035f8:	0f 84 c3 00 00 00    	je     801036c1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801035fe:	8b 03                	mov    (%ebx),%eax
80103600:	83 e0 06             	and    $0x6,%eax
80103603:	83 f8 02             	cmp    $0x2,%eax
80103606:	0f 84 a8 00 00 00    	je     801036b4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010360c:	8b 53 04             	mov    0x4(%ebx),%edx
8010360f:	85 d2                	test   %edx,%edx
80103611:	74 0d                	je     80103620 <iderw+0x40>
80103613:	a1 80 26 11 80       	mov    0x80112680,%eax
80103618:	85 c0                	test   %eax,%eax
8010361a:	0f 84 87 00 00 00    	je     801036a7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80103620:	83 ec 0c             	sub    $0xc,%esp
80103623:	68 a0 26 11 80       	push   $0x801126a0
80103628:	e8 73 22 00 00       	call   801058a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010362d:	a1 84 26 11 80       	mov    0x80112684,%eax
  b->qnext = 0;
80103632:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103639:	83 c4 10             	add    $0x10,%esp
8010363c:	85 c0                	test   %eax,%eax
8010363e:	74 60                	je     801036a0 <iderw+0xc0>
80103640:	89 c2                	mov    %eax,%edx
80103642:	8b 40 58             	mov    0x58(%eax),%eax
80103645:	85 c0                	test   %eax,%eax
80103647:	75 f7                	jne    80103640 <iderw+0x60>
80103649:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010364c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010364e:	39 1d 84 26 11 80    	cmp    %ebx,0x80112684
80103654:	74 3a                	je     80103690 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80103656:	8b 03                	mov    (%ebx),%eax
80103658:	83 e0 06             	and    $0x6,%eax
8010365b:	83 f8 02             	cmp    $0x2,%eax
8010365e:	74 1b                	je     8010367b <iderw+0x9b>
    sleep(b, &idelock);
80103660:	83 ec 08             	sub    $0x8,%esp
80103663:	68 a0 26 11 80       	push   $0x801126a0
80103668:	53                   	push   %ebx
80103669:	e8 d2 1c 00 00       	call   80105340 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010366e:	8b 03                	mov    (%ebx),%eax
80103670:	83 c4 10             	add    $0x10,%esp
80103673:	83 e0 06             	and    $0x6,%eax
80103676:	83 f8 02             	cmp    $0x2,%eax
80103679:	75 e5                	jne    80103660 <iderw+0x80>
  }


  release(&idelock);
8010367b:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80103682:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103685:	c9                   	leave  
  release(&idelock);
80103686:	e9 b5 21 00 00       	jmp    80105840 <release>
8010368b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010368f:	90                   	nop
    idestart(b);
80103690:	89 d8                	mov    %ebx,%eax
80103692:	e8 49 fd ff ff       	call   801033e0 <idestart>
80103697:	eb bd                	jmp    80103656 <iderw+0x76>
80103699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801036a0:	ba 84 26 11 80       	mov    $0x80112684,%edx
801036a5:	eb a5                	jmp    8010364c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801036a7:	83 ec 0c             	sub    $0xc,%esp
801036aa:	68 91 87 10 80       	push   $0x80108791
801036af:	e8 2c d6 ff ff       	call   80100ce0 <panic>
    panic("iderw: nothing to do");
801036b4:	83 ec 0c             	sub    $0xc,%esp
801036b7:	68 7c 87 10 80       	push   $0x8010877c
801036bc:	e8 1f d6 ff ff       	call   80100ce0 <panic>
    panic("iderw: buf not locked");
801036c1:	83 ec 0c             	sub    $0xc,%esp
801036c4:	68 66 87 10 80       	push   $0x80108766
801036c9:	e8 12 d6 ff ff       	call   80100ce0 <panic>
801036ce:	66 90                	xchg   %ax,%ax

801036d0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801036d0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801036d1:	c7 05 d4 26 11 80 00 	movl   $0xfec00000,0x801126d4
801036d8:	00 c0 fe 
{
801036db:	89 e5                	mov    %esp,%ebp
801036dd:	56                   	push   %esi
801036de:	53                   	push   %ebx
  ioapic->reg = reg;
801036df:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801036e6:	00 00 00 
  return ioapic->data;
801036e9:	8b 15 d4 26 11 80    	mov    0x801126d4,%edx
801036ef:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801036f2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801036f8:	8b 0d d4 26 11 80    	mov    0x801126d4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801036fe:	0f b6 15 20 28 11 80 	movzbl 0x80112820,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80103705:	c1 ee 10             	shr    $0x10,%esi
80103708:	89 f0                	mov    %esi,%eax
8010370a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010370d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80103710:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80103713:	39 c2                	cmp    %eax,%edx
80103715:	74 16                	je     8010372d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80103717:	83 ec 0c             	sub    $0xc,%esp
8010371a:	68 b0 87 10 80       	push   $0x801087b0
8010371f:	e8 3c d3 ff ff       	call   80100a60 <cprintf>
  ioapic->reg = reg;
80103724:	8b 0d d4 26 11 80    	mov    0x801126d4,%ecx
8010372a:	83 c4 10             	add    $0x10,%esp
8010372d:	83 c6 21             	add    $0x21,%esi
{
80103730:	ba 10 00 00 00       	mov    $0x10,%edx
80103735:	b8 20 00 00 00       	mov    $0x20,%eax
8010373a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80103740:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80103742:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80103744:	8b 0d d4 26 11 80    	mov    0x801126d4,%ecx
  for(i = 0; i <= maxintr; i++){
8010374a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010374d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80103753:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80103756:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80103759:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010375c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010375e:	8b 0d d4 26 11 80    	mov    0x801126d4,%ecx
80103764:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010376b:	39 f0                	cmp    %esi,%eax
8010376d:	75 d1                	jne    80103740 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010376f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103772:	5b                   	pop    %ebx
80103773:	5e                   	pop    %esi
80103774:	5d                   	pop    %ebp
80103775:	c3                   	ret    
80103776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010377d:	8d 76 00             	lea    0x0(%esi),%esi

80103780 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80103780:	55                   	push   %ebp
  ioapic->reg = reg;
80103781:	8b 0d d4 26 11 80    	mov    0x801126d4,%ecx
{
80103787:	89 e5                	mov    %esp,%ebp
80103789:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010378c:	8d 50 20             	lea    0x20(%eax),%edx
8010378f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80103793:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103795:	8b 0d d4 26 11 80    	mov    0x801126d4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010379b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010379e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801037a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801037a4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801037a6:	a1 d4 26 11 80       	mov    0x801126d4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801037ab:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801037ae:	89 50 10             	mov    %edx,0x10(%eax)
}
801037b1:	5d                   	pop    %ebp
801037b2:	c3                   	ret    
801037b3:	66 90                	xchg   %ax,%ax
801037b5:	66 90                	xchg   %ax,%ax
801037b7:	66 90                	xchg   %ax,%ax
801037b9:	66 90                	xchg   %ax,%ax
801037bb:	66 90                	xchg   %ax,%ax
801037bd:	66 90                	xchg   %ax,%ax
801037bf:	90                   	nop

801037c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
801037c4:	83 ec 04             	sub    $0x4,%esp
801037c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801037ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801037d0:	75 76                	jne    80103848 <kfree+0x88>
801037d2:	81 fb 70 65 11 80    	cmp    $0x80116570,%ebx
801037d8:	72 6e                	jb     80103848 <kfree+0x88>
801037da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801037e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801037e5:	77 61                	ja     80103848 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801037e7:	83 ec 04             	sub    $0x4,%esp
801037ea:	68 00 10 00 00       	push   $0x1000
801037ef:	6a 01                	push   $0x1
801037f1:	53                   	push   %ebx
801037f2:	e8 69 21 00 00       	call   80105960 <memset>

  if(kmem.use_lock)
801037f7:	8b 15 14 27 11 80    	mov    0x80112714,%edx
801037fd:	83 c4 10             	add    $0x10,%esp
80103800:	85 d2                	test   %edx,%edx
80103802:	75 1c                	jne    80103820 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80103804:	a1 18 27 11 80       	mov    0x80112718,%eax
80103809:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010380b:	a1 14 27 11 80       	mov    0x80112714,%eax
  kmem.freelist = r;
80103810:	89 1d 18 27 11 80    	mov    %ebx,0x80112718
  if(kmem.use_lock)
80103816:	85 c0                	test   %eax,%eax
80103818:	75 1e                	jne    80103838 <kfree+0x78>
    release(&kmem.lock);
}
8010381a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010381d:	c9                   	leave  
8010381e:	c3                   	ret    
8010381f:	90                   	nop
    acquire(&kmem.lock);
80103820:	83 ec 0c             	sub    $0xc,%esp
80103823:	68 e0 26 11 80       	push   $0x801126e0
80103828:	e8 73 20 00 00       	call   801058a0 <acquire>
8010382d:	83 c4 10             	add    $0x10,%esp
80103830:	eb d2                	jmp    80103804 <kfree+0x44>
80103832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103838:	c7 45 08 e0 26 11 80 	movl   $0x801126e0,0x8(%ebp)
}
8010383f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103842:	c9                   	leave  
    release(&kmem.lock);
80103843:	e9 f8 1f 00 00       	jmp    80105840 <release>
    panic("kfree");
80103848:	83 ec 0c             	sub    $0xc,%esp
8010384b:	68 e2 87 10 80       	push   $0x801087e2
80103850:	e8 8b d4 ff ff       	call   80100ce0 <panic>
80103855:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010385c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103860 <freerange>:
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80103864:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103867:	8b 75 0c             	mov    0xc(%ebp),%esi
8010386a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010386b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103871:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103877:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010387d:	39 de                	cmp    %ebx,%esi
8010387f:	72 23                	jb     801038a4 <freerange+0x44>
80103881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103888:	83 ec 0c             	sub    $0xc,%esp
8010388b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103891:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103897:	50                   	push   %eax
80103898:	e8 23 ff ff ff       	call   801037c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010389d:	83 c4 10             	add    $0x10,%esp
801038a0:	39 f3                	cmp    %esi,%ebx
801038a2:	76 e4                	jbe    80103888 <freerange+0x28>
}
801038a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038a7:	5b                   	pop    %ebx
801038a8:	5e                   	pop    %esi
801038a9:	5d                   	pop    %ebp
801038aa:	c3                   	ret    
801038ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038af:	90                   	nop

801038b0 <kinit2>:
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801038b4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801038b7:	8b 75 0c             	mov    0xc(%ebp),%esi
801038ba:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801038bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801038c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801038c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801038cd:	39 de                	cmp    %ebx,%esi
801038cf:	72 23                	jb     801038f4 <kinit2+0x44>
801038d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801038d8:	83 ec 0c             	sub    $0xc,%esp
801038db:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801038e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801038e7:	50                   	push   %eax
801038e8:	e8 d3 fe ff ff       	call   801037c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801038ed:	83 c4 10             	add    $0x10,%esp
801038f0:	39 de                	cmp    %ebx,%esi
801038f2:	73 e4                	jae    801038d8 <kinit2+0x28>
  kmem.use_lock = 1;
801038f4:	c7 05 14 27 11 80 01 	movl   $0x1,0x80112714
801038fb:	00 00 00 
}
801038fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103901:	5b                   	pop    %ebx
80103902:	5e                   	pop    %esi
80103903:	5d                   	pop    %ebp
80103904:	c3                   	ret    
80103905:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010390c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103910 <kinit1>:
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	56                   	push   %esi
80103914:	53                   	push   %ebx
80103915:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80103918:	83 ec 08             	sub    $0x8,%esp
8010391b:	68 e8 87 10 80       	push   $0x801087e8
80103920:	68 e0 26 11 80       	push   $0x801126e0
80103925:	e8 a6 1d 00 00       	call   801056d0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010392a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010392d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103930:	c7 05 14 27 11 80 00 	movl   $0x0,0x80112714
80103937:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010393a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103940:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103946:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010394c:	39 de                	cmp    %ebx,%esi
8010394e:	72 1c                	jb     8010396c <kinit1+0x5c>
    kfree(p);
80103950:	83 ec 0c             	sub    $0xc,%esp
80103953:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103959:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010395f:	50                   	push   %eax
80103960:	e8 5b fe ff ff       	call   801037c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103965:	83 c4 10             	add    $0x10,%esp
80103968:	39 de                	cmp    %ebx,%esi
8010396a:	73 e4                	jae    80103950 <kinit1+0x40>
}
8010396c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010396f:	5b                   	pop    %ebx
80103970:	5e                   	pop    %esi
80103971:	5d                   	pop    %ebp
80103972:	c3                   	ret    
80103973:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010397a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103980 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80103980:	a1 14 27 11 80       	mov    0x80112714,%eax
80103985:	85 c0                	test   %eax,%eax
80103987:	75 1f                	jne    801039a8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80103989:	a1 18 27 11 80       	mov    0x80112718,%eax
  if(r)
8010398e:	85 c0                	test   %eax,%eax
80103990:	74 0e                	je     801039a0 <kalloc+0x20>
    kmem.freelist = r->next;
80103992:	8b 10                	mov    (%eax),%edx
80103994:	89 15 18 27 11 80    	mov    %edx,0x80112718
  if(kmem.use_lock)
8010399a:	c3                   	ret    
8010399b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010399f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801039a0:	c3                   	ret    
801039a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801039a8:	55                   	push   %ebp
801039a9:	89 e5                	mov    %esp,%ebp
801039ab:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801039ae:	68 e0 26 11 80       	push   $0x801126e0
801039b3:	e8 e8 1e 00 00       	call   801058a0 <acquire>
  r = kmem.freelist;
801039b8:	a1 18 27 11 80       	mov    0x80112718,%eax
  if(kmem.use_lock)
801039bd:	8b 15 14 27 11 80    	mov    0x80112714,%edx
  if(r)
801039c3:	83 c4 10             	add    $0x10,%esp
801039c6:	85 c0                	test   %eax,%eax
801039c8:	74 08                	je     801039d2 <kalloc+0x52>
    kmem.freelist = r->next;
801039ca:	8b 08                	mov    (%eax),%ecx
801039cc:	89 0d 18 27 11 80    	mov    %ecx,0x80112718
  if(kmem.use_lock)
801039d2:	85 d2                	test   %edx,%edx
801039d4:	74 16                	je     801039ec <kalloc+0x6c>
    release(&kmem.lock);
801039d6:	83 ec 0c             	sub    $0xc,%esp
801039d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801039dc:	68 e0 26 11 80       	push   $0x801126e0
801039e1:	e8 5a 1e 00 00       	call   80105840 <release>
  return (char*)r;
801039e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801039e9:	83 c4 10             	add    $0x10,%esp
}
801039ec:	c9                   	leave  
801039ed:	c3                   	ret    
801039ee:	66 90                	xchg   %ax,%ax

801039f0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801039f0:	ba 64 00 00 00       	mov    $0x64,%edx
801039f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801039f6:	a8 01                	test   $0x1,%al
801039f8:	0f 84 c2 00 00 00    	je     80103ac0 <kbdgetc+0xd0>
{
801039fe:	55                   	push   %ebp
801039ff:	ba 60 00 00 00       	mov    $0x60,%edx
80103a04:	89 e5                	mov    %esp,%ebp
80103a06:	53                   	push   %ebx
80103a07:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80103a08:	8b 1d 1c 27 11 80    	mov    0x8011271c,%ebx
  data = inb(KBDATAP);
80103a0e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80103a11:	3c e0                	cmp    $0xe0,%al
80103a13:	74 5b                	je     80103a70 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80103a15:	89 da                	mov    %ebx,%edx
80103a17:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
80103a1a:	84 c0                	test   %al,%al
80103a1c:	78 62                	js     80103a80 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80103a1e:	85 d2                	test   %edx,%edx
80103a20:	74 09                	je     80103a2b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103a22:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103a25:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80103a28:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80103a2b:	0f b6 91 20 89 10 80 	movzbl -0x7fef76e0(%ecx),%edx
  shift ^= togglecode[data];
80103a32:	0f b6 81 20 88 10 80 	movzbl -0x7fef77e0(%ecx),%eax
  shift |= shiftcode[data];
80103a39:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80103a3b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80103a3d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80103a3f:	89 15 1c 27 11 80    	mov    %edx,0x8011271c
  c = charcode[shift & (CTL | SHIFT)][data];
80103a45:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80103a48:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80103a4b:	8b 04 85 00 88 10 80 	mov    -0x7fef7800(,%eax,4),%eax
80103a52:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80103a56:	74 0b                	je     80103a63 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80103a58:	8d 50 9f             	lea    -0x61(%eax),%edx
80103a5b:	83 fa 19             	cmp    $0x19,%edx
80103a5e:	77 48                	ja     80103aa8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80103a60:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103a63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a66:	c9                   	leave  
80103a67:	c3                   	ret    
80103a68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a6f:	90                   	nop
    shift |= E0ESC;
80103a70:	83 cb 40             	or     $0x40,%ebx
    return 0;
80103a73:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80103a75:	89 1d 1c 27 11 80    	mov    %ebx,0x8011271c
}
80103a7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a7e:	c9                   	leave  
80103a7f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80103a80:	83 e0 7f             	and    $0x7f,%eax
80103a83:	85 d2                	test   %edx,%edx
80103a85:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80103a88:	0f b6 81 20 89 10 80 	movzbl -0x7fef76e0(%ecx),%eax
80103a8f:	83 c8 40             	or     $0x40,%eax
80103a92:	0f b6 c0             	movzbl %al,%eax
80103a95:	f7 d0                	not    %eax
80103a97:	21 d8                	and    %ebx,%eax
}
80103a99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
80103a9c:	a3 1c 27 11 80       	mov    %eax,0x8011271c
    return 0;
80103aa1:	31 c0                	xor    %eax,%eax
}
80103aa3:	c9                   	leave  
80103aa4:	c3                   	ret    
80103aa5:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80103aa8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80103aab:	8d 50 20             	lea    0x20(%eax),%edx
}
80103aae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ab1:	c9                   	leave  
      c += 'a' - 'A';
80103ab2:	83 f9 1a             	cmp    $0x1a,%ecx
80103ab5:	0f 42 c2             	cmovb  %edx,%eax
}
80103ab8:	c3                   	ret    
80103ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80103ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103ac5:	c3                   	ret    
80103ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103acd:	8d 76 00             	lea    0x0(%esi),%esi

80103ad0 <kbdintr>:

void
kbdintr(void)
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80103ad6:	68 f0 39 10 80       	push   $0x801039f0
80103adb:	e8 70 d8 ff ff       	call   80101350 <consoleintr>
}
80103ae0:	83 c4 10             	add    $0x10,%esp
80103ae3:	c9                   	leave  
80103ae4:	c3                   	ret    
80103ae5:	66 90                	xchg   %ax,%ax
80103ae7:	66 90                	xchg   %ax,%ax
80103ae9:	66 90                	xchg   %ax,%ax
80103aeb:	66 90                	xchg   %ax,%ax
80103aed:	66 90                	xchg   %ax,%ax
80103aef:	90                   	nop

80103af0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80103af0:	a1 20 27 11 80       	mov    0x80112720,%eax
80103af5:	85 c0                	test   %eax,%eax
80103af7:	0f 84 cb 00 00 00    	je     80103bc8 <lapicinit+0xd8>
  lapic[index] = value;
80103afd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103b04:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103b07:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b0a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103b11:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103b14:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b17:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80103b1e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103b21:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b24:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80103b2b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80103b2e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b31:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103b38:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103b3b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b3e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103b45:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103b48:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80103b4b:	8b 50 30             	mov    0x30(%eax),%edx
80103b4e:	c1 ea 10             	shr    $0x10,%edx
80103b51:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80103b57:	75 77                	jne    80103bd0 <lapicinit+0xe0>
  lapic[index] = value;
80103b59:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80103b60:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103b63:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b66:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80103b6d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103b70:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b73:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80103b7a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103b7d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b80:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103b87:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103b8a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b8d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103b94:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103b97:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103b9a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80103ba1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80103ba4:	8b 50 20             	mov    0x20(%eax),%edx
80103ba7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bae:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80103bb0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80103bb6:	80 e6 10             	and    $0x10,%dh
80103bb9:	75 f5                	jne    80103bb0 <lapicinit+0xc0>
  lapic[index] = value;
80103bbb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80103bc2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103bc5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103bc8:	c3                   	ret    
80103bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80103bd0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80103bd7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103bda:	8b 50 20             	mov    0x20(%eax),%edx
}
80103bdd:	e9 77 ff ff ff       	jmp    80103b59 <lapicinit+0x69>
80103be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103bf0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80103bf0:	a1 20 27 11 80       	mov    0x80112720,%eax
80103bf5:	85 c0                	test   %eax,%eax
80103bf7:	74 07                	je     80103c00 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80103bf9:	8b 40 20             	mov    0x20(%eax),%eax
80103bfc:	c1 e8 18             	shr    $0x18,%eax
80103bff:	c3                   	ret    
    return 0;
80103c00:	31 c0                	xor    %eax,%eax
}
80103c02:	c3                   	ret    
80103c03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103c10 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80103c10:	a1 20 27 11 80       	mov    0x80112720,%eax
80103c15:	85 c0                	test   %eax,%eax
80103c17:	74 0d                	je     80103c26 <lapiceoi+0x16>
  lapic[index] = value;
80103c19:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103c20:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103c23:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80103c26:	c3                   	ret    
80103c27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c2e:	66 90                	xchg   %ax,%ax

80103c30 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103c30:	c3                   	ret    
80103c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c3f:	90                   	nop

80103c40 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103c40:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103c41:	b8 0f 00 00 00       	mov    $0xf,%eax
80103c46:	ba 70 00 00 00       	mov    $0x70,%edx
80103c4b:	89 e5                	mov    %esp,%ebp
80103c4d:	53                   	push   %ebx
80103c4e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103c51:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103c54:	ee                   	out    %al,(%dx)
80103c55:	b8 0a 00 00 00       	mov    $0xa,%eax
80103c5a:	ba 71 00 00 00       	mov    $0x71,%edx
80103c5f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103c60:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103c62:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103c65:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80103c6b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80103c6d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80103c70:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103c72:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103c75:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103c78:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80103c7e:	a1 20 27 11 80       	mov    0x80112720,%eax
80103c83:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103c89:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103c8c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103c93:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103c96:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103c99:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103ca0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103ca3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103ca6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103cac:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103caf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103cb5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103cb8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103cbe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103cc1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103cc7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80103cca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ccd:	c9                   	leave  
80103cce:	c3                   	ret    
80103ccf:	90                   	nop

80103cd0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103cd0:	55                   	push   %ebp
80103cd1:	b8 0b 00 00 00       	mov    $0xb,%eax
80103cd6:	ba 70 00 00 00       	mov    $0x70,%edx
80103cdb:	89 e5                	mov    %esp,%ebp
80103cdd:	57                   	push   %edi
80103cde:	56                   	push   %esi
80103cdf:	53                   	push   %ebx
80103ce0:	83 ec 4c             	sub    $0x4c,%esp
80103ce3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103ce4:	ba 71 00 00 00       	mov    $0x71,%edx
80103ce9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80103cea:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ced:	bb 70 00 00 00       	mov    $0x70,%ebx
80103cf2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103cf5:	8d 76 00             	lea    0x0(%esi),%esi
80103cf8:	31 c0                	xor    %eax,%eax
80103cfa:	89 da                	mov    %ebx,%edx
80103cfc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103cfd:	b9 71 00 00 00       	mov    $0x71,%ecx
80103d02:	89 ca                	mov    %ecx,%edx
80103d04:	ec                   	in     (%dx),%al
80103d05:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d08:	89 da                	mov    %ebx,%edx
80103d0a:	b8 02 00 00 00       	mov    $0x2,%eax
80103d0f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d10:	89 ca                	mov    %ecx,%edx
80103d12:	ec                   	in     (%dx),%al
80103d13:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d16:	89 da                	mov    %ebx,%edx
80103d18:	b8 04 00 00 00       	mov    $0x4,%eax
80103d1d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d1e:	89 ca                	mov    %ecx,%edx
80103d20:	ec                   	in     (%dx),%al
80103d21:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d24:	89 da                	mov    %ebx,%edx
80103d26:	b8 07 00 00 00       	mov    $0x7,%eax
80103d2b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d2c:	89 ca                	mov    %ecx,%edx
80103d2e:	ec                   	in     (%dx),%al
80103d2f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d32:	89 da                	mov    %ebx,%edx
80103d34:	b8 08 00 00 00       	mov    $0x8,%eax
80103d39:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d3a:	89 ca                	mov    %ecx,%edx
80103d3c:	ec                   	in     (%dx),%al
80103d3d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d3f:	89 da                	mov    %ebx,%edx
80103d41:	b8 09 00 00 00       	mov    $0x9,%eax
80103d46:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d47:	89 ca                	mov    %ecx,%edx
80103d49:	ec                   	in     (%dx),%al
80103d4a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d4c:	89 da                	mov    %ebx,%edx
80103d4e:	b8 0a 00 00 00       	mov    $0xa,%eax
80103d53:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d54:	89 ca                	mov    %ecx,%edx
80103d56:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103d57:	84 c0                	test   %al,%al
80103d59:	78 9d                	js     80103cf8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80103d5b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103d5f:	89 fa                	mov    %edi,%edx
80103d61:	0f b6 fa             	movzbl %dl,%edi
80103d64:	89 f2                	mov    %esi,%edx
80103d66:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103d69:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103d6d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d70:	89 da                	mov    %ebx,%edx
80103d72:	89 7d c8             	mov    %edi,-0x38(%ebp)
80103d75:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103d78:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80103d7c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80103d7f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103d82:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103d86:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103d89:	31 c0                	xor    %eax,%eax
80103d8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d8c:	89 ca                	mov    %ecx,%edx
80103d8e:	ec                   	in     (%dx),%al
80103d8f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d92:	89 da                	mov    %ebx,%edx
80103d94:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103d97:	b8 02 00 00 00       	mov    $0x2,%eax
80103d9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d9d:	89 ca                	mov    %ecx,%edx
80103d9f:	ec                   	in     (%dx),%al
80103da0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103da3:	89 da                	mov    %ebx,%edx
80103da5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103da8:	b8 04 00 00 00       	mov    $0x4,%eax
80103dad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103dae:	89 ca                	mov    %ecx,%edx
80103db0:	ec                   	in     (%dx),%al
80103db1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103db4:	89 da                	mov    %ebx,%edx
80103db6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103db9:	b8 07 00 00 00       	mov    $0x7,%eax
80103dbe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103dbf:	89 ca                	mov    %ecx,%edx
80103dc1:	ec                   	in     (%dx),%al
80103dc2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103dc5:	89 da                	mov    %ebx,%edx
80103dc7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80103dca:	b8 08 00 00 00       	mov    $0x8,%eax
80103dcf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103dd0:	89 ca                	mov    %ecx,%edx
80103dd2:	ec                   	in     (%dx),%al
80103dd3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103dd6:	89 da                	mov    %ebx,%edx
80103dd8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103ddb:	b8 09 00 00 00       	mov    $0x9,%eax
80103de0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103de1:	89 ca                	mov    %ecx,%edx
80103de3:	ec                   	in     (%dx),%al
80103de4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103de7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80103dea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103ded:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103df0:	6a 18                	push   $0x18
80103df2:	50                   	push   %eax
80103df3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103df6:	50                   	push   %eax
80103df7:	e8 b4 1b 00 00       	call   801059b0 <memcmp>
80103dfc:	83 c4 10             	add    $0x10,%esp
80103dff:	85 c0                	test   %eax,%eax
80103e01:	0f 85 f1 fe ff ff    	jne    80103cf8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103e07:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80103e0b:	75 78                	jne    80103e85 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103e0d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103e10:	89 c2                	mov    %eax,%edx
80103e12:	83 e0 0f             	and    $0xf,%eax
80103e15:	c1 ea 04             	shr    $0x4,%edx
80103e18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103e1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103e1e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103e21:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103e24:	89 c2                	mov    %eax,%edx
80103e26:	83 e0 0f             	and    $0xf,%eax
80103e29:	c1 ea 04             	shr    $0x4,%edx
80103e2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103e2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103e32:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103e35:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103e38:	89 c2                	mov    %eax,%edx
80103e3a:	83 e0 0f             	and    $0xf,%eax
80103e3d:	c1 ea 04             	shr    $0x4,%edx
80103e40:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103e43:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103e46:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103e49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103e4c:	89 c2                	mov    %eax,%edx
80103e4e:	83 e0 0f             	and    $0xf,%eax
80103e51:	c1 ea 04             	shr    $0x4,%edx
80103e54:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103e57:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103e5a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103e5d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103e60:	89 c2                	mov    %eax,%edx
80103e62:	83 e0 0f             	and    $0xf,%eax
80103e65:	c1 ea 04             	shr    $0x4,%edx
80103e68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103e6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103e6e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103e71:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103e74:	89 c2                	mov    %eax,%edx
80103e76:	83 e0 0f             	and    $0xf,%eax
80103e79:	c1 ea 04             	shr    $0x4,%edx
80103e7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103e7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103e82:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103e85:	8b 75 08             	mov    0x8(%ebp),%esi
80103e88:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103e8b:	89 06                	mov    %eax,(%esi)
80103e8d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103e90:	89 46 04             	mov    %eax,0x4(%esi)
80103e93:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103e96:	89 46 08             	mov    %eax,0x8(%esi)
80103e99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103e9c:	89 46 0c             	mov    %eax,0xc(%esi)
80103e9f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103ea2:	89 46 10             	mov    %eax,0x10(%esi)
80103ea5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103ea8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80103eab:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80103eb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103eb5:	5b                   	pop    %ebx
80103eb6:	5e                   	pop    %esi
80103eb7:	5f                   	pop    %edi
80103eb8:	5d                   	pop    %ebp
80103eb9:	c3                   	ret    
80103eba:	66 90                	xchg   %ax,%ax
80103ebc:	66 90                	xchg   %ax,%ax
80103ebe:	66 90                	xchg   %ax,%ax

80103ec0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103ec0:	8b 0d 88 27 11 80    	mov    0x80112788,%ecx
80103ec6:	85 c9                	test   %ecx,%ecx
80103ec8:	0f 8e 8a 00 00 00    	jle    80103f58 <install_trans+0x98>
{
80103ece:	55                   	push   %ebp
80103ecf:	89 e5                	mov    %esp,%ebp
80103ed1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103ed2:	31 ff                	xor    %edi,%edi
{
80103ed4:	56                   	push   %esi
80103ed5:	53                   	push   %ebx
80103ed6:	83 ec 0c             	sub    $0xc,%esp
80103ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103ee0:	a1 74 27 11 80       	mov    0x80112774,%eax
80103ee5:	83 ec 08             	sub    $0x8,%esp
80103ee8:	01 f8                	add    %edi,%eax
80103eea:	83 c0 01             	add    $0x1,%eax
80103eed:	50                   	push   %eax
80103eee:	ff 35 84 27 11 80    	push   0x80112784
80103ef4:	e8 d7 c1 ff ff       	call   801000d0 <bread>
80103ef9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103efb:	58                   	pop    %eax
80103efc:	5a                   	pop    %edx
80103efd:	ff 34 bd 8c 27 11 80 	push   -0x7feed874(,%edi,4)
80103f04:	ff 35 84 27 11 80    	push   0x80112784
  for (tail = 0; tail < log.lh.n; tail++) {
80103f0a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103f0d:	e8 be c1 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103f12:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103f15:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103f17:	8d 46 5c             	lea    0x5c(%esi),%eax
80103f1a:	68 00 02 00 00       	push   $0x200
80103f1f:	50                   	push   %eax
80103f20:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103f23:	50                   	push   %eax
80103f24:	e8 d7 1a 00 00       	call   80105a00 <memmove>
    bwrite(dbuf);  // write dst to disk
80103f29:	89 1c 24             	mov    %ebx,(%esp)
80103f2c:	e8 7f c2 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103f31:	89 34 24             	mov    %esi,(%esp)
80103f34:	e8 b7 c2 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103f39:	89 1c 24             	mov    %ebx,(%esp)
80103f3c:	e8 af c2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103f41:	83 c4 10             	add    $0x10,%esp
80103f44:	39 3d 88 27 11 80    	cmp    %edi,0x80112788
80103f4a:	7f 94                	jg     80103ee0 <install_trans+0x20>
  }
}
80103f4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f4f:	5b                   	pop    %ebx
80103f50:	5e                   	pop    %esi
80103f51:	5f                   	pop    %edi
80103f52:	5d                   	pop    %ebp
80103f53:	c3                   	ret    
80103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f58:	c3                   	ret    
80103f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103f60:	55                   	push   %ebp
80103f61:	89 e5                	mov    %esp,%ebp
80103f63:	53                   	push   %ebx
80103f64:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103f67:	ff 35 74 27 11 80    	push   0x80112774
80103f6d:	ff 35 84 27 11 80    	push   0x80112784
80103f73:	e8 58 c1 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103f78:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80103f7b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80103f7d:	a1 88 27 11 80       	mov    0x80112788,%eax
80103f82:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103f85:	85 c0                	test   %eax,%eax
80103f87:	7e 19                	jle    80103fa2 <write_head+0x42>
80103f89:	31 d2                	xor    %edx,%edx
80103f8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f8f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103f90:	8b 0c 95 8c 27 11 80 	mov    -0x7feed874(,%edx,4),%ecx
80103f97:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103f9b:	83 c2 01             	add    $0x1,%edx
80103f9e:	39 d0                	cmp    %edx,%eax
80103fa0:	75 ee                	jne    80103f90 <write_head+0x30>
  }
  bwrite(buf);
80103fa2:	83 ec 0c             	sub    $0xc,%esp
80103fa5:	53                   	push   %ebx
80103fa6:	e8 05 c2 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80103fab:	89 1c 24             	mov    %ebx,(%esp)
80103fae:	e8 3d c2 ff ff       	call   801001f0 <brelse>
}
80103fb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fb6:	83 c4 10             	add    $0x10,%esp
80103fb9:	c9                   	leave  
80103fba:	c3                   	ret    
80103fbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fbf:	90                   	nop

80103fc0 <initlog>:
{
80103fc0:	55                   	push   %ebp
80103fc1:	89 e5                	mov    %esp,%ebp
80103fc3:	53                   	push   %ebx
80103fc4:	83 ec 2c             	sub    $0x2c,%esp
80103fc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80103fca:	68 20 8a 10 80       	push   $0x80108a20
80103fcf:	68 40 27 11 80       	push   $0x80112740
80103fd4:	e8 f7 16 00 00       	call   801056d0 <initlock>
  readsb(dev, &sb);
80103fd9:	58                   	pop    %eax
80103fda:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103fdd:	5a                   	pop    %edx
80103fde:	50                   	push   %eax
80103fdf:	53                   	push   %ebx
80103fe0:	e8 3b e8 ff ff       	call   80102820 <readsb>
  log.start = sb.logstart;
80103fe5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103fe8:	59                   	pop    %ecx
  log.dev = dev;
80103fe9:	89 1d 84 27 11 80    	mov    %ebx,0x80112784
  log.size = sb.nlog;
80103fef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103ff2:	a3 74 27 11 80       	mov    %eax,0x80112774
  log.size = sb.nlog;
80103ff7:	89 15 78 27 11 80    	mov    %edx,0x80112778
  struct buf *buf = bread(log.dev, log.start);
80103ffd:	5a                   	pop    %edx
80103ffe:	50                   	push   %eax
80103fff:	53                   	push   %ebx
80104000:	e8 cb c0 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80104005:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80104008:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010400b:	89 1d 88 27 11 80    	mov    %ebx,0x80112788
  for (i = 0; i < log.lh.n; i++) {
80104011:	85 db                	test   %ebx,%ebx
80104013:	7e 1d                	jle    80104032 <initlog+0x72>
80104015:	31 d2                	xor    %edx,%edx
80104017:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010401e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80104020:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80104024:	89 0c 95 8c 27 11 80 	mov    %ecx,-0x7feed874(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010402b:	83 c2 01             	add    $0x1,%edx
8010402e:	39 d3                	cmp    %edx,%ebx
80104030:	75 ee                	jne    80104020 <initlog+0x60>
  brelse(buf);
80104032:	83 ec 0c             	sub    $0xc,%esp
80104035:	50                   	push   %eax
80104036:	e8 b5 c1 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010403b:	e8 80 fe ff ff       	call   80103ec0 <install_trans>
  log.lh.n = 0;
80104040:	c7 05 88 27 11 80 00 	movl   $0x0,0x80112788
80104047:	00 00 00 
  write_head(); // clear the log
8010404a:	e8 11 ff ff ff       	call   80103f60 <write_head>
}
8010404f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104052:	83 c4 10             	add    $0x10,%esp
80104055:	c9                   	leave  
80104056:	c3                   	ret    
80104057:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010405e:	66 90                	xchg   %ax,%ax

80104060 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80104066:	68 40 27 11 80       	push   $0x80112740
8010406b:	e8 30 18 00 00       	call   801058a0 <acquire>
80104070:	83 c4 10             	add    $0x10,%esp
80104073:	eb 18                	jmp    8010408d <begin_op+0x2d>
80104075:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80104078:	83 ec 08             	sub    $0x8,%esp
8010407b:	68 40 27 11 80       	push   $0x80112740
80104080:	68 40 27 11 80       	push   $0x80112740
80104085:	e8 b6 12 00 00       	call   80105340 <sleep>
8010408a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010408d:	a1 80 27 11 80       	mov    0x80112780,%eax
80104092:	85 c0                	test   %eax,%eax
80104094:	75 e2                	jne    80104078 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80104096:	a1 7c 27 11 80       	mov    0x8011277c,%eax
8010409b:	8b 15 88 27 11 80    	mov    0x80112788,%edx
801040a1:	83 c0 01             	add    $0x1,%eax
801040a4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801040a7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801040aa:	83 fa 1e             	cmp    $0x1e,%edx
801040ad:	7f c9                	jg     80104078 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801040af:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801040b2:	a3 7c 27 11 80       	mov    %eax,0x8011277c
      release(&log.lock);
801040b7:	68 40 27 11 80       	push   $0x80112740
801040bc:	e8 7f 17 00 00       	call   80105840 <release>
      break;
    }
  }
}
801040c1:	83 c4 10             	add    $0x10,%esp
801040c4:	c9                   	leave  
801040c5:	c3                   	ret    
801040c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040cd:	8d 76 00             	lea    0x0(%esi),%esi

801040d0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	57                   	push   %edi
801040d4:	56                   	push   %esi
801040d5:	53                   	push   %ebx
801040d6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801040d9:	68 40 27 11 80       	push   $0x80112740
801040de:	e8 bd 17 00 00       	call   801058a0 <acquire>
  log.outstanding -= 1;
801040e3:	a1 7c 27 11 80       	mov    0x8011277c,%eax
  if(log.committing)
801040e8:	8b 35 80 27 11 80    	mov    0x80112780,%esi
801040ee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801040f1:	8d 58 ff             	lea    -0x1(%eax),%ebx
801040f4:	89 1d 7c 27 11 80    	mov    %ebx,0x8011277c
  if(log.committing)
801040fa:	85 f6                	test   %esi,%esi
801040fc:	0f 85 22 01 00 00    	jne    80104224 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80104102:	85 db                	test   %ebx,%ebx
80104104:	0f 85 f6 00 00 00    	jne    80104200 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010410a:	c7 05 80 27 11 80 01 	movl   $0x1,0x80112780
80104111:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80104114:	83 ec 0c             	sub    $0xc,%esp
80104117:	68 40 27 11 80       	push   $0x80112740
8010411c:	e8 1f 17 00 00       	call   80105840 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80104121:	8b 0d 88 27 11 80    	mov    0x80112788,%ecx
80104127:	83 c4 10             	add    $0x10,%esp
8010412a:	85 c9                	test   %ecx,%ecx
8010412c:	7f 42                	jg     80104170 <end_op+0xa0>
    acquire(&log.lock);
8010412e:	83 ec 0c             	sub    $0xc,%esp
80104131:	68 40 27 11 80       	push   $0x80112740
80104136:	e8 65 17 00 00       	call   801058a0 <acquire>
    wakeup(&log);
8010413b:	c7 04 24 40 27 11 80 	movl   $0x80112740,(%esp)
    log.committing = 0;
80104142:	c7 05 80 27 11 80 00 	movl   $0x0,0x80112780
80104149:	00 00 00 
    wakeup(&log);
8010414c:	e8 af 12 00 00       	call   80105400 <wakeup>
    release(&log.lock);
80104151:	c7 04 24 40 27 11 80 	movl   $0x80112740,(%esp)
80104158:	e8 e3 16 00 00       	call   80105840 <release>
8010415d:	83 c4 10             	add    $0x10,%esp
}
80104160:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104163:	5b                   	pop    %ebx
80104164:	5e                   	pop    %esi
80104165:	5f                   	pop    %edi
80104166:	5d                   	pop    %ebp
80104167:	c3                   	ret    
80104168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010416f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80104170:	a1 74 27 11 80       	mov    0x80112774,%eax
80104175:	83 ec 08             	sub    $0x8,%esp
80104178:	01 d8                	add    %ebx,%eax
8010417a:	83 c0 01             	add    $0x1,%eax
8010417d:	50                   	push   %eax
8010417e:	ff 35 84 27 11 80    	push   0x80112784
80104184:	e8 47 bf ff ff       	call   801000d0 <bread>
80104189:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010418b:	58                   	pop    %eax
8010418c:	5a                   	pop    %edx
8010418d:	ff 34 9d 8c 27 11 80 	push   -0x7feed874(,%ebx,4)
80104194:	ff 35 84 27 11 80    	push   0x80112784
  for (tail = 0; tail < log.lh.n; tail++) {
8010419a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010419d:	e8 2e bf ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
801041a2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801041a5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801041a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801041aa:	68 00 02 00 00       	push   $0x200
801041af:	50                   	push   %eax
801041b0:	8d 46 5c             	lea    0x5c(%esi),%eax
801041b3:	50                   	push   %eax
801041b4:	e8 47 18 00 00       	call   80105a00 <memmove>
    bwrite(to);  // write the log
801041b9:	89 34 24             	mov    %esi,(%esp)
801041bc:	e8 ef bf ff ff       	call   801001b0 <bwrite>
    brelse(from);
801041c1:	89 3c 24             	mov    %edi,(%esp)
801041c4:	e8 27 c0 ff ff       	call   801001f0 <brelse>
    brelse(to);
801041c9:	89 34 24             	mov    %esi,(%esp)
801041cc:	e8 1f c0 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801041d1:	83 c4 10             	add    $0x10,%esp
801041d4:	3b 1d 88 27 11 80    	cmp    0x80112788,%ebx
801041da:	7c 94                	jl     80104170 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801041dc:	e8 7f fd ff ff       	call   80103f60 <write_head>
    install_trans(); // Now install writes to home locations
801041e1:	e8 da fc ff ff       	call   80103ec0 <install_trans>
    log.lh.n = 0;
801041e6:	c7 05 88 27 11 80 00 	movl   $0x0,0x80112788
801041ed:	00 00 00 
    write_head();    // Erase the transaction from the log
801041f0:	e8 6b fd ff ff       	call   80103f60 <write_head>
801041f5:	e9 34 ff ff ff       	jmp    8010412e <end_op+0x5e>
801041fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80104200:	83 ec 0c             	sub    $0xc,%esp
80104203:	68 40 27 11 80       	push   $0x80112740
80104208:	e8 f3 11 00 00       	call   80105400 <wakeup>
  release(&log.lock);
8010420d:	c7 04 24 40 27 11 80 	movl   $0x80112740,(%esp)
80104214:	e8 27 16 00 00       	call   80105840 <release>
80104219:	83 c4 10             	add    $0x10,%esp
}
8010421c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010421f:	5b                   	pop    %ebx
80104220:	5e                   	pop    %esi
80104221:	5f                   	pop    %edi
80104222:	5d                   	pop    %ebp
80104223:	c3                   	ret    
    panic("log.committing");
80104224:	83 ec 0c             	sub    $0xc,%esp
80104227:	68 24 8a 10 80       	push   $0x80108a24
8010422c:	e8 af ca ff ff       	call   80100ce0 <panic>
80104231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010423f:	90                   	nop

80104240 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	53                   	push   %ebx
80104244:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80104247:	8b 15 88 27 11 80    	mov    0x80112788,%edx
{
8010424d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80104250:	83 fa 1d             	cmp    $0x1d,%edx
80104253:	0f 8f 85 00 00 00    	jg     801042de <log_write+0x9e>
80104259:	a1 78 27 11 80       	mov    0x80112778,%eax
8010425e:	83 e8 01             	sub    $0x1,%eax
80104261:	39 c2                	cmp    %eax,%edx
80104263:	7d 79                	jge    801042de <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80104265:	a1 7c 27 11 80       	mov    0x8011277c,%eax
8010426a:	85 c0                	test   %eax,%eax
8010426c:	7e 7d                	jle    801042eb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010426e:	83 ec 0c             	sub    $0xc,%esp
80104271:	68 40 27 11 80       	push   $0x80112740
80104276:	e8 25 16 00 00       	call   801058a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
8010427b:	8b 15 88 27 11 80    	mov    0x80112788,%edx
80104281:	83 c4 10             	add    $0x10,%esp
80104284:	85 d2                	test   %edx,%edx
80104286:	7e 4a                	jle    801042d2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80104288:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010428b:	31 c0                	xor    %eax,%eax
8010428d:	eb 08                	jmp    80104297 <log_write+0x57>
8010428f:	90                   	nop
80104290:	83 c0 01             	add    $0x1,%eax
80104293:	39 c2                	cmp    %eax,%edx
80104295:	74 29                	je     801042c0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80104297:	39 0c 85 8c 27 11 80 	cmp    %ecx,-0x7feed874(,%eax,4)
8010429e:	75 f0                	jne    80104290 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
801042a0:	89 0c 85 8c 27 11 80 	mov    %ecx,-0x7feed874(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
801042a7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
801042aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
801042ad:	c7 45 08 40 27 11 80 	movl   $0x80112740,0x8(%ebp)
}
801042b4:	c9                   	leave  
  release(&log.lock);
801042b5:	e9 86 15 00 00       	jmp    80105840 <release>
801042ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801042c0:	89 0c 95 8c 27 11 80 	mov    %ecx,-0x7feed874(,%edx,4)
    log.lh.n++;
801042c7:	83 c2 01             	add    $0x1,%edx
801042ca:	89 15 88 27 11 80    	mov    %edx,0x80112788
801042d0:	eb d5                	jmp    801042a7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
801042d2:	8b 43 08             	mov    0x8(%ebx),%eax
801042d5:	a3 8c 27 11 80       	mov    %eax,0x8011278c
  if (i == log.lh.n)
801042da:	75 cb                	jne    801042a7 <log_write+0x67>
801042dc:	eb e9                	jmp    801042c7 <log_write+0x87>
    panic("too big a transaction");
801042de:	83 ec 0c             	sub    $0xc,%esp
801042e1:	68 33 8a 10 80       	push   $0x80108a33
801042e6:	e8 f5 c9 ff ff       	call   80100ce0 <panic>
    panic("log_write outside of trans");
801042eb:	83 ec 0c             	sub    $0xc,%esp
801042ee:	68 49 8a 10 80       	push   $0x80108a49
801042f3:	e8 e8 c9 ff ff       	call   80100ce0 <panic>
801042f8:	66 90                	xchg   %ax,%ax
801042fa:	66 90                	xchg   %ax,%ax
801042fc:	66 90                	xchg   %ax,%ax
801042fe:	66 90                	xchg   %ax,%ax

80104300 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	53                   	push   %ebx
80104304:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80104307:	e8 44 09 00 00       	call   80104c50 <cpuid>
8010430c:	89 c3                	mov    %eax,%ebx
8010430e:	e8 3d 09 00 00       	call   80104c50 <cpuid>
80104313:	83 ec 04             	sub    $0x4,%esp
80104316:	53                   	push   %ebx
80104317:	50                   	push   %eax
80104318:	68 64 8a 10 80       	push   $0x80108a64
8010431d:	e8 3e c7 ff ff       	call   80100a60 <cprintf>
  idtinit();       // load idt register
80104322:	e8 b9 28 00 00       	call   80106be0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80104327:	e8 c4 08 00 00       	call   80104bf0 <mycpu>
8010432c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010432e:	b8 01 00 00 00       	mov    $0x1,%eax
80104333:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010433a:	e8 f1 0b 00 00       	call   80104f30 <scheduler>
8010433f:	90                   	nop

80104340 <mpenter>:
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80104346:	e8 85 39 00 00       	call   80107cd0 <switchkvm>
  seginit();
8010434b:	e8 f0 38 00 00       	call   80107c40 <seginit>
  lapicinit();
80104350:	e8 9b f7 ff ff       	call   80103af0 <lapicinit>
  mpmain();
80104355:	e8 a6 ff ff ff       	call   80104300 <mpmain>
8010435a:	66 90                	xchg   %ax,%ax
8010435c:	66 90                	xchg   %ax,%ax
8010435e:	66 90                	xchg   %ax,%ax

80104360 <main>:
{
80104360:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80104364:	83 e4 f0             	and    $0xfffffff0,%esp
80104367:	ff 71 fc             	push   -0x4(%ecx)
8010436a:	55                   	push   %ebp
8010436b:	89 e5                	mov    %esp,%ebp
8010436d:	53                   	push   %ebx
8010436e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010436f:	83 ec 08             	sub    $0x8,%esp
80104372:	68 00 00 40 80       	push   $0x80400000
80104377:	68 70 65 11 80       	push   $0x80116570
8010437c:	e8 8f f5 ff ff       	call   80103910 <kinit1>
  kvmalloc();      // kernel page table
80104381:	e8 3a 3e 00 00       	call   801081c0 <kvmalloc>
  mpinit();        // detect other processors
80104386:	e8 85 01 00 00       	call   80104510 <mpinit>
  lapicinit();     // interrupt controller
8010438b:	e8 60 f7 ff ff       	call   80103af0 <lapicinit>
  seginit();       // segment descriptors
80104390:	e8 ab 38 00 00       	call   80107c40 <seginit>
  picinit();       // disable pic
80104395:	e8 76 03 00 00       	call   80104710 <picinit>
  ioapicinit();    // another interrupt controller
8010439a:	e8 31 f3 ff ff       	call   801036d0 <ioapicinit>
  consoleinit();   // console hardware
8010439f:	e8 6c cb ff ff       	call   80100f10 <consoleinit>
  uartinit();      // serial port
801043a4:	e8 27 2b 00 00       	call   80106ed0 <uartinit>
  pinit();         // process table
801043a9:	e8 22 08 00 00       	call   80104bd0 <pinit>
  tvinit();        // trap vectors
801043ae:	e8 ad 27 00 00       	call   80106b60 <tvinit>
  binit();         // buffer cache
801043b3:	e8 88 bc ff ff       	call   80100040 <binit>
  fileinit();      // file table
801043b8:	e8 53 dd ff ff       	call   80102110 <fileinit>
  ideinit();       // disk 
801043bd:	e8 fe f0 ff ff       	call   801034c0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801043c2:	83 c4 0c             	add    $0xc,%esp
801043c5:	68 8a 00 00 00       	push   $0x8a
801043ca:	68 8c b4 10 80       	push   $0x8010b48c
801043cf:	68 00 70 00 80       	push   $0x80007000
801043d4:	e8 27 16 00 00       	call   80105a00 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801043d9:	83 c4 10             	add    $0x10,%esp
801043dc:	69 05 24 28 11 80 b0 	imul   $0xb0,0x80112824,%eax
801043e3:	00 00 00 
801043e6:	05 40 28 11 80       	add    $0x80112840,%eax
801043eb:	3d 40 28 11 80       	cmp    $0x80112840,%eax
801043f0:	76 7e                	jbe    80104470 <main+0x110>
801043f2:	bb 40 28 11 80       	mov    $0x80112840,%ebx
801043f7:	eb 20                	jmp    80104419 <main+0xb9>
801043f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104400:	69 05 24 28 11 80 b0 	imul   $0xb0,0x80112824,%eax
80104407:	00 00 00 
8010440a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80104410:	05 40 28 11 80       	add    $0x80112840,%eax
80104415:	39 c3                	cmp    %eax,%ebx
80104417:	73 57                	jae    80104470 <main+0x110>
    if(c == mycpu())  // We've started already.
80104419:	e8 d2 07 00 00       	call   80104bf0 <mycpu>
8010441e:	39 c3                	cmp    %eax,%ebx
80104420:	74 de                	je     80104400 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80104422:	e8 59 f5 ff ff       	call   80103980 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80104427:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010442a:	c7 05 f8 6f 00 80 40 	movl   $0x80104340,0x80006ff8
80104431:	43 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80104434:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010443b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010443e:	05 00 10 00 00       	add    $0x1000,%eax
80104443:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80104448:	0f b6 03             	movzbl (%ebx),%eax
8010444b:	68 00 70 00 00       	push   $0x7000
80104450:	50                   	push   %eax
80104451:	e8 ea f7 ff ff       	call   80103c40 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80104456:	83 c4 10             	add    $0x10,%esp
80104459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104460:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80104466:	85 c0                	test   %eax,%eax
80104468:	74 f6                	je     80104460 <main+0x100>
8010446a:	eb 94                	jmp    80104400 <main+0xa0>
8010446c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80104470:	83 ec 08             	sub    $0x8,%esp
80104473:	68 00 00 00 8e       	push   $0x8e000000
80104478:	68 00 00 40 80       	push   $0x80400000
8010447d:	e8 2e f4 ff ff       	call   801038b0 <kinit2>
  userinit();      // first user process
80104482:	e8 19 08 00 00       	call   80104ca0 <userinit>
  mpmain();        // finish this processor's setup
80104487:	e8 74 fe ff ff       	call   80104300 <mpmain>
8010448c:	66 90                	xchg   %ax,%ax
8010448e:	66 90                	xchg   %ax,%ax

80104490 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	57                   	push   %edi
80104494:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80104495:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010449b:	53                   	push   %ebx
  e = addr+len;
8010449c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010449f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801044a2:	39 de                	cmp    %ebx,%esi
801044a4:	72 10                	jb     801044b6 <mpsearch1+0x26>
801044a6:	eb 50                	jmp    801044f8 <mpsearch1+0x68>
801044a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044af:	90                   	nop
801044b0:	89 fe                	mov    %edi,%esi
801044b2:	39 fb                	cmp    %edi,%ebx
801044b4:	76 42                	jbe    801044f8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801044b6:	83 ec 04             	sub    $0x4,%esp
801044b9:	8d 7e 10             	lea    0x10(%esi),%edi
801044bc:	6a 04                	push   $0x4
801044be:	68 78 8a 10 80       	push   $0x80108a78
801044c3:	56                   	push   %esi
801044c4:	e8 e7 14 00 00       	call   801059b0 <memcmp>
801044c9:	83 c4 10             	add    $0x10,%esp
801044cc:	85 c0                	test   %eax,%eax
801044ce:	75 e0                	jne    801044b0 <mpsearch1+0x20>
801044d0:	89 f2                	mov    %esi,%edx
801044d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801044d8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801044db:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801044de:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801044e0:	39 fa                	cmp    %edi,%edx
801044e2:	75 f4                	jne    801044d8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801044e4:	84 c0                	test   %al,%al
801044e6:	75 c8                	jne    801044b0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801044e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044eb:	89 f0                	mov    %esi,%eax
801044ed:	5b                   	pop    %ebx
801044ee:	5e                   	pop    %esi
801044ef:	5f                   	pop    %edi
801044f0:	5d                   	pop    %ebp
801044f1:	c3                   	ret    
801044f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801044fb:	31 f6                	xor    %esi,%esi
}
801044fd:	5b                   	pop    %ebx
801044fe:	89 f0                	mov    %esi,%eax
80104500:	5e                   	pop    %esi
80104501:	5f                   	pop    %edi
80104502:	5d                   	pop    %ebp
80104503:	c3                   	ret    
80104504:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010450b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010450f:	90                   	nop

80104510 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	57                   	push   %edi
80104514:	56                   	push   %esi
80104515:	53                   	push   %ebx
80104516:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80104519:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80104520:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80104527:	c1 e0 08             	shl    $0x8,%eax
8010452a:	09 d0                	or     %edx,%eax
8010452c:	c1 e0 04             	shl    $0x4,%eax
8010452f:	75 1b                	jne    8010454c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80104531:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80104538:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010453f:	c1 e0 08             	shl    $0x8,%eax
80104542:	09 d0                	or     %edx,%eax
80104544:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80104547:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010454c:	ba 00 04 00 00       	mov    $0x400,%edx
80104551:	e8 3a ff ff ff       	call   80104490 <mpsearch1>
80104556:	89 c3                	mov    %eax,%ebx
80104558:	85 c0                	test   %eax,%eax
8010455a:	0f 84 40 01 00 00    	je     801046a0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80104560:	8b 73 04             	mov    0x4(%ebx),%esi
80104563:	85 f6                	test   %esi,%esi
80104565:	0f 84 25 01 00 00    	je     80104690 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010456b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010456e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80104574:	6a 04                	push   $0x4
80104576:	68 7d 8a 10 80       	push   $0x80108a7d
8010457b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010457c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010457f:	e8 2c 14 00 00       	call   801059b0 <memcmp>
80104584:	83 c4 10             	add    $0x10,%esp
80104587:	85 c0                	test   %eax,%eax
80104589:	0f 85 01 01 00 00    	jne    80104690 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010458f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80104596:	3c 01                	cmp    $0x1,%al
80104598:	74 08                	je     801045a2 <mpinit+0x92>
8010459a:	3c 04                	cmp    $0x4,%al
8010459c:	0f 85 ee 00 00 00    	jne    80104690 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
801045a2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801045a9:	66 85 d2             	test   %dx,%dx
801045ac:	74 22                	je     801045d0 <mpinit+0xc0>
801045ae:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801045b1:	89 f0                	mov    %esi,%eax
  sum = 0;
801045b3:	31 d2                	xor    %edx,%edx
801045b5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801045b8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801045bf:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801045c2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801045c4:	39 c7                	cmp    %eax,%edi
801045c6:	75 f0                	jne    801045b8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801045c8:	84 d2                	test   %dl,%dl
801045ca:	0f 85 c0 00 00 00    	jne    80104690 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801045d0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801045d6:	a3 20 27 11 80       	mov    %eax,0x80112720
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801045db:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801045e2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801045e8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801045ed:	03 55 e4             	add    -0x1c(%ebp),%edx
801045f0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801045f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045f7:	90                   	nop
801045f8:	39 d0                	cmp    %edx,%eax
801045fa:	73 15                	jae    80104611 <mpinit+0x101>
    switch(*p){
801045fc:	0f b6 08             	movzbl (%eax),%ecx
801045ff:	80 f9 02             	cmp    $0x2,%cl
80104602:	74 4c                	je     80104650 <mpinit+0x140>
80104604:	77 3a                	ja     80104640 <mpinit+0x130>
80104606:	84 c9                	test   %cl,%cl
80104608:	74 56                	je     80104660 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010460a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010460d:	39 d0                	cmp    %edx,%eax
8010460f:	72 eb                	jb     801045fc <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80104611:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104614:	85 f6                	test   %esi,%esi
80104616:	0f 84 d9 00 00 00    	je     801046f5 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010461c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80104620:	74 15                	je     80104637 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104622:	b8 70 00 00 00       	mov    $0x70,%eax
80104627:	ba 22 00 00 00       	mov    $0x22,%edx
8010462c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010462d:	ba 23 00 00 00       	mov    $0x23,%edx
80104632:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80104633:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104636:	ee                   	out    %al,(%dx)
  }
}
80104637:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010463a:	5b                   	pop    %ebx
8010463b:	5e                   	pop    %esi
8010463c:	5f                   	pop    %edi
8010463d:	5d                   	pop    %ebp
8010463e:	c3                   	ret    
8010463f:	90                   	nop
    switch(*p){
80104640:	83 e9 03             	sub    $0x3,%ecx
80104643:	80 f9 01             	cmp    $0x1,%cl
80104646:	76 c2                	jbe    8010460a <mpinit+0xfa>
80104648:	31 f6                	xor    %esi,%esi
8010464a:	eb ac                	jmp    801045f8 <mpinit+0xe8>
8010464c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80104650:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80104654:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80104657:	88 0d 20 28 11 80    	mov    %cl,0x80112820
      continue;
8010465d:	eb 99                	jmp    801045f8 <mpinit+0xe8>
8010465f:	90                   	nop
      if(ncpu < NCPU) {
80104660:	8b 0d 24 28 11 80    	mov    0x80112824,%ecx
80104666:	83 f9 07             	cmp    $0x7,%ecx
80104669:	7f 19                	jg     80104684 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010466b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80104671:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80104675:	83 c1 01             	add    $0x1,%ecx
80104678:	89 0d 24 28 11 80    	mov    %ecx,0x80112824
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010467e:	88 9f 40 28 11 80    	mov    %bl,-0x7feed7c0(%edi)
      p += sizeof(struct mpproc);
80104684:	83 c0 14             	add    $0x14,%eax
      continue;
80104687:	e9 6c ff ff ff       	jmp    801045f8 <mpinit+0xe8>
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80104690:	83 ec 0c             	sub    $0xc,%esp
80104693:	68 82 8a 10 80       	push   $0x80108a82
80104698:	e8 43 c6 ff ff       	call   80100ce0 <panic>
8010469d:	8d 76 00             	lea    0x0(%esi),%esi
{
801046a0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801046a5:	eb 13                	jmp    801046ba <mpinit+0x1aa>
801046a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046ae:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
801046b0:	89 f3                	mov    %esi,%ebx
801046b2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801046b8:	74 d6                	je     80104690 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801046ba:	83 ec 04             	sub    $0x4,%esp
801046bd:	8d 73 10             	lea    0x10(%ebx),%esi
801046c0:	6a 04                	push   $0x4
801046c2:	68 78 8a 10 80       	push   $0x80108a78
801046c7:	53                   	push   %ebx
801046c8:	e8 e3 12 00 00       	call   801059b0 <memcmp>
801046cd:	83 c4 10             	add    $0x10,%esp
801046d0:	85 c0                	test   %eax,%eax
801046d2:	75 dc                	jne    801046b0 <mpinit+0x1a0>
801046d4:	89 da                	mov    %ebx,%edx
801046d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046dd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801046e0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801046e3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801046e6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801046e8:	39 d6                	cmp    %edx,%esi
801046ea:	75 f4                	jne    801046e0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801046ec:	84 c0                	test   %al,%al
801046ee:	75 c0                	jne    801046b0 <mpinit+0x1a0>
801046f0:	e9 6b fe ff ff       	jmp    80104560 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801046f5:	83 ec 0c             	sub    $0xc,%esp
801046f8:	68 9c 8a 10 80       	push   $0x80108a9c
801046fd:	e8 de c5 ff ff       	call   80100ce0 <panic>
80104702:	66 90                	xchg   %ax,%ax
80104704:	66 90                	xchg   %ax,%ax
80104706:	66 90                	xchg   %ax,%ax
80104708:	66 90                	xchg   %ax,%ax
8010470a:	66 90                	xchg   %ax,%ax
8010470c:	66 90                	xchg   %ax,%ax
8010470e:	66 90                	xchg   %ax,%ax

80104710 <picinit>:
80104710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104715:	ba 21 00 00 00       	mov    $0x21,%edx
8010471a:	ee                   	out    %al,(%dx)
8010471b:	ba a1 00 00 00       	mov    $0xa1,%edx
80104720:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80104721:	c3                   	ret    
80104722:	66 90                	xchg   %ax,%ax
80104724:	66 90                	xchg   %ax,%ax
80104726:	66 90                	xchg   %ax,%ax
80104728:	66 90                	xchg   %ax,%ax
8010472a:	66 90                	xchg   %ax,%ax
8010472c:	66 90                	xchg   %ax,%ax
8010472e:	66 90                	xchg   %ax,%ax

80104730 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	57                   	push   %edi
80104734:	56                   	push   %esi
80104735:	53                   	push   %ebx
80104736:	83 ec 0c             	sub    $0xc,%esp
80104739:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010473c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010473f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104745:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010474b:	e8 e0 d9 ff ff       	call   80102130 <filealloc>
80104750:	89 03                	mov    %eax,(%ebx)
80104752:	85 c0                	test   %eax,%eax
80104754:	0f 84 a8 00 00 00    	je     80104802 <pipealloc+0xd2>
8010475a:	e8 d1 d9 ff ff       	call   80102130 <filealloc>
8010475f:	89 06                	mov    %eax,(%esi)
80104761:	85 c0                	test   %eax,%eax
80104763:	0f 84 87 00 00 00    	je     801047f0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104769:	e8 12 f2 ff ff       	call   80103980 <kalloc>
8010476e:	89 c7                	mov    %eax,%edi
80104770:	85 c0                	test   %eax,%eax
80104772:	0f 84 b0 00 00 00    	je     80104828 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80104778:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010477f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80104782:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80104785:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010478c:	00 00 00 
  p->nwrite = 0;
8010478f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104796:	00 00 00 
  p->nread = 0;
80104799:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801047a0:	00 00 00 
  initlock(&p->lock, "pipe");
801047a3:	68 bb 8a 10 80       	push   $0x80108abb
801047a8:	50                   	push   %eax
801047a9:	e8 22 0f 00 00       	call   801056d0 <initlock>
  (*f0)->type = FD_PIPE;
801047ae:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801047b0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801047b3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801047b9:	8b 03                	mov    (%ebx),%eax
801047bb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801047bf:	8b 03                	mov    (%ebx),%eax
801047c1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801047c5:	8b 03                	mov    (%ebx),%eax
801047c7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801047ca:	8b 06                	mov    (%esi),%eax
801047cc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801047d2:	8b 06                	mov    (%esi),%eax
801047d4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801047d8:	8b 06                	mov    (%esi),%eax
801047da:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801047de:	8b 06                	mov    (%esi),%eax
801047e0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801047e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801047e6:	31 c0                	xor    %eax,%eax
}
801047e8:	5b                   	pop    %ebx
801047e9:	5e                   	pop    %esi
801047ea:	5f                   	pop    %edi
801047eb:	5d                   	pop    %ebp
801047ec:	c3                   	ret    
801047ed:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
801047f0:	8b 03                	mov    (%ebx),%eax
801047f2:	85 c0                	test   %eax,%eax
801047f4:	74 1e                	je     80104814 <pipealloc+0xe4>
    fileclose(*f0);
801047f6:	83 ec 0c             	sub    $0xc,%esp
801047f9:	50                   	push   %eax
801047fa:	e8 f1 d9 ff ff       	call   801021f0 <fileclose>
801047ff:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104802:	8b 06                	mov    (%esi),%eax
80104804:	85 c0                	test   %eax,%eax
80104806:	74 0c                	je     80104814 <pipealloc+0xe4>
    fileclose(*f1);
80104808:	83 ec 0c             	sub    $0xc,%esp
8010480b:	50                   	push   %eax
8010480c:	e8 df d9 ff ff       	call   801021f0 <fileclose>
80104811:	83 c4 10             	add    $0x10,%esp
}
80104814:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104817:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010481c:	5b                   	pop    %ebx
8010481d:	5e                   	pop    %esi
8010481e:	5f                   	pop    %edi
8010481f:	5d                   	pop    %ebp
80104820:	c3                   	ret    
80104821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80104828:	8b 03                	mov    (%ebx),%eax
8010482a:	85 c0                	test   %eax,%eax
8010482c:	75 c8                	jne    801047f6 <pipealloc+0xc6>
8010482e:	eb d2                	jmp    80104802 <pipealloc+0xd2>

80104830 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	56                   	push   %esi
80104834:	53                   	push   %ebx
80104835:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104838:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010483b:	83 ec 0c             	sub    $0xc,%esp
8010483e:	53                   	push   %ebx
8010483f:	e8 5c 10 00 00       	call   801058a0 <acquire>
  if(writable){
80104844:	83 c4 10             	add    $0x10,%esp
80104847:	85 f6                	test   %esi,%esi
80104849:	74 65                	je     801048b0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010484b:	83 ec 0c             	sub    $0xc,%esp
8010484e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104854:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010485b:	00 00 00 
    wakeup(&p->nread);
8010485e:	50                   	push   %eax
8010485f:	e8 9c 0b 00 00       	call   80105400 <wakeup>
80104864:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104867:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010486d:	85 d2                	test   %edx,%edx
8010486f:	75 0a                	jne    8010487b <pipeclose+0x4b>
80104871:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104877:	85 c0                	test   %eax,%eax
80104879:	74 15                	je     80104890 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010487b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010487e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104881:	5b                   	pop    %ebx
80104882:	5e                   	pop    %esi
80104883:	5d                   	pop    %ebp
    release(&p->lock);
80104884:	e9 b7 0f 00 00       	jmp    80105840 <release>
80104889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104890:	83 ec 0c             	sub    $0xc,%esp
80104893:	53                   	push   %ebx
80104894:	e8 a7 0f 00 00       	call   80105840 <release>
    kfree((char*)p);
80104899:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010489c:	83 c4 10             	add    $0x10,%esp
}
8010489f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048a2:	5b                   	pop    %ebx
801048a3:	5e                   	pop    %esi
801048a4:	5d                   	pop    %ebp
    kfree((char*)p);
801048a5:	e9 16 ef ff ff       	jmp    801037c0 <kfree>
801048aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801048b0:	83 ec 0c             	sub    $0xc,%esp
801048b3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801048b9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801048c0:	00 00 00 
    wakeup(&p->nwrite);
801048c3:	50                   	push   %eax
801048c4:	e8 37 0b 00 00       	call   80105400 <wakeup>
801048c9:	83 c4 10             	add    $0x10,%esp
801048cc:	eb 99                	jmp    80104867 <pipeclose+0x37>
801048ce:	66 90                	xchg   %ax,%ax

801048d0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	57                   	push   %edi
801048d4:	56                   	push   %esi
801048d5:	53                   	push   %ebx
801048d6:	83 ec 28             	sub    $0x28,%esp
801048d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801048dc:	53                   	push   %ebx
801048dd:	e8 be 0f 00 00       	call   801058a0 <acquire>
  for(i = 0; i < n; i++){
801048e2:	8b 45 10             	mov    0x10(%ebp),%eax
801048e5:	83 c4 10             	add    $0x10,%esp
801048e8:	85 c0                	test   %eax,%eax
801048ea:	0f 8e c0 00 00 00    	jle    801049b0 <pipewrite+0xe0>
801048f0:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801048f3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801048f9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801048ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104902:	03 45 10             	add    0x10(%ebp),%eax
80104905:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104908:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010490e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104914:	89 ca                	mov    %ecx,%edx
80104916:	05 00 02 00 00       	add    $0x200,%eax
8010491b:	39 c1                	cmp    %eax,%ecx
8010491d:	74 3f                	je     8010495e <pipewrite+0x8e>
8010491f:	eb 67                	jmp    80104988 <pipewrite+0xb8>
80104921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104928:	e8 43 03 00 00       	call   80104c70 <myproc>
8010492d:	8b 48 24             	mov    0x24(%eax),%ecx
80104930:	85 c9                	test   %ecx,%ecx
80104932:	75 34                	jne    80104968 <pipewrite+0x98>
      wakeup(&p->nread);
80104934:	83 ec 0c             	sub    $0xc,%esp
80104937:	57                   	push   %edi
80104938:	e8 c3 0a 00 00       	call   80105400 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010493d:	58                   	pop    %eax
8010493e:	5a                   	pop    %edx
8010493f:	53                   	push   %ebx
80104940:	56                   	push   %esi
80104941:	e8 fa 09 00 00       	call   80105340 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104946:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010494c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80104952:	83 c4 10             	add    $0x10,%esp
80104955:	05 00 02 00 00       	add    $0x200,%eax
8010495a:	39 c2                	cmp    %eax,%edx
8010495c:	75 2a                	jne    80104988 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010495e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80104964:	85 c0                	test   %eax,%eax
80104966:	75 c0                	jne    80104928 <pipewrite+0x58>
        release(&p->lock);
80104968:	83 ec 0c             	sub    $0xc,%esp
8010496b:	53                   	push   %ebx
8010496c:	e8 cf 0e 00 00       	call   80105840 <release>
        return -1;
80104971:	83 c4 10             	add    $0x10,%esp
80104974:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104979:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010497c:	5b                   	pop    %ebx
8010497d:	5e                   	pop    %esi
8010497e:	5f                   	pop    %edi
8010497f:	5d                   	pop    %ebp
80104980:	c3                   	ret    
80104981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104988:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010498b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010498e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80104994:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010499a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
8010499d:	83 c6 01             	add    $0x1,%esi
801049a0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801049a3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801049a7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801049aa:	0f 85 58 ff ff ff    	jne    80104908 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801049b0:	83 ec 0c             	sub    $0xc,%esp
801049b3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801049b9:	50                   	push   %eax
801049ba:	e8 41 0a 00 00       	call   80105400 <wakeup>
  release(&p->lock);
801049bf:	89 1c 24             	mov    %ebx,(%esp)
801049c2:	e8 79 0e 00 00       	call   80105840 <release>
  return n;
801049c7:	8b 45 10             	mov    0x10(%ebp),%eax
801049ca:	83 c4 10             	add    $0x10,%esp
801049cd:	eb aa                	jmp    80104979 <pipewrite+0xa9>
801049cf:	90                   	nop

801049d0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	57                   	push   %edi
801049d4:	56                   	push   %esi
801049d5:	53                   	push   %ebx
801049d6:	83 ec 18             	sub    $0x18,%esp
801049d9:	8b 75 08             	mov    0x8(%ebp),%esi
801049dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801049df:	56                   	push   %esi
801049e0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801049e6:	e8 b5 0e 00 00       	call   801058a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801049eb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801049f1:	83 c4 10             	add    $0x10,%esp
801049f4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801049fa:	74 2f                	je     80104a2b <piperead+0x5b>
801049fc:	eb 37                	jmp    80104a35 <piperead+0x65>
801049fe:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80104a00:	e8 6b 02 00 00       	call   80104c70 <myproc>
80104a05:	8b 48 24             	mov    0x24(%eax),%ecx
80104a08:	85 c9                	test   %ecx,%ecx
80104a0a:	0f 85 80 00 00 00    	jne    80104a90 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104a10:	83 ec 08             	sub    $0x8,%esp
80104a13:	56                   	push   %esi
80104a14:	53                   	push   %ebx
80104a15:	e8 26 09 00 00       	call   80105340 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104a1a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80104a20:	83 c4 10             	add    $0x10,%esp
80104a23:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80104a29:	75 0a                	jne    80104a35 <piperead+0x65>
80104a2b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80104a31:	85 c0                	test   %eax,%eax
80104a33:	75 cb                	jne    80104a00 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104a35:	8b 55 10             	mov    0x10(%ebp),%edx
80104a38:	31 db                	xor    %ebx,%ebx
80104a3a:	85 d2                	test   %edx,%edx
80104a3c:	7f 20                	jg     80104a5e <piperead+0x8e>
80104a3e:	eb 2c                	jmp    80104a6c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104a40:	8d 48 01             	lea    0x1(%eax),%ecx
80104a43:	25 ff 01 00 00       	and    $0x1ff,%eax
80104a48:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80104a4e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104a53:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104a56:	83 c3 01             	add    $0x1,%ebx
80104a59:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80104a5c:	74 0e                	je     80104a6c <piperead+0x9c>
    if(p->nread == p->nwrite)
80104a5e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104a64:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80104a6a:	75 d4                	jne    80104a40 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104a6c:	83 ec 0c             	sub    $0xc,%esp
80104a6f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104a75:	50                   	push   %eax
80104a76:	e8 85 09 00 00       	call   80105400 <wakeup>
  release(&p->lock);
80104a7b:	89 34 24             	mov    %esi,(%esp)
80104a7e:	e8 bd 0d 00 00       	call   80105840 <release>
  return i;
80104a83:	83 c4 10             	add    $0x10,%esp
}
80104a86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a89:	89 d8                	mov    %ebx,%eax
80104a8b:	5b                   	pop    %ebx
80104a8c:	5e                   	pop    %esi
80104a8d:	5f                   	pop    %edi
80104a8e:	5d                   	pop    %ebp
80104a8f:	c3                   	ret    
      release(&p->lock);
80104a90:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104a93:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80104a98:	56                   	push   %esi
80104a99:	e8 a2 0d 00 00       	call   80105840 <release>
      return -1;
80104a9e:	83 c4 10             	add    $0x10,%esp
}
80104aa1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104aa4:	89 d8                	mov    %ebx,%eax
80104aa6:	5b                   	pop    %ebx
80104aa7:	5e                   	pop    %esi
80104aa8:	5f                   	pop    %edi
80104aa9:	5d                   	pop    %ebp
80104aaa:	c3                   	ret    
80104aab:	66 90                	xchg   %ax,%ax
80104aad:	66 90                	xchg   %ax,%ax
80104aaf:	90                   	nop

80104ab0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ab4:	bb f4 2d 11 80       	mov    $0x80112df4,%ebx
{
80104ab9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80104abc:	68 c0 2d 11 80       	push   $0x80112dc0
80104ac1:	e8 da 0d 00 00       	call   801058a0 <acquire>
80104ac6:	83 c4 10             	add    $0x10,%esp
80104ac9:	eb 10                	jmp    80104adb <allocproc+0x2b>
80104acb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104acf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ad0:	83 c3 7c             	add    $0x7c,%ebx
80104ad3:	81 fb f4 4c 11 80    	cmp    $0x80114cf4,%ebx
80104ad9:	74 75                	je     80104b50 <allocproc+0xa0>
    if(p->state == UNUSED)
80104adb:	8b 43 0c             	mov    0xc(%ebx),%eax
80104ade:	85 c0                	test   %eax,%eax
80104ae0:	75 ee                	jne    80104ad0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80104ae2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80104ae7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80104aea:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80104af1:	89 43 10             	mov    %eax,0x10(%ebx)
80104af4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80104af7:	68 c0 2d 11 80       	push   $0x80112dc0
  p->pid = nextpid++;
80104afc:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80104b02:	e8 39 0d 00 00       	call   80105840 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104b07:	e8 74 ee ff ff       	call   80103980 <kalloc>
80104b0c:	83 c4 10             	add    $0x10,%esp
80104b0f:	89 43 08             	mov    %eax,0x8(%ebx)
80104b12:	85 c0                	test   %eax,%eax
80104b14:	74 53                	je     80104b69 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104b16:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80104b1c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80104b1f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80104b24:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80104b27:	c7 40 14 52 6b 10 80 	movl   $0x80106b52,0x14(%eax)
  p->context = (struct context*)sp;
80104b2e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104b31:	6a 14                	push   $0x14
80104b33:	6a 00                	push   $0x0
80104b35:	50                   	push   %eax
80104b36:	e8 25 0e 00 00       	call   80105960 <memset>
  p->context->eip = (uint)forkret;
80104b3b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80104b3e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104b41:	c7 40 10 80 4b 10 80 	movl   $0x80104b80,0x10(%eax)
}
80104b48:	89 d8                	mov    %ebx,%eax
80104b4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b4d:	c9                   	leave  
80104b4e:	c3                   	ret    
80104b4f:	90                   	nop
  release(&ptable.lock);
80104b50:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104b53:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104b55:	68 c0 2d 11 80       	push   $0x80112dc0
80104b5a:	e8 e1 0c 00 00       	call   80105840 <release>
}
80104b5f:	89 d8                	mov    %ebx,%eax
  return 0;
80104b61:	83 c4 10             	add    $0x10,%esp
}
80104b64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b67:	c9                   	leave  
80104b68:	c3                   	ret    
    p->state = UNUSED;
80104b69:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80104b70:	31 db                	xor    %ebx,%ebx
}
80104b72:	89 d8                	mov    %ebx,%eax
80104b74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b77:	c9                   	leave  
80104b78:	c3                   	ret    
80104b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b80 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104b86:	68 c0 2d 11 80       	push   $0x80112dc0
80104b8b:	e8 b0 0c 00 00       	call   80105840 <release>

  if (first) {
80104b90:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104b95:	83 c4 10             	add    $0x10,%esp
80104b98:	85 c0                	test   %eax,%eax
80104b9a:	75 04                	jne    80104ba0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80104b9c:	c9                   	leave  
80104b9d:	c3                   	ret    
80104b9e:	66 90                	xchg   %ax,%ax
    first = 0;
80104ba0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80104ba7:	00 00 00 
    iinit(ROOTDEV);
80104baa:	83 ec 0c             	sub    $0xc,%esp
80104bad:	6a 01                	push   $0x1
80104baf:	e8 ac dc ff ff       	call   80102860 <iinit>
    initlog(ROOTDEV);
80104bb4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104bbb:	e8 00 f4 ff ff       	call   80103fc0 <initlog>
}
80104bc0:	83 c4 10             	add    $0x10,%esp
80104bc3:	c9                   	leave  
80104bc4:	c3                   	ret    
80104bc5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bd0 <pinit>:
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80104bd6:	68 c0 8a 10 80       	push   $0x80108ac0
80104bdb:	68 c0 2d 11 80       	push   $0x80112dc0
80104be0:	e8 eb 0a 00 00       	call   801056d0 <initlock>
}
80104be5:	83 c4 10             	add    $0x10,%esp
80104be8:	c9                   	leave  
80104be9:	c3                   	ret    
80104bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bf0 <mycpu>:
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	56                   	push   %esi
80104bf4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104bf5:	9c                   	pushf  
80104bf6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104bf7:	f6 c4 02             	test   $0x2,%ah
80104bfa:	75 46                	jne    80104c42 <mycpu+0x52>
  apicid = lapicid();
80104bfc:	e8 ef ef ff ff       	call   80103bf0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80104c01:	8b 35 24 28 11 80    	mov    0x80112824,%esi
80104c07:	85 f6                	test   %esi,%esi
80104c09:	7e 2a                	jle    80104c35 <mycpu+0x45>
80104c0b:	31 d2                	xor    %edx,%edx
80104c0d:	eb 08                	jmp    80104c17 <mycpu+0x27>
80104c0f:	90                   	nop
80104c10:	83 c2 01             	add    $0x1,%edx
80104c13:	39 f2                	cmp    %esi,%edx
80104c15:	74 1e                	je     80104c35 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80104c17:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80104c1d:	0f b6 99 40 28 11 80 	movzbl -0x7feed7c0(%ecx),%ebx
80104c24:	39 c3                	cmp    %eax,%ebx
80104c26:	75 e8                	jne    80104c10 <mycpu+0x20>
}
80104c28:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80104c2b:	8d 81 40 28 11 80    	lea    -0x7feed7c0(%ecx),%eax
}
80104c31:	5b                   	pop    %ebx
80104c32:	5e                   	pop    %esi
80104c33:	5d                   	pop    %ebp
80104c34:	c3                   	ret    
  panic("unknown apicid\n");
80104c35:	83 ec 0c             	sub    $0xc,%esp
80104c38:	68 c7 8a 10 80       	push   $0x80108ac7
80104c3d:	e8 9e c0 ff ff       	call   80100ce0 <panic>
    panic("mycpu called with interrupts enabled\n");
80104c42:	83 ec 0c             	sub    $0xc,%esp
80104c45:	68 a4 8b 10 80       	push   $0x80108ba4
80104c4a:	e8 91 c0 ff ff       	call   80100ce0 <panic>
80104c4f:	90                   	nop

80104c50 <cpuid>:
cpuid() {
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104c56:	e8 95 ff ff ff       	call   80104bf0 <mycpu>
}
80104c5b:	c9                   	leave  
  return mycpu()-cpus;
80104c5c:	2d 40 28 11 80       	sub    $0x80112840,%eax
80104c61:	c1 f8 04             	sar    $0x4,%eax
80104c64:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80104c6a:	c3                   	ret    
80104c6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c6f:	90                   	nop

80104c70 <myproc>:
myproc(void) {
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	53                   	push   %ebx
80104c74:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104c77:	e8 d4 0a 00 00       	call   80105750 <pushcli>
  c = mycpu();
80104c7c:	e8 6f ff ff ff       	call   80104bf0 <mycpu>
  p = c->proc;
80104c81:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104c87:	e8 14 0b 00 00       	call   801057a0 <popcli>
}
80104c8c:	89 d8                	mov    %ebx,%eax
80104c8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c91:	c9                   	leave  
80104c92:	c3                   	ret    
80104c93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ca0 <userinit>:
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	53                   	push   %ebx
80104ca4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104ca7:	e8 04 fe ff ff       	call   80104ab0 <allocproc>
80104cac:	89 c3                	mov    %eax,%ebx
  initproc = p;
80104cae:	a3 f4 4c 11 80       	mov    %eax,0x80114cf4
  if((p->pgdir = setupkvm()) == 0)
80104cb3:	e8 88 34 00 00       	call   80108140 <setupkvm>
80104cb8:	89 43 04             	mov    %eax,0x4(%ebx)
80104cbb:	85 c0                	test   %eax,%eax
80104cbd:	0f 84 bd 00 00 00    	je     80104d80 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104cc3:	83 ec 04             	sub    $0x4,%esp
80104cc6:	68 2c 00 00 00       	push   $0x2c
80104ccb:	68 60 b4 10 80       	push   $0x8010b460
80104cd0:	50                   	push   %eax
80104cd1:	e8 1a 31 00 00       	call   80107df0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104cd6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104cd9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104cdf:	6a 4c                	push   $0x4c
80104ce1:	6a 00                	push   $0x0
80104ce3:	ff 73 18             	push   0x18(%ebx)
80104ce6:	e8 75 0c 00 00       	call   80105960 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104ceb:	8b 43 18             	mov    0x18(%ebx),%eax
80104cee:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104cf3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104cf6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104cfb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104cff:	8b 43 18             	mov    0x18(%ebx),%eax
80104d02:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104d06:	8b 43 18             	mov    0x18(%ebx),%eax
80104d09:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104d0d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104d11:	8b 43 18             	mov    0x18(%ebx),%eax
80104d14:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104d18:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104d1c:	8b 43 18             	mov    0x18(%ebx),%eax
80104d1f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104d26:	8b 43 18             	mov    0x18(%ebx),%eax
80104d29:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104d30:	8b 43 18             	mov    0x18(%ebx),%eax
80104d33:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104d3a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104d3d:	6a 10                	push   $0x10
80104d3f:	68 f0 8a 10 80       	push   $0x80108af0
80104d44:	50                   	push   %eax
80104d45:	e8 d6 0d 00 00       	call   80105b20 <safestrcpy>
  p->cwd = namei("/");
80104d4a:	c7 04 24 f9 8a 10 80 	movl   $0x80108af9,(%esp)
80104d51:	e8 4a e6 ff ff       	call   801033a0 <namei>
80104d56:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104d59:	c7 04 24 c0 2d 11 80 	movl   $0x80112dc0,(%esp)
80104d60:	e8 3b 0b 00 00       	call   801058a0 <acquire>
  p->state = RUNNABLE;
80104d65:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104d6c:	c7 04 24 c0 2d 11 80 	movl   $0x80112dc0,(%esp)
80104d73:	e8 c8 0a 00 00       	call   80105840 <release>
}
80104d78:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d7b:	83 c4 10             	add    $0x10,%esp
80104d7e:	c9                   	leave  
80104d7f:	c3                   	ret    
    panic("userinit: out of memory?");
80104d80:	83 ec 0c             	sub    $0xc,%esp
80104d83:	68 d7 8a 10 80       	push   $0x80108ad7
80104d88:	e8 53 bf ff ff       	call   80100ce0 <panic>
80104d8d:	8d 76 00             	lea    0x0(%esi),%esi

80104d90 <growproc>:
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	56                   	push   %esi
80104d94:	53                   	push   %ebx
80104d95:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104d98:	e8 b3 09 00 00       	call   80105750 <pushcli>
  c = mycpu();
80104d9d:	e8 4e fe ff ff       	call   80104bf0 <mycpu>
  p = c->proc;
80104da2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104da8:	e8 f3 09 00 00       	call   801057a0 <popcli>
  sz = curproc->sz;
80104dad:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80104daf:	85 f6                	test   %esi,%esi
80104db1:	7f 1d                	jg     80104dd0 <growproc+0x40>
  } else if(n < 0){
80104db3:	75 3b                	jne    80104df0 <growproc+0x60>
  switchuvm(curproc);
80104db5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104db8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80104dba:	53                   	push   %ebx
80104dbb:	e8 20 2f 00 00       	call   80107ce0 <switchuvm>
  return 0;
80104dc0:	83 c4 10             	add    $0x10,%esp
80104dc3:	31 c0                	xor    %eax,%eax
}
80104dc5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dc8:	5b                   	pop    %ebx
80104dc9:	5e                   	pop    %esi
80104dca:	5d                   	pop    %ebp
80104dcb:	c3                   	ret    
80104dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104dd0:	83 ec 04             	sub    $0x4,%esp
80104dd3:	01 c6                	add    %eax,%esi
80104dd5:	56                   	push   %esi
80104dd6:	50                   	push   %eax
80104dd7:	ff 73 04             	push   0x4(%ebx)
80104dda:	e8 81 31 00 00       	call   80107f60 <allocuvm>
80104ddf:	83 c4 10             	add    $0x10,%esp
80104de2:	85 c0                	test   %eax,%eax
80104de4:	75 cf                	jne    80104db5 <growproc+0x25>
      return -1;
80104de6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104deb:	eb d8                	jmp    80104dc5 <growproc+0x35>
80104ded:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104df0:	83 ec 04             	sub    $0x4,%esp
80104df3:	01 c6                	add    %eax,%esi
80104df5:	56                   	push   %esi
80104df6:	50                   	push   %eax
80104df7:	ff 73 04             	push   0x4(%ebx)
80104dfa:	e8 91 32 00 00       	call   80108090 <deallocuvm>
80104dff:	83 c4 10             	add    $0x10,%esp
80104e02:	85 c0                	test   %eax,%eax
80104e04:	75 af                	jne    80104db5 <growproc+0x25>
80104e06:	eb de                	jmp    80104de6 <growproc+0x56>
80104e08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e0f:	90                   	nop

80104e10 <fork>:
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	57                   	push   %edi
80104e14:	56                   	push   %esi
80104e15:	53                   	push   %ebx
80104e16:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104e19:	e8 32 09 00 00       	call   80105750 <pushcli>
  c = mycpu();
80104e1e:	e8 cd fd ff ff       	call   80104bf0 <mycpu>
  p = c->proc;
80104e23:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104e29:	e8 72 09 00 00       	call   801057a0 <popcli>
  if((np = allocproc()) == 0){
80104e2e:	e8 7d fc ff ff       	call   80104ab0 <allocproc>
80104e33:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104e36:	85 c0                	test   %eax,%eax
80104e38:	0f 84 b7 00 00 00    	je     80104ef5 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104e3e:	83 ec 08             	sub    $0x8,%esp
80104e41:	ff 33                	push   (%ebx)
80104e43:	89 c7                	mov    %eax,%edi
80104e45:	ff 73 04             	push   0x4(%ebx)
80104e48:	e8 e3 33 00 00       	call   80108230 <copyuvm>
80104e4d:	83 c4 10             	add    $0x10,%esp
80104e50:	89 47 04             	mov    %eax,0x4(%edi)
80104e53:	85 c0                	test   %eax,%eax
80104e55:	0f 84 a1 00 00 00    	je     80104efc <fork+0xec>
  np->sz = curproc->sz;
80104e5b:	8b 03                	mov    (%ebx),%eax
80104e5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104e60:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104e62:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104e65:	89 c8                	mov    %ecx,%eax
80104e67:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80104e6a:	b9 13 00 00 00       	mov    $0x13,%ecx
80104e6f:	8b 73 18             	mov    0x18(%ebx),%esi
80104e72:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104e74:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104e76:	8b 40 18             	mov    0x18(%eax),%eax
80104e79:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104e80:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104e84:	85 c0                	test   %eax,%eax
80104e86:	74 13                	je     80104e9b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104e88:	83 ec 0c             	sub    $0xc,%esp
80104e8b:	50                   	push   %eax
80104e8c:	e8 0f d3 ff ff       	call   801021a0 <filedup>
80104e91:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104e94:	83 c4 10             	add    $0x10,%esp
80104e97:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104e9b:	83 c6 01             	add    $0x1,%esi
80104e9e:	83 fe 10             	cmp    $0x10,%esi
80104ea1:	75 dd                	jne    80104e80 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104ea3:	83 ec 0c             	sub    $0xc,%esp
80104ea6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104ea9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80104eac:	e8 9f db ff ff       	call   80102a50 <idup>
80104eb1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104eb4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104eb7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104eba:	8d 47 6c             	lea    0x6c(%edi),%eax
80104ebd:	6a 10                	push   $0x10
80104ebf:	53                   	push   %ebx
80104ec0:	50                   	push   %eax
80104ec1:	e8 5a 0c 00 00       	call   80105b20 <safestrcpy>
  pid = np->pid;
80104ec6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104ec9:	c7 04 24 c0 2d 11 80 	movl   $0x80112dc0,(%esp)
80104ed0:	e8 cb 09 00 00       	call   801058a0 <acquire>
  np->state = RUNNABLE;
80104ed5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80104edc:	c7 04 24 c0 2d 11 80 	movl   $0x80112dc0,(%esp)
80104ee3:	e8 58 09 00 00       	call   80105840 <release>
  return pid;
80104ee8:	83 c4 10             	add    $0x10,%esp
}
80104eeb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104eee:	89 d8                	mov    %ebx,%eax
80104ef0:	5b                   	pop    %ebx
80104ef1:	5e                   	pop    %esi
80104ef2:	5f                   	pop    %edi
80104ef3:	5d                   	pop    %ebp
80104ef4:	c3                   	ret    
    return -1;
80104ef5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104efa:	eb ef                	jmp    80104eeb <fork+0xdb>
    kfree(np->kstack);
80104efc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104eff:	83 ec 0c             	sub    $0xc,%esp
80104f02:	ff 73 08             	push   0x8(%ebx)
80104f05:	e8 b6 e8 ff ff       	call   801037c0 <kfree>
    np->kstack = 0;
80104f0a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104f11:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104f14:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104f1b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104f20:	eb c9                	jmp    80104eeb <fork+0xdb>
80104f22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f30 <scheduler>:
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	57                   	push   %edi
80104f34:	56                   	push   %esi
80104f35:	53                   	push   %ebx
80104f36:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104f39:	e8 b2 fc ff ff       	call   80104bf0 <mycpu>
  c->proc = 0;
80104f3e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104f45:	00 00 00 
  struct cpu *c = mycpu();
80104f48:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104f4a:	8d 78 04             	lea    0x4(%eax),%edi
80104f4d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104f50:	fb                   	sti    
    acquire(&ptable.lock);
80104f51:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f54:	bb f4 2d 11 80       	mov    $0x80112df4,%ebx
    acquire(&ptable.lock);
80104f59:	68 c0 2d 11 80       	push   $0x80112dc0
80104f5e:	e8 3d 09 00 00       	call   801058a0 <acquire>
80104f63:	83 c4 10             	add    $0x10,%esp
80104f66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f6d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80104f70:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104f74:	75 33                	jne    80104fa9 <scheduler+0x79>
      switchuvm(p);
80104f76:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104f79:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80104f7f:	53                   	push   %ebx
80104f80:	e8 5b 2d 00 00       	call   80107ce0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104f85:	58                   	pop    %eax
80104f86:	5a                   	pop    %edx
80104f87:	ff 73 1c             	push   0x1c(%ebx)
80104f8a:	57                   	push   %edi
      p->state = RUNNING;
80104f8b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104f92:	e8 e4 0b 00 00       	call   80105b7b <swtch>
      switchkvm();
80104f97:	e8 34 2d 00 00       	call   80107cd0 <switchkvm>
      c->proc = 0;
80104f9c:	83 c4 10             	add    $0x10,%esp
80104f9f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104fa6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104fa9:	83 c3 7c             	add    $0x7c,%ebx
80104fac:	81 fb f4 4c 11 80    	cmp    $0x80114cf4,%ebx
80104fb2:	75 bc                	jne    80104f70 <scheduler+0x40>
    release(&ptable.lock);
80104fb4:	83 ec 0c             	sub    $0xc,%esp
80104fb7:	68 c0 2d 11 80       	push   $0x80112dc0
80104fbc:	e8 7f 08 00 00       	call   80105840 <release>
    sti();
80104fc1:	83 c4 10             	add    $0x10,%esp
80104fc4:	eb 8a                	jmp    80104f50 <scheduler+0x20>
80104fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fcd:	8d 76 00             	lea    0x0(%esi),%esi

80104fd0 <sched>:
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	56                   	push   %esi
80104fd4:	53                   	push   %ebx
  pushcli();
80104fd5:	e8 76 07 00 00       	call   80105750 <pushcli>
  c = mycpu();
80104fda:	e8 11 fc ff ff       	call   80104bf0 <mycpu>
  p = c->proc;
80104fdf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104fe5:	e8 b6 07 00 00       	call   801057a0 <popcli>
  if(!holding(&ptable.lock))
80104fea:	83 ec 0c             	sub    $0xc,%esp
80104fed:	68 c0 2d 11 80       	push   $0x80112dc0
80104ff2:	e8 09 08 00 00       	call   80105800 <holding>
80104ff7:	83 c4 10             	add    $0x10,%esp
80104ffa:	85 c0                	test   %eax,%eax
80104ffc:	74 4f                	je     8010504d <sched+0x7d>
  if(mycpu()->ncli != 1)
80104ffe:	e8 ed fb ff ff       	call   80104bf0 <mycpu>
80105003:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010500a:	75 68                	jne    80105074 <sched+0xa4>
  if(p->state == RUNNING)
8010500c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80105010:	74 55                	je     80105067 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105012:	9c                   	pushf  
80105013:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105014:	f6 c4 02             	test   $0x2,%ah
80105017:	75 41                	jne    8010505a <sched+0x8a>
  intena = mycpu()->intena;
80105019:	e8 d2 fb ff ff       	call   80104bf0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010501e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80105021:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80105027:	e8 c4 fb ff ff       	call   80104bf0 <mycpu>
8010502c:	83 ec 08             	sub    $0x8,%esp
8010502f:	ff 70 04             	push   0x4(%eax)
80105032:	53                   	push   %ebx
80105033:	e8 43 0b 00 00       	call   80105b7b <swtch>
  mycpu()->intena = intena;
80105038:	e8 b3 fb ff ff       	call   80104bf0 <mycpu>
}
8010503d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80105040:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80105046:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105049:	5b                   	pop    %ebx
8010504a:	5e                   	pop    %esi
8010504b:	5d                   	pop    %ebp
8010504c:	c3                   	ret    
    panic("sched ptable.lock");
8010504d:	83 ec 0c             	sub    $0xc,%esp
80105050:	68 fb 8a 10 80       	push   $0x80108afb
80105055:	e8 86 bc ff ff       	call   80100ce0 <panic>
    panic("sched interruptible");
8010505a:	83 ec 0c             	sub    $0xc,%esp
8010505d:	68 27 8b 10 80       	push   $0x80108b27
80105062:	e8 79 bc ff ff       	call   80100ce0 <panic>
    panic("sched running");
80105067:	83 ec 0c             	sub    $0xc,%esp
8010506a:	68 19 8b 10 80       	push   $0x80108b19
8010506f:	e8 6c bc ff ff       	call   80100ce0 <panic>
    panic("sched locks");
80105074:	83 ec 0c             	sub    $0xc,%esp
80105077:	68 0d 8b 10 80       	push   $0x80108b0d
8010507c:	e8 5f bc ff ff       	call   80100ce0 <panic>
80105081:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105088:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010508f:	90                   	nop

80105090 <exit>:
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	57                   	push   %edi
80105094:	56                   	push   %esi
80105095:	53                   	push   %ebx
80105096:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80105099:	e8 d2 fb ff ff       	call   80104c70 <myproc>
  if(curproc == initproc)
8010509e:	39 05 f4 4c 11 80    	cmp    %eax,0x80114cf4
801050a4:	0f 84 fd 00 00 00    	je     801051a7 <exit+0x117>
801050aa:	89 c3                	mov    %eax,%ebx
801050ac:	8d 70 28             	lea    0x28(%eax),%esi
801050af:	8d 78 68             	lea    0x68(%eax),%edi
801050b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
801050b8:	8b 06                	mov    (%esi),%eax
801050ba:	85 c0                	test   %eax,%eax
801050bc:	74 12                	je     801050d0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
801050be:	83 ec 0c             	sub    $0xc,%esp
801050c1:	50                   	push   %eax
801050c2:	e8 29 d1 ff ff       	call   801021f0 <fileclose>
      curproc->ofile[fd] = 0;
801050c7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801050cd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801050d0:	83 c6 04             	add    $0x4,%esi
801050d3:	39 f7                	cmp    %esi,%edi
801050d5:	75 e1                	jne    801050b8 <exit+0x28>
  begin_op();
801050d7:	e8 84 ef ff ff       	call   80104060 <begin_op>
  iput(curproc->cwd);
801050dc:	83 ec 0c             	sub    $0xc,%esp
801050df:	ff 73 68             	push   0x68(%ebx)
801050e2:	e8 c9 da ff ff       	call   80102bb0 <iput>
  end_op();
801050e7:	e8 e4 ef ff ff       	call   801040d0 <end_op>
  curproc->cwd = 0;
801050ec:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
801050f3:	c7 04 24 c0 2d 11 80 	movl   $0x80112dc0,(%esp)
801050fa:	e8 a1 07 00 00       	call   801058a0 <acquire>
  wakeup1(curproc->parent);
801050ff:	8b 53 14             	mov    0x14(%ebx),%edx
80105102:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105105:	b8 f4 2d 11 80       	mov    $0x80112df4,%eax
8010510a:	eb 0e                	jmp    8010511a <exit+0x8a>
8010510c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105110:	83 c0 7c             	add    $0x7c,%eax
80105113:	3d f4 4c 11 80       	cmp    $0x80114cf4,%eax
80105118:	74 1c                	je     80105136 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
8010511a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010511e:	75 f0                	jne    80105110 <exit+0x80>
80105120:	3b 50 20             	cmp    0x20(%eax),%edx
80105123:	75 eb                	jne    80105110 <exit+0x80>
      p->state = RUNNABLE;
80105125:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010512c:	83 c0 7c             	add    $0x7c,%eax
8010512f:	3d f4 4c 11 80       	cmp    $0x80114cf4,%eax
80105134:	75 e4                	jne    8010511a <exit+0x8a>
      p->parent = initproc;
80105136:	8b 0d f4 4c 11 80    	mov    0x80114cf4,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010513c:	ba f4 2d 11 80       	mov    $0x80112df4,%edx
80105141:	eb 10                	jmp    80105153 <exit+0xc3>
80105143:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105147:	90                   	nop
80105148:	83 c2 7c             	add    $0x7c,%edx
8010514b:	81 fa f4 4c 11 80    	cmp    $0x80114cf4,%edx
80105151:	74 3b                	je     8010518e <exit+0xfe>
    if(p->parent == curproc){
80105153:	39 5a 14             	cmp    %ebx,0x14(%edx)
80105156:	75 f0                	jne    80105148 <exit+0xb8>
      if(p->state == ZOMBIE)
80105158:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010515c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010515f:	75 e7                	jne    80105148 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105161:	b8 f4 2d 11 80       	mov    $0x80112df4,%eax
80105166:	eb 12                	jmp    8010517a <exit+0xea>
80105168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010516f:	90                   	nop
80105170:	83 c0 7c             	add    $0x7c,%eax
80105173:	3d f4 4c 11 80       	cmp    $0x80114cf4,%eax
80105178:	74 ce                	je     80105148 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
8010517a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010517e:	75 f0                	jne    80105170 <exit+0xe0>
80105180:	3b 48 20             	cmp    0x20(%eax),%ecx
80105183:	75 eb                	jne    80105170 <exit+0xe0>
      p->state = RUNNABLE;
80105185:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010518c:	eb e2                	jmp    80105170 <exit+0xe0>
  curproc->state = ZOMBIE;
8010518e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80105195:	e8 36 fe ff ff       	call   80104fd0 <sched>
  panic("zombie exit");
8010519a:	83 ec 0c             	sub    $0xc,%esp
8010519d:	68 48 8b 10 80       	push   $0x80108b48
801051a2:	e8 39 bb ff ff       	call   80100ce0 <panic>
    panic("init exiting");
801051a7:	83 ec 0c             	sub    $0xc,%esp
801051aa:	68 3b 8b 10 80       	push   $0x80108b3b
801051af:	e8 2c bb ff ff       	call   80100ce0 <panic>
801051b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051bf:	90                   	nop

801051c0 <wait>:
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	56                   	push   %esi
801051c4:	53                   	push   %ebx
  pushcli();
801051c5:	e8 86 05 00 00       	call   80105750 <pushcli>
  c = mycpu();
801051ca:	e8 21 fa ff ff       	call   80104bf0 <mycpu>
  p = c->proc;
801051cf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801051d5:	e8 c6 05 00 00       	call   801057a0 <popcli>
  acquire(&ptable.lock);
801051da:	83 ec 0c             	sub    $0xc,%esp
801051dd:	68 c0 2d 11 80       	push   $0x80112dc0
801051e2:	e8 b9 06 00 00       	call   801058a0 <acquire>
801051e7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801051ea:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051ec:	bb f4 2d 11 80       	mov    $0x80112df4,%ebx
801051f1:	eb 10                	jmp    80105203 <wait+0x43>
801051f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051f7:	90                   	nop
801051f8:	83 c3 7c             	add    $0x7c,%ebx
801051fb:	81 fb f4 4c 11 80    	cmp    $0x80114cf4,%ebx
80105201:	74 1b                	je     8010521e <wait+0x5e>
      if(p->parent != curproc)
80105203:	39 73 14             	cmp    %esi,0x14(%ebx)
80105206:	75 f0                	jne    801051f8 <wait+0x38>
      if(p->state == ZOMBIE){
80105208:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010520c:	74 62                	je     80105270 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010520e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80105211:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105216:	81 fb f4 4c 11 80    	cmp    $0x80114cf4,%ebx
8010521c:	75 e5                	jne    80105203 <wait+0x43>
    if(!havekids || curproc->killed){
8010521e:	85 c0                	test   %eax,%eax
80105220:	0f 84 a0 00 00 00    	je     801052c6 <wait+0x106>
80105226:	8b 46 24             	mov    0x24(%esi),%eax
80105229:	85 c0                	test   %eax,%eax
8010522b:	0f 85 95 00 00 00    	jne    801052c6 <wait+0x106>
  pushcli();
80105231:	e8 1a 05 00 00       	call   80105750 <pushcli>
  c = mycpu();
80105236:	e8 b5 f9 ff ff       	call   80104bf0 <mycpu>
  p = c->proc;
8010523b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105241:	e8 5a 05 00 00       	call   801057a0 <popcli>
  if(p == 0)
80105246:	85 db                	test   %ebx,%ebx
80105248:	0f 84 8f 00 00 00    	je     801052dd <wait+0x11d>
  p->chan = chan;
8010524e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80105251:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80105258:	e8 73 fd ff ff       	call   80104fd0 <sched>
  p->chan = 0;
8010525d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80105264:	eb 84                	jmp    801051ea <wait+0x2a>
80105266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526d:	8d 76 00             	lea    0x0(%esi),%esi
        kfree(p->kstack);
80105270:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80105273:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80105276:	ff 73 08             	push   0x8(%ebx)
80105279:	e8 42 e5 ff ff       	call   801037c0 <kfree>
        p->kstack = 0;
8010527e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80105285:	5a                   	pop    %edx
80105286:	ff 73 04             	push   0x4(%ebx)
80105289:	e8 32 2e 00 00       	call   801080c0 <freevm>
        p->pid = 0;
8010528e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80105295:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010529c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801052a0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801052a7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801052ae:	c7 04 24 c0 2d 11 80 	movl   $0x80112dc0,(%esp)
801052b5:	e8 86 05 00 00       	call   80105840 <release>
        return pid;
801052ba:	83 c4 10             	add    $0x10,%esp
}
801052bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801052c0:	89 f0                	mov    %esi,%eax
801052c2:	5b                   	pop    %ebx
801052c3:	5e                   	pop    %esi
801052c4:	5d                   	pop    %ebp
801052c5:	c3                   	ret    
      release(&ptable.lock);
801052c6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801052c9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801052ce:	68 c0 2d 11 80       	push   $0x80112dc0
801052d3:	e8 68 05 00 00       	call   80105840 <release>
      return -1;
801052d8:	83 c4 10             	add    $0x10,%esp
801052db:	eb e0                	jmp    801052bd <wait+0xfd>
    panic("sleep");
801052dd:	83 ec 0c             	sub    $0xc,%esp
801052e0:	68 54 8b 10 80       	push   $0x80108b54
801052e5:	e8 f6 b9 ff ff       	call   80100ce0 <panic>
801052ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052f0 <yield>:
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	53                   	push   %ebx
801052f4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801052f7:	68 c0 2d 11 80       	push   $0x80112dc0
801052fc:	e8 9f 05 00 00       	call   801058a0 <acquire>
  pushcli();
80105301:	e8 4a 04 00 00       	call   80105750 <pushcli>
  c = mycpu();
80105306:	e8 e5 f8 ff ff       	call   80104bf0 <mycpu>
  p = c->proc;
8010530b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105311:	e8 8a 04 00 00       	call   801057a0 <popcli>
  myproc()->state = RUNNABLE;
80105316:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010531d:	e8 ae fc ff ff       	call   80104fd0 <sched>
  release(&ptable.lock);
80105322:	c7 04 24 c0 2d 11 80 	movl   $0x80112dc0,(%esp)
80105329:	e8 12 05 00 00       	call   80105840 <release>
}
8010532e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105331:	83 c4 10             	add    $0x10,%esp
80105334:	c9                   	leave  
80105335:	c3                   	ret    
80105336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010533d:	8d 76 00             	lea    0x0(%esi),%esi

80105340 <sleep>:
{
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	57                   	push   %edi
80105344:	56                   	push   %esi
80105345:	53                   	push   %ebx
80105346:	83 ec 0c             	sub    $0xc,%esp
80105349:	8b 7d 08             	mov    0x8(%ebp),%edi
8010534c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010534f:	e8 fc 03 00 00       	call   80105750 <pushcli>
  c = mycpu();
80105354:	e8 97 f8 ff ff       	call   80104bf0 <mycpu>
  p = c->proc;
80105359:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010535f:	e8 3c 04 00 00       	call   801057a0 <popcli>
  if(p == 0)
80105364:	85 db                	test   %ebx,%ebx
80105366:	0f 84 87 00 00 00    	je     801053f3 <sleep+0xb3>
  if(lk == 0)
8010536c:	85 f6                	test   %esi,%esi
8010536e:	74 76                	je     801053e6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80105370:	81 fe c0 2d 11 80    	cmp    $0x80112dc0,%esi
80105376:	74 50                	je     801053c8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80105378:	83 ec 0c             	sub    $0xc,%esp
8010537b:	68 c0 2d 11 80       	push   $0x80112dc0
80105380:	e8 1b 05 00 00       	call   801058a0 <acquire>
    release(lk);
80105385:	89 34 24             	mov    %esi,(%esp)
80105388:	e8 b3 04 00 00       	call   80105840 <release>
  p->chan = chan;
8010538d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80105390:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80105397:	e8 34 fc ff ff       	call   80104fd0 <sched>
  p->chan = 0;
8010539c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801053a3:	c7 04 24 c0 2d 11 80 	movl   $0x80112dc0,(%esp)
801053aa:	e8 91 04 00 00       	call   80105840 <release>
    acquire(lk);
801053af:	89 75 08             	mov    %esi,0x8(%ebp)
801053b2:	83 c4 10             	add    $0x10,%esp
}
801053b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053b8:	5b                   	pop    %ebx
801053b9:	5e                   	pop    %esi
801053ba:	5f                   	pop    %edi
801053bb:	5d                   	pop    %ebp
    acquire(lk);
801053bc:	e9 df 04 00 00       	jmp    801058a0 <acquire>
801053c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801053c8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801053cb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801053d2:	e8 f9 fb ff ff       	call   80104fd0 <sched>
  p->chan = 0;
801053d7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801053de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053e1:	5b                   	pop    %ebx
801053e2:	5e                   	pop    %esi
801053e3:	5f                   	pop    %edi
801053e4:	5d                   	pop    %ebp
801053e5:	c3                   	ret    
    panic("sleep without lk");
801053e6:	83 ec 0c             	sub    $0xc,%esp
801053e9:	68 5a 8b 10 80       	push   $0x80108b5a
801053ee:	e8 ed b8 ff ff       	call   80100ce0 <panic>
    panic("sleep");
801053f3:	83 ec 0c             	sub    $0xc,%esp
801053f6:	68 54 8b 10 80       	push   $0x80108b54
801053fb:	e8 e0 b8 ff ff       	call   80100ce0 <panic>

80105400 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	53                   	push   %ebx
80105404:	83 ec 10             	sub    $0x10,%esp
80105407:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010540a:	68 c0 2d 11 80       	push   $0x80112dc0
8010540f:	e8 8c 04 00 00       	call   801058a0 <acquire>
80105414:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105417:	b8 f4 2d 11 80       	mov    $0x80112df4,%eax
8010541c:	eb 0c                	jmp    8010542a <wakeup+0x2a>
8010541e:	66 90                	xchg   %ax,%ax
80105420:	83 c0 7c             	add    $0x7c,%eax
80105423:	3d f4 4c 11 80       	cmp    $0x80114cf4,%eax
80105428:	74 1c                	je     80105446 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010542a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010542e:	75 f0                	jne    80105420 <wakeup+0x20>
80105430:	3b 58 20             	cmp    0x20(%eax),%ebx
80105433:	75 eb                	jne    80105420 <wakeup+0x20>
      p->state = RUNNABLE;
80105435:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010543c:	83 c0 7c             	add    $0x7c,%eax
8010543f:	3d f4 4c 11 80       	cmp    $0x80114cf4,%eax
80105444:	75 e4                	jne    8010542a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80105446:	c7 45 08 c0 2d 11 80 	movl   $0x80112dc0,0x8(%ebp)
}
8010544d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105450:	c9                   	leave  
  release(&ptable.lock);
80105451:	e9 ea 03 00 00       	jmp    80105840 <release>
80105456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010545d:	8d 76 00             	lea    0x0(%esi),%esi

80105460 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	53                   	push   %ebx
80105464:	83 ec 10             	sub    $0x10,%esp
80105467:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010546a:	68 c0 2d 11 80       	push   $0x80112dc0
8010546f:	e8 2c 04 00 00       	call   801058a0 <acquire>
80105474:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105477:	b8 f4 2d 11 80       	mov    $0x80112df4,%eax
8010547c:	eb 0c                	jmp    8010548a <kill+0x2a>
8010547e:	66 90                	xchg   %ax,%ax
80105480:	83 c0 7c             	add    $0x7c,%eax
80105483:	3d f4 4c 11 80       	cmp    $0x80114cf4,%eax
80105488:	74 36                	je     801054c0 <kill+0x60>
    if(p->pid == pid){
8010548a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010548d:	75 f1                	jne    80105480 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010548f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80105493:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010549a:	75 07                	jne    801054a3 <kill+0x43>
        p->state = RUNNABLE;
8010549c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801054a3:	83 ec 0c             	sub    $0xc,%esp
801054a6:	68 c0 2d 11 80       	push   $0x80112dc0
801054ab:	e8 90 03 00 00       	call   80105840 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801054b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801054b3:	83 c4 10             	add    $0x10,%esp
801054b6:	31 c0                	xor    %eax,%eax
}
801054b8:	c9                   	leave  
801054b9:	c3                   	ret    
801054ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801054c0:	83 ec 0c             	sub    $0xc,%esp
801054c3:	68 c0 2d 11 80       	push   $0x80112dc0
801054c8:	e8 73 03 00 00       	call   80105840 <release>
}
801054cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801054d0:	83 c4 10             	add    $0x10,%esp
801054d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054d8:	c9                   	leave  
801054d9:	c3                   	ret    
801054da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801054e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	57                   	push   %edi
801054e4:	56                   	push   %esi
801054e5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801054e8:	53                   	push   %ebx
801054e9:	bb 60 2e 11 80       	mov    $0x80112e60,%ebx
801054ee:	83 ec 3c             	sub    $0x3c,%esp
801054f1:	eb 24                	jmp    80105517 <procdump+0x37>
801054f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054f7:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801054f8:	83 ec 0c             	sub    $0xc,%esp
801054fb:	68 d7 8e 10 80       	push   $0x80108ed7
80105500:	e8 5b b5 ff ff       	call   80100a60 <cprintf>
80105505:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105508:	83 c3 7c             	add    $0x7c,%ebx
8010550b:	81 fb 60 4d 11 80    	cmp    $0x80114d60,%ebx
80105511:	0f 84 81 00 00 00    	je     80105598 <procdump+0xb8>
    if(p->state == UNUSED)
80105517:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010551a:	85 c0                	test   %eax,%eax
8010551c:	74 ea                	je     80105508 <procdump+0x28>
      state = "???";
8010551e:	ba 6b 8b 10 80       	mov    $0x80108b6b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105523:	83 f8 05             	cmp    $0x5,%eax
80105526:	77 11                	ja     80105539 <procdump+0x59>
80105528:	8b 14 85 cc 8b 10 80 	mov    -0x7fef7434(,%eax,4),%edx
      state = "???";
8010552f:	b8 6b 8b 10 80       	mov    $0x80108b6b,%eax
80105534:	85 d2                	test   %edx,%edx
80105536:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80105539:	53                   	push   %ebx
8010553a:	52                   	push   %edx
8010553b:	ff 73 a4             	push   -0x5c(%ebx)
8010553e:	68 6f 8b 10 80       	push   $0x80108b6f
80105543:	e8 18 b5 ff ff       	call   80100a60 <cprintf>
    if(p->state == SLEEPING){
80105548:	83 c4 10             	add    $0x10,%esp
8010554b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010554f:	75 a7                	jne    801054f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105551:	83 ec 08             	sub    $0x8,%esp
80105554:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105557:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010555a:	50                   	push   %eax
8010555b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010555e:	8b 40 0c             	mov    0xc(%eax),%eax
80105561:	83 c0 08             	add    $0x8,%eax
80105564:	50                   	push   %eax
80105565:	e8 86 01 00 00       	call   801056f0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010556a:	83 c4 10             	add    $0x10,%esp
8010556d:	8d 76 00             	lea    0x0(%esi),%esi
80105570:	8b 17                	mov    (%edi),%edx
80105572:	85 d2                	test   %edx,%edx
80105574:	74 82                	je     801054f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80105576:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105579:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010557c:	52                   	push   %edx
8010557d:	68 04 85 10 80       	push   $0x80108504
80105582:	e8 d9 b4 ff ff       	call   80100a60 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80105587:	83 c4 10             	add    $0x10,%esp
8010558a:	39 fe                	cmp    %edi,%esi
8010558c:	75 e2                	jne    80105570 <procdump+0x90>
8010558e:	e9 65 ff ff ff       	jmp    801054f8 <procdump+0x18>
80105593:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105597:	90                   	nop
  }
}
80105598:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010559b:	5b                   	pop    %ebx
8010559c:	5e                   	pop    %esi
8010559d:	5f                   	pop    %edi
8010559e:	5d                   	pop    %ebp
8010559f:	c3                   	ret    

801055a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	53                   	push   %ebx
801055a4:	83 ec 0c             	sub    $0xc,%esp
801055a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801055aa:	68 e4 8b 10 80       	push   $0x80108be4
801055af:	8d 43 04             	lea    0x4(%ebx),%eax
801055b2:	50                   	push   %eax
801055b3:	e8 18 01 00 00       	call   801056d0 <initlock>
  lk->name = name;
801055b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801055bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801055c1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801055c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801055cb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801055ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055d1:	c9                   	leave  
801055d2:	c3                   	ret    
801055d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801055e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	56                   	push   %esi
801055e4:	53                   	push   %ebx
801055e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801055e8:	8d 73 04             	lea    0x4(%ebx),%esi
801055eb:	83 ec 0c             	sub    $0xc,%esp
801055ee:	56                   	push   %esi
801055ef:	e8 ac 02 00 00       	call   801058a0 <acquire>
  while (lk->locked) {
801055f4:	8b 13                	mov    (%ebx),%edx
801055f6:	83 c4 10             	add    $0x10,%esp
801055f9:	85 d2                	test   %edx,%edx
801055fb:	74 16                	je     80105613 <acquiresleep+0x33>
801055fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105600:	83 ec 08             	sub    $0x8,%esp
80105603:	56                   	push   %esi
80105604:	53                   	push   %ebx
80105605:	e8 36 fd ff ff       	call   80105340 <sleep>
  while (lk->locked) {
8010560a:	8b 03                	mov    (%ebx),%eax
8010560c:	83 c4 10             	add    $0x10,%esp
8010560f:	85 c0                	test   %eax,%eax
80105611:	75 ed                	jne    80105600 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105613:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105619:	e8 52 f6 ff ff       	call   80104c70 <myproc>
8010561e:	8b 40 10             	mov    0x10(%eax),%eax
80105621:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105624:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105627:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010562a:	5b                   	pop    %ebx
8010562b:	5e                   	pop    %esi
8010562c:	5d                   	pop    %ebp
  release(&lk->lk);
8010562d:	e9 0e 02 00 00       	jmp    80105840 <release>
80105632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105640 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	56                   	push   %esi
80105644:	53                   	push   %ebx
80105645:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105648:	8d 73 04             	lea    0x4(%ebx),%esi
8010564b:	83 ec 0c             	sub    $0xc,%esp
8010564e:	56                   	push   %esi
8010564f:	e8 4c 02 00 00       	call   801058a0 <acquire>
  lk->locked = 0;
80105654:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010565a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105661:	89 1c 24             	mov    %ebx,(%esp)
80105664:	e8 97 fd ff ff       	call   80105400 <wakeup>
  release(&lk->lk);
80105669:	89 75 08             	mov    %esi,0x8(%ebp)
8010566c:	83 c4 10             	add    $0x10,%esp
}
8010566f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105672:	5b                   	pop    %ebx
80105673:	5e                   	pop    %esi
80105674:	5d                   	pop    %ebp
  release(&lk->lk);
80105675:	e9 c6 01 00 00       	jmp    80105840 <release>
8010567a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105680 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	57                   	push   %edi
80105684:	31 ff                	xor    %edi,%edi
80105686:	56                   	push   %esi
80105687:	53                   	push   %ebx
80105688:	83 ec 18             	sub    $0x18,%esp
8010568b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010568e:	8d 73 04             	lea    0x4(%ebx),%esi
80105691:	56                   	push   %esi
80105692:	e8 09 02 00 00       	call   801058a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105697:	8b 03                	mov    (%ebx),%eax
80105699:	83 c4 10             	add    $0x10,%esp
8010569c:	85 c0                	test   %eax,%eax
8010569e:	75 18                	jne    801056b8 <holdingsleep+0x38>
  release(&lk->lk);
801056a0:	83 ec 0c             	sub    $0xc,%esp
801056a3:	56                   	push   %esi
801056a4:	e8 97 01 00 00       	call   80105840 <release>
  return r;
}
801056a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056ac:	89 f8                	mov    %edi,%eax
801056ae:	5b                   	pop    %ebx
801056af:	5e                   	pop    %esi
801056b0:	5f                   	pop    %edi
801056b1:	5d                   	pop    %ebp
801056b2:	c3                   	ret    
801056b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056b7:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
801056b8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801056bb:	e8 b0 f5 ff ff       	call   80104c70 <myproc>
801056c0:	39 58 10             	cmp    %ebx,0x10(%eax)
801056c3:	0f 94 c0             	sete   %al
801056c6:	0f b6 c0             	movzbl %al,%eax
801056c9:	89 c7                	mov    %eax,%edi
801056cb:	eb d3                	jmp    801056a0 <holdingsleep+0x20>
801056cd:	66 90                	xchg   %ax,%ax
801056cf:	90                   	nop

801056d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801056d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801056d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801056df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801056e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801056e9:	5d                   	pop    %ebp
801056ea:	c3                   	ret    
801056eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056ef:	90                   	nop

801056f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801056f0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801056f1:	31 d2                	xor    %edx,%edx
{
801056f3:	89 e5                	mov    %esp,%ebp
801056f5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801056f6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801056f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801056fc:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801056ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105700:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105706:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010570c:	77 1a                	ja     80105728 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010570e:	8b 58 04             	mov    0x4(%eax),%ebx
80105711:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105714:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105717:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105719:	83 fa 0a             	cmp    $0xa,%edx
8010571c:	75 e2                	jne    80105700 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010571e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105721:	c9                   	leave  
80105722:	c3                   	ret    
80105723:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105727:	90                   	nop
  for(; i < 10; i++)
80105728:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010572b:	8d 51 28             	lea    0x28(%ecx),%edx
8010572e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105730:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105736:	83 c0 04             	add    $0x4,%eax
80105739:	39 d0                	cmp    %edx,%eax
8010573b:	75 f3                	jne    80105730 <getcallerpcs+0x40>
}
8010573d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105740:	c9                   	leave  
80105741:	c3                   	ret    
80105742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105750 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	53                   	push   %ebx
80105754:	83 ec 04             	sub    $0x4,%esp
80105757:	9c                   	pushf  
80105758:	5b                   	pop    %ebx
  asm volatile("cli");
80105759:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010575a:	e8 91 f4 ff ff       	call   80104bf0 <mycpu>
8010575f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105765:	85 c0                	test   %eax,%eax
80105767:	74 17                	je     80105780 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105769:	e8 82 f4 ff ff       	call   80104bf0 <mycpu>
8010576e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105775:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105778:	c9                   	leave  
80105779:	c3                   	ret    
8010577a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105780:	e8 6b f4 ff ff       	call   80104bf0 <mycpu>
80105785:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010578b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105791:	eb d6                	jmp    80105769 <pushcli+0x19>
80105793:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010579a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057a0 <popcli>:

void
popcli(void)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801057a6:	9c                   	pushf  
801057a7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801057a8:	f6 c4 02             	test   $0x2,%ah
801057ab:	75 35                	jne    801057e2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801057ad:	e8 3e f4 ff ff       	call   80104bf0 <mycpu>
801057b2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801057b9:	78 34                	js     801057ef <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801057bb:	e8 30 f4 ff ff       	call   80104bf0 <mycpu>
801057c0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801057c6:	85 d2                	test   %edx,%edx
801057c8:	74 06                	je     801057d0 <popcli+0x30>
    sti();
}
801057ca:	c9                   	leave  
801057cb:	c3                   	ret    
801057cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801057d0:	e8 1b f4 ff ff       	call   80104bf0 <mycpu>
801057d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801057db:	85 c0                	test   %eax,%eax
801057dd:	74 eb                	je     801057ca <popcli+0x2a>
  asm volatile("sti");
801057df:	fb                   	sti    
}
801057e0:	c9                   	leave  
801057e1:	c3                   	ret    
    panic("popcli - interruptible");
801057e2:	83 ec 0c             	sub    $0xc,%esp
801057e5:	68 ef 8b 10 80       	push   $0x80108bef
801057ea:	e8 f1 b4 ff ff       	call   80100ce0 <panic>
    panic("popcli");
801057ef:	83 ec 0c             	sub    $0xc,%esp
801057f2:	68 06 8c 10 80       	push   $0x80108c06
801057f7:	e8 e4 b4 ff ff       	call   80100ce0 <panic>
801057fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105800 <holding>:
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	56                   	push   %esi
80105804:	53                   	push   %ebx
80105805:	8b 75 08             	mov    0x8(%ebp),%esi
80105808:	31 db                	xor    %ebx,%ebx
  pushcli();
8010580a:	e8 41 ff ff ff       	call   80105750 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010580f:	8b 06                	mov    (%esi),%eax
80105811:	85 c0                	test   %eax,%eax
80105813:	75 0b                	jne    80105820 <holding+0x20>
  popcli();
80105815:	e8 86 ff ff ff       	call   801057a0 <popcli>
}
8010581a:	89 d8                	mov    %ebx,%eax
8010581c:	5b                   	pop    %ebx
8010581d:	5e                   	pop    %esi
8010581e:	5d                   	pop    %ebp
8010581f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80105820:	8b 5e 08             	mov    0x8(%esi),%ebx
80105823:	e8 c8 f3 ff ff       	call   80104bf0 <mycpu>
80105828:	39 c3                	cmp    %eax,%ebx
8010582a:	0f 94 c3             	sete   %bl
  popcli();
8010582d:	e8 6e ff ff ff       	call   801057a0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105832:	0f b6 db             	movzbl %bl,%ebx
}
80105835:	89 d8                	mov    %ebx,%eax
80105837:	5b                   	pop    %ebx
80105838:	5e                   	pop    %esi
80105839:	5d                   	pop    %ebp
8010583a:	c3                   	ret    
8010583b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010583f:	90                   	nop

80105840 <release>:
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	56                   	push   %esi
80105844:	53                   	push   %ebx
80105845:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105848:	e8 03 ff ff ff       	call   80105750 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010584d:	8b 03                	mov    (%ebx),%eax
8010584f:	85 c0                	test   %eax,%eax
80105851:	75 15                	jne    80105868 <release+0x28>
  popcli();
80105853:	e8 48 ff ff ff       	call   801057a0 <popcli>
    panic("release");
80105858:	83 ec 0c             	sub    $0xc,%esp
8010585b:	68 0d 8c 10 80       	push   $0x80108c0d
80105860:	e8 7b b4 ff ff       	call   80100ce0 <panic>
80105865:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105868:	8b 73 08             	mov    0x8(%ebx),%esi
8010586b:	e8 80 f3 ff ff       	call   80104bf0 <mycpu>
80105870:	39 c6                	cmp    %eax,%esi
80105872:	75 df                	jne    80105853 <release+0x13>
  popcli();
80105874:	e8 27 ff ff ff       	call   801057a0 <popcli>
  lk->pcs[0] = 0;
80105879:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105880:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105887:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010588c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105892:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105895:	5b                   	pop    %ebx
80105896:	5e                   	pop    %esi
80105897:	5d                   	pop    %ebp
  popcli();
80105898:	e9 03 ff ff ff       	jmp    801057a0 <popcli>
8010589d:	8d 76 00             	lea    0x0(%esi),%esi

801058a0 <acquire>:
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	53                   	push   %ebx
801058a4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801058a7:	e8 a4 fe ff ff       	call   80105750 <pushcli>
  if(holding(lk))
801058ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801058af:	e8 9c fe ff ff       	call   80105750 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801058b4:	8b 03                	mov    (%ebx),%eax
801058b6:	85 c0                	test   %eax,%eax
801058b8:	75 7e                	jne    80105938 <acquire+0x98>
  popcli();
801058ba:	e8 e1 fe ff ff       	call   801057a0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801058bf:	b9 01 00 00 00       	mov    $0x1,%ecx
801058c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
801058c8:	8b 55 08             	mov    0x8(%ebp),%edx
801058cb:	89 c8                	mov    %ecx,%eax
801058cd:	f0 87 02             	lock xchg %eax,(%edx)
801058d0:	85 c0                	test   %eax,%eax
801058d2:	75 f4                	jne    801058c8 <acquire+0x28>
  __sync_synchronize();
801058d4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801058d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801058dc:	e8 0f f3 ff ff       	call   80104bf0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801058e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
801058e4:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
801058e6:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
801058e9:	31 c0                	xor    %eax,%eax
801058eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058ef:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801058f0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801058f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801058fc:	77 1a                	ja     80105918 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
801058fe:	8b 5a 04             	mov    0x4(%edx),%ebx
80105901:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105905:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105908:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010590a:	83 f8 0a             	cmp    $0xa,%eax
8010590d:	75 e1                	jne    801058f0 <acquire+0x50>
}
8010590f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105912:	c9                   	leave  
80105913:	c3                   	ret    
80105914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105918:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010591c:	8d 51 34             	lea    0x34(%ecx),%edx
8010591f:	90                   	nop
    pcs[i] = 0;
80105920:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105926:	83 c0 04             	add    $0x4,%eax
80105929:	39 c2                	cmp    %eax,%edx
8010592b:	75 f3                	jne    80105920 <acquire+0x80>
}
8010592d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105930:	c9                   	leave  
80105931:	c3                   	ret    
80105932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105938:	8b 5b 08             	mov    0x8(%ebx),%ebx
8010593b:	e8 b0 f2 ff ff       	call   80104bf0 <mycpu>
80105940:	39 c3                	cmp    %eax,%ebx
80105942:	0f 85 72 ff ff ff    	jne    801058ba <acquire+0x1a>
  popcli();
80105948:	e8 53 fe ff ff       	call   801057a0 <popcli>
    panic("acquire");
8010594d:	83 ec 0c             	sub    $0xc,%esp
80105950:	68 15 8c 10 80       	push   $0x80108c15
80105955:	e8 86 b3 ff ff       	call   80100ce0 <panic>
8010595a:	66 90                	xchg   %ax,%ax
8010595c:	66 90                	xchg   %ax,%ax
8010595e:	66 90                	xchg   %ax,%ax

80105960 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105960:	55                   	push   %ebp
80105961:	89 e5                	mov    %esp,%ebp
80105963:	57                   	push   %edi
80105964:	8b 55 08             	mov    0x8(%ebp),%edx
80105967:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010596a:	53                   	push   %ebx
8010596b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
8010596e:	89 d7                	mov    %edx,%edi
80105970:	09 cf                	or     %ecx,%edi
80105972:	83 e7 03             	and    $0x3,%edi
80105975:	75 29                	jne    801059a0 <memset+0x40>
    c &= 0xFF;
80105977:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010597a:	c1 e0 18             	shl    $0x18,%eax
8010597d:	89 fb                	mov    %edi,%ebx
8010597f:	c1 e9 02             	shr    $0x2,%ecx
80105982:	c1 e3 10             	shl    $0x10,%ebx
80105985:	09 d8                	or     %ebx,%eax
80105987:	09 f8                	or     %edi,%eax
80105989:	c1 e7 08             	shl    $0x8,%edi
8010598c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
8010598e:	89 d7                	mov    %edx,%edi
80105990:	fc                   	cld    
80105991:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105993:	5b                   	pop    %ebx
80105994:	89 d0                	mov    %edx,%eax
80105996:	5f                   	pop    %edi
80105997:	5d                   	pop    %ebp
80105998:	c3                   	ret    
80105999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801059a0:	89 d7                	mov    %edx,%edi
801059a2:	fc                   	cld    
801059a3:	f3 aa                	rep stos %al,%es:(%edi)
801059a5:	5b                   	pop    %ebx
801059a6:	89 d0                	mov    %edx,%eax
801059a8:	5f                   	pop    %edi
801059a9:	5d                   	pop    %ebp
801059aa:	c3                   	ret    
801059ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059af:	90                   	nop

801059b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	56                   	push   %esi
801059b4:	8b 75 10             	mov    0x10(%ebp),%esi
801059b7:	8b 55 08             	mov    0x8(%ebp),%edx
801059ba:	53                   	push   %ebx
801059bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801059be:	85 f6                	test   %esi,%esi
801059c0:	74 2e                	je     801059f0 <memcmp+0x40>
801059c2:	01 c6                	add    %eax,%esi
801059c4:	eb 14                	jmp    801059da <memcmp+0x2a>
801059c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801059d0:	83 c0 01             	add    $0x1,%eax
801059d3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801059d6:	39 f0                	cmp    %esi,%eax
801059d8:	74 16                	je     801059f0 <memcmp+0x40>
    if(*s1 != *s2)
801059da:	0f b6 0a             	movzbl (%edx),%ecx
801059dd:	0f b6 18             	movzbl (%eax),%ebx
801059e0:	38 d9                	cmp    %bl,%cl
801059e2:	74 ec                	je     801059d0 <memcmp+0x20>
      return *s1 - *s2;
801059e4:	0f b6 c1             	movzbl %cl,%eax
801059e7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801059e9:	5b                   	pop    %ebx
801059ea:	5e                   	pop    %esi
801059eb:	5d                   	pop    %ebp
801059ec:	c3                   	ret    
801059ed:	8d 76 00             	lea    0x0(%esi),%esi
801059f0:	5b                   	pop    %ebx
  return 0;
801059f1:	31 c0                	xor    %eax,%eax
}
801059f3:	5e                   	pop    %esi
801059f4:	5d                   	pop    %ebp
801059f5:	c3                   	ret    
801059f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059fd:	8d 76 00             	lea    0x0(%esi),%esi

80105a00 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	57                   	push   %edi
80105a04:	8b 55 08             	mov    0x8(%ebp),%edx
80105a07:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105a0a:	56                   	push   %esi
80105a0b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105a0e:	39 d6                	cmp    %edx,%esi
80105a10:	73 26                	jae    80105a38 <memmove+0x38>
80105a12:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105a15:	39 fa                	cmp    %edi,%edx
80105a17:	73 1f                	jae    80105a38 <memmove+0x38>
80105a19:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80105a1c:	85 c9                	test   %ecx,%ecx
80105a1e:	74 0c                	je     80105a2c <memmove+0x2c>
      *--d = *--s;
80105a20:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105a24:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105a27:	83 e8 01             	sub    $0x1,%eax
80105a2a:	73 f4                	jae    80105a20 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105a2c:	5e                   	pop    %esi
80105a2d:	89 d0                	mov    %edx,%eax
80105a2f:	5f                   	pop    %edi
80105a30:	5d                   	pop    %ebp
80105a31:	c3                   	ret    
80105a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80105a38:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80105a3b:	89 d7                	mov    %edx,%edi
80105a3d:	85 c9                	test   %ecx,%ecx
80105a3f:	74 eb                	je     80105a2c <memmove+0x2c>
80105a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105a48:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105a49:	39 c6                	cmp    %eax,%esi
80105a4b:	75 fb                	jne    80105a48 <memmove+0x48>
}
80105a4d:	5e                   	pop    %esi
80105a4e:	89 d0                	mov    %edx,%eax
80105a50:	5f                   	pop    %edi
80105a51:	5d                   	pop    %ebp
80105a52:	c3                   	ret    
80105a53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a60 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105a60:	eb 9e                	jmp    80105a00 <memmove>
80105a62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a70 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	56                   	push   %esi
80105a74:	8b 75 10             	mov    0x10(%ebp),%esi
80105a77:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105a7a:	53                   	push   %ebx
80105a7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
80105a7e:	85 f6                	test   %esi,%esi
80105a80:	74 2e                	je     80105ab0 <strncmp+0x40>
80105a82:	01 d6                	add    %edx,%esi
80105a84:	eb 18                	jmp    80105a9e <strncmp+0x2e>
80105a86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a8d:	8d 76 00             	lea    0x0(%esi),%esi
80105a90:	38 d8                	cmp    %bl,%al
80105a92:	75 14                	jne    80105aa8 <strncmp+0x38>
    n--, p++, q++;
80105a94:	83 c2 01             	add    $0x1,%edx
80105a97:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80105a9a:	39 f2                	cmp    %esi,%edx
80105a9c:	74 12                	je     80105ab0 <strncmp+0x40>
80105a9e:	0f b6 01             	movzbl (%ecx),%eax
80105aa1:	0f b6 1a             	movzbl (%edx),%ebx
80105aa4:	84 c0                	test   %al,%al
80105aa6:	75 e8                	jne    80105a90 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80105aa8:	29 d8                	sub    %ebx,%eax
}
80105aaa:	5b                   	pop    %ebx
80105aab:	5e                   	pop    %esi
80105aac:	5d                   	pop    %ebp
80105aad:	c3                   	ret    
80105aae:	66 90                	xchg   %ax,%ax
80105ab0:	5b                   	pop    %ebx
    return 0;
80105ab1:	31 c0                	xor    %eax,%eax
}
80105ab3:	5e                   	pop    %esi
80105ab4:	5d                   	pop    %ebp
80105ab5:	c3                   	ret    
80105ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105abd:	8d 76 00             	lea    0x0(%esi),%esi

80105ac0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	57                   	push   %edi
80105ac4:	56                   	push   %esi
80105ac5:	8b 75 08             	mov    0x8(%ebp),%esi
80105ac8:	53                   	push   %ebx
80105ac9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105acc:	89 f0                	mov    %esi,%eax
80105ace:	eb 15                	jmp    80105ae5 <strncpy+0x25>
80105ad0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105ad4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105ad7:	83 c0 01             	add    $0x1,%eax
80105ada:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80105ade:	88 50 ff             	mov    %dl,-0x1(%eax)
80105ae1:	84 d2                	test   %dl,%dl
80105ae3:	74 09                	je     80105aee <strncpy+0x2e>
80105ae5:	89 cb                	mov    %ecx,%ebx
80105ae7:	83 e9 01             	sub    $0x1,%ecx
80105aea:	85 db                	test   %ebx,%ebx
80105aec:	7f e2                	jg     80105ad0 <strncpy+0x10>
    ;
  while(n-- > 0)
80105aee:	89 c2                	mov    %eax,%edx
80105af0:	85 c9                	test   %ecx,%ecx
80105af2:	7e 17                	jle    80105b0b <strncpy+0x4b>
80105af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105af8:	83 c2 01             	add    $0x1,%edx
80105afb:	89 c1                	mov    %eax,%ecx
80105afd:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80105b01:	29 d1                	sub    %edx,%ecx
80105b03:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80105b07:	85 c9                	test   %ecx,%ecx
80105b09:	7f ed                	jg     80105af8 <strncpy+0x38>
  return os;
}
80105b0b:	5b                   	pop    %ebx
80105b0c:	89 f0                	mov    %esi,%eax
80105b0e:	5e                   	pop    %esi
80105b0f:	5f                   	pop    %edi
80105b10:	5d                   	pop    %ebp
80105b11:	c3                   	ret    
80105b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b20 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	56                   	push   %esi
80105b24:	8b 55 10             	mov    0x10(%ebp),%edx
80105b27:	8b 75 08             	mov    0x8(%ebp),%esi
80105b2a:	53                   	push   %ebx
80105b2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80105b2e:	85 d2                	test   %edx,%edx
80105b30:	7e 25                	jle    80105b57 <safestrcpy+0x37>
80105b32:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105b36:	89 f2                	mov    %esi,%edx
80105b38:	eb 16                	jmp    80105b50 <safestrcpy+0x30>
80105b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105b40:	0f b6 08             	movzbl (%eax),%ecx
80105b43:	83 c0 01             	add    $0x1,%eax
80105b46:	83 c2 01             	add    $0x1,%edx
80105b49:	88 4a ff             	mov    %cl,-0x1(%edx)
80105b4c:	84 c9                	test   %cl,%cl
80105b4e:	74 04                	je     80105b54 <safestrcpy+0x34>
80105b50:	39 d8                	cmp    %ebx,%eax
80105b52:	75 ec                	jne    80105b40 <safestrcpy+0x20>
    ;
  *s = 0;
80105b54:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105b57:	89 f0                	mov    %esi,%eax
80105b59:	5b                   	pop    %ebx
80105b5a:	5e                   	pop    %esi
80105b5b:	5d                   	pop    %ebp
80105b5c:	c3                   	ret    
80105b5d:	8d 76 00             	lea    0x0(%esi),%esi

80105b60 <strlen>:

int
strlen(const char *s)
{
80105b60:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105b61:	31 c0                	xor    %eax,%eax
{
80105b63:	89 e5                	mov    %esp,%ebp
80105b65:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105b68:	80 3a 00             	cmpb   $0x0,(%edx)
80105b6b:	74 0c                	je     80105b79 <strlen+0x19>
80105b6d:	8d 76 00             	lea    0x0(%esi),%esi
80105b70:	83 c0 01             	add    $0x1,%eax
80105b73:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105b77:	75 f7                	jne    80105b70 <strlen+0x10>
    ;
  return n;
}
80105b79:	5d                   	pop    %ebp
80105b7a:	c3                   	ret    

80105b7b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105b7b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105b7f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105b83:	55                   	push   %ebp
  pushl %ebx
80105b84:	53                   	push   %ebx
  pushl %esi
80105b85:	56                   	push   %esi
  pushl %edi
80105b86:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105b87:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105b89:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105b8b:	5f                   	pop    %edi
  popl %esi
80105b8c:	5e                   	pop    %esi
  popl %ebx
80105b8d:	5b                   	pop    %ebx
  popl %ebp
80105b8e:	5d                   	pop    %ebp
  ret
80105b8f:	c3                   	ret    

80105b90 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	53                   	push   %ebx
80105b94:	83 ec 04             	sub    $0x4,%esp
80105b97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105b9a:	e8 d1 f0 ff ff       	call   80104c70 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105b9f:	8b 00                	mov    (%eax),%eax
80105ba1:	39 d8                	cmp    %ebx,%eax
80105ba3:	76 1b                	jbe    80105bc0 <fetchint+0x30>
80105ba5:	8d 53 04             	lea    0x4(%ebx),%edx
80105ba8:	39 d0                	cmp    %edx,%eax
80105baa:	72 14                	jb     80105bc0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105bac:	8b 45 0c             	mov    0xc(%ebp),%eax
80105baf:	8b 13                	mov    (%ebx),%edx
80105bb1:	89 10                	mov    %edx,(%eax)
  return 0;
80105bb3:	31 c0                	xor    %eax,%eax
}
80105bb5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bb8:	c9                   	leave  
80105bb9:	c3                   	ret    
80105bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bc5:	eb ee                	jmp    80105bb5 <fetchint+0x25>
80105bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bce:	66 90                	xchg   %ax,%ax

80105bd0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	53                   	push   %ebx
80105bd4:	83 ec 04             	sub    $0x4,%esp
80105bd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105bda:	e8 91 f0 ff ff       	call   80104c70 <myproc>

  if(addr >= curproc->sz)
80105bdf:	39 18                	cmp    %ebx,(%eax)
80105be1:	76 2d                	jbe    80105c10 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80105be3:	8b 55 0c             	mov    0xc(%ebp),%edx
80105be6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105be8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80105bea:	39 d3                	cmp    %edx,%ebx
80105bec:	73 22                	jae    80105c10 <fetchstr+0x40>
80105bee:	89 d8                	mov    %ebx,%eax
80105bf0:	eb 0d                	jmp    80105bff <fetchstr+0x2f>
80105bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105bf8:	83 c0 01             	add    $0x1,%eax
80105bfb:	39 c2                	cmp    %eax,%edx
80105bfd:	76 11                	jbe    80105c10 <fetchstr+0x40>
    if(*s == 0)
80105bff:	80 38 00             	cmpb   $0x0,(%eax)
80105c02:	75 f4                	jne    80105bf8 <fetchstr+0x28>
      return s - *pp;
80105c04:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105c06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c09:	c9                   	leave  
80105c0a:	c3                   	ret    
80105c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c0f:	90                   	nop
80105c10:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105c13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c18:	c9                   	leave  
80105c19:	c3                   	ret    
80105c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	56                   	push   %esi
80105c24:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105c25:	e8 46 f0 ff ff       	call   80104c70 <myproc>
80105c2a:	8b 55 08             	mov    0x8(%ebp),%edx
80105c2d:	8b 40 18             	mov    0x18(%eax),%eax
80105c30:	8b 40 44             	mov    0x44(%eax),%eax
80105c33:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105c36:	e8 35 f0 ff ff       	call   80104c70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105c3b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105c3e:	8b 00                	mov    (%eax),%eax
80105c40:	39 c6                	cmp    %eax,%esi
80105c42:	73 1c                	jae    80105c60 <argint+0x40>
80105c44:	8d 53 08             	lea    0x8(%ebx),%edx
80105c47:	39 d0                	cmp    %edx,%eax
80105c49:	72 15                	jb     80105c60 <argint+0x40>
  *ip = *(int*)(addr);
80105c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c4e:	8b 53 04             	mov    0x4(%ebx),%edx
80105c51:	89 10                	mov    %edx,(%eax)
  return 0;
80105c53:	31 c0                	xor    %eax,%eax
}
80105c55:	5b                   	pop    %ebx
80105c56:	5e                   	pop    %esi
80105c57:	5d                   	pop    %ebp
80105c58:	c3                   	ret    
80105c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105c65:	eb ee                	jmp    80105c55 <argint+0x35>
80105c67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c6e:	66 90                	xchg   %ax,%ax

80105c70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	57                   	push   %edi
80105c74:	56                   	push   %esi
80105c75:	53                   	push   %ebx
80105c76:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105c79:	e8 f2 ef ff ff       	call   80104c70 <myproc>
80105c7e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105c80:	e8 eb ef ff ff       	call   80104c70 <myproc>
80105c85:	8b 55 08             	mov    0x8(%ebp),%edx
80105c88:	8b 40 18             	mov    0x18(%eax),%eax
80105c8b:	8b 40 44             	mov    0x44(%eax),%eax
80105c8e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105c91:	e8 da ef ff ff       	call   80104c70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105c96:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105c99:	8b 00                	mov    (%eax),%eax
80105c9b:	39 c7                	cmp    %eax,%edi
80105c9d:	73 31                	jae    80105cd0 <argptr+0x60>
80105c9f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105ca2:	39 c8                	cmp    %ecx,%eax
80105ca4:	72 2a                	jb     80105cd0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105ca6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105ca9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105cac:	85 d2                	test   %edx,%edx
80105cae:	78 20                	js     80105cd0 <argptr+0x60>
80105cb0:	8b 16                	mov    (%esi),%edx
80105cb2:	39 c2                	cmp    %eax,%edx
80105cb4:	76 1a                	jbe    80105cd0 <argptr+0x60>
80105cb6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105cb9:	01 c3                	add    %eax,%ebx
80105cbb:	39 da                	cmp    %ebx,%edx
80105cbd:	72 11                	jb     80105cd0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80105cbf:	8b 55 0c             	mov    0xc(%ebp),%edx
80105cc2:	89 02                	mov    %eax,(%edx)
  return 0;
80105cc4:	31 c0                	xor    %eax,%eax
}
80105cc6:	83 c4 0c             	add    $0xc,%esp
80105cc9:	5b                   	pop    %ebx
80105cca:	5e                   	pop    %esi
80105ccb:	5f                   	pop    %edi
80105ccc:	5d                   	pop    %ebp
80105ccd:	c3                   	ret    
80105cce:	66 90                	xchg   %ax,%ax
    return -1;
80105cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cd5:	eb ef                	jmp    80105cc6 <argptr+0x56>
80105cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cde:	66 90                	xchg   %ax,%ax

80105ce0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	56                   	push   %esi
80105ce4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105ce5:	e8 86 ef ff ff       	call   80104c70 <myproc>
80105cea:	8b 55 08             	mov    0x8(%ebp),%edx
80105ced:	8b 40 18             	mov    0x18(%eax),%eax
80105cf0:	8b 40 44             	mov    0x44(%eax),%eax
80105cf3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105cf6:	e8 75 ef ff ff       	call   80104c70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105cfb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105cfe:	8b 00                	mov    (%eax),%eax
80105d00:	39 c6                	cmp    %eax,%esi
80105d02:	73 44                	jae    80105d48 <argstr+0x68>
80105d04:	8d 53 08             	lea    0x8(%ebx),%edx
80105d07:	39 d0                	cmp    %edx,%eax
80105d09:	72 3d                	jb     80105d48 <argstr+0x68>
  *ip = *(int*)(addr);
80105d0b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80105d0e:	e8 5d ef ff ff       	call   80104c70 <myproc>
  if(addr >= curproc->sz)
80105d13:	3b 18                	cmp    (%eax),%ebx
80105d15:	73 31                	jae    80105d48 <argstr+0x68>
  *pp = (char*)addr;
80105d17:	8b 55 0c             	mov    0xc(%ebp),%edx
80105d1a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105d1c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80105d1e:	39 d3                	cmp    %edx,%ebx
80105d20:	73 26                	jae    80105d48 <argstr+0x68>
80105d22:	89 d8                	mov    %ebx,%eax
80105d24:	eb 11                	jmp    80105d37 <argstr+0x57>
80105d26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d2d:	8d 76 00             	lea    0x0(%esi),%esi
80105d30:	83 c0 01             	add    $0x1,%eax
80105d33:	39 c2                	cmp    %eax,%edx
80105d35:	76 11                	jbe    80105d48 <argstr+0x68>
    if(*s == 0)
80105d37:	80 38 00             	cmpb   $0x0,(%eax)
80105d3a:	75 f4                	jne    80105d30 <argstr+0x50>
      return s - *pp;
80105d3c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80105d3e:	5b                   	pop    %ebx
80105d3f:	5e                   	pop    %esi
80105d40:	5d                   	pop    %ebp
80105d41:	c3                   	ret    
80105d42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d48:	5b                   	pop    %ebx
    return -1;
80105d49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d4e:	5e                   	pop    %esi
80105d4f:	5d                   	pop    %ebp
80105d50:	c3                   	ret    
80105d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d5f:	90                   	nop

80105d60 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	53                   	push   %ebx
80105d64:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105d67:	e8 04 ef ff ff       	call   80104c70 <myproc>
80105d6c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105d6e:	8b 40 18             	mov    0x18(%eax),%eax
80105d71:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105d74:	8d 50 ff             	lea    -0x1(%eax),%edx
80105d77:	83 fa 14             	cmp    $0x14,%edx
80105d7a:	77 24                	ja     80105da0 <syscall+0x40>
80105d7c:	8b 14 85 40 8c 10 80 	mov    -0x7fef73c0(,%eax,4),%edx
80105d83:	85 d2                	test   %edx,%edx
80105d85:	74 19                	je     80105da0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105d87:	ff d2                	call   *%edx
80105d89:	89 c2                	mov    %eax,%edx
80105d8b:	8b 43 18             	mov    0x18(%ebx),%eax
80105d8e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105d91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d94:	c9                   	leave  
80105d95:	c3                   	ret    
80105d96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d9d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105da0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105da1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105da4:	50                   	push   %eax
80105da5:	ff 73 10             	push   0x10(%ebx)
80105da8:	68 1d 8c 10 80       	push   $0x80108c1d
80105dad:	e8 ae ac ff ff       	call   80100a60 <cprintf>
    curproc->tf->eax = -1;
80105db2:	8b 43 18             	mov    0x18(%ebx),%eax
80105db5:	83 c4 10             	add    $0x10,%esp
80105db8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105dbf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105dc2:	c9                   	leave  
80105dc3:	c3                   	ret    
80105dc4:	66 90                	xchg   %ax,%ax
80105dc6:	66 90                	xchg   %ax,%ax
80105dc8:	66 90                	xchg   %ax,%ax
80105dca:	66 90                	xchg   %ax,%ax
80105dcc:	66 90                	xchg   %ax,%ax
80105dce:	66 90                	xchg   %ax,%ax

80105dd0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	57                   	push   %edi
80105dd4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105dd5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105dd8:	53                   	push   %ebx
80105dd9:	83 ec 34             	sub    $0x34,%esp
80105ddc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80105ddf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105de2:	57                   	push   %edi
80105de3:	50                   	push   %eax
{
80105de4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105de7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105dea:	e8 d1 d5 ff ff       	call   801033c0 <nameiparent>
80105def:	83 c4 10             	add    $0x10,%esp
80105df2:	85 c0                	test   %eax,%eax
80105df4:	0f 84 46 01 00 00    	je     80105f40 <create+0x170>
    return 0;
  ilock(dp);
80105dfa:	83 ec 0c             	sub    $0xc,%esp
80105dfd:	89 c3                	mov    %eax,%ebx
80105dff:	50                   	push   %eax
80105e00:	e8 7b cc ff ff       	call   80102a80 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105e05:	83 c4 0c             	add    $0xc,%esp
80105e08:	6a 00                	push   $0x0
80105e0a:	57                   	push   %edi
80105e0b:	53                   	push   %ebx
80105e0c:	e8 cf d1 ff ff       	call   80102fe0 <dirlookup>
80105e11:	83 c4 10             	add    $0x10,%esp
80105e14:	89 c6                	mov    %eax,%esi
80105e16:	85 c0                	test   %eax,%eax
80105e18:	74 56                	je     80105e70 <create+0xa0>
    iunlockput(dp);
80105e1a:	83 ec 0c             	sub    $0xc,%esp
80105e1d:	53                   	push   %ebx
80105e1e:	e8 ed ce ff ff       	call   80102d10 <iunlockput>
    ilock(ip);
80105e23:	89 34 24             	mov    %esi,(%esp)
80105e26:	e8 55 cc ff ff       	call   80102a80 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105e2b:	83 c4 10             	add    $0x10,%esp
80105e2e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105e33:	75 1b                	jne    80105e50 <create+0x80>
80105e35:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105e3a:	75 14                	jne    80105e50 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105e3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e3f:	89 f0                	mov    %esi,%eax
80105e41:	5b                   	pop    %ebx
80105e42:	5e                   	pop    %esi
80105e43:	5f                   	pop    %edi
80105e44:	5d                   	pop    %ebp
80105e45:	c3                   	ret    
80105e46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e4d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105e50:	83 ec 0c             	sub    $0xc,%esp
80105e53:	56                   	push   %esi
    return 0;
80105e54:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105e56:	e8 b5 ce ff ff       	call   80102d10 <iunlockput>
    return 0;
80105e5b:	83 c4 10             	add    $0x10,%esp
}
80105e5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e61:	89 f0                	mov    %esi,%eax
80105e63:	5b                   	pop    %ebx
80105e64:	5e                   	pop    %esi
80105e65:	5f                   	pop    %edi
80105e66:	5d                   	pop    %ebp
80105e67:	c3                   	ret    
80105e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e6f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105e70:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105e74:	83 ec 08             	sub    $0x8,%esp
80105e77:	50                   	push   %eax
80105e78:	ff 33                	push   (%ebx)
80105e7a:	e8 91 ca ff ff       	call   80102910 <ialloc>
80105e7f:	83 c4 10             	add    $0x10,%esp
80105e82:	89 c6                	mov    %eax,%esi
80105e84:	85 c0                	test   %eax,%eax
80105e86:	0f 84 cd 00 00 00    	je     80105f59 <create+0x189>
  ilock(ip);
80105e8c:	83 ec 0c             	sub    $0xc,%esp
80105e8f:	50                   	push   %eax
80105e90:	e8 eb cb ff ff       	call   80102a80 <ilock>
  ip->major = major;
80105e95:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105e99:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80105e9d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105ea1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105ea5:	b8 01 00 00 00       	mov    $0x1,%eax
80105eaa:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80105eae:	89 34 24             	mov    %esi,(%esp)
80105eb1:	e8 1a cb ff ff       	call   801029d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105eb6:	83 c4 10             	add    $0x10,%esp
80105eb9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105ebe:	74 30                	je     80105ef0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105ec0:	83 ec 04             	sub    $0x4,%esp
80105ec3:	ff 76 04             	push   0x4(%esi)
80105ec6:	57                   	push   %edi
80105ec7:	53                   	push   %ebx
80105ec8:	e8 13 d4 ff ff       	call   801032e0 <dirlink>
80105ecd:	83 c4 10             	add    $0x10,%esp
80105ed0:	85 c0                	test   %eax,%eax
80105ed2:	78 78                	js     80105f4c <create+0x17c>
  iunlockput(dp);
80105ed4:	83 ec 0c             	sub    $0xc,%esp
80105ed7:	53                   	push   %ebx
80105ed8:	e8 33 ce ff ff       	call   80102d10 <iunlockput>
  return ip;
80105edd:	83 c4 10             	add    $0x10,%esp
}
80105ee0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ee3:	89 f0                	mov    %esi,%eax
80105ee5:	5b                   	pop    %ebx
80105ee6:	5e                   	pop    %esi
80105ee7:	5f                   	pop    %edi
80105ee8:	5d                   	pop    %ebp
80105ee9:	c3                   	ret    
80105eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105ef0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105ef3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105ef8:	53                   	push   %ebx
80105ef9:	e8 d2 ca ff ff       	call   801029d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105efe:	83 c4 0c             	add    $0xc,%esp
80105f01:	ff 76 04             	push   0x4(%esi)
80105f04:	68 b4 8c 10 80       	push   $0x80108cb4
80105f09:	56                   	push   %esi
80105f0a:	e8 d1 d3 ff ff       	call   801032e0 <dirlink>
80105f0f:	83 c4 10             	add    $0x10,%esp
80105f12:	85 c0                	test   %eax,%eax
80105f14:	78 18                	js     80105f2e <create+0x15e>
80105f16:	83 ec 04             	sub    $0x4,%esp
80105f19:	ff 73 04             	push   0x4(%ebx)
80105f1c:	68 b3 8c 10 80       	push   $0x80108cb3
80105f21:	56                   	push   %esi
80105f22:	e8 b9 d3 ff ff       	call   801032e0 <dirlink>
80105f27:	83 c4 10             	add    $0x10,%esp
80105f2a:	85 c0                	test   %eax,%eax
80105f2c:	79 92                	jns    80105ec0 <create+0xf0>
      panic("create dots");
80105f2e:	83 ec 0c             	sub    $0xc,%esp
80105f31:	68 a7 8c 10 80       	push   $0x80108ca7
80105f36:	e8 a5 ad ff ff       	call   80100ce0 <panic>
80105f3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f3f:	90                   	nop
}
80105f40:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105f43:	31 f6                	xor    %esi,%esi
}
80105f45:	5b                   	pop    %ebx
80105f46:	89 f0                	mov    %esi,%eax
80105f48:	5e                   	pop    %esi
80105f49:	5f                   	pop    %edi
80105f4a:	5d                   	pop    %ebp
80105f4b:	c3                   	ret    
    panic("create: dirlink");
80105f4c:	83 ec 0c             	sub    $0xc,%esp
80105f4f:	68 b6 8c 10 80       	push   $0x80108cb6
80105f54:	e8 87 ad ff ff       	call   80100ce0 <panic>
    panic("create: ialloc");
80105f59:	83 ec 0c             	sub    $0xc,%esp
80105f5c:	68 98 8c 10 80       	push   $0x80108c98
80105f61:	e8 7a ad ff ff       	call   80100ce0 <panic>
80105f66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f6d:	8d 76 00             	lea    0x0(%esi),%esi

80105f70 <sys_dup>:
{
80105f70:	55                   	push   %ebp
80105f71:	89 e5                	mov    %esp,%ebp
80105f73:	56                   	push   %esi
80105f74:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105f75:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f78:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105f7b:	50                   	push   %eax
80105f7c:	6a 00                	push   $0x0
80105f7e:	e8 9d fc ff ff       	call   80105c20 <argint>
80105f83:	83 c4 10             	add    $0x10,%esp
80105f86:	85 c0                	test   %eax,%eax
80105f88:	78 36                	js     80105fc0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105f8a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105f8e:	77 30                	ja     80105fc0 <sys_dup+0x50>
80105f90:	e8 db ec ff ff       	call   80104c70 <myproc>
80105f95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f98:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105f9c:	85 f6                	test   %esi,%esi
80105f9e:	74 20                	je     80105fc0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105fa0:	e8 cb ec ff ff       	call   80104c70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105fa5:	31 db                	xor    %ebx,%ebx
80105fa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fae:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105fb0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105fb4:	85 d2                	test   %edx,%edx
80105fb6:	74 18                	je     80105fd0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105fb8:	83 c3 01             	add    $0x1,%ebx
80105fbb:	83 fb 10             	cmp    $0x10,%ebx
80105fbe:	75 f0                	jne    80105fb0 <sys_dup+0x40>
}
80105fc0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105fc3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105fc8:	89 d8                	mov    %ebx,%eax
80105fca:	5b                   	pop    %ebx
80105fcb:	5e                   	pop    %esi
80105fcc:	5d                   	pop    %ebp
80105fcd:	c3                   	ret    
80105fce:	66 90                	xchg   %ax,%ax
  filedup(f);
80105fd0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105fd3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105fd7:	56                   	push   %esi
80105fd8:	e8 c3 c1 ff ff       	call   801021a0 <filedup>
  return fd;
80105fdd:	83 c4 10             	add    $0x10,%esp
}
80105fe0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105fe3:	89 d8                	mov    %ebx,%eax
80105fe5:	5b                   	pop    %ebx
80105fe6:	5e                   	pop    %esi
80105fe7:	5d                   	pop    %ebp
80105fe8:	c3                   	ret    
80105fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ff0 <sys_read>:
{
80105ff0:	55                   	push   %ebp
80105ff1:	89 e5                	mov    %esp,%ebp
80105ff3:	56                   	push   %esi
80105ff4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105ff5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105ff8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105ffb:	53                   	push   %ebx
80105ffc:	6a 00                	push   $0x0
80105ffe:	e8 1d fc ff ff       	call   80105c20 <argint>
80106003:	83 c4 10             	add    $0x10,%esp
80106006:	85 c0                	test   %eax,%eax
80106008:	78 5e                	js     80106068 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010600a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010600e:	77 58                	ja     80106068 <sys_read+0x78>
80106010:	e8 5b ec ff ff       	call   80104c70 <myproc>
80106015:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106018:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010601c:	85 f6                	test   %esi,%esi
8010601e:	74 48                	je     80106068 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106020:	83 ec 08             	sub    $0x8,%esp
80106023:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106026:	50                   	push   %eax
80106027:	6a 02                	push   $0x2
80106029:	e8 f2 fb ff ff       	call   80105c20 <argint>
8010602e:	83 c4 10             	add    $0x10,%esp
80106031:	85 c0                	test   %eax,%eax
80106033:	78 33                	js     80106068 <sys_read+0x78>
80106035:	83 ec 04             	sub    $0x4,%esp
80106038:	ff 75 f0             	push   -0x10(%ebp)
8010603b:	53                   	push   %ebx
8010603c:	6a 01                	push   $0x1
8010603e:	e8 2d fc ff ff       	call   80105c70 <argptr>
80106043:	83 c4 10             	add    $0x10,%esp
80106046:	85 c0                	test   %eax,%eax
80106048:	78 1e                	js     80106068 <sys_read+0x78>
  return fileread(f, p, n);
8010604a:	83 ec 04             	sub    $0x4,%esp
8010604d:	ff 75 f0             	push   -0x10(%ebp)
80106050:	ff 75 f4             	push   -0xc(%ebp)
80106053:	56                   	push   %esi
80106054:	e8 c7 c2 ff ff       	call   80102320 <fileread>
80106059:	83 c4 10             	add    $0x10,%esp
}
8010605c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010605f:	5b                   	pop    %ebx
80106060:	5e                   	pop    %esi
80106061:	5d                   	pop    %ebp
80106062:	c3                   	ret    
80106063:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106067:	90                   	nop
    return -1;
80106068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010606d:	eb ed                	jmp    8010605c <sys_read+0x6c>
8010606f:	90                   	nop

80106070 <sys_write>:
{
80106070:	55                   	push   %ebp
80106071:	89 e5                	mov    %esp,%ebp
80106073:	56                   	push   %esi
80106074:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106075:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106078:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010607b:	53                   	push   %ebx
8010607c:	6a 00                	push   $0x0
8010607e:	e8 9d fb ff ff       	call   80105c20 <argint>
80106083:	83 c4 10             	add    $0x10,%esp
80106086:	85 c0                	test   %eax,%eax
80106088:	78 5e                	js     801060e8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010608a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010608e:	77 58                	ja     801060e8 <sys_write+0x78>
80106090:	e8 db eb ff ff       	call   80104c70 <myproc>
80106095:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106098:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010609c:	85 f6                	test   %esi,%esi
8010609e:	74 48                	je     801060e8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801060a0:	83 ec 08             	sub    $0x8,%esp
801060a3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060a6:	50                   	push   %eax
801060a7:	6a 02                	push   $0x2
801060a9:	e8 72 fb ff ff       	call   80105c20 <argint>
801060ae:	83 c4 10             	add    $0x10,%esp
801060b1:	85 c0                	test   %eax,%eax
801060b3:	78 33                	js     801060e8 <sys_write+0x78>
801060b5:	83 ec 04             	sub    $0x4,%esp
801060b8:	ff 75 f0             	push   -0x10(%ebp)
801060bb:	53                   	push   %ebx
801060bc:	6a 01                	push   $0x1
801060be:	e8 ad fb ff ff       	call   80105c70 <argptr>
801060c3:	83 c4 10             	add    $0x10,%esp
801060c6:	85 c0                	test   %eax,%eax
801060c8:	78 1e                	js     801060e8 <sys_write+0x78>
  return filewrite(f, p, n);
801060ca:	83 ec 04             	sub    $0x4,%esp
801060cd:	ff 75 f0             	push   -0x10(%ebp)
801060d0:	ff 75 f4             	push   -0xc(%ebp)
801060d3:	56                   	push   %esi
801060d4:	e8 d7 c2 ff ff       	call   801023b0 <filewrite>
801060d9:	83 c4 10             	add    $0x10,%esp
}
801060dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801060df:	5b                   	pop    %ebx
801060e0:	5e                   	pop    %esi
801060e1:	5d                   	pop    %ebp
801060e2:	c3                   	ret    
801060e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801060e7:	90                   	nop
    return -1;
801060e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060ed:	eb ed                	jmp    801060dc <sys_write+0x6c>
801060ef:	90                   	nop

801060f0 <sys_close>:
{
801060f0:	55                   	push   %ebp
801060f1:	89 e5                	mov    %esp,%ebp
801060f3:	56                   	push   %esi
801060f4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801060f5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801060f8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801060fb:	50                   	push   %eax
801060fc:	6a 00                	push   $0x0
801060fe:	e8 1d fb ff ff       	call   80105c20 <argint>
80106103:	83 c4 10             	add    $0x10,%esp
80106106:	85 c0                	test   %eax,%eax
80106108:	78 3e                	js     80106148 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010610a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010610e:	77 38                	ja     80106148 <sys_close+0x58>
80106110:	e8 5b eb ff ff       	call   80104c70 <myproc>
80106115:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106118:	8d 5a 08             	lea    0x8(%edx),%ebx
8010611b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010611f:	85 f6                	test   %esi,%esi
80106121:	74 25                	je     80106148 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80106123:	e8 48 eb ff ff       	call   80104c70 <myproc>
  fileclose(f);
80106128:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010612b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80106132:	00 
  fileclose(f);
80106133:	56                   	push   %esi
80106134:	e8 b7 c0 ff ff       	call   801021f0 <fileclose>
  return 0;
80106139:	83 c4 10             	add    $0x10,%esp
8010613c:	31 c0                	xor    %eax,%eax
}
8010613e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106141:	5b                   	pop    %ebx
80106142:	5e                   	pop    %esi
80106143:	5d                   	pop    %ebp
80106144:	c3                   	ret    
80106145:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106148:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010614d:	eb ef                	jmp    8010613e <sys_close+0x4e>
8010614f:	90                   	nop

80106150 <sys_fstat>:
{
80106150:	55                   	push   %ebp
80106151:	89 e5                	mov    %esp,%ebp
80106153:	56                   	push   %esi
80106154:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106155:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106158:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010615b:	53                   	push   %ebx
8010615c:	6a 00                	push   $0x0
8010615e:	e8 bd fa ff ff       	call   80105c20 <argint>
80106163:	83 c4 10             	add    $0x10,%esp
80106166:	85 c0                	test   %eax,%eax
80106168:	78 46                	js     801061b0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010616a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010616e:	77 40                	ja     801061b0 <sys_fstat+0x60>
80106170:	e8 fb ea ff ff       	call   80104c70 <myproc>
80106175:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106178:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010617c:	85 f6                	test   %esi,%esi
8010617e:	74 30                	je     801061b0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106180:	83 ec 04             	sub    $0x4,%esp
80106183:	6a 14                	push   $0x14
80106185:	53                   	push   %ebx
80106186:	6a 01                	push   $0x1
80106188:	e8 e3 fa ff ff       	call   80105c70 <argptr>
8010618d:	83 c4 10             	add    $0x10,%esp
80106190:	85 c0                	test   %eax,%eax
80106192:	78 1c                	js     801061b0 <sys_fstat+0x60>
  return filestat(f, st);
80106194:	83 ec 08             	sub    $0x8,%esp
80106197:	ff 75 f4             	push   -0xc(%ebp)
8010619a:	56                   	push   %esi
8010619b:	e8 30 c1 ff ff       	call   801022d0 <filestat>
801061a0:	83 c4 10             	add    $0x10,%esp
}
801061a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801061a6:	5b                   	pop    %ebx
801061a7:	5e                   	pop    %esi
801061a8:	5d                   	pop    %ebp
801061a9:	c3                   	ret    
801061aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801061b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061b5:	eb ec                	jmp    801061a3 <sys_fstat+0x53>
801061b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061be:	66 90                	xchg   %ax,%ax

801061c0 <sys_link>:
{
801061c0:	55                   	push   %ebp
801061c1:	89 e5                	mov    %esp,%ebp
801061c3:	57                   	push   %edi
801061c4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801061c5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801061c8:	53                   	push   %ebx
801061c9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801061cc:	50                   	push   %eax
801061cd:	6a 00                	push   $0x0
801061cf:	e8 0c fb ff ff       	call   80105ce0 <argstr>
801061d4:	83 c4 10             	add    $0x10,%esp
801061d7:	85 c0                	test   %eax,%eax
801061d9:	0f 88 fb 00 00 00    	js     801062da <sys_link+0x11a>
801061df:	83 ec 08             	sub    $0x8,%esp
801061e2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801061e5:	50                   	push   %eax
801061e6:	6a 01                	push   $0x1
801061e8:	e8 f3 fa ff ff       	call   80105ce0 <argstr>
801061ed:	83 c4 10             	add    $0x10,%esp
801061f0:	85 c0                	test   %eax,%eax
801061f2:	0f 88 e2 00 00 00    	js     801062da <sys_link+0x11a>
  begin_op();
801061f8:	e8 63 de ff ff       	call   80104060 <begin_op>
  if((ip = namei(old)) == 0){
801061fd:	83 ec 0c             	sub    $0xc,%esp
80106200:	ff 75 d4             	push   -0x2c(%ebp)
80106203:	e8 98 d1 ff ff       	call   801033a0 <namei>
80106208:	83 c4 10             	add    $0x10,%esp
8010620b:	89 c3                	mov    %eax,%ebx
8010620d:	85 c0                	test   %eax,%eax
8010620f:	0f 84 e4 00 00 00    	je     801062f9 <sys_link+0x139>
  ilock(ip);
80106215:	83 ec 0c             	sub    $0xc,%esp
80106218:	50                   	push   %eax
80106219:	e8 62 c8 ff ff       	call   80102a80 <ilock>
  if(ip->type == T_DIR){
8010621e:	83 c4 10             	add    $0x10,%esp
80106221:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106226:	0f 84 b5 00 00 00    	je     801062e1 <sys_link+0x121>
  iupdate(ip);
8010622c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010622f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106234:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106237:	53                   	push   %ebx
80106238:	e8 93 c7 ff ff       	call   801029d0 <iupdate>
  iunlock(ip);
8010623d:	89 1c 24             	mov    %ebx,(%esp)
80106240:	e8 1b c9 ff ff       	call   80102b60 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106245:	58                   	pop    %eax
80106246:	5a                   	pop    %edx
80106247:	57                   	push   %edi
80106248:	ff 75 d0             	push   -0x30(%ebp)
8010624b:	e8 70 d1 ff ff       	call   801033c0 <nameiparent>
80106250:	83 c4 10             	add    $0x10,%esp
80106253:	89 c6                	mov    %eax,%esi
80106255:	85 c0                	test   %eax,%eax
80106257:	74 5b                	je     801062b4 <sys_link+0xf4>
  ilock(dp);
80106259:	83 ec 0c             	sub    $0xc,%esp
8010625c:	50                   	push   %eax
8010625d:	e8 1e c8 ff ff       	call   80102a80 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106262:	8b 03                	mov    (%ebx),%eax
80106264:	83 c4 10             	add    $0x10,%esp
80106267:	39 06                	cmp    %eax,(%esi)
80106269:	75 3d                	jne    801062a8 <sys_link+0xe8>
8010626b:	83 ec 04             	sub    $0x4,%esp
8010626e:	ff 73 04             	push   0x4(%ebx)
80106271:	57                   	push   %edi
80106272:	56                   	push   %esi
80106273:	e8 68 d0 ff ff       	call   801032e0 <dirlink>
80106278:	83 c4 10             	add    $0x10,%esp
8010627b:	85 c0                	test   %eax,%eax
8010627d:	78 29                	js     801062a8 <sys_link+0xe8>
  iunlockput(dp);
8010627f:	83 ec 0c             	sub    $0xc,%esp
80106282:	56                   	push   %esi
80106283:	e8 88 ca ff ff       	call   80102d10 <iunlockput>
  iput(ip);
80106288:	89 1c 24             	mov    %ebx,(%esp)
8010628b:	e8 20 c9 ff ff       	call   80102bb0 <iput>
  end_op();
80106290:	e8 3b de ff ff       	call   801040d0 <end_op>
  return 0;
80106295:	83 c4 10             	add    $0x10,%esp
80106298:	31 c0                	xor    %eax,%eax
}
8010629a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010629d:	5b                   	pop    %ebx
8010629e:	5e                   	pop    %esi
8010629f:	5f                   	pop    %edi
801062a0:	5d                   	pop    %ebp
801062a1:	c3                   	ret    
801062a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801062a8:	83 ec 0c             	sub    $0xc,%esp
801062ab:	56                   	push   %esi
801062ac:	e8 5f ca ff ff       	call   80102d10 <iunlockput>
    goto bad;
801062b1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801062b4:	83 ec 0c             	sub    $0xc,%esp
801062b7:	53                   	push   %ebx
801062b8:	e8 c3 c7 ff ff       	call   80102a80 <ilock>
  ip->nlink--;
801062bd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801062c2:	89 1c 24             	mov    %ebx,(%esp)
801062c5:	e8 06 c7 ff ff       	call   801029d0 <iupdate>
  iunlockput(ip);
801062ca:	89 1c 24             	mov    %ebx,(%esp)
801062cd:	e8 3e ca ff ff       	call   80102d10 <iunlockput>
  end_op();
801062d2:	e8 f9 dd ff ff       	call   801040d0 <end_op>
  return -1;
801062d7:	83 c4 10             	add    $0x10,%esp
801062da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062df:	eb b9                	jmp    8010629a <sys_link+0xda>
    iunlockput(ip);
801062e1:	83 ec 0c             	sub    $0xc,%esp
801062e4:	53                   	push   %ebx
801062e5:	e8 26 ca ff ff       	call   80102d10 <iunlockput>
    end_op();
801062ea:	e8 e1 dd ff ff       	call   801040d0 <end_op>
    return -1;
801062ef:	83 c4 10             	add    $0x10,%esp
801062f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062f7:	eb a1                	jmp    8010629a <sys_link+0xda>
    end_op();
801062f9:	e8 d2 dd ff ff       	call   801040d0 <end_op>
    return -1;
801062fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106303:	eb 95                	jmp    8010629a <sys_link+0xda>
80106305:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010630c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106310 <sys_unlink>:
{
80106310:	55                   	push   %ebp
80106311:	89 e5                	mov    %esp,%ebp
80106313:	57                   	push   %edi
80106314:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80106315:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80106318:	53                   	push   %ebx
80106319:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010631c:	50                   	push   %eax
8010631d:	6a 00                	push   $0x0
8010631f:	e8 bc f9 ff ff       	call   80105ce0 <argstr>
80106324:	83 c4 10             	add    $0x10,%esp
80106327:	85 c0                	test   %eax,%eax
80106329:	0f 88 7a 01 00 00    	js     801064a9 <sys_unlink+0x199>
  begin_op();
8010632f:	e8 2c dd ff ff       	call   80104060 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106334:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80106337:	83 ec 08             	sub    $0x8,%esp
8010633a:	53                   	push   %ebx
8010633b:	ff 75 c0             	push   -0x40(%ebp)
8010633e:	e8 7d d0 ff ff       	call   801033c0 <nameiparent>
80106343:	83 c4 10             	add    $0x10,%esp
80106346:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80106349:	85 c0                	test   %eax,%eax
8010634b:	0f 84 62 01 00 00    	je     801064b3 <sys_unlink+0x1a3>
  ilock(dp);
80106351:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80106354:	83 ec 0c             	sub    $0xc,%esp
80106357:	57                   	push   %edi
80106358:	e8 23 c7 ff ff       	call   80102a80 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010635d:	58                   	pop    %eax
8010635e:	5a                   	pop    %edx
8010635f:	68 b4 8c 10 80       	push   $0x80108cb4
80106364:	53                   	push   %ebx
80106365:	e8 56 cc ff ff       	call   80102fc0 <namecmp>
8010636a:	83 c4 10             	add    $0x10,%esp
8010636d:	85 c0                	test   %eax,%eax
8010636f:	0f 84 fb 00 00 00    	je     80106470 <sys_unlink+0x160>
80106375:	83 ec 08             	sub    $0x8,%esp
80106378:	68 b3 8c 10 80       	push   $0x80108cb3
8010637d:	53                   	push   %ebx
8010637e:	e8 3d cc ff ff       	call   80102fc0 <namecmp>
80106383:	83 c4 10             	add    $0x10,%esp
80106386:	85 c0                	test   %eax,%eax
80106388:	0f 84 e2 00 00 00    	je     80106470 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010638e:	83 ec 04             	sub    $0x4,%esp
80106391:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106394:	50                   	push   %eax
80106395:	53                   	push   %ebx
80106396:	57                   	push   %edi
80106397:	e8 44 cc ff ff       	call   80102fe0 <dirlookup>
8010639c:	83 c4 10             	add    $0x10,%esp
8010639f:	89 c3                	mov    %eax,%ebx
801063a1:	85 c0                	test   %eax,%eax
801063a3:	0f 84 c7 00 00 00    	je     80106470 <sys_unlink+0x160>
  ilock(ip);
801063a9:	83 ec 0c             	sub    $0xc,%esp
801063ac:	50                   	push   %eax
801063ad:	e8 ce c6 ff ff       	call   80102a80 <ilock>
  if(ip->nlink < 1)
801063b2:	83 c4 10             	add    $0x10,%esp
801063b5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801063ba:	0f 8e 1c 01 00 00    	jle    801064dc <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801063c0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801063c5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801063c8:	74 66                	je     80106430 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801063ca:	83 ec 04             	sub    $0x4,%esp
801063cd:	6a 10                	push   $0x10
801063cf:	6a 00                	push   $0x0
801063d1:	57                   	push   %edi
801063d2:	e8 89 f5 ff ff       	call   80105960 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801063d7:	6a 10                	push   $0x10
801063d9:	ff 75 c4             	push   -0x3c(%ebp)
801063dc:	57                   	push   %edi
801063dd:	ff 75 b4             	push   -0x4c(%ebp)
801063e0:	e8 ab ca ff ff       	call   80102e90 <writei>
801063e5:	83 c4 20             	add    $0x20,%esp
801063e8:	83 f8 10             	cmp    $0x10,%eax
801063eb:	0f 85 de 00 00 00    	jne    801064cf <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
801063f1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801063f6:	0f 84 94 00 00 00    	je     80106490 <sys_unlink+0x180>
  iunlockput(dp);
801063fc:	83 ec 0c             	sub    $0xc,%esp
801063ff:	ff 75 b4             	push   -0x4c(%ebp)
80106402:	e8 09 c9 ff ff       	call   80102d10 <iunlockput>
  ip->nlink--;
80106407:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010640c:	89 1c 24             	mov    %ebx,(%esp)
8010640f:	e8 bc c5 ff ff       	call   801029d0 <iupdate>
  iunlockput(ip);
80106414:	89 1c 24             	mov    %ebx,(%esp)
80106417:	e8 f4 c8 ff ff       	call   80102d10 <iunlockput>
  end_op();
8010641c:	e8 af dc ff ff       	call   801040d0 <end_op>
  return 0;
80106421:	83 c4 10             	add    $0x10,%esp
80106424:	31 c0                	xor    %eax,%eax
}
80106426:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106429:	5b                   	pop    %ebx
8010642a:	5e                   	pop    %esi
8010642b:	5f                   	pop    %edi
8010642c:	5d                   	pop    %ebp
8010642d:	c3                   	ret    
8010642e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106430:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106434:	76 94                	jbe    801063ca <sys_unlink+0xba>
80106436:	be 20 00 00 00       	mov    $0x20,%esi
8010643b:	eb 0b                	jmp    80106448 <sys_unlink+0x138>
8010643d:	8d 76 00             	lea    0x0(%esi),%esi
80106440:	83 c6 10             	add    $0x10,%esi
80106443:	3b 73 58             	cmp    0x58(%ebx),%esi
80106446:	73 82                	jae    801063ca <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106448:	6a 10                	push   $0x10
8010644a:	56                   	push   %esi
8010644b:	57                   	push   %edi
8010644c:	53                   	push   %ebx
8010644d:	e8 3e c9 ff ff       	call   80102d90 <readi>
80106452:	83 c4 10             	add    $0x10,%esp
80106455:	83 f8 10             	cmp    $0x10,%eax
80106458:	75 68                	jne    801064c2 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010645a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010645f:	74 df                	je     80106440 <sys_unlink+0x130>
    iunlockput(ip);
80106461:	83 ec 0c             	sub    $0xc,%esp
80106464:	53                   	push   %ebx
80106465:	e8 a6 c8 ff ff       	call   80102d10 <iunlockput>
    goto bad;
8010646a:	83 c4 10             	add    $0x10,%esp
8010646d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80106470:	83 ec 0c             	sub    $0xc,%esp
80106473:	ff 75 b4             	push   -0x4c(%ebp)
80106476:	e8 95 c8 ff ff       	call   80102d10 <iunlockput>
  end_op();
8010647b:	e8 50 dc ff ff       	call   801040d0 <end_op>
  return -1;
80106480:	83 c4 10             	add    $0x10,%esp
80106483:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106488:	eb 9c                	jmp    80106426 <sys_unlink+0x116>
8010648a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80106490:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80106493:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80106496:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010649b:	50                   	push   %eax
8010649c:	e8 2f c5 ff ff       	call   801029d0 <iupdate>
801064a1:	83 c4 10             	add    $0x10,%esp
801064a4:	e9 53 ff ff ff       	jmp    801063fc <sys_unlink+0xec>
    return -1;
801064a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064ae:	e9 73 ff ff ff       	jmp    80106426 <sys_unlink+0x116>
    end_op();
801064b3:	e8 18 dc ff ff       	call   801040d0 <end_op>
    return -1;
801064b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064bd:	e9 64 ff ff ff       	jmp    80106426 <sys_unlink+0x116>
      panic("isdirempty: readi");
801064c2:	83 ec 0c             	sub    $0xc,%esp
801064c5:	68 d8 8c 10 80       	push   $0x80108cd8
801064ca:	e8 11 a8 ff ff       	call   80100ce0 <panic>
    panic("unlink: writei");
801064cf:	83 ec 0c             	sub    $0xc,%esp
801064d2:	68 ea 8c 10 80       	push   $0x80108cea
801064d7:	e8 04 a8 ff ff       	call   80100ce0 <panic>
    panic("unlink: nlink < 1");
801064dc:	83 ec 0c             	sub    $0xc,%esp
801064df:	68 c6 8c 10 80       	push   $0x80108cc6
801064e4:	e8 f7 a7 ff ff       	call   80100ce0 <panic>
801064e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801064f0 <sys_open>:

int
sys_open(void)
{
801064f0:	55                   	push   %ebp
801064f1:	89 e5                	mov    %esp,%ebp
801064f3:	57                   	push   %edi
801064f4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801064f5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801064f8:	53                   	push   %ebx
801064f9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801064fc:	50                   	push   %eax
801064fd:	6a 00                	push   $0x0
801064ff:	e8 dc f7 ff ff       	call   80105ce0 <argstr>
80106504:	83 c4 10             	add    $0x10,%esp
80106507:	85 c0                	test   %eax,%eax
80106509:	0f 88 8e 00 00 00    	js     8010659d <sys_open+0xad>
8010650f:	83 ec 08             	sub    $0x8,%esp
80106512:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106515:	50                   	push   %eax
80106516:	6a 01                	push   $0x1
80106518:	e8 03 f7 ff ff       	call   80105c20 <argint>
8010651d:	83 c4 10             	add    $0x10,%esp
80106520:	85 c0                	test   %eax,%eax
80106522:	78 79                	js     8010659d <sys_open+0xad>
    return -1;

  begin_op();
80106524:	e8 37 db ff ff       	call   80104060 <begin_op>

  if(omode & O_CREATE){
80106529:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010652d:	75 79                	jne    801065a8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010652f:	83 ec 0c             	sub    $0xc,%esp
80106532:	ff 75 e0             	push   -0x20(%ebp)
80106535:	e8 66 ce ff ff       	call   801033a0 <namei>
8010653a:	83 c4 10             	add    $0x10,%esp
8010653d:	89 c6                	mov    %eax,%esi
8010653f:	85 c0                	test   %eax,%eax
80106541:	0f 84 7e 00 00 00    	je     801065c5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80106547:	83 ec 0c             	sub    $0xc,%esp
8010654a:	50                   	push   %eax
8010654b:	e8 30 c5 ff ff       	call   80102a80 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106550:	83 c4 10             	add    $0x10,%esp
80106553:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106558:	0f 84 c2 00 00 00    	je     80106620 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010655e:	e8 cd bb ff ff       	call   80102130 <filealloc>
80106563:	89 c7                	mov    %eax,%edi
80106565:	85 c0                	test   %eax,%eax
80106567:	74 23                	je     8010658c <sys_open+0x9c>
  struct proc *curproc = myproc();
80106569:	e8 02 e7 ff ff       	call   80104c70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010656e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80106570:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106574:	85 d2                	test   %edx,%edx
80106576:	74 60                	je     801065d8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80106578:	83 c3 01             	add    $0x1,%ebx
8010657b:	83 fb 10             	cmp    $0x10,%ebx
8010657e:	75 f0                	jne    80106570 <sys_open+0x80>
    if(f)
      fileclose(f);
80106580:	83 ec 0c             	sub    $0xc,%esp
80106583:	57                   	push   %edi
80106584:	e8 67 bc ff ff       	call   801021f0 <fileclose>
80106589:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010658c:	83 ec 0c             	sub    $0xc,%esp
8010658f:	56                   	push   %esi
80106590:	e8 7b c7 ff ff       	call   80102d10 <iunlockput>
    end_op();
80106595:	e8 36 db ff ff       	call   801040d0 <end_op>
    return -1;
8010659a:	83 c4 10             	add    $0x10,%esp
8010659d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801065a2:	eb 6d                	jmp    80106611 <sys_open+0x121>
801065a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801065a8:	83 ec 0c             	sub    $0xc,%esp
801065ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801065ae:	31 c9                	xor    %ecx,%ecx
801065b0:	ba 02 00 00 00       	mov    $0x2,%edx
801065b5:	6a 00                	push   $0x0
801065b7:	e8 14 f8 ff ff       	call   80105dd0 <create>
    if(ip == 0){
801065bc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801065bf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801065c1:	85 c0                	test   %eax,%eax
801065c3:	75 99                	jne    8010655e <sys_open+0x6e>
      end_op();
801065c5:	e8 06 db ff ff       	call   801040d0 <end_op>
      return -1;
801065ca:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801065cf:	eb 40                	jmp    80106611 <sys_open+0x121>
801065d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801065d8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801065db:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801065df:	56                   	push   %esi
801065e0:	e8 7b c5 ff ff       	call   80102b60 <iunlock>
  end_op();
801065e5:	e8 e6 da ff ff       	call   801040d0 <end_op>

  f->type = FD_INODE;
801065ea:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801065f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801065f3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801065f6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801065f9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801065fb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106602:	f7 d0                	not    %eax
80106604:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106607:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010660a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010660d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106611:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106614:	89 d8                	mov    %ebx,%eax
80106616:	5b                   	pop    %ebx
80106617:	5e                   	pop    %esi
80106618:	5f                   	pop    %edi
80106619:	5d                   	pop    %ebp
8010661a:	c3                   	ret    
8010661b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010661f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80106620:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106623:	85 c9                	test   %ecx,%ecx
80106625:	0f 84 33 ff ff ff    	je     8010655e <sys_open+0x6e>
8010662b:	e9 5c ff ff ff       	jmp    8010658c <sys_open+0x9c>

80106630 <sys_mkdir>:

int
sys_mkdir(void)
{
80106630:	55                   	push   %ebp
80106631:	89 e5                	mov    %esp,%ebp
80106633:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106636:	e8 25 da ff ff       	call   80104060 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010663b:	83 ec 08             	sub    $0x8,%esp
8010663e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106641:	50                   	push   %eax
80106642:	6a 00                	push   $0x0
80106644:	e8 97 f6 ff ff       	call   80105ce0 <argstr>
80106649:	83 c4 10             	add    $0x10,%esp
8010664c:	85 c0                	test   %eax,%eax
8010664e:	78 30                	js     80106680 <sys_mkdir+0x50>
80106650:	83 ec 0c             	sub    $0xc,%esp
80106653:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106656:	31 c9                	xor    %ecx,%ecx
80106658:	ba 01 00 00 00       	mov    $0x1,%edx
8010665d:	6a 00                	push   $0x0
8010665f:	e8 6c f7 ff ff       	call   80105dd0 <create>
80106664:	83 c4 10             	add    $0x10,%esp
80106667:	85 c0                	test   %eax,%eax
80106669:	74 15                	je     80106680 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010666b:	83 ec 0c             	sub    $0xc,%esp
8010666e:	50                   	push   %eax
8010666f:	e8 9c c6 ff ff       	call   80102d10 <iunlockput>
  end_op();
80106674:	e8 57 da ff ff       	call   801040d0 <end_op>
  return 0;
80106679:	83 c4 10             	add    $0x10,%esp
8010667c:	31 c0                	xor    %eax,%eax
}
8010667e:	c9                   	leave  
8010667f:	c3                   	ret    
    end_op();
80106680:	e8 4b da ff ff       	call   801040d0 <end_op>
    return -1;
80106685:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010668a:	c9                   	leave  
8010668b:	c3                   	ret    
8010668c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106690 <sys_mknod>:

int
sys_mknod(void)
{
80106690:	55                   	push   %ebp
80106691:	89 e5                	mov    %esp,%ebp
80106693:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106696:	e8 c5 d9 ff ff       	call   80104060 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010669b:	83 ec 08             	sub    $0x8,%esp
8010669e:	8d 45 ec             	lea    -0x14(%ebp),%eax
801066a1:	50                   	push   %eax
801066a2:	6a 00                	push   $0x0
801066a4:	e8 37 f6 ff ff       	call   80105ce0 <argstr>
801066a9:	83 c4 10             	add    $0x10,%esp
801066ac:	85 c0                	test   %eax,%eax
801066ae:	78 60                	js     80106710 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801066b0:	83 ec 08             	sub    $0x8,%esp
801066b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801066b6:	50                   	push   %eax
801066b7:	6a 01                	push   $0x1
801066b9:	e8 62 f5 ff ff       	call   80105c20 <argint>
  if((argstr(0, &path)) < 0 ||
801066be:	83 c4 10             	add    $0x10,%esp
801066c1:	85 c0                	test   %eax,%eax
801066c3:	78 4b                	js     80106710 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801066c5:	83 ec 08             	sub    $0x8,%esp
801066c8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066cb:	50                   	push   %eax
801066cc:	6a 02                	push   $0x2
801066ce:	e8 4d f5 ff ff       	call   80105c20 <argint>
     argint(1, &major) < 0 ||
801066d3:	83 c4 10             	add    $0x10,%esp
801066d6:	85 c0                	test   %eax,%eax
801066d8:	78 36                	js     80106710 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801066da:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801066de:	83 ec 0c             	sub    $0xc,%esp
801066e1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801066e5:	ba 03 00 00 00       	mov    $0x3,%edx
801066ea:	50                   	push   %eax
801066eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801066ee:	e8 dd f6 ff ff       	call   80105dd0 <create>
     argint(2, &minor) < 0 ||
801066f3:	83 c4 10             	add    $0x10,%esp
801066f6:	85 c0                	test   %eax,%eax
801066f8:	74 16                	je     80106710 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801066fa:	83 ec 0c             	sub    $0xc,%esp
801066fd:	50                   	push   %eax
801066fe:	e8 0d c6 ff ff       	call   80102d10 <iunlockput>
  end_op();
80106703:	e8 c8 d9 ff ff       	call   801040d0 <end_op>
  return 0;
80106708:	83 c4 10             	add    $0x10,%esp
8010670b:	31 c0                	xor    %eax,%eax
}
8010670d:	c9                   	leave  
8010670e:	c3                   	ret    
8010670f:	90                   	nop
    end_op();
80106710:	e8 bb d9 ff ff       	call   801040d0 <end_op>
    return -1;
80106715:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010671a:	c9                   	leave  
8010671b:	c3                   	ret    
8010671c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106720 <sys_chdir>:

int
sys_chdir(void)
{
80106720:	55                   	push   %ebp
80106721:	89 e5                	mov    %esp,%ebp
80106723:	56                   	push   %esi
80106724:	53                   	push   %ebx
80106725:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106728:	e8 43 e5 ff ff       	call   80104c70 <myproc>
8010672d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010672f:	e8 2c d9 ff ff       	call   80104060 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106734:	83 ec 08             	sub    $0x8,%esp
80106737:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010673a:	50                   	push   %eax
8010673b:	6a 00                	push   $0x0
8010673d:	e8 9e f5 ff ff       	call   80105ce0 <argstr>
80106742:	83 c4 10             	add    $0x10,%esp
80106745:	85 c0                	test   %eax,%eax
80106747:	78 77                	js     801067c0 <sys_chdir+0xa0>
80106749:	83 ec 0c             	sub    $0xc,%esp
8010674c:	ff 75 f4             	push   -0xc(%ebp)
8010674f:	e8 4c cc ff ff       	call   801033a0 <namei>
80106754:	83 c4 10             	add    $0x10,%esp
80106757:	89 c3                	mov    %eax,%ebx
80106759:	85 c0                	test   %eax,%eax
8010675b:	74 63                	je     801067c0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010675d:	83 ec 0c             	sub    $0xc,%esp
80106760:	50                   	push   %eax
80106761:	e8 1a c3 ff ff       	call   80102a80 <ilock>
  if(ip->type != T_DIR){
80106766:	83 c4 10             	add    $0x10,%esp
80106769:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010676e:	75 30                	jne    801067a0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106770:	83 ec 0c             	sub    $0xc,%esp
80106773:	53                   	push   %ebx
80106774:	e8 e7 c3 ff ff       	call   80102b60 <iunlock>
  iput(curproc->cwd);
80106779:	58                   	pop    %eax
8010677a:	ff 76 68             	push   0x68(%esi)
8010677d:	e8 2e c4 ff ff       	call   80102bb0 <iput>
  end_op();
80106782:	e8 49 d9 ff ff       	call   801040d0 <end_op>
  curproc->cwd = ip;
80106787:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010678a:	83 c4 10             	add    $0x10,%esp
8010678d:	31 c0                	xor    %eax,%eax
}
8010678f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106792:	5b                   	pop    %ebx
80106793:	5e                   	pop    %esi
80106794:	5d                   	pop    %ebp
80106795:	c3                   	ret    
80106796:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010679d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801067a0:	83 ec 0c             	sub    $0xc,%esp
801067a3:	53                   	push   %ebx
801067a4:	e8 67 c5 ff ff       	call   80102d10 <iunlockput>
    end_op();
801067a9:	e8 22 d9 ff ff       	call   801040d0 <end_op>
    return -1;
801067ae:	83 c4 10             	add    $0x10,%esp
801067b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067b6:	eb d7                	jmp    8010678f <sys_chdir+0x6f>
801067b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067bf:	90                   	nop
    end_op();
801067c0:	e8 0b d9 ff ff       	call   801040d0 <end_op>
    return -1;
801067c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067ca:	eb c3                	jmp    8010678f <sys_chdir+0x6f>
801067cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801067d0 <sys_exec>:

int
sys_exec(void)
{
801067d0:	55                   	push   %ebp
801067d1:	89 e5                	mov    %esp,%ebp
801067d3:	57                   	push   %edi
801067d4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801067d5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801067db:	53                   	push   %ebx
801067dc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801067e2:	50                   	push   %eax
801067e3:	6a 00                	push   $0x0
801067e5:	e8 f6 f4 ff ff       	call   80105ce0 <argstr>
801067ea:	83 c4 10             	add    $0x10,%esp
801067ed:	85 c0                	test   %eax,%eax
801067ef:	0f 88 87 00 00 00    	js     8010687c <sys_exec+0xac>
801067f5:	83 ec 08             	sub    $0x8,%esp
801067f8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801067fe:	50                   	push   %eax
801067ff:	6a 01                	push   $0x1
80106801:	e8 1a f4 ff ff       	call   80105c20 <argint>
80106806:	83 c4 10             	add    $0x10,%esp
80106809:	85 c0                	test   %eax,%eax
8010680b:	78 6f                	js     8010687c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010680d:	83 ec 04             	sub    $0x4,%esp
80106810:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106816:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106818:	68 80 00 00 00       	push   $0x80
8010681d:	6a 00                	push   $0x0
8010681f:	56                   	push   %esi
80106820:	e8 3b f1 ff ff       	call   80105960 <memset>
80106825:	83 c4 10             	add    $0x10,%esp
80106828:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010682f:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106830:	83 ec 08             	sub    $0x8,%esp
80106833:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106839:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106840:	50                   	push   %eax
80106841:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106847:	01 f8                	add    %edi,%eax
80106849:	50                   	push   %eax
8010684a:	e8 41 f3 ff ff       	call   80105b90 <fetchint>
8010684f:	83 c4 10             	add    $0x10,%esp
80106852:	85 c0                	test   %eax,%eax
80106854:	78 26                	js     8010687c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106856:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010685c:	85 c0                	test   %eax,%eax
8010685e:	74 30                	je     80106890 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106860:	83 ec 08             	sub    $0x8,%esp
80106863:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106866:	52                   	push   %edx
80106867:	50                   	push   %eax
80106868:	e8 63 f3 ff ff       	call   80105bd0 <fetchstr>
8010686d:	83 c4 10             	add    $0x10,%esp
80106870:	85 c0                	test   %eax,%eax
80106872:	78 08                	js     8010687c <sys_exec+0xac>
  for(i=0;; i++){
80106874:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106877:	83 fb 20             	cmp    $0x20,%ebx
8010687a:	75 b4                	jne    80106830 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010687c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010687f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106884:	5b                   	pop    %ebx
80106885:	5e                   	pop    %esi
80106886:	5f                   	pop    %edi
80106887:	5d                   	pop    %ebp
80106888:	c3                   	ret    
80106889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106890:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106897:	00 00 00 00 
  return exec(path, argv);
8010689b:	83 ec 08             	sub    $0x8,%esp
8010689e:	56                   	push   %esi
8010689f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801068a5:	e8 06 b5 ff ff       	call   80101db0 <exec>
801068aa:	83 c4 10             	add    $0x10,%esp
}
801068ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068b0:	5b                   	pop    %ebx
801068b1:	5e                   	pop    %esi
801068b2:	5f                   	pop    %edi
801068b3:	5d                   	pop    %ebp
801068b4:	c3                   	ret    
801068b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068c0 <sys_pipe>:

int
sys_pipe(void)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	57                   	push   %edi
801068c4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801068c5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801068c8:	53                   	push   %ebx
801068c9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801068cc:	6a 08                	push   $0x8
801068ce:	50                   	push   %eax
801068cf:	6a 00                	push   $0x0
801068d1:	e8 9a f3 ff ff       	call   80105c70 <argptr>
801068d6:	83 c4 10             	add    $0x10,%esp
801068d9:	85 c0                	test   %eax,%eax
801068db:	78 4a                	js     80106927 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801068dd:	83 ec 08             	sub    $0x8,%esp
801068e0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801068e3:	50                   	push   %eax
801068e4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801068e7:	50                   	push   %eax
801068e8:	e8 43 de ff ff       	call   80104730 <pipealloc>
801068ed:	83 c4 10             	add    $0x10,%esp
801068f0:	85 c0                	test   %eax,%eax
801068f2:	78 33                	js     80106927 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801068f4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801068f7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801068f9:	e8 72 e3 ff ff       	call   80104c70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801068fe:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80106900:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106904:	85 f6                	test   %esi,%esi
80106906:	74 28                	je     80106930 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80106908:	83 c3 01             	add    $0x1,%ebx
8010690b:	83 fb 10             	cmp    $0x10,%ebx
8010690e:	75 f0                	jne    80106900 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106910:	83 ec 0c             	sub    $0xc,%esp
80106913:	ff 75 e0             	push   -0x20(%ebp)
80106916:	e8 d5 b8 ff ff       	call   801021f0 <fileclose>
    fileclose(wf);
8010691b:	58                   	pop    %eax
8010691c:	ff 75 e4             	push   -0x1c(%ebp)
8010691f:	e8 cc b8 ff ff       	call   801021f0 <fileclose>
    return -1;
80106924:	83 c4 10             	add    $0x10,%esp
80106927:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010692c:	eb 53                	jmp    80106981 <sys_pipe+0xc1>
8010692e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106930:	8d 73 08             	lea    0x8(%ebx),%esi
80106933:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106937:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010693a:	e8 31 e3 ff ff       	call   80104c70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010693f:	31 d2                	xor    %edx,%edx
80106941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106948:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010694c:	85 c9                	test   %ecx,%ecx
8010694e:	74 20                	je     80106970 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80106950:	83 c2 01             	add    $0x1,%edx
80106953:	83 fa 10             	cmp    $0x10,%edx
80106956:	75 f0                	jne    80106948 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80106958:	e8 13 e3 ff ff       	call   80104c70 <myproc>
8010695d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106964:	00 
80106965:	eb a9                	jmp    80106910 <sys_pipe+0x50>
80106967:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010696e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106970:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80106974:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106977:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106979:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010697c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010697f:	31 c0                	xor    %eax,%eax
}
80106981:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106984:	5b                   	pop    %ebx
80106985:	5e                   	pop    %esi
80106986:	5f                   	pop    %edi
80106987:	5d                   	pop    %ebp
80106988:	c3                   	ret    
80106989:	66 90                	xchg   %ax,%ax
8010698b:	66 90                	xchg   %ax,%ax
8010698d:	66 90                	xchg   %ax,%ax
8010698f:	90                   	nop

80106990 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106990:	e9 7b e4 ff ff       	jmp    80104e10 <fork>
80106995:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010699c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069a0 <sys_exit>:
}

int
sys_exit(void)
{
801069a0:	55                   	push   %ebp
801069a1:	89 e5                	mov    %esp,%ebp
801069a3:	83 ec 08             	sub    $0x8,%esp
  exit();
801069a6:	e8 e5 e6 ff ff       	call   80105090 <exit>
  return 0;  // not reached
}
801069ab:	31 c0                	xor    %eax,%eax
801069ad:	c9                   	leave  
801069ae:	c3                   	ret    
801069af:	90                   	nop

801069b0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
801069b0:	e9 0b e8 ff ff       	jmp    801051c0 <wait>
801069b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069c0 <sys_kill>:
}

int
sys_kill(void)
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801069c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069c9:	50                   	push   %eax
801069ca:	6a 00                	push   $0x0
801069cc:	e8 4f f2 ff ff       	call   80105c20 <argint>
801069d1:	83 c4 10             	add    $0x10,%esp
801069d4:	85 c0                	test   %eax,%eax
801069d6:	78 18                	js     801069f0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801069d8:	83 ec 0c             	sub    $0xc,%esp
801069db:	ff 75 f4             	push   -0xc(%ebp)
801069de:	e8 7d ea ff ff       	call   80105460 <kill>
801069e3:	83 c4 10             	add    $0x10,%esp
}
801069e6:	c9                   	leave  
801069e7:	c3                   	ret    
801069e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069ef:	90                   	nop
801069f0:	c9                   	leave  
    return -1;
801069f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069f6:	c3                   	ret    
801069f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069fe:	66 90                	xchg   %ax,%ax

80106a00 <sys_getpid>:

int
sys_getpid(void)
{
80106a00:	55                   	push   %ebp
80106a01:	89 e5                	mov    %esp,%ebp
80106a03:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106a06:	e8 65 e2 ff ff       	call   80104c70 <myproc>
80106a0b:	8b 40 10             	mov    0x10(%eax),%eax
}
80106a0e:	c9                   	leave  
80106a0f:	c3                   	ret    

80106a10 <sys_sbrk>:

int
sys_sbrk(void)
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106a14:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106a17:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106a1a:	50                   	push   %eax
80106a1b:	6a 00                	push   $0x0
80106a1d:	e8 fe f1 ff ff       	call   80105c20 <argint>
80106a22:	83 c4 10             	add    $0x10,%esp
80106a25:	85 c0                	test   %eax,%eax
80106a27:	78 27                	js     80106a50 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106a29:	e8 42 e2 ff ff       	call   80104c70 <myproc>
  if(growproc(n) < 0)
80106a2e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106a31:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106a33:	ff 75 f4             	push   -0xc(%ebp)
80106a36:	e8 55 e3 ff ff       	call   80104d90 <growproc>
80106a3b:	83 c4 10             	add    $0x10,%esp
80106a3e:	85 c0                	test   %eax,%eax
80106a40:	78 0e                	js     80106a50 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106a42:	89 d8                	mov    %ebx,%eax
80106a44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106a47:	c9                   	leave  
80106a48:	c3                   	ret    
80106a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106a50:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106a55:	eb eb                	jmp    80106a42 <sys_sbrk+0x32>
80106a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a5e:	66 90                	xchg   %ax,%ax

80106a60 <sys_sleep>:

int
sys_sleep(void)
{
80106a60:	55                   	push   %ebp
80106a61:	89 e5                	mov    %esp,%ebp
80106a63:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106a64:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106a67:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106a6a:	50                   	push   %eax
80106a6b:	6a 00                	push   $0x0
80106a6d:	e8 ae f1 ff ff       	call   80105c20 <argint>
80106a72:	83 c4 10             	add    $0x10,%esp
80106a75:	85 c0                	test   %eax,%eax
80106a77:	0f 88 8a 00 00 00    	js     80106b07 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80106a7d:	83 ec 0c             	sub    $0xc,%esp
80106a80:	68 20 4d 11 80       	push   $0x80114d20
80106a85:	e8 16 ee ff ff       	call   801058a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106a8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106a8d:	8b 1d 00 4d 11 80    	mov    0x80114d00,%ebx
  while(ticks - ticks0 < n){
80106a93:	83 c4 10             	add    $0x10,%esp
80106a96:	85 d2                	test   %edx,%edx
80106a98:	75 27                	jne    80106ac1 <sys_sleep+0x61>
80106a9a:	eb 54                	jmp    80106af0 <sys_sleep+0x90>
80106a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106aa0:	83 ec 08             	sub    $0x8,%esp
80106aa3:	68 20 4d 11 80       	push   $0x80114d20
80106aa8:	68 00 4d 11 80       	push   $0x80114d00
80106aad:	e8 8e e8 ff ff       	call   80105340 <sleep>
  while(ticks - ticks0 < n){
80106ab2:	a1 00 4d 11 80       	mov    0x80114d00,%eax
80106ab7:	83 c4 10             	add    $0x10,%esp
80106aba:	29 d8                	sub    %ebx,%eax
80106abc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106abf:	73 2f                	jae    80106af0 <sys_sleep+0x90>
    if(myproc()->killed){
80106ac1:	e8 aa e1 ff ff       	call   80104c70 <myproc>
80106ac6:	8b 40 24             	mov    0x24(%eax),%eax
80106ac9:	85 c0                	test   %eax,%eax
80106acb:	74 d3                	je     80106aa0 <sys_sleep+0x40>
      release(&tickslock);
80106acd:	83 ec 0c             	sub    $0xc,%esp
80106ad0:	68 20 4d 11 80       	push   $0x80114d20
80106ad5:	e8 66 ed ff ff       	call   80105840 <release>
  }
  release(&tickslock);
  return 0;
}
80106ada:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80106add:	83 c4 10             	add    $0x10,%esp
80106ae0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ae5:	c9                   	leave  
80106ae6:	c3                   	ret    
80106ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106aee:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106af0:	83 ec 0c             	sub    $0xc,%esp
80106af3:	68 20 4d 11 80       	push   $0x80114d20
80106af8:	e8 43 ed ff ff       	call   80105840 <release>
  return 0;
80106afd:	83 c4 10             	add    $0x10,%esp
80106b00:	31 c0                	xor    %eax,%eax
}
80106b02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106b05:	c9                   	leave  
80106b06:	c3                   	ret    
    return -1;
80106b07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b0c:	eb f4                	jmp    80106b02 <sys_sleep+0xa2>
80106b0e:	66 90                	xchg   %ax,%ax

80106b10 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	53                   	push   %ebx
80106b14:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106b17:	68 20 4d 11 80       	push   $0x80114d20
80106b1c:	e8 7f ed ff ff       	call   801058a0 <acquire>
  xticks = ticks;
80106b21:	8b 1d 00 4d 11 80    	mov    0x80114d00,%ebx
  release(&tickslock);
80106b27:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
80106b2e:	e8 0d ed ff ff       	call   80105840 <release>
  return xticks;
}
80106b33:	89 d8                	mov    %ebx,%eax
80106b35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106b38:	c9                   	leave  
80106b39:	c3                   	ret    

80106b3a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106b3a:	1e                   	push   %ds
  pushl %es
80106b3b:	06                   	push   %es
  pushl %fs
80106b3c:	0f a0                	push   %fs
  pushl %gs
80106b3e:	0f a8                	push   %gs
  pushal
80106b40:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106b41:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106b45:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106b47:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106b49:	54                   	push   %esp
  call trap
80106b4a:	e8 c1 00 00 00       	call   80106c10 <trap>
  addl $4, %esp
80106b4f:	83 c4 04             	add    $0x4,%esp

80106b52 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106b52:	61                   	popa   
  popl %gs
80106b53:	0f a9                	pop    %gs
  popl %fs
80106b55:	0f a1                	pop    %fs
  popl %es
80106b57:	07                   	pop    %es
  popl %ds
80106b58:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106b59:	83 c4 08             	add    $0x8,%esp
  iret
80106b5c:	cf                   	iret   
80106b5d:	66 90                	xchg   %ax,%ax
80106b5f:	90                   	nop

80106b60 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106b60:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106b61:	31 c0                	xor    %eax,%eax
{
80106b63:	89 e5                	mov    %esp,%ebp
80106b65:	83 ec 08             	sub    $0x8,%esp
80106b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b6f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106b70:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106b77:	c7 04 c5 62 4d 11 80 	movl   $0x8e000008,-0x7feeb29e(,%eax,8)
80106b7e:	08 00 00 8e 
80106b82:	66 89 14 c5 60 4d 11 	mov    %dx,-0x7feeb2a0(,%eax,8)
80106b89:	80 
80106b8a:	c1 ea 10             	shr    $0x10,%edx
80106b8d:	66 89 14 c5 66 4d 11 	mov    %dx,-0x7feeb29a(,%eax,8)
80106b94:	80 
  for(i = 0; i < 256; i++)
80106b95:	83 c0 01             	add    $0x1,%eax
80106b98:	3d 00 01 00 00       	cmp    $0x100,%eax
80106b9d:	75 d1                	jne    80106b70 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80106b9f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106ba2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106ba7:	c7 05 62 4f 11 80 08 	movl   $0xef000008,0x80114f62
80106bae:	00 00 ef 
  initlock(&tickslock, "time");
80106bb1:	68 f9 8c 10 80       	push   $0x80108cf9
80106bb6:	68 20 4d 11 80       	push   $0x80114d20
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106bbb:	66 a3 60 4f 11 80    	mov    %ax,0x80114f60
80106bc1:	c1 e8 10             	shr    $0x10,%eax
80106bc4:	66 a3 66 4f 11 80    	mov    %ax,0x80114f66
  initlock(&tickslock, "time");
80106bca:	e8 01 eb ff ff       	call   801056d0 <initlock>
}
80106bcf:	83 c4 10             	add    $0x10,%esp
80106bd2:	c9                   	leave  
80106bd3:	c3                   	ret    
80106bd4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106bdf:	90                   	nop

80106be0 <idtinit>:

void
idtinit(void)
{
80106be0:	55                   	push   %ebp
  pd[0] = size-1;
80106be1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106be6:	89 e5                	mov    %esp,%ebp
80106be8:	83 ec 10             	sub    $0x10,%esp
80106beb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106bef:	b8 60 4d 11 80       	mov    $0x80114d60,%eax
80106bf4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106bf8:	c1 e8 10             	shr    $0x10,%eax
80106bfb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106bff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106c02:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106c05:	c9                   	leave  
80106c06:	c3                   	ret    
80106c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c0e:	66 90                	xchg   %ax,%ax

80106c10 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106c10:	55                   	push   %ebp
80106c11:	89 e5                	mov    %esp,%ebp
80106c13:	57                   	push   %edi
80106c14:	56                   	push   %esi
80106c15:	53                   	push   %ebx
80106c16:	83 ec 1c             	sub    $0x1c,%esp
80106c19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106c1c:	8b 43 30             	mov    0x30(%ebx),%eax
80106c1f:	83 f8 40             	cmp    $0x40,%eax
80106c22:	0f 84 68 01 00 00    	je     80106d90 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106c28:	83 e8 20             	sub    $0x20,%eax
80106c2b:	83 f8 1f             	cmp    $0x1f,%eax
80106c2e:	0f 87 8c 00 00 00    	ja     80106cc0 <trap+0xb0>
80106c34:	ff 24 85 a0 8d 10 80 	jmp    *-0x7fef7260(,%eax,4)
80106c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c3f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106c40:	e8 fb c8 ff ff       	call   80103540 <ideintr>
    lapiceoi();
80106c45:	e8 c6 cf ff ff       	call   80103c10 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106c4a:	e8 21 e0 ff ff       	call   80104c70 <myproc>
80106c4f:	85 c0                	test   %eax,%eax
80106c51:	74 1d                	je     80106c70 <trap+0x60>
80106c53:	e8 18 e0 ff ff       	call   80104c70 <myproc>
80106c58:	8b 50 24             	mov    0x24(%eax),%edx
80106c5b:	85 d2                	test   %edx,%edx
80106c5d:	74 11                	je     80106c70 <trap+0x60>
80106c5f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106c63:	83 e0 03             	and    $0x3,%eax
80106c66:	66 83 f8 03          	cmp    $0x3,%ax
80106c6a:	0f 84 e8 01 00 00    	je     80106e58 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106c70:	e8 fb df ff ff       	call   80104c70 <myproc>
80106c75:	85 c0                	test   %eax,%eax
80106c77:	74 0f                	je     80106c88 <trap+0x78>
80106c79:	e8 f2 df ff ff       	call   80104c70 <myproc>
80106c7e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106c82:	0f 84 b8 00 00 00    	je     80106d40 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106c88:	e8 e3 df ff ff       	call   80104c70 <myproc>
80106c8d:	85 c0                	test   %eax,%eax
80106c8f:	74 1d                	je     80106cae <trap+0x9e>
80106c91:	e8 da df ff ff       	call   80104c70 <myproc>
80106c96:	8b 40 24             	mov    0x24(%eax),%eax
80106c99:	85 c0                	test   %eax,%eax
80106c9b:	74 11                	je     80106cae <trap+0x9e>
80106c9d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106ca1:	83 e0 03             	and    $0x3,%eax
80106ca4:	66 83 f8 03          	cmp    $0x3,%ax
80106ca8:	0f 84 0f 01 00 00    	je     80106dbd <trap+0x1ad>
    exit();
}
80106cae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cb1:	5b                   	pop    %ebx
80106cb2:	5e                   	pop    %esi
80106cb3:	5f                   	pop    %edi
80106cb4:	5d                   	pop    %ebp
80106cb5:	c3                   	ret    
80106cb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cbd:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106cc0:	e8 ab df ff ff       	call   80104c70 <myproc>
80106cc5:	8b 7b 38             	mov    0x38(%ebx),%edi
80106cc8:	85 c0                	test   %eax,%eax
80106cca:	0f 84 a2 01 00 00    	je     80106e72 <trap+0x262>
80106cd0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106cd4:	0f 84 98 01 00 00    	je     80106e72 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106cda:	0f 20 d1             	mov    %cr2,%ecx
80106cdd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106ce0:	e8 6b df ff ff       	call   80104c50 <cpuid>
80106ce5:	8b 73 30             	mov    0x30(%ebx),%esi
80106ce8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106ceb:	8b 43 34             	mov    0x34(%ebx),%eax
80106cee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106cf1:	e8 7a df ff ff       	call   80104c70 <myproc>
80106cf6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106cf9:	e8 72 df ff ff       	call   80104c70 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106cfe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106d01:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106d04:	51                   	push   %ecx
80106d05:	57                   	push   %edi
80106d06:	52                   	push   %edx
80106d07:	ff 75 e4             	push   -0x1c(%ebp)
80106d0a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106d0b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80106d0e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d11:	56                   	push   %esi
80106d12:	ff 70 10             	push   0x10(%eax)
80106d15:	68 5c 8d 10 80       	push   $0x80108d5c
80106d1a:	e8 41 9d ff ff       	call   80100a60 <cprintf>
    myproc()->killed = 1;
80106d1f:	83 c4 20             	add    $0x20,%esp
80106d22:	e8 49 df ff ff       	call   80104c70 <myproc>
80106d27:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106d2e:	e8 3d df ff ff       	call   80104c70 <myproc>
80106d33:	85 c0                	test   %eax,%eax
80106d35:	0f 85 18 ff ff ff    	jne    80106c53 <trap+0x43>
80106d3b:	e9 30 ff ff ff       	jmp    80106c70 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80106d40:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106d44:	0f 85 3e ff ff ff    	jne    80106c88 <trap+0x78>
    yield();
80106d4a:	e8 a1 e5 ff ff       	call   801052f0 <yield>
80106d4f:	e9 34 ff ff ff       	jmp    80106c88 <trap+0x78>
80106d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106d58:	8b 7b 38             	mov    0x38(%ebx),%edi
80106d5b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106d5f:	e8 ec de ff ff       	call   80104c50 <cpuid>
80106d64:	57                   	push   %edi
80106d65:	56                   	push   %esi
80106d66:	50                   	push   %eax
80106d67:	68 04 8d 10 80       	push   $0x80108d04
80106d6c:	e8 ef 9c ff ff       	call   80100a60 <cprintf>
    lapiceoi();
80106d71:	e8 9a ce ff ff       	call   80103c10 <lapiceoi>
    break;
80106d76:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106d79:	e8 f2 de ff ff       	call   80104c70 <myproc>
80106d7e:	85 c0                	test   %eax,%eax
80106d80:	0f 85 cd fe ff ff    	jne    80106c53 <trap+0x43>
80106d86:	e9 e5 fe ff ff       	jmp    80106c70 <trap+0x60>
80106d8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106d8f:	90                   	nop
    if(myproc()->killed)
80106d90:	e8 db de ff ff       	call   80104c70 <myproc>
80106d95:	8b 70 24             	mov    0x24(%eax),%esi
80106d98:	85 f6                	test   %esi,%esi
80106d9a:	0f 85 c8 00 00 00    	jne    80106e68 <trap+0x258>
    myproc()->tf = tf;
80106da0:	e8 cb de ff ff       	call   80104c70 <myproc>
80106da5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106da8:	e8 b3 ef ff ff       	call   80105d60 <syscall>
    if(myproc()->killed)
80106dad:	e8 be de ff ff       	call   80104c70 <myproc>
80106db2:	8b 48 24             	mov    0x24(%eax),%ecx
80106db5:	85 c9                	test   %ecx,%ecx
80106db7:	0f 84 f1 fe ff ff    	je     80106cae <trap+0x9e>
}
80106dbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dc0:	5b                   	pop    %ebx
80106dc1:	5e                   	pop    %esi
80106dc2:	5f                   	pop    %edi
80106dc3:	5d                   	pop    %ebp
      exit();
80106dc4:	e9 c7 e2 ff ff       	jmp    80105090 <exit>
80106dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106dd0:	e8 3b 02 00 00       	call   80107010 <uartintr>
    lapiceoi();
80106dd5:	e8 36 ce ff ff       	call   80103c10 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106dda:	e8 91 de ff ff       	call   80104c70 <myproc>
80106ddf:	85 c0                	test   %eax,%eax
80106de1:	0f 85 6c fe ff ff    	jne    80106c53 <trap+0x43>
80106de7:	e9 84 fe ff ff       	jmp    80106c70 <trap+0x60>
80106dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106df0:	e8 db cc ff ff       	call   80103ad0 <kbdintr>
    lapiceoi();
80106df5:	e8 16 ce ff ff       	call   80103c10 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106dfa:	e8 71 de ff ff       	call   80104c70 <myproc>
80106dff:	85 c0                	test   %eax,%eax
80106e01:	0f 85 4c fe ff ff    	jne    80106c53 <trap+0x43>
80106e07:	e9 64 fe ff ff       	jmp    80106c70 <trap+0x60>
80106e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106e10:	e8 3b de ff ff       	call   80104c50 <cpuid>
80106e15:	85 c0                	test   %eax,%eax
80106e17:	0f 85 28 fe ff ff    	jne    80106c45 <trap+0x35>
      acquire(&tickslock);
80106e1d:	83 ec 0c             	sub    $0xc,%esp
80106e20:	68 20 4d 11 80       	push   $0x80114d20
80106e25:	e8 76 ea ff ff       	call   801058a0 <acquire>
      wakeup(&ticks);
80106e2a:	c7 04 24 00 4d 11 80 	movl   $0x80114d00,(%esp)
      ticks++;
80106e31:	83 05 00 4d 11 80 01 	addl   $0x1,0x80114d00
      wakeup(&ticks);
80106e38:	e8 c3 e5 ff ff       	call   80105400 <wakeup>
      release(&tickslock);
80106e3d:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
80106e44:	e8 f7 e9 ff ff       	call   80105840 <release>
80106e49:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106e4c:	e9 f4 fd ff ff       	jmp    80106c45 <trap+0x35>
80106e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106e58:	e8 33 e2 ff ff       	call   80105090 <exit>
80106e5d:	e9 0e fe ff ff       	jmp    80106c70 <trap+0x60>
80106e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106e68:	e8 23 e2 ff ff       	call   80105090 <exit>
80106e6d:	e9 2e ff ff ff       	jmp    80106da0 <trap+0x190>
80106e72:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106e75:	e8 d6 dd ff ff       	call   80104c50 <cpuid>
80106e7a:	83 ec 0c             	sub    $0xc,%esp
80106e7d:	56                   	push   %esi
80106e7e:	57                   	push   %edi
80106e7f:	50                   	push   %eax
80106e80:	ff 73 30             	push   0x30(%ebx)
80106e83:	68 28 8d 10 80       	push   $0x80108d28
80106e88:	e8 d3 9b ff ff       	call   80100a60 <cprintf>
      panic("trap");
80106e8d:	83 c4 14             	add    $0x14,%esp
80106e90:	68 fe 8c 10 80       	push   $0x80108cfe
80106e95:	e8 46 9e ff ff       	call   80100ce0 <panic>
80106e9a:	66 90                	xchg   %ax,%ax
80106e9c:	66 90                	xchg   %ax,%ax
80106e9e:	66 90                	xchg   %ax,%ax

80106ea0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106ea0:	a1 60 55 11 80       	mov    0x80115560,%eax
80106ea5:	85 c0                	test   %eax,%eax
80106ea7:	74 17                	je     80106ec0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106ea9:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106eae:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106eaf:	a8 01                	test   $0x1,%al
80106eb1:	74 0d                	je     80106ec0 <uartgetc+0x20>
80106eb3:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106eb8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106eb9:	0f b6 c0             	movzbl %al,%eax
80106ebc:	c3                   	ret    
80106ebd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106ec0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ec5:	c3                   	ret    
80106ec6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ecd:	8d 76 00             	lea    0x0(%esi),%esi

80106ed0 <uartinit>:
{
80106ed0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106ed1:	31 c9                	xor    %ecx,%ecx
80106ed3:	89 c8                	mov    %ecx,%eax
80106ed5:	89 e5                	mov    %esp,%ebp
80106ed7:	57                   	push   %edi
80106ed8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80106edd:	56                   	push   %esi
80106ede:	89 fa                	mov    %edi,%edx
80106ee0:	53                   	push   %ebx
80106ee1:	83 ec 1c             	sub    $0x1c,%esp
80106ee4:	ee                   	out    %al,(%dx)
80106ee5:	be fb 03 00 00       	mov    $0x3fb,%esi
80106eea:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106eef:	89 f2                	mov    %esi,%edx
80106ef1:	ee                   	out    %al,(%dx)
80106ef2:	b8 0c 00 00 00       	mov    $0xc,%eax
80106ef7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106efc:	ee                   	out    %al,(%dx)
80106efd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106f02:	89 c8                	mov    %ecx,%eax
80106f04:	89 da                	mov    %ebx,%edx
80106f06:	ee                   	out    %al,(%dx)
80106f07:	b8 03 00 00 00       	mov    $0x3,%eax
80106f0c:	89 f2                	mov    %esi,%edx
80106f0e:	ee                   	out    %al,(%dx)
80106f0f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106f14:	89 c8                	mov    %ecx,%eax
80106f16:	ee                   	out    %al,(%dx)
80106f17:	b8 01 00 00 00       	mov    $0x1,%eax
80106f1c:	89 da                	mov    %ebx,%edx
80106f1e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106f1f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106f24:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106f25:	3c ff                	cmp    $0xff,%al
80106f27:	74 78                	je     80106fa1 <uartinit+0xd1>
  uart = 1;
80106f29:	c7 05 60 55 11 80 01 	movl   $0x1,0x80115560
80106f30:	00 00 00 
80106f33:	89 fa                	mov    %edi,%edx
80106f35:	ec                   	in     (%dx),%al
80106f36:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106f3b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106f3c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106f3f:	bf 20 8e 10 80       	mov    $0x80108e20,%edi
80106f44:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80106f49:	6a 00                	push   $0x0
80106f4b:	6a 04                	push   $0x4
80106f4d:	e8 2e c8 ff ff       	call   80103780 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106f52:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80106f56:	83 c4 10             	add    $0x10,%esp
80106f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106f60:	a1 60 55 11 80       	mov    0x80115560,%eax
80106f65:	bb 80 00 00 00       	mov    $0x80,%ebx
80106f6a:	85 c0                	test   %eax,%eax
80106f6c:	75 14                	jne    80106f82 <uartinit+0xb2>
80106f6e:	eb 23                	jmp    80106f93 <uartinit+0xc3>
    microdelay(10);
80106f70:	83 ec 0c             	sub    $0xc,%esp
80106f73:	6a 0a                	push   $0xa
80106f75:	e8 b6 cc ff ff       	call   80103c30 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106f7a:	83 c4 10             	add    $0x10,%esp
80106f7d:	83 eb 01             	sub    $0x1,%ebx
80106f80:	74 07                	je     80106f89 <uartinit+0xb9>
80106f82:	89 f2                	mov    %esi,%edx
80106f84:	ec                   	in     (%dx),%al
80106f85:	a8 20                	test   $0x20,%al
80106f87:	74 e7                	je     80106f70 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106f89:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80106f8d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106f92:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106f93:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106f97:	83 c7 01             	add    $0x1,%edi
80106f9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80106f9d:	84 c0                	test   %al,%al
80106f9f:	75 bf                	jne    80106f60 <uartinit+0x90>
}
80106fa1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fa4:	5b                   	pop    %ebx
80106fa5:	5e                   	pop    %esi
80106fa6:	5f                   	pop    %edi
80106fa7:	5d                   	pop    %ebp
80106fa8:	c3                   	ret    
80106fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fb0 <uartputc>:
  if(!uart)
80106fb0:	a1 60 55 11 80       	mov    0x80115560,%eax
80106fb5:	85 c0                	test   %eax,%eax
80106fb7:	74 47                	je     80107000 <uartputc+0x50>
{
80106fb9:	55                   	push   %ebp
80106fba:	89 e5                	mov    %esp,%ebp
80106fbc:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106fbd:	be fd 03 00 00       	mov    $0x3fd,%esi
80106fc2:	53                   	push   %ebx
80106fc3:	bb 80 00 00 00       	mov    $0x80,%ebx
80106fc8:	eb 18                	jmp    80106fe2 <uartputc+0x32>
80106fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106fd0:	83 ec 0c             	sub    $0xc,%esp
80106fd3:	6a 0a                	push   $0xa
80106fd5:	e8 56 cc ff ff       	call   80103c30 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106fda:	83 c4 10             	add    $0x10,%esp
80106fdd:	83 eb 01             	sub    $0x1,%ebx
80106fe0:	74 07                	je     80106fe9 <uartputc+0x39>
80106fe2:	89 f2                	mov    %esi,%edx
80106fe4:	ec                   	in     (%dx),%al
80106fe5:	a8 20                	test   $0x20,%al
80106fe7:	74 e7                	je     80106fd0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106fe9:	8b 45 08             	mov    0x8(%ebp),%eax
80106fec:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106ff1:	ee                   	out    %al,(%dx)
}
80106ff2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106ff5:	5b                   	pop    %ebx
80106ff6:	5e                   	pop    %esi
80106ff7:	5d                   	pop    %ebp
80106ff8:	c3                   	ret    
80106ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107000:	c3                   	ret    
80107001:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107008:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010700f:	90                   	nop

80107010 <uartintr>:

void
uartintr(void)
{
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80107016:	68 a0 6e 10 80       	push   $0x80106ea0
8010701b:	e8 30 a3 ff ff       	call   80101350 <consoleintr>
}
80107020:	83 c4 10             	add    $0x10,%esp
80107023:	c9                   	leave  
80107024:	c3                   	ret    

80107025 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107025:	6a 00                	push   $0x0
  pushl $0
80107027:	6a 00                	push   $0x0
  jmp alltraps
80107029:	e9 0c fb ff ff       	jmp    80106b3a <alltraps>

8010702e <vector1>:
.globl vector1
vector1:
  pushl $0
8010702e:	6a 00                	push   $0x0
  pushl $1
80107030:	6a 01                	push   $0x1
  jmp alltraps
80107032:	e9 03 fb ff ff       	jmp    80106b3a <alltraps>

80107037 <vector2>:
.globl vector2
vector2:
  pushl $0
80107037:	6a 00                	push   $0x0
  pushl $2
80107039:	6a 02                	push   $0x2
  jmp alltraps
8010703b:	e9 fa fa ff ff       	jmp    80106b3a <alltraps>

80107040 <vector3>:
.globl vector3
vector3:
  pushl $0
80107040:	6a 00                	push   $0x0
  pushl $3
80107042:	6a 03                	push   $0x3
  jmp alltraps
80107044:	e9 f1 fa ff ff       	jmp    80106b3a <alltraps>

80107049 <vector4>:
.globl vector4
vector4:
  pushl $0
80107049:	6a 00                	push   $0x0
  pushl $4
8010704b:	6a 04                	push   $0x4
  jmp alltraps
8010704d:	e9 e8 fa ff ff       	jmp    80106b3a <alltraps>

80107052 <vector5>:
.globl vector5
vector5:
  pushl $0
80107052:	6a 00                	push   $0x0
  pushl $5
80107054:	6a 05                	push   $0x5
  jmp alltraps
80107056:	e9 df fa ff ff       	jmp    80106b3a <alltraps>

8010705b <vector6>:
.globl vector6
vector6:
  pushl $0
8010705b:	6a 00                	push   $0x0
  pushl $6
8010705d:	6a 06                	push   $0x6
  jmp alltraps
8010705f:	e9 d6 fa ff ff       	jmp    80106b3a <alltraps>

80107064 <vector7>:
.globl vector7
vector7:
  pushl $0
80107064:	6a 00                	push   $0x0
  pushl $7
80107066:	6a 07                	push   $0x7
  jmp alltraps
80107068:	e9 cd fa ff ff       	jmp    80106b3a <alltraps>

8010706d <vector8>:
.globl vector8
vector8:
  pushl $8
8010706d:	6a 08                	push   $0x8
  jmp alltraps
8010706f:	e9 c6 fa ff ff       	jmp    80106b3a <alltraps>

80107074 <vector9>:
.globl vector9
vector9:
  pushl $0
80107074:	6a 00                	push   $0x0
  pushl $9
80107076:	6a 09                	push   $0x9
  jmp alltraps
80107078:	e9 bd fa ff ff       	jmp    80106b3a <alltraps>

8010707d <vector10>:
.globl vector10
vector10:
  pushl $10
8010707d:	6a 0a                	push   $0xa
  jmp alltraps
8010707f:	e9 b6 fa ff ff       	jmp    80106b3a <alltraps>

80107084 <vector11>:
.globl vector11
vector11:
  pushl $11
80107084:	6a 0b                	push   $0xb
  jmp alltraps
80107086:	e9 af fa ff ff       	jmp    80106b3a <alltraps>

8010708b <vector12>:
.globl vector12
vector12:
  pushl $12
8010708b:	6a 0c                	push   $0xc
  jmp alltraps
8010708d:	e9 a8 fa ff ff       	jmp    80106b3a <alltraps>

80107092 <vector13>:
.globl vector13
vector13:
  pushl $13
80107092:	6a 0d                	push   $0xd
  jmp alltraps
80107094:	e9 a1 fa ff ff       	jmp    80106b3a <alltraps>

80107099 <vector14>:
.globl vector14
vector14:
  pushl $14
80107099:	6a 0e                	push   $0xe
  jmp alltraps
8010709b:	e9 9a fa ff ff       	jmp    80106b3a <alltraps>

801070a0 <vector15>:
.globl vector15
vector15:
  pushl $0
801070a0:	6a 00                	push   $0x0
  pushl $15
801070a2:	6a 0f                	push   $0xf
  jmp alltraps
801070a4:	e9 91 fa ff ff       	jmp    80106b3a <alltraps>

801070a9 <vector16>:
.globl vector16
vector16:
  pushl $0
801070a9:	6a 00                	push   $0x0
  pushl $16
801070ab:	6a 10                	push   $0x10
  jmp alltraps
801070ad:	e9 88 fa ff ff       	jmp    80106b3a <alltraps>

801070b2 <vector17>:
.globl vector17
vector17:
  pushl $17
801070b2:	6a 11                	push   $0x11
  jmp alltraps
801070b4:	e9 81 fa ff ff       	jmp    80106b3a <alltraps>

801070b9 <vector18>:
.globl vector18
vector18:
  pushl $0
801070b9:	6a 00                	push   $0x0
  pushl $18
801070bb:	6a 12                	push   $0x12
  jmp alltraps
801070bd:	e9 78 fa ff ff       	jmp    80106b3a <alltraps>

801070c2 <vector19>:
.globl vector19
vector19:
  pushl $0
801070c2:	6a 00                	push   $0x0
  pushl $19
801070c4:	6a 13                	push   $0x13
  jmp alltraps
801070c6:	e9 6f fa ff ff       	jmp    80106b3a <alltraps>

801070cb <vector20>:
.globl vector20
vector20:
  pushl $0
801070cb:	6a 00                	push   $0x0
  pushl $20
801070cd:	6a 14                	push   $0x14
  jmp alltraps
801070cf:	e9 66 fa ff ff       	jmp    80106b3a <alltraps>

801070d4 <vector21>:
.globl vector21
vector21:
  pushl $0
801070d4:	6a 00                	push   $0x0
  pushl $21
801070d6:	6a 15                	push   $0x15
  jmp alltraps
801070d8:	e9 5d fa ff ff       	jmp    80106b3a <alltraps>

801070dd <vector22>:
.globl vector22
vector22:
  pushl $0
801070dd:	6a 00                	push   $0x0
  pushl $22
801070df:	6a 16                	push   $0x16
  jmp alltraps
801070e1:	e9 54 fa ff ff       	jmp    80106b3a <alltraps>

801070e6 <vector23>:
.globl vector23
vector23:
  pushl $0
801070e6:	6a 00                	push   $0x0
  pushl $23
801070e8:	6a 17                	push   $0x17
  jmp alltraps
801070ea:	e9 4b fa ff ff       	jmp    80106b3a <alltraps>

801070ef <vector24>:
.globl vector24
vector24:
  pushl $0
801070ef:	6a 00                	push   $0x0
  pushl $24
801070f1:	6a 18                	push   $0x18
  jmp alltraps
801070f3:	e9 42 fa ff ff       	jmp    80106b3a <alltraps>

801070f8 <vector25>:
.globl vector25
vector25:
  pushl $0
801070f8:	6a 00                	push   $0x0
  pushl $25
801070fa:	6a 19                	push   $0x19
  jmp alltraps
801070fc:	e9 39 fa ff ff       	jmp    80106b3a <alltraps>

80107101 <vector26>:
.globl vector26
vector26:
  pushl $0
80107101:	6a 00                	push   $0x0
  pushl $26
80107103:	6a 1a                	push   $0x1a
  jmp alltraps
80107105:	e9 30 fa ff ff       	jmp    80106b3a <alltraps>

8010710a <vector27>:
.globl vector27
vector27:
  pushl $0
8010710a:	6a 00                	push   $0x0
  pushl $27
8010710c:	6a 1b                	push   $0x1b
  jmp alltraps
8010710e:	e9 27 fa ff ff       	jmp    80106b3a <alltraps>

80107113 <vector28>:
.globl vector28
vector28:
  pushl $0
80107113:	6a 00                	push   $0x0
  pushl $28
80107115:	6a 1c                	push   $0x1c
  jmp alltraps
80107117:	e9 1e fa ff ff       	jmp    80106b3a <alltraps>

8010711c <vector29>:
.globl vector29
vector29:
  pushl $0
8010711c:	6a 00                	push   $0x0
  pushl $29
8010711e:	6a 1d                	push   $0x1d
  jmp alltraps
80107120:	e9 15 fa ff ff       	jmp    80106b3a <alltraps>

80107125 <vector30>:
.globl vector30
vector30:
  pushl $0
80107125:	6a 00                	push   $0x0
  pushl $30
80107127:	6a 1e                	push   $0x1e
  jmp alltraps
80107129:	e9 0c fa ff ff       	jmp    80106b3a <alltraps>

8010712e <vector31>:
.globl vector31
vector31:
  pushl $0
8010712e:	6a 00                	push   $0x0
  pushl $31
80107130:	6a 1f                	push   $0x1f
  jmp alltraps
80107132:	e9 03 fa ff ff       	jmp    80106b3a <alltraps>

80107137 <vector32>:
.globl vector32
vector32:
  pushl $0
80107137:	6a 00                	push   $0x0
  pushl $32
80107139:	6a 20                	push   $0x20
  jmp alltraps
8010713b:	e9 fa f9 ff ff       	jmp    80106b3a <alltraps>

80107140 <vector33>:
.globl vector33
vector33:
  pushl $0
80107140:	6a 00                	push   $0x0
  pushl $33
80107142:	6a 21                	push   $0x21
  jmp alltraps
80107144:	e9 f1 f9 ff ff       	jmp    80106b3a <alltraps>

80107149 <vector34>:
.globl vector34
vector34:
  pushl $0
80107149:	6a 00                	push   $0x0
  pushl $34
8010714b:	6a 22                	push   $0x22
  jmp alltraps
8010714d:	e9 e8 f9 ff ff       	jmp    80106b3a <alltraps>

80107152 <vector35>:
.globl vector35
vector35:
  pushl $0
80107152:	6a 00                	push   $0x0
  pushl $35
80107154:	6a 23                	push   $0x23
  jmp alltraps
80107156:	e9 df f9 ff ff       	jmp    80106b3a <alltraps>

8010715b <vector36>:
.globl vector36
vector36:
  pushl $0
8010715b:	6a 00                	push   $0x0
  pushl $36
8010715d:	6a 24                	push   $0x24
  jmp alltraps
8010715f:	e9 d6 f9 ff ff       	jmp    80106b3a <alltraps>

80107164 <vector37>:
.globl vector37
vector37:
  pushl $0
80107164:	6a 00                	push   $0x0
  pushl $37
80107166:	6a 25                	push   $0x25
  jmp alltraps
80107168:	e9 cd f9 ff ff       	jmp    80106b3a <alltraps>

8010716d <vector38>:
.globl vector38
vector38:
  pushl $0
8010716d:	6a 00                	push   $0x0
  pushl $38
8010716f:	6a 26                	push   $0x26
  jmp alltraps
80107171:	e9 c4 f9 ff ff       	jmp    80106b3a <alltraps>

80107176 <vector39>:
.globl vector39
vector39:
  pushl $0
80107176:	6a 00                	push   $0x0
  pushl $39
80107178:	6a 27                	push   $0x27
  jmp alltraps
8010717a:	e9 bb f9 ff ff       	jmp    80106b3a <alltraps>

8010717f <vector40>:
.globl vector40
vector40:
  pushl $0
8010717f:	6a 00                	push   $0x0
  pushl $40
80107181:	6a 28                	push   $0x28
  jmp alltraps
80107183:	e9 b2 f9 ff ff       	jmp    80106b3a <alltraps>

80107188 <vector41>:
.globl vector41
vector41:
  pushl $0
80107188:	6a 00                	push   $0x0
  pushl $41
8010718a:	6a 29                	push   $0x29
  jmp alltraps
8010718c:	e9 a9 f9 ff ff       	jmp    80106b3a <alltraps>

80107191 <vector42>:
.globl vector42
vector42:
  pushl $0
80107191:	6a 00                	push   $0x0
  pushl $42
80107193:	6a 2a                	push   $0x2a
  jmp alltraps
80107195:	e9 a0 f9 ff ff       	jmp    80106b3a <alltraps>

8010719a <vector43>:
.globl vector43
vector43:
  pushl $0
8010719a:	6a 00                	push   $0x0
  pushl $43
8010719c:	6a 2b                	push   $0x2b
  jmp alltraps
8010719e:	e9 97 f9 ff ff       	jmp    80106b3a <alltraps>

801071a3 <vector44>:
.globl vector44
vector44:
  pushl $0
801071a3:	6a 00                	push   $0x0
  pushl $44
801071a5:	6a 2c                	push   $0x2c
  jmp alltraps
801071a7:	e9 8e f9 ff ff       	jmp    80106b3a <alltraps>

801071ac <vector45>:
.globl vector45
vector45:
  pushl $0
801071ac:	6a 00                	push   $0x0
  pushl $45
801071ae:	6a 2d                	push   $0x2d
  jmp alltraps
801071b0:	e9 85 f9 ff ff       	jmp    80106b3a <alltraps>

801071b5 <vector46>:
.globl vector46
vector46:
  pushl $0
801071b5:	6a 00                	push   $0x0
  pushl $46
801071b7:	6a 2e                	push   $0x2e
  jmp alltraps
801071b9:	e9 7c f9 ff ff       	jmp    80106b3a <alltraps>

801071be <vector47>:
.globl vector47
vector47:
  pushl $0
801071be:	6a 00                	push   $0x0
  pushl $47
801071c0:	6a 2f                	push   $0x2f
  jmp alltraps
801071c2:	e9 73 f9 ff ff       	jmp    80106b3a <alltraps>

801071c7 <vector48>:
.globl vector48
vector48:
  pushl $0
801071c7:	6a 00                	push   $0x0
  pushl $48
801071c9:	6a 30                	push   $0x30
  jmp alltraps
801071cb:	e9 6a f9 ff ff       	jmp    80106b3a <alltraps>

801071d0 <vector49>:
.globl vector49
vector49:
  pushl $0
801071d0:	6a 00                	push   $0x0
  pushl $49
801071d2:	6a 31                	push   $0x31
  jmp alltraps
801071d4:	e9 61 f9 ff ff       	jmp    80106b3a <alltraps>

801071d9 <vector50>:
.globl vector50
vector50:
  pushl $0
801071d9:	6a 00                	push   $0x0
  pushl $50
801071db:	6a 32                	push   $0x32
  jmp alltraps
801071dd:	e9 58 f9 ff ff       	jmp    80106b3a <alltraps>

801071e2 <vector51>:
.globl vector51
vector51:
  pushl $0
801071e2:	6a 00                	push   $0x0
  pushl $51
801071e4:	6a 33                	push   $0x33
  jmp alltraps
801071e6:	e9 4f f9 ff ff       	jmp    80106b3a <alltraps>

801071eb <vector52>:
.globl vector52
vector52:
  pushl $0
801071eb:	6a 00                	push   $0x0
  pushl $52
801071ed:	6a 34                	push   $0x34
  jmp alltraps
801071ef:	e9 46 f9 ff ff       	jmp    80106b3a <alltraps>

801071f4 <vector53>:
.globl vector53
vector53:
  pushl $0
801071f4:	6a 00                	push   $0x0
  pushl $53
801071f6:	6a 35                	push   $0x35
  jmp alltraps
801071f8:	e9 3d f9 ff ff       	jmp    80106b3a <alltraps>

801071fd <vector54>:
.globl vector54
vector54:
  pushl $0
801071fd:	6a 00                	push   $0x0
  pushl $54
801071ff:	6a 36                	push   $0x36
  jmp alltraps
80107201:	e9 34 f9 ff ff       	jmp    80106b3a <alltraps>

80107206 <vector55>:
.globl vector55
vector55:
  pushl $0
80107206:	6a 00                	push   $0x0
  pushl $55
80107208:	6a 37                	push   $0x37
  jmp alltraps
8010720a:	e9 2b f9 ff ff       	jmp    80106b3a <alltraps>

8010720f <vector56>:
.globl vector56
vector56:
  pushl $0
8010720f:	6a 00                	push   $0x0
  pushl $56
80107211:	6a 38                	push   $0x38
  jmp alltraps
80107213:	e9 22 f9 ff ff       	jmp    80106b3a <alltraps>

80107218 <vector57>:
.globl vector57
vector57:
  pushl $0
80107218:	6a 00                	push   $0x0
  pushl $57
8010721a:	6a 39                	push   $0x39
  jmp alltraps
8010721c:	e9 19 f9 ff ff       	jmp    80106b3a <alltraps>

80107221 <vector58>:
.globl vector58
vector58:
  pushl $0
80107221:	6a 00                	push   $0x0
  pushl $58
80107223:	6a 3a                	push   $0x3a
  jmp alltraps
80107225:	e9 10 f9 ff ff       	jmp    80106b3a <alltraps>

8010722a <vector59>:
.globl vector59
vector59:
  pushl $0
8010722a:	6a 00                	push   $0x0
  pushl $59
8010722c:	6a 3b                	push   $0x3b
  jmp alltraps
8010722e:	e9 07 f9 ff ff       	jmp    80106b3a <alltraps>

80107233 <vector60>:
.globl vector60
vector60:
  pushl $0
80107233:	6a 00                	push   $0x0
  pushl $60
80107235:	6a 3c                	push   $0x3c
  jmp alltraps
80107237:	e9 fe f8 ff ff       	jmp    80106b3a <alltraps>

8010723c <vector61>:
.globl vector61
vector61:
  pushl $0
8010723c:	6a 00                	push   $0x0
  pushl $61
8010723e:	6a 3d                	push   $0x3d
  jmp alltraps
80107240:	e9 f5 f8 ff ff       	jmp    80106b3a <alltraps>

80107245 <vector62>:
.globl vector62
vector62:
  pushl $0
80107245:	6a 00                	push   $0x0
  pushl $62
80107247:	6a 3e                	push   $0x3e
  jmp alltraps
80107249:	e9 ec f8 ff ff       	jmp    80106b3a <alltraps>

8010724e <vector63>:
.globl vector63
vector63:
  pushl $0
8010724e:	6a 00                	push   $0x0
  pushl $63
80107250:	6a 3f                	push   $0x3f
  jmp alltraps
80107252:	e9 e3 f8 ff ff       	jmp    80106b3a <alltraps>

80107257 <vector64>:
.globl vector64
vector64:
  pushl $0
80107257:	6a 00                	push   $0x0
  pushl $64
80107259:	6a 40                	push   $0x40
  jmp alltraps
8010725b:	e9 da f8 ff ff       	jmp    80106b3a <alltraps>

80107260 <vector65>:
.globl vector65
vector65:
  pushl $0
80107260:	6a 00                	push   $0x0
  pushl $65
80107262:	6a 41                	push   $0x41
  jmp alltraps
80107264:	e9 d1 f8 ff ff       	jmp    80106b3a <alltraps>

80107269 <vector66>:
.globl vector66
vector66:
  pushl $0
80107269:	6a 00                	push   $0x0
  pushl $66
8010726b:	6a 42                	push   $0x42
  jmp alltraps
8010726d:	e9 c8 f8 ff ff       	jmp    80106b3a <alltraps>

80107272 <vector67>:
.globl vector67
vector67:
  pushl $0
80107272:	6a 00                	push   $0x0
  pushl $67
80107274:	6a 43                	push   $0x43
  jmp alltraps
80107276:	e9 bf f8 ff ff       	jmp    80106b3a <alltraps>

8010727b <vector68>:
.globl vector68
vector68:
  pushl $0
8010727b:	6a 00                	push   $0x0
  pushl $68
8010727d:	6a 44                	push   $0x44
  jmp alltraps
8010727f:	e9 b6 f8 ff ff       	jmp    80106b3a <alltraps>

80107284 <vector69>:
.globl vector69
vector69:
  pushl $0
80107284:	6a 00                	push   $0x0
  pushl $69
80107286:	6a 45                	push   $0x45
  jmp alltraps
80107288:	e9 ad f8 ff ff       	jmp    80106b3a <alltraps>

8010728d <vector70>:
.globl vector70
vector70:
  pushl $0
8010728d:	6a 00                	push   $0x0
  pushl $70
8010728f:	6a 46                	push   $0x46
  jmp alltraps
80107291:	e9 a4 f8 ff ff       	jmp    80106b3a <alltraps>

80107296 <vector71>:
.globl vector71
vector71:
  pushl $0
80107296:	6a 00                	push   $0x0
  pushl $71
80107298:	6a 47                	push   $0x47
  jmp alltraps
8010729a:	e9 9b f8 ff ff       	jmp    80106b3a <alltraps>

8010729f <vector72>:
.globl vector72
vector72:
  pushl $0
8010729f:	6a 00                	push   $0x0
  pushl $72
801072a1:	6a 48                	push   $0x48
  jmp alltraps
801072a3:	e9 92 f8 ff ff       	jmp    80106b3a <alltraps>

801072a8 <vector73>:
.globl vector73
vector73:
  pushl $0
801072a8:	6a 00                	push   $0x0
  pushl $73
801072aa:	6a 49                	push   $0x49
  jmp alltraps
801072ac:	e9 89 f8 ff ff       	jmp    80106b3a <alltraps>

801072b1 <vector74>:
.globl vector74
vector74:
  pushl $0
801072b1:	6a 00                	push   $0x0
  pushl $74
801072b3:	6a 4a                	push   $0x4a
  jmp alltraps
801072b5:	e9 80 f8 ff ff       	jmp    80106b3a <alltraps>

801072ba <vector75>:
.globl vector75
vector75:
  pushl $0
801072ba:	6a 00                	push   $0x0
  pushl $75
801072bc:	6a 4b                	push   $0x4b
  jmp alltraps
801072be:	e9 77 f8 ff ff       	jmp    80106b3a <alltraps>

801072c3 <vector76>:
.globl vector76
vector76:
  pushl $0
801072c3:	6a 00                	push   $0x0
  pushl $76
801072c5:	6a 4c                	push   $0x4c
  jmp alltraps
801072c7:	e9 6e f8 ff ff       	jmp    80106b3a <alltraps>

801072cc <vector77>:
.globl vector77
vector77:
  pushl $0
801072cc:	6a 00                	push   $0x0
  pushl $77
801072ce:	6a 4d                	push   $0x4d
  jmp alltraps
801072d0:	e9 65 f8 ff ff       	jmp    80106b3a <alltraps>

801072d5 <vector78>:
.globl vector78
vector78:
  pushl $0
801072d5:	6a 00                	push   $0x0
  pushl $78
801072d7:	6a 4e                	push   $0x4e
  jmp alltraps
801072d9:	e9 5c f8 ff ff       	jmp    80106b3a <alltraps>

801072de <vector79>:
.globl vector79
vector79:
  pushl $0
801072de:	6a 00                	push   $0x0
  pushl $79
801072e0:	6a 4f                	push   $0x4f
  jmp alltraps
801072e2:	e9 53 f8 ff ff       	jmp    80106b3a <alltraps>

801072e7 <vector80>:
.globl vector80
vector80:
  pushl $0
801072e7:	6a 00                	push   $0x0
  pushl $80
801072e9:	6a 50                	push   $0x50
  jmp alltraps
801072eb:	e9 4a f8 ff ff       	jmp    80106b3a <alltraps>

801072f0 <vector81>:
.globl vector81
vector81:
  pushl $0
801072f0:	6a 00                	push   $0x0
  pushl $81
801072f2:	6a 51                	push   $0x51
  jmp alltraps
801072f4:	e9 41 f8 ff ff       	jmp    80106b3a <alltraps>

801072f9 <vector82>:
.globl vector82
vector82:
  pushl $0
801072f9:	6a 00                	push   $0x0
  pushl $82
801072fb:	6a 52                	push   $0x52
  jmp alltraps
801072fd:	e9 38 f8 ff ff       	jmp    80106b3a <alltraps>

80107302 <vector83>:
.globl vector83
vector83:
  pushl $0
80107302:	6a 00                	push   $0x0
  pushl $83
80107304:	6a 53                	push   $0x53
  jmp alltraps
80107306:	e9 2f f8 ff ff       	jmp    80106b3a <alltraps>

8010730b <vector84>:
.globl vector84
vector84:
  pushl $0
8010730b:	6a 00                	push   $0x0
  pushl $84
8010730d:	6a 54                	push   $0x54
  jmp alltraps
8010730f:	e9 26 f8 ff ff       	jmp    80106b3a <alltraps>

80107314 <vector85>:
.globl vector85
vector85:
  pushl $0
80107314:	6a 00                	push   $0x0
  pushl $85
80107316:	6a 55                	push   $0x55
  jmp alltraps
80107318:	e9 1d f8 ff ff       	jmp    80106b3a <alltraps>

8010731d <vector86>:
.globl vector86
vector86:
  pushl $0
8010731d:	6a 00                	push   $0x0
  pushl $86
8010731f:	6a 56                	push   $0x56
  jmp alltraps
80107321:	e9 14 f8 ff ff       	jmp    80106b3a <alltraps>

80107326 <vector87>:
.globl vector87
vector87:
  pushl $0
80107326:	6a 00                	push   $0x0
  pushl $87
80107328:	6a 57                	push   $0x57
  jmp alltraps
8010732a:	e9 0b f8 ff ff       	jmp    80106b3a <alltraps>

8010732f <vector88>:
.globl vector88
vector88:
  pushl $0
8010732f:	6a 00                	push   $0x0
  pushl $88
80107331:	6a 58                	push   $0x58
  jmp alltraps
80107333:	e9 02 f8 ff ff       	jmp    80106b3a <alltraps>

80107338 <vector89>:
.globl vector89
vector89:
  pushl $0
80107338:	6a 00                	push   $0x0
  pushl $89
8010733a:	6a 59                	push   $0x59
  jmp alltraps
8010733c:	e9 f9 f7 ff ff       	jmp    80106b3a <alltraps>

80107341 <vector90>:
.globl vector90
vector90:
  pushl $0
80107341:	6a 00                	push   $0x0
  pushl $90
80107343:	6a 5a                	push   $0x5a
  jmp alltraps
80107345:	e9 f0 f7 ff ff       	jmp    80106b3a <alltraps>

8010734a <vector91>:
.globl vector91
vector91:
  pushl $0
8010734a:	6a 00                	push   $0x0
  pushl $91
8010734c:	6a 5b                	push   $0x5b
  jmp alltraps
8010734e:	e9 e7 f7 ff ff       	jmp    80106b3a <alltraps>

80107353 <vector92>:
.globl vector92
vector92:
  pushl $0
80107353:	6a 00                	push   $0x0
  pushl $92
80107355:	6a 5c                	push   $0x5c
  jmp alltraps
80107357:	e9 de f7 ff ff       	jmp    80106b3a <alltraps>

8010735c <vector93>:
.globl vector93
vector93:
  pushl $0
8010735c:	6a 00                	push   $0x0
  pushl $93
8010735e:	6a 5d                	push   $0x5d
  jmp alltraps
80107360:	e9 d5 f7 ff ff       	jmp    80106b3a <alltraps>

80107365 <vector94>:
.globl vector94
vector94:
  pushl $0
80107365:	6a 00                	push   $0x0
  pushl $94
80107367:	6a 5e                	push   $0x5e
  jmp alltraps
80107369:	e9 cc f7 ff ff       	jmp    80106b3a <alltraps>

8010736e <vector95>:
.globl vector95
vector95:
  pushl $0
8010736e:	6a 00                	push   $0x0
  pushl $95
80107370:	6a 5f                	push   $0x5f
  jmp alltraps
80107372:	e9 c3 f7 ff ff       	jmp    80106b3a <alltraps>

80107377 <vector96>:
.globl vector96
vector96:
  pushl $0
80107377:	6a 00                	push   $0x0
  pushl $96
80107379:	6a 60                	push   $0x60
  jmp alltraps
8010737b:	e9 ba f7 ff ff       	jmp    80106b3a <alltraps>

80107380 <vector97>:
.globl vector97
vector97:
  pushl $0
80107380:	6a 00                	push   $0x0
  pushl $97
80107382:	6a 61                	push   $0x61
  jmp alltraps
80107384:	e9 b1 f7 ff ff       	jmp    80106b3a <alltraps>

80107389 <vector98>:
.globl vector98
vector98:
  pushl $0
80107389:	6a 00                	push   $0x0
  pushl $98
8010738b:	6a 62                	push   $0x62
  jmp alltraps
8010738d:	e9 a8 f7 ff ff       	jmp    80106b3a <alltraps>

80107392 <vector99>:
.globl vector99
vector99:
  pushl $0
80107392:	6a 00                	push   $0x0
  pushl $99
80107394:	6a 63                	push   $0x63
  jmp alltraps
80107396:	e9 9f f7 ff ff       	jmp    80106b3a <alltraps>

8010739b <vector100>:
.globl vector100
vector100:
  pushl $0
8010739b:	6a 00                	push   $0x0
  pushl $100
8010739d:	6a 64                	push   $0x64
  jmp alltraps
8010739f:	e9 96 f7 ff ff       	jmp    80106b3a <alltraps>

801073a4 <vector101>:
.globl vector101
vector101:
  pushl $0
801073a4:	6a 00                	push   $0x0
  pushl $101
801073a6:	6a 65                	push   $0x65
  jmp alltraps
801073a8:	e9 8d f7 ff ff       	jmp    80106b3a <alltraps>

801073ad <vector102>:
.globl vector102
vector102:
  pushl $0
801073ad:	6a 00                	push   $0x0
  pushl $102
801073af:	6a 66                	push   $0x66
  jmp alltraps
801073b1:	e9 84 f7 ff ff       	jmp    80106b3a <alltraps>

801073b6 <vector103>:
.globl vector103
vector103:
  pushl $0
801073b6:	6a 00                	push   $0x0
  pushl $103
801073b8:	6a 67                	push   $0x67
  jmp alltraps
801073ba:	e9 7b f7 ff ff       	jmp    80106b3a <alltraps>

801073bf <vector104>:
.globl vector104
vector104:
  pushl $0
801073bf:	6a 00                	push   $0x0
  pushl $104
801073c1:	6a 68                	push   $0x68
  jmp alltraps
801073c3:	e9 72 f7 ff ff       	jmp    80106b3a <alltraps>

801073c8 <vector105>:
.globl vector105
vector105:
  pushl $0
801073c8:	6a 00                	push   $0x0
  pushl $105
801073ca:	6a 69                	push   $0x69
  jmp alltraps
801073cc:	e9 69 f7 ff ff       	jmp    80106b3a <alltraps>

801073d1 <vector106>:
.globl vector106
vector106:
  pushl $0
801073d1:	6a 00                	push   $0x0
  pushl $106
801073d3:	6a 6a                	push   $0x6a
  jmp alltraps
801073d5:	e9 60 f7 ff ff       	jmp    80106b3a <alltraps>

801073da <vector107>:
.globl vector107
vector107:
  pushl $0
801073da:	6a 00                	push   $0x0
  pushl $107
801073dc:	6a 6b                	push   $0x6b
  jmp alltraps
801073de:	e9 57 f7 ff ff       	jmp    80106b3a <alltraps>

801073e3 <vector108>:
.globl vector108
vector108:
  pushl $0
801073e3:	6a 00                	push   $0x0
  pushl $108
801073e5:	6a 6c                	push   $0x6c
  jmp alltraps
801073e7:	e9 4e f7 ff ff       	jmp    80106b3a <alltraps>

801073ec <vector109>:
.globl vector109
vector109:
  pushl $0
801073ec:	6a 00                	push   $0x0
  pushl $109
801073ee:	6a 6d                	push   $0x6d
  jmp alltraps
801073f0:	e9 45 f7 ff ff       	jmp    80106b3a <alltraps>

801073f5 <vector110>:
.globl vector110
vector110:
  pushl $0
801073f5:	6a 00                	push   $0x0
  pushl $110
801073f7:	6a 6e                	push   $0x6e
  jmp alltraps
801073f9:	e9 3c f7 ff ff       	jmp    80106b3a <alltraps>

801073fe <vector111>:
.globl vector111
vector111:
  pushl $0
801073fe:	6a 00                	push   $0x0
  pushl $111
80107400:	6a 6f                	push   $0x6f
  jmp alltraps
80107402:	e9 33 f7 ff ff       	jmp    80106b3a <alltraps>

80107407 <vector112>:
.globl vector112
vector112:
  pushl $0
80107407:	6a 00                	push   $0x0
  pushl $112
80107409:	6a 70                	push   $0x70
  jmp alltraps
8010740b:	e9 2a f7 ff ff       	jmp    80106b3a <alltraps>

80107410 <vector113>:
.globl vector113
vector113:
  pushl $0
80107410:	6a 00                	push   $0x0
  pushl $113
80107412:	6a 71                	push   $0x71
  jmp alltraps
80107414:	e9 21 f7 ff ff       	jmp    80106b3a <alltraps>

80107419 <vector114>:
.globl vector114
vector114:
  pushl $0
80107419:	6a 00                	push   $0x0
  pushl $114
8010741b:	6a 72                	push   $0x72
  jmp alltraps
8010741d:	e9 18 f7 ff ff       	jmp    80106b3a <alltraps>

80107422 <vector115>:
.globl vector115
vector115:
  pushl $0
80107422:	6a 00                	push   $0x0
  pushl $115
80107424:	6a 73                	push   $0x73
  jmp alltraps
80107426:	e9 0f f7 ff ff       	jmp    80106b3a <alltraps>

8010742b <vector116>:
.globl vector116
vector116:
  pushl $0
8010742b:	6a 00                	push   $0x0
  pushl $116
8010742d:	6a 74                	push   $0x74
  jmp alltraps
8010742f:	e9 06 f7 ff ff       	jmp    80106b3a <alltraps>

80107434 <vector117>:
.globl vector117
vector117:
  pushl $0
80107434:	6a 00                	push   $0x0
  pushl $117
80107436:	6a 75                	push   $0x75
  jmp alltraps
80107438:	e9 fd f6 ff ff       	jmp    80106b3a <alltraps>

8010743d <vector118>:
.globl vector118
vector118:
  pushl $0
8010743d:	6a 00                	push   $0x0
  pushl $118
8010743f:	6a 76                	push   $0x76
  jmp alltraps
80107441:	e9 f4 f6 ff ff       	jmp    80106b3a <alltraps>

80107446 <vector119>:
.globl vector119
vector119:
  pushl $0
80107446:	6a 00                	push   $0x0
  pushl $119
80107448:	6a 77                	push   $0x77
  jmp alltraps
8010744a:	e9 eb f6 ff ff       	jmp    80106b3a <alltraps>

8010744f <vector120>:
.globl vector120
vector120:
  pushl $0
8010744f:	6a 00                	push   $0x0
  pushl $120
80107451:	6a 78                	push   $0x78
  jmp alltraps
80107453:	e9 e2 f6 ff ff       	jmp    80106b3a <alltraps>

80107458 <vector121>:
.globl vector121
vector121:
  pushl $0
80107458:	6a 00                	push   $0x0
  pushl $121
8010745a:	6a 79                	push   $0x79
  jmp alltraps
8010745c:	e9 d9 f6 ff ff       	jmp    80106b3a <alltraps>

80107461 <vector122>:
.globl vector122
vector122:
  pushl $0
80107461:	6a 00                	push   $0x0
  pushl $122
80107463:	6a 7a                	push   $0x7a
  jmp alltraps
80107465:	e9 d0 f6 ff ff       	jmp    80106b3a <alltraps>

8010746a <vector123>:
.globl vector123
vector123:
  pushl $0
8010746a:	6a 00                	push   $0x0
  pushl $123
8010746c:	6a 7b                	push   $0x7b
  jmp alltraps
8010746e:	e9 c7 f6 ff ff       	jmp    80106b3a <alltraps>

80107473 <vector124>:
.globl vector124
vector124:
  pushl $0
80107473:	6a 00                	push   $0x0
  pushl $124
80107475:	6a 7c                	push   $0x7c
  jmp alltraps
80107477:	e9 be f6 ff ff       	jmp    80106b3a <alltraps>

8010747c <vector125>:
.globl vector125
vector125:
  pushl $0
8010747c:	6a 00                	push   $0x0
  pushl $125
8010747e:	6a 7d                	push   $0x7d
  jmp alltraps
80107480:	e9 b5 f6 ff ff       	jmp    80106b3a <alltraps>

80107485 <vector126>:
.globl vector126
vector126:
  pushl $0
80107485:	6a 00                	push   $0x0
  pushl $126
80107487:	6a 7e                	push   $0x7e
  jmp alltraps
80107489:	e9 ac f6 ff ff       	jmp    80106b3a <alltraps>

8010748e <vector127>:
.globl vector127
vector127:
  pushl $0
8010748e:	6a 00                	push   $0x0
  pushl $127
80107490:	6a 7f                	push   $0x7f
  jmp alltraps
80107492:	e9 a3 f6 ff ff       	jmp    80106b3a <alltraps>

80107497 <vector128>:
.globl vector128
vector128:
  pushl $0
80107497:	6a 00                	push   $0x0
  pushl $128
80107499:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010749e:	e9 97 f6 ff ff       	jmp    80106b3a <alltraps>

801074a3 <vector129>:
.globl vector129
vector129:
  pushl $0
801074a3:	6a 00                	push   $0x0
  pushl $129
801074a5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801074aa:	e9 8b f6 ff ff       	jmp    80106b3a <alltraps>

801074af <vector130>:
.globl vector130
vector130:
  pushl $0
801074af:	6a 00                	push   $0x0
  pushl $130
801074b1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801074b6:	e9 7f f6 ff ff       	jmp    80106b3a <alltraps>

801074bb <vector131>:
.globl vector131
vector131:
  pushl $0
801074bb:	6a 00                	push   $0x0
  pushl $131
801074bd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801074c2:	e9 73 f6 ff ff       	jmp    80106b3a <alltraps>

801074c7 <vector132>:
.globl vector132
vector132:
  pushl $0
801074c7:	6a 00                	push   $0x0
  pushl $132
801074c9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801074ce:	e9 67 f6 ff ff       	jmp    80106b3a <alltraps>

801074d3 <vector133>:
.globl vector133
vector133:
  pushl $0
801074d3:	6a 00                	push   $0x0
  pushl $133
801074d5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801074da:	e9 5b f6 ff ff       	jmp    80106b3a <alltraps>

801074df <vector134>:
.globl vector134
vector134:
  pushl $0
801074df:	6a 00                	push   $0x0
  pushl $134
801074e1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801074e6:	e9 4f f6 ff ff       	jmp    80106b3a <alltraps>

801074eb <vector135>:
.globl vector135
vector135:
  pushl $0
801074eb:	6a 00                	push   $0x0
  pushl $135
801074ed:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801074f2:	e9 43 f6 ff ff       	jmp    80106b3a <alltraps>

801074f7 <vector136>:
.globl vector136
vector136:
  pushl $0
801074f7:	6a 00                	push   $0x0
  pushl $136
801074f9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801074fe:	e9 37 f6 ff ff       	jmp    80106b3a <alltraps>

80107503 <vector137>:
.globl vector137
vector137:
  pushl $0
80107503:	6a 00                	push   $0x0
  pushl $137
80107505:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010750a:	e9 2b f6 ff ff       	jmp    80106b3a <alltraps>

8010750f <vector138>:
.globl vector138
vector138:
  pushl $0
8010750f:	6a 00                	push   $0x0
  pushl $138
80107511:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107516:	e9 1f f6 ff ff       	jmp    80106b3a <alltraps>

8010751b <vector139>:
.globl vector139
vector139:
  pushl $0
8010751b:	6a 00                	push   $0x0
  pushl $139
8010751d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107522:	e9 13 f6 ff ff       	jmp    80106b3a <alltraps>

80107527 <vector140>:
.globl vector140
vector140:
  pushl $0
80107527:	6a 00                	push   $0x0
  pushl $140
80107529:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010752e:	e9 07 f6 ff ff       	jmp    80106b3a <alltraps>

80107533 <vector141>:
.globl vector141
vector141:
  pushl $0
80107533:	6a 00                	push   $0x0
  pushl $141
80107535:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010753a:	e9 fb f5 ff ff       	jmp    80106b3a <alltraps>

8010753f <vector142>:
.globl vector142
vector142:
  pushl $0
8010753f:	6a 00                	push   $0x0
  pushl $142
80107541:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107546:	e9 ef f5 ff ff       	jmp    80106b3a <alltraps>

8010754b <vector143>:
.globl vector143
vector143:
  pushl $0
8010754b:	6a 00                	push   $0x0
  pushl $143
8010754d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107552:	e9 e3 f5 ff ff       	jmp    80106b3a <alltraps>

80107557 <vector144>:
.globl vector144
vector144:
  pushl $0
80107557:	6a 00                	push   $0x0
  pushl $144
80107559:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010755e:	e9 d7 f5 ff ff       	jmp    80106b3a <alltraps>

80107563 <vector145>:
.globl vector145
vector145:
  pushl $0
80107563:	6a 00                	push   $0x0
  pushl $145
80107565:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010756a:	e9 cb f5 ff ff       	jmp    80106b3a <alltraps>

8010756f <vector146>:
.globl vector146
vector146:
  pushl $0
8010756f:	6a 00                	push   $0x0
  pushl $146
80107571:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107576:	e9 bf f5 ff ff       	jmp    80106b3a <alltraps>

8010757b <vector147>:
.globl vector147
vector147:
  pushl $0
8010757b:	6a 00                	push   $0x0
  pushl $147
8010757d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107582:	e9 b3 f5 ff ff       	jmp    80106b3a <alltraps>

80107587 <vector148>:
.globl vector148
vector148:
  pushl $0
80107587:	6a 00                	push   $0x0
  pushl $148
80107589:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010758e:	e9 a7 f5 ff ff       	jmp    80106b3a <alltraps>

80107593 <vector149>:
.globl vector149
vector149:
  pushl $0
80107593:	6a 00                	push   $0x0
  pushl $149
80107595:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010759a:	e9 9b f5 ff ff       	jmp    80106b3a <alltraps>

8010759f <vector150>:
.globl vector150
vector150:
  pushl $0
8010759f:	6a 00                	push   $0x0
  pushl $150
801075a1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801075a6:	e9 8f f5 ff ff       	jmp    80106b3a <alltraps>

801075ab <vector151>:
.globl vector151
vector151:
  pushl $0
801075ab:	6a 00                	push   $0x0
  pushl $151
801075ad:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801075b2:	e9 83 f5 ff ff       	jmp    80106b3a <alltraps>

801075b7 <vector152>:
.globl vector152
vector152:
  pushl $0
801075b7:	6a 00                	push   $0x0
  pushl $152
801075b9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801075be:	e9 77 f5 ff ff       	jmp    80106b3a <alltraps>

801075c3 <vector153>:
.globl vector153
vector153:
  pushl $0
801075c3:	6a 00                	push   $0x0
  pushl $153
801075c5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801075ca:	e9 6b f5 ff ff       	jmp    80106b3a <alltraps>

801075cf <vector154>:
.globl vector154
vector154:
  pushl $0
801075cf:	6a 00                	push   $0x0
  pushl $154
801075d1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801075d6:	e9 5f f5 ff ff       	jmp    80106b3a <alltraps>

801075db <vector155>:
.globl vector155
vector155:
  pushl $0
801075db:	6a 00                	push   $0x0
  pushl $155
801075dd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801075e2:	e9 53 f5 ff ff       	jmp    80106b3a <alltraps>

801075e7 <vector156>:
.globl vector156
vector156:
  pushl $0
801075e7:	6a 00                	push   $0x0
  pushl $156
801075e9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801075ee:	e9 47 f5 ff ff       	jmp    80106b3a <alltraps>

801075f3 <vector157>:
.globl vector157
vector157:
  pushl $0
801075f3:	6a 00                	push   $0x0
  pushl $157
801075f5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801075fa:	e9 3b f5 ff ff       	jmp    80106b3a <alltraps>

801075ff <vector158>:
.globl vector158
vector158:
  pushl $0
801075ff:	6a 00                	push   $0x0
  pushl $158
80107601:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107606:	e9 2f f5 ff ff       	jmp    80106b3a <alltraps>

8010760b <vector159>:
.globl vector159
vector159:
  pushl $0
8010760b:	6a 00                	push   $0x0
  pushl $159
8010760d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107612:	e9 23 f5 ff ff       	jmp    80106b3a <alltraps>

80107617 <vector160>:
.globl vector160
vector160:
  pushl $0
80107617:	6a 00                	push   $0x0
  pushl $160
80107619:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010761e:	e9 17 f5 ff ff       	jmp    80106b3a <alltraps>

80107623 <vector161>:
.globl vector161
vector161:
  pushl $0
80107623:	6a 00                	push   $0x0
  pushl $161
80107625:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010762a:	e9 0b f5 ff ff       	jmp    80106b3a <alltraps>

8010762f <vector162>:
.globl vector162
vector162:
  pushl $0
8010762f:	6a 00                	push   $0x0
  pushl $162
80107631:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107636:	e9 ff f4 ff ff       	jmp    80106b3a <alltraps>

8010763b <vector163>:
.globl vector163
vector163:
  pushl $0
8010763b:	6a 00                	push   $0x0
  pushl $163
8010763d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107642:	e9 f3 f4 ff ff       	jmp    80106b3a <alltraps>

80107647 <vector164>:
.globl vector164
vector164:
  pushl $0
80107647:	6a 00                	push   $0x0
  pushl $164
80107649:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010764e:	e9 e7 f4 ff ff       	jmp    80106b3a <alltraps>

80107653 <vector165>:
.globl vector165
vector165:
  pushl $0
80107653:	6a 00                	push   $0x0
  pushl $165
80107655:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010765a:	e9 db f4 ff ff       	jmp    80106b3a <alltraps>

8010765f <vector166>:
.globl vector166
vector166:
  pushl $0
8010765f:	6a 00                	push   $0x0
  pushl $166
80107661:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107666:	e9 cf f4 ff ff       	jmp    80106b3a <alltraps>

8010766b <vector167>:
.globl vector167
vector167:
  pushl $0
8010766b:	6a 00                	push   $0x0
  pushl $167
8010766d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107672:	e9 c3 f4 ff ff       	jmp    80106b3a <alltraps>

80107677 <vector168>:
.globl vector168
vector168:
  pushl $0
80107677:	6a 00                	push   $0x0
  pushl $168
80107679:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010767e:	e9 b7 f4 ff ff       	jmp    80106b3a <alltraps>

80107683 <vector169>:
.globl vector169
vector169:
  pushl $0
80107683:	6a 00                	push   $0x0
  pushl $169
80107685:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010768a:	e9 ab f4 ff ff       	jmp    80106b3a <alltraps>

8010768f <vector170>:
.globl vector170
vector170:
  pushl $0
8010768f:	6a 00                	push   $0x0
  pushl $170
80107691:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107696:	e9 9f f4 ff ff       	jmp    80106b3a <alltraps>

8010769b <vector171>:
.globl vector171
vector171:
  pushl $0
8010769b:	6a 00                	push   $0x0
  pushl $171
8010769d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801076a2:	e9 93 f4 ff ff       	jmp    80106b3a <alltraps>

801076a7 <vector172>:
.globl vector172
vector172:
  pushl $0
801076a7:	6a 00                	push   $0x0
  pushl $172
801076a9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801076ae:	e9 87 f4 ff ff       	jmp    80106b3a <alltraps>

801076b3 <vector173>:
.globl vector173
vector173:
  pushl $0
801076b3:	6a 00                	push   $0x0
  pushl $173
801076b5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801076ba:	e9 7b f4 ff ff       	jmp    80106b3a <alltraps>

801076bf <vector174>:
.globl vector174
vector174:
  pushl $0
801076bf:	6a 00                	push   $0x0
  pushl $174
801076c1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801076c6:	e9 6f f4 ff ff       	jmp    80106b3a <alltraps>

801076cb <vector175>:
.globl vector175
vector175:
  pushl $0
801076cb:	6a 00                	push   $0x0
  pushl $175
801076cd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801076d2:	e9 63 f4 ff ff       	jmp    80106b3a <alltraps>

801076d7 <vector176>:
.globl vector176
vector176:
  pushl $0
801076d7:	6a 00                	push   $0x0
  pushl $176
801076d9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801076de:	e9 57 f4 ff ff       	jmp    80106b3a <alltraps>

801076e3 <vector177>:
.globl vector177
vector177:
  pushl $0
801076e3:	6a 00                	push   $0x0
  pushl $177
801076e5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801076ea:	e9 4b f4 ff ff       	jmp    80106b3a <alltraps>

801076ef <vector178>:
.globl vector178
vector178:
  pushl $0
801076ef:	6a 00                	push   $0x0
  pushl $178
801076f1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801076f6:	e9 3f f4 ff ff       	jmp    80106b3a <alltraps>

801076fb <vector179>:
.globl vector179
vector179:
  pushl $0
801076fb:	6a 00                	push   $0x0
  pushl $179
801076fd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107702:	e9 33 f4 ff ff       	jmp    80106b3a <alltraps>

80107707 <vector180>:
.globl vector180
vector180:
  pushl $0
80107707:	6a 00                	push   $0x0
  pushl $180
80107709:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010770e:	e9 27 f4 ff ff       	jmp    80106b3a <alltraps>

80107713 <vector181>:
.globl vector181
vector181:
  pushl $0
80107713:	6a 00                	push   $0x0
  pushl $181
80107715:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010771a:	e9 1b f4 ff ff       	jmp    80106b3a <alltraps>

8010771f <vector182>:
.globl vector182
vector182:
  pushl $0
8010771f:	6a 00                	push   $0x0
  pushl $182
80107721:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107726:	e9 0f f4 ff ff       	jmp    80106b3a <alltraps>

8010772b <vector183>:
.globl vector183
vector183:
  pushl $0
8010772b:	6a 00                	push   $0x0
  pushl $183
8010772d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107732:	e9 03 f4 ff ff       	jmp    80106b3a <alltraps>

80107737 <vector184>:
.globl vector184
vector184:
  pushl $0
80107737:	6a 00                	push   $0x0
  pushl $184
80107739:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010773e:	e9 f7 f3 ff ff       	jmp    80106b3a <alltraps>

80107743 <vector185>:
.globl vector185
vector185:
  pushl $0
80107743:	6a 00                	push   $0x0
  pushl $185
80107745:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010774a:	e9 eb f3 ff ff       	jmp    80106b3a <alltraps>

8010774f <vector186>:
.globl vector186
vector186:
  pushl $0
8010774f:	6a 00                	push   $0x0
  pushl $186
80107751:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107756:	e9 df f3 ff ff       	jmp    80106b3a <alltraps>

8010775b <vector187>:
.globl vector187
vector187:
  pushl $0
8010775b:	6a 00                	push   $0x0
  pushl $187
8010775d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107762:	e9 d3 f3 ff ff       	jmp    80106b3a <alltraps>

80107767 <vector188>:
.globl vector188
vector188:
  pushl $0
80107767:	6a 00                	push   $0x0
  pushl $188
80107769:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010776e:	e9 c7 f3 ff ff       	jmp    80106b3a <alltraps>

80107773 <vector189>:
.globl vector189
vector189:
  pushl $0
80107773:	6a 00                	push   $0x0
  pushl $189
80107775:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010777a:	e9 bb f3 ff ff       	jmp    80106b3a <alltraps>

8010777f <vector190>:
.globl vector190
vector190:
  pushl $0
8010777f:	6a 00                	push   $0x0
  pushl $190
80107781:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107786:	e9 af f3 ff ff       	jmp    80106b3a <alltraps>

8010778b <vector191>:
.globl vector191
vector191:
  pushl $0
8010778b:	6a 00                	push   $0x0
  pushl $191
8010778d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107792:	e9 a3 f3 ff ff       	jmp    80106b3a <alltraps>

80107797 <vector192>:
.globl vector192
vector192:
  pushl $0
80107797:	6a 00                	push   $0x0
  pushl $192
80107799:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010779e:	e9 97 f3 ff ff       	jmp    80106b3a <alltraps>

801077a3 <vector193>:
.globl vector193
vector193:
  pushl $0
801077a3:	6a 00                	push   $0x0
  pushl $193
801077a5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801077aa:	e9 8b f3 ff ff       	jmp    80106b3a <alltraps>

801077af <vector194>:
.globl vector194
vector194:
  pushl $0
801077af:	6a 00                	push   $0x0
  pushl $194
801077b1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801077b6:	e9 7f f3 ff ff       	jmp    80106b3a <alltraps>

801077bb <vector195>:
.globl vector195
vector195:
  pushl $0
801077bb:	6a 00                	push   $0x0
  pushl $195
801077bd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801077c2:	e9 73 f3 ff ff       	jmp    80106b3a <alltraps>

801077c7 <vector196>:
.globl vector196
vector196:
  pushl $0
801077c7:	6a 00                	push   $0x0
  pushl $196
801077c9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801077ce:	e9 67 f3 ff ff       	jmp    80106b3a <alltraps>

801077d3 <vector197>:
.globl vector197
vector197:
  pushl $0
801077d3:	6a 00                	push   $0x0
  pushl $197
801077d5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801077da:	e9 5b f3 ff ff       	jmp    80106b3a <alltraps>

801077df <vector198>:
.globl vector198
vector198:
  pushl $0
801077df:	6a 00                	push   $0x0
  pushl $198
801077e1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801077e6:	e9 4f f3 ff ff       	jmp    80106b3a <alltraps>

801077eb <vector199>:
.globl vector199
vector199:
  pushl $0
801077eb:	6a 00                	push   $0x0
  pushl $199
801077ed:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801077f2:	e9 43 f3 ff ff       	jmp    80106b3a <alltraps>

801077f7 <vector200>:
.globl vector200
vector200:
  pushl $0
801077f7:	6a 00                	push   $0x0
  pushl $200
801077f9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801077fe:	e9 37 f3 ff ff       	jmp    80106b3a <alltraps>

80107803 <vector201>:
.globl vector201
vector201:
  pushl $0
80107803:	6a 00                	push   $0x0
  pushl $201
80107805:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010780a:	e9 2b f3 ff ff       	jmp    80106b3a <alltraps>

8010780f <vector202>:
.globl vector202
vector202:
  pushl $0
8010780f:	6a 00                	push   $0x0
  pushl $202
80107811:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107816:	e9 1f f3 ff ff       	jmp    80106b3a <alltraps>

8010781b <vector203>:
.globl vector203
vector203:
  pushl $0
8010781b:	6a 00                	push   $0x0
  pushl $203
8010781d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107822:	e9 13 f3 ff ff       	jmp    80106b3a <alltraps>

80107827 <vector204>:
.globl vector204
vector204:
  pushl $0
80107827:	6a 00                	push   $0x0
  pushl $204
80107829:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010782e:	e9 07 f3 ff ff       	jmp    80106b3a <alltraps>

80107833 <vector205>:
.globl vector205
vector205:
  pushl $0
80107833:	6a 00                	push   $0x0
  pushl $205
80107835:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010783a:	e9 fb f2 ff ff       	jmp    80106b3a <alltraps>

8010783f <vector206>:
.globl vector206
vector206:
  pushl $0
8010783f:	6a 00                	push   $0x0
  pushl $206
80107841:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107846:	e9 ef f2 ff ff       	jmp    80106b3a <alltraps>

8010784b <vector207>:
.globl vector207
vector207:
  pushl $0
8010784b:	6a 00                	push   $0x0
  pushl $207
8010784d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107852:	e9 e3 f2 ff ff       	jmp    80106b3a <alltraps>

80107857 <vector208>:
.globl vector208
vector208:
  pushl $0
80107857:	6a 00                	push   $0x0
  pushl $208
80107859:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010785e:	e9 d7 f2 ff ff       	jmp    80106b3a <alltraps>

80107863 <vector209>:
.globl vector209
vector209:
  pushl $0
80107863:	6a 00                	push   $0x0
  pushl $209
80107865:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010786a:	e9 cb f2 ff ff       	jmp    80106b3a <alltraps>

8010786f <vector210>:
.globl vector210
vector210:
  pushl $0
8010786f:	6a 00                	push   $0x0
  pushl $210
80107871:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107876:	e9 bf f2 ff ff       	jmp    80106b3a <alltraps>

8010787b <vector211>:
.globl vector211
vector211:
  pushl $0
8010787b:	6a 00                	push   $0x0
  pushl $211
8010787d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107882:	e9 b3 f2 ff ff       	jmp    80106b3a <alltraps>

80107887 <vector212>:
.globl vector212
vector212:
  pushl $0
80107887:	6a 00                	push   $0x0
  pushl $212
80107889:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010788e:	e9 a7 f2 ff ff       	jmp    80106b3a <alltraps>

80107893 <vector213>:
.globl vector213
vector213:
  pushl $0
80107893:	6a 00                	push   $0x0
  pushl $213
80107895:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010789a:	e9 9b f2 ff ff       	jmp    80106b3a <alltraps>

8010789f <vector214>:
.globl vector214
vector214:
  pushl $0
8010789f:	6a 00                	push   $0x0
  pushl $214
801078a1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801078a6:	e9 8f f2 ff ff       	jmp    80106b3a <alltraps>

801078ab <vector215>:
.globl vector215
vector215:
  pushl $0
801078ab:	6a 00                	push   $0x0
  pushl $215
801078ad:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801078b2:	e9 83 f2 ff ff       	jmp    80106b3a <alltraps>

801078b7 <vector216>:
.globl vector216
vector216:
  pushl $0
801078b7:	6a 00                	push   $0x0
  pushl $216
801078b9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801078be:	e9 77 f2 ff ff       	jmp    80106b3a <alltraps>

801078c3 <vector217>:
.globl vector217
vector217:
  pushl $0
801078c3:	6a 00                	push   $0x0
  pushl $217
801078c5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801078ca:	e9 6b f2 ff ff       	jmp    80106b3a <alltraps>

801078cf <vector218>:
.globl vector218
vector218:
  pushl $0
801078cf:	6a 00                	push   $0x0
  pushl $218
801078d1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801078d6:	e9 5f f2 ff ff       	jmp    80106b3a <alltraps>

801078db <vector219>:
.globl vector219
vector219:
  pushl $0
801078db:	6a 00                	push   $0x0
  pushl $219
801078dd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801078e2:	e9 53 f2 ff ff       	jmp    80106b3a <alltraps>

801078e7 <vector220>:
.globl vector220
vector220:
  pushl $0
801078e7:	6a 00                	push   $0x0
  pushl $220
801078e9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801078ee:	e9 47 f2 ff ff       	jmp    80106b3a <alltraps>

801078f3 <vector221>:
.globl vector221
vector221:
  pushl $0
801078f3:	6a 00                	push   $0x0
  pushl $221
801078f5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801078fa:	e9 3b f2 ff ff       	jmp    80106b3a <alltraps>

801078ff <vector222>:
.globl vector222
vector222:
  pushl $0
801078ff:	6a 00                	push   $0x0
  pushl $222
80107901:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107906:	e9 2f f2 ff ff       	jmp    80106b3a <alltraps>

8010790b <vector223>:
.globl vector223
vector223:
  pushl $0
8010790b:	6a 00                	push   $0x0
  pushl $223
8010790d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107912:	e9 23 f2 ff ff       	jmp    80106b3a <alltraps>

80107917 <vector224>:
.globl vector224
vector224:
  pushl $0
80107917:	6a 00                	push   $0x0
  pushl $224
80107919:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010791e:	e9 17 f2 ff ff       	jmp    80106b3a <alltraps>

80107923 <vector225>:
.globl vector225
vector225:
  pushl $0
80107923:	6a 00                	push   $0x0
  pushl $225
80107925:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010792a:	e9 0b f2 ff ff       	jmp    80106b3a <alltraps>

8010792f <vector226>:
.globl vector226
vector226:
  pushl $0
8010792f:	6a 00                	push   $0x0
  pushl $226
80107931:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107936:	e9 ff f1 ff ff       	jmp    80106b3a <alltraps>

8010793b <vector227>:
.globl vector227
vector227:
  pushl $0
8010793b:	6a 00                	push   $0x0
  pushl $227
8010793d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107942:	e9 f3 f1 ff ff       	jmp    80106b3a <alltraps>

80107947 <vector228>:
.globl vector228
vector228:
  pushl $0
80107947:	6a 00                	push   $0x0
  pushl $228
80107949:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010794e:	e9 e7 f1 ff ff       	jmp    80106b3a <alltraps>

80107953 <vector229>:
.globl vector229
vector229:
  pushl $0
80107953:	6a 00                	push   $0x0
  pushl $229
80107955:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010795a:	e9 db f1 ff ff       	jmp    80106b3a <alltraps>

8010795f <vector230>:
.globl vector230
vector230:
  pushl $0
8010795f:	6a 00                	push   $0x0
  pushl $230
80107961:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107966:	e9 cf f1 ff ff       	jmp    80106b3a <alltraps>

8010796b <vector231>:
.globl vector231
vector231:
  pushl $0
8010796b:	6a 00                	push   $0x0
  pushl $231
8010796d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107972:	e9 c3 f1 ff ff       	jmp    80106b3a <alltraps>

80107977 <vector232>:
.globl vector232
vector232:
  pushl $0
80107977:	6a 00                	push   $0x0
  pushl $232
80107979:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010797e:	e9 b7 f1 ff ff       	jmp    80106b3a <alltraps>

80107983 <vector233>:
.globl vector233
vector233:
  pushl $0
80107983:	6a 00                	push   $0x0
  pushl $233
80107985:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010798a:	e9 ab f1 ff ff       	jmp    80106b3a <alltraps>

8010798f <vector234>:
.globl vector234
vector234:
  pushl $0
8010798f:	6a 00                	push   $0x0
  pushl $234
80107991:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107996:	e9 9f f1 ff ff       	jmp    80106b3a <alltraps>

8010799b <vector235>:
.globl vector235
vector235:
  pushl $0
8010799b:	6a 00                	push   $0x0
  pushl $235
8010799d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801079a2:	e9 93 f1 ff ff       	jmp    80106b3a <alltraps>

801079a7 <vector236>:
.globl vector236
vector236:
  pushl $0
801079a7:	6a 00                	push   $0x0
  pushl $236
801079a9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801079ae:	e9 87 f1 ff ff       	jmp    80106b3a <alltraps>

801079b3 <vector237>:
.globl vector237
vector237:
  pushl $0
801079b3:	6a 00                	push   $0x0
  pushl $237
801079b5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801079ba:	e9 7b f1 ff ff       	jmp    80106b3a <alltraps>

801079bf <vector238>:
.globl vector238
vector238:
  pushl $0
801079bf:	6a 00                	push   $0x0
  pushl $238
801079c1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801079c6:	e9 6f f1 ff ff       	jmp    80106b3a <alltraps>

801079cb <vector239>:
.globl vector239
vector239:
  pushl $0
801079cb:	6a 00                	push   $0x0
  pushl $239
801079cd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801079d2:	e9 63 f1 ff ff       	jmp    80106b3a <alltraps>

801079d7 <vector240>:
.globl vector240
vector240:
  pushl $0
801079d7:	6a 00                	push   $0x0
  pushl $240
801079d9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801079de:	e9 57 f1 ff ff       	jmp    80106b3a <alltraps>

801079e3 <vector241>:
.globl vector241
vector241:
  pushl $0
801079e3:	6a 00                	push   $0x0
  pushl $241
801079e5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801079ea:	e9 4b f1 ff ff       	jmp    80106b3a <alltraps>

801079ef <vector242>:
.globl vector242
vector242:
  pushl $0
801079ef:	6a 00                	push   $0x0
  pushl $242
801079f1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801079f6:	e9 3f f1 ff ff       	jmp    80106b3a <alltraps>

801079fb <vector243>:
.globl vector243
vector243:
  pushl $0
801079fb:	6a 00                	push   $0x0
  pushl $243
801079fd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107a02:	e9 33 f1 ff ff       	jmp    80106b3a <alltraps>

80107a07 <vector244>:
.globl vector244
vector244:
  pushl $0
80107a07:	6a 00                	push   $0x0
  pushl $244
80107a09:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107a0e:	e9 27 f1 ff ff       	jmp    80106b3a <alltraps>

80107a13 <vector245>:
.globl vector245
vector245:
  pushl $0
80107a13:	6a 00                	push   $0x0
  pushl $245
80107a15:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107a1a:	e9 1b f1 ff ff       	jmp    80106b3a <alltraps>

80107a1f <vector246>:
.globl vector246
vector246:
  pushl $0
80107a1f:	6a 00                	push   $0x0
  pushl $246
80107a21:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107a26:	e9 0f f1 ff ff       	jmp    80106b3a <alltraps>

80107a2b <vector247>:
.globl vector247
vector247:
  pushl $0
80107a2b:	6a 00                	push   $0x0
  pushl $247
80107a2d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107a32:	e9 03 f1 ff ff       	jmp    80106b3a <alltraps>

80107a37 <vector248>:
.globl vector248
vector248:
  pushl $0
80107a37:	6a 00                	push   $0x0
  pushl $248
80107a39:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107a3e:	e9 f7 f0 ff ff       	jmp    80106b3a <alltraps>

80107a43 <vector249>:
.globl vector249
vector249:
  pushl $0
80107a43:	6a 00                	push   $0x0
  pushl $249
80107a45:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107a4a:	e9 eb f0 ff ff       	jmp    80106b3a <alltraps>

80107a4f <vector250>:
.globl vector250
vector250:
  pushl $0
80107a4f:	6a 00                	push   $0x0
  pushl $250
80107a51:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107a56:	e9 df f0 ff ff       	jmp    80106b3a <alltraps>

80107a5b <vector251>:
.globl vector251
vector251:
  pushl $0
80107a5b:	6a 00                	push   $0x0
  pushl $251
80107a5d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107a62:	e9 d3 f0 ff ff       	jmp    80106b3a <alltraps>

80107a67 <vector252>:
.globl vector252
vector252:
  pushl $0
80107a67:	6a 00                	push   $0x0
  pushl $252
80107a69:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107a6e:	e9 c7 f0 ff ff       	jmp    80106b3a <alltraps>

80107a73 <vector253>:
.globl vector253
vector253:
  pushl $0
80107a73:	6a 00                	push   $0x0
  pushl $253
80107a75:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107a7a:	e9 bb f0 ff ff       	jmp    80106b3a <alltraps>

80107a7f <vector254>:
.globl vector254
vector254:
  pushl $0
80107a7f:	6a 00                	push   $0x0
  pushl $254
80107a81:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107a86:	e9 af f0 ff ff       	jmp    80106b3a <alltraps>

80107a8b <vector255>:
.globl vector255
vector255:
  pushl $0
80107a8b:	6a 00                	push   $0x0
  pushl $255
80107a8d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107a92:	e9 a3 f0 ff ff       	jmp    80106b3a <alltraps>
80107a97:	66 90                	xchg   %ax,%ax
80107a99:	66 90                	xchg   %ax,%ax
80107a9b:	66 90                	xchg   %ax,%ax
80107a9d:	66 90                	xchg   %ax,%ax
80107a9f:	90                   	nop

80107aa0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107aa0:	55                   	push   %ebp
80107aa1:	89 e5                	mov    %esp,%ebp
80107aa3:	57                   	push   %edi
80107aa4:	56                   	push   %esi
80107aa5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107aa6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80107aac:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107ab2:	83 ec 1c             	sub    $0x1c,%esp
80107ab5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107ab8:	39 d3                	cmp    %edx,%ebx
80107aba:	73 49                	jae    80107b05 <deallocuvm.part.0+0x65>
80107abc:	89 c7                	mov    %eax,%edi
80107abe:	eb 0c                	jmp    80107acc <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107ac0:	83 c0 01             	add    $0x1,%eax
80107ac3:	c1 e0 16             	shl    $0x16,%eax
80107ac6:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107ac8:	39 da                	cmp    %ebx,%edx
80107aca:	76 39                	jbe    80107b05 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
80107acc:	89 d8                	mov    %ebx,%eax
80107ace:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107ad1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80107ad4:	f6 c1 01             	test   $0x1,%cl
80107ad7:	74 e7                	je     80107ac0 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80107ad9:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107adb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107ae1:	c1 ee 0a             	shr    $0xa,%esi
80107ae4:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80107aea:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80107af1:	85 f6                	test   %esi,%esi
80107af3:	74 cb                	je     80107ac0 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80107af5:	8b 06                	mov    (%esi),%eax
80107af7:	a8 01                	test   $0x1,%al
80107af9:	75 15                	jne    80107b10 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80107afb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107b01:	39 da                	cmp    %ebx,%edx
80107b03:	77 c7                	ja     80107acc <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107b05:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b0b:	5b                   	pop    %ebx
80107b0c:	5e                   	pop    %esi
80107b0d:	5f                   	pop    %edi
80107b0e:	5d                   	pop    %ebp
80107b0f:	c3                   	ret    
      if(pa == 0)
80107b10:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b15:	74 25                	je     80107b3c <deallocuvm.part.0+0x9c>
      kfree(v);
80107b17:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107b1a:	05 00 00 00 80       	add    $0x80000000,%eax
80107b1f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107b22:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80107b28:	50                   	push   %eax
80107b29:	e8 92 bc ff ff       	call   801037c0 <kfree>
      *pte = 0;
80107b2e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80107b34:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107b37:	83 c4 10             	add    $0x10,%esp
80107b3a:	eb 8c                	jmp    80107ac8 <deallocuvm.part.0+0x28>
        panic("kfree");
80107b3c:	83 ec 0c             	sub    $0xc,%esp
80107b3f:	68 e2 87 10 80       	push   $0x801087e2
80107b44:	e8 97 91 ff ff       	call   80100ce0 <panic>
80107b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107b50 <mappages>:
{
80107b50:	55                   	push   %ebp
80107b51:	89 e5                	mov    %esp,%ebp
80107b53:	57                   	push   %edi
80107b54:	56                   	push   %esi
80107b55:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107b56:	89 d3                	mov    %edx,%ebx
80107b58:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107b5e:	83 ec 1c             	sub    $0x1c,%esp
80107b61:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107b64:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107b68:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b6d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107b70:	8b 45 08             	mov    0x8(%ebp),%eax
80107b73:	29 d8                	sub    %ebx,%eax
80107b75:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107b78:	eb 3d                	jmp    80107bb7 <mappages+0x67>
80107b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107b80:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107b87:	c1 ea 0a             	shr    $0xa,%edx
80107b8a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107b90:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107b97:	85 c0                	test   %eax,%eax
80107b99:	74 75                	je     80107c10 <mappages+0xc0>
    if(*pte & PTE_P)
80107b9b:	f6 00 01             	testb  $0x1,(%eax)
80107b9e:	0f 85 86 00 00 00    	jne    80107c2a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107ba4:	0b 75 0c             	or     0xc(%ebp),%esi
80107ba7:	83 ce 01             	or     $0x1,%esi
80107baa:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107bac:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
80107baf:	74 6f                	je     80107c20 <mappages+0xd0>
    a += PGSIZE;
80107bb1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107bb7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
80107bba:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107bbd:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107bc0:	89 d8                	mov    %ebx,%eax
80107bc2:	c1 e8 16             	shr    $0x16,%eax
80107bc5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107bc8:	8b 07                	mov    (%edi),%eax
80107bca:	a8 01                	test   $0x1,%al
80107bcc:	75 b2                	jne    80107b80 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107bce:	e8 ad bd ff ff       	call   80103980 <kalloc>
80107bd3:	85 c0                	test   %eax,%eax
80107bd5:	74 39                	je     80107c10 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107bd7:	83 ec 04             	sub    $0x4,%esp
80107bda:	89 45 d8             	mov    %eax,-0x28(%ebp)
80107bdd:	68 00 10 00 00       	push   $0x1000
80107be2:	6a 00                	push   $0x0
80107be4:	50                   	push   %eax
80107be5:	e8 76 dd ff ff       	call   80105960 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107bea:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80107bed:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107bf0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107bf6:	83 c8 07             	or     $0x7,%eax
80107bf9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80107bfb:	89 d8                	mov    %ebx,%eax
80107bfd:	c1 e8 0a             	shr    $0xa,%eax
80107c00:	25 fc 0f 00 00       	and    $0xffc,%eax
80107c05:	01 d0                	add    %edx,%eax
80107c07:	eb 92                	jmp    80107b9b <mappages+0x4b>
80107c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80107c10:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107c13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c18:	5b                   	pop    %ebx
80107c19:	5e                   	pop    %esi
80107c1a:	5f                   	pop    %edi
80107c1b:	5d                   	pop    %ebp
80107c1c:	c3                   	ret    
80107c1d:	8d 76 00             	lea    0x0(%esi),%esi
80107c20:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107c23:	31 c0                	xor    %eax,%eax
}
80107c25:	5b                   	pop    %ebx
80107c26:	5e                   	pop    %esi
80107c27:	5f                   	pop    %edi
80107c28:	5d                   	pop    %ebp
80107c29:	c3                   	ret    
      panic("remap");
80107c2a:	83 ec 0c             	sub    $0xc,%esp
80107c2d:	68 28 8e 10 80       	push   $0x80108e28
80107c32:	e8 a9 90 ff ff       	call   80100ce0 <panic>
80107c37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c3e:	66 90                	xchg   %ax,%ax

80107c40 <seginit>:
{
80107c40:	55                   	push   %ebp
80107c41:	89 e5                	mov    %esp,%ebp
80107c43:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107c46:	e8 05 d0 ff ff       	call   80104c50 <cpuid>
  pd[0] = size-1;
80107c4b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107c50:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107c56:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107c5a:	c7 80 b8 28 11 80 ff 	movl   $0xffff,-0x7feed748(%eax)
80107c61:	ff 00 00 
80107c64:	c7 80 bc 28 11 80 00 	movl   $0xcf9a00,-0x7feed744(%eax)
80107c6b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107c6e:	c7 80 c0 28 11 80 ff 	movl   $0xffff,-0x7feed740(%eax)
80107c75:	ff 00 00 
80107c78:	c7 80 c4 28 11 80 00 	movl   $0xcf9200,-0x7feed73c(%eax)
80107c7f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107c82:	c7 80 c8 28 11 80 ff 	movl   $0xffff,-0x7feed738(%eax)
80107c89:	ff 00 00 
80107c8c:	c7 80 cc 28 11 80 00 	movl   $0xcffa00,-0x7feed734(%eax)
80107c93:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107c96:	c7 80 d0 28 11 80 ff 	movl   $0xffff,-0x7feed730(%eax)
80107c9d:	ff 00 00 
80107ca0:	c7 80 d4 28 11 80 00 	movl   $0xcff200,-0x7feed72c(%eax)
80107ca7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80107caa:	05 b0 28 11 80       	add    $0x801128b0,%eax
  pd[1] = (uint)p;
80107caf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107cb3:	c1 e8 10             	shr    $0x10,%eax
80107cb6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107cba:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107cbd:	0f 01 10             	lgdtl  (%eax)
}
80107cc0:	c9                   	leave  
80107cc1:	c3                   	ret    
80107cc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107cd0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107cd0:	a1 64 55 11 80       	mov    0x80115564,%eax
80107cd5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107cda:	0f 22 d8             	mov    %eax,%cr3
}
80107cdd:	c3                   	ret    
80107cde:	66 90                	xchg   %ax,%ax

80107ce0 <switchuvm>:
{
80107ce0:	55                   	push   %ebp
80107ce1:	89 e5                	mov    %esp,%ebp
80107ce3:	57                   	push   %edi
80107ce4:	56                   	push   %esi
80107ce5:	53                   	push   %ebx
80107ce6:	83 ec 1c             	sub    $0x1c,%esp
80107ce9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107cec:	85 f6                	test   %esi,%esi
80107cee:	0f 84 cb 00 00 00    	je     80107dbf <switchuvm+0xdf>
  if(p->kstack == 0)
80107cf4:	8b 46 08             	mov    0x8(%esi),%eax
80107cf7:	85 c0                	test   %eax,%eax
80107cf9:	0f 84 da 00 00 00    	je     80107dd9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80107cff:	8b 46 04             	mov    0x4(%esi),%eax
80107d02:	85 c0                	test   %eax,%eax
80107d04:	0f 84 c2 00 00 00    	je     80107dcc <switchuvm+0xec>
  pushcli();
80107d0a:	e8 41 da ff ff       	call   80105750 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107d0f:	e8 dc ce ff ff       	call   80104bf0 <mycpu>
80107d14:	89 c3                	mov    %eax,%ebx
80107d16:	e8 d5 ce ff ff       	call   80104bf0 <mycpu>
80107d1b:	89 c7                	mov    %eax,%edi
80107d1d:	e8 ce ce ff ff       	call   80104bf0 <mycpu>
80107d22:	83 c7 08             	add    $0x8,%edi
80107d25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107d28:	e8 c3 ce ff ff       	call   80104bf0 <mycpu>
80107d2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107d30:	ba 67 00 00 00       	mov    $0x67,%edx
80107d35:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107d3c:	83 c0 08             	add    $0x8,%eax
80107d3f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107d46:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107d4b:	83 c1 08             	add    $0x8,%ecx
80107d4e:	c1 e8 18             	shr    $0x18,%eax
80107d51:	c1 e9 10             	shr    $0x10,%ecx
80107d54:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80107d5a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107d60:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107d65:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107d6c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107d71:	e8 7a ce ff ff       	call   80104bf0 <mycpu>
80107d76:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107d7d:	e8 6e ce ff ff       	call   80104bf0 <mycpu>
80107d82:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107d86:	8b 5e 08             	mov    0x8(%esi),%ebx
80107d89:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107d8f:	e8 5c ce ff ff       	call   80104bf0 <mycpu>
80107d94:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107d97:	e8 54 ce ff ff       	call   80104bf0 <mycpu>
80107d9c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107da0:	b8 28 00 00 00       	mov    $0x28,%eax
80107da5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107da8:	8b 46 04             	mov    0x4(%esi),%eax
80107dab:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107db0:	0f 22 d8             	mov    %eax,%cr3
}
80107db3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107db6:	5b                   	pop    %ebx
80107db7:	5e                   	pop    %esi
80107db8:	5f                   	pop    %edi
80107db9:	5d                   	pop    %ebp
  popcli();
80107dba:	e9 e1 d9 ff ff       	jmp    801057a0 <popcli>
    panic("switchuvm: no process");
80107dbf:	83 ec 0c             	sub    $0xc,%esp
80107dc2:	68 2e 8e 10 80       	push   $0x80108e2e
80107dc7:	e8 14 8f ff ff       	call   80100ce0 <panic>
    panic("switchuvm: no pgdir");
80107dcc:	83 ec 0c             	sub    $0xc,%esp
80107dcf:	68 59 8e 10 80       	push   $0x80108e59
80107dd4:	e8 07 8f ff ff       	call   80100ce0 <panic>
    panic("switchuvm: no kstack");
80107dd9:	83 ec 0c             	sub    $0xc,%esp
80107ddc:	68 44 8e 10 80       	push   $0x80108e44
80107de1:	e8 fa 8e ff ff       	call   80100ce0 <panic>
80107de6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ded:	8d 76 00             	lea    0x0(%esi),%esi

80107df0 <inituvm>:
{
80107df0:	55                   	push   %ebp
80107df1:	89 e5                	mov    %esp,%ebp
80107df3:	57                   	push   %edi
80107df4:	56                   	push   %esi
80107df5:	53                   	push   %ebx
80107df6:	83 ec 1c             	sub    $0x1c,%esp
80107df9:	8b 45 0c             	mov    0xc(%ebp),%eax
80107dfc:	8b 75 10             	mov    0x10(%ebp),%esi
80107dff:	8b 7d 08             	mov    0x8(%ebp),%edi
80107e02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107e05:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107e0b:	77 4b                	ja     80107e58 <inituvm+0x68>
  mem = kalloc();
80107e0d:	e8 6e bb ff ff       	call   80103980 <kalloc>
  memset(mem, 0, PGSIZE);
80107e12:	83 ec 04             	sub    $0x4,%esp
80107e15:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80107e1a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107e1c:	6a 00                	push   $0x0
80107e1e:	50                   	push   %eax
80107e1f:	e8 3c db ff ff       	call   80105960 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107e24:	58                   	pop    %eax
80107e25:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107e2b:	5a                   	pop    %edx
80107e2c:	6a 06                	push   $0x6
80107e2e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107e33:	31 d2                	xor    %edx,%edx
80107e35:	50                   	push   %eax
80107e36:	89 f8                	mov    %edi,%eax
80107e38:	e8 13 fd ff ff       	call   80107b50 <mappages>
  memmove(mem, init, sz);
80107e3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107e40:	89 75 10             	mov    %esi,0x10(%ebp)
80107e43:	83 c4 10             	add    $0x10,%esp
80107e46:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107e49:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107e4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e4f:	5b                   	pop    %ebx
80107e50:	5e                   	pop    %esi
80107e51:	5f                   	pop    %edi
80107e52:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107e53:	e9 a8 db ff ff       	jmp    80105a00 <memmove>
    panic("inituvm: more than a page");
80107e58:	83 ec 0c             	sub    $0xc,%esp
80107e5b:	68 6d 8e 10 80       	push   $0x80108e6d
80107e60:	e8 7b 8e ff ff       	call   80100ce0 <panic>
80107e65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107e70 <loaduvm>:
{
80107e70:	55                   	push   %ebp
80107e71:	89 e5                	mov    %esp,%ebp
80107e73:	57                   	push   %edi
80107e74:	56                   	push   %esi
80107e75:	53                   	push   %ebx
80107e76:	83 ec 1c             	sub    $0x1c,%esp
80107e79:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e7c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80107e7f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107e84:	0f 85 bb 00 00 00    	jne    80107f45 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
80107e8a:	01 f0                	add    %esi,%eax
80107e8c:	89 f3                	mov    %esi,%ebx
80107e8e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107e91:	8b 45 14             	mov    0x14(%ebp),%eax
80107e94:	01 f0                	add    %esi,%eax
80107e96:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107e99:	85 f6                	test   %esi,%esi
80107e9b:	0f 84 87 00 00 00    	je     80107f28 <loaduvm+0xb8>
80107ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107ea8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
80107eab:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107eae:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107eb0:	89 c2                	mov    %eax,%edx
80107eb2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107eb5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107eb8:	f6 c2 01             	test   $0x1,%dl
80107ebb:	75 13                	jne    80107ed0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
80107ebd:	83 ec 0c             	sub    $0xc,%esp
80107ec0:	68 87 8e 10 80       	push   $0x80108e87
80107ec5:	e8 16 8e ff ff       	call   80100ce0 <panic>
80107eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107ed0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ed3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107ed9:	25 fc 0f 00 00       	and    $0xffc,%eax
80107ede:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107ee5:	85 c0                	test   %eax,%eax
80107ee7:	74 d4                	je     80107ebd <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107ee9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107eeb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80107eee:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107ef3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107ef8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80107efe:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107f01:	29 d9                	sub    %ebx,%ecx
80107f03:	05 00 00 00 80       	add    $0x80000000,%eax
80107f08:	57                   	push   %edi
80107f09:	51                   	push   %ecx
80107f0a:	50                   	push   %eax
80107f0b:	ff 75 10             	push   0x10(%ebp)
80107f0e:	e8 7d ae ff ff       	call   80102d90 <readi>
80107f13:	83 c4 10             	add    $0x10,%esp
80107f16:	39 f8                	cmp    %edi,%eax
80107f18:	75 1e                	jne    80107f38 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107f1a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107f20:	89 f0                	mov    %esi,%eax
80107f22:	29 d8                	sub    %ebx,%eax
80107f24:	39 c6                	cmp    %eax,%esi
80107f26:	77 80                	ja     80107ea8 <loaduvm+0x38>
}
80107f28:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107f2b:	31 c0                	xor    %eax,%eax
}
80107f2d:	5b                   	pop    %ebx
80107f2e:	5e                   	pop    %esi
80107f2f:	5f                   	pop    %edi
80107f30:	5d                   	pop    %ebp
80107f31:	c3                   	ret    
80107f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107f38:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107f3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107f40:	5b                   	pop    %ebx
80107f41:	5e                   	pop    %esi
80107f42:	5f                   	pop    %edi
80107f43:	5d                   	pop    %ebp
80107f44:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107f45:	83 ec 0c             	sub    $0xc,%esp
80107f48:	68 28 8f 10 80       	push   $0x80108f28
80107f4d:	e8 8e 8d ff ff       	call   80100ce0 <panic>
80107f52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107f60 <allocuvm>:
{
80107f60:	55                   	push   %ebp
80107f61:	89 e5                	mov    %esp,%ebp
80107f63:	57                   	push   %edi
80107f64:	56                   	push   %esi
80107f65:	53                   	push   %ebx
80107f66:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107f69:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107f6c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107f6f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107f72:	85 c0                	test   %eax,%eax
80107f74:	0f 88 b6 00 00 00    	js     80108030 <allocuvm+0xd0>
  if(newsz < oldsz)
80107f7a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107f80:	0f 82 9a 00 00 00    	jb     80108020 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107f86:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107f8c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107f92:	39 75 10             	cmp    %esi,0x10(%ebp)
80107f95:	77 44                	ja     80107fdb <allocuvm+0x7b>
80107f97:	e9 87 00 00 00       	jmp    80108023 <allocuvm+0xc3>
80107f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107fa0:	83 ec 04             	sub    $0x4,%esp
80107fa3:	68 00 10 00 00       	push   $0x1000
80107fa8:	6a 00                	push   $0x0
80107faa:	50                   	push   %eax
80107fab:	e8 b0 d9 ff ff       	call   80105960 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107fb0:	58                   	pop    %eax
80107fb1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107fb7:	5a                   	pop    %edx
80107fb8:	6a 06                	push   $0x6
80107fba:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107fbf:	89 f2                	mov    %esi,%edx
80107fc1:	50                   	push   %eax
80107fc2:	89 f8                	mov    %edi,%eax
80107fc4:	e8 87 fb ff ff       	call   80107b50 <mappages>
80107fc9:	83 c4 10             	add    $0x10,%esp
80107fcc:	85 c0                	test   %eax,%eax
80107fce:	78 78                	js     80108048 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107fd0:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107fd6:	39 75 10             	cmp    %esi,0x10(%ebp)
80107fd9:	76 48                	jbe    80108023 <allocuvm+0xc3>
    mem = kalloc();
80107fdb:	e8 a0 b9 ff ff       	call   80103980 <kalloc>
80107fe0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107fe2:	85 c0                	test   %eax,%eax
80107fe4:	75 ba                	jne    80107fa0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107fe6:	83 ec 0c             	sub    $0xc,%esp
80107fe9:	68 a5 8e 10 80       	push   $0x80108ea5
80107fee:	e8 6d 8a ff ff       	call   80100a60 <cprintf>
  if(newsz >= oldsz)
80107ff3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ff6:	83 c4 10             	add    $0x10,%esp
80107ff9:	39 45 10             	cmp    %eax,0x10(%ebp)
80107ffc:	74 32                	je     80108030 <allocuvm+0xd0>
80107ffe:	8b 55 10             	mov    0x10(%ebp),%edx
80108001:	89 c1                	mov    %eax,%ecx
80108003:	89 f8                	mov    %edi,%eax
80108005:	e8 96 fa ff ff       	call   80107aa0 <deallocuvm.part.0>
      return 0;
8010800a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80108011:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108014:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108017:	5b                   	pop    %ebx
80108018:	5e                   	pop    %esi
80108019:	5f                   	pop    %edi
8010801a:	5d                   	pop    %ebp
8010801b:	c3                   	ret    
8010801c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108020:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80108023:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108026:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108029:	5b                   	pop    %ebx
8010802a:	5e                   	pop    %esi
8010802b:	5f                   	pop    %edi
8010802c:	5d                   	pop    %ebp
8010802d:	c3                   	ret    
8010802e:	66 90                	xchg   %ax,%ax
    return 0;
80108030:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80108037:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010803a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010803d:	5b                   	pop    %ebx
8010803e:	5e                   	pop    %esi
8010803f:	5f                   	pop    %edi
80108040:	5d                   	pop    %ebp
80108041:	c3                   	ret    
80108042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108048:	83 ec 0c             	sub    $0xc,%esp
8010804b:	68 bd 8e 10 80       	push   $0x80108ebd
80108050:	e8 0b 8a ff ff       	call   80100a60 <cprintf>
  if(newsz >= oldsz)
80108055:	8b 45 0c             	mov    0xc(%ebp),%eax
80108058:	83 c4 10             	add    $0x10,%esp
8010805b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010805e:	74 0c                	je     8010806c <allocuvm+0x10c>
80108060:	8b 55 10             	mov    0x10(%ebp),%edx
80108063:	89 c1                	mov    %eax,%ecx
80108065:	89 f8                	mov    %edi,%eax
80108067:	e8 34 fa ff ff       	call   80107aa0 <deallocuvm.part.0>
      kfree(mem);
8010806c:	83 ec 0c             	sub    $0xc,%esp
8010806f:	53                   	push   %ebx
80108070:	e8 4b b7 ff ff       	call   801037c0 <kfree>
      return 0;
80108075:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010807c:	83 c4 10             	add    $0x10,%esp
}
8010807f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108082:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108085:	5b                   	pop    %ebx
80108086:	5e                   	pop    %esi
80108087:	5f                   	pop    %edi
80108088:	5d                   	pop    %ebp
80108089:	c3                   	ret    
8010808a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108090 <deallocuvm>:
{
80108090:	55                   	push   %ebp
80108091:	89 e5                	mov    %esp,%ebp
80108093:	8b 55 0c             	mov    0xc(%ebp),%edx
80108096:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108099:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010809c:	39 d1                	cmp    %edx,%ecx
8010809e:	73 10                	jae    801080b0 <deallocuvm+0x20>
}
801080a0:	5d                   	pop    %ebp
801080a1:	e9 fa f9 ff ff       	jmp    80107aa0 <deallocuvm.part.0>
801080a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801080ad:	8d 76 00             	lea    0x0(%esi),%esi
801080b0:	89 d0                	mov    %edx,%eax
801080b2:	5d                   	pop    %ebp
801080b3:	c3                   	ret    
801080b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801080bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801080bf:	90                   	nop

801080c0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801080c0:	55                   	push   %ebp
801080c1:	89 e5                	mov    %esp,%ebp
801080c3:	57                   	push   %edi
801080c4:	56                   	push   %esi
801080c5:	53                   	push   %ebx
801080c6:	83 ec 0c             	sub    $0xc,%esp
801080c9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801080cc:	85 f6                	test   %esi,%esi
801080ce:	74 59                	je     80108129 <freevm+0x69>
  if(newsz >= oldsz)
801080d0:	31 c9                	xor    %ecx,%ecx
801080d2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801080d7:	89 f0                	mov    %esi,%eax
801080d9:	89 f3                	mov    %esi,%ebx
801080db:	e8 c0 f9 ff ff       	call   80107aa0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801080e0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801080e6:	eb 0f                	jmp    801080f7 <freevm+0x37>
801080e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801080ef:	90                   	nop
801080f0:	83 c3 04             	add    $0x4,%ebx
801080f3:	39 df                	cmp    %ebx,%edi
801080f5:	74 23                	je     8010811a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801080f7:	8b 03                	mov    (%ebx),%eax
801080f9:	a8 01                	test   $0x1,%al
801080fb:	74 f3                	je     801080f0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801080fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80108102:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108105:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108108:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010810d:	50                   	push   %eax
8010810e:	e8 ad b6 ff ff       	call   801037c0 <kfree>
80108113:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108116:	39 df                	cmp    %ebx,%edi
80108118:	75 dd                	jne    801080f7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010811a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010811d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108120:	5b                   	pop    %ebx
80108121:	5e                   	pop    %esi
80108122:	5f                   	pop    %edi
80108123:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108124:	e9 97 b6 ff ff       	jmp    801037c0 <kfree>
    panic("freevm: no pgdir");
80108129:	83 ec 0c             	sub    $0xc,%esp
8010812c:	68 d9 8e 10 80       	push   $0x80108ed9
80108131:	e8 aa 8b ff ff       	call   80100ce0 <panic>
80108136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010813d:	8d 76 00             	lea    0x0(%esi),%esi

80108140 <setupkvm>:
{
80108140:	55                   	push   %ebp
80108141:	89 e5                	mov    %esp,%ebp
80108143:	56                   	push   %esi
80108144:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80108145:	e8 36 b8 ff ff       	call   80103980 <kalloc>
8010814a:	89 c6                	mov    %eax,%esi
8010814c:	85 c0                	test   %eax,%eax
8010814e:	74 42                	je     80108192 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80108150:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108153:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80108158:	68 00 10 00 00       	push   $0x1000
8010815d:	6a 00                	push   $0x0
8010815f:	50                   	push   %eax
80108160:	e8 fb d7 ff ff       	call   80105960 <memset>
80108165:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108168:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010816b:	83 ec 08             	sub    $0x8,%esp
8010816e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108171:	ff 73 0c             	push   0xc(%ebx)
80108174:	8b 13                	mov    (%ebx),%edx
80108176:	50                   	push   %eax
80108177:	29 c1                	sub    %eax,%ecx
80108179:	89 f0                	mov    %esi,%eax
8010817b:	e8 d0 f9 ff ff       	call   80107b50 <mappages>
80108180:	83 c4 10             	add    $0x10,%esp
80108183:	85 c0                	test   %eax,%eax
80108185:	78 19                	js     801081a0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108187:	83 c3 10             	add    $0x10,%ebx
8010818a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80108190:	75 d6                	jne    80108168 <setupkvm+0x28>
}
80108192:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108195:	89 f0                	mov    %esi,%eax
80108197:	5b                   	pop    %ebx
80108198:	5e                   	pop    %esi
80108199:	5d                   	pop    %ebp
8010819a:	c3                   	ret    
8010819b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010819f:	90                   	nop
      freevm(pgdir);
801081a0:	83 ec 0c             	sub    $0xc,%esp
801081a3:	56                   	push   %esi
      return 0;
801081a4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801081a6:	e8 15 ff ff ff       	call   801080c0 <freevm>
      return 0;
801081ab:	83 c4 10             	add    $0x10,%esp
}
801081ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801081b1:	89 f0                	mov    %esi,%eax
801081b3:	5b                   	pop    %ebx
801081b4:	5e                   	pop    %esi
801081b5:	5d                   	pop    %ebp
801081b6:	c3                   	ret    
801081b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801081be:	66 90                	xchg   %ax,%ax

801081c0 <kvmalloc>:
{
801081c0:	55                   	push   %ebp
801081c1:	89 e5                	mov    %esp,%ebp
801081c3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801081c6:	e8 75 ff ff ff       	call   80108140 <setupkvm>
801081cb:	a3 64 55 11 80       	mov    %eax,0x80115564
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801081d0:	05 00 00 00 80       	add    $0x80000000,%eax
801081d5:	0f 22 d8             	mov    %eax,%cr3
}
801081d8:	c9                   	leave  
801081d9:	c3                   	ret    
801081da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801081e0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801081e0:	55                   	push   %ebp
801081e1:	89 e5                	mov    %esp,%ebp
801081e3:	83 ec 08             	sub    $0x8,%esp
801081e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801081e9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801081ec:	89 c1                	mov    %eax,%ecx
801081ee:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801081f1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801081f4:	f6 c2 01             	test   $0x1,%dl
801081f7:	75 17                	jne    80108210 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801081f9:	83 ec 0c             	sub    $0xc,%esp
801081fc:	68 ea 8e 10 80       	push   $0x80108eea
80108201:	e8 da 8a ff ff       	call   80100ce0 <panic>
80108206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010820d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108210:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108213:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80108219:	25 fc 0f 00 00       	and    $0xffc,%eax
8010821e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80108225:	85 c0                	test   %eax,%eax
80108227:	74 d0                	je     801081f9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80108229:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010822c:	c9                   	leave  
8010822d:	c3                   	ret    
8010822e:	66 90                	xchg   %ax,%ax

80108230 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108230:	55                   	push   %ebp
80108231:	89 e5                	mov    %esp,%ebp
80108233:	57                   	push   %edi
80108234:	56                   	push   %esi
80108235:	53                   	push   %ebx
80108236:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108239:	e8 02 ff ff ff       	call   80108140 <setupkvm>
8010823e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108241:	85 c0                	test   %eax,%eax
80108243:	0f 84 bd 00 00 00    	je     80108306 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108249:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010824c:	85 c9                	test   %ecx,%ecx
8010824e:	0f 84 b2 00 00 00    	je     80108306 <copyuvm+0xd6>
80108254:	31 f6                	xor    %esi,%esi
80108256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010825d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80108260:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80108263:	89 f0                	mov    %esi,%eax
80108265:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80108268:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010826b:	a8 01                	test   $0x1,%al
8010826d:	75 11                	jne    80108280 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010826f:	83 ec 0c             	sub    $0xc,%esp
80108272:	68 f4 8e 10 80       	push   $0x80108ef4
80108277:	e8 64 8a ff ff       	call   80100ce0 <panic>
8010827c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80108280:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108282:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108287:	c1 ea 0a             	shr    $0xa,%edx
8010828a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108290:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108297:	85 c0                	test   %eax,%eax
80108299:	74 d4                	je     8010826f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010829b:	8b 00                	mov    (%eax),%eax
8010829d:	a8 01                	test   $0x1,%al
8010829f:	0f 84 9f 00 00 00    	je     80108344 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801082a5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801082a7:	25 ff 0f 00 00       	and    $0xfff,%eax
801082ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801082af:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801082b5:	e8 c6 b6 ff ff       	call   80103980 <kalloc>
801082ba:	89 c3                	mov    %eax,%ebx
801082bc:	85 c0                	test   %eax,%eax
801082be:	74 64                	je     80108324 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801082c0:	83 ec 04             	sub    $0x4,%esp
801082c3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801082c9:	68 00 10 00 00       	push   $0x1000
801082ce:	57                   	push   %edi
801082cf:	50                   	push   %eax
801082d0:	e8 2b d7 ff ff       	call   80105a00 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801082d5:	58                   	pop    %eax
801082d6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801082dc:	5a                   	pop    %edx
801082dd:	ff 75 e4             	push   -0x1c(%ebp)
801082e0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801082e5:	89 f2                	mov    %esi,%edx
801082e7:	50                   	push   %eax
801082e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801082eb:	e8 60 f8 ff ff       	call   80107b50 <mappages>
801082f0:	83 c4 10             	add    $0x10,%esp
801082f3:	85 c0                	test   %eax,%eax
801082f5:	78 21                	js     80108318 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801082f7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801082fd:	39 75 0c             	cmp    %esi,0xc(%ebp)
80108300:	0f 87 5a ff ff ff    	ja     80108260 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80108306:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108309:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010830c:	5b                   	pop    %ebx
8010830d:	5e                   	pop    %esi
8010830e:	5f                   	pop    %edi
8010830f:	5d                   	pop    %ebp
80108310:	c3                   	ret    
80108311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80108318:	83 ec 0c             	sub    $0xc,%esp
8010831b:	53                   	push   %ebx
8010831c:	e8 9f b4 ff ff       	call   801037c0 <kfree>
      goto bad;
80108321:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80108324:	83 ec 0c             	sub    $0xc,%esp
80108327:	ff 75 e0             	push   -0x20(%ebp)
8010832a:	e8 91 fd ff ff       	call   801080c0 <freevm>
  return 0;
8010832f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80108336:	83 c4 10             	add    $0x10,%esp
}
80108339:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010833c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010833f:	5b                   	pop    %ebx
80108340:	5e                   	pop    %esi
80108341:	5f                   	pop    %edi
80108342:	5d                   	pop    %ebp
80108343:	c3                   	ret    
      panic("copyuvm: page not present");
80108344:	83 ec 0c             	sub    $0xc,%esp
80108347:	68 0e 8f 10 80       	push   $0x80108f0e
8010834c:	e8 8f 89 ff ff       	call   80100ce0 <panic>
80108351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010835f:	90                   	nop

80108360 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108360:	55                   	push   %ebp
80108361:	89 e5                	mov    %esp,%ebp
80108363:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108366:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80108369:	89 c1                	mov    %eax,%ecx
8010836b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010836e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80108371:	f6 c2 01             	test   $0x1,%dl
80108374:	0f 84 00 01 00 00    	je     8010847a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010837a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010837d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80108383:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80108384:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80108389:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80108390:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108392:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80108397:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010839a:	05 00 00 00 80       	add    $0x80000000,%eax
8010839f:	83 fa 05             	cmp    $0x5,%edx
801083a2:	ba 00 00 00 00       	mov    $0x0,%edx
801083a7:	0f 45 c2             	cmovne %edx,%eax
}
801083aa:	c3                   	ret    
801083ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801083af:	90                   	nop

801083b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801083b0:	55                   	push   %ebp
801083b1:	89 e5                	mov    %esp,%ebp
801083b3:	57                   	push   %edi
801083b4:	56                   	push   %esi
801083b5:	53                   	push   %ebx
801083b6:	83 ec 0c             	sub    $0xc,%esp
801083b9:	8b 75 14             	mov    0x14(%ebp),%esi
801083bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801083bf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801083c2:	85 f6                	test   %esi,%esi
801083c4:	75 51                	jne    80108417 <copyout+0x67>
801083c6:	e9 a5 00 00 00       	jmp    80108470 <copyout+0xc0>
801083cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801083cf:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801083d0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801083d6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801083dc:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801083e2:	74 75                	je     80108459 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
801083e4:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801083e6:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
801083e9:	29 c3                	sub    %eax,%ebx
801083eb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801083f1:	39 f3                	cmp    %esi,%ebx
801083f3:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
801083f6:	29 f8                	sub    %edi,%eax
801083f8:	83 ec 04             	sub    $0x4,%esp
801083fb:	01 c1                	add    %eax,%ecx
801083fd:	53                   	push   %ebx
801083fe:	52                   	push   %edx
801083ff:	51                   	push   %ecx
80108400:	e8 fb d5 ff ff       	call   80105a00 <memmove>
    len -= n;
    buf += n;
80108405:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80108408:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010840e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80108411:	01 da                	add    %ebx,%edx
  while(len > 0){
80108413:	29 de                	sub    %ebx,%esi
80108415:	74 59                	je     80108470 <copyout+0xc0>
  if(*pde & PTE_P){
80108417:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010841a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010841c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010841e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80108421:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80108427:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010842a:	f6 c1 01             	test   $0x1,%cl
8010842d:	0f 84 4e 00 00 00    	je     80108481 <copyout.cold>
  return &pgtab[PTX(va)];
80108433:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108435:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010843b:	c1 eb 0c             	shr    $0xc,%ebx
8010843e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80108444:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010844b:	89 d9                	mov    %ebx,%ecx
8010844d:	83 e1 05             	and    $0x5,%ecx
80108450:	83 f9 05             	cmp    $0x5,%ecx
80108453:	0f 84 77 ff ff ff    	je     801083d0 <copyout+0x20>
  }
  return 0;
}
80108459:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010845c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108461:	5b                   	pop    %ebx
80108462:	5e                   	pop    %esi
80108463:	5f                   	pop    %edi
80108464:	5d                   	pop    %ebp
80108465:	c3                   	ret    
80108466:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010846d:	8d 76 00             	lea    0x0(%esi),%esi
80108470:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108473:	31 c0                	xor    %eax,%eax
}
80108475:	5b                   	pop    %ebx
80108476:	5e                   	pop    %esi
80108477:	5f                   	pop    %edi
80108478:	5d                   	pop    %ebp
80108479:	c3                   	ret    

8010847a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010847a:	a1 00 00 00 00       	mov    0x0,%eax
8010847f:	0f 0b                	ud2    

80108481 <copyout.cold>:
80108481:	a1 00 00 00 00       	mov    0x0,%eax
80108486:	0f 0b                	ud2    
