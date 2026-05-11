unit ecs;

interface
uses sdl2;

type
 TEntity = integer;
 Tvec2 = record
  X,Y :single;
 end;

 TPosition = record
  Value: Tvec2;
 end;

  TVelocity = record
    Value: TVec2;
  end;

 THealth = record
   Value:integer;
 end;

 const
  MAX_ENTITIES = 1000;

 var
  Positions: array[0..MAX_ENTITIES] of TPosition;
  Velocities: array[0..MAX_ENTITIES] of TVelocity;
  Healths: array[0..MAX_ENTITIES] of THealth;

 procedure initECS;
 function createEntity:TEntity;
 procedure MovementSystem(DeltaTime:Single);
 procedure RenderSystem(Renderer: PSDL_Renderer);
implementation


  var
    EntityCount:Integer;

  procedure initECS;
  begin
    EntityCount := 0;
  end;

  function createEntity:TEntity;
  begin
    Result := EntityCount;
    Inc(EntityCount);
  end;

  procedure MovementSystem(DeltaTime:Single);
  var
   i:integer;
  begin
    for i := 0 to EntityCount - 1  do
    begin
      Positions[i].Value.X := Positions[i].Value.X + Velocities[i].Value.X * DeltaTime;
      Positions[i].Value.Y := Positions[i].Value.Y + Velocities[i].Value.Y * DeltaTime;
    end;

  end;

  procedure RenderSystem(Renderer:PSDL_Renderer);
  var
  i: Integer;
  Rect: TSDL_Rect;
  begin
    for i := 0 to MAX_ENTITIES - 1 do
    begin
      if i >= EntityCount then Break;

      Rect.x := Round(Positions[i].Value.X);
      Rect.y := Round(Positions[i].Value.Y);
      Rect.w := 20;
      Rect.h := 20;

      SDL_SetRenderDrawColor(Renderer, 255, 0, 0, 255);
      SDL_RenderDrawRect(Renderer, @Rect);
    end;
  end;

end.
