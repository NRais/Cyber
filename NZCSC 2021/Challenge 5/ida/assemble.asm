
./buff:     file format elf32-i386


Disassembly of section .init:

080482f4 <_init>:
 80482f4:	53                   	push   %ebx
 80482f5:	83 ec 08             	sub    $0x8,%esp
 80482f8:	e8 b3 00 00 00       	call   80483b0 <__x86.get_pc_thunk.bx>
 80482fd:	81 c3 03 1d 00 00    	add    $0x1d03,%ebx
 8048303:	8b 83 fc ff ff ff    	mov    -0x4(%ebx),%eax
 8048309:	85 c0                	test   %eax,%eax
 804830b:	74 05                	je     8048312 <_init+0x1e>
 804830d:	e8 4e 00 00 00       	call   8048360 <__gmon_start__@plt>
 8048312:	83 c4 08             	add    $0x8,%esp
 8048315:	5b                   	pop    %ebx
 8048316:	c3                   	ret    

Disassembly of section .plt:

08048320 <.plt>:
 8048320:	ff 35 04 a0 04 08    	pushl  0x804a004
 8048326:	ff 25 08 a0 04 08    	jmp    *0x804a008
 804832c:	00 00                	add    %al,(%eax)
	...

08048330 <read@plt>:
 8048330:	ff 25 0c a0 04 08    	jmp    *0x804a00c
 8048336:	68 00 00 00 00       	push   $0x0
 804833b:	e9 e0 ff ff ff       	jmp    8048320 <.plt>

08048340 <printf@plt>:
 8048340:	ff 25 10 a0 04 08    	jmp    *0x804a010
 8048346:	68 08 00 00 00       	push   $0x8
 804834b:	e9 d0 ff ff ff       	jmp    8048320 <.plt>

08048350 <system@plt>:
 8048350:	ff 25 14 a0 04 08    	jmp    *0x804a014
 8048356:	68 10 00 00 00       	push   $0x10
 804835b:	e9 c0 ff ff ff       	jmp    8048320 <.plt>

08048360 <__gmon_start__@plt>:
 8048360:	ff 25 18 a0 04 08    	jmp    *0x804a018
 8048366:	68 18 00 00 00       	push   $0x18
 804836b:	e9 b0 ff ff ff       	jmp    8048320 <.plt>

08048370 <__libc_start_main@plt>:
 8048370:	ff 25 1c a0 04 08    	jmp    *0x804a01c
 8048376:	68 20 00 00 00       	push   $0x20
 804837b:	e9 a0 ff ff ff       	jmp    8048320 <.plt>

Disassembly of section .text:

08048380 <_start>:
 8048380:	31 ed                	xor    %ebp,%ebp
 8048382:	5e                   	pop    %esi
 8048383:	89 e1                	mov    %esp,%ecx
 8048385:	83 e4 f0             	and    $0xfffffff0,%esp
 8048388:	50                   	push   %eax
 8048389:	54                   	push   %esp
 804838a:	52                   	push   %edx
 804838b:	68 70 85 04 08       	push   $0x8048570
 8048390:	68 00 85 04 08       	push   $0x8048500
 8048395:	51                   	push   %ecx
 8048396:	56                   	push   %esi
 8048397:	68 df 84 04 08       	push   $0x80484df
 804839c:	e8 cf ff ff ff       	call   8048370 <__libc_start_main@plt>
 80483a1:	f4                   	hlt    
 80483a2:	66 90                	xchg   %ax,%ax
 80483a4:	66 90                	xchg   %ax,%ax
 80483a6:	66 90                	xchg   %ax,%ax
 80483a8:	66 90                	xchg   %ax,%ax
 80483aa:	66 90                	xchg   %ax,%ax
 80483ac:	66 90                	xchg   %ax,%ax
 80483ae:	66 90                	xchg   %ax,%ax

080483b0 <__x86.get_pc_thunk.bx>:
 80483b0:	8b 1c 24             	mov    (%esp),%ebx
 80483b3:	c3                   	ret    
 80483b4:	66 90                	xchg   %ax,%ax
 80483b6:	66 90                	xchg   %ax,%ax
 80483b8:	66 90                	xchg   %ax,%ax
 80483ba:	66 90                	xchg   %ax,%ax
 80483bc:	66 90                	xchg   %ax,%ax
 80483be:	66 90                	xchg   %ax,%ax

