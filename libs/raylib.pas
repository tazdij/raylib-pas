(**********************************************************************************************
*
*   raylib - A simple and easy-to-use library to enjoy videogames programming (www.raylib.com)
*
*   FEATURES:
*       - NO external dependencies, all required libraries included with raylib
*       - Multiplatform: Windows, Linux, FreeBSD, OpenBSD, NetBSD, DragonFly, MacOS, UWP, Android, Raspberry Pi, HTML5.
*       - Written in plain C code (C99) in PascalCase/camelCase notation
*       - Hardware accelerated with OpenGL (1.1, 2.1, 3.3 or ES2 - choose at compile)
*       - Unique OpenGL abstraction layer (usable as standalone module): [rlgl]
*       - Multiple Fonts formats supported (TTF, XNA fonts, AngelCode fonts)
*       - Outstanding texture formats support, including compressed formats (DXT, ETC, ASTC)
*       - Full 3d support for 3d Shapes, Models, Billboards, Heightmaps and more!
*       - Flexible Materials system, supporting classic maps and PBR maps
*       - Skeletal Animation support (CPU bones-based animation)
*       - Shaders support, including Model shaders and Postprocessing shaders
*       - Powerful math module for Vector, Matrix and Quaternion operations: [raymath]
*       - Audio loading and playing with streaming support (WAV, OGG, MP3, FLAC, XM, MOD)
*       - VR stereo rendering with configurable HMD device parameters
*       - Bindings to multiple programming languages available!
*
*   NOTES:
*       One custom font is loaded by default when InitWindow() [core]
*       If using OpenGL 3.3 or ES2, one default shader is loaded automatically (internally defined) [rlgl]
*       If using OpenGL 3.3 or ES2, several vertex buffers (VAO/VBO) are created to manage lines-triangles-quads
*
*   DEPENDENCIES (included):
*       [core] rglfw (github.com/glfw/glfw) for window/context management and input (only PLATFORM_DESKTOP)
*       [rlgl] glad (github.com/Dav1dde/glad) for OpenGL 3.3 extensions loading (only PLATFORM_DESKTOP)
*       [raudio] miniaudio (github.com/dr-soft/miniaudio) for audio device/context management
*
*   OPTIONAL DEPENDENCIES (included):
*       [core] rgif (Charlie Tangora, Ramon Santamaria) for GIF recording
*       [textures] stb_image (Sean Barret) for images loading (BMP, TGA, PNG, JPEG, HDR...)
*       [textures] stb_image_write (Sean Barret) for image writting (BMP, TGA, PNG, JPG)
*       [textures] stb_image_resize (Sean Barret) for image resizing algorithms
*       [textures] stb_perlin (Sean Barret) for Perlin noise image generation
*       [text] stb_truetype (Sean Barret) for ttf fonts loading
*       [text] stb_rect_pack (Sean Barret) for rectangles packing
*       [models] par_shapes (Philip Rideout) for parametric 3d shapes generation
*       [models] tinyobj_loader_c (Syoyo Fujita) for models loading (OBJ, MTL)
*       [models] cgltf (Johannes Kuhlmann) for models loading (glTF)
*       [raudio] stb_vorbis (Sean Barret) for OGG audio loading
*       [raudio] dr_flac (David Reid) for FLAC audio file loading
*       [raudio] dr_mp3 (David Reid) for MP3 audio file loading
*       [raudio] jar_xm (Joshua Reisenauer) for XM audio module loading
*       [raudio] jar_mod (Joshua Reisenauer) for MOD audio module loading
*
*
*   LICENSE: zlib/libpng
*
*   raylib is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software:
*
*   Copyright (c) 2013-2020 Ramon Santamaria (@raysan5)
*
*   This software is provided "as-is", without any express or implied warranty. In no event
*   will the authors be held liable for any damages arising from the use of this software.
*
*   Permission is granted to anyone to use this software for any purpose, including commercial
*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
*
*     1. The origin of this software must not be misrepresented; you must not claim that you
*     wrote the original software. If you use this software in a product, an acknowledgment
*     in the product documentation would be appreciated but is not required.
*
*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
*     as being the original software.
*
*     3. This notice may not be removed or altered from any source distribution.
*
********************************************************************************
*
* raylib-pas - Header/DLLs Conversion
* Copyright (c) 2019 Duvall Industries LLC.
* All Rights Reserved.
* https://tazdij.com
*
* ----------------------------------------------------------------------------
* CHANGELOG
*
* Version 2019.10.24
*   - raylib-pas for raylib 2.6.0-dev
*
* Version 2020.09.17
*   - raylib-pas for raylib 3.0.0-dev
*
* Version 2021.05.22
*   - raylib-pas for raylib 3.7.0-dev
*     * Binaries for windows 32 & 64 included, precompiled, both Debug and Release
*     * Start working on Bundling libraylib.a for static linking on Linux and Mac?
*
*
*******************************************************************************)


{%region 'Pascal Wrapper TODO'}
(*
   This is a todo comment, wrapped in a region (simplifying the collapsing) :)

   ## Non Standard Pascal Addons:

   This might be rather contreversial but, I want to add some creature features
   into the wrapper. I don't plan to include them directly in this unit, keeping
   the "Translation" portiong as pure as I know how. But in an additional
   'RaylibExt' unit, I hope to add convenience and featureful additions to
   simplify patterns and common code.

   This is in an effort to prep for my new    game project 'Dawn Viking'. "An
   isometric 2d farm & town game life sim" similar in spirit and emotion to
   Harvest Moon 64.

*)
{%endregion}

unit raylib;

{$MODE ObjFpc}{$H+}
{$PACKRECORDS C}

interface

const
  cDllName = {$IFDEF WINDOWS}

                     {$IFDEF DEBUG}
                             {$IFDEF WIN64} 'libraylib64-debug.dll' {$ELSE} 'libraylib32-debug.dll' {$ENDIF}
                     {$ELSE}
                            {$IFDEF WIN64} 'libraylib64.dll' {$ELSE} 'libraylib32.dll' {$ENDIF}
                     {$ENDIF}
             {$IFEND}
             {$IFDEF DARWIN} 'libraylib.dylib' {$IFEND}
             {$IFDEF LINUX} 'libraylib.so' {$IFEND};

  // Some basic Defines
  DEG2RAD = (PI/180.0);
  RAD2DEG = (180.0/PI);

  MAX_TOUCH_POINTS     = 10;

  MAX_SHADER_LOCATIONS = 32;
  MAX_MATERIAL_MAPS    = 12;

type

  // Color type, RGBA (32bit)
  PColor = ^TColor;
  TColor = {$IFDEF WINDOWS}packed{$IFEND}record
    r : Byte;
    g : Byte;
    b : Byte;
    a : Byte;
  end;



const
  // Some Basic Colors
  // NOTE: Custom raylib color palette for amazing visuals on WHITE background
  LIGHTGRAY : TColor = (r: 200; g: 200; b: 200; a: 255);
  GRAY      : TColor = (r: 130; g: 130; b: 130; a: 255);
  DARKGRAY  : TColor = (r:  80; g:  80; b:  80; a: 255);
  YELLOW    : TColor = (r: 253; g: 249; b:   0; a: 255);
  GOLD      : TColor = (r: 255; g: 203; b:   0; a: 255);
  ORANGE    : TColor = (r: 255; g: 161; b:   0; a: 255);
  PINK      : TColor = (r: 255; g: 109; b: 194; a: 255);
  RED       : TColor = (r: 230; g:  41; b:  55; a: 255);
  MAROON    : TColor = (r: 190; g:  33; b:  55; a: 255);
  GREEN     : TColor = (r:   0; g: 228; b:  48; a: 255);
  LIME      : TColor = (r:   0; g: 158; b:  47; a: 255);
  DARKGREEN : TColor = (r:   0; g: 117; b:  44; a: 255);
  SKYBLUE   : TColor = (r: 102; g: 191; b: 255; a: 255);
  BLUE      : TColor = (r:   0; g: 121; b: 241; a: 255);
  DARKBLUE  : TColor = (r:   0; g:  82; b: 172; a: 255);
  PURPLE    : TColor = (r: 200; g: 122; b: 255; a: 255);
  VIOLET    : TColor = (r: 135; g:  60; b: 190; a: 255);
  DARKPURPLE: TColor = (r: 112; g:  31; b: 126; a: 255);
  BEIGE     : TColor = (r: 211; g: 176; b: 131; a: 255);
  BROWN     : TColor = (r: 127; g: 106; b:  79; a: 255);
  DARKBROWN : TColor = (r:  76; g:  63; b:  47; a: 255);
  WHITE     : TColor = (r: 255; g: 255; b: 255; a: 255);
  BLACK     : TColor = (r:   0; g:   0; b:   0; a: 255);
  BLANK     : TColor = (r:   0; g:   0; b:   0; a:   0);
  MAGENTA   : TColor = (r: 255; g:   0; b: 255; a: 255);
  RAYWHITE  : TColor = (r: 245; g: 245; b: 245; a: 255);

