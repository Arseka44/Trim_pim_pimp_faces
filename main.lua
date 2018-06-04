 function love.load()
   image_trimp_1 = love.graphics.newImage( "PicsArt_06-01-09_38_19.png" )
   image_trimp_2 = love.graphics.newImage( "TRIMP2.png" )
   width = image_trimp_1:getWidth( )
   x_pos = 100
   y_pos = 100

   sx = 0.2
   sy = 0.2

   speed_x = 800
   speed_y = 1000

   napravlenie_y = 1
   napravlenie_x = 1

   score = 0 -- счет игры
   timer = 10 -- исходная установка счетчика времени

   myFont = love.graphics.newFont(20) -- сделаем размер фонта больше
   gameState  =  1 --состояние игры.  1 - стоп игра, 2 - играем

  --source = love.audio.newSource( "simple" , mp3 )
  --success = source:play()
  love.audio.play(simple.mp3) 
 end


function love.draw()
  if gameState == 2 then -- если состояние игры == 2 то отрисовываем кнопку иначе скрываем
    love.graphics.draw(image_trimp_1, x_pos, y_pos, sx, sy)
  end
  -- сделам надпись белого цвета для лучшей читабельности и выведем на экран
  love.graphics.setColor(255,255,255)
  love.graphics.setFont(myFont)
  love.graphics.print("Game score = "..score)
  love.graphics.print("Timer = ".. math.ceil(timer,2), 400, 0)
    --[[12]]
  if gameState == 1 then
  love.graphics.printf("Click anywhere to begin!", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
  end
  if gameState == 3 and score <= 10 then
  love.graphics.printf("Game over! You have got " .. score .. " points! Politics is not for you. It`s only available to studying in millitary school for you, sorry :(", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
elseif gameState == 3 and score > 10  and score <=20 then
  love.graphics.printf("Game over! You have got " .. score .. " points! Congratulations, maybe you'd make a good Governor of face-punching , maybe not.", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
elseif gameState == 3 and score > 20  and score <=30 then
  love.graphics.printf("Game over! You have got " .. score .. " points! You have a talent for punching faces. You could do that at the district chief level.", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
elseif gameState == 3 and score > 30 then
  love.graphics.printf("Game over! You have got " .. score .. " points! Unbelievable! You could be President of face-punching. And poke anyone's face!.", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
  end


  love.graphics.setBackgroundColor( 1, 0, 1 )
  --love.graphics.draw(image_trimp_1, x,y)
 end

 function love.update(dt)
   if gameState == 2 then
       if timer > 0 then
         timer = timer - dt
       end
       if timer < 0 then
         timer = 0
         gameState = 3

       end
   end

--обработка х
   if x_pos + speed_x*dt >= 680 then
     napravlenie_x = 2
   elseif x_pos + speed_x*dt <= 10  then
     napravlenie_x = 1
   end

   if napravlenie_x == 1 then
     x_pos = x_pos + speed_x*dt
   elseif napravlenie_x == 2 then
     x_pos = x_pos - speed_x*dt
   end
--обработка y
   if y_pos + speed_y*dt >= 480 then
     napravlenie_y = 2
   elseif y_pos + speed_y*dt <= 10  then
     napravlenie_y = 1
   end

   if napravlenie_y == 1 then
     y_pos = y_pos + speed_y*dt
   elseif napravlenie_y == 2 then
     y_pos = y_pos - speed_y*dt
   end


end

function love.mousepressed(x, y, b, isTouch)
   if b == 1 and gameState == 2 then
     if distanceBetween(x_pos,  y_pos, love.mouse.getX(), love.mouse.getY()) < 0.2 * width then
        score = score + 1
        x_pos = math.random(love.graphics.getPointSize(image_trimp_1), love.graphics.getWidth() - love.graphics.getPointSize(image_trimp_1))
        y_pos = math.random(love.graphics.getPointSize(image_trimp_1), love.graphics.getHeight() - love.graphics.getPointSize(image_trimp_1))
    --  if distanceBetween(x_pos,  y_pos, love.mouse.getX(), love.mouse.getY()) < width then
      --  score = score + 1
        --button.x = math.random(button.size, love.graphics.getWidth() - button.size)
        --button.y = math.random(button.size, love.graphics.getHeight() - button.size)
      end
   end
   -- добавляем условие при котором в начале игры клик по любому месту игрового поля начинает игру
   if gameState == 1 then
     gameState =2
     timer = 10
   end
end -- funct

   function distanceBetween(x1, y1, x2, y2)
     return math.sqrt( (x2-x1)^2 + (y2-y1)^2  )
   end
