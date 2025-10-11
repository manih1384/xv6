
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
80100028:	bc d0 64 11 80       	mov    $0x801164d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 60 3b 10 80       	mov    $0x80103b60,%eax
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
8010004c:	68 a0 7c 10 80       	push   $0x80107ca0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 85 4e 00 00       	call   80104ee0 <initlock>
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
80100092:	68 a7 7c 10 80       	push   $0x80107ca7
80100097:	50                   	push   %eax
80100098:	e8 13 4d 00 00       	call   80104db0 <initsleeplock>
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
801000e4:	e8 e7 4f 00 00       	call   801050d0 <acquire>
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
80100162:	e8 09 4f 00 00       	call   80105070 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 7e 4c 00 00       	call   80104df0 <acquiresleep>
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
8010018c:	e8 6f 2c 00 00       	call   80102e00 <iderw>
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
801001a1:	68 ae 7c 10 80       	push   $0x80107cae
801001a6:	e8 65 09 00 00       	call   80100b10 <panic>
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
801001be:	e8 cd 4c 00 00       	call   80104e90 <holdingsleep>
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
801001d4:	e9 27 2c 00 00       	jmp    80102e00 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 bf 7c 10 80       	push   $0x80107cbf
801001e1:	e8 2a 09 00 00       	call   80100b10 <panic>
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
801001ff:	e8 8c 4c 00 00       	call   80104e90 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 3c 4c 00 00       	call   80104e50 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 b0 4e 00 00       	call   801050d0 <acquire>
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
80100269:	e9 02 4e 00 00       	jmp    80105070 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 c6 7c 10 80       	push   $0x80107cc6
80100276:	e8 95 08 00 00       	call   80100b10 <panic>
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
80100294:	e8 17 21 00 00       	call   801023b0 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 2b 4e 00 00       	call   801050d0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
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
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 7e 48 00 00       	call   80104b50 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 a9 41 00 00       	call   80104490 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 75 4d 00 00       	call   80105070 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 cc 1f 00 00       	call   801022d0 <ilock>
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
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 1f 4d 00 00       	call   80105070 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 76 1f 00 00       	call   801022d0 <ilock>
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
80100374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037b:	00 
8010037c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

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
8010051c:	a1 0c ff 10 80       	mov    0x8010ff0c,%eax
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
801005a0:	03 1d 0c ff 10 80    	add    0x8010ff0c,%ebx
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
801005c0:	8b 0d 0c ff 10 80    	mov    0x8010ff0c,%ecx
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
801005ed:	8b 0d 0c ff 10 80    	mov    0x8010ff0c,%ecx
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
8010068a:	e8 d1 4b 00 00       	call   80105260 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010068f:	b8 80 07 00 00       	mov    $0x780,%eax
80100694:	83 c4 0c             	add    $0xc,%esp
80100697:	29 d8                	sub    %ebx,%eax
80100699:	01 c0                	add    %eax,%eax
8010069b:	50                   	push   %eax
8010069c:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
801006a3:	6a 00                	push   $0x0
801006a5:	50                   	push   %eax
801006a6:	e8 25 4b 00 00       	call   801051d0 <memset>
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
801006f3:	8b 15 0c ff 10 80    	mov    0x8010ff0c,%edx
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
8010071d:	8b 15 0c ff 10 80    	mov    0x8010ff0c,%edx
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
8010076c:	89 15 0c ff 10 80    	mov    %edx,0x8010ff0c
80100772:	e9 e0 fd ff ff       	jmp    80100557 <cgaputc+0xd7>
80100777:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010077e:	00 
8010077f:	90                   	nop
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
80100780:	8b 15 0c ff 10 80    	mov    0x8010ff0c,%edx
80100786:	8d 04 16             	lea    (%esi,%edx,1),%eax
80100789:	39 c1                	cmp    %eax,%ecx
8010078b:	0f 8c 74 ff ff ff    	jl     80100705 <cgaputc+0x285>
80100791:	eb c9                	jmp    8010075c <cgaputc+0x2dc>
    panic("pos under/overflow");
80100793:	83 ec 0c             	sub    $0xc,%esp
80100796:	68 cd 7c 10 80       	push   $0x80107ccd
8010079b:	e8 70 03 00 00       	call   80100b10 <panic>

801007a0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801007a0:	55                   	push   %ebp
801007a1:	89 e5                	mov    %esp,%ebp
801007a3:	57                   	push   %edi
801007a4:	56                   	push   %esi
801007a5:	53                   	push   %ebx
801007a6:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
801007a9:	ff 75 08             	push   0x8(%ebp)
801007ac:	e8 ff 1b 00 00       	call   801023b0 <iunlock>
  acquire(&cons.lock);
801007b1:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801007b8:	e8 13 49 00 00       	call   801050d0 <acquire>
  for(i = 0; i < n; i++)
801007bd:	8b 4d 10             	mov    0x10(%ebp),%ecx
801007c0:	83 c4 10             	add    $0x10,%esp
801007c3:	85 c9                	test   %ecx,%ecx
801007c5:	7e 36                	jle    801007fd <consolewrite+0x5d>
801007c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801007ca:	8b 7d 10             	mov    0x10(%ebp),%edi
801007cd:	01 df                	add    %ebx,%edi
  if(panicked){
801007cf:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i] & 0xff);
801007d5:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801007d8:	85 d2                	test   %edx,%edx
801007da:	74 04                	je     801007e0 <consolewrite+0x40>
}

static inline void
cli(void)
{
  asm volatile("cli");
801007dc:	fa                   	cli
    for(;;)
801007dd:	eb fe                	jmp    801007dd <consolewrite+0x3d>
801007df:	90                   	nop
    uartputc(c);
801007e0:	83 ec 0c             	sub    $0xc,%esp
    consputc(buf[i] & 0xff);
801007e3:	0f b6 f0             	movzbl %al,%esi
  for(i = 0; i < n; i++)
801007e6:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
801007e9:	56                   	push   %esi
801007ea:	e8 f1 5f 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
801007ef:	89 f0                	mov    %esi,%eax
801007f1:	e8 8a fc ff ff       	call   80100480 <cgaputc>
  for(i = 0; i < n; i++)
801007f6:	83 c4 10             	add    $0x10,%esp
801007f9:	39 fb                	cmp    %edi,%ebx
801007fb:	75 d2                	jne    801007cf <consolewrite+0x2f>
  release(&cons.lock);
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 20 ff 10 80       	push   $0x8010ff20
80100805:	e8 66 48 00 00       	call   80105070 <release>
  ilock(ip);
8010080a:	58                   	pop    %eax
8010080b:	ff 75 08             	push   0x8(%ebp)
8010080e:	e8 bd 1a 00 00       	call   801022d0 <ilock>

  return n;
}
80100813:	8b 45 10             	mov    0x10(%ebp),%eax
80100816:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100819:	5b                   	pop    %ebx
8010081a:	5e                   	pop    %esi
8010081b:	5f                   	pop    %edi
8010081c:	5d                   	pop    %ebp
8010081d:	c3                   	ret
8010081e:	66 90                	xchg   %ax,%ax

80100820 <printint>:
{
80100820:	55                   	push   %ebp
80100821:	89 e5                	mov    %esp,%ebp
80100823:	57                   	push   %edi
80100824:	56                   	push   %esi
80100825:	53                   	push   %ebx
80100826:	89 d3                	mov    %edx,%ebx
80100828:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010082b:	85 c0                	test   %eax,%eax
8010082d:	79 05                	jns    80100834 <printint+0x14>
8010082f:	83 e1 01             	and    $0x1,%ecx
80100832:	75 6a                	jne    8010089e <printint+0x7e>
    x = xx;
80100834:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010083b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010083d:	31 f6                	xor    %esi,%esi
8010083f:	90                   	nop
    buf[i++] = digits[x % base];
80100840:	89 c8                	mov    %ecx,%eax
80100842:	31 d2                	xor    %edx,%edx
80100844:	89 f7                	mov    %esi,%edi
80100846:	f7 f3                	div    %ebx
80100848:	8d 76 01             	lea    0x1(%esi),%esi
8010084b:	0f b6 92 10 82 10 80 	movzbl -0x7fef7df0(%edx),%edx
80100852:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100856:	89 ca                	mov    %ecx,%edx
80100858:	89 c1                	mov    %eax,%ecx
8010085a:	39 da                	cmp    %ebx,%edx
8010085c:	73 e2                	jae    80100840 <printint+0x20>
  if(sign)
8010085e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100861:	85 d2                	test   %edx,%edx
80100863:	74 07                	je     8010086c <printint+0x4c>
    buf[i++] = '-';
80100865:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010086a:	89 f7                	mov    %esi,%edi
8010086c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010086f:	01 f7                	add    %esi,%edi
  if(panicked){
80100871:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
    consputc(buf[i]);
80100876:	0f be 1f             	movsbl (%edi),%ebx
  if(panicked){
80100879:	85 c0                	test   %eax,%eax
8010087b:	74 03                	je     80100880 <printint+0x60>
8010087d:	fa                   	cli
    for(;;)
8010087e:	eb fe                	jmp    8010087e <printint+0x5e>
    uartputc(c);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	53                   	push   %ebx
80100884:	e8 57 5f 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
80100889:	89 d8                	mov    %ebx,%eax
8010088b:	e8 f0 fb ff ff       	call   80100480 <cgaputc>
  while(--i >= 0)
80100890:	8d 47 ff             	lea    -0x1(%edi),%eax
80100893:	83 c4 10             	add    $0x10,%esp
80100896:	39 f7                	cmp    %esi,%edi
80100898:	74 11                	je     801008ab <printint+0x8b>
8010089a:	89 c7                	mov    %eax,%edi
8010089c:	eb d3                	jmp    80100871 <printint+0x51>
    x = -xx;
8010089e:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
801008a0:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801008a7:	89 c1                	mov    %eax,%ecx
801008a9:	eb 92                	jmp    8010083d <printint+0x1d>
}
801008ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801008ae:	5b                   	pop    %ebx
801008af:	5e                   	pop    %esi
801008b0:	5f                   	pop    %edi
801008b1:	5d                   	pop    %ebp
801008b2:	c3                   	ret
801008b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801008ba:	00 
801008bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801008c0 <cprintf>:
{
801008c0:	55                   	push   %ebp
801008c1:	89 e5                	mov    %esp,%ebp
801008c3:	57                   	push   %edi
801008c4:	56                   	push   %esi
801008c5:	53                   	push   %ebx
801008c6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801008c9:	8b 3d 54 ff 10 80    	mov    0x8010ff54,%edi
  if (fmt == 0)
801008cf:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801008d2:	85 ff                	test   %edi,%edi
801008d4:	0f 85 36 01 00 00    	jne    80100a10 <cprintf+0x150>
  if (fmt == 0)
801008da:	85 f6                	test   %esi,%esi
801008dc:	0f 84 1c 02 00 00    	je     80100afe <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008e2:	0f b6 06             	movzbl (%esi),%eax
801008e5:	85 c0                	test   %eax,%eax
801008e7:	74 67                	je     80100950 <cprintf+0x90>
  argp = (uint*)(void*)(&fmt + 1);
801008e9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008ec:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801008ef:	31 db                	xor    %ebx,%ebx
801008f1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801008f3:	83 f8 25             	cmp    $0x25,%eax
801008f6:	75 68                	jne    80100960 <cprintf+0xa0>
    c = fmt[++i] & 0xff;
801008f8:	83 c3 01             	add    $0x1,%ebx
801008fb:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801008ff:	85 c9                	test   %ecx,%ecx
80100901:	74 42                	je     80100945 <cprintf+0x85>
    switch(c){
80100903:	83 f9 70             	cmp    $0x70,%ecx
80100906:	0f 84 e4 00 00 00    	je     801009f0 <cprintf+0x130>
8010090c:	0f 8f 8e 00 00 00    	jg     801009a0 <cprintf+0xe0>
80100912:	83 f9 25             	cmp    $0x25,%ecx
80100915:	74 72                	je     80100989 <cprintf+0xc9>
80100917:	83 f9 64             	cmp    $0x64,%ecx
8010091a:	0f 85 8e 00 00 00    	jne    801009ae <cprintf+0xee>
      printint(*argp++, 10, 1);
80100920:	8d 47 04             	lea    0x4(%edi),%eax
80100923:	b9 01 00 00 00       	mov    $0x1,%ecx
80100928:	ba 0a 00 00 00       	mov    $0xa,%edx
8010092d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100930:	8b 07                	mov    (%edi),%eax
80100932:	e8 e9 fe ff ff       	call   80100820 <printint>
80100937:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010093a:	83 c3 01             	add    $0x1,%ebx
8010093d:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100941:	85 c0                	test   %eax,%eax
80100943:	75 ae                	jne    801008f3 <cprintf+0x33>
80100945:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
80100948:	85 ff                	test   %edi,%edi
8010094a:	0f 85 e3 00 00 00    	jne    80100a33 <cprintf+0x173>
}
80100950:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100953:	5b                   	pop    %ebx
80100954:	5e                   	pop    %esi
80100955:	5f                   	pop    %edi
80100956:	5d                   	pop    %ebp
80100957:	c3                   	ret
80100958:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010095f:	00 
  if(panicked){
80100960:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100966:	85 d2                	test   %edx,%edx
80100968:	74 06                	je     80100970 <cprintf+0xb0>
8010096a:	fa                   	cli
    for(;;)
8010096b:	eb fe                	jmp    8010096b <cprintf+0xab>
8010096d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100970:	83 ec 0c             	sub    $0xc,%esp
80100973:	50                   	push   %eax
80100974:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100977:	e8 64 5e 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
8010097c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010097f:	e8 fc fa ff ff       	call   80100480 <cgaputc>
      continue;
80100984:	83 c4 10             	add    $0x10,%esp
80100987:	eb b1                	jmp    8010093a <cprintf+0x7a>
  if(panicked){
80100989:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
8010098f:	85 c9                	test   %ecx,%ecx
80100991:	0f 84 f9 00 00 00    	je     80100a90 <cprintf+0x1d0>
80100997:	fa                   	cli
    for(;;)
80100998:	eb fe                	jmp    80100998 <cprintf+0xd8>
8010099a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
801009a0:	83 f9 73             	cmp    $0x73,%ecx
801009a3:	0f 84 9f 00 00 00    	je     80100a48 <cprintf+0x188>
801009a9:	83 f9 78             	cmp    $0x78,%ecx
801009ac:	74 42                	je     801009f0 <cprintf+0x130>
  if(panicked){
801009ae:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
801009b4:	85 d2                	test   %edx,%edx
801009b6:	0f 85 d0 00 00 00    	jne    80100a8c <cprintf+0x1cc>
    uartputc(c);
801009bc:	83 ec 0c             	sub    $0xc,%esp
801009bf:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801009c2:	6a 25                	push   $0x25
801009c4:	e8 17 5e 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
801009c9:	b8 25 00 00 00       	mov    $0x25,%eax
801009ce:	e8 ad fa ff ff       	call   80100480 <cgaputc>
  if(panicked){
801009d3:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801009d8:	83 c4 10             	add    $0x10,%esp
801009db:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801009de:	85 c0                	test   %eax,%eax
801009e0:	0f 84 f5 00 00 00    	je     80100adb <cprintf+0x21b>
801009e6:	fa                   	cli
    for(;;)
801009e7:	eb fe                	jmp    801009e7 <cprintf+0x127>
801009e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801009f0:	8d 47 04             	lea    0x4(%edi),%eax
801009f3:	31 c9                	xor    %ecx,%ecx
801009f5:	ba 10 00 00 00       	mov    $0x10,%edx
801009fa:	89 45 e0             	mov    %eax,-0x20(%ebp)
801009fd:	8b 07                	mov    (%edi),%eax
801009ff:	e8 1c fe ff ff       	call   80100820 <printint>
80100a04:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100a07:	e9 2e ff ff ff       	jmp    8010093a <cprintf+0x7a>
80100a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
80100a10:	83 ec 0c             	sub    $0xc,%esp
80100a13:	68 20 ff 10 80       	push   $0x8010ff20
80100a18:	e8 b3 46 00 00       	call   801050d0 <acquire>
  if (fmt == 0)
80100a1d:	83 c4 10             	add    $0x10,%esp
80100a20:	85 f6                	test   %esi,%esi
80100a22:	0f 84 d6 00 00 00    	je     80100afe <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100a28:	0f b6 06             	movzbl (%esi),%eax
80100a2b:	85 c0                	test   %eax,%eax
80100a2d:	0f 85 b6 fe ff ff    	jne    801008e9 <cprintf+0x29>
    release(&cons.lock);
80100a33:	83 ec 0c             	sub    $0xc,%esp
80100a36:	68 20 ff 10 80       	push   $0x8010ff20
80100a3b:	e8 30 46 00 00       	call   80105070 <release>
80100a40:	83 c4 10             	add    $0x10,%esp
80100a43:	e9 08 ff ff ff       	jmp    80100950 <cprintf+0x90>
      if((s = (char*)*argp++) == 0)
80100a48:	8b 17                	mov    (%edi),%edx
80100a4a:	8d 47 04             	lea    0x4(%edi),%eax
80100a4d:	85 d2                	test   %edx,%edx
80100a4f:	74 2f                	je     80100a80 <cprintf+0x1c0>
      for(; *s; s++)
80100a51:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100a54:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100a56:	84 c9                	test   %cl,%cl
80100a58:	0f 84 99 00 00 00    	je     80100af7 <cprintf+0x237>
80100a5e:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100a61:	89 fb                	mov    %edi,%ebx
80100a63:	89 f7                	mov    %esi,%edi
80100a65:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100a68:	89 c8                	mov    %ecx,%eax
  if(panicked){
80100a6a:	8b 35 58 ff 10 80    	mov    0x8010ff58,%esi
80100a70:	85 f6                	test   %esi,%esi
80100a72:	74 38                	je     80100aac <cprintf+0x1ec>
80100a74:	fa                   	cli
    for(;;)
80100a75:	eb fe                	jmp    80100a75 <cprintf+0x1b5>
80100a77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a7e:	00 
80100a7f:	90                   	nop
80100a80:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
80100a85:	bf e0 7c 10 80       	mov    $0x80107ce0,%edi
80100a8a:	eb d2                	jmp    80100a5e <cprintf+0x19e>
80100a8c:	fa                   	cli
    for(;;)
80100a8d:	eb fe                	jmp    80100a8d <cprintf+0x1cd>
80100a8f:	90                   	nop
    uartputc(c);
80100a90:	83 ec 0c             	sub    $0xc,%esp
80100a93:	6a 25                	push   $0x25
80100a95:	e8 46 5d 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
80100a9a:	b8 25 00 00 00       	mov    $0x25,%eax
80100a9f:	e8 dc f9 ff ff       	call   80100480 <cgaputc>
}
80100aa4:	83 c4 10             	add    $0x10,%esp
80100aa7:	e9 8e fe ff ff       	jmp    8010093a <cprintf+0x7a>
    uartputc(c);
80100aac:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
80100aaf:	0f be f0             	movsbl %al,%esi
      for(; *s; s++)
80100ab2:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100ab5:	56                   	push   %esi
80100ab6:	e8 25 5d 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
80100abb:	89 f0                	mov    %esi,%eax
80100abd:	e8 be f9 ff ff       	call   80100480 <cgaputc>
      for(; *s; s++)
80100ac2:	0f b6 03             	movzbl (%ebx),%eax
80100ac5:	83 c4 10             	add    $0x10,%esp
80100ac8:	84 c0                	test   %al,%al
80100aca:	75 9e                	jne    80100a6a <cprintf+0x1aa>
      if((s = (char*)*argp++) == 0)
80100acc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100acf:	89 fe                	mov    %edi,%esi
80100ad1:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100ad4:	89 c7                	mov    %eax,%edi
80100ad6:	e9 5f fe ff ff       	jmp    8010093a <cprintf+0x7a>
    uartputc(c);
80100adb:	83 ec 0c             	sub    $0xc,%esp
80100ade:	51                   	push   %ecx
80100adf:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100ae2:	e8 f9 5c 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
80100ae7:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100aea:	e8 91 f9 ff ff       	call   80100480 <cgaputc>
}
80100aef:	83 c4 10             	add    $0x10,%esp
80100af2:	e9 43 fe ff ff       	jmp    8010093a <cprintf+0x7a>
      if((s = (char*)*argp++) == 0)
80100af7:	89 c7                	mov    %eax,%edi
80100af9:	e9 3c fe ff ff       	jmp    8010093a <cprintf+0x7a>
    panic("null fmt");
80100afe:	83 ec 0c             	sub    $0xc,%esp
80100b01:	68 e7 7c 10 80       	push   $0x80107ce7
80100b06:	e8 05 00 00 00       	call   80100b10 <panic>
80100b0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100b10 <panic>:
{
80100b10:	55                   	push   %ebp
80100b11:	89 e5                	mov    %esp,%ebp
80100b13:	56                   	push   %esi
80100b14:	53                   	push   %ebx
80100b15:	83 ec 30             	sub    $0x30,%esp
80100b18:	fa                   	cli
  cons.locking = 0;
80100b19:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100b20:	00 00 00 
  getcallerpcs(&s, pcs);
80100b23:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100b26:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100b29:	e8 d2 28 00 00       	call   80103400 <lapicid>
80100b2e:	83 ec 08             	sub    $0x8,%esp
80100b31:	50                   	push   %eax
80100b32:	68 f0 7c 10 80       	push   $0x80107cf0
80100b37:	e8 84 fd ff ff       	call   801008c0 <cprintf>
  cprintf(s);
80100b3c:	58                   	pop    %eax
80100b3d:	ff 75 08             	push   0x8(%ebp)
80100b40:	e8 7b fd ff ff       	call   801008c0 <cprintf>
  cprintf("\n");
80100b45:	c7 04 24 51 81 10 80 	movl   $0x80108151,(%esp)
80100b4c:	e8 6f fd ff ff       	call   801008c0 <cprintf>
  getcallerpcs(&s, pcs);
80100b51:	8d 45 08             	lea    0x8(%ebp),%eax
80100b54:	5a                   	pop    %edx
80100b55:	59                   	pop    %ecx
80100b56:	53                   	push   %ebx
80100b57:	50                   	push   %eax
80100b58:	e8 a3 43 00 00       	call   80104f00 <getcallerpcs>
  for(i=0; i<10; i++)
80100b5d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100b60:	83 ec 08             	sub    $0x8,%esp
80100b63:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100b65:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100b68:	68 04 7d 10 80       	push   $0x80107d04
80100b6d:	e8 4e fd ff ff       	call   801008c0 <cprintf>
  for(i=0; i<10; i++)
80100b72:	83 c4 10             	add    $0x10,%esp
80100b75:	39 f3                	cmp    %esi,%ebx
80100b77:	75 e7                	jne    80100b60 <panic+0x50>
  panicked = 1; // freeze other CPU
80100b79:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
80100b80:	00 00 00 
  for(;;)
80100b83:	eb fe                	jmp    80100b83 <panic+0x73>
80100b85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100b8c:	00 
80100b8d:	8d 76 00             	lea    0x0(%esi),%esi

80100b90 <append_sequence>:
    if (input_sequence.size >= input_sequence.cap) {
80100b90:	a1 00 92 10 80       	mov    0x80109200,%eax
80100b95:	3b 05 04 92 10 80    	cmp    0x80109204,%eax
80100b9b:	7d 1b                	jge    80100bb8 <append_sequence+0x28>
void append_sequence(int value) {
80100b9d:	55                   	push   %ebp
    input_sequence.data[input_sequence.size++] = value;
80100b9e:	8d 50 01             	lea    0x1(%eax),%edx
80100ba1:	89 15 00 92 10 80    	mov    %edx,0x80109200
void append_sequence(int value) {
80100ba7:	89 e5                	mov    %esp,%ebp
    input_sequence.data[input_sequence.size++] = value;
80100ba9:	8b 55 08             	mov    0x8(%ebp),%edx
}
80100bac:	5d                   	pop    %ebp
    input_sequence.data[input_sequence.size++] = value;
80100bad:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
}
80100bb4:	c3                   	ret
80100bb5:	8d 76 00             	lea    0x0(%esi),%esi
80100bb8:	c3                   	ret
80100bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100bc0 <delete_from_sequence>:
void delete_from_sequence(int value) {
80100bc0:	55                   	push   %ebp
    for (int i = 0; i < input_sequence.size; i++) {
80100bc1:	8b 15 00 92 10 80    	mov    0x80109200,%edx
void delete_from_sequence(int value) {
80100bc7:	89 e5                	mov    %esp,%ebp
80100bc9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    for (int i = 0; i < input_sequence.size; i++) {
80100bcc:	85 d2                	test   %edx,%edx
80100bce:	7e 3b                	jle    80100c0b <delete_from_sequence+0x4b>
80100bd0:	31 c0                	xor    %eax,%eax
80100bd2:	eb 0b                	jmp    80100bdf <delete_from_sequence+0x1f>
80100bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100bd8:	83 c0 01             	add    $0x1,%eax
80100bdb:	39 d0                	cmp    %edx,%eax
80100bdd:	74 2c                	je     80100c0b <delete_from_sequence+0x4b>
        if (input_sequence.data[i] == value) {
80100bdf:	39 0c 85 00 90 10 80 	cmp    %ecx,-0x7fef7000(,%eax,4)
80100be6:	75 f0                	jne    80100bd8 <delete_from_sequence+0x18>
    for (int i = idx; i < input_sequence.size - 1; i++)
80100be8:	83 ea 01             	sub    $0x1,%edx
80100beb:	39 c2                	cmp    %eax,%edx
80100bed:	7e 16                	jle    80100c05 <delete_from_sequence+0x45>
80100bef:	90                   	nop
        input_sequence.data[i] = input_sequence.data[i + 1];
80100bf0:	83 c0 01             	add    $0x1,%eax
80100bf3:	8b 0c 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%ecx
80100bfa:	89 0c 85 fc 8f 10 80 	mov    %ecx,-0x7fef7004(,%eax,4)
    for (int i = idx; i < input_sequence.size - 1; i++)
80100c01:	39 d0                	cmp    %edx,%eax
80100c03:	75 eb                	jne    80100bf0 <delete_from_sequence+0x30>
    input_sequence.size--;
80100c05:	89 15 00 92 10 80    	mov    %edx,0x80109200
}
80100c0b:	5d                   	pop    %ebp
80100c0c:	c3                   	ret
80100c0d:	8d 76 00             	lea    0x0(%esi),%esi

80100c10 <last_sequence>:
    if (input_sequence.size == 0) return -1;
80100c10:	a1 00 92 10 80       	mov    0x80109200,%eax
80100c15:	85 c0                	test   %eax,%eax
80100c17:	74 0f                	je     80100c28 <last_sequence+0x18>
    return input_sequence.data[input_sequence.size - 1];
80100c19:	8b 04 85 fc 8f 10 80 	mov    -0x7fef7004(,%eax,4),%eax
80100c20:	c3                   	ret
80100c21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (input_sequence.size == 0) return -1;
80100c28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c2d:	c3                   	ret
80100c2e:	66 90                	xchg   %ax,%ax

80100c30 <clear_sequence>:
    input_sequence.size = 0;
80100c30:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80100c37:	00 00 00 
}
80100c3a:	c3                   	ret
80100c3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100c40 <print_array>:
void print_array(char *buffer){
80100c40:	55                   	push   %ebp
      for (int i = 0; i < input.e; i++)
80100c41:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
void print_array(char *buffer){
80100c46:	89 e5                	mov    %esp,%ebp
80100c48:	56                   	push   %esi
80100c49:	8b 75 08             	mov    0x8(%ebp),%esi
80100c4c:	53                   	push   %ebx
      for (int i = 0; i < input.e; i++)
80100c4d:	85 c0                	test   %eax,%eax
80100c4f:	74 1b                	je     80100c6c <print_array+0x2c>
80100c51:	31 db                	xor    %ebx,%ebx
80100c53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      cgaputc(buffer[i]);
80100c58:	0f be 04 1e          	movsbl (%esi,%ebx,1),%eax
      for (int i = 0; i < input.e; i++)
80100c5c:	83 c3 01             	add    $0x1,%ebx
      cgaputc(buffer[i]);
80100c5f:	e8 1c f8 ff ff       	call   80100480 <cgaputc>
      for (int i = 0; i < input.e; i++)
80100c64:	3b 1d 08 ff 10 80    	cmp    0x8010ff08,%ebx
80100c6a:	72 ec                	jb     80100c58 <print_array+0x18>
}
80100c6c:	5b                   	pop    %ebx
80100c6d:	5e                   	pop    %esi
80100c6e:	5d                   	pop    %ebp
80100c6f:	c3                   	ret

80100c70 <consoleinit>:

void
consoleinit(void)
{
80100c70:	55                   	push   %ebp
80100c71:	89 e5                	mov    %esp,%ebp
80100c73:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100c76:	68 08 7d 10 80       	push   $0x80107d08
80100c7b:	68 20 ff 10 80       	push   $0x8010ff20
80100c80:	e8 5b 42 00 00       	call   80104ee0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100c85:	58                   	pop    %eax
80100c86:	5a                   	pop    %edx
80100c87:	6a 00                	push   $0x0
80100c89:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100c8b:	c7 05 0c 09 11 80 a0 	movl   $0x801007a0,0x8011090c
80100c92:	07 10 80 
  devsw[CONSOLE].read = consoleread;
80100c95:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100c9c:	02 10 80 
  cons.locking = 1;
80100c9f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100ca6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100ca9:	e8 e2 22 00 00       	call   80102f90 <ioapicenable>
}
80100cae:	83 c4 10             	add    $0x10,%esp
80100cb1:	c9                   	leave
80100cb2:	c3                   	ret
80100cb3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100cba:	00 
80100cbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100cc0 <move_cursor_left>:





void move_cursor_left(void){
80100cc0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100cc1:	b8 0e 00 00 00       	mov    $0xe,%eax
80100cc6:	89 e5                	mov    %esp,%ebp
80100cc8:	56                   	push   %esi
80100cc9:	be d4 03 00 00       	mov    $0x3d4,%esi
80100cce:	53                   	push   %ebx
80100ccf:	89 f2                	mov    %esi,%edx
80100cd1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100cd2:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100cd7:	89 ca                	mov    %ecx,%edx
80100cd9:	ec                   	in     (%dx),%al
  int pos;

  // get cursor position
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100cda:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100cdd:	89 f2                	mov    %esi,%edx
80100cdf:	b8 0f 00 00 00       	mov    $0xf,%eax
80100ce4:	c1 e3 08             	shl    $0x8,%ebx
80100ce7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ce8:	89 ca                	mov    %ecx,%edx
80100cea:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100ceb:	0f b6 c8             	movzbl %al,%ecx
80100cee:	09 d9                	or     %ebx,%ecx




  if(crt[pos - 2] != ('$' | 0x0700))
80100cf0:	66 81 bc 09 fc 7f 0b 	cmpw   $0x724,-0x7ff48004(%ecx,%ecx,1)
80100cf7:	80 24 07 
80100cfa:	74 03                	je     80100cff <move_cursor_left+0x3f>
    pos--;
80100cfc:	83 e9 01             	sub    $0x1,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100cff:	be d4 03 00 00       	mov    $0x3d4,%esi
80100d04:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d09:	89 f2                	mov    %esi,%edx
80100d0b:	ee                   	out    %al,(%dx)
80100d0c:	bb d5 03 00 00       	mov    $0x3d5,%ebx

  // reset cursor
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
80100d11:	89 c8                	mov    %ecx,%eax
80100d13:	c1 f8 08             	sar    $0x8,%eax
80100d16:	89 da                	mov    %ebx,%edx
80100d18:	ee                   	out    %al,(%dx)
80100d19:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d1e:	89 f2                	mov    %esi,%edx
80100d20:	ee                   	out    %al,(%dx)
80100d21:	89 c8                	mov    %ecx,%eax
80100d23:	89 da                	mov    %ebx,%edx
80100d25:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
}
80100d26:	5b                   	pop    %ebx
80100d27:	5e                   	pop    %esi
80100d28:	5d                   	pop    %ebp
80100d29:	c3                   	ret
80100d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d30 <consoleintr>:
{
80100d30:	55                   	push   %ebp
80100d31:	89 e5                	mov    %esp,%ebp
80100d33:	57                   	push   %edi
80100d34:	56                   	push   %esi
80100d35:	53                   	push   %ebx
80100d36:	83 ec 28             	sub    $0x28,%esp
80100d39:	8b 45 08             	mov    0x8(%ebp),%eax
80100d3c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  acquire(&cons.lock);
80100d3f:	68 20 ff 10 80       	push   $0x8010ff20
80100d44:	e8 87 43 00 00       	call   801050d0 <acquire>
  while((c = getc()) >= 0){
80100d49:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
80100d4c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((c = getc()) >= 0){
80100d53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d56:	ff d0                	call   *%eax
80100d58:	89 c3                	mov    %eax,%ebx
80100d5a:	85 c0                	test   %eax,%eax
80100d5c:	0f 88 0e 01 00 00    	js     80100e70 <consoleintr+0x140>
    switch(c){
80100d62:	83 fb 1a             	cmp    $0x1a,%ebx
80100d65:	7f 19                	jg     80100d80 <consoleintr+0x50>
80100d67:	85 db                	test   %ebx,%ebx
80100d69:	74 e8                	je     80100d53 <consoleintr+0x23>
80100d6b:	83 fb 1a             	cmp    $0x1a,%ebx
80100d6e:	77 38                	ja     80100da8 <consoleintr+0x78>
80100d70:	ff 24 9d a4 81 10 80 	jmp    *-0x7fef7e5c(,%ebx,4)
80100d77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d7e:	00 
80100d7f:	90                   	nop
80100d80:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100d86:	0f 84 e4 04 00 00    	je     80101270 <consoleintr+0x540>
80100d8c:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100d92:	0f 84 a8 00 00 00    	je     80100e40 <consoleintr+0x110>
80100d98:	83 fb 7f             	cmp    $0x7f,%ebx
80100d9b:	0f 84 f2 00 00 00    	je     80100e93 <consoleintr+0x163>
80100da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100da8:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100dad:	89 c2                	mov    %eax,%edx
80100daf:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
80100db5:	83 fa 7f             	cmp    $0x7f,%edx
80100db8:	77 99                	ja     80100d53 <consoleintr+0x23>
  if(panicked){
80100dba:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
          input.buf[(input.e++) % INPUT_BUF] = c;
80100dc0:	8d 50 01             	lea    0x1(%eax),%edx
        if (c=='\n')
80100dc3:	83 fb 0a             	cmp    $0xa,%ebx
80100dc6:	74 09                	je     80100dd1 <consoleintr+0xa1>
80100dc8:	83 fb 0d             	cmp    $0xd,%ebx
80100dcb:	0f 85 6f 06 00 00    	jne    80101440 <consoleintr+0x710>
          input.buf[(input.e++) % INPUT_BUF] = c;
80100dd1:	83 e0 7f             	and    $0x7f,%eax
80100dd4:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
80100dda:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
  if(panicked){
80100de1:	85 c9                	test   %ecx,%ecx
80100de3:	0f 85 53 06 00 00    	jne    8010143c <consoleintr+0x70c>
    uartputc(c);
80100de9:	83 ec 0c             	sub    $0xc,%esp
80100dec:	6a 0a                	push   $0xa
80100dee:	e8 ed 59 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
80100df3:	b8 0a 00 00 00       	mov    $0xa,%eax
80100df8:	e8 83 f6 ff ff       	call   80100480 <cgaputc>
          input.w = input.e;
80100dfd:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100e02:	83 c4 10             	add    $0x10,%esp
    input_sequence.size = 0;
80100e05:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80100e0c:	00 00 00 
          wakeup(&input.r);
80100e0f:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100e12:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          left_key_pressed=0;
80100e17:	c7 05 10 ff 10 80 00 	movl   $0x0,0x8010ff10
80100e1e:	00 00 00 
          left_key_pressed_count=0;
80100e21:	c7 05 0c ff 10 80 00 	movl   $0x0,0x8010ff0c
80100e28:	00 00 00 
          wakeup(&input.r);
80100e2b:	68 00 ff 10 80       	push   $0x8010ff00
80100e30:	e8 db 3d 00 00       	call   80104c10 <wakeup>
80100e35:	83 c4 10             	add    $0x10,%esp
80100e38:	e9 16 ff ff ff       	jmp    80100d53 <consoleintr+0x23>
80100e3d:	8d 76 00             	lea    0x0(%esi),%esi
      int cursor1 = input.e-left_key_pressed_count;
80100e40:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
80100e46:	a1 0c ff 10 80       	mov    0x8010ff0c,%eax
80100e4b:	89 d1                	mov    %edx,%ecx
80100e4d:	29 c1                	sub    %eax,%ecx
      if(input.e>cursor1){
80100e4f:	39 d1                	cmp    %edx,%ecx
80100e51:	0f 82 fa 04 00 00    	jb     80101351 <consoleintr+0x621>
        left_key_pressed=0;
80100e57:	c7 05 10 ff 10 80 00 	movl   $0x0,0x8010ff10
80100e5e:	00 00 00 
  while((c = getc()) >= 0){
80100e61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e64:	ff d0                	call   *%eax
80100e66:	89 c3                	mov    %eax,%ebx
80100e68:	85 c0                	test   %eax,%eax
80100e6a:	0f 89 f2 fe ff ff    	jns    80100d62 <consoleintr+0x32>
  release(&cons.lock);
80100e70:	83 ec 0c             	sub    $0xc,%esp
80100e73:	68 20 ff 10 80       	push   $0x8010ff20
80100e78:	e8 f3 41 00 00       	call   80105070 <release>
  if(doprocdump) {
80100e7d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e80:	83 c4 10             	add    $0x10,%esp
80100e83:	85 c0                	test   %eax,%eax
80100e85:	0f 85 ba 04 00 00    	jne    80101345 <consoleintr+0x615>
}
80100e8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e8e:	5b                   	pop    %ebx
80100e8f:	5e                   	pop    %esi
80100e90:	5f                   	pop    %edi
80100e91:	5d                   	pop    %ebp
80100e92:	c3                   	ret
      if(input.e != input.w){
80100e93:	8b 1d 08 ff 10 80    	mov    0x8010ff08,%ebx
80100e99:	3b 1d 04 ff 10 80    	cmp    0x8010ff04,%ebx
80100e9f:	0f 84 ae fe ff ff    	je     80100d53 <consoleintr+0x23>
  int shift_idx= shift_from_seq ? last_sequence(): input.e-left_key_pressed_count;
80100ea5:	89 df                	mov    %ebx,%edi
80100ea7:	2b 3d 0c ff 10 80    	sub    0x8010ff0c,%edi
  for (int i = shift_idx - 1; i < input.e; i++)
80100ead:	89 de                	mov    %ebx,%esi
80100eaf:	8d 57 ff             	lea    -0x1(%edi),%edx
80100eb2:	39 da                	cmp    %ebx,%edx
80100eb4:	73 41                	jae    80100ef7 <consoleintr+0x1c7>
80100eb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100ebd:	00 
80100ebe:	66 90                	xchg   %ax,%ax
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
80100ec0:	89 d0                	mov    %edx,%eax
80100ec2:	83 c2 01             	add    $0x1,%edx
80100ec5:	89 d3                	mov    %edx,%ebx
80100ec7:	c1 fb 1f             	sar    $0x1f,%ebx
80100eca:	c1 eb 19             	shr    $0x19,%ebx
80100ecd:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80100ed0:	83 e1 7f             	and    $0x7f,%ecx
80100ed3:	29 d9                	sub    %ebx,%ecx
80100ed5:	0f b6 99 80 fe 10 80 	movzbl -0x7fef0180(%ecx),%ebx
80100edc:	89 c1                	mov    %eax,%ecx
80100ede:	c1 f9 1f             	sar    $0x1f,%ecx
80100ee1:	c1 e9 19             	shr    $0x19,%ecx
80100ee4:	01 c8                	add    %ecx,%eax
80100ee6:	83 e0 7f             	and    $0x7f,%eax
80100ee9:	29 c8                	sub    %ecx,%eax
80100eeb:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  for (int i = shift_idx - 1; i < input.e; i++)
80100ef1:	39 f2                	cmp    %esi,%edx
80100ef3:	72 cb                	jb     80100ec0 <consoleintr+0x190>
80100ef5:	89 f3                	mov    %esi,%ebx
        delete_from_sequence(input.e-left_key_pressed_count);
80100ef7:	83 ec 0c             	sub    $0xc,%esp
  input.buf[input.e] = ' ';
80100efa:	c6 83 80 fe 10 80 20 	movb   $0x20,-0x7fef0180(%ebx)
        delete_from_sequence(input.e-left_key_pressed_count);
80100f01:	57                   	push   %edi
80100f02:	e8 b9 fc ff ff       	call   80100bc0 <delete_from_sequence>
        for(int i=0;i<input_sequence.size;i++)
80100f07:	8b 1d 00 92 10 80    	mov    0x80109200,%ebx
80100f0d:	83 c4 10             	add    $0x10,%esp
80100f10:	85 db                	test   %ebx,%ebx
80100f12:	0f 8e 27 06 00 00    	jle    8010153f <consoleintr+0x80f>
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
80100f18:	8b 35 08 ff 10 80    	mov    0x8010ff08,%esi
        for(int i=0;i<input_sequence.size;i++)
80100f1e:	31 c0                	xor    %eax,%eax
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
80100f20:	89 f1                	mov    %esi,%ecx
80100f22:	2b 0d 0c ff 10 80    	sub    0x8010ff0c,%ecx
80100f28:	83 e1 7f             	and    $0x7f,%ecx
80100f2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f30:	8b 14 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%edx
80100f37:	39 d1                	cmp    %edx,%ecx
80100f39:	73 0a                	jae    80100f45 <consoleintr+0x215>
              input_sequence.data[i]--;
80100f3b:	83 ea 01             	sub    $0x1,%edx
80100f3e:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
        for(int i=0;i<input_sequence.size;i++)
80100f45:	83 c0 01             	add    $0x1,%eax
80100f48:	39 d8                	cmp    %ebx,%eax
80100f4a:	75 e4                	jne    80100f30 <consoleintr+0x200>
  if(panicked){
80100f4c:	8b 1d 58 ff 10 80    	mov    0x8010ff58,%ebx
        input.e--;
80100f52:	83 ee 01             	sub    $0x1,%esi
80100f55:	89 35 08 ff 10 80    	mov    %esi,0x8010ff08
  if(panicked){
80100f5b:	85 db                	test   %ebx,%ebx
80100f5d:	0f 84 a5 04 00 00    	je     80101408 <consoleintr+0x6d8>
  asm volatile("cli");
80100f63:	fa                   	cli
    for(;;)
80100f64:	eb fe                	jmp    80100f64 <consoleintr+0x234>
80100f66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f6d:	00 
80100f6e:	66 90                	xchg   %ax,%ax
      if(input.e != input.w){
80100f70:	a1 04 ff 10 80       	mov    0x8010ff04,%eax
80100f75:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
80100f7b:	0f 84 d2 fd ff ff    	je     80100d53 <consoleintr+0x23>
    if (input_sequence.size == 0) return -1;
80100f81:	a1 00 92 10 80       	mov    0x80109200,%eax
    return input_sequence.data[input_sequence.size - 1];
80100f86:	8d 50 ff             	lea    -0x1(%eax),%edx
    if (input_sequence.size == 0) return -1;
80100f89:	85 c0                	test   %eax,%eax
80100f8b:	0f 84 b9 05 00 00    	je     8010154a <consoleintr+0x81a>
  for (int i = shift_idx - 1; i < input.e; i++)
80100f91:	8b 04 95 00 90 10 80 	mov    -0x7fef7000(,%edx,4),%eax
80100f98:	8d 58 ff             	lea    -0x1(%eax),%ebx
80100f9b:	89 de                	mov    %ebx,%esi
    (delete_from_sequence(input_sequence.size-1));
80100f9d:	83 ec 0c             	sub    $0xc,%esp
80100fa0:	52                   	push   %edx
80100fa1:	e8 1a fc ff ff       	call   80100bc0 <delete_from_sequence>
  for (int i = shift_idx - 1; i < input.e; i++)
80100fa6:	8b 0d 08 ff 10 80    	mov    0x8010ff08,%ecx
80100fac:	83 c4 10             	add    $0x10,%esp
80100faf:	39 ce                	cmp    %ecx,%esi
80100fb1:	73 38                	jae    80100feb <consoleintr+0x2bb>
80100fb3:	89 ce                	mov    %ecx,%esi
80100fb5:	8d 76 00             	lea    0x0(%esi),%esi
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
80100fb8:	89 d8                	mov    %ebx,%eax
80100fba:	83 c3 01             	add    $0x1,%ebx
80100fbd:	89 d9                	mov    %ebx,%ecx
80100fbf:	c1 f9 1f             	sar    $0x1f,%ecx
80100fc2:	c1 e9 19             	shr    $0x19,%ecx
80100fc5:	8d 14 0b             	lea    (%ebx,%ecx,1),%edx
80100fc8:	83 e2 7f             	and    $0x7f,%edx
80100fcb:	29 ca                	sub    %ecx,%edx
80100fcd:	0f b6 8a 80 fe 10 80 	movzbl -0x7fef0180(%edx),%ecx
80100fd4:	99                   	cltd
80100fd5:	c1 ea 19             	shr    $0x19,%edx
80100fd8:	01 d0                	add    %edx,%eax
80100fda:	83 e0 7f             	and    $0x7f,%eax
80100fdd:	29 d0                	sub    %edx,%eax
80100fdf:	88 88 80 fe 10 80    	mov    %cl,-0x7fef0180(%eax)
  for (int i = shift_idx - 1; i < input.e; i++)
80100fe5:	39 f3                	cmp    %esi,%ebx
80100fe7:	72 cf                	jb     80100fb8 <consoleintr+0x288>
80100fe9:	89 f1                	mov    %esi,%ecx
  if(panicked){
80100feb:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
  input.buf[input.e] = ' ';
80100ff1:	c6 81 80 fe 10 80 20 	movb   $0x20,-0x7fef0180(%ecx)
        input.e--;
80100ff8:	83 e9 01             	sub    $0x1,%ecx
80100ffb:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
  if(panicked){
80101001:	85 d2                	test   %edx,%edx
80101003:	0f 84 a3 03 00 00    	je     801013ac <consoleintr+0x67c>
80101009:	fa                   	cli
    for(;;)
8010100a:	eb fe                	jmp    8010100a <consoleintr+0x2da>
8010100c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80101010:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80101015:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
8010101b:	0f 84 32 fd ff ff    	je     80100d53 <consoleintr+0x23>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80101021:	83 e8 01             	sub    $0x1,%eax
80101024:	89 c2                	mov    %eax,%edx
80101026:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80101029:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80101030:	0f 84 1d fd ff ff    	je     80100d53 <consoleintr+0x23>
  if(panicked){
80101036:	8b 35 58 ff 10 80    	mov    0x8010ff58,%esi
        input.e--;
8010103c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80101041:	85 f6                	test   %esi,%esi
80101043:	0f 84 67 02 00 00    	je     801012b0 <consoleintr+0x580>
80101049:	fa                   	cli
    for(;;)
8010104a:	eb fe                	jmp    8010104a <consoleintr+0x31a>
8010104c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cgaputc("0"+input.e);
80101050:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80101055:	05 10 7d 10 80       	add    $0x80107d10,%eax
8010105a:	e8 21 f4 ff ff       	call   80100480 <cgaputc>
         cgaputc(cga_pos_sequence.pos_data[cga_pos_sequence.size-1]);
8010105f:	a1 20 94 10 80       	mov    0x80109420,%eax
80101064:	8b 04 85 1c 92 10 80 	mov    -0x7fef6de4(,%eax,4),%eax
8010106b:	e8 10 f4 ff ff       	call   80100480 <cgaputc>
      break;
80101070:	e9 de fc ff ff       	jmp    80100d53 <consoleintr+0x23>
        int pos = input.e-left_key_pressed_count;
80101075:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010107a:	8b 3d 0c ff 10 80    	mov    0x8010ff0c,%edi
80101080:	89 c2                	mov    %eax,%edx
80101082:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101085:	29 fa                	sub    %edi,%edx
        int distance = pos - (input.e-left_key_pressed_count);
80101087:	29 c7                	sub    %eax,%edi
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
80101089:	89 d3                	mov    %edx,%ebx
        int distance = pos - (input.e-left_key_pressed_count);
8010108b:	89 fe                	mov    %edi,%esi
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
8010108d:	c1 fb 1f             	sar    $0x1f,%ebx
80101090:	c1 eb 19             	shr    $0x19,%ebx
80101093:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80101096:	83 e1 7f             	and    $0x7f,%ecx
80101099:	29 d9                	sub    %ebx,%ecx
8010109b:	80 b9 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%ecx)
801010a2:	74 2c                	je     801010d0 <consoleintr+0x3a0>
801010a4:	39 c2                	cmp    %eax,%edx
801010a6:	72 0c                	jb     801010b4 <consoleintr+0x384>
801010a8:	e9 b6 00 00 00       	jmp    80101163 <consoleintr+0x433>
801010ad:	8d 76 00             	lea    0x0(%esi),%esi
801010b0:	39 c2                	cmp    %eax,%edx
801010b2:	73 38                	jae    801010ec <consoleintr+0x3bc>
            pos++;
801010b4:	83 c2 01             	add    $0x1,%edx
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
801010b7:	89 d3                	mov    %edx,%ebx
801010b9:	c1 fb 1f             	sar    $0x1f,%ebx
801010bc:	c1 eb 19             	shr    $0x19,%ebx
801010bf:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
801010c2:	83 e1 7f             	and    $0x7f,%ecx
801010c5:	29 d9                	sub    %ebx,%ecx
801010c7:	80 b9 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%ecx)
801010ce:	75 e0                	jne    801010b0 <consoleintr+0x380>
            pos++;
801010d0:	83 c2 01             	add    $0x1,%edx
            while (input.buf[pos % INPUT_BUF] == ' '){
801010d3:	89 d3                	mov    %edx,%ebx
801010d5:	c1 fb 1f             	sar    $0x1f,%ebx
801010d8:	c1 eb 19             	shr    $0x19,%ebx
801010db:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
801010de:	83 e1 7f             	and    $0x7f,%ecx
801010e1:	29 d9                	sub    %ebx,%ecx
801010e3:	80 b9 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%ecx)
801010ea:	74 e4                	je     801010d0 <consoleintr+0x3a0>
        left_key_pressed_count = input.e-pos;
801010ec:	29 d0                	sub    %edx,%eax
        int distance = pos - (input.e-left_key_pressed_count);
801010ee:	01 f2                	add    %esi,%edx
        left_key_pressed_count = input.e-pos;
801010f0:	89 45 d8             	mov    %eax,-0x28(%ebp)
        for (int i = 0; i < distance; i++)
801010f3:	85 d2                	test   %edx,%edx
801010f5:	7e 6c                	jle    80101163 <consoleintr+0x433>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801010f7:	89 55 e0             	mov    %edx,-0x20(%ebp)
801010fa:	31 f6                	xor    %esi,%esi
801010fc:	bf 0e 00 00 00       	mov    $0xe,%edi
80101101:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80101106:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010110d:	00 
8010110e:	66 90                	xchg   %ax,%ax
80101110:	89 f8                	mov    %edi,%eax
80101112:	89 da                	mov    %ebx,%edx
80101114:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101115:	ba d5 03 00 00       	mov    $0x3d5,%edx
8010111a:	ec                   	in     (%dx),%al

void move_cursor_right(void) {
    int pos;

    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
8010111b:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010111e:	89 da                	mov    %ebx,%edx
80101120:	b8 0f 00 00 00       	mov    $0xf,%eax
80101125:	c1 e1 08             	shl    $0x8,%ecx
80101128:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101129:	ba d5 03 00 00       	mov    $0x3d5,%edx
8010112e:	ec                   	in     (%dx),%al
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
8010112f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101132:	89 da                	mov    %ebx,%edx
80101134:	09 c1                	or     %eax,%ecx
80101136:	89 f8                	mov    %edi,%eax

    pos++;
80101138:	83 c1 01             	add    $0x1,%ecx
8010113b:	ee                   	out    %al,(%dx)

    outb(CRTPORT, 14);
    outb(CRTPORT+1, pos >> 8);
8010113c:	89 ca                	mov    %ecx,%edx
8010113e:	c1 fa 08             	sar    $0x8,%edx
80101141:	89 d0                	mov    %edx,%eax
80101143:	ba d5 03 00 00       	mov    $0x3d5,%edx
80101148:	ee                   	out    %al,(%dx)
80101149:	b8 0f 00 00 00       	mov    $0xf,%eax
8010114e:	89 da                	mov    %ebx,%edx
80101150:	ee                   	out    %al,(%dx)
80101151:	ba d5 03 00 00       	mov    $0x3d5,%edx
80101156:	89 c8                	mov    %ecx,%eax
80101158:	ee                   	out    %al,(%dx)
        for (int i = 0; i < distance; i++)
80101159:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010115c:	83 c6 01             	add    $0x1,%esi
8010115f:	39 c6                	cmp    %eax,%esi
80101161:	75 ad                	jne    80101110 <consoleintr+0x3e0>
        left_key_pressed_count = input.e-pos;
80101163:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101166:	a3 0c ff 10 80       	mov    %eax,0x8010ff0c
        break;
8010116b:	e9 e3 fb ff ff       	jmp    80100d53 <consoleintr+0x23>
         int posA = input.e-left_key_pressed_count;
80101170:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80101175:	89 c2                	mov    %eax,%edx
80101177:	2b 15 0c ff 10 80    	sub    0x8010ff0c,%edx
8010117d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80101180:	89 d1                	mov    %edx,%ecx
         int posA = input.e-left_key_pressed_count;
80101182:	89 d0                	mov    %edx,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
80101184:	89 d3                	mov    %edx,%ebx
80101186:	c1 f9 1f             	sar    $0x1f,%ecx
80101189:	c1 e9 19             	shr    $0x19,%ecx
8010118c:	8d 34 0a             	lea    (%edx,%ecx,1),%esi
8010118f:	83 e6 7f             	and    $0x7f,%esi
80101192:	29 ce                	sub    %ecx,%esi
      while(input.e != input.w &&
80101194:	8b 0d 04 ff 10 80    	mov    0x8010ff04,%ecx
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
8010119a:	80 be 7f fe 10 80 20 	cmpb   $0x20,-0x7fef0181(%esi)
801011a1:	74 25                	je     801011c8 <consoleintr+0x498>
801011a3:	eb 29                	jmp    801011ce <consoleintr+0x49e>
801011a5:	8d 76 00             	lea    0x0(%esi),%esi
            posA--;
801011a8:	83 e8 01             	sub    $0x1,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
801011ab:	89 c3                	mov    %eax,%ebx
801011ad:	c1 fb 1f             	sar    $0x1f,%ebx
801011b0:	c1 eb 19             	shr    $0x19,%ebx
801011b3:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801011b6:	83 e6 7f             	and    $0x7f,%esi
801011b9:	29 de                	sub    %ebx,%esi
801011bb:	80 be 7f fe 10 80 20 	cmpb   $0x20,-0x7fef0181(%esi)
801011c2:	0f 85 4d 01 00 00    	jne    80101315 <consoleintr+0x5e5>
801011c8:	89 c3                	mov    %eax,%ebx
801011ca:	39 c1                	cmp    %eax,%ecx
801011cc:	72 da                	jb     801011a8 <consoleintr+0x478>
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
801011ce:	80 be 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%esi)
801011d5:	0f 84 49 01 00 00    	je     80101324 <consoleintr+0x5f4>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
801011db:	89 c7                	mov    %eax,%edi
801011dd:	c1 ff 1f             	sar    $0x1f,%edi
801011e0:	c1 ef 19             	shr    $0x19,%edi
801011e3:	8d 34 38             	lea    (%eax,%edi,1),%esi
801011e6:	83 e6 7f             	and    $0x7f,%esi
801011e9:	29 fe                	sub    %edi,%esi
801011eb:	80 be 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%esi)
801011f2:	75 2c                	jne    80101220 <consoleintr+0x4f0>
801011f4:	e9 3f 01 00 00       	jmp    80101338 <consoleintr+0x608>
801011f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            posA--;
80101200:	83 e8 01             	sub    $0x1,%eax
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
80101203:	89 c6                	mov    %eax,%esi
80101205:	c1 fe 1f             	sar    $0x1f,%esi
80101208:	c1 ee 19             	shr    $0x19,%esi
8010120b:	8d 1c 30             	lea    (%eax,%esi,1),%ebx
8010120e:	83 e3 7f             	and    $0x7f,%ebx
80101211:	29 f3                	sub    %esi,%ebx
80101213:	80 bb 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%ebx)
8010121a:	0f 84 16 01 00 00    	je     80101336 <consoleintr+0x606>
80101220:	89 c3                	mov    %eax,%ebx
80101222:	39 c1                	cmp    %eax,%ecx
80101224:	72 da                	jb     80101200 <consoleintr+0x4d0>
        int distanceA = input.e-left_key_pressed_count-posA;
80101226:	89 d6                	mov    %edx,%esi
80101228:	29 de                	sub    %ebx,%esi
        for (int i = distanceA; i > 0; i--)
8010122a:	85 f6                	test   %esi,%esi
8010122c:	7e 29                	jle    80101257 <consoleintr+0x527>
8010122e:	8d 7e ff             	lea    -0x1(%esi),%edi
80101231:	f7 c6 01 00 00 00    	test   $0x1,%esi
80101237:	74 0f                	je     80101248 <consoleintr+0x518>
            move_cursor_left();
80101239:	e8 82 fa ff ff       	call   80100cc0 <move_cursor_left>
        for (int i = distanceA; i > 0; i--)
8010123e:	89 fe                	mov    %edi,%esi
80101240:	85 ff                	test   %edi,%edi
80101242:	74 13                	je     80101257 <consoleintr+0x527>
80101244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            move_cursor_left();
80101248:	e8 73 fa ff ff       	call   80100cc0 <move_cursor_left>
8010124d:	e8 6e fa ff ff       	call   80100cc0 <move_cursor_left>
        for (int i = distanceA; i > 0; i--)
80101252:	83 ee 02             	sub    $0x2,%esi
80101255:	75 f1                	jne    80101248 <consoleintr+0x518>
        left_key_pressed_count = input.e-posA;     
80101257:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010125a:	29 d8                	sub    %ebx,%eax
8010125c:	a3 0c ff 10 80       	mov    %eax,0x8010ff0c
      break;
80101261:	e9 ed fa ff ff       	jmp    80100d53 <consoleintr+0x23>
80101266:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010126d:	00 
8010126e:	66 90                	xchg   %ax,%ax
        int cursor = input.e-left_key_pressed_count;
80101270:	8b 1d 0c ff 10 80    	mov    0x8010ff0c,%ebx
80101276:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010127b:	29 d8                	sub    %ebx,%eax
        if (input.w < cursor)
8010127d:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
80101283:	0f 83 ca fa ff ff    	jae    80100d53 <consoleintr+0x23>
          if (left_key_pressed==0)
80101289:	8b 0d 10 ff 10 80    	mov    0x8010ff10,%ecx
8010128f:	85 c9                	test   %ecx,%ecx
80101291:	75 0a                	jne    8010129d <consoleintr+0x56d>
            left_key_pressed=1;
80101293:	c7 05 10 ff 10 80 01 	movl   $0x1,0x8010ff10
8010129a:	00 00 00 
          move_cursor_left();
8010129d:	e8 1e fa ff ff       	call   80100cc0 <move_cursor_left>
          left_key_pressed_count++;
801012a2:	83 c3 01             	add    $0x1,%ebx
801012a5:	89 1d 0c ff 10 80    	mov    %ebx,0x8010ff0c
801012ab:	e9 a3 fa ff ff       	jmp    80100d53 <consoleintr+0x23>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801012b0:	83 ec 0c             	sub    $0xc,%esp
801012b3:	6a 08                	push   $0x8
801012b5:	e8 26 55 00 00       	call   801067e0 <uartputc>
801012ba:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801012c1:	e8 1a 55 00 00       	call   801067e0 <uartputc>
801012c6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801012cd:	e8 0e 55 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
801012d2:	b8 00 01 00 00       	mov    $0x100,%eax
801012d7:	e8 a4 f1 ff ff       	call   80100480 <cgaputc>
      while(input.e != input.w &&
801012dc:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801012e1:	83 c4 10             	add    $0x10,%esp
    input_sequence.size = 0;
801012e4:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
801012eb:	00 00 00 
    cga_pos_sequence.size = 0;
801012ee:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
801012f5:	00 00 00 
      while(input.e != input.w &&
801012f8:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801012fe:	0f 85 1d fd ff ff    	jne    80101021 <consoleintr+0x2f1>
80101304:	e9 4a fa ff ff       	jmp    80100d53 <consoleintr+0x23>
    switch(c){
80101309:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
80101310:	e9 3e fa ff ff       	jmp    80100d53 <consoleintr+0x23>
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
80101315:	80 be 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%esi)
8010131c:	89 c3                	mov    %eax,%ebx
8010131e:	0f 85 b7 fe ff ff    	jne    801011db <consoleintr+0x4ab>
80101324:	39 d9                	cmp    %ebx,%ecx
80101326:	0f 83 b4 00 00 00    	jae    801013e0 <consoleintr+0x6b0>
          posA--;
8010132c:	83 e8 01             	sub    $0x1,%eax
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
8010132f:	89 c3                	mov    %eax,%ebx
80101331:	e9 a5 fe ff ff       	jmp    801011db <consoleintr+0x4ab>
        int distanceA = input.e-left_key_pressed_count-posA;
80101336:	89 c3                	mov    %eax,%ebx
          posA++;
80101338:	83 c0 01             	add    $0x1,%eax
8010133b:	39 d9                	cmp    %ebx,%ecx
8010133d:	0f 42 d8             	cmovb  %eax,%ebx
80101340:	e9 e1 fe ff ff       	jmp    80101226 <consoleintr+0x4f6>
}
80101345:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101348:	5b                   	pop    %ebx
80101349:	5e                   	pop    %esi
8010134a:	5f                   	pop    %edi
8010134b:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
8010134c:	e9 9f 39 00 00       	jmp    80104cf0 <procdump>
        left_key_pressed_count--;
80101351:	83 e8 01             	sub    $0x1,%eax
80101354:	bf 0e 00 00 00       	mov    $0xe,%edi
80101359:	be d4 03 00 00       	mov    $0x3d4,%esi
8010135e:	a3 0c ff 10 80       	mov    %eax,0x8010ff0c
80101363:	89 f2                	mov    %esi,%edx
80101365:	89 f8                	mov    %edi,%eax
80101367:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101368:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010136d:	89 da                	mov    %ebx,%edx
8010136f:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80101370:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101373:	89 f2                	mov    %esi,%edx
80101375:	c1 e0 08             	shl    $0x8,%eax
80101378:	89 c1                	mov    %eax,%ecx
8010137a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010137f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101380:	89 da                	mov    %ebx,%edx
80101382:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80101383:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101386:	89 f2                	mov    %esi,%edx
80101388:	09 c1                	or     %eax,%ecx
8010138a:	89 f8                	mov    %edi,%eax
    pos++;
8010138c:	83 c1 01             	add    $0x1,%ecx
8010138f:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80101390:	89 cf                	mov    %ecx,%edi
80101392:	89 da                	mov    %ebx,%edx
80101394:	c1 ff 08             	sar    $0x8,%edi
80101397:	89 f8                	mov    %edi,%eax
80101399:	ee                   	out    %al,(%dx)
8010139a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010139f:	89 f2                	mov    %esi,%edx
801013a1:	ee                   	out    %al,(%dx)
801013a2:	89 c8                	mov    %ecx,%eax
801013a4:	89 da                	mov    %ebx,%edx
801013a6:	ee                   	out    %al,(%dx)
    outb(CRTPORT, 15);
    outb(CRTPORT+1, pos);
}
801013a7:	e9 a7 f9 ff ff       	jmp    80100d53 <consoleintr+0x23>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801013ac:	83 ec 0c             	sub    $0xc,%esp
801013af:	6a 08                	push   $0x8
801013b1:	e8 2a 54 00 00       	call   801067e0 <uartputc>
801013b6:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801013bd:	e8 1e 54 00 00       	call   801067e0 <uartputc>
801013c2:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801013c9:	e8 12 54 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
801013ce:	b8 01 01 00 00       	mov    $0x101,%eax
801013d3:	e8 a8 f0 ff ff       	call   80100480 <cgaputc>
}
801013d8:	83 c4 10             	add    $0x10,%esp
801013db:	e9 73 f9 ff ff       	jmp    80100d53 <consoleintr+0x23>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
801013e0:	89 c7                	mov    %eax,%edi
801013e2:	c1 ff 1f             	sar    $0x1f,%edi
801013e5:	c1 ef 19             	shr    $0x19,%edi
801013e8:	8d 34 38             	lea    (%eax,%edi,1),%esi
801013eb:	83 e6 7f             	and    $0x7f,%esi
801013ee:	29 fe                	sub    %edi,%esi
801013f0:	80 be 80 fe 10 80 20 	cmpb   $0x20,-0x7fef0180(%esi)
801013f7:	0f 85 23 fe ff ff    	jne    80101220 <consoleintr+0x4f0>
801013fd:	e9 24 fe ff ff       	jmp    80101226 <consoleintr+0x4f6>
80101402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101408:	83 ec 0c             	sub    $0xc,%esp
8010140b:	6a 08                	push   $0x8
8010140d:	e8 ce 53 00 00       	call   801067e0 <uartputc>
80101412:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101419:	e8 c2 53 00 00       	call   801067e0 <uartputc>
8010141e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101425:	e8 b6 53 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
8010142a:	b8 00 01 00 00       	mov    $0x100,%eax
8010142f:	e8 4c f0 ff ff       	call   80100480 <cgaputc>
}
80101434:	83 c4 10             	add    $0x10,%esp
80101437:	e9 17 f9 ff ff       	jmp    80100d53 <consoleintr+0x23>
  asm volatile("cli");
8010143c:	fa                   	cli
    for(;;)
8010143d:	eb fe                	jmp    8010143d <consoleintr+0x70d>
8010143f:	90                   	nop
   int cursor= input.e-left_key_pressed_count;
80101440:	89 c6                	mov    %eax,%esi
80101442:	2b 35 0c ff 10 80    	sub    0x8010ff0c,%esi
  for (int i = input.e; i > cursor; i--)
80101448:	39 c6                	cmp    %eax,%esi
8010144a:	7d 45                	jge    80101491 <consoleintr+0x761>
8010144c:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010144f:	89 cf                	mov    %ecx,%edi
80101451:	89 55 d8             	mov    %edx,-0x28(%ebp)
    input.buf[(i) % INPUT_BUF] = input.buf[(i-1) % INPUT_BUF]; // Shift elements to right
80101454:	89 c2                	mov    %eax,%edx
80101456:	83 e8 01             	sub    $0x1,%eax
80101459:	89 c3                	mov    %eax,%ebx
8010145b:	c1 fb 1f             	sar    $0x1f,%ebx
8010145e:	c1 eb 19             	shr    $0x19,%ebx
80101461:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80101464:	83 e1 7f             	and    $0x7f,%ecx
80101467:	29 d9                	sub    %ebx,%ecx
80101469:	89 d3                	mov    %edx,%ebx
8010146b:	c1 fb 1f             	sar    $0x1f,%ebx
8010146e:	0f b6 89 80 fe 10 80 	movzbl -0x7fef0180(%ecx),%ecx
80101475:	c1 eb 19             	shr    $0x19,%ebx
80101478:	01 da                	add    %ebx,%edx
8010147a:	83 e2 7f             	and    $0x7f,%edx
8010147d:	29 da                	sub    %ebx,%edx
8010147f:	88 8a 80 fe 10 80    	mov    %cl,-0x7fef0180(%edx)
  for (int i = input.e; i > cursor; i--)
80101485:	39 c6                	cmp    %eax,%esi
80101487:	75 cb                	jne    80101454 <consoleintr+0x724>
80101489:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010148c:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010148f:	89 f9                	mov    %edi,%ecx
    if (input_sequence.size >= input_sequence.cap) {
80101491:	8b 3d 00 92 10 80    	mov    0x80109200,%edi
80101497:	83 e6 7f             	and    $0x7f,%esi
8010149a:	3b 3d 04 92 10 80    	cmp    0x80109204,%edi
801014a0:	7d 11                	jge    801014b3 <consoleintr+0x783>
    input_sequence.data[input_sequence.size++] = value;
801014a2:	8d 47 01             	lea    0x1(%edi),%eax
801014a5:	89 34 bd 00 90 10 80 	mov    %esi,-0x7fef7000(,%edi,4)
801014ac:	a3 00 92 10 80       	mov    %eax,0x80109200
801014b1:	89 c7                	mov    %eax,%edi
          for(int i=0;i<input_sequence.size;i++)
801014b3:	31 c0                	xor    %eax,%eax
801014b5:	85 ff                	test   %edi,%edi
801014b7:	7e 22                	jle    801014db <consoleintr+0x7ab>
801014b9:	89 5d e0             	mov    %ebx,-0x20(%ebp)
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
801014bc:	8b 1c 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%ebx
801014c3:	39 de                	cmp    %ebx,%esi
801014c5:	73 0a                	jae    801014d1 <consoleintr+0x7a1>
              input_sequence.data[i]++;
801014c7:	83 c3 01             	add    $0x1,%ebx
801014ca:	89 1c 85 00 90 10 80 	mov    %ebx,-0x7fef7000(,%eax,4)
          for(int i=0;i<input_sequence.size;i++)
801014d1:	83 c0 01             	add    $0x1,%eax
801014d4:	39 f8                	cmp    %edi,%eax
801014d6:	75 e4                	jne    801014bc <consoleintr+0x78c>
801014d8:	8b 5d e0             	mov    -0x20(%ebp),%ebx
          input.buf[(input.e++-left_key_pressed_count) % INPUT_BUF] = c;
801014db:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
801014e1:	88 9e 80 fe 10 80    	mov    %bl,-0x7fef0180(%esi)
  if(panicked){
801014e7:	85 c9                	test   %ecx,%ecx
801014e9:	0f 85 4d ff ff ff    	jne    8010143c <consoleintr+0x70c>
  if(c == BACKSPACE || c==UNDO_BS){
801014ef:	8d 83 00 ff ff ff    	lea    -0x100(%ebx),%eax
801014f5:	83 f8 01             	cmp    $0x1,%eax
801014f8:	77 5f                	ja     80101559 <consoleintr+0x829>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801014fa:	83 ec 0c             	sub    $0xc,%esp
801014fd:	6a 08                	push   $0x8
801014ff:	e8 dc 52 00 00       	call   801067e0 <uartputc>
80101504:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010150b:	e8 d0 52 00 00       	call   801067e0 <uartputc>
80101510:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101517:	e8 c4 52 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
8010151c:	89 d8                	mov    %ebx,%eax
8010151e:	e8 5d ef ff ff       	call   80100480 <cgaputc>
80101523:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80101526:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
8010152b:	83 e8 80             	sub    $0xffffff80,%eax
8010152e:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
80101534:	0f 85 19 f8 ff ff    	jne    80100d53 <consoleintr+0x23>
8010153a:	e9 d0 f8 ff ff       	jmp    80100e0f <consoleintr+0xdf>
        input.e--;
8010153f:	8b 35 08 ff 10 80    	mov    0x8010ff08,%esi
80101545:	e9 02 fa ff ff       	jmp    80100f4c <consoleintr+0x21c>
8010154a:	be fe ff ff ff       	mov    $0xfffffffe,%esi
8010154f:	bb fe ff ff ff       	mov    $0xfffffffe,%ebx
80101554:	e9 44 fa ff ff       	jmp    80100f9d <consoleintr+0x26d>
    uartputc(c);
80101559:	83 ec 0c             	sub    $0xc,%esp
8010155c:	53                   	push   %ebx
8010155d:	e8 7e 52 00 00       	call   801067e0 <uartputc>
  cgaputc(c);
80101562:	89 d8                	mov    %ebx,%eax
80101564:	e8 17 ef ff ff       	call   80100480 <cgaputc>
80101569:	83 c4 10             	add    $0x10,%esp
8010156c:	eb b8                	jmp    80101526 <consoleintr+0x7f6>
8010156e:	66 90                	xchg   %ax,%ax

80101570 <move_cursor_right>:
void move_cursor_right(void) {
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	57                   	push   %edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101574:	bf 0e 00 00 00       	mov    $0xe,%edi
80101579:	56                   	push   %esi
8010157a:	89 f8                	mov    %edi,%eax
8010157c:	53                   	push   %ebx
8010157d:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80101582:	89 da                	mov    %ebx,%edx
80101584:	83 ec 04             	sub    $0x4,%esp
80101587:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101588:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010158d:	89 ca                	mov    %ecx,%edx
8010158f:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80101590:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101593:	be 0f 00 00 00       	mov    $0xf,%esi
80101598:	89 da                	mov    %ebx,%edx
8010159a:	c1 e0 08             	shl    $0x8,%eax
8010159d:	89 45 f0             	mov    %eax,-0x10(%ebp)
801015a0:	89 f0                	mov    %esi,%eax
801015a2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801015a3:	89 ca                	mov    %ecx,%edx
801015a5:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
801015a6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801015a9:	0f b6 c0             	movzbl %al,%eax
801015ac:	09 d0                	or     %edx,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801015ae:	89 da                	mov    %ebx,%edx
    pos++;
801015b0:	83 c0 01             	add    $0x1,%eax
801015b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801015b6:	89 f8                	mov    %edi,%eax
801015b8:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
801015b9:	8b 7d f0             	mov    -0x10(%ebp),%edi
801015bc:	89 ca                	mov    %ecx,%edx
801015be:	89 f8                	mov    %edi,%eax
801015c0:	c1 f8 08             	sar    $0x8,%eax
801015c3:	ee                   	out    %al,(%dx)
801015c4:	89 f0                	mov    %esi,%eax
801015c6:	89 da                	mov    %ebx,%edx
801015c8:	ee                   	out    %al,(%dx)
801015c9:	89 f8                	mov    %edi,%eax
801015cb:	89 ca                	mov    %ecx,%edx
801015cd:	ee                   	out    %al,(%dx)
}
801015ce:	83 c4 04             	add    $0x4,%esp
801015d1:	5b                   	pop    %ebx
801015d2:	5e                   	pop    %esi
801015d3:	5f                   	pop    %edi
801015d4:	5d                   	pop    %ebp
801015d5:	c3                   	ret
801015d6:	66 90                	xchg   %ax,%ax
801015d8:	66 90                	xchg   %ax,%ax
801015da:	66 90                	xchg   %ax,%ax
801015dc:	66 90                	xchg   %ax,%ax
801015de:	66 90                	xchg   %ax,%ax

801015e0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	57                   	push   %edi
801015e4:	56                   	push   %esi
801015e5:	53                   	push   %ebx
801015e6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801015ec:	e8 9f 2e 00 00       	call   80104490 <myproc>
801015f1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801015f7:	e8 74 22 00 00       	call   80103870 <begin_op>

  if((ip = namei(path)) == 0){
801015fc:	83 ec 0c             	sub    $0xc,%esp
801015ff:	ff 75 08             	push   0x8(%ebp)
80101602:	e8 a9 15 00 00       	call   80102bb0 <namei>
80101607:	83 c4 10             	add    $0x10,%esp
8010160a:	85 c0                	test   %eax,%eax
8010160c:	0f 84 30 03 00 00    	je     80101942 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101612:	83 ec 0c             	sub    $0xc,%esp
80101615:	89 c7                	mov    %eax,%edi
80101617:	50                   	push   %eax
80101618:	e8 b3 0c 00 00       	call   801022d0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
8010161d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101623:	6a 34                	push   $0x34
80101625:	6a 00                	push   $0x0
80101627:	50                   	push   %eax
80101628:	57                   	push   %edi
80101629:	e8 b2 0f 00 00       	call   801025e0 <readi>
8010162e:	83 c4 20             	add    $0x20,%esp
80101631:	83 f8 34             	cmp    $0x34,%eax
80101634:	0f 85 01 01 00 00    	jne    8010173b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
8010163a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101641:	45 4c 46 
80101644:	0f 85 f1 00 00 00    	jne    8010173b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
8010164a:	e8 01 63 00 00       	call   80107950 <setupkvm>
8010164f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101655:	85 c0                	test   %eax,%eax
80101657:	0f 84 de 00 00 00    	je     8010173b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010165d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101664:	00 
80101665:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
8010166b:	0f 84 a1 02 00 00    	je     80101912 <exec+0x332>
  sz = 0;
80101671:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101678:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010167b:	31 db                	xor    %ebx,%ebx
8010167d:	e9 8c 00 00 00       	jmp    8010170e <exec+0x12e>
80101682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80101688:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
8010168f:	75 6c                	jne    801016fd <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80101691:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80101697:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
8010169d:	0f 82 87 00 00 00    	jb     8010172a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
801016a3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801016a9:	72 7f                	jb     8010172a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801016ab:	83 ec 04             	sub    $0x4,%esp
801016ae:	50                   	push   %eax
801016af:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
801016b5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801016bb:	e8 c0 60 00 00       	call   80107780 <allocuvm>
801016c0:	83 c4 10             	add    $0x10,%esp
801016c3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801016c9:	85 c0                	test   %eax,%eax
801016cb:	74 5d                	je     8010172a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
801016cd:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801016d3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801016d8:	75 50                	jne    8010172a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801016da:	83 ec 0c             	sub    $0xc,%esp
801016dd:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
801016e3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
801016e9:	57                   	push   %edi
801016ea:	50                   	push   %eax
801016eb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801016f1:	e8 ba 5f 00 00       	call   801076b0 <loaduvm>
801016f6:	83 c4 20             	add    $0x20,%esp
801016f9:	85 c0                	test   %eax,%eax
801016fb:	78 2d                	js     8010172a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801016fd:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80101704:	83 c3 01             	add    $0x1,%ebx
80101707:	83 c6 20             	add    $0x20,%esi
8010170a:	39 d8                	cmp    %ebx,%eax
8010170c:	7e 52                	jle    80101760 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
8010170e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80101714:	6a 20                	push   $0x20
80101716:	56                   	push   %esi
80101717:	50                   	push   %eax
80101718:	57                   	push   %edi
80101719:	e8 c2 0e 00 00       	call   801025e0 <readi>
8010171e:	83 c4 10             	add    $0x10,%esp
80101721:	83 f8 20             	cmp    $0x20,%eax
80101724:	0f 84 5e ff ff ff    	je     80101688 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
8010172a:	83 ec 0c             	sub    $0xc,%esp
8010172d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101733:	e8 98 61 00 00       	call   801078d0 <freevm>
  if(ip){
80101738:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010173b:	83 ec 0c             	sub    $0xc,%esp
8010173e:	57                   	push   %edi
8010173f:	e8 1c 0e 00 00       	call   80102560 <iunlockput>
    end_op();
80101744:	e8 97 21 00 00       	call   801038e0 <end_op>
80101749:	83 c4 10             	add    $0x10,%esp
    return -1;
8010174c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80101751:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101754:	5b                   	pop    %ebx
80101755:	5e                   	pop    %esi
80101756:	5f                   	pop    %edi
80101757:	5d                   	pop    %ebp
80101758:	c3                   	ret
80101759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80101760:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80101766:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
8010176c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101772:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80101778:	83 ec 0c             	sub    $0xc,%esp
8010177b:	57                   	push   %edi
8010177c:	e8 df 0d 00 00       	call   80102560 <iunlockput>
  end_op();
80101781:	e8 5a 21 00 00       	call   801038e0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101786:	83 c4 0c             	add    $0xc,%esp
80101789:	53                   	push   %ebx
8010178a:	56                   	push   %esi
8010178b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80101791:	56                   	push   %esi
80101792:	e8 e9 5f 00 00       	call   80107780 <allocuvm>
80101797:	83 c4 10             	add    $0x10,%esp
8010179a:	89 c7                	mov    %eax,%edi
8010179c:	85 c0                	test   %eax,%eax
8010179e:	0f 84 86 00 00 00    	je     8010182a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801017a4:	83 ec 08             	sub    $0x8,%esp
801017a7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
801017ad:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801017af:	50                   	push   %eax
801017b0:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
801017b1:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801017b3:	e8 38 62 00 00       	call   801079f0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
801017b8:	8b 45 0c             	mov    0xc(%ebp),%eax
801017bb:	83 c4 10             	add    $0x10,%esp
801017be:	8b 10                	mov    (%eax),%edx
801017c0:	85 d2                	test   %edx,%edx
801017c2:	0f 84 56 01 00 00    	je     8010191e <exec+0x33e>
801017c8:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
801017ce:	8b 7d 0c             	mov    0xc(%ebp),%edi
801017d1:	eb 23                	jmp    801017f6 <exec+0x216>
801017d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801017d8:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
801017db:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
801017e2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
801017e8:	8b 14 87             	mov    (%edi,%eax,4),%edx
801017eb:	85 d2                	test   %edx,%edx
801017ed:	74 51                	je     80101840 <exec+0x260>
    if(argc >= MAXARG)
801017ef:	83 f8 20             	cmp    $0x20,%eax
801017f2:	74 36                	je     8010182a <exec+0x24a>
801017f4:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801017f6:	83 ec 0c             	sub    $0xc,%esp
801017f9:	52                   	push   %edx
801017fa:	e8 c1 3b 00 00       	call   801053c0 <strlen>
801017ff:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101801:	58                   	pop    %eax
80101802:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101805:	83 eb 01             	sub    $0x1,%ebx
80101808:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010180b:	e8 b0 3b 00 00       	call   801053c0 <strlen>
80101810:	83 c0 01             	add    $0x1,%eax
80101813:	50                   	push   %eax
80101814:	ff 34 b7             	push   (%edi,%esi,4)
80101817:	53                   	push   %ebx
80101818:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010181e:	e8 9d 63 00 00       	call   80107bc0 <copyout>
80101823:	83 c4 20             	add    $0x20,%esp
80101826:	85 c0                	test   %eax,%eax
80101828:	79 ae                	jns    801017d8 <exec+0x1f8>
    freevm(pgdir);
8010182a:	83 ec 0c             	sub    $0xc,%esp
8010182d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101833:	e8 98 60 00 00       	call   801078d0 <freevm>
80101838:	83 c4 10             	add    $0x10,%esp
8010183b:	e9 0c ff ff ff       	jmp    8010174c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101840:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80101847:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
8010184d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101853:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80101856:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80101859:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80101860:	00 00 00 00 
  ustack[1] = argc;
80101864:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
8010186a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101871:	ff ff ff 
  ustack[1] = argc;
80101874:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010187a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
8010187c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010187e:	29 d0                	sub    %edx,%eax
80101880:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101886:	56                   	push   %esi
80101887:	51                   	push   %ecx
80101888:	53                   	push   %ebx
80101889:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010188f:	e8 2c 63 00 00       	call   80107bc0 <copyout>
80101894:	83 c4 10             	add    $0x10,%esp
80101897:	85 c0                	test   %eax,%eax
80101899:	78 8f                	js     8010182a <exec+0x24a>
  for(last=s=path; *s; s++)
8010189b:	8b 45 08             	mov    0x8(%ebp),%eax
8010189e:	8b 55 08             	mov    0x8(%ebp),%edx
801018a1:	0f b6 00             	movzbl (%eax),%eax
801018a4:	84 c0                	test   %al,%al
801018a6:	74 17                	je     801018bf <exec+0x2df>
801018a8:	89 d1                	mov    %edx,%ecx
801018aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
801018b0:	83 c1 01             	add    $0x1,%ecx
801018b3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
801018b5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
801018b8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
801018bb:	84 c0                	test   %al,%al
801018bd:	75 f1                	jne    801018b0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
801018bf:	83 ec 04             	sub    $0x4,%esp
801018c2:	6a 10                	push   $0x10
801018c4:	52                   	push   %edx
801018c5:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
801018cb:	8d 46 6c             	lea    0x6c(%esi),%eax
801018ce:	50                   	push   %eax
801018cf:	e8 ac 3a 00 00       	call   80105380 <safestrcpy>
  curproc->pgdir = pgdir;
801018d4:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
801018da:	89 f0                	mov    %esi,%eax
801018dc:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
801018df:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
801018e1:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
801018e4:	89 c1                	mov    %eax,%ecx
801018e6:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
801018ec:	8b 40 18             	mov    0x18(%eax),%eax
801018ef:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
801018f2:	8b 41 18             	mov    0x18(%ecx),%eax
801018f5:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
801018f8:	89 0c 24             	mov    %ecx,(%esp)
801018fb:	e8 20 5c 00 00       	call   80107520 <switchuvm>
  freevm(oldpgdir);
80101900:	89 34 24             	mov    %esi,(%esp)
80101903:	e8 c8 5f 00 00       	call   801078d0 <freevm>
  return 0;
80101908:	83 c4 10             	add    $0x10,%esp
8010190b:	31 c0                	xor    %eax,%eax
8010190d:	e9 3f fe ff ff       	jmp    80101751 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101912:	bb 00 20 00 00       	mov    $0x2000,%ebx
80101917:	31 f6                	xor    %esi,%esi
80101919:	e9 5a fe ff ff       	jmp    80101778 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
8010191e:	be 10 00 00 00       	mov    $0x10,%esi
80101923:	ba 04 00 00 00       	mov    $0x4,%edx
80101928:	b8 03 00 00 00       	mov    $0x3,%eax
8010192d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101934:	00 00 00 
80101937:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
8010193d:	e9 17 ff ff ff       	jmp    80101859 <exec+0x279>
    end_op();
80101942:	e8 99 1f 00 00       	call   801038e0 <end_op>
    cprintf("exec: fail\n");
80101947:	83 ec 0c             	sub    $0xc,%esp
8010194a:	68 12 7d 10 80       	push   $0x80107d12
8010194f:	e8 6c ef ff ff       	call   801008c0 <cprintf>
    return -1;
80101954:	83 c4 10             	add    $0x10,%esp
80101957:	e9 f0 fd ff ff       	jmp    8010174c <exec+0x16c>
8010195c:	66 90                	xchg   %ax,%ax
8010195e:	66 90                	xchg   %ax,%ax

80101960 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101966:	68 1e 7d 10 80       	push   $0x80107d1e
8010196b:	68 60 ff 10 80       	push   $0x8010ff60
80101970:	e8 6b 35 00 00       	call   80104ee0 <initlock>
}
80101975:	83 c4 10             	add    $0x10,%esp
80101978:	c9                   	leave
80101979:	c3                   	ret
8010197a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101980 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101984:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80101989:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
8010198c:	68 60 ff 10 80       	push   $0x8010ff60
80101991:	e8 3a 37 00 00       	call   801050d0 <acquire>
80101996:	83 c4 10             	add    $0x10,%esp
80101999:	eb 10                	jmp    801019ab <filealloc+0x2b>
8010199b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801019a0:	83 c3 18             	add    $0x18,%ebx
801019a3:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
801019a9:	74 25                	je     801019d0 <filealloc+0x50>
    if(f->ref == 0){
801019ab:	8b 43 04             	mov    0x4(%ebx),%eax
801019ae:	85 c0                	test   %eax,%eax
801019b0:	75 ee                	jne    801019a0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
801019b2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
801019b5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
801019bc:	68 60 ff 10 80       	push   $0x8010ff60
801019c1:	e8 aa 36 00 00       	call   80105070 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
801019c6:	89 d8                	mov    %ebx,%eax
      return f;
801019c8:	83 c4 10             	add    $0x10,%esp
}
801019cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019ce:	c9                   	leave
801019cf:	c3                   	ret
  release(&ftable.lock);
801019d0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801019d3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
801019d5:	68 60 ff 10 80       	push   $0x8010ff60
801019da:	e8 91 36 00 00       	call   80105070 <release>
}
801019df:	89 d8                	mov    %ebx,%eax
  return 0;
801019e1:	83 c4 10             	add    $0x10,%esp
}
801019e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019e7:	c9                   	leave
801019e8:	c3                   	ret
801019e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801019f0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	53                   	push   %ebx
801019f4:	83 ec 10             	sub    $0x10,%esp
801019f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
801019fa:	68 60 ff 10 80       	push   $0x8010ff60
801019ff:	e8 cc 36 00 00       	call   801050d0 <acquire>
  if(f->ref < 1)
80101a04:	8b 43 04             	mov    0x4(%ebx),%eax
80101a07:	83 c4 10             	add    $0x10,%esp
80101a0a:	85 c0                	test   %eax,%eax
80101a0c:	7e 1a                	jle    80101a28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101a0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101a11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101a14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101a17:	68 60 ff 10 80       	push   $0x8010ff60
80101a1c:	e8 4f 36 00 00       	call   80105070 <release>
  return f;
}
80101a21:	89 d8                	mov    %ebx,%eax
80101a23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a26:	c9                   	leave
80101a27:	c3                   	ret
    panic("filedup");
80101a28:	83 ec 0c             	sub    $0xc,%esp
80101a2b:	68 25 7d 10 80       	push   $0x80107d25
80101a30:	e8 db f0 ff ff       	call   80100b10 <panic>
80101a35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a3c:	00 
80101a3d:	8d 76 00             	lea    0x0(%esi),%esi

80101a40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	57                   	push   %edi
80101a44:	56                   	push   %esi
80101a45:	53                   	push   %ebx
80101a46:	83 ec 28             	sub    $0x28,%esp
80101a49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101a4c:	68 60 ff 10 80       	push   $0x8010ff60
80101a51:	e8 7a 36 00 00       	call   801050d0 <acquire>
  if(f->ref < 1)
80101a56:	8b 53 04             	mov    0x4(%ebx),%edx
80101a59:	83 c4 10             	add    $0x10,%esp
80101a5c:	85 d2                	test   %edx,%edx
80101a5e:	0f 8e a5 00 00 00    	jle    80101b09 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101a64:	83 ea 01             	sub    $0x1,%edx
80101a67:	89 53 04             	mov    %edx,0x4(%ebx)
80101a6a:	75 44                	jne    80101ab0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101a6c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101a70:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101a73:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101a75:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80101a7b:	8b 73 0c             	mov    0xc(%ebx),%esi
80101a7e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101a81:	8b 43 10             	mov    0x10(%ebx),%eax
80101a84:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101a87:	68 60 ff 10 80       	push   $0x8010ff60
80101a8c:	e8 df 35 00 00       	call   80105070 <release>

  if(ff.type == FD_PIPE)
80101a91:	83 c4 10             	add    $0x10,%esp
80101a94:	83 ff 01             	cmp    $0x1,%edi
80101a97:	74 57                	je     80101af0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101a99:	83 ff 02             	cmp    $0x2,%edi
80101a9c:	74 2a                	je     80101ac8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101a9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101aa1:	5b                   	pop    %ebx
80101aa2:	5e                   	pop    %esi
80101aa3:	5f                   	pop    %edi
80101aa4:	5d                   	pop    %ebp
80101aa5:	c3                   	ret
80101aa6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101aad:	00 
80101aae:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80101ab0:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80101ab7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101aba:	5b                   	pop    %ebx
80101abb:	5e                   	pop    %esi
80101abc:	5f                   	pop    %edi
80101abd:	5d                   	pop    %ebp
    release(&ftable.lock);
80101abe:	e9 ad 35 00 00       	jmp    80105070 <release>
80101ac3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101ac8:	e8 a3 1d 00 00       	call   80103870 <begin_op>
    iput(ff.ip);
80101acd:	83 ec 0c             	sub    $0xc,%esp
80101ad0:	ff 75 e0             	push   -0x20(%ebp)
80101ad3:	e8 28 09 00 00       	call   80102400 <iput>
    end_op();
80101ad8:	83 c4 10             	add    $0x10,%esp
}
80101adb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ade:	5b                   	pop    %ebx
80101adf:	5e                   	pop    %esi
80101ae0:	5f                   	pop    %edi
80101ae1:	5d                   	pop    %ebp
    end_op();
80101ae2:	e9 f9 1d 00 00       	jmp    801038e0 <end_op>
80101ae7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101aee:	00 
80101aef:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101af0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101af4:	83 ec 08             	sub    $0x8,%esp
80101af7:	53                   	push   %ebx
80101af8:	56                   	push   %esi
80101af9:	e8 32 25 00 00       	call   80104030 <pipeclose>
80101afe:	83 c4 10             	add    $0x10,%esp
}
80101b01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b04:	5b                   	pop    %ebx
80101b05:	5e                   	pop    %esi
80101b06:	5f                   	pop    %edi
80101b07:	5d                   	pop    %ebp
80101b08:	c3                   	ret
    panic("fileclose");
80101b09:	83 ec 0c             	sub    $0xc,%esp
80101b0c:	68 2d 7d 10 80       	push   $0x80107d2d
80101b11:	e8 fa ef ff ff       	call   80100b10 <panic>
80101b16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b1d:	00 
80101b1e:	66 90                	xchg   %ax,%ax

80101b20 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	53                   	push   %ebx
80101b24:	83 ec 04             	sub    $0x4,%esp
80101b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80101b2a:	83 3b 02             	cmpl   $0x2,(%ebx)
80101b2d:	75 31                	jne    80101b60 <filestat+0x40>
    ilock(f->ip);
80101b2f:	83 ec 0c             	sub    $0xc,%esp
80101b32:	ff 73 10             	push   0x10(%ebx)
80101b35:	e8 96 07 00 00       	call   801022d0 <ilock>
    stati(f->ip, st);
80101b3a:	58                   	pop    %eax
80101b3b:	5a                   	pop    %edx
80101b3c:	ff 75 0c             	push   0xc(%ebp)
80101b3f:	ff 73 10             	push   0x10(%ebx)
80101b42:	e8 69 0a 00 00       	call   801025b0 <stati>
    iunlock(f->ip);
80101b47:	59                   	pop    %ecx
80101b48:	ff 73 10             	push   0x10(%ebx)
80101b4b:	e8 60 08 00 00       	call   801023b0 <iunlock>
    return 0;
  }
  return -1;
}
80101b50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101b53:	83 c4 10             	add    $0x10,%esp
80101b56:	31 c0                	xor    %eax,%eax
}
80101b58:	c9                   	leave
80101b59:	c3                   	ret
80101b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101b60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101b63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101b68:	c9                   	leave
80101b69:	c3                   	ret
80101b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b70 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	56                   	push   %esi
80101b75:	53                   	push   %ebx
80101b76:	83 ec 0c             	sub    $0xc,%esp
80101b79:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101b7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b7f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101b82:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101b86:	74 60                	je     80101be8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101b88:	8b 03                	mov    (%ebx),%eax
80101b8a:	83 f8 01             	cmp    $0x1,%eax
80101b8d:	74 41                	je     80101bd0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101b8f:	83 f8 02             	cmp    $0x2,%eax
80101b92:	75 5b                	jne    80101bef <fileread+0x7f>
    ilock(f->ip);
80101b94:	83 ec 0c             	sub    $0xc,%esp
80101b97:	ff 73 10             	push   0x10(%ebx)
80101b9a:	e8 31 07 00 00       	call   801022d0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101b9f:	57                   	push   %edi
80101ba0:	ff 73 14             	push   0x14(%ebx)
80101ba3:	56                   	push   %esi
80101ba4:	ff 73 10             	push   0x10(%ebx)
80101ba7:	e8 34 0a 00 00       	call   801025e0 <readi>
80101bac:	83 c4 20             	add    $0x20,%esp
80101baf:	89 c6                	mov    %eax,%esi
80101bb1:	85 c0                	test   %eax,%eax
80101bb3:	7e 03                	jle    80101bb8 <fileread+0x48>
      f->off += r;
80101bb5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101bb8:	83 ec 0c             	sub    $0xc,%esp
80101bbb:	ff 73 10             	push   0x10(%ebx)
80101bbe:	e8 ed 07 00 00       	call   801023b0 <iunlock>
    return r;
80101bc3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101bc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bc9:	89 f0                	mov    %esi,%eax
80101bcb:	5b                   	pop    %ebx
80101bcc:	5e                   	pop    %esi
80101bcd:	5f                   	pop    %edi
80101bce:	5d                   	pop    %ebp
80101bcf:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101bd0:	8b 43 0c             	mov    0xc(%ebx),%eax
80101bd3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101bd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bd9:	5b                   	pop    %ebx
80101bda:	5e                   	pop    %esi
80101bdb:	5f                   	pop    %edi
80101bdc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101bdd:	e9 0e 26 00 00       	jmp    801041f0 <piperead>
80101be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101be8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101bed:	eb d7                	jmp    80101bc6 <fileread+0x56>
  panic("fileread");
80101bef:	83 ec 0c             	sub    $0xc,%esp
80101bf2:	68 37 7d 10 80       	push   $0x80107d37
80101bf7:	e8 14 ef ff ff       	call   80100b10 <panic>
80101bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c00 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	57                   	push   %edi
80101c04:	56                   	push   %esi
80101c05:	53                   	push   %ebx
80101c06:	83 ec 1c             	sub    $0x1c,%esp
80101c09:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c0c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c0f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101c12:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101c15:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101c19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101c1c:	0f 84 bb 00 00 00    	je     80101cdd <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101c22:	8b 03                	mov    (%ebx),%eax
80101c24:	83 f8 01             	cmp    $0x1,%eax
80101c27:	0f 84 bf 00 00 00    	je     80101cec <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101c2d:	83 f8 02             	cmp    $0x2,%eax
80101c30:	0f 85 c8 00 00 00    	jne    80101cfe <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101c36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101c39:	31 f6                	xor    %esi,%esi
    while(i < n){
80101c3b:	85 c0                	test   %eax,%eax
80101c3d:	7f 30                	jg     80101c6f <filewrite+0x6f>
80101c3f:	e9 94 00 00 00       	jmp    80101cd8 <filewrite+0xd8>
80101c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101c48:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
80101c4b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
80101c4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101c51:	ff 73 10             	push   0x10(%ebx)
80101c54:	e8 57 07 00 00       	call   801023b0 <iunlock>
      end_op();
80101c59:	e8 82 1c 00 00       	call   801038e0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101c5e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101c61:	83 c4 10             	add    $0x10,%esp
80101c64:	39 c7                	cmp    %eax,%edi
80101c66:	75 5c                	jne    80101cc4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101c68:	01 fe                	add    %edi,%esi
    while(i < n){
80101c6a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101c6d:	7e 69                	jle    80101cd8 <filewrite+0xd8>
      int n1 = n - i;
80101c6f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101c72:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101c77:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101c79:	39 c7                	cmp    %eax,%edi
80101c7b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
80101c7e:	e8 ed 1b 00 00       	call   80103870 <begin_op>
      ilock(f->ip);
80101c83:	83 ec 0c             	sub    $0xc,%esp
80101c86:	ff 73 10             	push   0x10(%ebx)
80101c89:	e8 42 06 00 00       	call   801022d0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101c8e:	57                   	push   %edi
80101c8f:	ff 73 14             	push   0x14(%ebx)
80101c92:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101c95:	01 f0                	add    %esi,%eax
80101c97:	50                   	push   %eax
80101c98:	ff 73 10             	push   0x10(%ebx)
80101c9b:	e8 40 0a 00 00       	call   801026e0 <writei>
80101ca0:	83 c4 20             	add    $0x20,%esp
80101ca3:	85 c0                	test   %eax,%eax
80101ca5:	7f a1                	jg     80101c48 <filewrite+0x48>
80101ca7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101caa:	83 ec 0c             	sub    $0xc,%esp
80101cad:	ff 73 10             	push   0x10(%ebx)
80101cb0:	e8 fb 06 00 00       	call   801023b0 <iunlock>
      end_op();
80101cb5:	e8 26 1c 00 00       	call   801038e0 <end_op>
      if(r < 0)
80101cba:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101cbd:	83 c4 10             	add    $0x10,%esp
80101cc0:	85 c0                	test   %eax,%eax
80101cc2:	75 14                	jne    80101cd8 <filewrite+0xd8>
        panic("short filewrite");
80101cc4:	83 ec 0c             	sub    $0xc,%esp
80101cc7:	68 40 7d 10 80       	push   $0x80107d40
80101ccc:	e8 3f ee ff ff       	call   80100b10 <panic>
80101cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101cd8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101cdb:	74 05                	je     80101ce2 <filewrite+0xe2>
80101cdd:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101ce2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ce5:	89 f0                	mov    %esi,%eax
80101ce7:	5b                   	pop    %ebx
80101ce8:	5e                   	pop    %esi
80101ce9:	5f                   	pop    %edi
80101cea:	5d                   	pop    %ebp
80101ceb:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
80101cec:	8b 43 0c             	mov    0xc(%ebx),%eax
80101cef:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101cf2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cf5:	5b                   	pop    %ebx
80101cf6:	5e                   	pop    %esi
80101cf7:	5f                   	pop    %edi
80101cf8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101cf9:	e9 d2 23 00 00       	jmp    801040d0 <pipewrite>
  panic("filewrite");
80101cfe:	83 ec 0c             	sub    $0xc,%esp
80101d01:	68 46 7d 10 80       	push   $0x80107d46
80101d06:	e8 05 ee ff ff       	call   80100b10 <panic>
80101d0b:	66 90                	xchg   %ax,%ax
80101d0d:	66 90                	xchg   %ax,%ax
80101d0f:	90                   	nop

80101d10 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101d10:	55                   	push   %ebp
80101d11:	89 e5                	mov    %esp,%ebp
80101d13:	57                   	push   %edi
80101d14:	56                   	push   %esi
80101d15:	53                   	push   %ebx
80101d16:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101d19:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
80101d1f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101d22:	85 c9                	test   %ecx,%ecx
80101d24:	0f 84 8c 00 00 00    	je     80101db6 <balloc+0xa6>
80101d2a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
80101d2c:	89 f8                	mov    %edi,%eax
80101d2e:	83 ec 08             	sub    $0x8,%esp
80101d31:	89 fe                	mov    %edi,%esi
80101d33:	c1 f8 0c             	sar    $0xc,%eax
80101d36:	03 05 cc 25 11 80    	add    0x801125cc,%eax
80101d3c:	50                   	push   %eax
80101d3d:	ff 75 dc             	push   -0x24(%ebp)
80101d40:	e8 8b e3 ff ff       	call   801000d0 <bread>
80101d45:	83 c4 10             	add    $0x10,%esp
80101d48:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101d4b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101d4e:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101d53:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101d56:	31 c0                	xor    %eax,%eax
80101d58:	eb 32                	jmp    80101d8c <balloc+0x7c>
80101d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101d60:	89 c1                	mov    %eax,%ecx
80101d62:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101d67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
80101d6a:	83 e1 07             	and    $0x7,%ecx
80101d6d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101d6f:	89 c1                	mov    %eax,%ecx
80101d71:	c1 f9 03             	sar    $0x3,%ecx
80101d74:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101d79:	89 fa                	mov    %edi,%edx
80101d7b:	85 df                	test   %ebx,%edi
80101d7d:	74 49                	je     80101dc8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101d7f:	83 c0 01             	add    $0x1,%eax
80101d82:	83 c6 01             	add    $0x1,%esi
80101d85:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101d8a:	74 07                	je     80101d93 <balloc+0x83>
80101d8c:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d8f:	39 d6                	cmp    %edx,%esi
80101d91:	72 cd                	jb     80101d60 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101d93:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101d96:	83 ec 0c             	sub    $0xc,%esp
80101d99:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101d9c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101da2:	e8 49 e4 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101da7:	83 c4 10             	add    $0x10,%esp
80101daa:	3b 3d b4 25 11 80    	cmp    0x801125b4,%edi
80101db0:	0f 82 76 ff ff ff    	jb     80101d2c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101db6:	83 ec 0c             	sub    $0xc,%esp
80101db9:	68 50 7d 10 80       	push   $0x80107d50
80101dbe:	e8 4d ed ff ff       	call   80100b10 <panic>
80101dc3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101dc8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101dcb:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101dce:	09 da                	or     %ebx,%edx
80101dd0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101dd4:	57                   	push   %edi
80101dd5:	e8 76 1c 00 00       	call   80103a50 <log_write>
        brelse(bp);
80101dda:	89 3c 24             	mov    %edi,(%esp)
80101ddd:	e8 0e e4 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101de2:	58                   	pop    %eax
80101de3:	5a                   	pop    %edx
80101de4:	56                   	push   %esi
80101de5:	ff 75 dc             	push   -0x24(%ebp)
80101de8:	e8 e3 e2 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101ded:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101df0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101df2:	8d 40 5c             	lea    0x5c(%eax),%eax
80101df5:	68 00 02 00 00       	push   $0x200
80101dfa:	6a 00                	push   $0x0
80101dfc:	50                   	push   %eax
80101dfd:	e8 ce 33 00 00       	call   801051d0 <memset>
  log_write(bp);
80101e02:	89 1c 24             	mov    %ebx,(%esp)
80101e05:	e8 46 1c 00 00       	call   80103a50 <log_write>
  brelse(bp);
80101e0a:	89 1c 24             	mov    %ebx,(%esp)
80101e0d:	e8 de e3 ff ff       	call   801001f0 <brelse>
}
80101e12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e15:	89 f0                	mov    %esi,%eax
80101e17:	5b                   	pop    %ebx
80101e18:	5e                   	pop    %esi
80101e19:	5f                   	pop    %edi
80101e1a:	5d                   	pop    %ebp
80101e1b:	c3                   	ret
80101e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e20 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101e24:	31 ff                	xor    %edi,%edi
{
80101e26:	56                   	push   %esi
80101e27:	89 c6                	mov    %eax,%esi
80101e29:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101e2a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
80101e2f:	83 ec 28             	sub    $0x28,%esp
80101e32:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101e35:	68 60 09 11 80       	push   $0x80110960
80101e3a:	e8 91 32 00 00       	call   801050d0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101e3f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101e42:	83 c4 10             	add    $0x10,%esp
80101e45:	eb 1b                	jmp    80101e62 <iget+0x42>
80101e47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e4e:	00 
80101e4f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101e50:	39 33                	cmp    %esi,(%ebx)
80101e52:	74 6c                	je     80101ec0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101e54:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101e5a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101e60:	74 26                	je     80101e88 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101e62:	8b 43 08             	mov    0x8(%ebx),%eax
80101e65:	85 c0                	test   %eax,%eax
80101e67:	7f e7                	jg     80101e50 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101e69:	85 ff                	test   %edi,%edi
80101e6b:	75 e7                	jne    80101e54 <iget+0x34>
80101e6d:	85 c0                	test   %eax,%eax
80101e6f:	75 76                	jne    80101ee7 <iget+0xc7>
      empty = ip;
80101e71:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101e73:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101e79:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101e7f:	75 e1                	jne    80101e62 <iget+0x42>
80101e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101e88:	85 ff                	test   %edi,%edi
80101e8a:	74 79                	je     80101f05 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101e8c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101e8f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101e91:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101e94:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
80101e9b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80101ea2:	68 60 09 11 80       	push   $0x80110960
80101ea7:	e8 c4 31 00 00       	call   80105070 <release>

  return ip;
80101eac:	83 c4 10             	add    $0x10,%esp
}
80101eaf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eb2:	89 f8                	mov    %edi,%eax
80101eb4:	5b                   	pop    %ebx
80101eb5:	5e                   	pop    %esi
80101eb6:	5f                   	pop    %edi
80101eb7:	5d                   	pop    %ebp
80101eb8:	c3                   	ret
80101eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101ec0:	39 53 04             	cmp    %edx,0x4(%ebx)
80101ec3:	75 8f                	jne    80101e54 <iget+0x34>
      ip->ref++;
80101ec5:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80101ec8:	83 ec 0c             	sub    $0xc,%esp
      return ip;
80101ecb:	89 df                	mov    %ebx,%edi
      ip->ref++;
80101ecd:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101ed0:	68 60 09 11 80       	push   $0x80110960
80101ed5:	e8 96 31 00 00       	call   80105070 <release>
      return ip;
80101eda:	83 c4 10             	add    $0x10,%esp
}
80101edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ee0:	89 f8                	mov    %edi,%eax
80101ee2:	5b                   	pop    %ebx
80101ee3:	5e                   	pop    %esi
80101ee4:	5f                   	pop    %edi
80101ee5:	5d                   	pop    %ebp
80101ee6:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101ee7:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101eed:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101ef3:	74 10                	je     80101f05 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101ef5:	8b 43 08             	mov    0x8(%ebx),%eax
80101ef8:	85 c0                	test   %eax,%eax
80101efa:	0f 8f 50 ff ff ff    	jg     80101e50 <iget+0x30>
80101f00:	e9 68 ff ff ff       	jmp    80101e6d <iget+0x4d>
    panic("iget: no inodes");
80101f05:	83 ec 0c             	sub    $0xc,%esp
80101f08:	68 66 7d 10 80       	push   $0x80107d66
80101f0d:	e8 fe eb ff ff       	call   80100b10 <panic>
80101f12:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f19:	00 
80101f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f20 <bfree>:
{
80101f20:	55                   	push   %ebp
80101f21:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101f23:	89 d0                	mov    %edx,%eax
80101f25:	c1 e8 0c             	shr    $0xc,%eax
{
80101f28:	89 e5                	mov    %esp,%ebp
80101f2a:	56                   	push   %esi
80101f2b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
80101f2c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
80101f32:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101f34:	83 ec 08             	sub    $0x8,%esp
80101f37:	50                   	push   %eax
80101f38:	51                   	push   %ecx
80101f39:	e8 92 e1 ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101f3e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101f40:	c1 fb 03             	sar    $0x3,%ebx
80101f43:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101f46:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101f48:	83 e1 07             	and    $0x7,%ecx
80101f4b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101f50:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101f56:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101f58:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101f5d:	85 c1                	test   %eax,%ecx
80101f5f:	74 23                	je     80101f84 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101f61:	f7 d0                	not    %eax
  log_write(bp);
80101f63:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101f66:	21 c8                	and    %ecx,%eax
80101f68:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
80101f6c:	56                   	push   %esi
80101f6d:	e8 de 1a 00 00       	call   80103a50 <log_write>
  brelse(bp);
80101f72:	89 34 24             	mov    %esi,(%esp)
80101f75:	e8 76 e2 ff ff       	call   801001f0 <brelse>
}
80101f7a:	83 c4 10             	add    $0x10,%esp
80101f7d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f80:	5b                   	pop    %ebx
80101f81:	5e                   	pop    %esi
80101f82:	5d                   	pop    %ebp
80101f83:	c3                   	ret
    panic("freeing free block");
80101f84:	83 ec 0c             	sub    $0xc,%esp
80101f87:	68 76 7d 10 80       	push   $0x80107d76
80101f8c:	e8 7f eb ff ff       	call   80100b10 <panic>
80101f91:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f98:	00 
80101f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fa0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101fa0:	55                   	push   %ebp
80101fa1:	89 e5                	mov    %esp,%ebp
80101fa3:	57                   	push   %edi
80101fa4:	56                   	push   %esi
80101fa5:	89 c6                	mov    %eax,%esi
80101fa7:	53                   	push   %ebx
80101fa8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101fab:	83 fa 0b             	cmp    $0xb,%edx
80101fae:	0f 86 8c 00 00 00    	jbe    80102040 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101fb4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101fb7:	83 fb 7f             	cmp    $0x7f,%ebx
80101fba:	0f 87 a2 00 00 00    	ja     80102062 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101fc0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101fc6:	85 c0                	test   %eax,%eax
80101fc8:	74 5e                	je     80102028 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101fca:	83 ec 08             	sub    $0x8,%esp
80101fcd:	50                   	push   %eax
80101fce:	ff 36                	push   (%esi)
80101fd0:	e8 fb e0 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101fd5:	83 c4 10             	add    $0x10,%esp
80101fd8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
80101fdc:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
80101fde:	8b 3b                	mov    (%ebx),%edi
80101fe0:	85 ff                	test   %edi,%edi
80101fe2:	74 1c                	je     80102000 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101fe4:	83 ec 0c             	sub    $0xc,%esp
80101fe7:	52                   	push   %edx
80101fe8:	e8 03 e2 ff ff       	call   801001f0 <brelse>
80101fed:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ff3:	89 f8                	mov    %edi,%eax
80101ff5:	5b                   	pop    %ebx
80101ff6:	5e                   	pop    %esi
80101ff7:	5f                   	pop    %edi
80101ff8:	5d                   	pop    %ebp
80101ff9:	c3                   	ret
80101ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102000:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80102003:	8b 06                	mov    (%esi),%eax
80102005:	e8 06 fd ff ff       	call   80101d10 <balloc>
      log_write(bp);
8010200a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010200d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80102010:	89 03                	mov    %eax,(%ebx)
80102012:	89 c7                	mov    %eax,%edi
      log_write(bp);
80102014:	52                   	push   %edx
80102015:	e8 36 1a 00 00       	call   80103a50 <log_write>
8010201a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010201d:	83 c4 10             	add    $0x10,%esp
80102020:	eb c2                	jmp    80101fe4 <bmap+0x44>
80102022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80102028:	8b 06                	mov    (%esi),%eax
8010202a:	e8 e1 fc ff ff       	call   80101d10 <balloc>
8010202f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102035:	eb 93                	jmp    80101fca <bmap+0x2a>
80102037:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010203e:	00 
8010203f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80102040:	8d 5a 14             	lea    0x14(%edx),%ebx
80102043:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80102047:	85 ff                	test   %edi,%edi
80102049:	75 a5                	jne    80101ff0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010204b:	8b 00                	mov    (%eax),%eax
8010204d:	e8 be fc ff ff       	call   80101d10 <balloc>
80102052:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102056:	89 c7                	mov    %eax,%edi
}
80102058:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010205b:	5b                   	pop    %ebx
8010205c:	89 f8                	mov    %edi,%eax
8010205e:	5e                   	pop    %esi
8010205f:	5f                   	pop    %edi
80102060:	5d                   	pop    %ebp
80102061:	c3                   	ret
  panic("bmap: out of range");
80102062:	83 ec 0c             	sub    $0xc,%esp
80102065:	68 89 7d 10 80       	push   $0x80107d89
8010206a:	e8 a1 ea ff ff       	call   80100b10 <panic>
8010206f:	90                   	nop

80102070 <readsb>:
{
80102070:	55                   	push   %ebp
80102071:	89 e5                	mov    %esp,%ebp
80102073:	56                   	push   %esi
80102074:	53                   	push   %ebx
80102075:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102078:	83 ec 08             	sub    $0x8,%esp
8010207b:	6a 01                	push   $0x1
8010207d:	ff 75 08             	push   0x8(%ebp)
80102080:	e8 4b e0 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102085:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102088:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010208a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010208d:	6a 1c                	push   $0x1c
8010208f:	50                   	push   %eax
80102090:	56                   	push   %esi
80102091:	e8 ca 31 00 00       	call   80105260 <memmove>
  brelse(bp);
80102096:	83 c4 10             	add    $0x10,%esp
80102099:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010209c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010209f:	5b                   	pop    %ebx
801020a0:	5e                   	pop    %esi
801020a1:	5d                   	pop    %ebp
  brelse(bp);
801020a2:	e9 49 e1 ff ff       	jmp    801001f0 <brelse>
801020a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020ae:	00 
801020af:	90                   	nop

801020b0 <iinit>:
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	53                   	push   %ebx
801020b4:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
801020b9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801020bc:	68 9c 7d 10 80       	push   $0x80107d9c
801020c1:	68 60 09 11 80       	push   $0x80110960
801020c6:	e8 15 2e 00 00       	call   80104ee0 <initlock>
  for(i = 0; i < NINODE; i++) {
801020cb:	83 c4 10             	add    $0x10,%esp
801020ce:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801020d0:	83 ec 08             	sub    $0x8,%esp
801020d3:	68 a3 7d 10 80       	push   $0x80107da3
801020d8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801020d9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801020df:	e8 cc 2c 00 00       	call   80104db0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801020e4:	83 c4 10             	add    $0x10,%esp
801020e7:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
801020ed:	75 e1                	jne    801020d0 <iinit+0x20>
  bp = bread(dev, 1);
801020ef:	83 ec 08             	sub    $0x8,%esp
801020f2:	6a 01                	push   $0x1
801020f4:	ff 75 08             	push   0x8(%ebp)
801020f7:	e8 d4 df ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801020fc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801020ff:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80102101:	8d 40 5c             	lea    0x5c(%eax),%eax
80102104:	6a 1c                	push   $0x1c
80102106:	50                   	push   %eax
80102107:	68 b4 25 11 80       	push   $0x801125b4
8010210c:	e8 4f 31 00 00       	call   80105260 <memmove>
  brelse(bp);
80102111:	89 1c 24             	mov    %ebx,(%esp)
80102114:	e8 d7 e0 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80102119:	ff 35 cc 25 11 80    	push   0x801125cc
8010211f:	ff 35 c8 25 11 80    	push   0x801125c8
80102125:	ff 35 c4 25 11 80    	push   0x801125c4
8010212b:	ff 35 c0 25 11 80    	push   0x801125c0
80102131:	ff 35 bc 25 11 80    	push   0x801125bc
80102137:	ff 35 b8 25 11 80    	push   0x801125b8
8010213d:	ff 35 b4 25 11 80    	push   0x801125b4
80102143:	68 24 82 10 80       	push   $0x80108224
80102148:	e8 73 e7 ff ff       	call   801008c0 <cprintf>
}
8010214d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102150:	83 c4 30             	add    $0x30,%esp
80102153:	c9                   	leave
80102154:	c3                   	ret
80102155:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010215c:	00 
8010215d:	8d 76 00             	lea    0x0(%esi),%esi

80102160 <ialloc>:
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	57                   	push   %edi
80102164:	56                   	push   %esi
80102165:	53                   	push   %ebx
80102166:	83 ec 1c             	sub    $0x1c,%esp
80102169:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010216c:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80102173:	8b 75 08             	mov    0x8(%ebp),%esi
80102176:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102179:	0f 86 91 00 00 00    	jbe    80102210 <ialloc+0xb0>
8010217f:	bf 01 00 00 00       	mov    $0x1,%edi
80102184:	eb 21                	jmp    801021a7 <ialloc+0x47>
80102186:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010218d:	00 
8010218e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80102190:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102193:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102196:	53                   	push   %ebx
80102197:	e8 54 e0 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010219c:	83 c4 10             	add    $0x10,%esp
8010219f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
801021a5:	73 69                	jae    80102210 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801021a7:	89 f8                	mov    %edi,%eax
801021a9:	83 ec 08             	sub    $0x8,%esp
801021ac:	c1 e8 03             	shr    $0x3,%eax
801021af:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801021b5:	50                   	push   %eax
801021b6:	56                   	push   %esi
801021b7:	e8 14 df ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801021bc:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801021bf:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801021c1:	89 f8                	mov    %edi,%eax
801021c3:	83 e0 07             	and    $0x7,%eax
801021c6:	c1 e0 06             	shl    $0x6,%eax
801021c9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801021cd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801021d1:	75 bd                	jne    80102190 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801021d3:	83 ec 04             	sub    $0x4,%esp
801021d6:	6a 40                	push   $0x40
801021d8:	6a 00                	push   $0x0
801021da:	51                   	push   %ecx
801021db:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801021de:	e8 ed 2f 00 00       	call   801051d0 <memset>
      dip->type = type;
801021e3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801021e7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801021ea:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801021ed:	89 1c 24             	mov    %ebx,(%esp)
801021f0:	e8 5b 18 00 00       	call   80103a50 <log_write>
      brelse(bp);
801021f5:	89 1c 24             	mov    %ebx,(%esp)
801021f8:	e8 f3 df ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801021fd:	83 c4 10             	add    $0x10,%esp
}
80102200:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80102203:	89 fa                	mov    %edi,%edx
}
80102205:	5b                   	pop    %ebx
      return iget(dev, inum);
80102206:	89 f0                	mov    %esi,%eax
}
80102208:	5e                   	pop    %esi
80102209:	5f                   	pop    %edi
8010220a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010220b:	e9 10 fc ff ff       	jmp    80101e20 <iget>
  panic("ialloc: no inodes");
80102210:	83 ec 0c             	sub    $0xc,%esp
80102213:	68 a9 7d 10 80       	push   $0x80107da9
80102218:	e8 f3 e8 ff ff       	call   80100b10 <panic>
8010221d:	8d 76 00             	lea    0x0(%esi),%esi

80102220 <iupdate>:
{
80102220:	55                   	push   %ebp
80102221:	89 e5                	mov    %esp,%ebp
80102223:	56                   	push   %esi
80102224:	53                   	push   %ebx
80102225:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102228:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010222b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010222e:	83 ec 08             	sub    $0x8,%esp
80102231:	c1 e8 03             	shr    $0x3,%eax
80102234:	03 05 c8 25 11 80    	add    0x801125c8,%eax
8010223a:	50                   	push   %eax
8010223b:	ff 73 a4             	push   -0x5c(%ebx)
8010223e:	e8 8d de ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80102243:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102247:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010224a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010224c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010224f:	83 e0 07             	and    $0x7,%eax
80102252:	c1 e0 06             	shl    $0x6,%eax
80102255:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80102259:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010225c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102260:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102263:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80102267:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010226b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010226f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102273:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102277:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010227a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010227d:	6a 34                	push   $0x34
8010227f:	53                   	push   %ebx
80102280:	50                   	push   %eax
80102281:	e8 da 2f 00 00       	call   80105260 <memmove>
  log_write(bp);
80102286:	89 34 24             	mov    %esi,(%esp)
80102289:	e8 c2 17 00 00       	call   80103a50 <log_write>
  brelse(bp);
8010228e:	83 c4 10             	add    $0x10,%esp
80102291:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102294:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102297:	5b                   	pop    %ebx
80102298:	5e                   	pop    %esi
80102299:	5d                   	pop    %ebp
  brelse(bp);
8010229a:	e9 51 df ff ff       	jmp    801001f0 <brelse>
8010229f:	90                   	nop

801022a0 <idup>:
{
801022a0:	55                   	push   %ebp
801022a1:	89 e5                	mov    %esp,%ebp
801022a3:	53                   	push   %ebx
801022a4:	83 ec 10             	sub    $0x10,%esp
801022a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801022aa:	68 60 09 11 80       	push   $0x80110960
801022af:	e8 1c 2e 00 00       	call   801050d0 <acquire>
  ip->ref++;
801022b4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801022b8:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801022bf:	e8 ac 2d 00 00       	call   80105070 <release>
}
801022c4:	89 d8                	mov    %ebx,%eax
801022c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022c9:	c9                   	leave
801022ca:	c3                   	ret
801022cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801022d0 <ilock>:
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	56                   	push   %esi
801022d4:	53                   	push   %ebx
801022d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801022d8:	85 db                	test   %ebx,%ebx
801022da:	0f 84 b7 00 00 00    	je     80102397 <ilock+0xc7>
801022e0:	8b 53 08             	mov    0x8(%ebx),%edx
801022e3:	85 d2                	test   %edx,%edx
801022e5:	0f 8e ac 00 00 00    	jle    80102397 <ilock+0xc7>
  acquiresleep(&ip->lock);
801022eb:	83 ec 0c             	sub    $0xc,%esp
801022ee:	8d 43 0c             	lea    0xc(%ebx),%eax
801022f1:	50                   	push   %eax
801022f2:	e8 f9 2a 00 00       	call   80104df0 <acquiresleep>
  if(ip->valid == 0){
801022f7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801022fa:	83 c4 10             	add    $0x10,%esp
801022fd:	85 c0                	test   %eax,%eax
801022ff:	74 0f                	je     80102310 <ilock+0x40>
}
80102301:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102304:	5b                   	pop    %ebx
80102305:	5e                   	pop    %esi
80102306:	5d                   	pop    %ebp
80102307:	c3                   	ret
80102308:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010230f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102310:	8b 43 04             	mov    0x4(%ebx),%eax
80102313:	83 ec 08             	sub    $0x8,%esp
80102316:	c1 e8 03             	shr    $0x3,%eax
80102319:	03 05 c8 25 11 80    	add    0x801125c8,%eax
8010231f:	50                   	push   %eax
80102320:	ff 33                	push   (%ebx)
80102322:	e8 a9 dd ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102327:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010232a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010232c:	8b 43 04             	mov    0x4(%ebx),%eax
8010232f:	83 e0 07             	and    $0x7,%eax
80102332:	c1 e0 06             	shl    $0x6,%eax
80102335:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102339:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010233c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010233f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80102343:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102347:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010234b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010234f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80102353:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102357:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010235b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010235e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102361:	6a 34                	push   $0x34
80102363:	50                   	push   %eax
80102364:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102367:	50                   	push   %eax
80102368:	e8 f3 2e 00 00       	call   80105260 <memmove>
    brelse(bp);
8010236d:	89 34 24             	mov    %esi,(%esp)
80102370:	e8 7b de ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102375:	83 c4 10             	add    $0x10,%esp
80102378:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010237d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102384:	0f 85 77 ff ff ff    	jne    80102301 <ilock+0x31>
      panic("ilock: no type");
8010238a:	83 ec 0c             	sub    $0xc,%esp
8010238d:	68 c1 7d 10 80       	push   $0x80107dc1
80102392:	e8 79 e7 ff ff       	call   80100b10 <panic>
    panic("ilock");
80102397:	83 ec 0c             	sub    $0xc,%esp
8010239a:	68 bb 7d 10 80       	push   $0x80107dbb
8010239f:	e8 6c e7 ff ff       	call   80100b10 <panic>
801023a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801023ab:	00 
801023ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023b0 <iunlock>:
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
801023b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801023b8:	85 db                	test   %ebx,%ebx
801023ba:	74 28                	je     801023e4 <iunlock+0x34>
801023bc:	83 ec 0c             	sub    $0xc,%esp
801023bf:	8d 73 0c             	lea    0xc(%ebx),%esi
801023c2:	56                   	push   %esi
801023c3:	e8 c8 2a 00 00       	call   80104e90 <holdingsleep>
801023c8:	83 c4 10             	add    $0x10,%esp
801023cb:	85 c0                	test   %eax,%eax
801023cd:	74 15                	je     801023e4 <iunlock+0x34>
801023cf:	8b 43 08             	mov    0x8(%ebx),%eax
801023d2:	85 c0                	test   %eax,%eax
801023d4:	7e 0e                	jle    801023e4 <iunlock+0x34>
  releasesleep(&ip->lock);
801023d6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801023d9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023dc:	5b                   	pop    %ebx
801023dd:	5e                   	pop    %esi
801023de:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801023df:	e9 6c 2a 00 00       	jmp    80104e50 <releasesleep>
    panic("iunlock");
801023e4:	83 ec 0c             	sub    $0xc,%esp
801023e7:	68 d0 7d 10 80       	push   $0x80107dd0
801023ec:	e8 1f e7 ff ff       	call   80100b10 <panic>
801023f1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801023f8:	00 
801023f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102400 <iput>:
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	57                   	push   %edi
80102404:	56                   	push   %esi
80102405:	53                   	push   %ebx
80102406:	83 ec 28             	sub    $0x28,%esp
80102409:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010240c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010240f:	57                   	push   %edi
80102410:	e8 db 29 00 00       	call   80104df0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80102415:	8b 53 4c             	mov    0x4c(%ebx),%edx
80102418:	83 c4 10             	add    $0x10,%esp
8010241b:	85 d2                	test   %edx,%edx
8010241d:	74 07                	je     80102426 <iput+0x26>
8010241f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102424:	74 32                	je     80102458 <iput+0x58>
  releasesleep(&ip->lock);
80102426:	83 ec 0c             	sub    $0xc,%esp
80102429:	57                   	push   %edi
8010242a:	e8 21 2a 00 00       	call   80104e50 <releasesleep>
  acquire(&icache.lock);
8010242f:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80102436:	e8 95 2c 00 00       	call   801050d0 <acquire>
  ip->ref--;
8010243b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010243f:	83 c4 10             	add    $0x10,%esp
80102442:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
80102449:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010244c:	5b                   	pop    %ebx
8010244d:	5e                   	pop    %esi
8010244e:	5f                   	pop    %edi
8010244f:	5d                   	pop    %ebp
  release(&icache.lock);
80102450:	e9 1b 2c 00 00       	jmp    80105070 <release>
80102455:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102458:	83 ec 0c             	sub    $0xc,%esp
8010245b:	68 60 09 11 80       	push   $0x80110960
80102460:	e8 6b 2c 00 00       	call   801050d0 <acquire>
    int r = ip->ref;
80102465:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102468:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010246f:	e8 fc 2b 00 00       	call   80105070 <release>
    if(r == 1){
80102474:	83 c4 10             	add    $0x10,%esp
80102477:	83 fe 01             	cmp    $0x1,%esi
8010247a:	75 aa                	jne    80102426 <iput+0x26>
8010247c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102482:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102485:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102488:	89 df                	mov    %ebx,%edi
8010248a:	89 cb                	mov    %ecx,%ebx
8010248c:	eb 09                	jmp    80102497 <iput+0x97>
8010248e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102490:	83 c6 04             	add    $0x4,%esi
80102493:	39 de                	cmp    %ebx,%esi
80102495:	74 19                	je     801024b0 <iput+0xb0>
    if(ip->addrs[i]){
80102497:	8b 16                	mov    (%esi),%edx
80102499:	85 d2                	test   %edx,%edx
8010249b:	74 f3                	je     80102490 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010249d:	8b 07                	mov    (%edi),%eax
8010249f:	e8 7c fa ff ff       	call   80101f20 <bfree>
      ip->addrs[i] = 0;
801024a4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801024aa:	eb e4                	jmp    80102490 <iput+0x90>
801024ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801024b0:	89 fb                	mov    %edi,%ebx
801024b2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801024b5:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801024bb:	85 c0                	test   %eax,%eax
801024bd:	75 2d                	jne    801024ec <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801024bf:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801024c2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801024c9:	53                   	push   %ebx
801024ca:	e8 51 fd ff ff       	call   80102220 <iupdate>
      ip->type = 0;
801024cf:	31 c0                	xor    %eax,%eax
801024d1:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801024d5:	89 1c 24             	mov    %ebx,(%esp)
801024d8:	e8 43 fd ff ff       	call   80102220 <iupdate>
      ip->valid = 0;
801024dd:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801024e4:	83 c4 10             	add    $0x10,%esp
801024e7:	e9 3a ff ff ff       	jmp    80102426 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801024ec:	83 ec 08             	sub    $0x8,%esp
801024ef:	50                   	push   %eax
801024f0:	ff 33                	push   (%ebx)
801024f2:	e8 d9 db ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801024f7:	83 c4 10             	add    $0x10,%esp
801024fa:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801024fd:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102503:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102506:	8d 70 5c             	lea    0x5c(%eax),%esi
80102509:	89 cf                	mov    %ecx,%edi
8010250b:	eb 0a                	jmp    80102517 <iput+0x117>
8010250d:	8d 76 00             	lea    0x0(%esi),%esi
80102510:	83 c6 04             	add    $0x4,%esi
80102513:	39 fe                	cmp    %edi,%esi
80102515:	74 0f                	je     80102526 <iput+0x126>
      if(a[j])
80102517:	8b 16                	mov    (%esi),%edx
80102519:	85 d2                	test   %edx,%edx
8010251b:	74 f3                	je     80102510 <iput+0x110>
        bfree(ip->dev, a[j]);
8010251d:	8b 03                	mov    (%ebx),%eax
8010251f:	e8 fc f9 ff ff       	call   80101f20 <bfree>
80102524:	eb ea                	jmp    80102510 <iput+0x110>
    brelse(bp);
80102526:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102529:	83 ec 0c             	sub    $0xc,%esp
8010252c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010252f:	50                   	push   %eax
80102530:	e8 bb dc ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102535:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010253b:	8b 03                	mov    (%ebx),%eax
8010253d:	e8 de f9 ff ff       	call   80101f20 <bfree>
    ip->addrs[NDIRECT] = 0;
80102542:	83 c4 10             	add    $0x10,%esp
80102545:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010254c:	00 00 00 
8010254f:	e9 6b ff ff ff       	jmp    801024bf <iput+0xbf>
80102554:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010255b:	00 
8010255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102560 <iunlockput>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
80102564:	53                   	push   %ebx
80102565:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102568:	85 db                	test   %ebx,%ebx
8010256a:	74 34                	je     801025a0 <iunlockput+0x40>
8010256c:	83 ec 0c             	sub    $0xc,%esp
8010256f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102572:	56                   	push   %esi
80102573:	e8 18 29 00 00       	call   80104e90 <holdingsleep>
80102578:	83 c4 10             	add    $0x10,%esp
8010257b:	85 c0                	test   %eax,%eax
8010257d:	74 21                	je     801025a0 <iunlockput+0x40>
8010257f:	8b 43 08             	mov    0x8(%ebx),%eax
80102582:	85 c0                	test   %eax,%eax
80102584:	7e 1a                	jle    801025a0 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102586:	83 ec 0c             	sub    $0xc,%esp
80102589:	56                   	push   %esi
8010258a:	e8 c1 28 00 00       	call   80104e50 <releasesleep>
  iput(ip);
8010258f:	83 c4 10             	add    $0x10,%esp
80102592:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80102595:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102598:	5b                   	pop    %ebx
80102599:	5e                   	pop    %esi
8010259a:	5d                   	pop    %ebp
  iput(ip);
8010259b:	e9 60 fe ff ff       	jmp    80102400 <iput>
    panic("iunlock");
801025a0:	83 ec 0c             	sub    $0xc,%esp
801025a3:	68 d0 7d 10 80       	push   $0x80107dd0
801025a8:	e8 63 e5 ff ff       	call   80100b10 <panic>
801025ad:	8d 76 00             	lea    0x0(%esi),%esi

801025b0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	8b 55 08             	mov    0x8(%ebp),%edx
801025b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801025b9:	8b 0a                	mov    (%edx),%ecx
801025bb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801025be:	8b 4a 04             	mov    0x4(%edx),%ecx
801025c1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801025c4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801025c8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801025cb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801025cf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801025d3:	8b 52 58             	mov    0x58(%edx),%edx
801025d6:	89 50 10             	mov    %edx,0x10(%eax)
}
801025d9:	5d                   	pop    %ebp
801025da:	c3                   	ret
801025db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801025e0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	57                   	push   %edi
801025e4:	56                   	push   %esi
801025e5:	53                   	push   %ebx
801025e6:	83 ec 1c             	sub    $0x1c,%esp
801025e9:	8b 75 08             	mov    0x8(%ebp),%esi
801025ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801025ef:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801025f2:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
801025f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
801025fa:	89 75 d8             	mov    %esi,-0x28(%ebp)
801025fd:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80102600:	0f 84 aa 00 00 00    	je     801026b0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80102606:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102609:	8b 56 58             	mov    0x58(%esi),%edx
8010260c:	39 fa                	cmp    %edi,%edx
8010260e:	0f 82 bd 00 00 00    	jb     801026d1 <readi+0xf1>
80102614:	89 f9                	mov    %edi,%ecx
80102616:	31 db                	xor    %ebx,%ebx
80102618:	01 c1                	add    %eax,%ecx
8010261a:	0f 92 c3             	setb   %bl
8010261d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80102620:	0f 82 ab 00 00 00    	jb     801026d1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102626:	89 d3                	mov    %edx,%ebx
80102628:	29 fb                	sub    %edi,%ebx
8010262a:	39 ca                	cmp    %ecx,%edx
8010262c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010262f:	85 c0                	test   %eax,%eax
80102631:	74 73                	je     801026a6 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80102633:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80102636:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102640:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102643:	89 fa                	mov    %edi,%edx
80102645:	c1 ea 09             	shr    $0x9,%edx
80102648:	89 d8                	mov    %ebx,%eax
8010264a:	e8 51 f9 ff ff       	call   80101fa0 <bmap>
8010264f:	83 ec 08             	sub    $0x8,%esp
80102652:	50                   	push   %eax
80102653:	ff 33                	push   (%ebx)
80102655:	e8 76 da ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010265a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010265d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102662:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102664:	89 f8                	mov    %edi,%eax
80102666:	25 ff 01 00 00       	and    $0x1ff,%eax
8010266b:	29 f3                	sub    %esi,%ebx
8010266d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
8010266f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102673:	39 d9                	cmp    %ebx,%ecx
80102675:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102678:	83 c4 0c             	add    $0xc,%esp
8010267b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010267c:	01 de                	add    %ebx,%esi
8010267e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80102680:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102683:	50                   	push   %eax
80102684:	ff 75 e0             	push   -0x20(%ebp)
80102687:	e8 d4 2b 00 00       	call   80105260 <memmove>
    brelse(bp);
8010268c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010268f:	89 14 24             	mov    %edx,(%esp)
80102692:	e8 59 db ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102697:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010269a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010269d:	83 c4 10             	add    $0x10,%esp
801026a0:	39 de                	cmp    %ebx,%esi
801026a2:	72 9c                	jb     80102640 <readi+0x60>
801026a4:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
801026a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026a9:	5b                   	pop    %ebx
801026aa:	5e                   	pop    %esi
801026ab:	5f                   	pop    %edi
801026ac:	5d                   	pop    %ebp
801026ad:	c3                   	ret
801026ae:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801026b0:	0f bf 56 52          	movswl 0x52(%esi),%edx
801026b4:	66 83 fa 09          	cmp    $0x9,%dx
801026b8:	77 17                	ja     801026d1 <readi+0xf1>
801026ba:	8b 14 d5 00 09 11 80 	mov    -0x7feef700(,%edx,8),%edx
801026c1:	85 d2                	test   %edx,%edx
801026c3:	74 0c                	je     801026d1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
801026c5:	89 45 10             	mov    %eax,0x10(%ebp)
}
801026c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026cb:	5b                   	pop    %ebx
801026cc:	5e                   	pop    %esi
801026cd:	5f                   	pop    %edi
801026ce:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
801026cf:	ff e2                	jmp    *%edx
      return -1;
801026d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801026d6:	eb ce                	jmp    801026a6 <readi+0xc6>
801026d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026df:	00 

801026e0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
801026e3:	57                   	push   %edi
801026e4:	56                   	push   %esi
801026e5:	53                   	push   %ebx
801026e6:	83 ec 1c             	sub    $0x1c,%esp
801026e9:	8b 45 08             	mov    0x8(%ebp),%eax
801026ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
801026ef:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801026f2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801026f7:	89 7d dc             	mov    %edi,-0x24(%ebp)
801026fa:	89 75 e0             	mov    %esi,-0x20(%ebp)
801026fd:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80102700:	0f 84 ba 00 00 00    	je     801027c0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102706:	39 78 58             	cmp    %edi,0x58(%eax)
80102709:	0f 82 ea 00 00 00    	jb     801027f9 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
8010270f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80102712:	89 f2                	mov    %esi,%edx
80102714:	01 fa                	add    %edi,%edx
80102716:	0f 82 dd 00 00 00    	jb     801027f9 <writei+0x119>
8010271c:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80102722:	0f 87 d1 00 00 00    	ja     801027f9 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102728:	85 f6                	test   %esi,%esi
8010272a:	0f 84 85 00 00 00    	je     801027b5 <writei+0xd5>
80102730:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80102737:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010273a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102740:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102743:	89 fa                	mov    %edi,%edx
80102745:	c1 ea 09             	shr    $0x9,%edx
80102748:	89 f0                	mov    %esi,%eax
8010274a:	e8 51 f8 ff ff       	call   80101fa0 <bmap>
8010274f:	83 ec 08             	sub    $0x8,%esp
80102752:	50                   	push   %eax
80102753:	ff 36                	push   (%esi)
80102755:	e8 76 d9 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010275a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010275d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102760:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102765:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80102767:	89 f8                	mov    %edi,%eax
80102769:	25 ff 01 00 00       	and    $0x1ff,%eax
8010276e:	29 d3                	sub    %edx,%ebx
80102770:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102772:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102776:	39 d9                	cmp    %ebx,%ecx
80102778:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
8010277b:	83 c4 0c             	add    $0xc,%esp
8010277e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010277f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80102781:	ff 75 dc             	push   -0x24(%ebp)
80102784:	50                   	push   %eax
80102785:	e8 d6 2a 00 00       	call   80105260 <memmove>
    log_write(bp);
8010278a:	89 34 24             	mov    %esi,(%esp)
8010278d:	e8 be 12 00 00       	call   80103a50 <log_write>
    brelse(bp);
80102792:	89 34 24             	mov    %esi,(%esp)
80102795:	e8 56 da ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010279a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010279d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801027a0:	83 c4 10             	add    $0x10,%esp
801027a3:	01 5d dc             	add    %ebx,-0x24(%ebp)
801027a6:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801027a9:	39 d8                	cmp    %ebx,%eax
801027ab:	72 93                	jb     80102740 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
801027ad:	8b 45 d8             	mov    -0x28(%ebp),%eax
801027b0:	39 78 58             	cmp    %edi,0x58(%eax)
801027b3:	72 33                	jb     801027e8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
801027b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
801027b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027bb:	5b                   	pop    %ebx
801027bc:	5e                   	pop    %esi
801027bd:	5f                   	pop    %edi
801027be:	5d                   	pop    %ebp
801027bf:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801027c0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801027c4:	66 83 f8 09          	cmp    $0x9,%ax
801027c8:	77 2f                	ja     801027f9 <writei+0x119>
801027ca:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
801027d1:	85 c0                	test   %eax,%eax
801027d3:	74 24                	je     801027f9 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
801027d5:	89 75 10             	mov    %esi,0x10(%ebp)
}
801027d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027db:	5b                   	pop    %ebx
801027dc:	5e                   	pop    %esi
801027dd:	5f                   	pop    %edi
801027de:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
801027df:	ff e0                	jmp    *%eax
801027e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
801027e8:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
801027eb:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
801027ee:	50                   	push   %eax
801027ef:	e8 2c fa ff ff       	call   80102220 <iupdate>
801027f4:	83 c4 10             	add    $0x10,%esp
801027f7:	eb bc                	jmp    801027b5 <writei+0xd5>
      return -1;
801027f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801027fe:	eb b8                	jmp    801027b8 <writei+0xd8>

80102800 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
80102803:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102806:	6a 0e                	push   $0xe
80102808:	ff 75 0c             	push   0xc(%ebp)
8010280b:	ff 75 08             	push   0x8(%ebp)
8010280e:	e8 bd 2a 00 00       	call   801052d0 <strncmp>
}
80102813:	c9                   	leave
80102814:	c3                   	ret
80102815:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010281c:	00 
8010281d:	8d 76 00             	lea    0x0(%esi),%esi

80102820 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102820:	55                   	push   %ebp
80102821:	89 e5                	mov    %esp,%ebp
80102823:	57                   	push   %edi
80102824:	56                   	push   %esi
80102825:	53                   	push   %ebx
80102826:	83 ec 1c             	sub    $0x1c,%esp
80102829:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010282c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102831:	0f 85 85 00 00 00    	jne    801028bc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102837:	8b 53 58             	mov    0x58(%ebx),%edx
8010283a:	31 ff                	xor    %edi,%edi
8010283c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010283f:	85 d2                	test   %edx,%edx
80102841:	74 3e                	je     80102881 <dirlookup+0x61>
80102843:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102848:	6a 10                	push   $0x10
8010284a:	57                   	push   %edi
8010284b:	56                   	push   %esi
8010284c:	53                   	push   %ebx
8010284d:	e8 8e fd ff ff       	call   801025e0 <readi>
80102852:	83 c4 10             	add    $0x10,%esp
80102855:	83 f8 10             	cmp    $0x10,%eax
80102858:	75 55                	jne    801028af <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
8010285a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010285f:	74 18                	je     80102879 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102861:	83 ec 04             	sub    $0x4,%esp
80102864:	8d 45 da             	lea    -0x26(%ebp),%eax
80102867:	6a 0e                	push   $0xe
80102869:	50                   	push   %eax
8010286a:	ff 75 0c             	push   0xc(%ebp)
8010286d:	e8 5e 2a 00 00       	call   801052d0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102872:	83 c4 10             	add    $0x10,%esp
80102875:	85 c0                	test   %eax,%eax
80102877:	74 17                	je     80102890 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102879:	83 c7 10             	add    $0x10,%edi
8010287c:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010287f:	72 c7                	jb     80102848 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102881:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102884:	31 c0                	xor    %eax,%eax
}
80102886:	5b                   	pop    %ebx
80102887:	5e                   	pop    %esi
80102888:	5f                   	pop    %edi
80102889:	5d                   	pop    %ebp
8010288a:	c3                   	ret
8010288b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80102890:	8b 45 10             	mov    0x10(%ebp),%eax
80102893:	85 c0                	test   %eax,%eax
80102895:	74 05                	je     8010289c <dirlookup+0x7c>
        *poff = off;
80102897:	8b 45 10             	mov    0x10(%ebp),%eax
8010289a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010289c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
801028a0:	8b 03                	mov    (%ebx),%eax
801028a2:	e8 79 f5 ff ff       	call   80101e20 <iget>
}
801028a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028aa:	5b                   	pop    %ebx
801028ab:	5e                   	pop    %esi
801028ac:	5f                   	pop    %edi
801028ad:	5d                   	pop    %ebp
801028ae:	c3                   	ret
      panic("dirlookup read");
801028af:	83 ec 0c             	sub    $0xc,%esp
801028b2:	68 ea 7d 10 80       	push   $0x80107dea
801028b7:	e8 54 e2 ff ff       	call   80100b10 <panic>
    panic("dirlookup not DIR");
801028bc:	83 ec 0c             	sub    $0xc,%esp
801028bf:	68 d8 7d 10 80       	push   $0x80107dd8
801028c4:	e8 47 e2 ff ff       	call   80100b10 <panic>
801028c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028d0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801028d0:	55                   	push   %ebp
801028d1:	89 e5                	mov    %esp,%ebp
801028d3:	57                   	push   %edi
801028d4:	56                   	push   %esi
801028d5:	53                   	push   %ebx
801028d6:	89 c3                	mov    %eax,%ebx
801028d8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
801028db:	80 38 2f             	cmpb   $0x2f,(%eax)
{
801028de:	89 55 dc             	mov    %edx,-0x24(%ebp)
801028e1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
801028e4:	0f 84 9e 01 00 00    	je     80102a88 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
801028ea:	e8 a1 1b 00 00       	call   80104490 <myproc>
  acquire(&icache.lock);
801028ef:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
801028f2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
801028f5:	68 60 09 11 80       	push   $0x80110960
801028fa:	e8 d1 27 00 00       	call   801050d0 <acquire>
  ip->ref++;
801028ff:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102903:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010290a:	e8 61 27 00 00       	call   80105070 <release>
8010290f:	83 c4 10             	add    $0x10,%esp
80102912:	eb 07                	jmp    8010291b <namex+0x4b>
80102914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102918:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010291b:	0f b6 03             	movzbl (%ebx),%eax
8010291e:	3c 2f                	cmp    $0x2f,%al
80102920:	74 f6                	je     80102918 <namex+0x48>
  if(*path == 0)
80102922:	84 c0                	test   %al,%al
80102924:	0f 84 06 01 00 00    	je     80102a30 <namex+0x160>
  while(*path != '/' && *path != 0)
8010292a:	0f b6 03             	movzbl (%ebx),%eax
8010292d:	84 c0                	test   %al,%al
8010292f:	0f 84 10 01 00 00    	je     80102a45 <namex+0x175>
80102935:	89 df                	mov    %ebx,%edi
80102937:	3c 2f                	cmp    $0x2f,%al
80102939:	0f 84 06 01 00 00    	je     80102a45 <namex+0x175>
8010293f:	90                   	nop
80102940:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102944:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102947:	3c 2f                	cmp    $0x2f,%al
80102949:	74 04                	je     8010294f <namex+0x7f>
8010294b:	84 c0                	test   %al,%al
8010294d:	75 f1                	jne    80102940 <namex+0x70>
  len = path - s;
8010294f:	89 f8                	mov    %edi,%eax
80102951:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102953:	83 f8 0d             	cmp    $0xd,%eax
80102956:	0f 8e ac 00 00 00    	jle    80102a08 <namex+0x138>
    memmove(name, s, DIRSIZ);
8010295c:	83 ec 04             	sub    $0x4,%esp
8010295f:	6a 0e                	push   $0xe
80102961:	53                   	push   %ebx
80102962:	89 fb                	mov    %edi,%ebx
80102964:	ff 75 e4             	push   -0x1c(%ebp)
80102967:	e8 f4 28 00 00       	call   80105260 <memmove>
8010296c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010296f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102972:	75 0c                	jne    80102980 <namex+0xb0>
80102974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102978:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010297b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
8010297e:	74 f8                	je     80102978 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102980:	83 ec 0c             	sub    $0xc,%esp
80102983:	56                   	push   %esi
80102984:	e8 47 f9 ff ff       	call   801022d0 <ilock>
    if(ip->type != T_DIR){
80102989:	83 c4 10             	add    $0x10,%esp
8010298c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102991:	0f 85 b7 00 00 00    	jne    80102a4e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102997:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010299a:	85 c0                	test   %eax,%eax
8010299c:	74 09                	je     801029a7 <namex+0xd7>
8010299e:	80 3b 00             	cmpb   $0x0,(%ebx)
801029a1:	0f 84 f7 00 00 00    	je     80102a9e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801029a7:	83 ec 04             	sub    $0x4,%esp
801029aa:	6a 00                	push   $0x0
801029ac:	ff 75 e4             	push   -0x1c(%ebp)
801029af:	56                   	push   %esi
801029b0:	e8 6b fe ff ff       	call   80102820 <dirlookup>
801029b5:	83 c4 10             	add    $0x10,%esp
801029b8:	89 c7                	mov    %eax,%edi
801029ba:	85 c0                	test   %eax,%eax
801029bc:	0f 84 8c 00 00 00    	je     80102a4e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801029c2:	83 ec 0c             	sub    $0xc,%esp
801029c5:	8d 4e 0c             	lea    0xc(%esi),%ecx
801029c8:	51                   	push   %ecx
801029c9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801029cc:	e8 bf 24 00 00       	call   80104e90 <holdingsleep>
801029d1:	83 c4 10             	add    $0x10,%esp
801029d4:	85 c0                	test   %eax,%eax
801029d6:	0f 84 02 01 00 00    	je     80102ade <namex+0x20e>
801029dc:	8b 56 08             	mov    0x8(%esi),%edx
801029df:	85 d2                	test   %edx,%edx
801029e1:	0f 8e f7 00 00 00    	jle    80102ade <namex+0x20e>
  releasesleep(&ip->lock);
801029e7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801029ea:	83 ec 0c             	sub    $0xc,%esp
801029ed:	51                   	push   %ecx
801029ee:	e8 5d 24 00 00       	call   80104e50 <releasesleep>
  iput(ip);
801029f3:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
801029f6:	89 fe                	mov    %edi,%esi
  iput(ip);
801029f8:	e8 03 fa ff ff       	call   80102400 <iput>
801029fd:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102a00:	e9 16 ff ff ff       	jmp    8010291b <namex+0x4b>
80102a05:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102a08:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102a0b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80102a0e:	83 ec 04             	sub    $0x4,%esp
80102a11:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102a14:	50                   	push   %eax
80102a15:	53                   	push   %ebx
    name[len] = 0;
80102a16:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102a18:	ff 75 e4             	push   -0x1c(%ebp)
80102a1b:	e8 40 28 00 00       	call   80105260 <memmove>
    name[len] = 0;
80102a20:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102a23:	83 c4 10             	add    $0x10,%esp
80102a26:	c6 01 00             	movb   $0x0,(%ecx)
80102a29:	e9 41 ff ff ff       	jmp    8010296f <namex+0x9f>
80102a2e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80102a30:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102a33:	85 c0                	test   %eax,%eax
80102a35:	0f 85 93 00 00 00    	jne    80102ace <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80102a3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a3e:	89 f0                	mov    %esi,%eax
80102a40:	5b                   	pop    %ebx
80102a41:	5e                   	pop    %esi
80102a42:	5f                   	pop    %edi
80102a43:	5d                   	pop    %ebp
80102a44:	c3                   	ret
  while(*path != '/' && *path != 0)
80102a45:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102a48:	89 df                	mov    %ebx,%edi
80102a4a:	31 c0                	xor    %eax,%eax
80102a4c:	eb c0                	jmp    80102a0e <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102a4e:	83 ec 0c             	sub    $0xc,%esp
80102a51:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102a54:	53                   	push   %ebx
80102a55:	e8 36 24 00 00       	call   80104e90 <holdingsleep>
80102a5a:	83 c4 10             	add    $0x10,%esp
80102a5d:	85 c0                	test   %eax,%eax
80102a5f:	74 7d                	je     80102ade <namex+0x20e>
80102a61:	8b 4e 08             	mov    0x8(%esi),%ecx
80102a64:	85 c9                	test   %ecx,%ecx
80102a66:	7e 76                	jle    80102ade <namex+0x20e>
  releasesleep(&ip->lock);
80102a68:	83 ec 0c             	sub    $0xc,%esp
80102a6b:	53                   	push   %ebx
80102a6c:	e8 df 23 00 00       	call   80104e50 <releasesleep>
  iput(ip);
80102a71:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102a74:	31 f6                	xor    %esi,%esi
  iput(ip);
80102a76:	e8 85 f9 ff ff       	call   80102400 <iput>
      return 0;
80102a7b:	83 c4 10             	add    $0x10,%esp
}
80102a7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a81:	89 f0                	mov    %esi,%eax
80102a83:	5b                   	pop    %ebx
80102a84:	5e                   	pop    %esi
80102a85:	5f                   	pop    %edi
80102a86:	5d                   	pop    %ebp
80102a87:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102a88:	ba 01 00 00 00       	mov    $0x1,%edx
80102a8d:	b8 01 00 00 00       	mov    $0x1,%eax
80102a92:	e8 89 f3 ff ff       	call   80101e20 <iget>
80102a97:	89 c6                	mov    %eax,%esi
80102a99:	e9 7d fe ff ff       	jmp    8010291b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102a9e:	83 ec 0c             	sub    $0xc,%esp
80102aa1:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102aa4:	53                   	push   %ebx
80102aa5:	e8 e6 23 00 00       	call   80104e90 <holdingsleep>
80102aaa:	83 c4 10             	add    $0x10,%esp
80102aad:	85 c0                	test   %eax,%eax
80102aaf:	74 2d                	je     80102ade <namex+0x20e>
80102ab1:	8b 7e 08             	mov    0x8(%esi),%edi
80102ab4:	85 ff                	test   %edi,%edi
80102ab6:	7e 26                	jle    80102ade <namex+0x20e>
  releasesleep(&ip->lock);
80102ab8:	83 ec 0c             	sub    $0xc,%esp
80102abb:	53                   	push   %ebx
80102abc:	e8 8f 23 00 00       	call   80104e50 <releasesleep>
}
80102ac1:	83 c4 10             	add    $0x10,%esp
}
80102ac4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ac7:	89 f0                	mov    %esi,%eax
80102ac9:	5b                   	pop    %ebx
80102aca:	5e                   	pop    %esi
80102acb:	5f                   	pop    %edi
80102acc:	5d                   	pop    %ebp
80102acd:	c3                   	ret
    iput(ip);
80102ace:	83 ec 0c             	sub    $0xc,%esp
80102ad1:	56                   	push   %esi
      return 0;
80102ad2:	31 f6                	xor    %esi,%esi
    iput(ip);
80102ad4:	e8 27 f9 ff ff       	call   80102400 <iput>
    return 0;
80102ad9:	83 c4 10             	add    $0x10,%esp
80102adc:	eb a0                	jmp    80102a7e <namex+0x1ae>
    panic("iunlock");
80102ade:	83 ec 0c             	sub    $0xc,%esp
80102ae1:	68 d0 7d 10 80       	push   $0x80107dd0
80102ae6:	e8 25 e0 ff ff       	call   80100b10 <panic>
80102aeb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102af0 <dirlink>:
{
80102af0:	55                   	push   %ebp
80102af1:	89 e5                	mov    %esp,%ebp
80102af3:	57                   	push   %edi
80102af4:	56                   	push   %esi
80102af5:	53                   	push   %ebx
80102af6:	83 ec 20             	sub    $0x20,%esp
80102af9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102afc:	6a 00                	push   $0x0
80102afe:	ff 75 0c             	push   0xc(%ebp)
80102b01:	53                   	push   %ebx
80102b02:	e8 19 fd ff ff       	call   80102820 <dirlookup>
80102b07:	83 c4 10             	add    $0x10,%esp
80102b0a:	85 c0                	test   %eax,%eax
80102b0c:	75 67                	jne    80102b75 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102b0e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102b11:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102b14:	85 ff                	test   %edi,%edi
80102b16:	74 29                	je     80102b41 <dirlink+0x51>
80102b18:	31 ff                	xor    %edi,%edi
80102b1a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102b1d:	eb 09                	jmp    80102b28 <dirlink+0x38>
80102b1f:	90                   	nop
80102b20:	83 c7 10             	add    $0x10,%edi
80102b23:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102b26:	73 19                	jae    80102b41 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102b28:	6a 10                	push   $0x10
80102b2a:	57                   	push   %edi
80102b2b:	56                   	push   %esi
80102b2c:	53                   	push   %ebx
80102b2d:	e8 ae fa ff ff       	call   801025e0 <readi>
80102b32:	83 c4 10             	add    $0x10,%esp
80102b35:	83 f8 10             	cmp    $0x10,%eax
80102b38:	75 4e                	jne    80102b88 <dirlink+0x98>
    if(de.inum == 0)
80102b3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102b3f:	75 df                	jne    80102b20 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102b41:	83 ec 04             	sub    $0x4,%esp
80102b44:	8d 45 da             	lea    -0x26(%ebp),%eax
80102b47:	6a 0e                	push   $0xe
80102b49:	ff 75 0c             	push   0xc(%ebp)
80102b4c:	50                   	push   %eax
80102b4d:	e8 ce 27 00 00       	call   80105320 <strncpy>
  de.inum = inum;
80102b52:	8b 45 10             	mov    0x10(%ebp),%eax
80102b55:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102b59:	6a 10                	push   $0x10
80102b5b:	57                   	push   %edi
80102b5c:	56                   	push   %esi
80102b5d:	53                   	push   %ebx
80102b5e:	e8 7d fb ff ff       	call   801026e0 <writei>
80102b63:	83 c4 20             	add    $0x20,%esp
80102b66:	83 f8 10             	cmp    $0x10,%eax
80102b69:	75 2a                	jne    80102b95 <dirlink+0xa5>
  return 0;
80102b6b:	31 c0                	xor    %eax,%eax
}
80102b6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b70:	5b                   	pop    %ebx
80102b71:	5e                   	pop    %esi
80102b72:	5f                   	pop    %edi
80102b73:	5d                   	pop    %ebp
80102b74:	c3                   	ret
    iput(ip);
80102b75:	83 ec 0c             	sub    $0xc,%esp
80102b78:	50                   	push   %eax
80102b79:	e8 82 f8 ff ff       	call   80102400 <iput>
    return -1;
80102b7e:	83 c4 10             	add    $0x10,%esp
80102b81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102b86:	eb e5                	jmp    80102b6d <dirlink+0x7d>
      panic("dirlink read");
80102b88:	83 ec 0c             	sub    $0xc,%esp
80102b8b:	68 f9 7d 10 80       	push   $0x80107df9
80102b90:	e8 7b df ff ff       	call   80100b10 <panic>
    panic("dirlink");
80102b95:	83 ec 0c             	sub    $0xc,%esp
80102b98:	68 55 80 10 80       	push   $0x80108055
80102b9d:	e8 6e df ff ff       	call   80100b10 <panic>
80102ba2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ba9:	00 
80102baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102bb0 <namei>:

struct inode*
namei(char *path)
{
80102bb0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102bb1:	31 d2                	xor    %edx,%edx
{
80102bb3:	89 e5                	mov    %esp,%ebp
80102bb5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102bb8:	8b 45 08             	mov    0x8(%ebp),%eax
80102bbb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102bbe:	e8 0d fd ff ff       	call   801028d0 <namex>
}
80102bc3:	c9                   	leave
80102bc4:	c3                   	ret
80102bc5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102bcc:	00 
80102bcd:	8d 76 00             	lea    0x0(%esi),%esi

80102bd0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102bd0:	55                   	push   %ebp
  return namex(path, 1, name);
80102bd1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102bd6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102bd8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102bdb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102bde:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102bdf:	e9 ec fc ff ff       	jmp    801028d0 <namex>
80102be4:	66 90                	xchg   %ax,%ax
80102be6:	66 90                	xchg   %ax,%ax
80102be8:	66 90                	xchg   %ax,%ax
80102bea:	66 90                	xchg   %ax,%ax
80102bec:	66 90                	xchg   %ax,%ax
80102bee:	66 90                	xchg   %ax,%ax

80102bf0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102bf0:	55                   	push   %ebp
80102bf1:	89 e5                	mov    %esp,%ebp
80102bf3:	57                   	push   %edi
80102bf4:	56                   	push   %esi
80102bf5:	53                   	push   %ebx
80102bf6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102bf9:	85 c0                	test   %eax,%eax
80102bfb:	0f 84 b4 00 00 00    	je     80102cb5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102c01:	8b 70 08             	mov    0x8(%eax),%esi
80102c04:	89 c3                	mov    %eax,%ebx
80102c06:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102c0c:	0f 87 96 00 00 00    	ja     80102ca8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c12:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102c17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c1e:	00 
80102c1f:	90                   	nop
80102c20:	89 ca                	mov    %ecx,%edx
80102c22:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102c23:	83 e0 c0             	and    $0xffffffc0,%eax
80102c26:	3c 40                	cmp    $0x40,%al
80102c28:	75 f6                	jne    80102c20 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c2a:	31 ff                	xor    %edi,%edi
80102c2c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102c31:	89 f8                	mov    %edi,%eax
80102c33:	ee                   	out    %al,(%dx)
80102c34:	b8 01 00 00 00       	mov    $0x1,%eax
80102c39:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102c3e:	ee                   	out    %al,(%dx)
80102c3f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102c44:	89 f0                	mov    %esi,%eax
80102c46:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102c47:	89 f0                	mov    %esi,%eax
80102c49:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102c4e:	c1 f8 08             	sar    $0x8,%eax
80102c51:	ee                   	out    %al,(%dx)
80102c52:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102c57:	89 f8                	mov    %edi,%eax
80102c59:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102c5a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102c5e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102c63:	c1 e0 04             	shl    $0x4,%eax
80102c66:	83 e0 10             	and    $0x10,%eax
80102c69:	83 c8 e0             	or     $0xffffffe0,%eax
80102c6c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102c6d:	f6 03 04             	testb  $0x4,(%ebx)
80102c70:	75 16                	jne    80102c88 <idestart+0x98>
80102c72:	b8 20 00 00 00       	mov    $0x20,%eax
80102c77:	89 ca                	mov    %ecx,%edx
80102c79:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102c7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c7d:	5b                   	pop    %ebx
80102c7e:	5e                   	pop    %esi
80102c7f:	5f                   	pop    %edi
80102c80:	5d                   	pop    %ebp
80102c81:	c3                   	ret
80102c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c88:	b8 30 00 00 00       	mov    $0x30,%eax
80102c8d:	89 ca                	mov    %ecx,%edx
80102c8f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102c90:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102c95:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102c98:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102c9d:	fc                   	cld
80102c9e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102ca0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ca3:	5b                   	pop    %ebx
80102ca4:	5e                   	pop    %esi
80102ca5:	5f                   	pop    %edi
80102ca6:	5d                   	pop    %ebp
80102ca7:	c3                   	ret
    panic("incorrect blockno");
80102ca8:	83 ec 0c             	sub    $0xc,%esp
80102cab:	68 0f 7e 10 80       	push   $0x80107e0f
80102cb0:	e8 5b de ff ff       	call   80100b10 <panic>
    panic("idestart");
80102cb5:	83 ec 0c             	sub    $0xc,%esp
80102cb8:	68 06 7e 10 80       	push   $0x80107e06
80102cbd:	e8 4e de ff ff       	call   80100b10 <panic>
80102cc2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102cc9:	00 
80102cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102cd0 <ideinit>:
{
80102cd0:	55                   	push   %ebp
80102cd1:	89 e5                	mov    %esp,%ebp
80102cd3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102cd6:	68 21 7e 10 80       	push   $0x80107e21
80102cdb:	68 00 26 11 80       	push   $0x80112600
80102ce0:	e8 fb 21 00 00       	call   80104ee0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102ce5:	58                   	pop    %eax
80102ce6:	a1 84 27 11 80       	mov    0x80112784,%eax
80102ceb:	5a                   	pop    %edx
80102cec:	83 e8 01             	sub    $0x1,%eax
80102cef:	50                   	push   %eax
80102cf0:	6a 0e                	push   $0xe
80102cf2:	e8 99 02 00 00       	call   80102f90 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102cf7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cfa:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102cff:	90                   	nop
80102d00:	89 ca                	mov    %ecx,%edx
80102d02:	ec                   	in     (%dx),%al
80102d03:	83 e0 c0             	and    $0xffffffc0,%eax
80102d06:	3c 40                	cmp    $0x40,%al
80102d08:	75 f6                	jne    80102d00 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d0a:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102d0f:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102d14:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d15:	89 ca                	mov    %ecx,%edx
80102d17:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102d18:	84 c0                	test   %al,%al
80102d1a:	75 1e                	jne    80102d3a <ideinit+0x6a>
80102d1c:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102d21:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102d26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d2d:	00 
80102d2e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102d30:	83 e9 01             	sub    $0x1,%ecx
80102d33:	74 0f                	je     80102d44 <ideinit+0x74>
80102d35:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102d36:	84 c0                	test   %al,%al
80102d38:	74 f6                	je     80102d30 <ideinit+0x60>
      havedisk1 = 1;
80102d3a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102d41:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d44:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102d49:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102d4e:	ee                   	out    %al,(%dx)
}
80102d4f:	c9                   	leave
80102d50:	c3                   	ret
80102d51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d58:	00 
80102d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d60 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	57                   	push   %edi
80102d64:	56                   	push   %esi
80102d65:	53                   	push   %ebx
80102d66:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102d69:	68 00 26 11 80       	push   $0x80112600
80102d6e:	e8 5d 23 00 00       	call   801050d0 <acquire>

  if((b = idequeue) == 0){
80102d73:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102d79:	83 c4 10             	add    $0x10,%esp
80102d7c:	85 db                	test   %ebx,%ebx
80102d7e:	74 63                	je     80102de3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102d80:	8b 43 58             	mov    0x58(%ebx),%eax
80102d83:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102d88:	8b 33                	mov    (%ebx),%esi
80102d8a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102d90:	75 2f                	jne    80102dc1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d92:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102d97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d9e:	00 
80102d9f:	90                   	nop
80102da0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102da1:	89 c1                	mov    %eax,%ecx
80102da3:	83 e1 c0             	and    $0xffffffc0,%ecx
80102da6:	80 f9 40             	cmp    $0x40,%cl
80102da9:	75 f5                	jne    80102da0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102dab:	a8 21                	test   $0x21,%al
80102dad:	75 12                	jne    80102dc1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
80102daf:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102db2:	b9 80 00 00 00       	mov    $0x80,%ecx
80102db7:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102dbc:	fc                   	cld
80102dbd:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102dbf:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102dc1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102dc4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102dc7:	83 ce 02             	or     $0x2,%esi
80102dca:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102dcc:	53                   	push   %ebx
80102dcd:	e8 3e 1e 00 00       	call   80104c10 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102dd2:	a1 e4 25 11 80       	mov    0x801125e4,%eax
80102dd7:	83 c4 10             	add    $0x10,%esp
80102dda:	85 c0                	test   %eax,%eax
80102ddc:	74 05                	je     80102de3 <ideintr+0x83>
    idestart(idequeue);
80102dde:	e8 0d fe ff ff       	call   80102bf0 <idestart>
    release(&idelock);
80102de3:	83 ec 0c             	sub    $0xc,%esp
80102de6:	68 00 26 11 80       	push   $0x80112600
80102deb:	e8 80 22 00 00       	call   80105070 <release>

  release(&idelock);
}
80102df0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102df3:	5b                   	pop    %ebx
80102df4:	5e                   	pop    %esi
80102df5:	5f                   	pop    %edi
80102df6:	5d                   	pop    %ebp
80102df7:	c3                   	ret
80102df8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dff:	00 

80102e00 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102e00:	55                   	push   %ebp
80102e01:	89 e5                	mov    %esp,%ebp
80102e03:	53                   	push   %ebx
80102e04:	83 ec 10             	sub    $0x10,%esp
80102e07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102e0a:	8d 43 0c             	lea    0xc(%ebx),%eax
80102e0d:	50                   	push   %eax
80102e0e:	e8 7d 20 00 00       	call   80104e90 <holdingsleep>
80102e13:	83 c4 10             	add    $0x10,%esp
80102e16:	85 c0                	test   %eax,%eax
80102e18:	0f 84 c3 00 00 00    	je     80102ee1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102e1e:	8b 03                	mov    (%ebx),%eax
80102e20:	83 e0 06             	and    $0x6,%eax
80102e23:	83 f8 02             	cmp    $0x2,%eax
80102e26:	0f 84 a8 00 00 00    	je     80102ed4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102e2c:	8b 53 04             	mov    0x4(%ebx),%edx
80102e2f:	85 d2                	test   %edx,%edx
80102e31:	74 0d                	je     80102e40 <iderw+0x40>
80102e33:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102e38:	85 c0                	test   %eax,%eax
80102e3a:	0f 84 87 00 00 00    	je     80102ec7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102e40:	83 ec 0c             	sub    $0xc,%esp
80102e43:	68 00 26 11 80       	push   $0x80112600
80102e48:	e8 83 22 00 00       	call   801050d0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102e4d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102e52:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102e59:	83 c4 10             	add    $0x10,%esp
80102e5c:	85 c0                	test   %eax,%eax
80102e5e:	74 60                	je     80102ec0 <iderw+0xc0>
80102e60:	89 c2                	mov    %eax,%edx
80102e62:	8b 40 58             	mov    0x58(%eax),%eax
80102e65:	85 c0                	test   %eax,%eax
80102e67:	75 f7                	jne    80102e60 <iderw+0x60>
80102e69:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102e6c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102e6e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102e74:	74 3a                	je     80102eb0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102e76:	8b 03                	mov    (%ebx),%eax
80102e78:	83 e0 06             	and    $0x6,%eax
80102e7b:	83 f8 02             	cmp    $0x2,%eax
80102e7e:	74 1b                	je     80102e9b <iderw+0x9b>
    sleep(b, &idelock);
80102e80:	83 ec 08             	sub    $0x8,%esp
80102e83:	68 00 26 11 80       	push   $0x80112600
80102e88:	53                   	push   %ebx
80102e89:	e8 c2 1c 00 00       	call   80104b50 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102e8e:	8b 03                	mov    (%ebx),%eax
80102e90:	83 c4 10             	add    $0x10,%esp
80102e93:	83 e0 06             	and    $0x6,%eax
80102e96:	83 f8 02             	cmp    $0x2,%eax
80102e99:	75 e5                	jne    80102e80 <iderw+0x80>
  }


  release(&idelock);
80102e9b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102ea2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ea5:	c9                   	leave
  release(&idelock);
80102ea6:	e9 c5 21 00 00       	jmp    80105070 <release>
80102eab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102eb0:	89 d8                	mov    %ebx,%eax
80102eb2:	e8 39 fd ff ff       	call   80102bf0 <idestart>
80102eb7:	eb bd                	jmp    80102e76 <iderw+0x76>
80102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102ec0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
80102ec5:	eb a5                	jmp    80102e6c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102ec7:	83 ec 0c             	sub    $0xc,%esp
80102eca:	68 50 7e 10 80       	push   $0x80107e50
80102ecf:	e8 3c dc ff ff       	call   80100b10 <panic>
    panic("iderw: nothing to do");
80102ed4:	83 ec 0c             	sub    $0xc,%esp
80102ed7:	68 3b 7e 10 80       	push   $0x80107e3b
80102edc:	e8 2f dc ff ff       	call   80100b10 <panic>
    panic("iderw: buf not locked");
80102ee1:	83 ec 0c             	sub    $0xc,%esp
80102ee4:	68 25 7e 10 80       	push   $0x80107e25
80102ee9:	e8 22 dc ff ff       	call   80100b10 <panic>
80102eee:	66 90                	xchg   %ax,%ax

80102ef0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102ef0:	55                   	push   %ebp
80102ef1:	89 e5                	mov    %esp,%ebp
80102ef3:	56                   	push   %esi
80102ef4:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102ef5:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102efc:	00 c0 fe 
  ioapic->reg = reg;
80102eff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102f06:	00 00 00 
  return ioapic->data;
80102f09:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102f0f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102f12:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102f18:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102f1e:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102f25:	c1 ee 10             	shr    $0x10,%esi
80102f28:	89 f0                	mov    %esi,%eax
80102f2a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
80102f2d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102f30:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102f33:	39 c2                	cmp    %eax,%edx
80102f35:	74 16                	je     80102f4d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102f37:	83 ec 0c             	sub    $0xc,%esp
80102f3a:	68 78 82 10 80       	push   $0x80108278
80102f3f:	e8 7c d9 ff ff       	call   801008c0 <cprintf>
  ioapic->reg = reg;
80102f44:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102f4a:	83 c4 10             	add    $0x10,%esp
{
80102f4d:	ba 10 00 00 00       	mov    $0x10,%edx
80102f52:	31 c0                	xor    %eax,%eax
80102f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102f58:	89 13                	mov    %edx,(%ebx)
80102f5a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
80102f5d:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102f63:	83 c0 01             	add    $0x1,%eax
80102f66:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
80102f6c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
80102f6f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80102f72:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102f75:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102f77:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102f7d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80102f84:	39 c6                	cmp    %eax,%esi
80102f86:	7d d0                	jge    80102f58 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102f88:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102f8b:	5b                   	pop    %ebx
80102f8c:	5e                   	pop    %esi
80102f8d:	5d                   	pop    %ebp
80102f8e:	c3                   	ret
80102f8f:	90                   	nop

80102f90 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102f90:	55                   	push   %ebp
  ioapic->reg = reg;
80102f91:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102f97:	89 e5                	mov    %esp,%ebp
80102f99:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102f9c:	8d 50 20             	lea    0x20(%eax),%edx
80102f9f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102fa3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102fa5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102fab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102fae:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102fb1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102fb4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102fb6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102fbb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102fbe:	89 50 10             	mov    %edx,0x10(%eax)
}
80102fc1:	5d                   	pop    %ebp
80102fc2:	c3                   	ret
80102fc3:	66 90                	xchg   %ax,%ax
80102fc5:	66 90                	xchg   %ax,%ax
80102fc7:	66 90                	xchg   %ax,%ax
80102fc9:	66 90                	xchg   %ax,%ax
80102fcb:	66 90                	xchg   %ax,%ax
80102fcd:	66 90                	xchg   %ax,%ax
80102fcf:	90                   	nop

80102fd0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	53                   	push   %ebx
80102fd4:	83 ec 04             	sub    $0x4,%esp
80102fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102fda:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102fe0:	75 76                	jne    80103058 <kfree+0x88>
80102fe2:	81 fb d0 64 11 80    	cmp    $0x801164d0,%ebx
80102fe8:	72 6e                	jb     80103058 <kfree+0x88>
80102fea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102ff0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102ff5:	77 61                	ja     80103058 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102ff7:	83 ec 04             	sub    $0x4,%esp
80102ffa:	68 00 10 00 00       	push   $0x1000
80102fff:	6a 01                	push   $0x1
80103001:	53                   	push   %ebx
80103002:	e8 c9 21 00 00       	call   801051d0 <memset>

  if(kmem.use_lock)
80103007:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010300d:	83 c4 10             	add    $0x10,%esp
80103010:	85 d2                	test   %edx,%edx
80103012:	75 1c                	jne    80103030 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80103014:	a1 78 26 11 80       	mov    0x80112678,%eax
80103019:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010301b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80103020:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80103026:	85 c0                	test   %eax,%eax
80103028:	75 1e                	jne    80103048 <kfree+0x78>
    release(&kmem.lock);
}
8010302a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010302d:	c9                   	leave
8010302e:	c3                   	ret
8010302f:	90                   	nop
    acquire(&kmem.lock);
80103030:	83 ec 0c             	sub    $0xc,%esp
80103033:	68 40 26 11 80       	push   $0x80112640
80103038:	e8 93 20 00 00       	call   801050d0 <acquire>
8010303d:	83 c4 10             	add    $0x10,%esp
80103040:	eb d2                	jmp    80103014 <kfree+0x44>
80103042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103048:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010304f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103052:	c9                   	leave
    release(&kmem.lock);
80103053:	e9 18 20 00 00       	jmp    80105070 <release>
    panic("kfree");
80103058:	83 ec 0c             	sub    $0xc,%esp
8010305b:	68 6e 7e 10 80       	push   $0x80107e6e
80103060:	e8 ab da ff ff       	call   80100b10 <panic>
80103065:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010306c:	00 
8010306d:	8d 76 00             	lea    0x0(%esi),%esi

80103070 <freerange>:
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	56                   	push   %esi
80103074:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80103075:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103078:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010307b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103081:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103087:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010308d:	39 de                	cmp    %ebx,%esi
8010308f:	72 23                	jb     801030b4 <freerange+0x44>
80103091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103098:	83 ec 0c             	sub    $0xc,%esp
8010309b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801030a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801030a7:	50                   	push   %eax
801030a8:	e8 23 ff ff ff       	call   80102fd0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801030ad:	83 c4 10             	add    $0x10,%esp
801030b0:	39 de                	cmp    %ebx,%esi
801030b2:	73 e4                	jae    80103098 <freerange+0x28>
}
801030b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801030b7:	5b                   	pop    %ebx
801030b8:	5e                   	pop    %esi
801030b9:	5d                   	pop    %ebp
801030ba:	c3                   	ret
801030bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801030c0 <kinit2>:
{
801030c0:	55                   	push   %ebp
801030c1:	89 e5                	mov    %esp,%ebp
801030c3:	56                   	push   %esi
801030c4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801030c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801030c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801030cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801030d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801030d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801030dd:	39 de                	cmp    %ebx,%esi
801030df:	72 23                	jb     80103104 <kinit2+0x44>
801030e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801030e8:	83 ec 0c             	sub    $0xc,%esp
801030eb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801030f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801030f7:	50                   	push   %eax
801030f8:	e8 d3 fe ff ff       	call   80102fd0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801030fd:	83 c4 10             	add    $0x10,%esp
80103100:	39 de                	cmp    %ebx,%esi
80103102:	73 e4                	jae    801030e8 <kinit2+0x28>
  kmem.use_lock = 1;
80103104:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010310b:	00 00 00 
}
8010310e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103111:	5b                   	pop    %ebx
80103112:	5e                   	pop    %esi
80103113:	5d                   	pop    %ebp
80103114:	c3                   	ret
80103115:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010311c:	00 
8010311d:	8d 76 00             	lea    0x0(%esi),%esi

80103120 <kinit1>:
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	56                   	push   %esi
80103124:	53                   	push   %ebx
80103125:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80103128:	83 ec 08             	sub    $0x8,%esp
8010312b:	68 74 7e 10 80       	push   $0x80107e74
80103130:	68 40 26 11 80       	push   $0x80112640
80103135:	e8 a6 1d 00 00       	call   80104ee0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010313a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010313d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103140:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80103147:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010314a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103150:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103156:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010315c:	39 de                	cmp    %ebx,%esi
8010315e:	72 1c                	jb     8010317c <kinit1+0x5c>
    kfree(p);
80103160:	83 ec 0c             	sub    $0xc,%esp
80103163:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103169:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010316f:	50                   	push   %eax
80103170:	e8 5b fe ff ff       	call   80102fd0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103175:	83 c4 10             	add    $0x10,%esp
80103178:	39 de                	cmp    %ebx,%esi
8010317a:	73 e4                	jae    80103160 <kinit1+0x40>
}
8010317c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010317f:	5b                   	pop    %ebx
80103180:	5e                   	pop    %esi
80103181:	5d                   	pop    %ebp
80103182:	c3                   	ret
80103183:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010318a:	00 
8010318b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103190 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	53                   	push   %ebx
80103194:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80103197:	a1 74 26 11 80       	mov    0x80112674,%eax
8010319c:	85 c0                	test   %eax,%eax
8010319e:	75 20                	jne    801031c0 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
801031a0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801031a6:	85 db                	test   %ebx,%ebx
801031a8:	74 07                	je     801031b1 <kalloc+0x21>
    kmem.freelist = r->next;
801031aa:	8b 03                	mov    (%ebx),%eax
801031ac:	a3 78 26 11 80       	mov    %eax,0x80112678
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801031b1:	89 d8                	mov    %ebx,%eax
801031b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031b6:	c9                   	leave
801031b7:	c3                   	ret
801031b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031bf:	00 
    acquire(&kmem.lock);
801031c0:	83 ec 0c             	sub    $0xc,%esp
801031c3:	68 40 26 11 80       	push   $0x80112640
801031c8:	e8 03 1f 00 00       	call   801050d0 <acquire>
  r = kmem.freelist;
801031cd:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(kmem.use_lock)
801031d3:	a1 74 26 11 80       	mov    0x80112674,%eax
  if(r)
801031d8:	83 c4 10             	add    $0x10,%esp
801031db:	85 db                	test   %ebx,%ebx
801031dd:	74 08                	je     801031e7 <kalloc+0x57>
    kmem.freelist = r->next;
801031df:	8b 13                	mov    (%ebx),%edx
801031e1:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801031e7:	85 c0                	test   %eax,%eax
801031e9:	74 c6                	je     801031b1 <kalloc+0x21>
    release(&kmem.lock);
801031eb:	83 ec 0c             	sub    $0xc,%esp
801031ee:	68 40 26 11 80       	push   $0x80112640
801031f3:	e8 78 1e 00 00       	call   80105070 <release>
}
801031f8:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
801031fa:	83 c4 10             	add    $0x10,%esp
}
801031fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103200:	c9                   	leave
80103201:	c3                   	ret
80103202:	66 90                	xchg   %ax,%ax
80103204:	66 90                	xchg   %ax,%ax
80103206:	66 90                	xchg   %ax,%ax
80103208:	66 90                	xchg   %ax,%ax
8010320a:	66 90                	xchg   %ax,%ax
8010320c:	66 90                	xchg   %ax,%ax
8010320e:	66 90                	xchg   %ax,%ax

80103210 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103210:	ba 64 00 00 00       	mov    $0x64,%edx
80103215:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80103216:	a8 01                	test   $0x1,%al
80103218:	0f 84 c2 00 00 00    	je     801032e0 <kbdgetc+0xd0>
{
8010321e:	55                   	push   %ebp
8010321f:	ba 60 00 00 00       	mov    $0x60,%edx
80103224:	89 e5                	mov    %esp,%ebp
80103226:	53                   	push   %ebx
80103227:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80103228:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
  data = inb(KBDATAP);
8010322e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80103231:	3c e0                	cmp    $0xe0,%al
80103233:	74 5b                	je     80103290 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80103235:	89 da                	mov    %ebx,%edx
80103237:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010323a:	84 c0                	test   %al,%al
8010323c:	78 62                	js     801032a0 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010323e:	85 d2                	test   %edx,%edx
80103240:	74 09                	je     8010324b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103242:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103245:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80103248:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010324b:	0f b6 91 e0 84 10 80 	movzbl -0x7fef7b20(%ecx),%edx
  shift ^= togglecode[data];
80103252:	0f b6 81 e0 83 10 80 	movzbl -0x7fef7c20(%ecx),%eax
  shift |= shiftcode[data];
80103259:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010325b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010325d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010325f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80103265:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80103268:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010326b:	8b 04 85 c0 83 10 80 	mov    -0x7fef7c40(,%eax,4),%eax
80103272:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80103276:	74 0b                	je     80103283 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80103278:	8d 50 9f             	lea    -0x61(%eax),%edx
8010327b:	83 fa 19             	cmp    $0x19,%edx
8010327e:	77 48                	ja     801032c8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80103280:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103283:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103286:	c9                   	leave
80103287:	c3                   	ret
80103288:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010328f:	00 
    shift |= E0ESC;
80103290:	83 cb 40             	or     $0x40,%ebx
    return 0;
80103293:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80103295:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
8010329b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010329e:	c9                   	leave
8010329f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
801032a0:	83 e0 7f             	and    $0x7f,%eax
801032a3:	85 d2                	test   %edx,%edx
801032a5:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
801032a8:	0f b6 81 e0 84 10 80 	movzbl -0x7fef7b20(%ecx),%eax
801032af:	83 c8 40             	or     $0x40,%eax
801032b2:	0f b6 c0             	movzbl %al,%eax
801032b5:	f7 d0                	not    %eax
801032b7:	21 d8                	and    %ebx,%eax
801032b9:	a3 7c 26 11 80       	mov    %eax,0x8011267c
    return 0;
801032be:	31 c0                	xor    %eax,%eax
801032c0:	eb d9                	jmp    8010329b <kbdgetc+0x8b>
801032c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801032c8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801032cb:	8d 50 20             	lea    0x20(%eax),%edx
}
801032ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801032d1:	c9                   	leave
      c += 'a' - 'A';
801032d2:	83 f9 1a             	cmp    $0x1a,%ecx
801032d5:	0f 42 c2             	cmovb  %edx,%eax
}
801032d8:	c3                   	ret
801032d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801032e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032e5:	c3                   	ret
801032e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032ed:	00 
801032ee:	66 90                	xchg   %ax,%ax

801032f0 <kbdintr>:

void
kbdintr(void)
{
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801032f6:	68 10 32 10 80       	push   $0x80103210
801032fb:	e8 30 da ff ff       	call   80100d30 <consoleintr>
}
80103300:	83 c4 10             	add    $0x10,%esp
80103303:	c9                   	leave
80103304:	c3                   	ret
80103305:	66 90                	xchg   %ax,%ax
80103307:	66 90                	xchg   %ax,%ax
80103309:	66 90                	xchg   %ax,%ax
8010330b:	66 90                	xchg   %ax,%ax
8010330d:	66 90                	xchg   %ax,%ax
8010330f:	90                   	nop

80103310 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80103310:	a1 80 26 11 80       	mov    0x80112680,%eax
80103315:	85 c0                	test   %eax,%eax
80103317:	0f 84 c3 00 00 00    	je     801033e0 <lapicinit+0xd0>
  lapic[index] = value;
8010331d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103324:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103327:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010332a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103331:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103334:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103337:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010333e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103341:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103344:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010334b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010334e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103351:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103358:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010335b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010335e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103365:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103368:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010336b:	8b 50 30             	mov    0x30(%eax),%edx
8010336e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80103374:	75 72                	jne    801033e8 <lapicinit+0xd8>
  lapic[index] = value;
80103376:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010337d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103380:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103383:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010338a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010338d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103390:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80103397:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010339a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010339d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801033a4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033a7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033aa:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801033b1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033b4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033b7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801033be:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801033c1:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801033c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801033c8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801033ce:	80 e6 10             	and    $0x10,%dh
801033d1:	75 f5                	jne    801033c8 <lapicinit+0xb8>
  lapic[index] = value;
801033d3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801033da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033dd:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801033e0:	c3                   	ret
801033e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801033e8:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801033ef:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801033f2:	8b 50 20             	mov    0x20(%eax),%edx
}
801033f5:	e9 7c ff ff ff       	jmp    80103376 <lapicinit+0x66>
801033fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103400 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80103400:	a1 80 26 11 80       	mov    0x80112680,%eax
80103405:	85 c0                	test   %eax,%eax
80103407:	74 07                	je     80103410 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80103409:	8b 40 20             	mov    0x20(%eax),%eax
8010340c:	c1 e8 18             	shr    $0x18,%eax
8010340f:	c3                   	ret
    return 0;
80103410:	31 c0                	xor    %eax,%eax
}
80103412:	c3                   	ret
80103413:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010341a:	00 
8010341b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103420 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80103420:	a1 80 26 11 80       	mov    0x80112680,%eax
80103425:	85 c0                	test   %eax,%eax
80103427:	74 0d                	je     80103436 <lapiceoi+0x16>
  lapic[index] = value;
80103429:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103430:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103433:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80103436:	c3                   	ret
80103437:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010343e:	00 
8010343f:	90                   	nop

80103440 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103440:	c3                   	ret
80103441:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103448:	00 
80103449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103450 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103450:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103451:	b8 0f 00 00 00       	mov    $0xf,%eax
80103456:	ba 70 00 00 00       	mov    $0x70,%edx
8010345b:	89 e5                	mov    %esp,%ebp
8010345d:	53                   	push   %ebx
8010345e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103461:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103464:	ee                   	out    %al,(%dx)
80103465:	b8 0a 00 00 00       	mov    $0xa,%eax
8010346a:	ba 71 00 00 00       	mov    $0x71,%edx
8010346f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103470:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80103472:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103475:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010347b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010347d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80103480:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103482:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103485:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103488:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010348e:	a1 80 26 11 80       	mov    0x80112680,%eax
80103493:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103499:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010349c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801034a3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034a6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801034a9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801034b0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034b3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801034b6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801034bc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801034bf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801034c5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801034c8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801034ce:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801034d1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801034d7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801034da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034dd:	c9                   	leave
801034de:	c3                   	ret
801034df:	90                   	nop

801034e0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801034e0:	55                   	push   %ebp
801034e1:	b8 0b 00 00 00       	mov    $0xb,%eax
801034e6:	ba 70 00 00 00       	mov    $0x70,%edx
801034eb:	89 e5                	mov    %esp,%ebp
801034ed:	57                   	push   %edi
801034ee:	56                   	push   %esi
801034ef:	53                   	push   %ebx
801034f0:	83 ec 4c             	sub    $0x4c,%esp
801034f3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034f4:	ba 71 00 00 00       	mov    $0x71,%edx
801034f9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801034fa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034fd:	bf 70 00 00 00       	mov    $0x70,%edi
80103502:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103505:	8d 76 00             	lea    0x0(%esi),%esi
80103508:	31 c0                	xor    %eax,%eax
8010350a:	89 fa                	mov    %edi,%edx
8010350c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010350d:	b9 71 00 00 00       	mov    $0x71,%ecx
80103512:	89 ca                	mov    %ecx,%edx
80103514:	ec                   	in     (%dx),%al
80103515:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103518:	89 fa                	mov    %edi,%edx
8010351a:	b8 02 00 00 00       	mov    $0x2,%eax
8010351f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103520:	89 ca                	mov    %ecx,%edx
80103522:	ec                   	in     (%dx),%al
80103523:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103526:	89 fa                	mov    %edi,%edx
80103528:	b8 04 00 00 00       	mov    $0x4,%eax
8010352d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010352e:	89 ca                	mov    %ecx,%edx
80103530:	ec                   	in     (%dx),%al
80103531:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103534:	89 fa                	mov    %edi,%edx
80103536:	b8 07 00 00 00       	mov    $0x7,%eax
8010353b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010353c:	89 ca                	mov    %ecx,%edx
8010353e:	ec                   	in     (%dx),%al
8010353f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103542:	89 fa                	mov    %edi,%edx
80103544:	b8 08 00 00 00       	mov    $0x8,%eax
80103549:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010354a:	89 ca                	mov    %ecx,%edx
8010354c:	ec                   	in     (%dx),%al
8010354d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010354f:	89 fa                	mov    %edi,%edx
80103551:	b8 09 00 00 00       	mov    $0x9,%eax
80103556:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103557:	89 ca                	mov    %ecx,%edx
80103559:	ec                   	in     (%dx),%al
8010355a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010355d:	89 fa                	mov    %edi,%edx
8010355f:	b8 0a 00 00 00       	mov    $0xa,%eax
80103564:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103565:	89 ca                	mov    %ecx,%edx
80103567:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103568:	84 c0                	test   %al,%al
8010356a:	78 9c                	js     80103508 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010356c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103570:	89 f2                	mov    %esi,%edx
80103572:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80103575:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103578:	89 fa                	mov    %edi,%edx
8010357a:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010357d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103581:	89 75 c8             	mov    %esi,-0x38(%ebp)
80103584:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103587:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010358b:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010358e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103592:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103595:	31 c0                	xor    %eax,%eax
80103597:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103598:	89 ca                	mov    %ecx,%edx
8010359a:	ec                   	in     (%dx),%al
8010359b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010359e:	89 fa                	mov    %edi,%edx
801035a0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801035a3:	b8 02 00 00 00       	mov    $0x2,%eax
801035a8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035a9:	89 ca                	mov    %ecx,%edx
801035ab:	ec                   	in     (%dx),%al
801035ac:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035af:	89 fa                	mov    %edi,%edx
801035b1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801035b4:	b8 04 00 00 00       	mov    $0x4,%eax
801035b9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035ba:	89 ca                	mov    %ecx,%edx
801035bc:	ec                   	in     (%dx),%al
801035bd:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035c0:	89 fa                	mov    %edi,%edx
801035c2:	89 45 d8             	mov    %eax,-0x28(%ebp)
801035c5:	b8 07 00 00 00       	mov    $0x7,%eax
801035ca:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035cb:	89 ca                	mov    %ecx,%edx
801035cd:	ec                   	in     (%dx),%al
801035ce:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035d1:	89 fa                	mov    %edi,%edx
801035d3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801035d6:	b8 08 00 00 00       	mov    $0x8,%eax
801035db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035dc:	89 ca                	mov    %ecx,%edx
801035de:	ec                   	in     (%dx),%al
801035df:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035e2:	89 fa                	mov    %edi,%edx
801035e4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801035e7:	b8 09 00 00 00       	mov    $0x9,%eax
801035ec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035ed:	89 ca                	mov    %ecx,%edx
801035ef:	ec                   	in     (%dx),%al
801035f0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801035f3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801035f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801035f9:	8d 45 d0             	lea    -0x30(%ebp),%eax
801035fc:	6a 18                	push   $0x18
801035fe:	50                   	push   %eax
801035ff:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103602:	50                   	push   %eax
80103603:	e8 08 1c 00 00       	call   80105210 <memcmp>
80103608:	83 c4 10             	add    $0x10,%esp
8010360b:	85 c0                	test   %eax,%eax
8010360d:	0f 85 f5 fe ff ff    	jne    80103508 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103613:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80103617:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010361a:	89 f0                	mov    %esi,%eax
8010361c:	84 c0                	test   %al,%al
8010361e:	75 78                	jne    80103698 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103620:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103623:	89 c2                	mov    %eax,%edx
80103625:	83 e0 0f             	and    $0xf,%eax
80103628:	c1 ea 04             	shr    $0x4,%edx
8010362b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010362e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103631:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103634:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103637:	89 c2                	mov    %eax,%edx
80103639:	83 e0 0f             	and    $0xf,%eax
8010363c:	c1 ea 04             	shr    $0x4,%edx
8010363f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103642:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103645:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103648:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010364b:	89 c2                	mov    %eax,%edx
8010364d:	83 e0 0f             	and    $0xf,%eax
80103650:	c1 ea 04             	shr    $0x4,%edx
80103653:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103656:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103659:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
8010365c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010365f:	89 c2                	mov    %eax,%edx
80103661:	83 e0 0f             	and    $0xf,%eax
80103664:	c1 ea 04             	shr    $0x4,%edx
80103667:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010366a:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010366d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103670:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103673:	89 c2                	mov    %eax,%edx
80103675:	83 e0 0f             	and    $0xf,%eax
80103678:	c1 ea 04             	shr    $0x4,%edx
8010367b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010367e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103681:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103684:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103687:	89 c2                	mov    %eax,%edx
80103689:	83 e0 0f             	and    $0xf,%eax
8010368c:	c1 ea 04             	shr    $0x4,%edx
8010368f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103692:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103695:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103698:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010369b:	89 03                	mov    %eax,(%ebx)
8010369d:	8b 45 bc             	mov    -0x44(%ebp),%eax
801036a0:	89 43 04             	mov    %eax,0x4(%ebx)
801036a3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801036a6:	89 43 08             	mov    %eax,0x8(%ebx)
801036a9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801036ac:	89 43 0c             	mov    %eax,0xc(%ebx)
801036af:	8b 45 c8             	mov    -0x38(%ebp),%eax
801036b2:	89 43 10             	mov    %eax,0x10(%ebx)
801036b5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801036b8:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
801036bb:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
801036c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036c5:	5b                   	pop    %ebx
801036c6:	5e                   	pop    %esi
801036c7:	5f                   	pop    %edi
801036c8:	5d                   	pop    %ebp
801036c9:	c3                   	ret
801036ca:	66 90                	xchg   %ax,%ax
801036cc:	66 90                	xchg   %ax,%ax
801036ce:	66 90                	xchg   %ax,%ax

801036d0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801036d0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
801036d6:	85 c9                	test   %ecx,%ecx
801036d8:	0f 8e 8a 00 00 00    	jle    80103768 <install_trans+0x98>
{
801036de:	55                   	push   %ebp
801036df:	89 e5                	mov    %esp,%ebp
801036e1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
801036e2:	31 ff                	xor    %edi,%edi
{
801036e4:	56                   	push   %esi
801036e5:	53                   	push   %ebx
801036e6:	83 ec 0c             	sub    $0xc,%esp
801036e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801036f0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
801036f5:	83 ec 08             	sub    $0x8,%esp
801036f8:	01 f8                	add    %edi,%eax
801036fa:	83 c0 01             	add    $0x1,%eax
801036fd:	50                   	push   %eax
801036fe:	ff 35 e4 26 11 80    	push   0x801126e4
80103704:	e8 c7 c9 ff ff       	call   801000d0 <bread>
80103709:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010370b:	58                   	pop    %eax
8010370c:	5a                   	pop    %edx
8010370d:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80103714:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010371a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010371d:	e8 ae c9 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103722:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103725:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103727:	8d 46 5c             	lea    0x5c(%esi),%eax
8010372a:	68 00 02 00 00       	push   $0x200
8010372f:	50                   	push   %eax
80103730:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103733:	50                   	push   %eax
80103734:	e8 27 1b 00 00       	call   80105260 <memmove>
    bwrite(dbuf);  // write dst to disk
80103739:	89 1c 24             	mov    %ebx,(%esp)
8010373c:	e8 6f ca ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103741:	89 34 24             	mov    %esi,(%esp)
80103744:	e8 a7 ca ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103749:	89 1c 24             	mov    %ebx,(%esp)
8010374c:	e8 9f ca ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103751:	83 c4 10             	add    $0x10,%esp
80103754:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
8010375a:	7f 94                	jg     801036f0 <install_trans+0x20>
  }
}
8010375c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010375f:	5b                   	pop    %ebx
80103760:	5e                   	pop    %esi
80103761:	5f                   	pop    %edi
80103762:	5d                   	pop    %ebp
80103763:	c3                   	ret
80103764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103768:	c3                   	ret
80103769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103770 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	53                   	push   %ebx
80103774:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103777:	ff 35 d4 26 11 80    	push   0x801126d4
8010377d:	ff 35 e4 26 11 80    	push   0x801126e4
80103783:	e8 48 c9 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103788:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010378b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010378d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80103792:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103795:	85 c0                	test   %eax,%eax
80103797:	7e 19                	jle    801037b2 <write_head+0x42>
80103799:	31 d2                	xor    %edx,%edx
8010379b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
801037a0:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
801037a7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801037ab:	83 c2 01             	add    $0x1,%edx
801037ae:	39 d0                	cmp    %edx,%eax
801037b0:	75 ee                	jne    801037a0 <write_head+0x30>
  }
  bwrite(buf);
801037b2:	83 ec 0c             	sub    $0xc,%esp
801037b5:	53                   	push   %ebx
801037b6:	e8 f5 c9 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
801037bb:	89 1c 24             	mov    %ebx,(%esp)
801037be:	e8 2d ca ff ff       	call   801001f0 <brelse>
}
801037c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037c6:	83 c4 10             	add    $0x10,%esp
801037c9:	c9                   	leave
801037ca:	c3                   	ret
801037cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801037d0 <initlog>:
{
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp
801037d3:	53                   	push   %ebx
801037d4:	83 ec 2c             	sub    $0x2c,%esp
801037d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801037da:	68 79 7e 10 80       	push   $0x80107e79
801037df:	68 a0 26 11 80       	push   $0x801126a0
801037e4:	e8 f7 16 00 00       	call   80104ee0 <initlock>
  readsb(dev, &sb);
801037e9:	58                   	pop    %eax
801037ea:	8d 45 dc             	lea    -0x24(%ebp),%eax
801037ed:	5a                   	pop    %edx
801037ee:	50                   	push   %eax
801037ef:	53                   	push   %ebx
801037f0:	e8 7b e8 ff ff       	call   80102070 <readsb>
  log.start = sb.logstart;
801037f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801037f8:	59                   	pop    %ecx
  log.dev = dev;
801037f9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
801037ff:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103802:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80103807:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
8010380d:	5a                   	pop    %edx
8010380e:	50                   	push   %eax
8010380f:	53                   	push   %ebx
80103810:	e8 bb c8 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103815:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103818:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010381b:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80103821:	85 db                	test   %ebx,%ebx
80103823:	7e 1d                	jle    80103842 <initlog+0x72>
80103825:	31 d2                	xor    %edx,%edx
80103827:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010382e:	00 
8010382f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80103830:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103834:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010383b:	83 c2 01             	add    $0x1,%edx
8010383e:	39 d3                	cmp    %edx,%ebx
80103840:	75 ee                	jne    80103830 <initlog+0x60>
  brelse(buf);
80103842:	83 ec 0c             	sub    $0xc,%esp
80103845:	50                   	push   %eax
80103846:	e8 a5 c9 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010384b:	e8 80 fe ff ff       	call   801036d0 <install_trans>
  log.lh.n = 0;
80103850:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80103857:	00 00 00 
  write_head(); // clear the log
8010385a:	e8 11 ff ff ff       	call   80103770 <write_head>
}
8010385f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103862:	83 c4 10             	add    $0x10,%esp
80103865:	c9                   	leave
80103866:	c3                   	ret
80103867:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010386e:	00 
8010386f:	90                   	nop

80103870 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103876:	68 a0 26 11 80       	push   $0x801126a0
8010387b:	e8 50 18 00 00       	call   801050d0 <acquire>
80103880:	83 c4 10             	add    $0x10,%esp
80103883:	eb 18                	jmp    8010389d <begin_op+0x2d>
80103885:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103888:	83 ec 08             	sub    $0x8,%esp
8010388b:	68 a0 26 11 80       	push   $0x801126a0
80103890:	68 a0 26 11 80       	push   $0x801126a0
80103895:	e8 b6 12 00 00       	call   80104b50 <sleep>
8010389a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010389d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
801038a2:	85 c0                	test   %eax,%eax
801038a4:	75 e2                	jne    80103888 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801038a6:	a1 dc 26 11 80       	mov    0x801126dc,%eax
801038ab:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
801038b1:	83 c0 01             	add    $0x1,%eax
801038b4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801038b7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801038ba:	83 fa 1e             	cmp    $0x1e,%edx
801038bd:	7f c9                	jg     80103888 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801038bf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801038c2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
801038c7:	68 a0 26 11 80       	push   $0x801126a0
801038cc:	e8 9f 17 00 00       	call   80105070 <release>
      break;
    }
  }
}
801038d1:	83 c4 10             	add    $0x10,%esp
801038d4:	c9                   	leave
801038d5:	c3                   	ret
801038d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801038dd:	00 
801038de:	66 90                	xchg   %ax,%ax

801038e0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	57                   	push   %edi
801038e4:	56                   	push   %esi
801038e5:	53                   	push   %ebx
801038e6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801038e9:	68 a0 26 11 80       	push   $0x801126a0
801038ee:	e8 dd 17 00 00       	call   801050d0 <acquire>
  log.outstanding -= 1;
801038f3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
801038f8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
801038fe:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103901:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103904:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
8010390a:	85 f6                	test   %esi,%esi
8010390c:	0f 85 22 01 00 00    	jne    80103a34 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103912:	85 db                	test   %ebx,%ebx
80103914:	0f 85 f6 00 00 00    	jne    80103a10 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010391a:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80103921:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103924:	83 ec 0c             	sub    $0xc,%esp
80103927:	68 a0 26 11 80       	push   $0x801126a0
8010392c:	e8 3f 17 00 00       	call   80105070 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103931:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80103937:	83 c4 10             	add    $0x10,%esp
8010393a:	85 c9                	test   %ecx,%ecx
8010393c:	7f 42                	jg     80103980 <end_op+0xa0>
    acquire(&log.lock);
8010393e:	83 ec 0c             	sub    $0xc,%esp
80103941:	68 a0 26 11 80       	push   $0x801126a0
80103946:	e8 85 17 00 00       	call   801050d0 <acquire>
    log.committing = 0;
8010394b:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80103952:	00 00 00 
    wakeup(&log);
80103955:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
8010395c:	e8 af 12 00 00       	call   80104c10 <wakeup>
    release(&log.lock);
80103961:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80103968:	e8 03 17 00 00       	call   80105070 <release>
8010396d:	83 c4 10             	add    $0x10,%esp
}
80103970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103973:	5b                   	pop    %ebx
80103974:	5e                   	pop    %esi
80103975:	5f                   	pop    %edi
80103976:	5d                   	pop    %ebp
80103977:	c3                   	ret
80103978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010397f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103980:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80103985:	83 ec 08             	sub    $0x8,%esp
80103988:	01 d8                	add    %ebx,%eax
8010398a:	83 c0 01             	add    $0x1,%eax
8010398d:	50                   	push   %eax
8010398e:	ff 35 e4 26 11 80    	push   0x801126e4
80103994:	e8 37 c7 ff ff       	call   801000d0 <bread>
80103999:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010399b:	58                   	pop    %eax
8010399c:	5a                   	pop    %edx
8010399d:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
801039a4:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
801039aa:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801039ad:	e8 1e c7 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
801039b2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801039b5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801039b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801039ba:	68 00 02 00 00       	push   $0x200
801039bf:	50                   	push   %eax
801039c0:	8d 46 5c             	lea    0x5c(%esi),%eax
801039c3:	50                   	push   %eax
801039c4:	e8 97 18 00 00       	call   80105260 <memmove>
    bwrite(to);  // write the log
801039c9:	89 34 24             	mov    %esi,(%esp)
801039cc:	e8 df c7 ff ff       	call   801001b0 <bwrite>
    brelse(from);
801039d1:	89 3c 24             	mov    %edi,(%esp)
801039d4:	e8 17 c8 ff ff       	call   801001f0 <brelse>
    brelse(to);
801039d9:	89 34 24             	mov    %esi,(%esp)
801039dc:	e8 0f c8 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801039e1:	83 c4 10             	add    $0x10,%esp
801039e4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
801039ea:	7c 94                	jl     80103980 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801039ec:	e8 7f fd ff ff       	call   80103770 <write_head>
    install_trans(); // Now install writes to home locations
801039f1:	e8 da fc ff ff       	call   801036d0 <install_trans>
    log.lh.n = 0;
801039f6:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
801039fd:	00 00 00 
    write_head();    // Erase the transaction from the log
80103a00:	e8 6b fd ff ff       	call   80103770 <write_head>
80103a05:	e9 34 ff ff ff       	jmp    8010393e <end_op+0x5e>
80103a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103a10:	83 ec 0c             	sub    $0xc,%esp
80103a13:	68 a0 26 11 80       	push   $0x801126a0
80103a18:	e8 f3 11 00 00       	call   80104c10 <wakeup>
  release(&log.lock);
80103a1d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80103a24:	e8 47 16 00 00       	call   80105070 <release>
80103a29:	83 c4 10             	add    $0x10,%esp
}
80103a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a2f:	5b                   	pop    %ebx
80103a30:	5e                   	pop    %esi
80103a31:	5f                   	pop    %edi
80103a32:	5d                   	pop    %ebp
80103a33:	c3                   	ret
    panic("log.committing");
80103a34:	83 ec 0c             	sub    $0xc,%esp
80103a37:	68 7d 7e 10 80       	push   $0x80107e7d
80103a3c:	e8 cf d0 ff ff       	call   80100b10 <panic>
80103a41:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a48:	00 
80103a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a50 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	53                   	push   %ebx
80103a54:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103a57:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80103a5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103a60:	83 fa 1d             	cmp    $0x1d,%edx
80103a63:	7f 7d                	jg     80103ae2 <log_write+0x92>
80103a65:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80103a6a:	83 e8 01             	sub    $0x1,%eax
80103a6d:	39 c2                	cmp    %eax,%edx
80103a6f:	7d 71                	jge    80103ae2 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103a71:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80103a76:	85 c0                	test   %eax,%eax
80103a78:	7e 75                	jle    80103aef <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103a7a:	83 ec 0c             	sub    $0xc,%esp
80103a7d:	68 a0 26 11 80       	push   $0x801126a0
80103a82:	e8 49 16 00 00       	call   801050d0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103a87:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103a8a:	83 c4 10             	add    $0x10,%esp
80103a8d:	31 c0                	xor    %eax,%eax
80103a8f:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80103a95:	85 d2                	test   %edx,%edx
80103a97:	7f 0e                	jg     80103aa7 <log_write+0x57>
80103a99:	eb 15                	jmp    80103ab0 <log_write+0x60>
80103a9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103aa0:	83 c0 01             	add    $0x1,%eax
80103aa3:	39 c2                	cmp    %eax,%edx
80103aa5:	74 29                	je     80103ad0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103aa7:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80103aae:	75 f0                	jne    80103aa0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103ab0:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
80103ab7:	39 c2                	cmp    %eax,%edx
80103ab9:	74 1c                	je     80103ad7 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103abb:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103abe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103ac1:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80103ac8:	c9                   	leave
  release(&log.lock);
80103ac9:	e9 a2 15 00 00       	jmp    80105070 <release>
80103ace:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103ad0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80103ad7:	83 c2 01             	add    $0x1,%edx
80103ada:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80103ae0:	eb d9                	jmp    80103abb <log_write+0x6b>
    panic("too big a transaction");
80103ae2:	83 ec 0c             	sub    $0xc,%esp
80103ae5:	68 8c 7e 10 80       	push   $0x80107e8c
80103aea:	e8 21 d0 ff ff       	call   80100b10 <panic>
    panic("log_write outside of trans");
80103aef:	83 ec 0c             	sub    $0xc,%esp
80103af2:	68 a2 7e 10 80       	push   $0x80107ea2
80103af7:	e8 14 d0 ff ff       	call   80100b10 <panic>
80103afc:	66 90                	xchg   %ax,%ax
80103afe:	66 90                	xchg   %ax,%ax

80103b00 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	53                   	push   %ebx
80103b04:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103b07:	e8 64 09 00 00       	call   80104470 <cpuid>
80103b0c:	89 c3                	mov    %eax,%ebx
80103b0e:	e8 5d 09 00 00       	call   80104470 <cpuid>
80103b13:	83 ec 04             	sub    $0x4,%esp
80103b16:	53                   	push   %ebx
80103b17:	50                   	push   %eax
80103b18:	68 bd 7e 10 80       	push   $0x80107ebd
80103b1d:	e8 9e cd ff ff       	call   801008c0 <cprintf>
  idtinit();       // load idt register
80103b22:	e8 e9 28 00 00       	call   80106410 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103b27:	e8 e4 08 00 00       	call   80104410 <mycpu>
80103b2c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103b2e:	b8 01 00 00 00       	mov    $0x1,%eax
80103b33:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103b3a:	e8 01 0c 00 00       	call   80104740 <scheduler>
80103b3f:	90                   	nop

80103b40 <mpenter>:
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103b46:	e8 c5 39 00 00       	call   80107510 <switchkvm>
  seginit();
80103b4b:	e8 30 39 00 00       	call   80107480 <seginit>
  lapicinit();
80103b50:	e8 bb f7 ff ff       	call   80103310 <lapicinit>
  mpmain();
80103b55:	e8 a6 ff ff ff       	call   80103b00 <mpmain>
80103b5a:	66 90                	xchg   %ax,%ax
80103b5c:	66 90                	xchg   %ax,%ax
80103b5e:	66 90                	xchg   %ax,%ax

80103b60 <main>:
{
80103b60:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103b64:	83 e4 f0             	and    $0xfffffff0,%esp
80103b67:	ff 71 fc             	push   -0x4(%ecx)
80103b6a:	55                   	push   %ebp
80103b6b:	89 e5                	mov    %esp,%ebp
80103b6d:	53                   	push   %ebx
80103b6e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103b6f:	83 ec 08             	sub    $0x8,%esp
80103b72:	68 00 00 40 80       	push   $0x80400000
80103b77:	68 d0 64 11 80       	push   $0x801164d0
80103b7c:	e8 9f f5 ff ff       	call   80103120 <kinit1>
  kvmalloc();      // kernel page table
80103b81:	e8 4a 3e 00 00       	call   801079d0 <kvmalloc>
  mpinit();        // detect other processors
80103b86:	e8 85 01 00 00       	call   80103d10 <mpinit>
  lapicinit();     // interrupt controller
80103b8b:	e8 80 f7 ff ff       	call   80103310 <lapicinit>
  seginit();       // segment descriptors
80103b90:	e8 eb 38 00 00       	call   80107480 <seginit>
  picinit();       // disable pic
80103b95:	e8 86 03 00 00       	call   80103f20 <picinit>
  ioapicinit();    // another interrupt controller
80103b9a:	e8 51 f3 ff ff       	call   80102ef0 <ioapicinit>
  consoleinit();   // console hardware
80103b9f:	e8 cc d0 ff ff       	call   80100c70 <consoleinit>
  uartinit();      // serial port
80103ba4:	e8 47 2b 00 00       	call   801066f0 <uartinit>
  pinit();         // process table
80103ba9:	e8 42 08 00 00       	call   801043f0 <pinit>
  tvinit();        // trap vectors
80103bae:	e8 dd 27 00 00       	call   80106390 <tvinit>
  binit();         // buffer cache
80103bb3:	e8 88 c4 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103bb8:	e8 a3 dd ff ff       	call   80101960 <fileinit>
  ideinit();       // disk 
80103bbd:	e8 0e f1 ff ff       	call   80102cd0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103bc2:	83 c4 0c             	add    $0xc,%esp
80103bc5:	68 8a 00 00 00       	push   $0x8a
80103bca:	68 8c b4 10 80       	push   $0x8010b48c
80103bcf:	68 00 70 00 80       	push   $0x80007000
80103bd4:	e8 87 16 00 00       	call   80105260 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103bd9:	83 c4 10             	add    $0x10,%esp
80103bdc:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103be3:	00 00 00 
80103be6:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103beb:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80103bf0:	76 7e                	jbe    80103c70 <main+0x110>
80103bf2:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80103bf7:	eb 20                	jmp    80103c19 <main+0xb9>
80103bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c00:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103c07:	00 00 00 
80103c0a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103c10:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103c15:	39 c3                	cmp    %eax,%ebx
80103c17:	73 57                	jae    80103c70 <main+0x110>
    if(c == mycpu())  // We've started already.
80103c19:	e8 f2 07 00 00       	call   80104410 <mycpu>
80103c1e:	39 c3                	cmp    %eax,%ebx
80103c20:	74 de                	je     80103c00 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103c22:	e8 69 f5 ff ff       	call   80103190 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103c27:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103c2a:	c7 05 f8 6f 00 80 40 	movl   $0x80103b40,0x80006ff8
80103c31:	3b 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103c34:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103c3b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103c3e:	05 00 10 00 00       	add    $0x1000,%eax
80103c43:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103c48:	0f b6 03             	movzbl (%ebx),%eax
80103c4b:	68 00 70 00 00       	push   $0x7000
80103c50:	50                   	push   %eax
80103c51:	e8 fa f7 ff ff       	call   80103450 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103c56:	83 c4 10             	add    $0x10,%esp
80103c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c60:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103c66:	85 c0                	test   %eax,%eax
80103c68:	74 f6                	je     80103c60 <main+0x100>
80103c6a:	eb 94                	jmp    80103c00 <main+0xa0>
80103c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103c70:	83 ec 08             	sub    $0x8,%esp
80103c73:	68 00 00 00 8e       	push   $0x8e000000
80103c78:	68 00 00 40 80       	push   $0x80400000
80103c7d:	e8 3e f4 ff ff       	call   801030c0 <kinit2>
  userinit();      // first user process
80103c82:	e8 39 08 00 00       	call   801044c0 <userinit>
  mpmain();        // finish this processor's setup
80103c87:	e8 74 fe ff ff       	call   80103b00 <mpmain>
80103c8c:	66 90                	xchg   %ax,%ax
80103c8e:	66 90                	xchg   %ax,%ax

80103c90 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103c90:	55                   	push   %ebp
80103c91:	89 e5                	mov    %esp,%ebp
80103c93:	57                   	push   %edi
80103c94:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103c95:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103c9b:	53                   	push   %ebx
  e = addr+len;
80103c9c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103c9f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103ca2:	39 de                	cmp    %ebx,%esi
80103ca4:	72 10                	jb     80103cb6 <mpsearch1+0x26>
80103ca6:	eb 50                	jmp    80103cf8 <mpsearch1+0x68>
80103ca8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103caf:	00 
80103cb0:	89 fe                	mov    %edi,%esi
80103cb2:	39 df                	cmp    %ebx,%edi
80103cb4:	73 42                	jae    80103cf8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103cb6:	83 ec 04             	sub    $0x4,%esp
80103cb9:	8d 7e 10             	lea    0x10(%esi),%edi
80103cbc:	6a 04                	push   $0x4
80103cbe:	68 d1 7e 10 80       	push   $0x80107ed1
80103cc3:	56                   	push   %esi
80103cc4:	e8 47 15 00 00       	call   80105210 <memcmp>
80103cc9:	83 c4 10             	add    $0x10,%esp
80103ccc:	85 c0                	test   %eax,%eax
80103cce:	75 e0                	jne    80103cb0 <mpsearch1+0x20>
80103cd0:	89 f2                	mov    %esi,%edx
80103cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103cd8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103cdb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103cde:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103ce0:	39 fa                	cmp    %edi,%edx
80103ce2:	75 f4                	jne    80103cd8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103ce4:	84 c0                	test   %al,%al
80103ce6:	75 c8                	jne    80103cb0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103ce8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ceb:	89 f0                	mov    %esi,%eax
80103ced:	5b                   	pop    %ebx
80103cee:	5e                   	pop    %esi
80103cef:	5f                   	pop    %edi
80103cf0:	5d                   	pop    %ebp
80103cf1:	c3                   	ret
80103cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103cf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103cfb:	31 f6                	xor    %esi,%esi
}
80103cfd:	5b                   	pop    %ebx
80103cfe:	89 f0                	mov    %esi,%eax
80103d00:	5e                   	pop    %esi
80103d01:	5f                   	pop    %edi
80103d02:	5d                   	pop    %ebp
80103d03:	c3                   	ret
80103d04:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d0b:	00 
80103d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103d10 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	57                   	push   %edi
80103d14:	56                   	push   %esi
80103d15:	53                   	push   %ebx
80103d16:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103d19:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103d20:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103d27:	c1 e0 08             	shl    $0x8,%eax
80103d2a:	09 d0                	or     %edx,%eax
80103d2c:	c1 e0 04             	shl    $0x4,%eax
80103d2f:	75 1b                	jne    80103d4c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103d31:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103d38:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103d3f:	c1 e0 08             	shl    $0x8,%eax
80103d42:	09 d0                	or     %edx,%eax
80103d44:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103d47:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103d4c:	ba 00 04 00 00       	mov    $0x400,%edx
80103d51:	e8 3a ff ff ff       	call   80103c90 <mpsearch1>
80103d56:	89 c3                	mov    %eax,%ebx
80103d58:	85 c0                	test   %eax,%eax
80103d5a:	0f 84 58 01 00 00    	je     80103eb8 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103d60:	8b 73 04             	mov    0x4(%ebx),%esi
80103d63:	85 f6                	test   %esi,%esi
80103d65:	0f 84 3d 01 00 00    	je     80103ea8 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
80103d6b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103d6e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103d74:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103d77:	6a 04                	push   $0x4
80103d79:	68 d6 7e 10 80       	push   $0x80107ed6
80103d7e:	50                   	push   %eax
80103d7f:	e8 8c 14 00 00       	call   80105210 <memcmp>
80103d84:	83 c4 10             	add    $0x10,%esp
80103d87:	85 c0                	test   %eax,%eax
80103d89:	0f 85 19 01 00 00    	jne    80103ea8 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
80103d8f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103d96:	3c 01                	cmp    $0x1,%al
80103d98:	74 08                	je     80103da2 <mpinit+0x92>
80103d9a:	3c 04                	cmp    $0x4,%al
80103d9c:	0f 85 06 01 00 00    	jne    80103ea8 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80103da2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103da9:	66 85 d2             	test   %dx,%dx
80103dac:	74 22                	je     80103dd0 <mpinit+0xc0>
80103dae:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103db1:	89 f0                	mov    %esi,%eax
  sum = 0;
80103db3:	31 d2                	xor    %edx,%edx
80103db5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103db8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103dbf:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103dc2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103dc4:	39 f8                	cmp    %edi,%eax
80103dc6:	75 f0                	jne    80103db8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103dc8:	84 d2                	test   %dl,%dl
80103dca:	0f 85 d8 00 00 00    	jne    80103ea8 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103dd0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103dd6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103dd9:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
80103ddc:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103de1:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103de8:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103dee:	01 d7                	add    %edx,%edi
80103df0:	89 fa                	mov    %edi,%edx
  ismp = 1;
80103df2:	bf 01 00 00 00       	mov    $0x1,%edi
80103df7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103dfe:	00 
80103dff:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e00:	39 d0                	cmp    %edx,%eax
80103e02:	73 19                	jae    80103e1d <mpinit+0x10d>
    switch(*p){
80103e04:	0f b6 08             	movzbl (%eax),%ecx
80103e07:	80 f9 02             	cmp    $0x2,%cl
80103e0a:	0f 84 80 00 00 00    	je     80103e90 <mpinit+0x180>
80103e10:	77 6e                	ja     80103e80 <mpinit+0x170>
80103e12:	84 c9                	test   %cl,%cl
80103e14:	74 3a                	je     80103e50 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103e16:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e19:	39 d0                	cmp    %edx,%eax
80103e1b:	72 e7                	jb     80103e04 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103e1d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103e20:	85 ff                	test   %edi,%edi
80103e22:	0f 84 dd 00 00 00    	je     80103f05 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103e28:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103e2c:	74 15                	je     80103e43 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103e2e:	b8 70 00 00 00       	mov    $0x70,%eax
80103e33:	ba 22 00 00 00       	mov    $0x22,%edx
80103e38:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103e39:	ba 23 00 00 00       	mov    $0x23,%edx
80103e3e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103e3f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103e42:	ee                   	out    %al,(%dx)
  }
}
80103e43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e46:	5b                   	pop    %ebx
80103e47:	5e                   	pop    %esi
80103e48:	5f                   	pop    %edi
80103e49:	5d                   	pop    %ebp
80103e4a:	c3                   	ret
80103e4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103e50:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103e56:	83 f9 07             	cmp    $0x7,%ecx
80103e59:	7f 19                	jg     80103e74 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103e5b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80103e61:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103e65:	83 c1 01             	add    $0x1,%ecx
80103e68:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103e6e:	88 9e a0 27 11 80    	mov    %bl,-0x7feed860(%esi)
      p += sizeof(struct mpproc);
80103e74:	83 c0 14             	add    $0x14,%eax
      continue;
80103e77:	eb 87                	jmp    80103e00 <mpinit+0xf0>
80103e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103e80:	83 e9 03             	sub    $0x3,%ecx
80103e83:	80 f9 01             	cmp    $0x1,%cl
80103e86:	76 8e                	jbe    80103e16 <mpinit+0x106>
80103e88:	31 ff                	xor    %edi,%edi
80103e8a:	e9 71 ff ff ff       	jmp    80103e00 <mpinit+0xf0>
80103e8f:	90                   	nop
      ioapicid = ioapic->apicno;
80103e90:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103e94:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103e97:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
80103e9d:	e9 5e ff ff ff       	jmp    80103e00 <mpinit+0xf0>
80103ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103ea8:	83 ec 0c             	sub    $0xc,%esp
80103eab:	68 db 7e 10 80       	push   $0x80107edb
80103eb0:	e8 5b cc ff ff       	call   80100b10 <panic>
80103eb5:	8d 76 00             	lea    0x0(%esi),%esi
{
80103eb8:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103ebd:	eb 0b                	jmp    80103eca <mpinit+0x1ba>
80103ebf:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103ec0:	89 f3                	mov    %esi,%ebx
80103ec2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103ec8:	74 de                	je     80103ea8 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103eca:	83 ec 04             	sub    $0x4,%esp
80103ecd:	8d 73 10             	lea    0x10(%ebx),%esi
80103ed0:	6a 04                	push   $0x4
80103ed2:	68 d1 7e 10 80       	push   $0x80107ed1
80103ed7:	53                   	push   %ebx
80103ed8:	e8 33 13 00 00       	call   80105210 <memcmp>
80103edd:	83 c4 10             	add    $0x10,%esp
80103ee0:	85 c0                	test   %eax,%eax
80103ee2:	75 dc                	jne    80103ec0 <mpinit+0x1b0>
80103ee4:	89 da                	mov    %ebx,%edx
80103ee6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103eed:	00 
80103eee:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80103ef0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103ef3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103ef6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103ef8:	39 d6                	cmp    %edx,%esi
80103efa:	75 f4                	jne    80103ef0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103efc:	84 c0                	test   %al,%al
80103efe:	75 c0                	jne    80103ec0 <mpinit+0x1b0>
80103f00:	e9 5b fe ff ff       	jmp    80103d60 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103f05:	83 ec 0c             	sub    $0xc,%esp
80103f08:	68 ac 82 10 80       	push   $0x801082ac
80103f0d:	e8 fe cb ff ff       	call   80100b10 <panic>
80103f12:	66 90                	xchg   %ax,%ax
80103f14:	66 90                	xchg   %ax,%ax
80103f16:	66 90                	xchg   %ax,%ax
80103f18:	66 90                	xchg   %ax,%ax
80103f1a:	66 90                	xchg   %ax,%ax
80103f1c:	66 90                	xchg   %ax,%ax
80103f1e:	66 90                	xchg   %ax,%ax

80103f20 <picinit>:
80103f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f25:	ba 21 00 00 00       	mov    $0x21,%edx
80103f2a:	ee                   	out    %al,(%dx)
80103f2b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103f30:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103f31:	c3                   	ret
80103f32:	66 90                	xchg   %ax,%ax
80103f34:	66 90                	xchg   %ax,%ax
80103f36:	66 90                	xchg   %ax,%ax
80103f38:	66 90                	xchg   %ax,%ax
80103f3a:	66 90                	xchg   %ax,%ax
80103f3c:	66 90                	xchg   %ax,%ax
80103f3e:	66 90                	xchg   %ax,%ax

80103f40 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	57                   	push   %edi
80103f44:	56                   	push   %esi
80103f45:	53                   	push   %ebx
80103f46:	83 ec 0c             	sub    $0xc,%esp
80103f49:	8b 75 08             	mov    0x8(%ebp),%esi
80103f4c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103f4f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103f55:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103f5b:	e8 20 da ff ff       	call   80101980 <filealloc>
80103f60:	89 06                	mov    %eax,(%esi)
80103f62:	85 c0                	test   %eax,%eax
80103f64:	0f 84 a5 00 00 00    	je     8010400f <pipealloc+0xcf>
80103f6a:	e8 11 da ff ff       	call   80101980 <filealloc>
80103f6f:	89 07                	mov    %eax,(%edi)
80103f71:	85 c0                	test   %eax,%eax
80103f73:	0f 84 84 00 00 00    	je     80103ffd <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103f79:	e8 12 f2 ff ff       	call   80103190 <kalloc>
80103f7e:	89 c3                	mov    %eax,%ebx
80103f80:	85 c0                	test   %eax,%eax
80103f82:	0f 84 a0 00 00 00    	je     80104028 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103f88:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103f8f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103f92:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103f95:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103f9c:	00 00 00 
  p->nwrite = 0;
80103f9f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103fa6:	00 00 00 
  p->nread = 0;
80103fa9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103fb0:	00 00 00 
  initlock(&p->lock, "pipe");
80103fb3:	68 f3 7e 10 80       	push   $0x80107ef3
80103fb8:	50                   	push   %eax
80103fb9:	e8 22 0f 00 00       	call   80104ee0 <initlock>
  (*f0)->type = FD_PIPE;
80103fbe:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103fc0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103fc3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103fc9:	8b 06                	mov    (%esi),%eax
80103fcb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103fcf:	8b 06                	mov    (%esi),%eax
80103fd1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103fd5:	8b 06                	mov    (%esi),%eax
80103fd7:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103fda:	8b 07                	mov    (%edi),%eax
80103fdc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103fe2:	8b 07                	mov    (%edi),%eax
80103fe4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103fe8:	8b 07                	mov    (%edi),%eax
80103fea:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103fee:	8b 07                	mov    (%edi),%eax
80103ff0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103ff3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103ff5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ff8:	5b                   	pop    %ebx
80103ff9:	5e                   	pop    %esi
80103ffa:	5f                   	pop    %edi
80103ffb:	5d                   	pop    %ebp
80103ffc:	c3                   	ret
  if(*f0)
80103ffd:	8b 06                	mov    (%esi),%eax
80103fff:	85 c0                	test   %eax,%eax
80104001:	74 1e                	je     80104021 <pipealloc+0xe1>
    fileclose(*f0);
80104003:	83 ec 0c             	sub    $0xc,%esp
80104006:	50                   	push   %eax
80104007:	e8 34 da ff ff       	call   80101a40 <fileclose>
8010400c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010400f:	8b 07                	mov    (%edi),%eax
80104011:	85 c0                	test   %eax,%eax
80104013:	74 0c                	je     80104021 <pipealloc+0xe1>
    fileclose(*f1);
80104015:	83 ec 0c             	sub    $0xc,%esp
80104018:	50                   	push   %eax
80104019:	e8 22 da ff ff       	call   80101a40 <fileclose>
8010401e:	83 c4 10             	add    $0x10,%esp
  return -1;
80104021:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104026:	eb cd                	jmp    80103ff5 <pipealloc+0xb5>
  if(*f0)
80104028:	8b 06                	mov    (%esi),%eax
8010402a:	85 c0                	test   %eax,%eax
8010402c:	75 d5                	jne    80104003 <pipealloc+0xc3>
8010402e:	eb df                	jmp    8010400f <pipealloc+0xcf>

80104030 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	56                   	push   %esi
80104034:	53                   	push   %ebx
80104035:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104038:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010403b:	83 ec 0c             	sub    $0xc,%esp
8010403e:	53                   	push   %ebx
8010403f:	e8 8c 10 00 00       	call   801050d0 <acquire>
  if(writable){
80104044:	83 c4 10             	add    $0x10,%esp
80104047:	85 f6                	test   %esi,%esi
80104049:	74 65                	je     801040b0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010404b:	83 ec 0c             	sub    $0xc,%esp
8010404e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104054:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010405b:	00 00 00 
    wakeup(&p->nread);
8010405e:	50                   	push   %eax
8010405f:	e8 ac 0b 00 00       	call   80104c10 <wakeup>
80104064:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104067:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010406d:	85 d2                	test   %edx,%edx
8010406f:	75 0a                	jne    8010407b <pipeclose+0x4b>
80104071:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104077:	85 c0                	test   %eax,%eax
80104079:	74 15                	je     80104090 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010407b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010407e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104081:	5b                   	pop    %ebx
80104082:	5e                   	pop    %esi
80104083:	5d                   	pop    %ebp
    release(&p->lock);
80104084:	e9 e7 0f 00 00       	jmp    80105070 <release>
80104089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104090:	83 ec 0c             	sub    $0xc,%esp
80104093:	53                   	push   %ebx
80104094:	e8 d7 0f 00 00       	call   80105070 <release>
    kfree((char*)p);
80104099:	83 c4 10             	add    $0x10,%esp
8010409c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010409f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040a2:	5b                   	pop    %ebx
801040a3:	5e                   	pop    %esi
801040a4:	5d                   	pop    %ebp
    kfree((char*)p);
801040a5:	e9 26 ef ff ff       	jmp    80102fd0 <kfree>
801040aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801040b0:	83 ec 0c             	sub    $0xc,%esp
801040b3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801040b9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801040c0:	00 00 00 
    wakeup(&p->nwrite);
801040c3:	50                   	push   %eax
801040c4:	e8 47 0b 00 00       	call   80104c10 <wakeup>
801040c9:	83 c4 10             	add    $0x10,%esp
801040cc:	eb 99                	jmp    80104067 <pipeclose+0x37>
801040ce:	66 90                	xchg   %ax,%ax

801040d0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	57                   	push   %edi
801040d4:	56                   	push   %esi
801040d5:	53                   	push   %ebx
801040d6:	83 ec 28             	sub    $0x28,%esp
801040d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801040dc:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
801040df:	53                   	push   %ebx
801040e0:	e8 eb 0f 00 00       	call   801050d0 <acquire>
  for(i = 0; i < n; i++){
801040e5:	83 c4 10             	add    $0x10,%esp
801040e8:	85 ff                	test   %edi,%edi
801040ea:	0f 8e ce 00 00 00    	jle    801041be <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801040f0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801040f6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801040f9:	89 7d 10             	mov    %edi,0x10(%ebp)
801040fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801040ff:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80104102:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80104105:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010410b:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104111:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104117:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010411d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80104120:	0f 85 b6 00 00 00    	jne    801041dc <pipewrite+0x10c>
80104126:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80104129:	eb 3b                	jmp    80104166 <pipewrite+0x96>
8010412b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104130:	e8 5b 03 00 00       	call   80104490 <myproc>
80104135:	8b 48 24             	mov    0x24(%eax),%ecx
80104138:	85 c9                	test   %ecx,%ecx
8010413a:	75 34                	jne    80104170 <pipewrite+0xa0>
      wakeup(&p->nread);
8010413c:	83 ec 0c             	sub    $0xc,%esp
8010413f:	56                   	push   %esi
80104140:	e8 cb 0a 00 00       	call   80104c10 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104145:	58                   	pop    %eax
80104146:	5a                   	pop    %edx
80104147:	53                   	push   %ebx
80104148:	57                   	push   %edi
80104149:	e8 02 0a 00 00       	call   80104b50 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010414e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80104154:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010415a:	83 c4 10             	add    $0x10,%esp
8010415d:	05 00 02 00 00       	add    $0x200,%eax
80104162:	39 c2                	cmp    %eax,%edx
80104164:	75 2a                	jne    80104190 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80104166:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010416c:	85 c0                	test   %eax,%eax
8010416e:	75 c0                	jne    80104130 <pipewrite+0x60>
        release(&p->lock);
80104170:	83 ec 0c             	sub    $0xc,%esp
80104173:	53                   	push   %ebx
80104174:	e8 f7 0e 00 00       	call   80105070 <release>
        return -1;
80104179:	83 c4 10             	add    $0x10,%esp
8010417c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104181:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104184:	5b                   	pop    %ebx
80104185:	5e                   	pop    %esi
80104186:	5f                   	pop    %edi
80104187:	5d                   	pop    %ebp
80104188:	c3                   	ret
80104189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104190:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104193:	8d 42 01             	lea    0x1(%edx),%eax
80104196:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010419c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010419f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801041a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801041a8:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
801041ac:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801041b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801041b3:	39 c1                	cmp    %eax,%ecx
801041b5:	0f 85 50 ff ff ff    	jne    8010410b <pipewrite+0x3b>
801041bb:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801041be:	83 ec 0c             	sub    $0xc,%esp
801041c1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801041c7:	50                   	push   %eax
801041c8:	e8 43 0a 00 00       	call   80104c10 <wakeup>
  release(&p->lock);
801041cd:	89 1c 24             	mov    %ebx,(%esp)
801041d0:	e8 9b 0e 00 00       	call   80105070 <release>
  return n;
801041d5:	83 c4 10             	add    $0x10,%esp
801041d8:	89 f8                	mov    %edi,%eax
801041da:	eb a5                	jmp    80104181 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041dc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801041df:	eb b2                	jmp    80104193 <pipewrite+0xc3>
801041e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041e8:	00 
801041e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041f0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	57                   	push   %edi
801041f4:	56                   	push   %esi
801041f5:	53                   	push   %ebx
801041f6:	83 ec 18             	sub    $0x18,%esp
801041f9:	8b 75 08             	mov    0x8(%ebp),%esi
801041fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801041ff:	56                   	push   %esi
80104200:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80104206:	e8 c5 0e 00 00       	call   801050d0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010420b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104211:	83 c4 10             	add    $0x10,%esp
80104214:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010421a:	74 2f                	je     8010424b <piperead+0x5b>
8010421c:	eb 37                	jmp    80104255 <piperead+0x65>
8010421e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80104220:	e8 6b 02 00 00       	call   80104490 <myproc>
80104225:	8b 40 24             	mov    0x24(%eax),%eax
80104228:	85 c0                	test   %eax,%eax
8010422a:	0f 85 80 00 00 00    	jne    801042b0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104230:	83 ec 08             	sub    $0x8,%esp
80104233:	56                   	push   %esi
80104234:	53                   	push   %ebx
80104235:	e8 16 09 00 00       	call   80104b50 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010423a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104240:	83 c4 10             	add    $0x10,%esp
80104243:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80104249:	75 0a                	jne    80104255 <piperead+0x65>
8010424b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80104251:	85 d2                	test   %edx,%edx
80104253:	75 cb                	jne    80104220 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104255:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104258:	31 db                	xor    %ebx,%ebx
8010425a:	85 c9                	test   %ecx,%ecx
8010425c:	7f 26                	jg     80104284 <piperead+0x94>
8010425e:	eb 2c                	jmp    8010428c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104260:	8d 48 01             	lea    0x1(%eax),%ecx
80104263:	25 ff 01 00 00       	and    $0x1ff,%eax
80104268:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010426e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104273:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104276:	83 c3 01             	add    $0x1,%ebx
80104279:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010427c:	74 0e                	je     8010428c <piperead+0x9c>
8010427e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80104284:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010428a:	75 d4                	jne    80104260 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010428c:	83 ec 0c             	sub    $0xc,%esp
8010428f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104295:	50                   	push   %eax
80104296:	e8 75 09 00 00       	call   80104c10 <wakeup>
  release(&p->lock);
8010429b:	89 34 24             	mov    %esi,(%esp)
8010429e:	e8 cd 0d 00 00       	call   80105070 <release>
  return i;
801042a3:	83 c4 10             	add    $0x10,%esp
}
801042a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042a9:	89 d8                	mov    %ebx,%eax
801042ab:	5b                   	pop    %ebx
801042ac:	5e                   	pop    %esi
801042ad:	5f                   	pop    %edi
801042ae:	5d                   	pop    %ebp
801042af:	c3                   	ret
      release(&p->lock);
801042b0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801042b3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801042b8:	56                   	push   %esi
801042b9:	e8 b2 0d 00 00       	call   80105070 <release>
      return -1;
801042be:	83 c4 10             	add    $0x10,%esp
}
801042c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042c4:	89 d8                	mov    %ebx,%eax
801042c6:	5b                   	pop    %ebx
801042c7:	5e                   	pop    %esi
801042c8:	5f                   	pop    %edi
801042c9:	5d                   	pop    %ebp
801042ca:	c3                   	ret
801042cb:	66 90                	xchg   %ax,%ax
801042cd:	66 90                	xchg   %ax,%ax
801042cf:	90                   	nop

801042d0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042d4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801042d9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801042dc:	68 20 2d 11 80       	push   $0x80112d20
801042e1:	e8 ea 0d 00 00       	call   801050d0 <acquire>
801042e6:	83 c4 10             	add    $0x10,%esp
801042e9:	eb 10                	jmp    801042fb <allocproc+0x2b>
801042eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042f0:	83 c3 7c             	add    $0x7c,%ebx
801042f3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801042f9:	74 75                	je     80104370 <allocproc+0xa0>
    if(p->state == UNUSED)
801042fb:	8b 43 0c             	mov    0xc(%ebx),%eax
801042fe:	85 c0                	test   %eax,%eax
80104300:	75 ee                	jne    801042f0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80104302:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80104307:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010430a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80104311:	89 43 10             	mov    %eax,0x10(%ebx)
80104314:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80104317:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
8010431c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80104322:	e8 49 0d 00 00       	call   80105070 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104327:	e8 64 ee ff ff       	call   80103190 <kalloc>
8010432c:	83 c4 10             	add    $0x10,%esp
8010432f:	89 43 08             	mov    %eax,0x8(%ebx)
80104332:	85 c0                	test   %eax,%eax
80104334:	74 53                	je     80104389 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104336:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010433c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010433f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80104344:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80104347:	c7 40 14 82 63 10 80 	movl   $0x80106382,0x14(%eax)
  p->context = (struct context*)sp;
8010434e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104351:	6a 14                	push   $0x14
80104353:	6a 00                	push   $0x0
80104355:	50                   	push   %eax
80104356:	e8 75 0e 00 00       	call   801051d0 <memset>
  p->context->eip = (uint)forkret;
8010435b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010435e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104361:	c7 40 10 a0 43 10 80 	movl   $0x801043a0,0x10(%eax)
}
80104368:	89 d8                	mov    %ebx,%eax
8010436a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010436d:	c9                   	leave
8010436e:	c3                   	ret
8010436f:	90                   	nop
  release(&ptable.lock);
80104370:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104373:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104375:	68 20 2d 11 80       	push   $0x80112d20
8010437a:	e8 f1 0c 00 00       	call   80105070 <release>
  return 0;
8010437f:	83 c4 10             	add    $0x10,%esp
}
80104382:	89 d8                	mov    %ebx,%eax
80104384:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104387:	c9                   	leave
80104388:	c3                   	ret
    p->state = UNUSED;
80104389:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80104390:	31 db                	xor    %ebx,%ebx
80104392:	eb ee                	jmp    80104382 <allocproc+0xb2>
80104394:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010439b:	00 
8010439c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801043a6:	68 20 2d 11 80       	push   $0x80112d20
801043ab:	e8 c0 0c 00 00       	call   80105070 <release>

  if (first) {
801043b0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801043b5:	83 c4 10             	add    $0x10,%esp
801043b8:	85 c0                	test   %eax,%eax
801043ba:	75 04                	jne    801043c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801043bc:	c9                   	leave
801043bd:	c3                   	ret
801043be:	66 90                	xchg   %ax,%ax
    first = 0;
801043c0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801043c7:	00 00 00 
    iinit(ROOTDEV);
801043ca:	83 ec 0c             	sub    $0xc,%esp
801043cd:	6a 01                	push   $0x1
801043cf:	e8 dc dc ff ff       	call   801020b0 <iinit>
    initlog(ROOTDEV);
801043d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801043db:	e8 f0 f3 ff ff       	call   801037d0 <initlog>
}
801043e0:	83 c4 10             	add    $0x10,%esp
801043e3:	c9                   	leave
801043e4:	c3                   	ret
801043e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043ec:	00 
801043ed:	8d 76 00             	lea    0x0(%esi),%esi

801043f0 <pinit>:
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801043f6:	68 f8 7e 10 80       	push   $0x80107ef8
801043fb:	68 20 2d 11 80       	push   $0x80112d20
80104400:	e8 db 0a 00 00       	call   80104ee0 <initlock>
}
80104405:	83 c4 10             	add    $0x10,%esp
80104408:	c9                   	leave
80104409:	c3                   	ret
8010440a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104410 <mycpu>:
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	56                   	push   %esi
80104414:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104415:	9c                   	pushf
80104416:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104417:	f6 c4 02             	test   $0x2,%ah
8010441a:	75 46                	jne    80104462 <mycpu+0x52>
  apicid = lapicid();
8010441c:	e8 df ef ff ff       	call   80103400 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80104421:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80104427:	85 f6                	test   %esi,%esi
80104429:	7e 2a                	jle    80104455 <mycpu+0x45>
8010442b:	31 d2                	xor    %edx,%edx
8010442d:	eb 08                	jmp    80104437 <mycpu+0x27>
8010442f:	90                   	nop
80104430:	83 c2 01             	add    $0x1,%edx
80104433:	39 f2                	cmp    %esi,%edx
80104435:	74 1e                	je     80104455 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80104437:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010443d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
80104444:	39 c3                	cmp    %eax,%ebx
80104446:	75 e8                	jne    80104430 <mycpu+0x20>
}
80104448:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010444b:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
80104451:	5b                   	pop    %ebx
80104452:	5e                   	pop    %esi
80104453:	5d                   	pop    %ebp
80104454:	c3                   	ret
  panic("unknown apicid\n");
80104455:	83 ec 0c             	sub    $0xc,%esp
80104458:	68 ff 7e 10 80       	push   $0x80107eff
8010445d:	e8 ae c6 ff ff       	call   80100b10 <panic>
    panic("mycpu called with interrupts enabled\n");
80104462:	83 ec 0c             	sub    $0xc,%esp
80104465:	68 cc 82 10 80       	push   $0x801082cc
8010446a:	e8 a1 c6 ff ff       	call   80100b10 <panic>
8010446f:	90                   	nop

80104470 <cpuid>:
cpuid() {
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104476:	e8 95 ff ff ff       	call   80104410 <mycpu>
}
8010447b:	c9                   	leave
  return mycpu()-cpus;
8010447c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80104481:	c1 f8 04             	sar    $0x4,%eax
80104484:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010448a:	c3                   	ret
8010448b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104490 <myproc>:
myproc(void) {
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104497:	e8 e4 0a 00 00       	call   80104f80 <pushcli>
  c = mycpu();
8010449c:	e8 6f ff ff ff       	call   80104410 <mycpu>
  p = c->proc;
801044a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801044a7:	e8 24 0b 00 00       	call   80104fd0 <popcli>
}
801044ac:	89 d8                	mov    %ebx,%eax
801044ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044b1:	c9                   	leave
801044b2:	c3                   	ret
801044b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044ba:	00 
801044bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801044c0 <userinit>:
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	53                   	push   %ebx
801044c4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801044c7:	e8 04 fe ff ff       	call   801042d0 <allocproc>
801044cc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801044ce:	a3 54 4c 11 80       	mov    %eax,0x80114c54
  if((p->pgdir = setupkvm()) == 0)
801044d3:	e8 78 34 00 00       	call   80107950 <setupkvm>
801044d8:	89 43 04             	mov    %eax,0x4(%ebx)
801044db:	85 c0                	test   %eax,%eax
801044dd:	0f 84 bd 00 00 00    	je     801045a0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801044e3:	83 ec 04             	sub    $0x4,%esp
801044e6:	68 2c 00 00 00       	push   $0x2c
801044eb:	68 60 b4 10 80       	push   $0x8010b460
801044f0:	50                   	push   %eax
801044f1:	e8 3a 31 00 00       	call   80107630 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801044f6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801044f9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801044ff:	6a 4c                	push   $0x4c
80104501:	6a 00                	push   $0x0
80104503:	ff 73 18             	push   0x18(%ebx)
80104506:	e8 c5 0c 00 00       	call   801051d0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010450b:	8b 43 18             	mov    0x18(%ebx),%eax
8010450e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104513:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104516:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010451b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010451f:	8b 43 18             	mov    0x18(%ebx),%eax
80104522:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104526:	8b 43 18             	mov    0x18(%ebx),%eax
80104529:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010452d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104531:	8b 43 18             	mov    0x18(%ebx),%eax
80104534:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104538:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010453c:	8b 43 18             	mov    0x18(%ebx),%eax
8010453f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104546:	8b 43 18             	mov    0x18(%ebx),%eax
80104549:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104550:	8b 43 18             	mov    0x18(%ebx),%eax
80104553:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010455a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010455d:	6a 10                	push   $0x10
8010455f:	68 28 7f 10 80       	push   $0x80107f28
80104564:	50                   	push   %eax
80104565:	e8 16 0e 00 00       	call   80105380 <safestrcpy>
  p->cwd = namei("/");
8010456a:	c7 04 24 31 7f 10 80 	movl   $0x80107f31,(%esp)
80104571:	e8 3a e6 ff ff       	call   80102bb0 <namei>
80104576:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104579:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104580:	e8 4b 0b 00 00       	call   801050d0 <acquire>
  p->state = RUNNABLE;
80104585:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010458c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104593:	e8 d8 0a 00 00       	call   80105070 <release>
}
80104598:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010459b:	83 c4 10             	add    $0x10,%esp
8010459e:	c9                   	leave
8010459f:	c3                   	ret
    panic("userinit: out of memory?");
801045a0:	83 ec 0c             	sub    $0xc,%esp
801045a3:	68 0f 7f 10 80       	push   $0x80107f0f
801045a8:	e8 63 c5 ff ff       	call   80100b10 <panic>
801045ad:	8d 76 00             	lea    0x0(%esi),%esi

801045b0 <growproc>:
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	56                   	push   %esi
801045b4:	53                   	push   %ebx
801045b5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801045b8:	e8 c3 09 00 00       	call   80104f80 <pushcli>
  c = mycpu();
801045bd:	e8 4e fe ff ff       	call   80104410 <mycpu>
  p = c->proc;
801045c2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045c8:	e8 03 0a 00 00       	call   80104fd0 <popcli>
  sz = curproc->sz;
801045cd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801045cf:	85 f6                	test   %esi,%esi
801045d1:	7f 1d                	jg     801045f0 <growproc+0x40>
  } else if(n < 0){
801045d3:	75 3b                	jne    80104610 <growproc+0x60>
  switchuvm(curproc);
801045d5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801045d8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801045da:	53                   	push   %ebx
801045db:	e8 40 2f 00 00       	call   80107520 <switchuvm>
  return 0;
801045e0:	83 c4 10             	add    $0x10,%esp
801045e3:	31 c0                	xor    %eax,%eax
}
801045e5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045e8:	5b                   	pop    %ebx
801045e9:	5e                   	pop    %esi
801045ea:	5d                   	pop    %ebp
801045eb:	c3                   	ret
801045ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801045f0:	83 ec 04             	sub    $0x4,%esp
801045f3:	01 c6                	add    %eax,%esi
801045f5:	56                   	push   %esi
801045f6:	50                   	push   %eax
801045f7:	ff 73 04             	push   0x4(%ebx)
801045fa:	e8 81 31 00 00       	call   80107780 <allocuvm>
801045ff:	83 c4 10             	add    $0x10,%esp
80104602:	85 c0                	test   %eax,%eax
80104604:	75 cf                	jne    801045d5 <growproc+0x25>
      return -1;
80104606:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010460b:	eb d8                	jmp    801045e5 <growproc+0x35>
8010460d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104610:	83 ec 04             	sub    $0x4,%esp
80104613:	01 c6                	add    %eax,%esi
80104615:	56                   	push   %esi
80104616:	50                   	push   %eax
80104617:	ff 73 04             	push   0x4(%ebx)
8010461a:	e8 81 32 00 00       	call   801078a0 <deallocuvm>
8010461f:	83 c4 10             	add    $0x10,%esp
80104622:	85 c0                	test   %eax,%eax
80104624:	75 af                	jne    801045d5 <growproc+0x25>
80104626:	eb de                	jmp    80104606 <growproc+0x56>
80104628:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010462f:	00 

80104630 <fork>:
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	57                   	push   %edi
80104634:	56                   	push   %esi
80104635:	53                   	push   %ebx
80104636:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104639:	e8 42 09 00 00       	call   80104f80 <pushcli>
  c = mycpu();
8010463e:	e8 cd fd ff ff       	call   80104410 <mycpu>
  p = c->proc;
80104643:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104649:	e8 82 09 00 00       	call   80104fd0 <popcli>
  if((np = allocproc()) == 0){
8010464e:	e8 7d fc ff ff       	call   801042d0 <allocproc>
80104653:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104656:	85 c0                	test   %eax,%eax
80104658:	0f 84 d6 00 00 00    	je     80104734 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010465e:	83 ec 08             	sub    $0x8,%esp
80104661:	ff 33                	push   (%ebx)
80104663:	89 c7                	mov    %eax,%edi
80104665:	ff 73 04             	push   0x4(%ebx)
80104668:	e8 d3 33 00 00       	call   80107a40 <copyuvm>
8010466d:	83 c4 10             	add    $0x10,%esp
80104670:	89 47 04             	mov    %eax,0x4(%edi)
80104673:	85 c0                	test   %eax,%eax
80104675:	0f 84 9a 00 00 00    	je     80104715 <fork+0xe5>
  np->sz = curproc->sz;
8010467b:	8b 03                	mov    (%ebx),%eax
8010467d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104680:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104682:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104685:	89 c8                	mov    %ecx,%eax
80104687:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010468a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010468f:	8b 73 18             	mov    0x18(%ebx),%esi
80104692:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104694:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104696:	8b 40 18             	mov    0x18(%eax),%eax
80104699:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
801046a0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801046a4:	85 c0                	test   %eax,%eax
801046a6:	74 13                	je     801046bb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801046a8:	83 ec 0c             	sub    $0xc,%esp
801046ab:	50                   	push   %eax
801046ac:	e8 3f d3 ff ff       	call   801019f0 <filedup>
801046b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046b4:	83 c4 10             	add    $0x10,%esp
801046b7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801046bb:	83 c6 01             	add    $0x1,%esi
801046be:	83 fe 10             	cmp    $0x10,%esi
801046c1:	75 dd                	jne    801046a0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
801046c3:	83 ec 0c             	sub    $0xc,%esp
801046c6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801046c9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
801046cc:	e8 cf db ff ff       	call   801022a0 <idup>
801046d1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801046d4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801046d7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801046da:	8d 47 6c             	lea    0x6c(%edi),%eax
801046dd:	6a 10                	push   $0x10
801046df:	53                   	push   %ebx
801046e0:	50                   	push   %eax
801046e1:	e8 9a 0c 00 00       	call   80105380 <safestrcpy>
  pid = np->pid;
801046e6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
801046e9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801046f0:	e8 db 09 00 00       	call   801050d0 <acquire>
  np->state = RUNNABLE;
801046f5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
801046fc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104703:	e8 68 09 00 00       	call   80105070 <release>
  return pid;
80104708:	83 c4 10             	add    $0x10,%esp
}
8010470b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010470e:	89 d8                	mov    %ebx,%eax
80104710:	5b                   	pop    %ebx
80104711:	5e                   	pop    %esi
80104712:	5f                   	pop    %edi
80104713:	5d                   	pop    %ebp
80104714:	c3                   	ret
    kfree(np->kstack);
80104715:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104718:	83 ec 0c             	sub    $0xc,%esp
8010471b:	ff 73 08             	push   0x8(%ebx)
8010471e:	e8 ad e8 ff ff       	call   80102fd0 <kfree>
    np->kstack = 0;
80104723:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
8010472a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
8010472d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104734:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104739:	eb d0                	jmp    8010470b <fork+0xdb>
8010473b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104740 <scheduler>:
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	57                   	push   %edi
80104744:	56                   	push   %esi
80104745:	53                   	push   %ebx
80104746:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104749:	e8 c2 fc ff ff       	call   80104410 <mycpu>
  c->proc = 0;
8010474e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104755:	00 00 00 
  struct cpu *c = mycpu();
80104758:	89 c6                	mov    %eax,%esi
  c->proc = 0;
8010475a:	8d 78 04             	lea    0x4(%eax),%edi
8010475d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104760:	fb                   	sti
    acquire(&ptable.lock);
80104761:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104764:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80104769:	68 20 2d 11 80       	push   $0x80112d20
8010476e:	e8 5d 09 00 00       	call   801050d0 <acquire>
80104773:	83 c4 10             	add    $0x10,%esp
80104776:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010477d:	00 
8010477e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80104780:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104784:	75 33                	jne    801047b9 <scheduler+0x79>
      switchuvm(p);
80104786:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104789:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010478f:	53                   	push   %ebx
80104790:	e8 8b 2d 00 00       	call   80107520 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104795:	58                   	pop    %eax
80104796:	5a                   	pop    %edx
80104797:	ff 73 1c             	push   0x1c(%ebx)
8010479a:	57                   	push   %edi
      p->state = RUNNING;
8010479b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
801047a2:	e8 34 0c 00 00       	call   801053db <swtch>
      switchkvm();
801047a7:	e8 64 2d 00 00       	call   80107510 <switchkvm>
      c->proc = 0;
801047ac:	83 c4 10             	add    $0x10,%esp
801047af:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801047b6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047b9:	83 c3 7c             	add    $0x7c,%ebx
801047bc:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801047c2:	75 bc                	jne    80104780 <scheduler+0x40>
    release(&ptable.lock);
801047c4:	83 ec 0c             	sub    $0xc,%esp
801047c7:	68 20 2d 11 80       	push   $0x80112d20
801047cc:	e8 9f 08 00 00       	call   80105070 <release>
    sti();
801047d1:	83 c4 10             	add    $0x10,%esp
801047d4:	eb 8a                	jmp    80104760 <scheduler+0x20>
801047d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047dd:	00 
801047de:	66 90                	xchg   %ax,%ax

801047e0 <sched>:
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	53                   	push   %ebx
  pushcli();
801047e5:	e8 96 07 00 00       	call   80104f80 <pushcli>
  c = mycpu();
801047ea:	e8 21 fc ff ff       	call   80104410 <mycpu>
  p = c->proc;
801047ef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047f5:	e8 d6 07 00 00       	call   80104fd0 <popcli>
  if(!holding(&ptable.lock))
801047fa:	83 ec 0c             	sub    $0xc,%esp
801047fd:	68 20 2d 11 80       	push   $0x80112d20
80104802:	e8 29 08 00 00       	call   80105030 <holding>
80104807:	83 c4 10             	add    $0x10,%esp
8010480a:	85 c0                	test   %eax,%eax
8010480c:	74 4f                	je     8010485d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010480e:	e8 fd fb ff ff       	call   80104410 <mycpu>
80104813:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010481a:	75 68                	jne    80104884 <sched+0xa4>
  if(p->state == RUNNING)
8010481c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104820:	74 55                	je     80104877 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104822:	9c                   	pushf
80104823:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104824:	f6 c4 02             	test   $0x2,%ah
80104827:	75 41                	jne    8010486a <sched+0x8a>
  intena = mycpu()->intena;
80104829:	e8 e2 fb ff ff       	call   80104410 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010482e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104831:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104837:	e8 d4 fb ff ff       	call   80104410 <mycpu>
8010483c:	83 ec 08             	sub    $0x8,%esp
8010483f:	ff 70 04             	push   0x4(%eax)
80104842:	53                   	push   %ebx
80104843:	e8 93 0b 00 00       	call   801053db <swtch>
  mycpu()->intena = intena;
80104848:	e8 c3 fb ff ff       	call   80104410 <mycpu>
}
8010484d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104850:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104856:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104859:	5b                   	pop    %ebx
8010485a:	5e                   	pop    %esi
8010485b:	5d                   	pop    %ebp
8010485c:	c3                   	ret
    panic("sched ptable.lock");
8010485d:	83 ec 0c             	sub    $0xc,%esp
80104860:	68 33 7f 10 80       	push   $0x80107f33
80104865:	e8 a6 c2 ff ff       	call   80100b10 <panic>
    panic("sched interruptible");
8010486a:	83 ec 0c             	sub    $0xc,%esp
8010486d:	68 5f 7f 10 80       	push   $0x80107f5f
80104872:	e8 99 c2 ff ff       	call   80100b10 <panic>
    panic("sched running");
80104877:	83 ec 0c             	sub    $0xc,%esp
8010487a:	68 51 7f 10 80       	push   $0x80107f51
8010487f:	e8 8c c2 ff ff       	call   80100b10 <panic>
    panic("sched locks");
80104884:	83 ec 0c             	sub    $0xc,%esp
80104887:	68 45 7f 10 80       	push   $0x80107f45
8010488c:	e8 7f c2 ff ff       	call   80100b10 <panic>
80104891:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104898:	00 
80104899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801048a0 <exit>:
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	57                   	push   %edi
801048a4:	56                   	push   %esi
801048a5:	53                   	push   %ebx
801048a6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
801048a9:	e8 e2 fb ff ff       	call   80104490 <myproc>
  if(curproc == initproc)
801048ae:	39 05 54 4c 11 80    	cmp    %eax,0x80114c54
801048b4:	0f 84 fd 00 00 00    	je     801049b7 <exit+0x117>
801048ba:	89 c3                	mov    %eax,%ebx
801048bc:	8d 70 28             	lea    0x28(%eax),%esi
801048bf:	8d 78 68             	lea    0x68(%eax),%edi
801048c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
801048c8:	8b 06                	mov    (%esi),%eax
801048ca:	85 c0                	test   %eax,%eax
801048cc:	74 12                	je     801048e0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
801048ce:	83 ec 0c             	sub    $0xc,%esp
801048d1:	50                   	push   %eax
801048d2:	e8 69 d1 ff ff       	call   80101a40 <fileclose>
      curproc->ofile[fd] = 0;
801048d7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801048dd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801048e0:	83 c6 04             	add    $0x4,%esi
801048e3:	39 f7                	cmp    %esi,%edi
801048e5:	75 e1                	jne    801048c8 <exit+0x28>
  begin_op();
801048e7:	e8 84 ef ff ff       	call   80103870 <begin_op>
  iput(curproc->cwd);
801048ec:	83 ec 0c             	sub    $0xc,%esp
801048ef:	ff 73 68             	push   0x68(%ebx)
801048f2:	e8 09 db ff ff       	call   80102400 <iput>
  end_op();
801048f7:	e8 e4 ef ff ff       	call   801038e0 <end_op>
  curproc->cwd = 0;
801048fc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104903:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010490a:	e8 c1 07 00 00       	call   801050d0 <acquire>
  wakeup1(curproc->parent);
8010490f:	8b 53 14             	mov    0x14(%ebx),%edx
80104912:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104915:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010491a:	eb 0e                	jmp    8010492a <exit+0x8a>
8010491c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104920:	83 c0 7c             	add    $0x7c,%eax
80104923:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104928:	74 1c                	je     80104946 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
8010492a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010492e:	75 f0                	jne    80104920 <exit+0x80>
80104930:	3b 50 20             	cmp    0x20(%eax),%edx
80104933:	75 eb                	jne    80104920 <exit+0x80>
      p->state = RUNNABLE;
80104935:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010493c:	83 c0 7c             	add    $0x7c,%eax
8010493f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104944:	75 e4                	jne    8010492a <exit+0x8a>
      p->parent = initproc;
80104946:	8b 0d 54 4c 11 80    	mov    0x80114c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010494c:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80104951:	eb 10                	jmp    80104963 <exit+0xc3>
80104953:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104958:	83 c2 7c             	add    $0x7c,%edx
8010495b:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80104961:	74 3b                	je     8010499e <exit+0xfe>
    if(p->parent == curproc){
80104963:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104966:	75 f0                	jne    80104958 <exit+0xb8>
      if(p->state == ZOMBIE)
80104968:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010496c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010496f:	75 e7                	jne    80104958 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104971:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104976:	eb 12                	jmp    8010498a <exit+0xea>
80104978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010497f:	00 
80104980:	83 c0 7c             	add    $0x7c,%eax
80104983:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104988:	74 ce                	je     80104958 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
8010498a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010498e:	75 f0                	jne    80104980 <exit+0xe0>
80104990:	3b 48 20             	cmp    0x20(%eax),%ecx
80104993:	75 eb                	jne    80104980 <exit+0xe0>
      p->state = RUNNABLE;
80104995:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010499c:	eb e2                	jmp    80104980 <exit+0xe0>
  curproc->state = ZOMBIE;
8010499e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801049a5:	e8 36 fe ff ff       	call   801047e0 <sched>
  panic("zombie exit");
801049aa:	83 ec 0c             	sub    $0xc,%esp
801049ad:	68 80 7f 10 80       	push   $0x80107f80
801049b2:	e8 59 c1 ff ff       	call   80100b10 <panic>
    panic("init exiting");
801049b7:	83 ec 0c             	sub    $0xc,%esp
801049ba:	68 73 7f 10 80       	push   $0x80107f73
801049bf:	e8 4c c1 ff ff       	call   80100b10 <panic>
801049c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049cb:	00 
801049cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049d0 <wait>:
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	56                   	push   %esi
801049d4:	53                   	push   %ebx
  pushcli();
801049d5:	e8 a6 05 00 00       	call   80104f80 <pushcli>
  c = mycpu();
801049da:	e8 31 fa ff ff       	call   80104410 <mycpu>
  p = c->proc;
801049df:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801049e5:	e8 e6 05 00 00       	call   80104fd0 <popcli>
  acquire(&ptable.lock);
801049ea:	83 ec 0c             	sub    $0xc,%esp
801049ed:	68 20 2d 11 80       	push   $0x80112d20
801049f2:	e8 d9 06 00 00       	call   801050d0 <acquire>
801049f7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801049fa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049fc:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80104a01:	eb 10                	jmp    80104a13 <wait+0x43>
80104a03:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a08:	83 c3 7c             	add    $0x7c,%ebx
80104a0b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104a11:	74 1b                	je     80104a2e <wait+0x5e>
      if(p->parent != curproc)
80104a13:	39 73 14             	cmp    %esi,0x14(%ebx)
80104a16:	75 f0                	jne    80104a08 <wait+0x38>
      if(p->state == ZOMBIE){
80104a18:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104a1c:	74 62                	je     80104a80 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a1e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104a21:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a26:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104a2c:	75 e5                	jne    80104a13 <wait+0x43>
    if(!havekids || curproc->killed){
80104a2e:	85 c0                	test   %eax,%eax
80104a30:	0f 84 a0 00 00 00    	je     80104ad6 <wait+0x106>
80104a36:	8b 46 24             	mov    0x24(%esi),%eax
80104a39:	85 c0                	test   %eax,%eax
80104a3b:	0f 85 95 00 00 00    	jne    80104ad6 <wait+0x106>
  pushcli();
80104a41:	e8 3a 05 00 00       	call   80104f80 <pushcli>
  c = mycpu();
80104a46:	e8 c5 f9 ff ff       	call   80104410 <mycpu>
  p = c->proc;
80104a4b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104a51:	e8 7a 05 00 00       	call   80104fd0 <popcli>
  if(p == 0)
80104a56:	85 db                	test   %ebx,%ebx
80104a58:	0f 84 8f 00 00 00    	je     80104aed <wait+0x11d>
  p->chan = chan;
80104a5e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104a61:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104a68:	e8 73 fd ff ff       	call   801047e0 <sched>
  p->chan = 0;
80104a6d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104a74:	eb 84                	jmp    801049fa <wait+0x2a>
80104a76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a7d:	00 
80104a7e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104a80:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104a83:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104a86:	ff 73 08             	push   0x8(%ebx)
80104a89:	e8 42 e5 ff ff       	call   80102fd0 <kfree>
        p->kstack = 0;
80104a8e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104a95:	5a                   	pop    %edx
80104a96:	ff 73 04             	push   0x4(%ebx)
80104a99:	e8 32 2e 00 00       	call   801078d0 <freevm>
        p->pid = 0;
80104a9e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104aa5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104aac:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104ab0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104ab7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104abe:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104ac5:	e8 a6 05 00 00       	call   80105070 <release>
        return pid;
80104aca:	83 c4 10             	add    $0x10,%esp
}
80104acd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ad0:	89 f0                	mov    %esi,%eax
80104ad2:	5b                   	pop    %ebx
80104ad3:	5e                   	pop    %esi
80104ad4:	5d                   	pop    %ebp
80104ad5:	c3                   	ret
      release(&ptable.lock);
80104ad6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104ad9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104ade:	68 20 2d 11 80       	push   $0x80112d20
80104ae3:	e8 88 05 00 00       	call   80105070 <release>
      return -1;
80104ae8:	83 c4 10             	add    $0x10,%esp
80104aeb:	eb e0                	jmp    80104acd <wait+0xfd>
    panic("sleep");
80104aed:	83 ec 0c             	sub    $0xc,%esp
80104af0:	68 8c 7f 10 80       	push   $0x80107f8c
80104af5:	e8 16 c0 ff ff       	call   80100b10 <panic>
80104afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b00 <yield>:
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	53                   	push   %ebx
80104b04:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104b07:	68 20 2d 11 80       	push   $0x80112d20
80104b0c:	e8 bf 05 00 00       	call   801050d0 <acquire>
  pushcli();
80104b11:	e8 6a 04 00 00       	call   80104f80 <pushcli>
  c = mycpu();
80104b16:	e8 f5 f8 ff ff       	call   80104410 <mycpu>
  p = c->proc;
80104b1b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104b21:	e8 aa 04 00 00       	call   80104fd0 <popcli>
  myproc()->state = RUNNABLE;
80104b26:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104b2d:	e8 ae fc ff ff       	call   801047e0 <sched>
  release(&ptable.lock);
80104b32:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104b39:	e8 32 05 00 00       	call   80105070 <release>
}
80104b3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b41:	83 c4 10             	add    $0x10,%esp
80104b44:	c9                   	leave
80104b45:	c3                   	ret
80104b46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b4d:	00 
80104b4e:	66 90                	xchg   %ax,%ax

80104b50 <sleep>:
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	57                   	push   %edi
80104b54:	56                   	push   %esi
80104b55:	53                   	push   %ebx
80104b56:	83 ec 0c             	sub    $0xc,%esp
80104b59:	8b 7d 08             	mov    0x8(%ebp),%edi
80104b5c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104b5f:	e8 1c 04 00 00       	call   80104f80 <pushcli>
  c = mycpu();
80104b64:	e8 a7 f8 ff ff       	call   80104410 <mycpu>
  p = c->proc;
80104b69:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104b6f:	e8 5c 04 00 00       	call   80104fd0 <popcli>
  if(p == 0)
80104b74:	85 db                	test   %ebx,%ebx
80104b76:	0f 84 87 00 00 00    	je     80104c03 <sleep+0xb3>
  if(lk == 0)
80104b7c:	85 f6                	test   %esi,%esi
80104b7e:	74 76                	je     80104bf6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104b80:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80104b86:	74 50                	je     80104bd8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104b88:	83 ec 0c             	sub    $0xc,%esp
80104b8b:	68 20 2d 11 80       	push   $0x80112d20
80104b90:	e8 3b 05 00 00       	call   801050d0 <acquire>
    release(lk);
80104b95:	89 34 24             	mov    %esi,(%esp)
80104b98:	e8 d3 04 00 00       	call   80105070 <release>
  p->chan = chan;
80104b9d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104ba0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104ba7:	e8 34 fc ff ff       	call   801047e0 <sched>
  p->chan = 0;
80104bac:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104bb3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104bba:	e8 b1 04 00 00       	call   80105070 <release>
    acquire(lk);
80104bbf:	83 c4 10             	add    $0x10,%esp
80104bc2:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104bc5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bc8:	5b                   	pop    %ebx
80104bc9:	5e                   	pop    %esi
80104bca:	5f                   	pop    %edi
80104bcb:	5d                   	pop    %ebp
    acquire(lk);
80104bcc:	e9 ff 04 00 00       	jmp    801050d0 <acquire>
80104bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104bd8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104bdb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104be2:	e8 f9 fb ff ff       	call   801047e0 <sched>
  p->chan = 0;
80104be7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104bee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bf1:	5b                   	pop    %ebx
80104bf2:	5e                   	pop    %esi
80104bf3:	5f                   	pop    %edi
80104bf4:	5d                   	pop    %ebp
80104bf5:	c3                   	ret
    panic("sleep without lk");
80104bf6:	83 ec 0c             	sub    $0xc,%esp
80104bf9:	68 92 7f 10 80       	push   $0x80107f92
80104bfe:	e8 0d bf ff ff       	call   80100b10 <panic>
    panic("sleep");
80104c03:	83 ec 0c             	sub    $0xc,%esp
80104c06:	68 8c 7f 10 80       	push   $0x80107f8c
80104c0b:	e8 00 bf ff ff       	call   80100b10 <panic>

80104c10 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	53                   	push   %ebx
80104c14:	83 ec 10             	sub    $0x10,%esp
80104c17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104c1a:	68 20 2d 11 80       	push   $0x80112d20
80104c1f:	e8 ac 04 00 00       	call   801050d0 <acquire>
80104c24:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c27:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104c2c:	eb 0c                	jmp    80104c3a <wakeup+0x2a>
80104c2e:	66 90                	xchg   %ax,%ax
80104c30:	83 c0 7c             	add    $0x7c,%eax
80104c33:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104c38:	74 1c                	je     80104c56 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80104c3a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104c3e:	75 f0                	jne    80104c30 <wakeup+0x20>
80104c40:	3b 58 20             	cmp    0x20(%eax),%ebx
80104c43:	75 eb                	jne    80104c30 <wakeup+0x20>
      p->state = RUNNABLE;
80104c45:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c4c:	83 c0 7c             	add    $0x7c,%eax
80104c4f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104c54:	75 e4                	jne    80104c3a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104c56:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80104c5d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c60:	c9                   	leave
  release(&ptable.lock);
80104c61:	e9 0a 04 00 00       	jmp    80105070 <release>
80104c66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c6d:	00 
80104c6e:	66 90                	xchg   %ax,%ax

80104c70 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	53                   	push   %ebx
80104c74:	83 ec 10             	sub    $0x10,%esp
80104c77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104c7a:	68 20 2d 11 80       	push   $0x80112d20
80104c7f:	e8 4c 04 00 00       	call   801050d0 <acquire>
80104c84:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c87:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104c8c:	eb 0c                	jmp    80104c9a <kill+0x2a>
80104c8e:	66 90                	xchg   %ax,%ax
80104c90:	83 c0 7c             	add    $0x7c,%eax
80104c93:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104c98:	74 36                	je     80104cd0 <kill+0x60>
    if(p->pid == pid){
80104c9a:	39 58 10             	cmp    %ebx,0x10(%eax)
80104c9d:	75 f1                	jne    80104c90 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104c9f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104ca3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104caa:	75 07                	jne    80104cb3 <kill+0x43>
        p->state = RUNNABLE;
80104cac:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104cb3:	83 ec 0c             	sub    $0xc,%esp
80104cb6:	68 20 2d 11 80       	push   $0x80112d20
80104cbb:	e8 b0 03 00 00       	call   80105070 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104cc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104cc3:	83 c4 10             	add    $0x10,%esp
80104cc6:	31 c0                	xor    %eax,%eax
}
80104cc8:	c9                   	leave
80104cc9:	c3                   	ret
80104cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104cd0:	83 ec 0c             	sub    $0xc,%esp
80104cd3:	68 20 2d 11 80       	push   $0x80112d20
80104cd8:	e8 93 03 00 00       	call   80105070 <release>
}
80104cdd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104ce0:	83 c4 10             	add    $0x10,%esp
80104ce3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ce8:	c9                   	leave
80104ce9:	c3                   	ret
80104cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104cf0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	57                   	push   %edi
80104cf4:	56                   	push   %esi
80104cf5:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104cf8:	53                   	push   %ebx
80104cf9:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
80104cfe:	83 ec 3c             	sub    $0x3c,%esp
80104d01:	eb 24                	jmp    80104d27 <procdump+0x37>
80104d03:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104d08:	83 ec 0c             	sub    $0xc,%esp
80104d0b:	68 51 81 10 80       	push   $0x80108151
80104d10:	e8 ab bb ff ff       	call   801008c0 <cprintf>
80104d15:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d18:	83 c3 7c             	add    $0x7c,%ebx
80104d1b:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
80104d21:	0f 84 81 00 00 00    	je     80104da8 <procdump+0xb8>
    if(p->state == UNUSED)
80104d27:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104d2a:	85 c0                	test   %eax,%eax
80104d2c:	74 ea                	je     80104d18 <procdump+0x28>
      state = "???";
80104d2e:	ba a3 7f 10 80       	mov    $0x80107fa3,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d33:	83 f8 05             	cmp    $0x5,%eax
80104d36:	77 11                	ja     80104d49 <procdump+0x59>
80104d38:	8b 14 85 e0 85 10 80 	mov    -0x7fef7a20(,%eax,4),%edx
      state = "???";
80104d3f:	b8 a3 7f 10 80       	mov    $0x80107fa3,%eax
80104d44:	85 d2                	test   %edx,%edx
80104d46:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104d49:	53                   	push   %ebx
80104d4a:	52                   	push   %edx
80104d4b:	ff 73 a4             	push   -0x5c(%ebx)
80104d4e:	68 a7 7f 10 80       	push   $0x80107fa7
80104d53:	e8 68 bb ff ff       	call   801008c0 <cprintf>
    if(p->state == SLEEPING){
80104d58:	83 c4 10             	add    $0x10,%esp
80104d5b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104d5f:	75 a7                	jne    80104d08 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104d61:	83 ec 08             	sub    $0x8,%esp
80104d64:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104d67:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104d6a:	50                   	push   %eax
80104d6b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104d6e:	8b 40 0c             	mov    0xc(%eax),%eax
80104d71:	83 c0 08             	add    $0x8,%eax
80104d74:	50                   	push   %eax
80104d75:	e8 86 01 00 00       	call   80104f00 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104d7a:	83 c4 10             	add    $0x10,%esp
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi
80104d80:	8b 17                	mov    (%edi),%edx
80104d82:	85 d2                	test   %edx,%edx
80104d84:	74 82                	je     80104d08 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104d86:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104d89:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
80104d8c:	52                   	push   %edx
80104d8d:	68 04 7d 10 80       	push   $0x80107d04
80104d92:	e8 29 bb ff ff       	call   801008c0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104d97:	83 c4 10             	add    $0x10,%esp
80104d9a:	39 f7                	cmp    %esi,%edi
80104d9c:	75 e2                	jne    80104d80 <procdump+0x90>
80104d9e:	e9 65 ff ff ff       	jmp    80104d08 <procdump+0x18>
80104da3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104da8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104dab:	5b                   	pop    %ebx
80104dac:	5e                   	pop    %esi
80104dad:	5f                   	pop    %edi
80104dae:	5d                   	pop    %ebp
80104daf:	c3                   	ret

80104db0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	53                   	push   %ebx
80104db4:	83 ec 0c             	sub    $0xc,%esp
80104db7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104dba:	68 da 7f 10 80       	push   $0x80107fda
80104dbf:	8d 43 04             	lea    0x4(%ebx),%eax
80104dc2:	50                   	push   %eax
80104dc3:	e8 18 01 00 00       	call   80104ee0 <initlock>
  lk->name = name;
80104dc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104dcb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104dd1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104dd4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104ddb:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104dde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104de1:	c9                   	leave
80104de2:	c3                   	ret
80104de3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104dea:	00 
80104deb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104df0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	56                   	push   %esi
80104df4:	53                   	push   %ebx
80104df5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104df8:	8d 73 04             	lea    0x4(%ebx),%esi
80104dfb:	83 ec 0c             	sub    $0xc,%esp
80104dfe:	56                   	push   %esi
80104dff:	e8 cc 02 00 00       	call   801050d0 <acquire>
  while (lk->locked) {
80104e04:	8b 13                	mov    (%ebx),%edx
80104e06:	83 c4 10             	add    $0x10,%esp
80104e09:	85 d2                	test   %edx,%edx
80104e0b:	74 16                	je     80104e23 <acquiresleep+0x33>
80104e0d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104e10:	83 ec 08             	sub    $0x8,%esp
80104e13:	56                   	push   %esi
80104e14:	53                   	push   %ebx
80104e15:	e8 36 fd ff ff       	call   80104b50 <sleep>
  while (lk->locked) {
80104e1a:	8b 03                	mov    (%ebx),%eax
80104e1c:	83 c4 10             	add    $0x10,%esp
80104e1f:	85 c0                	test   %eax,%eax
80104e21:	75 ed                	jne    80104e10 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104e23:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104e29:	e8 62 f6 ff ff       	call   80104490 <myproc>
80104e2e:	8b 40 10             	mov    0x10(%eax),%eax
80104e31:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104e34:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104e37:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e3a:	5b                   	pop    %ebx
80104e3b:	5e                   	pop    %esi
80104e3c:	5d                   	pop    %ebp
  release(&lk->lk);
80104e3d:	e9 2e 02 00 00       	jmp    80105070 <release>
80104e42:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e49:	00 
80104e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e50 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	56                   	push   %esi
80104e54:	53                   	push   %ebx
80104e55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e58:	8d 73 04             	lea    0x4(%ebx),%esi
80104e5b:	83 ec 0c             	sub    $0xc,%esp
80104e5e:	56                   	push   %esi
80104e5f:	e8 6c 02 00 00       	call   801050d0 <acquire>
  lk->locked = 0;
80104e64:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104e6a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104e71:	89 1c 24             	mov    %ebx,(%esp)
80104e74:	e8 97 fd ff ff       	call   80104c10 <wakeup>
  release(&lk->lk);
80104e79:	83 c4 10             	add    $0x10,%esp
80104e7c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104e7f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e82:	5b                   	pop    %ebx
80104e83:	5e                   	pop    %esi
80104e84:	5d                   	pop    %ebp
  release(&lk->lk);
80104e85:	e9 e6 01 00 00       	jmp    80105070 <release>
80104e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e90 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	57                   	push   %edi
80104e94:	31 ff                	xor    %edi,%edi
80104e96:	56                   	push   %esi
80104e97:	53                   	push   %ebx
80104e98:	83 ec 18             	sub    $0x18,%esp
80104e9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104e9e:	8d 73 04             	lea    0x4(%ebx),%esi
80104ea1:	56                   	push   %esi
80104ea2:	e8 29 02 00 00       	call   801050d0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104ea7:	8b 03                	mov    (%ebx),%eax
80104ea9:	83 c4 10             	add    $0x10,%esp
80104eac:	85 c0                	test   %eax,%eax
80104eae:	75 18                	jne    80104ec8 <holdingsleep+0x38>
  release(&lk->lk);
80104eb0:	83 ec 0c             	sub    $0xc,%esp
80104eb3:	56                   	push   %esi
80104eb4:	e8 b7 01 00 00       	call   80105070 <release>
  return r;
}
80104eb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ebc:	89 f8                	mov    %edi,%eax
80104ebe:	5b                   	pop    %ebx
80104ebf:	5e                   	pop    %esi
80104ec0:	5f                   	pop    %edi
80104ec1:	5d                   	pop    %ebp
80104ec2:	c3                   	ret
80104ec3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104ec8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104ecb:	e8 c0 f5 ff ff       	call   80104490 <myproc>
80104ed0:	39 58 10             	cmp    %ebx,0x10(%eax)
80104ed3:	0f 94 c0             	sete   %al
80104ed6:	0f b6 c0             	movzbl %al,%eax
80104ed9:	89 c7                	mov    %eax,%edi
80104edb:	eb d3                	jmp    80104eb0 <holdingsleep+0x20>
80104edd:	66 90                	xchg   %ax,%ax
80104edf:	90                   	nop

80104ee0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104ee6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104ee9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104eef:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104ef2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104ef9:	5d                   	pop    %ebp
80104efa:	c3                   	ret
80104efb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104f00 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	53                   	push   %ebx
80104f04:	8b 45 08             	mov    0x8(%ebp),%eax
80104f07:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104f0a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f0d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104f12:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104f17:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f1c:	76 10                	jbe    80104f2e <getcallerpcs+0x2e>
80104f1e:	eb 28                	jmp    80104f48 <getcallerpcs+0x48>
80104f20:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104f26:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104f2c:	77 1a                	ja     80104f48 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f2e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104f31:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104f34:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104f37:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104f39:	83 f8 0a             	cmp    $0xa,%eax
80104f3c:	75 e2                	jne    80104f20 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104f3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f41:	c9                   	leave
80104f42:	c3                   	ret
80104f43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f48:	8d 04 81             	lea    (%ecx,%eax,4),%eax
80104f4b:	83 c1 28             	add    $0x28,%ecx
80104f4e:	89 ca                	mov    %ecx,%edx
80104f50:	29 c2                	sub    %eax,%edx
80104f52:	83 e2 04             	and    $0x4,%edx
80104f55:	74 11                	je     80104f68 <getcallerpcs+0x68>
    pcs[i] = 0;
80104f57:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104f5d:	83 c0 04             	add    $0x4,%eax
80104f60:	39 c1                	cmp    %eax,%ecx
80104f62:	74 da                	je     80104f3e <getcallerpcs+0x3e>
80104f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104f68:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104f6e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104f71:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104f78:	39 c1                	cmp    %eax,%ecx
80104f7a:	75 ec                	jne    80104f68 <getcallerpcs+0x68>
80104f7c:	eb c0                	jmp    80104f3e <getcallerpcs+0x3e>
80104f7e:	66 90                	xchg   %ax,%ax

80104f80 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	53                   	push   %ebx
80104f84:	83 ec 04             	sub    $0x4,%esp
80104f87:	9c                   	pushf
80104f88:	5b                   	pop    %ebx
  asm volatile("cli");
80104f89:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104f8a:	e8 81 f4 ff ff       	call   80104410 <mycpu>
80104f8f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104f95:	85 c0                	test   %eax,%eax
80104f97:	74 17                	je     80104fb0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104f99:	e8 72 f4 ff ff       	call   80104410 <mycpu>
80104f9e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104fa5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fa8:	c9                   	leave
80104fa9:	c3                   	ret
80104faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104fb0:	e8 5b f4 ff ff       	call   80104410 <mycpu>
80104fb5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104fbb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104fc1:	eb d6                	jmp    80104f99 <pushcli+0x19>
80104fc3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fca:	00 
80104fcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104fd0 <popcli>:

void
popcli(void)
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104fd6:	9c                   	pushf
80104fd7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104fd8:	f6 c4 02             	test   $0x2,%ah
80104fdb:	75 35                	jne    80105012 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104fdd:	e8 2e f4 ff ff       	call   80104410 <mycpu>
80104fe2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104fe9:	78 34                	js     8010501f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104feb:	e8 20 f4 ff ff       	call   80104410 <mycpu>
80104ff0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104ff6:	85 d2                	test   %edx,%edx
80104ff8:	74 06                	je     80105000 <popcli+0x30>
    sti();
}
80104ffa:	c9                   	leave
80104ffb:	c3                   	ret
80104ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105000:	e8 0b f4 ff ff       	call   80104410 <mycpu>
80105005:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010500b:	85 c0                	test   %eax,%eax
8010500d:	74 eb                	je     80104ffa <popcli+0x2a>
  asm volatile("sti");
8010500f:	fb                   	sti
}
80105010:	c9                   	leave
80105011:	c3                   	ret
    panic("popcli - interruptible");
80105012:	83 ec 0c             	sub    $0xc,%esp
80105015:	68 e5 7f 10 80       	push   $0x80107fe5
8010501a:	e8 f1 ba ff ff       	call   80100b10 <panic>
    panic("popcli");
8010501f:	83 ec 0c             	sub    $0xc,%esp
80105022:	68 fc 7f 10 80       	push   $0x80107ffc
80105027:	e8 e4 ba ff ff       	call   80100b10 <panic>
8010502c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105030 <holding>:
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	56                   	push   %esi
80105034:	53                   	push   %ebx
80105035:	8b 75 08             	mov    0x8(%ebp),%esi
80105038:	31 db                	xor    %ebx,%ebx
  pushcli();
8010503a:	e8 41 ff ff ff       	call   80104f80 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010503f:	8b 06                	mov    (%esi),%eax
80105041:	85 c0                	test   %eax,%eax
80105043:	75 0b                	jne    80105050 <holding+0x20>
  popcli();
80105045:	e8 86 ff ff ff       	call   80104fd0 <popcli>
}
8010504a:	89 d8                	mov    %ebx,%eax
8010504c:	5b                   	pop    %ebx
8010504d:	5e                   	pop    %esi
8010504e:	5d                   	pop    %ebp
8010504f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80105050:	8b 5e 08             	mov    0x8(%esi),%ebx
80105053:	e8 b8 f3 ff ff       	call   80104410 <mycpu>
80105058:	39 c3                	cmp    %eax,%ebx
8010505a:	0f 94 c3             	sete   %bl
  popcli();
8010505d:	e8 6e ff ff ff       	call   80104fd0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105062:	0f b6 db             	movzbl %bl,%ebx
}
80105065:	89 d8                	mov    %ebx,%eax
80105067:	5b                   	pop    %ebx
80105068:	5e                   	pop    %esi
80105069:	5d                   	pop    %ebp
8010506a:	c3                   	ret
8010506b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105070 <release>:
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	56                   	push   %esi
80105074:	53                   	push   %ebx
80105075:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105078:	e8 03 ff ff ff       	call   80104f80 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010507d:	8b 03                	mov    (%ebx),%eax
8010507f:	85 c0                	test   %eax,%eax
80105081:	75 15                	jne    80105098 <release+0x28>
  popcli();
80105083:	e8 48 ff ff ff       	call   80104fd0 <popcli>
    panic("release");
80105088:	83 ec 0c             	sub    $0xc,%esp
8010508b:	68 03 80 10 80       	push   $0x80108003
80105090:	e8 7b ba ff ff       	call   80100b10 <panic>
80105095:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105098:	8b 73 08             	mov    0x8(%ebx),%esi
8010509b:	e8 70 f3 ff ff       	call   80104410 <mycpu>
801050a0:	39 c6                	cmp    %eax,%esi
801050a2:	75 df                	jne    80105083 <release+0x13>
  popcli();
801050a4:	e8 27 ff ff ff       	call   80104fd0 <popcli>
  lk->pcs[0] = 0;
801050a9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801050b0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801050b7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801050bc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801050c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050c5:	5b                   	pop    %ebx
801050c6:	5e                   	pop    %esi
801050c7:	5d                   	pop    %ebp
  popcli();
801050c8:	e9 03 ff ff ff       	jmp    80104fd0 <popcli>
801050cd:	8d 76 00             	lea    0x0(%esi),%esi

801050d0 <acquire>:
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	53                   	push   %ebx
801050d4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801050d7:	e8 a4 fe ff ff       	call   80104f80 <pushcli>
  if(holding(lk))
801050dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801050df:	e8 9c fe ff ff       	call   80104f80 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801050e4:	8b 03                	mov    (%ebx),%eax
801050e6:	85 c0                	test   %eax,%eax
801050e8:	0f 85 b2 00 00 00    	jne    801051a0 <acquire+0xd0>
  popcli();
801050ee:	e8 dd fe ff ff       	call   80104fd0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801050f3:	b9 01 00 00 00       	mov    $0x1,%ecx
801050f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801050ff:	00 
  while(xchg(&lk->locked, 1) != 0)
80105100:	8b 55 08             	mov    0x8(%ebp),%edx
80105103:	89 c8                	mov    %ecx,%eax
80105105:	f0 87 02             	lock xchg %eax,(%edx)
80105108:	85 c0                	test   %eax,%eax
8010510a:	75 f4                	jne    80105100 <acquire+0x30>
  __sync_synchronize();
8010510c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105111:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105114:	e8 f7 f2 ff ff       	call   80104410 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105119:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
8010511c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
8010511e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105121:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80105127:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010512c:	77 32                	ja     80105160 <acquire+0x90>
  ebp = (uint*)v - 2;
8010512e:	89 e8                	mov    %ebp,%eax
80105130:	eb 14                	jmp    80105146 <acquire+0x76>
80105132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105138:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010513e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105144:	77 1a                	ja     80105160 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80105146:	8b 58 04             	mov    0x4(%eax),%ebx
80105149:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010514d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105150:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105152:	83 fa 0a             	cmp    $0xa,%edx
80105155:	75 e1                	jne    80105138 <acquire+0x68>
}
80105157:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010515a:	c9                   	leave
8010515b:	c3                   	ret
8010515c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105160:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80105164:	83 c1 34             	add    $0x34,%ecx
80105167:	89 ca                	mov    %ecx,%edx
80105169:	29 c2                	sub    %eax,%edx
8010516b:	83 e2 04             	and    $0x4,%edx
8010516e:	74 10                	je     80105180 <acquire+0xb0>
    pcs[i] = 0;
80105170:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105176:	83 c0 04             	add    $0x4,%eax
80105179:	39 c1                	cmp    %eax,%ecx
8010517b:	74 da                	je     80105157 <acquire+0x87>
8010517d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80105180:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105186:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105189:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105190:	39 c1                	cmp    %eax,%ecx
80105192:	75 ec                	jne    80105180 <acquire+0xb0>
80105194:	eb c1                	jmp    80105157 <acquire+0x87>
80105196:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010519d:	00 
8010519e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
801051a0:	8b 5b 08             	mov    0x8(%ebx),%ebx
801051a3:	e8 68 f2 ff ff       	call   80104410 <mycpu>
801051a8:	39 c3                	cmp    %eax,%ebx
801051aa:	0f 85 3e ff ff ff    	jne    801050ee <acquire+0x1e>
  popcli();
801051b0:	e8 1b fe ff ff       	call   80104fd0 <popcli>
    panic("acquire");
801051b5:	83 ec 0c             	sub    $0xc,%esp
801051b8:	68 0b 80 10 80       	push   $0x8010800b
801051bd:	e8 4e b9 ff ff       	call   80100b10 <panic>
801051c2:	66 90                	xchg   %ax,%ax
801051c4:	66 90                	xchg   %ax,%ax
801051c6:	66 90                	xchg   %ax,%ax
801051c8:	66 90                	xchg   %ax,%ax
801051ca:	66 90                	xchg   %ax,%ax
801051cc:	66 90                	xchg   %ax,%ax
801051ce:	66 90                	xchg   %ax,%ax

801051d0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	8b 55 08             	mov    0x8(%ebp),%edx
801051d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801051da:	89 d0                	mov    %edx,%eax
801051dc:	09 c8                	or     %ecx,%eax
801051de:	a8 03                	test   $0x3,%al
801051e0:	75 1e                	jne    80105200 <memset+0x30>
    c &= 0xFF;
801051e2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801051e6:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
801051e9:	89 d7                	mov    %edx,%edi
801051eb:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
801051f1:	fc                   	cld
801051f2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801051f4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801051f7:	89 d0                	mov    %edx,%eax
801051f9:	c9                   	leave
801051fa:	c3                   	ret
801051fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80105200:	8b 45 0c             	mov    0xc(%ebp),%eax
80105203:	89 d7                	mov    %edx,%edi
80105205:	fc                   	cld
80105206:	f3 aa                	rep stos %al,%es:(%edi)
80105208:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010520b:	89 d0                	mov    %edx,%eax
8010520d:	c9                   	leave
8010520e:	c3                   	ret
8010520f:	90                   	nop

80105210 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	56                   	push   %esi
80105214:	8b 75 10             	mov    0x10(%ebp),%esi
80105217:	8b 45 08             	mov    0x8(%ebp),%eax
8010521a:	53                   	push   %ebx
8010521b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010521e:	85 f6                	test   %esi,%esi
80105220:	74 2e                	je     80105250 <memcmp+0x40>
80105222:	01 c6                	add    %eax,%esi
80105224:	eb 14                	jmp    8010523a <memcmp+0x2a>
80105226:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010522d:	00 
8010522e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105230:	83 c0 01             	add    $0x1,%eax
80105233:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105236:	39 f0                	cmp    %esi,%eax
80105238:	74 16                	je     80105250 <memcmp+0x40>
    if(*s1 != *s2)
8010523a:	0f b6 08             	movzbl (%eax),%ecx
8010523d:	0f b6 1a             	movzbl (%edx),%ebx
80105240:	38 d9                	cmp    %bl,%cl
80105242:	74 ec                	je     80105230 <memcmp+0x20>
      return *s1 - *s2;
80105244:	0f b6 c1             	movzbl %cl,%eax
80105247:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105249:	5b                   	pop    %ebx
8010524a:	5e                   	pop    %esi
8010524b:	5d                   	pop    %ebp
8010524c:	c3                   	ret
8010524d:	8d 76 00             	lea    0x0(%esi),%esi
80105250:	5b                   	pop    %ebx
  return 0;
80105251:	31 c0                	xor    %eax,%eax
}
80105253:	5e                   	pop    %esi
80105254:	5d                   	pop    %ebp
80105255:	c3                   	ret
80105256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010525d:	00 
8010525e:	66 90                	xchg   %ax,%ax

80105260 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	57                   	push   %edi
80105264:	8b 55 08             	mov    0x8(%ebp),%edx
80105267:	8b 45 10             	mov    0x10(%ebp),%eax
8010526a:	56                   	push   %esi
8010526b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010526e:	39 d6                	cmp    %edx,%esi
80105270:	73 26                	jae    80105298 <memmove+0x38>
80105272:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80105275:	39 ca                	cmp    %ecx,%edx
80105277:	73 1f                	jae    80105298 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105279:	85 c0                	test   %eax,%eax
8010527b:	74 0f                	je     8010528c <memmove+0x2c>
8010527d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80105280:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105284:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105287:	83 e8 01             	sub    $0x1,%eax
8010528a:	73 f4                	jae    80105280 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010528c:	5e                   	pop    %esi
8010528d:	89 d0                	mov    %edx,%eax
8010528f:	5f                   	pop    %edi
80105290:	5d                   	pop    %ebp
80105291:	c3                   	ret
80105292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80105298:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010529b:	89 d7                	mov    %edx,%edi
8010529d:	85 c0                	test   %eax,%eax
8010529f:	74 eb                	je     8010528c <memmove+0x2c>
801052a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801052a8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801052a9:	39 ce                	cmp    %ecx,%esi
801052ab:	75 fb                	jne    801052a8 <memmove+0x48>
}
801052ad:	5e                   	pop    %esi
801052ae:	89 d0                	mov    %edx,%eax
801052b0:	5f                   	pop    %edi
801052b1:	5d                   	pop    %ebp
801052b2:	c3                   	ret
801052b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052ba:	00 
801052bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801052c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801052c0:	eb 9e                	jmp    80105260 <memmove>
801052c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052c9:	00 
801052ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052d0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	53                   	push   %ebx
801052d4:	8b 55 10             	mov    0x10(%ebp),%edx
801052d7:	8b 45 08             	mov    0x8(%ebp),%eax
801052da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
801052dd:	85 d2                	test   %edx,%edx
801052df:	75 16                	jne    801052f7 <strncmp+0x27>
801052e1:	eb 2d                	jmp    80105310 <strncmp+0x40>
801052e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801052e8:	3a 19                	cmp    (%ecx),%bl
801052ea:	75 12                	jne    801052fe <strncmp+0x2e>
    n--, p++, q++;
801052ec:	83 c0 01             	add    $0x1,%eax
801052ef:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801052f2:	83 ea 01             	sub    $0x1,%edx
801052f5:	74 19                	je     80105310 <strncmp+0x40>
801052f7:	0f b6 18             	movzbl (%eax),%ebx
801052fa:	84 db                	test   %bl,%bl
801052fc:	75 ea                	jne    801052e8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801052fe:	0f b6 00             	movzbl (%eax),%eax
80105301:	0f b6 11             	movzbl (%ecx),%edx
}
80105304:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105307:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80105308:	29 d0                	sub    %edx,%eax
}
8010530a:	c3                   	ret
8010530b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105310:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80105313:	31 c0                	xor    %eax,%eax
}
80105315:	c9                   	leave
80105316:	c3                   	ret
80105317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010531e:	00 
8010531f:	90                   	nop

80105320 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	57                   	push   %edi
80105324:	56                   	push   %esi
80105325:	8b 75 08             	mov    0x8(%ebp),%esi
80105328:	53                   	push   %ebx
80105329:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010532c:	89 f0                	mov    %esi,%eax
8010532e:	eb 15                	jmp    80105345 <strncpy+0x25>
80105330:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105334:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105337:	83 c0 01             	add    $0x1,%eax
8010533a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
8010533e:	88 48 ff             	mov    %cl,-0x1(%eax)
80105341:	84 c9                	test   %cl,%cl
80105343:	74 13                	je     80105358 <strncpy+0x38>
80105345:	89 d3                	mov    %edx,%ebx
80105347:	83 ea 01             	sub    $0x1,%edx
8010534a:	85 db                	test   %ebx,%ebx
8010534c:	7f e2                	jg     80105330 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
8010534e:	5b                   	pop    %ebx
8010534f:	89 f0                	mov    %esi,%eax
80105351:	5e                   	pop    %esi
80105352:	5f                   	pop    %edi
80105353:	5d                   	pop    %ebp
80105354:	c3                   	ret
80105355:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80105358:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
8010535b:	83 e9 01             	sub    $0x1,%ecx
8010535e:	85 d2                	test   %edx,%edx
80105360:	74 ec                	je     8010534e <strncpy+0x2e>
80105362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80105368:	83 c0 01             	add    $0x1,%eax
8010536b:	89 ca                	mov    %ecx,%edx
8010536d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80105371:	29 c2                	sub    %eax,%edx
80105373:	85 d2                	test   %edx,%edx
80105375:	7f f1                	jg     80105368 <strncpy+0x48>
}
80105377:	5b                   	pop    %ebx
80105378:	89 f0                	mov    %esi,%eax
8010537a:	5e                   	pop    %esi
8010537b:	5f                   	pop    %edi
8010537c:	5d                   	pop    %ebp
8010537d:	c3                   	ret
8010537e:	66 90                	xchg   %ax,%ax

80105380 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	56                   	push   %esi
80105384:	8b 55 10             	mov    0x10(%ebp),%edx
80105387:	8b 75 08             	mov    0x8(%ebp),%esi
8010538a:	53                   	push   %ebx
8010538b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010538e:	85 d2                	test   %edx,%edx
80105390:	7e 25                	jle    801053b7 <safestrcpy+0x37>
80105392:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105396:	89 f2                	mov    %esi,%edx
80105398:	eb 16                	jmp    801053b0 <safestrcpy+0x30>
8010539a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801053a0:	0f b6 08             	movzbl (%eax),%ecx
801053a3:	83 c0 01             	add    $0x1,%eax
801053a6:	83 c2 01             	add    $0x1,%edx
801053a9:	88 4a ff             	mov    %cl,-0x1(%edx)
801053ac:	84 c9                	test   %cl,%cl
801053ae:	74 04                	je     801053b4 <safestrcpy+0x34>
801053b0:	39 d8                	cmp    %ebx,%eax
801053b2:	75 ec                	jne    801053a0 <safestrcpy+0x20>
    ;
  *s = 0;
801053b4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801053b7:	89 f0                	mov    %esi,%eax
801053b9:	5b                   	pop    %ebx
801053ba:	5e                   	pop    %esi
801053bb:	5d                   	pop    %ebp
801053bc:	c3                   	ret
801053bd:	8d 76 00             	lea    0x0(%esi),%esi

801053c0 <strlen>:

int
strlen(const char *s)
{
801053c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801053c1:	31 c0                	xor    %eax,%eax
{
801053c3:	89 e5                	mov    %esp,%ebp
801053c5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801053c8:	80 3a 00             	cmpb   $0x0,(%edx)
801053cb:	74 0c                	je     801053d9 <strlen+0x19>
801053cd:	8d 76 00             	lea    0x0(%esi),%esi
801053d0:	83 c0 01             	add    $0x1,%eax
801053d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801053d7:	75 f7                	jne    801053d0 <strlen+0x10>
    ;
  return n;
}
801053d9:	5d                   	pop    %ebp
801053da:	c3                   	ret

801053db <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801053db:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801053df:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801053e3:	55                   	push   %ebp
  pushl %ebx
801053e4:	53                   	push   %ebx
  pushl %esi
801053e5:	56                   	push   %esi
  pushl %edi
801053e6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801053e7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801053e9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801053eb:	5f                   	pop    %edi
  popl %esi
801053ec:	5e                   	pop    %esi
  popl %ebx
801053ed:	5b                   	pop    %ebx
  popl %ebp
801053ee:	5d                   	pop    %ebp
  ret
801053ef:	c3                   	ret

801053f0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	53                   	push   %ebx
801053f4:	83 ec 04             	sub    $0x4,%esp
801053f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801053fa:	e8 91 f0 ff ff       	call   80104490 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801053ff:	8b 00                	mov    (%eax),%eax
80105401:	39 c3                	cmp    %eax,%ebx
80105403:	73 1b                	jae    80105420 <fetchint+0x30>
80105405:	8d 53 04             	lea    0x4(%ebx),%edx
80105408:	39 d0                	cmp    %edx,%eax
8010540a:	72 14                	jb     80105420 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010540c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010540f:	8b 13                	mov    (%ebx),%edx
80105411:	89 10                	mov    %edx,(%eax)
  return 0;
80105413:	31 c0                	xor    %eax,%eax
}
80105415:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105418:	c9                   	leave
80105419:	c3                   	ret
8010541a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105425:	eb ee                	jmp    80105415 <fetchint+0x25>
80105427:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010542e:	00 
8010542f:	90                   	nop

80105430 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	53                   	push   %ebx
80105434:	83 ec 04             	sub    $0x4,%esp
80105437:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010543a:	e8 51 f0 ff ff       	call   80104490 <myproc>

  if(addr >= curproc->sz)
8010543f:	3b 18                	cmp    (%eax),%ebx
80105441:	73 2d                	jae    80105470 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80105443:	8b 55 0c             	mov    0xc(%ebp),%edx
80105446:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105448:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010544a:	39 d3                	cmp    %edx,%ebx
8010544c:	73 22                	jae    80105470 <fetchstr+0x40>
8010544e:	89 d8                	mov    %ebx,%eax
80105450:	eb 0d                	jmp    8010545f <fetchstr+0x2f>
80105452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105458:	83 c0 01             	add    $0x1,%eax
8010545b:	39 d0                	cmp    %edx,%eax
8010545d:	73 11                	jae    80105470 <fetchstr+0x40>
    if(*s == 0)
8010545f:	80 38 00             	cmpb   $0x0,(%eax)
80105462:	75 f4                	jne    80105458 <fetchstr+0x28>
      return s - *pp;
80105464:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105466:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105469:	c9                   	leave
8010546a:	c3                   	ret
8010546b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105470:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105473:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105478:	c9                   	leave
80105479:	c3                   	ret
8010547a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105480 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	56                   	push   %esi
80105484:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105485:	e8 06 f0 ff ff       	call   80104490 <myproc>
8010548a:	8b 55 08             	mov    0x8(%ebp),%edx
8010548d:	8b 40 18             	mov    0x18(%eax),%eax
80105490:	8b 40 44             	mov    0x44(%eax),%eax
80105493:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105496:	e8 f5 ef ff ff       	call   80104490 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010549b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010549e:	8b 00                	mov    (%eax),%eax
801054a0:	39 c6                	cmp    %eax,%esi
801054a2:	73 1c                	jae    801054c0 <argint+0x40>
801054a4:	8d 53 08             	lea    0x8(%ebx),%edx
801054a7:	39 d0                	cmp    %edx,%eax
801054a9:	72 15                	jb     801054c0 <argint+0x40>
  *ip = *(int*)(addr);
801054ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801054ae:	8b 53 04             	mov    0x4(%ebx),%edx
801054b1:	89 10                	mov    %edx,(%eax)
  return 0;
801054b3:	31 c0                	xor    %eax,%eax
}
801054b5:	5b                   	pop    %ebx
801054b6:	5e                   	pop    %esi
801054b7:	5d                   	pop    %ebp
801054b8:	c3                   	ret
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801054c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054c5:	eb ee                	jmp    801054b5 <argint+0x35>
801054c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054ce:	00 
801054cf:	90                   	nop

801054d0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	57                   	push   %edi
801054d4:	56                   	push   %esi
801054d5:	53                   	push   %ebx
801054d6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
801054d9:	e8 b2 ef ff ff       	call   80104490 <myproc>
801054de:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054e0:	e8 ab ef ff ff       	call   80104490 <myproc>
801054e5:	8b 55 08             	mov    0x8(%ebp),%edx
801054e8:	8b 40 18             	mov    0x18(%eax),%eax
801054eb:	8b 40 44             	mov    0x44(%eax),%eax
801054ee:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801054f1:	e8 9a ef ff ff       	call   80104490 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054f6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054f9:	8b 00                	mov    (%eax),%eax
801054fb:	39 c7                	cmp    %eax,%edi
801054fd:	73 31                	jae    80105530 <argptr+0x60>
801054ff:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105502:	39 c8                	cmp    %ecx,%eax
80105504:	72 2a                	jb     80105530 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105506:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105509:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010550c:	85 d2                	test   %edx,%edx
8010550e:	78 20                	js     80105530 <argptr+0x60>
80105510:	8b 16                	mov    (%esi),%edx
80105512:	39 d0                	cmp    %edx,%eax
80105514:	73 1a                	jae    80105530 <argptr+0x60>
80105516:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105519:	01 c3                	add    %eax,%ebx
8010551b:	39 da                	cmp    %ebx,%edx
8010551d:	72 11                	jb     80105530 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010551f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105522:	89 02                	mov    %eax,(%edx)
  return 0;
80105524:	31 c0                	xor    %eax,%eax
}
80105526:	83 c4 0c             	add    $0xc,%esp
80105529:	5b                   	pop    %ebx
8010552a:	5e                   	pop    %esi
8010552b:	5f                   	pop    %edi
8010552c:	5d                   	pop    %ebp
8010552d:	c3                   	ret
8010552e:	66 90                	xchg   %ax,%ax
    return -1;
80105530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105535:	eb ef                	jmp    80105526 <argptr+0x56>
80105537:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010553e:	00 
8010553f:	90                   	nop

80105540 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	56                   	push   %esi
80105544:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105545:	e8 46 ef ff ff       	call   80104490 <myproc>
8010554a:	8b 55 08             	mov    0x8(%ebp),%edx
8010554d:	8b 40 18             	mov    0x18(%eax),%eax
80105550:	8b 40 44             	mov    0x44(%eax),%eax
80105553:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105556:	e8 35 ef ff ff       	call   80104490 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010555b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010555e:	8b 00                	mov    (%eax),%eax
80105560:	39 c6                	cmp    %eax,%esi
80105562:	73 44                	jae    801055a8 <argstr+0x68>
80105564:	8d 53 08             	lea    0x8(%ebx),%edx
80105567:	39 d0                	cmp    %edx,%eax
80105569:	72 3d                	jb     801055a8 <argstr+0x68>
  *ip = *(int*)(addr);
8010556b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010556e:	e8 1d ef ff ff       	call   80104490 <myproc>
  if(addr >= curproc->sz)
80105573:	3b 18                	cmp    (%eax),%ebx
80105575:	73 31                	jae    801055a8 <argstr+0x68>
  *pp = (char*)addr;
80105577:	8b 55 0c             	mov    0xc(%ebp),%edx
8010557a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010557c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010557e:	39 d3                	cmp    %edx,%ebx
80105580:	73 26                	jae    801055a8 <argstr+0x68>
80105582:	89 d8                	mov    %ebx,%eax
80105584:	eb 11                	jmp    80105597 <argstr+0x57>
80105586:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010558d:	00 
8010558e:	66 90                	xchg   %ax,%ax
80105590:	83 c0 01             	add    $0x1,%eax
80105593:	39 d0                	cmp    %edx,%eax
80105595:	73 11                	jae    801055a8 <argstr+0x68>
    if(*s == 0)
80105597:	80 38 00             	cmpb   $0x0,(%eax)
8010559a:	75 f4                	jne    80105590 <argstr+0x50>
      return s - *pp;
8010559c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010559e:	5b                   	pop    %ebx
8010559f:	5e                   	pop    %esi
801055a0:	5d                   	pop    %ebp
801055a1:	c3                   	ret
801055a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055a8:	5b                   	pop    %ebx
    return -1;
801055a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055ae:	5e                   	pop    %esi
801055af:	5d                   	pop    %ebp
801055b0:	c3                   	ret
801055b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055b8:	00 
801055b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801055c0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	53                   	push   %ebx
801055c4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801055c7:	e8 c4 ee ff ff       	call   80104490 <myproc>
801055cc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801055ce:	8b 40 18             	mov    0x18(%eax),%eax
801055d1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801055d4:	8d 50 ff             	lea    -0x1(%eax),%edx
801055d7:	83 fa 14             	cmp    $0x14,%edx
801055da:	77 24                	ja     80105600 <syscall+0x40>
801055dc:	8b 14 85 00 86 10 80 	mov    -0x7fef7a00(,%eax,4),%edx
801055e3:	85 d2                	test   %edx,%edx
801055e5:	74 19                	je     80105600 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801055e7:	ff d2                	call   *%edx
801055e9:	89 c2                	mov    %eax,%edx
801055eb:	8b 43 18             	mov    0x18(%ebx),%eax
801055ee:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801055f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055f4:	c9                   	leave
801055f5:	c3                   	ret
801055f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055fd:	00 
801055fe:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80105600:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105601:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105604:	50                   	push   %eax
80105605:	ff 73 10             	push   0x10(%ebx)
80105608:	68 13 80 10 80       	push   $0x80108013
8010560d:	e8 ae b2 ff ff       	call   801008c0 <cprintf>
    curproc->tf->eax = -1;
80105612:	8b 43 18             	mov    0x18(%ebx),%eax
80105615:	83 c4 10             	add    $0x10,%esp
80105618:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010561f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105622:	c9                   	leave
80105623:	c3                   	ret
80105624:	66 90                	xchg   %ax,%ax
80105626:	66 90                	xchg   %ax,%ax
80105628:	66 90                	xchg   %ax,%ax
8010562a:	66 90                	xchg   %ax,%ax
8010562c:	66 90                	xchg   %ax,%ax
8010562e:	66 90                	xchg   %ax,%ax

80105630 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	57                   	push   %edi
80105634:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105635:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105638:	53                   	push   %ebx
80105639:	83 ec 34             	sub    $0x34,%esp
8010563c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010563f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105642:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105645:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105648:	57                   	push   %edi
80105649:	50                   	push   %eax
8010564a:	e8 81 d5 ff ff       	call   80102bd0 <nameiparent>
8010564f:	83 c4 10             	add    $0x10,%esp
80105652:	85 c0                	test   %eax,%eax
80105654:	74 5e                	je     801056b4 <create+0x84>
    return 0;
  ilock(dp);
80105656:	83 ec 0c             	sub    $0xc,%esp
80105659:	89 c3                	mov    %eax,%ebx
8010565b:	50                   	push   %eax
8010565c:	e8 6f cc ff ff       	call   801022d0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105661:	83 c4 0c             	add    $0xc,%esp
80105664:	6a 00                	push   $0x0
80105666:	57                   	push   %edi
80105667:	53                   	push   %ebx
80105668:	e8 b3 d1 ff ff       	call   80102820 <dirlookup>
8010566d:	83 c4 10             	add    $0x10,%esp
80105670:	89 c6                	mov    %eax,%esi
80105672:	85 c0                	test   %eax,%eax
80105674:	74 4a                	je     801056c0 <create+0x90>
    iunlockput(dp);
80105676:	83 ec 0c             	sub    $0xc,%esp
80105679:	53                   	push   %ebx
8010567a:	e8 e1 ce ff ff       	call   80102560 <iunlockput>
    ilock(ip);
8010567f:	89 34 24             	mov    %esi,(%esp)
80105682:	e8 49 cc ff ff       	call   801022d0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105687:	83 c4 10             	add    $0x10,%esp
8010568a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010568f:	75 17                	jne    801056a8 <create+0x78>
80105691:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105696:	75 10                	jne    801056a8 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105698:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010569b:	89 f0                	mov    %esi,%eax
8010569d:	5b                   	pop    %ebx
8010569e:	5e                   	pop    %esi
8010569f:	5f                   	pop    %edi
801056a0:	5d                   	pop    %ebp
801056a1:	c3                   	ret
801056a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
801056a8:	83 ec 0c             	sub    $0xc,%esp
801056ab:	56                   	push   %esi
801056ac:	e8 af ce ff ff       	call   80102560 <iunlockput>
    return 0;
801056b1:	83 c4 10             	add    $0x10,%esp
}
801056b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801056b7:	31 f6                	xor    %esi,%esi
}
801056b9:	5b                   	pop    %ebx
801056ba:	89 f0                	mov    %esi,%eax
801056bc:	5e                   	pop    %esi
801056bd:	5f                   	pop    %edi
801056be:	5d                   	pop    %ebp
801056bf:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
801056c0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801056c4:	83 ec 08             	sub    $0x8,%esp
801056c7:	50                   	push   %eax
801056c8:	ff 33                	push   (%ebx)
801056ca:	e8 91 ca ff ff       	call   80102160 <ialloc>
801056cf:	83 c4 10             	add    $0x10,%esp
801056d2:	89 c6                	mov    %eax,%esi
801056d4:	85 c0                	test   %eax,%eax
801056d6:	0f 84 bc 00 00 00    	je     80105798 <create+0x168>
  ilock(ip);
801056dc:	83 ec 0c             	sub    $0xc,%esp
801056df:	50                   	push   %eax
801056e0:	e8 eb cb ff ff       	call   801022d0 <ilock>
  ip->major = major;
801056e5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801056e9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801056ed:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801056f1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801056f5:	b8 01 00 00 00       	mov    $0x1,%eax
801056fa:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801056fe:	89 34 24             	mov    %esi,(%esp)
80105701:	e8 1a cb ff ff       	call   80102220 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105706:	83 c4 10             	add    $0x10,%esp
80105709:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010570e:	74 30                	je     80105740 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80105710:	83 ec 04             	sub    $0x4,%esp
80105713:	ff 76 04             	push   0x4(%esi)
80105716:	57                   	push   %edi
80105717:	53                   	push   %ebx
80105718:	e8 d3 d3 ff ff       	call   80102af0 <dirlink>
8010571d:	83 c4 10             	add    $0x10,%esp
80105720:	85 c0                	test   %eax,%eax
80105722:	78 67                	js     8010578b <create+0x15b>
  iunlockput(dp);
80105724:	83 ec 0c             	sub    $0xc,%esp
80105727:	53                   	push   %ebx
80105728:	e8 33 ce ff ff       	call   80102560 <iunlockput>
  return ip;
8010572d:	83 c4 10             	add    $0x10,%esp
}
80105730:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105733:	89 f0                	mov    %esi,%eax
80105735:	5b                   	pop    %ebx
80105736:	5e                   	pop    %esi
80105737:	5f                   	pop    %edi
80105738:	5d                   	pop    %ebp
80105739:	c3                   	ret
8010573a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105740:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105743:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105748:	53                   	push   %ebx
80105749:	e8 d2 ca ff ff       	call   80102220 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010574e:	83 c4 0c             	add    $0xc,%esp
80105751:	ff 76 04             	push   0x4(%esi)
80105754:	68 4b 80 10 80       	push   $0x8010804b
80105759:	56                   	push   %esi
8010575a:	e8 91 d3 ff ff       	call   80102af0 <dirlink>
8010575f:	83 c4 10             	add    $0x10,%esp
80105762:	85 c0                	test   %eax,%eax
80105764:	78 18                	js     8010577e <create+0x14e>
80105766:	83 ec 04             	sub    $0x4,%esp
80105769:	ff 73 04             	push   0x4(%ebx)
8010576c:	68 4a 80 10 80       	push   $0x8010804a
80105771:	56                   	push   %esi
80105772:	e8 79 d3 ff ff       	call   80102af0 <dirlink>
80105777:	83 c4 10             	add    $0x10,%esp
8010577a:	85 c0                	test   %eax,%eax
8010577c:	79 92                	jns    80105710 <create+0xe0>
      panic("create dots");
8010577e:	83 ec 0c             	sub    $0xc,%esp
80105781:	68 3e 80 10 80       	push   $0x8010803e
80105786:	e8 85 b3 ff ff       	call   80100b10 <panic>
    panic("create: dirlink");
8010578b:	83 ec 0c             	sub    $0xc,%esp
8010578e:	68 4d 80 10 80       	push   $0x8010804d
80105793:	e8 78 b3 ff ff       	call   80100b10 <panic>
    panic("create: ialloc");
80105798:	83 ec 0c             	sub    $0xc,%esp
8010579b:	68 2f 80 10 80       	push   $0x8010802f
801057a0:	e8 6b b3 ff ff       	call   80100b10 <panic>
801057a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057ac:	00 
801057ad:	8d 76 00             	lea    0x0(%esi),%esi

801057b0 <sys_dup>:
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	56                   	push   %esi
801057b4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801057b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057b8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801057bb:	50                   	push   %eax
801057bc:	6a 00                	push   $0x0
801057be:	e8 bd fc ff ff       	call   80105480 <argint>
801057c3:	83 c4 10             	add    $0x10,%esp
801057c6:	85 c0                	test   %eax,%eax
801057c8:	78 36                	js     80105800 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801057ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801057ce:	77 30                	ja     80105800 <sys_dup+0x50>
801057d0:	e8 bb ec ff ff       	call   80104490 <myproc>
801057d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057d8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801057dc:	85 f6                	test   %esi,%esi
801057de:	74 20                	je     80105800 <sys_dup+0x50>
  struct proc *curproc = myproc();
801057e0:	e8 ab ec ff ff       	call   80104490 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801057e5:	31 db                	xor    %ebx,%ebx
801057e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057ee:	00 
801057ef:	90                   	nop
    if(curproc->ofile[fd] == 0){
801057f0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801057f4:	85 d2                	test   %edx,%edx
801057f6:	74 18                	je     80105810 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
801057f8:	83 c3 01             	add    $0x1,%ebx
801057fb:	83 fb 10             	cmp    $0x10,%ebx
801057fe:	75 f0                	jne    801057f0 <sys_dup+0x40>
}
80105800:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105803:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105808:	89 d8                	mov    %ebx,%eax
8010580a:	5b                   	pop    %ebx
8010580b:	5e                   	pop    %esi
8010580c:	5d                   	pop    %ebp
8010580d:	c3                   	ret
8010580e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105810:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105813:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105817:	56                   	push   %esi
80105818:	e8 d3 c1 ff ff       	call   801019f0 <filedup>
  return fd;
8010581d:	83 c4 10             	add    $0x10,%esp
}
80105820:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105823:	89 d8                	mov    %ebx,%eax
80105825:	5b                   	pop    %ebx
80105826:	5e                   	pop    %esi
80105827:	5d                   	pop    %ebp
80105828:	c3                   	ret
80105829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105830 <sys_read>:
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	56                   	push   %esi
80105834:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105835:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105838:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010583b:	53                   	push   %ebx
8010583c:	6a 00                	push   $0x0
8010583e:	e8 3d fc ff ff       	call   80105480 <argint>
80105843:	83 c4 10             	add    $0x10,%esp
80105846:	85 c0                	test   %eax,%eax
80105848:	78 5e                	js     801058a8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010584a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010584e:	77 58                	ja     801058a8 <sys_read+0x78>
80105850:	e8 3b ec ff ff       	call   80104490 <myproc>
80105855:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105858:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010585c:	85 f6                	test   %esi,%esi
8010585e:	74 48                	je     801058a8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105860:	83 ec 08             	sub    $0x8,%esp
80105863:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105866:	50                   	push   %eax
80105867:	6a 02                	push   $0x2
80105869:	e8 12 fc ff ff       	call   80105480 <argint>
8010586e:	83 c4 10             	add    $0x10,%esp
80105871:	85 c0                	test   %eax,%eax
80105873:	78 33                	js     801058a8 <sys_read+0x78>
80105875:	83 ec 04             	sub    $0x4,%esp
80105878:	ff 75 f0             	push   -0x10(%ebp)
8010587b:	53                   	push   %ebx
8010587c:	6a 01                	push   $0x1
8010587e:	e8 4d fc ff ff       	call   801054d0 <argptr>
80105883:	83 c4 10             	add    $0x10,%esp
80105886:	85 c0                	test   %eax,%eax
80105888:	78 1e                	js     801058a8 <sys_read+0x78>
  return fileread(f, p, n);
8010588a:	83 ec 04             	sub    $0x4,%esp
8010588d:	ff 75 f0             	push   -0x10(%ebp)
80105890:	ff 75 f4             	push   -0xc(%ebp)
80105893:	56                   	push   %esi
80105894:	e8 d7 c2 ff ff       	call   80101b70 <fileread>
80105899:	83 c4 10             	add    $0x10,%esp
}
8010589c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010589f:	5b                   	pop    %ebx
801058a0:	5e                   	pop    %esi
801058a1:	5d                   	pop    %ebp
801058a2:	c3                   	ret
801058a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
801058a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ad:	eb ed                	jmp    8010589c <sys_read+0x6c>
801058af:	90                   	nop

801058b0 <sys_write>:
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	56                   	push   %esi
801058b4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801058b5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801058b8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801058bb:	53                   	push   %ebx
801058bc:	6a 00                	push   $0x0
801058be:	e8 bd fb ff ff       	call   80105480 <argint>
801058c3:	83 c4 10             	add    $0x10,%esp
801058c6:	85 c0                	test   %eax,%eax
801058c8:	78 5e                	js     80105928 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801058ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801058ce:	77 58                	ja     80105928 <sys_write+0x78>
801058d0:	e8 bb eb ff ff       	call   80104490 <myproc>
801058d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058d8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801058dc:	85 f6                	test   %esi,%esi
801058de:	74 48                	je     80105928 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058e0:	83 ec 08             	sub    $0x8,%esp
801058e3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058e6:	50                   	push   %eax
801058e7:	6a 02                	push   $0x2
801058e9:	e8 92 fb ff ff       	call   80105480 <argint>
801058ee:	83 c4 10             	add    $0x10,%esp
801058f1:	85 c0                	test   %eax,%eax
801058f3:	78 33                	js     80105928 <sys_write+0x78>
801058f5:	83 ec 04             	sub    $0x4,%esp
801058f8:	ff 75 f0             	push   -0x10(%ebp)
801058fb:	53                   	push   %ebx
801058fc:	6a 01                	push   $0x1
801058fe:	e8 cd fb ff ff       	call   801054d0 <argptr>
80105903:	83 c4 10             	add    $0x10,%esp
80105906:	85 c0                	test   %eax,%eax
80105908:	78 1e                	js     80105928 <sys_write+0x78>
  return filewrite(f, p, n);
8010590a:	83 ec 04             	sub    $0x4,%esp
8010590d:	ff 75 f0             	push   -0x10(%ebp)
80105910:	ff 75 f4             	push   -0xc(%ebp)
80105913:	56                   	push   %esi
80105914:	e8 e7 c2 ff ff       	call   80101c00 <filewrite>
80105919:	83 c4 10             	add    $0x10,%esp
}
8010591c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010591f:	5b                   	pop    %ebx
80105920:	5e                   	pop    %esi
80105921:	5d                   	pop    %ebp
80105922:	c3                   	ret
80105923:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105928:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010592d:	eb ed                	jmp    8010591c <sys_write+0x6c>
8010592f:	90                   	nop

80105930 <sys_close>:
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	56                   	push   %esi
80105934:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105935:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105938:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010593b:	50                   	push   %eax
8010593c:	6a 00                	push   $0x0
8010593e:	e8 3d fb ff ff       	call   80105480 <argint>
80105943:	83 c4 10             	add    $0x10,%esp
80105946:	85 c0                	test   %eax,%eax
80105948:	78 3e                	js     80105988 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010594a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010594e:	77 38                	ja     80105988 <sys_close+0x58>
80105950:	e8 3b eb ff ff       	call   80104490 <myproc>
80105955:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105958:	8d 5a 08             	lea    0x8(%edx),%ebx
8010595b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010595f:	85 f6                	test   %esi,%esi
80105961:	74 25                	je     80105988 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105963:	e8 28 eb ff ff       	call   80104490 <myproc>
  fileclose(f);
80105968:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010596b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105972:	00 
  fileclose(f);
80105973:	56                   	push   %esi
80105974:	e8 c7 c0 ff ff       	call   80101a40 <fileclose>
  return 0;
80105979:	83 c4 10             	add    $0x10,%esp
8010597c:	31 c0                	xor    %eax,%eax
}
8010597e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105981:	5b                   	pop    %ebx
80105982:	5e                   	pop    %esi
80105983:	5d                   	pop    %ebp
80105984:	c3                   	ret
80105985:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105988:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010598d:	eb ef                	jmp    8010597e <sys_close+0x4e>
8010598f:	90                   	nop

80105990 <sys_fstat>:
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	56                   	push   %esi
80105994:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105995:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105998:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010599b:	53                   	push   %ebx
8010599c:	6a 00                	push   $0x0
8010599e:	e8 dd fa ff ff       	call   80105480 <argint>
801059a3:	83 c4 10             	add    $0x10,%esp
801059a6:	85 c0                	test   %eax,%eax
801059a8:	78 46                	js     801059f0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801059aa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801059ae:	77 40                	ja     801059f0 <sys_fstat+0x60>
801059b0:	e8 db ea ff ff       	call   80104490 <myproc>
801059b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059b8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801059bc:	85 f6                	test   %esi,%esi
801059be:	74 30                	je     801059f0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801059c0:	83 ec 04             	sub    $0x4,%esp
801059c3:	6a 14                	push   $0x14
801059c5:	53                   	push   %ebx
801059c6:	6a 01                	push   $0x1
801059c8:	e8 03 fb ff ff       	call   801054d0 <argptr>
801059cd:	83 c4 10             	add    $0x10,%esp
801059d0:	85 c0                	test   %eax,%eax
801059d2:	78 1c                	js     801059f0 <sys_fstat+0x60>
  return filestat(f, st);
801059d4:	83 ec 08             	sub    $0x8,%esp
801059d7:	ff 75 f4             	push   -0xc(%ebp)
801059da:	56                   	push   %esi
801059db:	e8 40 c1 ff ff       	call   80101b20 <filestat>
801059e0:	83 c4 10             	add    $0x10,%esp
}
801059e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059e6:	5b                   	pop    %ebx
801059e7:	5e                   	pop    %esi
801059e8:	5d                   	pop    %ebp
801059e9:	c3                   	ret
801059ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801059f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059f5:	eb ec                	jmp    801059e3 <sys_fstat+0x53>
801059f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059fe:	00 
801059ff:	90                   	nop

80105a00 <sys_link>:
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	57                   	push   %edi
80105a04:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a05:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105a08:	53                   	push   %ebx
80105a09:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a0c:	50                   	push   %eax
80105a0d:	6a 00                	push   $0x0
80105a0f:	e8 2c fb ff ff       	call   80105540 <argstr>
80105a14:	83 c4 10             	add    $0x10,%esp
80105a17:	85 c0                	test   %eax,%eax
80105a19:	0f 88 fb 00 00 00    	js     80105b1a <sys_link+0x11a>
80105a1f:	83 ec 08             	sub    $0x8,%esp
80105a22:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105a25:	50                   	push   %eax
80105a26:	6a 01                	push   $0x1
80105a28:	e8 13 fb ff ff       	call   80105540 <argstr>
80105a2d:	83 c4 10             	add    $0x10,%esp
80105a30:	85 c0                	test   %eax,%eax
80105a32:	0f 88 e2 00 00 00    	js     80105b1a <sys_link+0x11a>
  begin_op();
80105a38:	e8 33 de ff ff       	call   80103870 <begin_op>
  if((ip = namei(old)) == 0){
80105a3d:	83 ec 0c             	sub    $0xc,%esp
80105a40:	ff 75 d4             	push   -0x2c(%ebp)
80105a43:	e8 68 d1 ff ff       	call   80102bb0 <namei>
80105a48:	83 c4 10             	add    $0x10,%esp
80105a4b:	89 c3                	mov    %eax,%ebx
80105a4d:	85 c0                	test   %eax,%eax
80105a4f:	0f 84 df 00 00 00    	je     80105b34 <sys_link+0x134>
  ilock(ip);
80105a55:	83 ec 0c             	sub    $0xc,%esp
80105a58:	50                   	push   %eax
80105a59:	e8 72 c8 ff ff       	call   801022d0 <ilock>
  if(ip->type == T_DIR){
80105a5e:	83 c4 10             	add    $0x10,%esp
80105a61:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a66:	0f 84 b5 00 00 00    	je     80105b21 <sys_link+0x121>
  iupdate(ip);
80105a6c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105a6f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105a74:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105a77:	53                   	push   %ebx
80105a78:	e8 a3 c7 ff ff       	call   80102220 <iupdate>
  iunlock(ip);
80105a7d:	89 1c 24             	mov    %ebx,(%esp)
80105a80:	e8 2b c9 ff ff       	call   801023b0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105a85:	58                   	pop    %eax
80105a86:	5a                   	pop    %edx
80105a87:	57                   	push   %edi
80105a88:	ff 75 d0             	push   -0x30(%ebp)
80105a8b:	e8 40 d1 ff ff       	call   80102bd0 <nameiparent>
80105a90:	83 c4 10             	add    $0x10,%esp
80105a93:	89 c6                	mov    %eax,%esi
80105a95:	85 c0                	test   %eax,%eax
80105a97:	74 5b                	je     80105af4 <sys_link+0xf4>
  ilock(dp);
80105a99:	83 ec 0c             	sub    $0xc,%esp
80105a9c:	50                   	push   %eax
80105a9d:	e8 2e c8 ff ff       	call   801022d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105aa2:	8b 03                	mov    (%ebx),%eax
80105aa4:	83 c4 10             	add    $0x10,%esp
80105aa7:	39 06                	cmp    %eax,(%esi)
80105aa9:	75 3d                	jne    80105ae8 <sys_link+0xe8>
80105aab:	83 ec 04             	sub    $0x4,%esp
80105aae:	ff 73 04             	push   0x4(%ebx)
80105ab1:	57                   	push   %edi
80105ab2:	56                   	push   %esi
80105ab3:	e8 38 d0 ff ff       	call   80102af0 <dirlink>
80105ab8:	83 c4 10             	add    $0x10,%esp
80105abb:	85 c0                	test   %eax,%eax
80105abd:	78 29                	js     80105ae8 <sys_link+0xe8>
  iunlockput(dp);
80105abf:	83 ec 0c             	sub    $0xc,%esp
80105ac2:	56                   	push   %esi
80105ac3:	e8 98 ca ff ff       	call   80102560 <iunlockput>
  iput(ip);
80105ac8:	89 1c 24             	mov    %ebx,(%esp)
80105acb:	e8 30 c9 ff ff       	call   80102400 <iput>
  end_op();
80105ad0:	e8 0b de ff ff       	call   801038e0 <end_op>
  return 0;
80105ad5:	83 c4 10             	add    $0x10,%esp
80105ad8:	31 c0                	xor    %eax,%eax
}
80105ada:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105add:	5b                   	pop    %ebx
80105ade:	5e                   	pop    %esi
80105adf:	5f                   	pop    %edi
80105ae0:	5d                   	pop    %ebp
80105ae1:	c3                   	ret
80105ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105ae8:	83 ec 0c             	sub    $0xc,%esp
80105aeb:	56                   	push   %esi
80105aec:	e8 6f ca ff ff       	call   80102560 <iunlockput>
    goto bad;
80105af1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105af4:	83 ec 0c             	sub    $0xc,%esp
80105af7:	53                   	push   %ebx
80105af8:	e8 d3 c7 ff ff       	call   801022d0 <ilock>
  ip->nlink--;
80105afd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105b02:	89 1c 24             	mov    %ebx,(%esp)
80105b05:	e8 16 c7 ff ff       	call   80102220 <iupdate>
  iunlockput(ip);
80105b0a:	89 1c 24             	mov    %ebx,(%esp)
80105b0d:	e8 4e ca ff ff       	call   80102560 <iunlockput>
  end_op();
80105b12:	e8 c9 dd ff ff       	call   801038e0 <end_op>
  return -1;
80105b17:	83 c4 10             	add    $0x10,%esp
    return -1;
80105b1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b1f:	eb b9                	jmp    80105ada <sys_link+0xda>
    iunlockput(ip);
80105b21:	83 ec 0c             	sub    $0xc,%esp
80105b24:	53                   	push   %ebx
80105b25:	e8 36 ca ff ff       	call   80102560 <iunlockput>
    end_op();
80105b2a:	e8 b1 dd ff ff       	call   801038e0 <end_op>
    return -1;
80105b2f:	83 c4 10             	add    $0x10,%esp
80105b32:	eb e6                	jmp    80105b1a <sys_link+0x11a>
    end_op();
80105b34:	e8 a7 dd ff ff       	call   801038e0 <end_op>
    return -1;
80105b39:	eb df                	jmp    80105b1a <sys_link+0x11a>
80105b3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105b40 <sys_unlink>:
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	57                   	push   %edi
80105b44:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105b45:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105b48:	53                   	push   %ebx
80105b49:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105b4c:	50                   	push   %eax
80105b4d:	6a 00                	push   $0x0
80105b4f:	e8 ec f9 ff ff       	call   80105540 <argstr>
80105b54:	83 c4 10             	add    $0x10,%esp
80105b57:	85 c0                	test   %eax,%eax
80105b59:	0f 88 54 01 00 00    	js     80105cb3 <sys_unlink+0x173>
  begin_op();
80105b5f:	e8 0c dd ff ff       	call   80103870 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105b64:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105b67:	83 ec 08             	sub    $0x8,%esp
80105b6a:	53                   	push   %ebx
80105b6b:	ff 75 c0             	push   -0x40(%ebp)
80105b6e:	e8 5d d0 ff ff       	call   80102bd0 <nameiparent>
80105b73:	83 c4 10             	add    $0x10,%esp
80105b76:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105b79:	85 c0                	test   %eax,%eax
80105b7b:	0f 84 58 01 00 00    	je     80105cd9 <sys_unlink+0x199>
  ilock(dp);
80105b81:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105b84:	83 ec 0c             	sub    $0xc,%esp
80105b87:	57                   	push   %edi
80105b88:	e8 43 c7 ff ff       	call   801022d0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105b8d:	58                   	pop    %eax
80105b8e:	5a                   	pop    %edx
80105b8f:	68 4b 80 10 80       	push   $0x8010804b
80105b94:	53                   	push   %ebx
80105b95:	e8 66 cc ff ff       	call   80102800 <namecmp>
80105b9a:	83 c4 10             	add    $0x10,%esp
80105b9d:	85 c0                	test   %eax,%eax
80105b9f:	0f 84 fb 00 00 00    	je     80105ca0 <sys_unlink+0x160>
80105ba5:	83 ec 08             	sub    $0x8,%esp
80105ba8:	68 4a 80 10 80       	push   $0x8010804a
80105bad:	53                   	push   %ebx
80105bae:	e8 4d cc ff ff       	call   80102800 <namecmp>
80105bb3:	83 c4 10             	add    $0x10,%esp
80105bb6:	85 c0                	test   %eax,%eax
80105bb8:	0f 84 e2 00 00 00    	je     80105ca0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105bbe:	83 ec 04             	sub    $0x4,%esp
80105bc1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105bc4:	50                   	push   %eax
80105bc5:	53                   	push   %ebx
80105bc6:	57                   	push   %edi
80105bc7:	e8 54 cc ff ff       	call   80102820 <dirlookup>
80105bcc:	83 c4 10             	add    $0x10,%esp
80105bcf:	89 c3                	mov    %eax,%ebx
80105bd1:	85 c0                	test   %eax,%eax
80105bd3:	0f 84 c7 00 00 00    	je     80105ca0 <sys_unlink+0x160>
  ilock(ip);
80105bd9:	83 ec 0c             	sub    $0xc,%esp
80105bdc:	50                   	push   %eax
80105bdd:	e8 ee c6 ff ff       	call   801022d0 <ilock>
  if(ip->nlink < 1)
80105be2:	83 c4 10             	add    $0x10,%esp
80105be5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105bea:	0f 8e 0a 01 00 00    	jle    80105cfa <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105bf0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bf5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105bf8:	74 66                	je     80105c60 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105bfa:	83 ec 04             	sub    $0x4,%esp
80105bfd:	6a 10                	push   $0x10
80105bff:	6a 00                	push   $0x0
80105c01:	57                   	push   %edi
80105c02:	e8 c9 f5 ff ff       	call   801051d0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c07:	6a 10                	push   $0x10
80105c09:	ff 75 c4             	push   -0x3c(%ebp)
80105c0c:	57                   	push   %edi
80105c0d:	ff 75 b4             	push   -0x4c(%ebp)
80105c10:	e8 cb ca ff ff       	call   801026e0 <writei>
80105c15:	83 c4 20             	add    $0x20,%esp
80105c18:	83 f8 10             	cmp    $0x10,%eax
80105c1b:	0f 85 cc 00 00 00    	jne    80105ced <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105c21:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c26:	0f 84 94 00 00 00    	je     80105cc0 <sys_unlink+0x180>
  iunlockput(dp);
80105c2c:	83 ec 0c             	sub    $0xc,%esp
80105c2f:	ff 75 b4             	push   -0x4c(%ebp)
80105c32:	e8 29 c9 ff ff       	call   80102560 <iunlockput>
  ip->nlink--;
80105c37:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105c3c:	89 1c 24             	mov    %ebx,(%esp)
80105c3f:	e8 dc c5 ff ff       	call   80102220 <iupdate>
  iunlockput(ip);
80105c44:	89 1c 24             	mov    %ebx,(%esp)
80105c47:	e8 14 c9 ff ff       	call   80102560 <iunlockput>
  end_op();
80105c4c:	e8 8f dc ff ff       	call   801038e0 <end_op>
  return 0;
80105c51:	83 c4 10             	add    $0x10,%esp
80105c54:	31 c0                	xor    %eax,%eax
}
80105c56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c59:	5b                   	pop    %ebx
80105c5a:	5e                   	pop    %esi
80105c5b:	5f                   	pop    %edi
80105c5c:	5d                   	pop    %ebp
80105c5d:	c3                   	ret
80105c5e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c60:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105c64:	76 94                	jbe    80105bfa <sys_unlink+0xba>
80105c66:	be 20 00 00 00       	mov    $0x20,%esi
80105c6b:	eb 0b                	jmp    80105c78 <sys_unlink+0x138>
80105c6d:	8d 76 00             	lea    0x0(%esi),%esi
80105c70:	83 c6 10             	add    $0x10,%esi
80105c73:	3b 73 58             	cmp    0x58(%ebx),%esi
80105c76:	73 82                	jae    80105bfa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c78:	6a 10                	push   $0x10
80105c7a:	56                   	push   %esi
80105c7b:	57                   	push   %edi
80105c7c:	53                   	push   %ebx
80105c7d:	e8 5e c9 ff ff       	call   801025e0 <readi>
80105c82:	83 c4 10             	add    $0x10,%esp
80105c85:	83 f8 10             	cmp    $0x10,%eax
80105c88:	75 56                	jne    80105ce0 <sys_unlink+0x1a0>
    if(de.inum != 0)
80105c8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105c8f:	74 df                	je     80105c70 <sys_unlink+0x130>
    iunlockput(ip);
80105c91:	83 ec 0c             	sub    $0xc,%esp
80105c94:	53                   	push   %ebx
80105c95:	e8 c6 c8 ff ff       	call   80102560 <iunlockput>
    goto bad;
80105c9a:	83 c4 10             	add    $0x10,%esp
80105c9d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105ca0:	83 ec 0c             	sub    $0xc,%esp
80105ca3:	ff 75 b4             	push   -0x4c(%ebp)
80105ca6:	e8 b5 c8 ff ff       	call   80102560 <iunlockput>
  end_op();
80105cab:	e8 30 dc ff ff       	call   801038e0 <end_op>
  return -1;
80105cb0:	83 c4 10             	add    $0x10,%esp
    return -1;
80105cb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cb8:	eb 9c                	jmp    80105c56 <sys_unlink+0x116>
80105cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105cc0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105cc3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105cc6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105ccb:	50                   	push   %eax
80105ccc:	e8 4f c5 ff ff       	call   80102220 <iupdate>
80105cd1:	83 c4 10             	add    $0x10,%esp
80105cd4:	e9 53 ff ff ff       	jmp    80105c2c <sys_unlink+0xec>
    end_op();
80105cd9:	e8 02 dc ff ff       	call   801038e0 <end_op>
    return -1;
80105cde:	eb d3                	jmp    80105cb3 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105ce0:	83 ec 0c             	sub    $0xc,%esp
80105ce3:	68 6f 80 10 80       	push   $0x8010806f
80105ce8:	e8 23 ae ff ff       	call   80100b10 <panic>
    panic("unlink: writei");
80105ced:	83 ec 0c             	sub    $0xc,%esp
80105cf0:	68 81 80 10 80       	push   $0x80108081
80105cf5:	e8 16 ae ff ff       	call   80100b10 <panic>
    panic("unlink: nlink < 1");
80105cfa:	83 ec 0c             	sub    $0xc,%esp
80105cfd:	68 5d 80 10 80       	push   $0x8010805d
80105d02:	e8 09 ae ff ff       	call   80100b10 <panic>
80105d07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d0e:	00 
80105d0f:	90                   	nop

80105d10 <sys_open>:

int
sys_open(void)
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	57                   	push   %edi
80105d14:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d15:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105d18:	53                   	push   %ebx
80105d19:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d1c:	50                   	push   %eax
80105d1d:	6a 00                	push   $0x0
80105d1f:	e8 1c f8 ff ff       	call   80105540 <argstr>
80105d24:	83 c4 10             	add    $0x10,%esp
80105d27:	85 c0                	test   %eax,%eax
80105d29:	0f 88 8e 00 00 00    	js     80105dbd <sys_open+0xad>
80105d2f:	83 ec 08             	sub    $0x8,%esp
80105d32:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d35:	50                   	push   %eax
80105d36:	6a 01                	push   $0x1
80105d38:	e8 43 f7 ff ff       	call   80105480 <argint>
80105d3d:	83 c4 10             	add    $0x10,%esp
80105d40:	85 c0                	test   %eax,%eax
80105d42:	78 79                	js     80105dbd <sys_open+0xad>
    return -1;

  begin_op();
80105d44:	e8 27 db ff ff       	call   80103870 <begin_op>

  if(omode & O_CREATE){
80105d49:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105d4d:	75 79                	jne    80105dc8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105d4f:	83 ec 0c             	sub    $0xc,%esp
80105d52:	ff 75 e0             	push   -0x20(%ebp)
80105d55:	e8 56 ce ff ff       	call   80102bb0 <namei>
80105d5a:	83 c4 10             	add    $0x10,%esp
80105d5d:	89 c6                	mov    %eax,%esi
80105d5f:	85 c0                	test   %eax,%eax
80105d61:	0f 84 7e 00 00 00    	je     80105de5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105d67:	83 ec 0c             	sub    $0xc,%esp
80105d6a:	50                   	push   %eax
80105d6b:	e8 60 c5 ff ff       	call   801022d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105d70:	83 c4 10             	add    $0x10,%esp
80105d73:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105d78:	0f 84 ba 00 00 00    	je     80105e38 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105d7e:	e8 fd bb ff ff       	call   80101980 <filealloc>
80105d83:	89 c7                	mov    %eax,%edi
80105d85:	85 c0                	test   %eax,%eax
80105d87:	74 23                	je     80105dac <sys_open+0x9c>
  struct proc *curproc = myproc();
80105d89:	e8 02 e7 ff ff       	call   80104490 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d8e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105d90:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105d94:	85 d2                	test   %edx,%edx
80105d96:	74 58                	je     80105df0 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105d98:	83 c3 01             	add    $0x1,%ebx
80105d9b:	83 fb 10             	cmp    $0x10,%ebx
80105d9e:	75 f0                	jne    80105d90 <sys_open+0x80>
    if(f)
      fileclose(f);
80105da0:	83 ec 0c             	sub    $0xc,%esp
80105da3:	57                   	push   %edi
80105da4:	e8 97 bc ff ff       	call   80101a40 <fileclose>
80105da9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105dac:	83 ec 0c             	sub    $0xc,%esp
80105daf:	56                   	push   %esi
80105db0:	e8 ab c7 ff ff       	call   80102560 <iunlockput>
    end_op();
80105db5:	e8 26 db ff ff       	call   801038e0 <end_op>
    return -1;
80105dba:	83 c4 10             	add    $0x10,%esp
    return -1;
80105dbd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105dc2:	eb 65                	jmp    80105e29 <sys_open+0x119>
80105dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105dc8:	83 ec 0c             	sub    $0xc,%esp
80105dcb:	31 c9                	xor    %ecx,%ecx
80105dcd:	ba 02 00 00 00       	mov    $0x2,%edx
80105dd2:	6a 00                	push   $0x0
80105dd4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105dd7:	e8 54 f8 ff ff       	call   80105630 <create>
    if(ip == 0){
80105ddc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105ddf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105de1:	85 c0                	test   %eax,%eax
80105de3:	75 99                	jne    80105d7e <sys_open+0x6e>
      end_op();
80105de5:	e8 f6 da ff ff       	call   801038e0 <end_op>
      return -1;
80105dea:	eb d1                	jmp    80105dbd <sys_open+0xad>
80105dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105df0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105df3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105df7:	56                   	push   %esi
80105df8:	e8 b3 c5 ff ff       	call   801023b0 <iunlock>
  end_op();
80105dfd:	e8 de da ff ff       	call   801038e0 <end_op>

  f->type = FD_INODE;
80105e02:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105e08:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e0b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105e0e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105e11:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105e13:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105e1a:	f7 d0                	not    %eax
80105e1c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e1f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105e22:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e25:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105e29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e2c:	89 d8                	mov    %ebx,%eax
80105e2e:	5b                   	pop    %ebx
80105e2f:	5e                   	pop    %esi
80105e30:	5f                   	pop    %edi
80105e31:	5d                   	pop    %ebp
80105e32:	c3                   	ret
80105e33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e38:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105e3b:	85 c9                	test   %ecx,%ecx
80105e3d:	0f 84 3b ff ff ff    	je     80105d7e <sys_open+0x6e>
80105e43:	e9 64 ff ff ff       	jmp    80105dac <sys_open+0x9c>
80105e48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e4f:	00 

80105e50 <sys_mkdir>:

int
sys_mkdir(void)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105e56:	e8 15 da ff ff       	call   80103870 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105e5b:	83 ec 08             	sub    $0x8,%esp
80105e5e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e61:	50                   	push   %eax
80105e62:	6a 00                	push   $0x0
80105e64:	e8 d7 f6 ff ff       	call   80105540 <argstr>
80105e69:	83 c4 10             	add    $0x10,%esp
80105e6c:	85 c0                	test   %eax,%eax
80105e6e:	78 30                	js     80105ea0 <sys_mkdir+0x50>
80105e70:	83 ec 0c             	sub    $0xc,%esp
80105e73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e76:	31 c9                	xor    %ecx,%ecx
80105e78:	ba 01 00 00 00       	mov    $0x1,%edx
80105e7d:	6a 00                	push   $0x0
80105e7f:	e8 ac f7 ff ff       	call   80105630 <create>
80105e84:	83 c4 10             	add    $0x10,%esp
80105e87:	85 c0                	test   %eax,%eax
80105e89:	74 15                	je     80105ea0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105e8b:	83 ec 0c             	sub    $0xc,%esp
80105e8e:	50                   	push   %eax
80105e8f:	e8 cc c6 ff ff       	call   80102560 <iunlockput>
  end_op();
80105e94:	e8 47 da ff ff       	call   801038e0 <end_op>
  return 0;
80105e99:	83 c4 10             	add    $0x10,%esp
80105e9c:	31 c0                	xor    %eax,%eax
}
80105e9e:	c9                   	leave
80105e9f:	c3                   	ret
    end_op();
80105ea0:	e8 3b da ff ff       	call   801038e0 <end_op>
    return -1;
80105ea5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105eaa:	c9                   	leave
80105eab:	c3                   	ret
80105eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105eb0 <sys_mknod>:

int
sys_mknod(void)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105eb6:	e8 b5 d9 ff ff       	call   80103870 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105ebb:	83 ec 08             	sub    $0x8,%esp
80105ebe:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ec1:	50                   	push   %eax
80105ec2:	6a 00                	push   $0x0
80105ec4:	e8 77 f6 ff ff       	call   80105540 <argstr>
80105ec9:	83 c4 10             	add    $0x10,%esp
80105ecc:	85 c0                	test   %eax,%eax
80105ece:	78 60                	js     80105f30 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105ed0:	83 ec 08             	sub    $0x8,%esp
80105ed3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ed6:	50                   	push   %eax
80105ed7:	6a 01                	push   $0x1
80105ed9:	e8 a2 f5 ff ff       	call   80105480 <argint>
  if((argstr(0, &path)) < 0 ||
80105ede:	83 c4 10             	add    $0x10,%esp
80105ee1:	85 c0                	test   %eax,%eax
80105ee3:	78 4b                	js     80105f30 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105ee5:	83 ec 08             	sub    $0x8,%esp
80105ee8:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105eeb:	50                   	push   %eax
80105eec:	6a 02                	push   $0x2
80105eee:	e8 8d f5 ff ff       	call   80105480 <argint>
     argint(1, &major) < 0 ||
80105ef3:	83 c4 10             	add    $0x10,%esp
80105ef6:	85 c0                	test   %eax,%eax
80105ef8:	78 36                	js     80105f30 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105efa:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105efe:	83 ec 0c             	sub    $0xc,%esp
80105f01:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105f05:	ba 03 00 00 00       	mov    $0x3,%edx
80105f0a:	50                   	push   %eax
80105f0b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f0e:	e8 1d f7 ff ff       	call   80105630 <create>
     argint(2, &minor) < 0 ||
80105f13:	83 c4 10             	add    $0x10,%esp
80105f16:	85 c0                	test   %eax,%eax
80105f18:	74 16                	je     80105f30 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f1a:	83 ec 0c             	sub    $0xc,%esp
80105f1d:	50                   	push   %eax
80105f1e:	e8 3d c6 ff ff       	call   80102560 <iunlockput>
  end_op();
80105f23:	e8 b8 d9 ff ff       	call   801038e0 <end_op>
  return 0;
80105f28:	83 c4 10             	add    $0x10,%esp
80105f2b:	31 c0                	xor    %eax,%eax
}
80105f2d:	c9                   	leave
80105f2e:	c3                   	ret
80105f2f:	90                   	nop
    end_op();
80105f30:	e8 ab d9 ff ff       	call   801038e0 <end_op>
    return -1;
80105f35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f3a:	c9                   	leave
80105f3b:	c3                   	ret
80105f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f40 <sys_chdir>:

int
sys_chdir(void)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	56                   	push   %esi
80105f44:	53                   	push   %ebx
80105f45:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105f48:	e8 43 e5 ff ff       	call   80104490 <myproc>
80105f4d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105f4f:	e8 1c d9 ff ff       	call   80103870 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105f54:	83 ec 08             	sub    $0x8,%esp
80105f57:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f5a:	50                   	push   %eax
80105f5b:	6a 00                	push   $0x0
80105f5d:	e8 de f5 ff ff       	call   80105540 <argstr>
80105f62:	83 c4 10             	add    $0x10,%esp
80105f65:	85 c0                	test   %eax,%eax
80105f67:	78 77                	js     80105fe0 <sys_chdir+0xa0>
80105f69:	83 ec 0c             	sub    $0xc,%esp
80105f6c:	ff 75 f4             	push   -0xc(%ebp)
80105f6f:	e8 3c cc ff ff       	call   80102bb0 <namei>
80105f74:	83 c4 10             	add    $0x10,%esp
80105f77:	89 c3                	mov    %eax,%ebx
80105f79:	85 c0                	test   %eax,%eax
80105f7b:	74 63                	je     80105fe0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105f7d:	83 ec 0c             	sub    $0xc,%esp
80105f80:	50                   	push   %eax
80105f81:	e8 4a c3 ff ff       	call   801022d0 <ilock>
  if(ip->type != T_DIR){
80105f86:	83 c4 10             	add    $0x10,%esp
80105f89:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105f8e:	75 30                	jne    80105fc0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105f90:	83 ec 0c             	sub    $0xc,%esp
80105f93:	53                   	push   %ebx
80105f94:	e8 17 c4 ff ff       	call   801023b0 <iunlock>
  iput(curproc->cwd);
80105f99:	58                   	pop    %eax
80105f9a:	ff 76 68             	push   0x68(%esi)
80105f9d:	e8 5e c4 ff ff       	call   80102400 <iput>
  end_op();
80105fa2:	e8 39 d9 ff ff       	call   801038e0 <end_op>
  curproc->cwd = ip;
80105fa7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105faa:	83 c4 10             	add    $0x10,%esp
80105fad:	31 c0                	xor    %eax,%eax
}
80105faf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105fb2:	5b                   	pop    %ebx
80105fb3:	5e                   	pop    %esi
80105fb4:	5d                   	pop    %ebp
80105fb5:	c3                   	ret
80105fb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fbd:	00 
80105fbe:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105fc0:	83 ec 0c             	sub    $0xc,%esp
80105fc3:	53                   	push   %ebx
80105fc4:	e8 97 c5 ff ff       	call   80102560 <iunlockput>
    end_op();
80105fc9:	e8 12 d9 ff ff       	call   801038e0 <end_op>
    return -1;
80105fce:	83 c4 10             	add    $0x10,%esp
    return -1;
80105fd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fd6:	eb d7                	jmp    80105faf <sys_chdir+0x6f>
80105fd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fdf:	00 
    end_op();
80105fe0:	e8 fb d8 ff ff       	call   801038e0 <end_op>
    return -1;
80105fe5:	eb ea                	jmp    80105fd1 <sys_chdir+0x91>
80105fe7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fee:	00 
80105fef:	90                   	nop

80105ff0 <sys_exec>:

int
sys_exec(void)
{
80105ff0:	55                   	push   %ebp
80105ff1:	89 e5                	mov    %esp,%ebp
80105ff3:	57                   	push   %edi
80105ff4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105ff5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105ffb:	53                   	push   %ebx
80105ffc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106002:	50                   	push   %eax
80106003:	6a 00                	push   $0x0
80106005:	e8 36 f5 ff ff       	call   80105540 <argstr>
8010600a:	83 c4 10             	add    $0x10,%esp
8010600d:	85 c0                	test   %eax,%eax
8010600f:	0f 88 87 00 00 00    	js     8010609c <sys_exec+0xac>
80106015:	83 ec 08             	sub    $0x8,%esp
80106018:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010601e:	50                   	push   %eax
8010601f:	6a 01                	push   $0x1
80106021:	e8 5a f4 ff ff       	call   80105480 <argint>
80106026:	83 c4 10             	add    $0x10,%esp
80106029:	85 c0                	test   %eax,%eax
8010602b:	78 6f                	js     8010609c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010602d:	83 ec 04             	sub    $0x4,%esp
80106030:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106036:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106038:	68 80 00 00 00       	push   $0x80
8010603d:	6a 00                	push   $0x0
8010603f:	56                   	push   %esi
80106040:	e8 8b f1 ff ff       	call   801051d0 <memset>
80106045:	83 c4 10             	add    $0x10,%esp
80106048:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010604f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106050:	83 ec 08             	sub    $0x8,%esp
80106053:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106059:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106060:	50                   	push   %eax
80106061:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106067:	01 f8                	add    %edi,%eax
80106069:	50                   	push   %eax
8010606a:	e8 81 f3 ff ff       	call   801053f0 <fetchint>
8010606f:	83 c4 10             	add    $0x10,%esp
80106072:	85 c0                	test   %eax,%eax
80106074:	78 26                	js     8010609c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106076:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010607c:	85 c0                	test   %eax,%eax
8010607e:	74 30                	je     801060b0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106080:	83 ec 08             	sub    $0x8,%esp
80106083:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106086:	52                   	push   %edx
80106087:	50                   	push   %eax
80106088:	e8 a3 f3 ff ff       	call   80105430 <fetchstr>
8010608d:	83 c4 10             	add    $0x10,%esp
80106090:	85 c0                	test   %eax,%eax
80106092:	78 08                	js     8010609c <sys_exec+0xac>
  for(i=0;; i++){
80106094:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106097:	83 fb 20             	cmp    $0x20,%ebx
8010609a:	75 b4                	jne    80106050 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010609c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010609f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060a4:	5b                   	pop    %ebx
801060a5:	5e                   	pop    %esi
801060a6:	5f                   	pop    %edi
801060a7:	5d                   	pop    %ebp
801060a8:	c3                   	ret
801060a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801060b0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801060b7:	00 00 00 00 
  return exec(path, argv);
801060bb:	83 ec 08             	sub    $0x8,%esp
801060be:	56                   	push   %esi
801060bf:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801060c5:	e8 16 b5 ff ff       	call   801015e0 <exec>
801060ca:	83 c4 10             	add    $0x10,%esp
}
801060cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060d0:	5b                   	pop    %ebx
801060d1:	5e                   	pop    %esi
801060d2:	5f                   	pop    %edi
801060d3:	5d                   	pop    %ebp
801060d4:	c3                   	ret
801060d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060dc:	00 
801060dd:	8d 76 00             	lea    0x0(%esi),%esi

801060e0 <sys_pipe>:

int
sys_pipe(void)
{
801060e0:	55                   	push   %ebp
801060e1:	89 e5                	mov    %esp,%ebp
801060e3:	57                   	push   %edi
801060e4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801060e5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801060e8:	53                   	push   %ebx
801060e9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801060ec:	6a 08                	push   $0x8
801060ee:	50                   	push   %eax
801060ef:	6a 00                	push   $0x0
801060f1:	e8 da f3 ff ff       	call   801054d0 <argptr>
801060f6:	83 c4 10             	add    $0x10,%esp
801060f9:	85 c0                	test   %eax,%eax
801060fb:	0f 88 8b 00 00 00    	js     8010618c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106101:	83 ec 08             	sub    $0x8,%esp
80106104:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106107:	50                   	push   %eax
80106108:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010610b:	50                   	push   %eax
8010610c:	e8 2f de ff ff       	call   80103f40 <pipealloc>
80106111:	83 c4 10             	add    $0x10,%esp
80106114:	85 c0                	test   %eax,%eax
80106116:	78 74                	js     8010618c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106118:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010611b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010611d:	e8 6e e3 ff ff       	call   80104490 <myproc>
    if(curproc->ofile[fd] == 0){
80106122:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106126:	85 f6                	test   %esi,%esi
80106128:	74 16                	je     80106140 <sys_pipe+0x60>
8010612a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106130:	83 c3 01             	add    $0x1,%ebx
80106133:	83 fb 10             	cmp    $0x10,%ebx
80106136:	74 3d                	je     80106175 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80106138:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010613c:	85 f6                	test   %esi,%esi
8010613e:	75 f0                	jne    80106130 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106140:	8d 73 08             	lea    0x8(%ebx),%esi
80106143:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106147:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010614a:	e8 41 e3 ff ff       	call   80104490 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010614f:	31 d2                	xor    %edx,%edx
80106151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106158:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010615c:	85 c9                	test   %ecx,%ecx
8010615e:	74 38                	je     80106198 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80106160:	83 c2 01             	add    $0x1,%edx
80106163:	83 fa 10             	cmp    $0x10,%edx
80106166:	75 f0                	jne    80106158 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80106168:	e8 23 e3 ff ff       	call   80104490 <myproc>
8010616d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106174:	00 
    fileclose(rf);
80106175:	83 ec 0c             	sub    $0xc,%esp
80106178:	ff 75 e0             	push   -0x20(%ebp)
8010617b:	e8 c0 b8 ff ff       	call   80101a40 <fileclose>
    fileclose(wf);
80106180:	58                   	pop    %eax
80106181:	ff 75 e4             	push   -0x1c(%ebp)
80106184:	e8 b7 b8 ff ff       	call   80101a40 <fileclose>
    return -1;
80106189:	83 c4 10             	add    $0x10,%esp
    return -1;
8010618c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106191:	eb 16                	jmp    801061a9 <sys_pipe+0xc9>
80106193:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80106198:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010619c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010619f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801061a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061a4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801061a7:	31 c0                	xor    %eax,%eax
}
801061a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061ac:	5b                   	pop    %ebx
801061ad:	5e                   	pop    %esi
801061ae:	5f                   	pop    %edi
801061af:	5d                   	pop    %ebp
801061b0:	c3                   	ret
801061b1:	66 90                	xchg   %ax,%ax
801061b3:	66 90                	xchg   %ax,%ax
801061b5:	66 90                	xchg   %ax,%ax
801061b7:	66 90                	xchg   %ax,%ax
801061b9:	66 90                	xchg   %ax,%ax
801061bb:	66 90                	xchg   %ax,%ax
801061bd:	66 90                	xchg   %ax,%ax
801061bf:	90                   	nop

801061c0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801061c0:	e9 6b e4 ff ff       	jmp    80104630 <fork>
801061c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061cc:	00 
801061cd:	8d 76 00             	lea    0x0(%esi),%esi

801061d0 <sys_exit>:
}

int
sys_exit(void)
{
801061d0:	55                   	push   %ebp
801061d1:	89 e5                	mov    %esp,%ebp
801061d3:	83 ec 08             	sub    $0x8,%esp
  exit();
801061d6:	e8 c5 e6 ff ff       	call   801048a0 <exit>
  return 0;  // not reached
}
801061db:	31 c0                	xor    %eax,%eax
801061dd:	c9                   	leave
801061de:	c3                   	ret
801061df:	90                   	nop

801061e0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
801061e0:	e9 eb e7 ff ff       	jmp    801049d0 <wait>
801061e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061ec:	00 
801061ed:	8d 76 00             	lea    0x0(%esi),%esi

801061f0 <sys_kill>:
}

int
sys_kill(void)
{
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
801061f3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801061f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061f9:	50                   	push   %eax
801061fa:	6a 00                	push   $0x0
801061fc:	e8 7f f2 ff ff       	call   80105480 <argint>
80106201:	83 c4 10             	add    $0x10,%esp
80106204:	85 c0                	test   %eax,%eax
80106206:	78 18                	js     80106220 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106208:	83 ec 0c             	sub    $0xc,%esp
8010620b:	ff 75 f4             	push   -0xc(%ebp)
8010620e:	e8 5d ea ff ff       	call   80104c70 <kill>
80106213:	83 c4 10             	add    $0x10,%esp
}
80106216:	c9                   	leave
80106217:	c3                   	ret
80106218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010621f:	00 
80106220:	c9                   	leave
    return -1;
80106221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106226:	c3                   	ret
80106227:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010622e:	00 
8010622f:	90                   	nop

80106230 <sys_getpid>:

int
sys_getpid(void)
{
80106230:	55                   	push   %ebp
80106231:	89 e5                	mov    %esp,%ebp
80106233:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106236:	e8 55 e2 ff ff       	call   80104490 <myproc>
8010623b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010623e:	c9                   	leave
8010623f:	c3                   	ret

80106240 <sys_sbrk>:

int
sys_sbrk(void)
{
80106240:	55                   	push   %ebp
80106241:	89 e5                	mov    %esp,%ebp
80106243:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106244:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106247:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010624a:	50                   	push   %eax
8010624b:	6a 00                	push   $0x0
8010624d:	e8 2e f2 ff ff       	call   80105480 <argint>
80106252:	83 c4 10             	add    $0x10,%esp
80106255:	85 c0                	test   %eax,%eax
80106257:	78 27                	js     80106280 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106259:	e8 32 e2 ff ff       	call   80104490 <myproc>
  if(growproc(n) < 0)
8010625e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106261:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106263:	ff 75 f4             	push   -0xc(%ebp)
80106266:	e8 45 e3 ff ff       	call   801045b0 <growproc>
8010626b:	83 c4 10             	add    $0x10,%esp
8010626e:	85 c0                	test   %eax,%eax
80106270:	78 0e                	js     80106280 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106272:	89 d8                	mov    %ebx,%eax
80106274:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106277:	c9                   	leave
80106278:	c3                   	ret
80106279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106280:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106285:	eb eb                	jmp    80106272 <sys_sbrk+0x32>
80106287:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010628e:	00 
8010628f:	90                   	nop

80106290 <sys_sleep>:

int
sys_sleep(void)
{
80106290:	55                   	push   %ebp
80106291:	89 e5                	mov    %esp,%ebp
80106293:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106294:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106297:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010629a:	50                   	push   %eax
8010629b:	6a 00                	push   $0x0
8010629d:	e8 de f1 ff ff       	call   80105480 <argint>
801062a2:	83 c4 10             	add    $0x10,%esp
801062a5:	85 c0                	test   %eax,%eax
801062a7:	78 64                	js     8010630d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
801062a9:	83 ec 0c             	sub    $0xc,%esp
801062ac:	68 80 4c 11 80       	push   $0x80114c80
801062b1:	e8 1a ee ff ff       	call   801050d0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801062b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801062b9:	8b 1d 60 4c 11 80    	mov    0x80114c60,%ebx
  while(ticks - ticks0 < n){
801062bf:	83 c4 10             	add    $0x10,%esp
801062c2:	85 d2                	test   %edx,%edx
801062c4:	75 2b                	jne    801062f1 <sys_sleep+0x61>
801062c6:	eb 58                	jmp    80106320 <sys_sleep+0x90>
801062c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062cf:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801062d0:	83 ec 08             	sub    $0x8,%esp
801062d3:	68 80 4c 11 80       	push   $0x80114c80
801062d8:	68 60 4c 11 80       	push   $0x80114c60
801062dd:	e8 6e e8 ff ff       	call   80104b50 <sleep>
  while(ticks - ticks0 < n){
801062e2:	a1 60 4c 11 80       	mov    0x80114c60,%eax
801062e7:	83 c4 10             	add    $0x10,%esp
801062ea:	29 d8                	sub    %ebx,%eax
801062ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801062ef:	73 2f                	jae    80106320 <sys_sleep+0x90>
    if(myproc()->killed){
801062f1:	e8 9a e1 ff ff       	call   80104490 <myproc>
801062f6:	8b 40 24             	mov    0x24(%eax),%eax
801062f9:	85 c0                	test   %eax,%eax
801062fb:	74 d3                	je     801062d0 <sys_sleep+0x40>
      release(&tickslock);
801062fd:	83 ec 0c             	sub    $0xc,%esp
80106300:	68 80 4c 11 80       	push   $0x80114c80
80106305:	e8 66 ed ff ff       	call   80105070 <release>
      return -1;
8010630a:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
8010630d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80106310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106315:	c9                   	leave
80106316:	c3                   	ret
80106317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010631e:	00 
8010631f:	90                   	nop
  release(&tickslock);
80106320:	83 ec 0c             	sub    $0xc,%esp
80106323:	68 80 4c 11 80       	push   $0x80114c80
80106328:	e8 43 ed ff ff       	call   80105070 <release>
}
8010632d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80106330:	83 c4 10             	add    $0x10,%esp
80106333:	31 c0                	xor    %eax,%eax
}
80106335:	c9                   	leave
80106336:	c3                   	ret
80106337:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010633e:	00 
8010633f:	90                   	nop

80106340 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106340:	55                   	push   %ebp
80106341:	89 e5                	mov    %esp,%ebp
80106343:	53                   	push   %ebx
80106344:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106347:	68 80 4c 11 80       	push   $0x80114c80
8010634c:	e8 7f ed ff ff       	call   801050d0 <acquire>
  xticks = ticks;
80106351:	8b 1d 60 4c 11 80    	mov    0x80114c60,%ebx
  release(&tickslock);
80106357:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
8010635e:	e8 0d ed ff ff       	call   80105070 <release>
  return xticks;
}
80106363:	89 d8                	mov    %ebx,%eax
80106365:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106368:	c9                   	leave
80106369:	c3                   	ret

8010636a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010636a:	1e                   	push   %ds
  pushl %es
8010636b:	06                   	push   %es
  pushl %fs
8010636c:	0f a0                	push   %fs
  pushl %gs
8010636e:	0f a8                	push   %gs
  pushal
80106370:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106371:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106375:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106377:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106379:	54                   	push   %esp
  call trap
8010637a:	e8 c1 00 00 00       	call   80106440 <trap>
  addl $4, %esp
8010637f:	83 c4 04             	add    $0x4,%esp

80106382 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106382:	61                   	popa
  popl %gs
80106383:	0f a9                	pop    %gs
  popl %fs
80106385:	0f a1                	pop    %fs
  popl %es
80106387:	07                   	pop    %es
  popl %ds
80106388:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106389:	83 c4 08             	add    $0x8,%esp
  iret
8010638c:	cf                   	iret
8010638d:	66 90                	xchg   %ax,%ax
8010638f:	90                   	nop

80106390 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106390:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106391:	31 c0                	xor    %eax,%eax
{
80106393:	89 e5                	mov    %esp,%ebp
80106395:	83 ec 08             	sub    $0x8,%esp
80106398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010639f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801063a0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801063a7:	c7 04 c5 c2 4c 11 80 	movl   $0x8e000008,-0x7feeb33e(,%eax,8)
801063ae:	08 00 00 8e 
801063b2:	66 89 14 c5 c0 4c 11 	mov    %dx,-0x7feeb340(,%eax,8)
801063b9:	80 
801063ba:	c1 ea 10             	shr    $0x10,%edx
801063bd:	66 89 14 c5 c6 4c 11 	mov    %dx,-0x7feeb33a(,%eax,8)
801063c4:	80 
  for(i = 0; i < 256; i++)
801063c5:	83 c0 01             	add    $0x1,%eax
801063c8:	3d 00 01 00 00       	cmp    $0x100,%eax
801063cd:	75 d1                	jne    801063a0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801063cf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801063d2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801063d7:	c7 05 c2 4e 11 80 08 	movl   $0xef000008,0x80114ec2
801063de:	00 00 ef 
  initlock(&tickslock, "time");
801063e1:	68 90 80 10 80       	push   $0x80108090
801063e6:	68 80 4c 11 80       	push   $0x80114c80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801063eb:	66 a3 c0 4e 11 80    	mov    %ax,0x80114ec0
801063f1:	c1 e8 10             	shr    $0x10,%eax
801063f4:	66 a3 c6 4e 11 80    	mov    %ax,0x80114ec6
  initlock(&tickslock, "time");
801063fa:	e8 e1 ea ff ff       	call   80104ee0 <initlock>
}
801063ff:	83 c4 10             	add    $0x10,%esp
80106402:	c9                   	leave
80106403:	c3                   	ret
80106404:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010640b:	00 
8010640c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106410 <idtinit>:

void
idtinit(void)
{
80106410:	55                   	push   %ebp
  pd[0] = size-1;
80106411:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106416:	89 e5                	mov    %esp,%ebp
80106418:	83 ec 10             	sub    $0x10,%esp
8010641b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010641f:	b8 c0 4c 11 80       	mov    $0x80114cc0,%eax
80106424:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106428:	c1 e8 10             	shr    $0x10,%eax
8010642b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010642f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106432:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106435:	c9                   	leave
80106436:	c3                   	ret
80106437:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010643e:	00 
8010643f:	90                   	nop

80106440 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106440:	55                   	push   %ebp
80106441:	89 e5                	mov    %esp,%ebp
80106443:	57                   	push   %edi
80106444:	56                   	push   %esi
80106445:	53                   	push   %ebx
80106446:	83 ec 1c             	sub    $0x1c,%esp
80106449:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010644c:	8b 43 30             	mov    0x30(%ebx),%eax
8010644f:	83 f8 40             	cmp    $0x40,%eax
80106452:	0f 84 58 01 00 00    	je     801065b0 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106458:	83 e8 20             	sub    $0x20,%eax
8010645b:	83 f8 1f             	cmp    $0x1f,%eax
8010645e:	0f 87 7c 00 00 00    	ja     801064e0 <trap+0xa0>
80106464:	ff 24 85 58 86 10 80 	jmp    *-0x7fef79a8(,%eax,4)
8010646b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106470:	e8 eb c8 ff ff       	call   80102d60 <ideintr>
    lapiceoi();
80106475:	e8 a6 cf ff ff       	call   80103420 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010647a:	e8 11 e0 ff ff       	call   80104490 <myproc>
8010647f:	85 c0                	test   %eax,%eax
80106481:	74 1a                	je     8010649d <trap+0x5d>
80106483:	e8 08 e0 ff ff       	call   80104490 <myproc>
80106488:	8b 50 24             	mov    0x24(%eax),%edx
8010648b:	85 d2                	test   %edx,%edx
8010648d:	74 0e                	je     8010649d <trap+0x5d>
8010648f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106493:	f7 d0                	not    %eax
80106495:	a8 03                	test   $0x3,%al
80106497:	0f 84 db 01 00 00    	je     80106678 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
8010649d:	e8 ee df ff ff       	call   80104490 <myproc>
801064a2:	85 c0                	test   %eax,%eax
801064a4:	74 0f                	je     801064b5 <trap+0x75>
801064a6:	e8 e5 df ff ff       	call   80104490 <myproc>
801064ab:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801064af:	0f 84 ab 00 00 00    	je     80106560 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801064b5:	e8 d6 df ff ff       	call   80104490 <myproc>
801064ba:	85 c0                	test   %eax,%eax
801064bc:	74 1a                	je     801064d8 <trap+0x98>
801064be:	e8 cd df ff ff       	call   80104490 <myproc>
801064c3:	8b 40 24             	mov    0x24(%eax),%eax
801064c6:	85 c0                	test   %eax,%eax
801064c8:	74 0e                	je     801064d8 <trap+0x98>
801064ca:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801064ce:	f7 d0                	not    %eax
801064d0:	a8 03                	test   $0x3,%al
801064d2:	0f 84 05 01 00 00    	je     801065dd <trap+0x19d>
    exit();
}
801064d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064db:	5b                   	pop    %ebx
801064dc:	5e                   	pop    %esi
801064dd:	5f                   	pop    %edi
801064de:	5d                   	pop    %ebp
801064df:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
801064e0:	e8 ab df ff ff       	call   80104490 <myproc>
801064e5:	8b 7b 38             	mov    0x38(%ebx),%edi
801064e8:	85 c0                	test   %eax,%eax
801064ea:	0f 84 a2 01 00 00    	je     80106692 <trap+0x252>
801064f0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801064f4:	0f 84 98 01 00 00    	je     80106692 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801064fa:	0f 20 d1             	mov    %cr2,%ecx
801064fd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106500:	e8 6b df ff ff       	call   80104470 <cpuid>
80106505:	8b 73 30             	mov    0x30(%ebx),%esi
80106508:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010650b:	8b 43 34             	mov    0x34(%ebx),%eax
8010650e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106511:	e8 7a df ff ff       	call   80104490 <myproc>
80106516:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106519:	e8 72 df ff ff       	call   80104490 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010651e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106521:	51                   	push   %ecx
80106522:	57                   	push   %edi
80106523:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106526:	52                   	push   %edx
80106527:	ff 75 e4             	push   -0x1c(%ebp)
8010652a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010652b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010652e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106531:	56                   	push   %esi
80106532:	ff 70 10             	push   0x10(%eax)
80106535:	68 4c 83 10 80       	push   $0x8010834c
8010653a:	e8 81 a3 ff ff       	call   801008c0 <cprintf>
    myproc()->killed = 1;
8010653f:	83 c4 20             	add    $0x20,%esp
80106542:	e8 49 df ff ff       	call   80104490 <myproc>
80106547:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010654e:	e8 3d df ff ff       	call   80104490 <myproc>
80106553:	85 c0                	test   %eax,%eax
80106555:	0f 85 28 ff ff ff    	jne    80106483 <trap+0x43>
8010655b:	e9 3d ff ff ff       	jmp    8010649d <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80106560:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106564:	0f 85 4b ff ff ff    	jne    801064b5 <trap+0x75>
    yield();
8010656a:	e8 91 e5 ff ff       	call   80104b00 <yield>
8010656f:	e9 41 ff ff ff       	jmp    801064b5 <trap+0x75>
80106574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106578:	8b 7b 38             	mov    0x38(%ebx),%edi
8010657b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010657f:	e8 ec de ff ff       	call   80104470 <cpuid>
80106584:	57                   	push   %edi
80106585:	56                   	push   %esi
80106586:	50                   	push   %eax
80106587:	68 f4 82 10 80       	push   $0x801082f4
8010658c:	e8 2f a3 ff ff       	call   801008c0 <cprintf>
    lapiceoi();
80106591:	e8 8a ce ff ff       	call   80103420 <lapiceoi>
    break;
80106596:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106599:	e8 f2 de ff ff       	call   80104490 <myproc>
8010659e:	85 c0                	test   %eax,%eax
801065a0:	0f 85 dd fe ff ff    	jne    80106483 <trap+0x43>
801065a6:	e9 f2 fe ff ff       	jmp    8010649d <trap+0x5d>
801065ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801065b0:	e8 db de ff ff       	call   80104490 <myproc>
801065b5:	8b 70 24             	mov    0x24(%eax),%esi
801065b8:	85 f6                	test   %esi,%esi
801065ba:	0f 85 c8 00 00 00    	jne    80106688 <trap+0x248>
    myproc()->tf = tf;
801065c0:	e8 cb de ff ff       	call   80104490 <myproc>
801065c5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801065c8:	e8 f3 ef ff ff       	call   801055c0 <syscall>
    if(myproc()->killed)
801065cd:	e8 be de ff ff       	call   80104490 <myproc>
801065d2:	8b 48 24             	mov    0x24(%eax),%ecx
801065d5:	85 c9                	test   %ecx,%ecx
801065d7:	0f 84 fb fe ff ff    	je     801064d8 <trap+0x98>
}
801065dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065e0:	5b                   	pop    %ebx
801065e1:	5e                   	pop    %esi
801065e2:	5f                   	pop    %edi
801065e3:	5d                   	pop    %ebp
      exit();
801065e4:	e9 b7 e2 ff ff       	jmp    801048a0 <exit>
801065e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801065f0:	e8 4b 02 00 00       	call   80106840 <uartintr>
    lapiceoi();
801065f5:	e8 26 ce ff ff       	call   80103420 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065fa:	e8 91 de ff ff       	call   80104490 <myproc>
801065ff:	85 c0                	test   %eax,%eax
80106601:	0f 85 7c fe ff ff    	jne    80106483 <trap+0x43>
80106607:	e9 91 fe ff ff       	jmp    8010649d <trap+0x5d>
8010660c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106610:	e8 db cc ff ff       	call   801032f0 <kbdintr>
    lapiceoi();
80106615:	e8 06 ce ff ff       	call   80103420 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010661a:	e8 71 de ff ff       	call   80104490 <myproc>
8010661f:	85 c0                	test   %eax,%eax
80106621:	0f 85 5c fe ff ff    	jne    80106483 <trap+0x43>
80106627:	e9 71 fe ff ff       	jmp    8010649d <trap+0x5d>
8010662c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106630:	e8 3b de ff ff       	call   80104470 <cpuid>
80106635:	85 c0                	test   %eax,%eax
80106637:	0f 85 38 fe ff ff    	jne    80106475 <trap+0x35>
      acquire(&tickslock);
8010663d:	83 ec 0c             	sub    $0xc,%esp
80106640:	68 80 4c 11 80       	push   $0x80114c80
80106645:	e8 86 ea ff ff       	call   801050d0 <acquire>
      ticks++;
8010664a:	83 05 60 4c 11 80 01 	addl   $0x1,0x80114c60
      wakeup(&ticks);
80106651:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80106658:	e8 b3 e5 ff ff       	call   80104c10 <wakeup>
      release(&tickslock);
8010665d:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80106664:	e8 07 ea ff ff       	call   80105070 <release>
80106669:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010666c:	e9 04 fe ff ff       	jmp    80106475 <trap+0x35>
80106671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106678:	e8 23 e2 ff ff       	call   801048a0 <exit>
8010667d:	e9 1b fe ff ff       	jmp    8010649d <trap+0x5d>
80106682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106688:	e8 13 e2 ff ff       	call   801048a0 <exit>
8010668d:	e9 2e ff ff ff       	jmp    801065c0 <trap+0x180>
80106692:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106695:	e8 d6 dd ff ff       	call   80104470 <cpuid>
8010669a:	83 ec 0c             	sub    $0xc,%esp
8010669d:	56                   	push   %esi
8010669e:	57                   	push   %edi
8010669f:	50                   	push   %eax
801066a0:	ff 73 30             	push   0x30(%ebx)
801066a3:	68 18 83 10 80       	push   $0x80108318
801066a8:	e8 13 a2 ff ff       	call   801008c0 <cprintf>
      panic("trap");
801066ad:	83 c4 14             	add    $0x14,%esp
801066b0:	68 95 80 10 80       	push   $0x80108095
801066b5:	e8 56 a4 ff ff       	call   80100b10 <panic>
801066ba:	66 90                	xchg   %ax,%ax
801066bc:	66 90                	xchg   %ax,%ax
801066be:	66 90                	xchg   %ax,%ax

801066c0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801066c0:	a1 c0 54 11 80       	mov    0x801154c0,%eax
801066c5:	85 c0                	test   %eax,%eax
801066c7:	74 17                	je     801066e0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801066c9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801066ce:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801066cf:	a8 01                	test   $0x1,%al
801066d1:	74 0d                	je     801066e0 <uartgetc+0x20>
801066d3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801066d8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801066d9:	0f b6 c0             	movzbl %al,%eax
801066dc:	c3                   	ret
801066dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801066e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801066e5:	c3                   	ret
801066e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801066ed:	00 
801066ee:	66 90                	xchg   %ax,%ax

801066f0 <uartinit>:
{
801066f0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801066f1:	31 c9                	xor    %ecx,%ecx
801066f3:	89 c8                	mov    %ecx,%eax
801066f5:	89 e5                	mov    %esp,%ebp
801066f7:	57                   	push   %edi
801066f8:	bf fa 03 00 00       	mov    $0x3fa,%edi
801066fd:	56                   	push   %esi
801066fe:	89 fa                	mov    %edi,%edx
80106700:	53                   	push   %ebx
80106701:	83 ec 1c             	sub    $0x1c,%esp
80106704:	ee                   	out    %al,(%dx)
80106705:	be fb 03 00 00       	mov    $0x3fb,%esi
8010670a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010670f:	89 f2                	mov    %esi,%edx
80106711:	ee                   	out    %al,(%dx)
80106712:	b8 0c 00 00 00       	mov    $0xc,%eax
80106717:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010671c:	ee                   	out    %al,(%dx)
8010671d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106722:	89 c8                	mov    %ecx,%eax
80106724:	89 da                	mov    %ebx,%edx
80106726:	ee                   	out    %al,(%dx)
80106727:	b8 03 00 00 00       	mov    $0x3,%eax
8010672c:	89 f2                	mov    %esi,%edx
8010672e:	ee                   	out    %al,(%dx)
8010672f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106734:	89 c8                	mov    %ecx,%eax
80106736:	ee                   	out    %al,(%dx)
80106737:	b8 01 00 00 00       	mov    $0x1,%eax
8010673c:	89 da                	mov    %ebx,%edx
8010673e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010673f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106744:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106745:	3c ff                	cmp    $0xff,%al
80106747:	0f 84 7c 00 00 00    	je     801067c9 <uartinit+0xd9>
  uart = 1;
8010674d:	c7 05 c0 54 11 80 01 	movl   $0x1,0x801154c0
80106754:	00 00 00 
80106757:	89 fa                	mov    %edi,%edx
80106759:	ec                   	in     (%dx),%al
8010675a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010675f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106760:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106763:	bf 9a 80 10 80       	mov    $0x8010809a,%edi
80106768:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
8010676d:	6a 00                	push   $0x0
8010676f:	6a 04                	push   $0x4
80106771:	e8 1a c8 ff ff       	call   80102f90 <ioapicenable>
80106776:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106779:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
8010677d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80106780:	a1 c0 54 11 80       	mov    0x801154c0,%eax
80106785:	85 c0                	test   %eax,%eax
80106787:	74 32                	je     801067bb <uartinit+0xcb>
80106789:	89 f2                	mov    %esi,%edx
8010678b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010678c:	a8 20                	test   $0x20,%al
8010678e:	75 21                	jne    801067b1 <uartinit+0xc1>
80106790:	bb 80 00 00 00       	mov    $0x80,%ebx
80106795:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80106798:	83 ec 0c             	sub    $0xc,%esp
8010679b:	6a 0a                	push   $0xa
8010679d:	e8 9e cc ff ff       	call   80103440 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801067a2:	83 c4 10             	add    $0x10,%esp
801067a5:	83 eb 01             	sub    $0x1,%ebx
801067a8:	74 07                	je     801067b1 <uartinit+0xc1>
801067aa:	89 f2                	mov    %esi,%edx
801067ac:	ec                   	in     (%dx),%al
801067ad:	a8 20                	test   $0x20,%al
801067af:	74 e7                	je     80106798 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801067b1:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067b6:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801067ba:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
801067bb:	0f b6 47 01          	movzbl 0x1(%edi),%eax
801067bf:	83 c7 01             	add    $0x1,%edi
801067c2:	88 45 e7             	mov    %al,-0x19(%ebp)
801067c5:	84 c0                	test   %al,%al
801067c7:	75 b7                	jne    80106780 <uartinit+0x90>
}
801067c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067cc:	5b                   	pop    %ebx
801067cd:	5e                   	pop    %esi
801067ce:	5f                   	pop    %edi
801067cf:	5d                   	pop    %ebp
801067d0:	c3                   	ret
801067d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801067d8:	00 
801067d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801067e0 <uartputc>:
  if(!uart)
801067e0:	a1 c0 54 11 80       	mov    0x801154c0,%eax
801067e5:	85 c0                	test   %eax,%eax
801067e7:	74 4f                	je     80106838 <uartputc+0x58>
{
801067e9:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801067ea:	ba fd 03 00 00       	mov    $0x3fd,%edx
801067ef:	89 e5                	mov    %esp,%ebp
801067f1:	56                   	push   %esi
801067f2:	53                   	push   %ebx
801067f3:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801067f4:	a8 20                	test   $0x20,%al
801067f6:	75 29                	jne    80106821 <uartputc+0x41>
801067f8:	bb 80 00 00 00       	mov    $0x80,%ebx
801067fd:	be fd 03 00 00       	mov    $0x3fd,%esi
80106802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106808:	83 ec 0c             	sub    $0xc,%esp
8010680b:	6a 0a                	push   $0xa
8010680d:	e8 2e cc ff ff       	call   80103440 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106812:	83 c4 10             	add    $0x10,%esp
80106815:	83 eb 01             	sub    $0x1,%ebx
80106818:	74 07                	je     80106821 <uartputc+0x41>
8010681a:	89 f2                	mov    %esi,%edx
8010681c:	ec                   	in     (%dx),%al
8010681d:	a8 20                	test   $0x20,%al
8010681f:	74 e7                	je     80106808 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106821:	8b 45 08             	mov    0x8(%ebp),%eax
80106824:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106829:	ee                   	out    %al,(%dx)
}
8010682a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010682d:	5b                   	pop    %ebx
8010682e:	5e                   	pop    %esi
8010682f:	5d                   	pop    %ebp
80106830:	c3                   	ret
80106831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106838:	c3                   	ret
80106839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106840 <uartintr>:

void
uartintr(void)
{
80106840:	55                   	push   %ebp
80106841:	89 e5                	mov    %esp,%ebp
80106843:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106846:	68 c0 66 10 80       	push   $0x801066c0
8010684b:	e8 e0 a4 ff ff       	call   80100d30 <consoleintr>
}
80106850:	83 c4 10             	add    $0x10,%esp
80106853:	c9                   	leave
80106854:	c3                   	ret

80106855 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106855:	6a 00                	push   $0x0
  pushl $0
80106857:	6a 00                	push   $0x0
  jmp alltraps
80106859:	e9 0c fb ff ff       	jmp    8010636a <alltraps>

8010685e <vector1>:
.globl vector1
vector1:
  pushl $0
8010685e:	6a 00                	push   $0x0
  pushl $1
80106860:	6a 01                	push   $0x1
  jmp alltraps
80106862:	e9 03 fb ff ff       	jmp    8010636a <alltraps>

80106867 <vector2>:
.globl vector2
vector2:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $2
80106869:	6a 02                	push   $0x2
  jmp alltraps
8010686b:	e9 fa fa ff ff       	jmp    8010636a <alltraps>

80106870 <vector3>:
.globl vector3
vector3:
  pushl $0
80106870:	6a 00                	push   $0x0
  pushl $3
80106872:	6a 03                	push   $0x3
  jmp alltraps
80106874:	e9 f1 fa ff ff       	jmp    8010636a <alltraps>

80106879 <vector4>:
.globl vector4
vector4:
  pushl $0
80106879:	6a 00                	push   $0x0
  pushl $4
8010687b:	6a 04                	push   $0x4
  jmp alltraps
8010687d:	e9 e8 fa ff ff       	jmp    8010636a <alltraps>

80106882 <vector5>:
.globl vector5
vector5:
  pushl $0
80106882:	6a 00                	push   $0x0
  pushl $5
80106884:	6a 05                	push   $0x5
  jmp alltraps
80106886:	e9 df fa ff ff       	jmp    8010636a <alltraps>

8010688b <vector6>:
.globl vector6
vector6:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $6
8010688d:	6a 06                	push   $0x6
  jmp alltraps
8010688f:	e9 d6 fa ff ff       	jmp    8010636a <alltraps>

80106894 <vector7>:
.globl vector7
vector7:
  pushl $0
80106894:	6a 00                	push   $0x0
  pushl $7
80106896:	6a 07                	push   $0x7
  jmp alltraps
80106898:	e9 cd fa ff ff       	jmp    8010636a <alltraps>

8010689d <vector8>:
.globl vector8
vector8:
  pushl $8
8010689d:	6a 08                	push   $0x8
  jmp alltraps
8010689f:	e9 c6 fa ff ff       	jmp    8010636a <alltraps>

801068a4 <vector9>:
.globl vector9
vector9:
  pushl $0
801068a4:	6a 00                	push   $0x0
  pushl $9
801068a6:	6a 09                	push   $0x9
  jmp alltraps
801068a8:	e9 bd fa ff ff       	jmp    8010636a <alltraps>

801068ad <vector10>:
.globl vector10
vector10:
  pushl $10
801068ad:	6a 0a                	push   $0xa
  jmp alltraps
801068af:	e9 b6 fa ff ff       	jmp    8010636a <alltraps>

801068b4 <vector11>:
.globl vector11
vector11:
  pushl $11
801068b4:	6a 0b                	push   $0xb
  jmp alltraps
801068b6:	e9 af fa ff ff       	jmp    8010636a <alltraps>

801068bb <vector12>:
.globl vector12
vector12:
  pushl $12
801068bb:	6a 0c                	push   $0xc
  jmp alltraps
801068bd:	e9 a8 fa ff ff       	jmp    8010636a <alltraps>

801068c2 <vector13>:
.globl vector13
vector13:
  pushl $13
801068c2:	6a 0d                	push   $0xd
  jmp alltraps
801068c4:	e9 a1 fa ff ff       	jmp    8010636a <alltraps>

801068c9 <vector14>:
.globl vector14
vector14:
  pushl $14
801068c9:	6a 0e                	push   $0xe
  jmp alltraps
801068cb:	e9 9a fa ff ff       	jmp    8010636a <alltraps>

801068d0 <vector15>:
.globl vector15
vector15:
  pushl $0
801068d0:	6a 00                	push   $0x0
  pushl $15
801068d2:	6a 0f                	push   $0xf
  jmp alltraps
801068d4:	e9 91 fa ff ff       	jmp    8010636a <alltraps>

801068d9 <vector16>:
.globl vector16
vector16:
  pushl $0
801068d9:	6a 00                	push   $0x0
  pushl $16
801068db:	6a 10                	push   $0x10
  jmp alltraps
801068dd:	e9 88 fa ff ff       	jmp    8010636a <alltraps>

801068e2 <vector17>:
.globl vector17
vector17:
  pushl $17
801068e2:	6a 11                	push   $0x11
  jmp alltraps
801068e4:	e9 81 fa ff ff       	jmp    8010636a <alltraps>

801068e9 <vector18>:
.globl vector18
vector18:
  pushl $0
801068e9:	6a 00                	push   $0x0
  pushl $18
801068eb:	6a 12                	push   $0x12
  jmp alltraps
801068ed:	e9 78 fa ff ff       	jmp    8010636a <alltraps>

801068f2 <vector19>:
.globl vector19
vector19:
  pushl $0
801068f2:	6a 00                	push   $0x0
  pushl $19
801068f4:	6a 13                	push   $0x13
  jmp alltraps
801068f6:	e9 6f fa ff ff       	jmp    8010636a <alltraps>

801068fb <vector20>:
.globl vector20
vector20:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $20
801068fd:	6a 14                	push   $0x14
  jmp alltraps
801068ff:	e9 66 fa ff ff       	jmp    8010636a <alltraps>

80106904 <vector21>:
.globl vector21
vector21:
  pushl $0
80106904:	6a 00                	push   $0x0
  pushl $21
80106906:	6a 15                	push   $0x15
  jmp alltraps
80106908:	e9 5d fa ff ff       	jmp    8010636a <alltraps>

8010690d <vector22>:
.globl vector22
vector22:
  pushl $0
8010690d:	6a 00                	push   $0x0
  pushl $22
8010690f:	6a 16                	push   $0x16
  jmp alltraps
80106911:	e9 54 fa ff ff       	jmp    8010636a <alltraps>

80106916 <vector23>:
.globl vector23
vector23:
  pushl $0
80106916:	6a 00                	push   $0x0
  pushl $23
80106918:	6a 17                	push   $0x17
  jmp alltraps
8010691a:	e9 4b fa ff ff       	jmp    8010636a <alltraps>

8010691f <vector24>:
.globl vector24
vector24:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $24
80106921:	6a 18                	push   $0x18
  jmp alltraps
80106923:	e9 42 fa ff ff       	jmp    8010636a <alltraps>

80106928 <vector25>:
.globl vector25
vector25:
  pushl $0
80106928:	6a 00                	push   $0x0
  pushl $25
8010692a:	6a 19                	push   $0x19
  jmp alltraps
8010692c:	e9 39 fa ff ff       	jmp    8010636a <alltraps>

80106931 <vector26>:
.globl vector26
vector26:
  pushl $0
80106931:	6a 00                	push   $0x0
  pushl $26
80106933:	6a 1a                	push   $0x1a
  jmp alltraps
80106935:	e9 30 fa ff ff       	jmp    8010636a <alltraps>

8010693a <vector27>:
.globl vector27
vector27:
  pushl $0
8010693a:	6a 00                	push   $0x0
  pushl $27
8010693c:	6a 1b                	push   $0x1b
  jmp alltraps
8010693e:	e9 27 fa ff ff       	jmp    8010636a <alltraps>

80106943 <vector28>:
.globl vector28
vector28:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $28
80106945:	6a 1c                	push   $0x1c
  jmp alltraps
80106947:	e9 1e fa ff ff       	jmp    8010636a <alltraps>

8010694c <vector29>:
.globl vector29
vector29:
  pushl $0
8010694c:	6a 00                	push   $0x0
  pushl $29
8010694e:	6a 1d                	push   $0x1d
  jmp alltraps
80106950:	e9 15 fa ff ff       	jmp    8010636a <alltraps>

80106955 <vector30>:
.globl vector30
vector30:
  pushl $0
80106955:	6a 00                	push   $0x0
  pushl $30
80106957:	6a 1e                	push   $0x1e
  jmp alltraps
80106959:	e9 0c fa ff ff       	jmp    8010636a <alltraps>

8010695e <vector31>:
.globl vector31
vector31:
  pushl $0
8010695e:	6a 00                	push   $0x0
  pushl $31
80106960:	6a 1f                	push   $0x1f
  jmp alltraps
80106962:	e9 03 fa ff ff       	jmp    8010636a <alltraps>

80106967 <vector32>:
.globl vector32
vector32:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $32
80106969:	6a 20                	push   $0x20
  jmp alltraps
8010696b:	e9 fa f9 ff ff       	jmp    8010636a <alltraps>

80106970 <vector33>:
.globl vector33
vector33:
  pushl $0
80106970:	6a 00                	push   $0x0
  pushl $33
80106972:	6a 21                	push   $0x21
  jmp alltraps
80106974:	e9 f1 f9 ff ff       	jmp    8010636a <alltraps>

80106979 <vector34>:
.globl vector34
vector34:
  pushl $0
80106979:	6a 00                	push   $0x0
  pushl $34
8010697b:	6a 22                	push   $0x22
  jmp alltraps
8010697d:	e9 e8 f9 ff ff       	jmp    8010636a <alltraps>

80106982 <vector35>:
.globl vector35
vector35:
  pushl $0
80106982:	6a 00                	push   $0x0
  pushl $35
80106984:	6a 23                	push   $0x23
  jmp alltraps
80106986:	e9 df f9 ff ff       	jmp    8010636a <alltraps>

8010698b <vector36>:
.globl vector36
vector36:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $36
8010698d:	6a 24                	push   $0x24
  jmp alltraps
8010698f:	e9 d6 f9 ff ff       	jmp    8010636a <alltraps>

80106994 <vector37>:
.globl vector37
vector37:
  pushl $0
80106994:	6a 00                	push   $0x0
  pushl $37
80106996:	6a 25                	push   $0x25
  jmp alltraps
80106998:	e9 cd f9 ff ff       	jmp    8010636a <alltraps>

8010699d <vector38>:
.globl vector38
vector38:
  pushl $0
8010699d:	6a 00                	push   $0x0
  pushl $38
8010699f:	6a 26                	push   $0x26
  jmp alltraps
801069a1:	e9 c4 f9 ff ff       	jmp    8010636a <alltraps>

801069a6 <vector39>:
.globl vector39
vector39:
  pushl $0
801069a6:	6a 00                	push   $0x0
  pushl $39
801069a8:	6a 27                	push   $0x27
  jmp alltraps
801069aa:	e9 bb f9 ff ff       	jmp    8010636a <alltraps>

801069af <vector40>:
.globl vector40
vector40:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $40
801069b1:	6a 28                	push   $0x28
  jmp alltraps
801069b3:	e9 b2 f9 ff ff       	jmp    8010636a <alltraps>

801069b8 <vector41>:
.globl vector41
vector41:
  pushl $0
801069b8:	6a 00                	push   $0x0
  pushl $41
801069ba:	6a 29                	push   $0x29
  jmp alltraps
801069bc:	e9 a9 f9 ff ff       	jmp    8010636a <alltraps>

801069c1 <vector42>:
.globl vector42
vector42:
  pushl $0
801069c1:	6a 00                	push   $0x0
  pushl $42
801069c3:	6a 2a                	push   $0x2a
  jmp alltraps
801069c5:	e9 a0 f9 ff ff       	jmp    8010636a <alltraps>

801069ca <vector43>:
.globl vector43
vector43:
  pushl $0
801069ca:	6a 00                	push   $0x0
  pushl $43
801069cc:	6a 2b                	push   $0x2b
  jmp alltraps
801069ce:	e9 97 f9 ff ff       	jmp    8010636a <alltraps>

801069d3 <vector44>:
.globl vector44
vector44:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $44
801069d5:	6a 2c                	push   $0x2c
  jmp alltraps
801069d7:	e9 8e f9 ff ff       	jmp    8010636a <alltraps>

801069dc <vector45>:
.globl vector45
vector45:
  pushl $0
801069dc:	6a 00                	push   $0x0
  pushl $45
801069de:	6a 2d                	push   $0x2d
  jmp alltraps
801069e0:	e9 85 f9 ff ff       	jmp    8010636a <alltraps>

801069e5 <vector46>:
.globl vector46
vector46:
  pushl $0
801069e5:	6a 00                	push   $0x0
  pushl $46
801069e7:	6a 2e                	push   $0x2e
  jmp alltraps
801069e9:	e9 7c f9 ff ff       	jmp    8010636a <alltraps>

801069ee <vector47>:
.globl vector47
vector47:
  pushl $0
801069ee:	6a 00                	push   $0x0
  pushl $47
801069f0:	6a 2f                	push   $0x2f
  jmp alltraps
801069f2:	e9 73 f9 ff ff       	jmp    8010636a <alltraps>

801069f7 <vector48>:
.globl vector48
vector48:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $48
801069f9:	6a 30                	push   $0x30
  jmp alltraps
801069fb:	e9 6a f9 ff ff       	jmp    8010636a <alltraps>

80106a00 <vector49>:
.globl vector49
vector49:
  pushl $0
80106a00:	6a 00                	push   $0x0
  pushl $49
80106a02:	6a 31                	push   $0x31
  jmp alltraps
80106a04:	e9 61 f9 ff ff       	jmp    8010636a <alltraps>

80106a09 <vector50>:
.globl vector50
vector50:
  pushl $0
80106a09:	6a 00                	push   $0x0
  pushl $50
80106a0b:	6a 32                	push   $0x32
  jmp alltraps
80106a0d:	e9 58 f9 ff ff       	jmp    8010636a <alltraps>

80106a12 <vector51>:
.globl vector51
vector51:
  pushl $0
80106a12:	6a 00                	push   $0x0
  pushl $51
80106a14:	6a 33                	push   $0x33
  jmp alltraps
80106a16:	e9 4f f9 ff ff       	jmp    8010636a <alltraps>

80106a1b <vector52>:
.globl vector52
vector52:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $52
80106a1d:	6a 34                	push   $0x34
  jmp alltraps
80106a1f:	e9 46 f9 ff ff       	jmp    8010636a <alltraps>

80106a24 <vector53>:
.globl vector53
vector53:
  pushl $0
80106a24:	6a 00                	push   $0x0
  pushl $53
80106a26:	6a 35                	push   $0x35
  jmp alltraps
80106a28:	e9 3d f9 ff ff       	jmp    8010636a <alltraps>

80106a2d <vector54>:
.globl vector54
vector54:
  pushl $0
80106a2d:	6a 00                	push   $0x0
  pushl $54
80106a2f:	6a 36                	push   $0x36
  jmp alltraps
80106a31:	e9 34 f9 ff ff       	jmp    8010636a <alltraps>

80106a36 <vector55>:
.globl vector55
vector55:
  pushl $0
80106a36:	6a 00                	push   $0x0
  pushl $55
80106a38:	6a 37                	push   $0x37
  jmp alltraps
80106a3a:	e9 2b f9 ff ff       	jmp    8010636a <alltraps>

80106a3f <vector56>:
.globl vector56
vector56:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $56
80106a41:	6a 38                	push   $0x38
  jmp alltraps
80106a43:	e9 22 f9 ff ff       	jmp    8010636a <alltraps>

80106a48 <vector57>:
.globl vector57
vector57:
  pushl $0
80106a48:	6a 00                	push   $0x0
  pushl $57
80106a4a:	6a 39                	push   $0x39
  jmp alltraps
80106a4c:	e9 19 f9 ff ff       	jmp    8010636a <alltraps>

80106a51 <vector58>:
.globl vector58
vector58:
  pushl $0
80106a51:	6a 00                	push   $0x0
  pushl $58
80106a53:	6a 3a                	push   $0x3a
  jmp alltraps
80106a55:	e9 10 f9 ff ff       	jmp    8010636a <alltraps>

80106a5a <vector59>:
.globl vector59
vector59:
  pushl $0
80106a5a:	6a 00                	push   $0x0
  pushl $59
80106a5c:	6a 3b                	push   $0x3b
  jmp alltraps
80106a5e:	e9 07 f9 ff ff       	jmp    8010636a <alltraps>

80106a63 <vector60>:
.globl vector60
vector60:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $60
80106a65:	6a 3c                	push   $0x3c
  jmp alltraps
80106a67:	e9 fe f8 ff ff       	jmp    8010636a <alltraps>

80106a6c <vector61>:
.globl vector61
vector61:
  pushl $0
80106a6c:	6a 00                	push   $0x0
  pushl $61
80106a6e:	6a 3d                	push   $0x3d
  jmp alltraps
80106a70:	e9 f5 f8 ff ff       	jmp    8010636a <alltraps>

80106a75 <vector62>:
.globl vector62
vector62:
  pushl $0
80106a75:	6a 00                	push   $0x0
  pushl $62
80106a77:	6a 3e                	push   $0x3e
  jmp alltraps
80106a79:	e9 ec f8 ff ff       	jmp    8010636a <alltraps>

80106a7e <vector63>:
.globl vector63
vector63:
  pushl $0
80106a7e:	6a 00                	push   $0x0
  pushl $63
80106a80:	6a 3f                	push   $0x3f
  jmp alltraps
80106a82:	e9 e3 f8 ff ff       	jmp    8010636a <alltraps>

80106a87 <vector64>:
.globl vector64
vector64:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $64
80106a89:	6a 40                	push   $0x40
  jmp alltraps
80106a8b:	e9 da f8 ff ff       	jmp    8010636a <alltraps>

80106a90 <vector65>:
.globl vector65
vector65:
  pushl $0
80106a90:	6a 00                	push   $0x0
  pushl $65
80106a92:	6a 41                	push   $0x41
  jmp alltraps
80106a94:	e9 d1 f8 ff ff       	jmp    8010636a <alltraps>

80106a99 <vector66>:
.globl vector66
vector66:
  pushl $0
80106a99:	6a 00                	push   $0x0
  pushl $66
80106a9b:	6a 42                	push   $0x42
  jmp alltraps
80106a9d:	e9 c8 f8 ff ff       	jmp    8010636a <alltraps>

80106aa2 <vector67>:
.globl vector67
vector67:
  pushl $0
80106aa2:	6a 00                	push   $0x0
  pushl $67
80106aa4:	6a 43                	push   $0x43
  jmp alltraps
80106aa6:	e9 bf f8 ff ff       	jmp    8010636a <alltraps>

80106aab <vector68>:
.globl vector68
vector68:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $68
80106aad:	6a 44                	push   $0x44
  jmp alltraps
80106aaf:	e9 b6 f8 ff ff       	jmp    8010636a <alltraps>

80106ab4 <vector69>:
.globl vector69
vector69:
  pushl $0
80106ab4:	6a 00                	push   $0x0
  pushl $69
80106ab6:	6a 45                	push   $0x45
  jmp alltraps
80106ab8:	e9 ad f8 ff ff       	jmp    8010636a <alltraps>

80106abd <vector70>:
.globl vector70
vector70:
  pushl $0
80106abd:	6a 00                	push   $0x0
  pushl $70
80106abf:	6a 46                	push   $0x46
  jmp alltraps
80106ac1:	e9 a4 f8 ff ff       	jmp    8010636a <alltraps>

80106ac6 <vector71>:
.globl vector71
vector71:
  pushl $0
80106ac6:	6a 00                	push   $0x0
  pushl $71
80106ac8:	6a 47                	push   $0x47
  jmp alltraps
80106aca:	e9 9b f8 ff ff       	jmp    8010636a <alltraps>

80106acf <vector72>:
.globl vector72
vector72:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $72
80106ad1:	6a 48                	push   $0x48
  jmp alltraps
80106ad3:	e9 92 f8 ff ff       	jmp    8010636a <alltraps>

80106ad8 <vector73>:
.globl vector73
vector73:
  pushl $0
80106ad8:	6a 00                	push   $0x0
  pushl $73
80106ada:	6a 49                	push   $0x49
  jmp alltraps
80106adc:	e9 89 f8 ff ff       	jmp    8010636a <alltraps>

80106ae1 <vector74>:
.globl vector74
vector74:
  pushl $0
80106ae1:	6a 00                	push   $0x0
  pushl $74
80106ae3:	6a 4a                	push   $0x4a
  jmp alltraps
80106ae5:	e9 80 f8 ff ff       	jmp    8010636a <alltraps>

80106aea <vector75>:
.globl vector75
vector75:
  pushl $0
80106aea:	6a 00                	push   $0x0
  pushl $75
80106aec:	6a 4b                	push   $0x4b
  jmp alltraps
80106aee:	e9 77 f8 ff ff       	jmp    8010636a <alltraps>

80106af3 <vector76>:
.globl vector76
vector76:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $76
80106af5:	6a 4c                	push   $0x4c
  jmp alltraps
80106af7:	e9 6e f8 ff ff       	jmp    8010636a <alltraps>

80106afc <vector77>:
.globl vector77
vector77:
  pushl $0
80106afc:	6a 00                	push   $0x0
  pushl $77
80106afe:	6a 4d                	push   $0x4d
  jmp alltraps
80106b00:	e9 65 f8 ff ff       	jmp    8010636a <alltraps>

80106b05 <vector78>:
.globl vector78
vector78:
  pushl $0
80106b05:	6a 00                	push   $0x0
  pushl $78
80106b07:	6a 4e                	push   $0x4e
  jmp alltraps
80106b09:	e9 5c f8 ff ff       	jmp    8010636a <alltraps>

80106b0e <vector79>:
.globl vector79
vector79:
  pushl $0
80106b0e:	6a 00                	push   $0x0
  pushl $79
80106b10:	6a 4f                	push   $0x4f
  jmp alltraps
80106b12:	e9 53 f8 ff ff       	jmp    8010636a <alltraps>

80106b17 <vector80>:
.globl vector80
vector80:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $80
80106b19:	6a 50                	push   $0x50
  jmp alltraps
80106b1b:	e9 4a f8 ff ff       	jmp    8010636a <alltraps>

80106b20 <vector81>:
.globl vector81
vector81:
  pushl $0
80106b20:	6a 00                	push   $0x0
  pushl $81
80106b22:	6a 51                	push   $0x51
  jmp alltraps
80106b24:	e9 41 f8 ff ff       	jmp    8010636a <alltraps>

80106b29 <vector82>:
.globl vector82
vector82:
  pushl $0
80106b29:	6a 00                	push   $0x0
  pushl $82
80106b2b:	6a 52                	push   $0x52
  jmp alltraps
80106b2d:	e9 38 f8 ff ff       	jmp    8010636a <alltraps>

80106b32 <vector83>:
.globl vector83
vector83:
  pushl $0
80106b32:	6a 00                	push   $0x0
  pushl $83
80106b34:	6a 53                	push   $0x53
  jmp alltraps
80106b36:	e9 2f f8 ff ff       	jmp    8010636a <alltraps>

80106b3b <vector84>:
.globl vector84
vector84:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $84
80106b3d:	6a 54                	push   $0x54
  jmp alltraps
80106b3f:	e9 26 f8 ff ff       	jmp    8010636a <alltraps>

80106b44 <vector85>:
.globl vector85
vector85:
  pushl $0
80106b44:	6a 00                	push   $0x0
  pushl $85
80106b46:	6a 55                	push   $0x55
  jmp alltraps
80106b48:	e9 1d f8 ff ff       	jmp    8010636a <alltraps>

80106b4d <vector86>:
.globl vector86
vector86:
  pushl $0
80106b4d:	6a 00                	push   $0x0
  pushl $86
80106b4f:	6a 56                	push   $0x56
  jmp alltraps
80106b51:	e9 14 f8 ff ff       	jmp    8010636a <alltraps>

80106b56 <vector87>:
.globl vector87
vector87:
  pushl $0
80106b56:	6a 00                	push   $0x0
  pushl $87
80106b58:	6a 57                	push   $0x57
  jmp alltraps
80106b5a:	e9 0b f8 ff ff       	jmp    8010636a <alltraps>

80106b5f <vector88>:
.globl vector88
vector88:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $88
80106b61:	6a 58                	push   $0x58
  jmp alltraps
80106b63:	e9 02 f8 ff ff       	jmp    8010636a <alltraps>

80106b68 <vector89>:
.globl vector89
vector89:
  pushl $0
80106b68:	6a 00                	push   $0x0
  pushl $89
80106b6a:	6a 59                	push   $0x59
  jmp alltraps
80106b6c:	e9 f9 f7 ff ff       	jmp    8010636a <alltraps>

80106b71 <vector90>:
.globl vector90
vector90:
  pushl $0
80106b71:	6a 00                	push   $0x0
  pushl $90
80106b73:	6a 5a                	push   $0x5a
  jmp alltraps
80106b75:	e9 f0 f7 ff ff       	jmp    8010636a <alltraps>

80106b7a <vector91>:
.globl vector91
vector91:
  pushl $0
80106b7a:	6a 00                	push   $0x0
  pushl $91
80106b7c:	6a 5b                	push   $0x5b
  jmp alltraps
80106b7e:	e9 e7 f7 ff ff       	jmp    8010636a <alltraps>

80106b83 <vector92>:
.globl vector92
vector92:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $92
80106b85:	6a 5c                	push   $0x5c
  jmp alltraps
80106b87:	e9 de f7 ff ff       	jmp    8010636a <alltraps>

80106b8c <vector93>:
.globl vector93
vector93:
  pushl $0
80106b8c:	6a 00                	push   $0x0
  pushl $93
80106b8e:	6a 5d                	push   $0x5d
  jmp alltraps
80106b90:	e9 d5 f7 ff ff       	jmp    8010636a <alltraps>

80106b95 <vector94>:
.globl vector94
vector94:
  pushl $0
80106b95:	6a 00                	push   $0x0
  pushl $94
80106b97:	6a 5e                	push   $0x5e
  jmp alltraps
80106b99:	e9 cc f7 ff ff       	jmp    8010636a <alltraps>

80106b9e <vector95>:
.globl vector95
vector95:
  pushl $0
80106b9e:	6a 00                	push   $0x0
  pushl $95
80106ba0:	6a 5f                	push   $0x5f
  jmp alltraps
80106ba2:	e9 c3 f7 ff ff       	jmp    8010636a <alltraps>

80106ba7 <vector96>:
.globl vector96
vector96:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $96
80106ba9:	6a 60                	push   $0x60
  jmp alltraps
80106bab:	e9 ba f7 ff ff       	jmp    8010636a <alltraps>

80106bb0 <vector97>:
.globl vector97
vector97:
  pushl $0
80106bb0:	6a 00                	push   $0x0
  pushl $97
80106bb2:	6a 61                	push   $0x61
  jmp alltraps
80106bb4:	e9 b1 f7 ff ff       	jmp    8010636a <alltraps>

80106bb9 <vector98>:
.globl vector98
vector98:
  pushl $0
80106bb9:	6a 00                	push   $0x0
  pushl $98
80106bbb:	6a 62                	push   $0x62
  jmp alltraps
80106bbd:	e9 a8 f7 ff ff       	jmp    8010636a <alltraps>

80106bc2 <vector99>:
.globl vector99
vector99:
  pushl $0
80106bc2:	6a 00                	push   $0x0
  pushl $99
80106bc4:	6a 63                	push   $0x63
  jmp alltraps
80106bc6:	e9 9f f7 ff ff       	jmp    8010636a <alltraps>

80106bcb <vector100>:
.globl vector100
vector100:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $100
80106bcd:	6a 64                	push   $0x64
  jmp alltraps
80106bcf:	e9 96 f7 ff ff       	jmp    8010636a <alltraps>

80106bd4 <vector101>:
.globl vector101
vector101:
  pushl $0
80106bd4:	6a 00                	push   $0x0
  pushl $101
80106bd6:	6a 65                	push   $0x65
  jmp alltraps
80106bd8:	e9 8d f7 ff ff       	jmp    8010636a <alltraps>

80106bdd <vector102>:
.globl vector102
vector102:
  pushl $0
80106bdd:	6a 00                	push   $0x0
  pushl $102
80106bdf:	6a 66                	push   $0x66
  jmp alltraps
80106be1:	e9 84 f7 ff ff       	jmp    8010636a <alltraps>

80106be6 <vector103>:
.globl vector103
vector103:
  pushl $0
80106be6:	6a 00                	push   $0x0
  pushl $103
80106be8:	6a 67                	push   $0x67
  jmp alltraps
80106bea:	e9 7b f7 ff ff       	jmp    8010636a <alltraps>

80106bef <vector104>:
.globl vector104
vector104:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $104
80106bf1:	6a 68                	push   $0x68
  jmp alltraps
80106bf3:	e9 72 f7 ff ff       	jmp    8010636a <alltraps>

80106bf8 <vector105>:
.globl vector105
vector105:
  pushl $0
80106bf8:	6a 00                	push   $0x0
  pushl $105
80106bfa:	6a 69                	push   $0x69
  jmp alltraps
80106bfc:	e9 69 f7 ff ff       	jmp    8010636a <alltraps>

80106c01 <vector106>:
.globl vector106
vector106:
  pushl $0
80106c01:	6a 00                	push   $0x0
  pushl $106
80106c03:	6a 6a                	push   $0x6a
  jmp alltraps
80106c05:	e9 60 f7 ff ff       	jmp    8010636a <alltraps>

80106c0a <vector107>:
.globl vector107
vector107:
  pushl $0
80106c0a:	6a 00                	push   $0x0
  pushl $107
80106c0c:	6a 6b                	push   $0x6b
  jmp alltraps
80106c0e:	e9 57 f7 ff ff       	jmp    8010636a <alltraps>

80106c13 <vector108>:
.globl vector108
vector108:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $108
80106c15:	6a 6c                	push   $0x6c
  jmp alltraps
80106c17:	e9 4e f7 ff ff       	jmp    8010636a <alltraps>

80106c1c <vector109>:
.globl vector109
vector109:
  pushl $0
80106c1c:	6a 00                	push   $0x0
  pushl $109
80106c1e:	6a 6d                	push   $0x6d
  jmp alltraps
80106c20:	e9 45 f7 ff ff       	jmp    8010636a <alltraps>

80106c25 <vector110>:
.globl vector110
vector110:
  pushl $0
80106c25:	6a 00                	push   $0x0
  pushl $110
80106c27:	6a 6e                	push   $0x6e
  jmp alltraps
80106c29:	e9 3c f7 ff ff       	jmp    8010636a <alltraps>

80106c2e <vector111>:
.globl vector111
vector111:
  pushl $0
80106c2e:	6a 00                	push   $0x0
  pushl $111
80106c30:	6a 6f                	push   $0x6f
  jmp alltraps
80106c32:	e9 33 f7 ff ff       	jmp    8010636a <alltraps>

80106c37 <vector112>:
.globl vector112
vector112:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $112
80106c39:	6a 70                	push   $0x70
  jmp alltraps
80106c3b:	e9 2a f7 ff ff       	jmp    8010636a <alltraps>

80106c40 <vector113>:
.globl vector113
vector113:
  pushl $0
80106c40:	6a 00                	push   $0x0
  pushl $113
80106c42:	6a 71                	push   $0x71
  jmp alltraps
80106c44:	e9 21 f7 ff ff       	jmp    8010636a <alltraps>

80106c49 <vector114>:
.globl vector114
vector114:
  pushl $0
80106c49:	6a 00                	push   $0x0
  pushl $114
80106c4b:	6a 72                	push   $0x72
  jmp alltraps
80106c4d:	e9 18 f7 ff ff       	jmp    8010636a <alltraps>

80106c52 <vector115>:
.globl vector115
vector115:
  pushl $0
80106c52:	6a 00                	push   $0x0
  pushl $115
80106c54:	6a 73                	push   $0x73
  jmp alltraps
80106c56:	e9 0f f7 ff ff       	jmp    8010636a <alltraps>

80106c5b <vector116>:
.globl vector116
vector116:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $116
80106c5d:	6a 74                	push   $0x74
  jmp alltraps
80106c5f:	e9 06 f7 ff ff       	jmp    8010636a <alltraps>

80106c64 <vector117>:
.globl vector117
vector117:
  pushl $0
80106c64:	6a 00                	push   $0x0
  pushl $117
80106c66:	6a 75                	push   $0x75
  jmp alltraps
80106c68:	e9 fd f6 ff ff       	jmp    8010636a <alltraps>

80106c6d <vector118>:
.globl vector118
vector118:
  pushl $0
80106c6d:	6a 00                	push   $0x0
  pushl $118
80106c6f:	6a 76                	push   $0x76
  jmp alltraps
80106c71:	e9 f4 f6 ff ff       	jmp    8010636a <alltraps>

80106c76 <vector119>:
.globl vector119
vector119:
  pushl $0
80106c76:	6a 00                	push   $0x0
  pushl $119
80106c78:	6a 77                	push   $0x77
  jmp alltraps
80106c7a:	e9 eb f6 ff ff       	jmp    8010636a <alltraps>

80106c7f <vector120>:
.globl vector120
vector120:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $120
80106c81:	6a 78                	push   $0x78
  jmp alltraps
80106c83:	e9 e2 f6 ff ff       	jmp    8010636a <alltraps>

80106c88 <vector121>:
.globl vector121
vector121:
  pushl $0
80106c88:	6a 00                	push   $0x0
  pushl $121
80106c8a:	6a 79                	push   $0x79
  jmp alltraps
80106c8c:	e9 d9 f6 ff ff       	jmp    8010636a <alltraps>

80106c91 <vector122>:
.globl vector122
vector122:
  pushl $0
80106c91:	6a 00                	push   $0x0
  pushl $122
80106c93:	6a 7a                	push   $0x7a
  jmp alltraps
80106c95:	e9 d0 f6 ff ff       	jmp    8010636a <alltraps>

80106c9a <vector123>:
.globl vector123
vector123:
  pushl $0
80106c9a:	6a 00                	push   $0x0
  pushl $123
80106c9c:	6a 7b                	push   $0x7b
  jmp alltraps
80106c9e:	e9 c7 f6 ff ff       	jmp    8010636a <alltraps>

80106ca3 <vector124>:
.globl vector124
vector124:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $124
80106ca5:	6a 7c                	push   $0x7c
  jmp alltraps
80106ca7:	e9 be f6 ff ff       	jmp    8010636a <alltraps>

80106cac <vector125>:
.globl vector125
vector125:
  pushl $0
80106cac:	6a 00                	push   $0x0
  pushl $125
80106cae:	6a 7d                	push   $0x7d
  jmp alltraps
80106cb0:	e9 b5 f6 ff ff       	jmp    8010636a <alltraps>

80106cb5 <vector126>:
.globl vector126
vector126:
  pushl $0
80106cb5:	6a 00                	push   $0x0
  pushl $126
80106cb7:	6a 7e                	push   $0x7e
  jmp alltraps
80106cb9:	e9 ac f6 ff ff       	jmp    8010636a <alltraps>

80106cbe <vector127>:
.globl vector127
vector127:
  pushl $0
80106cbe:	6a 00                	push   $0x0
  pushl $127
80106cc0:	6a 7f                	push   $0x7f
  jmp alltraps
80106cc2:	e9 a3 f6 ff ff       	jmp    8010636a <alltraps>

80106cc7 <vector128>:
.globl vector128
vector128:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $128
80106cc9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106cce:	e9 97 f6 ff ff       	jmp    8010636a <alltraps>

80106cd3 <vector129>:
.globl vector129
vector129:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $129
80106cd5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106cda:	e9 8b f6 ff ff       	jmp    8010636a <alltraps>

80106cdf <vector130>:
.globl vector130
vector130:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $130
80106ce1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106ce6:	e9 7f f6 ff ff       	jmp    8010636a <alltraps>

80106ceb <vector131>:
.globl vector131
vector131:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $131
80106ced:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106cf2:	e9 73 f6 ff ff       	jmp    8010636a <alltraps>

80106cf7 <vector132>:
.globl vector132
vector132:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $132
80106cf9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106cfe:	e9 67 f6 ff ff       	jmp    8010636a <alltraps>

80106d03 <vector133>:
.globl vector133
vector133:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $133
80106d05:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106d0a:	e9 5b f6 ff ff       	jmp    8010636a <alltraps>

80106d0f <vector134>:
.globl vector134
vector134:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $134
80106d11:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106d16:	e9 4f f6 ff ff       	jmp    8010636a <alltraps>

80106d1b <vector135>:
.globl vector135
vector135:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $135
80106d1d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106d22:	e9 43 f6 ff ff       	jmp    8010636a <alltraps>

80106d27 <vector136>:
.globl vector136
vector136:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $136
80106d29:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106d2e:	e9 37 f6 ff ff       	jmp    8010636a <alltraps>

80106d33 <vector137>:
.globl vector137
vector137:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $137
80106d35:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106d3a:	e9 2b f6 ff ff       	jmp    8010636a <alltraps>

80106d3f <vector138>:
.globl vector138
vector138:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $138
80106d41:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106d46:	e9 1f f6 ff ff       	jmp    8010636a <alltraps>

80106d4b <vector139>:
.globl vector139
vector139:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $139
80106d4d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106d52:	e9 13 f6 ff ff       	jmp    8010636a <alltraps>

80106d57 <vector140>:
.globl vector140
vector140:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $140
80106d59:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106d5e:	e9 07 f6 ff ff       	jmp    8010636a <alltraps>

80106d63 <vector141>:
.globl vector141
vector141:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $141
80106d65:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106d6a:	e9 fb f5 ff ff       	jmp    8010636a <alltraps>

80106d6f <vector142>:
.globl vector142
vector142:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $142
80106d71:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106d76:	e9 ef f5 ff ff       	jmp    8010636a <alltraps>

80106d7b <vector143>:
.globl vector143
vector143:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $143
80106d7d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106d82:	e9 e3 f5 ff ff       	jmp    8010636a <alltraps>

80106d87 <vector144>:
.globl vector144
vector144:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $144
80106d89:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106d8e:	e9 d7 f5 ff ff       	jmp    8010636a <alltraps>

80106d93 <vector145>:
.globl vector145
vector145:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $145
80106d95:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106d9a:	e9 cb f5 ff ff       	jmp    8010636a <alltraps>

80106d9f <vector146>:
.globl vector146
vector146:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $146
80106da1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106da6:	e9 bf f5 ff ff       	jmp    8010636a <alltraps>

80106dab <vector147>:
.globl vector147
vector147:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $147
80106dad:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106db2:	e9 b3 f5 ff ff       	jmp    8010636a <alltraps>

80106db7 <vector148>:
.globl vector148
vector148:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $148
80106db9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106dbe:	e9 a7 f5 ff ff       	jmp    8010636a <alltraps>

80106dc3 <vector149>:
.globl vector149
vector149:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $149
80106dc5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106dca:	e9 9b f5 ff ff       	jmp    8010636a <alltraps>

80106dcf <vector150>:
.globl vector150
vector150:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $150
80106dd1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106dd6:	e9 8f f5 ff ff       	jmp    8010636a <alltraps>

80106ddb <vector151>:
.globl vector151
vector151:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $151
80106ddd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106de2:	e9 83 f5 ff ff       	jmp    8010636a <alltraps>

80106de7 <vector152>:
.globl vector152
vector152:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $152
80106de9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106dee:	e9 77 f5 ff ff       	jmp    8010636a <alltraps>

80106df3 <vector153>:
.globl vector153
vector153:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $153
80106df5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106dfa:	e9 6b f5 ff ff       	jmp    8010636a <alltraps>

80106dff <vector154>:
.globl vector154
vector154:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $154
80106e01:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106e06:	e9 5f f5 ff ff       	jmp    8010636a <alltraps>

80106e0b <vector155>:
.globl vector155
vector155:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $155
80106e0d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106e12:	e9 53 f5 ff ff       	jmp    8010636a <alltraps>

80106e17 <vector156>:
.globl vector156
vector156:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $156
80106e19:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106e1e:	e9 47 f5 ff ff       	jmp    8010636a <alltraps>

80106e23 <vector157>:
.globl vector157
vector157:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $157
80106e25:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106e2a:	e9 3b f5 ff ff       	jmp    8010636a <alltraps>

80106e2f <vector158>:
.globl vector158
vector158:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $158
80106e31:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106e36:	e9 2f f5 ff ff       	jmp    8010636a <alltraps>

80106e3b <vector159>:
.globl vector159
vector159:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $159
80106e3d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106e42:	e9 23 f5 ff ff       	jmp    8010636a <alltraps>

80106e47 <vector160>:
.globl vector160
vector160:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $160
80106e49:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106e4e:	e9 17 f5 ff ff       	jmp    8010636a <alltraps>

80106e53 <vector161>:
.globl vector161
vector161:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $161
80106e55:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106e5a:	e9 0b f5 ff ff       	jmp    8010636a <alltraps>

80106e5f <vector162>:
.globl vector162
vector162:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $162
80106e61:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106e66:	e9 ff f4 ff ff       	jmp    8010636a <alltraps>

80106e6b <vector163>:
.globl vector163
vector163:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $163
80106e6d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106e72:	e9 f3 f4 ff ff       	jmp    8010636a <alltraps>

80106e77 <vector164>:
.globl vector164
vector164:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $164
80106e79:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106e7e:	e9 e7 f4 ff ff       	jmp    8010636a <alltraps>

80106e83 <vector165>:
.globl vector165
vector165:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $165
80106e85:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106e8a:	e9 db f4 ff ff       	jmp    8010636a <alltraps>

80106e8f <vector166>:
.globl vector166
vector166:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $166
80106e91:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106e96:	e9 cf f4 ff ff       	jmp    8010636a <alltraps>

80106e9b <vector167>:
.globl vector167
vector167:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $167
80106e9d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106ea2:	e9 c3 f4 ff ff       	jmp    8010636a <alltraps>

80106ea7 <vector168>:
.globl vector168
vector168:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $168
80106ea9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106eae:	e9 b7 f4 ff ff       	jmp    8010636a <alltraps>

80106eb3 <vector169>:
.globl vector169
vector169:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $169
80106eb5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106eba:	e9 ab f4 ff ff       	jmp    8010636a <alltraps>

80106ebf <vector170>:
.globl vector170
vector170:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $170
80106ec1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106ec6:	e9 9f f4 ff ff       	jmp    8010636a <alltraps>

80106ecb <vector171>:
.globl vector171
vector171:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $171
80106ecd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106ed2:	e9 93 f4 ff ff       	jmp    8010636a <alltraps>

80106ed7 <vector172>:
.globl vector172
vector172:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $172
80106ed9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106ede:	e9 87 f4 ff ff       	jmp    8010636a <alltraps>

80106ee3 <vector173>:
.globl vector173
vector173:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $173
80106ee5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106eea:	e9 7b f4 ff ff       	jmp    8010636a <alltraps>

80106eef <vector174>:
.globl vector174
vector174:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $174
80106ef1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106ef6:	e9 6f f4 ff ff       	jmp    8010636a <alltraps>

80106efb <vector175>:
.globl vector175
vector175:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $175
80106efd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106f02:	e9 63 f4 ff ff       	jmp    8010636a <alltraps>

80106f07 <vector176>:
.globl vector176
vector176:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $176
80106f09:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106f0e:	e9 57 f4 ff ff       	jmp    8010636a <alltraps>

80106f13 <vector177>:
.globl vector177
vector177:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $177
80106f15:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106f1a:	e9 4b f4 ff ff       	jmp    8010636a <alltraps>

80106f1f <vector178>:
.globl vector178
vector178:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $178
80106f21:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106f26:	e9 3f f4 ff ff       	jmp    8010636a <alltraps>

80106f2b <vector179>:
.globl vector179
vector179:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $179
80106f2d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106f32:	e9 33 f4 ff ff       	jmp    8010636a <alltraps>

80106f37 <vector180>:
.globl vector180
vector180:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $180
80106f39:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106f3e:	e9 27 f4 ff ff       	jmp    8010636a <alltraps>

80106f43 <vector181>:
.globl vector181
vector181:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $181
80106f45:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106f4a:	e9 1b f4 ff ff       	jmp    8010636a <alltraps>

80106f4f <vector182>:
.globl vector182
vector182:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $182
80106f51:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106f56:	e9 0f f4 ff ff       	jmp    8010636a <alltraps>

80106f5b <vector183>:
.globl vector183
vector183:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $183
80106f5d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106f62:	e9 03 f4 ff ff       	jmp    8010636a <alltraps>

80106f67 <vector184>:
.globl vector184
vector184:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $184
80106f69:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106f6e:	e9 f7 f3 ff ff       	jmp    8010636a <alltraps>

80106f73 <vector185>:
.globl vector185
vector185:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $185
80106f75:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106f7a:	e9 eb f3 ff ff       	jmp    8010636a <alltraps>

80106f7f <vector186>:
.globl vector186
vector186:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $186
80106f81:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106f86:	e9 df f3 ff ff       	jmp    8010636a <alltraps>

80106f8b <vector187>:
.globl vector187
vector187:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $187
80106f8d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106f92:	e9 d3 f3 ff ff       	jmp    8010636a <alltraps>

80106f97 <vector188>:
.globl vector188
vector188:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $188
80106f99:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106f9e:	e9 c7 f3 ff ff       	jmp    8010636a <alltraps>

80106fa3 <vector189>:
.globl vector189
vector189:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $189
80106fa5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106faa:	e9 bb f3 ff ff       	jmp    8010636a <alltraps>

80106faf <vector190>:
.globl vector190
vector190:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $190
80106fb1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106fb6:	e9 af f3 ff ff       	jmp    8010636a <alltraps>

80106fbb <vector191>:
.globl vector191
vector191:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $191
80106fbd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106fc2:	e9 a3 f3 ff ff       	jmp    8010636a <alltraps>

80106fc7 <vector192>:
.globl vector192
vector192:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $192
80106fc9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106fce:	e9 97 f3 ff ff       	jmp    8010636a <alltraps>

80106fd3 <vector193>:
.globl vector193
vector193:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $193
80106fd5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106fda:	e9 8b f3 ff ff       	jmp    8010636a <alltraps>

80106fdf <vector194>:
.globl vector194
vector194:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $194
80106fe1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106fe6:	e9 7f f3 ff ff       	jmp    8010636a <alltraps>

80106feb <vector195>:
.globl vector195
vector195:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $195
80106fed:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106ff2:	e9 73 f3 ff ff       	jmp    8010636a <alltraps>

80106ff7 <vector196>:
.globl vector196
vector196:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $196
80106ff9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106ffe:	e9 67 f3 ff ff       	jmp    8010636a <alltraps>

80107003 <vector197>:
.globl vector197
vector197:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $197
80107005:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010700a:	e9 5b f3 ff ff       	jmp    8010636a <alltraps>

8010700f <vector198>:
.globl vector198
vector198:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $198
80107011:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107016:	e9 4f f3 ff ff       	jmp    8010636a <alltraps>

8010701b <vector199>:
.globl vector199
vector199:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $199
8010701d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107022:	e9 43 f3 ff ff       	jmp    8010636a <alltraps>

80107027 <vector200>:
.globl vector200
vector200:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $200
80107029:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010702e:	e9 37 f3 ff ff       	jmp    8010636a <alltraps>

80107033 <vector201>:
.globl vector201
vector201:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $201
80107035:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010703a:	e9 2b f3 ff ff       	jmp    8010636a <alltraps>

8010703f <vector202>:
.globl vector202
vector202:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $202
80107041:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107046:	e9 1f f3 ff ff       	jmp    8010636a <alltraps>

8010704b <vector203>:
.globl vector203
vector203:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $203
8010704d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107052:	e9 13 f3 ff ff       	jmp    8010636a <alltraps>

80107057 <vector204>:
.globl vector204
vector204:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $204
80107059:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010705e:	e9 07 f3 ff ff       	jmp    8010636a <alltraps>

80107063 <vector205>:
.globl vector205
vector205:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $205
80107065:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010706a:	e9 fb f2 ff ff       	jmp    8010636a <alltraps>

8010706f <vector206>:
.globl vector206
vector206:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $206
80107071:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107076:	e9 ef f2 ff ff       	jmp    8010636a <alltraps>

8010707b <vector207>:
.globl vector207
vector207:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $207
8010707d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107082:	e9 e3 f2 ff ff       	jmp    8010636a <alltraps>

80107087 <vector208>:
.globl vector208
vector208:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $208
80107089:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010708e:	e9 d7 f2 ff ff       	jmp    8010636a <alltraps>

80107093 <vector209>:
.globl vector209
vector209:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $209
80107095:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010709a:	e9 cb f2 ff ff       	jmp    8010636a <alltraps>

8010709f <vector210>:
.globl vector210
vector210:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $210
801070a1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801070a6:	e9 bf f2 ff ff       	jmp    8010636a <alltraps>

801070ab <vector211>:
.globl vector211
vector211:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $211
801070ad:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801070b2:	e9 b3 f2 ff ff       	jmp    8010636a <alltraps>

801070b7 <vector212>:
.globl vector212
vector212:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $212
801070b9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801070be:	e9 a7 f2 ff ff       	jmp    8010636a <alltraps>

801070c3 <vector213>:
.globl vector213
vector213:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $213
801070c5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801070ca:	e9 9b f2 ff ff       	jmp    8010636a <alltraps>

801070cf <vector214>:
.globl vector214
vector214:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $214
801070d1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801070d6:	e9 8f f2 ff ff       	jmp    8010636a <alltraps>

801070db <vector215>:
.globl vector215
vector215:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $215
801070dd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801070e2:	e9 83 f2 ff ff       	jmp    8010636a <alltraps>

801070e7 <vector216>:
.globl vector216
vector216:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $216
801070e9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801070ee:	e9 77 f2 ff ff       	jmp    8010636a <alltraps>

801070f3 <vector217>:
.globl vector217
vector217:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $217
801070f5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801070fa:	e9 6b f2 ff ff       	jmp    8010636a <alltraps>

801070ff <vector218>:
.globl vector218
vector218:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $218
80107101:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107106:	e9 5f f2 ff ff       	jmp    8010636a <alltraps>

8010710b <vector219>:
.globl vector219
vector219:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $219
8010710d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107112:	e9 53 f2 ff ff       	jmp    8010636a <alltraps>

80107117 <vector220>:
.globl vector220
vector220:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $220
80107119:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010711e:	e9 47 f2 ff ff       	jmp    8010636a <alltraps>

80107123 <vector221>:
.globl vector221
vector221:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $221
80107125:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010712a:	e9 3b f2 ff ff       	jmp    8010636a <alltraps>

8010712f <vector222>:
.globl vector222
vector222:
  pushl $0
8010712f:	6a 00                	push   $0x0
  pushl $222
80107131:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107136:	e9 2f f2 ff ff       	jmp    8010636a <alltraps>

8010713b <vector223>:
.globl vector223
vector223:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $223
8010713d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107142:	e9 23 f2 ff ff       	jmp    8010636a <alltraps>

80107147 <vector224>:
.globl vector224
vector224:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $224
80107149:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010714e:	e9 17 f2 ff ff       	jmp    8010636a <alltraps>

80107153 <vector225>:
.globl vector225
vector225:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $225
80107155:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010715a:	e9 0b f2 ff ff       	jmp    8010636a <alltraps>

8010715f <vector226>:
.globl vector226
vector226:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $226
80107161:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107166:	e9 ff f1 ff ff       	jmp    8010636a <alltraps>

8010716b <vector227>:
.globl vector227
vector227:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $227
8010716d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107172:	e9 f3 f1 ff ff       	jmp    8010636a <alltraps>

80107177 <vector228>:
.globl vector228
vector228:
  pushl $0
80107177:	6a 00                	push   $0x0
  pushl $228
80107179:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010717e:	e9 e7 f1 ff ff       	jmp    8010636a <alltraps>

80107183 <vector229>:
.globl vector229
vector229:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $229
80107185:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010718a:	e9 db f1 ff ff       	jmp    8010636a <alltraps>

8010718f <vector230>:
.globl vector230
vector230:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $230
80107191:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107196:	e9 cf f1 ff ff       	jmp    8010636a <alltraps>

8010719b <vector231>:
.globl vector231
vector231:
  pushl $0
8010719b:	6a 00                	push   $0x0
  pushl $231
8010719d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801071a2:	e9 c3 f1 ff ff       	jmp    8010636a <alltraps>

801071a7 <vector232>:
.globl vector232
vector232:
  pushl $0
801071a7:	6a 00                	push   $0x0
  pushl $232
801071a9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801071ae:	e9 b7 f1 ff ff       	jmp    8010636a <alltraps>

801071b3 <vector233>:
.globl vector233
vector233:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $233
801071b5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801071ba:	e9 ab f1 ff ff       	jmp    8010636a <alltraps>

801071bf <vector234>:
.globl vector234
vector234:
  pushl $0
801071bf:	6a 00                	push   $0x0
  pushl $234
801071c1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801071c6:	e9 9f f1 ff ff       	jmp    8010636a <alltraps>

801071cb <vector235>:
.globl vector235
vector235:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $235
801071cd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801071d2:	e9 93 f1 ff ff       	jmp    8010636a <alltraps>

801071d7 <vector236>:
.globl vector236
vector236:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $236
801071d9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801071de:	e9 87 f1 ff ff       	jmp    8010636a <alltraps>

801071e3 <vector237>:
.globl vector237
vector237:
  pushl $0
801071e3:	6a 00                	push   $0x0
  pushl $237
801071e5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801071ea:	e9 7b f1 ff ff       	jmp    8010636a <alltraps>

801071ef <vector238>:
.globl vector238
vector238:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $238
801071f1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801071f6:	e9 6f f1 ff ff       	jmp    8010636a <alltraps>

801071fb <vector239>:
.globl vector239
vector239:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $239
801071fd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107202:	e9 63 f1 ff ff       	jmp    8010636a <alltraps>

80107207 <vector240>:
.globl vector240
vector240:
  pushl $0
80107207:	6a 00                	push   $0x0
  pushl $240
80107209:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010720e:	e9 57 f1 ff ff       	jmp    8010636a <alltraps>

80107213 <vector241>:
.globl vector241
vector241:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $241
80107215:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010721a:	e9 4b f1 ff ff       	jmp    8010636a <alltraps>

8010721f <vector242>:
.globl vector242
vector242:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $242
80107221:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107226:	e9 3f f1 ff ff       	jmp    8010636a <alltraps>

8010722b <vector243>:
.globl vector243
vector243:
  pushl $0
8010722b:	6a 00                	push   $0x0
  pushl $243
8010722d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107232:	e9 33 f1 ff ff       	jmp    8010636a <alltraps>

80107237 <vector244>:
.globl vector244
vector244:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $244
80107239:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010723e:	e9 27 f1 ff ff       	jmp    8010636a <alltraps>

80107243 <vector245>:
.globl vector245
vector245:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $245
80107245:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010724a:	e9 1b f1 ff ff       	jmp    8010636a <alltraps>

8010724f <vector246>:
.globl vector246
vector246:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $246
80107251:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107256:	e9 0f f1 ff ff       	jmp    8010636a <alltraps>

8010725b <vector247>:
.globl vector247
vector247:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $247
8010725d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107262:	e9 03 f1 ff ff       	jmp    8010636a <alltraps>

80107267 <vector248>:
.globl vector248
vector248:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $248
80107269:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010726e:	e9 f7 f0 ff ff       	jmp    8010636a <alltraps>

80107273 <vector249>:
.globl vector249
vector249:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $249
80107275:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010727a:	e9 eb f0 ff ff       	jmp    8010636a <alltraps>

8010727f <vector250>:
.globl vector250
vector250:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $250
80107281:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107286:	e9 df f0 ff ff       	jmp    8010636a <alltraps>

8010728b <vector251>:
.globl vector251
vector251:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $251
8010728d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107292:	e9 d3 f0 ff ff       	jmp    8010636a <alltraps>

80107297 <vector252>:
.globl vector252
vector252:
  pushl $0
80107297:	6a 00                	push   $0x0
  pushl $252
80107299:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010729e:	e9 c7 f0 ff ff       	jmp    8010636a <alltraps>

801072a3 <vector253>:
.globl vector253
vector253:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $253
801072a5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801072aa:	e9 bb f0 ff ff       	jmp    8010636a <alltraps>

801072af <vector254>:
.globl vector254
vector254:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $254
801072b1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801072b6:	e9 af f0 ff ff       	jmp    8010636a <alltraps>

801072bb <vector255>:
.globl vector255
vector255:
  pushl $0
801072bb:	6a 00                	push   $0x0
  pushl $255
801072bd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801072c2:	e9 a3 f0 ff ff       	jmp    8010636a <alltraps>
801072c7:	66 90                	xchg   %ax,%ax
801072c9:	66 90                	xchg   %ax,%ax
801072cb:	66 90                	xchg   %ax,%ax
801072cd:	66 90                	xchg   %ax,%ax
801072cf:	90                   	nop

801072d0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801072d0:	55                   	push   %ebp
801072d1:	89 e5                	mov    %esp,%ebp
801072d3:	57                   	push   %edi
801072d4:	56                   	push   %esi
801072d5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801072d6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801072dc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801072e2:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
801072e5:	39 d3                	cmp    %edx,%ebx
801072e7:	73 56                	jae    8010733f <deallocuvm.part.0+0x6f>
801072e9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801072ec:	89 c6                	mov    %eax,%esi
801072ee:	89 d7                	mov    %edx,%edi
801072f0:	eb 12                	jmp    80107304 <deallocuvm.part.0+0x34>
801072f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801072f8:	83 c2 01             	add    $0x1,%edx
801072fb:	89 d3                	mov    %edx,%ebx
801072fd:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107300:	39 fb                	cmp    %edi,%ebx
80107302:	73 38                	jae    8010733c <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80107304:	89 da                	mov    %ebx,%edx
80107306:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107309:	8b 04 96             	mov    (%esi,%edx,4),%eax
8010730c:	a8 01                	test   $0x1,%al
8010730e:	74 e8                	je     801072f8 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80107310:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107312:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107317:	c1 e9 0a             	shr    $0xa,%ecx
8010731a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80107320:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80107327:	85 c0                	test   %eax,%eax
80107329:	74 cd                	je     801072f8 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
8010732b:	8b 10                	mov    (%eax),%edx
8010732d:	f6 c2 01             	test   $0x1,%dl
80107330:	75 1e                	jne    80107350 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80107332:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107338:	39 fb                	cmp    %edi,%ebx
8010733a:	72 c8                	jb     80107304 <deallocuvm.part.0+0x34>
8010733c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
8010733f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107342:	89 c8                	mov    %ecx,%eax
80107344:	5b                   	pop    %ebx
80107345:	5e                   	pop    %esi
80107346:	5f                   	pop    %edi
80107347:	5d                   	pop    %ebp
80107348:	c3                   	ret
80107349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80107350:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107356:	74 26                	je     8010737e <deallocuvm.part.0+0xae>
      kfree(v);
80107358:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010735b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107361:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107364:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
8010736a:	52                   	push   %edx
8010736b:	e8 60 bc ff ff       	call   80102fd0 <kfree>
      *pte = 0;
80107370:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80107373:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80107376:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010737c:	eb 82                	jmp    80107300 <deallocuvm.part.0+0x30>
        panic("kfree");
8010737e:	83 ec 0c             	sub    $0xc,%esp
80107381:	68 6e 7e 10 80       	push   $0x80107e6e
80107386:	e8 85 97 ff ff       	call   80100b10 <panic>
8010738b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107390 <mappages>:
{
80107390:	55                   	push   %ebp
80107391:	89 e5                	mov    %esp,%ebp
80107393:	57                   	push   %edi
80107394:	56                   	push   %esi
80107395:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107396:	89 d3                	mov    %edx,%ebx
80107398:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010739e:	83 ec 1c             	sub    $0x1c,%esp
801073a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801073a4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801073a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073ad:	89 45 dc             	mov    %eax,-0x24(%ebp)
801073b0:	8b 45 08             	mov    0x8(%ebp),%eax
801073b3:	29 d8                	sub    %ebx,%eax
801073b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801073b8:	eb 3f                	jmp    801073f9 <mappages+0x69>
801073ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801073c0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801073c7:	c1 ea 0a             	shr    $0xa,%edx
801073ca:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801073d0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801073d7:	85 c0                	test   %eax,%eax
801073d9:	74 75                	je     80107450 <mappages+0xc0>
    if(*pte & PTE_P)
801073db:	f6 00 01             	testb  $0x1,(%eax)
801073de:	0f 85 86 00 00 00    	jne    8010746a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801073e4:	0b 75 0c             	or     0xc(%ebp),%esi
801073e7:	83 ce 01             	or     $0x1,%esi
801073ea:	89 30                	mov    %esi,(%eax)
    if(a == last)
801073ec:	8b 45 dc             	mov    -0x24(%ebp),%eax
801073ef:	39 c3                	cmp    %eax,%ebx
801073f1:	74 6d                	je     80107460 <mappages+0xd0>
    a += PGSIZE;
801073f3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801073f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
801073fc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801073ff:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80107402:	89 d8                	mov    %ebx,%eax
80107404:	c1 e8 16             	shr    $0x16,%eax
80107407:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
8010740a:	8b 07                	mov    (%edi),%eax
8010740c:	a8 01                	test   $0x1,%al
8010740e:	75 b0                	jne    801073c0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107410:	e8 7b bd ff ff       	call   80103190 <kalloc>
80107415:	85 c0                	test   %eax,%eax
80107417:	74 37                	je     80107450 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107419:	83 ec 04             	sub    $0x4,%esp
8010741c:	68 00 10 00 00       	push   $0x1000
80107421:	6a 00                	push   $0x0
80107423:	50                   	push   %eax
80107424:	89 45 d8             	mov    %eax,-0x28(%ebp)
80107427:	e8 a4 dd ff ff       	call   801051d0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010742c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010742f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107432:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107438:	83 c8 07             	or     $0x7,%eax
8010743b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
8010743d:	89 d8                	mov    %ebx,%eax
8010743f:	c1 e8 0a             	shr    $0xa,%eax
80107442:	25 fc 0f 00 00       	and    $0xffc,%eax
80107447:	01 d0                	add    %edx,%eax
80107449:	eb 90                	jmp    801073db <mappages+0x4b>
8010744b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80107450:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107453:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107458:	5b                   	pop    %ebx
80107459:	5e                   	pop    %esi
8010745a:	5f                   	pop    %edi
8010745b:	5d                   	pop    %ebp
8010745c:	c3                   	ret
8010745d:	8d 76 00             	lea    0x0(%esi),%esi
80107460:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107463:	31 c0                	xor    %eax,%eax
}
80107465:	5b                   	pop    %ebx
80107466:	5e                   	pop    %esi
80107467:	5f                   	pop    %edi
80107468:	5d                   	pop    %ebp
80107469:	c3                   	ret
      panic("remap");
8010746a:	83 ec 0c             	sub    $0xc,%esp
8010746d:	68 a2 80 10 80       	push   $0x801080a2
80107472:	e8 99 96 ff ff       	call   80100b10 <panic>
80107477:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010747e:	00 
8010747f:	90                   	nop

80107480 <seginit>:
{
80107480:	55                   	push   %ebp
80107481:	89 e5                	mov    %esp,%ebp
80107483:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107486:	e8 e5 cf ff ff       	call   80104470 <cpuid>
  pd[0] = size-1;
8010748b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107490:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107496:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
8010749a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
801074a1:	ff 00 00 
801074a4:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
801074ab:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801074ae:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
801074b5:	ff 00 00 
801074b8:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
801074bf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801074c2:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
801074c9:	ff 00 00 
801074cc:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
801074d3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801074d6:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
801074dd:	ff 00 00 
801074e0:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
801074e7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801074ea:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
801074ef:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801074f3:	c1 e8 10             	shr    $0x10,%eax
801074f6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801074fa:	8d 45 f2             	lea    -0xe(%ebp),%eax
801074fd:	0f 01 10             	lgdtl  (%eax)
}
80107500:	c9                   	leave
80107501:	c3                   	ret
80107502:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107509:	00 
8010750a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107510 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107510:	a1 c4 54 11 80       	mov    0x801154c4,%eax
80107515:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010751a:	0f 22 d8             	mov    %eax,%cr3
}
8010751d:	c3                   	ret
8010751e:	66 90                	xchg   %ax,%ax

80107520 <switchuvm>:
{
80107520:	55                   	push   %ebp
80107521:	89 e5                	mov    %esp,%ebp
80107523:	57                   	push   %edi
80107524:	56                   	push   %esi
80107525:	53                   	push   %ebx
80107526:	83 ec 1c             	sub    $0x1c,%esp
80107529:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010752c:	85 f6                	test   %esi,%esi
8010752e:	0f 84 cb 00 00 00    	je     801075ff <switchuvm+0xdf>
  if(p->kstack == 0)
80107534:	8b 46 08             	mov    0x8(%esi),%eax
80107537:	85 c0                	test   %eax,%eax
80107539:	0f 84 da 00 00 00    	je     80107619 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010753f:	8b 46 04             	mov    0x4(%esi),%eax
80107542:	85 c0                	test   %eax,%eax
80107544:	0f 84 c2 00 00 00    	je     8010760c <switchuvm+0xec>
  pushcli();
8010754a:	e8 31 da ff ff       	call   80104f80 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010754f:	e8 bc ce ff ff       	call   80104410 <mycpu>
80107554:	89 c3                	mov    %eax,%ebx
80107556:	e8 b5 ce ff ff       	call   80104410 <mycpu>
8010755b:	89 c7                	mov    %eax,%edi
8010755d:	e8 ae ce ff ff       	call   80104410 <mycpu>
80107562:	83 c7 08             	add    $0x8,%edi
80107565:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107568:	e8 a3 ce ff ff       	call   80104410 <mycpu>
8010756d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107570:	ba 67 00 00 00       	mov    $0x67,%edx
80107575:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010757c:	83 c0 08             	add    $0x8,%eax
8010757f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107586:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010758b:	83 c1 08             	add    $0x8,%ecx
8010758e:	c1 e8 18             	shr    $0x18,%eax
80107591:	c1 e9 10             	shr    $0x10,%ecx
80107594:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010759a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801075a0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801075a5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801075ac:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801075b1:	e8 5a ce ff ff       	call   80104410 <mycpu>
801075b6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801075bd:	e8 4e ce ff ff       	call   80104410 <mycpu>
801075c2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801075c6:	8b 5e 08             	mov    0x8(%esi),%ebx
801075c9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801075cf:	e8 3c ce ff ff       	call   80104410 <mycpu>
801075d4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801075d7:	e8 34 ce ff ff       	call   80104410 <mycpu>
801075dc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801075e0:	b8 28 00 00 00       	mov    $0x28,%eax
801075e5:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801075e8:	8b 46 04             	mov    0x4(%esi),%eax
801075eb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801075f0:	0f 22 d8             	mov    %eax,%cr3
}
801075f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075f6:	5b                   	pop    %ebx
801075f7:	5e                   	pop    %esi
801075f8:	5f                   	pop    %edi
801075f9:	5d                   	pop    %ebp
  popcli();
801075fa:	e9 d1 d9 ff ff       	jmp    80104fd0 <popcli>
    panic("switchuvm: no process");
801075ff:	83 ec 0c             	sub    $0xc,%esp
80107602:	68 a8 80 10 80       	push   $0x801080a8
80107607:	e8 04 95 ff ff       	call   80100b10 <panic>
    panic("switchuvm: no pgdir");
8010760c:	83 ec 0c             	sub    $0xc,%esp
8010760f:	68 d3 80 10 80       	push   $0x801080d3
80107614:	e8 f7 94 ff ff       	call   80100b10 <panic>
    panic("switchuvm: no kstack");
80107619:	83 ec 0c             	sub    $0xc,%esp
8010761c:	68 be 80 10 80       	push   $0x801080be
80107621:	e8 ea 94 ff ff       	call   80100b10 <panic>
80107626:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010762d:	00 
8010762e:	66 90                	xchg   %ax,%ax

80107630 <inituvm>:
{
80107630:	55                   	push   %ebp
80107631:	89 e5                	mov    %esp,%ebp
80107633:	57                   	push   %edi
80107634:	56                   	push   %esi
80107635:	53                   	push   %ebx
80107636:	83 ec 1c             	sub    $0x1c,%esp
80107639:	8b 45 08             	mov    0x8(%ebp),%eax
8010763c:	8b 75 10             	mov    0x10(%ebp),%esi
8010763f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107642:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107645:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010764b:	77 49                	ja     80107696 <inituvm+0x66>
  mem = kalloc();
8010764d:	e8 3e bb ff ff       	call   80103190 <kalloc>
  memset(mem, 0, PGSIZE);
80107652:	83 ec 04             	sub    $0x4,%esp
80107655:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010765a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010765c:	6a 00                	push   $0x0
8010765e:	50                   	push   %eax
8010765f:	e8 6c db ff ff       	call   801051d0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107664:	58                   	pop    %eax
80107665:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010766b:	5a                   	pop    %edx
8010766c:	6a 06                	push   $0x6
8010766e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107673:	31 d2                	xor    %edx,%edx
80107675:	50                   	push   %eax
80107676:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107679:	e8 12 fd ff ff       	call   80107390 <mappages>
  memmove(mem, init, sz);
8010767e:	83 c4 10             	add    $0x10,%esp
80107681:	89 75 10             	mov    %esi,0x10(%ebp)
80107684:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107687:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010768a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010768d:	5b                   	pop    %ebx
8010768e:	5e                   	pop    %esi
8010768f:	5f                   	pop    %edi
80107690:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107691:	e9 ca db ff ff       	jmp    80105260 <memmove>
    panic("inituvm: more than a page");
80107696:	83 ec 0c             	sub    $0xc,%esp
80107699:	68 e7 80 10 80       	push   $0x801080e7
8010769e:	e8 6d 94 ff ff       	call   80100b10 <panic>
801076a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801076aa:	00 
801076ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801076b0 <loaduvm>:
{
801076b0:	55                   	push   %ebp
801076b1:	89 e5                	mov    %esp,%ebp
801076b3:	57                   	push   %edi
801076b4:	56                   	push   %esi
801076b5:	53                   	push   %ebx
801076b6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
801076b9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
801076bc:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
801076bf:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
801076c5:	0f 85 a2 00 00 00    	jne    8010776d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
801076cb:	85 ff                	test   %edi,%edi
801076cd:	74 7d                	je     8010774c <loaduvm+0x9c>
801076cf:	90                   	nop
  pde = &pgdir[PDX(va)];
801076d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801076d3:	8b 55 08             	mov    0x8(%ebp),%edx
801076d6:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
801076d8:	89 c1                	mov    %eax,%ecx
801076da:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801076dd:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
801076e0:	f6 c1 01             	test   $0x1,%cl
801076e3:	75 13                	jne    801076f8 <loaduvm+0x48>
      panic("loaduvm: address should exist");
801076e5:	83 ec 0c             	sub    $0xc,%esp
801076e8:	68 01 81 10 80       	push   $0x80108101
801076ed:	e8 1e 94 ff ff       	call   80100b10 <panic>
801076f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801076f8:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076fb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107701:	25 fc 0f 00 00       	and    $0xffc,%eax
80107706:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010770d:	85 c9                	test   %ecx,%ecx
8010770f:	74 d4                	je     801076e5 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80107711:	89 fb                	mov    %edi,%ebx
80107713:	b8 00 10 00 00       	mov    $0x1000,%eax
80107718:	29 f3                	sub    %esi,%ebx
8010771a:	39 c3                	cmp    %eax,%ebx
8010771c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010771f:	53                   	push   %ebx
80107720:	8b 45 14             	mov    0x14(%ebp),%eax
80107723:	01 f0                	add    %esi,%eax
80107725:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80107726:	8b 01                	mov    (%ecx),%eax
80107728:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010772d:	05 00 00 00 80       	add    $0x80000000,%eax
80107732:	50                   	push   %eax
80107733:	ff 75 10             	push   0x10(%ebp)
80107736:	e8 a5 ae ff ff       	call   801025e0 <readi>
8010773b:	83 c4 10             	add    $0x10,%esp
8010773e:	39 d8                	cmp    %ebx,%eax
80107740:	75 1e                	jne    80107760 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80107742:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107748:	39 fe                	cmp    %edi,%esi
8010774a:	72 84                	jb     801076d0 <loaduvm+0x20>
}
8010774c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010774f:	31 c0                	xor    %eax,%eax
}
80107751:	5b                   	pop    %ebx
80107752:	5e                   	pop    %esi
80107753:	5f                   	pop    %edi
80107754:	5d                   	pop    %ebp
80107755:	c3                   	ret
80107756:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010775d:	00 
8010775e:	66 90                	xchg   %ax,%ax
80107760:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107763:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107768:	5b                   	pop    %ebx
80107769:	5e                   	pop    %esi
8010776a:	5f                   	pop    %edi
8010776b:	5d                   	pop    %ebp
8010776c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
8010776d:	83 ec 0c             	sub    $0xc,%esp
80107770:	68 90 83 10 80       	push   $0x80108390
80107775:	e8 96 93 ff ff       	call   80100b10 <panic>
8010777a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107780 <allocuvm>:
{
80107780:	55                   	push   %ebp
80107781:	89 e5                	mov    %esp,%ebp
80107783:	57                   	push   %edi
80107784:	56                   	push   %esi
80107785:	53                   	push   %ebx
80107786:	83 ec 1c             	sub    $0x1c,%esp
80107789:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
8010778c:	85 f6                	test   %esi,%esi
8010778e:	0f 88 98 00 00 00    	js     8010782c <allocuvm+0xac>
80107794:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80107796:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107799:	0f 82 a1 00 00 00    	jb     80107840 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010779f:	8b 45 0c             	mov    0xc(%ebp),%eax
801077a2:	05 ff 0f 00 00       	add    $0xfff,%eax
801077a7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801077ac:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
801077ae:	39 f0                	cmp    %esi,%eax
801077b0:	0f 83 8d 00 00 00    	jae    80107843 <allocuvm+0xc3>
801077b6:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801077b9:	eb 44                	jmp    801077ff <allocuvm+0x7f>
801077bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801077c0:	83 ec 04             	sub    $0x4,%esp
801077c3:	68 00 10 00 00       	push   $0x1000
801077c8:	6a 00                	push   $0x0
801077ca:	50                   	push   %eax
801077cb:	e8 00 da ff ff       	call   801051d0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801077d0:	58                   	pop    %eax
801077d1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801077d7:	5a                   	pop    %edx
801077d8:	6a 06                	push   $0x6
801077da:	b9 00 10 00 00       	mov    $0x1000,%ecx
801077df:	89 fa                	mov    %edi,%edx
801077e1:	50                   	push   %eax
801077e2:	8b 45 08             	mov    0x8(%ebp),%eax
801077e5:	e8 a6 fb ff ff       	call   80107390 <mappages>
801077ea:	83 c4 10             	add    $0x10,%esp
801077ed:	85 c0                	test   %eax,%eax
801077ef:	78 5f                	js     80107850 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
801077f1:	81 c7 00 10 00 00    	add    $0x1000,%edi
801077f7:	39 f7                	cmp    %esi,%edi
801077f9:	0f 83 89 00 00 00    	jae    80107888 <allocuvm+0x108>
    mem = kalloc();
801077ff:	e8 8c b9 ff ff       	call   80103190 <kalloc>
80107804:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107806:	85 c0                	test   %eax,%eax
80107808:	75 b6                	jne    801077c0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010780a:	83 ec 0c             	sub    $0xc,%esp
8010780d:	68 1f 81 10 80       	push   $0x8010811f
80107812:	e8 a9 90 ff ff       	call   801008c0 <cprintf>
  if(newsz >= oldsz)
80107817:	83 c4 10             	add    $0x10,%esp
8010781a:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010781d:	74 0d                	je     8010782c <allocuvm+0xac>
8010781f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107822:	8b 45 08             	mov    0x8(%ebp),%eax
80107825:	89 f2                	mov    %esi,%edx
80107827:	e8 a4 fa ff ff       	call   801072d0 <deallocuvm.part.0>
    return 0;
8010782c:	31 d2                	xor    %edx,%edx
}
8010782e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107831:	89 d0                	mov    %edx,%eax
80107833:	5b                   	pop    %ebx
80107834:	5e                   	pop    %esi
80107835:	5f                   	pop    %edi
80107836:	5d                   	pop    %ebp
80107837:	c3                   	ret
80107838:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010783f:	00 
    return oldsz;
80107840:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80107843:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107846:	89 d0                	mov    %edx,%eax
80107848:	5b                   	pop    %ebx
80107849:	5e                   	pop    %esi
8010784a:	5f                   	pop    %edi
8010784b:	5d                   	pop    %ebp
8010784c:	c3                   	ret
8010784d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107850:	83 ec 0c             	sub    $0xc,%esp
80107853:	68 37 81 10 80       	push   $0x80108137
80107858:	e8 63 90 ff ff       	call   801008c0 <cprintf>
  if(newsz >= oldsz)
8010785d:	83 c4 10             	add    $0x10,%esp
80107860:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107863:	74 0d                	je     80107872 <allocuvm+0xf2>
80107865:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107868:	8b 45 08             	mov    0x8(%ebp),%eax
8010786b:	89 f2                	mov    %esi,%edx
8010786d:	e8 5e fa ff ff       	call   801072d0 <deallocuvm.part.0>
      kfree(mem);
80107872:	83 ec 0c             	sub    $0xc,%esp
80107875:	53                   	push   %ebx
80107876:	e8 55 b7 ff ff       	call   80102fd0 <kfree>
      return 0;
8010787b:	83 c4 10             	add    $0x10,%esp
    return 0;
8010787e:	31 d2                	xor    %edx,%edx
80107880:	eb ac                	jmp    8010782e <allocuvm+0xae>
80107882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107888:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
8010788b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010788e:	5b                   	pop    %ebx
8010788f:	5e                   	pop    %esi
80107890:	89 d0                	mov    %edx,%eax
80107892:	5f                   	pop    %edi
80107893:	5d                   	pop    %ebp
80107894:	c3                   	ret
80107895:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010789c:	00 
8010789d:	8d 76 00             	lea    0x0(%esi),%esi

801078a0 <deallocuvm>:
{
801078a0:	55                   	push   %ebp
801078a1:	89 e5                	mov    %esp,%ebp
801078a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801078a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801078a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801078ac:	39 d1                	cmp    %edx,%ecx
801078ae:	73 10                	jae    801078c0 <deallocuvm+0x20>
}
801078b0:	5d                   	pop    %ebp
801078b1:	e9 1a fa ff ff       	jmp    801072d0 <deallocuvm.part.0>
801078b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801078bd:	00 
801078be:	66 90                	xchg   %ax,%ax
801078c0:	89 d0                	mov    %edx,%eax
801078c2:	5d                   	pop    %ebp
801078c3:	c3                   	ret
801078c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801078cb:	00 
801078cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801078d0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801078d0:	55                   	push   %ebp
801078d1:	89 e5                	mov    %esp,%ebp
801078d3:	57                   	push   %edi
801078d4:	56                   	push   %esi
801078d5:	53                   	push   %ebx
801078d6:	83 ec 0c             	sub    $0xc,%esp
801078d9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801078dc:	85 f6                	test   %esi,%esi
801078de:	74 59                	je     80107939 <freevm+0x69>
  if(newsz >= oldsz)
801078e0:	31 c9                	xor    %ecx,%ecx
801078e2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801078e7:	89 f0                	mov    %esi,%eax
801078e9:	89 f3                	mov    %esi,%ebx
801078eb:	e8 e0 f9 ff ff       	call   801072d0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801078f0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801078f6:	eb 0f                	jmp    80107907 <freevm+0x37>
801078f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801078ff:	00 
80107900:	83 c3 04             	add    $0x4,%ebx
80107903:	39 fb                	cmp    %edi,%ebx
80107905:	74 23                	je     8010792a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107907:	8b 03                	mov    (%ebx),%eax
80107909:	a8 01                	test   $0x1,%al
8010790b:	74 f3                	je     80107900 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010790d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107912:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107915:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107918:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010791d:	50                   	push   %eax
8010791e:	e8 ad b6 ff ff       	call   80102fd0 <kfree>
80107923:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107926:	39 fb                	cmp    %edi,%ebx
80107928:	75 dd                	jne    80107907 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010792a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010792d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107930:	5b                   	pop    %ebx
80107931:	5e                   	pop    %esi
80107932:	5f                   	pop    %edi
80107933:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107934:	e9 97 b6 ff ff       	jmp    80102fd0 <kfree>
    panic("freevm: no pgdir");
80107939:	83 ec 0c             	sub    $0xc,%esp
8010793c:	68 53 81 10 80       	push   $0x80108153
80107941:	e8 ca 91 ff ff       	call   80100b10 <panic>
80107946:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010794d:	00 
8010794e:	66 90                	xchg   %ax,%ax

80107950 <setupkvm>:
{
80107950:	55                   	push   %ebp
80107951:	89 e5                	mov    %esp,%ebp
80107953:	56                   	push   %esi
80107954:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107955:	e8 36 b8 ff ff       	call   80103190 <kalloc>
8010795a:	85 c0                	test   %eax,%eax
8010795c:	74 5e                	je     801079bc <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
8010795e:	83 ec 04             	sub    $0x4,%esp
80107961:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107963:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107968:	68 00 10 00 00       	push   $0x1000
8010796d:	6a 00                	push   $0x0
8010796f:	50                   	push   %eax
80107970:	e8 5b d8 ff ff       	call   801051d0 <memset>
80107975:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107978:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010797b:	83 ec 08             	sub    $0x8,%esp
8010797e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107981:	8b 13                	mov    (%ebx),%edx
80107983:	ff 73 0c             	push   0xc(%ebx)
80107986:	50                   	push   %eax
80107987:	29 c1                	sub    %eax,%ecx
80107989:	89 f0                	mov    %esi,%eax
8010798b:	e8 00 fa ff ff       	call   80107390 <mappages>
80107990:	83 c4 10             	add    $0x10,%esp
80107993:	85 c0                	test   %eax,%eax
80107995:	78 19                	js     801079b0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107997:	83 c3 10             	add    $0x10,%ebx
8010799a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801079a0:	75 d6                	jne    80107978 <setupkvm+0x28>
}
801079a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801079a5:	89 f0                	mov    %esi,%eax
801079a7:	5b                   	pop    %ebx
801079a8:	5e                   	pop    %esi
801079a9:	5d                   	pop    %ebp
801079aa:	c3                   	ret
801079ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801079b0:	83 ec 0c             	sub    $0xc,%esp
801079b3:	56                   	push   %esi
801079b4:	e8 17 ff ff ff       	call   801078d0 <freevm>
      return 0;
801079b9:	83 c4 10             	add    $0x10,%esp
}
801079bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
801079bf:	31 f6                	xor    %esi,%esi
}
801079c1:	89 f0                	mov    %esi,%eax
801079c3:	5b                   	pop    %ebx
801079c4:	5e                   	pop    %esi
801079c5:	5d                   	pop    %ebp
801079c6:	c3                   	ret
801079c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801079ce:	00 
801079cf:	90                   	nop

801079d0 <kvmalloc>:
{
801079d0:	55                   	push   %ebp
801079d1:	89 e5                	mov    %esp,%ebp
801079d3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801079d6:	e8 75 ff ff ff       	call   80107950 <setupkvm>
801079db:	a3 c4 54 11 80       	mov    %eax,0x801154c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801079e0:	05 00 00 00 80       	add    $0x80000000,%eax
801079e5:	0f 22 d8             	mov    %eax,%cr3
}
801079e8:	c9                   	leave
801079e9:	c3                   	ret
801079ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801079f0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801079f0:	55                   	push   %ebp
801079f1:	89 e5                	mov    %esp,%ebp
801079f3:	83 ec 08             	sub    $0x8,%esp
801079f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801079f9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801079fc:	89 c1                	mov    %eax,%ecx
801079fe:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107a01:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107a04:	f6 c2 01             	test   $0x1,%dl
80107a07:	75 17                	jne    80107a20 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107a09:	83 ec 0c             	sub    $0xc,%esp
80107a0c:	68 64 81 10 80       	push   $0x80108164
80107a11:	e8 fa 90 ff ff       	call   80100b10 <panic>
80107a16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a1d:	00 
80107a1e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107a20:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107a23:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107a29:	25 fc 0f 00 00       	and    $0xffc,%eax
80107a2e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107a35:	85 c0                	test   %eax,%eax
80107a37:	74 d0                	je     80107a09 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107a39:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107a3c:	c9                   	leave
80107a3d:	c3                   	ret
80107a3e:	66 90                	xchg   %ax,%ax

80107a40 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107a40:	55                   	push   %ebp
80107a41:	89 e5                	mov    %esp,%ebp
80107a43:	57                   	push   %edi
80107a44:	56                   	push   %esi
80107a45:	53                   	push   %ebx
80107a46:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107a49:	e8 02 ff ff ff       	call   80107950 <setupkvm>
80107a4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107a51:	85 c0                	test   %eax,%eax
80107a53:	0f 84 e9 00 00 00    	je     80107b42 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107a59:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107a5c:	85 c9                	test   %ecx,%ecx
80107a5e:	0f 84 b2 00 00 00    	je     80107b16 <copyuvm+0xd6>
80107a64:	31 f6                	xor    %esi,%esi
80107a66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a6d:	00 
80107a6e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107a70:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107a73:	89 f0                	mov    %esi,%eax
80107a75:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107a78:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107a7b:	a8 01                	test   $0x1,%al
80107a7d:	75 11                	jne    80107a90 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107a7f:	83 ec 0c             	sub    $0xc,%esp
80107a82:	68 6e 81 10 80       	push   $0x8010816e
80107a87:	e8 84 90 ff ff       	call   80100b10 <panic>
80107a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107a90:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107a92:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107a97:	c1 ea 0a             	shr    $0xa,%edx
80107a9a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107aa0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107aa7:	85 c0                	test   %eax,%eax
80107aa9:	74 d4                	je     80107a7f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80107aab:	8b 00                	mov    (%eax),%eax
80107aad:	a8 01                	test   $0x1,%al
80107aaf:	0f 84 9f 00 00 00    	je     80107b54 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107ab5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107ab7:	25 ff 0f 00 00       	and    $0xfff,%eax
80107abc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107abf:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107ac5:	e8 c6 b6 ff ff       	call   80103190 <kalloc>
80107aca:	89 c3                	mov    %eax,%ebx
80107acc:	85 c0                	test   %eax,%eax
80107ace:	74 64                	je     80107b34 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107ad0:	83 ec 04             	sub    $0x4,%esp
80107ad3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107ad9:	68 00 10 00 00       	push   $0x1000
80107ade:	57                   	push   %edi
80107adf:	50                   	push   %eax
80107ae0:	e8 7b d7 ff ff       	call   80105260 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107ae5:	58                   	pop    %eax
80107ae6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107aec:	5a                   	pop    %edx
80107aed:	ff 75 e4             	push   -0x1c(%ebp)
80107af0:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107af5:	89 f2                	mov    %esi,%edx
80107af7:	50                   	push   %eax
80107af8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107afb:	e8 90 f8 ff ff       	call   80107390 <mappages>
80107b00:	83 c4 10             	add    $0x10,%esp
80107b03:	85 c0                	test   %eax,%eax
80107b05:	78 21                	js     80107b28 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107b07:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107b0d:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107b10:	0f 82 5a ff ff ff    	jb     80107a70 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107b16:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b1c:	5b                   	pop    %ebx
80107b1d:	5e                   	pop    %esi
80107b1e:	5f                   	pop    %edi
80107b1f:	5d                   	pop    %ebp
80107b20:	c3                   	ret
80107b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107b28:	83 ec 0c             	sub    $0xc,%esp
80107b2b:	53                   	push   %ebx
80107b2c:	e8 9f b4 ff ff       	call   80102fd0 <kfree>
      goto bad;
80107b31:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107b34:	83 ec 0c             	sub    $0xc,%esp
80107b37:	ff 75 e0             	push   -0x20(%ebp)
80107b3a:	e8 91 fd ff ff       	call   801078d0 <freevm>
  return 0;
80107b3f:	83 c4 10             	add    $0x10,%esp
    return 0;
80107b42:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107b49:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b4f:	5b                   	pop    %ebx
80107b50:	5e                   	pop    %esi
80107b51:	5f                   	pop    %edi
80107b52:	5d                   	pop    %ebp
80107b53:	c3                   	ret
      panic("copyuvm: page not present");
80107b54:	83 ec 0c             	sub    $0xc,%esp
80107b57:	68 88 81 10 80       	push   $0x80108188
80107b5c:	e8 af 8f ff ff       	call   80100b10 <panic>
80107b61:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107b68:	00 
80107b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107b70 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107b70:	55                   	push   %ebp
80107b71:	89 e5                	mov    %esp,%ebp
80107b73:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107b76:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107b79:	89 c1                	mov    %eax,%ecx
80107b7b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107b7e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107b81:	f6 c2 01             	test   $0x1,%dl
80107b84:	0f 84 f8 00 00 00    	je     80107c82 <uva2ka.cold>
  return &pgtab[PTX(va)];
80107b8a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b8d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107b93:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107b94:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107b99:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ba0:	89 d0                	mov    %edx,%eax
80107ba2:	f7 d2                	not    %edx
80107ba4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ba9:	05 00 00 00 80       	add    $0x80000000,%eax
80107bae:	83 e2 05             	and    $0x5,%edx
80107bb1:	ba 00 00 00 00       	mov    $0x0,%edx
80107bb6:	0f 45 c2             	cmovne %edx,%eax
}
80107bb9:	c3                   	ret
80107bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107bc0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	57                   	push   %edi
80107bc4:	56                   	push   %esi
80107bc5:	53                   	push   %ebx
80107bc6:	83 ec 0c             	sub    $0xc,%esp
80107bc9:	8b 75 14             	mov    0x14(%ebp),%esi
80107bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
80107bcf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107bd2:	85 f6                	test   %esi,%esi
80107bd4:	75 51                	jne    80107c27 <copyout+0x67>
80107bd6:	e9 9d 00 00 00       	jmp    80107c78 <copyout+0xb8>
80107bdb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107be0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107be6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107bec:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107bf2:	74 74                	je     80107c68 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
80107bf4:	89 fb                	mov    %edi,%ebx
80107bf6:	29 c3                	sub    %eax,%ebx
80107bf8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107bfe:	39 f3                	cmp    %esi,%ebx
80107c00:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107c03:	29 f8                	sub    %edi,%eax
80107c05:	83 ec 04             	sub    $0x4,%esp
80107c08:	01 c1                	add    %eax,%ecx
80107c0a:	53                   	push   %ebx
80107c0b:	52                   	push   %edx
80107c0c:	89 55 10             	mov    %edx,0x10(%ebp)
80107c0f:	51                   	push   %ecx
80107c10:	e8 4b d6 ff ff       	call   80105260 <memmove>
    len -= n;
    buf += n;
80107c15:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107c18:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80107c1e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107c21:	01 da                	add    %ebx,%edx
  while(len > 0){
80107c23:	29 de                	sub    %ebx,%esi
80107c25:	74 51                	je     80107c78 <copyout+0xb8>
  if(*pde & PTE_P){
80107c27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107c2a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107c2c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80107c2e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107c31:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107c37:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107c3a:	f6 c1 01             	test   $0x1,%cl
80107c3d:	0f 84 46 00 00 00    	je     80107c89 <copyout.cold>
  return &pgtab[PTX(va)];
80107c43:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c45:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107c4b:	c1 eb 0c             	shr    $0xc,%ebx
80107c4e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107c54:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80107c5b:	89 d9                	mov    %ebx,%ecx
80107c5d:	f7 d1                	not    %ecx
80107c5f:	83 e1 05             	and    $0x5,%ecx
80107c62:	0f 84 78 ff ff ff    	je     80107be0 <copyout+0x20>
  }
  return 0;
}
80107c68:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107c6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c70:	5b                   	pop    %ebx
80107c71:	5e                   	pop    %esi
80107c72:	5f                   	pop    %edi
80107c73:	5d                   	pop    %ebp
80107c74:	c3                   	ret
80107c75:	8d 76 00             	lea    0x0(%esi),%esi
80107c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107c7b:	31 c0                	xor    %eax,%eax
}
80107c7d:	5b                   	pop    %ebx
80107c7e:	5e                   	pop    %esi
80107c7f:	5f                   	pop    %edi
80107c80:	5d                   	pop    %ebp
80107c81:	c3                   	ret

80107c82 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107c82:	a1 00 00 00 00       	mov    0x0,%eax
80107c87:	0f 0b                	ud2

80107c89 <copyout.cold>:
80107c89:	a1 00 00 00 00       	mov    0x0,%eax
80107c8e:	0f 0b                	ud2