type
  PVector2 = ^TVector2;
  TVector2 = {$IFDEF WINDOWS}packed{$IFEND} record
    x : Single;
    y : Single;
  end;

  // Vector3 type
  PVector3 = ^TVector3;
  TVector3 = {$IFDEF WINDOWS}packed{$IFEND} record
    x : Single;
    y : Single;
    z : Single;
  end;

  // Vector4 type
  PVector4 = ^TVector4;
  TVector4 = {$IFDEF WINDOWS}packed{$IFEND} record
    x : Single;
    y : Single;
    z : Single;
    w : Single;
  end;

  // Quaternion type, same as Vector4
  PQuaternion = ^TQuaternion;
  TQuaternion = TVector4;

  // Matrix type (OpenGL style 4x4 - right handed, column major)
  PMatrix = ^TMatrix;
  TMatrix = {$IFDEF WINDOWS}packed{$IFEND} record
    m0  : Single;
    m4  : Single;
    m8  : Single;
    m12 : Single;
    m1  : Single;
    m5  : Single;
    m9  : Single;
    m13 : Single;
    m2  : Single;
    m6  : Single;
    m10 : Single;
    m14 : Single;
    m3  : Single;
    m7  : Single;
    m11 : Single;
    m15 : Single;
  end;

  // Rectangle type
  PPRectangle = ^PRectangle;
  PRectangle = ^TRectangle;
  TRectangle = {$IFDEF WINDOWS}packed{$IFEND} record
    x      : Single;
    y      : Single;
    width  : Single;
    height : Single;
  end;

  // Image type, bpp always RGBA (32bit)
  // NOTE: Data stored in CPU memory (RAM)
  PImage = ^TImage;
  TImage = {$IFDEF WINDOWS}packed{$IFEND} record
    data    : Pointer;
    width   : Integer;
    height  : Integer;
    mipmaps : Integer;
    format  : Integer;
  end;

  // Texture2D type
  // NOTE: Data stored in GPU memory
  PTexture = ^TTexture;
  TTexture = {$IFDEF WINDOWS}packed{$IFEND} record
    id      : Cardinal;
    width   : Integer;
    height  : Integer;
    mipmaps : Integer;
    format  : Integer;
  end;

  // Texture type, same as Texture2D
  //  UPDATE: these were swapped with actual declaration at some point
  //  2D is now the deprecated naming
  PTexture2D = ^TTexture2D;
  TTexture2D = TTexture;

  PTextureCubemap = ^TTextureCubemap;
  TTextureCubemap = TTexture2D;

  // RenderTexture type, for texture rendering (Aliased later as ...2D)
  PRenderTexture = ^TRenderTexture;
  TRenderTexture = {$IFDEF WINDOWS}packed{$IFEND} record
    id      : Cardinal;
    texture : TTexture;
    depth   : TTexture;
  //  depthTexture : Boolean;       // Removed in current header
  end;

  // RenderTexture type, same as RenderTexture2D
  PRenderTexture2D = ^TRenderTexture2D;  // maybe not to alias but to original? @TODO: determine after a test
  TRenderTexture2D = TRenderTexture;

  // N-Patch layout info
  PNPatchInfo = ^TNPatchInfo;
  TNPatchInfo = {$IFDEF WINDOWS}packed{$IFEND} record
    source : TRectangle;
    left   : Integer;
    top    : Integer;
    right  : Integer;
    bottom : Integer;
    layout : Integer;
  end;


  // Font character info
  PCharInfo = ^TCharInfo;
  TCharInfo = {$IFDEF WINDOWS}packed{$IFEND} record
    value : Integer;
    offsetX : Integer;
    offsetY : Integer;
    advanceX : Integer;
    image : TImage;
  end;

  // Font type, includes texture and charSet array data
  PFont = ^TFont;
  TFont = {$IFDEF WINDOWS}packed{$IFEND} record
    baseSize     : Integer;
    charsCount   : Integer;
    charsPadding : Integer;
    texture      : TTexture2D;
    recs         : PRectangle;
    chars        : PCharInfo;
  end;

  // SpriteFont type fallback, defaults to Font
  PSpriteFont = ^TFont;
  TSpriteFont = TFont;


  // Camera type, defines a camera position/orientation in 3d space
  PCamera3D = ^TCamera3D;
  TCamera3D = {$IFDEF WINDOWS}packed{$IFEND} record
    position   : TVector3;
    target     : TVector3;
    up         : TVector3;
    fovy       : Single;
    projection : Integer;
  end;

  PCamera = ^TCamera;
  TCamera = TCamera3D;


  // Camera2D type, defines a 2d camera
  PCamera2D = ^TCamera2D;
  TCamera2D = {$IFDEF WINDOWS}packed{$IFEND} record
    offset   : TVector2;
    target   : TVector2;
    rotation : Single;
    zoom     : Single;
  end;

  // Vertex data definning a mesh
  // NOTE: Data stored in CPU memory (and GPU)
  PMesh = ^TMesh;
  TMesh = {$IFDEF WINDOWS}packed{$IFEND} record
    vertexCount: Integer;
    triangleCount: Integer;
    
    // Default Vertex Data
    vertices: PSingle;
    texcoords: PSingle;
    texcoords2: PSingle;
    normals: PSingle;
    tangents: PSingle;
    colors: PByte;
    indices: PWord;

    // Animation Vertex Data
    animVertices : PSingle;
    animNormals : PSingle;
    boneIds : PInteger;
    boneWeights : PSingle;

    // OpenGL identifiers 
    vaoId: Cardinal;
    vboId: PCardinal;
  end;

  // Shader type (generic)
  PShader = ^TShader;
  TShader = {$IFDEF WINDOWS}packed{$IFEND} record
    id : Cardinal;
    locs : PInteger;
  end;

  // Material texture map
  PMaterialMap = ^TMaterialMap;
  TMaterialMap = {$IFDEF WINDOWS}packed{$IFEND} record
    texture : TTexture2D;
    color : TColor;
    value : Single;
  end;

  // Material type (generic)
  PMaterial = ^TMaterial;
  TMaterial = {$IFDEF WINDOWS}packed{$IFEND} record
    shader : TShader;
    maps : ^TMaterialMap;
    params : Array[0..3] of Single;
  end;

  // Transformation Properties
  PPTransform = ^PTransform;
  PTransform = ^TTransform;
  TTransform = {$IFDEF WINDOWS}packed{$IFEND} record
    translation : TVector3;
    rotation : TQuaternion;
    scale : TVector3;
  end;

  // Bone Information
  PBoneInfo = ^TBoneInfo;
  TBoneInfo = {$IFDEF WINDOWS}packed{$IFEND} record
    &name : Array[0..31] of Char;
    parent : Integer;
  end;

  // Model type
  PModel = ^TModel;
  TModel = {$IFDEF WINDOWS}packed{$IFEND} record
    transform     : TMatrix;

    meshCount     : Integer;
    materialCount : Integer;
    meshes        : PMesh;
    materials     : PMaterial;
    meshMaterial  : PInteger;

    // Animation data
    boneCount : Integer;
    bones     : PBoneInfo;
    bindPose  : PTransform;
  end;

  // Model Animation
  PModelAnimation = ^TModelAnimation;
  TModelAnimation = {$IFDEF WINDOWS}packed{$IFEND} record
    boneCount  : Integer;
    frameCount : Integer;

    bones      : PBoneInfo;
    framePoses : PPTransform;
  end;

  // Ray type (useful for raycast)
  PRay = ^TRay;
  TRay = {$IFDEF WINDOWS}packed{$IFEND} record
    position  : TVector3;
    direction : TVector3;
  end;

  // Raycast hit information
  PRayHitInfo = ^TRayHitInfo;
  TRayHitInfo = {$IFDEF WINDOWS}packed{$IFEND} record
    hit      : Boolean;
    distance : Single;
    position : TVector3;
    normal   : TVector3;
  end;

  // Bounding box type
  PBoundingBox = ^TBoundingBox;
  TBoundingBox = {$IFDEF WINDOWS}packed{$IFEND} record
    min : TVector3;
    max : TVector3;
  end;

// Wave type, defines audio wave data
  PWave = ^TWave;
  TWave = {$IFDEF WINDOWS}packed{$IFEND} record
    sampleCount : Cardinal;
    sampleRate  : Cardinal;
    sampleSize  : Cardinal;
    channels    : Cardinal;
    data        : Pointer;
  end;

  PrAudioBuffer = ^TrAudioBuffer;
  TrAudioBuffer = record
  end;

  // Audio stream type
  // NOTE: Useful to create custom audio streams not bound to a specific file
  PAudioStream = ^TAudioStream;
  TAudioStream = {$IFDEF WINDOWS}packed{$IFEND} record
    buffer     : PrAudioBuffer;

    sampleRate : Cardinal;
    sampleSize : Cardinal;
    channels   : Cardinal;
  end;

  // Sound source type
  PSound = ^TSound;
  TSound = {$IFDEF WINDOWS}packed{$IFEND} record
    stream      : TAudioStream;
    sampleCount : Cardinal;
  end;

  // Music type (file streaming from memory)
  // NOTE: Anything longer than ~10 seconds should be streamed
  TMusic = {$IFDEF WINDOWS}packed{$IFEND} record
    stream      : TAudioStream;
    sampleCount : Cardinal;
    looping     : Boolean;

    ctxType     : Integer;
    ctxData     : Pointer;
  end;

  // Head-Mounted-Display device parameters
  PVrDeviceInfo = ^TVrDeviceInfo;
  TVrDeviceInfo = {$IFDEF WINDOWS}packed{$IFEND} record
    hResolution            : Integer;
    vResolution            : Integer;
    hScreenSize            : Single;
    vScreenSize            : Single;
    vScreenCenter          : Single;
    eyeToScreenDistance    : Single;
    lensSeparationDistance : Single;
    interpupillaryDistance : Single;
    lensDistortionValues   : Array[0..3] of Single;
    chromaAbCorrection     : Array[0..3] of Single;
  end;

  PVrStereoConfig = ^TVrStereoConfig;
  TVrStereoConfig = {$IFDEF WINDOWS}packed{$IFEND} record
    projection        : Array[0..1] of TMatrix;
    viewOffset        : Array[0..1] of TMatrix;
    leftLensCenter    : Array[0..1] of Single;
    rightLensCenter   : Array[0..1] of Single;
    leftScreenCenter  : Array[0..1] of Single;
    rightScreenCenter : Array[0..1] of Single;
    scale             : Array[0..1] of Single;
    scaleIn           : Array[0..1] of Single;
  end;

const

{%region 'enum ConfigFlags'}
  // raylib Config Flags
  FLAG_VSYNC_HINT         = $00000040;
  FLAG_FULLSCREEN_MODE    = $00000002;
  FLAG_WINDOW_RESIZABLE   = $00000004;
  FLAG_WINDOW_UNDECORATED = $00000008;
  FLAG_WINDOW_HIDDEN      = $00000080;
  FLAG_WINDOW_MINIMIZED   = $00000200;
  FLAG_WINDOW_MAXIMIZED   = $00000400;
  FLAG_WINDOW_UNFOCUSED   = $00000800;
  FLAG_WINDOW_TOPMOST     = $00001000;
  FLAG_WINDOW_ALWAYS_RUN  = $00000100;
  FLAG_WINDOW_TRANSPARENT = $00000010;
  FLAG_WINDOW_HIGHDPI     = $00002000;
  FLAG_MSAA_4X_HINT       = $00000020;
  FLAG_INTERLACED_HINT    = $00010000;
{%endregion}

{%region 'enum TraceLogLevel'}
  // Trace log type
  LOG_ALL     = 0;
  LOG_TRACE   = 1;
  LOG_DEBUG   = 3;
  LOG_INFO    = 4;
  LOG_WARNING = 5;
  LOG_ERROR   = 6;
  LOG_FATAL   = 7;
  LOG_NONE    = 8;
{%endregion}

{%region 'enum KeyboardKey'}
  // Keyboard Function Keys
  // Alphanumeric keys
  KEY_NULL            =  0;
  KEY_APOSTROPHE      = 39;
  KEY_COMMA           = 44;
  KEY_MINUS           = 45;
  KEY_PERIOD          = 46;
  KEY_SLASH           = 47;
  KEY_ZERO            = 48;
  KEY_ONE             = 49;
  KEY_TWO             = 50;
  KEY_THREE           = 51;
  KEY_FOUR            = 52;
  KEY_FIVE            = 53;
  KEY_SIX             = 54;
  KEY_SEVEN           = 55;
  KEY_EIGHT           = 56;
  KEY_NINE            = 57;
  KEY_SEMICOLON       = 59;
  KEY_EQUAL           = 61;
  KEY_A               = 65;
  KEY_B               = 66;
  KEY_C               = 67;
  KEY_D               = 68;
  KEY_E               = 69;
  KEY_F               = 70;
  KEY_G               = 71;
  KEY_H               = 72;
  KEY_I               = 73;
  KEY_J               = 74;
  KEY_K               = 75;
  KEY_L               = 76;
  KEY_M               = 77;
  KEY_N               = 78;
  KEY_O               = 79;
  KEY_P               = 80;
  KEY_Q               = 81;
  KEY_R               = 82;
  KEY_S               = 83;
  KEY_T               = 84;
  KEY_U               = 85;
  KEY_V               = 86;
  KEY_W               = 87;
  KEY_X               = 88;
  KEY_Y               = 89;
  KEY_Z               = 90;

  // Function keys
  KEY_SPACE           =  32;
  KEY_ESCAPE          = 256;
  KEY_ENTER           = 257;
  KEY_TAB             = 258;
  KEY_BACKSPACE       = 259;
  KEY_INSERT          = 260;
  KEY_DELETE          = 261;
  KEY_RIGHT           = 262;
  KEY_LEFT            = 263;
  KEY_DOWN            = 264;
  KEY_UP              = 265;
  KEY_PAGE_UP         = 266;
  KEY_PAGE_DOWN       = 267;
  KEY_HOME            = 268;
  KEY_END             = 269;
  KEY_CAPS_LOCK       = 280;
  KEY_SCROLL_LOCK     = 281;
  KEY_NUM_LOCK        = 282;
  KEY_PRINT_SCREEN    = 283;
  KEY_PAUSE           = 284;
  KEY_F1              = 290;
  KEY_F2              = 291;
  KEY_F3              = 292;
  KEY_F4              = 293;
  KEY_F5              = 294;
  KEY_F6              = 295;
  KEY_F7              = 296;
  KEY_F8              = 297;
  KEY_F9              = 298;
  KEY_F10             = 299;
  KEY_F11             = 300;
  KEY_F12             = 301;
  KEY_LEFT_SHIFT      = 340;
  KEY_LEFT_CONTROL    = 341;
  KEY_LEFT_ALT        = 342;
  KEY_LEFT_SUPER      = 343;
  KEY_RIGHT_SHIFT     = 344;
  KEY_RIGHT_CONTROL   = 345;
  KEY_RIGHT_ALT       = 346;
  KEY_RIGHT_SUPER     = 347;
  KEY_KB_MENU         = 348;
  KEY_LEFT_BRACKET    =  91;
  KEY_BACKSLASH       =  92;
  KEY_RIGHT_BRACKET   =  93;
  KEY_GRAVE           =  96;

  // Keypad keys
  KEY_KP_0            = 320;
  KEY_KP_1            = 321;
  KEY_KP_2            = 322;
  KEY_KP_3            = 323;
  KEY_KP_4            = 324;
  KEY_KP_5            = 325;
  KEY_KP_6            = 326;
  KEY_KP_7            = 327;
  KEY_KP_8            = 328;
  KEY_KP_9            = 329;
  KEY_KP_DECIMAL      = 330;
  KEY_KP_DIVIDE       = 331;
  KEY_KP_MULTIPLY     = 332;
  KEY_KP_SUBTRACT     = 333;
  KEY_KP_ADD          = 334;
  KEY_KP_ENTER        = 335;
  KEY_KP_EQUAL        = 336;

  // Android Physical Buttons
  KEY_BACK           =  4;
  KEY_MENU           = 82;
  KEY_VOLUME_UP      = 24;
  KEY_VOLUME_DOWN    = 25;
{%endregion 'enum KeyboardKey'}

