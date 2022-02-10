Þ    9      ä              ¬  x   ­  o   &  Z    l   ñ  Ñ   ^     0     D  m   \     Ê     Ø  |   x  M   õ  Ï   C	  ç   
  d   û
     `  Ï   g     7  ß   ?  ô     =     t   R  Ú   Ç  
   ¢     ­  !   Å  0   ç       1   7     i       3  	  ©   =  Ü   ç  	  Ä     Î  Û   X  :  4  ²   o      "     C  )   Ð     ú  g     ±     `   4  õ          Õ     @   q  ,   ²  C   ß  L   #  =   p  5   ®  *   ä      k   ¤  n      :     s   º!  Ð   ."     ÿ"     #  k   ,#     #     ¥#  }   8$  K   ¶$  ­   %  ã   °%  T   &  	   é&  Ð   ó&  	   Ä'  Ú   Î'  ë   ©(  3   )  ]   É)  Ò   '*  	   ú*     +  %   +  -   A+     o+     +     ©+     7,    J,     L-  Ã   Ý-  Å   ¡.  s   g/  Ø   Û/  7  ´0  ª   ì1  '   2     ¿2  -   D3  $   r3  N   3  ¶   æ3  N   4  í   ì4     Ú5  ×   ç5  C   ¿6  #   7  G   '7  =   o7  3   ­7  -   á7  (   8   Add hints module with a useful Python implementation that the compiler can use to learn about types from the programmer. Add interfacing to C code, so Nuitka can turn a ``ctypes`` binding into an efficient binding as written with C. At this time, this is the recommended IDE for Linux and Windows. This is going to cover the plugins to install. Configuration is part of the ``.vscode`` in your Nuitka checkout. If you are not familiar with Eclipse, this is Free Software IDE,designed to be universally extended, and it truly is. There are plugins available for nearly everything. Before milestone 1, we used ``0.1.x`` version numbers. After reaching it, we used ``0.2.x`` version numbers. Before milestone 2 and 3, we used ``0.3.x`` version numbers. After almost reaching 3, and beginning with 4, we use "0.4.x" version numbers. Due to an interface change, ``0.5.x`` version numbers are being used. Coding Rules Python Commit and Code Hygiene Create the most efficient native code from this. This means to be fast with the basic Python object handling. Current State Currently there are very different kinds of files that we need support for. This is best addressed with an IDE. We cover here how to setup the most common one. Don't use these anymore, we consider Visual Studio Code to be far superior for delivering a nice out of the box environment. Download Visual Studio Code from here: https://code.visualstudio.com/download Due to reaching type inference in code generation, even if only starting, the ``0.6.x`` version numbers were started to be used. This stage should allow quick progress in performance for individual releases. Feature parity has been reached for CPython 2.6 and 2.7. We do not target any older CPython release. For CPython 3.3 up to 3.8 it also has been reached. We do not target the older and practically unused CPython 3.0 to 3.2 releases. Feature parity with CPython, understand all the language construct and behave absolutely compatible. Final: For Nuitka we use a defensive version numbering system to indicate that it is not yet ready for everything. We have defined milestones and the version numbers should express which of these, we consider done. Future: In Nuitka we have tools to autoformat code, you can execute them manually, but it's probably best to execute them at commit time, to make sure when we share code, it's already well format, and to avoid noise doing cleanups. In code generation, the supported C types are used, and sometimes we have specialized code generation, e.g. a binary operation that takes an ``int`` and a ``float`` and produces a ``float`` value. There will be fallbacks to less specific types. In order to set up hooks, you need to execute these commands: It grows out of discussions and presentations made at conferences as well as private conversations or issue tracker. It should be used as a reference for the process of planning and documenting decisions we made. Therefore we are e.g. presenting here the type inference plans before implementing them. And we update them as we proceed. Milestones Nuitka Developer Manual Nuitka top level works like this: Of course, all of this may be subject to change. Regarding types, the state is: Setting up the Development Environment for Nuitka Should you encounter problems with applying the changes to the checked out file, you can always execute it with ``COMMIT_UNCHECKED=1`` environment set. So far: The expansion with more C types is currently in progress, and there will also be alternative C types, where e.g. ``PyObject *`` and ``C long`` are in an enum that indicates which value is valid, and where special code will be available that can avoid creating the ``PyObject **`` unless the later overflows. The extensions to be installed are part of the Visual Code recommendations in ``.vscode/extensions.json`` and you will be prompted about that and ought to install these. The kinds of changes also often cause unnecessary merge conflicts, while the autoformat is designed to format code also in a way that it avoids merge conflicts in the normal case, e.g. by doing imports one item per line. The purpose of this Developer Manual is to present the current design of Nuitka, the project rules, and the motivations for choices made. It is intended to be a guide to the source code, and to give explanations that don't fit into the source code in comments form. Then do constant propagation, determine as many values and useful constraints as possible at compile time and create more efficient code. There are a some specific use of types beyond "compile time constant", that are encoded in type and value shapes, which can be used to predict some operations, conditions, etc. if they raise, and result types they give. These commands will make sure that the ``autoformat-nuitka-source`` is run on every staged file content at the time you do the commit. For C files, it may complain unavailability of ``clang-format``, follow it's advice. You may call the above tool at all times, without arguments to format call Nuitka source code. These rules should generally be adhered when working on Nuitka code. It's not library code and it's optimized for readability, and avoids all performance optimization for itself. This design is intended to last. This milestone is considered almost reached. We continue to discover new things, but the infrastructure is there, and these are easy to add. This milestone is considered in progress. This milestone is planned only. This milestone was reached, although of course, micro optimizations to this are happening all the time. This milestone was reached. Dropping support for Python 2.6 and 3.3 is an option, should this prove to be any benefit. Currently it is not, as it extends the test coverage only. Type inference, detect and special case the handling of strings, integers, lists in the program. Types are always ``PyObject *``, and only a few C types, e.g. ``nuitka_bool`` and ``nuitka_void`` and more are coming. Even for objects, often it's know that things are e.g. really a ``PyTupleObject **``, but no C type is available for that yet. Version Numbers We will then round it up and call it Nuitka ``1.0`` when this works as expected for a bunch of people. The plan is to reach this goal during 2021. This is based on positive assumptions that may not hold up though. With ``ctypes`` bindings in a usable state it will be ``0.7.x``. ``nuitka.MainControl`` keeps it all together ``nuitka.codegen.*Codes`` knows how specific code kinds are created ``nuitka.codegen.CodeGeneration`` orchestrates the creation of code snippets ``nuitka.finalization`` prepares the tree for code generation ``nuitka.optimization`` enhances it as best as it can ``nuitka.tree.Building`` outputs node tree Project-Id-Version: Nuitka the Python Compiler 
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2022-01-09 23:30+0800
PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE
Last-Translator: xinetzone <735613050@qq.com>, 2022
Language: zh_CN
Language-Team: zh_CN <LL@li.org>
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.9.1
 å¢å æç¤ºæ¨¡åï¼æä¸ä¸ªæç¨ç Python å®ç°ï¼ç¼è¯å¨å¯ä»¥ç¨å®æ¥åç¨åºåå­¦ä¹ ç±»åã å¢å ä¸ C ä»£ç çæ¥å£ï¼æä»¥ Nuitka å¯ä»¥æ ``ctypes`` çç»å®åæç¨ C ç¼åçææç»å®ã ç®åï¼è¿æ¯æ¨èç¨äº Linux å Windows ç IDEãè¿å°æ¶µçè¦å®è£çæä»¶ãéç½®æ¯ä½ ç Nuitka æ£åºä¸­ç ``.vscode`` çä¸é¨åãå¦æä½ ä¸çæ Eclipseï¼è¿æ¯ä¸ä¸ªèªç±è½¯ä»¶ IDEï¼è¢«è®¾è®¡æå¯ä»¥æ®éæ©å±çï¼èä¸å®ç¡®å®å¦æ­¤ãå ä¹ææçä¸è¥¿é½ææä»¶å¯ç¨ã å¨éç¨ç¢ 1 ä¹åï¼æä»¬ä½¿ç¨ ``0.1.x`` ççæ¬å·ãè¾¾å°ä¹åï¼æä»¬ä½¿ç¨ ``0.2.x`` ççæ¬å·ã å¨éç¨ç¢ 2 å 3 ä¹åï¼æä»¬ä½¿ç¨ ``0.3.x`` ççæ¬å·ãå¨å ä¹è¾¾å° 3 ä¹åï¼ä» 4 å¼å§ï¼æä»¬ä½¿ç¨ "0.4.x" ççæ¬å·ãç±äºæ¥å£çæ¹åï¼æ­£å¨ä½¿ç¨ ``0.5.x`` ççæ¬å·ã Python ç¼ç è§å æ¿è¯ºåå®åçå«å£« ä»ä¸­åå»ºæææçæ¬å°ä»£ç ãè¿æå³çè¦å¨åºæ¬ç Python å¯¹è±¡å¤çæ¹é¢åå°å¿«éã å½åç¶æ ç®åï¼æä»¬éè¦æ¯ææå¶ä¸åç§ç±»çæä»¶ãè¿ä¸ç¹æå¥½ç¨ IDE æ¥è§£å³ãæä»¬å¨è¿éä»ç»å¦ä½è®¾ç½®æå¸¸è§çæä»¶ã ä¸è¦åä½¿ç¨è¿äºäºï¼æä»¬è®¤ä¸º Visual Studio Code å¨æä¾ä¸ä¸ªè¯å¥½çå¼ç®±å³ç¨ç¯å¢æ¹é¢è¦ä¼è¶å¾å¤ã ä»è¿éä¸è½½ Visual Studio Codeï¼https://code.visualstudio.com/download ç±äºå¨ä»£ç çæä¸­è¾¾å°äºç±»åæ¨çï¼å³ä½¿åªæ¯å¼å§ï¼ä¹å¼å§ä½¿ç¨ ``0.6.x`` ççæ¬å·äºãè¿ä¸ªé¶æ®µåºè¯¥åè®¸ä¸ªå«çæ¬çæ§è½å¿«éè¿æ­¥ã CPython 2.6 å2.7 çåè½å·²ç»è¾¾å°å¹³ä»·ãæä»¬ä¸éå¯¹ä»»ä½æ§ç CPython çæ¬ãå¯¹äºCPython 3.3 å° 3.8ï¼ä¹å·²ç»è¾¾å°äºå¹³ä»·ãæä»¬ä¸éå¯¹æ§çãå ä¹æ²¡æä½¿ç¨è¿ç CPython 3.0 å° 3.2 çæ¬ã ä¸ CPython çåè½ç¸å½ï¼çè§£ææçè¯­è¨æé ï¼è¡ä¸ºä¸ç»å¯¹å¼å®¹ã æç»ï¼ å¯¹äº Nuitkaï¼æä»¬ä½¿ç¨äºä¸ä¸ªé²å¾¡æ§ççæ¬ç¼å·ç³»ç»ï¼ä»¥è¡¨æå®è¿æ²¡æåå¤å¥½ä¸åãæä»¬å·²ç»å®ä¹äºéç¨ç¢ï¼çæ¬å·åºè¯¥è¡¨è¾¾å¶ä¸­åªäºï¼æä»¬è®¤ä¸ºå·²ç»å®æäºã æªæ¥ï¼ å¨ Nuitka ä¸­ï¼æä»¬æèªå¨æ ¼å¼åä»£ç çå·¥å·ï¼ä½ å¯ä»¥æå¨æ§è¡ï¼ä½æå¥½æ¯å¨æäº¤æ¶æ§è¡ï¼ä»¥ç¡®ä¿å½æä»¬åäº«ä»£ç æ¶ï¼å®å·²ç»è¢«å¾å¥½å°æ ¼å¼åäºï¼å¹¶é¿ååæ¸ççåªé³ã å¨ä»£ç çæä¸­ï¼ä½¿ç¨æ¯æç C ç±»åï¼ææ¶æä»¬ä¼æä¸é¨çä»£ç çæï¼ä¾å¦ï¼ä¸ä¸ªäºè¿å¶æä½éè¦ä¸ä¸ª ``int`` åä¸ä¸ª ``float`` å¹¶äº§çä¸ä¸ª ``float`` å¼ãå°ä¼æåè½å°ä¸å¤ªå·ä½çç±»åã ä¸ºäºè®¾ç½®é©å­ï¼ä½ éè¦æ§è¡è¿äºå½ä»¤ï¼ å®æ¯ä»ä¼è®®ä¸çè®¨è®ºåæ¼è®²ä»¥åç§äººè°è¯æé®é¢è·è¸ªå¨ä¸­æé¿èµ·æ¥çã å®åºè¯¥è¢«ç¨ä½è§ååè®°å½æä»¬æåå³å®è¿ç¨çåèãå æ­¤ï¼æä»¬å¨è¿éï¼ä¾å¦ï¼å¨å®æ½ç±»åæ¨çè®¡åä¹åï¼æåºäºè¿äºè®¡åãèä¸æä»¬å¨è¿è¡è¿ç¨ä¸­æ´æ°å®ä»¬ã éç¨ç¢ Nuitka å¼åèæå Nuitka é¡¶å±çå·¥ä½æ¯è¿æ ·çï¼ å½ç¶ï¼ææè¿äºé½å¯è½ä¼æååã å³äºç±»åï¼ç¶ææ¯ï¼ ä¸º Nuitka è®¾ç½®å¼åç¯å¢ å¦æä½ å¨å°ä¿®æ¹åºç¨å°æ£æ¥åºæ¥çæä»¶æ¶éå°é®é¢ï¼ä½ æ»æ¯å¯ä»¥å¨ ``COMMIT_UNCHECKED=1`` çç¯å¢è®¾ç½®ä¸æ§è¡å®ã å°ç®åä¸ºæ­¢ï¼ ç®åæ­£å¨ç¨æ´å¤ç C ç±»åè¿è¡æ©å±ï¼ä¹ä¼ææ¿ä»£ç C ç±»åï¼ä¾å¦ ``PyObject *`` å ``C long`` å¨ä¸ä¸ªæä¸¾ä¸­ï¼è¡¨æåªä¸ªå¼æ¯ææçï¼èä¸ä¼æç¹æ®çä»£ç ï¼å¯ä»¥é¿ååå»º ``PyObject **``ï¼é¤éåæ¥çæº¢åºã è¦å®è£çæ©å±æ¯ Visual Code å»ºè®®çä¸é¨åï¼å¨ ``.vscode/extensions.json`` ä¸­ï¼ä½ ä¼è¢«æç¤ºå°è¿ä¸ç¹ï¼åºè¯¥å®è£è¿äºã è¿ç±»ä¿®æ¹ä¹ç»å¸¸å¼èµ·ä¸å¿è¦çåå¹¶å²çªï¼èèªå¨æ ¼å¼åçè®¾è®¡ä¹æ¯ä¸ºäºå¨æ­£å¸¸æåµä¸é¿ååå¹¶å²çªï¼æ¯å¦è¯´æ¯è¡åå¯¼å¥ä¸é¡¹ï¼å°±å¯ä»¥é¿ååå¹¶å²çªã æ¬å¼åèæåçç®çæ¯ä»ç» Nuitka çå½åè®¾è®¡ãé¡¹ç®è§åä»¥åæåéæ©çå¨æºãå®æ¨å¨æä¸ºæºä»£ç çæåï¼å¹¶ä»¥æ³¨éçå½¢å¼ç»åºä¸éåæºä»£ç çè§£éã ç¶åå constant ä¼ æ­ï¼å¨ç¼è¯æ¶ç¡®å®å°½å¯è½å¤çå¼åæç¨ççº¦æï¼å¹¶åå»ºæ´ææçä»£ç ã æä¸äºç¹å®çä½¿ç¨ç±»åè¶è¶äº "ç¼è¯æ¶é´å¸¸é"ï¼è¿äºç±»åå¨ç±»ååå¼çå½¢ç¶ä¸­è¢«ç¼ç ï¼å¯ä»¥ç¨æ¥é¢æµä¸äºæä½ãæ¡ä»¶ç­ï¼å¦æä»ä»¬æåºï¼ä»¥åä»ä»¬ç»åºçç»æç±»åã è¿äºå½ä»¤å°ç¡®ä¿ ``autoformat-nuitka-source`` å¨ä½ åæäº¤çæ¶åå¯¹æ¯ä¸ªé¶æ®µæ§çæä»¶åå®¹è¿è¡ãå¯¹äº C æä»¶ï¼å®å¯è½ä¼æ±æ¨ ``clang-format`` ä¸å¯ç¨ï¼è¯·éµå¾ªå®çå»ºè®®ãä½ å¯ä»¥å¨ä»»ä½æ¶åè°ç¨ä¸è¿°å·¥å·ï¼ä¸éè¦åæ°å°±å¯ä»¥æ ¼å¼åè°ç¨ Nuitka æºä»£ç ã å¨ Nuitka ä»£ç ä¸å·¥ä½æ¶ï¼ä¸è¬åºéµå®è¿äºè§åãå®ä¸æ¯åºçä»£ç ï¼èä¸å®æ¯ä¸ºäºå¯è¯»æ§èä¼åçï¼é¿åäºå¯¹èªå·±çæææ§è½ä¼åã è¿ç§è®¾è®¡çç®çæ¯ä¸ºäºæä¹ã è¿ä¸ªéç¨ç¢è¢«è®¤ä¸ºå ä¹è¾¾å°äºãæä»¬ç»§ç»­åç°æ°çä¸è¥¿ï¼ä½åºç¡è®¾æ½å·²ç»å­å¨ï¼è¿äºé½å¾å®¹ææ·»å ã è¿ä¸ªéç¨ç¢è¢«è®¤ä¸ºæ¯æ­£å¨è¿è¡ä¸­ã è¿ä¸ªéç¨ç¢åªæ¯è®¡åä¸­çã è¿ä¸ªéç¨ç¢å·²ç»è¾¾æï¼å½ç¶ï¼å¯¹æ­¤çå¾®è§ä¼åä¸ç´å¨è¿è¡ã è¿ä¸ªéç¨ç¢å·²ç»è¾¾æãæ¾å¼å¯¹ Python 2.6 å 3.3 çæ¯ææ¯ä¸ç§éæ©ï¼å¦æè¿è¢«è¯ææä»»ä½å¥½å¤çè¯ãç®åè¿æ²¡æï¼å ä¸ºå®åªæ©å±äºæµè¯èå´ã ç±»åæ¨çï¼æ£æµåç¹ä¾å¤çç¨åºä¸­çå­ç¬¦ä¸²ãæ´æ°ãåè¡¨ã ç±»åæ»æ¯ ``PyObject *``ï¼åªæå°æ° C ç±»åï¼ä¾å¦ ``nuitka_bool`` å ``nuitka_void``ï¼æ´å¤çç±»åæ­£å¨å°æ¥ãå³ä½¿æ¯å¯¹è±¡ï¼ä¹ç»å¸¸ç¥éäºç©æ¯ä¾å¦ ``PyTupleObject **``ï¼ä½è¿æ²¡æ C ç±»åå¯ç¨äºæ­¤ã çæ¬æ°å­ ç¶åæä»¬å°æå®å´èµ·æ¥ï¼å½è¿å¯¹ä¸ç¾¤äººæ¥è¯´å¦é¢æçé£æ ·å·¥ä½æ¶ï¼å°±ç§°ä¹ä¸ºNuitka ``1.0``ãè®¡åæ¯å¨ 2021 å¹´æé´è¾¾å°è¿ä¸ªç®æ ãè¿æ¯åºäºç§¯æçåè®¾ï¼ä½å¯è½ä¸æç«ã å¨ ``ctypes`` ç»å®å¤äºå¯ç¨ç¶ææ¶ï¼å®å°æ¯ ``0.7.x``ã ``nuitka.MainControl`` ä¿æä¸è´ ``nuitka.codegen.*Codes`` ç¥éå·ä½çä»£ç ç§ç±»æ¯å¦ä½äº§çç ``nuitka.codegen.CodeGeneration`` åè°ä»£ç çæ­çåå»º ``nuitka.finalization`` ä¸ºä»£ç çæåå¤å¥½æ  ``nuitka.optimization`` å°½å¯è½å°å¢å¼ºå® ``nuitka.tree.Building`` è¾åºèç¹æ  