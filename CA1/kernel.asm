
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
8010002d:	b8 00 3c 10 80       	mov    $0x80103c00,%eax
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
8010004c:	68 40 7d 10 80       	push   $0x80107d40
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 25 4f 00 00       	call   80104f80 <initlock>
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
80100092:	68 47 7d 10 80       	push   $0x80107d47
80100097:	50                   	push   %eax
80100098:	e8 b3 4d 00 00       	call   80104e50 <initsleeplock>
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
801000e4:	e8 87 50 00 00       	call   80105170 <acquire>
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
80100162:	e8 a9 4f 00 00       	call   80105110 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 4d 00 00       	call   80104e90 <acquiresleep>
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
8010018c:	e8 0f 2d 00 00       	call   80102ea0 <iderw>
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
801001a1:	68 4e 7d 10 80       	push   $0x80107d4e
801001a6:	e8 c5 09 00 00       	call   80100b70 <panic>
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
801001be:	e8 6d 4d 00 00       	call   80104f30 <holdingsleep>
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
801001d4:	e9 c7 2c 00 00       	jmp    80102ea0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 5f 7d 10 80       	push   $0x80107d5f
801001e1:	e8 8a 09 00 00       	call   80100b70 <panic>
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
801001ff:	e8 2c 4d 00 00       	call   80104f30 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 dc 4c 00 00       	call   80104ef0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 50 4f 00 00       	call   80105170 <acquire>
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
80100269:	e9 a2 4e 00 00       	jmp    80105110 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 66 7d 10 80       	push   $0x80107d66
80100276:	e8 f5 08 00 00       	call   80100b70 <panic>
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
80100294:	e8 b7 21 00 00       	call   80102450 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801002a0:	e8 cb 4e 00 00       	call   80105170 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	7e 77                	jle    80100323 <consoleread+0xa3>
801002ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while ((!tab_flag && input.r == input.w) || (tab_flag && input.tabr == input.e)) {
801002b0:	8b 15 80 fe 10 80    	mov    0x8010fe80,%edx
801002b6:	85 d2                	test   %edx,%edx
801002b8:	0f 85 92 00 00 00    	jne    80100350 <consoleread+0xd0>
801002be:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801002c3:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
801002c9:	0f 84 8e 00 00 00    	je     8010035d <consoleread+0xdd>
    }


    if (tab_flag==0)
    {
          c = input.buf[input.r++ % INPUT_BUF];
801002cf:	8d 50 01             	lea    0x1(%eax),%edx
801002d2:	89 15 20 ff 10 80    	mov    %edx,0x8010ff20
801002d8:	89 c2                	mov    %eax,%edx
801002da:	83 e2 7f             	and    $0x7f,%edx
801002dd:	0f be 92 a0 fe 10 80 	movsbl -0x7fef0160(%edx),%edx
801002e4:	89 d1                	mov    %edx,%ecx
          if(c == C('D')){  // EOF
801002e6:	80 fa 04             	cmp    $0x4,%dl
801002e9:	0f 84 df 00 00 00    	je     801003ce <consoleread+0x14e>
        *dst++ =c;
    }
    else
    {
      c = input.buf[input.tabr++ % INPUT_BUF];
      *dst++ =c;
801002ef:	8d 46 01             	lea    0x1(%esi),%eax
        *dst++ =c;
801002f2:	88 0e                	mov    %cl,(%esi)
      
    }

    

    if (input.tabr==input.e)
801002f4:	8b 0d 28 ff 10 80    	mov    0x8010ff28,%ecx
801002fa:	89 c6                	mov    %eax,%esi
801002fc:	39 0d 2c ff 10 80    	cmp    %ecx,0x8010ff2c
80100302:	75 14                	jne    80100318 <consoleread+0x98>
    {
      tab_flag=0;
      *dst++ = "\t";
80100304:	b9 6d 7d 10 80       	mov    $0x80107d6d,%ecx
80100309:	83 c6 01             	add    $0x1,%esi
      tab_flag=0;
8010030c:	c7 05 80 fe 10 80 00 	movl   $0x0,0x8010fe80
80100313:	00 00 00 
      *dst++ = "\t";
80100316:	88 08                	mov    %cl,(%eax)
    }
    
 
    
    --n;
    if(c == '\n' || c=='\t')
80100318:	8d 42 f7             	lea    -0x9(%edx),%eax
    --n;
8010031b:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n' || c=='\t')
8010031e:	83 f8 01             	cmp    $0x1,%eax
80100321:	77 85                	ja     801002a8 <consoleread+0x28>
      break;
  }
  release(&cons.lock);
80100323:	83 ec 0c             	sub    $0xc,%esp
80100326:	68 40 ff 10 80       	push   $0x8010ff40
8010032b:	e8 e0 4d 00 00       	call   80105110 <release>
  ilock(ip);
80100330:	58                   	pop    %eax
80100331:	ff 75 08             	push   0x8(%ebp)
80100334:	e8 37 20 00 00       	call   80102370 <ilock>

  return target - n;
80100339:	89 f8                	mov    %edi,%eax
8010033b:	83 c4 10             	add    $0x10,%esp
}
8010033e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100341:	29 d8                	sub    %ebx,%eax
}
80100343:	5b                   	pop    %ebx
80100344:	5e                   	pop    %esi
80100345:	5f                   	pop    %edi
80100346:	5d                   	pop    %ebp
80100347:	c3                   	ret
80100348:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010034f:	00 
    while ((!tab_flag && input.r == input.w) || (tab_flag && input.tabr == input.e)) {
80100350:	a1 2c ff 10 80       	mov    0x8010ff2c,%eax
80100355:	3b 05 28 ff 10 80    	cmp    0x8010ff28,%eax
8010035b:	75 2b                	jne    80100388 <consoleread+0x108>
      if(myproc()->killed){
8010035d:	e8 ce 41 00 00       	call   80104530 <myproc>
80100362:	8b 40 24             	mov    0x24(%eax),%eax
80100365:	85 c0                	test   %eax,%eax
80100367:	75 3f                	jne    801003a8 <consoleread+0x128>
      sleep(&input.r, &cons.lock);
80100369:	83 ec 08             	sub    $0x8,%esp
8010036c:	68 40 ff 10 80       	push   $0x8010ff40
80100371:	68 20 ff 10 80       	push   $0x8010ff20
80100376:	e8 75 48 00 00       	call   80104bf0 <sleep>
8010037b:	83 c4 10             	add    $0x10,%esp
8010037e:	e9 2d ff ff ff       	jmp    801002b0 <consoleread+0x30>
80100383:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      c = input.buf[input.tabr++ % INPUT_BUF];
80100388:	8d 50 01             	lea    0x1(%eax),%edx
8010038b:	83 e0 7f             	and    $0x7f,%eax
8010038e:	89 15 2c ff 10 80    	mov    %edx,0x8010ff2c
80100394:	0f be 90 a0 fe 10 80 	movsbl -0x7fef0160(%eax),%edx
8010039b:	89 d1                	mov    %edx,%ecx
8010039d:	e9 4d ff ff ff       	jmp    801002ef <consoleread+0x6f>
801003a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        release(&cons.lock);
801003a8:	83 ec 0c             	sub    $0xc,%esp
801003ab:	68 40 ff 10 80       	push   $0x8010ff40
801003b0:	e8 5b 4d 00 00       	call   80105110 <release>
        ilock(ip);
801003b5:	59                   	pop    %ecx
801003b6:	ff 75 08             	push   0x8(%ebp)
801003b9:	e8 b2 1f 00 00       	call   80102370 <ilock>
        return -1;
801003be:	83 c4 10             	add    $0x10,%esp
}
801003c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
801003c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801003c9:	5b                   	pop    %ebx
801003ca:	5e                   	pop    %esi
801003cb:	5f                   	pop    %edi
801003cc:	5d                   	pop    %ebp
801003cd:	c3                   	ret
          if(n < target){
801003ce:	39 fb                	cmp    %edi,%ebx
801003d0:	0f 83 4d ff ff ff    	jae    80100323 <consoleread+0xa3>
            input.r--;
801003d6:	a3 20 ff 10 80       	mov    %eax,0x8010ff20
801003db:	e9 43 ff ff ff       	jmp    80100323 <consoleread+0xa3>

801003e0 <append_cga_pos>:
    if (cga_pos_sequence.size >= cga_pos_sequence.cap) {
801003e0:	a1 20 94 10 80       	mov    0x80109420,%eax
801003e5:	3b 05 24 94 10 80    	cmp    0x80109424,%eax
801003eb:	7d 1b                	jge    80100408 <append_cga_pos+0x28>
void append_cga_pos(int pos) {
801003ed:	55                   	push   %ebp
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
801003ee:	8d 50 01             	lea    0x1(%eax),%edx
801003f1:	89 15 20 94 10 80    	mov    %edx,0x80109420
void append_cga_pos(int pos) {
801003f7:	89 e5                	mov    %esp,%ebp
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
801003f9:	8b 55 08             	mov    0x8(%ebp),%edx
}
801003fc:	5d                   	pop    %ebp
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
801003fd:	89 14 85 20 92 10 80 	mov    %edx,-0x7fef6de0(,%eax,4)
}
80100404:	c3                   	ret
80100405:	8d 76 00             	lea    0x0(%esi),%esi
80100408:	c3                   	ret
80100409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100410 <last_cga_pos>:
    if (cga_pos_sequence.size == 0) return -1;
80100410:	a1 20 94 10 80       	mov    0x80109420,%eax
80100415:	85 c0                	test   %eax,%eax
80100417:	74 0f                	je     80100428 <last_cga_pos+0x18>
    return cga_pos_sequence.pos_data[cga_pos_sequence.size - 1];
80100419:	8b 04 85 1c 92 10 80 	mov    -0x7fef6de4(,%eax,4),%eax
80100420:	c3                   	ret
80100421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (cga_pos_sequence.size == 0) return -1;
80100428:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010042d:	c3                   	ret
8010042e:	66 90                	xchg   %ax,%ax

80100430 <delete_last_cga_pos>:
    if (cga_pos_sequence.size > 0) {
80100430:	a1 20 94 10 80       	mov    0x80109420,%eax
80100435:	85 c0                	test   %eax,%eax
80100437:	7e 08                	jle    80100441 <delete_last_cga_pos+0x11>
        cga_pos_sequence.size--;
80100439:	83 e8 01             	sub    $0x1,%eax
8010043c:	a3 20 94 10 80       	mov    %eax,0x80109420
}
80100441:	c3                   	ret
80100442:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100449:	00 
8010044a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100450 <clear_cga_pos_sequence>:
    cga_pos_sequence.size = 0;
80100450:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
80100457:	00 00 00 
}
8010045a:	c3                   	ret
8010045b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100460 <delete_from_cga_pos_sequence>:
void delete_from_cga_pos_sequence(int pos) {
80100460:	55                   	push   %ebp
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100461:	8b 15 20 94 10 80    	mov    0x80109420,%edx
void delete_from_cga_pos_sequence(int pos) {
80100467:	89 e5                	mov    %esp,%ebp
80100469:	53                   	push   %ebx
8010046a:	8b 5d 08             	mov    0x8(%ebp),%ebx
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010046d:	85 d2                	test   %edx,%edx
8010046f:	7e 5b                	jle    801004cc <delete_from_cga_pos_sequence+0x6c>
80100471:	31 c0                	xor    %eax,%eax
80100473:	eb 0a                	jmp    8010047f <delete_from_cga_pos_sequence+0x1f>
80100475:	8d 76 00             	lea    0x0(%esi),%esi
80100478:	83 c0 01             	add    $0x1,%eax
8010047b:	39 d0                	cmp    %edx,%eax
8010047d:	74 4d                	je     801004cc <delete_from_cga_pos_sequence+0x6c>
        if (cga_pos_sequence.pos_data[i] == pos) {
8010047f:	39 1c 85 20 92 10 80 	cmp    %ebx,-0x7fef6de0(,%eax,4)
80100486:	75 f0                	jne    80100478 <delete_from_cga_pos_sequence+0x18>
    for (int i = idx; i < cga_pos_sequence.size - 1; i++) {
80100488:	83 ea 01             	sub    $0x1,%edx
8010048b:	39 c2                	cmp    %eax,%edx
8010048d:	7e 42                	jle    801004d1 <delete_from_cga_pos_sequence+0x71>
8010048f:	90                   	nop
        cga_pos_sequence.pos_data[i] = cga_pos_sequence.pos_data[i + 1];
80100490:	83 c0 01             	add    $0x1,%eax
80100493:	8b 0c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ecx
8010049a:	89 0c 85 1c 92 10 80 	mov    %ecx,-0x7fef6de4(,%eax,4)
    for (int i = idx; i < cga_pos_sequence.size - 1; i++) {
801004a1:	39 d0                	cmp    %edx,%eax
801004a3:	75 eb                	jne    80100490 <delete_from_cga_pos_sequence+0x30>
    cga_pos_sequence.size--;
801004a5:	89 15 20 94 10 80    	mov    %edx,0x80109420
    for (int i = 0; i < cga_pos_sequence.size; i++) {
801004ab:	31 c0                	xor    %eax,%eax
801004ad:	8d 76 00             	lea    0x0(%esi),%esi
        if (cga_pos_sequence.pos_data[i] > pos) {
801004b0:	8b 0c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ecx
801004b7:	39 d9                	cmp    %ebx,%ecx
801004b9:	7e 0a                	jle    801004c5 <delete_from_cga_pos_sequence+0x65>
            cga_pos_sequence.pos_data[i]--;
801004bb:	83 e9 01             	sub    $0x1,%ecx
801004be:	89 0c 85 20 92 10 80 	mov    %ecx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size; i++) {
801004c5:	83 c0 01             	add    $0x1,%eax
801004c8:	39 d0                	cmp    %edx,%eax
801004ca:	75 e4                	jne    801004b0 <delete_from_cga_pos_sequence+0x50>
}
801004cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801004cf:	c9                   	leave
801004d0:	c3                   	ret
    cga_pos_sequence.size--;
801004d1:	89 15 20 94 10 80    	mov    %edx,0x80109420
    for (int i = 0; i < cga_pos_sequence.size; i++) {
801004d7:	85 d2                	test   %edx,%edx
801004d9:	75 d0                	jne    801004ab <delete_from_cga_pos_sequence+0x4b>
801004db:	eb ef                	jmp    801004cc <delete_from_cga_pos_sequence+0x6c>
801004dd:	8d 76 00             	lea    0x0(%esi),%esi

801004e0 <cgaputc>:
{
801004e0:	55                   	push   %ebp
801004e1:	89 c1                	mov    %eax,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004e3:	b8 0e 00 00 00       	mov    $0xe,%eax
801004e8:	89 e5                	mov    %esp,%ebp
801004ea:	57                   	push   %edi
801004eb:	bf d4 03 00 00       	mov    $0x3d4,%edi
801004f0:	56                   	push   %esi
801004f1:	89 fa                	mov    %edi,%edx
801004f3:	53                   	push   %ebx
801004f4:	83 ec 1c             	sub    $0x1c,%esp
801004f7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004f8:	be d5 03 00 00       	mov    $0x3d5,%esi
801004fd:	89 f2                	mov    %esi,%edx
801004ff:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100500:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100503:	89 fa                	mov    %edi,%edx
80100505:	b8 0f 00 00 00       	mov    $0xf,%eax
8010050a:	c1 e3 08             	shl    $0x8,%ebx
8010050d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010050e:	89 f2                	mov    %esi,%edx
80100510:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100511:	0f b6 f0             	movzbl %al,%esi
80100514:	09 de                	or     %ebx,%esi
  if(c == '\n'){
80100516:	83 f9 0a             	cmp    $0xa,%ecx
80100519:	0f 84 89 01 00 00    	je     801006a8 <cgaputc+0x1c8>
    else if(c == BACKSPACE){
8010051f:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
80100525:	0f 84 f5 00 00 00    	je     80100620 <cgaputc+0x140>
    if (cga_pos_sequence.size == 0) return -1;
8010052b:	8b 1d 20 94 10 80    	mov    0x80109420,%ebx
else if (c == UNDO_BS) {
80100531:	81 f9 01 01 00 00    	cmp    $0x101,%ecx
80100537:	0f 84 f3 01 00 00    	je     80100730 <cgaputc+0x250>
    if (cga_pos_sequence.size >= cga_pos_sequence.cap) {
8010053d:	39 1d 24 94 10 80    	cmp    %ebx,0x80109424
80100543:	0f 8e d7 01 00 00    	jle    80100720 <cgaputc+0x240>
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
80100549:	8d 43 01             	lea    0x1(%ebx),%eax
8010054c:	89 34 9d 20 92 10 80 	mov    %esi,-0x7fef6de0(,%ebx,4)
80100553:	a3 20 94 10 80       	mov    %eax,0x80109420
    for (int i = 0; i < cga_pos_sequence.size - 1; i++) { // size-1 because we just added the new one
80100558:	31 c0                	xor    %eax,%eax
8010055a:	85 db                	test   %ebx,%ebx
8010055c:	7e 1e                	jle    8010057c <cgaputc+0x9c>
8010055e:	66 90                	xchg   %ax,%ax
        if (cga_pos_sequence.pos_data[i] >= pos) {
80100560:	8b 14 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%edx
80100567:	39 f2                	cmp    %esi,%edx
80100569:	7c 0a                	jl     80100575 <cgaputc+0x95>
            cga_pos_sequence.pos_data[i]++;
8010056b:	83 c2 01             	add    $0x1,%edx
8010056e:	89 14 85 20 92 10 80 	mov    %edx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size - 1; i++) { // size-1 because we just added the new one
80100575:	83 c0 01             	add    $0x1,%eax
80100578:	39 d8                	cmp    %ebx,%eax
8010057a:	75 e4                	jne    80100560 <cgaputc+0x80>
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
8010057c:	a1 30 ff 10 80       	mov    0x8010ff30,%eax
80100581:	01 f0                	add    %esi,%eax
80100583:	39 c6                	cmp    %eax,%esi
80100585:	7d 1f                	jge    801005a6 <cgaputc+0xc6>
80100587:	8d 84 00 fe 7f 0b 80 	lea    -0x7ff48002(%eax,%eax,1),%eax
8010058e:	8d 9c 36 fe 7f 0b 80 	lea    -0x7ff48002(%esi,%esi,1),%ebx
80100595:	8d 76 00             	lea    0x0(%esi),%esi
      crt[i] = crt[i - 1];
80100598:	0f b7 10             	movzwl (%eax),%edx
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
8010059b:	83 e8 02             	sub    $0x2,%eax
      crt[i] = crt[i - 1];
8010059e:	66 89 50 04          	mov    %dx,0x4(%eax)
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
801005a2:	39 c3                	cmp    %eax,%ebx
801005a4:	75 f2                	jne    80100598 <cgaputc+0xb8>
    crt[pos++] = (c&0xff) | 0x0700;
801005a6:	0f b6 c9             	movzbl %cl,%ecx
801005a9:	8d 5e 01             	lea    0x1(%esi),%ebx
801005ac:	80 cd 07             	or     $0x7,%ch
801005af:	66 89 8c 36 00 80 0b 	mov    %cx,-0x7ff48000(%esi,%esi,1)
801005b6:	80 
  if(pos < 0 || pos > 25*80)
801005b7:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801005bd:	0f 87 30 02 00 00    	ja     801007f3 <cgaputc+0x313>
  if((pos/80) >= 24){  // Scroll up.
801005c3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801005c9:	0f 8f 01 01 00 00    	jg     801006d0 <cgaputc+0x1f0>
  outb(CRTPORT+1, pos);
801005cf:	88 5d e7             	mov    %bl,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
801005d2:	0f b6 ff             	movzbl %bh,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801005d5:	be d4 03 00 00       	mov    $0x3d4,%esi
801005da:	b8 0e 00 00 00       	mov    $0xe,%eax
801005df:	89 f2                	mov    %esi,%edx
801005e1:	ee                   	out    %al,(%dx)
801005e2:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801005e7:	89 f8                	mov    %edi,%eax
801005e9:	89 ca                	mov    %ecx,%edx
801005eb:	ee                   	out    %al,(%dx)
801005ec:	b8 0f 00 00 00       	mov    $0xf,%eax
801005f1:	89 f2                	mov    %esi,%edx
801005f3:	ee                   	out    %al,(%dx)
801005f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801005f8:	89 ca                	mov    %ecx,%edx
801005fa:	ee                   	out    %al,(%dx)
  crt[pos+left_key_pressed_count] = ' ' | 0x0700;
801005fb:	b8 20 07 00 00       	mov    $0x720,%eax
80100600:	03 1d 30 ff 10 80    	add    0x8010ff30,%ebx
80100606:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
8010060d:	80 
}
8010060e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100611:	5b                   	pop    %ebx
80100612:	5e                   	pop    %esi
80100613:	5f                   	pop    %edi
80100614:	5d                   	pop    %ebp
80100615:	c3                   	ret
80100616:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010061d:	00 
8010061e:	66 90                	xchg   %ax,%ax
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
80100620:	8b 0d 30 ff 10 80    	mov    0x8010ff30,%ecx
    int deleted_pos = pos - 1;
80100626:	8d 5e ff             	lea    -0x1(%esi),%ebx
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
80100629:	8d 84 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%eax
80100630:	89 da                	mov    %ebx,%edx
80100632:	85 c9                	test   %ecx,%ecx
80100634:	78 23                	js     80100659 <cgaputc+0x179>
80100636:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010063d:	00 
8010063e:	66 90                	xchg   %ax,%ax
      crt[i] = crt[i + 1];
80100640:	0f b7 08             	movzwl (%eax),%ecx
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
80100643:	83 c2 01             	add    $0x1,%edx
80100646:	83 c0 02             	add    $0x2,%eax
      crt[i] = crt[i + 1];
80100649:	66 89 48 fc          	mov    %cx,-0x4(%eax)
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
8010064d:	8b 0d 30 ff 10 80    	mov    0x8010ff30,%ecx
80100653:	01 f1                	add    %esi,%ecx
80100655:	39 d1                	cmp    %edx,%ecx
80100657:	7f e7                	jg     80100640 <cgaputc+0x160>
    for (int i = 0; i < cga_pos_sequence.size; i++) {
80100659:	8b 0d 20 94 10 80    	mov    0x80109420,%ecx
8010065f:	31 c0                	xor    %eax,%eax
80100661:	85 c9                	test   %ecx,%ecx
80100663:	7e 1f                	jle    80100684 <cgaputc+0x1a4>
80100665:	8d 76 00             	lea    0x0(%esi),%esi
        if (cga_pos_sequence.pos_data[i] > deleted_pos) {
80100668:	8b 14 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%edx
8010066f:	39 da                	cmp    %ebx,%edx
80100671:	7e 0a                	jle    8010067d <cgaputc+0x19d>
            cga_pos_sequence.pos_data[i]--;
80100673:	83 ea 01             	sub    $0x1,%edx
80100676:	89 14 85 20 92 10 80 	mov    %edx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010067d:	83 c0 01             	add    $0x1,%eax
80100680:	39 c8                	cmp    %ecx,%eax
80100682:	75 e4                	jne    80100668 <cgaputc+0x188>
    delete_from_cga_pos_sequence(deleted_pos);
80100684:	83 ec 0c             	sub    $0xc,%esp
80100687:	53                   	push   %ebx
80100688:	e8 d3 fd ff ff       	call   80100460 <delete_from_cga_pos_sequence>
    if(pos > 0) --pos;
8010068d:	83 c4 10             	add    $0x10,%esp
80100690:	85 f6                	test   %esi,%esi
80100692:	0f 85 1f ff ff ff    	jne    801005b7 <cgaputc+0xd7>
80100698:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  pos |= inb(CRTPORT+1);
8010069c:	31 db                	xor    %ebx,%ebx
8010069e:	31 ff                	xor    %edi,%edi
801006a0:	e9 30 ff ff ff       	jmp    801005d5 <cgaputc+0xf5>
801006a5:	8d 76 00             	lea    0x0(%esi),%esi
    cga_pos_sequence.size = 0;
801006a8:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
801006af:	00 00 00 
    pos += 80 - pos%80;
801006b2:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
801006b7:	f7 e6                	mul    %esi
801006b9:	c1 ea 06             	shr    $0x6,%edx
801006bc:	8d 04 92             	lea    (%edx,%edx,4),%eax
801006bf:	c1 e0 04             	shl    $0x4,%eax
801006c2:	8d 58 50             	lea    0x50(%eax),%ebx
}
801006c5:	e9 ed fe ff ff       	jmp    801005b7 <cgaputc+0xd7>
801006ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006d0:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801006d3:	83 eb 50             	sub    $0x50,%ebx
  outb(CRTPORT+1, pos);
801006d6:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006db:	68 60 0e 00 00       	push   $0xe60
801006e0:	68 a0 80 0b 80       	push   $0x800b80a0
801006e5:	68 00 80 0b 80       	push   $0x800b8000
801006ea:	e8 11 4c 00 00       	call   80105300 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006ef:	b8 80 07 00 00       	mov    $0x780,%eax
801006f4:	83 c4 0c             	add    $0xc,%esp
801006f7:	29 d8                	sub    %ebx,%eax
801006f9:	01 c0                	add    %eax,%eax
801006fb:	50                   	push   %eax
801006fc:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100703:	6a 00                	push   $0x0
80100705:	50                   	push   %eax
80100706:	e8 65 4b 00 00       	call   80105270 <memset>
  outb(CRTPORT+1, pos);
8010070b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010070e:	83 c4 10             	add    $0x10,%esp
80100711:	e9 bf fe ff ff       	jmp    801005d5 <cgaputc+0xf5>
80100716:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010071d:	00 
8010071e:	66 90                	xchg   %ax,%ax
    for (int i = 0; i < cga_pos_sequence.size - 1; i++) { // size-1 because we just added the new one
80100720:	83 eb 01             	sub    $0x1,%ebx
80100723:	e9 30 fe ff ff       	jmp    80100558 <cgaputc+0x78>
80100728:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010072f:	00 
    if (cga_pos_sequence.size == 0) return -1;
80100730:	85 db                	test   %ebx,%ebx
80100732:	0f 84 d6 fe ff ff    	je     8010060e <cgaputc+0x12e>
    return cga_pos_sequence.pos_data[cga_pos_sequence.size - 1];
80100738:	8d 43 ff             	lea    -0x1(%ebx),%eax
8010073b:	8b 0c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ecx
    if (undo_pos == -1) return;
80100742:	83 f9 ff             	cmp    $0xffffffff,%ecx
80100745:	0f 84 c3 fe ff ff    	je     8010060e <cgaputc+0x12e>
    if (cga_pos_sequence.size > 0) {
8010074b:	85 db                	test   %ebx,%ebx
8010074d:	0f 8e 8d 00 00 00    	jle    801007e0 <cgaputc+0x300>
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
80100753:	8b 15 30 ff 10 80    	mov    0x8010ff30,%edx
        cga_pos_sequence.size--;
80100759:	a3 20 94 10 80       	mov    %eax,0x80109420
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
8010075e:	8d 04 16             	lea    (%esi,%edx,1),%eax
80100761:	39 c1                	cmp    %eax,%ecx
80100763:	7d 25                	jge    8010078a <cgaputc+0x2aa>
80100765:	8d 84 09 02 80 0b 80 	lea    -0x7ff47ffe(%ecx,%ecx,1),%eax
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010076c:	89 cb                	mov    %ecx,%ebx
8010076e:	66 90                	xchg   %ax,%ax
        crt[i] = crt[i + 1];
80100770:	0f b7 10             	movzwl (%eax),%edx
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
80100773:	83 c3 01             	add    $0x1,%ebx
80100776:	83 c0 02             	add    $0x2,%eax
        crt[i] = crt[i + 1];
80100779:	66 89 50 fc          	mov    %dx,-0x4(%eax)
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
8010077d:	8b 15 30 ff 10 80    	mov    0x8010ff30,%edx
80100783:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80100786:	39 df                	cmp    %ebx,%edi
80100788:	7f e6                	jg     80100770 <cgaputc+0x290>
    for (int i = 0; i < cga_pos_sequence.size; i++) {
8010078a:	8b 3d 20 94 10 80    	mov    0x80109420,%edi
80100790:	31 c0                	xor    %eax,%eax
80100792:	85 ff                	test   %edi,%edi
80100794:	7e 26                	jle    801007bc <cgaputc+0x2dc>
80100796:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010079d:	00 
8010079e:	66 90                	xchg   %ax,%ax
        if (cga_pos_sequence.pos_data[i] > undo_pos) {
801007a0:	8b 1c 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%ebx
801007a7:	39 cb                	cmp    %ecx,%ebx
801007a9:	7e 0a                	jle    801007b5 <cgaputc+0x2d5>
            cga_pos_sequence.pos_data[i]--;
801007ab:	83 eb 01             	sub    $0x1,%ebx
801007ae:	89 1c 85 20 92 10 80 	mov    %ebx,-0x7fef6de0(,%eax,4)
    for (int i = 0; i < cga_pos_sequence.size; i++) {
801007b5:	83 c0 01             	add    $0x1,%eax
801007b8:	39 c7                	cmp    %eax,%edi
801007ba:	75 e4                	jne    801007a0 <cgaputc+0x2c0>
    if(pos > pos + left_key_pressed_count-1) --pos;
801007bc:	8d 5e ff             	lea    -0x1(%esi),%ebx
801007bf:	85 d2                	test   %edx,%edx
801007c1:	0f 8e f0 fd ff ff    	jle    801005b7 <cgaputc+0xd7>
      left_key_pressed_count--;
801007c7:	83 ea 01             	sub    $0x1,%edx
  pos |= inb(CRTPORT+1);
801007ca:	89 f3                	mov    %esi,%ebx
      left_key_pressed_count--;
801007cc:	89 15 30 ff 10 80    	mov    %edx,0x8010ff30
801007d2:	e9 e0 fd ff ff       	jmp    801005b7 <cgaputc+0xd7>
801007d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801007de:	00 
801007df:	90                   	nop
    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
801007e0:	8b 15 30 ff 10 80    	mov    0x8010ff30,%edx
801007e6:	8d 04 16             	lea    (%esi,%edx,1),%eax
801007e9:	39 c1                	cmp    %eax,%ecx
801007eb:	0f 8c 74 ff ff ff    	jl     80100765 <cgaputc+0x285>
801007f1:	eb c9                	jmp    801007bc <cgaputc+0x2dc>
    panic("pos under/overflow");
801007f3:	83 ec 0c             	sub    $0xc,%esp
801007f6:	68 6f 7d 10 80       	push   $0x80107d6f
801007fb:	e8 70 03 00 00       	call   80100b70 <panic>

80100800 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100800:	55                   	push   %ebp
80100801:	89 e5                	mov    %esp,%ebp
80100803:	57                   	push   %edi
80100804:	56                   	push   %esi
80100805:	53                   	push   %ebx
80100806:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100809:	ff 75 08             	push   0x8(%ebp)
8010080c:	e8 3f 1c 00 00       	call   80102450 <iunlock>
  acquire(&cons.lock);
80100811:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80100818:	e8 53 49 00 00       	call   80105170 <acquire>
  for(i = 0; i < n; i++)
8010081d:	8b 4d 10             	mov    0x10(%ebp),%ecx
80100820:	83 c4 10             	add    $0x10,%esp
80100823:	85 c9                	test   %ecx,%ecx
80100825:	7e 36                	jle    8010085d <consolewrite+0x5d>
80100827:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010082a:	8b 7d 10             	mov    0x10(%ebp),%edi
8010082d:	01 df                	add    %ebx,%edi
  if(panicked){
8010082f:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
    consputc(buf[i] & 0xff);
80100835:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
80100838:	85 d2                	test   %edx,%edx
8010083a:	74 04                	je     80100840 <consolewrite+0x40>
}

static inline void
cli(void)
{
  asm volatile("cli");
8010083c:	fa                   	cli
    for(;;)
8010083d:	eb fe                	jmp    8010083d <consolewrite+0x3d>
8010083f:	90                   	nop
    uartputc(c);
80100840:	83 ec 0c             	sub    $0xc,%esp
    consputc(buf[i] & 0xff);
80100843:	0f b6 f0             	movzbl %al,%esi
  for(i = 0; i < n; i++)
80100846:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100849:	56                   	push   %esi
8010084a:	e8 31 60 00 00       	call   80106880 <uartputc>
  cgaputc(c);
8010084f:	89 f0                	mov    %esi,%eax
80100851:	e8 8a fc ff ff       	call   801004e0 <cgaputc>
  for(i = 0; i < n; i++)
80100856:	83 c4 10             	add    $0x10,%esp
80100859:	39 fb                	cmp    %edi,%ebx
8010085b:	75 d2                	jne    8010082f <consolewrite+0x2f>
  release(&cons.lock);
8010085d:	83 ec 0c             	sub    $0xc,%esp
80100860:	68 40 ff 10 80       	push   $0x8010ff40
80100865:	e8 a6 48 00 00       	call   80105110 <release>
  ilock(ip);
8010086a:	58                   	pop    %eax
8010086b:	ff 75 08             	push   0x8(%ebp)
8010086e:	e8 fd 1a 00 00       	call   80102370 <ilock>

  return n;
}
80100873:	8b 45 10             	mov    0x10(%ebp),%eax
80100876:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100879:	5b                   	pop    %ebx
8010087a:	5e                   	pop    %esi
8010087b:	5f                   	pop    %edi
8010087c:	5d                   	pop    %ebp
8010087d:	c3                   	ret
8010087e:	66 90                	xchg   %ax,%ax

80100880 <printint>:
{
80100880:	55                   	push   %ebp
80100881:	89 e5                	mov    %esp,%ebp
80100883:	57                   	push   %edi
80100884:	56                   	push   %esi
80100885:	53                   	push   %ebx
80100886:	89 d3                	mov    %edx,%ebx
80100888:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010088b:	85 c0                	test   %eax,%eax
8010088d:	79 05                	jns    80100894 <printint+0x14>
8010088f:	83 e1 01             	and    $0x1,%ecx
80100892:	75 6a                	jne    801008fe <printint+0x7e>
    x = xx;
80100894:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010089b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010089d:	31 f6                	xor    %esi,%esi
8010089f:	90                   	nop
    buf[i++] = digits[x % base];
801008a0:	89 c8                	mov    %ecx,%eax
801008a2:	31 d2                	xor    %edx,%edx
801008a4:	89 f7                	mov    %esi,%edi
801008a6:	f7 f3                	div    %ebx
801008a8:	8d 76 01             	lea    0x1(%esi),%esi
801008ab:	0f b6 92 b0 82 10 80 	movzbl -0x7fef7d50(%edx),%edx
801008b2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
801008b6:	89 ca                	mov    %ecx,%edx
801008b8:	89 c1                	mov    %eax,%ecx
801008ba:	39 da                	cmp    %ebx,%edx
801008bc:	73 e2                	jae    801008a0 <printint+0x20>
  if(sign)
801008be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801008c1:	85 d2                	test   %edx,%edx
801008c3:	74 07                	je     801008cc <printint+0x4c>
    buf[i++] = '-';
801008c5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
801008ca:	89 f7                	mov    %esi,%edi
801008cc:	8d 75 d8             	lea    -0x28(%ebp),%esi
801008cf:	01 f7                	add    %esi,%edi
  if(panicked){
801008d1:	a1 78 ff 10 80       	mov    0x8010ff78,%eax
    consputc(buf[i]);
801008d6:	0f be 1f             	movsbl (%edi),%ebx
  if(panicked){
801008d9:	85 c0                	test   %eax,%eax
801008db:	74 03                	je     801008e0 <printint+0x60>
801008dd:	fa                   	cli
    for(;;)
801008de:	eb fe                	jmp    801008de <printint+0x5e>
    uartputc(c);
801008e0:	83 ec 0c             	sub    $0xc,%esp
801008e3:	53                   	push   %ebx
801008e4:	e8 97 5f 00 00       	call   80106880 <uartputc>
  cgaputc(c);
801008e9:	89 d8                	mov    %ebx,%eax
801008eb:	e8 f0 fb ff ff       	call   801004e0 <cgaputc>
  while(--i >= 0)
801008f0:	8d 47 ff             	lea    -0x1(%edi),%eax
801008f3:	83 c4 10             	add    $0x10,%esp
801008f6:	39 f7                	cmp    %esi,%edi
801008f8:	74 11                	je     8010090b <printint+0x8b>
801008fa:	89 c7                	mov    %eax,%edi
801008fc:	eb d3                	jmp    801008d1 <printint+0x51>
    x = -xx;
801008fe:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
80100900:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
80100907:	89 c1                	mov    %eax,%ecx
80100909:	eb 92                	jmp    8010089d <printint+0x1d>
}
8010090b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010090e:	5b                   	pop    %ebx
8010090f:	5e                   	pop    %esi
80100910:	5f                   	pop    %edi
80100911:	5d                   	pop    %ebp
80100912:	c3                   	ret
80100913:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010091a:	00 
8010091b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100920 <cprintf>:
{
80100920:	55                   	push   %ebp
80100921:	89 e5                	mov    %esp,%ebp
80100923:	57                   	push   %edi
80100924:	56                   	push   %esi
80100925:	53                   	push   %ebx
80100926:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100929:	8b 3d 74 ff 10 80    	mov    0x8010ff74,%edi
  if (fmt == 0)
8010092f:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100932:	85 ff                	test   %edi,%edi
80100934:	0f 85 36 01 00 00    	jne    80100a70 <cprintf+0x150>
  if (fmt == 0)
8010093a:	85 f6                	test   %esi,%esi
8010093c:	0f 84 1c 02 00 00    	je     80100b5e <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100942:	0f b6 06             	movzbl (%esi),%eax
80100945:	85 c0                	test   %eax,%eax
80100947:	74 67                	je     801009b0 <cprintf+0x90>
  argp = (uint*)(void*)(&fmt + 1);
80100949:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010094c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010094f:	31 db                	xor    %ebx,%ebx
80100951:	89 d7                	mov    %edx,%edi
    if(c != '%'){
80100953:	83 f8 25             	cmp    $0x25,%eax
80100956:	75 68                	jne    801009c0 <cprintf+0xa0>
    c = fmt[++i] & 0xff;
80100958:	83 c3 01             	add    $0x1,%ebx
8010095b:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
8010095f:	85 c9                	test   %ecx,%ecx
80100961:	74 42                	je     801009a5 <cprintf+0x85>
    switch(c){
80100963:	83 f9 70             	cmp    $0x70,%ecx
80100966:	0f 84 e4 00 00 00    	je     80100a50 <cprintf+0x130>
8010096c:	0f 8f 8e 00 00 00    	jg     80100a00 <cprintf+0xe0>
80100972:	83 f9 25             	cmp    $0x25,%ecx
80100975:	74 72                	je     801009e9 <cprintf+0xc9>
80100977:	83 f9 64             	cmp    $0x64,%ecx
8010097a:	0f 85 8e 00 00 00    	jne    80100a0e <cprintf+0xee>
      printint(*argp++, 10, 1);
80100980:	8d 47 04             	lea    0x4(%edi),%eax
80100983:	b9 01 00 00 00       	mov    $0x1,%ecx
80100988:	ba 0a 00 00 00       	mov    $0xa,%edx
8010098d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100990:	8b 07                	mov    (%edi),%eax
80100992:	e8 e9 fe ff ff       	call   80100880 <printint>
80100997:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010099a:	83 c3 01             	add    $0x1,%ebx
8010099d:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801009a1:	85 c0                	test   %eax,%eax
801009a3:	75 ae                	jne    80100953 <cprintf+0x33>
801009a5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
801009a8:	85 ff                	test   %edi,%edi
801009aa:	0f 85 e3 00 00 00    	jne    80100a93 <cprintf+0x173>
}
801009b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009b3:	5b                   	pop    %ebx
801009b4:	5e                   	pop    %esi
801009b5:	5f                   	pop    %edi
801009b6:	5d                   	pop    %ebp
801009b7:	c3                   	ret
801009b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801009bf:	00 
  if(panicked){
801009c0:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
801009c6:	85 d2                	test   %edx,%edx
801009c8:	74 06                	je     801009d0 <cprintf+0xb0>
801009ca:	fa                   	cli
    for(;;)
801009cb:	eb fe                	jmp    801009cb <cprintf+0xab>
801009cd:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
801009d0:	83 ec 0c             	sub    $0xc,%esp
801009d3:	50                   	push   %eax
801009d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801009d7:	e8 a4 5e 00 00       	call   80106880 <uartputc>
  cgaputc(c);
801009dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801009df:	e8 fc fa ff ff       	call   801004e0 <cgaputc>
      continue;
801009e4:	83 c4 10             	add    $0x10,%esp
801009e7:	eb b1                	jmp    8010099a <cprintf+0x7a>
  if(panicked){
801009e9:	8b 0d 78 ff 10 80    	mov    0x8010ff78,%ecx
801009ef:	85 c9                	test   %ecx,%ecx
801009f1:	0f 84 f9 00 00 00    	je     80100af0 <cprintf+0x1d0>
801009f7:	fa                   	cli
    for(;;)
801009f8:	eb fe                	jmp    801009f8 <cprintf+0xd8>
801009fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100a00:	83 f9 73             	cmp    $0x73,%ecx
80100a03:	0f 84 9f 00 00 00    	je     80100aa8 <cprintf+0x188>
80100a09:	83 f9 78             	cmp    $0x78,%ecx
80100a0c:	74 42                	je     80100a50 <cprintf+0x130>
  if(panicked){
80100a0e:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
80100a14:	85 d2                	test   %edx,%edx
80100a16:	0f 85 d0 00 00 00    	jne    80100aec <cprintf+0x1cc>
    uartputc(c);
80100a1c:	83 ec 0c             	sub    $0xc,%esp
80100a1f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100a22:	6a 25                	push   $0x25
80100a24:	e8 57 5e 00 00       	call   80106880 <uartputc>
  cgaputc(c);
80100a29:	b8 25 00 00 00       	mov    $0x25,%eax
80100a2e:	e8 ad fa ff ff       	call   801004e0 <cgaputc>
  if(panicked){
80100a33:	a1 78 ff 10 80       	mov    0x8010ff78,%eax
80100a38:	83 c4 10             	add    $0x10,%esp
80100a3b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100a3e:	85 c0                	test   %eax,%eax
80100a40:	0f 84 f5 00 00 00    	je     80100b3b <cprintf+0x21b>
80100a46:	fa                   	cli
    for(;;)
80100a47:	eb fe                	jmp    80100a47 <cprintf+0x127>
80100a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
80100a50:	8d 47 04             	lea    0x4(%edi),%eax
80100a53:	31 c9                	xor    %ecx,%ecx
80100a55:	ba 10 00 00 00       	mov    $0x10,%edx
80100a5a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100a5d:	8b 07                	mov    (%edi),%eax
80100a5f:	e8 1c fe ff ff       	call   80100880 <printint>
80100a64:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100a67:	e9 2e ff ff ff       	jmp    8010099a <cprintf+0x7a>
80100a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
80100a70:	83 ec 0c             	sub    $0xc,%esp
80100a73:	68 40 ff 10 80       	push   $0x8010ff40
80100a78:	e8 f3 46 00 00       	call   80105170 <acquire>
  if (fmt == 0)
80100a7d:	83 c4 10             	add    $0x10,%esp
80100a80:	85 f6                	test   %esi,%esi
80100a82:	0f 84 d6 00 00 00    	je     80100b5e <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100a88:	0f b6 06             	movzbl (%esi),%eax
80100a8b:	85 c0                	test   %eax,%eax
80100a8d:	0f 85 b6 fe ff ff    	jne    80100949 <cprintf+0x29>
    release(&cons.lock);
80100a93:	83 ec 0c             	sub    $0xc,%esp
80100a96:	68 40 ff 10 80       	push   $0x8010ff40
80100a9b:	e8 70 46 00 00       	call   80105110 <release>
80100aa0:	83 c4 10             	add    $0x10,%esp
80100aa3:	e9 08 ff ff ff       	jmp    801009b0 <cprintf+0x90>
      if((s = (char*)*argp++) == 0)
80100aa8:	8b 17                	mov    (%edi),%edx
80100aaa:	8d 47 04             	lea    0x4(%edi),%eax
80100aad:	85 d2                	test   %edx,%edx
80100aaf:	74 2f                	je     80100ae0 <cprintf+0x1c0>
      for(; *s; s++)
80100ab1:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100ab4:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100ab6:	84 c9                	test   %cl,%cl
80100ab8:	0f 84 99 00 00 00    	je     80100b57 <cprintf+0x237>
80100abe:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100ac1:	89 fb                	mov    %edi,%ebx
80100ac3:	89 f7                	mov    %esi,%edi
80100ac5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ac8:	89 c8                	mov    %ecx,%eax
  if(panicked){
80100aca:	8b 35 78 ff 10 80    	mov    0x8010ff78,%esi
80100ad0:	85 f6                	test   %esi,%esi
80100ad2:	74 38                	je     80100b0c <cprintf+0x1ec>
80100ad4:	fa                   	cli
    for(;;)
80100ad5:	eb fe                	jmp    80100ad5 <cprintf+0x1b5>
80100ad7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100ade:	00 
80100adf:	90                   	nop
80100ae0:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
80100ae5:	bf 82 7d 10 80       	mov    $0x80107d82,%edi
80100aea:	eb d2                	jmp    80100abe <cprintf+0x19e>
80100aec:	fa                   	cli
    for(;;)
80100aed:	eb fe                	jmp    80100aed <cprintf+0x1cd>
80100aef:	90                   	nop
    uartputc(c);
80100af0:	83 ec 0c             	sub    $0xc,%esp
80100af3:	6a 25                	push   $0x25
80100af5:	e8 86 5d 00 00       	call   80106880 <uartputc>
  cgaputc(c);
80100afa:	b8 25 00 00 00       	mov    $0x25,%eax
80100aff:	e8 dc f9 ff ff       	call   801004e0 <cgaputc>
}
80100b04:	83 c4 10             	add    $0x10,%esp
80100b07:	e9 8e fe ff ff       	jmp    8010099a <cprintf+0x7a>
    uartputc(c);
80100b0c:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
80100b0f:	0f be f0             	movsbl %al,%esi
      for(; *s; s++)
80100b12:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100b15:	56                   	push   %esi
80100b16:	e8 65 5d 00 00       	call   80106880 <uartputc>
  cgaputc(c);
80100b1b:	89 f0                	mov    %esi,%eax
80100b1d:	e8 be f9 ff ff       	call   801004e0 <cgaputc>
      for(; *s; s++)
80100b22:	0f b6 03             	movzbl (%ebx),%eax
80100b25:	83 c4 10             	add    $0x10,%esp
80100b28:	84 c0                	test   %al,%al
80100b2a:	75 9e                	jne    80100aca <cprintf+0x1aa>
      if((s = (char*)*argp++) == 0)
80100b2c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100b2f:	89 fe                	mov    %edi,%esi
80100b31:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100b34:	89 c7                	mov    %eax,%edi
80100b36:	e9 5f fe ff ff       	jmp    8010099a <cprintf+0x7a>
    uartputc(c);
80100b3b:	83 ec 0c             	sub    $0xc,%esp
80100b3e:	51                   	push   %ecx
80100b3f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100b42:	e8 39 5d 00 00       	call   80106880 <uartputc>
  cgaputc(c);
80100b47:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100b4a:	e8 91 f9 ff ff       	call   801004e0 <cgaputc>
}
80100b4f:	83 c4 10             	add    $0x10,%esp
80100b52:	e9 43 fe ff ff       	jmp    8010099a <cprintf+0x7a>
      if((s = (char*)*argp++) == 0)
80100b57:	89 c7                	mov    %eax,%edi
80100b59:	e9 3c fe ff ff       	jmp    8010099a <cprintf+0x7a>
    panic("null fmt");
80100b5e:	83 ec 0c             	sub    $0xc,%esp
80100b61:	68 89 7d 10 80       	push   $0x80107d89
80100b66:	e8 05 00 00 00       	call   80100b70 <panic>
80100b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100b70 <panic>:
{
80100b70:	55                   	push   %ebp
80100b71:	89 e5                	mov    %esp,%ebp
80100b73:	56                   	push   %esi
80100b74:	53                   	push   %ebx
80100b75:	83 ec 30             	sub    $0x30,%esp
80100b78:	fa                   	cli
  cons.locking = 0;
80100b79:	c7 05 74 ff 10 80 00 	movl   $0x0,0x8010ff74
80100b80:	00 00 00 
  getcallerpcs(&s, pcs);
80100b83:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100b86:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100b89:	e8 12 29 00 00       	call   801034a0 <lapicid>
80100b8e:	83 ec 08             	sub    $0x8,%esp
80100b91:	50                   	push   %eax
80100b92:	68 92 7d 10 80       	push   $0x80107d92
80100b97:	e8 84 fd ff ff       	call   80100920 <cprintf>
  cprintf(s);
80100b9c:	58                   	pop    %eax
80100b9d:	ff 75 08             	push   0x8(%ebp)
80100ba0:	e8 7b fd ff ff       	call   80100920 <cprintf>
  cprintf("\n");
80100ba5:	c7 04 24 f3 81 10 80 	movl   $0x801081f3,(%esp)
80100bac:	e8 6f fd ff ff       	call   80100920 <cprintf>
  getcallerpcs(&s, pcs);
80100bb1:	8d 45 08             	lea    0x8(%ebp),%eax
80100bb4:	5a                   	pop    %edx
80100bb5:	59                   	pop    %ecx
80100bb6:	53                   	push   %ebx
80100bb7:	50                   	push   %eax
80100bb8:	e8 e3 43 00 00       	call   80104fa0 <getcallerpcs>
  for(i=0; i<10; i++)
80100bbd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100bc0:	83 ec 08             	sub    $0x8,%esp
80100bc3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100bc5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100bc8:	68 a6 7d 10 80       	push   $0x80107da6
80100bcd:	e8 4e fd ff ff       	call   80100920 <cprintf>
  for(i=0; i<10; i++)
80100bd2:	83 c4 10             	add    $0x10,%esp
80100bd5:	39 f3                	cmp    %esi,%ebx
80100bd7:	75 e7                	jne    80100bc0 <panic+0x50>
  panicked = 1; // freeze other CPU
80100bd9:	c7 05 78 ff 10 80 01 	movl   $0x1,0x8010ff78
80100be0:	00 00 00 
  for(;;)
80100be3:	eb fe                	jmp    80100be3 <panic+0x73>
80100be5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100bec:	00 
80100bed:	8d 76 00             	lea    0x0(%esi),%esi

80100bf0 <append_sequence>:
    if (input_sequence.size >= input_sequence.cap) {
80100bf0:	a1 00 92 10 80       	mov    0x80109200,%eax
80100bf5:	3b 05 04 92 10 80    	cmp    0x80109204,%eax
80100bfb:	7d 1b                	jge    80100c18 <append_sequence+0x28>
void append_sequence(int value) {
80100bfd:	55                   	push   %ebp
    input_sequence.data[input_sequence.size++] = value;
80100bfe:	8d 50 01             	lea    0x1(%eax),%edx
80100c01:	89 15 00 92 10 80    	mov    %edx,0x80109200
void append_sequence(int value) {
80100c07:	89 e5                	mov    %esp,%ebp
    input_sequence.data[input_sequence.size++] = value;
80100c09:	8b 55 08             	mov    0x8(%ebp),%edx
}
80100c0c:	5d                   	pop    %ebp
    input_sequence.data[input_sequence.size++] = value;
80100c0d:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
}
80100c14:	c3                   	ret
80100c15:	8d 76 00             	lea    0x0(%esi),%esi
80100c18:	c3                   	ret
80100c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100c20 <delete_from_sequence>:
void delete_from_sequence(int value) {
80100c20:	55                   	push   %ebp
    for (int i = 0; i < input_sequence.size; i++) {
80100c21:	8b 15 00 92 10 80    	mov    0x80109200,%edx
void delete_from_sequence(int value) {
80100c27:	89 e5                	mov    %esp,%ebp
80100c29:	8b 4d 08             	mov    0x8(%ebp),%ecx
    for (int i = 0; i < input_sequence.size; i++) {
80100c2c:	85 d2                	test   %edx,%edx
80100c2e:	7e 3b                	jle    80100c6b <delete_from_sequence+0x4b>
80100c30:	31 c0                	xor    %eax,%eax
80100c32:	eb 0b                	jmp    80100c3f <delete_from_sequence+0x1f>
80100c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c38:	83 c0 01             	add    $0x1,%eax
80100c3b:	39 d0                	cmp    %edx,%eax
80100c3d:	74 2c                	je     80100c6b <delete_from_sequence+0x4b>
        if (input_sequence.data[i] == value) {
80100c3f:	39 0c 85 00 90 10 80 	cmp    %ecx,-0x7fef7000(,%eax,4)
80100c46:	75 f0                	jne    80100c38 <delete_from_sequence+0x18>
    for (int i = idx; i < input_sequence.size - 1; i++)
80100c48:	83 ea 01             	sub    $0x1,%edx
80100c4b:	39 c2                	cmp    %eax,%edx
80100c4d:	7e 16                	jle    80100c65 <delete_from_sequence+0x45>
80100c4f:	90                   	nop
        input_sequence.data[i] = input_sequence.data[i + 1];
80100c50:	83 c0 01             	add    $0x1,%eax
80100c53:	8b 0c 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%ecx
80100c5a:	89 0c 85 fc 8f 10 80 	mov    %ecx,-0x7fef7004(,%eax,4)
    for (int i = idx; i < input_sequence.size - 1; i++)
80100c61:	39 d0                	cmp    %edx,%eax
80100c63:	75 eb                	jne    80100c50 <delete_from_sequence+0x30>
    input_sequence.size--;
80100c65:	89 15 00 92 10 80    	mov    %edx,0x80109200
}
80100c6b:	5d                   	pop    %ebp
80100c6c:	c3                   	ret
80100c6d:	8d 76 00             	lea    0x0(%esi),%esi

80100c70 <last_sequence>:
    if (input_sequence.size == 0) return -1;
80100c70:	a1 00 92 10 80       	mov    0x80109200,%eax
80100c75:	85 c0                	test   %eax,%eax
80100c77:	74 0f                	je     80100c88 <last_sequence+0x18>
    return input_sequence.data[input_sequence.size - 1];
80100c79:	8b 04 85 fc 8f 10 80 	mov    -0x7fef7004(,%eax,4),%eax
80100c80:	c3                   	ret
80100c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (input_sequence.size == 0) return -1;
80100c88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c8d:	c3                   	ret
80100c8e:	66 90                	xchg   %ax,%ax

80100c90 <clear_sequence>:
    input_sequence.size = 0;
80100c90:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80100c97:	00 00 00 
}
80100c9a:	c3                   	ret
80100c9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100ca0 <print_array>:
void print_array(char *buffer){
80100ca0:	55                   	push   %ebp
      for (int i = 0; i < input.e; i++)
80100ca1:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
void print_array(char *buffer){
80100ca6:	89 e5                	mov    %esp,%ebp
80100ca8:	56                   	push   %esi
80100ca9:	8b 75 08             	mov    0x8(%ebp),%esi
80100cac:	53                   	push   %ebx
      for (int i = 0; i < input.e; i++)
80100cad:	85 c0                	test   %eax,%eax
80100caf:	74 1b                	je     80100ccc <print_array+0x2c>
80100cb1:	31 db                	xor    %ebx,%ebx
80100cb3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      cgaputc(buffer[i]);
80100cb8:	0f be 04 1e          	movsbl (%esi,%ebx,1),%eax
      for (int i = 0; i < input.e; i++)
80100cbc:	83 c3 01             	add    $0x1,%ebx
      cgaputc(buffer[i]);
80100cbf:	e8 1c f8 ff ff       	call   801004e0 <cgaputc>
      for (int i = 0; i < input.e; i++)
80100cc4:	3b 1d 28 ff 10 80    	cmp    0x8010ff28,%ebx
80100cca:	72 ec                	jb     80100cb8 <print_array+0x18>
}
80100ccc:	5b                   	pop    %ebx
80100ccd:	5e                   	pop    %esi
80100cce:	5d                   	pop    %ebp
80100ccf:	c3                   	ret

80100cd0 <consoleinit>:

void
consoleinit(void)
{
80100cd0:	55                   	push   %ebp
80100cd1:	89 e5                	mov    %esp,%ebp
80100cd3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100cd6:	68 aa 7d 10 80       	push   $0x80107daa
80100cdb:	68 40 ff 10 80       	push   $0x8010ff40
80100ce0:	e8 9b 42 00 00       	call   80104f80 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100ce5:	58                   	pop    %eax
80100ce6:	5a                   	pop    %edx
80100ce7:	6a 00                	push   $0x0
80100ce9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100ceb:	c7 05 2c 09 11 80 00 	movl   $0x80100800,0x8011092c
80100cf2:	08 10 80 
  devsw[CONSOLE].read = consoleread;
80100cf5:	c7 05 28 09 11 80 80 	movl   $0x80100280,0x80110928
80100cfc:	02 10 80 
  cons.locking = 1;
80100cff:	c7 05 74 ff 10 80 01 	movl   $0x1,0x8010ff74
80100d06:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100d09:	e8 22 23 00 00       	call   80103030 <ioapicenable>
}
80100d0e:	83 c4 10             	add    $0x10,%esp
80100d11:	c9                   	leave
80100d12:	c3                   	ret
80100d13:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d1a:	00 
80100d1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100d20 <move_cursor_left>:





void move_cursor_left(void){
80100d20:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d21:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d26:	89 e5                	mov    %esp,%ebp
80100d28:	56                   	push   %esi
80100d29:	be d4 03 00 00       	mov    $0x3d4,%esi
80100d2e:	53                   	push   %ebx
80100d2f:	89 f2                	mov    %esi,%edx
80100d31:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d32:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100d37:	89 ca                	mov    %ecx,%edx
80100d39:	ec                   	in     (%dx),%al
  int pos;

  // get cursor position
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100d3a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d3d:	89 f2                	mov    %esi,%edx
80100d3f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d44:	c1 e3 08             	shl    $0x8,%ebx
80100d47:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d48:	89 ca                	mov    %ecx,%edx
80100d4a:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100d4b:	0f b6 c8             	movzbl %al,%ecx
80100d4e:	09 d9                	or     %ebx,%ecx




  if(crt[pos - 2] != ('$' | 0x0700))
80100d50:	66 81 bc 09 fc 7f 0b 	cmpw   $0x724,-0x7ff48004(%ecx,%ecx,1)
80100d57:	80 24 07 
80100d5a:	74 03                	je     80100d5f <move_cursor_left+0x3f>
    pos--;
80100d5c:	83 e9 01             	sub    $0x1,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d5f:	be d4 03 00 00       	mov    $0x3d4,%esi
80100d64:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d69:	89 f2                	mov    %esi,%edx
80100d6b:	ee                   	out    %al,(%dx)
80100d6c:	bb d5 03 00 00       	mov    $0x3d5,%ebx

  // reset cursor
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
80100d71:	89 c8                	mov    %ecx,%eax
80100d73:	c1 f8 08             	sar    $0x8,%eax
80100d76:	89 da                	mov    %ebx,%edx
80100d78:	ee                   	out    %al,(%dx)
80100d79:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d7e:	89 f2                	mov    %esi,%edx
80100d80:	ee                   	out    %al,(%dx)
80100d81:	89 c8                	mov    %ecx,%eax
80100d83:	89 da                	mov    %ebx,%edx
80100d85:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
}
80100d86:	5b                   	pop    %ebx
80100d87:	5e                   	pop    %esi
80100d88:	5d                   	pop    %ebp
80100d89:	c3                   	ret
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d90 <consoleintr>:
{
80100d90:	55                   	push   %ebp
80100d91:	89 e5                	mov    %esp,%ebp
80100d93:	57                   	push   %edi
80100d94:	56                   	push   %esi
80100d95:	53                   	push   %ebx
80100d96:	83 ec 28             	sub    $0x28,%esp
80100d99:	8b 45 08             	mov    0x8(%ebp),%eax
80100d9c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  acquire(&cons.lock);
80100d9f:	68 40 ff 10 80       	push   $0x8010ff40
80100da4:	e8 c7 43 00 00       	call   80105170 <acquire>
  while((c = getc()) >= 0){
80100da9:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
80100dac:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((c = getc()) >= 0){
80100db3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100db6:	ff d0                	call   *%eax
80100db8:	89 c3                	mov    %eax,%ebx
80100dba:	85 c0                	test   %eax,%eax
80100dbc:	78 62                	js     80100e20 <consoleintr+0x90>
    switch(c){
80100dbe:	83 fb 1a             	cmp    $0x1a,%ebx
80100dc1:	7f 1d                	jg     80100de0 <consoleintr+0x50>
80100dc3:	85 db                	test   %ebx,%ebx
80100dc5:	74 ec                	je     80100db3 <consoleintr+0x23>
80100dc7:	83 fb 1a             	cmp    $0x1a,%ebx
80100dca:	0f 87 88 00 00 00    	ja     80100e58 <consoleintr+0xc8>
80100dd0:	ff 24 9d 44 82 10 80 	jmp    *-0x7fef7dbc(,%ebx,4)
80100dd7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100dde:	00 
80100ddf:	90                   	nop
80100de0:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100de6:	0f 84 14 05 00 00    	je     80101300 <consoleintr+0x570>
80100dec:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100df2:	75 54                	jne    80100e48 <consoleintr+0xb8>
      int cursor1 = input.e-left_key_pressed_count;
80100df4:	8b 15 28 ff 10 80    	mov    0x8010ff28,%edx
80100dfa:	a1 30 ff 10 80       	mov    0x8010ff30,%eax
80100dff:	89 d1                	mov    %edx,%ecx
80100e01:	29 c1                	sub    %eax,%ecx
      if(input.e>cursor1){
80100e03:	39 d1                	cmp    %edx,%ecx
80100e05:	0f 82 dd 05 00 00    	jb     801013e8 <consoleintr+0x658>
        left_key_pressed=0;
80100e0b:	c7 05 34 ff 10 80 00 	movl   $0x0,0x8010ff34
80100e12:	00 00 00 
  while((c = getc()) >= 0){
80100e15:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e18:	ff d0                	call   *%eax
80100e1a:	89 c3                	mov    %eax,%ebx
80100e1c:	85 c0                	test   %eax,%eax
80100e1e:	79 9e                	jns    80100dbe <consoleintr+0x2e>
  release(&cons.lock);
80100e20:	83 ec 0c             	sub    $0xc,%esp
80100e23:	68 40 ff 10 80       	push   $0x8010ff40
80100e28:	e8 e3 42 00 00       	call   80105110 <release>
  if(doprocdump) {
80100e2d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e30:	83 c4 10             	add    $0x10,%esp
80100e33:	85 c0                	test   %eax,%eax
80100e35:	0f 85 65 05 00 00    	jne    801013a0 <consoleintr+0x610>
}
80100e3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e3e:	5b                   	pop    %ebx
80100e3f:	5e                   	pop    %esi
80100e40:	5f                   	pop    %edi
80100e41:	5d                   	pop    %ebp
80100e42:	c3                   	ret
80100e43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    switch(c){
80100e48:	83 fb 7f             	cmp    $0x7f,%ebx
80100e4b:	0f 84 af 00 00 00    	je     80100f00 <consoleintr+0x170>
80100e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100e58:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100e5d:	89 c2                	mov    %eax,%edx
80100e5f:	2b 15 20 ff 10 80    	sub    0x8010ff20,%edx
80100e65:	83 fa 7f             	cmp    $0x7f,%edx
80100e68:	0f 87 45 ff ff ff    	ja     80100db3 <consoleintr+0x23>
  if(panicked){
80100e6e:	8b 0d 78 ff 10 80    	mov    0x8010ff78,%ecx
          input.buf[(input.e++) % INPUT_BUF] = c;
80100e74:	8d 50 01             	lea    0x1(%eax),%edx
        if (c=='\n')
80100e77:	83 fb 0a             	cmp    $0xa,%ebx
80100e7a:	74 09                	je     80100e85 <consoleintr+0xf5>
80100e7c:	83 fb 0d             	cmp    $0xd,%ebx
80100e7f:	0f 85 23 06 00 00    	jne    801014a8 <consoleintr+0x718>
          input.buf[(input.e++) % INPUT_BUF] = c;
80100e85:	83 e0 7f             	and    $0x7f,%eax
80100e88:	89 15 28 ff 10 80    	mov    %edx,0x8010ff28
80100e8e:	c6 80 a0 fe 10 80 0a 	movb   $0xa,-0x7fef0160(%eax)
    input_sequence.size = 0;
80100e95:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80100e9c:	00 00 00 
  if(panicked){
80100e9f:	85 c9                	test   %ecx,%ecx
80100ea1:	0f 85 f9 05 00 00    	jne    801014a0 <consoleintr+0x710>
    uartputc(c);
80100ea7:	83 ec 0c             	sub    $0xc,%esp
80100eaa:	6a 0a                	push   $0xa
80100eac:	e8 cf 59 00 00       	call   80106880 <uartputc>
  cgaputc(c);
80100eb1:	b8 0a 00 00 00       	mov    $0xa,%eax
80100eb6:	e8 25 f6 ff ff       	call   801004e0 <cgaputc>
          input.w = input.e;
80100ebb:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100ec0:	83 c4 10             	add    $0x10,%esp
    input_sequence.size = 0;
80100ec3:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
80100eca:	00 00 00 
          wakeup(&input.r);
80100ecd:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100ed0:	a3 24 ff 10 80       	mov    %eax,0x8010ff24
          left_key_pressed=0;
80100ed5:	c7 05 34 ff 10 80 00 	movl   $0x0,0x8010ff34
80100edc:	00 00 00 
          left_key_pressed_count=0;
80100edf:	c7 05 30 ff 10 80 00 	movl   $0x0,0x8010ff30
80100ee6:	00 00 00 
          wakeup(&input.r);
80100ee9:	68 20 ff 10 80       	push   $0x8010ff20
80100eee:	e8 bd 3d 00 00       	call   80104cb0 <wakeup>
80100ef3:	83 c4 10             	add    $0x10,%esp
80100ef6:	e9 b8 fe ff ff       	jmp    80100db3 <consoleintr+0x23>
80100efb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(input.e != input.w && input.e - input.w > left_key_pressed_count){
80100f00:	8b 1d 28 ff 10 80    	mov    0x8010ff28,%ebx
80100f06:	a1 24 ff 10 80       	mov    0x8010ff24,%eax
80100f0b:	39 c3                	cmp    %eax,%ebx
80100f0d:	0f 84 a0 fe ff ff    	je     80100db3 <consoleintr+0x23>
80100f13:	89 d9                	mov    %ebx,%ecx
80100f15:	8b 15 30 ff 10 80    	mov    0x8010ff30,%edx
80100f1b:	29 c1                	sub    %eax,%ecx
80100f1d:	39 ca                	cmp    %ecx,%edx
80100f1f:	0f 83 8e fe ff ff    	jae    80100db3 <consoleintr+0x23>
  int shift_idx= shift_from_seq ? last_sequence(): input.e-left_key_pressed_count;
80100f25:	89 df                	mov    %ebx,%edi
80100f27:	89 de                	mov    %ebx,%esi
80100f29:	29 d7                	sub    %edx,%edi
  for (int i = shift_idx - 1; i < input.e; i++)
80100f2b:	8d 57 ff             	lea    -0x1(%edi),%edx
80100f2e:	39 da                	cmp    %ebx,%edx
80100f30:	73 3d                	jae    80100f6f <consoleintr+0x1df>
80100f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
80100f38:	89 d0                	mov    %edx,%eax
80100f3a:	83 c2 01             	add    $0x1,%edx
80100f3d:	89 d3                	mov    %edx,%ebx
80100f3f:	c1 fb 1f             	sar    $0x1f,%ebx
80100f42:	c1 eb 19             	shr    $0x19,%ebx
80100f45:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80100f48:	83 e1 7f             	and    $0x7f,%ecx
80100f4b:	29 d9                	sub    %ebx,%ecx
80100f4d:	0f b6 99 a0 fe 10 80 	movzbl -0x7fef0160(%ecx),%ebx
80100f54:	89 c1                	mov    %eax,%ecx
80100f56:	c1 f9 1f             	sar    $0x1f,%ecx
80100f59:	c1 e9 19             	shr    $0x19,%ecx
80100f5c:	01 c8                	add    %ecx,%eax
80100f5e:	83 e0 7f             	and    $0x7f,%eax
80100f61:	29 c8                	sub    %ecx,%eax
80100f63:	88 98 a0 fe 10 80    	mov    %bl,-0x7fef0160(%eax)
  for (int i = shift_idx - 1; i < input.e; i++)
80100f69:	39 f2                	cmp    %esi,%edx
80100f6b:	72 cb                	jb     80100f38 <consoleintr+0x1a8>
80100f6d:	89 f3                	mov    %esi,%ebx
        delete_from_sequence(input.e-left_key_pressed_count);
80100f6f:	83 ec 0c             	sub    $0xc,%esp
  input.buf[input.e] = ' ';
80100f72:	c6 83 a0 fe 10 80 20 	movb   $0x20,-0x7fef0160(%ebx)
        delete_from_sequence(input.e-left_key_pressed_count);
80100f79:	57                   	push   %edi
80100f7a:	e8 a1 fc ff ff       	call   80100c20 <delete_from_sequence>
        for(int i=0;i<input_sequence.size;i++)
80100f7f:	8b 1d 00 92 10 80    	mov    0x80109200,%ebx
80100f85:	83 c4 10             	add    $0x10,%esp
80100f88:	85 db                	test   %ebx,%ebx
80100f8a:	0f 8e 5e 06 00 00    	jle    801015ee <consoleintr+0x85e>
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
80100f90:	8b 35 28 ff 10 80    	mov    0x8010ff28,%esi
        for(int i=0;i<input_sequence.size;i++)
80100f96:	31 c0                	xor    %eax,%eax
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
80100f98:	89 f1                	mov    %esi,%ecx
80100f9a:	2b 0d 30 ff 10 80    	sub    0x8010ff30,%ecx
80100fa0:	83 e1 7f             	and    $0x7f,%ecx
80100fa3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fa8:	8b 14 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%edx
80100faf:	39 d1                	cmp    %edx,%ecx
80100fb1:	73 0a                	jae    80100fbd <consoleintr+0x22d>
              input_sequence.data[i]--;
80100fb3:	83 ea 01             	sub    $0x1,%edx
80100fb6:	89 14 85 00 90 10 80 	mov    %edx,-0x7fef7000(,%eax,4)
        for(int i=0;i<input_sequence.size;i++)
80100fbd:	83 c0 01             	add    $0x1,%eax
80100fc0:	39 c3                	cmp    %eax,%ebx
80100fc2:	75 e4                	jne    80100fa8 <consoleintr+0x218>
  if(panicked){
80100fc4:	8b 1d 78 ff 10 80    	mov    0x8010ff78,%ebx
        input.e--;
80100fca:	83 ee 01             	sub    $0x1,%esi
80100fcd:	89 35 28 ff 10 80    	mov    %esi,0x8010ff28
  if(panicked){
80100fd3:	85 db                	test   %ebx,%ebx
80100fd5:	0f 84 d0 05 00 00    	je     801015ab <consoleintr+0x81b>
  asm volatile("cli");
80100fdb:	fa                   	cli
    for(;;)
80100fdc:	eb fe                	jmp    80100fdc <consoleintr+0x24c>
80100fde:	66 90                	xchg   %ax,%ax
        cgaputc("0"+input.e);
80100fe0:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80100fe5:	05 b2 7d 10 80       	add    $0x80107db2,%eax
80100fea:	e8 f1 f4 ff ff       	call   801004e0 <cgaputc>
         cgaputc(cga_pos_sequence.pos_data[cga_pos_sequence.size-1]);
80100fef:	a1 20 94 10 80       	mov    0x80109420,%eax
80100ff4:	8b 04 85 1c 92 10 80 	mov    -0x7fef6de4(,%eax,4),%eax
80100ffb:	e8 e0 f4 ff ff       	call   801004e0 <cgaputc>
      break;
80101000:	e9 ae fd ff ff       	jmp    80100db3 <consoleintr+0x23>
        int pos = input.e-left_key_pressed_count;
80101005:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
8010100a:	8b 3d 30 ff 10 80    	mov    0x8010ff30,%edi
80101010:	89 c2                	mov    %eax,%edx
80101012:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101015:	29 fa                	sub    %edi,%edx
        int distance = pos - (input.e-left_key_pressed_count);
80101017:	29 c7                	sub    %eax,%edi
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
80101019:	89 d3                	mov    %edx,%ebx
        int distance = pos - (input.e-left_key_pressed_count);
8010101b:	89 fe                	mov    %edi,%esi
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
8010101d:	c1 fb 1f             	sar    $0x1f,%ebx
80101020:	c1 eb 19             	shr    $0x19,%ebx
80101023:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80101026:	83 e1 7f             	and    $0x7f,%ecx
80101029:	29 d9                	sub    %ebx,%ecx
8010102b:	80 b9 a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ecx)
80101032:	74 2c                	je     80101060 <consoleintr+0x2d0>
80101034:	39 c2                	cmp    %eax,%edx
80101036:	72 0c                	jb     80101044 <consoleintr+0x2b4>
80101038:	e9 b6 00 00 00       	jmp    801010f3 <consoleintr+0x363>
8010103d:	8d 76 00             	lea    0x0(%esi),%esi
80101040:	39 c2                	cmp    %eax,%edx
80101042:	73 38                	jae    8010107c <consoleintr+0x2ec>
            pos++;
80101044:	83 c2 01             	add    $0x1,%edx
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
80101047:	89 d3                	mov    %edx,%ebx
80101049:	c1 fb 1f             	sar    $0x1f,%ebx
8010104c:	c1 eb 19             	shr    $0x19,%ebx
8010104f:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80101052:	83 e1 7f             	and    $0x7f,%ecx
80101055:	29 d9                	sub    %ebx,%ecx
80101057:	80 b9 a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ecx)
8010105e:	75 e0                	jne    80101040 <consoleintr+0x2b0>
            pos++;
80101060:	83 c2 01             	add    $0x1,%edx
            while (input.buf[pos % INPUT_BUF] == ' '){
80101063:	89 d3                	mov    %edx,%ebx
80101065:	c1 fb 1f             	sar    $0x1f,%ebx
80101068:	c1 eb 19             	shr    $0x19,%ebx
8010106b:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
8010106e:	83 e1 7f             	and    $0x7f,%ecx
80101071:	29 d9                	sub    %ebx,%ecx
80101073:	80 b9 a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ecx)
8010107a:	74 e4                	je     80101060 <consoleintr+0x2d0>
        left_key_pressed_count = input.e-pos;
8010107c:	29 d0                	sub    %edx,%eax
        int distance = pos - (input.e-left_key_pressed_count);
8010107e:	01 f2                	add    %esi,%edx
        left_key_pressed_count = input.e-pos;
80101080:	89 45 d8             	mov    %eax,-0x28(%ebp)
        for (int i = 0; i < distance; i++)
80101083:	85 d2                	test   %edx,%edx
80101085:	7e 6c                	jle    801010f3 <consoleintr+0x363>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101087:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010108a:	31 f6                	xor    %esi,%esi
8010108c:	bf 0e 00 00 00       	mov    $0xe,%edi
80101091:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80101096:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010109d:	00 
8010109e:	66 90                	xchg   %ax,%ax
801010a0:	89 f8                	mov    %edi,%eax
801010a2:	89 da                	mov    %ebx,%edx
801010a4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801010a5:	ba d5 03 00 00       	mov    $0x3d5,%edx
801010aa:	ec                   	in     (%dx),%al

void move_cursor_right(void) {
    int pos;

    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
801010ab:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801010ae:	89 da                	mov    %ebx,%edx
801010b0:	b8 0f 00 00 00       	mov    $0xf,%eax
801010b5:	c1 e1 08             	shl    $0x8,%ecx
801010b8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801010b9:	ba d5 03 00 00       	mov    $0x3d5,%edx
801010be:	ec                   	in     (%dx),%al
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
801010bf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801010c2:	89 da                	mov    %ebx,%edx
801010c4:	09 c1                	or     %eax,%ecx
801010c6:	89 f8                	mov    %edi,%eax

    pos++;
801010c8:	83 c1 01             	add    $0x1,%ecx
801010cb:	ee                   	out    %al,(%dx)

    outb(CRTPORT, 14);
    outb(CRTPORT+1, pos >> 8);
801010cc:	89 ca                	mov    %ecx,%edx
801010ce:	c1 fa 08             	sar    $0x8,%edx
801010d1:	89 d0                	mov    %edx,%eax
801010d3:	ba d5 03 00 00       	mov    $0x3d5,%edx
801010d8:	ee                   	out    %al,(%dx)
801010d9:	b8 0f 00 00 00       	mov    $0xf,%eax
801010de:	89 da                	mov    %ebx,%edx
801010e0:	ee                   	out    %al,(%dx)
801010e1:	ba d5 03 00 00       	mov    $0x3d5,%edx
801010e6:	89 c8                	mov    %ecx,%eax
801010e8:	ee                   	out    %al,(%dx)
        for (int i = 0; i < distance; i++)
801010e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ec:	83 c6 01             	add    $0x1,%esi
801010ef:	39 c6                	cmp    %eax,%esi
801010f1:	75 ad                	jne    801010a0 <consoleintr+0x310>
        left_key_pressed_count = input.e-pos;
801010f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
801010f6:	a3 30 ff 10 80       	mov    %eax,0x8010ff30
        break;
801010fb:	e9 b3 fc ff ff       	jmp    80100db3 <consoleintr+0x23>
      if(input.e != input.w){
80101100:	a1 24 ff 10 80       	mov    0x8010ff24,%eax
80101105:	39 05 28 ff 10 80    	cmp    %eax,0x8010ff28
8010110b:	0f 84 a2 fc ff ff    	je     80100db3 <consoleintr+0x23>
    if (input_sequence.size == 0) return -1;
80101111:	a1 00 92 10 80       	mov    0x80109200,%eax
    return input_sequence.data[input_sequence.size - 1];
80101116:	8d 50 ff             	lea    -0x1(%eax),%edx
    if (input_sequence.size == 0) return -1;
80101119:	85 c0                	test   %eax,%eax
8010111b:	0f 84 be 04 00 00    	je     801015df <consoleintr+0x84f>
  for (int i = shift_idx - 1; i < input.e; i++)
80101121:	8b 04 95 00 90 10 80 	mov    -0x7fef7000(,%edx,4),%eax
80101128:	8d 58 ff             	lea    -0x1(%eax),%ebx
8010112b:	89 de                	mov    %ebx,%esi
    (delete_from_sequence(input_sequence.size-1));
8010112d:	83 ec 0c             	sub    $0xc,%esp
80101130:	52                   	push   %edx
80101131:	e8 ea fa ff ff       	call   80100c20 <delete_from_sequence>
  for (int i = shift_idx - 1; i < input.e; i++)
80101136:	8b 0d 28 ff 10 80    	mov    0x8010ff28,%ecx
8010113c:	83 c4 10             	add    $0x10,%esp
8010113f:	39 ce                	cmp    %ecx,%esi
80101141:	73 38                	jae    8010117b <consoleintr+0x3eb>
80101143:	89 ce                	mov    %ecx,%esi
80101145:	8d 76 00             	lea    0x0(%esi),%esi
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
80101148:	89 d8                	mov    %ebx,%eax
8010114a:	83 c3 01             	add    $0x1,%ebx
8010114d:	89 d9                	mov    %ebx,%ecx
8010114f:	c1 f9 1f             	sar    $0x1f,%ecx
80101152:	c1 e9 19             	shr    $0x19,%ecx
80101155:	8d 14 0b             	lea    (%ebx,%ecx,1),%edx
80101158:	83 e2 7f             	and    $0x7f,%edx
8010115b:	29 ca                	sub    %ecx,%edx
8010115d:	0f b6 8a a0 fe 10 80 	movzbl -0x7fef0160(%edx),%ecx
80101164:	99                   	cltd
80101165:	c1 ea 19             	shr    $0x19,%edx
80101168:	01 d0                	add    %edx,%eax
8010116a:	83 e0 7f             	and    $0x7f,%eax
8010116d:	29 d0                	sub    %edx,%eax
8010116f:	88 88 a0 fe 10 80    	mov    %cl,-0x7fef0160(%eax)
  for (int i = shift_idx - 1; i < input.e; i++)
80101175:	39 f3                	cmp    %esi,%ebx
80101177:	72 cf                	jb     80101148 <consoleintr+0x3b8>
80101179:	89 f1                	mov    %esi,%ecx
  if(panicked){
8010117b:	8b 15 78 ff 10 80    	mov    0x8010ff78,%edx
  input.buf[input.e] = ' ';
80101181:	c6 81 a0 fe 10 80 20 	movb   $0x20,-0x7fef0160(%ecx)
        input.e--;
80101188:	83 e9 01             	sub    $0x1,%ecx
8010118b:	89 0d 28 ff 10 80    	mov    %ecx,0x8010ff28
  if(panicked){
80101191:	85 d2                	test   %edx,%edx
80101193:	0f 84 aa 02 00 00    	je     80101443 <consoleintr+0x6b3>
  asm volatile("cli");
80101199:	fa                   	cli
    for(;;)
8010119a:	eb fe                	jmp    8010119a <consoleintr+0x40a>
8010119c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
801011a0:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
801011a5:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
801011ab:	0f 84 02 fc ff ff    	je     80100db3 <consoleintr+0x23>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801011b1:	83 e8 01             	sub    $0x1,%eax
801011b4:	89 c2                	mov    %eax,%edx
801011b6:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801011b9:	80 ba a0 fe 10 80 0a 	cmpb   $0xa,-0x7fef0160(%edx)
801011c0:	0f 84 ed fb ff ff    	je     80100db3 <consoleintr+0x23>
  if(panicked){
801011c6:	8b 35 78 ff 10 80    	mov    0x8010ff78,%esi
        input.e--;
801011cc:	a3 28 ff 10 80       	mov    %eax,0x8010ff28
  if(panicked){
801011d1:	85 f6                	test   %esi,%esi
801011d3:	0f 84 67 01 00 00    	je     80101340 <consoleintr+0x5b0>
801011d9:	fa                   	cli
    for(;;)
801011da:	eb fe                	jmp    801011da <consoleintr+0x44a>
801011dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
         int posA = input.e-left_key_pressed_count;
801011e0:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
801011e5:	89 c2                	mov    %eax,%edx
801011e7:	2b 15 30 ff 10 80    	sub    0x8010ff30,%edx
801011ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
801011f0:	89 d1                	mov    %edx,%ecx
         int posA = input.e-left_key_pressed_count;
801011f2:	89 d0                	mov    %edx,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
801011f4:	89 d3                	mov    %edx,%ebx
801011f6:	c1 f9 1f             	sar    $0x1f,%ecx
801011f9:	c1 e9 19             	shr    $0x19,%ecx
801011fc:	8d 34 0a             	lea    (%edx,%ecx,1),%esi
801011ff:	83 e6 7f             	and    $0x7f,%esi
80101202:	29 ce                	sub    %ecx,%esi
      while(input.e != input.w &&
80101204:	8b 0d 24 ff 10 80    	mov    0x8010ff24,%ecx
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
8010120a:	80 be 9f fe 10 80 20 	cmpb   $0x20,-0x7fef0161(%esi)
80101211:	74 25                	je     80101238 <consoleintr+0x4a8>
80101213:	eb 29                	jmp    8010123e <consoleintr+0x4ae>
80101215:	8d 76 00             	lea    0x0(%esi),%esi
            posA--;
80101218:	83 e8 01             	sub    $0x1,%eax
        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
8010121b:	89 c3                	mov    %eax,%ebx
8010121d:	c1 fb 1f             	sar    $0x1f,%ebx
80101220:	c1 eb 19             	shr    $0x19,%ebx
80101223:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80101226:	83 e6 7f             	and    $0x7f,%esi
80101229:	29 de                	sub    %ebx,%esi
8010122b:	80 be 9f fe 10 80 20 	cmpb   $0x20,-0x7fef0161(%esi)
80101232:	0f 85 8f 01 00 00    	jne    801013c7 <consoleintr+0x637>
80101238:	89 c3                	mov    %eax,%ebx
8010123a:	39 c1                	cmp    %eax,%ecx
8010123c:	72 da                	jb     80101218 <consoleintr+0x488>
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
8010123e:	80 be a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%esi)
80101245:	0f 84 8b 01 00 00    	je     801013d6 <consoleintr+0x646>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
8010124b:	89 c7                	mov    %eax,%edi
8010124d:	c1 ff 1f             	sar    $0x1f,%edi
80101250:	c1 ef 19             	shr    $0x19,%edi
80101253:	8d 34 38             	lea    (%eax,%edi,1),%esi
80101256:	83 e6 7f             	and    $0x7f,%esi
80101259:	29 fe                	sub    %edi,%esi
8010125b:	80 be a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%esi)
80101262:	75 2c                	jne    80101290 <consoleintr+0x500>
80101264:	e9 51 01 00 00       	jmp    801013ba <consoleintr+0x62a>
80101269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            posA--;
80101270:	83 e8 01             	sub    $0x1,%eax
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
80101273:	89 c6                	mov    %eax,%esi
80101275:	c1 fe 1f             	sar    $0x1f,%esi
80101278:	c1 ee 19             	shr    $0x19,%esi
8010127b:	8d 1c 30             	lea    (%eax,%esi,1),%ebx
8010127e:	83 e3 7f             	and    $0x7f,%ebx
80101281:	29 f3                	sub    %esi,%ebx
80101283:	80 bb a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%ebx)
8010128a:	0f 84 28 01 00 00    	je     801013b8 <consoleintr+0x628>
80101290:	89 c3                	mov    %eax,%ebx
80101292:	39 c1                	cmp    %eax,%ecx
80101294:	72 da                	jb     80101270 <consoleintr+0x4e0>
        int distanceA = input.e-left_key_pressed_count-posA;
80101296:	89 d6                	mov    %edx,%esi
80101298:	29 de                	sub    %ebx,%esi
        for (int i = distanceA; i > 0; i--)
8010129a:	85 f6                	test   %esi,%esi
8010129c:	7e 29                	jle    801012c7 <consoleintr+0x537>
8010129e:	8d 7e ff             	lea    -0x1(%esi),%edi
801012a1:	f7 c6 01 00 00 00    	test   $0x1,%esi
801012a7:	74 0f                	je     801012b8 <consoleintr+0x528>
            move_cursor_left();
801012a9:	e8 72 fa ff ff       	call   80100d20 <move_cursor_left>
        for (int i = distanceA; i > 0; i--)
801012ae:	89 fe                	mov    %edi,%esi
801012b0:	85 ff                	test   %edi,%edi
801012b2:	74 13                	je     801012c7 <consoleintr+0x537>
801012b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            move_cursor_left();
801012b8:	e8 63 fa ff ff       	call   80100d20 <move_cursor_left>
801012bd:	e8 5e fa ff ff       	call   80100d20 <move_cursor_left>
        for (int i = distanceA; i > 0; i--)
801012c2:	83 ee 02             	sub    $0x2,%esi
801012c5:	75 f1                	jne    801012b8 <consoleintr+0x528>
        left_key_pressed_count = input.e-posA;     
801012c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801012ca:	29 d8                	sub    %ebx,%eax
801012cc:	a3 30 ff 10 80       	mov    %eax,0x8010ff30
      break;
801012d1:	e9 dd fa ff ff       	jmp    80100db3 <consoleintr+0x23>
      input.tabr=input.r;
801012d6:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
      wakeup(&input.r);
801012db:	83 ec 0c             	sub    $0xc,%esp
      tab_flag=1;
801012de:	c7 05 80 fe 10 80 01 	movl   $0x1,0x8010fe80
801012e5:	00 00 00 
      input.tabr=input.r;
801012e8:	a3 2c ff 10 80       	mov    %eax,0x8010ff2c
      wakeup(&input.r);
801012ed:	68 20 ff 10 80       	push   $0x8010ff20
801012f2:	e8 b9 39 00 00       	call   80104cb0 <wakeup>
      break;
801012f7:	83 c4 10             	add    $0x10,%esp
801012fa:	e9 b4 fa ff ff       	jmp    80100db3 <consoleintr+0x23>
801012ff:	90                   	nop
        int cursor = input.e-left_key_pressed_count;
80101300:	8b 1d 30 ff 10 80    	mov    0x8010ff30,%ebx
80101306:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
8010130b:	29 d8                	sub    %ebx,%eax
        if (input.w < cursor)
8010130d:	39 05 24 ff 10 80    	cmp    %eax,0x8010ff24
80101313:	0f 83 9a fa ff ff    	jae    80100db3 <consoleintr+0x23>
          if (left_key_pressed==0)
80101319:	8b 0d 34 ff 10 80    	mov    0x8010ff34,%ecx
8010131f:	85 c9                	test   %ecx,%ecx
80101321:	75 0a                	jne    8010132d <consoleintr+0x59d>
            left_key_pressed=1;
80101323:	c7 05 34 ff 10 80 01 	movl   $0x1,0x8010ff34
8010132a:	00 00 00 
          move_cursor_left();
8010132d:	e8 ee f9 ff ff       	call   80100d20 <move_cursor_left>
          left_key_pressed_count++;
80101332:	83 c3 01             	add    $0x1,%ebx
80101335:	89 1d 30 ff 10 80    	mov    %ebx,0x8010ff30
8010133b:	e9 73 fa ff ff       	jmp    80100db3 <consoleintr+0x23>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101340:	83 ec 0c             	sub    $0xc,%esp
80101343:	6a 08                	push   $0x8
80101345:	e8 36 55 00 00       	call   80106880 <uartputc>
8010134a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101351:	e8 2a 55 00 00       	call   80106880 <uartputc>
80101356:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010135d:	e8 1e 55 00 00       	call   80106880 <uartputc>
  cgaputc(c);
80101362:	b8 00 01 00 00       	mov    $0x100,%eax
80101367:	e8 74 f1 ff ff       	call   801004e0 <cgaputc>
      while(input.e != input.w &&
8010136c:	a1 28 ff 10 80       	mov    0x8010ff28,%eax
80101371:	83 c4 10             	add    $0x10,%esp
    input_sequence.size = 0;
80101374:	c7 05 00 92 10 80 00 	movl   $0x0,0x80109200
8010137b:	00 00 00 
    cga_pos_sequence.size = 0;
8010137e:	c7 05 20 94 10 80 00 	movl   $0x0,0x80109420
80101385:	00 00 00 
      while(input.e != input.w &&
80101388:	3b 05 24 ff 10 80    	cmp    0x8010ff24,%eax
8010138e:	0f 85 1d fe ff ff    	jne    801011b1 <consoleintr+0x421>
80101394:	e9 1a fa ff ff       	jmp    80100db3 <consoleintr+0x23>
80101399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801013a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013a3:	5b                   	pop    %ebx
801013a4:	5e                   	pop    %esi
801013a5:	5f                   	pop    %edi
801013a6:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
801013a7:	e9 e4 39 00 00       	jmp    80104d90 <procdump>
    switch(c){
801013ac:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
801013b3:	e9 fb f9 ff ff       	jmp    80100db3 <consoleintr+0x23>
        int distanceA = input.e-left_key_pressed_count-posA;
801013b8:	89 c3                	mov    %eax,%ebx
          posA++;
801013ba:	83 c0 01             	add    $0x1,%eax
801013bd:	39 d9                	cmp    %ebx,%ecx
801013bf:	0f 42 d8             	cmovb  %eax,%ebx
801013c2:	e9 cf fe ff ff       	jmp    80101296 <consoleintr+0x506>
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
801013c7:	80 be a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%esi)
801013ce:	89 c3                	mov    %eax,%ebx
801013d0:	0f 85 75 fe ff ff    	jne    8010124b <consoleintr+0x4bb>
801013d6:	39 d9                	cmp    %ebx,%ecx
801013d8:	0f 83 99 00 00 00    	jae    80101477 <consoleintr+0x6e7>
          posA--;
801013de:	83 e8 01             	sub    $0x1,%eax
        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
801013e1:	89 c3                	mov    %eax,%ebx
801013e3:	e9 63 fe ff ff       	jmp    8010124b <consoleintr+0x4bb>
        left_key_pressed_count--;
801013e8:	83 e8 01             	sub    $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801013eb:	bf 0e 00 00 00       	mov    $0xe,%edi
801013f0:	be d4 03 00 00       	mov    $0x3d4,%esi
801013f5:	a3 30 ff 10 80       	mov    %eax,0x8010ff30
801013fa:	89 f2                	mov    %esi,%edx
801013fc:	89 f8                	mov    %edi,%eax
801013fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801013ff:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80101404:	89 da                	mov    %ebx,%edx
80101406:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80101407:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010140a:	89 f2                	mov    %esi,%edx
8010140c:	c1 e0 08             	shl    $0x8,%eax
8010140f:	89 c1                	mov    %eax,%ecx
80101411:	b8 0f 00 00 00       	mov    $0xf,%eax
80101416:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101417:	89 da                	mov    %ebx,%edx
80101419:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
8010141a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010141d:	89 f2                	mov    %esi,%edx
8010141f:	09 c1                	or     %eax,%ecx
80101421:	89 f8                	mov    %edi,%eax
    pos++;
80101423:	83 c1 01             	add    $0x1,%ecx
80101426:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80101427:	89 cf                	mov    %ecx,%edi
80101429:	89 da                	mov    %ebx,%edx
8010142b:	c1 ff 08             	sar    $0x8,%edi
8010142e:	89 f8                	mov    %edi,%eax
80101430:	ee                   	out    %al,(%dx)
80101431:	b8 0f 00 00 00       	mov    $0xf,%eax
80101436:	89 f2                	mov    %esi,%edx
80101438:	ee                   	out    %al,(%dx)
80101439:	89 c8                	mov    %ecx,%eax
8010143b:	89 da                	mov    %ebx,%edx
8010143d:	ee                   	out    %al,(%dx)
    outb(CRTPORT, 15);
    outb(CRTPORT+1, pos);
}
8010143e:	e9 70 f9 ff ff       	jmp    80100db3 <consoleintr+0x23>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101443:	83 ec 0c             	sub    $0xc,%esp
80101446:	6a 08                	push   $0x8
80101448:	e8 33 54 00 00       	call   80106880 <uartputc>
8010144d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101454:	e8 27 54 00 00       	call   80106880 <uartputc>
80101459:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101460:	e8 1b 54 00 00       	call   80106880 <uartputc>
  cgaputc(c);
80101465:	b8 01 01 00 00       	mov    $0x101,%eax
8010146a:	e8 71 f0 ff ff       	call   801004e0 <cgaputc>
}
8010146f:	83 c4 10             	add    $0x10,%esp
80101472:	e9 3c f9 ff ff       	jmp    80100db3 <consoleintr+0x23>
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
80101477:	89 c7                	mov    %eax,%edi
80101479:	c1 ff 1f             	sar    $0x1f,%edi
8010147c:	c1 ef 19             	shr    $0x19,%edi
8010147f:	8d 34 38             	lea    (%eax,%edi,1),%esi
80101482:	83 e6 7f             	and    $0x7f,%esi
80101485:	29 fe                	sub    %edi,%esi
80101487:	80 be a0 fe 10 80 20 	cmpb   $0x20,-0x7fef0160(%esi)
8010148e:	0f 85 fc fd ff ff    	jne    80101290 <consoleintr+0x500>
80101494:	e9 fd fd ff ff       	jmp    80101296 <consoleintr+0x506>
80101499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cli");
801014a0:	fa                   	cli
    for(;;)
801014a1:	eb fe                	jmp    801014a1 <consoleintr+0x711>
801014a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
   int cursor= input.e-left_key_pressed_count;
801014a8:	89 c6                	mov    %eax,%esi
801014aa:	2b 35 30 ff 10 80    	sub    0x8010ff30,%esi
  for (int i = input.e; i > cursor; i--)
801014b0:	39 c6                	cmp    %eax,%esi
801014b2:	7d 45                	jge    801014f9 <consoleintr+0x769>
801014b4:	89 5d e0             	mov    %ebx,-0x20(%ebp)
801014b7:	89 cf                	mov    %ecx,%edi
801014b9:	89 55 d8             	mov    %edx,-0x28(%ebp)
    input.buf[(i) % INPUT_BUF] = input.buf[(i-1) % INPUT_BUF]; // Shift elements to right
801014bc:	89 c2                	mov    %eax,%edx
801014be:	83 e8 01             	sub    $0x1,%eax
801014c1:	89 c3                	mov    %eax,%ebx
801014c3:	c1 fb 1f             	sar    $0x1f,%ebx
801014c6:	c1 eb 19             	shr    $0x19,%ebx
801014c9:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801014cc:	83 e1 7f             	and    $0x7f,%ecx
801014cf:	29 d9                	sub    %ebx,%ecx
801014d1:	89 d3                	mov    %edx,%ebx
801014d3:	c1 fb 1f             	sar    $0x1f,%ebx
801014d6:	0f b6 89 a0 fe 10 80 	movzbl -0x7fef0160(%ecx),%ecx
801014dd:	c1 eb 19             	shr    $0x19,%ebx
801014e0:	01 da                	add    %ebx,%edx
801014e2:	83 e2 7f             	and    $0x7f,%edx
801014e5:	29 da                	sub    %ebx,%edx
801014e7:	88 8a a0 fe 10 80    	mov    %cl,-0x7fef0160(%edx)
  for (int i = input.e; i > cursor; i--)
801014ed:	39 c6                	cmp    %eax,%esi
801014ef:	75 cb                	jne    801014bc <consoleintr+0x72c>
801014f1:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801014f4:	8b 55 d8             	mov    -0x28(%ebp),%edx
801014f7:	89 f9                	mov    %edi,%ecx
    if (input_sequence.size >= input_sequence.cap) {
801014f9:	8b 3d 00 92 10 80    	mov    0x80109200,%edi
801014ff:	83 e6 7f             	and    $0x7f,%esi
80101502:	3b 3d 04 92 10 80    	cmp    0x80109204,%edi
80101508:	7d 11                	jge    8010151b <consoleintr+0x78b>
    input_sequence.data[input_sequence.size++] = value;
8010150a:	8d 47 01             	lea    0x1(%edi),%eax
8010150d:	89 34 bd 00 90 10 80 	mov    %esi,-0x7fef7000(,%edi,4)
80101514:	a3 00 92 10 80       	mov    %eax,0x80109200
80101519:	89 c7                	mov    %eax,%edi
          for(int i=0;i<input_sequence.size;i++)
8010151b:	31 c0                	xor    %eax,%eax
8010151d:	85 ff                	test   %edi,%edi
8010151f:	7e 22                	jle    80101543 <consoleintr+0x7b3>
80101521:	89 5d e0             	mov    %ebx,-0x20(%ebp)
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
80101524:	8b 1c 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%ebx
8010152b:	39 de                	cmp    %ebx,%esi
8010152d:	73 0a                	jae    80101539 <consoleintr+0x7a9>
              input_sequence.data[i]++;
8010152f:	83 c3 01             	add    $0x1,%ebx
80101532:	89 1c 85 00 90 10 80 	mov    %ebx,-0x7fef7000(,%eax,4)
          for(int i=0;i<input_sequence.size;i++)
80101539:	83 c0 01             	add    $0x1,%eax
8010153c:	39 f8                	cmp    %edi,%eax
8010153e:	75 e4                	jne    80101524 <consoleintr+0x794>
80101540:	8b 5d e0             	mov    -0x20(%ebp),%ebx
          input.buf[(input.e++-left_key_pressed_count) % INPUT_BUF] = c;
80101543:	89 15 28 ff 10 80    	mov    %edx,0x8010ff28
80101549:	88 9e a0 fe 10 80    	mov    %bl,-0x7fef0160(%esi)
  if(panicked){
8010154f:	85 c9                	test   %ecx,%ecx
80101551:	0f 85 49 ff ff ff    	jne    801014a0 <consoleintr+0x710>
  if(c == BACKSPACE || c==UNDO_BS){
80101557:	8d 83 00 ff ff ff    	lea    -0x100(%ebx),%eax
8010155d:	83 f8 01             	cmp    $0x1,%eax
80101560:	0f 87 93 00 00 00    	ja     801015f9 <consoleintr+0x869>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101566:	83 ec 0c             	sub    $0xc,%esp
80101569:	6a 08                	push   $0x8
8010156b:	e8 10 53 00 00       	call   80106880 <uartputc>
80101570:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101577:	e8 04 53 00 00       	call   80106880 <uartputc>
8010157c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101583:	e8 f8 52 00 00       	call   80106880 <uartputc>
  cgaputc(c);
80101588:	89 d8                	mov    %ebx,%eax
8010158a:	e8 51 ef ff ff       	call   801004e0 <cgaputc>
8010158f:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80101592:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
80101597:	83 e8 80             	sub    $0xffffff80,%eax
8010159a:	39 05 28 ff 10 80    	cmp    %eax,0x8010ff28
801015a0:	0f 85 0d f8 ff ff    	jne    80100db3 <consoleintr+0x23>
801015a6:	e9 22 f9 ff ff       	jmp    80100ecd <consoleintr+0x13d>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801015ab:	83 ec 0c             	sub    $0xc,%esp
801015ae:	6a 08                	push   $0x8
801015b0:	e8 cb 52 00 00       	call   80106880 <uartputc>
801015b5:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801015bc:	e8 bf 52 00 00       	call   80106880 <uartputc>
801015c1:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801015c8:	e8 b3 52 00 00       	call   80106880 <uartputc>
  cgaputc(c);
801015cd:	b8 00 01 00 00       	mov    $0x100,%eax
801015d2:	e8 09 ef ff ff       	call   801004e0 <cgaputc>
}
801015d7:	83 c4 10             	add    $0x10,%esp
801015da:	e9 d4 f7 ff ff       	jmp    80100db3 <consoleintr+0x23>
801015df:	be fe ff ff ff       	mov    $0xfffffffe,%esi
801015e4:	bb fe ff ff ff       	mov    $0xfffffffe,%ebx
801015e9:	e9 3f fb ff ff       	jmp    8010112d <consoleintr+0x39d>
        input.e--;
801015ee:	8b 35 28 ff 10 80    	mov    0x8010ff28,%esi
801015f4:	e9 cb f9 ff ff       	jmp    80100fc4 <consoleintr+0x234>
    uartputc(c);
801015f9:	83 ec 0c             	sub    $0xc,%esp
801015fc:	53                   	push   %ebx
801015fd:	e8 7e 52 00 00       	call   80106880 <uartputc>
  cgaputc(c);
80101602:	89 d8                	mov    %ebx,%eax
80101604:	e8 d7 ee ff ff       	call   801004e0 <cgaputc>
80101609:	83 c4 10             	add    $0x10,%esp
8010160c:	eb 84                	jmp    80101592 <consoleintr+0x802>
8010160e:	66 90                	xchg   %ax,%ax

80101610 <move_cursor_right>:
void move_cursor_right(void) {
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	57                   	push   %edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101614:	bf 0e 00 00 00       	mov    $0xe,%edi
80101619:	56                   	push   %esi
8010161a:	89 f8                	mov    %edi,%eax
8010161c:	53                   	push   %ebx
8010161d:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80101622:	89 da                	mov    %ebx,%edx
80101624:	83 ec 04             	sub    $0x4,%esp
80101627:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101628:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010162d:	89 ca                	mov    %ecx,%edx
8010162f:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80101630:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101633:	be 0f 00 00 00       	mov    $0xf,%esi
80101638:	89 da                	mov    %ebx,%edx
8010163a:	c1 e0 08             	shl    $0x8,%eax
8010163d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101640:	89 f0                	mov    %esi,%eax
80101642:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101643:	89 ca                	mov    %ecx,%edx
80101645:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80101646:	8b 55 f0             	mov    -0x10(%ebp),%edx
80101649:	0f b6 c0             	movzbl %al,%eax
8010164c:	09 d0                	or     %edx,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010164e:	89 da                	mov    %ebx,%edx
    pos++;
80101650:	83 c0 01             	add    $0x1,%eax
80101653:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101656:	89 f8                	mov    %edi,%eax
80101658:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos >> 8);
80101659:	8b 7d f0             	mov    -0x10(%ebp),%edi
8010165c:	89 ca                	mov    %ecx,%edx
8010165e:	89 f8                	mov    %edi,%eax
80101660:	c1 f8 08             	sar    $0x8,%eax
80101663:	ee                   	out    %al,(%dx)
80101664:	89 f0                	mov    %esi,%eax
80101666:	89 da                	mov    %ebx,%edx
80101668:	ee                   	out    %al,(%dx)
80101669:	89 f8                	mov    %edi,%eax
8010166b:	89 ca                	mov    %ecx,%edx
8010166d:	ee                   	out    %al,(%dx)
}
8010166e:	83 c4 04             	add    $0x4,%esp
80101671:	5b                   	pop    %ebx
80101672:	5e                   	pop    %esi
80101673:	5f                   	pop    %edi
80101674:	5d                   	pop    %ebp
80101675:	c3                   	ret
80101676:	66 90                	xchg   %ax,%ax
80101678:	66 90                	xchg   %ax,%ax
8010167a:	66 90                	xchg   %ax,%ax
8010167c:	66 90                	xchg   %ax,%ax
8010167e:	66 90                	xchg   %ax,%ax

80101680 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	57                   	push   %edi
80101684:	56                   	push   %esi
80101685:	53                   	push   %ebx
80101686:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
8010168c:	e8 9f 2e 00 00       	call   80104530 <myproc>
80101691:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101697:	e8 74 22 00 00       	call   80103910 <begin_op>

  if((ip = namei(path)) == 0){
8010169c:	83 ec 0c             	sub    $0xc,%esp
8010169f:	ff 75 08             	push   0x8(%ebp)
801016a2:	e8 a9 15 00 00       	call   80102c50 <namei>
801016a7:	83 c4 10             	add    $0x10,%esp
801016aa:	85 c0                	test   %eax,%eax
801016ac:	0f 84 30 03 00 00    	je     801019e2 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801016b2:	83 ec 0c             	sub    $0xc,%esp
801016b5:	89 c7                	mov    %eax,%edi
801016b7:	50                   	push   %eax
801016b8:	e8 b3 0c 00 00       	call   80102370 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801016bd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801016c3:	6a 34                	push   $0x34
801016c5:	6a 00                	push   $0x0
801016c7:	50                   	push   %eax
801016c8:	57                   	push   %edi
801016c9:	e8 b2 0f 00 00       	call   80102680 <readi>
801016ce:	83 c4 20             	add    $0x20,%esp
801016d1:	83 f8 34             	cmp    $0x34,%eax
801016d4:	0f 85 01 01 00 00    	jne    801017db <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
801016da:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
801016e1:	45 4c 46 
801016e4:	0f 85 f1 00 00 00    	jne    801017db <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
801016ea:	e8 01 63 00 00       	call   801079f0 <setupkvm>
801016ef:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
801016f5:	85 c0                	test   %eax,%eax
801016f7:	0f 84 de 00 00 00    	je     801017db <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801016fd:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101704:	00 
80101705:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
8010170b:	0f 84 a1 02 00 00    	je     801019b2 <exec+0x332>
  sz = 0;
80101711:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101718:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010171b:	31 db                	xor    %ebx,%ebx
8010171d:	e9 8c 00 00 00       	jmp    801017ae <exec+0x12e>
80101722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80101728:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
8010172f:	75 6c                	jne    8010179d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80101731:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80101737:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
8010173d:	0f 82 87 00 00 00    	jb     801017ca <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80101743:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101749:	72 7f                	jb     801017ca <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
8010174b:	83 ec 04             	sub    $0x4,%esp
8010174e:	50                   	push   %eax
8010174f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80101755:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010175b:	e8 c0 60 00 00       	call   80107820 <allocuvm>
80101760:	83 c4 10             	add    $0x10,%esp
80101763:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101769:	85 c0                	test   %eax,%eax
8010176b:	74 5d                	je     801017ca <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
8010176d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80101773:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101778:	75 50                	jne    801017ca <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
8010177a:	83 ec 0c             	sub    $0xc,%esp
8010177d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80101783:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101789:	57                   	push   %edi
8010178a:	50                   	push   %eax
8010178b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101791:	e8 ba 5f 00 00       	call   80107750 <loaduvm>
80101796:	83 c4 20             	add    $0x20,%esp
80101799:	85 c0                	test   %eax,%eax
8010179b:	78 2d                	js     801017ca <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010179d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801017a4:	83 c3 01             	add    $0x1,%ebx
801017a7:	83 c6 20             	add    $0x20,%esi
801017aa:	39 d8                	cmp    %ebx,%eax
801017ac:	7e 52                	jle    80101800 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801017ae:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801017b4:	6a 20                	push   $0x20
801017b6:	56                   	push   %esi
801017b7:	50                   	push   %eax
801017b8:	57                   	push   %edi
801017b9:	e8 c2 0e 00 00       	call   80102680 <readi>
801017be:	83 c4 10             	add    $0x10,%esp
801017c1:	83 f8 20             	cmp    $0x20,%eax
801017c4:	0f 84 5e ff ff ff    	je     80101728 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
801017ca:	83 ec 0c             	sub    $0xc,%esp
801017cd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801017d3:	e8 98 61 00 00       	call   80107970 <freevm>
  if(ip){
801017d8:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801017db:	83 ec 0c             	sub    $0xc,%esp
801017de:	57                   	push   %edi
801017df:	e8 1c 0e 00 00       	call   80102600 <iunlockput>
    end_op();
801017e4:	e8 97 21 00 00       	call   80103980 <end_op>
801017e9:	83 c4 10             	add    $0x10,%esp
    return -1;
801017ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
801017f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017f4:	5b                   	pop    %ebx
801017f5:	5e                   	pop    %esi
801017f6:	5f                   	pop    %edi
801017f7:	5d                   	pop    %ebp
801017f8:	c3                   	ret
801017f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80101800:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80101806:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
8010180c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101812:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80101818:	83 ec 0c             	sub    $0xc,%esp
8010181b:	57                   	push   %edi
8010181c:	e8 df 0d 00 00       	call   80102600 <iunlockput>
  end_op();
80101821:	e8 5a 21 00 00       	call   80103980 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101826:	83 c4 0c             	add    $0xc,%esp
80101829:	53                   	push   %ebx
8010182a:	56                   	push   %esi
8010182b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80101831:	56                   	push   %esi
80101832:	e8 e9 5f 00 00       	call   80107820 <allocuvm>
80101837:	83 c4 10             	add    $0x10,%esp
8010183a:	89 c7                	mov    %eax,%edi
8010183c:	85 c0                	test   %eax,%eax
8010183e:	0f 84 86 00 00 00    	je     801018ca <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101844:	83 ec 08             	sub    $0x8,%esp
80101847:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
8010184d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010184f:	50                   	push   %eax
80101850:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80101851:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101853:	e8 38 62 00 00       	call   80107a90 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101858:	8b 45 0c             	mov    0xc(%ebp),%eax
8010185b:	83 c4 10             	add    $0x10,%esp
8010185e:	8b 10                	mov    (%eax),%edx
80101860:	85 d2                	test   %edx,%edx
80101862:	0f 84 56 01 00 00    	je     801019be <exec+0x33e>
80101868:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
8010186e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101871:	eb 23                	jmp    80101896 <exec+0x216>
80101873:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101878:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
8010187b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80101882:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80101888:	8b 14 87             	mov    (%edi,%eax,4),%edx
8010188b:	85 d2                	test   %edx,%edx
8010188d:	74 51                	je     801018e0 <exec+0x260>
    if(argc >= MAXARG)
8010188f:	83 f8 20             	cmp    $0x20,%eax
80101892:	74 36                	je     801018ca <exec+0x24a>
80101894:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101896:	83 ec 0c             	sub    $0xc,%esp
80101899:	52                   	push   %edx
8010189a:	e8 c1 3b 00 00       	call   80105460 <strlen>
8010189f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801018a1:	58                   	pop    %eax
801018a2:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801018a5:	83 eb 01             	sub    $0x1,%ebx
801018a8:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801018ab:	e8 b0 3b 00 00       	call   80105460 <strlen>
801018b0:	83 c0 01             	add    $0x1,%eax
801018b3:	50                   	push   %eax
801018b4:	ff 34 b7             	push   (%edi,%esi,4)
801018b7:	53                   	push   %ebx
801018b8:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801018be:	e8 9d 63 00 00       	call   80107c60 <copyout>
801018c3:	83 c4 20             	add    $0x20,%esp
801018c6:	85 c0                	test   %eax,%eax
801018c8:	79 ae                	jns    80101878 <exec+0x1f8>
    freevm(pgdir);
801018ca:	83 ec 0c             	sub    $0xc,%esp
801018cd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801018d3:	e8 98 60 00 00       	call   80107970 <freevm>
801018d8:	83 c4 10             	add    $0x10,%esp
801018db:	e9 0c ff ff ff       	jmp    801017ec <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801018e0:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
801018e7:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801018ed:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801018f3:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
801018f6:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
801018f9:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80101900:	00 00 00 00 
  ustack[1] = argc;
80101904:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
8010190a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101911:	ff ff ff 
  ustack[1] = argc;
80101914:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010191a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
8010191c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010191e:	29 d0                	sub    %edx,%eax
80101920:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101926:	56                   	push   %esi
80101927:	51                   	push   %ecx
80101928:	53                   	push   %ebx
80101929:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010192f:	e8 2c 63 00 00       	call   80107c60 <copyout>
80101934:	83 c4 10             	add    $0x10,%esp
80101937:	85 c0                	test   %eax,%eax
80101939:	78 8f                	js     801018ca <exec+0x24a>
  for(last=s=path; *s; s++)
8010193b:	8b 45 08             	mov    0x8(%ebp),%eax
8010193e:	8b 55 08             	mov    0x8(%ebp),%edx
80101941:	0f b6 00             	movzbl (%eax),%eax
80101944:	84 c0                	test   %al,%al
80101946:	74 17                	je     8010195f <exec+0x2df>
80101948:	89 d1                	mov    %edx,%ecx
8010194a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80101950:	83 c1 01             	add    $0x1,%ecx
80101953:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101955:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101958:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010195b:	84 c0                	test   %al,%al
8010195d:	75 f1                	jne    80101950 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010195f:	83 ec 04             	sub    $0x4,%esp
80101962:	6a 10                	push   $0x10
80101964:	52                   	push   %edx
80101965:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
8010196b:	8d 46 6c             	lea    0x6c(%esi),%eax
8010196e:	50                   	push   %eax
8010196f:	e8 ac 3a 00 00       	call   80105420 <safestrcpy>
  curproc->pgdir = pgdir;
80101974:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010197a:	89 f0                	mov    %esi,%eax
8010197c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
8010197f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80101981:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101984:	89 c1                	mov    %eax,%ecx
80101986:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010198c:	8b 40 18             	mov    0x18(%eax),%eax
8010198f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101992:	8b 41 18             	mov    0x18(%ecx),%eax
80101995:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101998:	89 0c 24             	mov    %ecx,(%esp)
8010199b:	e8 20 5c 00 00       	call   801075c0 <switchuvm>
  freevm(oldpgdir);
801019a0:	89 34 24             	mov    %esi,(%esp)
801019a3:	e8 c8 5f 00 00       	call   80107970 <freevm>
  return 0;
801019a8:	83 c4 10             	add    $0x10,%esp
801019ab:	31 c0                	xor    %eax,%eax
801019ad:	e9 3f fe ff ff       	jmp    801017f1 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801019b2:	bb 00 20 00 00       	mov    $0x2000,%ebx
801019b7:	31 f6                	xor    %esi,%esi
801019b9:	e9 5a fe ff ff       	jmp    80101818 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
801019be:	be 10 00 00 00       	mov    $0x10,%esi
801019c3:	ba 04 00 00 00       	mov    $0x4,%edx
801019c8:	b8 03 00 00 00       	mov    $0x3,%eax
801019cd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
801019d4:	00 00 00 
801019d7:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
801019dd:	e9 17 ff ff ff       	jmp    801018f9 <exec+0x279>
    end_op();
801019e2:	e8 99 1f 00 00       	call   80103980 <end_op>
    cprintf("exec: fail\n");
801019e7:	83 ec 0c             	sub    $0xc,%esp
801019ea:	68 b4 7d 10 80       	push   $0x80107db4
801019ef:	e8 2c ef ff ff       	call   80100920 <cprintf>
    return -1;
801019f4:	83 c4 10             	add    $0x10,%esp
801019f7:	e9 f0 fd ff ff       	jmp    801017ec <exec+0x16c>
801019fc:	66 90                	xchg   %ax,%ax
801019fe:	66 90                	xchg   %ax,%ax

80101a00 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101a06:	68 c0 7d 10 80       	push   $0x80107dc0
80101a0b:	68 80 ff 10 80       	push   $0x8010ff80
80101a10:	e8 6b 35 00 00       	call   80104f80 <initlock>
}
80101a15:	83 c4 10             	add    $0x10,%esp
80101a18:	c9                   	leave
80101a19:	c3                   	ret
80101a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a20 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101a24:	bb b4 ff 10 80       	mov    $0x8010ffb4,%ebx
{
80101a29:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101a2c:	68 80 ff 10 80       	push   $0x8010ff80
80101a31:	e8 3a 37 00 00       	call   80105170 <acquire>
80101a36:	83 c4 10             	add    $0x10,%esp
80101a39:	eb 10                	jmp    80101a4b <filealloc+0x2b>
80101a3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101a40:	83 c3 18             	add    $0x18,%ebx
80101a43:	81 fb 14 09 11 80    	cmp    $0x80110914,%ebx
80101a49:	74 25                	je     80101a70 <filealloc+0x50>
    if(f->ref == 0){
80101a4b:	8b 43 04             	mov    0x4(%ebx),%eax
80101a4e:	85 c0                	test   %eax,%eax
80101a50:	75 ee                	jne    80101a40 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101a52:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101a55:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101a5c:	68 80 ff 10 80       	push   $0x8010ff80
80101a61:	e8 aa 36 00 00       	call   80105110 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101a66:	89 d8                	mov    %ebx,%eax
      return f;
80101a68:	83 c4 10             	add    $0x10,%esp
}
80101a6b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a6e:	c9                   	leave
80101a6f:	c3                   	ret
  release(&ftable.lock);
80101a70:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101a73:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101a75:	68 80 ff 10 80       	push   $0x8010ff80
80101a7a:	e8 91 36 00 00       	call   80105110 <release>
}
80101a7f:	89 d8                	mov    %ebx,%eax
  return 0;
80101a81:	83 c4 10             	add    $0x10,%esp
}
80101a84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a87:	c9                   	leave
80101a88:	c3                   	ret
80101a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a90 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	53                   	push   %ebx
80101a94:	83 ec 10             	sub    $0x10,%esp
80101a97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80101a9a:	68 80 ff 10 80       	push   $0x8010ff80
80101a9f:	e8 cc 36 00 00       	call   80105170 <acquire>
  if(f->ref < 1)
80101aa4:	8b 43 04             	mov    0x4(%ebx),%eax
80101aa7:	83 c4 10             	add    $0x10,%esp
80101aaa:	85 c0                	test   %eax,%eax
80101aac:	7e 1a                	jle    80101ac8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101aae:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101ab1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101ab4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101ab7:	68 80 ff 10 80       	push   $0x8010ff80
80101abc:	e8 4f 36 00 00       	call   80105110 <release>
  return f;
}
80101ac1:	89 d8                	mov    %ebx,%eax
80101ac3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101ac6:	c9                   	leave
80101ac7:	c3                   	ret
    panic("filedup");
80101ac8:	83 ec 0c             	sub    $0xc,%esp
80101acb:	68 c7 7d 10 80       	push   $0x80107dc7
80101ad0:	e8 9b f0 ff ff       	call   80100b70 <panic>
80101ad5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101adc:	00 
80101add:	8d 76 00             	lea    0x0(%esi),%esi

80101ae0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101ae0:	55                   	push   %ebp
80101ae1:	89 e5                	mov    %esp,%ebp
80101ae3:	57                   	push   %edi
80101ae4:	56                   	push   %esi
80101ae5:	53                   	push   %ebx
80101ae6:	83 ec 28             	sub    $0x28,%esp
80101ae9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101aec:	68 80 ff 10 80       	push   $0x8010ff80
80101af1:	e8 7a 36 00 00       	call   80105170 <acquire>
  if(f->ref < 1)
80101af6:	8b 53 04             	mov    0x4(%ebx),%edx
80101af9:	83 c4 10             	add    $0x10,%esp
80101afc:	85 d2                	test   %edx,%edx
80101afe:	0f 8e a5 00 00 00    	jle    80101ba9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101b04:	83 ea 01             	sub    $0x1,%edx
80101b07:	89 53 04             	mov    %edx,0x4(%ebx)
80101b0a:	75 44                	jne    80101b50 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101b0c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101b10:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101b13:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101b15:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80101b1b:	8b 73 0c             	mov    0xc(%ebx),%esi
80101b1e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101b21:	8b 43 10             	mov    0x10(%ebx),%eax
80101b24:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101b27:	68 80 ff 10 80       	push   $0x8010ff80
80101b2c:	e8 df 35 00 00       	call   80105110 <release>

  if(ff.type == FD_PIPE)
80101b31:	83 c4 10             	add    $0x10,%esp
80101b34:	83 ff 01             	cmp    $0x1,%edi
80101b37:	74 57                	je     80101b90 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101b39:	83 ff 02             	cmp    $0x2,%edi
80101b3c:	74 2a                	je     80101b68 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101b3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b41:	5b                   	pop    %ebx
80101b42:	5e                   	pop    %esi
80101b43:	5f                   	pop    %edi
80101b44:	5d                   	pop    %ebp
80101b45:	c3                   	ret
80101b46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b4d:	00 
80101b4e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80101b50:	c7 45 08 80 ff 10 80 	movl   $0x8010ff80,0x8(%ebp)
}
80101b57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5a:	5b                   	pop    %ebx
80101b5b:	5e                   	pop    %esi
80101b5c:	5f                   	pop    %edi
80101b5d:	5d                   	pop    %ebp
    release(&ftable.lock);
80101b5e:	e9 ad 35 00 00       	jmp    80105110 <release>
80101b63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101b68:	e8 a3 1d 00 00       	call   80103910 <begin_op>
    iput(ff.ip);
80101b6d:	83 ec 0c             	sub    $0xc,%esp
80101b70:	ff 75 e0             	push   -0x20(%ebp)
80101b73:	e8 28 09 00 00       	call   801024a0 <iput>
    end_op();
80101b78:	83 c4 10             	add    $0x10,%esp
}
80101b7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b7e:	5b                   	pop    %ebx
80101b7f:	5e                   	pop    %esi
80101b80:	5f                   	pop    %edi
80101b81:	5d                   	pop    %ebp
    end_op();
80101b82:	e9 f9 1d 00 00       	jmp    80103980 <end_op>
80101b87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b8e:	00 
80101b8f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101b90:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101b94:	83 ec 08             	sub    $0x8,%esp
80101b97:	53                   	push   %ebx
80101b98:	56                   	push   %esi
80101b99:	e8 32 25 00 00       	call   801040d0 <pipeclose>
80101b9e:	83 c4 10             	add    $0x10,%esp
}
80101ba1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ba4:	5b                   	pop    %ebx
80101ba5:	5e                   	pop    %esi
80101ba6:	5f                   	pop    %edi
80101ba7:	5d                   	pop    %ebp
80101ba8:	c3                   	ret
    panic("fileclose");
80101ba9:	83 ec 0c             	sub    $0xc,%esp
80101bac:	68 cf 7d 10 80       	push   $0x80107dcf
80101bb1:	e8 ba ef ff ff       	call   80100b70 <panic>
80101bb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101bbd:	00 
80101bbe:	66 90                	xchg   %ax,%ax

80101bc0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	53                   	push   %ebx
80101bc4:	83 ec 04             	sub    $0x4,%esp
80101bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80101bca:	83 3b 02             	cmpl   $0x2,(%ebx)
80101bcd:	75 31                	jne    80101c00 <filestat+0x40>
    ilock(f->ip);
80101bcf:	83 ec 0c             	sub    $0xc,%esp
80101bd2:	ff 73 10             	push   0x10(%ebx)
80101bd5:	e8 96 07 00 00       	call   80102370 <ilock>
    stati(f->ip, st);
80101bda:	58                   	pop    %eax
80101bdb:	5a                   	pop    %edx
80101bdc:	ff 75 0c             	push   0xc(%ebp)
80101bdf:	ff 73 10             	push   0x10(%ebx)
80101be2:	e8 69 0a 00 00       	call   80102650 <stati>
    iunlock(f->ip);
80101be7:	59                   	pop    %ecx
80101be8:	ff 73 10             	push   0x10(%ebx)
80101beb:	e8 60 08 00 00       	call   80102450 <iunlock>
    return 0;
  }
  return -1;
}
80101bf0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101bf3:	83 c4 10             	add    $0x10,%esp
80101bf6:	31 c0                	xor    %eax,%eax
}
80101bf8:	c9                   	leave
80101bf9:	c3                   	ret
80101bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c00:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101c03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101c08:	c9                   	leave
80101c09:	c3                   	ret
80101c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c10 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	57                   	push   %edi
80101c14:	56                   	push   %esi
80101c15:	53                   	push   %ebx
80101c16:	83 ec 0c             	sub    $0xc,%esp
80101c19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c1c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101c1f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101c22:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101c26:	74 60                	je     80101c88 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101c28:	8b 03                	mov    (%ebx),%eax
80101c2a:	83 f8 01             	cmp    $0x1,%eax
80101c2d:	74 41                	je     80101c70 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101c2f:	83 f8 02             	cmp    $0x2,%eax
80101c32:	75 5b                	jne    80101c8f <fileread+0x7f>
    ilock(f->ip);
80101c34:	83 ec 0c             	sub    $0xc,%esp
80101c37:	ff 73 10             	push   0x10(%ebx)
80101c3a:	e8 31 07 00 00       	call   80102370 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101c3f:	57                   	push   %edi
80101c40:	ff 73 14             	push   0x14(%ebx)
80101c43:	56                   	push   %esi
80101c44:	ff 73 10             	push   0x10(%ebx)
80101c47:	e8 34 0a 00 00       	call   80102680 <readi>
80101c4c:	83 c4 20             	add    $0x20,%esp
80101c4f:	89 c6                	mov    %eax,%esi
80101c51:	85 c0                	test   %eax,%eax
80101c53:	7e 03                	jle    80101c58 <fileread+0x48>
      f->off += r;
80101c55:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101c58:	83 ec 0c             	sub    $0xc,%esp
80101c5b:	ff 73 10             	push   0x10(%ebx)
80101c5e:	e8 ed 07 00 00       	call   80102450 <iunlock>
    return r;
80101c63:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101c66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c69:	89 f0                	mov    %esi,%eax
80101c6b:	5b                   	pop    %ebx
80101c6c:	5e                   	pop    %esi
80101c6d:	5f                   	pop    %edi
80101c6e:	5d                   	pop    %ebp
80101c6f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101c70:	8b 43 0c             	mov    0xc(%ebx),%eax
80101c73:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101c76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c79:	5b                   	pop    %ebx
80101c7a:	5e                   	pop    %esi
80101c7b:	5f                   	pop    %edi
80101c7c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101c7d:	e9 0e 26 00 00       	jmp    80104290 <piperead>
80101c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101c88:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101c8d:	eb d7                	jmp    80101c66 <fileread+0x56>
  panic("fileread");
80101c8f:	83 ec 0c             	sub    $0xc,%esp
80101c92:	68 d9 7d 10 80       	push   $0x80107dd9
80101c97:	e8 d4 ee ff ff       	call   80100b70 <panic>
80101c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ca0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	57                   	push   %edi
80101ca4:	56                   	push   %esi
80101ca5:	53                   	push   %ebx
80101ca6:	83 ec 1c             	sub    $0x1c,%esp
80101ca9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cac:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101caf:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101cb2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101cb5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101cb9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101cbc:	0f 84 bb 00 00 00    	je     80101d7d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101cc2:	8b 03                	mov    (%ebx),%eax
80101cc4:	83 f8 01             	cmp    $0x1,%eax
80101cc7:	0f 84 bf 00 00 00    	je     80101d8c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101ccd:	83 f8 02             	cmp    $0x2,%eax
80101cd0:	0f 85 c8 00 00 00    	jne    80101d9e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101cd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101cd9:	31 f6                	xor    %esi,%esi
    while(i < n){
80101cdb:	85 c0                	test   %eax,%eax
80101cdd:	7f 30                	jg     80101d0f <filewrite+0x6f>
80101cdf:	e9 94 00 00 00       	jmp    80101d78 <filewrite+0xd8>
80101ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101ce8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
80101ceb:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
80101cee:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101cf1:	ff 73 10             	push   0x10(%ebx)
80101cf4:	e8 57 07 00 00       	call   80102450 <iunlock>
      end_op();
80101cf9:	e8 82 1c 00 00       	call   80103980 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101cfe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d01:	83 c4 10             	add    $0x10,%esp
80101d04:	39 c7                	cmp    %eax,%edi
80101d06:	75 5c                	jne    80101d64 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101d08:	01 fe                	add    %edi,%esi
    while(i < n){
80101d0a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101d0d:	7e 69                	jle    80101d78 <filewrite+0xd8>
      int n1 = n - i;
80101d0f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101d12:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101d17:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101d19:	39 c7                	cmp    %eax,%edi
80101d1b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
80101d1e:	e8 ed 1b 00 00       	call   80103910 <begin_op>
      ilock(f->ip);
80101d23:	83 ec 0c             	sub    $0xc,%esp
80101d26:	ff 73 10             	push   0x10(%ebx)
80101d29:	e8 42 06 00 00       	call   80102370 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101d2e:	57                   	push   %edi
80101d2f:	ff 73 14             	push   0x14(%ebx)
80101d32:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101d35:	01 f0                	add    %esi,%eax
80101d37:	50                   	push   %eax
80101d38:	ff 73 10             	push   0x10(%ebx)
80101d3b:	e8 40 0a 00 00       	call   80102780 <writei>
80101d40:	83 c4 20             	add    $0x20,%esp
80101d43:	85 c0                	test   %eax,%eax
80101d45:	7f a1                	jg     80101ce8 <filewrite+0x48>
80101d47:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101d4a:	83 ec 0c             	sub    $0xc,%esp
80101d4d:	ff 73 10             	push   0x10(%ebx)
80101d50:	e8 fb 06 00 00       	call   80102450 <iunlock>
      end_op();
80101d55:	e8 26 1c 00 00       	call   80103980 <end_op>
      if(r < 0)
80101d5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d5d:	83 c4 10             	add    $0x10,%esp
80101d60:	85 c0                	test   %eax,%eax
80101d62:	75 14                	jne    80101d78 <filewrite+0xd8>
        panic("short filewrite");
80101d64:	83 ec 0c             	sub    $0xc,%esp
80101d67:	68 e2 7d 10 80       	push   $0x80107de2
80101d6c:	e8 ff ed ff ff       	call   80100b70 <panic>
80101d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101d78:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101d7b:	74 05                	je     80101d82 <filewrite+0xe2>
80101d7d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101d82:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d85:	89 f0                	mov    %esi,%eax
80101d87:	5b                   	pop    %ebx
80101d88:	5e                   	pop    %esi
80101d89:	5f                   	pop    %edi
80101d8a:	5d                   	pop    %ebp
80101d8b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
80101d8c:	8b 43 0c             	mov    0xc(%ebx),%eax
80101d8f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101d92:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d95:	5b                   	pop    %ebx
80101d96:	5e                   	pop    %esi
80101d97:	5f                   	pop    %edi
80101d98:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101d99:	e9 d2 23 00 00       	jmp    80104170 <pipewrite>
  panic("filewrite");
80101d9e:	83 ec 0c             	sub    $0xc,%esp
80101da1:	68 e8 7d 10 80       	push   $0x80107de8
80101da6:	e8 c5 ed ff ff       	call   80100b70 <panic>
80101dab:	66 90                	xchg   %ax,%ax
80101dad:	66 90                	xchg   %ax,%ax
80101daf:	90                   	nop

80101db0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101db0:	55                   	push   %ebp
80101db1:	89 e5                	mov    %esp,%ebp
80101db3:	57                   	push   %edi
80101db4:	56                   	push   %esi
80101db5:	53                   	push   %ebx
80101db6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101db9:	8b 0d d4 25 11 80    	mov    0x801125d4,%ecx
{
80101dbf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101dc2:	85 c9                	test   %ecx,%ecx
80101dc4:	0f 84 8c 00 00 00    	je     80101e56 <balloc+0xa6>
80101dca:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
80101dcc:	89 f8                	mov    %edi,%eax
80101dce:	83 ec 08             	sub    $0x8,%esp
80101dd1:	89 fe                	mov    %edi,%esi
80101dd3:	c1 f8 0c             	sar    $0xc,%eax
80101dd6:	03 05 ec 25 11 80    	add    0x801125ec,%eax
80101ddc:	50                   	push   %eax
80101ddd:	ff 75 dc             	push   -0x24(%ebp)
80101de0:	e8 eb e2 ff ff       	call   801000d0 <bread>
80101de5:	83 c4 10             	add    $0x10,%esp
80101de8:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101deb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101dee:	a1 d4 25 11 80       	mov    0x801125d4,%eax
80101df3:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101df6:	31 c0                	xor    %eax,%eax
80101df8:	eb 32                	jmp    80101e2c <balloc+0x7c>
80101dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101e00:	89 c1                	mov    %eax,%ecx
80101e02:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101e07:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
80101e0a:	83 e1 07             	and    $0x7,%ecx
80101e0d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101e0f:	89 c1                	mov    %eax,%ecx
80101e11:	c1 f9 03             	sar    $0x3,%ecx
80101e14:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101e19:	89 fa                	mov    %edi,%edx
80101e1b:	85 df                	test   %ebx,%edi
80101e1d:	74 49                	je     80101e68 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101e1f:	83 c0 01             	add    $0x1,%eax
80101e22:	83 c6 01             	add    $0x1,%esi
80101e25:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101e2a:	74 07                	je     80101e33 <balloc+0x83>
80101e2c:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e2f:	39 d6                	cmp    %edx,%esi
80101e31:	72 cd                	jb     80101e00 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101e33:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101e36:	83 ec 0c             	sub    $0xc,%esp
80101e39:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101e3c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101e42:	e8 a9 e3 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101e47:	83 c4 10             	add    $0x10,%esp
80101e4a:	3b 3d d4 25 11 80    	cmp    0x801125d4,%edi
80101e50:	0f 82 76 ff ff ff    	jb     80101dcc <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101e56:	83 ec 0c             	sub    $0xc,%esp
80101e59:	68 f2 7d 10 80       	push   $0x80107df2
80101e5e:	e8 0d ed ff ff       	call   80100b70 <panic>
80101e63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101e68:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101e6b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101e6e:	09 da                	or     %ebx,%edx
80101e70:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101e74:	57                   	push   %edi
80101e75:	e8 76 1c 00 00       	call   80103af0 <log_write>
        brelse(bp);
80101e7a:	89 3c 24             	mov    %edi,(%esp)
80101e7d:	e8 6e e3 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101e82:	58                   	pop    %eax
80101e83:	5a                   	pop    %edx
80101e84:	56                   	push   %esi
80101e85:	ff 75 dc             	push   -0x24(%ebp)
80101e88:	e8 43 e2 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101e8d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101e90:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101e92:	8d 40 5c             	lea    0x5c(%eax),%eax
80101e95:	68 00 02 00 00       	push   $0x200
80101e9a:	6a 00                	push   $0x0
80101e9c:	50                   	push   %eax
80101e9d:	e8 ce 33 00 00       	call   80105270 <memset>
  log_write(bp);
80101ea2:	89 1c 24             	mov    %ebx,(%esp)
80101ea5:	e8 46 1c 00 00       	call   80103af0 <log_write>
  brelse(bp);
80101eaa:	89 1c 24             	mov    %ebx,(%esp)
80101ead:	e8 3e e3 ff ff       	call   801001f0 <brelse>
}
80101eb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eb5:	89 f0                	mov    %esi,%eax
80101eb7:	5b                   	pop    %ebx
80101eb8:	5e                   	pop    %esi
80101eb9:	5f                   	pop    %edi
80101eba:	5d                   	pop    %ebp
80101ebb:	c3                   	ret
80101ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ec0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
80101ec3:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101ec4:	31 ff                	xor    %edi,%edi
{
80101ec6:	56                   	push   %esi
80101ec7:	89 c6                	mov    %eax,%esi
80101ec9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101eca:	bb b4 09 11 80       	mov    $0x801109b4,%ebx
{
80101ecf:	83 ec 28             	sub    $0x28,%esp
80101ed2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101ed5:	68 80 09 11 80       	push   $0x80110980
80101eda:	e8 91 32 00 00       	call   80105170 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101edf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101ee2:	83 c4 10             	add    $0x10,%esp
80101ee5:	eb 1b                	jmp    80101f02 <iget+0x42>
80101ee7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101eee:	00 
80101eef:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101ef0:	39 33                	cmp    %esi,(%ebx)
80101ef2:	74 6c                	je     80101f60 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101ef4:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101efa:	81 fb d4 25 11 80    	cmp    $0x801125d4,%ebx
80101f00:	74 26                	je     80101f28 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101f02:	8b 43 08             	mov    0x8(%ebx),%eax
80101f05:	85 c0                	test   %eax,%eax
80101f07:	7f e7                	jg     80101ef0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101f09:	85 ff                	test   %edi,%edi
80101f0b:	75 e7                	jne    80101ef4 <iget+0x34>
80101f0d:	85 c0                	test   %eax,%eax
80101f0f:	75 76                	jne    80101f87 <iget+0xc7>
      empty = ip;
80101f11:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101f13:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101f19:	81 fb d4 25 11 80    	cmp    $0x801125d4,%ebx
80101f1f:	75 e1                	jne    80101f02 <iget+0x42>
80101f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101f28:	85 ff                	test   %edi,%edi
80101f2a:	74 79                	je     80101fa5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101f2c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101f2f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101f31:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101f34:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
80101f3b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80101f42:	68 80 09 11 80       	push   $0x80110980
80101f47:	e8 c4 31 00 00       	call   80105110 <release>

  return ip;
80101f4c:	83 c4 10             	add    $0x10,%esp
}
80101f4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f52:	89 f8                	mov    %edi,%eax
80101f54:	5b                   	pop    %ebx
80101f55:	5e                   	pop    %esi
80101f56:	5f                   	pop    %edi
80101f57:	5d                   	pop    %ebp
80101f58:	c3                   	ret
80101f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101f60:	39 53 04             	cmp    %edx,0x4(%ebx)
80101f63:	75 8f                	jne    80101ef4 <iget+0x34>
      ip->ref++;
80101f65:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80101f68:	83 ec 0c             	sub    $0xc,%esp
      return ip;
80101f6b:	89 df                	mov    %ebx,%edi
      ip->ref++;
80101f6d:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101f70:	68 80 09 11 80       	push   $0x80110980
80101f75:	e8 96 31 00 00       	call   80105110 <release>
      return ip;
80101f7a:	83 c4 10             	add    $0x10,%esp
}
80101f7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f80:	89 f8                	mov    %edi,%eax
80101f82:	5b                   	pop    %ebx
80101f83:	5e                   	pop    %esi
80101f84:	5f                   	pop    %edi
80101f85:	5d                   	pop    %ebp
80101f86:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101f87:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101f8d:	81 fb d4 25 11 80    	cmp    $0x801125d4,%ebx
80101f93:	74 10                	je     80101fa5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101f95:	8b 43 08             	mov    0x8(%ebx),%eax
80101f98:	85 c0                	test   %eax,%eax
80101f9a:	0f 8f 50 ff ff ff    	jg     80101ef0 <iget+0x30>
80101fa0:	e9 68 ff ff ff       	jmp    80101f0d <iget+0x4d>
    panic("iget: no inodes");
80101fa5:	83 ec 0c             	sub    $0xc,%esp
80101fa8:	68 08 7e 10 80       	push   $0x80107e08
80101fad:	e8 be eb ff ff       	call   80100b70 <panic>
80101fb2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101fb9:	00 
80101fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101fc0 <bfree>:
{
80101fc0:	55                   	push   %ebp
80101fc1:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101fc3:	89 d0                	mov    %edx,%eax
80101fc5:	c1 e8 0c             	shr    $0xc,%eax
{
80101fc8:	89 e5                	mov    %esp,%ebp
80101fca:	56                   	push   %esi
80101fcb:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
80101fcc:	03 05 ec 25 11 80    	add    0x801125ec,%eax
{
80101fd2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101fd4:	83 ec 08             	sub    $0x8,%esp
80101fd7:	50                   	push   %eax
80101fd8:	51                   	push   %ecx
80101fd9:	e8 f2 e0 ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101fde:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101fe0:	c1 fb 03             	sar    $0x3,%ebx
80101fe3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101fe6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101fe8:	83 e1 07             	and    $0x7,%ecx
80101feb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101ff0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101ff6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101ff8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101ffd:	85 c1                	test   %eax,%ecx
80101fff:	74 23                	je     80102024 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80102001:	f7 d0                	not    %eax
  log_write(bp);
80102003:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80102006:	21 c8                	and    %ecx,%eax
80102008:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010200c:	56                   	push   %esi
8010200d:	e8 de 1a 00 00       	call   80103af0 <log_write>
  brelse(bp);
80102012:	89 34 24             	mov    %esi,(%esp)
80102015:	e8 d6 e1 ff ff       	call   801001f0 <brelse>
}
8010201a:	83 c4 10             	add    $0x10,%esp
8010201d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102020:	5b                   	pop    %ebx
80102021:	5e                   	pop    %esi
80102022:	5d                   	pop    %ebp
80102023:	c3                   	ret
    panic("freeing free block");
80102024:	83 ec 0c             	sub    $0xc,%esp
80102027:	68 18 7e 10 80       	push   $0x80107e18
8010202c:	e8 3f eb ff ff       	call   80100b70 <panic>
80102031:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102038:	00 
80102039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102040 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102040:	55                   	push   %ebp
80102041:	89 e5                	mov    %esp,%ebp
80102043:	57                   	push   %edi
80102044:	56                   	push   %esi
80102045:	89 c6                	mov    %eax,%esi
80102047:	53                   	push   %ebx
80102048:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010204b:	83 fa 0b             	cmp    $0xb,%edx
8010204e:	0f 86 8c 00 00 00    	jbe    801020e0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80102054:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80102057:	83 fb 7f             	cmp    $0x7f,%ebx
8010205a:	0f 87 a2 00 00 00    	ja     80102102 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80102060:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102066:	85 c0                	test   %eax,%eax
80102068:	74 5e                	je     801020c8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010206a:	83 ec 08             	sub    $0x8,%esp
8010206d:	50                   	push   %eax
8010206e:	ff 36                	push   (%esi)
80102070:	e8 5b e0 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80102075:	83 c4 10             	add    $0x10,%esp
80102078:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010207c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010207e:	8b 3b                	mov    (%ebx),%edi
80102080:	85 ff                	test   %edi,%edi
80102082:	74 1c                	je     801020a0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80102084:	83 ec 0c             	sub    $0xc,%esp
80102087:	52                   	push   %edx
80102088:	e8 63 e1 ff ff       	call   801001f0 <brelse>
8010208d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80102090:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102093:	89 f8                	mov    %edi,%eax
80102095:	5b                   	pop    %ebx
80102096:	5e                   	pop    %esi
80102097:	5f                   	pop    %edi
80102098:	5d                   	pop    %ebp
80102099:	c3                   	ret
8010209a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801020a3:	8b 06                	mov    (%esi),%eax
801020a5:	e8 06 fd ff ff       	call   80101db0 <balloc>
      log_write(bp);
801020aa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801020ad:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801020b0:	89 03                	mov    %eax,(%ebx)
801020b2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801020b4:	52                   	push   %edx
801020b5:	e8 36 1a 00 00       	call   80103af0 <log_write>
801020ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801020bd:	83 c4 10             	add    $0x10,%esp
801020c0:	eb c2                	jmp    80102084 <bmap+0x44>
801020c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801020c8:	8b 06                	mov    (%esi),%eax
801020ca:	e8 e1 fc ff ff       	call   80101db0 <balloc>
801020cf:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801020d5:	eb 93                	jmp    8010206a <bmap+0x2a>
801020d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020de:	00 
801020df:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
801020e0:	8d 5a 14             	lea    0x14(%edx),%ebx
801020e3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801020e7:	85 ff                	test   %edi,%edi
801020e9:	75 a5                	jne    80102090 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801020eb:	8b 00                	mov    (%eax),%eax
801020ed:	e8 be fc ff ff       	call   80101db0 <balloc>
801020f2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801020f6:	89 c7                	mov    %eax,%edi
}
801020f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020fb:	5b                   	pop    %ebx
801020fc:	89 f8                	mov    %edi,%eax
801020fe:	5e                   	pop    %esi
801020ff:	5f                   	pop    %edi
80102100:	5d                   	pop    %ebp
80102101:	c3                   	ret
  panic("bmap: out of range");
80102102:	83 ec 0c             	sub    $0xc,%esp
80102105:	68 2b 7e 10 80       	push   $0x80107e2b
8010210a:	e8 61 ea ff ff       	call   80100b70 <panic>
8010210f:	90                   	nop

80102110 <readsb>:
{
80102110:	55                   	push   %ebp
80102111:	89 e5                	mov    %esp,%ebp
80102113:	56                   	push   %esi
80102114:	53                   	push   %ebx
80102115:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102118:	83 ec 08             	sub    $0x8,%esp
8010211b:	6a 01                	push   $0x1
8010211d:	ff 75 08             	push   0x8(%ebp)
80102120:	e8 ab df ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102125:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102128:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010212a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010212d:	6a 1c                	push   $0x1c
8010212f:	50                   	push   %eax
80102130:	56                   	push   %esi
80102131:	e8 ca 31 00 00       	call   80105300 <memmove>
  brelse(bp);
80102136:	83 c4 10             	add    $0x10,%esp
80102139:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010213c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010213f:	5b                   	pop    %ebx
80102140:	5e                   	pop    %esi
80102141:	5d                   	pop    %ebp
  brelse(bp);
80102142:	e9 a9 e0 ff ff       	jmp    801001f0 <brelse>
80102147:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010214e:	00 
8010214f:	90                   	nop

80102150 <iinit>:
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	53                   	push   %ebx
80102154:	bb c0 09 11 80       	mov    $0x801109c0,%ebx
80102159:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010215c:	68 3e 7e 10 80       	push   $0x80107e3e
80102161:	68 80 09 11 80       	push   $0x80110980
80102166:	e8 15 2e 00 00       	call   80104f80 <initlock>
  for(i = 0; i < NINODE; i++) {
8010216b:	83 c4 10             	add    $0x10,%esp
8010216e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80102170:	83 ec 08             	sub    $0x8,%esp
80102173:	68 45 7e 10 80       	push   $0x80107e45
80102178:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80102179:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010217f:	e8 cc 2c 00 00       	call   80104e50 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80102184:	83 c4 10             	add    $0x10,%esp
80102187:	81 fb e0 25 11 80    	cmp    $0x801125e0,%ebx
8010218d:	75 e1                	jne    80102170 <iinit+0x20>
  bp = bread(dev, 1);
8010218f:	83 ec 08             	sub    $0x8,%esp
80102192:	6a 01                	push   $0x1
80102194:	ff 75 08             	push   0x8(%ebp)
80102197:	e8 34 df ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010219c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010219f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801021a1:	8d 40 5c             	lea    0x5c(%eax),%eax
801021a4:	6a 1c                	push   $0x1c
801021a6:	50                   	push   %eax
801021a7:	68 d4 25 11 80       	push   $0x801125d4
801021ac:	e8 4f 31 00 00       	call   80105300 <memmove>
  brelse(bp);
801021b1:	89 1c 24             	mov    %ebx,(%esp)
801021b4:	e8 37 e0 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801021b9:	ff 35 ec 25 11 80    	push   0x801125ec
801021bf:	ff 35 e8 25 11 80    	push   0x801125e8
801021c5:	ff 35 e4 25 11 80    	push   0x801125e4
801021cb:	ff 35 e0 25 11 80    	push   0x801125e0
801021d1:	ff 35 dc 25 11 80    	push   0x801125dc
801021d7:	ff 35 d8 25 11 80    	push   0x801125d8
801021dd:	ff 35 d4 25 11 80    	push   0x801125d4
801021e3:	68 c4 82 10 80       	push   $0x801082c4
801021e8:	e8 33 e7 ff ff       	call   80100920 <cprintf>
}
801021ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021f0:	83 c4 30             	add    $0x30,%esp
801021f3:	c9                   	leave
801021f4:	c3                   	ret
801021f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021fc:	00 
801021fd:	8d 76 00             	lea    0x0(%esi),%esi

80102200 <ialloc>:
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	57                   	push   %edi
80102204:	56                   	push   %esi
80102205:	53                   	push   %ebx
80102206:	83 ec 1c             	sub    $0x1c,%esp
80102209:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010220c:	83 3d dc 25 11 80 01 	cmpl   $0x1,0x801125dc
{
80102213:	8b 75 08             	mov    0x8(%ebp),%esi
80102216:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102219:	0f 86 91 00 00 00    	jbe    801022b0 <ialloc+0xb0>
8010221f:	bf 01 00 00 00       	mov    $0x1,%edi
80102224:	eb 21                	jmp    80102247 <ialloc+0x47>
80102226:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010222d:	00 
8010222e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80102230:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102233:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102236:	53                   	push   %ebx
80102237:	e8 b4 df ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010223c:	83 c4 10             	add    $0x10,%esp
8010223f:	3b 3d dc 25 11 80    	cmp    0x801125dc,%edi
80102245:	73 69                	jae    801022b0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102247:	89 f8                	mov    %edi,%eax
80102249:	83 ec 08             	sub    $0x8,%esp
8010224c:	c1 e8 03             	shr    $0x3,%eax
8010224f:	03 05 e8 25 11 80    	add    0x801125e8,%eax
80102255:	50                   	push   %eax
80102256:	56                   	push   %esi
80102257:	e8 74 de ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010225c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010225f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80102261:	89 f8                	mov    %edi,%eax
80102263:	83 e0 07             	and    $0x7,%eax
80102266:	c1 e0 06             	shl    $0x6,%eax
80102269:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010226d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80102271:	75 bd                	jne    80102230 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80102273:	83 ec 04             	sub    $0x4,%esp
80102276:	6a 40                	push   $0x40
80102278:	6a 00                	push   $0x0
8010227a:	51                   	push   %ecx
8010227b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010227e:	e8 ed 2f 00 00       	call   80105270 <memset>
      dip->type = type;
80102283:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80102287:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010228a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010228d:	89 1c 24             	mov    %ebx,(%esp)
80102290:	e8 5b 18 00 00       	call   80103af0 <log_write>
      brelse(bp);
80102295:	89 1c 24             	mov    %ebx,(%esp)
80102298:	e8 53 df ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010229d:	83 c4 10             	add    $0x10,%esp
}
801022a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801022a3:	89 fa                	mov    %edi,%edx
}
801022a5:	5b                   	pop    %ebx
      return iget(dev, inum);
801022a6:	89 f0                	mov    %esi,%eax
}
801022a8:	5e                   	pop    %esi
801022a9:	5f                   	pop    %edi
801022aa:	5d                   	pop    %ebp
      return iget(dev, inum);
801022ab:	e9 10 fc ff ff       	jmp    80101ec0 <iget>
  panic("ialloc: no inodes");
801022b0:	83 ec 0c             	sub    $0xc,%esp
801022b3:	68 4b 7e 10 80       	push   $0x80107e4b
801022b8:	e8 b3 e8 ff ff       	call   80100b70 <panic>
801022bd:	8d 76 00             	lea    0x0(%esi),%esi

801022c0 <iupdate>:
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	56                   	push   %esi
801022c4:	53                   	push   %ebx
801022c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801022c8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801022cb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801022ce:	83 ec 08             	sub    $0x8,%esp
801022d1:	c1 e8 03             	shr    $0x3,%eax
801022d4:	03 05 e8 25 11 80    	add    0x801125e8,%eax
801022da:	50                   	push   %eax
801022db:	ff 73 a4             	push   -0x5c(%ebx)
801022de:	e8 ed dd ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801022e3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801022e7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801022ea:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801022ec:	8b 43 a8             	mov    -0x58(%ebx),%eax
801022ef:	83 e0 07             	and    $0x7,%eax
801022f2:	c1 e0 06             	shl    $0x6,%eax
801022f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801022f9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801022fc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102300:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102303:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80102307:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010230b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010230f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102313:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102317:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010231a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010231d:	6a 34                	push   $0x34
8010231f:	53                   	push   %ebx
80102320:	50                   	push   %eax
80102321:	e8 da 2f 00 00       	call   80105300 <memmove>
  log_write(bp);
80102326:	89 34 24             	mov    %esi,(%esp)
80102329:	e8 c2 17 00 00       	call   80103af0 <log_write>
  brelse(bp);
8010232e:	83 c4 10             	add    $0x10,%esp
80102331:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102334:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102337:	5b                   	pop    %ebx
80102338:	5e                   	pop    %esi
80102339:	5d                   	pop    %ebp
  brelse(bp);
8010233a:	e9 b1 de ff ff       	jmp    801001f0 <brelse>
8010233f:	90                   	nop

80102340 <idup>:
{
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	53                   	push   %ebx
80102344:	83 ec 10             	sub    $0x10,%esp
80102347:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010234a:	68 80 09 11 80       	push   $0x80110980
8010234f:	e8 1c 2e 00 00       	call   80105170 <acquire>
  ip->ref++;
80102354:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102358:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
8010235f:	e8 ac 2d 00 00       	call   80105110 <release>
}
80102364:	89 d8                	mov    %ebx,%eax
80102366:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102369:	c9                   	leave
8010236a:	c3                   	ret
8010236b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102370 <ilock>:
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	56                   	push   %esi
80102374:	53                   	push   %ebx
80102375:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80102378:	85 db                	test   %ebx,%ebx
8010237a:	0f 84 b7 00 00 00    	je     80102437 <ilock+0xc7>
80102380:	8b 53 08             	mov    0x8(%ebx),%edx
80102383:	85 d2                	test   %edx,%edx
80102385:	0f 8e ac 00 00 00    	jle    80102437 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010238b:	83 ec 0c             	sub    $0xc,%esp
8010238e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102391:	50                   	push   %eax
80102392:	e8 f9 2a 00 00       	call   80104e90 <acquiresleep>
  if(ip->valid == 0){
80102397:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010239a:	83 c4 10             	add    $0x10,%esp
8010239d:	85 c0                	test   %eax,%eax
8010239f:	74 0f                	je     801023b0 <ilock+0x40>
}
801023a1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023a4:	5b                   	pop    %ebx
801023a5:	5e                   	pop    %esi
801023a6:	5d                   	pop    %ebp
801023a7:	c3                   	ret
801023a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801023af:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801023b0:	8b 43 04             	mov    0x4(%ebx),%eax
801023b3:	83 ec 08             	sub    $0x8,%esp
801023b6:	c1 e8 03             	shr    $0x3,%eax
801023b9:	03 05 e8 25 11 80    	add    0x801125e8,%eax
801023bf:	50                   	push   %eax
801023c0:	ff 33                	push   (%ebx)
801023c2:	e8 09 dd ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801023c7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801023ca:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801023cc:	8b 43 04             	mov    0x4(%ebx),%eax
801023cf:	83 e0 07             	and    $0x7,%eax
801023d2:	c1 e0 06             	shl    $0x6,%eax
801023d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801023d9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801023dc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801023df:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801023e3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801023e7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801023eb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801023ef:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801023f3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801023f7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801023fb:	8b 50 fc             	mov    -0x4(%eax),%edx
801023fe:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102401:	6a 34                	push   $0x34
80102403:	50                   	push   %eax
80102404:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102407:	50                   	push   %eax
80102408:	e8 f3 2e 00 00       	call   80105300 <memmove>
    brelse(bp);
8010240d:	89 34 24             	mov    %esi,(%esp)
80102410:	e8 db dd ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102415:	83 c4 10             	add    $0x10,%esp
80102418:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010241d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102424:	0f 85 77 ff ff ff    	jne    801023a1 <ilock+0x31>
      panic("ilock: no type");
8010242a:	83 ec 0c             	sub    $0xc,%esp
8010242d:	68 63 7e 10 80       	push   $0x80107e63
80102432:	e8 39 e7 ff ff       	call   80100b70 <panic>
    panic("ilock");
80102437:	83 ec 0c             	sub    $0xc,%esp
8010243a:	68 5d 7e 10 80       	push   $0x80107e5d
8010243f:	e8 2c e7 ff ff       	call   80100b70 <panic>
80102444:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010244b:	00 
8010244c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102450 <iunlock>:
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	56                   	push   %esi
80102454:	53                   	push   %ebx
80102455:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102458:	85 db                	test   %ebx,%ebx
8010245a:	74 28                	je     80102484 <iunlock+0x34>
8010245c:	83 ec 0c             	sub    $0xc,%esp
8010245f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102462:	56                   	push   %esi
80102463:	e8 c8 2a 00 00       	call   80104f30 <holdingsleep>
80102468:	83 c4 10             	add    $0x10,%esp
8010246b:	85 c0                	test   %eax,%eax
8010246d:	74 15                	je     80102484 <iunlock+0x34>
8010246f:	8b 43 08             	mov    0x8(%ebx),%eax
80102472:	85 c0                	test   %eax,%eax
80102474:	7e 0e                	jle    80102484 <iunlock+0x34>
  releasesleep(&ip->lock);
80102476:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102479:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010247c:	5b                   	pop    %ebx
8010247d:	5e                   	pop    %esi
8010247e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010247f:	e9 6c 2a 00 00       	jmp    80104ef0 <releasesleep>
    panic("iunlock");
80102484:	83 ec 0c             	sub    $0xc,%esp
80102487:	68 72 7e 10 80       	push   $0x80107e72
8010248c:	e8 df e6 ff ff       	call   80100b70 <panic>
80102491:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102498:	00 
80102499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801024a0 <iput>:
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	57                   	push   %edi
801024a4:	56                   	push   %esi
801024a5:	53                   	push   %ebx
801024a6:	83 ec 28             	sub    $0x28,%esp
801024a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801024ac:	8d 7b 0c             	lea    0xc(%ebx),%edi
801024af:	57                   	push   %edi
801024b0:	e8 db 29 00 00       	call   80104e90 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801024b5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801024b8:	83 c4 10             	add    $0x10,%esp
801024bb:	85 d2                	test   %edx,%edx
801024bd:	74 07                	je     801024c6 <iput+0x26>
801024bf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801024c4:	74 32                	je     801024f8 <iput+0x58>
  releasesleep(&ip->lock);
801024c6:	83 ec 0c             	sub    $0xc,%esp
801024c9:	57                   	push   %edi
801024ca:	e8 21 2a 00 00       	call   80104ef0 <releasesleep>
  acquire(&icache.lock);
801024cf:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
801024d6:	e8 95 2c 00 00       	call   80105170 <acquire>
  ip->ref--;
801024db:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801024df:	83 c4 10             	add    $0x10,%esp
801024e2:	c7 45 08 80 09 11 80 	movl   $0x80110980,0x8(%ebp)
}
801024e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024ec:	5b                   	pop    %ebx
801024ed:	5e                   	pop    %esi
801024ee:	5f                   	pop    %edi
801024ef:	5d                   	pop    %ebp
  release(&icache.lock);
801024f0:	e9 1b 2c 00 00       	jmp    80105110 <release>
801024f5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801024f8:	83 ec 0c             	sub    $0xc,%esp
801024fb:	68 80 09 11 80       	push   $0x80110980
80102500:	e8 6b 2c 00 00       	call   80105170 <acquire>
    int r = ip->ref;
80102505:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102508:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
8010250f:	e8 fc 2b 00 00       	call   80105110 <release>
    if(r == 1){
80102514:	83 c4 10             	add    $0x10,%esp
80102517:	83 fe 01             	cmp    $0x1,%esi
8010251a:	75 aa                	jne    801024c6 <iput+0x26>
8010251c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102522:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102525:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102528:	89 df                	mov    %ebx,%edi
8010252a:	89 cb                	mov    %ecx,%ebx
8010252c:	eb 09                	jmp    80102537 <iput+0x97>
8010252e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102530:	83 c6 04             	add    $0x4,%esi
80102533:	39 de                	cmp    %ebx,%esi
80102535:	74 19                	je     80102550 <iput+0xb0>
    if(ip->addrs[i]){
80102537:	8b 16                	mov    (%esi),%edx
80102539:	85 d2                	test   %edx,%edx
8010253b:	74 f3                	je     80102530 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010253d:	8b 07                	mov    (%edi),%eax
8010253f:	e8 7c fa ff ff       	call   80101fc0 <bfree>
      ip->addrs[i] = 0;
80102544:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010254a:	eb e4                	jmp    80102530 <iput+0x90>
8010254c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102550:	89 fb                	mov    %edi,%ebx
80102552:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102555:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010255b:	85 c0                	test   %eax,%eax
8010255d:	75 2d                	jne    8010258c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010255f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80102562:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80102569:	53                   	push   %ebx
8010256a:	e8 51 fd ff ff       	call   801022c0 <iupdate>
      ip->type = 0;
8010256f:	31 c0                	xor    %eax,%eax
80102571:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80102575:	89 1c 24             	mov    %ebx,(%esp)
80102578:	e8 43 fd ff ff       	call   801022c0 <iupdate>
      ip->valid = 0;
8010257d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80102584:	83 c4 10             	add    $0x10,%esp
80102587:	e9 3a ff ff ff       	jmp    801024c6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010258c:	83 ec 08             	sub    $0x8,%esp
8010258f:	50                   	push   %eax
80102590:	ff 33                	push   (%ebx)
80102592:	e8 39 db ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80102597:	83 c4 10             	add    $0x10,%esp
8010259a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010259d:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801025a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801025a6:	8d 70 5c             	lea    0x5c(%eax),%esi
801025a9:	89 cf                	mov    %ecx,%edi
801025ab:	eb 0a                	jmp    801025b7 <iput+0x117>
801025ad:	8d 76 00             	lea    0x0(%esi),%esi
801025b0:	83 c6 04             	add    $0x4,%esi
801025b3:	39 fe                	cmp    %edi,%esi
801025b5:	74 0f                	je     801025c6 <iput+0x126>
      if(a[j])
801025b7:	8b 16                	mov    (%esi),%edx
801025b9:	85 d2                	test   %edx,%edx
801025bb:	74 f3                	je     801025b0 <iput+0x110>
        bfree(ip->dev, a[j]);
801025bd:	8b 03                	mov    (%ebx),%eax
801025bf:	e8 fc f9 ff ff       	call   80101fc0 <bfree>
801025c4:	eb ea                	jmp    801025b0 <iput+0x110>
    brelse(bp);
801025c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801025c9:	83 ec 0c             	sub    $0xc,%esp
801025cc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801025cf:	50                   	push   %eax
801025d0:	e8 1b dc ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801025d5:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801025db:	8b 03                	mov    (%ebx),%eax
801025dd:	e8 de f9 ff ff       	call   80101fc0 <bfree>
    ip->addrs[NDIRECT] = 0;
801025e2:	83 c4 10             	add    $0x10,%esp
801025e5:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801025ec:	00 00 00 
801025ef:	e9 6b ff ff ff       	jmp    8010255f <iput+0xbf>
801025f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025fb:	00 
801025fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102600 <iunlockput>:
{
80102600:	55                   	push   %ebp
80102601:	89 e5                	mov    %esp,%ebp
80102603:	56                   	push   %esi
80102604:	53                   	push   %ebx
80102605:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102608:	85 db                	test   %ebx,%ebx
8010260a:	74 34                	je     80102640 <iunlockput+0x40>
8010260c:	83 ec 0c             	sub    $0xc,%esp
8010260f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102612:	56                   	push   %esi
80102613:	e8 18 29 00 00       	call   80104f30 <holdingsleep>
80102618:	83 c4 10             	add    $0x10,%esp
8010261b:	85 c0                	test   %eax,%eax
8010261d:	74 21                	je     80102640 <iunlockput+0x40>
8010261f:	8b 43 08             	mov    0x8(%ebx),%eax
80102622:	85 c0                	test   %eax,%eax
80102624:	7e 1a                	jle    80102640 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102626:	83 ec 0c             	sub    $0xc,%esp
80102629:	56                   	push   %esi
8010262a:	e8 c1 28 00 00       	call   80104ef0 <releasesleep>
  iput(ip);
8010262f:	83 c4 10             	add    $0x10,%esp
80102632:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80102635:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102638:	5b                   	pop    %ebx
80102639:	5e                   	pop    %esi
8010263a:	5d                   	pop    %ebp
  iput(ip);
8010263b:	e9 60 fe ff ff       	jmp    801024a0 <iput>
    panic("iunlock");
80102640:	83 ec 0c             	sub    $0xc,%esp
80102643:	68 72 7e 10 80       	push   $0x80107e72
80102648:	e8 23 e5 ff ff       	call   80100b70 <panic>
8010264d:	8d 76 00             	lea    0x0(%esi),%esi

80102650 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
80102653:	8b 55 08             	mov    0x8(%ebp),%edx
80102656:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102659:	8b 0a                	mov    (%edx),%ecx
8010265b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010265e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102661:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102664:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102668:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010266b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010266f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102673:	8b 52 58             	mov    0x58(%edx),%edx
80102676:	89 50 10             	mov    %edx,0x10(%eax)
}
80102679:	5d                   	pop    %ebp
8010267a:	c3                   	ret
8010267b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102680 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102680:	55                   	push   %ebp
80102681:	89 e5                	mov    %esp,%ebp
80102683:	57                   	push   %edi
80102684:	56                   	push   %esi
80102685:	53                   	push   %ebx
80102686:	83 ec 1c             	sub    $0x1c,%esp
80102689:	8b 75 08             	mov    0x8(%ebp),%esi
8010268c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010268f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102692:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80102697:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010269a:	89 75 d8             	mov    %esi,-0x28(%ebp)
8010269d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
801026a0:	0f 84 aa 00 00 00    	je     80102750 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801026a6:	8b 75 d8             	mov    -0x28(%ebp),%esi
801026a9:	8b 56 58             	mov    0x58(%esi),%edx
801026ac:	39 fa                	cmp    %edi,%edx
801026ae:	0f 82 bd 00 00 00    	jb     80102771 <readi+0xf1>
801026b4:	89 f9                	mov    %edi,%ecx
801026b6:	31 db                	xor    %ebx,%ebx
801026b8:	01 c1                	add    %eax,%ecx
801026ba:	0f 92 c3             	setb   %bl
801026bd:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801026c0:	0f 82 ab 00 00 00    	jb     80102771 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801026c6:	89 d3                	mov    %edx,%ebx
801026c8:	29 fb                	sub    %edi,%ebx
801026ca:	39 ca                	cmp    %ecx,%edx
801026cc:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801026cf:	85 c0                	test   %eax,%eax
801026d1:	74 73                	je     80102746 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801026d3:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801026d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801026d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801026e0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801026e3:	89 fa                	mov    %edi,%edx
801026e5:	c1 ea 09             	shr    $0x9,%edx
801026e8:	89 d8                	mov    %ebx,%eax
801026ea:	e8 51 f9 ff ff       	call   80102040 <bmap>
801026ef:	83 ec 08             	sub    $0x8,%esp
801026f2:	50                   	push   %eax
801026f3:	ff 33                	push   (%ebx)
801026f5:	e8 d6 d9 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801026fa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801026fd:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102702:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102704:	89 f8                	mov    %edi,%eax
80102706:	25 ff 01 00 00       	and    $0x1ff,%eax
8010270b:	29 f3                	sub    %esi,%ebx
8010270d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
8010270f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102713:	39 d9                	cmp    %ebx,%ecx
80102715:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102718:	83 c4 0c             	add    $0xc,%esp
8010271b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010271c:	01 de                	add    %ebx,%esi
8010271e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80102720:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102723:	50                   	push   %eax
80102724:	ff 75 e0             	push   -0x20(%ebp)
80102727:	e8 d4 2b 00 00       	call   80105300 <memmove>
    brelse(bp);
8010272c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010272f:	89 14 24             	mov    %edx,(%esp)
80102732:	e8 b9 da ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102737:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010273a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010273d:	83 c4 10             	add    $0x10,%esp
80102740:	39 de                	cmp    %ebx,%esi
80102742:	72 9c                	jb     801026e0 <readi+0x60>
80102744:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80102746:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102749:	5b                   	pop    %ebx
8010274a:	5e                   	pop    %esi
8010274b:	5f                   	pop    %edi
8010274c:	5d                   	pop    %ebp
8010274d:	c3                   	ret
8010274e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102750:	0f bf 56 52          	movswl 0x52(%esi),%edx
80102754:	66 83 fa 09          	cmp    $0x9,%dx
80102758:	77 17                	ja     80102771 <readi+0xf1>
8010275a:	8b 14 d5 20 09 11 80 	mov    -0x7feef6e0(,%edx,8),%edx
80102761:	85 d2                	test   %edx,%edx
80102763:	74 0c                	je     80102771 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102765:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102768:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010276b:	5b                   	pop    %ebx
8010276c:	5e                   	pop    %esi
8010276d:	5f                   	pop    %edi
8010276e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010276f:	ff e2                	jmp    *%edx
      return -1;
80102771:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102776:	eb ce                	jmp    80102746 <readi+0xc6>
80102778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010277f:	00 

80102780 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	57                   	push   %edi
80102784:	56                   	push   %esi
80102785:	53                   	push   %ebx
80102786:	83 ec 1c             	sub    $0x1c,%esp
80102789:	8b 45 08             	mov    0x8(%ebp),%eax
8010278c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010278f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102792:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102797:	89 7d dc             	mov    %edi,-0x24(%ebp)
8010279a:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010279d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
801027a0:	0f 84 ba 00 00 00    	je     80102860 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801027a6:	39 78 58             	cmp    %edi,0x58(%eax)
801027a9:	0f 82 ea 00 00 00    	jb     80102899 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801027af:	8b 75 e0             	mov    -0x20(%ebp),%esi
801027b2:	89 f2                	mov    %esi,%edx
801027b4:	01 fa                	add    %edi,%edx
801027b6:	0f 82 dd 00 00 00    	jb     80102899 <writei+0x119>
801027bc:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
801027c2:	0f 87 d1 00 00 00    	ja     80102899 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801027c8:	85 f6                	test   %esi,%esi
801027ca:	0f 84 85 00 00 00    	je     80102855 <writei+0xd5>
801027d0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801027d7:	89 45 d8             	mov    %eax,-0x28(%ebp)
801027da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801027e0:	8b 75 d8             	mov    -0x28(%ebp),%esi
801027e3:	89 fa                	mov    %edi,%edx
801027e5:	c1 ea 09             	shr    $0x9,%edx
801027e8:	89 f0                	mov    %esi,%eax
801027ea:	e8 51 f8 ff ff       	call   80102040 <bmap>
801027ef:	83 ec 08             	sub    $0x8,%esp
801027f2:	50                   	push   %eax
801027f3:	ff 36                	push   (%esi)
801027f5:	e8 d6 d8 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801027fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801027fd:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102800:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102805:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80102807:	89 f8                	mov    %edi,%eax
80102809:	25 ff 01 00 00       	and    $0x1ff,%eax
8010280e:	29 d3                	sub    %edx,%ebx
80102810:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102812:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102816:	39 d9                	cmp    %ebx,%ecx
80102818:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
8010281b:	83 c4 0c             	add    $0xc,%esp
8010281e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010281f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80102821:	ff 75 dc             	push   -0x24(%ebp)
80102824:	50                   	push   %eax
80102825:	e8 d6 2a 00 00       	call   80105300 <memmove>
    log_write(bp);
8010282a:	89 34 24             	mov    %esi,(%esp)
8010282d:	e8 be 12 00 00       	call   80103af0 <log_write>
    brelse(bp);
80102832:	89 34 24             	mov    %esi,(%esp)
80102835:	e8 b6 d9 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010283a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010283d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102840:	83 c4 10             	add    $0x10,%esp
80102843:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102846:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102849:	39 d8                	cmp    %ebx,%eax
8010284b:	72 93                	jb     801027e0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
8010284d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102850:	39 78 58             	cmp    %edi,0x58(%eax)
80102853:	72 33                	jb     80102888 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102855:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102858:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010285b:	5b                   	pop    %ebx
8010285c:	5e                   	pop    %esi
8010285d:	5f                   	pop    %edi
8010285e:	5d                   	pop    %ebp
8010285f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102860:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102864:	66 83 f8 09          	cmp    $0x9,%ax
80102868:	77 2f                	ja     80102899 <writei+0x119>
8010286a:	8b 04 c5 24 09 11 80 	mov    -0x7feef6dc(,%eax,8),%eax
80102871:	85 c0                	test   %eax,%eax
80102873:	74 24                	je     80102899 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80102875:	89 75 10             	mov    %esi,0x10(%ebp)
}
80102878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010287b:	5b                   	pop    %ebx
8010287c:	5e                   	pop    %esi
8010287d:	5f                   	pop    %edi
8010287e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010287f:	ff e0                	jmp    *%eax
80102881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80102888:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010288b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
8010288e:	50                   	push   %eax
8010288f:	e8 2c fa ff ff       	call   801022c0 <iupdate>
80102894:	83 c4 10             	add    $0x10,%esp
80102897:	eb bc                	jmp    80102855 <writei+0xd5>
      return -1;
80102899:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010289e:	eb b8                	jmp    80102858 <writei+0xd8>

801028a0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801028a0:	55                   	push   %ebp
801028a1:	89 e5                	mov    %esp,%ebp
801028a3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
801028a6:	6a 0e                	push   $0xe
801028a8:	ff 75 0c             	push   0xc(%ebp)
801028ab:	ff 75 08             	push   0x8(%ebp)
801028ae:	e8 bd 2a 00 00       	call   80105370 <strncmp>
}
801028b3:	c9                   	leave
801028b4:	c3                   	ret
801028b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028bc:	00 
801028bd:	8d 76 00             	lea    0x0(%esi),%esi

801028c0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801028c0:	55                   	push   %ebp
801028c1:	89 e5                	mov    %esp,%ebp
801028c3:	57                   	push   %edi
801028c4:	56                   	push   %esi
801028c5:	53                   	push   %ebx
801028c6:	83 ec 1c             	sub    $0x1c,%esp
801028c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801028cc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801028d1:	0f 85 85 00 00 00    	jne    8010295c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801028d7:	8b 53 58             	mov    0x58(%ebx),%edx
801028da:	31 ff                	xor    %edi,%edi
801028dc:	8d 75 d8             	lea    -0x28(%ebp),%esi
801028df:	85 d2                	test   %edx,%edx
801028e1:	74 3e                	je     80102921 <dirlookup+0x61>
801028e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801028e8:	6a 10                	push   $0x10
801028ea:	57                   	push   %edi
801028eb:	56                   	push   %esi
801028ec:	53                   	push   %ebx
801028ed:	e8 8e fd ff ff       	call   80102680 <readi>
801028f2:	83 c4 10             	add    $0x10,%esp
801028f5:	83 f8 10             	cmp    $0x10,%eax
801028f8:	75 55                	jne    8010294f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
801028fa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801028ff:	74 18                	je     80102919 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102901:	83 ec 04             	sub    $0x4,%esp
80102904:	8d 45 da             	lea    -0x26(%ebp),%eax
80102907:	6a 0e                	push   $0xe
80102909:	50                   	push   %eax
8010290a:	ff 75 0c             	push   0xc(%ebp)
8010290d:	e8 5e 2a 00 00       	call   80105370 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102912:	83 c4 10             	add    $0x10,%esp
80102915:	85 c0                	test   %eax,%eax
80102917:	74 17                	je     80102930 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102919:	83 c7 10             	add    $0x10,%edi
8010291c:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010291f:	72 c7                	jb     801028e8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102921:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102924:	31 c0                	xor    %eax,%eax
}
80102926:	5b                   	pop    %ebx
80102927:	5e                   	pop    %esi
80102928:	5f                   	pop    %edi
80102929:	5d                   	pop    %ebp
8010292a:	c3                   	ret
8010292b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80102930:	8b 45 10             	mov    0x10(%ebp),%eax
80102933:	85 c0                	test   %eax,%eax
80102935:	74 05                	je     8010293c <dirlookup+0x7c>
        *poff = off;
80102937:	8b 45 10             	mov    0x10(%ebp),%eax
8010293a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010293c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102940:	8b 03                	mov    (%ebx),%eax
80102942:	e8 79 f5 ff ff       	call   80101ec0 <iget>
}
80102947:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010294a:	5b                   	pop    %ebx
8010294b:	5e                   	pop    %esi
8010294c:	5f                   	pop    %edi
8010294d:	5d                   	pop    %ebp
8010294e:	c3                   	ret
      panic("dirlookup read");
8010294f:	83 ec 0c             	sub    $0xc,%esp
80102952:	68 8c 7e 10 80       	push   $0x80107e8c
80102957:	e8 14 e2 ff ff       	call   80100b70 <panic>
    panic("dirlookup not DIR");
8010295c:	83 ec 0c             	sub    $0xc,%esp
8010295f:	68 7a 7e 10 80       	push   $0x80107e7a
80102964:	e8 07 e2 ff ff       	call   80100b70 <panic>
80102969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102970 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102970:	55                   	push   %ebp
80102971:	89 e5                	mov    %esp,%ebp
80102973:	57                   	push   %edi
80102974:	56                   	push   %esi
80102975:	53                   	push   %ebx
80102976:	89 c3                	mov    %eax,%ebx
80102978:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010297b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010297e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102981:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102984:	0f 84 9e 01 00 00    	je     80102b28 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010298a:	e8 a1 1b 00 00       	call   80104530 <myproc>
  acquire(&icache.lock);
8010298f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102992:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102995:	68 80 09 11 80       	push   $0x80110980
8010299a:	e8 d1 27 00 00       	call   80105170 <acquire>
  ip->ref++;
8010299f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
801029a3:	c7 04 24 80 09 11 80 	movl   $0x80110980,(%esp)
801029aa:	e8 61 27 00 00       	call   80105110 <release>
801029af:	83 c4 10             	add    $0x10,%esp
801029b2:	eb 07                	jmp    801029bb <namex+0x4b>
801029b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801029b8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801029bb:	0f b6 03             	movzbl (%ebx),%eax
801029be:	3c 2f                	cmp    $0x2f,%al
801029c0:	74 f6                	je     801029b8 <namex+0x48>
  if(*path == 0)
801029c2:	84 c0                	test   %al,%al
801029c4:	0f 84 06 01 00 00    	je     80102ad0 <namex+0x160>
  while(*path != '/' && *path != 0)
801029ca:	0f b6 03             	movzbl (%ebx),%eax
801029cd:	84 c0                	test   %al,%al
801029cf:	0f 84 10 01 00 00    	je     80102ae5 <namex+0x175>
801029d5:	89 df                	mov    %ebx,%edi
801029d7:	3c 2f                	cmp    $0x2f,%al
801029d9:	0f 84 06 01 00 00    	je     80102ae5 <namex+0x175>
801029df:	90                   	nop
801029e0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
801029e4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
801029e7:	3c 2f                	cmp    $0x2f,%al
801029e9:	74 04                	je     801029ef <namex+0x7f>
801029eb:	84 c0                	test   %al,%al
801029ed:	75 f1                	jne    801029e0 <namex+0x70>
  len = path - s;
801029ef:	89 f8                	mov    %edi,%eax
801029f1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
801029f3:	83 f8 0d             	cmp    $0xd,%eax
801029f6:	0f 8e ac 00 00 00    	jle    80102aa8 <namex+0x138>
    memmove(name, s, DIRSIZ);
801029fc:	83 ec 04             	sub    $0x4,%esp
801029ff:	6a 0e                	push   $0xe
80102a01:	53                   	push   %ebx
80102a02:	89 fb                	mov    %edi,%ebx
80102a04:	ff 75 e4             	push   -0x1c(%ebp)
80102a07:	e8 f4 28 00 00       	call   80105300 <memmove>
80102a0c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102a0f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102a12:	75 0c                	jne    80102a20 <namex+0xb0>
80102a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102a18:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102a1b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102a1e:	74 f8                	je     80102a18 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102a20:	83 ec 0c             	sub    $0xc,%esp
80102a23:	56                   	push   %esi
80102a24:	e8 47 f9 ff ff       	call   80102370 <ilock>
    if(ip->type != T_DIR){
80102a29:	83 c4 10             	add    $0x10,%esp
80102a2c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102a31:	0f 85 b7 00 00 00    	jne    80102aee <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102a37:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102a3a:	85 c0                	test   %eax,%eax
80102a3c:	74 09                	je     80102a47 <namex+0xd7>
80102a3e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102a41:	0f 84 f7 00 00 00    	je     80102b3e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102a47:	83 ec 04             	sub    $0x4,%esp
80102a4a:	6a 00                	push   $0x0
80102a4c:	ff 75 e4             	push   -0x1c(%ebp)
80102a4f:	56                   	push   %esi
80102a50:	e8 6b fe ff ff       	call   801028c0 <dirlookup>
80102a55:	83 c4 10             	add    $0x10,%esp
80102a58:	89 c7                	mov    %eax,%edi
80102a5a:	85 c0                	test   %eax,%eax
80102a5c:	0f 84 8c 00 00 00    	je     80102aee <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102a62:	83 ec 0c             	sub    $0xc,%esp
80102a65:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102a68:	51                   	push   %ecx
80102a69:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102a6c:	e8 bf 24 00 00       	call   80104f30 <holdingsleep>
80102a71:	83 c4 10             	add    $0x10,%esp
80102a74:	85 c0                	test   %eax,%eax
80102a76:	0f 84 02 01 00 00    	je     80102b7e <namex+0x20e>
80102a7c:	8b 56 08             	mov    0x8(%esi),%edx
80102a7f:	85 d2                	test   %edx,%edx
80102a81:	0f 8e f7 00 00 00    	jle    80102b7e <namex+0x20e>
  releasesleep(&ip->lock);
80102a87:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102a8a:	83 ec 0c             	sub    $0xc,%esp
80102a8d:	51                   	push   %ecx
80102a8e:	e8 5d 24 00 00       	call   80104ef0 <releasesleep>
  iput(ip);
80102a93:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80102a96:	89 fe                	mov    %edi,%esi
  iput(ip);
80102a98:	e8 03 fa ff ff       	call   801024a0 <iput>
80102a9d:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102aa0:	e9 16 ff ff ff       	jmp    801029bb <namex+0x4b>
80102aa5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102aa8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102aab:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80102aae:	83 ec 04             	sub    $0x4,%esp
80102ab1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102ab4:	50                   	push   %eax
80102ab5:	53                   	push   %ebx
    name[len] = 0;
80102ab6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102ab8:	ff 75 e4             	push   -0x1c(%ebp)
80102abb:	e8 40 28 00 00       	call   80105300 <memmove>
    name[len] = 0;
80102ac0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102ac3:	83 c4 10             	add    $0x10,%esp
80102ac6:	c6 01 00             	movb   $0x0,(%ecx)
80102ac9:	e9 41 ff ff ff       	jmp    80102a0f <namex+0x9f>
80102ace:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80102ad0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102ad3:	85 c0                	test   %eax,%eax
80102ad5:	0f 85 93 00 00 00    	jne    80102b6e <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80102adb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ade:	89 f0                	mov    %esi,%eax
80102ae0:	5b                   	pop    %ebx
80102ae1:	5e                   	pop    %esi
80102ae2:	5f                   	pop    %edi
80102ae3:	5d                   	pop    %ebp
80102ae4:	c3                   	ret
  while(*path != '/' && *path != 0)
80102ae5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102ae8:	89 df                	mov    %ebx,%edi
80102aea:	31 c0                	xor    %eax,%eax
80102aec:	eb c0                	jmp    80102aae <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102aee:	83 ec 0c             	sub    $0xc,%esp
80102af1:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102af4:	53                   	push   %ebx
80102af5:	e8 36 24 00 00       	call   80104f30 <holdingsleep>
80102afa:	83 c4 10             	add    $0x10,%esp
80102afd:	85 c0                	test   %eax,%eax
80102aff:	74 7d                	je     80102b7e <namex+0x20e>
80102b01:	8b 4e 08             	mov    0x8(%esi),%ecx
80102b04:	85 c9                	test   %ecx,%ecx
80102b06:	7e 76                	jle    80102b7e <namex+0x20e>
  releasesleep(&ip->lock);
80102b08:	83 ec 0c             	sub    $0xc,%esp
80102b0b:	53                   	push   %ebx
80102b0c:	e8 df 23 00 00       	call   80104ef0 <releasesleep>
  iput(ip);
80102b11:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102b14:	31 f6                	xor    %esi,%esi
  iput(ip);
80102b16:	e8 85 f9 ff ff       	call   801024a0 <iput>
      return 0;
80102b1b:	83 c4 10             	add    $0x10,%esp
}
80102b1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b21:	89 f0                	mov    %esi,%eax
80102b23:	5b                   	pop    %ebx
80102b24:	5e                   	pop    %esi
80102b25:	5f                   	pop    %edi
80102b26:	5d                   	pop    %ebp
80102b27:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102b28:	ba 01 00 00 00       	mov    $0x1,%edx
80102b2d:	b8 01 00 00 00       	mov    $0x1,%eax
80102b32:	e8 89 f3 ff ff       	call   80101ec0 <iget>
80102b37:	89 c6                	mov    %eax,%esi
80102b39:	e9 7d fe ff ff       	jmp    801029bb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102b3e:	83 ec 0c             	sub    $0xc,%esp
80102b41:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102b44:	53                   	push   %ebx
80102b45:	e8 e6 23 00 00       	call   80104f30 <holdingsleep>
80102b4a:	83 c4 10             	add    $0x10,%esp
80102b4d:	85 c0                	test   %eax,%eax
80102b4f:	74 2d                	je     80102b7e <namex+0x20e>
80102b51:	8b 7e 08             	mov    0x8(%esi),%edi
80102b54:	85 ff                	test   %edi,%edi
80102b56:	7e 26                	jle    80102b7e <namex+0x20e>
  releasesleep(&ip->lock);
80102b58:	83 ec 0c             	sub    $0xc,%esp
80102b5b:	53                   	push   %ebx
80102b5c:	e8 8f 23 00 00       	call   80104ef0 <releasesleep>
}
80102b61:	83 c4 10             	add    $0x10,%esp
}
80102b64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b67:	89 f0                	mov    %esi,%eax
80102b69:	5b                   	pop    %ebx
80102b6a:	5e                   	pop    %esi
80102b6b:	5f                   	pop    %edi
80102b6c:	5d                   	pop    %ebp
80102b6d:	c3                   	ret
    iput(ip);
80102b6e:	83 ec 0c             	sub    $0xc,%esp
80102b71:	56                   	push   %esi
      return 0;
80102b72:	31 f6                	xor    %esi,%esi
    iput(ip);
80102b74:	e8 27 f9 ff ff       	call   801024a0 <iput>
    return 0;
80102b79:	83 c4 10             	add    $0x10,%esp
80102b7c:	eb a0                	jmp    80102b1e <namex+0x1ae>
    panic("iunlock");
80102b7e:	83 ec 0c             	sub    $0xc,%esp
80102b81:	68 72 7e 10 80       	push   $0x80107e72
80102b86:	e8 e5 df ff ff       	call   80100b70 <panic>
80102b8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102b90 <dirlink>:
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	57                   	push   %edi
80102b94:	56                   	push   %esi
80102b95:	53                   	push   %ebx
80102b96:	83 ec 20             	sub    $0x20,%esp
80102b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102b9c:	6a 00                	push   $0x0
80102b9e:	ff 75 0c             	push   0xc(%ebp)
80102ba1:	53                   	push   %ebx
80102ba2:	e8 19 fd ff ff       	call   801028c0 <dirlookup>
80102ba7:	83 c4 10             	add    $0x10,%esp
80102baa:	85 c0                	test   %eax,%eax
80102bac:	75 67                	jne    80102c15 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102bae:	8b 7b 58             	mov    0x58(%ebx),%edi
80102bb1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102bb4:	85 ff                	test   %edi,%edi
80102bb6:	74 29                	je     80102be1 <dirlink+0x51>
80102bb8:	31 ff                	xor    %edi,%edi
80102bba:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102bbd:	eb 09                	jmp    80102bc8 <dirlink+0x38>
80102bbf:	90                   	nop
80102bc0:	83 c7 10             	add    $0x10,%edi
80102bc3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102bc6:	73 19                	jae    80102be1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102bc8:	6a 10                	push   $0x10
80102bca:	57                   	push   %edi
80102bcb:	56                   	push   %esi
80102bcc:	53                   	push   %ebx
80102bcd:	e8 ae fa ff ff       	call   80102680 <readi>
80102bd2:	83 c4 10             	add    $0x10,%esp
80102bd5:	83 f8 10             	cmp    $0x10,%eax
80102bd8:	75 4e                	jne    80102c28 <dirlink+0x98>
    if(de.inum == 0)
80102bda:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102bdf:	75 df                	jne    80102bc0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102be1:	83 ec 04             	sub    $0x4,%esp
80102be4:	8d 45 da             	lea    -0x26(%ebp),%eax
80102be7:	6a 0e                	push   $0xe
80102be9:	ff 75 0c             	push   0xc(%ebp)
80102bec:	50                   	push   %eax
80102bed:	e8 ce 27 00 00       	call   801053c0 <strncpy>
  de.inum = inum;
80102bf2:	8b 45 10             	mov    0x10(%ebp),%eax
80102bf5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102bf9:	6a 10                	push   $0x10
80102bfb:	57                   	push   %edi
80102bfc:	56                   	push   %esi
80102bfd:	53                   	push   %ebx
80102bfe:	e8 7d fb ff ff       	call   80102780 <writei>
80102c03:	83 c4 20             	add    $0x20,%esp
80102c06:	83 f8 10             	cmp    $0x10,%eax
80102c09:	75 2a                	jne    80102c35 <dirlink+0xa5>
  return 0;
80102c0b:	31 c0                	xor    %eax,%eax
}
80102c0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c10:	5b                   	pop    %ebx
80102c11:	5e                   	pop    %esi
80102c12:	5f                   	pop    %edi
80102c13:	5d                   	pop    %ebp
80102c14:	c3                   	ret
    iput(ip);
80102c15:	83 ec 0c             	sub    $0xc,%esp
80102c18:	50                   	push   %eax
80102c19:	e8 82 f8 ff ff       	call   801024a0 <iput>
    return -1;
80102c1e:	83 c4 10             	add    $0x10,%esp
80102c21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c26:	eb e5                	jmp    80102c0d <dirlink+0x7d>
      panic("dirlink read");
80102c28:	83 ec 0c             	sub    $0xc,%esp
80102c2b:	68 9b 7e 10 80       	push   $0x80107e9b
80102c30:	e8 3b df ff ff       	call   80100b70 <panic>
    panic("dirlink");
80102c35:	83 ec 0c             	sub    $0xc,%esp
80102c38:	68 f7 80 10 80       	push   $0x801080f7
80102c3d:	e8 2e df ff ff       	call   80100b70 <panic>
80102c42:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c49:	00 
80102c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102c50 <namei>:

struct inode*
namei(char *path)
{
80102c50:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102c51:	31 d2                	xor    %edx,%edx
{
80102c53:	89 e5                	mov    %esp,%ebp
80102c55:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102c58:	8b 45 08             	mov    0x8(%ebp),%eax
80102c5b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102c5e:	e8 0d fd ff ff       	call   80102970 <namex>
}
80102c63:	c9                   	leave
80102c64:	c3                   	ret
80102c65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c6c:	00 
80102c6d:	8d 76 00             	lea    0x0(%esi),%esi

80102c70 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102c70:	55                   	push   %ebp
  return namex(path, 1, name);
80102c71:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102c76:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102c78:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102c7b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102c7e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102c7f:	e9 ec fc ff ff       	jmp    80102970 <namex>
80102c84:	66 90                	xchg   %ax,%ax
80102c86:	66 90                	xchg   %ax,%ax
80102c88:	66 90                	xchg   %ax,%ax
80102c8a:	66 90                	xchg   %ax,%ax
80102c8c:	66 90                	xchg   %ax,%ax
80102c8e:	66 90                	xchg   %ax,%ax

80102c90 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102c90:	55                   	push   %ebp
80102c91:	89 e5                	mov    %esp,%ebp
80102c93:	57                   	push   %edi
80102c94:	56                   	push   %esi
80102c95:	53                   	push   %ebx
80102c96:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102c99:	85 c0                	test   %eax,%eax
80102c9b:	0f 84 b4 00 00 00    	je     80102d55 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102ca1:	8b 70 08             	mov    0x8(%eax),%esi
80102ca4:	89 c3                	mov    %eax,%ebx
80102ca6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102cac:	0f 87 96 00 00 00    	ja     80102d48 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cb2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102cb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102cbe:	00 
80102cbf:	90                   	nop
80102cc0:	89 ca                	mov    %ecx,%edx
80102cc2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102cc3:	83 e0 c0             	and    $0xffffffc0,%eax
80102cc6:	3c 40                	cmp    $0x40,%al
80102cc8:	75 f6                	jne    80102cc0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cca:	31 ff                	xor    %edi,%edi
80102ccc:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102cd1:	89 f8                	mov    %edi,%eax
80102cd3:	ee                   	out    %al,(%dx)
80102cd4:	b8 01 00 00 00       	mov    $0x1,%eax
80102cd9:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102cde:	ee                   	out    %al,(%dx)
80102cdf:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102ce4:	89 f0                	mov    %esi,%eax
80102ce6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102ce7:	89 f0                	mov    %esi,%eax
80102ce9:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102cee:	c1 f8 08             	sar    $0x8,%eax
80102cf1:	ee                   	out    %al,(%dx)
80102cf2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102cf7:	89 f8                	mov    %edi,%eax
80102cf9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102cfa:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102cfe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102d03:	c1 e0 04             	shl    $0x4,%eax
80102d06:	83 e0 10             	and    $0x10,%eax
80102d09:	83 c8 e0             	or     $0xffffffe0,%eax
80102d0c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102d0d:	f6 03 04             	testb  $0x4,(%ebx)
80102d10:	75 16                	jne    80102d28 <idestart+0x98>
80102d12:	b8 20 00 00 00       	mov    $0x20,%eax
80102d17:	89 ca                	mov    %ecx,%edx
80102d19:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102d1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d1d:	5b                   	pop    %ebx
80102d1e:	5e                   	pop    %esi
80102d1f:	5f                   	pop    %edi
80102d20:	5d                   	pop    %ebp
80102d21:	c3                   	ret
80102d22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d28:	b8 30 00 00 00       	mov    $0x30,%eax
80102d2d:	89 ca                	mov    %ecx,%edx
80102d2f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102d30:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102d35:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102d38:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102d3d:	fc                   	cld
80102d3e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102d40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d43:	5b                   	pop    %ebx
80102d44:	5e                   	pop    %esi
80102d45:	5f                   	pop    %edi
80102d46:	5d                   	pop    %ebp
80102d47:	c3                   	ret
    panic("incorrect blockno");
80102d48:	83 ec 0c             	sub    $0xc,%esp
80102d4b:	68 b1 7e 10 80       	push   $0x80107eb1
80102d50:	e8 1b de ff ff       	call   80100b70 <panic>
    panic("idestart");
80102d55:	83 ec 0c             	sub    $0xc,%esp
80102d58:	68 a8 7e 10 80       	push   $0x80107ea8
80102d5d:	e8 0e de ff ff       	call   80100b70 <panic>
80102d62:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d69:	00 
80102d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102d70 <ideinit>:
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102d76:	68 c3 7e 10 80       	push   $0x80107ec3
80102d7b:	68 20 26 11 80       	push   $0x80112620
80102d80:	e8 fb 21 00 00       	call   80104f80 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102d85:	58                   	pop    %eax
80102d86:	a1 a4 27 11 80       	mov    0x801127a4,%eax
80102d8b:	5a                   	pop    %edx
80102d8c:	83 e8 01             	sub    $0x1,%eax
80102d8f:	50                   	push   %eax
80102d90:	6a 0e                	push   $0xe
80102d92:	e8 99 02 00 00       	call   80103030 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102d97:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d9a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102d9f:	90                   	nop
80102da0:	89 ca                	mov    %ecx,%edx
80102da2:	ec                   	in     (%dx),%al
80102da3:	83 e0 c0             	and    $0xffffffc0,%eax
80102da6:	3c 40                	cmp    $0x40,%al
80102da8:	75 f6                	jne    80102da0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102daa:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102daf:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102db4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102db5:	89 ca                	mov    %ecx,%edx
80102db7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102db8:	84 c0                	test   %al,%al
80102dba:	75 1e                	jne    80102dda <ideinit+0x6a>
80102dbc:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102dc1:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102dc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dcd:	00 
80102dce:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102dd0:	83 e9 01             	sub    $0x1,%ecx
80102dd3:	74 0f                	je     80102de4 <ideinit+0x74>
80102dd5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102dd6:	84 c0                	test   %al,%al
80102dd8:	74 f6                	je     80102dd0 <ideinit+0x60>
      havedisk1 = 1;
80102dda:	c7 05 00 26 11 80 01 	movl   $0x1,0x80112600
80102de1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102de4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102de9:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102dee:	ee                   	out    %al,(%dx)
}
80102def:	c9                   	leave
80102df0:	c3                   	ret
80102df1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102df8:	00 
80102df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e00 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102e00:	55                   	push   %ebp
80102e01:	89 e5                	mov    %esp,%ebp
80102e03:	57                   	push   %edi
80102e04:	56                   	push   %esi
80102e05:	53                   	push   %ebx
80102e06:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102e09:	68 20 26 11 80       	push   $0x80112620
80102e0e:	e8 5d 23 00 00       	call   80105170 <acquire>

  if((b = idequeue) == 0){
80102e13:	8b 1d 04 26 11 80    	mov    0x80112604,%ebx
80102e19:	83 c4 10             	add    $0x10,%esp
80102e1c:	85 db                	test   %ebx,%ebx
80102e1e:	74 63                	je     80102e83 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102e20:	8b 43 58             	mov    0x58(%ebx),%eax
80102e23:	a3 04 26 11 80       	mov    %eax,0x80112604

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102e28:	8b 33                	mov    (%ebx),%esi
80102e2a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102e30:	75 2f                	jne    80102e61 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e32:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102e37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e3e:	00 
80102e3f:	90                   	nop
80102e40:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102e41:	89 c1                	mov    %eax,%ecx
80102e43:	83 e1 c0             	and    $0xffffffc0,%ecx
80102e46:	80 f9 40             	cmp    $0x40,%cl
80102e49:	75 f5                	jne    80102e40 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102e4b:	a8 21                	test   $0x21,%al
80102e4d:	75 12                	jne    80102e61 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
80102e4f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102e52:	b9 80 00 00 00       	mov    $0x80,%ecx
80102e57:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102e5c:	fc                   	cld
80102e5d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102e5f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102e61:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102e64:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102e67:	83 ce 02             	or     $0x2,%esi
80102e6a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102e6c:	53                   	push   %ebx
80102e6d:	e8 3e 1e 00 00       	call   80104cb0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102e72:	a1 04 26 11 80       	mov    0x80112604,%eax
80102e77:	83 c4 10             	add    $0x10,%esp
80102e7a:	85 c0                	test   %eax,%eax
80102e7c:	74 05                	je     80102e83 <ideintr+0x83>
    idestart(idequeue);
80102e7e:	e8 0d fe ff ff       	call   80102c90 <idestart>
    release(&idelock);
80102e83:	83 ec 0c             	sub    $0xc,%esp
80102e86:	68 20 26 11 80       	push   $0x80112620
80102e8b:	e8 80 22 00 00       	call   80105110 <release>

  release(&idelock);
}
80102e90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e93:	5b                   	pop    %ebx
80102e94:	5e                   	pop    %esi
80102e95:	5f                   	pop    %edi
80102e96:	5d                   	pop    %ebp
80102e97:	c3                   	ret
80102e98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e9f:	00 

80102ea0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	53                   	push   %ebx
80102ea4:	83 ec 10             	sub    $0x10,%esp
80102ea7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102eaa:	8d 43 0c             	lea    0xc(%ebx),%eax
80102ead:	50                   	push   %eax
80102eae:	e8 7d 20 00 00       	call   80104f30 <holdingsleep>
80102eb3:	83 c4 10             	add    $0x10,%esp
80102eb6:	85 c0                	test   %eax,%eax
80102eb8:	0f 84 c3 00 00 00    	je     80102f81 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102ebe:	8b 03                	mov    (%ebx),%eax
80102ec0:	83 e0 06             	and    $0x6,%eax
80102ec3:	83 f8 02             	cmp    $0x2,%eax
80102ec6:	0f 84 a8 00 00 00    	je     80102f74 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102ecc:	8b 53 04             	mov    0x4(%ebx),%edx
80102ecf:	85 d2                	test   %edx,%edx
80102ed1:	74 0d                	je     80102ee0 <iderw+0x40>
80102ed3:	a1 00 26 11 80       	mov    0x80112600,%eax
80102ed8:	85 c0                	test   %eax,%eax
80102eda:	0f 84 87 00 00 00    	je     80102f67 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102ee0:	83 ec 0c             	sub    $0xc,%esp
80102ee3:	68 20 26 11 80       	push   $0x80112620
80102ee8:	e8 83 22 00 00       	call   80105170 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102eed:	a1 04 26 11 80       	mov    0x80112604,%eax
  b->qnext = 0;
80102ef2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102ef9:	83 c4 10             	add    $0x10,%esp
80102efc:	85 c0                	test   %eax,%eax
80102efe:	74 60                	je     80102f60 <iderw+0xc0>
80102f00:	89 c2                	mov    %eax,%edx
80102f02:	8b 40 58             	mov    0x58(%eax),%eax
80102f05:	85 c0                	test   %eax,%eax
80102f07:	75 f7                	jne    80102f00 <iderw+0x60>
80102f09:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102f0c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102f0e:	39 1d 04 26 11 80    	cmp    %ebx,0x80112604
80102f14:	74 3a                	je     80102f50 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102f16:	8b 03                	mov    (%ebx),%eax
80102f18:	83 e0 06             	and    $0x6,%eax
80102f1b:	83 f8 02             	cmp    $0x2,%eax
80102f1e:	74 1b                	je     80102f3b <iderw+0x9b>
    sleep(b, &idelock);
80102f20:	83 ec 08             	sub    $0x8,%esp
80102f23:	68 20 26 11 80       	push   $0x80112620
80102f28:	53                   	push   %ebx
80102f29:	e8 c2 1c 00 00       	call   80104bf0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102f2e:	8b 03                	mov    (%ebx),%eax
80102f30:	83 c4 10             	add    $0x10,%esp
80102f33:	83 e0 06             	and    $0x6,%eax
80102f36:	83 f8 02             	cmp    $0x2,%eax
80102f39:	75 e5                	jne    80102f20 <iderw+0x80>
  }


  release(&idelock);
80102f3b:	c7 45 08 20 26 11 80 	movl   $0x80112620,0x8(%ebp)
}
80102f42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f45:	c9                   	leave
  release(&idelock);
80102f46:	e9 c5 21 00 00       	jmp    80105110 <release>
80102f4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102f50:	89 d8                	mov    %ebx,%eax
80102f52:	e8 39 fd ff ff       	call   80102c90 <idestart>
80102f57:	eb bd                	jmp    80102f16 <iderw+0x76>
80102f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102f60:	ba 04 26 11 80       	mov    $0x80112604,%edx
80102f65:	eb a5                	jmp    80102f0c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102f67:	83 ec 0c             	sub    $0xc,%esp
80102f6a:	68 f2 7e 10 80       	push   $0x80107ef2
80102f6f:	e8 fc db ff ff       	call   80100b70 <panic>
    panic("iderw: nothing to do");
80102f74:	83 ec 0c             	sub    $0xc,%esp
80102f77:	68 dd 7e 10 80       	push   $0x80107edd
80102f7c:	e8 ef db ff ff       	call   80100b70 <panic>
    panic("iderw: buf not locked");
80102f81:	83 ec 0c             	sub    $0xc,%esp
80102f84:	68 c7 7e 10 80       	push   $0x80107ec7
80102f89:	e8 e2 db ff ff       	call   80100b70 <panic>
80102f8e:	66 90                	xchg   %ax,%ax

80102f90 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	56                   	push   %esi
80102f94:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102f95:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
80102f9c:	00 c0 fe 
  ioapic->reg = reg;
80102f9f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102fa6:	00 00 00 
  return ioapic->data;
80102fa9:	8b 15 54 26 11 80    	mov    0x80112654,%edx
80102faf:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102fb2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102fb8:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102fbe:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102fc5:	c1 ee 10             	shr    $0x10,%esi
80102fc8:	89 f0                	mov    %esi,%eax
80102fca:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
80102fcd:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102fd0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102fd3:	39 c2                	cmp    %eax,%edx
80102fd5:	74 16                	je     80102fed <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102fd7:	83 ec 0c             	sub    $0xc,%esp
80102fda:	68 18 83 10 80       	push   $0x80108318
80102fdf:	e8 3c d9 ff ff       	call   80100920 <cprintf>
  ioapic->reg = reg;
80102fe4:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
80102fea:	83 c4 10             	add    $0x10,%esp
{
80102fed:	ba 10 00 00 00       	mov    $0x10,%edx
80102ff2:	31 c0                	xor    %eax,%eax
80102ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102ff8:	89 13                	mov    %edx,(%ebx)
80102ffa:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
80102ffd:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80103003:	83 c0 01             	add    $0x1,%eax
80103006:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010300c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010300f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80103012:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80103015:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80103017:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
8010301d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80103024:	39 c6                	cmp    %eax,%esi
80103026:	7d d0                	jge    80102ff8 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80103028:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010302b:	5b                   	pop    %ebx
8010302c:	5e                   	pop    %esi
8010302d:	5d                   	pop    %ebp
8010302e:	c3                   	ret
8010302f:	90                   	nop

80103030 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80103030:	55                   	push   %ebp
  ioapic->reg = reg;
80103031:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
{
80103037:	89 e5                	mov    %esp,%ebp
80103039:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010303c:	8d 50 20             	lea    0x20(%eax),%edx
8010303f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80103043:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103045:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010304b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010304e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80103051:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80103054:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103056:	a1 54 26 11 80       	mov    0x80112654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010305b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010305e:	89 50 10             	mov    %edx,0x10(%eax)
}
80103061:	5d                   	pop    %ebp
80103062:	c3                   	ret
80103063:	66 90                	xchg   %ax,%ax
80103065:	66 90                	xchg   %ax,%ax
80103067:	66 90                	xchg   %ax,%ax
80103069:	66 90                	xchg   %ax,%ax
8010306b:	66 90                	xchg   %ax,%ax
8010306d:	66 90                	xchg   %ax,%ax
8010306f:	90                   	nop

80103070 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	53                   	push   %ebx
80103074:	83 ec 04             	sub    $0x4,%esp
80103077:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010307a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80103080:	75 76                	jne    801030f8 <kfree+0x88>
80103082:	81 fb f0 64 11 80    	cmp    $0x801164f0,%ebx
80103088:	72 6e                	jb     801030f8 <kfree+0x88>
8010308a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103090:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80103095:	77 61                	ja     801030f8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80103097:	83 ec 04             	sub    $0x4,%esp
8010309a:	68 00 10 00 00       	push   $0x1000
8010309f:	6a 01                	push   $0x1
801030a1:	53                   	push   %ebx
801030a2:	e8 c9 21 00 00       	call   80105270 <memset>

  if(kmem.use_lock)
801030a7:	8b 15 94 26 11 80    	mov    0x80112694,%edx
801030ad:	83 c4 10             	add    $0x10,%esp
801030b0:	85 d2                	test   %edx,%edx
801030b2:	75 1c                	jne    801030d0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801030b4:	a1 98 26 11 80       	mov    0x80112698,%eax
801030b9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801030bb:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
801030c0:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
801030c6:	85 c0                	test   %eax,%eax
801030c8:	75 1e                	jne    801030e8 <kfree+0x78>
    release(&kmem.lock);
}
801030ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030cd:	c9                   	leave
801030ce:	c3                   	ret
801030cf:	90                   	nop
    acquire(&kmem.lock);
801030d0:	83 ec 0c             	sub    $0xc,%esp
801030d3:	68 60 26 11 80       	push   $0x80112660
801030d8:	e8 93 20 00 00       	call   80105170 <acquire>
801030dd:	83 c4 10             	add    $0x10,%esp
801030e0:	eb d2                	jmp    801030b4 <kfree+0x44>
801030e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801030e8:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
801030ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030f2:	c9                   	leave
    release(&kmem.lock);
801030f3:	e9 18 20 00 00       	jmp    80105110 <release>
    panic("kfree");
801030f8:	83 ec 0c             	sub    $0xc,%esp
801030fb:	68 10 7f 10 80       	push   $0x80107f10
80103100:	e8 6b da ff ff       	call   80100b70 <panic>
80103105:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010310c:	00 
8010310d:	8d 76 00             	lea    0x0(%esi),%esi

80103110 <freerange>:
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	56                   	push   %esi
80103114:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80103115:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103118:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010311b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103121:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103127:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010312d:	39 de                	cmp    %ebx,%esi
8010312f:	72 23                	jb     80103154 <freerange+0x44>
80103131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103138:	83 ec 0c             	sub    $0xc,%esp
8010313b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103141:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103147:	50                   	push   %eax
80103148:	e8 23 ff ff ff       	call   80103070 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010314d:	83 c4 10             	add    $0x10,%esp
80103150:	39 de                	cmp    %ebx,%esi
80103152:	73 e4                	jae    80103138 <freerange+0x28>
}
80103154:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103157:	5b                   	pop    %ebx
80103158:	5e                   	pop    %esi
80103159:	5d                   	pop    %ebp
8010315a:	c3                   	ret
8010315b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103160 <kinit2>:
{
80103160:	55                   	push   %ebp
80103161:	89 e5                	mov    %esp,%ebp
80103163:	56                   	push   %esi
80103164:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80103165:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103168:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010316b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103171:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103177:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010317d:	39 de                	cmp    %ebx,%esi
8010317f:	72 23                	jb     801031a4 <kinit2+0x44>
80103181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103188:	83 ec 0c             	sub    $0xc,%esp
8010318b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103191:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103197:	50                   	push   %eax
80103198:	e8 d3 fe ff ff       	call   80103070 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010319d:	83 c4 10             	add    $0x10,%esp
801031a0:	39 de                	cmp    %ebx,%esi
801031a2:	73 e4                	jae    80103188 <kinit2+0x28>
  kmem.use_lock = 1;
801031a4:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801031ab:	00 00 00 
}
801031ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031b1:	5b                   	pop    %ebx
801031b2:	5e                   	pop    %esi
801031b3:	5d                   	pop    %ebp
801031b4:	c3                   	ret
801031b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031bc:	00 
801031bd:	8d 76 00             	lea    0x0(%esi),%esi

801031c0 <kinit1>:
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	56                   	push   %esi
801031c4:	53                   	push   %ebx
801031c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801031c8:	83 ec 08             	sub    $0x8,%esp
801031cb:	68 16 7f 10 80       	push   $0x80107f16
801031d0:	68 60 26 11 80       	push   $0x80112660
801031d5:	e8 a6 1d 00 00       	call   80104f80 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801031da:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031dd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801031e0:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
801031e7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801031ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801031f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801031fc:	39 de                	cmp    %ebx,%esi
801031fe:	72 1c                	jb     8010321c <kinit1+0x5c>
    kfree(p);
80103200:	83 ec 0c             	sub    $0xc,%esp
80103203:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103209:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010320f:	50                   	push   %eax
80103210:	e8 5b fe ff ff       	call   80103070 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103215:	83 c4 10             	add    $0x10,%esp
80103218:	39 de                	cmp    %ebx,%esi
8010321a:	73 e4                	jae    80103200 <kinit1+0x40>
}
8010321c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010321f:	5b                   	pop    %ebx
80103220:	5e                   	pop    %esi
80103221:	5d                   	pop    %ebp
80103222:	c3                   	ret
80103223:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010322a:	00 
8010322b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103230 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103230:	55                   	push   %ebp
80103231:	89 e5                	mov    %esp,%ebp
80103233:	53                   	push   %ebx
80103234:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80103237:	a1 94 26 11 80       	mov    0x80112694,%eax
8010323c:	85 c0                	test   %eax,%eax
8010323e:	75 20                	jne    80103260 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80103240:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80103246:	85 db                	test   %ebx,%ebx
80103248:	74 07                	je     80103251 <kalloc+0x21>
    kmem.freelist = r->next;
8010324a:	8b 03                	mov    (%ebx),%eax
8010324c:	a3 98 26 11 80       	mov    %eax,0x80112698
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80103251:	89 d8                	mov    %ebx,%eax
80103253:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103256:	c9                   	leave
80103257:	c3                   	ret
80103258:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010325f:	00 
    acquire(&kmem.lock);
80103260:	83 ec 0c             	sub    $0xc,%esp
80103263:	68 60 26 11 80       	push   $0x80112660
80103268:	e8 03 1f 00 00       	call   80105170 <acquire>
  r = kmem.freelist;
8010326d:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(kmem.use_lock)
80103273:	a1 94 26 11 80       	mov    0x80112694,%eax
  if(r)
80103278:	83 c4 10             	add    $0x10,%esp
8010327b:	85 db                	test   %ebx,%ebx
8010327d:	74 08                	je     80103287 <kalloc+0x57>
    kmem.freelist = r->next;
8010327f:	8b 13                	mov    (%ebx),%edx
80103281:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
80103287:	85 c0                	test   %eax,%eax
80103289:	74 c6                	je     80103251 <kalloc+0x21>
    release(&kmem.lock);
8010328b:	83 ec 0c             	sub    $0xc,%esp
8010328e:	68 60 26 11 80       	push   $0x80112660
80103293:	e8 78 1e 00 00       	call   80105110 <release>
}
80103298:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010329a:	83 c4 10             	add    $0x10,%esp
}
8010329d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801032a0:	c9                   	leave
801032a1:	c3                   	ret
801032a2:	66 90                	xchg   %ax,%ax
801032a4:	66 90                	xchg   %ax,%ax
801032a6:	66 90                	xchg   %ax,%ax
801032a8:	66 90                	xchg   %ax,%ax
801032aa:	66 90                	xchg   %ax,%ax
801032ac:	66 90                	xchg   %ax,%ax
801032ae:	66 90                	xchg   %ax,%ax

801032b0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032b0:	ba 64 00 00 00       	mov    $0x64,%edx
801032b5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801032b6:	a8 01                	test   $0x1,%al
801032b8:	0f 84 c2 00 00 00    	je     80103380 <kbdgetc+0xd0>
{
801032be:	55                   	push   %ebp
801032bf:	ba 60 00 00 00       	mov    $0x60,%edx
801032c4:	89 e5                	mov    %esp,%ebp
801032c6:	53                   	push   %ebx
801032c7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801032c8:	8b 1d 9c 26 11 80    	mov    0x8011269c,%ebx
  data = inb(KBDATAP);
801032ce:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801032d1:	3c e0                	cmp    $0xe0,%al
801032d3:	74 5b                	je     80103330 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801032d5:	89 da                	mov    %ebx,%edx
801032d7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801032da:	84 c0                	test   %al,%al
801032dc:	78 62                	js     80103340 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801032de:	85 d2                	test   %edx,%edx
801032e0:	74 09                	je     801032eb <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801032e2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801032e5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801032e8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
801032eb:	0f b6 91 80 85 10 80 	movzbl -0x7fef7a80(%ecx),%edx
  shift ^= togglecode[data];
801032f2:	0f b6 81 80 84 10 80 	movzbl -0x7fef7b80(%ecx),%eax
  shift |= shiftcode[data];
801032f9:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801032fb:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801032fd:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
801032ff:	89 15 9c 26 11 80    	mov    %edx,0x8011269c
  c = charcode[shift & (CTL | SHIFT)][data];
80103305:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80103308:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010330b:	8b 04 85 60 84 10 80 	mov    -0x7fef7ba0(,%eax,4),%eax
80103312:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80103316:	74 0b                	je     80103323 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80103318:	8d 50 9f             	lea    -0x61(%eax),%edx
8010331b:	83 fa 19             	cmp    $0x19,%edx
8010331e:	77 48                	ja     80103368 <kbdgetc+0xb8>
      c += 'A' - 'a';
80103320:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103323:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103326:	c9                   	leave
80103327:	c3                   	ret
80103328:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010332f:	00 
    shift |= E0ESC;
80103330:	83 cb 40             	or     $0x40,%ebx
    return 0;
80103333:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80103335:	89 1d 9c 26 11 80    	mov    %ebx,0x8011269c
}
8010333b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010333e:	c9                   	leave
8010333f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80103340:	83 e0 7f             	and    $0x7f,%eax
80103343:	85 d2                	test   %edx,%edx
80103345:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80103348:	0f b6 81 80 85 10 80 	movzbl -0x7fef7a80(%ecx),%eax
8010334f:	83 c8 40             	or     $0x40,%eax
80103352:	0f b6 c0             	movzbl %al,%eax
80103355:	f7 d0                	not    %eax
80103357:	21 d8                	and    %ebx,%eax
80103359:	a3 9c 26 11 80       	mov    %eax,0x8011269c
    return 0;
8010335e:	31 c0                	xor    %eax,%eax
80103360:	eb d9                	jmp    8010333b <kbdgetc+0x8b>
80103362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80103368:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010336b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010336e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103371:	c9                   	leave
      c += 'a' - 'A';
80103372:	83 f9 1a             	cmp    $0x1a,%ecx
80103375:	0f 42 c2             	cmovb  %edx,%eax
}
80103378:	c3                   	ret
80103379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80103380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103385:	c3                   	ret
80103386:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010338d:	00 
8010338e:	66 90                	xchg   %ax,%ax

80103390 <kbdintr>:

void
kbdintr(void)
{
80103390:	55                   	push   %ebp
80103391:	89 e5                	mov    %esp,%ebp
80103393:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80103396:	68 b0 32 10 80       	push   $0x801032b0
8010339b:	e8 f0 d9 ff ff       	call   80100d90 <consoleintr>
}
801033a0:	83 c4 10             	add    $0x10,%esp
801033a3:	c9                   	leave
801033a4:	c3                   	ret
801033a5:	66 90                	xchg   %ax,%ax
801033a7:	66 90                	xchg   %ax,%ax
801033a9:	66 90                	xchg   %ax,%ax
801033ab:	66 90                	xchg   %ax,%ax
801033ad:	66 90                	xchg   %ax,%ax
801033af:	90                   	nop

801033b0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801033b0:	a1 a0 26 11 80       	mov    0x801126a0,%eax
801033b5:	85 c0                	test   %eax,%eax
801033b7:	0f 84 c3 00 00 00    	je     80103480 <lapicinit+0xd0>
  lapic[index] = value;
801033bd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801033c4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033ca:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801033d1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033d7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801033de:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801033e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033e4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801033eb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801033ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033f1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801033f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801033fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033fe:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103405:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103408:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010340b:	8b 50 30             	mov    0x30(%eax),%edx
8010340e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80103414:	75 72                	jne    80103488 <lapicinit+0xd8>
  lapic[index] = value;
80103416:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010341d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103420:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103423:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010342a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010342d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103430:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80103437:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010343a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010343d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103444:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103447:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010344a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103451:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103454:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103457:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010345e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80103461:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80103464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103468:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010346e:	80 e6 10             	and    $0x10,%dh
80103471:	75 f5                	jne    80103468 <lapicinit+0xb8>
  lapic[index] = value;
80103473:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010347a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010347d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103480:	c3                   	ret
80103481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80103488:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010348f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103492:	8b 50 20             	mov    0x20(%eax),%edx
}
80103495:	e9 7c ff ff ff       	jmp    80103416 <lapicinit+0x66>
8010349a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034a0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801034a0:	a1 a0 26 11 80       	mov    0x801126a0,%eax
801034a5:	85 c0                	test   %eax,%eax
801034a7:	74 07                	je     801034b0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801034a9:	8b 40 20             	mov    0x20(%eax),%eax
801034ac:	c1 e8 18             	shr    $0x18,%eax
801034af:	c3                   	ret
    return 0;
801034b0:	31 c0                	xor    %eax,%eax
}
801034b2:	c3                   	ret
801034b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034ba:	00 
801034bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801034c0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801034c0:	a1 a0 26 11 80       	mov    0x801126a0,%eax
801034c5:	85 c0                	test   %eax,%eax
801034c7:	74 0d                	je     801034d6 <lapiceoi+0x16>
  lapic[index] = value;
801034c9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801034d0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034d3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801034d6:	c3                   	ret
801034d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034de:	00 
801034df:	90                   	nop

801034e0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
801034e0:	c3                   	ret
801034e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034e8:	00 
801034e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034f0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801034f0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034f1:	b8 0f 00 00 00       	mov    $0xf,%eax
801034f6:	ba 70 00 00 00       	mov    $0x70,%edx
801034fb:	89 e5                	mov    %esp,%ebp
801034fd:	53                   	push   %ebx
801034fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103501:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103504:	ee                   	out    %al,(%dx)
80103505:	b8 0a 00 00 00       	mov    $0xa,%eax
8010350a:	ba 71 00 00 00       	mov    $0x71,%edx
8010350f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103510:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80103512:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103515:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010351b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010351d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80103520:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103522:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103525:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103528:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010352e:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80103533:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103539:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010353c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103543:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103546:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103549:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103550:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103553:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103556:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010355c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010355f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103565:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103568:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010356e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103571:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103577:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010357a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010357d:	c9                   	leave
8010357e:	c3                   	ret
8010357f:	90                   	nop

80103580 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103580:	55                   	push   %ebp
80103581:	b8 0b 00 00 00       	mov    $0xb,%eax
80103586:	ba 70 00 00 00       	mov    $0x70,%edx
8010358b:	89 e5                	mov    %esp,%ebp
8010358d:	57                   	push   %edi
8010358e:	56                   	push   %esi
8010358f:	53                   	push   %ebx
80103590:	83 ec 4c             	sub    $0x4c,%esp
80103593:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103594:	ba 71 00 00 00       	mov    $0x71,%edx
80103599:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010359a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010359d:	bf 70 00 00 00       	mov    $0x70,%edi
801035a2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801035a5:	8d 76 00             	lea    0x0(%esi),%esi
801035a8:	31 c0                	xor    %eax,%eax
801035aa:	89 fa                	mov    %edi,%edx
801035ac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035ad:	b9 71 00 00 00       	mov    $0x71,%ecx
801035b2:	89 ca                	mov    %ecx,%edx
801035b4:	ec                   	in     (%dx),%al
801035b5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035b8:	89 fa                	mov    %edi,%edx
801035ba:	b8 02 00 00 00       	mov    $0x2,%eax
801035bf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035c0:	89 ca                	mov    %ecx,%edx
801035c2:	ec                   	in     (%dx),%al
801035c3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035c6:	89 fa                	mov    %edi,%edx
801035c8:	b8 04 00 00 00       	mov    $0x4,%eax
801035cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035ce:	89 ca                	mov    %ecx,%edx
801035d0:	ec                   	in     (%dx),%al
801035d1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035d4:	89 fa                	mov    %edi,%edx
801035d6:	b8 07 00 00 00       	mov    $0x7,%eax
801035db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035dc:	89 ca                	mov    %ecx,%edx
801035de:	ec                   	in     (%dx),%al
801035df:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035e2:	89 fa                	mov    %edi,%edx
801035e4:	b8 08 00 00 00       	mov    $0x8,%eax
801035e9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035ea:	89 ca                	mov    %ecx,%edx
801035ec:	ec                   	in     (%dx),%al
801035ed:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035ef:	89 fa                	mov    %edi,%edx
801035f1:	b8 09 00 00 00       	mov    $0x9,%eax
801035f6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035f7:	89 ca                	mov    %ecx,%edx
801035f9:	ec                   	in     (%dx),%al
801035fa:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035fd:	89 fa                	mov    %edi,%edx
801035ff:	b8 0a 00 00 00       	mov    $0xa,%eax
80103604:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103605:	89 ca                	mov    %ecx,%edx
80103607:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103608:	84 c0                	test   %al,%al
8010360a:	78 9c                	js     801035a8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010360c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103610:	89 f2                	mov    %esi,%edx
80103612:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80103615:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103618:	89 fa                	mov    %edi,%edx
8010361a:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010361d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103621:	89 75 c8             	mov    %esi,-0x38(%ebp)
80103624:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103627:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010362b:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010362e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103632:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103635:	31 c0                	xor    %eax,%eax
80103637:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103638:	89 ca                	mov    %ecx,%edx
8010363a:	ec                   	in     (%dx),%al
8010363b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010363e:	89 fa                	mov    %edi,%edx
80103640:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103643:	b8 02 00 00 00       	mov    $0x2,%eax
80103648:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103649:	89 ca                	mov    %ecx,%edx
8010364b:	ec                   	in     (%dx),%al
8010364c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010364f:	89 fa                	mov    %edi,%edx
80103651:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103654:	b8 04 00 00 00       	mov    $0x4,%eax
80103659:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010365a:	89 ca                	mov    %ecx,%edx
8010365c:	ec                   	in     (%dx),%al
8010365d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103660:	89 fa                	mov    %edi,%edx
80103662:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103665:	b8 07 00 00 00       	mov    $0x7,%eax
8010366a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010366b:	89 ca                	mov    %ecx,%edx
8010366d:	ec                   	in     (%dx),%al
8010366e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103671:	89 fa                	mov    %edi,%edx
80103673:	89 45 dc             	mov    %eax,-0x24(%ebp)
80103676:	b8 08 00 00 00       	mov    $0x8,%eax
8010367b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010367c:	89 ca                	mov    %ecx,%edx
8010367e:	ec                   	in     (%dx),%al
8010367f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103682:	89 fa                	mov    %edi,%edx
80103684:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103687:	b8 09 00 00 00       	mov    $0x9,%eax
8010368c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010368d:	89 ca                	mov    %ecx,%edx
8010368f:	ec                   	in     (%dx),%al
80103690:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103693:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80103696:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103699:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010369c:	6a 18                	push   $0x18
8010369e:	50                   	push   %eax
8010369f:	8d 45 b8             	lea    -0x48(%ebp),%eax
801036a2:	50                   	push   %eax
801036a3:	e8 08 1c 00 00       	call   801052b0 <memcmp>
801036a8:	83 c4 10             	add    $0x10,%esp
801036ab:	85 c0                	test   %eax,%eax
801036ad:	0f 85 f5 fe ff ff    	jne    801035a8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801036b3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
801036b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036ba:	89 f0                	mov    %esi,%eax
801036bc:	84 c0                	test   %al,%al
801036be:	75 78                	jne    80103738 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801036c0:	8b 45 b8             	mov    -0x48(%ebp),%eax
801036c3:	89 c2                	mov    %eax,%edx
801036c5:	83 e0 0f             	and    $0xf,%eax
801036c8:	c1 ea 04             	shr    $0x4,%edx
801036cb:	8d 14 92             	lea    (%edx,%edx,4),%edx
801036ce:	8d 04 50             	lea    (%eax,%edx,2),%eax
801036d1:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801036d4:	8b 45 bc             	mov    -0x44(%ebp),%eax
801036d7:	89 c2                	mov    %eax,%edx
801036d9:	83 e0 0f             	and    $0xf,%eax
801036dc:	c1 ea 04             	shr    $0x4,%edx
801036df:	8d 14 92             	lea    (%edx,%edx,4),%edx
801036e2:	8d 04 50             	lea    (%eax,%edx,2),%eax
801036e5:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801036e8:	8b 45 c0             	mov    -0x40(%ebp),%eax
801036eb:	89 c2                	mov    %eax,%edx
801036ed:	83 e0 0f             	and    $0xf,%eax
801036f0:	c1 ea 04             	shr    $0x4,%edx
801036f3:	8d 14 92             	lea    (%edx,%edx,4),%edx
801036f6:	8d 04 50             	lea    (%eax,%edx,2),%eax
801036f9:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801036fc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801036ff:	89 c2                	mov    %eax,%edx
80103701:	83 e0 0f             	and    $0xf,%eax
80103704:	c1 ea 04             	shr    $0x4,%edx
80103707:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010370a:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010370d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103710:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103713:	89 c2                	mov    %eax,%edx
80103715:	83 e0 0f             	and    $0xf,%eax
80103718:	c1 ea 04             	shr    $0x4,%edx
8010371b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010371e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103721:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103724:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103727:	89 c2                	mov    %eax,%edx
80103729:	83 e0 0f             	and    $0xf,%eax
8010372c:	c1 ea 04             	shr    $0x4,%edx
8010372f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103732:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103735:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103738:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010373b:	89 03                	mov    %eax,(%ebx)
8010373d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103740:	89 43 04             	mov    %eax,0x4(%ebx)
80103743:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103746:	89 43 08             	mov    %eax,0x8(%ebx)
80103749:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010374c:	89 43 0c             	mov    %eax,0xc(%ebx)
8010374f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103752:	89 43 10             	mov    %eax,0x10(%ebx)
80103755:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103758:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
8010375b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80103762:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103765:	5b                   	pop    %ebx
80103766:	5e                   	pop    %esi
80103767:	5f                   	pop    %edi
80103768:	5d                   	pop    %ebp
80103769:	c3                   	ret
8010376a:	66 90                	xchg   %ax,%ax
8010376c:	66 90                	xchg   %ax,%ax
8010376e:	66 90                	xchg   %ax,%ax

80103770 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103770:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
80103776:	85 c9                	test   %ecx,%ecx
80103778:	0f 8e 8a 00 00 00    	jle    80103808 <install_trans+0x98>
{
8010377e:	55                   	push   %ebp
8010377f:	89 e5                	mov    %esp,%ebp
80103781:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103782:	31 ff                	xor    %edi,%edi
{
80103784:	56                   	push   %esi
80103785:	53                   	push   %ebx
80103786:	83 ec 0c             	sub    $0xc,%esp
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103790:	a1 f4 26 11 80       	mov    0x801126f4,%eax
80103795:	83 ec 08             	sub    $0x8,%esp
80103798:	01 f8                	add    %edi,%eax
8010379a:	83 c0 01             	add    $0x1,%eax
8010379d:	50                   	push   %eax
8010379e:	ff 35 04 27 11 80    	push   0x80112704
801037a4:	e8 27 c9 ff ff       	call   801000d0 <bread>
801037a9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801037ab:	58                   	pop    %eax
801037ac:	5a                   	pop    %edx
801037ad:	ff 34 bd 0c 27 11 80 	push   -0x7feed8f4(,%edi,4)
801037b4:	ff 35 04 27 11 80    	push   0x80112704
  for (tail = 0; tail < log.lh.n; tail++) {
801037ba:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801037bd:	e8 0e c9 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801037c2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801037c5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801037c7:	8d 46 5c             	lea    0x5c(%esi),%eax
801037ca:	68 00 02 00 00       	push   $0x200
801037cf:	50                   	push   %eax
801037d0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801037d3:	50                   	push   %eax
801037d4:	e8 27 1b 00 00       	call   80105300 <memmove>
    bwrite(dbuf);  // write dst to disk
801037d9:	89 1c 24             	mov    %ebx,(%esp)
801037dc:	e8 cf c9 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
801037e1:	89 34 24             	mov    %esi,(%esp)
801037e4:	e8 07 ca ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
801037e9:	89 1c 24             	mov    %ebx,(%esp)
801037ec:	e8 ff c9 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801037f1:	83 c4 10             	add    $0x10,%esp
801037f4:	39 3d 08 27 11 80    	cmp    %edi,0x80112708
801037fa:	7f 94                	jg     80103790 <install_trans+0x20>
  }
}
801037fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037ff:	5b                   	pop    %ebx
80103800:	5e                   	pop    %esi
80103801:	5f                   	pop    %edi
80103802:	5d                   	pop    %ebp
80103803:	c3                   	ret
80103804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103808:	c3                   	ret
80103809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103810 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
80103814:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103817:	ff 35 f4 26 11 80    	push   0x801126f4
8010381d:	ff 35 04 27 11 80    	push   0x80112704
80103823:	e8 a8 c8 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103828:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010382b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010382d:	a1 08 27 11 80       	mov    0x80112708,%eax
80103832:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103835:	85 c0                	test   %eax,%eax
80103837:	7e 19                	jle    80103852 <write_head+0x42>
80103839:	31 d2                	xor    %edx,%edx
8010383b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80103840:	8b 0c 95 0c 27 11 80 	mov    -0x7feed8f4(,%edx,4),%ecx
80103847:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010384b:	83 c2 01             	add    $0x1,%edx
8010384e:	39 d0                	cmp    %edx,%eax
80103850:	75 ee                	jne    80103840 <write_head+0x30>
  }
  bwrite(buf);
80103852:	83 ec 0c             	sub    $0xc,%esp
80103855:	53                   	push   %ebx
80103856:	e8 55 c9 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010385b:	89 1c 24             	mov    %ebx,(%esp)
8010385e:	e8 8d c9 ff ff       	call   801001f0 <brelse>
}
80103863:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103866:	83 c4 10             	add    $0x10,%esp
80103869:	c9                   	leave
8010386a:	c3                   	ret
8010386b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103870 <initlog>:
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	53                   	push   %ebx
80103874:	83 ec 2c             	sub    $0x2c,%esp
80103877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010387a:	68 1b 7f 10 80       	push   $0x80107f1b
8010387f:	68 c0 26 11 80       	push   $0x801126c0
80103884:	e8 f7 16 00 00       	call   80104f80 <initlock>
  readsb(dev, &sb);
80103889:	58                   	pop    %eax
8010388a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010388d:	5a                   	pop    %edx
8010388e:	50                   	push   %eax
8010388f:	53                   	push   %ebx
80103890:	e8 7b e8 ff ff       	call   80102110 <readsb>
  log.start = sb.logstart;
80103895:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103898:	59                   	pop    %ecx
  log.dev = dev;
80103899:	89 1d 04 27 11 80    	mov    %ebx,0x80112704
  log.size = sb.nlog;
8010389f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801038a2:	a3 f4 26 11 80       	mov    %eax,0x801126f4
  log.size = sb.nlog;
801038a7:	89 15 f8 26 11 80    	mov    %edx,0x801126f8
  struct buf *buf = bread(log.dev, log.start);
801038ad:	5a                   	pop    %edx
801038ae:	50                   	push   %eax
801038af:	53                   	push   %ebx
801038b0:	e8 1b c8 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801038b5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801038b8:	8b 58 5c             	mov    0x5c(%eax),%ebx
801038bb:	89 1d 08 27 11 80    	mov    %ebx,0x80112708
  for (i = 0; i < log.lh.n; i++) {
801038c1:	85 db                	test   %ebx,%ebx
801038c3:	7e 1d                	jle    801038e2 <initlog+0x72>
801038c5:	31 d2                	xor    %edx,%edx
801038c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801038ce:	00 
801038cf:	90                   	nop
    log.lh.block[i] = lh->block[i];
801038d0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
801038d4:	89 0c 95 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801038db:	83 c2 01             	add    $0x1,%edx
801038de:	39 d3                	cmp    %edx,%ebx
801038e0:	75 ee                	jne    801038d0 <initlog+0x60>
  brelse(buf);
801038e2:	83 ec 0c             	sub    $0xc,%esp
801038e5:	50                   	push   %eax
801038e6:	e8 05 c9 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
801038eb:	e8 80 fe ff ff       	call   80103770 <install_trans>
  log.lh.n = 0;
801038f0:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
801038f7:	00 00 00 
  write_head(); // clear the log
801038fa:	e8 11 ff ff ff       	call   80103810 <write_head>
}
801038ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103902:	83 c4 10             	add    $0x10,%esp
80103905:	c9                   	leave
80103906:	c3                   	ret
80103907:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010390e:	00 
8010390f:	90                   	nop

80103910 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103916:	68 c0 26 11 80       	push   $0x801126c0
8010391b:	e8 50 18 00 00       	call   80105170 <acquire>
80103920:	83 c4 10             	add    $0x10,%esp
80103923:	eb 18                	jmp    8010393d <begin_op+0x2d>
80103925:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103928:	83 ec 08             	sub    $0x8,%esp
8010392b:	68 c0 26 11 80       	push   $0x801126c0
80103930:	68 c0 26 11 80       	push   $0x801126c0
80103935:	e8 b6 12 00 00       	call   80104bf0 <sleep>
8010393a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010393d:	a1 00 27 11 80       	mov    0x80112700,%eax
80103942:	85 c0                	test   %eax,%eax
80103944:	75 e2                	jne    80103928 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103946:	a1 fc 26 11 80       	mov    0x801126fc,%eax
8010394b:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80103951:	83 c0 01             	add    $0x1,%eax
80103954:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103957:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010395a:	83 fa 1e             	cmp    $0x1e,%edx
8010395d:	7f c9                	jg     80103928 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010395f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103962:	a3 fc 26 11 80       	mov    %eax,0x801126fc
      release(&log.lock);
80103967:	68 c0 26 11 80       	push   $0x801126c0
8010396c:	e8 9f 17 00 00       	call   80105110 <release>
      break;
    }
  }
}
80103971:	83 c4 10             	add    $0x10,%esp
80103974:	c9                   	leave
80103975:	c3                   	ret
80103976:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010397d:	00 
8010397e:	66 90                	xchg   %ax,%ax

80103980 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	57                   	push   %edi
80103984:	56                   	push   %esi
80103985:	53                   	push   %ebx
80103986:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103989:	68 c0 26 11 80       	push   $0x801126c0
8010398e:	e8 dd 17 00 00       	call   80105170 <acquire>
  log.outstanding -= 1;
80103993:	a1 fc 26 11 80       	mov    0x801126fc,%eax
  if(log.committing)
80103998:	8b 35 00 27 11 80    	mov    0x80112700,%esi
8010399e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801039a1:	8d 58 ff             	lea    -0x1(%eax),%ebx
801039a4:	89 1d fc 26 11 80    	mov    %ebx,0x801126fc
  if(log.committing)
801039aa:	85 f6                	test   %esi,%esi
801039ac:	0f 85 22 01 00 00    	jne    80103ad4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801039b2:	85 db                	test   %ebx,%ebx
801039b4:	0f 85 f6 00 00 00    	jne    80103ab0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801039ba:	c7 05 00 27 11 80 01 	movl   $0x1,0x80112700
801039c1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801039c4:	83 ec 0c             	sub    $0xc,%esp
801039c7:	68 c0 26 11 80       	push   $0x801126c0
801039cc:	e8 3f 17 00 00       	call   80105110 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801039d1:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
801039d7:	83 c4 10             	add    $0x10,%esp
801039da:	85 c9                	test   %ecx,%ecx
801039dc:	7f 42                	jg     80103a20 <end_op+0xa0>
    acquire(&log.lock);
801039de:	83 ec 0c             	sub    $0xc,%esp
801039e1:	68 c0 26 11 80       	push   $0x801126c0
801039e6:	e8 85 17 00 00       	call   80105170 <acquire>
    log.committing = 0;
801039eb:	c7 05 00 27 11 80 00 	movl   $0x0,0x80112700
801039f2:	00 00 00 
    wakeup(&log);
801039f5:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
801039fc:	e8 af 12 00 00       	call   80104cb0 <wakeup>
    release(&log.lock);
80103a01:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
80103a08:	e8 03 17 00 00       	call   80105110 <release>
80103a0d:	83 c4 10             	add    $0x10,%esp
}
80103a10:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a13:	5b                   	pop    %ebx
80103a14:	5e                   	pop    %esi
80103a15:	5f                   	pop    %edi
80103a16:	5d                   	pop    %ebp
80103a17:	c3                   	ret
80103a18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a1f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103a20:	a1 f4 26 11 80       	mov    0x801126f4,%eax
80103a25:	83 ec 08             	sub    $0x8,%esp
80103a28:	01 d8                	add    %ebx,%eax
80103a2a:	83 c0 01             	add    $0x1,%eax
80103a2d:	50                   	push   %eax
80103a2e:	ff 35 04 27 11 80    	push   0x80112704
80103a34:	e8 97 c6 ff ff       	call   801000d0 <bread>
80103a39:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103a3b:	58                   	pop    %eax
80103a3c:	5a                   	pop    %edx
80103a3d:	ff 34 9d 0c 27 11 80 	push   -0x7feed8f4(,%ebx,4)
80103a44:	ff 35 04 27 11 80    	push   0x80112704
  for (tail = 0; tail < log.lh.n; tail++) {
80103a4a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103a4d:	e8 7e c6 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103a52:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103a55:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103a57:	8d 40 5c             	lea    0x5c(%eax),%eax
80103a5a:	68 00 02 00 00       	push   $0x200
80103a5f:	50                   	push   %eax
80103a60:	8d 46 5c             	lea    0x5c(%esi),%eax
80103a63:	50                   	push   %eax
80103a64:	e8 97 18 00 00       	call   80105300 <memmove>
    bwrite(to);  // write the log
80103a69:	89 34 24             	mov    %esi,(%esp)
80103a6c:	e8 3f c7 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103a71:	89 3c 24             	mov    %edi,(%esp)
80103a74:	e8 77 c7 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103a79:	89 34 24             	mov    %esi,(%esp)
80103a7c:	e8 6f c7 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103a81:	83 c4 10             	add    $0x10,%esp
80103a84:	3b 1d 08 27 11 80    	cmp    0x80112708,%ebx
80103a8a:	7c 94                	jl     80103a20 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103a8c:	e8 7f fd ff ff       	call   80103810 <write_head>
    install_trans(); // Now install writes to home locations
80103a91:	e8 da fc ff ff       	call   80103770 <install_trans>
    log.lh.n = 0;
80103a96:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
80103a9d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103aa0:	e8 6b fd ff ff       	call   80103810 <write_head>
80103aa5:	e9 34 ff ff ff       	jmp    801039de <end_op+0x5e>
80103aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103ab0:	83 ec 0c             	sub    $0xc,%esp
80103ab3:	68 c0 26 11 80       	push   $0x801126c0
80103ab8:	e8 f3 11 00 00       	call   80104cb0 <wakeup>
  release(&log.lock);
80103abd:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
80103ac4:	e8 47 16 00 00       	call   80105110 <release>
80103ac9:	83 c4 10             	add    $0x10,%esp
}
80103acc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103acf:	5b                   	pop    %ebx
80103ad0:	5e                   	pop    %esi
80103ad1:	5f                   	pop    %edi
80103ad2:	5d                   	pop    %ebp
80103ad3:	c3                   	ret
    panic("log.committing");
80103ad4:	83 ec 0c             	sub    $0xc,%esp
80103ad7:	68 1f 7f 10 80       	push   $0x80107f1f
80103adc:	e8 8f d0 ff ff       	call   80100b70 <panic>
80103ae1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ae8:	00 
80103ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103af0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	53                   	push   %ebx
80103af4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103af7:	8b 15 08 27 11 80    	mov    0x80112708,%edx
{
80103afd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103b00:	83 fa 1d             	cmp    $0x1d,%edx
80103b03:	7f 7d                	jg     80103b82 <log_write+0x92>
80103b05:	a1 f8 26 11 80       	mov    0x801126f8,%eax
80103b0a:	83 e8 01             	sub    $0x1,%eax
80103b0d:	39 c2                	cmp    %eax,%edx
80103b0f:	7d 71                	jge    80103b82 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103b11:	a1 fc 26 11 80       	mov    0x801126fc,%eax
80103b16:	85 c0                	test   %eax,%eax
80103b18:	7e 75                	jle    80103b8f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103b1a:	83 ec 0c             	sub    $0xc,%esp
80103b1d:	68 c0 26 11 80       	push   $0x801126c0
80103b22:	e8 49 16 00 00       	call   80105170 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103b27:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103b2a:	83 c4 10             	add    $0x10,%esp
80103b2d:	31 c0                	xor    %eax,%eax
80103b2f:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80103b35:	85 d2                	test   %edx,%edx
80103b37:	7f 0e                	jg     80103b47 <log_write+0x57>
80103b39:	eb 15                	jmp    80103b50 <log_write+0x60>
80103b3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b40:	83 c0 01             	add    $0x1,%eax
80103b43:	39 c2                	cmp    %eax,%edx
80103b45:	74 29                	je     80103b70 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103b47:	39 0c 85 0c 27 11 80 	cmp    %ecx,-0x7feed8f4(,%eax,4)
80103b4e:	75 f0                	jne    80103b40 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103b50:	89 0c 85 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%eax,4)
  if (i == log.lh.n)
80103b57:	39 c2                	cmp    %eax,%edx
80103b59:	74 1c                	je     80103b77 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103b5b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103b5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103b61:	c7 45 08 c0 26 11 80 	movl   $0x801126c0,0x8(%ebp)
}
80103b68:	c9                   	leave
  release(&log.lock);
80103b69:	e9 a2 15 00 00       	jmp    80105110 <release>
80103b6e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103b70:	89 0c 95 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%edx,4)
    log.lh.n++;
80103b77:	83 c2 01             	add    $0x1,%edx
80103b7a:	89 15 08 27 11 80    	mov    %edx,0x80112708
80103b80:	eb d9                	jmp    80103b5b <log_write+0x6b>
    panic("too big a transaction");
80103b82:	83 ec 0c             	sub    $0xc,%esp
80103b85:	68 2e 7f 10 80       	push   $0x80107f2e
80103b8a:	e8 e1 cf ff ff       	call   80100b70 <panic>
    panic("log_write outside of trans");
80103b8f:	83 ec 0c             	sub    $0xc,%esp
80103b92:	68 44 7f 10 80       	push   $0x80107f44
80103b97:	e8 d4 cf ff ff       	call   80100b70 <panic>
80103b9c:	66 90                	xchg   %ax,%ax
80103b9e:	66 90                	xchg   %ax,%ax

80103ba0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	53                   	push   %ebx
80103ba4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103ba7:	e8 64 09 00 00       	call   80104510 <cpuid>
80103bac:	89 c3                	mov    %eax,%ebx
80103bae:	e8 5d 09 00 00       	call   80104510 <cpuid>
80103bb3:	83 ec 04             	sub    $0x4,%esp
80103bb6:	53                   	push   %ebx
80103bb7:	50                   	push   %eax
80103bb8:	68 5f 7f 10 80       	push   $0x80107f5f
80103bbd:	e8 5e cd ff ff       	call   80100920 <cprintf>
  idtinit();       // load idt register
80103bc2:	e8 e9 28 00 00       	call   801064b0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103bc7:	e8 e4 08 00 00       	call   801044b0 <mycpu>
80103bcc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103bce:	b8 01 00 00 00       	mov    $0x1,%eax
80103bd3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103bda:	e8 01 0c 00 00       	call   801047e0 <scheduler>
80103bdf:	90                   	nop

80103be0 <mpenter>:
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103be6:	e8 c5 39 00 00       	call   801075b0 <switchkvm>
  seginit();
80103beb:	e8 30 39 00 00       	call   80107520 <seginit>
  lapicinit();
80103bf0:	e8 bb f7 ff ff       	call   801033b0 <lapicinit>
  mpmain();
80103bf5:	e8 a6 ff ff ff       	call   80103ba0 <mpmain>
80103bfa:	66 90                	xchg   %ax,%ax
80103bfc:	66 90                	xchg   %ax,%ax
80103bfe:	66 90                	xchg   %ax,%ax

80103c00 <main>:
{
80103c00:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103c04:	83 e4 f0             	and    $0xfffffff0,%esp
80103c07:	ff 71 fc             	push   -0x4(%ecx)
80103c0a:	55                   	push   %ebp
80103c0b:	89 e5                	mov    %esp,%ebp
80103c0d:	53                   	push   %ebx
80103c0e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103c0f:	83 ec 08             	sub    $0x8,%esp
80103c12:	68 00 00 40 80       	push   $0x80400000
80103c17:	68 f0 64 11 80       	push   $0x801164f0
80103c1c:	e8 9f f5 ff ff       	call   801031c0 <kinit1>
  kvmalloc();      // kernel page table
80103c21:	e8 4a 3e 00 00       	call   80107a70 <kvmalloc>
  mpinit();        // detect other processors
80103c26:	e8 85 01 00 00       	call   80103db0 <mpinit>
  lapicinit();     // interrupt controller
80103c2b:	e8 80 f7 ff ff       	call   801033b0 <lapicinit>
  seginit();       // segment descriptors
80103c30:	e8 eb 38 00 00       	call   80107520 <seginit>
  picinit();       // disable pic
80103c35:	e8 86 03 00 00       	call   80103fc0 <picinit>
  ioapicinit();    // another interrupt controller
80103c3a:	e8 51 f3 ff ff       	call   80102f90 <ioapicinit>
  consoleinit();   // console hardware
80103c3f:	e8 8c d0 ff ff       	call   80100cd0 <consoleinit>
  uartinit();      // serial port
80103c44:	e8 47 2b 00 00       	call   80106790 <uartinit>
  pinit();         // process table
80103c49:	e8 42 08 00 00       	call   80104490 <pinit>
  tvinit();        // trap vectors
80103c4e:	e8 dd 27 00 00       	call   80106430 <tvinit>
  binit();         // buffer cache
80103c53:	e8 e8 c3 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103c58:	e8 a3 dd ff ff       	call   80101a00 <fileinit>
  ideinit();       // disk 
80103c5d:	e8 0e f1 ff ff       	call   80102d70 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103c62:	83 c4 0c             	add    $0xc,%esp
80103c65:	68 8a 00 00 00       	push   $0x8a
80103c6a:	68 8c b4 10 80       	push   $0x8010b48c
80103c6f:	68 00 70 00 80       	push   $0x80007000
80103c74:	e8 87 16 00 00       	call   80105300 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103c79:	83 c4 10             	add    $0x10,%esp
80103c7c:	69 05 a4 27 11 80 b0 	imul   $0xb0,0x801127a4,%eax
80103c83:	00 00 00 
80103c86:	05 c0 27 11 80       	add    $0x801127c0,%eax
80103c8b:	3d c0 27 11 80       	cmp    $0x801127c0,%eax
80103c90:	76 7e                	jbe    80103d10 <main+0x110>
80103c92:	bb c0 27 11 80       	mov    $0x801127c0,%ebx
80103c97:	eb 20                	jmp    80103cb9 <main+0xb9>
80103c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ca0:	69 05 a4 27 11 80 b0 	imul   $0xb0,0x801127a4,%eax
80103ca7:	00 00 00 
80103caa:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103cb0:	05 c0 27 11 80       	add    $0x801127c0,%eax
80103cb5:	39 c3                	cmp    %eax,%ebx
80103cb7:	73 57                	jae    80103d10 <main+0x110>
    if(c == mycpu())  // We've started already.
80103cb9:	e8 f2 07 00 00       	call   801044b0 <mycpu>
80103cbe:	39 c3                	cmp    %eax,%ebx
80103cc0:	74 de                	je     80103ca0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103cc2:	e8 69 f5 ff ff       	call   80103230 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103cc7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103cca:	c7 05 f8 6f 00 80 e0 	movl   $0x80103be0,0x80006ff8
80103cd1:	3b 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103cd4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103cdb:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103cde:	05 00 10 00 00       	add    $0x1000,%eax
80103ce3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103ce8:	0f b6 03             	movzbl (%ebx),%eax
80103ceb:	68 00 70 00 00       	push   $0x7000
80103cf0:	50                   	push   %eax
80103cf1:	e8 fa f7 ff ff       	call   801034f0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103cf6:	83 c4 10             	add    $0x10,%esp
80103cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d00:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103d06:	85 c0                	test   %eax,%eax
80103d08:	74 f6                	je     80103d00 <main+0x100>
80103d0a:	eb 94                	jmp    80103ca0 <main+0xa0>
80103d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103d10:	83 ec 08             	sub    $0x8,%esp
80103d13:	68 00 00 00 8e       	push   $0x8e000000
80103d18:	68 00 00 40 80       	push   $0x80400000
80103d1d:	e8 3e f4 ff ff       	call   80103160 <kinit2>
  userinit();      // first user process
80103d22:	e8 39 08 00 00       	call   80104560 <userinit>
  mpmain();        // finish this processor's setup
80103d27:	e8 74 fe ff ff       	call   80103ba0 <mpmain>
80103d2c:	66 90                	xchg   %ax,%ax
80103d2e:	66 90                	xchg   %ax,%ax

80103d30 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	57                   	push   %edi
80103d34:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103d35:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103d3b:	53                   	push   %ebx
  e = addr+len;
80103d3c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103d3f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103d42:	39 de                	cmp    %ebx,%esi
80103d44:	72 10                	jb     80103d56 <mpsearch1+0x26>
80103d46:	eb 50                	jmp    80103d98 <mpsearch1+0x68>
80103d48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d4f:	00 
80103d50:	89 fe                	mov    %edi,%esi
80103d52:	39 df                	cmp    %ebx,%edi
80103d54:	73 42                	jae    80103d98 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103d56:	83 ec 04             	sub    $0x4,%esp
80103d59:	8d 7e 10             	lea    0x10(%esi),%edi
80103d5c:	6a 04                	push   $0x4
80103d5e:	68 73 7f 10 80       	push   $0x80107f73
80103d63:	56                   	push   %esi
80103d64:	e8 47 15 00 00       	call   801052b0 <memcmp>
80103d69:	83 c4 10             	add    $0x10,%esp
80103d6c:	85 c0                	test   %eax,%eax
80103d6e:	75 e0                	jne    80103d50 <mpsearch1+0x20>
80103d70:	89 f2                	mov    %esi,%edx
80103d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103d78:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103d7b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103d7e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103d80:	39 fa                	cmp    %edi,%edx
80103d82:	75 f4                	jne    80103d78 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103d84:	84 c0                	test   %al,%al
80103d86:	75 c8                	jne    80103d50 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103d88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d8b:	89 f0                	mov    %esi,%eax
80103d8d:	5b                   	pop    %ebx
80103d8e:	5e                   	pop    %esi
80103d8f:	5f                   	pop    %edi
80103d90:	5d                   	pop    %ebp
80103d91:	c3                   	ret
80103d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d98:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103d9b:	31 f6                	xor    %esi,%esi
}
80103d9d:	5b                   	pop    %ebx
80103d9e:	89 f0                	mov    %esi,%eax
80103da0:	5e                   	pop    %esi
80103da1:	5f                   	pop    %edi
80103da2:	5d                   	pop    %ebp
80103da3:	c3                   	ret
80103da4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103dab:	00 
80103dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103db0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103db0:	55                   	push   %ebp
80103db1:	89 e5                	mov    %esp,%ebp
80103db3:	57                   	push   %edi
80103db4:	56                   	push   %esi
80103db5:	53                   	push   %ebx
80103db6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103db9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103dc0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103dc7:	c1 e0 08             	shl    $0x8,%eax
80103dca:	09 d0                	or     %edx,%eax
80103dcc:	c1 e0 04             	shl    $0x4,%eax
80103dcf:	75 1b                	jne    80103dec <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103dd1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103dd8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103ddf:	c1 e0 08             	shl    $0x8,%eax
80103de2:	09 d0                	or     %edx,%eax
80103de4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103de7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103dec:	ba 00 04 00 00       	mov    $0x400,%edx
80103df1:	e8 3a ff ff ff       	call   80103d30 <mpsearch1>
80103df6:	89 c3                	mov    %eax,%ebx
80103df8:	85 c0                	test   %eax,%eax
80103dfa:	0f 84 58 01 00 00    	je     80103f58 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103e00:	8b 73 04             	mov    0x4(%ebx),%esi
80103e03:	85 f6                	test   %esi,%esi
80103e05:	0f 84 3d 01 00 00    	je     80103f48 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
80103e0b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103e0e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103e14:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103e17:	6a 04                	push   $0x4
80103e19:	68 78 7f 10 80       	push   $0x80107f78
80103e1e:	50                   	push   %eax
80103e1f:	e8 8c 14 00 00       	call   801052b0 <memcmp>
80103e24:	83 c4 10             	add    $0x10,%esp
80103e27:	85 c0                	test   %eax,%eax
80103e29:	0f 85 19 01 00 00    	jne    80103f48 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
80103e2f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103e36:	3c 01                	cmp    $0x1,%al
80103e38:	74 08                	je     80103e42 <mpinit+0x92>
80103e3a:	3c 04                	cmp    $0x4,%al
80103e3c:	0f 85 06 01 00 00    	jne    80103f48 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80103e42:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103e49:	66 85 d2             	test   %dx,%dx
80103e4c:	74 22                	je     80103e70 <mpinit+0xc0>
80103e4e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103e51:	89 f0                	mov    %esi,%eax
  sum = 0;
80103e53:	31 d2                	xor    %edx,%edx
80103e55:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103e58:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103e5f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103e62:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103e64:	39 f8                	cmp    %edi,%eax
80103e66:	75 f0                	jne    80103e58 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103e68:	84 d2                	test   %dl,%dl
80103e6a:	0f 85 d8 00 00 00    	jne    80103f48 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103e70:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e76:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103e79:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
80103e7c:	a3 a0 26 11 80       	mov    %eax,0x801126a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e81:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103e88:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103e8e:	01 d7                	add    %edx,%edi
80103e90:	89 fa                	mov    %edi,%edx
  ismp = 1;
80103e92:	bf 01 00 00 00       	mov    $0x1,%edi
80103e97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e9e:	00 
80103e9f:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103ea0:	39 d0                	cmp    %edx,%eax
80103ea2:	73 19                	jae    80103ebd <mpinit+0x10d>
    switch(*p){
80103ea4:	0f b6 08             	movzbl (%eax),%ecx
80103ea7:	80 f9 02             	cmp    $0x2,%cl
80103eaa:	0f 84 80 00 00 00    	je     80103f30 <mpinit+0x180>
80103eb0:	77 6e                	ja     80103f20 <mpinit+0x170>
80103eb2:	84 c9                	test   %cl,%cl
80103eb4:	74 3a                	je     80103ef0 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103eb6:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103eb9:	39 d0                	cmp    %edx,%eax
80103ebb:	72 e7                	jb     80103ea4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103ebd:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103ec0:	85 ff                	test   %edi,%edi
80103ec2:	0f 84 dd 00 00 00    	je     80103fa5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103ec8:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103ecc:	74 15                	je     80103ee3 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ece:	b8 70 00 00 00       	mov    $0x70,%eax
80103ed3:	ba 22 00 00 00       	mov    $0x22,%edx
80103ed8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103ed9:	ba 23 00 00 00       	mov    $0x23,%edx
80103ede:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103edf:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ee2:	ee                   	out    %al,(%dx)
  }
}
80103ee3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ee6:	5b                   	pop    %ebx
80103ee7:	5e                   	pop    %esi
80103ee8:	5f                   	pop    %edi
80103ee9:	5d                   	pop    %ebp
80103eea:	c3                   	ret
80103eeb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103ef0:	8b 0d a4 27 11 80    	mov    0x801127a4,%ecx
80103ef6:	83 f9 07             	cmp    $0x7,%ecx
80103ef9:	7f 19                	jg     80103f14 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103efb:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80103f01:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103f05:	83 c1 01             	add    $0x1,%ecx
80103f08:	89 0d a4 27 11 80    	mov    %ecx,0x801127a4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103f0e:	88 9e c0 27 11 80    	mov    %bl,-0x7feed840(%esi)
      p += sizeof(struct mpproc);
80103f14:	83 c0 14             	add    $0x14,%eax
      continue;
80103f17:	eb 87                	jmp    80103ea0 <mpinit+0xf0>
80103f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103f20:	83 e9 03             	sub    $0x3,%ecx
80103f23:	80 f9 01             	cmp    $0x1,%cl
80103f26:	76 8e                	jbe    80103eb6 <mpinit+0x106>
80103f28:	31 ff                	xor    %edi,%edi
80103f2a:	e9 71 ff ff ff       	jmp    80103ea0 <mpinit+0xf0>
80103f2f:	90                   	nop
      ioapicid = ioapic->apicno;
80103f30:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103f34:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103f37:	88 0d a0 27 11 80    	mov    %cl,0x801127a0
      continue;
80103f3d:	e9 5e ff ff ff       	jmp    80103ea0 <mpinit+0xf0>
80103f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103f48:	83 ec 0c             	sub    $0xc,%esp
80103f4b:	68 7d 7f 10 80       	push   $0x80107f7d
80103f50:	e8 1b cc ff ff       	call   80100b70 <panic>
80103f55:	8d 76 00             	lea    0x0(%esi),%esi
{
80103f58:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103f5d:	eb 0b                	jmp    80103f6a <mpinit+0x1ba>
80103f5f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103f60:	89 f3                	mov    %esi,%ebx
80103f62:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103f68:	74 de                	je     80103f48 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f6a:	83 ec 04             	sub    $0x4,%esp
80103f6d:	8d 73 10             	lea    0x10(%ebx),%esi
80103f70:	6a 04                	push   $0x4
80103f72:	68 73 7f 10 80       	push   $0x80107f73
80103f77:	53                   	push   %ebx
80103f78:	e8 33 13 00 00       	call   801052b0 <memcmp>
80103f7d:	83 c4 10             	add    $0x10,%esp
80103f80:	85 c0                	test   %eax,%eax
80103f82:	75 dc                	jne    80103f60 <mpinit+0x1b0>
80103f84:	89 da                	mov    %ebx,%edx
80103f86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f8d:	00 
80103f8e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80103f90:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103f93:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103f96:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103f98:	39 d6                	cmp    %edx,%esi
80103f9a:	75 f4                	jne    80103f90 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f9c:	84 c0                	test   %al,%al
80103f9e:	75 c0                	jne    80103f60 <mpinit+0x1b0>
80103fa0:	e9 5b fe ff ff       	jmp    80103e00 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103fa5:	83 ec 0c             	sub    $0xc,%esp
80103fa8:	68 4c 83 10 80       	push   $0x8010834c
80103fad:	e8 be cb ff ff       	call   80100b70 <panic>
80103fb2:	66 90                	xchg   %ax,%ax
80103fb4:	66 90                	xchg   %ax,%ax
80103fb6:	66 90                	xchg   %ax,%ax
80103fb8:	66 90                	xchg   %ax,%ax
80103fba:	66 90                	xchg   %ax,%ax
80103fbc:	66 90                	xchg   %ax,%ax
80103fbe:	66 90                	xchg   %ax,%ax

80103fc0 <picinit>:
80103fc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103fc5:	ba 21 00 00 00       	mov    $0x21,%edx
80103fca:	ee                   	out    %al,(%dx)
80103fcb:	ba a1 00 00 00       	mov    $0xa1,%edx
80103fd0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103fd1:	c3                   	ret
80103fd2:	66 90                	xchg   %ax,%ax
80103fd4:	66 90                	xchg   %ax,%ax
80103fd6:	66 90                	xchg   %ax,%ax
80103fd8:	66 90                	xchg   %ax,%ax
80103fda:	66 90                	xchg   %ax,%ax
80103fdc:	66 90                	xchg   %ax,%ax
80103fde:	66 90                	xchg   %ax,%ax

80103fe0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	57                   	push   %edi
80103fe4:	56                   	push   %esi
80103fe5:	53                   	push   %ebx
80103fe6:	83 ec 0c             	sub    $0xc,%esp
80103fe9:	8b 75 08             	mov    0x8(%ebp),%esi
80103fec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103fef:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103ff5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103ffb:	e8 20 da ff ff       	call   80101a20 <filealloc>
80104000:	89 06                	mov    %eax,(%esi)
80104002:	85 c0                	test   %eax,%eax
80104004:	0f 84 a5 00 00 00    	je     801040af <pipealloc+0xcf>
8010400a:	e8 11 da ff ff       	call   80101a20 <filealloc>
8010400f:	89 07                	mov    %eax,(%edi)
80104011:	85 c0                	test   %eax,%eax
80104013:	0f 84 84 00 00 00    	je     8010409d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104019:	e8 12 f2 ff ff       	call   80103230 <kalloc>
8010401e:	89 c3                	mov    %eax,%ebx
80104020:	85 c0                	test   %eax,%eax
80104022:	0f 84 a0 00 00 00    	je     801040c8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80104028:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010402f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80104032:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80104035:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010403c:	00 00 00 
  p->nwrite = 0;
8010403f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104046:	00 00 00 
  p->nread = 0;
80104049:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104050:	00 00 00 
  initlock(&p->lock, "pipe");
80104053:	68 95 7f 10 80       	push   $0x80107f95
80104058:	50                   	push   %eax
80104059:	e8 22 0f 00 00       	call   80104f80 <initlock>
  (*f0)->type = FD_PIPE;
8010405e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104060:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104063:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104069:	8b 06                	mov    (%esi),%eax
8010406b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010406f:	8b 06                	mov    (%esi),%eax
80104071:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104075:	8b 06                	mov    (%esi),%eax
80104077:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010407a:	8b 07                	mov    (%edi),%eax
8010407c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104082:	8b 07                	mov    (%edi),%eax
80104084:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104088:	8b 07                	mov    (%edi),%eax
8010408a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010408e:	8b 07                	mov    (%edi),%eax
80104090:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80104093:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80104095:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104098:	5b                   	pop    %ebx
80104099:	5e                   	pop    %esi
8010409a:	5f                   	pop    %edi
8010409b:	5d                   	pop    %ebp
8010409c:	c3                   	ret
  if(*f0)
8010409d:	8b 06                	mov    (%esi),%eax
8010409f:	85 c0                	test   %eax,%eax
801040a1:	74 1e                	je     801040c1 <pipealloc+0xe1>
    fileclose(*f0);
801040a3:	83 ec 0c             	sub    $0xc,%esp
801040a6:	50                   	push   %eax
801040a7:	e8 34 da ff ff       	call   80101ae0 <fileclose>
801040ac:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801040af:	8b 07                	mov    (%edi),%eax
801040b1:	85 c0                	test   %eax,%eax
801040b3:	74 0c                	je     801040c1 <pipealloc+0xe1>
    fileclose(*f1);
801040b5:	83 ec 0c             	sub    $0xc,%esp
801040b8:	50                   	push   %eax
801040b9:	e8 22 da ff ff       	call   80101ae0 <fileclose>
801040be:	83 c4 10             	add    $0x10,%esp
  return -1;
801040c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801040c6:	eb cd                	jmp    80104095 <pipealloc+0xb5>
  if(*f0)
801040c8:	8b 06                	mov    (%esi),%eax
801040ca:	85 c0                	test   %eax,%eax
801040cc:	75 d5                	jne    801040a3 <pipealloc+0xc3>
801040ce:	eb df                	jmp    801040af <pipealloc+0xcf>

801040d0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	56                   	push   %esi
801040d4:	53                   	push   %ebx
801040d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801040d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801040db:	83 ec 0c             	sub    $0xc,%esp
801040de:	53                   	push   %ebx
801040df:	e8 8c 10 00 00       	call   80105170 <acquire>
  if(writable){
801040e4:	83 c4 10             	add    $0x10,%esp
801040e7:	85 f6                	test   %esi,%esi
801040e9:	74 65                	je     80104150 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801040eb:	83 ec 0c             	sub    $0xc,%esp
801040ee:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801040f4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801040fb:	00 00 00 
    wakeup(&p->nread);
801040fe:	50                   	push   %eax
801040ff:	e8 ac 0b 00 00       	call   80104cb0 <wakeup>
80104104:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104107:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010410d:	85 d2                	test   %edx,%edx
8010410f:	75 0a                	jne    8010411b <pipeclose+0x4b>
80104111:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104117:	85 c0                	test   %eax,%eax
80104119:	74 15                	je     80104130 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010411b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010411e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104121:	5b                   	pop    %ebx
80104122:	5e                   	pop    %esi
80104123:	5d                   	pop    %ebp
    release(&p->lock);
80104124:	e9 e7 0f 00 00       	jmp    80105110 <release>
80104129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104130:	83 ec 0c             	sub    $0xc,%esp
80104133:	53                   	push   %ebx
80104134:	e8 d7 0f 00 00       	call   80105110 <release>
    kfree((char*)p);
80104139:	83 c4 10             	add    $0x10,%esp
8010413c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010413f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104142:	5b                   	pop    %ebx
80104143:	5e                   	pop    %esi
80104144:	5d                   	pop    %ebp
    kfree((char*)p);
80104145:	e9 26 ef ff ff       	jmp    80103070 <kfree>
8010414a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80104150:	83 ec 0c             	sub    $0xc,%esp
80104153:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80104159:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104160:	00 00 00 
    wakeup(&p->nwrite);
80104163:	50                   	push   %eax
80104164:	e8 47 0b 00 00       	call   80104cb0 <wakeup>
80104169:	83 c4 10             	add    $0x10,%esp
8010416c:	eb 99                	jmp    80104107 <pipeclose+0x37>
8010416e:	66 90                	xchg   %ax,%ax

80104170 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	57                   	push   %edi
80104174:	56                   	push   %esi
80104175:	53                   	push   %ebx
80104176:	83 ec 28             	sub    $0x28,%esp
80104179:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010417c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010417f:	53                   	push   %ebx
80104180:	e8 eb 0f 00 00       	call   80105170 <acquire>
  for(i = 0; i < n; i++){
80104185:	83 c4 10             	add    $0x10,%esp
80104188:	85 ff                	test   %edi,%edi
8010418a:	0f 8e ce 00 00 00    	jle    8010425e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104190:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80104196:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104199:	89 7d 10             	mov    %edi,0x10(%ebp)
8010419c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010419f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801041a2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801041a5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041ab:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801041b1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041b7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801041bd:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801041c0:	0f 85 b6 00 00 00    	jne    8010427c <pipewrite+0x10c>
801041c6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801041c9:	eb 3b                	jmp    80104206 <pipewrite+0x96>
801041cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
801041d0:	e8 5b 03 00 00       	call   80104530 <myproc>
801041d5:	8b 48 24             	mov    0x24(%eax),%ecx
801041d8:	85 c9                	test   %ecx,%ecx
801041da:	75 34                	jne    80104210 <pipewrite+0xa0>
      wakeup(&p->nread);
801041dc:	83 ec 0c             	sub    $0xc,%esp
801041df:	56                   	push   %esi
801041e0:	e8 cb 0a 00 00       	call   80104cb0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801041e5:	58                   	pop    %eax
801041e6:	5a                   	pop    %edx
801041e7:	53                   	push   %ebx
801041e8:	57                   	push   %edi
801041e9:	e8 02 0a 00 00       	call   80104bf0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041ee:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801041f4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801041fa:	83 c4 10             	add    $0x10,%esp
801041fd:	05 00 02 00 00       	add    $0x200,%eax
80104202:	39 c2                	cmp    %eax,%edx
80104204:	75 2a                	jne    80104230 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80104206:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010420c:	85 c0                	test   %eax,%eax
8010420e:	75 c0                	jne    801041d0 <pipewrite+0x60>
        release(&p->lock);
80104210:	83 ec 0c             	sub    $0xc,%esp
80104213:	53                   	push   %ebx
80104214:	e8 f7 0e 00 00       	call   80105110 <release>
        return -1;
80104219:	83 c4 10             	add    $0x10,%esp
8010421c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104221:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104224:	5b                   	pop    %ebx
80104225:	5e                   	pop    %esi
80104226:	5f                   	pop    %edi
80104227:	5d                   	pop    %ebp
80104228:	c3                   	ret
80104229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104230:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104233:	8d 42 01             	lea    0x1(%edx),%eax
80104236:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010423c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010423f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80104245:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104248:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010424c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80104250:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104253:	39 c1                	cmp    %eax,%ecx
80104255:	0f 85 50 ff ff ff    	jne    801041ab <pipewrite+0x3b>
8010425b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010425e:	83 ec 0c             	sub    $0xc,%esp
80104261:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104267:	50                   	push   %eax
80104268:	e8 43 0a 00 00       	call   80104cb0 <wakeup>
  release(&p->lock);
8010426d:	89 1c 24             	mov    %ebx,(%esp)
80104270:	e8 9b 0e 00 00       	call   80105110 <release>
  return n;
80104275:	83 c4 10             	add    $0x10,%esp
80104278:	89 f8                	mov    %edi,%eax
8010427a:	eb a5                	jmp    80104221 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010427c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010427f:	eb b2                	jmp    80104233 <pipewrite+0xc3>
80104281:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104288:	00 
80104289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104290 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	57                   	push   %edi
80104294:	56                   	push   %esi
80104295:	53                   	push   %ebx
80104296:	83 ec 18             	sub    $0x18,%esp
80104299:	8b 75 08             	mov    0x8(%ebp),%esi
8010429c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010429f:	56                   	push   %esi
801042a0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801042a6:	e8 c5 0e 00 00       	call   80105170 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801042ab:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801042b1:	83 c4 10             	add    $0x10,%esp
801042b4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801042ba:	74 2f                	je     801042eb <piperead+0x5b>
801042bc:	eb 37                	jmp    801042f5 <piperead+0x65>
801042be:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801042c0:	e8 6b 02 00 00       	call   80104530 <myproc>
801042c5:	8b 40 24             	mov    0x24(%eax),%eax
801042c8:	85 c0                	test   %eax,%eax
801042ca:	0f 85 80 00 00 00    	jne    80104350 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801042d0:	83 ec 08             	sub    $0x8,%esp
801042d3:	56                   	push   %esi
801042d4:	53                   	push   %ebx
801042d5:	e8 16 09 00 00       	call   80104bf0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801042da:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801042e0:	83 c4 10             	add    $0x10,%esp
801042e3:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801042e9:	75 0a                	jne    801042f5 <piperead+0x65>
801042eb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801042f1:	85 d2                	test   %edx,%edx
801042f3:	75 cb                	jne    801042c0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801042f8:	31 db                	xor    %ebx,%ebx
801042fa:	85 c9                	test   %ecx,%ecx
801042fc:	7f 26                	jg     80104324 <piperead+0x94>
801042fe:	eb 2c                	jmp    8010432c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104300:	8d 48 01             	lea    0x1(%eax),%ecx
80104303:	25 ff 01 00 00       	and    $0x1ff,%eax
80104308:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010430e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104313:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104316:	83 c3 01             	add    $0x1,%ebx
80104319:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010431c:	74 0e                	je     8010432c <piperead+0x9c>
8010431e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80104324:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010432a:	75 d4                	jne    80104300 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010432c:	83 ec 0c             	sub    $0xc,%esp
8010432f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104335:	50                   	push   %eax
80104336:	e8 75 09 00 00       	call   80104cb0 <wakeup>
  release(&p->lock);
8010433b:	89 34 24             	mov    %esi,(%esp)
8010433e:	e8 cd 0d 00 00       	call   80105110 <release>
  return i;
80104343:	83 c4 10             	add    $0x10,%esp
}
80104346:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104349:	89 d8                	mov    %ebx,%eax
8010434b:	5b                   	pop    %ebx
8010434c:	5e                   	pop    %esi
8010434d:	5f                   	pop    %edi
8010434e:	5d                   	pop    %ebp
8010434f:	c3                   	ret
      release(&p->lock);
80104350:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104353:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80104358:	56                   	push   %esi
80104359:	e8 b2 0d 00 00       	call   80105110 <release>
      return -1;
8010435e:	83 c4 10             	add    $0x10,%esp
}
80104361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104364:	89 d8                	mov    %ebx,%eax
80104366:	5b                   	pop    %ebx
80104367:	5e                   	pop    %esi
80104368:	5f                   	pop    %edi
80104369:	5d                   	pop    %ebp
8010436a:	c3                   	ret
8010436b:	66 90                	xchg   %ax,%ax
8010436d:	66 90                	xchg   %ax,%ax
8010436f:	90                   	nop

80104370 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104374:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
80104379:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010437c:	68 40 2d 11 80       	push   $0x80112d40
80104381:	e8 ea 0d 00 00       	call   80105170 <acquire>
80104386:	83 c4 10             	add    $0x10,%esp
80104389:	eb 10                	jmp    8010439b <allocproc+0x2b>
8010438b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104390:	83 c3 7c             	add    $0x7c,%ebx
80104393:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104399:	74 75                	je     80104410 <allocproc+0xa0>
    if(p->state == UNUSED)
8010439b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010439e:	85 c0                	test   %eax,%eax
801043a0:	75 ee                	jne    80104390 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801043a2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
801043a7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801043aa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801043b1:	89 43 10             	mov    %eax,0x10(%ebx)
801043b4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801043b7:	68 40 2d 11 80       	push   $0x80112d40
  p->pid = nextpid++;
801043bc:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
801043c2:	e8 49 0d 00 00       	call   80105110 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801043c7:	e8 64 ee ff ff       	call   80103230 <kalloc>
801043cc:	83 c4 10             	add    $0x10,%esp
801043cf:	89 43 08             	mov    %eax,0x8(%ebx)
801043d2:	85 c0                	test   %eax,%eax
801043d4:	74 53                	je     80104429 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043d6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801043dc:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801043df:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801043e4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801043e7:	c7 40 14 22 64 10 80 	movl   $0x80106422,0x14(%eax)
  p->context = (struct context*)sp;
801043ee:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801043f1:	6a 14                	push   $0x14
801043f3:	6a 00                	push   $0x0
801043f5:	50                   	push   %eax
801043f6:	e8 75 0e 00 00       	call   80105270 <memset>
  p->context->eip = (uint)forkret;
801043fb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801043fe:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104401:	c7 40 10 40 44 10 80 	movl   $0x80104440,0x10(%eax)
}
80104408:	89 d8                	mov    %ebx,%eax
8010440a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010440d:	c9                   	leave
8010440e:	c3                   	ret
8010440f:	90                   	nop
  release(&ptable.lock);
80104410:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104413:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104415:	68 40 2d 11 80       	push   $0x80112d40
8010441a:	e8 f1 0c 00 00       	call   80105110 <release>
  return 0;
8010441f:	83 c4 10             	add    $0x10,%esp
}
80104422:	89 d8                	mov    %ebx,%eax
80104424:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104427:	c9                   	leave
80104428:	c3                   	ret
    p->state = UNUSED;
80104429:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80104430:	31 db                	xor    %ebx,%ebx
80104432:	eb ee                	jmp    80104422 <allocproc+0xb2>
80104434:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010443b:	00 
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104440 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104446:	68 40 2d 11 80       	push   $0x80112d40
8010444b:	e8 c0 0c 00 00       	call   80105110 <release>

  if (first) {
80104450:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104455:	83 c4 10             	add    $0x10,%esp
80104458:	85 c0                	test   %eax,%eax
8010445a:	75 04                	jne    80104460 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010445c:	c9                   	leave
8010445d:	c3                   	ret
8010445e:	66 90                	xchg   %ax,%ax
    first = 0;
80104460:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80104467:	00 00 00 
    iinit(ROOTDEV);
8010446a:	83 ec 0c             	sub    $0xc,%esp
8010446d:	6a 01                	push   $0x1
8010446f:	e8 dc dc ff ff       	call   80102150 <iinit>
    initlog(ROOTDEV);
80104474:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010447b:	e8 f0 f3 ff ff       	call   80103870 <initlog>
}
80104480:	83 c4 10             	add    $0x10,%esp
80104483:	c9                   	leave
80104484:	c3                   	ret
80104485:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010448c:	00 
8010448d:	8d 76 00             	lea    0x0(%esi),%esi

80104490 <pinit>:
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80104496:	68 9a 7f 10 80       	push   $0x80107f9a
8010449b:	68 40 2d 11 80       	push   $0x80112d40
801044a0:	e8 db 0a 00 00       	call   80104f80 <initlock>
}
801044a5:	83 c4 10             	add    $0x10,%esp
801044a8:	c9                   	leave
801044a9:	c3                   	ret
801044aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044b0 <mycpu>:
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	56                   	push   %esi
801044b4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044b5:	9c                   	pushf
801044b6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801044b7:	f6 c4 02             	test   $0x2,%ah
801044ba:	75 46                	jne    80104502 <mycpu+0x52>
  apicid = lapicid();
801044bc:	e8 df ef ff ff       	call   801034a0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801044c1:	8b 35 a4 27 11 80    	mov    0x801127a4,%esi
801044c7:	85 f6                	test   %esi,%esi
801044c9:	7e 2a                	jle    801044f5 <mycpu+0x45>
801044cb:	31 d2                	xor    %edx,%edx
801044cd:	eb 08                	jmp    801044d7 <mycpu+0x27>
801044cf:	90                   	nop
801044d0:	83 c2 01             	add    $0x1,%edx
801044d3:	39 f2                	cmp    %esi,%edx
801044d5:	74 1e                	je     801044f5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
801044d7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801044dd:	0f b6 99 c0 27 11 80 	movzbl -0x7feed840(%ecx),%ebx
801044e4:	39 c3                	cmp    %eax,%ebx
801044e6:	75 e8                	jne    801044d0 <mycpu+0x20>
}
801044e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
801044eb:	8d 81 c0 27 11 80    	lea    -0x7feed840(%ecx),%eax
}
801044f1:	5b                   	pop    %ebx
801044f2:	5e                   	pop    %esi
801044f3:	5d                   	pop    %ebp
801044f4:	c3                   	ret
  panic("unknown apicid\n");
801044f5:	83 ec 0c             	sub    $0xc,%esp
801044f8:	68 a1 7f 10 80       	push   $0x80107fa1
801044fd:	e8 6e c6 ff ff       	call   80100b70 <panic>
    panic("mycpu called with interrupts enabled\n");
80104502:	83 ec 0c             	sub    $0xc,%esp
80104505:	68 6c 83 10 80       	push   $0x8010836c
8010450a:	e8 61 c6 ff ff       	call   80100b70 <panic>
8010450f:	90                   	nop

80104510 <cpuid>:
cpuid() {
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104516:	e8 95 ff ff ff       	call   801044b0 <mycpu>
}
8010451b:	c9                   	leave
  return mycpu()-cpus;
8010451c:	2d c0 27 11 80       	sub    $0x801127c0,%eax
80104521:	c1 f8 04             	sar    $0x4,%eax
80104524:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010452a:	c3                   	ret
8010452b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104530 <myproc>:
myproc(void) {
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	53                   	push   %ebx
80104534:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104537:	e8 e4 0a 00 00       	call   80105020 <pushcli>
  c = mycpu();
8010453c:	e8 6f ff ff ff       	call   801044b0 <mycpu>
  p = c->proc;
80104541:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104547:	e8 24 0b 00 00       	call   80105070 <popcli>
}
8010454c:	89 d8                	mov    %ebx,%eax
8010454e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104551:	c9                   	leave
80104552:	c3                   	ret
80104553:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010455a:	00 
8010455b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104560 <userinit>:
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	53                   	push   %ebx
80104564:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104567:	e8 04 fe ff ff       	call   80104370 <allocproc>
8010456c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010456e:	a3 74 4c 11 80       	mov    %eax,0x80114c74
  if((p->pgdir = setupkvm()) == 0)
80104573:	e8 78 34 00 00       	call   801079f0 <setupkvm>
80104578:	89 43 04             	mov    %eax,0x4(%ebx)
8010457b:	85 c0                	test   %eax,%eax
8010457d:	0f 84 bd 00 00 00    	je     80104640 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104583:	83 ec 04             	sub    $0x4,%esp
80104586:	68 2c 00 00 00       	push   $0x2c
8010458b:	68 60 b4 10 80       	push   $0x8010b460
80104590:	50                   	push   %eax
80104591:	e8 3a 31 00 00       	call   801076d0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104596:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104599:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010459f:	6a 4c                	push   $0x4c
801045a1:	6a 00                	push   $0x0
801045a3:	ff 73 18             	push   0x18(%ebx)
801045a6:	e8 c5 0c 00 00       	call   80105270 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801045ab:	8b 43 18             	mov    0x18(%ebx),%eax
801045ae:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801045b3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801045b6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801045bb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801045bf:	8b 43 18             	mov    0x18(%ebx),%eax
801045c2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801045c6:	8b 43 18             	mov    0x18(%ebx),%eax
801045c9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801045cd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801045d1:	8b 43 18             	mov    0x18(%ebx),%eax
801045d4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801045d8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801045dc:	8b 43 18             	mov    0x18(%ebx),%eax
801045df:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801045e6:	8b 43 18             	mov    0x18(%ebx),%eax
801045e9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801045f0:	8b 43 18             	mov    0x18(%ebx),%eax
801045f3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801045fa:	8d 43 6c             	lea    0x6c(%ebx),%eax
801045fd:	6a 10                	push   $0x10
801045ff:	68 ca 7f 10 80       	push   $0x80107fca
80104604:	50                   	push   %eax
80104605:	e8 16 0e 00 00       	call   80105420 <safestrcpy>
  p->cwd = namei("/");
8010460a:	c7 04 24 d3 7f 10 80 	movl   $0x80107fd3,(%esp)
80104611:	e8 3a e6 ff ff       	call   80102c50 <namei>
80104616:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104619:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104620:	e8 4b 0b 00 00       	call   80105170 <acquire>
  p->state = RUNNABLE;
80104625:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010462c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104633:	e8 d8 0a 00 00       	call   80105110 <release>
}
80104638:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010463b:	83 c4 10             	add    $0x10,%esp
8010463e:	c9                   	leave
8010463f:	c3                   	ret
    panic("userinit: out of memory?");
80104640:	83 ec 0c             	sub    $0xc,%esp
80104643:	68 b1 7f 10 80       	push   $0x80107fb1
80104648:	e8 23 c5 ff ff       	call   80100b70 <panic>
8010464d:	8d 76 00             	lea    0x0(%esi),%esi

80104650 <growproc>:
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
80104655:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104658:	e8 c3 09 00 00       	call   80105020 <pushcli>
  c = mycpu();
8010465d:	e8 4e fe ff ff       	call   801044b0 <mycpu>
  p = c->proc;
80104662:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104668:	e8 03 0a 00 00       	call   80105070 <popcli>
  sz = curproc->sz;
8010466d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
8010466f:	85 f6                	test   %esi,%esi
80104671:	7f 1d                	jg     80104690 <growproc+0x40>
  } else if(n < 0){
80104673:	75 3b                	jne    801046b0 <growproc+0x60>
  switchuvm(curproc);
80104675:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104678:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010467a:	53                   	push   %ebx
8010467b:	e8 40 2f 00 00       	call   801075c0 <switchuvm>
  return 0;
80104680:	83 c4 10             	add    $0x10,%esp
80104683:	31 c0                	xor    %eax,%eax
}
80104685:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104688:	5b                   	pop    %ebx
80104689:	5e                   	pop    %esi
8010468a:	5d                   	pop    %ebp
8010468b:	c3                   	ret
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104690:	83 ec 04             	sub    $0x4,%esp
80104693:	01 c6                	add    %eax,%esi
80104695:	56                   	push   %esi
80104696:	50                   	push   %eax
80104697:	ff 73 04             	push   0x4(%ebx)
8010469a:	e8 81 31 00 00       	call   80107820 <allocuvm>
8010469f:	83 c4 10             	add    $0x10,%esp
801046a2:	85 c0                	test   %eax,%eax
801046a4:	75 cf                	jne    80104675 <growproc+0x25>
      return -1;
801046a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046ab:	eb d8                	jmp    80104685 <growproc+0x35>
801046ad:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801046b0:	83 ec 04             	sub    $0x4,%esp
801046b3:	01 c6                	add    %eax,%esi
801046b5:	56                   	push   %esi
801046b6:	50                   	push   %eax
801046b7:	ff 73 04             	push   0x4(%ebx)
801046ba:	e8 81 32 00 00       	call   80107940 <deallocuvm>
801046bf:	83 c4 10             	add    $0x10,%esp
801046c2:	85 c0                	test   %eax,%eax
801046c4:	75 af                	jne    80104675 <growproc+0x25>
801046c6:	eb de                	jmp    801046a6 <growproc+0x56>
801046c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046cf:	00 

801046d0 <fork>:
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	57                   	push   %edi
801046d4:	56                   	push   %esi
801046d5:	53                   	push   %ebx
801046d6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801046d9:	e8 42 09 00 00       	call   80105020 <pushcli>
  c = mycpu();
801046de:	e8 cd fd ff ff       	call   801044b0 <mycpu>
  p = c->proc;
801046e3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046e9:	e8 82 09 00 00       	call   80105070 <popcli>
  if((np = allocproc()) == 0){
801046ee:	e8 7d fc ff ff       	call   80104370 <allocproc>
801046f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801046f6:	85 c0                	test   %eax,%eax
801046f8:	0f 84 d6 00 00 00    	je     801047d4 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801046fe:	83 ec 08             	sub    $0x8,%esp
80104701:	ff 33                	push   (%ebx)
80104703:	89 c7                	mov    %eax,%edi
80104705:	ff 73 04             	push   0x4(%ebx)
80104708:	e8 d3 33 00 00       	call   80107ae0 <copyuvm>
8010470d:	83 c4 10             	add    $0x10,%esp
80104710:	89 47 04             	mov    %eax,0x4(%edi)
80104713:	85 c0                	test   %eax,%eax
80104715:	0f 84 9a 00 00 00    	je     801047b5 <fork+0xe5>
  np->sz = curproc->sz;
8010471b:	8b 03                	mov    (%ebx),%eax
8010471d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104720:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104722:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104725:	89 c8                	mov    %ecx,%eax
80104727:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010472a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010472f:	8b 73 18             	mov    0x18(%ebx),%esi
80104732:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104734:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104736:	8b 40 18             	mov    0x18(%eax),%eax
80104739:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104740:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104744:	85 c0                	test   %eax,%eax
80104746:	74 13                	je     8010475b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104748:	83 ec 0c             	sub    $0xc,%esp
8010474b:	50                   	push   %eax
8010474c:	e8 3f d3 ff ff       	call   80101a90 <filedup>
80104751:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104754:	83 c4 10             	add    $0x10,%esp
80104757:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
8010475b:	83 c6 01             	add    $0x1,%esi
8010475e:	83 fe 10             	cmp    $0x10,%esi
80104761:	75 dd                	jne    80104740 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104763:	83 ec 0c             	sub    $0xc,%esp
80104766:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104769:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010476c:	e8 cf db ff ff       	call   80102340 <idup>
80104771:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104774:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104777:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010477a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010477d:	6a 10                	push   $0x10
8010477f:	53                   	push   %ebx
80104780:	50                   	push   %eax
80104781:	e8 9a 0c 00 00       	call   80105420 <safestrcpy>
  pid = np->pid;
80104786:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104789:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104790:	e8 db 09 00 00       	call   80105170 <acquire>
  np->state = RUNNABLE;
80104795:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010479c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801047a3:	e8 68 09 00 00       	call   80105110 <release>
  return pid;
801047a8:	83 c4 10             	add    $0x10,%esp
}
801047ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047ae:	89 d8                	mov    %ebx,%eax
801047b0:	5b                   	pop    %ebx
801047b1:	5e                   	pop    %esi
801047b2:	5f                   	pop    %edi
801047b3:	5d                   	pop    %ebp
801047b4:	c3                   	ret
    kfree(np->kstack);
801047b5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801047b8:	83 ec 0c             	sub    $0xc,%esp
801047bb:	ff 73 08             	push   0x8(%ebx)
801047be:	e8 ad e8 ff ff       	call   80103070 <kfree>
    np->kstack = 0;
801047c3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
801047ca:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
801047cd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801047d4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801047d9:	eb d0                	jmp    801047ab <fork+0xdb>
801047db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801047e0 <scheduler>:
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	57                   	push   %edi
801047e4:	56                   	push   %esi
801047e5:	53                   	push   %ebx
801047e6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801047e9:	e8 c2 fc ff ff       	call   801044b0 <mycpu>
  c->proc = 0;
801047ee:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801047f5:	00 00 00 
  struct cpu *c = mycpu();
801047f8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801047fa:	8d 78 04             	lea    0x4(%eax),%edi
801047fd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104800:	fb                   	sti
    acquire(&ptable.lock);
80104801:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104804:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
    acquire(&ptable.lock);
80104809:	68 40 2d 11 80       	push   $0x80112d40
8010480e:	e8 5d 09 00 00       	call   80105170 <acquire>
80104813:	83 c4 10             	add    $0x10,%esp
80104816:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010481d:	00 
8010481e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80104820:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104824:	75 33                	jne    80104859 <scheduler+0x79>
      switchuvm(p);
80104826:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104829:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010482f:	53                   	push   %ebx
80104830:	e8 8b 2d 00 00       	call   801075c0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104835:	58                   	pop    %eax
80104836:	5a                   	pop    %edx
80104837:	ff 73 1c             	push   0x1c(%ebx)
8010483a:	57                   	push   %edi
      p->state = RUNNING;
8010483b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104842:	e8 34 0c 00 00       	call   8010547b <swtch>
      switchkvm();
80104847:	e8 64 2d 00 00       	call   801075b0 <switchkvm>
      c->proc = 0;
8010484c:	83 c4 10             	add    $0x10,%esp
8010484f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104856:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104859:	83 c3 7c             	add    $0x7c,%ebx
8010485c:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104862:	75 bc                	jne    80104820 <scheduler+0x40>
    release(&ptable.lock);
80104864:	83 ec 0c             	sub    $0xc,%esp
80104867:	68 40 2d 11 80       	push   $0x80112d40
8010486c:	e8 9f 08 00 00       	call   80105110 <release>
    sti();
80104871:	83 c4 10             	add    $0x10,%esp
80104874:	eb 8a                	jmp    80104800 <scheduler+0x20>
80104876:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010487d:	00 
8010487e:	66 90                	xchg   %ax,%ax

80104880 <sched>:
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	56                   	push   %esi
80104884:	53                   	push   %ebx
  pushcli();
80104885:	e8 96 07 00 00       	call   80105020 <pushcli>
  c = mycpu();
8010488a:	e8 21 fc ff ff       	call   801044b0 <mycpu>
  p = c->proc;
8010488f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104895:	e8 d6 07 00 00       	call   80105070 <popcli>
  if(!holding(&ptable.lock))
8010489a:	83 ec 0c             	sub    $0xc,%esp
8010489d:	68 40 2d 11 80       	push   $0x80112d40
801048a2:	e8 29 08 00 00       	call   801050d0 <holding>
801048a7:	83 c4 10             	add    $0x10,%esp
801048aa:	85 c0                	test   %eax,%eax
801048ac:	74 4f                	je     801048fd <sched+0x7d>
  if(mycpu()->ncli != 1)
801048ae:	e8 fd fb ff ff       	call   801044b0 <mycpu>
801048b3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801048ba:	75 68                	jne    80104924 <sched+0xa4>
  if(p->state == RUNNING)
801048bc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801048c0:	74 55                	je     80104917 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801048c2:	9c                   	pushf
801048c3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801048c4:	f6 c4 02             	test   $0x2,%ah
801048c7:	75 41                	jne    8010490a <sched+0x8a>
  intena = mycpu()->intena;
801048c9:	e8 e2 fb ff ff       	call   801044b0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801048ce:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801048d1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801048d7:	e8 d4 fb ff ff       	call   801044b0 <mycpu>
801048dc:	83 ec 08             	sub    $0x8,%esp
801048df:	ff 70 04             	push   0x4(%eax)
801048e2:	53                   	push   %ebx
801048e3:	e8 93 0b 00 00       	call   8010547b <swtch>
  mycpu()->intena = intena;
801048e8:	e8 c3 fb ff ff       	call   801044b0 <mycpu>
}
801048ed:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801048f0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801048f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048f9:	5b                   	pop    %ebx
801048fa:	5e                   	pop    %esi
801048fb:	5d                   	pop    %ebp
801048fc:	c3                   	ret
    panic("sched ptable.lock");
801048fd:	83 ec 0c             	sub    $0xc,%esp
80104900:	68 d5 7f 10 80       	push   $0x80107fd5
80104905:	e8 66 c2 ff ff       	call   80100b70 <panic>
    panic("sched interruptible");
8010490a:	83 ec 0c             	sub    $0xc,%esp
8010490d:	68 01 80 10 80       	push   $0x80108001
80104912:	e8 59 c2 ff ff       	call   80100b70 <panic>
    panic("sched running");
80104917:	83 ec 0c             	sub    $0xc,%esp
8010491a:	68 f3 7f 10 80       	push   $0x80107ff3
8010491f:	e8 4c c2 ff ff       	call   80100b70 <panic>
    panic("sched locks");
80104924:	83 ec 0c             	sub    $0xc,%esp
80104927:	68 e7 7f 10 80       	push   $0x80107fe7
8010492c:	e8 3f c2 ff ff       	call   80100b70 <panic>
80104931:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104938:	00 
80104939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104940 <exit>:
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	57                   	push   %edi
80104944:	56                   	push   %esi
80104945:	53                   	push   %ebx
80104946:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104949:	e8 e2 fb ff ff       	call   80104530 <myproc>
  if(curproc == initproc)
8010494e:	39 05 74 4c 11 80    	cmp    %eax,0x80114c74
80104954:	0f 84 fd 00 00 00    	je     80104a57 <exit+0x117>
8010495a:	89 c3                	mov    %eax,%ebx
8010495c:	8d 70 28             	lea    0x28(%eax),%esi
8010495f:	8d 78 68             	lea    0x68(%eax),%edi
80104962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104968:	8b 06                	mov    (%esi),%eax
8010496a:	85 c0                	test   %eax,%eax
8010496c:	74 12                	je     80104980 <exit+0x40>
      fileclose(curproc->ofile[fd]);
8010496e:	83 ec 0c             	sub    $0xc,%esp
80104971:	50                   	push   %eax
80104972:	e8 69 d1 ff ff       	call   80101ae0 <fileclose>
      curproc->ofile[fd] = 0;
80104977:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010497d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104980:	83 c6 04             	add    $0x4,%esi
80104983:	39 f7                	cmp    %esi,%edi
80104985:	75 e1                	jne    80104968 <exit+0x28>
  begin_op();
80104987:	e8 84 ef ff ff       	call   80103910 <begin_op>
  iput(curproc->cwd);
8010498c:	83 ec 0c             	sub    $0xc,%esp
8010498f:	ff 73 68             	push   0x68(%ebx)
80104992:	e8 09 db ff ff       	call   801024a0 <iput>
  end_op();
80104997:	e8 e4 ef ff ff       	call   80103980 <end_op>
  curproc->cwd = 0;
8010499c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
801049a3:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801049aa:	e8 c1 07 00 00       	call   80105170 <acquire>
  wakeup1(curproc->parent);
801049af:	8b 53 14             	mov    0x14(%ebx),%edx
801049b2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049b5:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801049ba:	eb 0e                	jmp    801049ca <exit+0x8a>
801049bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049c0:	83 c0 7c             	add    $0x7c,%eax
801049c3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801049c8:	74 1c                	je     801049e6 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
801049ca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801049ce:	75 f0                	jne    801049c0 <exit+0x80>
801049d0:	3b 50 20             	cmp    0x20(%eax),%edx
801049d3:	75 eb                	jne    801049c0 <exit+0x80>
      p->state = RUNNABLE;
801049d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049dc:	83 c0 7c             	add    $0x7c,%eax
801049df:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801049e4:	75 e4                	jne    801049ca <exit+0x8a>
      p->parent = initproc;
801049e6:	8b 0d 74 4c 11 80    	mov    0x80114c74,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049ec:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
801049f1:	eb 10                	jmp    80104a03 <exit+0xc3>
801049f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801049f8:	83 c2 7c             	add    $0x7c,%edx
801049fb:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80104a01:	74 3b                	je     80104a3e <exit+0xfe>
    if(p->parent == curproc){
80104a03:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104a06:	75 f0                	jne    801049f8 <exit+0xb8>
      if(p->state == ZOMBIE)
80104a08:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104a0c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104a0f:	75 e7                	jne    801049f8 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a11:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104a16:	eb 12                	jmp    80104a2a <exit+0xea>
80104a18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a1f:	00 
80104a20:	83 c0 7c             	add    $0x7c,%eax
80104a23:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104a28:	74 ce                	je     801049f8 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80104a2a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a2e:	75 f0                	jne    80104a20 <exit+0xe0>
80104a30:	3b 48 20             	cmp    0x20(%eax),%ecx
80104a33:	75 eb                	jne    80104a20 <exit+0xe0>
      p->state = RUNNABLE;
80104a35:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104a3c:	eb e2                	jmp    80104a20 <exit+0xe0>
  curproc->state = ZOMBIE;
80104a3e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104a45:	e8 36 fe ff ff       	call   80104880 <sched>
  panic("zombie exit");
80104a4a:	83 ec 0c             	sub    $0xc,%esp
80104a4d:	68 22 80 10 80       	push   $0x80108022
80104a52:	e8 19 c1 ff ff       	call   80100b70 <panic>
    panic("init exiting");
80104a57:	83 ec 0c             	sub    $0xc,%esp
80104a5a:	68 15 80 10 80       	push   $0x80108015
80104a5f:	e8 0c c1 ff ff       	call   80100b70 <panic>
80104a64:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a6b:	00 
80104a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a70 <wait>:
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	56                   	push   %esi
80104a74:	53                   	push   %ebx
  pushcli();
80104a75:	e8 a6 05 00 00       	call   80105020 <pushcli>
  c = mycpu();
80104a7a:	e8 31 fa ff ff       	call   801044b0 <mycpu>
  p = c->proc;
80104a7f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104a85:	e8 e6 05 00 00       	call   80105070 <popcli>
  acquire(&ptable.lock);
80104a8a:	83 ec 0c             	sub    $0xc,%esp
80104a8d:	68 40 2d 11 80       	push   $0x80112d40
80104a92:	e8 d9 06 00 00       	call   80105170 <acquire>
80104a97:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104a9a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a9c:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104aa1:	eb 10                	jmp    80104ab3 <wait+0x43>
80104aa3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104aa8:	83 c3 7c             	add    $0x7c,%ebx
80104aab:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104ab1:	74 1b                	je     80104ace <wait+0x5e>
      if(p->parent != curproc)
80104ab3:	39 73 14             	cmp    %esi,0x14(%ebx)
80104ab6:	75 f0                	jne    80104aa8 <wait+0x38>
      if(p->state == ZOMBIE){
80104ab8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104abc:	74 62                	je     80104b20 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104abe:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104ac1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ac6:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104acc:	75 e5                	jne    80104ab3 <wait+0x43>
    if(!havekids || curproc->killed){
80104ace:	85 c0                	test   %eax,%eax
80104ad0:	0f 84 a0 00 00 00    	je     80104b76 <wait+0x106>
80104ad6:	8b 46 24             	mov    0x24(%esi),%eax
80104ad9:	85 c0                	test   %eax,%eax
80104adb:	0f 85 95 00 00 00    	jne    80104b76 <wait+0x106>
  pushcli();
80104ae1:	e8 3a 05 00 00       	call   80105020 <pushcli>
  c = mycpu();
80104ae6:	e8 c5 f9 ff ff       	call   801044b0 <mycpu>
  p = c->proc;
80104aeb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104af1:	e8 7a 05 00 00       	call   80105070 <popcli>
  if(p == 0)
80104af6:	85 db                	test   %ebx,%ebx
80104af8:	0f 84 8f 00 00 00    	je     80104b8d <wait+0x11d>
  p->chan = chan;
80104afe:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104b01:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104b08:	e8 73 fd ff ff       	call   80104880 <sched>
  p->chan = 0;
80104b0d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104b14:	eb 84                	jmp    80104a9a <wait+0x2a>
80104b16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b1d:	00 
80104b1e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104b20:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104b23:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104b26:	ff 73 08             	push   0x8(%ebx)
80104b29:	e8 42 e5 ff ff       	call   80103070 <kfree>
        p->kstack = 0;
80104b2e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104b35:	5a                   	pop    %edx
80104b36:	ff 73 04             	push   0x4(%ebx)
80104b39:	e8 32 2e 00 00       	call   80107970 <freevm>
        p->pid = 0;
80104b3e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104b45:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104b4c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104b50:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104b57:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104b5e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104b65:	e8 a6 05 00 00       	call   80105110 <release>
        return pid;
80104b6a:	83 c4 10             	add    $0x10,%esp
}
80104b6d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b70:	89 f0                	mov    %esi,%eax
80104b72:	5b                   	pop    %ebx
80104b73:	5e                   	pop    %esi
80104b74:	5d                   	pop    %ebp
80104b75:	c3                   	ret
      release(&ptable.lock);
80104b76:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104b79:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104b7e:	68 40 2d 11 80       	push   $0x80112d40
80104b83:	e8 88 05 00 00       	call   80105110 <release>
      return -1;
80104b88:	83 c4 10             	add    $0x10,%esp
80104b8b:	eb e0                	jmp    80104b6d <wait+0xfd>
    panic("sleep");
80104b8d:	83 ec 0c             	sub    $0xc,%esp
80104b90:	68 2e 80 10 80       	push   $0x8010802e
80104b95:	e8 d6 bf ff ff       	call   80100b70 <panic>
80104b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ba0 <yield>:
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	53                   	push   %ebx
80104ba4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104ba7:	68 40 2d 11 80       	push   $0x80112d40
80104bac:	e8 bf 05 00 00       	call   80105170 <acquire>
  pushcli();
80104bb1:	e8 6a 04 00 00       	call   80105020 <pushcli>
  c = mycpu();
80104bb6:	e8 f5 f8 ff ff       	call   801044b0 <mycpu>
  p = c->proc;
80104bbb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104bc1:	e8 aa 04 00 00       	call   80105070 <popcli>
  myproc()->state = RUNNABLE;
80104bc6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104bcd:	e8 ae fc ff ff       	call   80104880 <sched>
  release(&ptable.lock);
80104bd2:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104bd9:	e8 32 05 00 00       	call   80105110 <release>
}
80104bde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104be1:	83 c4 10             	add    $0x10,%esp
80104be4:	c9                   	leave
80104be5:	c3                   	ret
80104be6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bed:	00 
80104bee:	66 90                	xchg   %ax,%ax

80104bf0 <sleep>:
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	57                   	push   %edi
80104bf4:	56                   	push   %esi
80104bf5:	53                   	push   %ebx
80104bf6:	83 ec 0c             	sub    $0xc,%esp
80104bf9:	8b 7d 08             	mov    0x8(%ebp),%edi
80104bfc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104bff:	e8 1c 04 00 00       	call   80105020 <pushcli>
  c = mycpu();
80104c04:	e8 a7 f8 ff ff       	call   801044b0 <mycpu>
  p = c->proc;
80104c09:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104c0f:	e8 5c 04 00 00       	call   80105070 <popcli>
  if(p == 0)
80104c14:	85 db                	test   %ebx,%ebx
80104c16:	0f 84 87 00 00 00    	je     80104ca3 <sleep+0xb3>
  if(lk == 0)
80104c1c:	85 f6                	test   %esi,%esi
80104c1e:	74 76                	je     80104c96 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104c20:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80104c26:	74 50                	je     80104c78 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104c28:	83 ec 0c             	sub    $0xc,%esp
80104c2b:	68 40 2d 11 80       	push   $0x80112d40
80104c30:	e8 3b 05 00 00       	call   80105170 <acquire>
    release(lk);
80104c35:	89 34 24             	mov    %esi,(%esp)
80104c38:	e8 d3 04 00 00       	call   80105110 <release>
  p->chan = chan;
80104c3d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104c40:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104c47:	e8 34 fc ff ff       	call   80104880 <sched>
  p->chan = 0;
80104c4c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104c53:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104c5a:	e8 b1 04 00 00       	call   80105110 <release>
    acquire(lk);
80104c5f:	83 c4 10             	add    $0x10,%esp
80104c62:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104c65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c68:	5b                   	pop    %ebx
80104c69:	5e                   	pop    %esi
80104c6a:	5f                   	pop    %edi
80104c6b:	5d                   	pop    %ebp
    acquire(lk);
80104c6c:	e9 ff 04 00 00       	jmp    80105170 <acquire>
80104c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104c78:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104c7b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104c82:	e8 f9 fb ff ff       	call   80104880 <sched>
  p->chan = 0;
80104c87:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104c8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c91:	5b                   	pop    %ebx
80104c92:	5e                   	pop    %esi
80104c93:	5f                   	pop    %edi
80104c94:	5d                   	pop    %ebp
80104c95:	c3                   	ret
    panic("sleep without lk");
80104c96:	83 ec 0c             	sub    $0xc,%esp
80104c99:	68 34 80 10 80       	push   $0x80108034
80104c9e:	e8 cd be ff ff       	call   80100b70 <panic>
    panic("sleep");
80104ca3:	83 ec 0c             	sub    $0xc,%esp
80104ca6:	68 2e 80 10 80       	push   $0x8010802e
80104cab:	e8 c0 be ff ff       	call   80100b70 <panic>

80104cb0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	53                   	push   %ebx
80104cb4:	83 ec 10             	sub    $0x10,%esp
80104cb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104cba:	68 40 2d 11 80       	push   $0x80112d40
80104cbf:	e8 ac 04 00 00       	call   80105170 <acquire>
80104cc4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cc7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104ccc:	eb 0c                	jmp    80104cda <wakeup+0x2a>
80104cce:	66 90                	xchg   %ax,%ax
80104cd0:	83 c0 7c             	add    $0x7c,%eax
80104cd3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104cd8:	74 1c                	je     80104cf6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80104cda:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104cde:	75 f0                	jne    80104cd0 <wakeup+0x20>
80104ce0:	3b 58 20             	cmp    0x20(%eax),%ebx
80104ce3:	75 eb                	jne    80104cd0 <wakeup+0x20>
      p->state = RUNNABLE;
80104ce5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cec:	83 c0 7c             	add    $0x7c,%eax
80104cef:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104cf4:	75 e4                	jne    80104cda <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104cf6:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
80104cfd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d00:	c9                   	leave
  release(&ptable.lock);
80104d01:	e9 0a 04 00 00       	jmp    80105110 <release>
80104d06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d0d:	00 
80104d0e:	66 90                	xchg   %ax,%ax

80104d10 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	53                   	push   %ebx
80104d14:	83 ec 10             	sub    $0x10,%esp
80104d17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104d1a:	68 40 2d 11 80       	push   $0x80112d40
80104d1f:	e8 4c 04 00 00       	call   80105170 <acquire>
80104d24:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d27:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104d2c:	eb 0c                	jmp    80104d3a <kill+0x2a>
80104d2e:	66 90                	xchg   %ax,%ax
80104d30:	83 c0 7c             	add    $0x7c,%eax
80104d33:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104d38:	74 36                	je     80104d70 <kill+0x60>
    if(p->pid == pid){
80104d3a:	39 58 10             	cmp    %ebx,0x10(%eax)
80104d3d:	75 f1                	jne    80104d30 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104d3f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104d43:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104d4a:	75 07                	jne    80104d53 <kill+0x43>
        p->state = RUNNABLE;
80104d4c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104d53:	83 ec 0c             	sub    $0xc,%esp
80104d56:	68 40 2d 11 80       	push   $0x80112d40
80104d5b:	e8 b0 03 00 00       	call   80105110 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104d60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104d63:	83 c4 10             	add    $0x10,%esp
80104d66:	31 c0                	xor    %eax,%eax
}
80104d68:	c9                   	leave
80104d69:	c3                   	ret
80104d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104d70:	83 ec 0c             	sub    $0xc,%esp
80104d73:	68 40 2d 11 80       	push   $0x80112d40
80104d78:	e8 93 03 00 00       	call   80105110 <release>
}
80104d7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104d80:	83 c4 10             	add    $0x10,%esp
80104d83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d88:	c9                   	leave
80104d89:	c3                   	ret
80104d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d90 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	57                   	push   %edi
80104d94:	56                   	push   %esi
80104d95:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104d98:	53                   	push   %ebx
80104d99:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
80104d9e:	83 ec 3c             	sub    $0x3c,%esp
80104da1:	eb 24                	jmp    80104dc7 <procdump+0x37>
80104da3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104da8:	83 ec 0c             	sub    $0xc,%esp
80104dab:	68 f3 81 10 80       	push   $0x801081f3
80104db0:	e8 6b bb ff ff       	call   80100920 <cprintf>
80104db5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104db8:	83 c3 7c             	add    $0x7c,%ebx
80104dbb:	81 fb e0 4c 11 80    	cmp    $0x80114ce0,%ebx
80104dc1:	0f 84 81 00 00 00    	je     80104e48 <procdump+0xb8>
    if(p->state == UNUSED)
80104dc7:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104dca:	85 c0                	test   %eax,%eax
80104dcc:	74 ea                	je     80104db8 <procdump+0x28>
      state = "???";
80104dce:	ba 45 80 10 80       	mov    $0x80108045,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104dd3:	83 f8 05             	cmp    $0x5,%eax
80104dd6:	77 11                	ja     80104de9 <procdump+0x59>
80104dd8:	8b 14 85 80 86 10 80 	mov    -0x7fef7980(,%eax,4),%edx
      state = "???";
80104ddf:	b8 45 80 10 80       	mov    $0x80108045,%eax
80104de4:	85 d2                	test   %edx,%edx
80104de6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104de9:	53                   	push   %ebx
80104dea:	52                   	push   %edx
80104deb:	ff 73 a4             	push   -0x5c(%ebx)
80104dee:	68 49 80 10 80       	push   $0x80108049
80104df3:	e8 28 bb ff ff       	call   80100920 <cprintf>
    if(p->state == SLEEPING){
80104df8:	83 c4 10             	add    $0x10,%esp
80104dfb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104dff:	75 a7                	jne    80104da8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104e01:	83 ec 08             	sub    $0x8,%esp
80104e04:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104e07:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104e0a:	50                   	push   %eax
80104e0b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104e0e:	8b 40 0c             	mov    0xc(%eax),%eax
80104e11:	83 c0 08             	add    $0x8,%eax
80104e14:	50                   	push   %eax
80104e15:	e8 86 01 00 00       	call   80104fa0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104e1a:	83 c4 10             	add    $0x10,%esp
80104e1d:	8d 76 00             	lea    0x0(%esi),%esi
80104e20:	8b 17                	mov    (%edi),%edx
80104e22:	85 d2                	test   %edx,%edx
80104e24:	74 82                	je     80104da8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104e26:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104e29:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
80104e2c:	52                   	push   %edx
80104e2d:	68 a6 7d 10 80       	push   $0x80107da6
80104e32:	e8 e9 ba ff ff       	call   80100920 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104e37:	83 c4 10             	add    $0x10,%esp
80104e3a:	39 f7                	cmp    %esi,%edi
80104e3c:	75 e2                	jne    80104e20 <procdump+0x90>
80104e3e:	e9 65 ff ff ff       	jmp    80104da8 <procdump+0x18>
80104e43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104e48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e4b:	5b                   	pop    %ebx
80104e4c:	5e                   	pop    %esi
80104e4d:	5f                   	pop    %edi
80104e4e:	5d                   	pop    %ebp
80104e4f:	c3                   	ret

80104e50 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	53                   	push   %ebx
80104e54:	83 ec 0c             	sub    $0xc,%esp
80104e57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104e5a:	68 7c 80 10 80       	push   $0x8010807c
80104e5f:	8d 43 04             	lea    0x4(%ebx),%eax
80104e62:	50                   	push   %eax
80104e63:	e8 18 01 00 00       	call   80104f80 <initlock>
  lk->name = name;
80104e68:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104e6b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104e71:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104e74:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104e7b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104e7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e81:	c9                   	leave
80104e82:	c3                   	ret
80104e83:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e8a:	00 
80104e8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104e90 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	56                   	push   %esi
80104e94:	53                   	push   %ebx
80104e95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e98:	8d 73 04             	lea    0x4(%ebx),%esi
80104e9b:	83 ec 0c             	sub    $0xc,%esp
80104e9e:	56                   	push   %esi
80104e9f:	e8 cc 02 00 00       	call   80105170 <acquire>
  while (lk->locked) {
80104ea4:	8b 13                	mov    (%ebx),%edx
80104ea6:	83 c4 10             	add    $0x10,%esp
80104ea9:	85 d2                	test   %edx,%edx
80104eab:	74 16                	je     80104ec3 <acquiresleep+0x33>
80104ead:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104eb0:	83 ec 08             	sub    $0x8,%esp
80104eb3:	56                   	push   %esi
80104eb4:	53                   	push   %ebx
80104eb5:	e8 36 fd ff ff       	call   80104bf0 <sleep>
  while (lk->locked) {
80104eba:	8b 03                	mov    (%ebx),%eax
80104ebc:	83 c4 10             	add    $0x10,%esp
80104ebf:	85 c0                	test   %eax,%eax
80104ec1:	75 ed                	jne    80104eb0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104ec3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104ec9:	e8 62 f6 ff ff       	call   80104530 <myproc>
80104ece:	8b 40 10             	mov    0x10(%eax),%eax
80104ed1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104ed4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104ed7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eda:	5b                   	pop    %ebx
80104edb:	5e                   	pop    %esi
80104edc:	5d                   	pop    %ebp
  release(&lk->lk);
80104edd:	e9 2e 02 00 00       	jmp    80105110 <release>
80104ee2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ee9:	00 
80104eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ef0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	56                   	push   %esi
80104ef4:	53                   	push   %ebx
80104ef5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ef8:	8d 73 04             	lea    0x4(%ebx),%esi
80104efb:	83 ec 0c             	sub    $0xc,%esp
80104efe:	56                   	push   %esi
80104eff:	e8 6c 02 00 00       	call   80105170 <acquire>
  lk->locked = 0;
80104f04:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104f0a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104f11:	89 1c 24             	mov    %ebx,(%esp)
80104f14:	e8 97 fd ff ff       	call   80104cb0 <wakeup>
  release(&lk->lk);
80104f19:	83 c4 10             	add    $0x10,%esp
80104f1c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104f1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f22:	5b                   	pop    %ebx
80104f23:	5e                   	pop    %esi
80104f24:	5d                   	pop    %ebp
  release(&lk->lk);
80104f25:	e9 e6 01 00 00       	jmp    80105110 <release>
80104f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f30 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	57                   	push   %edi
80104f34:	31 ff                	xor    %edi,%edi
80104f36:	56                   	push   %esi
80104f37:	53                   	push   %ebx
80104f38:	83 ec 18             	sub    $0x18,%esp
80104f3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104f3e:	8d 73 04             	lea    0x4(%ebx),%esi
80104f41:	56                   	push   %esi
80104f42:	e8 29 02 00 00       	call   80105170 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104f47:	8b 03                	mov    (%ebx),%eax
80104f49:	83 c4 10             	add    $0x10,%esp
80104f4c:	85 c0                	test   %eax,%eax
80104f4e:	75 18                	jne    80104f68 <holdingsleep+0x38>
  release(&lk->lk);
80104f50:	83 ec 0c             	sub    $0xc,%esp
80104f53:	56                   	push   %esi
80104f54:	e8 b7 01 00 00       	call   80105110 <release>
  return r;
}
80104f59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f5c:	89 f8                	mov    %edi,%eax
80104f5e:	5b                   	pop    %ebx
80104f5f:	5e                   	pop    %esi
80104f60:	5f                   	pop    %edi
80104f61:	5d                   	pop    %ebp
80104f62:	c3                   	ret
80104f63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104f68:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104f6b:	e8 c0 f5 ff ff       	call   80104530 <myproc>
80104f70:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f73:	0f 94 c0             	sete   %al
80104f76:	0f b6 c0             	movzbl %al,%eax
80104f79:	89 c7                	mov    %eax,%edi
80104f7b:	eb d3                	jmp    80104f50 <holdingsleep+0x20>
80104f7d:	66 90                	xchg   %ax,%ax
80104f7f:	90                   	nop

80104f80 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f86:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f89:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104f8f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104f92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f99:	5d                   	pop    %ebp
80104f9a:	c3                   	ret
80104f9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104fa0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	53                   	push   %ebx
80104fa4:	8b 45 08             	mov    0x8(%ebp),%eax
80104fa7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104faa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104fad:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104fb2:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104fb7:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104fbc:	76 10                	jbe    80104fce <getcallerpcs+0x2e>
80104fbe:	eb 28                	jmp    80104fe8 <getcallerpcs+0x48>
80104fc0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104fc6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104fcc:	77 1a                	ja     80104fe8 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104fce:	8b 5a 04             	mov    0x4(%edx),%ebx
80104fd1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104fd4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104fd7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104fd9:	83 f8 0a             	cmp    $0xa,%eax
80104fdc:	75 e2                	jne    80104fc0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104fde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fe1:	c9                   	leave
80104fe2:	c3                   	ret
80104fe3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fe8:	8d 04 81             	lea    (%ecx,%eax,4),%eax
80104feb:	83 c1 28             	add    $0x28,%ecx
80104fee:	89 ca                	mov    %ecx,%edx
80104ff0:	29 c2                	sub    %eax,%edx
80104ff2:	83 e2 04             	and    $0x4,%edx
80104ff5:	74 11                	je     80105008 <getcallerpcs+0x68>
    pcs[i] = 0;
80104ff7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ffd:	83 c0 04             	add    $0x4,%eax
80105000:	39 c1                	cmp    %eax,%ecx
80105002:	74 da                	je     80104fde <getcallerpcs+0x3e>
80105004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80105008:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010500e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105011:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105018:	39 c1                	cmp    %eax,%ecx
8010501a:	75 ec                	jne    80105008 <getcallerpcs+0x68>
8010501c:	eb c0                	jmp    80104fde <getcallerpcs+0x3e>
8010501e:	66 90                	xchg   %ax,%ax

80105020 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	53                   	push   %ebx
80105024:	83 ec 04             	sub    $0x4,%esp
80105027:	9c                   	pushf
80105028:	5b                   	pop    %ebx
  asm volatile("cli");
80105029:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010502a:	e8 81 f4 ff ff       	call   801044b0 <mycpu>
8010502f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105035:	85 c0                	test   %eax,%eax
80105037:	74 17                	je     80105050 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105039:	e8 72 f4 ff ff       	call   801044b0 <mycpu>
8010503e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105045:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105048:	c9                   	leave
80105049:	c3                   	ret
8010504a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105050:	e8 5b f4 ff ff       	call   801044b0 <mycpu>
80105055:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010505b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105061:	eb d6                	jmp    80105039 <pushcli+0x19>
80105063:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010506a:	00 
8010506b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105070 <popcli>:

void
popcli(void)
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105076:	9c                   	pushf
80105077:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105078:	f6 c4 02             	test   $0x2,%ah
8010507b:	75 35                	jne    801050b2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010507d:	e8 2e f4 ff ff       	call   801044b0 <mycpu>
80105082:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105089:	78 34                	js     801050bf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010508b:	e8 20 f4 ff ff       	call   801044b0 <mycpu>
80105090:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105096:	85 d2                	test   %edx,%edx
80105098:	74 06                	je     801050a0 <popcli+0x30>
    sti();
}
8010509a:	c9                   	leave
8010509b:	c3                   	ret
8010509c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801050a0:	e8 0b f4 ff ff       	call   801044b0 <mycpu>
801050a5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801050ab:	85 c0                	test   %eax,%eax
801050ad:	74 eb                	je     8010509a <popcli+0x2a>
  asm volatile("sti");
801050af:	fb                   	sti
}
801050b0:	c9                   	leave
801050b1:	c3                   	ret
    panic("popcli - interruptible");
801050b2:	83 ec 0c             	sub    $0xc,%esp
801050b5:	68 87 80 10 80       	push   $0x80108087
801050ba:	e8 b1 ba ff ff       	call   80100b70 <panic>
    panic("popcli");
801050bf:	83 ec 0c             	sub    $0xc,%esp
801050c2:	68 9e 80 10 80       	push   $0x8010809e
801050c7:	e8 a4 ba ff ff       	call   80100b70 <panic>
801050cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050d0 <holding>:
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	56                   	push   %esi
801050d4:	53                   	push   %ebx
801050d5:	8b 75 08             	mov    0x8(%ebp),%esi
801050d8:	31 db                	xor    %ebx,%ebx
  pushcli();
801050da:	e8 41 ff ff ff       	call   80105020 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801050df:	8b 06                	mov    (%esi),%eax
801050e1:	85 c0                	test   %eax,%eax
801050e3:	75 0b                	jne    801050f0 <holding+0x20>
  popcli();
801050e5:	e8 86 ff ff ff       	call   80105070 <popcli>
}
801050ea:	89 d8                	mov    %ebx,%eax
801050ec:	5b                   	pop    %ebx
801050ed:	5e                   	pop    %esi
801050ee:	5d                   	pop    %ebp
801050ef:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
801050f0:	8b 5e 08             	mov    0x8(%esi),%ebx
801050f3:	e8 b8 f3 ff ff       	call   801044b0 <mycpu>
801050f8:	39 c3                	cmp    %eax,%ebx
801050fa:	0f 94 c3             	sete   %bl
  popcli();
801050fd:	e8 6e ff ff ff       	call   80105070 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105102:	0f b6 db             	movzbl %bl,%ebx
}
80105105:	89 d8                	mov    %ebx,%eax
80105107:	5b                   	pop    %ebx
80105108:	5e                   	pop    %esi
80105109:	5d                   	pop    %ebp
8010510a:	c3                   	ret
8010510b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105110 <release>:
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	53                   	push   %ebx
80105115:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105118:	e8 03 ff ff ff       	call   80105020 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010511d:	8b 03                	mov    (%ebx),%eax
8010511f:	85 c0                	test   %eax,%eax
80105121:	75 15                	jne    80105138 <release+0x28>
  popcli();
80105123:	e8 48 ff ff ff       	call   80105070 <popcli>
    panic("release");
80105128:	83 ec 0c             	sub    $0xc,%esp
8010512b:	68 a5 80 10 80       	push   $0x801080a5
80105130:	e8 3b ba ff ff       	call   80100b70 <panic>
80105135:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105138:	8b 73 08             	mov    0x8(%ebx),%esi
8010513b:	e8 70 f3 ff ff       	call   801044b0 <mycpu>
80105140:	39 c6                	cmp    %eax,%esi
80105142:	75 df                	jne    80105123 <release+0x13>
  popcli();
80105144:	e8 27 ff ff ff       	call   80105070 <popcli>
  lk->pcs[0] = 0;
80105149:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105150:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105157:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010515c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105162:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105165:	5b                   	pop    %ebx
80105166:	5e                   	pop    %esi
80105167:	5d                   	pop    %ebp
  popcli();
80105168:	e9 03 ff ff ff       	jmp    80105070 <popcli>
8010516d:	8d 76 00             	lea    0x0(%esi),%esi

80105170 <acquire>:
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	53                   	push   %ebx
80105174:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105177:	e8 a4 fe ff ff       	call   80105020 <pushcli>
  if(holding(lk))
8010517c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010517f:	e8 9c fe ff ff       	call   80105020 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105184:	8b 03                	mov    (%ebx),%eax
80105186:	85 c0                	test   %eax,%eax
80105188:	0f 85 b2 00 00 00    	jne    80105240 <acquire+0xd0>
  popcli();
8010518e:	e8 dd fe ff ff       	call   80105070 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80105193:	b9 01 00 00 00       	mov    $0x1,%ecx
80105198:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010519f:	00 
  while(xchg(&lk->locked, 1) != 0)
801051a0:	8b 55 08             	mov    0x8(%ebp),%edx
801051a3:	89 c8                	mov    %ecx,%eax
801051a5:	f0 87 02             	lock xchg %eax,(%edx)
801051a8:	85 c0                	test   %eax,%eax
801051aa:	75 f4                	jne    801051a0 <acquire+0x30>
  __sync_synchronize();
801051ac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801051b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801051b4:	e8 f7 f2 ff ff       	call   801044b0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801051b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
801051bc:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
801051be:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051c1:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
801051c7:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
801051cc:	77 32                	ja     80105200 <acquire+0x90>
  ebp = (uint*)v - 2;
801051ce:	89 e8                	mov    %ebp,%eax
801051d0:	eb 14                	jmp    801051e6 <acquire+0x76>
801051d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051d8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801051de:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801051e4:	77 1a                	ja     80105200 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
801051e6:	8b 58 04             	mov    0x4(%eax),%ebx
801051e9:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801051ed:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801051f0:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801051f2:	83 fa 0a             	cmp    $0xa,%edx
801051f5:	75 e1                	jne    801051d8 <acquire+0x68>
}
801051f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051fa:	c9                   	leave
801051fb:	c3                   	ret
801051fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105200:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80105204:	83 c1 34             	add    $0x34,%ecx
80105207:	89 ca                	mov    %ecx,%edx
80105209:	29 c2                	sub    %eax,%edx
8010520b:	83 e2 04             	and    $0x4,%edx
8010520e:	74 10                	je     80105220 <acquire+0xb0>
    pcs[i] = 0;
80105210:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105216:	83 c0 04             	add    $0x4,%eax
80105219:	39 c1                	cmp    %eax,%ecx
8010521b:	74 da                	je     801051f7 <acquire+0x87>
8010521d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80105220:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105226:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105229:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105230:	39 c1                	cmp    %eax,%ecx
80105232:	75 ec                	jne    80105220 <acquire+0xb0>
80105234:	eb c1                	jmp    801051f7 <acquire+0x87>
80105236:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010523d:	00 
8010523e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80105240:	8b 5b 08             	mov    0x8(%ebx),%ebx
80105243:	e8 68 f2 ff ff       	call   801044b0 <mycpu>
80105248:	39 c3                	cmp    %eax,%ebx
8010524a:	0f 85 3e ff ff ff    	jne    8010518e <acquire+0x1e>
  popcli();
80105250:	e8 1b fe ff ff       	call   80105070 <popcli>
    panic("acquire");
80105255:	83 ec 0c             	sub    $0xc,%esp
80105258:	68 ad 80 10 80       	push   $0x801080ad
8010525d:	e8 0e b9 ff ff       	call   80100b70 <panic>
80105262:	66 90                	xchg   %ax,%ax
80105264:	66 90                	xchg   %ax,%ax
80105266:	66 90                	xchg   %ax,%ax
80105268:	66 90                	xchg   %ax,%ax
8010526a:	66 90                	xchg   %ax,%ax
8010526c:	66 90                	xchg   %ax,%ax
8010526e:	66 90                	xchg   %ax,%ax

80105270 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	57                   	push   %edi
80105274:	8b 55 08             	mov    0x8(%ebp),%edx
80105277:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010527a:	89 d0                	mov    %edx,%eax
8010527c:	09 c8                	or     %ecx,%eax
8010527e:	a8 03                	test   $0x3,%al
80105280:	75 1e                	jne    801052a0 <memset+0x30>
    c &= 0xFF;
80105282:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105286:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80105289:	89 d7                	mov    %edx,%edi
8010528b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80105291:	fc                   	cld
80105292:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105294:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105297:	89 d0                	mov    %edx,%eax
80105299:	c9                   	leave
8010529a:	c3                   	ret
8010529b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801052a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801052a3:	89 d7                	mov    %edx,%edi
801052a5:	fc                   	cld
801052a6:	f3 aa                	rep stos %al,%es:(%edi)
801052a8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801052ab:	89 d0                	mov    %edx,%eax
801052ad:	c9                   	leave
801052ae:	c3                   	ret
801052af:	90                   	nop

801052b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	56                   	push   %esi
801052b4:	8b 75 10             	mov    0x10(%ebp),%esi
801052b7:	8b 45 08             	mov    0x8(%ebp),%eax
801052ba:	53                   	push   %ebx
801052bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801052be:	85 f6                	test   %esi,%esi
801052c0:	74 2e                	je     801052f0 <memcmp+0x40>
801052c2:	01 c6                	add    %eax,%esi
801052c4:	eb 14                	jmp    801052da <memcmp+0x2a>
801052c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052cd:	00 
801052ce:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801052d0:	83 c0 01             	add    $0x1,%eax
801052d3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801052d6:	39 f0                	cmp    %esi,%eax
801052d8:	74 16                	je     801052f0 <memcmp+0x40>
    if(*s1 != *s2)
801052da:	0f b6 08             	movzbl (%eax),%ecx
801052dd:	0f b6 1a             	movzbl (%edx),%ebx
801052e0:	38 d9                	cmp    %bl,%cl
801052e2:	74 ec                	je     801052d0 <memcmp+0x20>
      return *s1 - *s2;
801052e4:	0f b6 c1             	movzbl %cl,%eax
801052e7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801052e9:	5b                   	pop    %ebx
801052ea:	5e                   	pop    %esi
801052eb:	5d                   	pop    %ebp
801052ec:	c3                   	ret
801052ed:	8d 76 00             	lea    0x0(%esi),%esi
801052f0:	5b                   	pop    %ebx
  return 0;
801052f1:	31 c0                	xor    %eax,%eax
}
801052f3:	5e                   	pop    %esi
801052f4:	5d                   	pop    %ebp
801052f5:	c3                   	ret
801052f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052fd:	00 
801052fe:	66 90                	xchg   %ax,%ax

80105300 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	57                   	push   %edi
80105304:	8b 55 08             	mov    0x8(%ebp),%edx
80105307:	8b 45 10             	mov    0x10(%ebp),%eax
8010530a:	56                   	push   %esi
8010530b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010530e:	39 d6                	cmp    %edx,%esi
80105310:	73 26                	jae    80105338 <memmove+0x38>
80105312:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80105315:	39 ca                	cmp    %ecx,%edx
80105317:	73 1f                	jae    80105338 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105319:	85 c0                	test   %eax,%eax
8010531b:	74 0f                	je     8010532c <memmove+0x2c>
8010531d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80105320:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105324:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105327:	83 e8 01             	sub    $0x1,%eax
8010532a:	73 f4                	jae    80105320 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010532c:	5e                   	pop    %esi
8010532d:	89 d0                	mov    %edx,%eax
8010532f:	5f                   	pop    %edi
80105330:	5d                   	pop    %ebp
80105331:	c3                   	ret
80105332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80105338:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010533b:	89 d7                	mov    %edx,%edi
8010533d:	85 c0                	test   %eax,%eax
8010533f:	74 eb                	je     8010532c <memmove+0x2c>
80105341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105348:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105349:	39 ce                	cmp    %ecx,%esi
8010534b:	75 fb                	jne    80105348 <memmove+0x48>
}
8010534d:	5e                   	pop    %esi
8010534e:	89 d0                	mov    %edx,%eax
80105350:	5f                   	pop    %edi
80105351:	5d                   	pop    %ebp
80105352:	c3                   	ret
80105353:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010535a:	00 
8010535b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105360 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105360:	eb 9e                	jmp    80105300 <memmove>
80105362:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105369:	00 
8010536a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105370 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	53                   	push   %ebx
80105374:	8b 55 10             	mov    0x10(%ebp),%edx
80105377:	8b 45 08             	mov    0x8(%ebp),%eax
8010537a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
8010537d:	85 d2                	test   %edx,%edx
8010537f:	75 16                	jne    80105397 <strncmp+0x27>
80105381:	eb 2d                	jmp    801053b0 <strncmp+0x40>
80105383:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105388:	3a 19                	cmp    (%ecx),%bl
8010538a:	75 12                	jne    8010539e <strncmp+0x2e>
    n--, p++, q++;
8010538c:	83 c0 01             	add    $0x1,%eax
8010538f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80105392:	83 ea 01             	sub    $0x1,%edx
80105395:	74 19                	je     801053b0 <strncmp+0x40>
80105397:	0f b6 18             	movzbl (%eax),%ebx
8010539a:	84 db                	test   %bl,%bl
8010539c:	75 ea                	jne    80105388 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010539e:	0f b6 00             	movzbl (%eax),%eax
801053a1:	0f b6 11             	movzbl (%ecx),%edx
}
801053a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053a7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
801053a8:	29 d0                	sub    %edx,%eax
}
801053aa:	c3                   	ret
801053ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801053b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801053b3:	31 c0                	xor    %eax,%eax
}
801053b5:	c9                   	leave
801053b6:	c3                   	ret
801053b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053be:	00 
801053bf:	90                   	nop

801053c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	57                   	push   %edi
801053c4:	56                   	push   %esi
801053c5:	8b 75 08             	mov    0x8(%ebp),%esi
801053c8:	53                   	push   %ebx
801053c9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801053cc:	89 f0                	mov    %esi,%eax
801053ce:	eb 15                	jmp    801053e5 <strncpy+0x25>
801053d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801053d4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801053d7:	83 c0 01             	add    $0x1,%eax
801053da:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
801053de:	88 48 ff             	mov    %cl,-0x1(%eax)
801053e1:	84 c9                	test   %cl,%cl
801053e3:	74 13                	je     801053f8 <strncpy+0x38>
801053e5:	89 d3                	mov    %edx,%ebx
801053e7:	83 ea 01             	sub    $0x1,%edx
801053ea:	85 db                	test   %ebx,%ebx
801053ec:	7f e2                	jg     801053d0 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
801053ee:	5b                   	pop    %ebx
801053ef:	89 f0                	mov    %esi,%eax
801053f1:	5e                   	pop    %esi
801053f2:	5f                   	pop    %edi
801053f3:	5d                   	pop    %ebp
801053f4:	c3                   	ret
801053f5:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
801053f8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801053fb:	83 e9 01             	sub    $0x1,%ecx
801053fe:	85 d2                	test   %edx,%edx
80105400:	74 ec                	je     801053ee <strncpy+0x2e>
80105402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80105408:	83 c0 01             	add    $0x1,%eax
8010540b:	89 ca                	mov    %ecx,%edx
8010540d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80105411:	29 c2                	sub    %eax,%edx
80105413:	85 d2                	test   %edx,%edx
80105415:	7f f1                	jg     80105408 <strncpy+0x48>
}
80105417:	5b                   	pop    %ebx
80105418:	89 f0                	mov    %esi,%eax
8010541a:	5e                   	pop    %esi
8010541b:	5f                   	pop    %edi
8010541c:	5d                   	pop    %ebp
8010541d:	c3                   	ret
8010541e:	66 90                	xchg   %ax,%ax

80105420 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	56                   	push   %esi
80105424:	8b 55 10             	mov    0x10(%ebp),%edx
80105427:	8b 75 08             	mov    0x8(%ebp),%esi
8010542a:	53                   	push   %ebx
8010542b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010542e:	85 d2                	test   %edx,%edx
80105430:	7e 25                	jle    80105457 <safestrcpy+0x37>
80105432:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105436:	89 f2                	mov    %esi,%edx
80105438:	eb 16                	jmp    80105450 <safestrcpy+0x30>
8010543a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105440:	0f b6 08             	movzbl (%eax),%ecx
80105443:	83 c0 01             	add    $0x1,%eax
80105446:	83 c2 01             	add    $0x1,%edx
80105449:	88 4a ff             	mov    %cl,-0x1(%edx)
8010544c:	84 c9                	test   %cl,%cl
8010544e:	74 04                	je     80105454 <safestrcpy+0x34>
80105450:	39 d8                	cmp    %ebx,%eax
80105452:	75 ec                	jne    80105440 <safestrcpy+0x20>
    ;
  *s = 0;
80105454:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105457:	89 f0                	mov    %esi,%eax
80105459:	5b                   	pop    %ebx
8010545a:	5e                   	pop    %esi
8010545b:	5d                   	pop    %ebp
8010545c:	c3                   	ret
8010545d:	8d 76 00             	lea    0x0(%esi),%esi

80105460 <strlen>:

int
strlen(const char *s)
{
80105460:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105461:	31 c0                	xor    %eax,%eax
{
80105463:	89 e5                	mov    %esp,%ebp
80105465:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105468:	80 3a 00             	cmpb   $0x0,(%edx)
8010546b:	74 0c                	je     80105479 <strlen+0x19>
8010546d:	8d 76 00             	lea    0x0(%esi),%esi
80105470:	83 c0 01             	add    $0x1,%eax
80105473:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105477:	75 f7                	jne    80105470 <strlen+0x10>
    ;
  return n;
}
80105479:	5d                   	pop    %ebp
8010547a:	c3                   	ret

8010547b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010547b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010547f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105483:	55                   	push   %ebp
  pushl %ebx
80105484:	53                   	push   %ebx
  pushl %esi
80105485:	56                   	push   %esi
  pushl %edi
80105486:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105487:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105489:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010548b:	5f                   	pop    %edi
  popl %esi
8010548c:	5e                   	pop    %esi
  popl %ebx
8010548d:	5b                   	pop    %ebx
  popl %ebp
8010548e:	5d                   	pop    %ebp
  ret
8010548f:	c3                   	ret

80105490 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105490:	55                   	push   %ebp
80105491:	89 e5                	mov    %esp,%ebp
80105493:	53                   	push   %ebx
80105494:	83 ec 04             	sub    $0x4,%esp
80105497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010549a:	e8 91 f0 ff ff       	call   80104530 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010549f:	8b 00                	mov    (%eax),%eax
801054a1:	39 c3                	cmp    %eax,%ebx
801054a3:	73 1b                	jae    801054c0 <fetchint+0x30>
801054a5:	8d 53 04             	lea    0x4(%ebx),%edx
801054a8:	39 d0                	cmp    %edx,%eax
801054aa:	72 14                	jb     801054c0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801054ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801054af:	8b 13                	mov    (%ebx),%edx
801054b1:	89 10                	mov    %edx,(%eax)
  return 0;
801054b3:	31 c0                	xor    %eax,%eax
}
801054b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054b8:	c9                   	leave
801054b9:	c3                   	ret
801054ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801054c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054c5:	eb ee                	jmp    801054b5 <fetchint+0x25>
801054c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054ce:	00 
801054cf:	90                   	nop

801054d0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	53                   	push   %ebx
801054d4:	83 ec 04             	sub    $0x4,%esp
801054d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801054da:	e8 51 f0 ff ff       	call   80104530 <myproc>

  if(addr >= curproc->sz)
801054df:	3b 18                	cmp    (%eax),%ebx
801054e1:	73 2d                	jae    80105510 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801054e3:	8b 55 0c             	mov    0xc(%ebp),%edx
801054e6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801054e8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801054ea:	39 d3                	cmp    %edx,%ebx
801054ec:	73 22                	jae    80105510 <fetchstr+0x40>
801054ee:	89 d8                	mov    %ebx,%eax
801054f0:	eb 0d                	jmp    801054ff <fetchstr+0x2f>
801054f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054f8:	83 c0 01             	add    $0x1,%eax
801054fb:	39 d0                	cmp    %edx,%eax
801054fd:	73 11                	jae    80105510 <fetchstr+0x40>
    if(*s == 0)
801054ff:	80 38 00             	cmpb   $0x0,(%eax)
80105502:	75 f4                	jne    801054f8 <fetchstr+0x28>
      return s - *pp;
80105504:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105506:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105509:	c9                   	leave
8010550a:	c3                   	ret
8010550b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105510:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105513:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105518:	c9                   	leave
80105519:	c3                   	ret
8010551a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105520 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	56                   	push   %esi
80105524:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105525:	e8 06 f0 ff ff       	call   80104530 <myproc>
8010552a:	8b 55 08             	mov    0x8(%ebp),%edx
8010552d:	8b 40 18             	mov    0x18(%eax),%eax
80105530:	8b 40 44             	mov    0x44(%eax),%eax
80105533:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105536:	e8 f5 ef ff ff       	call   80104530 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010553b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010553e:	8b 00                	mov    (%eax),%eax
80105540:	39 c6                	cmp    %eax,%esi
80105542:	73 1c                	jae    80105560 <argint+0x40>
80105544:	8d 53 08             	lea    0x8(%ebx),%edx
80105547:	39 d0                	cmp    %edx,%eax
80105549:	72 15                	jb     80105560 <argint+0x40>
  *ip = *(int*)(addr);
8010554b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010554e:	8b 53 04             	mov    0x4(%ebx),%edx
80105551:	89 10                	mov    %edx,(%eax)
  return 0;
80105553:	31 c0                	xor    %eax,%eax
}
80105555:	5b                   	pop    %ebx
80105556:	5e                   	pop    %esi
80105557:	5d                   	pop    %ebp
80105558:	c3                   	ret
80105559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105560:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105565:	eb ee                	jmp    80105555 <argint+0x35>
80105567:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010556e:	00 
8010556f:	90                   	nop

80105570 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	57                   	push   %edi
80105574:	56                   	push   %esi
80105575:	53                   	push   %ebx
80105576:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105579:	e8 b2 ef ff ff       	call   80104530 <myproc>
8010557e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105580:	e8 ab ef ff ff       	call   80104530 <myproc>
80105585:	8b 55 08             	mov    0x8(%ebp),%edx
80105588:	8b 40 18             	mov    0x18(%eax),%eax
8010558b:	8b 40 44             	mov    0x44(%eax),%eax
8010558e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105591:	e8 9a ef ff ff       	call   80104530 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105596:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105599:	8b 00                	mov    (%eax),%eax
8010559b:	39 c7                	cmp    %eax,%edi
8010559d:	73 31                	jae    801055d0 <argptr+0x60>
8010559f:	8d 4b 08             	lea    0x8(%ebx),%ecx
801055a2:	39 c8                	cmp    %ecx,%eax
801055a4:	72 2a                	jb     801055d0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801055a6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
801055a9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801055ac:	85 d2                	test   %edx,%edx
801055ae:	78 20                	js     801055d0 <argptr+0x60>
801055b0:	8b 16                	mov    (%esi),%edx
801055b2:	39 d0                	cmp    %edx,%eax
801055b4:	73 1a                	jae    801055d0 <argptr+0x60>
801055b6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801055b9:	01 c3                	add    %eax,%ebx
801055bb:	39 da                	cmp    %ebx,%edx
801055bd:	72 11                	jb     801055d0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
801055bf:	8b 55 0c             	mov    0xc(%ebp),%edx
801055c2:	89 02                	mov    %eax,(%edx)
  return 0;
801055c4:	31 c0                	xor    %eax,%eax
}
801055c6:	83 c4 0c             	add    $0xc,%esp
801055c9:	5b                   	pop    %ebx
801055ca:	5e                   	pop    %esi
801055cb:	5f                   	pop    %edi
801055cc:	5d                   	pop    %ebp
801055cd:	c3                   	ret
801055ce:	66 90                	xchg   %ax,%ax
    return -1;
801055d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055d5:	eb ef                	jmp    801055c6 <argptr+0x56>
801055d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055de:	00 
801055df:	90                   	nop

801055e0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	56                   	push   %esi
801055e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801055e5:	e8 46 ef ff ff       	call   80104530 <myproc>
801055ea:	8b 55 08             	mov    0x8(%ebp),%edx
801055ed:	8b 40 18             	mov    0x18(%eax),%eax
801055f0:	8b 40 44             	mov    0x44(%eax),%eax
801055f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801055f6:	e8 35 ef ff ff       	call   80104530 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801055fb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801055fe:	8b 00                	mov    (%eax),%eax
80105600:	39 c6                	cmp    %eax,%esi
80105602:	73 44                	jae    80105648 <argstr+0x68>
80105604:	8d 53 08             	lea    0x8(%ebx),%edx
80105607:	39 d0                	cmp    %edx,%eax
80105609:	72 3d                	jb     80105648 <argstr+0x68>
  *ip = *(int*)(addr);
8010560b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010560e:	e8 1d ef ff ff       	call   80104530 <myproc>
  if(addr >= curproc->sz)
80105613:	3b 18                	cmp    (%eax),%ebx
80105615:	73 31                	jae    80105648 <argstr+0x68>
  *pp = (char*)addr;
80105617:	8b 55 0c             	mov    0xc(%ebp),%edx
8010561a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010561c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010561e:	39 d3                	cmp    %edx,%ebx
80105620:	73 26                	jae    80105648 <argstr+0x68>
80105622:	89 d8                	mov    %ebx,%eax
80105624:	eb 11                	jmp    80105637 <argstr+0x57>
80105626:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010562d:	00 
8010562e:	66 90                	xchg   %ax,%ax
80105630:	83 c0 01             	add    $0x1,%eax
80105633:	39 d0                	cmp    %edx,%eax
80105635:	73 11                	jae    80105648 <argstr+0x68>
    if(*s == 0)
80105637:	80 38 00             	cmpb   $0x0,(%eax)
8010563a:	75 f4                	jne    80105630 <argstr+0x50>
      return s - *pp;
8010563c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010563e:	5b                   	pop    %ebx
8010563f:	5e                   	pop    %esi
80105640:	5d                   	pop    %ebp
80105641:	c3                   	ret
80105642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105648:	5b                   	pop    %ebx
    return -1;
80105649:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010564e:	5e                   	pop    %esi
8010564f:	5d                   	pop    %ebp
80105650:	c3                   	ret
80105651:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105658:	00 
80105659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105660 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	53                   	push   %ebx
80105664:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105667:	e8 c4 ee ff ff       	call   80104530 <myproc>
8010566c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010566e:	8b 40 18             	mov    0x18(%eax),%eax
80105671:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105674:	8d 50 ff             	lea    -0x1(%eax),%edx
80105677:	83 fa 14             	cmp    $0x14,%edx
8010567a:	77 24                	ja     801056a0 <syscall+0x40>
8010567c:	8b 14 85 a0 86 10 80 	mov    -0x7fef7960(,%eax,4),%edx
80105683:	85 d2                	test   %edx,%edx
80105685:	74 19                	je     801056a0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105687:	ff d2                	call   *%edx
80105689:	89 c2                	mov    %eax,%edx
8010568b:	8b 43 18             	mov    0x18(%ebx),%eax
8010568e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105691:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105694:	c9                   	leave
80105695:	c3                   	ret
80105696:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010569d:	00 
8010569e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
801056a0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801056a1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801056a4:	50                   	push   %eax
801056a5:	ff 73 10             	push   0x10(%ebx)
801056a8:	68 b5 80 10 80       	push   $0x801080b5
801056ad:	e8 6e b2 ff ff       	call   80100920 <cprintf>
    curproc->tf->eax = -1;
801056b2:	8b 43 18             	mov    0x18(%ebx),%eax
801056b5:	83 c4 10             	add    $0x10,%esp
801056b8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801056bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056c2:	c9                   	leave
801056c3:	c3                   	ret
801056c4:	66 90                	xchg   %ax,%ax
801056c6:	66 90                	xchg   %ax,%ax
801056c8:	66 90                	xchg   %ax,%ax
801056ca:	66 90                	xchg   %ax,%ax
801056cc:	66 90                	xchg   %ax,%ax
801056ce:	66 90                	xchg   %ax,%ax

801056d0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	57                   	push   %edi
801056d4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801056d5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801056d8:	53                   	push   %ebx
801056d9:	83 ec 34             	sub    $0x34,%esp
801056dc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801056df:	8b 4d 08             	mov    0x8(%ebp),%ecx
801056e2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801056e5:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801056e8:	57                   	push   %edi
801056e9:	50                   	push   %eax
801056ea:	e8 81 d5 ff ff       	call   80102c70 <nameiparent>
801056ef:	83 c4 10             	add    $0x10,%esp
801056f2:	85 c0                	test   %eax,%eax
801056f4:	74 5e                	je     80105754 <create+0x84>
    return 0;
  ilock(dp);
801056f6:	83 ec 0c             	sub    $0xc,%esp
801056f9:	89 c3                	mov    %eax,%ebx
801056fb:	50                   	push   %eax
801056fc:	e8 6f cc ff ff       	call   80102370 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105701:	83 c4 0c             	add    $0xc,%esp
80105704:	6a 00                	push   $0x0
80105706:	57                   	push   %edi
80105707:	53                   	push   %ebx
80105708:	e8 b3 d1 ff ff       	call   801028c0 <dirlookup>
8010570d:	83 c4 10             	add    $0x10,%esp
80105710:	89 c6                	mov    %eax,%esi
80105712:	85 c0                	test   %eax,%eax
80105714:	74 4a                	je     80105760 <create+0x90>
    iunlockput(dp);
80105716:	83 ec 0c             	sub    $0xc,%esp
80105719:	53                   	push   %ebx
8010571a:	e8 e1 ce ff ff       	call   80102600 <iunlockput>
    ilock(ip);
8010571f:	89 34 24             	mov    %esi,(%esp)
80105722:	e8 49 cc ff ff       	call   80102370 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105727:	83 c4 10             	add    $0x10,%esp
8010572a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010572f:	75 17                	jne    80105748 <create+0x78>
80105731:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105736:	75 10                	jne    80105748 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105738:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010573b:	89 f0                	mov    %esi,%eax
8010573d:	5b                   	pop    %ebx
8010573e:	5e                   	pop    %esi
8010573f:	5f                   	pop    %edi
80105740:	5d                   	pop    %ebp
80105741:	c3                   	ret
80105742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105748:	83 ec 0c             	sub    $0xc,%esp
8010574b:	56                   	push   %esi
8010574c:	e8 af ce ff ff       	call   80102600 <iunlockput>
    return 0;
80105751:	83 c4 10             	add    $0x10,%esp
}
80105754:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105757:	31 f6                	xor    %esi,%esi
}
80105759:	5b                   	pop    %ebx
8010575a:	89 f0                	mov    %esi,%eax
8010575c:	5e                   	pop    %esi
8010575d:	5f                   	pop    %edi
8010575e:	5d                   	pop    %ebp
8010575f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80105760:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105764:	83 ec 08             	sub    $0x8,%esp
80105767:	50                   	push   %eax
80105768:	ff 33                	push   (%ebx)
8010576a:	e8 91 ca ff ff       	call   80102200 <ialloc>
8010576f:	83 c4 10             	add    $0x10,%esp
80105772:	89 c6                	mov    %eax,%esi
80105774:	85 c0                	test   %eax,%eax
80105776:	0f 84 bc 00 00 00    	je     80105838 <create+0x168>
  ilock(ip);
8010577c:	83 ec 0c             	sub    $0xc,%esp
8010577f:	50                   	push   %eax
80105780:	e8 eb cb ff ff       	call   80102370 <ilock>
  ip->major = major;
80105785:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105789:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010578d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105791:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105795:	b8 01 00 00 00       	mov    $0x1,%eax
8010579a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010579e:	89 34 24             	mov    %esi,(%esp)
801057a1:	e8 1a cb ff ff       	call   801022c0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801057a6:	83 c4 10             	add    $0x10,%esp
801057a9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801057ae:	74 30                	je     801057e0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
801057b0:	83 ec 04             	sub    $0x4,%esp
801057b3:	ff 76 04             	push   0x4(%esi)
801057b6:	57                   	push   %edi
801057b7:	53                   	push   %ebx
801057b8:	e8 d3 d3 ff ff       	call   80102b90 <dirlink>
801057bd:	83 c4 10             	add    $0x10,%esp
801057c0:	85 c0                	test   %eax,%eax
801057c2:	78 67                	js     8010582b <create+0x15b>
  iunlockput(dp);
801057c4:	83 ec 0c             	sub    $0xc,%esp
801057c7:	53                   	push   %ebx
801057c8:	e8 33 ce ff ff       	call   80102600 <iunlockput>
  return ip;
801057cd:	83 c4 10             	add    $0x10,%esp
}
801057d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057d3:	89 f0                	mov    %esi,%eax
801057d5:	5b                   	pop    %ebx
801057d6:	5e                   	pop    %esi
801057d7:	5f                   	pop    %edi
801057d8:	5d                   	pop    %ebp
801057d9:	c3                   	ret
801057da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801057e0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801057e3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801057e8:	53                   	push   %ebx
801057e9:	e8 d2 ca ff ff       	call   801022c0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801057ee:	83 c4 0c             	add    $0xc,%esp
801057f1:	ff 76 04             	push   0x4(%esi)
801057f4:	68 ed 80 10 80       	push   $0x801080ed
801057f9:	56                   	push   %esi
801057fa:	e8 91 d3 ff ff       	call   80102b90 <dirlink>
801057ff:	83 c4 10             	add    $0x10,%esp
80105802:	85 c0                	test   %eax,%eax
80105804:	78 18                	js     8010581e <create+0x14e>
80105806:	83 ec 04             	sub    $0x4,%esp
80105809:	ff 73 04             	push   0x4(%ebx)
8010580c:	68 ec 80 10 80       	push   $0x801080ec
80105811:	56                   	push   %esi
80105812:	e8 79 d3 ff ff       	call   80102b90 <dirlink>
80105817:	83 c4 10             	add    $0x10,%esp
8010581a:	85 c0                	test   %eax,%eax
8010581c:	79 92                	jns    801057b0 <create+0xe0>
      panic("create dots");
8010581e:	83 ec 0c             	sub    $0xc,%esp
80105821:	68 e0 80 10 80       	push   $0x801080e0
80105826:	e8 45 b3 ff ff       	call   80100b70 <panic>
    panic("create: dirlink");
8010582b:	83 ec 0c             	sub    $0xc,%esp
8010582e:	68 ef 80 10 80       	push   $0x801080ef
80105833:	e8 38 b3 ff ff       	call   80100b70 <panic>
    panic("create: ialloc");
80105838:	83 ec 0c             	sub    $0xc,%esp
8010583b:	68 d1 80 10 80       	push   $0x801080d1
80105840:	e8 2b b3 ff ff       	call   80100b70 <panic>
80105845:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010584c:	00 
8010584d:	8d 76 00             	lea    0x0(%esi),%esi

80105850 <sys_dup>:
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	56                   	push   %esi
80105854:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105855:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105858:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010585b:	50                   	push   %eax
8010585c:	6a 00                	push   $0x0
8010585e:	e8 bd fc ff ff       	call   80105520 <argint>
80105863:	83 c4 10             	add    $0x10,%esp
80105866:	85 c0                	test   %eax,%eax
80105868:	78 36                	js     801058a0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010586a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010586e:	77 30                	ja     801058a0 <sys_dup+0x50>
80105870:	e8 bb ec ff ff       	call   80104530 <myproc>
80105875:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105878:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010587c:	85 f6                	test   %esi,%esi
8010587e:	74 20                	je     801058a0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105880:	e8 ab ec ff ff       	call   80104530 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105885:	31 db                	xor    %ebx,%ebx
80105887:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010588e:	00 
8010588f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105890:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105894:	85 d2                	test   %edx,%edx
80105896:	74 18                	je     801058b0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105898:	83 c3 01             	add    $0x1,%ebx
8010589b:	83 fb 10             	cmp    $0x10,%ebx
8010589e:	75 f0                	jne    80105890 <sys_dup+0x40>
}
801058a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801058a3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801058a8:	89 d8                	mov    %ebx,%eax
801058aa:	5b                   	pop    %ebx
801058ab:	5e                   	pop    %esi
801058ac:	5d                   	pop    %ebp
801058ad:	c3                   	ret
801058ae:	66 90                	xchg   %ax,%ax
  filedup(f);
801058b0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801058b3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801058b7:	56                   	push   %esi
801058b8:	e8 d3 c1 ff ff       	call   80101a90 <filedup>
  return fd;
801058bd:	83 c4 10             	add    $0x10,%esp
}
801058c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801058c3:	89 d8                	mov    %ebx,%eax
801058c5:	5b                   	pop    %ebx
801058c6:	5e                   	pop    %esi
801058c7:	5d                   	pop    %ebp
801058c8:	c3                   	ret
801058c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058d0 <sys_read>:
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	56                   	push   %esi
801058d4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801058d5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801058d8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801058db:	53                   	push   %ebx
801058dc:	6a 00                	push   $0x0
801058de:	e8 3d fc ff ff       	call   80105520 <argint>
801058e3:	83 c4 10             	add    $0x10,%esp
801058e6:	85 c0                	test   %eax,%eax
801058e8:	78 5e                	js     80105948 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801058ea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801058ee:	77 58                	ja     80105948 <sys_read+0x78>
801058f0:	e8 3b ec ff ff       	call   80104530 <myproc>
801058f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058f8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801058fc:	85 f6                	test   %esi,%esi
801058fe:	74 48                	je     80105948 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105900:	83 ec 08             	sub    $0x8,%esp
80105903:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105906:	50                   	push   %eax
80105907:	6a 02                	push   $0x2
80105909:	e8 12 fc ff ff       	call   80105520 <argint>
8010590e:	83 c4 10             	add    $0x10,%esp
80105911:	85 c0                	test   %eax,%eax
80105913:	78 33                	js     80105948 <sys_read+0x78>
80105915:	83 ec 04             	sub    $0x4,%esp
80105918:	ff 75 f0             	push   -0x10(%ebp)
8010591b:	53                   	push   %ebx
8010591c:	6a 01                	push   $0x1
8010591e:	e8 4d fc ff ff       	call   80105570 <argptr>
80105923:	83 c4 10             	add    $0x10,%esp
80105926:	85 c0                	test   %eax,%eax
80105928:	78 1e                	js     80105948 <sys_read+0x78>
  return fileread(f, p, n);
8010592a:	83 ec 04             	sub    $0x4,%esp
8010592d:	ff 75 f0             	push   -0x10(%ebp)
80105930:	ff 75 f4             	push   -0xc(%ebp)
80105933:	56                   	push   %esi
80105934:	e8 d7 c2 ff ff       	call   80101c10 <fileread>
80105939:	83 c4 10             	add    $0x10,%esp
}
8010593c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010593f:	5b                   	pop    %ebx
80105940:	5e                   	pop    %esi
80105941:	5d                   	pop    %ebp
80105942:	c3                   	ret
80105943:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105948:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594d:	eb ed                	jmp    8010593c <sys_read+0x6c>
8010594f:	90                   	nop

80105950 <sys_write>:
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	56                   	push   %esi
80105954:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105955:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105958:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010595b:	53                   	push   %ebx
8010595c:	6a 00                	push   $0x0
8010595e:	e8 bd fb ff ff       	call   80105520 <argint>
80105963:	83 c4 10             	add    $0x10,%esp
80105966:	85 c0                	test   %eax,%eax
80105968:	78 5e                	js     801059c8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010596a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010596e:	77 58                	ja     801059c8 <sys_write+0x78>
80105970:	e8 bb eb ff ff       	call   80104530 <myproc>
80105975:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105978:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010597c:	85 f6                	test   %esi,%esi
8010597e:	74 48                	je     801059c8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105980:	83 ec 08             	sub    $0x8,%esp
80105983:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105986:	50                   	push   %eax
80105987:	6a 02                	push   $0x2
80105989:	e8 92 fb ff ff       	call   80105520 <argint>
8010598e:	83 c4 10             	add    $0x10,%esp
80105991:	85 c0                	test   %eax,%eax
80105993:	78 33                	js     801059c8 <sys_write+0x78>
80105995:	83 ec 04             	sub    $0x4,%esp
80105998:	ff 75 f0             	push   -0x10(%ebp)
8010599b:	53                   	push   %ebx
8010599c:	6a 01                	push   $0x1
8010599e:	e8 cd fb ff ff       	call   80105570 <argptr>
801059a3:	83 c4 10             	add    $0x10,%esp
801059a6:	85 c0                	test   %eax,%eax
801059a8:	78 1e                	js     801059c8 <sys_write+0x78>
  return filewrite(f, p, n);
801059aa:	83 ec 04             	sub    $0x4,%esp
801059ad:	ff 75 f0             	push   -0x10(%ebp)
801059b0:	ff 75 f4             	push   -0xc(%ebp)
801059b3:	56                   	push   %esi
801059b4:	e8 e7 c2 ff ff       	call   80101ca0 <filewrite>
801059b9:	83 c4 10             	add    $0x10,%esp
}
801059bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059bf:	5b                   	pop    %ebx
801059c0:	5e                   	pop    %esi
801059c1:	5d                   	pop    %ebp
801059c2:	c3                   	ret
801059c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
801059c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059cd:	eb ed                	jmp    801059bc <sys_write+0x6c>
801059cf:	90                   	nop

801059d0 <sys_close>:
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
801059d3:	56                   	push   %esi
801059d4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801059d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801059d8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801059db:	50                   	push   %eax
801059dc:	6a 00                	push   $0x0
801059de:	e8 3d fb ff ff       	call   80105520 <argint>
801059e3:	83 c4 10             	add    $0x10,%esp
801059e6:	85 c0                	test   %eax,%eax
801059e8:	78 3e                	js     80105a28 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801059ea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801059ee:	77 38                	ja     80105a28 <sys_close+0x58>
801059f0:	e8 3b eb ff ff       	call   80104530 <myproc>
801059f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059f8:	8d 5a 08             	lea    0x8(%edx),%ebx
801059fb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801059ff:	85 f6                	test   %esi,%esi
80105a01:	74 25                	je     80105a28 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105a03:	e8 28 eb ff ff       	call   80104530 <myproc>
  fileclose(f);
80105a08:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105a0b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105a12:	00 
  fileclose(f);
80105a13:	56                   	push   %esi
80105a14:	e8 c7 c0 ff ff       	call   80101ae0 <fileclose>
  return 0;
80105a19:	83 c4 10             	add    $0x10,%esp
80105a1c:	31 c0                	xor    %eax,%eax
}
80105a1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a21:	5b                   	pop    %ebx
80105a22:	5e                   	pop    %esi
80105a23:	5d                   	pop    %ebp
80105a24:	c3                   	ret
80105a25:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105a28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a2d:	eb ef                	jmp    80105a1e <sys_close+0x4e>
80105a2f:	90                   	nop

80105a30 <sys_fstat>:
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	56                   	push   %esi
80105a34:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105a35:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105a38:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105a3b:	53                   	push   %ebx
80105a3c:	6a 00                	push   $0x0
80105a3e:	e8 dd fa ff ff       	call   80105520 <argint>
80105a43:	83 c4 10             	add    $0x10,%esp
80105a46:	85 c0                	test   %eax,%eax
80105a48:	78 46                	js     80105a90 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105a4a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a4e:	77 40                	ja     80105a90 <sys_fstat+0x60>
80105a50:	e8 db ea ff ff       	call   80104530 <myproc>
80105a55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a58:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105a5c:	85 f6                	test   %esi,%esi
80105a5e:	74 30                	je     80105a90 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a60:	83 ec 04             	sub    $0x4,%esp
80105a63:	6a 14                	push   $0x14
80105a65:	53                   	push   %ebx
80105a66:	6a 01                	push   $0x1
80105a68:	e8 03 fb ff ff       	call   80105570 <argptr>
80105a6d:	83 c4 10             	add    $0x10,%esp
80105a70:	85 c0                	test   %eax,%eax
80105a72:	78 1c                	js     80105a90 <sys_fstat+0x60>
  return filestat(f, st);
80105a74:	83 ec 08             	sub    $0x8,%esp
80105a77:	ff 75 f4             	push   -0xc(%ebp)
80105a7a:	56                   	push   %esi
80105a7b:	e8 40 c1 ff ff       	call   80101bc0 <filestat>
80105a80:	83 c4 10             	add    $0x10,%esp
}
80105a83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a86:	5b                   	pop    %ebx
80105a87:	5e                   	pop    %esi
80105a88:	5d                   	pop    %ebp
80105a89:	c3                   	ret
80105a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a95:	eb ec                	jmp    80105a83 <sys_fstat+0x53>
80105a97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a9e:	00 
80105a9f:	90                   	nop

80105aa0 <sys_link>:
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	57                   	push   %edi
80105aa4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105aa5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105aa8:	53                   	push   %ebx
80105aa9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105aac:	50                   	push   %eax
80105aad:	6a 00                	push   $0x0
80105aaf:	e8 2c fb ff ff       	call   801055e0 <argstr>
80105ab4:	83 c4 10             	add    $0x10,%esp
80105ab7:	85 c0                	test   %eax,%eax
80105ab9:	0f 88 fb 00 00 00    	js     80105bba <sys_link+0x11a>
80105abf:	83 ec 08             	sub    $0x8,%esp
80105ac2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105ac5:	50                   	push   %eax
80105ac6:	6a 01                	push   $0x1
80105ac8:	e8 13 fb ff ff       	call   801055e0 <argstr>
80105acd:	83 c4 10             	add    $0x10,%esp
80105ad0:	85 c0                	test   %eax,%eax
80105ad2:	0f 88 e2 00 00 00    	js     80105bba <sys_link+0x11a>
  begin_op();
80105ad8:	e8 33 de ff ff       	call   80103910 <begin_op>
  if((ip = namei(old)) == 0){
80105add:	83 ec 0c             	sub    $0xc,%esp
80105ae0:	ff 75 d4             	push   -0x2c(%ebp)
80105ae3:	e8 68 d1 ff ff       	call   80102c50 <namei>
80105ae8:	83 c4 10             	add    $0x10,%esp
80105aeb:	89 c3                	mov    %eax,%ebx
80105aed:	85 c0                	test   %eax,%eax
80105aef:	0f 84 df 00 00 00    	je     80105bd4 <sys_link+0x134>
  ilock(ip);
80105af5:	83 ec 0c             	sub    $0xc,%esp
80105af8:	50                   	push   %eax
80105af9:	e8 72 c8 ff ff       	call   80102370 <ilock>
  if(ip->type == T_DIR){
80105afe:	83 c4 10             	add    $0x10,%esp
80105b01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b06:	0f 84 b5 00 00 00    	je     80105bc1 <sys_link+0x121>
  iupdate(ip);
80105b0c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105b0f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105b14:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105b17:	53                   	push   %ebx
80105b18:	e8 a3 c7 ff ff       	call   801022c0 <iupdate>
  iunlock(ip);
80105b1d:	89 1c 24             	mov    %ebx,(%esp)
80105b20:	e8 2b c9 ff ff       	call   80102450 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105b25:	58                   	pop    %eax
80105b26:	5a                   	pop    %edx
80105b27:	57                   	push   %edi
80105b28:	ff 75 d0             	push   -0x30(%ebp)
80105b2b:	e8 40 d1 ff ff       	call   80102c70 <nameiparent>
80105b30:	83 c4 10             	add    $0x10,%esp
80105b33:	89 c6                	mov    %eax,%esi
80105b35:	85 c0                	test   %eax,%eax
80105b37:	74 5b                	je     80105b94 <sys_link+0xf4>
  ilock(dp);
80105b39:	83 ec 0c             	sub    $0xc,%esp
80105b3c:	50                   	push   %eax
80105b3d:	e8 2e c8 ff ff       	call   80102370 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105b42:	8b 03                	mov    (%ebx),%eax
80105b44:	83 c4 10             	add    $0x10,%esp
80105b47:	39 06                	cmp    %eax,(%esi)
80105b49:	75 3d                	jne    80105b88 <sys_link+0xe8>
80105b4b:	83 ec 04             	sub    $0x4,%esp
80105b4e:	ff 73 04             	push   0x4(%ebx)
80105b51:	57                   	push   %edi
80105b52:	56                   	push   %esi
80105b53:	e8 38 d0 ff ff       	call   80102b90 <dirlink>
80105b58:	83 c4 10             	add    $0x10,%esp
80105b5b:	85 c0                	test   %eax,%eax
80105b5d:	78 29                	js     80105b88 <sys_link+0xe8>
  iunlockput(dp);
80105b5f:	83 ec 0c             	sub    $0xc,%esp
80105b62:	56                   	push   %esi
80105b63:	e8 98 ca ff ff       	call   80102600 <iunlockput>
  iput(ip);
80105b68:	89 1c 24             	mov    %ebx,(%esp)
80105b6b:	e8 30 c9 ff ff       	call   801024a0 <iput>
  end_op();
80105b70:	e8 0b de ff ff       	call   80103980 <end_op>
  return 0;
80105b75:	83 c4 10             	add    $0x10,%esp
80105b78:	31 c0                	xor    %eax,%eax
}
80105b7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b7d:	5b                   	pop    %ebx
80105b7e:	5e                   	pop    %esi
80105b7f:	5f                   	pop    %edi
80105b80:	5d                   	pop    %ebp
80105b81:	c3                   	ret
80105b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105b88:	83 ec 0c             	sub    $0xc,%esp
80105b8b:	56                   	push   %esi
80105b8c:	e8 6f ca ff ff       	call   80102600 <iunlockput>
    goto bad;
80105b91:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105b94:	83 ec 0c             	sub    $0xc,%esp
80105b97:	53                   	push   %ebx
80105b98:	e8 d3 c7 ff ff       	call   80102370 <ilock>
  ip->nlink--;
80105b9d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105ba2:	89 1c 24             	mov    %ebx,(%esp)
80105ba5:	e8 16 c7 ff ff       	call   801022c0 <iupdate>
  iunlockput(ip);
80105baa:	89 1c 24             	mov    %ebx,(%esp)
80105bad:	e8 4e ca ff ff       	call   80102600 <iunlockput>
  end_op();
80105bb2:	e8 c9 dd ff ff       	call   80103980 <end_op>
  return -1;
80105bb7:	83 c4 10             	add    $0x10,%esp
    return -1;
80105bba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bbf:	eb b9                	jmp    80105b7a <sys_link+0xda>
    iunlockput(ip);
80105bc1:	83 ec 0c             	sub    $0xc,%esp
80105bc4:	53                   	push   %ebx
80105bc5:	e8 36 ca ff ff       	call   80102600 <iunlockput>
    end_op();
80105bca:	e8 b1 dd ff ff       	call   80103980 <end_op>
    return -1;
80105bcf:	83 c4 10             	add    $0x10,%esp
80105bd2:	eb e6                	jmp    80105bba <sys_link+0x11a>
    end_op();
80105bd4:	e8 a7 dd ff ff       	call   80103980 <end_op>
    return -1;
80105bd9:	eb df                	jmp    80105bba <sys_link+0x11a>
80105bdb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105be0 <sys_unlink>:
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	57                   	push   %edi
80105be4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105be5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105be8:	53                   	push   %ebx
80105be9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105bec:	50                   	push   %eax
80105bed:	6a 00                	push   $0x0
80105bef:	e8 ec f9 ff ff       	call   801055e0 <argstr>
80105bf4:	83 c4 10             	add    $0x10,%esp
80105bf7:	85 c0                	test   %eax,%eax
80105bf9:	0f 88 54 01 00 00    	js     80105d53 <sys_unlink+0x173>
  begin_op();
80105bff:	e8 0c dd ff ff       	call   80103910 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105c04:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105c07:	83 ec 08             	sub    $0x8,%esp
80105c0a:	53                   	push   %ebx
80105c0b:	ff 75 c0             	push   -0x40(%ebp)
80105c0e:	e8 5d d0 ff ff       	call   80102c70 <nameiparent>
80105c13:	83 c4 10             	add    $0x10,%esp
80105c16:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105c19:	85 c0                	test   %eax,%eax
80105c1b:	0f 84 58 01 00 00    	je     80105d79 <sys_unlink+0x199>
  ilock(dp);
80105c21:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105c24:	83 ec 0c             	sub    $0xc,%esp
80105c27:	57                   	push   %edi
80105c28:	e8 43 c7 ff ff       	call   80102370 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105c2d:	58                   	pop    %eax
80105c2e:	5a                   	pop    %edx
80105c2f:	68 ed 80 10 80       	push   $0x801080ed
80105c34:	53                   	push   %ebx
80105c35:	e8 66 cc ff ff       	call   801028a0 <namecmp>
80105c3a:	83 c4 10             	add    $0x10,%esp
80105c3d:	85 c0                	test   %eax,%eax
80105c3f:	0f 84 fb 00 00 00    	je     80105d40 <sys_unlink+0x160>
80105c45:	83 ec 08             	sub    $0x8,%esp
80105c48:	68 ec 80 10 80       	push   $0x801080ec
80105c4d:	53                   	push   %ebx
80105c4e:	e8 4d cc ff ff       	call   801028a0 <namecmp>
80105c53:	83 c4 10             	add    $0x10,%esp
80105c56:	85 c0                	test   %eax,%eax
80105c58:	0f 84 e2 00 00 00    	je     80105d40 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105c5e:	83 ec 04             	sub    $0x4,%esp
80105c61:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105c64:	50                   	push   %eax
80105c65:	53                   	push   %ebx
80105c66:	57                   	push   %edi
80105c67:	e8 54 cc ff ff       	call   801028c0 <dirlookup>
80105c6c:	83 c4 10             	add    $0x10,%esp
80105c6f:	89 c3                	mov    %eax,%ebx
80105c71:	85 c0                	test   %eax,%eax
80105c73:	0f 84 c7 00 00 00    	je     80105d40 <sys_unlink+0x160>
  ilock(ip);
80105c79:	83 ec 0c             	sub    $0xc,%esp
80105c7c:	50                   	push   %eax
80105c7d:	e8 ee c6 ff ff       	call   80102370 <ilock>
  if(ip->nlink < 1)
80105c82:	83 c4 10             	add    $0x10,%esp
80105c85:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105c8a:	0f 8e 0a 01 00 00    	jle    80105d9a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105c90:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c95:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105c98:	74 66                	je     80105d00 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105c9a:	83 ec 04             	sub    $0x4,%esp
80105c9d:	6a 10                	push   $0x10
80105c9f:	6a 00                	push   $0x0
80105ca1:	57                   	push   %edi
80105ca2:	e8 c9 f5 ff ff       	call   80105270 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ca7:	6a 10                	push   $0x10
80105ca9:	ff 75 c4             	push   -0x3c(%ebp)
80105cac:	57                   	push   %edi
80105cad:	ff 75 b4             	push   -0x4c(%ebp)
80105cb0:	e8 cb ca ff ff       	call   80102780 <writei>
80105cb5:	83 c4 20             	add    $0x20,%esp
80105cb8:	83 f8 10             	cmp    $0x10,%eax
80105cbb:	0f 85 cc 00 00 00    	jne    80105d8d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105cc1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105cc6:	0f 84 94 00 00 00    	je     80105d60 <sys_unlink+0x180>
  iunlockput(dp);
80105ccc:	83 ec 0c             	sub    $0xc,%esp
80105ccf:	ff 75 b4             	push   -0x4c(%ebp)
80105cd2:	e8 29 c9 ff ff       	call   80102600 <iunlockput>
  ip->nlink--;
80105cd7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105cdc:	89 1c 24             	mov    %ebx,(%esp)
80105cdf:	e8 dc c5 ff ff       	call   801022c0 <iupdate>
  iunlockput(ip);
80105ce4:	89 1c 24             	mov    %ebx,(%esp)
80105ce7:	e8 14 c9 ff ff       	call   80102600 <iunlockput>
  end_op();
80105cec:	e8 8f dc ff ff       	call   80103980 <end_op>
  return 0;
80105cf1:	83 c4 10             	add    $0x10,%esp
80105cf4:	31 c0                	xor    %eax,%eax
}
80105cf6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cf9:	5b                   	pop    %ebx
80105cfa:	5e                   	pop    %esi
80105cfb:	5f                   	pop    %edi
80105cfc:	5d                   	pop    %ebp
80105cfd:	c3                   	ret
80105cfe:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105d00:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105d04:	76 94                	jbe    80105c9a <sys_unlink+0xba>
80105d06:	be 20 00 00 00       	mov    $0x20,%esi
80105d0b:	eb 0b                	jmp    80105d18 <sys_unlink+0x138>
80105d0d:	8d 76 00             	lea    0x0(%esi),%esi
80105d10:	83 c6 10             	add    $0x10,%esi
80105d13:	3b 73 58             	cmp    0x58(%ebx),%esi
80105d16:	73 82                	jae    80105c9a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d18:	6a 10                	push   $0x10
80105d1a:	56                   	push   %esi
80105d1b:	57                   	push   %edi
80105d1c:	53                   	push   %ebx
80105d1d:	e8 5e c9 ff ff       	call   80102680 <readi>
80105d22:	83 c4 10             	add    $0x10,%esp
80105d25:	83 f8 10             	cmp    $0x10,%eax
80105d28:	75 56                	jne    80105d80 <sys_unlink+0x1a0>
    if(de.inum != 0)
80105d2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105d2f:	74 df                	je     80105d10 <sys_unlink+0x130>
    iunlockput(ip);
80105d31:	83 ec 0c             	sub    $0xc,%esp
80105d34:	53                   	push   %ebx
80105d35:	e8 c6 c8 ff ff       	call   80102600 <iunlockput>
    goto bad;
80105d3a:	83 c4 10             	add    $0x10,%esp
80105d3d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105d40:	83 ec 0c             	sub    $0xc,%esp
80105d43:	ff 75 b4             	push   -0x4c(%ebp)
80105d46:	e8 b5 c8 ff ff       	call   80102600 <iunlockput>
  end_op();
80105d4b:	e8 30 dc ff ff       	call   80103980 <end_op>
  return -1;
80105d50:	83 c4 10             	add    $0x10,%esp
    return -1;
80105d53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d58:	eb 9c                	jmp    80105cf6 <sys_unlink+0x116>
80105d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105d60:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105d63:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105d66:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105d6b:	50                   	push   %eax
80105d6c:	e8 4f c5 ff ff       	call   801022c0 <iupdate>
80105d71:	83 c4 10             	add    $0x10,%esp
80105d74:	e9 53 ff ff ff       	jmp    80105ccc <sys_unlink+0xec>
    end_op();
80105d79:	e8 02 dc ff ff       	call   80103980 <end_op>
    return -1;
80105d7e:	eb d3                	jmp    80105d53 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105d80:	83 ec 0c             	sub    $0xc,%esp
80105d83:	68 11 81 10 80       	push   $0x80108111
80105d88:	e8 e3 ad ff ff       	call   80100b70 <panic>
    panic("unlink: writei");
80105d8d:	83 ec 0c             	sub    $0xc,%esp
80105d90:	68 23 81 10 80       	push   $0x80108123
80105d95:	e8 d6 ad ff ff       	call   80100b70 <panic>
    panic("unlink: nlink < 1");
80105d9a:	83 ec 0c             	sub    $0xc,%esp
80105d9d:	68 ff 80 10 80       	push   $0x801080ff
80105da2:	e8 c9 ad ff ff       	call   80100b70 <panic>
80105da7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105dae:	00 
80105daf:	90                   	nop

80105db0 <sys_open>:

int
sys_open(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	57                   	push   %edi
80105db4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105db5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105db8:	53                   	push   %ebx
80105db9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105dbc:	50                   	push   %eax
80105dbd:	6a 00                	push   $0x0
80105dbf:	e8 1c f8 ff ff       	call   801055e0 <argstr>
80105dc4:	83 c4 10             	add    $0x10,%esp
80105dc7:	85 c0                	test   %eax,%eax
80105dc9:	0f 88 8e 00 00 00    	js     80105e5d <sys_open+0xad>
80105dcf:	83 ec 08             	sub    $0x8,%esp
80105dd2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105dd5:	50                   	push   %eax
80105dd6:	6a 01                	push   $0x1
80105dd8:	e8 43 f7 ff ff       	call   80105520 <argint>
80105ddd:	83 c4 10             	add    $0x10,%esp
80105de0:	85 c0                	test   %eax,%eax
80105de2:	78 79                	js     80105e5d <sys_open+0xad>
    return -1;

  begin_op();
80105de4:	e8 27 db ff ff       	call   80103910 <begin_op>

  if(omode & O_CREATE){
80105de9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105ded:	75 79                	jne    80105e68 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105def:	83 ec 0c             	sub    $0xc,%esp
80105df2:	ff 75 e0             	push   -0x20(%ebp)
80105df5:	e8 56 ce ff ff       	call   80102c50 <namei>
80105dfa:	83 c4 10             	add    $0x10,%esp
80105dfd:	89 c6                	mov    %eax,%esi
80105dff:	85 c0                	test   %eax,%eax
80105e01:	0f 84 7e 00 00 00    	je     80105e85 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105e07:	83 ec 0c             	sub    $0xc,%esp
80105e0a:	50                   	push   %eax
80105e0b:	e8 60 c5 ff ff       	call   80102370 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e10:	83 c4 10             	add    $0x10,%esp
80105e13:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105e18:	0f 84 ba 00 00 00    	je     80105ed8 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e1e:	e8 fd bb ff ff       	call   80101a20 <filealloc>
80105e23:	89 c7                	mov    %eax,%edi
80105e25:	85 c0                	test   %eax,%eax
80105e27:	74 23                	je     80105e4c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105e29:	e8 02 e7 ff ff       	call   80104530 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105e2e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105e30:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105e34:	85 d2                	test   %edx,%edx
80105e36:	74 58                	je     80105e90 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105e38:	83 c3 01             	add    $0x1,%ebx
80105e3b:	83 fb 10             	cmp    $0x10,%ebx
80105e3e:	75 f0                	jne    80105e30 <sys_open+0x80>
    if(f)
      fileclose(f);
80105e40:	83 ec 0c             	sub    $0xc,%esp
80105e43:	57                   	push   %edi
80105e44:	e8 97 bc ff ff       	call   80101ae0 <fileclose>
80105e49:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105e4c:	83 ec 0c             	sub    $0xc,%esp
80105e4f:	56                   	push   %esi
80105e50:	e8 ab c7 ff ff       	call   80102600 <iunlockput>
    end_op();
80105e55:	e8 26 db ff ff       	call   80103980 <end_op>
    return -1;
80105e5a:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e5d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e62:	eb 65                	jmp    80105ec9 <sys_open+0x119>
80105e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105e68:	83 ec 0c             	sub    $0xc,%esp
80105e6b:	31 c9                	xor    %ecx,%ecx
80105e6d:	ba 02 00 00 00       	mov    $0x2,%edx
80105e72:	6a 00                	push   $0x0
80105e74:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e77:	e8 54 f8 ff ff       	call   801056d0 <create>
    if(ip == 0){
80105e7c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105e7f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105e81:	85 c0                	test   %eax,%eax
80105e83:	75 99                	jne    80105e1e <sys_open+0x6e>
      end_op();
80105e85:	e8 f6 da ff ff       	call   80103980 <end_op>
      return -1;
80105e8a:	eb d1                	jmp    80105e5d <sys_open+0xad>
80105e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105e90:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105e93:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105e97:	56                   	push   %esi
80105e98:	e8 b3 c5 ff ff       	call   80102450 <iunlock>
  end_op();
80105e9d:	e8 de da ff ff       	call   80103980 <end_op>

  f->type = FD_INODE;
80105ea2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105ea8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105eab:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105eae:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105eb1:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105eb3:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105eba:	f7 d0                	not    %eax
80105ebc:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ebf:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105ec2:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ec5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105ec9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ecc:	89 d8                	mov    %ebx,%eax
80105ece:	5b                   	pop    %ebx
80105ecf:	5e                   	pop    %esi
80105ed0:	5f                   	pop    %edi
80105ed1:	5d                   	pop    %ebp
80105ed2:	c3                   	ret
80105ed3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105ed8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105edb:	85 c9                	test   %ecx,%ecx
80105edd:	0f 84 3b ff ff ff    	je     80105e1e <sys_open+0x6e>
80105ee3:	e9 64 ff ff ff       	jmp    80105e4c <sys_open+0x9c>
80105ee8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105eef:	00 

80105ef0 <sys_mkdir>:

int
sys_mkdir(void)
{
80105ef0:	55                   	push   %ebp
80105ef1:	89 e5                	mov    %esp,%ebp
80105ef3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105ef6:	e8 15 da ff ff       	call   80103910 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105efb:	83 ec 08             	sub    $0x8,%esp
80105efe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f01:	50                   	push   %eax
80105f02:	6a 00                	push   $0x0
80105f04:	e8 d7 f6 ff ff       	call   801055e0 <argstr>
80105f09:	83 c4 10             	add    $0x10,%esp
80105f0c:	85 c0                	test   %eax,%eax
80105f0e:	78 30                	js     80105f40 <sys_mkdir+0x50>
80105f10:	83 ec 0c             	sub    $0xc,%esp
80105f13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f16:	31 c9                	xor    %ecx,%ecx
80105f18:	ba 01 00 00 00       	mov    $0x1,%edx
80105f1d:	6a 00                	push   $0x0
80105f1f:	e8 ac f7 ff ff       	call   801056d0 <create>
80105f24:	83 c4 10             	add    $0x10,%esp
80105f27:	85 c0                	test   %eax,%eax
80105f29:	74 15                	je     80105f40 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f2b:	83 ec 0c             	sub    $0xc,%esp
80105f2e:	50                   	push   %eax
80105f2f:	e8 cc c6 ff ff       	call   80102600 <iunlockput>
  end_op();
80105f34:	e8 47 da ff ff       	call   80103980 <end_op>
  return 0;
80105f39:	83 c4 10             	add    $0x10,%esp
80105f3c:	31 c0                	xor    %eax,%eax
}
80105f3e:	c9                   	leave
80105f3f:	c3                   	ret
    end_op();
80105f40:	e8 3b da ff ff       	call   80103980 <end_op>
    return -1;
80105f45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f4a:	c9                   	leave
80105f4b:	c3                   	ret
80105f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f50 <sys_mknod>:

int
sys_mknod(void)
{
80105f50:	55                   	push   %ebp
80105f51:	89 e5                	mov    %esp,%ebp
80105f53:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105f56:	e8 b5 d9 ff ff       	call   80103910 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105f5b:	83 ec 08             	sub    $0x8,%esp
80105f5e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f61:	50                   	push   %eax
80105f62:	6a 00                	push   $0x0
80105f64:	e8 77 f6 ff ff       	call   801055e0 <argstr>
80105f69:	83 c4 10             	add    $0x10,%esp
80105f6c:	85 c0                	test   %eax,%eax
80105f6e:	78 60                	js     80105fd0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105f70:	83 ec 08             	sub    $0x8,%esp
80105f73:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f76:	50                   	push   %eax
80105f77:	6a 01                	push   $0x1
80105f79:	e8 a2 f5 ff ff       	call   80105520 <argint>
  if((argstr(0, &path)) < 0 ||
80105f7e:	83 c4 10             	add    $0x10,%esp
80105f81:	85 c0                	test   %eax,%eax
80105f83:	78 4b                	js     80105fd0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105f85:	83 ec 08             	sub    $0x8,%esp
80105f88:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f8b:	50                   	push   %eax
80105f8c:	6a 02                	push   $0x2
80105f8e:	e8 8d f5 ff ff       	call   80105520 <argint>
     argint(1, &major) < 0 ||
80105f93:	83 c4 10             	add    $0x10,%esp
80105f96:	85 c0                	test   %eax,%eax
80105f98:	78 36                	js     80105fd0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f9a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105f9e:	83 ec 0c             	sub    $0xc,%esp
80105fa1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105fa5:	ba 03 00 00 00       	mov    $0x3,%edx
80105faa:	50                   	push   %eax
80105fab:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105fae:	e8 1d f7 ff ff       	call   801056d0 <create>
     argint(2, &minor) < 0 ||
80105fb3:	83 c4 10             	add    $0x10,%esp
80105fb6:	85 c0                	test   %eax,%eax
80105fb8:	74 16                	je     80105fd0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105fba:	83 ec 0c             	sub    $0xc,%esp
80105fbd:	50                   	push   %eax
80105fbe:	e8 3d c6 ff ff       	call   80102600 <iunlockput>
  end_op();
80105fc3:	e8 b8 d9 ff ff       	call   80103980 <end_op>
  return 0;
80105fc8:	83 c4 10             	add    $0x10,%esp
80105fcb:	31 c0                	xor    %eax,%eax
}
80105fcd:	c9                   	leave
80105fce:	c3                   	ret
80105fcf:	90                   	nop
    end_op();
80105fd0:	e8 ab d9 ff ff       	call   80103980 <end_op>
    return -1;
80105fd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fda:	c9                   	leave
80105fdb:	c3                   	ret
80105fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fe0 <sys_chdir>:

int
sys_chdir(void)
{
80105fe0:	55                   	push   %ebp
80105fe1:	89 e5                	mov    %esp,%ebp
80105fe3:	56                   	push   %esi
80105fe4:	53                   	push   %ebx
80105fe5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105fe8:	e8 43 e5 ff ff       	call   80104530 <myproc>
80105fed:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105fef:	e8 1c d9 ff ff       	call   80103910 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105ff4:	83 ec 08             	sub    $0x8,%esp
80105ff7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ffa:	50                   	push   %eax
80105ffb:	6a 00                	push   $0x0
80105ffd:	e8 de f5 ff ff       	call   801055e0 <argstr>
80106002:	83 c4 10             	add    $0x10,%esp
80106005:	85 c0                	test   %eax,%eax
80106007:	78 77                	js     80106080 <sys_chdir+0xa0>
80106009:	83 ec 0c             	sub    $0xc,%esp
8010600c:	ff 75 f4             	push   -0xc(%ebp)
8010600f:	e8 3c cc ff ff       	call   80102c50 <namei>
80106014:	83 c4 10             	add    $0x10,%esp
80106017:	89 c3                	mov    %eax,%ebx
80106019:	85 c0                	test   %eax,%eax
8010601b:	74 63                	je     80106080 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010601d:	83 ec 0c             	sub    $0xc,%esp
80106020:	50                   	push   %eax
80106021:	e8 4a c3 ff ff       	call   80102370 <ilock>
  if(ip->type != T_DIR){
80106026:	83 c4 10             	add    $0x10,%esp
80106029:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010602e:	75 30                	jne    80106060 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106030:	83 ec 0c             	sub    $0xc,%esp
80106033:	53                   	push   %ebx
80106034:	e8 17 c4 ff ff       	call   80102450 <iunlock>
  iput(curproc->cwd);
80106039:	58                   	pop    %eax
8010603a:	ff 76 68             	push   0x68(%esi)
8010603d:	e8 5e c4 ff ff       	call   801024a0 <iput>
  end_op();
80106042:	e8 39 d9 ff ff       	call   80103980 <end_op>
  curproc->cwd = ip;
80106047:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010604a:	83 c4 10             	add    $0x10,%esp
8010604d:	31 c0                	xor    %eax,%eax
}
8010604f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106052:	5b                   	pop    %ebx
80106053:	5e                   	pop    %esi
80106054:	5d                   	pop    %ebp
80106055:	c3                   	ret
80106056:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010605d:	00 
8010605e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80106060:	83 ec 0c             	sub    $0xc,%esp
80106063:	53                   	push   %ebx
80106064:	e8 97 c5 ff ff       	call   80102600 <iunlockput>
    end_op();
80106069:	e8 12 d9 ff ff       	call   80103980 <end_op>
    return -1;
8010606e:	83 c4 10             	add    $0x10,%esp
    return -1;
80106071:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106076:	eb d7                	jmp    8010604f <sys_chdir+0x6f>
80106078:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010607f:	00 
    end_op();
80106080:	e8 fb d8 ff ff       	call   80103980 <end_op>
    return -1;
80106085:	eb ea                	jmp    80106071 <sys_chdir+0x91>
80106087:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010608e:	00 
8010608f:	90                   	nop

80106090 <sys_exec>:

int
sys_exec(void)
{
80106090:	55                   	push   %ebp
80106091:	89 e5                	mov    %esp,%ebp
80106093:	57                   	push   %edi
80106094:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106095:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010609b:	53                   	push   %ebx
8010609c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801060a2:	50                   	push   %eax
801060a3:	6a 00                	push   $0x0
801060a5:	e8 36 f5 ff ff       	call   801055e0 <argstr>
801060aa:	83 c4 10             	add    $0x10,%esp
801060ad:	85 c0                	test   %eax,%eax
801060af:	0f 88 87 00 00 00    	js     8010613c <sys_exec+0xac>
801060b5:	83 ec 08             	sub    $0x8,%esp
801060b8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801060be:	50                   	push   %eax
801060bf:	6a 01                	push   $0x1
801060c1:	e8 5a f4 ff ff       	call   80105520 <argint>
801060c6:	83 c4 10             	add    $0x10,%esp
801060c9:	85 c0                	test   %eax,%eax
801060cb:	78 6f                	js     8010613c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801060cd:	83 ec 04             	sub    $0x4,%esp
801060d0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801060d6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801060d8:	68 80 00 00 00       	push   $0x80
801060dd:	6a 00                	push   $0x0
801060df:	56                   	push   %esi
801060e0:	e8 8b f1 ff ff       	call   80105270 <memset>
801060e5:	83 c4 10             	add    $0x10,%esp
801060e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060ef:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801060f0:	83 ec 08             	sub    $0x8,%esp
801060f3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801060f9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106100:	50                   	push   %eax
80106101:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106107:	01 f8                	add    %edi,%eax
80106109:	50                   	push   %eax
8010610a:	e8 81 f3 ff ff       	call   80105490 <fetchint>
8010610f:	83 c4 10             	add    $0x10,%esp
80106112:	85 c0                	test   %eax,%eax
80106114:	78 26                	js     8010613c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106116:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010611c:	85 c0                	test   %eax,%eax
8010611e:	74 30                	je     80106150 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106120:	83 ec 08             	sub    $0x8,%esp
80106123:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106126:	52                   	push   %edx
80106127:	50                   	push   %eax
80106128:	e8 a3 f3 ff ff       	call   801054d0 <fetchstr>
8010612d:	83 c4 10             	add    $0x10,%esp
80106130:	85 c0                	test   %eax,%eax
80106132:	78 08                	js     8010613c <sys_exec+0xac>
  for(i=0;; i++){
80106134:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106137:	83 fb 20             	cmp    $0x20,%ebx
8010613a:	75 b4                	jne    801060f0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010613c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010613f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106144:	5b                   	pop    %ebx
80106145:	5e                   	pop    %esi
80106146:	5f                   	pop    %edi
80106147:	5d                   	pop    %ebp
80106148:	c3                   	ret
80106149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106150:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106157:	00 00 00 00 
  return exec(path, argv);
8010615b:	83 ec 08             	sub    $0x8,%esp
8010615e:	56                   	push   %esi
8010615f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80106165:	e8 16 b5 ff ff       	call   80101680 <exec>
8010616a:	83 c4 10             	add    $0x10,%esp
}
8010616d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106170:	5b                   	pop    %ebx
80106171:	5e                   	pop    %esi
80106172:	5f                   	pop    %edi
80106173:	5d                   	pop    %ebp
80106174:	c3                   	ret
80106175:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010617c:	00 
8010617d:	8d 76 00             	lea    0x0(%esi),%esi

80106180 <sys_pipe>:

int
sys_pipe(void)
{
80106180:	55                   	push   %ebp
80106181:	89 e5                	mov    %esp,%ebp
80106183:	57                   	push   %edi
80106184:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106185:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106188:	53                   	push   %ebx
80106189:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010618c:	6a 08                	push   $0x8
8010618e:	50                   	push   %eax
8010618f:	6a 00                	push   $0x0
80106191:	e8 da f3 ff ff       	call   80105570 <argptr>
80106196:	83 c4 10             	add    $0x10,%esp
80106199:	85 c0                	test   %eax,%eax
8010619b:	0f 88 8b 00 00 00    	js     8010622c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801061a1:	83 ec 08             	sub    $0x8,%esp
801061a4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801061a7:	50                   	push   %eax
801061a8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801061ab:	50                   	push   %eax
801061ac:	e8 2f de ff ff       	call   80103fe0 <pipealloc>
801061b1:	83 c4 10             	add    $0x10,%esp
801061b4:	85 c0                	test   %eax,%eax
801061b6:	78 74                	js     8010622c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061b8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801061bb:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801061bd:	e8 6e e3 ff ff       	call   80104530 <myproc>
    if(curproc->ofile[fd] == 0){
801061c2:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801061c6:	85 f6                	test   %esi,%esi
801061c8:	74 16                	je     801061e0 <sys_pipe+0x60>
801061ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801061d0:	83 c3 01             	add    $0x1,%ebx
801061d3:	83 fb 10             	cmp    $0x10,%ebx
801061d6:	74 3d                	je     80106215 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
801061d8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801061dc:	85 f6                	test   %esi,%esi
801061de:	75 f0                	jne    801061d0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801061e0:	8d 73 08             	lea    0x8(%ebx),%esi
801061e3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061e7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801061ea:	e8 41 e3 ff ff       	call   80104530 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801061ef:	31 d2                	xor    %edx,%edx
801061f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801061f8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801061fc:	85 c9                	test   %ecx,%ecx
801061fe:	74 38                	je     80106238 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80106200:	83 c2 01             	add    $0x1,%edx
80106203:	83 fa 10             	cmp    $0x10,%edx
80106206:	75 f0                	jne    801061f8 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80106208:	e8 23 e3 ff ff       	call   80104530 <myproc>
8010620d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106214:	00 
    fileclose(rf);
80106215:	83 ec 0c             	sub    $0xc,%esp
80106218:	ff 75 e0             	push   -0x20(%ebp)
8010621b:	e8 c0 b8 ff ff       	call   80101ae0 <fileclose>
    fileclose(wf);
80106220:	58                   	pop    %eax
80106221:	ff 75 e4             	push   -0x1c(%ebp)
80106224:	e8 b7 b8 ff ff       	call   80101ae0 <fileclose>
    return -1;
80106229:	83 c4 10             	add    $0x10,%esp
    return -1;
8010622c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106231:	eb 16                	jmp    80106249 <sys_pipe+0xc9>
80106233:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80106238:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010623c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010623f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106241:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106244:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106247:	31 c0                	xor    %eax,%eax
}
80106249:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010624c:	5b                   	pop    %ebx
8010624d:	5e                   	pop    %esi
8010624e:	5f                   	pop    %edi
8010624f:	5d                   	pop    %ebp
80106250:	c3                   	ret
80106251:	66 90                	xchg   %ax,%ax
80106253:	66 90                	xchg   %ax,%ax
80106255:	66 90                	xchg   %ax,%ax
80106257:	66 90                	xchg   %ax,%ax
80106259:	66 90                	xchg   %ax,%ax
8010625b:	66 90                	xchg   %ax,%ax
8010625d:	66 90                	xchg   %ax,%ax
8010625f:	90                   	nop

80106260 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106260:	e9 6b e4 ff ff       	jmp    801046d0 <fork>
80106265:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010626c:	00 
8010626d:	8d 76 00             	lea    0x0(%esi),%esi

80106270 <sys_exit>:
}

int
sys_exit(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	83 ec 08             	sub    $0x8,%esp
  exit();
80106276:	e8 c5 e6 ff ff       	call   80104940 <exit>
  return 0;  // not reached
}
8010627b:	31 c0                	xor    %eax,%eax
8010627d:	c9                   	leave
8010627e:	c3                   	ret
8010627f:	90                   	nop

80106280 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106280:	e9 eb e7 ff ff       	jmp    80104a70 <wait>
80106285:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010628c:	00 
8010628d:	8d 76 00             	lea    0x0(%esi),%esi

80106290 <sys_kill>:
}

int
sys_kill(void)
{
80106290:	55                   	push   %ebp
80106291:	89 e5                	mov    %esp,%ebp
80106293:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106296:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106299:	50                   	push   %eax
8010629a:	6a 00                	push   $0x0
8010629c:	e8 7f f2 ff ff       	call   80105520 <argint>
801062a1:	83 c4 10             	add    $0x10,%esp
801062a4:	85 c0                	test   %eax,%eax
801062a6:	78 18                	js     801062c0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801062a8:	83 ec 0c             	sub    $0xc,%esp
801062ab:	ff 75 f4             	push   -0xc(%ebp)
801062ae:	e8 5d ea ff ff       	call   80104d10 <kill>
801062b3:	83 c4 10             	add    $0x10,%esp
}
801062b6:	c9                   	leave
801062b7:	c3                   	ret
801062b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062bf:	00 
801062c0:	c9                   	leave
    return -1;
801062c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062c6:	c3                   	ret
801062c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062ce:	00 
801062cf:	90                   	nop

801062d0 <sys_getpid>:

int
sys_getpid(void)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801062d6:	e8 55 e2 ff ff       	call   80104530 <myproc>
801062db:	8b 40 10             	mov    0x10(%eax),%eax
}
801062de:	c9                   	leave
801062df:	c3                   	ret

801062e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801062e0:	55                   	push   %ebp
801062e1:	89 e5                	mov    %esp,%ebp
801062e3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801062e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801062ea:	50                   	push   %eax
801062eb:	6a 00                	push   $0x0
801062ed:	e8 2e f2 ff ff       	call   80105520 <argint>
801062f2:	83 c4 10             	add    $0x10,%esp
801062f5:	85 c0                	test   %eax,%eax
801062f7:	78 27                	js     80106320 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801062f9:	e8 32 e2 ff ff       	call   80104530 <myproc>
  if(growproc(n) < 0)
801062fe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106301:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106303:	ff 75 f4             	push   -0xc(%ebp)
80106306:	e8 45 e3 ff ff       	call   80104650 <growproc>
8010630b:	83 c4 10             	add    $0x10,%esp
8010630e:	85 c0                	test   %eax,%eax
80106310:	78 0e                	js     80106320 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106312:	89 d8                	mov    %ebx,%eax
80106314:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106317:	c9                   	leave
80106318:	c3                   	ret
80106319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106320:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106325:	eb eb                	jmp    80106312 <sys_sbrk+0x32>
80106327:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010632e:	00 
8010632f:	90                   	nop

80106330 <sys_sleep>:

int
sys_sleep(void)
{
80106330:	55                   	push   %ebp
80106331:	89 e5                	mov    %esp,%ebp
80106333:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106334:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106337:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010633a:	50                   	push   %eax
8010633b:	6a 00                	push   $0x0
8010633d:	e8 de f1 ff ff       	call   80105520 <argint>
80106342:	83 c4 10             	add    $0x10,%esp
80106345:	85 c0                	test   %eax,%eax
80106347:	78 64                	js     801063ad <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80106349:	83 ec 0c             	sub    $0xc,%esp
8010634c:	68 a0 4c 11 80       	push   $0x80114ca0
80106351:	e8 1a ee ff ff       	call   80105170 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106356:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106359:	8b 1d 80 4c 11 80    	mov    0x80114c80,%ebx
  while(ticks - ticks0 < n){
8010635f:	83 c4 10             	add    $0x10,%esp
80106362:	85 d2                	test   %edx,%edx
80106364:	75 2b                	jne    80106391 <sys_sleep+0x61>
80106366:	eb 58                	jmp    801063c0 <sys_sleep+0x90>
80106368:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010636f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106370:	83 ec 08             	sub    $0x8,%esp
80106373:	68 a0 4c 11 80       	push   $0x80114ca0
80106378:	68 80 4c 11 80       	push   $0x80114c80
8010637d:	e8 6e e8 ff ff       	call   80104bf0 <sleep>
  while(ticks - ticks0 < n){
80106382:	a1 80 4c 11 80       	mov    0x80114c80,%eax
80106387:	83 c4 10             	add    $0x10,%esp
8010638a:	29 d8                	sub    %ebx,%eax
8010638c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010638f:	73 2f                	jae    801063c0 <sys_sleep+0x90>
    if(myproc()->killed){
80106391:	e8 9a e1 ff ff       	call   80104530 <myproc>
80106396:	8b 40 24             	mov    0x24(%eax),%eax
80106399:	85 c0                	test   %eax,%eax
8010639b:	74 d3                	je     80106370 <sys_sleep+0x40>
      release(&tickslock);
8010639d:	83 ec 0c             	sub    $0xc,%esp
801063a0:	68 a0 4c 11 80       	push   $0x80114ca0
801063a5:	e8 66 ed ff ff       	call   80105110 <release>
      return -1;
801063aa:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
801063ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801063b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063b5:	c9                   	leave
801063b6:	c3                   	ret
801063b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063be:	00 
801063bf:	90                   	nop
  release(&tickslock);
801063c0:	83 ec 0c             	sub    $0xc,%esp
801063c3:	68 a0 4c 11 80       	push   $0x80114ca0
801063c8:	e8 43 ed ff ff       	call   80105110 <release>
}
801063cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
801063d0:	83 c4 10             	add    $0x10,%esp
801063d3:	31 c0                	xor    %eax,%eax
}
801063d5:	c9                   	leave
801063d6:	c3                   	ret
801063d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063de:	00 
801063df:	90                   	nop

801063e0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	53                   	push   %ebx
801063e4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801063e7:	68 a0 4c 11 80       	push   $0x80114ca0
801063ec:	e8 7f ed ff ff       	call   80105170 <acquire>
  xticks = ticks;
801063f1:	8b 1d 80 4c 11 80    	mov    0x80114c80,%ebx
  release(&tickslock);
801063f7:	c7 04 24 a0 4c 11 80 	movl   $0x80114ca0,(%esp)
801063fe:	e8 0d ed ff ff       	call   80105110 <release>
  return xticks;
}
80106403:	89 d8                	mov    %ebx,%eax
80106405:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106408:	c9                   	leave
80106409:	c3                   	ret

8010640a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010640a:	1e                   	push   %ds
  pushl %es
8010640b:	06                   	push   %es
  pushl %fs
8010640c:	0f a0                	push   %fs
  pushl %gs
8010640e:	0f a8                	push   %gs
  pushal
80106410:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106411:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106415:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106417:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106419:	54                   	push   %esp
  call trap
8010641a:	e8 c1 00 00 00       	call   801064e0 <trap>
  addl $4, %esp
8010641f:	83 c4 04             	add    $0x4,%esp

80106422 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106422:	61                   	popa
  popl %gs
80106423:	0f a9                	pop    %gs
  popl %fs
80106425:	0f a1                	pop    %fs
  popl %es
80106427:	07                   	pop    %es
  popl %ds
80106428:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106429:	83 c4 08             	add    $0x8,%esp
  iret
8010642c:	cf                   	iret
8010642d:	66 90                	xchg   %ax,%ax
8010642f:	90                   	nop

80106430 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106430:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106431:	31 c0                	xor    %eax,%eax
{
80106433:	89 e5                	mov    %esp,%ebp
80106435:	83 ec 08             	sub    $0x8,%esp
80106438:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010643f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106440:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106447:	c7 04 c5 e2 4c 11 80 	movl   $0x8e000008,-0x7feeb31e(,%eax,8)
8010644e:	08 00 00 8e 
80106452:	66 89 14 c5 e0 4c 11 	mov    %dx,-0x7feeb320(,%eax,8)
80106459:	80 
8010645a:	c1 ea 10             	shr    $0x10,%edx
8010645d:	66 89 14 c5 e6 4c 11 	mov    %dx,-0x7feeb31a(,%eax,8)
80106464:	80 
  for(i = 0; i < 256; i++)
80106465:	83 c0 01             	add    $0x1,%eax
80106468:	3d 00 01 00 00       	cmp    $0x100,%eax
8010646d:	75 d1                	jne    80106440 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010646f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106472:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106477:	c7 05 e2 4e 11 80 08 	movl   $0xef000008,0x80114ee2
8010647e:	00 00 ef 
  initlock(&tickslock, "time");
80106481:	68 32 81 10 80       	push   $0x80108132
80106486:	68 a0 4c 11 80       	push   $0x80114ca0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010648b:	66 a3 e0 4e 11 80    	mov    %ax,0x80114ee0
80106491:	c1 e8 10             	shr    $0x10,%eax
80106494:	66 a3 e6 4e 11 80    	mov    %ax,0x80114ee6
  initlock(&tickslock, "time");
8010649a:	e8 e1 ea ff ff       	call   80104f80 <initlock>
}
8010649f:	83 c4 10             	add    $0x10,%esp
801064a2:	c9                   	leave
801064a3:	c3                   	ret
801064a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064ab:	00 
801064ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801064b0 <idtinit>:

void
idtinit(void)
{
801064b0:	55                   	push   %ebp
  pd[0] = size-1;
801064b1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801064b6:	89 e5                	mov    %esp,%ebp
801064b8:	83 ec 10             	sub    $0x10,%esp
801064bb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801064bf:	b8 e0 4c 11 80       	mov    $0x80114ce0,%eax
801064c4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801064c8:	c1 e8 10             	shr    $0x10,%eax
801064cb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801064cf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801064d2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801064d5:	c9                   	leave
801064d6:	c3                   	ret
801064d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064de:	00 
801064df:	90                   	nop

801064e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	57                   	push   %edi
801064e4:	56                   	push   %esi
801064e5:	53                   	push   %ebx
801064e6:	83 ec 1c             	sub    $0x1c,%esp
801064e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801064ec:	8b 43 30             	mov    0x30(%ebx),%eax
801064ef:	83 f8 40             	cmp    $0x40,%eax
801064f2:	0f 84 58 01 00 00    	je     80106650 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801064f8:	83 e8 20             	sub    $0x20,%eax
801064fb:	83 f8 1f             	cmp    $0x1f,%eax
801064fe:	0f 87 7c 00 00 00    	ja     80106580 <trap+0xa0>
80106504:	ff 24 85 f8 86 10 80 	jmp    *-0x7fef7908(,%eax,4)
8010650b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106510:	e8 eb c8 ff ff       	call   80102e00 <ideintr>
    lapiceoi();
80106515:	e8 a6 cf ff ff       	call   801034c0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010651a:	e8 11 e0 ff ff       	call   80104530 <myproc>
8010651f:	85 c0                	test   %eax,%eax
80106521:	74 1a                	je     8010653d <trap+0x5d>
80106523:	e8 08 e0 ff ff       	call   80104530 <myproc>
80106528:	8b 50 24             	mov    0x24(%eax),%edx
8010652b:	85 d2                	test   %edx,%edx
8010652d:	74 0e                	je     8010653d <trap+0x5d>
8010652f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106533:	f7 d0                	not    %eax
80106535:	a8 03                	test   $0x3,%al
80106537:	0f 84 db 01 00 00    	je     80106718 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
8010653d:	e8 ee df ff ff       	call   80104530 <myproc>
80106542:	85 c0                	test   %eax,%eax
80106544:	74 0f                	je     80106555 <trap+0x75>
80106546:	e8 e5 df ff ff       	call   80104530 <myproc>
8010654b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010654f:	0f 84 ab 00 00 00    	je     80106600 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106555:	e8 d6 df ff ff       	call   80104530 <myproc>
8010655a:	85 c0                	test   %eax,%eax
8010655c:	74 1a                	je     80106578 <trap+0x98>
8010655e:	e8 cd df ff ff       	call   80104530 <myproc>
80106563:	8b 40 24             	mov    0x24(%eax),%eax
80106566:	85 c0                	test   %eax,%eax
80106568:	74 0e                	je     80106578 <trap+0x98>
8010656a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010656e:	f7 d0                	not    %eax
80106570:	a8 03                	test   $0x3,%al
80106572:	0f 84 05 01 00 00    	je     8010667d <trap+0x19d>
    exit();
}
80106578:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010657b:	5b                   	pop    %ebx
8010657c:	5e                   	pop    %esi
8010657d:	5f                   	pop    %edi
8010657e:	5d                   	pop    %ebp
8010657f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80106580:	e8 ab df ff ff       	call   80104530 <myproc>
80106585:	8b 7b 38             	mov    0x38(%ebx),%edi
80106588:	85 c0                	test   %eax,%eax
8010658a:	0f 84 a2 01 00 00    	je     80106732 <trap+0x252>
80106590:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106594:	0f 84 98 01 00 00    	je     80106732 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010659a:	0f 20 d1             	mov    %cr2,%ecx
8010659d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801065a0:	e8 6b df ff ff       	call   80104510 <cpuid>
801065a5:	8b 73 30             	mov    0x30(%ebx),%esi
801065a8:	89 45 dc             	mov    %eax,-0x24(%ebp)
801065ab:	8b 43 34             	mov    0x34(%ebx),%eax
801065ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801065b1:	e8 7a df ff ff       	call   80104530 <myproc>
801065b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801065b9:	e8 72 df ff ff       	call   80104530 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801065be:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801065c1:	51                   	push   %ecx
801065c2:	57                   	push   %edi
801065c3:	8b 55 dc             	mov    -0x24(%ebp),%edx
801065c6:	52                   	push   %edx
801065c7:	ff 75 e4             	push   -0x1c(%ebp)
801065ca:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801065cb:	8b 75 e0             	mov    -0x20(%ebp),%esi
801065ce:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801065d1:	56                   	push   %esi
801065d2:	ff 70 10             	push   0x10(%eax)
801065d5:	68 ec 83 10 80       	push   $0x801083ec
801065da:	e8 41 a3 ff ff       	call   80100920 <cprintf>
    myproc()->killed = 1;
801065df:	83 c4 20             	add    $0x20,%esp
801065e2:	e8 49 df ff ff       	call   80104530 <myproc>
801065e7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065ee:	e8 3d df ff ff       	call   80104530 <myproc>
801065f3:	85 c0                	test   %eax,%eax
801065f5:	0f 85 28 ff ff ff    	jne    80106523 <trap+0x43>
801065fb:	e9 3d ff ff ff       	jmp    8010653d <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80106600:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106604:	0f 85 4b ff ff ff    	jne    80106555 <trap+0x75>
    yield();
8010660a:	e8 91 e5 ff ff       	call   80104ba0 <yield>
8010660f:	e9 41 ff ff ff       	jmp    80106555 <trap+0x75>
80106614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106618:	8b 7b 38             	mov    0x38(%ebx),%edi
8010661b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010661f:	e8 ec de ff ff       	call   80104510 <cpuid>
80106624:	57                   	push   %edi
80106625:	56                   	push   %esi
80106626:	50                   	push   %eax
80106627:	68 94 83 10 80       	push   $0x80108394
8010662c:	e8 ef a2 ff ff       	call   80100920 <cprintf>
    lapiceoi();
80106631:	e8 8a ce ff ff       	call   801034c0 <lapiceoi>
    break;
80106636:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106639:	e8 f2 de ff ff       	call   80104530 <myproc>
8010663e:	85 c0                	test   %eax,%eax
80106640:	0f 85 dd fe ff ff    	jne    80106523 <trap+0x43>
80106646:	e9 f2 fe ff ff       	jmp    8010653d <trap+0x5d>
8010664b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106650:	e8 db de ff ff       	call   80104530 <myproc>
80106655:	8b 70 24             	mov    0x24(%eax),%esi
80106658:	85 f6                	test   %esi,%esi
8010665a:	0f 85 c8 00 00 00    	jne    80106728 <trap+0x248>
    myproc()->tf = tf;
80106660:	e8 cb de ff ff       	call   80104530 <myproc>
80106665:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106668:	e8 f3 ef ff ff       	call   80105660 <syscall>
    if(myproc()->killed)
8010666d:	e8 be de ff ff       	call   80104530 <myproc>
80106672:	8b 48 24             	mov    0x24(%eax),%ecx
80106675:	85 c9                	test   %ecx,%ecx
80106677:	0f 84 fb fe ff ff    	je     80106578 <trap+0x98>
}
8010667d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106680:	5b                   	pop    %ebx
80106681:	5e                   	pop    %esi
80106682:	5f                   	pop    %edi
80106683:	5d                   	pop    %ebp
      exit();
80106684:	e9 b7 e2 ff ff       	jmp    80104940 <exit>
80106689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106690:	e8 4b 02 00 00       	call   801068e0 <uartintr>
    lapiceoi();
80106695:	e8 26 ce ff ff       	call   801034c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010669a:	e8 91 de ff ff       	call   80104530 <myproc>
8010669f:	85 c0                	test   %eax,%eax
801066a1:	0f 85 7c fe ff ff    	jne    80106523 <trap+0x43>
801066a7:	e9 91 fe ff ff       	jmp    8010653d <trap+0x5d>
801066ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801066b0:	e8 db cc ff ff       	call   80103390 <kbdintr>
    lapiceoi();
801066b5:	e8 06 ce ff ff       	call   801034c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066ba:	e8 71 de ff ff       	call   80104530 <myproc>
801066bf:	85 c0                	test   %eax,%eax
801066c1:	0f 85 5c fe ff ff    	jne    80106523 <trap+0x43>
801066c7:	e9 71 fe ff ff       	jmp    8010653d <trap+0x5d>
801066cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801066d0:	e8 3b de ff ff       	call   80104510 <cpuid>
801066d5:	85 c0                	test   %eax,%eax
801066d7:	0f 85 38 fe ff ff    	jne    80106515 <trap+0x35>
      acquire(&tickslock);
801066dd:	83 ec 0c             	sub    $0xc,%esp
801066e0:	68 a0 4c 11 80       	push   $0x80114ca0
801066e5:	e8 86 ea ff ff       	call   80105170 <acquire>
      ticks++;
801066ea:	83 05 80 4c 11 80 01 	addl   $0x1,0x80114c80
      wakeup(&ticks);
801066f1:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
801066f8:	e8 b3 e5 ff ff       	call   80104cb0 <wakeup>
      release(&tickslock);
801066fd:	c7 04 24 a0 4c 11 80 	movl   $0x80114ca0,(%esp)
80106704:	e8 07 ea ff ff       	call   80105110 <release>
80106709:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010670c:	e9 04 fe ff ff       	jmp    80106515 <trap+0x35>
80106711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106718:	e8 23 e2 ff ff       	call   80104940 <exit>
8010671d:	e9 1b fe ff ff       	jmp    8010653d <trap+0x5d>
80106722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106728:	e8 13 e2 ff ff       	call   80104940 <exit>
8010672d:	e9 2e ff ff ff       	jmp    80106660 <trap+0x180>
80106732:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106735:	e8 d6 dd ff ff       	call   80104510 <cpuid>
8010673a:	83 ec 0c             	sub    $0xc,%esp
8010673d:	56                   	push   %esi
8010673e:	57                   	push   %edi
8010673f:	50                   	push   %eax
80106740:	ff 73 30             	push   0x30(%ebx)
80106743:	68 b8 83 10 80       	push   $0x801083b8
80106748:	e8 d3 a1 ff ff       	call   80100920 <cprintf>
      panic("trap");
8010674d:	83 c4 14             	add    $0x14,%esp
80106750:	68 37 81 10 80       	push   $0x80108137
80106755:	e8 16 a4 ff ff       	call   80100b70 <panic>
8010675a:	66 90                	xchg   %ax,%ax
8010675c:	66 90                	xchg   %ax,%ax
8010675e:	66 90                	xchg   %ax,%ax

80106760 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106760:	a1 e0 54 11 80       	mov    0x801154e0,%eax
80106765:	85 c0                	test   %eax,%eax
80106767:	74 17                	je     80106780 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106769:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010676e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010676f:	a8 01                	test   $0x1,%al
80106771:	74 0d                	je     80106780 <uartgetc+0x20>
80106773:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106778:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106779:	0f b6 c0             	movzbl %al,%eax
8010677c:	c3                   	ret
8010677d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106780:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106785:	c3                   	ret
80106786:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010678d:	00 
8010678e:	66 90                	xchg   %ax,%ax

80106790 <uartinit>:
{
80106790:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106791:	31 c9                	xor    %ecx,%ecx
80106793:	89 c8                	mov    %ecx,%eax
80106795:	89 e5                	mov    %esp,%ebp
80106797:	57                   	push   %edi
80106798:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010679d:	56                   	push   %esi
8010679e:	89 fa                	mov    %edi,%edx
801067a0:	53                   	push   %ebx
801067a1:	83 ec 1c             	sub    $0x1c,%esp
801067a4:	ee                   	out    %al,(%dx)
801067a5:	be fb 03 00 00       	mov    $0x3fb,%esi
801067aa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801067af:	89 f2                	mov    %esi,%edx
801067b1:	ee                   	out    %al,(%dx)
801067b2:	b8 0c 00 00 00       	mov    $0xc,%eax
801067b7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067bc:	ee                   	out    %al,(%dx)
801067bd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801067c2:	89 c8                	mov    %ecx,%eax
801067c4:	89 da                	mov    %ebx,%edx
801067c6:	ee                   	out    %al,(%dx)
801067c7:	b8 03 00 00 00       	mov    $0x3,%eax
801067cc:	89 f2                	mov    %esi,%edx
801067ce:	ee                   	out    %al,(%dx)
801067cf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801067d4:	89 c8                	mov    %ecx,%eax
801067d6:	ee                   	out    %al,(%dx)
801067d7:	b8 01 00 00 00       	mov    $0x1,%eax
801067dc:	89 da                	mov    %ebx,%edx
801067de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801067df:	ba fd 03 00 00       	mov    $0x3fd,%edx
801067e4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801067e5:	3c ff                	cmp    $0xff,%al
801067e7:	0f 84 7c 00 00 00    	je     80106869 <uartinit+0xd9>
  uart = 1;
801067ed:	c7 05 e0 54 11 80 01 	movl   $0x1,0x801154e0
801067f4:	00 00 00 
801067f7:	89 fa                	mov    %edi,%edx
801067f9:	ec                   	in     (%dx),%al
801067fa:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067ff:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106800:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106803:	bf 3c 81 10 80       	mov    $0x8010813c,%edi
80106808:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
8010680d:	6a 00                	push   $0x0
8010680f:	6a 04                	push   $0x4
80106811:	e8 1a c8 ff ff       	call   80103030 <ioapicenable>
80106816:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106819:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
8010681d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80106820:	a1 e0 54 11 80       	mov    0x801154e0,%eax
80106825:	85 c0                	test   %eax,%eax
80106827:	74 32                	je     8010685b <uartinit+0xcb>
80106829:	89 f2                	mov    %esi,%edx
8010682b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010682c:	a8 20                	test   $0x20,%al
8010682e:	75 21                	jne    80106851 <uartinit+0xc1>
80106830:	bb 80 00 00 00       	mov    $0x80,%ebx
80106835:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80106838:	83 ec 0c             	sub    $0xc,%esp
8010683b:	6a 0a                	push   $0xa
8010683d:	e8 9e cc ff ff       	call   801034e0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106842:	83 c4 10             	add    $0x10,%esp
80106845:	83 eb 01             	sub    $0x1,%ebx
80106848:	74 07                	je     80106851 <uartinit+0xc1>
8010684a:	89 f2                	mov    %esi,%edx
8010684c:	ec                   	in     (%dx),%al
8010684d:	a8 20                	test   $0x20,%al
8010684f:	74 e7                	je     80106838 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106851:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106856:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010685a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
8010685b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010685f:	83 c7 01             	add    $0x1,%edi
80106862:	88 45 e7             	mov    %al,-0x19(%ebp)
80106865:	84 c0                	test   %al,%al
80106867:	75 b7                	jne    80106820 <uartinit+0x90>
}
80106869:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010686c:	5b                   	pop    %ebx
8010686d:	5e                   	pop    %esi
8010686e:	5f                   	pop    %edi
8010686f:	5d                   	pop    %ebp
80106870:	c3                   	ret
80106871:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106878:	00 
80106879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106880 <uartputc>:
  if(!uart)
80106880:	a1 e0 54 11 80       	mov    0x801154e0,%eax
80106885:	85 c0                	test   %eax,%eax
80106887:	74 4f                	je     801068d8 <uartputc+0x58>
{
80106889:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010688a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010688f:	89 e5                	mov    %esp,%ebp
80106891:	56                   	push   %esi
80106892:	53                   	push   %ebx
80106893:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106894:	a8 20                	test   $0x20,%al
80106896:	75 29                	jne    801068c1 <uartputc+0x41>
80106898:	bb 80 00 00 00       	mov    $0x80,%ebx
8010689d:	be fd 03 00 00       	mov    $0x3fd,%esi
801068a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801068a8:	83 ec 0c             	sub    $0xc,%esp
801068ab:	6a 0a                	push   $0xa
801068ad:	e8 2e cc ff ff       	call   801034e0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801068b2:	83 c4 10             	add    $0x10,%esp
801068b5:	83 eb 01             	sub    $0x1,%ebx
801068b8:	74 07                	je     801068c1 <uartputc+0x41>
801068ba:	89 f2                	mov    %esi,%edx
801068bc:	ec                   	in     (%dx),%al
801068bd:	a8 20                	test   $0x20,%al
801068bf:	74 e7                	je     801068a8 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801068c1:	8b 45 08             	mov    0x8(%ebp),%eax
801068c4:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068c9:	ee                   	out    %al,(%dx)
}
801068ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801068cd:	5b                   	pop    %ebx
801068ce:	5e                   	pop    %esi
801068cf:	5d                   	pop    %ebp
801068d0:	c3                   	ret
801068d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068d8:	c3                   	ret
801068d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801068e0 <uartintr>:

void
uartintr(void)
{
801068e0:	55                   	push   %ebp
801068e1:	89 e5                	mov    %esp,%ebp
801068e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801068e6:	68 60 67 10 80       	push   $0x80106760
801068eb:	e8 a0 a4 ff ff       	call   80100d90 <consoleintr>
}
801068f0:	83 c4 10             	add    $0x10,%esp
801068f3:	c9                   	leave
801068f4:	c3                   	ret

801068f5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801068f5:	6a 00                	push   $0x0
  pushl $0
801068f7:	6a 00                	push   $0x0
  jmp alltraps
801068f9:	e9 0c fb ff ff       	jmp    8010640a <alltraps>

801068fe <vector1>:
.globl vector1
vector1:
  pushl $0
801068fe:	6a 00                	push   $0x0
  pushl $1
80106900:	6a 01                	push   $0x1
  jmp alltraps
80106902:	e9 03 fb ff ff       	jmp    8010640a <alltraps>

80106907 <vector2>:
.globl vector2
vector2:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $2
80106909:	6a 02                	push   $0x2
  jmp alltraps
8010690b:	e9 fa fa ff ff       	jmp    8010640a <alltraps>

80106910 <vector3>:
.globl vector3
vector3:
  pushl $0
80106910:	6a 00                	push   $0x0
  pushl $3
80106912:	6a 03                	push   $0x3
  jmp alltraps
80106914:	e9 f1 fa ff ff       	jmp    8010640a <alltraps>

80106919 <vector4>:
.globl vector4
vector4:
  pushl $0
80106919:	6a 00                	push   $0x0
  pushl $4
8010691b:	6a 04                	push   $0x4
  jmp alltraps
8010691d:	e9 e8 fa ff ff       	jmp    8010640a <alltraps>

80106922 <vector5>:
.globl vector5
vector5:
  pushl $0
80106922:	6a 00                	push   $0x0
  pushl $5
80106924:	6a 05                	push   $0x5
  jmp alltraps
80106926:	e9 df fa ff ff       	jmp    8010640a <alltraps>

8010692b <vector6>:
.globl vector6
vector6:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $6
8010692d:	6a 06                	push   $0x6
  jmp alltraps
8010692f:	e9 d6 fa ff ff       	jmp    8010640a <alltraps>

80106934 <vector7>:
.globl vector7
vector7:
  pushl $0
80106934:	6a 00                	push   $0x0
  pushl $7
80106936:	6a 07                	push   $0x7
  jmp alltraps
80106938:	e9 cd fa ff ff       	jmp    8010640a <alltraps>

8010693d <vector8>:
.globl vector8
vector8:
  pushl $8
8010693d:	6a 08                	push   $0x8
  jmp alltraps
8010693f:	e9 c6 fa ff ff       	jmp    8010640a <alltraps>

80106944 <vector9>:
.globl vector9
vector9:
  pushl $0
80106944:	6a 00                	push   $0x0
  pushl $9
80106946:	6a 09                	push   $0x9
  jmp alltraps
80106948:	e9 bd fa ff ff       	jmp    8010640a <alltraps>

8010694d <vector10>:
.globl vector10
vector10:
  pushl $10
8010694d:	6a 0a                	push   $0xa
  jmp alltraps
8010694f:	e9 b6 fa ff ff       	jmp    8010640a <alltraps>

80106954 <vector11>:
.globl vector11
vector11:
  pushl $11
80106954:	6a 0b                	push   $0xb
  jmp alltraps
80106956:	e9 af fa ff ff       	jmp    8010640a <alltraps>

8010695b <vector12>:
.globl vector12
vector12:
  pushl $12
8010695b:	6a 0c                	push   $0xc
  jmp alltraps
8010695d:	e9 a8 fa ff ff       	jmp    8010640a <alltraps>

80106962 <vector13>:
.globl vector13
vector13:
  pushl $13
80106962:	6a 0d                	push   $0xd
  jmp alltraps
80106964:	e9 a1 fa ff ff       	jmp    8010640a <alltraps>

80106969 <vector14>:
.globl vector14
vector14:
  pushl $14
80106969:	6a 0e                	push   $0xe
  jmp alltraps
8010696b:	e9 9a fa ff ff       	jmp    8010640a <alltraps>

80106970 <vector15>:
.globl vector15
vector15:
  pushl $0
80106970:	6a 00                	push   $0x0
  pushl $15
80106972:	6a 0f                	push   $0xf
  jmp alltraps
80106974:	e9 91 fa ff ff       	jmp    8010640a <alltraps>

80106979 <vector16>:
.globl vector16
vector16:
  pushl $0
80106979:	6a 00                	push   $0x0
  pushl $16
8010697b:	6a 10                	push   $0x10
  jmp alltraps
8010697d:	e9 88 fa ff ff       	jmp    8010640a <alltraps>

80106982 <vector17>:
.globl vector17
vector17:
  pushl $17
80106982:	6a 11                	push   $0x11
  jmp alltraps
80106984:	e9 81 fa ff ff       	jmp    8010640a <alltraps>

80106989 <vector18>:
.globl vector18
vector18:
  pushl $0
80106989:	6a 00                	push   $0x0
  pushl $18
8010698b:	6a 12                	push   $0x12
  jmp alltraps
8010698d:	e9 78 fa ff ff       	jmp    8010640a <alltraps>

80106992 <vector19>:
.globl vector19
vector19:
  pushl $0
80106992:	6a 00                	push   $0x0
  pushl $19
80106994:	6a 13                	push   $0x13
  jmp alltraps
80106996:	e9 6f fa ff ff       	jmp    8010640a <alltraps>

8010699b <vector20>:
.globl vector20
vector20:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $20
8010699d:	6a 14                	push   $0x14
  jmp alltraps
8010699f:	e9 66 fa ff ff       	jmp    8010640a <alltraps>

801069a4 <vector21>:
.globl vector21
vector21:
  pushl $0
801069a4:	6a 00                	push   $0x0
  pushl $21
801069a6:	6a 15                	push   $0x15
  jmp alltraps
801069a8:	e9 5d fa ff ff       	jmp    8010640a <alltraps>

801069ad <vector22>:
.globl vector22
vector22:
  pushl $0
801069ad:	6a 00                	push   $0x0
  pushl $22
801069af:	6a 16                	push   $0x16
  jmp alltraps
801069b1:	e9 54 fa ff ff       	jmp    8010640a <alltraps>

801069b6 <vector23>:
.globl vector23
vector23:
  pushl $0
801069b6:	6a 00                	push   $0x0
  pushl $23
801069b8:	6a 17                	push   $0x17
  jmp alltraps
801069ba:	e9 4b fa ff ff       	jmp    8010640a <alltraps>

801069bf <vector24>:
.globl vector24
vector24:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $24
801069c1:	6a 18                	push   $0x18
  jmp alltraps
801069c3:	e9 42 fa ff ff       	jmp    8010640a <alltraps>

801069c8 <vector25>:
.globl vector25
vector25:
  pushl $0
801069c8:	6a 00                	push   $0x0
  pushl $25
801069ca:	6a 19                	push   $0x19
  jmp alltraps
801069cc:	e9 39 fa ff ff       	jmp    8010640a <alltraps>

801069d1 <vector26>:
.globl vector26
vector26:
  pushl $0
801069d1:	6a 00                	push   $0x0
  pushl $26
801069d3:	6a 1a                	push   $0x1a
  jmp alltraps
801069d5:	e9 30 fa ff ff       	jmp    8010640a <alltraps>

801069da <vector27>:
.globl vector27
vector27:
  pushl $0
801069da:	6a 00                	push   $0x0
  pushl $27
801069dc:	6a 1b                	push   $0x1b
  jmp alltraps
801069de:	e9 27 fa ff ff       	jmp    8010640a <alltraps>

801069e3 <vector28>:
.globl vector28
vector28:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $28
801069e5:	6a 1c                	push   $0x1c
  jmp alltraps
801069e7:	e9 1e fa ff ff       	jmp    8010640a <alltraps>

801069ec <vector29>:
.globl vector29
vector29:
  pushl $0
801069ec:	6a 00                	push   $0x0
  pushl $29
801069ee:	6a 1d                	push   $0x1d
  jmp alltraps
801069f0:	e9 15 fa ff ff       	jmp    8010640a <alltraps>

801069f5 <vector30>:
.globl vector30
vector30:
  pushl $0
801069f5:	6a 00                	push   $0x0
  pushl $30
801069f7:	6a 1e                	push   $0x1e
  jmp alltraps
801069f9:	e9 0c fa ff ff       	jmp    8010640a <alltraps>

801069fe <vector31>:
.globl vector31
vector31:
  pushl $0
801069fe:	6a 00                	push   $0x0
  pushl $31
80106a00:	6a 1f                	push   $0x1f
  jmp alltraps
80106a02:	e9 03 fa ff ff       	jmp    8010640a <alltraps>

80106a07 <vector32>:
.globl vector32
vector32:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $32
80106a09:	6a 20                	push   $0x20
  jmp alltraps
80106a0b:	e9 fa f9 ff ff       	jmp    8010640a <alltraps>

80106a10 <vector33>:
.globl vector33
vector33:
  pushl $0
80106a10:	6a 00                	push   $0x0
  pushl $33
80106a12:	6a 21                	push   $0x21
  jmp alltraps
80106a14:	e9 f1 f9 ff ff       	jmp    8010640a <alltraps>

80106a19 <vector34>:
.globl vector34
vector34:
  pushl $0
80106a19:	6a 00                	push   $0x0
  pushl $34
80106a1b:	6a 22                	push   $0x22
  jmp alltraps
80106a1d:	e9 e8 f9 ff ff       	jmp    8010640a <alltraps>

80106a22 <vector35>:
.globl vector35
vector35:
  pushl $0
80106a22:	6a 00                	push   $0x0
  pushl $35
80106a24:	6a 23                	push   $0x23
  jmp alltraps
80106a26:	e9 df f9 ff ff       	jmp    8010640a <alltraps>

80106a2b <vector36>:
.globl vector36
vector36:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $36
80106a2d:	6a 24                	push   $0x24
  jmp alltraps
80106a2f:	e9 d6 f9 ff ff       	jmp    8010640a <alltraps>

80106a34 <vector37>:
.globl vector37
vector37:
  pushl $0
80106a34:	6a 00                	push   $0x0
  pushl $37
80106a36:	6a 25                	push   $0x25
  jmp alltraps
80106a38:	e9 cd f9 ff ff       	jmp    8010640a <alltraps>

80106a3d <vector38>:
.globl vector38
vector38:
  pushl $0
80106a3d:	6a 00                	push   $0x0
  pushl $38
80106a3f:	6a 26                	push   $0x26
  jmp alltraps
80106a41:	e9 c4 f9 ff ff       	jmp    8010640a <alltraps>

80106a46 <vector39>:
.globl vector39
vector39:
  pushl $0
80106a46:	6a 00                	push   $0x0
  pushl $39
80106a48:	6a 27                	push   $0x27
  jmp alltraps
80106a4a:	e9 bb f9 ff ff       	jmp    8010640a <alltraps>

80106a4f <vector40>:
.globl vector40
vector40:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $40
80106a51:	6a 28                	push   $0x28
  jmp alltraps
80106a53:	e9 b2 f9 ff ff       	jmp    8010640a <alltraps>

80106a58 <vector41>:
.globl vector41
vector41:
  pushl $0
80106a58:	6a 00                	push   $0x0
  pushl $41
80106a5a:	6a 29                	push   $0x29
  jmp alltraps
80106a5c:	e9 a9 f9 ff ff       	jmp    8010640a <alltraps>

80106a61 <vector42>:
.globl vector42
vector42:
  pushl $0
80106a61:	6a 00                	push   $0x0
  pushl $42
80106a63:	6a 2a                	push   $0x2a
  jmp alltraps
80106a65:	e9 a0 f9 ff ff       	jmp    8010640a <alltraps>

80106a6a <vector43>:
.globl vector43
vector43:
  pushl $0
80106a6a:	6a 00                	push   $0x0
  pushl $43
80106a6c:	6a 2b                	push   $0x2b
  jmp alltraps
80106a6e:	e9 97 f9 ff ff       	jmp    8010640a <alltraps>

80106a73 <vector44>:
.globl vector44
vector44:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $44
80106a75:	6a 2c                	push   $0x2c
  jmp alltraps
80106a77:	e9 8e f9 ff ff       	jmp    8010640a <alltraps>

80106a7c <vector45>:
.globl vector45
vector45:
  pushl $0
80106a7c:	6a 00                	push   $0x0
  pushl $45
80106a7e:	6a 2d                	push   $0x2d
  jmp alltraps
80106a80:	e9 85 f9 ff ff       	jmp    8010640a <alltraps>

80106a85 <vector46>:
.globl vector46
vector46:
  pushl $0
80106a85:	6a 00                	push   $0x0
  pushl $46
80106a87:	6a 2e                	push   $0x2e
  jmp alltraps
80106a89:	e9 7c f9 ff ff       	jmp    8010640a <alltraps>

80106a8e <vector47>:
.globl vector47
vector47:
  pushl $0
80106a8e:	6a 00                	push   $0x0
  pushl $47
80106a90:	6a 2f                	push   $0x2f
  jmp alltraps
80106a92:	e9 73 f9 ff ff       	jmp    8010640a <alltraps>

80106a97 <vector48>:
.globl vector48
vector48:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $48
80106a99:	6a 30                	push   $0x30
  jmp alltraps
80106a9b:	e9 6a f9 ff ff       	jmp    8010640a <alltraps>

80106aa0 <vector49>:
.globl vector49
vector49:
  pushl $0
80106aa0:	6a 00                	push   $0x0
  pushl $49
80106aa2:	6a 31                	push   $0x31
  jmp alltraps
80106aa4:	e9 61 f9 ff ff       	jmp    8010640a <alltraps>

80106aa9 <vector50>:
.globl vector50
vector50:
  pushl $0
80106aa9:	6a 00                	push   $0x0
  pushl $50
80106aab:	6a 32                	push   $0x32
  jmp alltraps
80106aad:	e9 58 f9 ff ff       	jmp    8010640a <alltraps>

80106ab2 <vector51>:
.globl vector51
vector51:
  pushl $0
80106ab2:	6a 00                	push   $0x0
  pushl $51
80106ab4:	6a 33                	push   $0x33
  jmp alltraps
80106ab6:	e9 4f f9 ff ff       	jmp    8010640a <alltraps>

80106abb <vector52>:
.globl vector52
vector52:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $52
80106abd:	6a 34                	push   $0x34
  jmp alltraps
80106abf:	e9 46 f9 ff ff       	jmp    8010640a <alltraps>

80106ac4 <vector53>:
.globl vector53
vector53:
  pushl $0
80106ac4:	6a 00                	push   $0x0
  pushl $53
80106ac6:	6a 35                	push   $0x35
  jmp alltraps
80106ac8:	e9 3d f9 ff ff       	jmp    8010640a <alltraps>

80106acd <vector54>:
.globl vector54
vector54:
  pushl $0
80106acd:	6a 00                	push   $0x0
  pushl $54
80106acf:	6a 36                	push   $0x36
  jmp alltraps
80106ad1:	e9 34 f9 ff ff       	jmp    8010640a <alltraps>

80106ad6 <vector55>:
.globl vector55
vector55:
  pushl $0
80106ad6:	6a 00                	push   $0x0
  pushl $55
80106ad8:	6a 37                	push   $0x37
  jmp alltraps
80106ada:	e9 2b f9 ff ff       	jmp    8010640a <alltraps>

80106adf <vector56>:
.globl vector56
vector56:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $56
80106ae1:	6a 38                	push   $0x38
  jmp alltraps
80106ae3:	e9 22 f9 ff ff       	jmp    8010640a <alltraps>

80106ae8 <vector57>:
.globl vector57
vector57:
  pushl $0
80106ae8:	6a 00                	push   $0x0
  pushl $57
80106aea:	6a 39                	push   $0x39
  jmp alltraps
80106aec:	e9 19 f9 ff ff       	jmp    8010640a <alltraps>

80106af1 <vector58>:
.globl vector58
vector58:
  pushl $0
80106af1:	6a 00                	push   $0x0
  pushl $58
80106af3:	6a 3a                	push   $0x3a
  jmp alltraps
80106af5:	e9 10 f9 ff ff       	jmp    8010640a <alltraps>

80106afa <vector59>:
.globl vector59
vector59:
  pushl $0
80106afa:	6a 00                	push   $0x0
  pushl $59
80106afc:	6a 3b                	push   $0x3b
  jmp alltraps
80106afe:	e9 07 f9 ff ff       	jmp    8010640a <alltraps>

80106b03 <vector60>:
.globl vector60
vector60:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $60
80106b05:	6a 3c                	push   $0x3c
  jmp alltraps
80106b07:	e9 fe f8 ff ff       	jmp    8010640a <alltraps>

80106b0c <vector61>:
.globl vector61
vector61:
  pushl $0
80106b0c:	6a 00                	push   $0x0
  pushl $61
80106b0e:	6a 3d                	push   $0x3d
  jmp alltraps
80106b10:	e9 f5 f8 ff ff       	jmp    8010640a <alltraps>

80106b15 <vector62>:
.globl vector62
vector62:
  pushl $0
80106b15:	6a 00                	push   $0x0
  pushl $62
80106b17:	6a 3e                	push   $0x3e
  jmp alltraps
80106b19:	e9 ec f8 ff ff       	jmp    8010640a <alltraps>

80106b1e <vector63>:
.globl vector63
vector63:
  pushl $0
80106b1e:	6a 00                	push   $0x0
  pushl $63
80106b20:	6a 3f                	push   $0x3f
  jmp alltraps
80106b22:	e9 e3 f8 ff ff       	jmp    8010640a <alltraps>

80106b27 <vector64>:
.globl vector64
vector64:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $64
80106b29:	6a 40                	push   $0x40
  jmp alltraps
80106b2b:	e9 da f8 ff ff       	jmp    8010640a <alltraps>

80106b30 <vector65>:
.globl vector65
vector65:
  pushl $0
80106b30:	6a 00                	push   $0x0
  pushl $65
80106b32:	6a 41                	push   $0x41
  jmp alltraps
80106b34:	e9 d1 f8 ff ff       	jmp    8010640a <alltraps>

80106b39 <vector66>:
.globl vector66
vector66:
  pushl $0
80106b39:	6a 00                	push   $0x0
  pushl $66
80106b3b:	6a 42                	push   $0x42
  jmp alltraps
80106b3d:	e9 c8 f8 ff ff       	jmp    8010640a <alltraps>

80106b42 <vector67>:
.globl vector67
vector67:
  pushl $0
80106b42:	6a 00                	push   $0x0
  pushl $67
80106b44:	6a 43                	push   $0x43
  jmp alltraps
80106b46:	e9 bf f8 ff ff       	jmp    8010640a <alltraps>

80106b4b <vector68>:
.globl vector68
vector68:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $68
80106b4d:	6a 44                	push   $0x44
  jmp alltraps
80106b4f:	e9 b6 f8 ff ff       	jmp    8010640a <alltraps>

80106b54 <vector69>:
.globl vector69
vector69:
  pushl $0
80106b54:	6a 00                	push   $0x0
  pushl $69
80106b56:	6a 45                	push   $0x45
  jmp alltraps
80106b58:	e9 ad f8 ff ff       	jmp    8010640a <alltraps>

80106b5d <vector70>:
.globl vector70
vector70:
  pushl $0
80106b5d:	6a 00                	push   $0x0
  pushl $70
80106b5f:	6a 46                	push   $0x46
  jmp alltraps
80106b61:	e9 a4 f8 ff ff       	jmp    8010640a <alltraps>

80106b66 <vector71>:
.globl vector71
vector71:
  pushl $0
80106b66:	6a 00                	push   $0x0
  pushl $71
80106b68:	6a 47                	push   $0x47
  jmp alltraps
80106b6a:	e9 9b f8 ff ff       	jmp    8010640a <alltraps>

80106b6f <vector72>:
.globl vector72
vector72:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $72
80106b71:	6a 48                	push   $0x48
  jmp alltraps
80106b73:	e9 92 f8 ff ff       	jmp    8010640a <alltraps>

80106b78 <vector73>:
.globl vector73
vector73:
  pushl $0
80106b78:	6a 00                	push   $0x0
  pushl $73
80106b7a:	6a 49                	push   $0x49
  jmp alltraps
80106b7c:	e9 89 f8 ff ff       	jmp    8010640a <alltraps>

80106b81 <vector74>:
.globl vector74
vector74:
  pushl $0
80106b81:	6a 00                	push   $0x0
  pushl $74
80106b83:	6a 4a                	push   $0x4a
  jmp alltraps
80106b85:	e9 80 f8 ff ff       	jmp    8010640a <alltraps>

80106b8a <vector75>:
.globl vector75
vector75:
  pushl $0
80106b8a:	6a 00                	push   $0x0
  pushl $75
80106b8c:	6a 4b                	push   $0x4b
  jmp alltraps
80106b8e:	e9 77 f8 ff ff       	jmp    8010640a <alltraps>

80106b93 <vector76>:
.globl vector76
vector76:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $76
80106b95:	6a 4c                	push   $0x4c
  jmp alltraps
80106b97:	e9 6e f8 ff ff       	jmp    8010640a <alltraps>

80106b9c <vector77>:
.globl vector77
vector77:
  pushl $0
80106b9c:	6a 00                	push   $0x0
  pushl $77
80106b9e:	6a 4d                	push   $0x4d
  jmp alltraps
80106ba0:	e9 65 f8 ff ff       	jmp    8010640a <alltraps>

80106ba5 <vector78>:
.globl vector78
vector78:
  pushl $0
80106ba5:	6a 00                	push   $0x0
  pushl $78
80106ba7:	6a 4e                	push   $0x4e
  jmp alltraps
80106ba9:	e9 5c f8 ff ff       	jmp    8010640a <alltraps>

80106bae <vector79>:
.globl vector79
vector79:
  pushl $0
80106bae:	6a 00                	push   $0x0
  pushl $79
80106bb0:	6a 4f                	push   $0x4f
  jmp alltraps
80106bb2:	e9 53 f8 ff ff       	jmp    8010640a <alltraps>

80106bb7 <vector80>:
.globl vector80
vector80:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $80
80106bb9:	6a 50                	push   $0x50
  jmp alltraps
80106bbb:	e9 4a f8 ff ff       	jmp    8010640a <alltraps>

80106bc0 <vector81>:
.globl vector81
vector81:
  pushl $0
80106bc0:	6a 00                	push   $0x0
  pushl $81
80106bc2:	6a 51                	push   $0x51
  jmp alltraps
80106bc4:	e9 41 f8 ff ff       	jmp    8010640a <alltraps>

80106bc9 <vector82>:
.globl vector82
vector82:
  pushl $0
80106bc9:	6a 00                	push   $0x0
  pushl $82
80106bcb:	6a 52                	push   $0x52
  jmp alltraps
80106bcd:	e9 38 f8 ff ff       	jmp    8010640a <alltraps>

80106bd2 <vector83>:
.globl vector83
vector83:
  pushl $0
80106bd2:	6a 00                	push   $0x0
  pushl $83
80106bd4:	6a 53                	push   $0x53
  jmp alltraps
80106bd6:	e9 2f f8 ff ff       	jmp    8010640a <alltraps>

80106bdb <vector84>:
.globl vector84
vector84:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $84
80106bdd:	6a 54                	push   $0x54
  jmp alltraps
80106bdf:	e9 26 f8 ff ff       	jmp    8010640a <alltraps>

80106be4 <vector85>:
.globl vector85
vector85:
  pushl $0
80106be4:	6a 00                	push   $0x0
  pushl $85
80106be6:	6a 55                	push   $0x55
  jmp alltraps
80106be8:	e9 1d f8 ff ff       	jmp    8010640a <alltraps>

80106bed <vector86>:
.globl vector86
vector86:
  pushl $0
80106bed:	6a 00                	push   $0x0
  pushl $86
80106bef:	6a 56                	push   $0x56
  jmp alltraps
80106bf1:	e9 14 f8 ff ff       	jmp    8010640a <alltraps>

80106bf6 <vector87>:
.globl vector87
vector87:
  pushl $0
80106bf6:	6a 00                	push   $0x0
  pushl $87
80106bf8:	6a 57                	push   $0x57
  jmp alltraps
80106bfa:	e9 0b f8 ff ff       	jmp    8010640a <alltraps>

80106bff <vector88>:
.globl vector88
vector88:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $88
80106c01:	6a 58                	push   $0x58
  jmp alltraps
80106c03:	e9 02 f8 ff ff       	jmp    8010640a <alltraps>

80106c08 <vector89>:
.globl vector89
vector89:
  pushl $0
80106c08:	6a 00                	push   $0x0
  pushl $89
80106c0a:	6a 59                	push   $0x59
  jmp alltraps
80106c0c:	e9 f9 f7 ff ff       	jmp    8010640a <alltraps>

80106c11 <vector90>:
.globl vector90
vector90:
  pushl $0
80106c11:	6a 00                	push   $0x0
  pushl $90
80106c13:	6a 5a                	push   $0x5a
  jmp alltraps
80106c15:	e9 f0 f7 ff ff       	jmp    8010640a <alltraps>

80106c1a <vector91>:
.globl vector91
vector91:
  pushl $0
80106c1a:	6a 00                	push   $0x0
  pushl $91
80106c1c:	6a 5b                	push   $0x5b
  jmp alltraps
80106c1e:	e9 e7 f7 ff ff       	jmp    8010640a <alltraps>

80106c23 <vector92>:
.globl vector92
vector92:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $92
80106c25:	6a 5c                	push   $0x5c
  jmp alltraps
80106c27:	e9 de f7 ff ff       	jmp    8010640a <alltraps>

80106c2c <vector93>:
.globl vector93
vector93:
  pushl $0
80106c2c:	6a 00                	push   $0x0
  pushl $93
80106c2e:	6a 5d                	push   $0x5d
  jmp alltraps
80106c30:	e9 d5 f7 ff ff       	jmp    8010640a <alltraps>

80106c35 <vector94>:
.globl vector94
vector94:
  pushl $0
80106c35:	6a 00                	push   $0x0
  pushl $94
80106c37:	6a 5e                	push   $0x5e
  jmp alltraps
80106c39:	e9 cc f7 ff ff       	jmp    8010640a <alltraps>

80106c3e <vector95>:
.globl vector95
vector95:
  pushl $0
80106c3e:	6a 00                	push   $0x0
  pushl $95
80106c40:	6a 5f                	push   $0x5f
  jmp alltraps
80106c42:	e9 c3 f7 ff ff       	jmp    8010640a <alltraps>

80106c47 <vector96>:
.globl vector96
vector96:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $96
80106c49:	6a 60                	push   $0x60
  jmp alltraps
80106c4b:	e9 ba f7 ff ff       	jmp    8010640a <alltraps>

80106c50 <vector97>:
.globl vector97
vector97:
  pushl $0
80106c50:	6a 00                	push   $0x0
  pushl $97
80106c52:	6a 61                	push   $0x61
  jmp alltraps
80106c54:	e9 b1 f7 ff ff       	jmp    8010640a <alltraps>

80106c59 <vector98>:
.globl vector98
vector98:
  pushl $0
80106c59:	6a 00                	push   $0x0
  pushl $98
80106c5b:	6a 62                	push   $0x62
  jmp alltraps
80106c5d:	e9 a8 f7 ff ff       	jmp    8010640a <alltraps>

80106c62 <vector99>:
.globl vector99
vector99:
  pushl $0
80106c62:	6a 00                	push   $0x0
  pushl $99
80106c64:	6a 63                	push   $0x63
  jmp alltraps
80106c66:	e9 9f f7 ff ff       	jmp    8010640a <alltraps>

80106c6b <vector100>:
.globl vector100
vector100:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $100
80106c6d:	6a 64                	push   $0x64
  jmp alltraps
80106c6f:	e9 96 f7 ff ff       	jmp    8010640a <alltraps>

80106c74 <vector101>:
.globl vector101
vector101:
  pushl $0
80106c74:	6a 00                	push   $0x0
  pushl $101
80106c76:	6a 65                	push   $0x65
  jmp alltraps
80106c78:	e9 8d f7 ff ff       	jmp    8010640a <alltraps>

80106c7d <vector102>:
.globl vector102
vector102:
  pushl $0
80106c7d:	6a 00                	push   $0x0
  pushl $102
80106c7f:	6a 66                	push   $0x66
  jmp alltraps
80106c81:	e9 84 f7 ff ff       	jmp    8010640a <alltraps>

80106c86 <vector103>:
.globl vector103
vector103:
  pushl $0
80106c86:	6a 00                	push   $0x0
  pushl $103
80106c88:	6a 67                	push   $0x67
  jmp alltraps
80106c8a:	e9 7b f7 ff ff       	jmp    8010640a <alltraps>

80106c8f <vector104>:
.globl vector104
vector104:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $104
80106c91:	6a 68                	push   $0x68
  jmp alltraps
80106c93:	e9 72 f7 ff ff       	jmp    8010640a <alltraps>

80106c98 <vector105>:
.globl vector105
vector105:
  pushl $0
80106c98:	6a 00                	push   $0x0
  pushl $105
80106c9a:	6a 69                	push   $0x69
  jmp alltraps
80106c9c:	e9 69 f7 ff ff       	jmp    8010640a <alltraps>

80106ca1 <vector106>:
.globl vector106
vector106:
  pushl $0
80106ca1:	6a 00                	push   $0x0
  pushl $106
80106ca3:	6a 6a                	push   $0x6a
  jmp alltraps
80106ca5:	e9 60 f7 ff ff       	jmp    8010640a <alltraps>

80106caa <vector107>:
.globl vector107
vector107:
  pushl $0
80106caa:	6a 00                	push   $0x0
  pushl $107
80106cac:	6a 6b                	push   $0x6b
  jmp alltraps
80106cae:	e9 57 f7 ff ff       	jmp    8010640a <alltraps>

80106cb3 <vector108>:
.globl vector108
vector108:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $108
80106cb5:	6a 6c                	push   $0x6c
  jmp alltraps
80106cb7:	e9 4e f7 ff ff       	jmp    8010640a <alltraps>

80106cbc <vector109>:
.globl vector109
vector109:
  pushl $0
80106cbc:	6a 00                	push   $0x0
  pushl $109
80106cbe:	6a 6d                	push   $0x6d
  jmp alltraps
80106cc0:	e9 45 f7 ff ff       	jmp    8010640a <alltraps>

80106cc5 <vector110>:
.globl vector110
vector110:
  pushl $0
80106cc5:	6a 00                	push   $0x0
  pushl $110
80106cc7:	6a 6e                	push   $0x6e
  jmp alltraps
80106cc9:	e9 3c f7 ff ff       	jmp    8010640a <alltraps>

80106cce <vector111>:
.globl vector111
vector111:
  pushl $0
80106cce:	6a 00                	push   $0x0
  pushl $111
80106cd0:	6a 6f                	push   $0x6f
  jmp alltraps
80106cd2:	e9 33 f7 ff ff       	jmp    8010640a <alltraps>

80106cd7 <vector112>:
.globl vector112
vector112:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $112
80106cd9:	6a 70                	push   $0x70
  jmp alltraps
80106cdb:	e9 2a f7 ff ff       	jmp    8010640a <alltraps>

80106ce0 <vector113>:
.globl vector113
vector113:
  pushl $0
80106ce0:	6a 00                	push   $0x0
  pushl $113
80106ce2:	6a 71                	push   $0x71
  jmp alltraps
80106ce4:	e9 21 f7 ff ff       	jmp    8010640a <alltraps>

80106ce9 <vector114>:
.globl vector114
vector114:
  pushl $0
80106ce9:	6a 00                	push   $0x0
  pushl $114
80106ceb:	6a 72                	push   $0x72
  jmp alltraps
80106ced:	e9 18 f7 ff ff       	jmp    8010640a <alltraps>

80106cf2 <vector115>:
.globl vector115
vector115:
  pushl $0
80106cf2:	6a 00                	push   $0x0
  pushl $115
80106cf4:	6a 73                	push   $0x73
  jmp alltraps
80106cf6:	e9 0f f7 ff ff       	jmp    8010640a <alltraps>

80106cfb <vector116>:
.globl vector116
vector116:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $116
80106cfd:	6a 74                	push   $0x74
  jmp alltraps
80106cff:	e9 06 f7 ff ff       	jmp    8010640a <alltraps>

80106d04 <vector117>:
.globl vector117
vector117:
  pushl $0
80106d04:	6a 00                	push   $0x0
  pushl $117
80106d06:	6a 75                	push   $0x75
  jmp alltraps
80106d08:	e9 fd f6 ff ff       	jmp    8010640a <alltraps>

80106d0d <vector118>:
.globl vector118
vector118:
  pushl $0
80106d0d:	6a 00                	push   $0x0
  pushl $118
80106d0f:	6a 76                	push   $0x76
  jmp alltraps
80106d11:	e9 f4 f6 ff ff       	jmp    8010640a <alltraps>

80106d16 <vector119>:
.globl vector119
vector119:
  pushl $0
80106d16:	6a 00                	push   $0x0
  pushl $119
80106d18:	6a 77                	push   $0x77
  jmp alltraps
80106d1a:	e9 eb f6 ff ff       	jmp    8010640a <alltraps>

80106d1f <vector120>:
.globl vector120
vector120:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $120
80106d21:	6a 78                	push   $0x78
  jmp alltraps
80106d23:	e9 e2 f6 ff ff       	jmp    8010640a <alltraps>

80106d28 <vector121>:
.globl vector121
vector121:
  pushl $0
80106d28:	6a 00                	push   $0x0
  pushl $121
80106d2a:	6a 79                	push   $0x79
  jmp alltraps
80106d2c:	e9 d9 f6 ff ff       	jmp    8010640a <alltraps>

80106d31 <vector122>:
.globl vector122
vector122:
  pushl $0
80106d31:	6a 00                	push   $0x0
  pushl $122
80106d33:	6a 7a                	push   $0x7a
  jmp alltraps
80106d35:	e9 d0 f6 ff ff       	jmp    8010640a <alltraps>

80106d3a <vector123>:
.globl vector123
vector123:
  pushl $0
80106d3a:	6a 00                	push   $0x0
  pushl $123
80106d3c:	6a 7b                	push   $0x7b
  jmp alltraps
80106d3e:	e9 c7 f6 ff ff       	jmp    8010640a <alltraps>

80106d43 <vector124>:
.globl vector124
vector124:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $124
80106d45:	6a 7c                	push   $0x7c
  jmp alltraps
80106d47:	e9 be f6 ff ff       	jmp    8010640a <alltraps>

80106d4c <vector125>:
.globl vector125
vector125:
  pushl $0
80106d4c:	6a 00                	push   $0x0
  pushl $125
80106d4e:	6a 7d                	push   $0x7d
  jmp alltraps
80106d50:	e9 b5 f6 ff ff       	jmp    8010640a <alltraps>

80106d55 <vector126>:
.globl vector126
vector126:
  pushl $0
80106d55:	6a 00                	push   $0x0
  pushl $126
80106d57:	6a 7e                	push   $0x7e
  jmp alltraps
80106d59:	e9 ac f6 ff ff       	jmp    8010640a <alltraps>

80106d5e <vector127>:
.globl vector127
vector127:
  pushl $0
80106d5e:	6a 00                	push   $0x0
  pushl $127
80106d60:	6a 7f                	push   $0x7f
  jmp alltraps
80106d62:	e9 a3 f6 ff ff       	jmp    8010640a <alltraps>

80106d67 <vector128>:
.globl vector128
vector128:
  pushl $0
80106d67:	6a 00                	push   $0x0
  pushl $128
80106d69:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106d6e:	e9 97 f6 ff ff       	jmp    8010640a <alltraps>

80106d73 <vector129>:
.globl vector129
vector129:
  pushl $0
80106d73:	6a 00                	push   $0x0
  pushl $129
80106d75:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106d7a:	e9 8b f6 ff ff       	jmp    8010640a <alltraps>

80106d7f <vector130>:
.globl vector130
vector130:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $130
80106d81:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106d86:	e9 7f f6 ff ff       	jmp    8010640a <alltraps>

80106d8b <vector131>:
.globl vector131
vector131:
  pushl $0
80106d8b:	6a 00                	push   $0x0
  pushl $131
80106d8d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106d92:	e9 73 f6 ff ff       	jmp    8010640a <alltraps>

80106d97 <vector132>:
.globl vector132
vector132:
  pushl $0
80106d97:	6a 00                	push   $0x0
  pushl $132
80106d99:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106d9e:	e9 67 f6 ff ff       	jmp    8010640a <alltraps>

80106da3 <vector133>:
.globl vector133
vector133:
  pushl $0
80106da3:	6a 00                	push   $0x0
  pushl $133
80106da5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106daa:	e9 5b f6 ff ff       	jmp    8010640a <alltraps>

80106daf <vector134>:
.globl vector134
vector134:
  pushl $0
80106daf:	6a 00                	push   $0x0
  pushl $134
80106db1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106db6:	e9 4f f6 ff ff       	jmp    8010640a <alltraps>

80106dbb <vector135>:
.globl vector135
vector135:
  pushl $0
80106dbb:	6a 00                	push   $0x0
  pushl $135
80106dbd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106dc2:	e9 43 f6 ff ff       	jmp    8010640a <alltraps>

80106dc7 <vector136>:
.globl vector136
vector136:
  pushl $0
80106dc7:	6a 00                	push   $0x0
  pushl $136
80106dc9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106dce:	e9 37 f6 ff ff       	jmp    8010640a <alltraps>

80106dd3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106dd3:	6a 00                	push   $0x0
  pushl $137
80106dd5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106dda:	e9 2b f6 ff ff       	jmp    8010640a <alltraps>

80106ddf <vector138>:
.globl vector138
vector138:
  pushl $0
80106ddf:	6a 00                	push   $0x0
  pushl $138
80106de1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106de6:	e9 1f f6 ff ff       	jmp    8010640a <alltraps>

80106deb <vector139>:
.globl vector139
vector139:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $139
80106ded:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106df2:	e9 13 f6 ff ff       	jmp    8010640a <alltraps>

80106df7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106df7:	6a 00                	push   $0x0
  pushl $140
80106df9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106dfe:	e9 07 f6 ff ff       	jmp    8010640a <alltraps>

80106e03 <vector141>:
.globl vector141
vector141:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $141
80106e05:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106e0a:	e9 fb f5 ff ff       	jmp    8010640a <alltraps>

80106e0f <vector142>:
.globl vector142
vector142:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $142
80106e11:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106e16:	e9 ef f5 ff ff       	jmp    8010640a <alltraps>

80106e1b <vector143>:
.globl vector143
vector143:
  pushl $0
80106e1b:	6a 00                	push   $0x0
  pushl $143
80106e1d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106e22:	e9 e3 f5 ff ff       	jmp    8010640a <alltraps>

80106e27 <vector144>:
.globl vector144
vector144:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $144
80106e29:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106e2e:	e9 d7 f5 ff ff       	jmp    8010640a <alltraps>

80106e33 <vector145>:
.globl vector145
vector145:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $145
80106e35:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106e3a:	e9 cb f5 ff ff       	jmp    8010640a <alltraps>

80106e3f <vector146>:
.globl vector146
vector146:
  pushl $0
80106e3f:	6a 00                	push   $0x0
  pushl $146
80106e41:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106e46:	e9 bf f5 ff ff       	jmp    8010640a <alltraps>

80106e4b <vector147>:
.globl vector147
vector147:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $147
80106e4d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106e52:	e9 b3 f5 ff ff       	jmp    8010640a <alltraps>

80106e57 <vector148>:
.globl vector148
vector148:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $148
80106e59:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106e5e:	e9 a7 f5 ff ff       	jmp    8010640a <alltraps>

80106e63 <vector149>:
.globl vector149
vector149:
  pushl $0
80106e63:	6a 00                	push   $0x0
  pushl $149
80106e65:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106e6a:	e9 9b f5 ff ff       	jmp    8010640a <alltraps>

80106e6f <vector150>:
.globl vector150
vector150:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $150
80106e71:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106e76:	e9 8f f5 ff ff       	jmp    8010640a <alltraps>

80106e7b <vector151>:
.globl vector151
vector151:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $151
80106e7d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106e82:	e9 83 f5 ff ff       	jmp    8010640a <alltraps>

80106e87 <vector152>:
.globl vector152
vector152:
  pushl $0
80106e87:	6a 00                	push   $0x0
  pushl $152
80106e89:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106e8e:	e9 77 f5 ff ff       	jmp    8010640a <alltraps>

80106e93 <vector153>:
.globl vector153
vector153:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $153
80106e95:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106e9a:	e9 6b f5 ff ff       	jmp    8010640a <alltraps>

80106e9f <vector154>:
.globl vector154
vector154:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $154
80106ea1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106ea6:	e9 5f f5 ff ff       	jmp    8010640a <alltraps>

80106eab <vector155>:
.globl vector155
vector155:
  pushl $0
80106eab:	6a 00                	push   $0x0
  pushl $155
80106ead:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106eb2:	e9 53 f5 ff ff       	jmp    8010640a <alltraps>

80106eb7 <vector156>:
.globl vector156
vector156:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $156
80106eb9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106ebe:	e9 47 f5 ff ff       	jmp    8010640a <alltraps>

80106ec3 <vector157>:
.globl vector157
vector157:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $157
80106ec5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106eca:	e9 3b f5 ff ff       	jmp    8010640a <alltraps>

80106ecf <vector158>:
.globl vector158
vector158:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $158
80106ed1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106ed6:	e9 2f f5 ff ff       	jmp    8010640a <alltraps>

80106edb <vector159>:
.globl vector159
vector159:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $159
80106edd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106ee2:	e9 23 f5 ff ff       	jmp    8010640a <alltraps>

80106ee7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $160
80106ee9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106eee:	e9 17 f5 ff ff       	jmp    8010640a <alltraps>

80106ef3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ef3:	6a 00                	push   $0x0
  pushl $161
80106ef5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106efa:	e9 0b f5 ff ff       	jmp    8010640a <alltraps>

80106eff <vector162>:
.globl vector162
vector162:
  pushl $0
80106eff:	6a 00                	push   $0x0
  pushl $162
80106f01:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106f06:	e9 ff f4 ff ff       	jmp    8010640a <alltraps>

80106f0b <vector163>:
.globl vector163
vector163:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $163
80106f0d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106f12:	e9 f3 f4 ff ff       	jmp    8010640a <alltraps>

80106f17 <vector164>:
.globl vector164
vector164:
  pushl $0
80106f17:	6a 00                	push   $0x0
  pushl $164
80106f19:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106f1e:	e9 e7 f4 ff ff       	jmp    8010640a <alltraps>

80106f23 <vector165>:
.globl vector165
vector165:
  pushl $0
80106f23:	6a 00                	push   $0x0
  pushl $165
80106f25:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106f2a:	e9 db f4 ff ff       	jmp    8010640a <alltraps>

80106f2f <vector166>:
.globl vector166
vector166:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $166
80106f31:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106f36:	e9 cf f4 ff ff       	jmp    8010640a <alltraps>

80106f3b <vector167>:
.globl vector167
vector167:
  pushl $0
80106f3b:	6a 00                	push   $0x0
  pushl $167
80106f3d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106f42:	e9 c3 f4 ff ff       	jmp    8010640a <alltraps>

80106f47 <vector168>:
.globl vector168
vector168:
  pushl $0
80106f47:	6a 00                	push   $0x0
  pushl $168
80106f49:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106f4e:	e9 b7 f4 ff ff       	jmp    8010640a <alltraps>

80106f53 <vector169>:
.globl vector169
vector169:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $169
80106f55:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106f5a:	e9 ab f4 ff ff       	jmp    8010640a <alltraps>

80106f5f <vector170>:
.globl vector170
vector170:
  pushl $0
80106f5f:	6a 00                	push   $0x0
  pushl $170
80106f61:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106f66:	e9 9f f4 ff ff       	jmp    8010640a <alltraps>

80106f6b <vector171>:
.globl vector171
vector171:
  pushl $0
80106f6b:	6a 00                	push   $0x0
  pushl $171
80106f6d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106f72:	e9 93 f4 ff ff       	jmp    8010640a <alltraps>

80106f77 <vector172>:
.globl vector172
vector172:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $172
80106f79:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106f7e:	e9 87 f4 ff ff       	jmp    8010640a <alltraps>

80106f83 <vector173>:
.globl vector173
vector173:
  pushl $0
80106f83:	6a 00                	push   $0x0
  pushl $173
80106f85:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106f8a:	e9 7b f4 ff ff       	jmp    8010640a <alltraps>

80106f8f <vector174>:
.globl vector174
vector174:
  pushl $0
80106f8f:	6a 00                	push   $0x0
  pushl $174
80106f91:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106f96:	e9 6f f4 ff ff       	jmp    8010640a <alltraps>

80106f9b <vector175>:
.globl vector175
vector175:
  pushl $0
80106f9b:	6a 00                	push   $0x0
  pushl $175
80106f9d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106fa2:	e9 63 f4 ff ff       	jmp    8010640a <alltraps>

80106fa7 <vector176>:
.globl vector176
vector176:
  pushl $0
80106fa7:	6a 00                	push   $0x0
  pushl $176
80106fa9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106fae:	e9 57 f4 ff ff       	jmp    8010640a <alltraps>

80106fb3 <vector177>:
.globl vector177
vector177:
  pushl $0
80106fb3:	6a 00                	push   $0x0
  pushl $177
80106fb5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106fba:	e9 4b f4 ff ff       	jmp    8010640a <alltraps>

80106fbf <vector178>:
.globl vector178
vector178:
  pushl $0
80106fbf:	6a 00                	push   $0x0
  pushl $178
80106fc1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106fc6:	e9 3f f4 ff ff       	jmp    8010640a <alltraps>

80106fcb <vector179>:
.globl vector179
vector179:
  pushl $0
80106fcb:	6a 00                	push   $0x0
  pushl $179
80106fcd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106fd2:	e9 33 f4 ff ff       	jmp    8010640a <alltraps>

80106fd7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106fd7:	6a 00                	push   $0x0
  pushl $180
80106fd9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106fde:	e9 27 f4 ff ff       	jmp    8010640a <alltraps>

80106fe3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106fe3:	6a 00                	push   $0x0
  pushl $181
80106fe5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106fea:	e9 1b f4 ff ff       	jmp    8010640a <alltraps>

80106fef <vector182>:
.globl vector182
vector182:
  pushl $0
80106fef:	6a 00                	push   $0x0
  pushl $182
80106ff1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106ff6:	e9 0f f4 ff ff       	jmp    8010640a <alltraps>

80106ffb <vector183>:
.globl vector183
vector183:
  pushl $0
80106ffb:	6a 00                	push   $0x0
  pushl $183
80106ffd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107002:	e9 03 f4 ff ff       	jmp    8010640a <alltraps>

80107007 <vector184>:
.globl vector184
vector184:
  pushl $0
80107007:	6a 00                	push   $0x0
  pushl $184
80107009:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010700e:	e9 f7 f3 ff ff       	jmp    8010640a <alltraps>

80107013 <vector185>:
.globl vector185
vector185:
  pushl $0
80107013:	6a 00                	push   $0x0
  pushl $185
80107015:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010701a:	e9 eb f3 ff ff       	jmp    8010640a <alltraps>

8010701f <vector186>:
.globl vector186
vector186:
  pushl $0
8010701f:	6a 00                	push   $0x0
  pushl $186
80107021:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107026:	e9 df f3 ff ff       	jmp    8010640a <alltraps>

8010702b <vector187>:
.globl vector187
vector187:
  pushl $0
8010702b:	6a 00                	push   $0x0
  pushl $187
8010702d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107032:	e9 d3 f3 ff ff       	jmp    8010640a <alltraps>

80107037 <vector188>:
.globl vector188
vector188:
  pushl $0
80107037:	6a 00                	push   $0x0
  pushl $188
80107039:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010703e:	e9 c7 f3 ff ff       	jmp    8010640a <alltraps>

80107043 <vector189>:
.globl vector189
vector189:
  pushl $0
80107043:	6a 00                	push   $0x0
  pushl $189
80107045:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010704a:	e9 bb f3 ff ff       	jmp    8010640a <alltraps>

8010704f <vector190>:
.globl vector190
vector190:
  pushl $0
8010704f:	6a 00                	push   $0x0
  pushl $190
80107051:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107056:	e9 af f3 ff ff       	jmp    8010640a <alltraps>

8010705b <vector191>:
.globl vector191
vector191:
  pushl $0
8010705b:	6a 00                	push   $0x0
  pushl $191
8010705d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107062:	e9 a3 f3 ff ff       	jmp    8010640a <alltraps>

80107067 <vector192>:
.globl vector192
vector192:
  pushl $0
80107067:	6a 00                	push   $0x0
  pushl $192
80107069:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010706e:	e9 97 f3 ff ff       	jmp    8010640a <alltraps>

80107073 <vector193>:
.globl vector193
vector193:
  pushl $0
80107073:	6a 00                	push   $0x0
  pushl $193
80107075:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010707a:	e9 8b f3 ff ff       	jmp    8010640a <alltraps>

8010707f <vector194>:
.globl vector194
vector194:
  pushl $0
8010707f:	6a 00                	push   $0x0
  pushl $194
80107081:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107086:	e9 7f f3 ff ff       	jmp    8010640a <alltraps>

8010708b <vector195>:
.globl vector195
vector195:
  pushl $0
8010708b:	6a 00                	push   $0x0
  pushl $195
8010708d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107092:	e9 73 f3 ff ff       	jmp    8010640a <alltraps>

80107097 <vector196>:
.globl vector196
vector196:
  pushl $0
80107097:	6a 00                	push   $0x0
  pushl $196
80107099:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010709e:	e9 67 f3 ff ff       	jmp    8010640a <alltraps>

801070a3 <vector197>:
.globl vector197
vector197:
  pushl $0
801070a3:	6a 00                	push   $0x0
  pushl $197
801070a5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801070aa:	e9 5b f3 ff ff       	jmp    8010640a <alltraps>

801070af <vector198>:
.globl vector198
vector198:
  pushl $0
801070af:	6a 00                	push   $0x0
  pushl $198
801070b1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801070b6:	e9 4f f3 ff ff       	jmp    8010640a <alltraps>

801070bb <vector199>:
.globl vector199
vector199:
  pushl $0
801070bb:	6a 00                	push   $0x0
  pushl $199
801070bd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801070c2:	e9 43 f3 ff ff       	jmp    8010640a <alltraps>

801070c7 <vector200>:
.globl vector200
vector200:
  pushl $0
801070c7:	6a 00                	push   $0x0
  pushl $200
801070c9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801070ce:	e9 37 f3 ff ff       	jmp    8010640a <alltraps>

801070d3 <vector201>:
.globl vector201
vector201:
  pushl $0
801070d3:	6a 00                	push   $0x0
  pushl $201
801070d5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801070da:	e9 2b f3 ff ff       	jmp    8010640a <alltraps>

801070df <vector202>:
.globl vector202
vector202:
  pushl $0
801070df:	6a 00                	push   $0x0
  pushl $202
801070e1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801070e6:	e9 1f f3 ff ff       	jmp    8010640a <alltraps>

801070eb <vector203>:
.globl vector203
vector203:
  pushl $0
801070eb:	6a 00                	push   $0x0
  pushl $203
801070ed:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801070f2:	e9 13 f3 ff ff       	jmp    8010640a <alltraps>

801070f7 <vector204>:
.globl vector204
vector204:
  pushl $0
801070f7:	6a 00                	push   $0x0
  pushl $204
801070f9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801070fe:	e9 07 f3 ff ff       	jmp    8010640a <alltraps>

80107103 <vector205>:
.globl vector205
vector205:
  pushl $0
80107103:	6a 00                	push   $0x0
  pushl $205
80107105:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010710a:	e9 fb f2 ff ff       	jmp    8010640a <alltraps>

8010710f <vector206>:
.globl vector206
vector206:
  pushl $0
8010710f:	6a 00                	push   $0x0
  pushl $206
80107111:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107116:	e9 ef f2 ff ff       	jmp    8010640a <alltraps>

8010711b <vector207>:
.globl vector207
vector207:
  pushl $0
8010711b:	6a 00                	push   $0x0
  pushl $207
8010711d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107122:	e9 e3 f2 ff ff       	jmp    8010640a <alltraps>

80107127 <vector208>:
.globl vector208
vector208:
  pushl $0
80107127:	6a 00                	push   $0x0
  pushl $208
80107129:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010712e:	e9 d7 f2 ff ff       	jmp    8010640a <alltraps>

80107133 <vector209>:
.globl vector209
vector209:
  pushl $0
80107133:	6a 00                	push   $0x0
  pushl $209
80107135:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010713a:	e9 cb f2 ff ff       	jmp    8010640a <alltraps>

8010713f <vector210>:
.globl vector210
vector210:
  pushl $0
8010713f:	6a 00                	push   $0x0
  pushl $210
80107141:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107146:	e9 bf f2 ff ff       	jmp    8010640a <alltraps>

8010714b <vector211>:
.globl vector211
vector211:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $211
8010714d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107152:	e9 b3 f2 ff ff       	jmp    8010640a <alltraps>

80107157 <vector212>:
.globl vector212
vector212:
  pushl $0
80107157:	6a 00                	push   $0x0
  pushl $212
80107159:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010715e:	e9 a7 f2 ff ff       	jmp    8010640a <alltraps>

80107163 <vector213>:
.globl vector213
vector213:
  pushl $0
80107163:	6a 00                	push   $0x0
  pushl $213
80107165:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010716a:	e9 9b f2 ff ff       	jmp    8010640a <alltraps>

8010716f <vector214>:
.globl vector214
vector214:
  pushl $0
8010716f:	6a 00                	push   $0x0
  pushl $214
80107171:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107176:	e9 8f f2 ff ff       	jmp    8010640a <alltraps>

8010717b <vector215>:
.globl vector215
vector215:
  pushl $0
8010717b:	6a 00                	push   $0x0
  pushl $215
8010717d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107182:	e9 83 f2 ff ff       	jmp    8010640a <alltraps>

80107187 <vector216>:
.globl vector216
vector216:
  pushl $0
80107187:	6a 00                	push   $0x0
  pushl $216
80107189:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010718e:	e9 77 f2 ff ff       	jmp    8010640a <alltraps>

80107193 <vector217>:
.globl vector217
vector217:
  pushl $0
80107193:	6a 00                	push   $0x0
  pushl $217
80107195:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010719a:	e9 6b f2 ff ff       	jmp    8010640a <alltraps>

8010719f <vector218>:
.globl vector218
vector218:
  pushl $0
8010719f:	6a 00                	push   $0x0
  pushl $218
801071a1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801071a6:	e9 5f f2 ff ff       	jmp    8010640a <alltraps>

801071ab <vector219>:
.globl vector219
vector219:
  pushl $0
801071ab:	6a 00                	push   $0x0
  pushl $219
801071ad:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801071b2:	e9 53 f2 ff ff       	jmp    8010640a <alltraps>

801071b7 <vector220>:
.globl vector220
vector220:
  pushl $0
801071b7:	6a 00                	push   $0x0
  pushl $220
801071b9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801071be:	e9 47 f2 ff ff       	jmp    8010640a <alltraps>

801071c3 <vector221>:
.globl vector221
vector221:
  pushl $0
801071c3:	6a 00                	push   $0x0
  pushl $221
801071c5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801071ca:	e9 3b f2 ff ff       	jmp    8010640a <alltraps>

801071cf <vector222>:
.globl vector222
vector222:
  pushl $0
801071cf:	6a 00                	push   $0x0
  pushl $222
801071d1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801071d6:	e9 2f f2 ff ff       	jmp    8010640a <alltraps>

801071db <vector223>:
.globl vector223
vector223:
  pushl $0
801071db:	6a 00                	push   $0x0
  pushl $223
801071dd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801071e2:	e9 23 f2 ff ff       	jmp    8010640a <alltraps>

801071e7 <vector224>:
.globl vector224
vector224:
  pushl $0
801071e7:	6a 00                	push   $0x0
  pushl $224
801071e9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801071ee:	e9 17 f2 ff ff       	jmp    8010640a <alltraps>

801071f3 <vector225>:
.globl vector225
vector225:
  pushl $0
801071f3:	6a 00                	push   $0x0
  pushl $225
801071f5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801071fa:	e9 0b f2 ff ff       	jmp    8010640a <alltraps>

801071ff <vector226>:
.globl vector226
vector226:
  pushl $0
801071ff:	6a 00                	push   $0x0
  pushl $226
80107201:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107206:	e9 ff f1 ff ff       	jmp    8010640a <alltraps>

8010720b <vector227>:
.globl vector227
vector227:
  pushl $0
8010720b:	6a 00                	push   $0x0
  pushl $227
8010720d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107212:	e9 f3 f1 ff ff       	jmp    8010640a <alltraps>

80107217 <vector228>:
.globl vector228
vector228:
  pushl $0
80107217:	6a 00                	push   $0x0
  pushl $228
80107219:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010721e:	e9 e7 f1 ff ff       	jmp    8010640a <alltraps>

80107223 <vector229>:
.globl vector229
vector229:
  pushl $0
80107223:	6a 00                	push   $0x0
  pushl $229
80107225:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010722a:	e9 db f1 ff ff       	jmp    8010640a <alltraps>

8010722f <vector230>:
.globl vector230
vector230:
  pushl $0
8010722f:	6a 00                	push   $0x0
  pushl $230
80107231:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107236:	e9 cf f1 ff ff       	jmp    8010640a <alltraps>

8010723b <vector231>:
.globl vector231
vector231:
  pushl $0
8010723b:	6a 00                	push   $0x0
  pushl $231
8010723d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107242:	e9 c3 f1 ff ff       	jmp    8010640a <alltraps>

80107247 <vector232>:
.globl vector232
vector232:
  pushl $0
80107247:	6a 00                	push   $0x0
  pushl $232
80107249:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010724e:	e9 b7 f1 ff ff       	jmp    8010640a <alltraps>

80107253 <vector233>:
.globl vector233
vector233:
  pushl $0
80107253:	6a 00                	push   $0x0
  pushl $233
80107255:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010725a:	e9 ab f1 ff ff       	jmp    8010640a <alltraps>

8010725f <vector234>:
.globl vector234
vector234:
  pushl $0
8010725f:	6a 00                	push   $0x0
  pushl $234
80107261:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107266:	e9 9f f1 ff ff       	jmp    8010640a <alltraps>

8010726b <vector235>:
.globl vector235
vector235:
  pushl $0
8010726b:	6a 00                	push   $0x0
  pushl $235
8010726d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107272:	e9 93 f1 ff ff       	jmp    8010640a <alltraps>

80107277 <vector236>:
.globl vector236
vector236:
  pushl $0
80107277:	6a 00                	push   $0x0
  pushl $236
80107279:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010727e:	e9 87 f1 ff ff       	jmp    8010640a <alltraps>

80107283 <vector237>:
.globl vector237
vector237:
  pushl $0
80107283:	6a 00                	push   $0x0
  pushl $237
80107285:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010728a:	e9 7b f1 ff ff       	jmp    8010640a <alltraps>

8010728f <vector238>:
.globl vector238
vector238:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $238
80107291:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107296:	e9 6f f1 ff ff       	jmp    8010640a <alltraps>

8010729b <vector239>:
.globl vector239
vector239:
  pushl $0
8010729b:	6a 00                	push   $0x0
  pushl $239
8010729d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801072a2:	e9 63 f1 ff ff       	jmp    8010640a <alltraps>

801072a7 <vector240>:
.globl vector240
vector240:
  pushl $0
801072a7:	6a 00                	push   $0x0
  pushl $240
801072a9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801072ae:	e9 57 f1 ff ff       	jmp    8010640a <alltraps>

801072b3 <vector241>:
.globl vector241
vector241:
  pushl $0
801072b3:	6a 00                	push   $0x0
  pushl $241
801072b5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801072ba:	e9 4b f1 ff ff       	jmp    8010640a <alltraps>

801072bf <vector242>:
.globl vector242
vector242:
  pushl $0
801072bf:	6a 00                	push   $0x0
  pushl $242
801072c1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801072c6:	e9 3f f1 ff ff       	jmp    8010640a <alltraps>

801072cb <vector243>:
.globl vector243
vector243:
  pushl $0
801072cb:	6a 00                	push   $0x0
  pushl $243
801072cd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801072d2:	e9 33 f1 ff ff       	jmp    8010640a <alltraps>

801072d7 <vector244>:
.globl vector244
vector244:
  pushl $0
801072d7:	6a 00                	push   $0x0
  pushl $244
801072d9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801072de:	e9 27 f1 ff ff       	jmp    8010640a <alltraps>

801072e3 <vector245>:
.globl vector245
vector245:
  pushl $0
801072e3:	6a 00                	push   $0x0
  pushl $245
801072e5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801072ea:	e9 1b f1 ff ff       	jmp    8010640a <alltraps>

801072ef <vector246>:
.globl vector246
vector246:
  pushl $0
801072ef:	6a 00                	push   $0x0
  pushl $246
801072f1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801072f6:	e9 0f f1 ff ff       	jmp    8010640a <alltraps>

801072fb <vector247>:
.globl vector247
vector247:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $247
801072fd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107302:	e9 03 f1 ff ff       	jmp    8010640a <alltraps>

80107307 <vector248>:
.globl vector248
vector248:
  pushl $0
80107307:	6a 00                	push   $0x0
  pushl $248
80107309:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010730e:	e9 f7 f0 ff ff       	jmp    8010640a <alltraps>

80107313 <vector249>:
.globl vector249
vector249:
  pushl $0
80107313:	6a 00                	push   $0x0
  pushl $249
80107315:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010731a:	e9 eb f0 ff ff       	jmp    8010640a <alltraps>

8010731f <vector250>:
.globl vector250
vector250:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $250
80107321:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107326:	e9 df f0 ff ff       	jmp    8010640a <alltraps>

8010732b <vector251>:
.globl vector251
vector251:
  pushl $0
8010732b:	6a 00                	push   $0x0
  pushl $251
8010732d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107332:	e9 d3 f0 ff ff       	jmp    8010640a <alltraps>

80107337 <vector252>:
.globl vector252
vector252:
  pushl $0
80107337:	6a 00                	push   $0x0
  pushl $252
80107339:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010733e:	e9 c7 f0 ff ff       	jmp    8010640a <alltraps>

80107343 <vector253>:
.globl vector253
vector253:
  pushl $0
80107343:	6a 00                	push   $0x0
  pushl $253
80107345:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010734a:	e9 bb f0 ff ff       	jmp    8010640a <alltraps>

8010734f <vector254>:
.globl vector254
vector254:
  pushl $0
8010734f:	6a 00                	push   $0x0
  pushl $254
80107351:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107356:	e9 af f0 ff ff       	jmp    8010640a <alltraps>

8010735b <vector255>:
.globl vector255
vector255:
  pushl $0
8010735b:	6a 00                	push   $0x0
  pushl $255
8010735d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107362:	e9 a3 f0 ff ff       	jmp    8010640a <alltraps>
80107367:	66 90                	xchg   %ax,%ax
80107369:	66 90                	xchg   %ax,%ax
8010736b:	66 90                	xchg   %ax,%ax
8010736d:	66 90                	xchg   %ax,%ax
8010736f:	90                   	nop

80107370 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	57                   	push   %edi
80107374:	56                   	push   %esi
80107375:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107376:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010737c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107382:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80107385:	39 d3                	cmp    %edx,%ebx
80107387:	73 56                	jae    801073df <deallocuvm.part.0+0x6f>
80107389:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010738c:	89 c6                	mov    %eax,%esi
8010738e:	89 d7                	mov    %edx,%edi
80107390:	eb 12                	jmp    801073a4 <deallocuvm.part.0+0x34>
80107392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107398:	83 c2 01             	add    $0x1,%edx
8010739b:	89 d3                	mov    %edx,%ebx
8010739d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
801073a0:	39 fb                	cmp    %edi,%ebx
801073a2:	73 38                	jae    801073dc <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
801073a4:	89 da                	mov    %ebx,%edx
801073a6:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801073a9:	8b 04 96             	mov    (%esi,%edx,4),%eax
801073ac:	a8 01                	test   $0x1,%al
801073ae:	74 e8                	je     80107398 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
801073b0:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801073b7:	c1 e9 0a             	shr    $0xa,%ecx
801073ba:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
801073c0:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
801073c7:	85 c0                	test   %eax,%eax
801073c9:	74 cd                	je     80107398 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
801073cb:	8b 10                	mov    (%eax),%edx
801073cd:	f6 c2 01             	test   $0x1,%dl
801073d0:	75 1e                	jne    801073f0 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
801073d2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801073d8:	39 fb                	cmp    %edi,%ebx
801073da:	72 c8                	jb     801073a4 <deallocuvm.part.0+0x34>
801073dc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801073df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073e2:	89 c8                	mov    %ecx,%eax
801073e4:	5b                   	pop    %ebx
801073e5:	5e                   	pop    %esi
801073e6:	5f                   	pop    %edi
801073e7:	5d                   	pop    %ebp
801073e8:	c3                   	ret
801073e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
801073f0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801073f6:	74 26                	je     8010741e <deallocuvm.part.0+0xae>
      kfree(v);
801073f8:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801073fb:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107401:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107404:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
8010740a:	52                   	push   %edx
8010740b:	e8 60 bc ff ff       	call   80103070 <kfree>
      *pte = 0;
80107410:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80107413:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80107416:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010741c:	eb 82                	jmp    801073a0 <deallocuvm.part.0+0x30>
        panic("kfree");
8010741e:	83 ec 0c             	sub    $0xc,%esp
80107421:	68 10 7f 10 80       	push   $0x80107f10
80107426:	e8 45 97 ff ff       	call   80100b70 <panic>
8010742b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107430 <mappages>:
{
80107430:	55                   	push   %ebp
80107431:	89 e5                	mov    %esp,%ebp
80107433:	57                   	push   %edi
80107434:	56                   	push   %esi
80107435:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107436:	89 d3                	mov    %edx,%ebx
80107438:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010743e:	83 ec 1c             	sub    $0x1c,%esp
80107441:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107444:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107448:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010744d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107450:	8b 45 08             	mov    0x8(%ebp),%eax
80107453:	29 d8                	sub    %ebx,%eax
80107455:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107458:	eb 3f                	jmp    80107499 <mappages+0x69>
8010745a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107460:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107462:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107467:	c1 ea 0a             	shr    $0xa,%edx
8010746a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107470:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107477:	85 c0                	test   %eax,%eax
80107479:	74 75                	je     801074f0 <mappages+0xc0>
    if(*pte & PTE_P)
8010747b:	f6 00 01             	testb  $0x1,(%eax)
8010747e:	0f 85 86 00 00 00    	jne    8010750a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107484:	0b 75 0c             	or     0xc(%ebp),%esi
80107487:	83 ce 01             	or     $0x1,%esi
8010748a:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010748c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010748f:	39 c3                	cmp    %eax,%ebx
80107491:	74 6d                	je     80107500 <mappages+0xd0>
    a += PGSIZE;
80107493:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107499:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010749c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010749f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
801074a2:	89 d8                	mov    %ebx,%eax
801074a4:	c1 e8 16             	shr    $0x16,%eax
801074a7:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801074aa:	8b 07                	mov    (%edi),%eax
801074ac:	a8 01                	test   $0x1,%al
801074ae:	75 b0                	jne    80107460 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801074b0:	e8 7b bd ff ff       	call   80103230 <kalloc>
801074b5:	85 c0                	test   %eax,%eax
801074b7:	74 37                	je     801074f0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
801074b9:	83 ec 04             	sub    $0x4,%esp
801074bc:	68 00 10 00 00       	push   $0x1000
801074c1:	6a 00                	push   $0x0
801074c3:	50                   	push   %eax
801074c4:	89 45 d8             	mov    %eax,-0x28(%ebp)
801074c7:	e8 a4 dd ff ff       	call   80105270 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801074cc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
801074cf:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801074d2:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801074d8:	83 c8 07             	or     $0x7,%eax
801074db:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801074dd:	89 d8                	mov    %ebx,%eax
801074df:	c1 e8 0a             	shr    $0xa,%eax
801074e2:	25 fc 0f 00 00       	and    $0xffc,%eax
801074e7:	01 d0                	add    %edx,%eax
801074e9:	eb 90                	jmp    8010747b <mappages+0x4b>
801074eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
801074f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801074f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801074f8:	5b                   	pop    %ebx
801074f9:	5e                   	pop    %esi
801074fa:	5f                   	pop    %edi
801074fb:	5d                   	pop    %ebp
801074fc:	c3                   	ret
801074fd:	8d 76 00             	lea    0x0(%esi),%esi
80107500:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107503:	31 c0                	xor    %eax,%eax
}
80107505:	5b                   	pop    %ebx
80107506:	5e                   	pop    %esi
80107507:	5f                   	pop    %edi
80107508:	5d                   	pop    %ebp
80107509:	c3                   	ret
      panic("remap");
8010750a:	83 ec 0c             	sub    $0xc,%esp
8010750d:	68 44 81 10 80       	push   $0x80108144
80107512:	e8 59 96 ff ff       	call   80100b70 <panic>
80107517:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010751e:	00 
8010751f:	90                   	nop

80107520 <seginit>:
{
80107520:	55                   	push   %ebp
80107521:	89 e5                	mov    %esp,%ebp
80107523:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107526:	e8 e5 cf ff ff       	call   80104510 <cpuid>
  pd[0] = size-1;
8010752b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107530:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107536:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
8010753a:	c7 80 38 28 11 80 ff 	movl   $0xffff,-0x7feed7c8(%eax)
80107541:	ff 00 00 
80107544:	c7 80 3c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7c4(%eax)
8010754b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010754e:	c7 80 40 28 11 80 ff 	movl   $0xffff,-0x7feed7c0(%eax)
80107555:	ff 00 00 
80107558:	c7 80 44 28 11 80 00 	movl   $0xcf9200,-0x7feed7bc(%eax)
8010755f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107562:	c7 80 48 28 11 80 ff 	movl   $0xffff,-0x7feed7b8(%eax)
80107569:	ff 00 00 
8010756c:	c7 80 4c 28 11 80 00 	movl   $0xcffa00,-0x7feed7b4(%eax)
80107573:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107576:	c7 80 50 28 11 80 ff 	movl   $0xffff,-0x7feed7b0(%eax)
8010757d:	ff 00 00 
80107580:	c7 80 54 28 11 80 00 	movl   $0xcff200,-0x7feed7ac(%eax)
80107587:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010758a:	05 30 28 11 80       	add    $0x80112830,%eax
  pd[1] = (uint)p;
8010758f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107593:	c1 e8 10             	shr    $0x10,%eax
80107596:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010759a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010759d:	0f 01 10             	lgdtl  (%eax)
}
801075a0:	c9                   	leave
801075a1:	c3                   	ret
801075a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801075a9:	00 
801075aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801075b0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801075b0:	a1 e4 54 11 80       	mov    0x801154e4,%eax
801075b5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801075ba:	0f 22 d8             	mov    %eax,%cr3
}
801075bd:	c3                   	ret
801075be:	66 90                	xchg   %ax,%ax

801075c0 <switchuvm>:
{
801075c0:	55                   	push   %ebp
801075c1:	89 e5                	mov    %esp,%ebp
801075c3:	57                   	push   %edi
801075c4:	56                   	push   %esi
801075c5:	53                   	push   %ebx
801075c6:	83 ec 1c             	sub    $0x1c,%esp
801075c9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801075cc:	85 f6                	test   %esi,%esi
801075ce:	0f 84 cb 00 00 00    	je     8010769f <switchuvm+0xdf>
  if(p->kstack == 0)
801075d4:	8b 46 08             	mov    0x8(%esi),%eax
801075d7:	85 c0                	test   %eax,%eax
801075d9:	0f 84 da 00 00 00    	je     801076b9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801075df:	8b 46 04             	mov    0x4(%esi),%eax
801075e2:	85 c0                	test   %eax,%eax
801075e4:	0f 84 c2 00 00 00    	je     801076ac <switchuvm+0xec>
  pushcli();
801075ea:	e8 31 da ff ff       	call   80105020 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801075ef:	e8 bc ce ff ff       	call   801044b0 <mycpu>
801075f4:	89 c3                	mov    %eax,%ebx
801075f6:	e8 b5 ce ff ff       	call   801044b0 <mycpu>
801075fb:	89 c7                	mov    %eax,%edi
801075fd:	e8 ae ce ff ff       	call   801044b0 <mycpu>
80107602:	83 c7 08             	add    $0x8,%edi
80107605:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107608:	e8 a3 ce ff ff       	call   801044b0 <mycpu>
8010760d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107610:	ba 67 00 00 00       	mov    $0x67,%edx
80107615:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010761c:	83 c0 08             	add    $0x8,%eax
8010761f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107626:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010762b:	83 c1 08             	add    $0x8,%ecx
8010762e:	c1 e8 18             	shr    $0x18,%eax
80107631:	c1 e9 10             	shr    $0x10,%ecx
80107634:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010763a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107640:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107645:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010764c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107651:	e8 5a ce ff ff       	call   801044b0 <mycpu>
80107656:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010765d:	e8 4e ce ff ff       	call   801044b0 <mycpu>
80107662:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107666:	8b 5e 08             	mov    0x8(%esi),%ebx
80107669:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010766f:	e8 3c ce ff ff       	call   801044b0 <mycpu>
80107674:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107677:	e8 34 ce ff ff       	call   801044b0 <mycpu>
8010767c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107680:	b8 28 00 00 00       	mov    $0x28,%eax
80107685:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107688:	8b 46 04             	mov    0x4(%esi),%eax
8010768b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107690:	0f 22 d8             	mov    %eax,%cr3
}
80107693:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107696:	5b                   	pop    %ebx
80107697:	5e                   	pop    %esi
80107698:	5f                   	pop    %edi
80107699:	5d                   	pop    %ebp
  popcli();
8010769a:	e9 d1 d9 ff ff       	jmp    80105070 <popcli>
    panic("switchuvm: no process");
8010769f:	83 ec 0c             	sub    $0xc,%esp
801076a2:	68 4a 81 10 80       	push   $0x8010814a
801076a7:	e8 c4 94 ff ff       	call   80100b70 <panic>
    panic("switchuvm: no pgdir");
801076ac:	83 ec 0c             	sub    $0xc,%esp
801076af:	68 75 81 10 80       	push   $0x80108175
801076b4:	e8 b7 94 ff ff       	call   80100b70 <panic>
    panic("switchuvm: no kstack");
801076b9:	83 ec 0c             	sub    $0xc,%esp
801076bc:	68 60 81 10 80       	push   $0x80108160
801076c1:	e8 aa 94 ff ff       	call   80100b70 <panic>
801076c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801076cd:	00 
801076ce:	66 90                	xchg   %ax,%ax

801076d0 <inituvm>:
{
801076d0:	55                   	push   %ebp
801076d1:	89 e5                	mov    %esp,%ebp
801076d3:	57                   	push   %edi
801076d4:	56                   	push   %esi
801076d5:	53                   	push   %ebx
801076d6:	83 ec 1c             	sub    $0x1c,%esp
801076d9:	8b 45 08             	mov    0x8(%ebp),%eax
801076dc:	8b 75 10             	mov    0x10(%ebp),%esi
801076df:	8b 7d 0c             	mov    0xc(%ebp),%edi
801076e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801076e5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801076eb:	77 49                	ja     80107736 <inituvm+0x66>
  mem = kalloc();
801076ed:	e8 3e bb ff ff       	call   80103230 <kalloc>
  memset(mem, 0, PGSIZE);
801076f2:	83 ec 04             	sub    $0x4,%esp
801076f5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801076fa:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801076fc:	6a 00                	push   $0x0
801076fe:	50                   	push   %eax
801076ff:	e8 6c db ff ff       	call   80105270 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107704:	58                   	pop    %eax
80107705:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010770b:	5a                   	pop    %edx
8010770c:	6a 06                	push   $0x6
8010770e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107713:	31 d2                	xor    %edx,%edx
80107715:	50                   	push   %eax
80107716:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107719:	e8 12 fd ff ff       	call   80107430 <mappages>
  memmove(mem, init, sz);
8010771e:	83 c4 10             	add    $0x10,%esp
80107721:	89 75 10             	mov    %esi,0x10(%ebp)
80107724:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107727:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010772a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010772d:	5b                   	pop    %ebx
8010772e:	5e                   	pop    %esi
8010772f:	5f                   	pop    %edi
80107730:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107731:	e9 ca db ff ff       	jmp    80105300 <memmove>
    panic("inituvm: more than a page");
80107736:	83 ec 0c             	sub    $0xc,%esp
80107739:	68 89 81 10 80       	push   $0x80108189
8010773e:	e8 2d 94 ff ff       	call   80100b70 <panic>
80107743:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010774a:	00 
8010774b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107750 <loaduvm>:
{
80107750:	55                   	push   %ebp
80107751:	89 e5                	mov    %esp,%ebp
80107753:	57                   	push   %edi
80107754:	56                   	push   %esi
80107755:	53                   	push   %ebx
80107756:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107759:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010775c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010775f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107765:	0f 85 a2 00 00 00    	jne    8010780d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
8010776b:	85 ff                	test   %edi,%edi
8010776d:	74 7d                	je     801077ec <loaduvm+0x9c>
8010776f:	90                   	nop
  pde = &pgdir[PDX(va)];
80107770:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107773:	8b 55 08             	mov    0x8(%ebp),%edx
80107776:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80107778:	89 c1                	mov    %eax,%ecx
8010777a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010777d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107780:	f6 c1 01             	test   $0x1,%cl
80107783:	75 13                	jne    80107798 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80107785:	83 ec 0c             	sub    $0xc,%esp
80107788:	68 a3 81 10 80       	push   $0x801081a3
8010778d:	e8 de 93 ff ff       	call   80100b70 <panic>
80107792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107798:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010779b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801077a1:	25 fc 0f 00 00       	and    $0xffc,%eax
801077a6:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801077ad:	85 c9                	test   %ecx,%ecx
801077af:	74 d4                	je     80107785 <loaduvm+0x35>
    if(sz - i < PGSIZE)
801077b1:	89 fb                	mov    %edi,%ebx
801077b3:	b8 00 10 00 00       	mov    $0x1000,%eax
801077b8:	29 f3                	sub    %esi,%ebx
801077ba:	39 c3                	cmp    %eax,%ebx
801077bc:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
801077bf:	53                   	push   %ebx
801077c0:	8b 45 14             	mov    0x14(%ebp),%eax
801077c3:	01 f0                	add    %esi,%eax
801077c5:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
801077c6:	8b 01                	mov    (%ecx),%eax
801077c8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801077cd:	05 00 00 00 80       	add    $0x80000000,%eax
801077d2:	50                   	push   %eax
801077d3:	ff 75 10             	push   0x10(%ebp)
801077d6:	e8 a5 ae ff ff       	call   80102680 <readi>
801077db:	83 c4 10             	add    $0x10,%esp
801077de:	39 d8                	cmp    %ebx,%eax
801077e0:	75 1e                	jne    80107800 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
801077e2:	81 c6 00 10 00 00    	add    $0x1000,%esi
801077e8:	39 fe                	cmp    %edi,%esi
801077ea:	72 84                	jb     80107770 <loaduvm+0x20>
}
801077ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801077ef:	31 c0                	xor    %eax,%eax
}
801077f1:	5b                   	pop    %ebx
801077f2:	5e                   	pop    %esi
801077f3:	5f                   	pop    %edi
801077f4:	5d                   	pop    %ebp
801077f5:	c3                   	ret
801077f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801077fd:	00 
801077fe:	66 90                	xchg   %ax,%ax
80107800:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107803:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107808:	5b                   	pop    %ebx
80107809:	5e                   	pop    %esi
8010780a:	5f                   	pop    %edi
8010780b:	5d                   	pop    %ebp
8010780c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
8010780d:	83 ec 0c             	sub    $0xc,%esp
80107810:	68 30 84 10 80       	push   $0x80108430
80107815:	e8 56 93 ff ff       	call   80100b70 <panic>
8010781a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107820 <allocuvm>:
{
80107820:	55                   	push   %ebp
80107821:	89 e5                	mov    %esp,%ebp
80107823:	57                   	push   %edi
80107824:	56                   	push   %esi
80107825:	53                   	push   %ebx
80107826:	83 ec 1c             	sub    $0x1c,%esp
80107829:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
8010782c:	85 f6                	test   %esi,%esi
8010782e:	0f 88 98 00 00 00    	js     801078cc <allocuvm+0xac>
80107834:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80107836:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107839:	0f 82 a1 00 00 00    	jb     801078e0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010783f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107842:	05 ff 0f 00 00       	add    $0xfff,%eax
80107847:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010784c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
8010784e:	39 f0                	cmp    %esi,%eax
80107850:	0f 83 8d 00 00 00    	jae    801078e3 <allocuvm+0xc3>
80107856:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107859:	eb 44                	jmp    8010789f <allocuvm+0x7f>
8010785b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107860:	83 ec 04             	sub    $0x4,%esp
80107863:	68 00 10 00 00       	push   $0x1000
80107868:	6a 00                	push   $0x0
8010786a:	50                   	push   %eax
8010786b:	e8 00 da ff ff       	call   80105270 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107870:	58                   	pop    %eax
80107871:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107877:	5a                   	pop    %edx
80107878:	6a 06                	push   $0x6
8010787a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010787f:	89 fa                	mov    %edi,%edx
80107881:	50                   	push   %eax
80107882:	8b 45 08             	mov    0x8(%ebp),%eax
80107885:	e8 a6 fb ff ff       	call   80107430 <mappages>
8010788a:	83 c4 10             	add    $0x10,%esp
8010788d:	85 c0                	test   %eax,%eax
8010788f:	78 5f                	js     801078f0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80107891:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107897:	39 f7                	cmp    %esi,%edi
80107899:	0f 83 89 00 00 00    	jae    80107928 <allocuvm+0x108>
    mem = kalloc();
8010789f:	e8 8c b9 ff ff       	call   80103230 <kalloc>
801078a4:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801078a6:	85 c0                	test   %eax,%eax
801078a8:	75 b6                	jne    80107860 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801078aa:	83 ec 0c             	sub    $0xc,%esp
801078ad:	68 c1 81 10 80       	push   $0x801081c1
801078b2:	e8 69 90 ff ff       	call   80100920 <cprintf>
  if(newsz >= oldsz)
801078b7:	83 c4 10             	add    $0x10,%esp
801078ba:	3b 75 0c             	cmp    0xc(%ebp),%esi
801078bd:	74 0d                	je     801078cc <allocuvm+0xac>
801078bf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801078c2:	8b 45 08             	mov    0x8(%ebp),%eax
801078c5:	89 f2                	mov    %esi,%edx
801078c7:	e8 a4 fa ff ff       	call   80107370 <deallocuvm.part.0>
    return 0;
801078cc:	31 d2                	xor    %edx,%edx
}
801078ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078d1:	89 d0                	mov    %edx,%eax
801078d3:	5b                   	pop    %ebx
801078d4:	5e                   	pop    %esi
801078d5:	5f                   	pop    %edi
801078d6:	5d                   	pop    %ebp
801078d7:	c3                   	ret
801078d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801078df:	00 
    return oldsz;
801078e0:	8b 55 0c             	mov    0xc(%ebp),%edx
}
801078e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078e6:	89 d0                	mov    %edx,%eax
801078e8:	5b                   	pop    %ebx
801078e9:	5e                   	pop    %esi
801078ea:	5f                   	pop    %edi
801078eb:	5d                   	pop    %ebp
801078ec:	c3                   	ret
801078ed:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801078f0:	83 ec 0c             	sub    $0xc,%esp
801078f3:	68 d9 81 10 80       	push   $0x801081d9
801078f8:	e8 23 90 ff ff       	call   80100920 <cprintf>
  if(newsz >= oldsz)
801078fd:	83 c4 10             	add    $0x10,%esp
80107900:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107903:	74 0d                	je     80107912 <allocuvm+0xf2>
80107905:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107908:	8b 45 08             	mov    0x8(%ebp),%eax
8010790b:	89 f2                	mov    %esi,%edx
8010790d:	e8 5e fa ff ff       	call   80107370 <deallocuvm.part.0>
      kfree(mem);
80107912:	83 ec 0c             	sub    $0xc,%esp
80107915:	53                   	push   %ebx
80107916:	e8 55 b7 ff ff       	call   80103070 <kfree>
      return 0;
8010791b:	83 c4 10             	add    $0x10,%esp
    return 0;
8010791e:	31 d2                	xor    %edx,%edx
80107920:	eb ac                	jmp    801078ce <allocuvm+0xae>
80107922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107928:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
8010792b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010792e:	5b                   	pop    %ebx
8010792f:	5e                   	pop    %esi
80107930:	89 d0                	mov    %edx,%eax
80107932:	5f                   	pop    %edi
80107933:	5d                   	pop    %ebp
80107934:	c3                   	ret
80107935:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010793c:	00 
8010793d:	8d 76 00             	lea    0x0(%esi),%esi

80107940 <deallocuvm>:
{
80107940:	55                   	push   %ebp
80107941:	89 e5                	mov    %esp,%ebp
80107943:	8b 55 0c             	mov    0xc(%ebp),%edx
80107946:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107949:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010794c:	39 d1                	cmp    %edx,%ecx
8010794e:	73 10                	jae    80107960 <deallocuvm+0x20>
}
80107950:	5d                   	pop    %ebp
80107951:	e9 1a fa ff ff       	jmp    80107370 <deallocuvm.part.0>
80107956:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010795d:	00 
8010795e:	66 90                	xchg   %ax,%ax
80107960:	89 d0                	mov    %edx,%eax
80107962:	5d                   	pop    %ebp
80107963:	c3                   	ret
80107964:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010796b:	00 
8010796c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107970 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107970:	55                   	push   %ebp
80107971:	89 e5                	mov    %esp,%ebp
80107973:	57                   	push   %edi
80107974:	56                   	push   %esi
80107975:	53                   	push   %ebx
80107976:	83 ec 0c             	sub    $0xc,%esp
80107979:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010797c:	85 f6                	test   %esi,%esi
8010797e:	74 59                	je     801079d9 <freevm+0x69>
  if(newsz >= oldsz)
80107980:	31 c9                	xor    %ecx,%ecx
80107982:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107987:	89 f0                	mov    %esi,%eax
80107989:	89 f3                	mov    %esi,%ebx
8010798b:	e8 e0 f9 ff ff       	call   80107370 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107990:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107996:	eb 0f                	jmp    801079a7 <freevm+0x37>
80107998:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010799f:	00 
801079a0:	83 c3 04             	add    $0x4,%ebx
801079a3:	39 fb                	cmp    %edi,%ebx
801079a5:	74 23                	je     801079ca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801079a7:	8b 03                	mov    (%ebx),%eax
801079a9:	a8 01                	test   $0x1,%al
801079ab:	74 f3                	je     801079a0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801079ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801079b2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
801079b5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801079b8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801079bd:	50                   	push   %eax
801079be:	e8 ad b6 ff ff       	call   80103070 <kfree>
801079c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801079c6:	39 fb                	cmp    %edi,%ebx
801079c8:	75 dd                	jne    801079a7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801079ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801079cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079d0:	5b                   	pop    %ebx
801079d1:	5e                   	pop    %esi
801079d2:	5f                   	pop    %edi
801079d3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801079d4:	e9 97 b6 ff ff       	jmp    80103070 <kfree>
    panic("freevm: no pgdir");
801079d9:	83 ec 0c             	sub    $0xc,%esp
801079dc:	68 f5 81 10 80       	push   $0x801081f5
801079e1:	e8 8a 91 ff ff       	call   80100b70 <panic>
801079e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801079ed:	00 
801079ee:	66 90                	xchg   %ax,%ax

801079f0 <setupkvm>:
{
801079f0:	55                   	push   %ebp
801079f1:	89 e5                	mov    %esp,%ebp
801079f3:	56                   	push   %esi
801079f4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801079f5:	e8 36 b8 ff ff       	call   80103230 <kalloc>
801079fa:	85 c0                	test   %eax,%eax
801079fc:	74 5e                	je     80107a5c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
801079fe:	83 ec 04             	sub    $0x4,%esp
80107a01:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a03:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107a08:	68 00 10 00 00       	push   $0x1000
80107a0d:	6a 00                	push   $0x0
80107a0f:	50                   	push   %eax
80107a10:	e8 5b d8 ff ff       	call   80105270 <memset>
80107a15:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107a18:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107a1b:	83 ec 08             	sub    $0x8,%esp
80107a1e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107a21:	8b 13                	mov    (%ebx),%edx
80107a23:	ff 73 0c             	push   0xc(%ebx)
80107a26:	50                   	push   %eax
80107a27:	29 c1                	sub    %eax,%ecx
80107a29:	89 f0                	mov    %esi,%eax
80107a2b:	e8 00 fa ff ff       	call   80107430 <mappages>
80107a30:	83 c4 10             	add    $0x10,%esp
80107a33:	85 c0                	test   %eax,%eax
80107a35:	78 19                	js     80107a50 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a37:	83 c3 10             	add    $0x10,%ebx
80107a3a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107a40:	75 d6                	jne    80107a18 <setupkvm+0x28>
}
80107a42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107a45:	89 f0                	mov    %esi,%eax
80107a47:	5b                   	pop    %ebx
80107a48:	5e                   	pop    %esi
80107a49:	5d                   	pop    %ebp
80107a4a:	c3                   	ret
80107a4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107a50:	83 ec 0c             	sub    $0xc,%esp
80107a53:	56                   	push   %esi
80107a54:	e8 17 ff ff ff       	call   80107970 <freevm>
      return 0;
80107a59:	83 c4 10             	add    $0x10,%esp
}
80107a5c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80107a5f:	31 f6                	xor    %esi,%esi
}
80107a61:	89 f0                	mov    %esi,%eax
80107a63:	5b                   	pop    %ebx
80107a64:	5e                   	pop    %esi
80107a65:	5d                   	pop    %ebp
80107a66:	c3                   	ret
80107a67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a6e:	00 
80107a6f:	90                   	nop

80107a70 <kvmalloc>:
{
80107a70:	55                   	push   %ebp
80107a71:	89 e5                	mov    %esp,%ebp
80107a73:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107a76:	e8 75 ff ff ff       	call   801079f0 <setupkvm>
80107a7b:	a3 e4 54 11 80       	mov    %eax,0x801154e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107a80:	05 00 00 00 80       	add    $0x80000000,%eax
80107a85:	0f 22 d8             	mov    %eax,%cr3
}
80107a88:	c9                   	leave
80107a89:	c3                   	ret
80107a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107a90 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107a90:	55                   	push   %ebp
80107a91:	89 e5                	mov    %esp,%ebp
80107a93:	83 ec 08             	sub    $0x8,%esp
80107a96:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107a99:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107a9c:	89 c1                	mov    %eax,%ecx
80107a9e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107aa1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107aa4:	f6 c2 01             	test   $0x1,%dl
80107aa7:	75 17                	jne    80107ac0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107aa9:	83 ec 0c             	sub    $0xc,%esp
80107aac:	68 06 82 10 80       	push   $0x80108206
80107ab1:	e8 ba 90 ff ff       	call   80100b70 <panic>
80107ab6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107abd:	00 
80107abe:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107ac0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ac3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107ac9:	25 fc 0f 00 00       	and    $0xffc,%eax
80107ace:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107ad5:	85 c0                	test   %eax,%eax
80107ad7:	74 d0                	je     80107aa9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107ad9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107adc:	c9                   	leave
80107add:	c3                   	ret
80107ade:	66 90                	xchg   %ax,%ax

80107ae0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107ae0:	55                   	push   %ebp
80107ae1:	89 e5                	mov    %esp,%ebp
80107ae3:	57                   	push   %edi
80107ae4:	56                   	push   %esi
80107ae5:	53                   	push   %ebx
80107ae6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107ae9:	e8 02 ff ff ff       	call   801079f0 <setupkvm>
80107aee:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107af1:	85 c0                	test   %eax,%eax
80107af3:	0f 84 e9 00 00 00    	je     80107be2 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107af9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107afc:	85 c9                	test   %ecx,%ecx
80107afe:	0f 84 b2 00 00 00    	je     80107bb6 <copyuvm+0xd6>
80107b04:	31 f6                	xor    %esi,%esi
80107b06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107b0d:	00 
80107b0e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107b10:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107b13:	89 f0                	mov    %esi,%eax
80107b15:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107b18:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107b1b:	a8 01                	test   $0x1,%al
80107b1d:	75 11                	jne    80107b30 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107b1f:	83 ec 0c             	sub    $0xc,%esp
80107b22:	68 10 82 10 80       	push   $0x80108210
80107b27:	e8 44 90 ff ff       	call   80100b70 <panic>
80107b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107b30:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b32:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107b37:	c1 ea 0a             	shr    $0xa,%edx
80107b3a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107b40:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107b47:	85 c0                	test   %eax,%eax
80107b49:	74 d4                	je     80107b1f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80107b4b:	8b 00                	mov    (%eax),%eax
80107b4d:	a8 01                	test   $0x1,%al
80107b4f:	0f 84 9f 00 00 00    	je     80107bf4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107b55:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107b57:	25 ff 0f 00 00       	and    $0xfff,%eax
80107b5c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107b5f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107b65:	e8 c6 b6 ff ff       	call   80103230 <kalloc>
80107b6a:	89 c3                	mov    %eax,%ebx
80107b6c:	85 c0                	test   %eax,%eax
80107b6e:	74 64                	je     80107bd4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107b70:	83 ec 04             	sub    $0x4,%esp
80107b73:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107b79:	68 00 10 00 00       	push   $0x1000
80107b7e:	57                   	push   %edi
80107b7f:	50                   	push   %eax
80107b80:	e8 7b d7 ff ff       	call   80105300 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107b85:	58                   	pop    %eax
80107b86:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107b8c:	5a                   	pop    %edx
80107b8d:	ff 75 e4             	push   -0x1c(%ebp)
80107b90:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107b95:	89 f2                	mov    %esi,%edx
80107b97:	50                   	push   %eax
80107b98:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b9b:	e8 90 f8 ff ff       	call   80107430 <mappages>
80107ba0:	83 c4 10             	add    $0x10,%esp
80107ba3:	85 c0                	test   %eax,%eax
80107ba5:	78 21                	js     80107bc8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107ba7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107bad:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107bb0:	0f 82 5a ff ff ff    	jb     80107b10 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107bb6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107bb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bbc:	5b                   	pop    %ebx
80107bbd:	5e                   	pop    %esi
80107bbe:	5f                   	pop    %edi
80107bbf:	5d                   	pop    %ebp
80107bc0:	c3                   	ret
80107bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107bc8:	83 ec 0c             	sub    $0xc,%esp
80107bcb:	53                   	push   %ebx
80107bcc:	e8 9f b4 ff ff       	call   80103070 <kfree>
      goto bad;
80107bd1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107bd4:	83 ec 0c             	sub    $0xc,%esp
80107bd7:	ff 75 e0             	push   -0x20(%ebp)
80107bda:	e8 91 fd ff ff       	call   80107970 <freevm>
  return 0;
80107bdf:	83 c4 10             	add    $0x10,%esp
    return 0;
80107be2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107be9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107bec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bef:	5b                   	pop    %ebx
80107bf0:	5e                   	pop    %esi
80107bf1:	5f                   	pop    %edi
80107bf2:	5d                   	pop    %ebp
80107bf3:	c3                   	ret
      panic("copyuvm: page not present");
80107bf4:	83 ec 0c             	sub    $0xc,%esp
80107bf7:	68 2a 82 10 80       	push   $0x8010822a
80107bfc:	e8 6f 8f ff ff       	call   80100b70 <panic>
80107c01:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107c08:	00 
80107c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107c10 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107c10:	55                   	push   %ebp
80107c11:	89 e5                	mov    %esp,%ebp
80107c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107c16:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107c19:	89 c1                	mov    %eax,%ecx
80107c1b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107c1e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107c21:	f6 c2 01             	test   $0x1,%dl
80107c24:	0f 84 f8 00 00 00    	je     80107d22 <uva2ka.cold>
  return &pgtab[PTX(va)];
80107c2a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c2d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107c33:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107c34:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107c39:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107c40:	89 d0                	mov    %edx,%eax
80107c42:	f7 d2                	not    %edx
80107c44:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c49:	05 00 00 00 80       	add    $0x80000000,%eax
80107c4e:	83 e2 05             	and    $0x5,%edx
80107c51:	ba 00 00 00 00       	mov    $0x0,%edx
80107c56:	0f 45 c2             	cmovne %edx,%eax
}
80107c59:	c3                   	ret
80107c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c60 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107c60:	55                   	push   %ebp
80107c61:	89 e5                	mov    %esp,%ebp
80107c63:	57                   	push   %edi
80107c64:	56                   	push   %esi
80107c65:	53                   	push   %ebx
80107c66:	83 ec 0c             	sub    $0xc,%esp
80107c69:	8b 75 14             	mov    0x14(%ebp),%esi
80107c6c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c6f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107c72:	85 f6                	test   %esi,%esi
80107c74:	75 51                	jne    80107cc7 <copyout+0x67>
80107c76:	e9 9d 00 00 00       	jmp    80107d18 <copyout+0xb8>
80107c7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107c80:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107c86:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107c8c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107c92:	74 74                	je     80107d08 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
80107c94:	89 fb                	mov    %edi,%ebx
80107c96:	29 c3                	sub    %eax,%ebx
80107c98:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107c9e:	39 f3                	cmp    %esi,%ebx
80107ca0:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107ca3:	29 f8                	sub    %edi,%eax
80107ca5:	83 ec 04             	sub    $0x4,%esp
80107ca8:	01 c1                	add    %eax,%ecx
80107caa:	53                   	push   %ebx
80107cab:	52                   	push   %edx
80107cac:	89 55 10             	mov    %edx,0x10(%ebp)
80107caf:	51                   	push   %ecx
80107cb0:	e8 4b d6 ff ff       	call   80105300 <memmove>
    len -= n;
    buf += n;
80107cb5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107cb8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80107cbe:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107cc1:	01 da                	add    %ebx,%edx
  while(len > 0){
80107cc3:	29 de                	sub    %ebx,%esi
80107cc5:	74 51                	je     80107d18 <copyout+0xb8>
  if(*pde & PTE_P){
80107cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107cca:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107ccc:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80107cce:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107cd1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107cd7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107cda:	f6 c1 01             	test   $0x1,%cl
80107cdd:	0f 84 46 00 00 00    	je     80107d29 <copyout.cold>
  return &pgtab[PTX(va)];
80107ce3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ce5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107ceb:	c1 eb 0c             	shr    $0xc,%ebx
80107cee:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107cf4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80107cfb:	89 d9                	mov    %ebx,%ecx
80107cfd:	f7 d1                	not    %ecx
80107cff:	83 e1 05             	and    $0x5,%ecx
80107d02:	0f 84 78 ff ff ff    	je     80107c80 <copyout+0x20>
  }
  return 0;
}
80107d08:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107d0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107d10:	5b                   	pop    %ebx
80107d11:	5e                   	pop    %esi
80107d12:	5f                   	pop    %edi
80107d13:	5d                   	pop    %ebp
80107d14:	c3                   	ret
80107d15:	8d 76 00             	lea    0x0(%esi),%esi
80107d18:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107d1b:	31 c0                	xor    %eax,%eax
}
80107d1d:	5b                   	pop    %ebx
80107d1e:	5e                   	pop    %esi
80107d1f:	5f                   	pop    %edi
80107d20:	5d                   	pop    %ebp
80107d21:	c3                   	ret

80107d22 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107d22:	a1 00 00 00 00       	mov    0x0,%eax
80107d27:	0f 0b                	ud2

80107d29 <copyout.cold>:
80107d29:	a1 00 00 00 00       	mov    0x0,%eax
80107d2e:	0f 0b                	ud2
