/**
 * 仙女棒烟花效果
 * 跟随鼠标产生金色闪烁的粒子效果
 */
(function() {
    // 创建canvas元素
    const canvas = document.createElement('canvas');
    canvas.id = 'sparkler-canvas';
    canvas.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: 9999;
    `;
    document.body.appendChild(canvas);
    
    const ctx = canvas.getContext('2d');
    
    // 设置画布大小
    function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
    resizeCanvas();
    
    // 鼠标位置
    let mouseX = -100;
    let mouseY = -100;
    let isMouseMoving = false;
    
    // 粒子数组
    const particles = [];
    
    // 粒子类
    class Particle {
        constructor(x, y) {
            this.x = x;
            this.y = y;
            
            // 随机速度和方向
            const angle = Math.random() * Math.PI * 2;
            const speed = Math.random() * 2 + 0.5;
            this.vx = Math.cos(angle) * speed;
            this.vy = Math.sin(angle) * speed;
            
            // 重力
            this.gravity = 0.08;
            
            // 大小
            this.size = Math.random() * 2.5 + 0.5;
            
            // 生命值
            this.life = 1;
            this.decay = Math.random() * 0.02 + 0.01;
            
            // 颜色 - 低饱和度柔和色系
            const colors = [
                { r: 255, g: 180, b: 180 }, // 淡红色
                { r: 255, g: 200, b: 150 }, // 淡橙色
                { r: 255, g: 230, b: 150 }, // 淡金色
                { r: 255, g: 255, b: 180 }, // 淡黄色
                { r: 180, g: 255, b: 180 }, // 淡绿色
                { r: 150, g: 255, b: 200 }, // 淡青绿色
                { r: 180, g: 240, b: 255 }, // 淡青色
                { r: 180, g: 210, b: 255 }, // 淡天蓝色
                { r: 200, g: 200, b: 255 }, // 淡蓝色
                { r: 220, g: 180, b: 255 }, // 淡紫色
                { r: 255, g: 180, b: 240 }, // 淡洋红色
                { r: 255, g: 180, b: 200 }, // 淡玫红色
                { r: 255, g: 255, b: 255 }, // 白色
                { r: 255, g: 200, b: 220 }, // 淡粉色
                { r: 240, g: 200, b: 255 }, // 淡粉紫色
                { r: 200, g: 180, b: 255 }  // 淡蓝紫色
            ];
            this.color = colors[Math.floor(Math.random() * colors.length)];
            
            // 闪烁效果
            this.twinkle = Math.random() * Math.PI * 2;
            this.twinkleSpeed = Math.random() * 0.1 + 0.05;
            
            // 形状类型 - 固定为长条形
            this.shape = 'line';
            
            // 旋转角度
            this.rotation = Math.random() * Math.PI * 2;
            this.rotationSpeed = (Math.random() - 0.5) * 0.2;
        }
        
        update() {
            // 更新速度
            this.vy += this.gravity;
            
            // 更新位置
            this.x += this.vx;
            this.y += this.vy;
            
            // 空气阻力
            this.vx *= 0.99;
            this.vy *= 0.99;
            
            // 减少生命值
            this.life -= this.decay;
            
            // 更新闪烁
            this.twinkle += this.twinkleSpeed;
            
            // 更新旋转
            this.rotation += this.rotationSpeed;
        }
        
        draw() {
            const alpha = this.life * (0.5 + Math.sin(this.twinkle) * 0.5);
            
            ctx.save();
            ctx.translate(this.x, this.y);
            ctx.rotate(this.rotation);
            
            // 绘制光晕
            const gradient = ctx.createRadialGradient(0, 0, 0, 0, 0, this.size * 4);
            gradient.addColorStop(0, `rgba(${this.color.r}, ${this.color.g}, ${this.color.b}, ${alpha})`);
            gradient.addColorStop(0.5, `rgba(${this.color.r}, ${this.color.g}, ${this.color.b}, ${alpha * 0.5})`);
            gradient.addColorStop(1, `rgba(${this.color.r}, ${this.color.g}, ${this.color.b}, 0)`);
            
            ctx.fillStyle = gradient;
            ctx.fillRect(-this.size * 4, -this.size * 4, this.size * 8, this.size * 8);
            
            // 绘制形状
            ctx.fillStyle = `rgba(${this.color.r}, ${this.color.g}, ${this.color.b}, ${alpha})`;
            ctx.strokeStyle = `rgba(255, 255, 255, ${alpha * 0.8})`;
            ctx.lineWidth = 0.5;
            
            ctx.beginPath();
            
            switch(this.shape) {
                case 'line': // 长条形 - 更长的条形
                    ctx.rect(-this.size * 4, -this.size * 0.4, this.size * 8, this.size * 0.8);
                    break;
                    
                case 'triangle': // 三角形
                    ctx.moveTo(0, -this.size * 1.5);
                    ctx.lineTo(this.size * 1.3, this.size * 1.5);
                    ctx.lineTo(-this.size * 1.3, this.size * 1.5);
                    ctx.closePath();
                    break;
                    
                case 'square': // 正方形
                    ctx.rect(-this.size, -this.size, this.size * 2, this.size * 2);
                    break;
                    
                case 'hexagon': // 六边形
                    for (let i = 0; i < 6; i++) {
                        const angle = (Math.PI / 3) * i;
                        const x = Math.cos(angle) * this.size * 1.5;
                        const y = Math.sin(angle) * this.size * 1.5;
                        if (i === 0) {
                            ctx.moveTo(x, y);
                        } else {
                            ctx.lineTo(x, y);
                        }
                    }
                    ctx.closePath();
                    break;
                    
                case 'parallelogram': // 平行四边形
                    ctx.moveTo(-this.size * 1.5, -this.size);
                    ctx.lineTo(this.size * 0.5, -this.size);
                    ctx.lineTo(this.size * 1.5, this.size);
                    ctx.lineTo(-this.size * 0.5, this.size);
                    ctx.closePath();
                    break;
            }
            
            ctx.fill();
            ctx.stroke();
            
            ctx.restore();
        }
        
        isDead() {
            return this.life <= 0;
        }
    }
    
    // 创建粒子
    function createParticles(x, y, count) {
        for (let i = 0; i < count; i++) {
            particles.push(new Particle(x, y));
        }
    }
    
    // 动画循环
    function animate() {
        // 清空画布
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        
        // 如果鼠标在移动，持续创建粒子
        if (isMouseMoving && mouseX >= 0 && mouseY >= 0) {
            createParticles(mouseX, mouseY, 3);
        }
        
        // 更新和绘制所有粒子
        for (let i = particles.length - 1; i >= 0; i--) {
            const particle = particles[i];
            particle.update();
            particle.draw();
            
            // 移除死亡的粒子
            if (particle.isDead()) {
                particles.splice(i, 1);
            }
        }
        
        requestAnimationFrame(animate);
    }
    
    // 鼠标移动事件
    let mouseMoveTimeout;
    document.addEventListener('mousemove', (e) => {
        mouseX = e.clientX;
        mouseY = e.clientY;
        isMouseMoving = true;
        
        // 清除之前的定时器
        clearTimeout(mouseMoveTimeout);
        
        // 设置新的定时器，鼠标停止移动后停止创建粒子
        mouseMoveTimeout = setTimeout(() => {
            isMouseMoving = false;
        }, 50);
    });
    
    // 窗口大小改变
    window.addEventListener('resize', resizeCanvas);
    
    // 开始动画
    animate();
})();