{%region 'enum MouseButton'}

// Mouse Buttons
MOUSE_LEFT_BUTTON   = 0;   // legacy
MOUSE_RIGHT_BUTTON  = 1;   // legacy
MOUSE_MIDDLE_BUTTON = 2;   // legacy

  MOUSE_BUTTON_LEFT    = 0;
  MOUSE_BUTTON_RIGHT   = 1;
  MOUSE_BUTTON_MIDDLE  = 2;
  MOUSE_BUTTON_SIDE    = 3;
  MOUSE_BUTTON_EXTRA   = 4;
  MOUSE_BUTTON_FORWARD = 5;
  MOUSE_BUTTON_BACK    = 6;
  MOUSE_BUTTON_MAX     = 7;
{%endregion}

{%region 'enum MouseCursor'}
  MOUSE_CURSOR_DEFAULT       =  0;
  MOUSE_CURSOR_ARROW         =  1;
  MOUSE_CURSOR_IBEAM         =  2;
  MOUSE_CURSOR_CROSSHAIR     =  3;
  MOUSE_CURSOR_POINTING_HAND =  4;
  MOUSE_CURSOR_RESIZE_EW     =  5;     // The horizontal resize/move arrow shape
  MOUSE_CURSOR_RESIZE_NS     =  6;     // The vertical resize/move arrow shape
  MOUSE_CURSOR_RESIZE_NWSE   =  7;     // The top-left to bottom-right diagonal resize/move arrow shape
  MOUSE_CURSOR_RESIZE_NESW   =  8;     // The top-right to bottom-left diagonal resize/move arrow shape
  MOUSE_CURSOR_RESIZE_ALL    =  9;     // The omni-directional resize/move cursor shape
  MOUSE_CURSOR_NOT_ALLOWED   = 10;     // The operation-not-allowed shape
  {%endregion}

{%region 'enum GamepadButton'}

//**** Removed from raylib.h (we might need to bring it back?)
// Gamepad Number
//GAMEPAD_PLAYER1     = 0;
//GAMEPAD_PLAYER2     = 1;
//GAMEPAD_PLAYER3     = 2;
//GAMEPAD_PLAYER4     = 3;


  // This is here just for error checking
  GAMEPAD_BUTTON_UNKNOWN          = 0;

  // This is normally [A,B,X,Y]/[Circle,Triangle,Square,Cross]
  // No support for 6 button controllers though..
  GAMEPAD_BUTTON_LEFT_FACE_UP     = 1;
  GAMEPAD_BUTTON_LEFT_FACE_RIGHT  = 2;
  GAMEPAD_BUTTON_LEFT_FACE_DOWN   = 3;
  GAMEPAD_BUTTON_LEFT_FACE_LEFT   = 4;

  // This is normally a DPA
  GAMEPAD_BUTTON_RIGHT_FACE_UP    = 5;
  GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6;
  GAMEPAD_BUTTON_RIGHT_FACE_DOWN  = 7;
  GAMEPAD_BUTTON_RIGHT_FACE_LEFT  = 8;

  // Triggers
  GAMEPAD_BUTTON_LEFT_TRIGGER_1   = 9;
  GAMEPAD_BUTTON_LEFT_TRIGGER_2   = 10;
  GAMEPAD_BUTTON_RIGHT_TRIGGER_1  = 11;
  GAMEPAD_BUTTON_RIGHT_TRIGGER_2  = 12;

  // These are buttons in the center of the gamepad
  GAMEPAD_BUTTON_MIDDLE_LEFT      = 13;     //PS3 Select
  GAMEPAD_BUTTON_MIDDLE           = 14;          //PS Button/XBOX Button
  GAMEPAD_BUTTON_MIDDLE_RIGHT     = 15;    //PS3 Start

  // These are the joystick press in buttons
  GAMEPAD_BUTTON_LEFT_THUMB       = 16;
  GAMEPAD_BUTTON_RIGHT_THUMB      = 17;
{%endregion}

{%region 'enum GamepadAxis'}
  // This is here just for error checking
  //GAMEPAD_AXIS_UNKNOWN = 0;  // Removed?

  // Left stick
  GAMEPAD_AXIS_LEFT_X  = 0;
  GAMEPAD_AXIS_LEFT_Y  = 1;

  // Right stick
  GAMEPAD_AXIS_RIGHT_X = 2;
  GAMEPAD_AXIS_RIGHT_Y = 3;

  // Pressure levels for the back triggers
  GAMEPAD_AXIS_LEFT_TRIGGER = 5;      // [1..-1] (pressure-level)
  GAMEPAD_AXIS_RIGHT_TRIGGER = 6;     // [1..-1] (pressure-level)
{%endregion}

{%region 'enum MaterialMapIndex'}
  MATERIAL_MAP_ALBEDO     =  0;       // MATERIAL_MAP_DIFFUSE
  MATERIAL_MAP_METALNESS  =  1;       // MATERIAL_MAP_SPECULAR
  MATERIAL_MAP_NORMAL     =  2;
  MATERIAL_MAP_ROUGHNESS  =  3;
  MATERIAL_MAP_OCCLUSION  =  4;
  MATERIAL_MAP_EMISSION   =  5;
  MATERIAL_MAP_HEIGHT     =  6;
  MATERIAL_MAP_BRDG       =  7;
  MATERIAL_MAP_CUBEMAP    =  8;             // NOTE: Uses GL_TEXTURE_CUBE_MAP
  MATERIAL_MAP_IRRADIANCE =  9;          // NOTE: Uses GL_TEXTURE_CUBE_MAP
  MATERIAL_MAP_PREFILTER  = 10;          // NOTE: Uses GL_TEXTURE_CUBE_MAP

  // Deprecated Enums/Constants for old shader mats
  MATERIAL_MAP_DIFFUSE    = MATERIAL_MAP_ALBEDO;
  MATERIAL_MAP_SPECULAR   = MATERIAL_MAP_METALNESS;
{%endregion}

{%region 'enum ShaderLocationIndex'}
  // Shader location point type
  SHADER_LOC_VERTEX_POSITION    = 0;
  SHADER_LOC_VERTEX_TEXCOORD01  = 1;
  SHADER_LOC_VERTEX_TEXCOORD02  = 2;
  SHADER_LOC_VERTEX_NORMAL      = 3;
  SHADER_LOC_VERTEX_TANGENT     = 4;
  SHADER_LOC_VERTEX_COLOR       = 5;

  SHADER_LOC_MATRIX_MVP         = 6;
  SHADER_LOC_MATRIX_VIEW        = 7;
  SHADER_LOC_MATRIX_PROJECTION  = 8;
  SHADER_LOC_MATRIX_MODEL       = 9;
  SHADER_LOC_MATRIX_NORMAL      = 10;

  SHADER_LOC_VECTOR_VIEW        = 11;
  SHADER_LOC_COLOR_DIFFUSE      = 12;
  SHADER_LOC_COLOR_SPECULAR     = 13;
  SHADER_LOC_COLOR_AMBIENT      = 14;

  SHADER_LOC_MAP_ALBEDO         = 15;
  SHADER_LOC_MAP_METALNESS      = 16;
  SHADER_LOC_MAP_NORMAL         = 17;
  SHADER_LOC_MAP_ROUGHNESS      = 18;
  SHADER_LOC_MAP_OCCLUSION      = 19;
  SHADER_LOC_MAP_EMISSION       = 20;
  SHADER_LOC_MAP_HEIGHT         = 21;
  SHADER_LOC_MAP_CUBEMAP        = 22;
  SHADER_LOC_MAP_IRRADIANCE     = 23;
  SHADER_LOC_MAP_PREFILTER      = 24;
  SHADER_LOC_MAP_BRDF           = 25;

  SHADER_LOC_MAP_DIFFUSE  = SHADER_LOC_MAP_ALBEDO;
  SHADER_LOC_MAP_SPECULAR = SHADER_LOC_MAP_METALNESS;

{%endregion}

{%region 'enum ShaderUniformDataType'}
  SHADER_UNIFORM_FLOAT = 0;
  SHADER_UNIFORM_VEC2  = 1;
  SHADER_UNIFORM_VEC3  = 2;
  SHADER_UNIFORM_VEC4  = 3;
  SHADER_UNIFORM_INT   = 4;
  SHADER_UNIFORM_IVEC2 = 5;
  SHADER_UNIFORM_IVEC3 = 6;
  SHADER_UNIFORM_IVEC4 = 7;
  SHADER_UNIFORM_SAMPLER2D = 8;
{%endregion}

{%region 'enum PixelFormat'}
  // Pixel formats
  // NOTE: Support depends on OpenGL version and platform
  PIXELFORMAT_UNCOMPRESSED_GRAYSCALE    = 1;
  PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA   = 2;
  PIXELFORMAT_UNCOMPRESSED_R5G6B5       = 3;
  PIXELFORMAT_UNCOMPRESSED_R8G8B8       = 4;
  PIXELFORMAT_UNCOMPRESSED_R5G5B5A1     = 5;
  PIXELFORMAT_UNCOMPRESSED_R4G4B4A4     = 6;
  PIXELFORMAT_UNCOMPRESSED_R8G8B8A8     = 7;
  PIXELFORMAT_UNCOMPRESSED_R32          = 8;
  PIXELFORMAT_UNCOMPRESSED_R32G32B32    = 9;
  PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10;
  PIXELFORMAT_COMPRESSED_DXT1_RGB       = 11;
  PIXELFORMAT_COMPRESSED_DXT1_RGBA      = 12;
  PIXELFORMAT_COMPRESSED_DXT3_RGBA      = 13;
  PIXELFORMAT_COMPRESSED_DXT5_RGBA      = 14;
  PIXELFORMAT_COMPRESSED_ETC1_RGB       = 15;
  PIXELFORMAT_COMPRESSED_ETC2_RGB       = 16;
  PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA  = 17;
  PIXELFORMAT_COMPRESSED_PVRT_RGB       = 18;
  PIXELFORMAT_COMPRESSED_PVRT_RGBA      = 19;
  PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA  = 20;
  PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA  = 21;
{%endregion}

{%region 'enum TextureFilter'}
  // Texture parameters: filter mode
  // NOTE 1: Filtering considers mipmaps if available in the texture
  // NOTE 2: Filter is accordingly set for minification and magnification
  TEXTURE_FILTER_POINT           = 0;
  TEXTURE_FILTER_BILINEAR        = 1;
  TEXTURE_FILTER_TRILINEAR       = 2;
  TEXTURE_FILTER_ANISOTROPIC_4X  = 3;
  TEXTURE_FILTER_ANISOTROPIC_8X  = 4;
  TEXTURE_FILTER_ANISOTROPIC_16X = 5;
{%endregion}

{%region 'enum TextureWrap'}
  // Texture parameters: wrap mode
  TEXTURE_WRAP_REPEAT        = 0;
  TEXTURE_WRAP_CLAMP         = 1;
  TEXTURE_WRAP_MIRROR_REPEAT = 2;
  TEXTURE_WRAP_MIRROR_CLAMP  = 3;
{%endregion}

{%region 'enum CubemapLayout'}
  // Cubemap layout type
  CUBEMAP_LAYOUT_AUTO_DETECT         = 0;        // Automatically detect layout type
  CUBEMAP_LAYOUT_LINE_VERTICAL       = 1;        // Layout is defined by a vertical line with faces
  CUBEMAP_LAYOUT_LINE_HORIZONTAL     = 2;        // Layout is defined by an horizontal line with faces
  CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3;        // Layout is defined by a 3x4 cross with cubemap faces
  CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4;        // Layout is defined by a 4x3 cross with cubemap faces
  CUBEMAP_LAYOUT_PANORAMA            = 5;        // Layout is defined by a panorama image (equirectangular map)
{%endregion}

{%region 'enum FontType'}
  FONT_DEFAULT = 0;
  FONT_BITMAP  = 1;
  FONT_SDF     = 2;
{%endregion}

{%region 'enum BlendMode'}
  // Color blending modes (pre-defined)
  BLEND_ALPHA           = 0;
  BLEND_ADDITIVE        = 1;
  BLEND_MULTIPLIED      = 2;
  BLEND_ADD_COLORS      = 3;
  BLEND_SUBTRACT_COLORS = 4;
  BLEND_CUSTOM          = 5;
{%endregion}

