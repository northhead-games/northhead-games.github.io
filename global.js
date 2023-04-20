const calcHeight = () => {
    let vh = window.innerHeight * 0.01;
    document.documentElement.style.setProperty('--vh', `${vh}px`);
    console.log("test");
};

calcHeight();
window.addEventListener('resize', () => {
    calcHeight();
});
