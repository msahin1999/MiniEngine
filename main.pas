unit main;
//deneme yanýlma
interface

uses
  SDL2,ecs,vcl.dialogs;


const
  MAX_SPEED = 350;
  SCREEN_W = 1280;
  SCREEN_H = 720;
procedure RunEngine;

implementation

procedure RunEngine;

var
  Window: PSDL_Window;
  Event: TSDL_Event;
  Running: Boolean;
  Player:TEntity;
  i:integer;
  E:TEntity;
  LastTime,CurrentTime:UInt32;
  DeltaTime:Single;
  Renderer : PSDL_Renderer;

begin

  if SDL_Init(SDL_INIT_VIDEO) < 0 then
  begin
    Halt;
  end;

  InitECS;

  Player := CreateEntity;

  Positions[Player].Value.X := 200;
  Positions[Player].Value.Y := 200;

  Velocities[Player].Value.X := 0;
  Velocities[Player].Value.Y := 0;

(*
    for i := 0 to 9 do
    begin
      E:=CreateEntity;
      Positions[E].Value.X := 100 + i * 30;
      Positions[E].Value.Y := 100;

      Velocities[E].Value.X := 20 + i * 10;
      Velocities[E].Value.Y := 10 * i * 5;
    end;
*)


  Window := SDL_CreateWindow(
    'Mini Engine',
    SDL_WINDOWPOS_CENTERED,
    SDL_WINDOWPOS_CENTERED,
    1280,
    720,
    SDL_WINDOW_SHOWN
  );

  Renderer := SDL_CreateRenderer(Window,-1,SDL_RENDERER_ACCELERATED);

  LastTime := SDL_GetTicks;

  Running := True;
                                                                       ////
  while Running do
  begin

    while SDL_PollEvent(@Event) = 1 do
    begin

      case Event.type_ of

        SDL_QUITEV:
          Running := False;

        SDL_KEYDOWN:
        begin
          case Event.Key.keysym.sym of

            SDLK_ESCAPE:
            begin
              ShowMessage('Program Kapanýyor.');
              Running:= False;
            end;

            SDLK_w:
              Velocities[Player].Value.Y := -100;

            SDLK_s:
              Velocities[Player].Value.Y := 100;

            SDLK_a:
              Velocities[Player].Value.X := -100;

            SDLK_d:
              Velocities[Player].Value.X := 100;

            SDLK_SPACE:
            begin
              if Velocities[Player].Value.X < 0 then Velocities[Player].Value.X := -MAX_SPEED
              else if Velocities[Player].Value.X > 0 then Velocities[Player].Value.X := MAX_SPEED;

             if Velocities[Player].Value.Y < 0 then Velocities[Player].Value.Y := -MAX_SPEED
             else if Velocities[Player].Value.Y > 0 then Velocities[Player].Value.Y := MAX_SPEED;
            end;
          end;
        end;

        SDL_KEYUP:
        begin
          case Event.Key.keysym.sym of
            SDLK_w, SDLK_s:
            Velocities[Player].Value.Y := 0;

            SDLK_a, SDLK_d:
            Velocities[Player].Value.X := 0;

            SDLK_SPACE:
            begin
              if Velocities[Player].Value.X < 0 then Velocities[Player].Value.X := -100
              else if Velocities[Player].Value.X > 0 then Velocities[Player].Value.X := 100;


              if Velocities[Player].Value.Y < 0 then Velocities[Player].Value.Y := -100
              else if Velocities[Player].Value.Y > 0 then Velocities[Player].Value.Y := 100;
            end;
          end;
        end;

      end;

    end;

    CurrentTime := SDL_GetTicks;
    DeltaTime := (CurrentTime - LastTime) / 1000.0;
    LastTime := CurrentTime;

    MovementSystem(DeltaTime);


    if Positions[Player].Value.X < 0 then
    begin
      Positions[Player].Value.X := 0;
      Velocities[Player].Value.X := Velocities[Player].Value.X * -0.9;
    end;

    if Positions[Player].Value.X > SCREEN_W - 20 then
    begin
      Positions[Player].Value.X := SCREEN_W - 20;
      Velocities[Player].Value.X := Velocities[Player].Value.X * -0.9;
    end;

    if Positions[Player].Value.Y < 0 then
    begin
      Positions[Player].Value.Y := 0;
      Velocities[Player].Value.Y := Velocities[Player].Value.Y * -0.9;
    end;

    if Positions[Player].Value.Y > SCREEN_H - 20 then
    begin
      Positions[Player].Value.Y := SCREEN_H - 20;
      Velocities[Player].Value.Y := Velocities[Player].Value.Y * -0.9;
    end;
    SDL_SetRenderDrawColor(Renderer,10,20,30,155);
    SDL_RenderClear(Renderer);

    RenderSystem(Renderer);

    SDL_RenderPresent(Renderer);
    SDL_Delay(1);

  end;

  SDL_DestroyRenderer(Renderer);
  SDL_DestroyWindow(Window);

  SDL_Quit;

end;

end.