{%region 'enum Gestures'}
  // Gestures type
  // NOTE: It could be used as flags to enable only some gestures
  GESTURE_NONE        = 0;
  GESTURE_TAP         = 1;
  GESTURE_DOUBLETAP   = 2;
  GESTURE_HOLD        = 4;
  GESTURE_DRAG        = 8;
  GESTURE_SWIPE_RIGHT = 16;
  GESTURE_SWIPE_LEFT  = 32;
  GESTURE_SWIPE_UP    = 64;
  GESTURE_SWIPE_DOWN  = 128;
  GESTURE_PINCH_IN    = 256;
  GESTURE_PINCH_OUT   = 512;
{%endregion}

{%region 'enum CamerMode'}
  // Camera system modes
  CAMERA_CUSTOM       = 0;
  CAMERA_FREE         = 1;
  CAMERA_ORBITAL      = 2;
  CAMERA_FIRST_PERSON = 3;
  CAMERA_THIRD_PERSON = 4;
{%endregion}

{%region 'enum CameraProjection'}
  // Camera projection modes
  CAMERA_PERSPECTIVE   = 0;
  CAMERA_ORTHOGRAPHIC  = 1;
{%endregion}

{%region 'enum NPatchLayout'}
  // Type of n-patch
  NPATCH_NINE_PATCH             = 0;
  NPATCH_THREE_PATCH_VERTICAL   = 1;
  NPATCH_THREE_PATCH_HORIZONTAL = 2;
{%endregion}

{%region 'Internal Callback Pointer Types'}
// Callbacks to hook some internal functions
// WARNING: This callbacks are intended for advance users

type
  TTraceLogCallback     = procedure(aLogType : Integer; aText, aArgs : PAnsiChar); cdecl;
  //PLoadFileDataCallback = ^TLoadFileDataCallback;
  TLoadFileDataCallback = function(aFileName : PChar; aBytesRead : PCardinal) : PByte; cdecl;
  TSaveFileDataCallback = function(aFileName : PChar; aData : Pointer; aBytesToWrite : Cardinal) : Boolean; cdecl;

  // A type for a function or procedure should inherently a pointer
  // rendering the following commented line, a point to a function pointer,
  //   essentially a  CB** in C (or more easily, a list/array of callbacks)
  // @LOOKOUT: Look to see if there are callback** in the following functions.
  //           if so, we will need this type declared (but I would err' on
  //           PT...Callback or PP...Callback)
  //PLoadFileTextCallback = ^TLoadFileTextCallback;
  TLoadFileTextCallback = function(aFileName : PChar) : PChar; cdecl;
  TSaveFileTextCallback = function(aFileName : PChar; aText : PChar) : PChar; cdecl;
{%endregion}

{%region 'Window Functions'}

// Window-related functions
procedure InitWindow(aWidth : Integer; aHeight : Integer; aTitle : PAnsiChar); cdecl; external cDllName;
function  WindowShouldClose() : Boolean; cdecl; external cDllName;
procedure CloseWindow(); cdecl; external cDllName;
function  IsWindowReady() : Boolean; cdecl; external cDllName;
function  IsWindowFullscreen() : Boolean; cdecl; external cDllName;
function  IsWindowHidden() : Boolean; cdecl; external cDllName;
function  IsWindowMinimized() : Boolean; cdecl; external cDllName;
function  IsWindowMaximized() : Boolean; cdecl; external cDllName;
function  IsWindowFocused() : Boolean; cdecl; external cDllName;
function  IsWindowResized() : Boolean; cdecl; external cDllName;
function  IsWindowState(aFlag : Cardinal) : Boolean; cdecl; external cDllName;
procedure SetWindowState(aFlag : Cardinal); cdecl; external cDllName;
procedure ClearWindowState(aFlag : Cardinal); cdecl; external cDllName;
procedure ToggleFullscreen(); cdecl; external cDllName;
procedure MaximizeWindow(); cdecl; external cDllName;
procedure MinimizeWindow(); cdecl; external cDllName;
procedure RestoreWindow(); cdecl; external cDllName;
procedure SetWindowIcon(aImage: TImage); cdecl; external cDllName;
procedure SetWindowTitle(aTitle: PAnsiChar); cdecl; external cDllName;
procedure SetWindowPosition(aX: Integer; aY: Integer); cdecl; external cDllName;
procedure SetWindowMonitor(aMonitor: Integer); cdecl; external cDllName;
procedure SetWindowMinSize(aWidth: Integer; aHeight: Integer); cdecl; external cDllName;
procedure SetWindowSize(aWidth: Integer; aHeight: Integer); cdecl; external cDllName;
function  GetWindowHandle(): Pointer; cdecl; external cDllName;
function  GetScreenWidth(): Integer; cdecl; external cDllName;
function  GetScreenHeight(): Integer; cdecl; external cDllName;
function  GetMonitorCount(): Integer; cdecl; external cDllName;
function  GetCurrentMonitor(): Integer; cdecl; external cDllName;
function  GetMonitorPosition(aMonitor : Integer) : TVector2; cdecl; external cDllName;
function  GetMonitorWidth(aMonitor : Integer): Integer; cdecl; external cDllName;
function  GetMonitorHeight(aMonitor : Integer): Integer; cdecl; external cDllName;
function  GetMonitorPhysicalWidth(aMonitor : Integer): Integer; cdecl; external cDllName;
function  GetMonitorPhysicalHeight(aMonitor : Integer): Integer; cdecl; external cDllName;
function  GetMonitorRefreshRate(aMonitor : Integer): Integer; cdecl; external cDllName;
function  GetWindowPosition(): TVector2; cdecl; external cDllName; // Get window position XY on monitor
function  GetWindowScaleDPI(): TVector2; cdecl; external cDllName;
function  GetMonitorName(aMonitor : Integer): PAnsiChar; cdecl; external cDllName;

// Gone
//procedure UnhideWindow(); cdecl; external cDllName;
//procedure HideWindow(); cdecl; external cDllName;

{%endregion}

{%region 'Clipboard Functions'}

function  GetClipboardText(): PAnsiChar; cdecl; external cDllName;
procedure SetClipboardText(aText : PAnsiChar); cdecl; external cDllName;

{%endregion}

{%region 'Cursor Functions'}

procedure ShowCursor(); cdecl; external cDllName;
procedure HideCursor(); cdecl; external cDllName;
function  IsCursorHidden(): Boolean; cdecl; external cDllName;
procedure EnableCursor(); cdecl; external cDllName;
procedure DisableCursor(); cdecl; external cDllName;
function  IsCursorOnScreen() : Boolean; cdecl; external cDllName;

{%endregion}

{%region 'Drawing Functions'}

procedure ClearBackground(aColor: TColor); cdecl; external cDllName;
procedure BeginDrawing(); cdecl; external cDllName;
procedure EndDrawing(); cdecl; external cDllName;
procedure BeginMode2D(aCamera: TCamera2D); cdecl; external cDllName;
procedure EndMode2D(); cdecl; external cDllName;
procedure BeginMode3D(aCamera: TCamera3D); cdecl; external cDllName;
procedure EndMode3D(); cdecl; external cDllName;
procedure BeginTextureMode(aTarget: TRenderTexture); cdecl; external cDllName;
procedure EndTextureMode(); cdecl; external cDllName;
procedure BeginShaderMode(aShader : TShader); cdecl; external cDllName;
procedure EndShaderMode(); cdecl; external cDllName;
procedure BeginBlendMode(aMode : Integer); cdecl; external cDllName;
procedure EndBlendMode(); cdecl; external cDllName;
procedure BeginScissorMode(aX, aY, aWidth, aHeight : Integer); cdecl; external cDllName;
procedure EndScissorMode(); cdecl; external cDllName;
procedure BeginVrStereoMode(aConfig : TVrStereoConfig); cdecl; external cDllName;
procedure EndVrStereoMode(); cdecl; external cDllName;

{%endregion}

{%region 'VR Configuration Functions'}

// VR stereo config functions for VR simulator
function  LoadVrStereoConfig(aDevice : TVrDeviceInfo) : TVrStereoConfig; cdecl; external cDllName;     // Load VR stereo config for VR simulator device parameters
procedure UnloadVrStereoConfig(aConfig : TVrStereoConfig); cdecl; external cDllName;           // Unload VR stereo config

{%endregion}

{%region 'Shader Management Functions'}

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
function  LoadShader(aVsFileName, aFsFileName : PChar) : TShader; cdecl; external cDllName;   // Load shader from files and bind default locations
function  LoadShaderFromMemory(aVsCode, aFsCode : PChar) : TShader; cdecl; external cDllName; // Load shader from code strings and bind default locations
function  GetShaderLocation(aShader : TShader; aUuniformName : PChar) : Integer; cdecl; external cDllName;       // Get shader uniform location
function  GetShaderLocationAttrib(aShader : TShader; aAttribName : PChar) : Integer; cdecl; external cDllName;  // Get shader attribute location
procedure SetShaderValue(shader : TShader; aLocIndex : Integer; aValue : Pointer; aUniformType : Integer); cdecl; external cDllName;               // Set shader uniform value
procedure SetShaderValueV(shader : TShader; aLocIndex : Integer; aValue : Pointer; aUniformType, aCount : Integer); cdecl; external cDllName;   // Set shader uniform value vector
procedure SetShaderValueMatrix(aShader : TShader; aLocIndex : Integer; aMat : TMatrix); cdecl; external cDllName;         // Set shader uniform value (matrix 4x4)
procedure SetShaderValueTexture(aShader : TShader; aLocIndex : Integer; aTexture : TTexture); cdecl; external cDllName; // Set shader uniform value for texture (sampler2d)
procedure UnloadShader(aShader : TShader); cdecl; external cDllName;                                    // Unload shader from GPU memory (VRAM)

{%endregion}

{%region 'Screen Space Functions'}

// Screen-space-related functions
function  GetMouseRay(aMousePosition: TVector2; aCamera: TCamera) : TRay; cdecl; external cDllName;
function  GetCameraMatrix(aCamera : TCamera) : TMatrix; cdecl; external cDllName;
function  GetCameraMatrix2D(aCamera : TCamera2D) : TMatrix; cdecl; external cDllName;
function  GetWorldToScreen(aPosition: TVector3; aCamera: TCamera) : TVector2; cdecl; external cDllName;
function  GetWorldToScreenEx(aPosition : TVector3; aCamera : TCamera; aWidth, aHeight : Integer) : TVector2; cdecl; external cDllName;
function  GetWorldToScreen2D(aPosition : TVector2; aCamera : TCamera2D) : TVector2; cdecl; external cDllName;
function  GetScreenToWorld2D(aPosition : TVector2; aCamera : TCamera2D) : TVector2; cdecl; external cDllName;
{%endregion}

// Timming-related functions
procedure SetTargetFPS(aFPS: Integer); cdecl; external cDllName;
function  GetFPS(): Integer; cdecl; external cDllName;
function  GetFrameTime(): Single; cdecl; external cDllName;
function  GetTime(): Double; cdecl; external cDllName;

// TColor-related functions
function  ColorToInt(aColor: TColor): Integer; cdecl; external cDllName;
function  ColorNormalize(aColor: TColor): TVector4; cdecl; external cDllName;
function  ColorFromNormalized(aNormalized : TVector4): TColor; cdecl; external cDllName;
function  ColorToHSV(aColor: TColor): TVector3; cdecl; external cDllName;
function  ColorFromHSV(aHsv : TVector3): TColor; cdecl; external cDllName;
function  GetColor(aHexValue: Integer): TColor; cdecl; external cDllName;
function  Fade(aColor: TColor; aAlpha: Single): TColor; cdecl; external cDllName;

// Misc. functions
procedure SetConfigFlags(aFlags : Cardinal); cdecl; external cDllName;
procedure SetTraceLogLevel(aLogType : Integer); cdecl; external cDllName;
procedure SetTraceLogExit(aLogType : Integer); cdecl; external cDllName;
procedure SetTraceLogCallback(aCallback : TTraceLogCallback); cdecl; external cDllName;
procedure TraceLog(aLogType : Integer; aText : PAnsiChar); cdecl; external cDllName;
procedure TakeScreenshot(aFilename : PAnsiChar); cdecl; external cDllName;
function  GetRandomValue(aMin : Integer; aMax : Integer): Integer; cdecl; external cDllName;

