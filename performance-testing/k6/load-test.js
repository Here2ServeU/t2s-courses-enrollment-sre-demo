import http from 'k6/http';

export let options = {
  stages: [
    { duration: '30s', target: 50 },
    { duration: '1m', target: 100 },
  ],
};

export default function () {
  http.get('https://t2s-courses.com/enroll');
}
