namespace Pomodoro {
    public class Task : Object {
        public virtual string title { get; set; default = ""; }
        public virtual bool done { get; set; default = false; }

        public Task (string title) {
            this.title = title;
        }

        public string to_string () {
            return @"Task<done: $done; title: $title>";
        }
    }
}