// Files management functions
function  LoadFileData(aFileName: PAnsiChar; bytesRead: PCardinal): PAnsiChar; cdecl; external;
procedure SaveFileData(aFileName: PAnsiChar; aData: Pointer; bytesToWrite: Cardinal); cdecl; external;
function  LoadFileText(aFileName: PAnsiChar): PAnsiChar; cdecl; external cDllName;
procedure SaveFileText(aFileName: PAnsiChar; aText: PAnsiChar); cdecl; external cDllName;
function  FileExists(aFilename : PAnsiChar): Boolean; cdecl; external cDllName;
function  IsFileExtension(aFilename: PAnsiChar; aExt: PAnsiChar): Boolean; cdecl; external cDllName;
function  DirectoryExists(aDirPath : PAnsiChar): Boolean; cdecl; external cDllName;
function  GetExtension(aFilename: PAnsiChar): PAnsiChar; cdecl; external cDllName;
function  GetFileName(aFilepath: PAnsiChar): PAnsiChar; cdecl; external cDllName;
function  GetFileNameWithoutExt(aFilepath : PAnsiChar): PAnsiChar; cdecl; external cDllName;
function  GetDirectoryPath(aFilename: PAnsiChar): PAnsiChar; cdecl; external cDllName;
function  GetPrevDirectoryPath(aDirPath : PAnsiChar): PAnsiChar; cdecl; external cDllName;
function  GetWorkingDirectory(): AnsiChar; cdecl; external cDllName;
function  GetDirectoryFiles(aDirpath : PAnsiChar; aCount : PInteger) : PPAnsiChar; cdecl; external cDllName;
procedure ClearDirectoryFiles(); cdecl; external cDllName;
function  ChangeDirectory(aDir: PAnsiChar): Boolean; cdecl; external cDllName;
function  IsFileDropped(): Boolean; cdecl; external cDllName;
function  GetDroppedFiles(aCount: PInteger): PPAnsiChar; cdecl; external cDllName;
procedure ClearDroppedFiles; cdecl; external cDllName;
function  GetFileModTime(aFilename : PAnsiChar): LongInt; cdecl; external cDllName;

function  CompressData(aData : PByte; aDataLength : Integer; aCompDataLength : PInteger) : PByte; cdecl; external cDllName;
function  DecompressData(aCompData : PByte; aCompDataLength : Integer; aDataLength : PInteger) : PByte; cdecl; external cDllName;

// Persistent storage management
procedure StorageSaveValue(aPosition: Integer; aValue: Integer); cdecl; external cDllName;
function  StorageLoadValue(aPosition: Integer): Integer; cdecl; external cDllName;

procedure OpenURL(aUrl : PAnsiChar); cdecl; external cDllName;

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
function  IsKeyPressed(aKey: Integer): Boolean; cdecl; external cDllName;
function  IsKeyDown(aKey: Integer): Boolean; cdecl; external cDllName;
function  IsKeyReleased(aKey: Integer): Boolean; cdecl; external cDllName;
function  IsKeyUp(aKey: Integer): Boolean; cdecl; external cDllName;
function  GetKeyPressed(): Integer; cdecl; external cDllName;
procedure SetExitKey(aKey: Integer); cdecl; external cDllName;

// Input-related functions: gamepads
function  IsGamepadAvailable(aGamepad: Integer): Boolean; cdecl; external cDllName;
function  IsGamepadName(aGamepad: Integer; aName: PAnsiChar): Boolean; cdecl; external cDllName;
function  GetGamepadName(aGamepad: Integer): PAnsiChar; cdecl; external cDllName;
function  IsGamepadButtonPressed(aGamepad: Integer; aButton: Integer): Boolean; cdecl; external cDllName;
function  IsGamepadButtonDown(aGamepad: Integer; aButton: Integer): Boolean; cdecl; external cDllName;
function  IsGamepadButtonReleased(aGamepad: Integer; aButton: Integer): Boolean; cdecl; external cDllName;
function  IsGamepadButtonUp(aGamepad: Integer; aButton: Integer): Boolean; cdecl; external cDllName;
function  GetGamepadButtonPressed(): Integer; cdecl; external cDllName;
function  GetGamepadAxisCount(aGamepad: Integer): Integer; cdecl; external cDllName;
function  GetGamepadAxisMovement(aGamepad: Integer; aAxis: Integer): Single; cdecl; external cDllName;

// Input-related functions: mouse
function  IsMouseButtonPressed(aButton: Integer): Boolean; cdecl; external cDllName;
function  IsMouseButtonDown(aButton: Integer): Boolean; cdecl; external cDllName;
function  IsMouseButtonReleased(aButton: Integer): Boolean; cdecl; external cDllName;
function  IsMouseButtonUp(aButton: Integer): Boolean; cdecl; external cDllName;
function  GetMouseX: Integer; cdecl; external cDllName;
function  GetMouseY: Integer; cdecl; external cDllName;
function  GetMousePosition(): TVector2; cdecl; external cDllName;
procedure SetMousePosition(aPosition: TVector2); cdecl; external cDllName;
procedure SetMouseOffset(aOffsetX, aOffsetY : Integer); cdecl; external cDllName;
procedure SetMouseScale(aScaleX, aScaleY: Single); cdecl; external cDllName;
function  GetMouseWheelMove(): Integer; cdecl; external cDllName;

// Input-related functions: touch
function  GetTouchX(): Integer; cdecl; external cDllName;
function  GetTouchY(): Integer; cdecl; external cDllName;
function  GetTouchPosition(aIndex: Integer): TVector2; cdecl; external cDllName;

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: gestures)
//------------------------------------------------------------------------------------
procedure SetGesturesEnabled(aGestureFlags: Cardinal); cdecl; external cDllName;
function  IsGestureDetected(aGesture: Integer): Boolean; cdecl; external cDllName;
function  GetGestureDetected(): Integer; cdecl; external cDllName;
function  GetTouchPointsCount(): Integer; cdecl; external cDllName;
function  GetGestureHoldDuration(): Single; cdecl; external cDllName;
function  GetGestureDragVector(): TVector2; cdecl; external cDllName;
function  GetGestureDragAngle(): Single; cdecl; external cDllName;
function  GetGesturePinchVector(): TVector2; cdecl; external cDllName;
function  GetGesturePinchAngle(): Single; cdecl; external cDllName;

//------------------------------------------------------------------------------------
// TCamera System Functions (Module: TCamera)
//------------------------------------------------------------------------------------
procedure SetCameraMode(aCamera: TCamera; aMode: Integer); cdecl; external cDllName;
procedure UpdateCamera(aCamera: PCamera); cdecl; external cDllName;

procedure SetCameraPanControl(aPanKey: Integer); cdecl; external cDllName;
procedure SetCameraAltControl(aAltKey: Integer); cdecl; external cDllName;
procedure SetCameraSmoothZoomControl(aszKey: Integer); cdecl; external cDllName;
procedure SetCameraMoveControls(aFrontKey: Integer; aBackKey: Integer; aRightKey: Integer; aLeftKey: Integer; aUpKey: Integer; aDownKey: Integer); cdecl; external cDllName;

//------------------------------------------------------------------------------------
// Basic Shapes Drawing Functions (Module: shapes)
//------------------------------------------------------------------------------------

