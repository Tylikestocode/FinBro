const CONFIG = {
    BASE_URL: window.location.hostname === 'localhost'
        ? 'http://localhost:8081/api' : 'https://finbro.yazeedmo.com/api'
};

export default CONFIG;