080483c0 <deregister_tm_clones>:
 80483c0:	b8 2b a0 04 08       	mov    $0x804a02b,%eax
 80483c5:	2d 28 a0 04 08       	sub    $0x804a028,%eax
 80483ca:	83 f8 06             	cmp    $0x6,%eax
 80483cd:	77 01                	ja     80483d0 <deregister_tm_clones+0x10>
 80483cf:	c3                   	ret    
 80483d0:	b8 00 00 00 00       	mov    $0x0,%eax
 80483d5:	85 c0                	test   %eax,%eax
 80483d7:	74 f6                	je     80483cf <deregister_tm_clones+0xf>
 80483d9:	55                   	push   %ebp
 80483da:	89 e5                	mov    %esp,%ebp
 80483dc:	83 ec 18             	sub    $0x18,%esp
 80483df:	c7 04 24 28 a0 04 08 	movl   $0x804a028,(%esp)
 80483e6:	ff d0                	call   *%eax
 80483e8:	c9                   	leave  
 80483e9:	c3                   	ret    
 80483ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

080483f0 <register_tm_clones>:
 80483f0:	b8 28 a0 04 08       	mov    $0x804a028,%eax
 80483f5:	2d 28 a0 04 08       	sub    $0x804a028,%eax
 80483fa:	c1 f8 02             	sar    $0x2,%eax
 80483fd:	89 c2                	mov    %eax,%edx
 80483ff:	c1 ea 1f             	shr    $0x1f,%edx
 8048402:	01 d0                	add    %edx,%eax
 8048404:	d1 f8                	sar    %eax
 8048406:	75 01                	jne    8048409 <register_tm_clones+0x19>
 8048408:	c3                   	ret    
 8048409:	ba 00 00 00 00       	mov    $0x0,%edx
 804840e:	85 d2                	test   %edx,%edx
 8048410:	74 f6                	je     8048408 <register_tm_clones+0x18>
 8048412:	55                   	push   %ebp
 8048413:	89 e5                	mov    %esp,%ebp
 8048415:	83 ec 18             	sub    $0x18,%esp
 8048418:	89 44 24 04          	mov    %eax,0x4(%esp)
 804841c:	c7 04 24 28 a0 04 08 	movl   $0x804a028,(%esp)
 8048423:	ff d2                	call   *%edx
 8048425:	c9                   	leave  
 8048426:	c3                   	ret    
 8048427:	89 f6                	mov    %esi,%esi
 8048429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

08048430 <__do_global_dtors_aux>:
 8048430:	80 3d 28 a0 04 08 00 	cmpb   $0x0,0x804a028
 8048437:	75 13                	jne    804844c <__do_global_dtors_aux+0x1c>
 8048439:	55                   	push   %ebp
 804843a:	89 e5                	mov    %esp,%ebp
 804843c:	83 ec 08             	sub    $0x8,%esp
 804843f:	e8 7c ff ff ff       	call   80483c0 <deregister_tm_clones>
 8048444:	c6 05 28 a0 04 08 01 	movb   $0x1,0x804a028
 804844b:	c9                   	leave  
 804844c:	f3 c3                	repz ret 
 804844e:	66 90                	xchg   %ax,%ax

08048450 <frame_dummy>:
 8048450:	a1 10 9f 04 08       	mov    0x8049f10,%eax
 8048455:	85 c0                	test   %eax,%eax
 8048457:	74 1f                	je     8048478 <frame_dummy+0x28>
 8048459:	b8 00 00 00 00       	mov    $0x0,%eax
 804845e:	85 c0                	test   %eax,%eax
 8048460:	74 16                	je     8048478 <frame_dummy+0x28>
 8048462:	55                   	push   %ebp
 8048463:	89 e5                	mov    %esp,%ebp
 8048465:	83 ec 18             	sub    $0x18,%esp
 8048468:	c7 04 24 10 9f 04 08 	movl   $0x8049f10,(%esp)
 804846f:	ff d0                	call   *%eax
 8048471:	c9                   	leave  
 8048472:	e9 79 ff ff ff       	jmp    80483f0 <register_tm_clones>
 8048477:	90                   	nop
 8048478:	e9 73 ff ff ff       	jmp    80483f0 <register_tm_clones>

0804847d <helper>:
 804847d:	55                   	push   %ebp
 804847e:	89 e5                	mov    %esp,%ebp
 8048480:	83 ec 18             	sub    $0x18,%esp
 8048483:	c7 04 24 90 85 04 08 	movl   $0x8048590,(%esp)
 804848a:	e8 c1 fe ff ff       	call   8048350 <system@plt>
 804848f:	c9                   	leave  
 8048490:	c3                   	ret    