// Basic shapes drawing functions
procedure DrawPixel(aPosX: Integer; aPosY: Integer; aColor: TColor); cdecl; external cDllName;
procedure DrawPixelV(aPosition: TVector2; TColor: TColor); cdecl; external cDllName;
procedure DrawLine(aStartPosX: Integer; aStartPosY: Integer; aEndPosX: Integer; aEndPosY: Integer; aColor: TColor); cdecl; external cDllName;
procedure DrawLineV(aStartPos: TVector2; aEndPos: TVector2; aColor: TColor); cdecl; external cDllName;
procedure DrawLineEx(aStartPos: TVector2; aEndPos: TVector2; aThick: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawLineBezier(aStartPos: TVector2; aEndPos: TVector2; aThick: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawLineStrip(aPoints : PVector2; aNumPoints : Integer; aColor : TColor); cdecl; external cDllName;

procedure DrawCircle(aCenterX: Integer; aCenterY: Integer; aRadius: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawCircleSector(aCenter : TVector2; aRadius : Single; aStartAngle, aEndAngle, aSegments : Integer; aColor : TColor); cdecl; external cDllName;
procedure DrawCircleSectorLines(aCenter : TVector2; aRadius : Single; aStartAngle, aEndAngle, aSegments : Integer; aColor : TColor); cdecl; external cDllName;
procedure DrawCircleGradient(aCenterX: Integer; aCenterY: Integer; aRadius: Single; aColor1: TColor; aColor2: TColor); cdecl; external cDllName;
procedure DrawCircleV(aCenter: TVector2; aRadius: Single; TColor: TColor); cdecl; external cDllName;
procedure DrawCircleLines(aCenterX: Integer; aCenterY: Integer; aRadius: Single; aColor: TColor); cdecl; external cDllName;

procedure DrawEllipse(aCenterX: Integer; aCenterY: Integer; aRadiusH: Single; aRadiusV: Single; aColor:TColor); cdecl; external cDllName;
procedure DrawEllipseLines(aCenterX: Integer; aCenterY: Integer; aRadiusH: Single; aRadiusV: Single; aColor:TColor); cdecl; external cDllName;

procedure DrawRing( aCenter : TVector2; aInnerRadius, aOuterRadius : Single; aStartAngle, aEndAngle, aSegments : Integer; aColor : TColor); cdecl; external cDllName;
procedure DrawRingLines( aCenter : TVector2; aInnerRadius, aOuterRadius : Single; aStartAngle, aEndAngle, aSegments : Integer; aColor : TColor); cdecl; external cDllName;

procedure DrawRectangle(aPosX: Integer; aPosY: Integer; aWidth: Integer; aHeight: Integer; aColor: TColor); cdecl; external cDllName;
procedure DrawRectangleV(aPosition: TVector2; size: TVector2; TColor: TColor); cdecl; external cDllName;
procedure DrawRectangleRec(aRect: TRectangle; aColor: TColor); cdecl; external cDllName;
procedure DrawRectanglePro(aRect: TRectangle; origin: TVector2; aRotation: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawRectangleGradientV(aPosX: Integer; aPosY: Integer; aWidth: Integer; aHeight: Integer; aColor1: TColor; aColor2: TColor); cdecl; external cDllName;
procedure DrawRectangleGradientH(aPosX: Integer; aPosY: Integer; aWidth: Integer; aHeight: Integer; aColor1: TColor; aColor2: TColor); cdecl; external cDllName;
procedure DrawRectangleGradientEx(aRect: TRectangle; aCol1: TColor; aCol2: TColor; aCol3: TColor; aCol4: TColor); cdecl; external cDllName;
procedure DrawRectangleLines(aPosX: Integer; aPosY: Integer; aWidth: Integer; aHeight: Integer; TColor: TColor); cdecl; external cDllName;
procedure DrawRectangleLinesEx(aRect: TRectangle; lineThick: Integer; TColor: TColor); cdecl; external cDllName;
procedure DrawRectabgleRounded(aRec : TRectangle; aRoundness : Single; aSegments, aLineThick : Integer; aColor : TColor); cdecl; external cDllName;
procedure DrawRectabgleRoundedLines(aRec : TRectangle; aRoundness : Single; aSegments, aLineThick : Integer; aColor : TColor); cdecl; external cDllName;


procedure DrawTriangle(aVec1: TVector2; aVec2: TVector2; aVec3: TVector2; aColor: TColor); cdecl; external cDllName;
procedure DrawTriangleLines(aVec1: TVector2; aVec2: TVector2; aVec3: TVector2; aColor: TColor); cdecl; external cDllName;
procedure DrawTriangleFan(aPoints : PVector2; aNumPoints : Integer; aColor : TColor); cdecl; external cDllName;
procedure DrawTriangleStrip(aPoints : PVector2; aPointsCount : Integer; aColor : TColor); cdecl; external cDllName;
procedure DrawPoly(aCenter: TVector2; aSides: Integer; aRadius: Single; aRotation: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawPolyLines(aCenter: TVector2; aSides: Integer; aRadius: Single; aRotation:Single; aColor: TColor); cdecl; external cDllName;

// Basic shapes collision detection functions
function  CheckCollisionRecs(aRect1: TRectangle; aRect2: TRectangle): Boolean; cdecl; external cDllName;
function  CheckCollisionCircles(aCenter1: TVector2; aRadius1: Single; aCenter2: TVector2; aRadius2: Single): Boolean; cdecl; external cDllName;
function  CheckCollisionCircleRec(aCenter: TVector2; aRadius: Single; aRect: TRectangle): Boolean; cdecl; external cDllName;
function  GetCollisionRec(aRect1: TRectangle; aRect2: TRectangle): TRectangle; cdecl; external cDllName;
function  CheckCollisionPointRec(aPoint: TVector2; aRect: TRectangle): Boolean; cdecl; external cDllName;
function  CheckCollisionPointCircle(aPoint: TVector2; aCenter: TVector2; aRadius: Single): Boolean; cdecl; external cDllName;
function  CheckCollisionPointTriangle(aPoint: TVector2; aP1: TVector2; aP2: TVector2; aP3: TVector2): Boolean; cdecl; external cDllName;

//------------------------------------------------------------------------------------
// Texture Loading and Drawing Functions (Module: textures)
//------------------------------------------------------------------------------------

// Image loading functions
// NOTE: This functions do not require GPU access
function  LoadImage(aFilename: PAnsiChar): TImage; cdecl; external cDllName;
function  LoadImageEx(aPixels: PColor; aWidth: Integer; aHeight: Integer): TImage; cdecl; external cDllName;
function  LoadImagePro(aData: Pointer; aWidth: Integer; aHeight: Integer; aFormat: Integer): TImage; cdecl; external cDllName;
function  LoadImageRaw(aFilename: PAnsiChar; aWidth: Integer; aHeight: Integer; aFormat: Integer; headerSize: Integer): TImage; cdecl; external cDllName;
procedure UnloadImage(aImage: TImage); cdecl; external cDllName;
procedure ExportImage(aFilename: PAnsiChar; TImage: TImage); cdecl; external cDllName;
procedure ExportImageAsCode(aImage : TImage; aFilename : PAnsiChar); cdecl; external cDllName;
function  GetImageData(aImage: TImage): PColor; cdecl; external cDllName;
function  GetImageDataNormalized(aImage: TImage): PVector4; cdecl; external cDllName;

// TImage generation functions
function  GenImageColor(aWidth: Integer; aHeight: Integer; aColor: TColor): TImage; cdecl; external cDllName;
function  GenImageGradientV(aWidth: Integer; aHeight: Integer; aTop: TColor; aBottom: TColor): TImage; cdecl; external cDllName;
function  GenImageGradientH(aWidth: Integer; aHeight: Integer; aLeft: TColor; aRight: TColor): TImage; cdecl; external cDllName;
function  GenImageGradientRadial(aWidth: Integer; aHeight: Integer; aDensity: Single; aInner: TColor; aOuter: TColor): TImage; cdecl; external cDllName;
function  GenImageChecked(aWidth: Integer; aHeight: Integer; aChecksX: Integer; aChecksY: Integer; aCol1: TColor; aCol2: TColor): TImage; cdecl; external cDllName;
function  GenImageWhiteNoise(aWidth: Integer; aHeight: Integer; aFactor: Single): TImage; cdecl; external cDllName;
function  GenImagePerlinNoise(aWidth: Integer; aHeight: Integer; aOffsetX: Integer; aOffsetY: Integer; aScale: Single): TImage; cdecl; external cDllName;
function  GenImageCellular(aWidth: Integer; aHeight: Integer; aTileSize: Integer): TImage; cdecl; external cDllName;

// TImage manipulation functions
function  ImageCopy(aImage: TImage): TImage; cdecl; external cDllName;
function  ImageFromImage(aImage : TImage; aRec : TRectangle): TImage; cdecl; external cDllName;
function  ImageText(aText: PAnsiChar; aFontSize: Integer; aColor: TColor): TImage; cdecl; external cDllName;
function  ImageTextEx(aFont: TFont; aText: PAnsiChar; aFontSize: Single; aSpacing: Single; aTint: TColor): TImage; cdecl; external cDllName;
procedure ImageToPOT(aImage: PImage; fillColor: TColor); cdecl; external cDllName;
procedure ImageFormat(aImage: PImage; aNewFormat: Integer); cdecl; external cDllName;
procedure ImageAlphaMask(aImage : PImage; alphaMask: TImage); cdecl; external cDllName;
procedure ImageAlphaClear(aImage : PImage; TColor: TColor; threshold: Single); cdecl; external cDllName;
procedure ImageAlphaCrop(aImage : PImage; threshold: Single); cdecl; external cDllName;
procedure ImageAlphaPremultiply(aImage : PImage); cdecl; external cDllName;
procedure ImageCrop(aImage : PImage; crop: TRectangle); cdecl; external cDllName;
procedure ImageResize(aImage : PImage; aNewWidth: Integer; aNewHeight: Integer); cdecl; external cDllName;
procedure ImageResizeNN(aImage : PImage; aNewWidth: Integer; aNewHeight: Integer); cdecl; external cDllName;
procedure ImageResizeCanvas(aImage : PImage; aNewWidth: Integer; aNewHeight: Integer; aOffsetX: Integer; aOffsetY: Integer; aColor: TColor); cdecl; external cDllName;
procedure ImageMipmaps(aImage : PImage); cdecl; external cDllName;
procedure ImageDither(aImage : PImage; aRedBpp: Integer; aGreenBpp: Integer; aBlueBpp: Integer; aAlphaBpp: Integer); cdecl; external cDllName;
procedure ImageFlipVertical(aImage : PImage); cdecl; external cDllName;
procedure ImageFlipHorizontal(aImage : PImage); cdecl; external cDllName;
procedure ImageRotateCW(aImage : PImage); cdecl; external cDllName;
procedure ImageRotateCCW(aImage : PImage); cdecl; external cDllName;
procedure ImageColorTint(aImage : PImage; aColor: TColor); cdecl; external cDllName;
procedure ImageColorInvert(aImage : PImage); cdecl; external cDllName;
procedure ImageColorGrayscale(aImage : PImage); cdecl; external cDllName;
procedure ImageColorContrast(aImage : PImage; aContrast: Single); cdecl; external cDllName;
procedure ImageColorBrightness(aImage : PImage; aBrightness: Integer); cdecl; external cDllName;
procedure ImageColorReplace(aImage : PImage; aColor: TColor; aReplace: TColor); cdecl; external cDllName;
function  ImageExtractPalette(aImage : TImage; aMaxPaletteSize : Integer; aExtractCount : PInteger): PColor; cdecl; external cDllName;
function  GetImageAlphaBorder(aImage : TImage; aThreshold : Single): TRectangle; cdecl; external cDllName;

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
procedure ImageClearBackground(aDst: PImage; aColor: TColor); cdecl; external cDllName;
procedure ImageDrawPixel(aDst: PImage; aPosX: Integer; aPosY: Integer; aColor: TColor); cdecl; external cDllName;
procedure ImageDrawPixelV(aDst: PImage; aPosition: TVector2; aColor: TColor); cdecl; external cDllName;
procedure ImageDrawLine(aDst: PImage; aStartPosX: Integer; aStartPosY: Integer; aEndPosX: Integer; aEndPosY: Integer; aColor: TColor); cdecl; external cDllName;
procedure ImageDrawLineV(aDst: PImage; aStart: TVector2; aEnd: TVector2; aColor: TColor); cdecl; external cDllName;
procedure ImageDrawCircle(aDst: PImage; aCenterX: Integer; aCenterY: Integer; aRadius: Integer; aColor:TColor); cdecl; external cDllName;
procedure ImageDrawCircleV(aDst: PImage; aCenter: TVector2; aRadius: Integer; aColor: TColor); cdecl; external cDllName;
procedure ImageDrawRectangle(aDst: PImage; aPosX: Integer; aPosY: Integer; aWidth: Integer; aHeight: Integer); cdecl; external cDllName;
procedure ImageDrawRectangleV(aDst: PImage; aPosition: TVector2; aSize: TVector2; aColor: TColor); cdecl; external cDllName;
procedure ImageDrawRectangleRec(aDst: PImage; aRec: TRectangle; aColor: TColor); cdecl; external cDllName;
procedure ImageDrawRectangleLines(aDst : PImage; aRec : TRectangle; aThick : Integer; aColor : TColor); cdecl; external cDllName;                   // Draw rectangle lines within an image
procedure ImageDraw(aDest : PImage; aSrc: TImage; aSrcRec: TRectangle; aDestRec: TRectangle; aTint: TColor); cdecl; external cDllName;
procedure ImageDrawText(aDest : PImage; aPosition: TVector2; aText: PAnsiChar; aFontSize: Integer; aColor: TColor); cdecl; external cDllName;
procedure ImageDrawTextEx(aDest : PImage; aPosition: TVector2; TFont: TFont; aText: PAnsiChar; aFontSize: Single; aSpacing: Single; aColor: TColor); cdecl; external cDllName;

// Texture loading functions
// NOTE: These functions require GPU access
function  LoadTexture(aFilename: PAnsiChar): TTexture2D; cdecl; external cDllName;
function  LoadTextureFromImage(aImage: TImage): TTexture2D; cdecl; external cDllName;
function  LoadTextureCubemap(aImage : TImage; aLayoutType : Integer) : TTextureCubemap; cdecl; external cDllName;
function  LoadRenderTexture(aWidth: Integer; aHeight: Integer): TRenderTexture2D; cdecl; external cDllName;
procedure UnloadTexture(aTexture: TTexture2D); cdecl; external cDllName;
procedure UnloadRenderTexture(aTarget: TRenderTexture2D); cdecl; external cDllName;
procedure UpdateTexture(aTexture: TTexture2D; aPixels: Pointer); cdecl; external cDllName;
function  GetTextureData(aTexture: TTexture2D): TImage; cdecl; external cDllName;
function  GetScreenData(): TImage; cdecl; external cDllName;

// TTexture2D configuration functions
procedure GenTextureMipmaps(aTexture: PTexture2D); cdecl; external cDllName;
procedure SetTextureFilter(aTexture: TTexture2D; aFilterMode: Integer); cdecl; external cDllName;
procedure SetTextureWrap(aTexture: TTexture2D; aWrapMode: Integer); cdecl; external cDllName;

// TTexture2D drawing functions
procedure DrawTexture(aTexture: TTexture2D; posX: Integer; aPosY: Integer; aTint: TColor); cdecl; external cDllName;
procedure DrawTextureV(aTexture: TTexture2D; position: TVector2; aTint: TColor); cdecl; external cDllName;
procedure DrawTextureEx(aTexture: TTexture2D; position: TVector2; aRotation: Single; aScale: Single; aTint: TColor); cdecl; external cDllName;
procedure DrawTextureRec(aTexture: TTexture2D; sourceRec: TRectangle; aPosition: TVector2; tint: TColor); cdecl; external cDllName;
procedure DrawTextureQuad(aTexture: TTexture2D; aTiling, aOffset : TVector2; aQuad : TRectangle; aTint : TColor); cdecl; external cDllName;
procedure DrawTexturePro(aTexture: TTexture2D; sourceRec: TRectangle; aDestRec: TRectangle; aOrigin: TVector2; aRotation: Single; aTint: TColor); cdecl; external cDllName;
procedure DrawTextureNPatch(aTexture: TTexture2D; aNPatchInfo : TNPatchInfo; aDestRec : TRectangle; aOrigin : TVector2; aRotation : Single; aTint : TColor); cdecl; external cDllName;

// Image/Texture misc functions
function  GetPixelDataSize(aWidth: Integer; aHeight: Integer; aFormat: Integer): Integer; cdecl; external cDllName;

//------------------------------------------------------------------------------------
// TFont Loading and Text Drawing Functions (Module: text)
//------------------------------------------------------------------------------------

// TFont loading/unloading functions
function  GetFontDefault(): TFont; cdecl; external cDllName;
function  LoadFont(aFilename: PAnsiChar): TFont; cdecl; external cDllName;
function  LoadFontEx(aFilename: PAnsiChar; aFontSize: Integer; aFontChars: PInteger; aCharsCount: Integer): TFont; cdecl; external cDllName;
function  LoadFontFromImage(aImage : TImage; aKey : TColor; aFirstChar : Integer): TFont; cdecl; external cDllName;
function  LoadFontData(aFilename: PAnsiChar; aFontSize: Integer; aFontChars: PInteger; aCharsCount, atype : Integer): PCharInfo; cdecl; external cDllName;
function  GenImageFontAtlas(aChars: PCharInfo; aRecs : PPRectangle; aCharsCount, aFontSize, aPadding, aPackMethod : Integer): TImage; cdecl; external cDllName;
procedure UnloadFont(aFont: TFont); cdecl; external cDllName;

// aText drawing functions
procedure DrawFPS(aPosX: Integer; aPosY: Integer); cdecl; external cDllName;
procedure DrawText(aText: PAnsiChar; aPosX: Integer; aPosY: Integer; aFontSize: Integer; TColor: TColor); cdecl; external cDllName;
procedure DrawTextEx(aFont: TFont; aText: PAnsiChar; aPosition: TVector2; aFontSize: Single; aSpacing: Single; aTint: TColor); cdecl; external cDllName;
procedure DrawTextRec(afont : TFont; aText : PAnsiChar; rec : TRectangle; aFontSize, aSpacing : Single; aWordWrap : Boolean; aTint : TColor); cdecl; external cDllName;   // Draw text using font inside rectangle limits
procedure DrawTextRecEx(aFont : TFont; aText : PAnsiChar; aRec : TRectangle; aFontSize, aSpacing : Single; aWordWrap : Boolean; aTint : TColor;
                        aSelectStart, aSelectLength : Integer; aSelectText, selectBack : TColor); cdecl; external cDllName;
procedure DrawTextCodepoint(aFont:TFont; aCodepoint: Integer; aPosition: TVector2; aScale: Single; aColor: TColor); cdecl; external cDllName;

// Text misc. functions
function  MeasureText(aText: PAnsiChar; aFontSize: Integer): Integer; cdecl; external cDllName;
function  MeasureTextEx(aFont: TFont; aText: PAnsiChar; aFontSize, aSpacing: Single): TVector2; cdecl; external cDllName;
function  GetGlyphIndex(aFont: TFont; character: Integer): Integer; cdecl; external cDllName;

// Text strings management functions (no utf8 strings, only byte chars)
// NOTE: Some strings allocate memory internally for returned strings, just be careful!
function  TextCopy(aDst: PAnsiChar;aScr: PAnsichar): Integer; cdecl; external cDllName;
function  TextIsEqual(aText1, aText2 : PAnsiChar): Boolean; cdecl; external cDllName;
function  TextLength(aText : PAnsiChar): Cardinal; cdecl; external cDllName;
function  TextFormat(aText: PAnsiChar; aArg:integer): PAnsiChar; cdecl; external cDllName;//3.0.0
function  TextSubtext(aText: PAnsiChar; aPosition: Integer; aLength: Integer): PAnsiChar; cdecl; external cDllName;
function  TextReplace(aText, aReplace, aBy : PAnsiChar): PAnsiChar; cdecl; external cDllName;
function  TextInsert(aText, aInsert : PAnsiChar; aPosition : Integer): PAnsiChar; cdecl; external cDllName;           // Insert text in a position (memory should be freed!)
function  TextJoin(aTextList : PPAnsiChar; aCount : Integer; aDelimiter : PAnsiChar): PAnsiChar; cdecl; external cDllName;        // Join text strings with delimiter
function  TextSplit(aText : PAnsiChar; aDelimiter : Char; aCount : PInteger): PPAnsiChar; cdecl; external cDllName;                 // Split text into multiple strings
procedure TextAppend(aText, aAppend : PAnsiChar; aPosition : PInteger); cdecl; external cDllName;                           // Append text at specific position and move cursor!
function  TextFindIndex(aText, aFind : PAnsiChar): Integer; cdecl; external cDllName;                          // Find first text occurrence within a string
function  TextToUpper(aText : PAnsiChar): PAnsiChar; cdecl; external cDllName;                      // Get upper case version of provided string
function  TextToLower(aText : PAnsiChar): PAnsiChar; cdecl; external cDllName;                      // Get lower case version of provided string
function  TextToPascal(aText : PAnsiChar): PAnsiChar; cdecl; external cDllName;                     // Get Pascal case notation version of provided string
function  TextToInteger(aText : PAnsiChar): Integer; cdecl; external cDllName; 
function  TextToUtf8(aCodepoints : PInteger; aLength : Integer): PAnsiChar; cdecl; external cDllName;

// UTF8 text strings management functions
function  GetCodepoints(aText : PAnsiChar; aCount : PInteger) : PInteger; cdecl; external cDllName;               // Get all codepoints in a string, codepoints count returned by parameters
function  GetCodepointsCount(aText : PAnsiChar) : Integer; cdecl; external cDllName;                       // Get total number of characters (codepoints) in a UTF8 encoded string
function  GetNextCodepoint(aText : PAnsiChar; aBytesProcessed : PInteger): Integer; cdecl; external cDllName;    // Returns next codepoint in a UTF8 encoded string; 0x3f('?') is returned on failure
function  CodepointToUtf8(aCodepoint : Integer; aByteLength : PInteger): PAnsiChar; cdecl; external cDllName;    // Encode codepoint into utf8 text (char array length returned as parameter)

//------------------------------------------------------------------------------------
// Basic 3d Shapes Drawing Functions (Module: models)
//------------------------------------------------------------------------------------
// Basic geometric 3D shapes drawing functions
procedure DrawLine3D(aStartPos: TVector3; aEndPos: TVector3; aColor: TColor); cdecl; external cDllName;
procedure DrawPoint3D(aPosition: TVector3; aColor:TColor); cdecl; external cDllName;
procedure DrawCircle3D(aCenter: TVector3; aRadius: Single; aRotationAxis: TVector3; aRotationAngle: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawCube(aPosition: TVector3; aWidth: Single; aHeight: Single; aLength: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawCubeV(aPosition: TVector3; aSize: TVector3; aColor: TColor); cdecl; external cDllName;
procedure DrawCubeWires(aPosition: TVector3; aWidth: Single; aHeight: Single; aLength: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawCubeWiresV(aPosition, aSize : TVector3; aColor : TColor); cdecl; external cDllName;
procedure DrawCubeTexture(aTexture: TTexture2D; aPosition: TVector3; aWidth: Single; aHeight: Single; aLength: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawSphere(aCenterPos: TVector3; aRadius: Single; aColor: TColor); cdecl; external cDllName;
procedure DrawSphereEx(aCenterPos: TVector3; aRadius: Single; aRings: Integer; aSlices: Integer; aColor: TColor); cdecl; external cDllName;
procedure DrawSphereWires(aCenterPos: TVector3; aRadius: Single; aRings: Integer; aSlices: Integer; aColor: TColor); cdecl; external cDllName;
procedure DrawCylinder(aPosition: TVector3; radiusTop: Single; aRadiusBottom: Single; aHeight: Single; aSlices: Integer; aColor: TColor); cdecl; external cDllName;
procedure DrawCylinderWires(aPosition: TVector3; radiusTop: Single; aRadiusBottom: Single; aHeight: Single; aSlices: Integer; aColor: TColor); cdecl; external cDllName;
procedure DrawPlane(aCenterPos: TVector3; aSize: TVector2; aColor: TColor); cdecl; external cDllName;
procedure DrawRay(TRay: TRay; aColor: TColor); cdecl; external cDllName;
procedure DrawGrid(aSlices: Integer; aSpacing: Single); cdecl; external cDllName;
procedure DrawGizmo(aPosition: TVector3); cdecl; external cDllName;
//DrawTorus(), DrawTeapot() could be useful?

//------------------------------------------------------------------------------------
// TModel 3d Loading and Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// TModel loading/unloading functions
function  LoadModel(aFilename: PAnsiChar): TModel; cdecl; external cDllName;
function  LoadModelFromMesh(aMesh: TMesh): TModel; cdecl; external cDllName;
procedure UnloadModel(aModel: TModel); cdecl; external cDllName;

// TMesh loading/unloading functions
function  LoadMeshes(aFilename: PAnsiChar; aCount : PInteger): PMesh; cdecl; external cDllName;
procedure ExportMesh(aMesh: TMesh; aFilename: PAnsiChar); cdecl; external cDllName;
procedure UnloadMesh(aMesh: TMesh); cdecl; external cDllName;

// Material loading/unloading functions
function  LoadMaterials(aFilename : PAnsiChar; aMaterialCount : PInteger): PMaterial; cdecl; external cDllName;                               // Load materials from model file
function  LoadMaterialDefault(): TMaterial; cdecl; external cDllName;                                                              // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
procedure UnloadMaterial(aMaterial : TMaterial); cdecl; external cDllName;                                                         // Unload material from GPU memory (VRAM)
procedure SetMaterialTexture(aMaterial : PMaterial; aMapType : Integer; aTexture : TTexture2D); cdecl; external cDllName;                     // Set texture for a material map type (MAP_DIFFUSE, MAP_SPECULAR...)
procedure SetModelMeshMaterial(aModel : PModel; aMeshId, aMaterialId : Integer); cdecl; external cDllName;

// Model animations loading/unloading functions
function  LoadModelAnimations(aFilename : PAnsiChar; aAnimsCount : PInteger): PModelAnimation; cdecl; external cDllName;                       // Load model animations from file
procedure UpdateModelAnimation(aModel : TModel; aAnim : TModelAnimation; aFrame : Integer); cdecl; external cDllName;                          // Update model animation pose
procedure UnloadModelAnimation(aAnim : TModelAnimation); cdecl; external cDllName;                                                  // Unload animation data
function  IsModelAnimationValid(aModel : TModel; aAnim : TModelAnimation): Boolean; cdecl; external cDllName;

// TMesh generation functions
function  GenMeshPoly(aSides : Integer; aRadius : Single): TMesh; cdecl; external cDllName;
function  GenMeshPlane(aWidth: Single; aLength: Single; aResX: Integer; aResZ: Integer): TMesh; cdecl; external cDllName;
function  GenMeshCube(aWidth: Single; aHeight: Single; aLength: Single): TMesh; cdecl; external cDllName;
function  GenMeshSphere(aRadius: Single; aRings: Integer; aSlices: Integer): TMesh; cdecl; external cDllName;
function  GenMeshHemiSphere(aRadius: Single; aRings: Integer; aSlices: Integer): TMesh; cdecl; external cDllName;
function  GenMeshCylinder(aRadius: Single; aHeight: Single; aSlices: Integer): TMesh; cdecl; external cDllName;
function  GenMeshTorus(aRadius: Single; aSize: Single; radSeg: Integer; sides: Integer): TMesh; cdecl; external cDllName;
function  GenMeshKnot(aRadius: Single; aSize: Single; radSeg: Integer; sides: Integer): TMesh; cdecl; external cDllName;
function  GenMeshHeightmap(aHeightMap: TImage; aSize: TVector3): TMesh; cdecl; external cDllName;
function  GenMeshCubicmap(aCubicMap: TImage; aCubeSize: TVector3): TMesh; cdecl; external cDllName;

// TMesh manipulation functions
function  MeshBoundingBox(aMesh: TMesh): TBoundingBox; cdecl; external cDllName;
procedure MeshTangents(aMesh: PMesh); cdecl; external cDllName;
procedure MeshBinormals(aMesh: PMesh); cdecl; external cDllName;

// TModel drawing functions
procedure DrawModel(aModel: TModel; aPosition: TVector3; aScale: Single; aTint: TColor); cdecl; external cDllName;
procedure DrawModelEx(aModel: TModel; aPosition: TVector3; aRotationAxis: TVector3; aRotationAngle: Single; aScale: TVector3; aTint: TColor); cdecl; external cDllName;
procedure DrawModelWires(aModel: TModel; aPosition: TVector3; aScale: Single; aTint: TColor); cdecl; external cDllName;
procedure DrawModelWiresEx(aModel: TModel; aPosition: TVector3; aRotationAxis: TVector3; aRotationAngle: Single; aScale: TVector3; aTint: TColor); cdecl; external cDllName;
procedure DrawBoundingBox(aBox: TBoundingBox; TColor: TColor); cdecl; external cDllName;
procedure DrawBillboard(aCamera: TCamera; aTexture: TTexture2D; aCenter: TVector3; aSize: Single; aTint: TColor); cdecl; external cDllName;
procedure DrawBillboardRec(aCamera: TCamera; aTexture: TTexture2D; sourceRec: TRectangle; aCenter: TVector3; aSize: Single; aTint: TColor); cdecl; external cDllName;

// Collision detection functions
function CheckCollisionSpheres(aCenterA: TVector3; aRadiusA: Single; aCenterB: TVector3; aRadiusB: Single): Boolean; cdecl; external cDllName;
function CheckCollisionBoxes(aBox1: TBoundingBox; aBox2: TBoundingBox): Boolean; cdecl; external cDllName;
function CheckCollisionBoxSphere(aBox: TBoundingBox; aCenterSphere: TVector3; aRadiusSphere: Single): Boolean; cdecl; external cDllName;
function CheckCollisionRaySphere(aRay: TRay; aSpherePosition: TVector3; aSphereRadius: Single): Boolean; cdecl; external cDllName;
function CheckCollisionRaySphereEx(aRay: TRay; aSpherePosition: TVector3; aSphereRadius: Single; var collisionPoint: TVector3): Boolean; cdecl; external cDllName;
function CheckCollisionRayBox(aRay: TRay; aBox: TBoundingBox): Boolean; cdecl; external cDllName;
function GetCollisionRayModel(aRay: TRay; var aModel: TModel): TRayHitInfo; cdecl; external cDllName;
function GetCollisionRayTriangle(aRay: TRay; aP1: TVector3; aP2: TVector3; aP3: TVector3): TRayHitInfo; cdecl; external cDllName;
function GetCollisionRayGround(aRay: TRay; aGroundHeight: Single): TRayHitInfo; cdecl; external cDllName;

//------------------------------------------------------------------------------------
// Shaders System Functions (Module: rlgl)
// NOTE: This functions are useless when using OpenGL 1.1
//------------------------------------------------------------------------------------

// TShader loading/unloading functions
// I think this may have been removed
//function  LoadShaderCode(avsCode: PAnsiChar; afsCode: PAnsiChar): TShader; cdecl; external cDllName;

function  GetShaderDefault(): TShader; cdecl; external cDllName;
function  GetTextureDefault(): TTexture2D; cdecl; external cDllName;
function  GetShapesTexture(): TTexture2D; cdecl; external cDllName;
function  GetShapesTextureRec(): TRectangle; cdecl; external cDllName;
procedure SetShapesTexture(aTexture : TTexture2D; aSource : TRectangle); cdecl; external cDllName;






procedure SetMatrixProjection(aProj: TMatrix); cdecl; external cDllName;
procedure SetMatrixModelview(aView: TMatrix); cdecl; external cDllName;
function  GetMatrixModelview(): TMatrix; cdecl; external cDllName;
function  GetMatrixProjection(): TMatrix; cdecl; external cDllName;

// aTexture maps generation (PBR)
// NOTE: Required shaders should be provided
function  GenTextureCubemap(aShader: TShader; aSkyHDR: TTexture2D; aSize: Integer): TTexture2D; cdecl; external cDllName;
function  GenTextureIrradiance(aShader: TShader; aCubemap: TTexture2D; aSize: Integer): TTexture2D; cdecl; external cDllName;
function  GenTexturePrefilter(aShader: TShader; aCubemap: TTexture2D; aSize: Integer): TTexture2D; cdecl; external cDllName;
function  GenTextureBRDF(aShader: TShader; aCubemap: TTexture2D; aSize: Integer): TTexture2D; cdecl; external cDllName;

// Moved to drawing functions
// Shading begin/end functions
//procedure BeginShaderMode(aShader : TShader); cdecl; external cDllName;                                // Begin custom shader drawing
//procedure EndShaderMode();  cdecl; external cDllName;                                         // End custom shader drawing (use default shader)
//procedure BeginBlendMode(aMode : Integer); cdecl; external cDllName;                                      // Begin blending mode (alpha, additive, multiplied)
//procedure EndBlendMode();cdecl; external cDllName;                                            // End blending mode (reset to default: alpha blending)

// VR control functions
procedure InitVrSimulator(); cdecl; external cDllName;
procedure CloseVrSimulator(); cdecl; external cDllName;
procedure UpdateVrTracking(aCamera: PCamera); cdecl; external cDllName;
procedure SetVrConfiguration(aInfo : TVrDeviceInfo; aDistortion : TShader); cdecl; external cDllName;
function  IsVrSimulatorReady(): Boolean; cdecl; external cDllName;
procedure ToggleVrMode(); cdecl; external cDllName;
procedure BeginVrDrawing(); cdecl; external cDllName;
procedure EndVrDrawing(); cdecl; external cDllName;

//------------------------------------------------------------------------------------
// Audio Loading and Playing Functions (Module: audio)
//------------------------------------------------------------------------------------

// Audio device management functions
procedure InitAudioDevice; cdecl; external cDllName;
procedure CloseAudioDevice; cdecl; external cDllName;
function  IsAudioDeviceReady: Boolean; cdecl; external cDllName;
procedure SetMasterVolume(aVolume: Single); cdecl; external cDllName;

// TWave/TSound loading/unloading functions
function  LoadWave(aFilename: PAnsiChar): TWave; cdecl; external cDllName;
function  LoadSound(aFilename: PAnsiChar): TSound; cdecl; external cDllName;
function  LoadSoundFromWave(aWave: TWave): TSound; cdecl; external cDllName;
procedure UpdateSound(aSound: TSound; aData: Pointer; samplesCount: Integer); cdecl; external cDllName;
procedure UnloadWave(aWave: TWave); cdecl; external cDllName;
procedure UnloadSound(aSound: TSound); cdecl; external cDllName;
procedure ExportWave(aWave : TWave; aFileName : PAnsiChar); cdecl; external cDllName;               // Export wave data to file
procedure ExportWaveAsCode(aWave : TWave; aFileName : PAnsiChar); cdecl; external cDllName;

// TWave/TSound management functions
procedure PlaySound(aSound: TSound); cdecl; external cDllName;
procedure StopSound(aSound: TSound); cdecl; external cDllName;
procedure PauseSound(aSound: TSound); cdecl; external cDllName;
procedure ResumeSound(aSound: TSound); cdecl; external cDllName;
procedure PlaySoundMulti(aSound: TSound); cdecl; external cDllName;
procedure StopSoundMulti(); cdecl; external cDllName;
function  GetSoundsPlaying(): Integer; cdecl; external cDllName;
function  IsSoundPlaying(aSound: TSound): Boolean; cdecl; external cDllName;
procedure SetSoundVolume(aSound: TSound; aVolume: Single); cdecl; external cDllName;
procedure SetSoundPitch(aSound: TSound; aPitch: Single); cdecl; external cDllName;
procedure WaveFormat(aWave: PWave; aSampleRate: Integer; aSampleSize: Integer; aChannels: Integer); cdecl; external cDllName;
function  WaveCopy(aWave: TWave): TWave; cdecl; external cDllName;
procedure WaveCrop(aWave: PWave; initSample, finalSample: Integer); cdecl; external cDllName;
function  GetWaveData(aWave: TWave): PSingle; cdecl; external cDllName;

// aMusic management functions
function  LoadMusicStream(aFilename: PAnsiChar): TMusic; cdecl; external cDllName;
procedure UnloadMusicStream(aMusic: TMusic); cdecl; external cDllName;
procedure PlayMusicStream(aMusic: TMusic); cdecl; external cDllName;
procedure UpdateMusicStream(aMusic: TMusic); cdecl; external cDllName;
procedure StopMusicStream(aMusic: TMusic); cdecl; external cDllName;
procedure PauseMusicStream(aMusic: TMusic); cdecl; external cDllName;
procedure ResumeMusicStream(aMusic: TMusic); cdecl; external cDllName;
function  IsMusicPlaying(aMusic: TMusic): Boolean; cdecl; external cDllName;
procedure SetMusicVolume(aMusic: TMusic; aVolume: Single); cdecl; external cDllName;
procedure SetMusicPitch(aMusic: TMusic; aPitch: Single); cdecl; external cDllName;
procedure SetMusicLoopCount(aMusic: TMusic; aCount: Integer); cdecl; external cDllName;
function  GetMusicTimeLength(aMusic: TMusic): Single; cdecl; external cDllName;
function  GetMusicTimePlayed(aMusic: TMusic): Single; cdecl; external cDllName;

// TAudioStream management functions
function  InitAudioStream(aSampleRate, aSampleSize, aChannels: Cardinal): TAudioStream; cdecl; external cDllName;
procedure UpdateAudioStream(aStream: TAudioStream; aData: Pointer; samplesCount: Integer); cdecl; external cDllName;
procedure CloseAudioStream(aStream: TAudioStream); cdecl; external cDllName;
function  IsAudioBufferProcessed(aStream: TAudioStream): Boolean; cdecl; external cDllName;
procedure PlayAudioStream(aStream: TAudioStream); cdecl; external cDllName;
procedure PauseAudioStream(aStream: TAudioStream); cdecl; external cDllName;
procedure ResumeAudioStream(aStream: TAudioStream); cdecl; external cDllName;
function  IsAudioStreamPlaying(aStream: TAudioStream): Boolean; cdecl; external cDllName;
procedure StopAudioStream(aStream: TAudioStream); cdecl; external cDllName;
procedure SetAudioStreamVolume(aStream: TAudioStream; aVolume: Single); cdecl; external cDllName;
procedure SetAudioStreamPitch(aStream: TAudioStream; aPitch: Single); cdecl; external cDllName;
procedure SetAudioStreamBufferSizeDefault(aSize: Integer); cdecl; external cDllName;

// Custom Misc Functions to help simplify a few things
function Vector2Create(aX: Single; aY: Single) : TVector2;
procedure Vector2Set(aVec : PVector2; aX: Single; aY: Single);
function Vector3Create(aX: Single; aY: Single; aZ: Single) : TVector3;
procedure Vector3Set(aVec : PVector3; aX: Single; aY: Single; aZ: Single);
function ColorCreate(aR: Byte; aG: Byte; aB: Byte; aA: Byte) : TColor;
procedure TColorSet(aColor : PColor; aR: Byte; aG: Byte; aB: Byte; aA: Byte);
function RectangleCreate(aX: Integer; aY: Integer; aWidth: Integer; aHeight: Integer) : TRectangle;
procedure RectangleSet(aRect : PRectangle; aX: Integer; aY: Integer; aWidth: Integer; aHeight: Integer);
function TCamera3DCreate(aPosition, aTarget, aUp: TVector3; aFOVY: Single; aType: Integer) : TCamera3D;
procedure TCamera3DSet(aCam : PCamera3D; aPosition, aTarget, aUp: TVector3; aFOVY: Single; aType: Integer);


implementation


function Vector2Create(aX: Single; aY: Single) : TVector2;
begin
  Result.x := aX;
  Result.y := aY;
end;

procedure Vector2Set(aVec : PVector2; aX: Single; aY: Single);
begin
  aVec^.x := aX;
  aVec^.y := aY;
end;

function Vector3Create(aX: Single; aY: Single; aZ: Single) : TVector3;
begin
  Result.x := aX;
  Result.y := aY;
  Result.z := aZ;
end;

procedure Vector3Set(aVec : PVector3; aX: Single; aY: Single; aZ: Single);
begin
  aVec^.x := aX;
  aVec^.y := aY;
  aVec^.z := aZ;
end;

function ColorCreate(aR: Byte; aG: Byte; aB: Byte; aA: Byte) : TColor;
begin
  Result.r := aR;
  Result.g := aG;
  Result.b := aB;
  Result.a := aA;
end;

procedure TColorSet(aColor : PColor; aR: Byte; aG: Byte; aB: Byte; aA: Byte);
begin
  aColor^.r := aR;
  aColor^.g := aG;
  aColor^.b := aB;
  aColor^.a := aA;
end;


function RectangleCreate(aX: Integer; aY: Integer; aWidth: Integer; aHeight: Integer) : TRectangle;
begin
  Result.x := aX;
  Result.y := aY;
  Result.width := aWidth;
  Result.height := aHeight;
end;

procedure RectangleSet(aRect : PRectangle; aX: Integer; aY: Integer; aWidth: Integer; aHeight: Integer);
begin
  aRect^.x := aX;
  aRect^.y := aY;
  aRect^.width := aWidth;
  aRect^.height := aHeight;
end;

function TCamera3DCreate(aPosition, aTarget, aUp: TVector3; aFOVY: Single; aType: Integer) : TCamera3D;
begin
  Result.position := aPosition;
  Result.target := aTarget;
  Result.up := aUp;
  Result.fovy := aFOVY;
  Result.projection := aType;
end;

procedure TCamera3DSet(aCam : PCamera3D; aPosition, aTarget, aUp: TVector3; aFOVY: Single; aType: Integer);
begin
  aCam^.position := aPosition;
  aCam^.target := aTarget;
  aCam^.up := aUp;
  aCam^.fovy := aFOVY;
  aCam^.projection := aType;
end;


initialization

end.