08048491 <overflow>:
 8048491:	55                   	push   %ebp
 8048492:	89 e5                	mov    %esp,%ebp
 8048494:	81 ec 18 02 00 00    	sub    $0x218,%esp
 804849a:	c7 44 24 08 bc 02 00 	movl   $0x2bc,0x8(%esp)
 80484a1:	00 
 80484a2:	8d 85 00 fe ff ff    	lea    -0x200(%ebp),%eax
 80484a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 80484ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 80484b3:	e8 78 fe ff ff       	call   8048330 <read@plt>
 80484b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 80484bb:	8d 85 00 fe ff ff    	lea    -0x200(%ebp),%eax
 80484c1:	89 44 24 08          	mov    %eax,0x8(%esp)
 80484c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80484c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 80484cc:	c7 04 24 a0 85 04 08 	movl   $0x80485a0,(%esp)
 80484d3:	e8 68 fe ff ff       	call   8048340 <printf@plt>
 80484d8:	b8 00 00 00 00       	mov    $0x0,%eax
 80484dd:	c9                   	leave  
 80484de:	c3                   	ret    

080484df <main>:
 80484df:	55                   	push   %ebp
 80484e0:	89 e5                	mov    %esp,%ebp
 80484e2:	83 e4 f0             	and    $0xfffffff0,%esp
 80484e5:	e8 a7 ff ff ff       	call   8048491 <overflow>
 80484ea:	b8 00 00 00 00       	mov    $0x0,%eax
 80484ef:	c9                   	leave  
 80484f0:	c3                   	ret    
 80484f1:	66 90                	xchg   %ax,%ax
 80484f3:	66 90                	xchg   %ax,%ax
 80484f5:	66 90                	xchg   %ax,%ax
 80484f7:	66 90                	xchg   %ax,%ax
 80484f9:	66 90                	xchg   %ax,%ax
 80484fb:	66 90                	xchg   %ax,%ax
 80484fd:	66 90                	xchg   %ax,%ax
 80484ff:	90                   	nop

08048500 <__libc_csu_init>:
 8048500:	55                   	push   %ebp
 8048501:	57                   	push   %edi
 8048502:	31 ff                	xor    %edi,%edi
 8048504:	56                   	push   %esi
 8048505:	53                   	push   %ebx
 8048506:	e8 a5 fe ff ff       	call   80483b0 <__x86.get_pc_thunk.bx>
 804850b:	81 c3 f5 1a 00 00    	add    $0x1af5,%ebx
 8048511:	83 ec 1c             	sub    $0x1c,%esp
 8048514:	8b 6c 24 30          	mov    0x30(%esp),%ebp
 8048518:	8d b3 0c ff ff ff    	lea    -0xf4(%ebx),%esi
 804851e:	e8 d1 fd ff ff       	call   80482f4 <_init>
 8048523:	8d 83 08 ff ff ff    	lea    -0xf8(%ebx),%eax
 8048529:	29 c6                	sub    %eax,%esi
 804852b:	c1 fe 02             	sar    $0x2,%esi
 804852e:	85 f6                	test   %esi,%esi
 8048530:	74 27                	je     8048559 <__libc_csu_init+0x59>
 8048532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8048538:	8b 44 24 38          	mov    0x38(%esp),%eax
 804853c:	89 2c 24             	mov    %ebp,(%esp)
 804853f:	89 44 24 08          	mov    %eax,0x8(%esp)
 8048543:	8b 44 24 34          	mov    0x34(%esp),%eax
 8048547:	89 44 24 04          	mov    %eax,0x4(%esp)
 804854b:	ff 94 bb 08 ff ff ff 	call   *-0xf8(%ebx,%edi,4)
 8048552:	83 c7 01             	add    $0x1,%edi
 8048555:	39 f7                	cmp    %esi,%edi
 8048557:	75 df                	jne    8048538 <__libc_csu_init+0x38>
 8048559:	83 c4 1c             	add    $0x1c,%esp
 804855c:	5b                   	pop    %ebx
 804855d:	5e                   	pop    %esi
 804855e:	5f                   	pop    %edi
 804855f:	5d                   	pop    %ebp
 8048560:	c3                   	ret    
 8048561:	eb 0d                	jmp    8048570 <__libc_csu_fini>
 8048563:	90                   	nop
 8048564:	90                   	nop
 8048565:	90                   	nop
 8048566:	90                   	nop
 8048567:	90                   	nop
 8048568:	90                   	nop
 8048569:	90                   	nop
 804856a:	90                   	nop
 804856b:	90                   	nop
 804856c:	90                   	nop
 804856d:	90                   	nop
 804856e:	90                   	nop
 804856f:	90                   	nop

08048570 <__libc_csu_fini>:
 8048570:	f3 c3                	repz ret 

Disassembly of section .fini:

08048574 <_fini>:
 8048574:	53                   	push   %ebx
 8048575:	83 ec 08             	sub    $0x8,%esp
 8048578:	e8 33 fe ff ff       	call   80483b0 <__x86.get_pc_thunk.bx>
 804857d:	81 c3 83 1a 00 00    	add    $0x1a83,%ebx
 8048583:	83 c4 08             	add    $0x8,%esp
 8048586:	5b                   	pop    %ebx
 8048587:	c3                   	ret    
